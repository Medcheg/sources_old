//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit_Export.h"
#include "mpiBlackBox.h"
#include "Unit_Main.h"
#include "mpiDeclaration.h"
#include "stdio.h"
#include "math.h"
#include "mpiComPort.h"
#include "winioctl.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmExport *frmExport;
//---------------------------------------------------------------------------
__fastcall TfrmExport::TfrmExport(TComponent* Owner)
        : TForm(Owner)
{
      CheckFlashDriveLeters();

     // -----------
      RadioButton2->Enabled = (ComboBox1->Items->Count != 0);
      if ( ComboBox1->Items->Count == 0 ) RadioButton1->Checked = true;
}

// --------
void TfrmExport::CheckFlashDriveLeters()
{
   // --- Достаем Драйв Летер ;
      ComboBox1->Items->Clear();

   // ------
      /*      char *buff = new char[255];
      GetLogicalDriveStrings(255, buff);

      while ( (buff[0] >= 'A' && buff[0] <= 'Z') || (buff[0] >= 'a' && buff[0] <= 'z'))
      {
             unsigned int gdt = GetDriveType(buff);
             switch (gdt) {
               case                 0:                                break;//"?"
               case                 1:                                break;//"Path does not exists";
               case   DRIVE_REMOVABLE:  ComboBox1->Items->Add(buff); break; // "Removable";
               case       DRIVE_FIXED:                                break; // "Fixed";
               case      DRIVE_REMOTE:                                break; //"Remote";
               case       DRIVE_CDROM:                                break; //"CD_ROM";
               case     DRIVE_RAMDISK:                                break; //"RAMDISK";
               //default:    ; // drive_type = "Unknown";
            }
            buff = buff + 4;
      }
      delete buff;
*/
      for ( char DriveLeter = 'A'; DriveLeter <= 'Z'; DriveLeter ++)
      {
          DISK_GEOMETRY diskGeo;
          unsigned long readBytes = 0;
          char DriveName[255];
          sprintf(DriveName, "\\\\.\\%c:", DriveLeter);

          HANDLE hDevice = CreateFile(DriveName, FILE_ALL_ACCESS, FILE_SHARE_READ| FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL); //

          if ( (hDevice != NULL) && (hDevice != INVALID_HANDLE_VALUE) )
          {
                bool Result  = DeviceIoControl(hDevice, IOCTL_DISK_GET_DRIVE_GEOMETRY, NULL, 0, &diskGeo, sizeof(diskGeo), &readBytes, NULL);

                if ( Result == true && diskGeo.MediaType == RemovableMedia )  ComboBox1->Items->Add(AnsiString(DriveLeter));
          }
          CloseHandle (hDevice);
          hDevice = NULL;
      }
}

void __fastcall TfrmExport::Label3Click(TObject *Sender)
{
      int OldItemIndex = ComboBox1->ItemIndex;
      CheckFlashDriveLeters();

      if (ComboBox1->Items->Count - 1 <  OldItemIndex ) ComboBox1->ItemIndex = -1;
      else ComboBox1->ItemIndex = OldItemIndex;

      RadioButton2->Enabled = (ComboBox1->Items->Count != 0);
      if ( ComboBox1->Items->Count == 0 ) RadioButton1->Checked = true;
}

void TfrmExport::SetEnabledC(bool isEnabled)
{
    bSelectedDataExport     ->Enabled = isEnabled;
    bDataExport             ->Enabled = isEnabled;
    cbiData                 ->Enabled = isEnabled;
    cbiVideoData            ->Enabled = isEnabled;
    bSelectedVideoDataExport->Enabled = isEnabled;
    bVideoDataExport        ->Enabled = isEnabled;
    DirectoryListBox1       ->Enabled = isEnabled;
}

//---------------------------------------------------------------------------
int TfrmExport::DecodePresentEvent()
{
    // ---- Посылаем команду чтения ивентов -------
        frmMain->eCOMText->Text = "event";

        frmMain->bSendCommandClick(NULL);

        if ( frmMain->isCommandSuccesed == false ) return -1;

    // ------- Если критических ошибок чтения небыло, тогда пытаюсь декодировать ивенты  -----
        int iPosBuffer       = 0;
        int CircleBufferSize = 0;
        int CurrentTemp      = 0;
        int day, month, year, hour, min, sec;
    // -----------

         iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer); // ---- пропуст первой строки -----
     // Дата
         sscanf(&BlackBox->ReadBuffer[iPosBuffer], "Current date and time %d/%d/%d %d:%d:%d", &month, &day, &year, &hour, &min, &sec);
         iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer);

     // Количество событий
         sscanf(&BlackBox->ReadBuffer[iPosBuffer], "Total number of events - %d", &EventCount);
         iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer);
         if (fabs(EventCount) >  300) return -2;
         if (fabs(EventCount) <=   0) return -2;

     // Размер кольцевого буфера
         sscanf(&BlackBox->ReadBuffer[iPosBuffer], "Circle Buffer Size = %d", &CircleBufferSize);
         iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer);

     // Температура
         sscanf(&BlackBox->ReadBuffer[iPosBuffer], "Current temperature in MDRS = %d", &CurrentTemp);
         iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer);

     //  Создаю масив ивентов
         Events = new TBEvent[EventCount];
     // Цикл по Ивентам
         for (int i = 0; i < EventCount; i++) {
              Events[i].CurrentTemp = CurrentTemp;
              iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer); // --- пропуск --- Event #0

              sscanf(&BlackBox->ReadBuffer[iPosBuffer], "Events date and time %d/%d/%d %d:%d:%d", &Events[i].month, &Events[i].day, &Events[i].year, &Events[i].hour, &Events[i].min, &Events[i].sec);
              iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer);
              iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer); // --- пропуск --- General byte counter = 61248
              iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer); // --- пропуск --- Last page number - 116
              iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer); // --- пропуск --- Writing Time = 2.026 s

              sscanf(&BlackBox->ReadBuffer[iPosBuffer], "Events point = %d", &Events[i].Events_point);
              iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer);

              sscanf(&BlackBox->ReadBuffer[iPosBuffer], "Number of byte after event = %d", &Events[i].Number_of_byte_after_event);
              iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer);
              iPosBuffer = PosNextLine(BlackBox->ReadBuffer, iPosBuffer); // --- пропуск --------------------------------------------------------
         }
      //
         return 0;
}

//---------------------------------------------------------------------------


//---------------------------------------------------------------------------
bool CheckCorrectIDCounter(TBEvent *aEvent)
{
     bool Result = true;
     unsigned short int CurIDCounter = aEvent->true_values[0][0];
     for ( int i = 1; i < aEvent->RealBlockCount; i++ )
     {
          CurIDCounter++;
          if ( CurIDCounter != aEvent->true_values[i][0])
                Result = false;

     }

     return Result;
}

//---------------------------------------------------------------------------
void TfrmExport::WorkEvent(int aEvIndex, TBEvent *aBaseEvent, TBEvent *aEvent)
{
   // ----- Имя ескпортируемой директории ------
      aEvent->ExportFolderName = IntToStr(aBaseEvent->year ) + "." + IntToStr(aBaseEvent->month) + "." + IntToStr(aBaseEvent->day  ) + "_" +
                                 IntToStr(aBaseEvent->hour ) + "." + IntToStr(aBaseEvent->min  ) + "." + IntToStr(aBaseEvent->sec  );


      int  CountTryReadData  = 0;
      int  CountTryIDCorrect = 0;
      char MessBuff[1024];

gRepeat:
      aEvent->isCorrectEvent = true;
    // ----- Читаем поток данных ----
      frmMain->eCOMText->Text = "bin_read " + IntToStr(aEvIndex);
      frmMain->bSendCommandClick(NULL);

    // ------------------------------
      if ( DecodeBuffer(aEvent, BlackBox->ReadBuffer) == false )
      {
           CountTryReadData++;
           aEvent->isCorrectEvent = false;
           if ( CountTryReadData >= 3 ) {
               sprintf(MessBuff, "Packet length error! Try to export event %d again!", aEvIndex);
               MessageBox(Handle, MessBuff, "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
               return;
           }
           goto gRepeat;
      }

    // коррекция входного буферра данных ----
       Correct_DataBuffer(aEvent);

       CountTryReadData = 0;

    // ------ Проверка на последовательность индексов в пакете данных --------
       if ( CheckCorrectIDCounter(aEvent) == false )
       {
           FILE *h_file = fopen(LogFileName, "at");
               fprintf(h_file, "\t\t\t\t\t\t\t\t\tStep number check error!\n");
           fclose(h_file);
         // -----------
           aEvent->isCorrectEvent = false;
         // -----------
           CountTryIDCorrect++;
           if ( CountTryIDCorrect >= 2 ) {
               sprintf(MessBuff, "Step number check error!  Try to export event %d again!", aEvIndex);
               MessageBox(Handle, MessBuff, "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
               return;
           }
           goto gRepeat;
       }

    // сохранняем данные на диск ----
       Save_DataEvent_to_Disk(aEvent, aEvIndex);
}

//---------------------------------------------------------------------------
void TfrmExport::WorkVideoEvent_ComPORT(int aEvIndex, TBEvent *aBaseEvent, TBEvent *aEvent)
{
   // ----- Имя ескпортируемой директории ------
      aEvent->ExportFolderName = IntToStr(aBaseEvent->year ) + "." + IntToStr(aBaseEvent->month) + "." + IntToStr(aBaseEvent->day  ) + "_" +
                                 IntToStr(aBaseEvent->hour ) + "." + IntToStr(aBaseEvent->min  ) + "." + IntToStr(aBaseEvent->sec  );

      for (  int i = 0; i < COUNT_VIDEO_FRAME; i++)
      {
            if ( cbBreakReadEvent->Checked == true ) continue;

          // ----- Читаем поток данных ----
            frmMain->eCOMText->Text = "capture " + IntToStr(aEvIndex) + " " + IntToStr(i);
            Application->ProcessMessages();
            frmMain->bSendCommandClick(NULL);

          // ----- РазборДанных ----

            int a1,a2;
            sscanf(BlackBox->ReadBuffer, "Event = %d Frame = %d  Permanent Count = %d", &a1, &a2, &aEvent->FrameNumber[i]);
            memcpy(aEvent->VideoData[i], BlackBox->ReadBuffer, BlackBox->BytesRead);
          // -----
      }
    // ---- Записую изображение --------
      Save_VideoEvent_to_Disk(aEvent, aEvIndex);
}

//---------------------------------------------------------------------------
void TfrmExport::WorkVideoEvent_SDCard (HANDLE h_File, int aEvIndex, TBEvent *aBaseEvent, TBEvent *aEvent)
{
   // ----- Имя ескпортируемой директории ------
      aEvent->ExportFolderName = IntToStr(aBaseEvent->year ) + "." + IntToStr(aBaseEvent->month) + "." + IntToStr(aBaseEvent->day  ) + "_" +
                                 IntToStr(aBaseEvent->hour ) + "." + IntToStr(aBaseEvent->min  ) + "." + IntToStr(aBaseEvent->sec  );

      frmMain->pVideo->Visible = true;
      SetFilePointer(h_File, 32768*4*aEvIndex*80, NULL, FILE_BEGIN);

      int offset = 0;
      unsigned int BlockNumber = 0;
      for (  int i = 0; i < COUNT_VIDEO_FRAME; i++)          //
      {
            frmMain->eCOMText->Text = "capture " + IntToStr(aEvIndex) + " " + IntToStr(i);
            if ( cbBreakReadEvent->Checked == true ) continue;
          // ----- Читаем поток данных ----

            for ( int k = 0; k < 100; k ++ )
            {
                  //BlockNumber = aEvIndex*((COUNT_VIDEO_FRAME-1)*128 +   0) + 128*i + k;
                  BlockNumber = aEvIndex*((COUNT_VIDEO_FRAME-1)*128 + 100) + 128*i + k;
              // ----------
                 DWORD dw = 0;
                 unsigned short int varl = (unsigned short int)((BlockNumber & 0x0000003F)<<9);
                 unsigned short int varh = (unsigned short int)(((BlockNumber & 0xFFFFFFC0)>>6) & 0x0000FFFF);                           
                 dw = (((DWORD)varh) << 16) | varl;

                 SetFilePointer(h_File, (LONG)dw, NULL, FILE_BEGIN);
              // -----
                 unsigned long bb;
                 ReadFile(h_File, &BlackBox->ReadBuffer[k*512], 512, &bb, NULL);
            }

            BlackBox->BytesRead = 51200;
          // ----- РазборДанных ----
            int a1,a2;
            sscanf(BlackBox->ReadBuffer, "Event = %d Frame = %d  Permanent Count = %d", &a1, &a2, &aEvent->FrameNumber[i]);
            memcpy(aEvent->VideoData[i], BlackBox->ReadBuffer, BlackBox->BytesRead);
          // -----
            frmMain->Draw_and_Decode_frame();
            Application->ProcessMessages();
      }
      //frmMain->pVideo->Visible = false;
    // ---- Записую изображение --------
      Save_VideoEvent_to_Disk(aEvent, aEvIndex);
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::bDataExportClick(TObject *Sender)
{
      cbBreakReadEvent->Checked = false;
      cbBreakReadEvent->Visible = true;
   // ------- Считываю базовые данніе ----
      if ( DecodePresentEvent() != 0) return;

  // ----- Расшифровка по ивентам -----
      SetEnabledC(false);
      for (int i = 0; i < EventCount; i++) {
           if ( cbBreakReadEvent->Checked == true ) continue;
           WorkEvent(i, &Events[0], &Events[i]);
      }
      SetEnabledC(true);

      cbBreakReadEvent->Visible = false;
      DirectoryListBox1->Update();
   // -----------------------------------------------
      if ( Events != NULL) delete [] Events;
      Events = NULL;


   // ------ Окно о успешном окончании експорта -----
      char buhh[4096];
      sprintf(buhh, "%d event(s) successfully exported!\0", EventCount);
      MessageBox(Handle, buhh, "MDRS - Information", MB_OK|MB_ICONINFORMATION);
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::bSelectedDataExportClick(TObject *Sender)
{
      cbBreakReadEvent->Checked = false;
      cbBreakReadEvent->Visible = true;
   // ----
      if (cbiData->ItemIndex == -1) return;

   // ------- Считываю базовые данніе ----
      if ( DecodePresentEvent() != 0 ) return;
      if ( cbiData->ItemIndex > EventCount -1 ) {
          MessageBox(Handle, "The selected event number exeeds the total number of events", "MDRS - Information", MB_OK|MB_ICONERROR);
          return;
      }

   // ---------------
      SetEnabledC(false);
      WorkEvent(cbiData->ItemIndex, &Events[0], &Events[cbiData->ItemIndex]);
      SetEnabledC(true);
      cbBreakReadEvent   ->Visible = false;
      DirectoryListBox1->Update();

   // ------ Окно о успешном окончании експорта -----
      MessageBox(Handle, "Sensor data successfully exported!\0", "MDRS - Information", MB_OK|MB_ICONINFORMATION);
}
//---------------------------------------------------------------------------

void __fastcall TfrmExport::bSelectedVideoDataExportClick(TObject *Sender)
{
      cbBreakReadEvent->Checked = false;
      cbBreakReadEvent->Visible = true;
    // ------- Считываю базовые данніе ----
      if ( DecodePresentEvent() != 0) return;

   // -----------
      if ( RadioButton1->Checked == true )
         if ( frmMain->cbVideoDataCOMPort->ItemIndex == -1)
         {
            MessageBox(NULL, "Please select VIDEO port name!", "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
            return;
         }

      if (cbiVideoData->ItemIndex == -1) return;


      if ( cbiVideoData->ItemIndex > EventCount -1 ) {
          MessageBox(Handle, "The selected event number exeeds the total number of events", "MDRS - Information", MB_OK|MB_ICONERROR);
          return;
      }
    // ---------------
      SetEnabledC(false);

   // ----- Чтение данных с КОМ Порта ------
      if ( RadioButton1->Checked == true ) WorkVideoEvent_ComPORT(cbiVideoData->ItemIndex, &Events[0], &Events[cbiVideoData->ItemIndex]);
   // ----- Чтение данных с СД карточки  ------
      if ( RadioButton2->Checked == true ) {

             char DriveName[4096];
             sprintf(DriveName, "\\\\.\\%s:", ComboBox1->Text.c_str());
             HANDLE bFile = CreateFile(DriveName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, 0);

                WorkVideoEvent_SDCard (bFile, cbiVideoData->ItemIndex, &Events[0], &Events[cbiVideoData->ItemIndex]);

             CloseHandle(bFile);
      }


      SetEnabledC(true);

      cbBreakReadEvent->Visible = false;
      DirectoryListBox1->Update();

    // ------ Окно о успешном окончании експорта -----
      MessageBox(Handle, "Video data successfully exported!\0", "MDRS - Information", MB_OK|MB_ICONINFORMATION);
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::bVideoDataExportClick(TObject *Sender)
{
      cbBreakReadEvent->Checked = false;
      cbBreakReadEvent->Visible = true;

   // ------- Считываю базовые данніе ----
      if ( DecodePresentEvent() != 0) return;

      if ( RadioButton1->Checked == true )
         if ( frmMain->cbVideoDataCOMPort->ItemIndex == -1)
         {
            MessageBox(NULL, "Please select VIDEO port name!", "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
            return;
         }

  //--
      if ( cbiVideoData->ItemIndex > EventCount -1 ) {
          MessageBox(Handle, "The selected event number exeeds the total number of events", "MDRS - Information", MB_OK|MB_ICONERROR);
          return;
      }
   // ---------------
      SetEnabledC(false);
      // ----- Чтение данных с КОМ Порта ------
      if ( RadioButton1->Checked == true )
           for (int i = 0; i < EventCount; i++) WorkVideoEvent_ComPORT(i, &Events[0], &Events[i]);
    // ----- Чтение данных с СД карточки  ------
      if ( RadioButton2->Checked == true ) {

             char DriveName[4096];
             sprintf(DriveName, "\\\\.\\%s:", ComboBox1->Text.c_str());
             HANDLE bFile = CreateFile(DriveName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, 0);

                for (int i = 0; i < EventCount; i++)
                     WorkVideoEvent_SDCard (bFile, i, &Events[0], &Events[i]);

             CloseHandle(bFile);
      }

      SetEnabledC(true);
   // ---------------
      cbBreakReadEvent->Visible = false;
      DirectoryListBox1->Update();
   // ------ Окно о успешном окончании експорта -----
      MessageBox(Handle, "Video data successfully exported!\0", "MDRS - Information", MB_OK|MB_ICONINFORMATION);
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::RadioButton1Click(TObject *Sender)
{
//     Label3   ->Enabled = RadioButton2->Enabled;
     ComboBox1->Enabled = RadioButton2->Enabled;
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::Seteventpathname1Click(TObject *Sender)
{
//        
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::FormActivate(TObject *Sender)
{
   DecimalSeparator = '.';
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::FormShow(TObject *Sender)
{
   try
   {
      DirectoryListBox1->Directory = SaveEventPath;
      DriveComboBox1->Drive        = DirectoryListBox1->Drive;
   } catch (...)
   {
      DirectoryListBox1->Directory = ExtractFilePath(Application->ExeName);
   }
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::DirectoryListBox1Change(TObject *Sender)
{
   sprintf(SaveEventPath, DirectoryListBox1->Directory.c_str());
//   Label5->Caption  = SaveEventPath;
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::DirectoryListBox1Click(TObject *Sender)
{
   sprintf(SaveEventPath, DirectoryListBox1->Directory.c_str());
}

//---------------------------------------------------------------------------
void __fastcall TfrmExport::DriveComboBox1Change(TObject *Sender)
{
  DirectoryListBox1->Drive = DriveComboBox1->Drive;
}
//---------------------------------------------------------------------------

