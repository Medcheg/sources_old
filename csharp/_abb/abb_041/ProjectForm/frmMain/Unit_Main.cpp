//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "math.h"
#include "stdio.h"

#include "Unit_Main.h"
#include "mpiComPort.h"
#include "mpiBlackBox.h"
#include "mpiDeclaration.h"
#include "Registry.hpp"
#include "mpiTimer.h"
#include "Unit_TestBinRead.h"
#include "Unit_Export.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmMain *frmMain;

//---------------------------------------------------------------------------
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
   if (Font->PixelsPerInch != 96)
       MessageBox(Handle, "For proper data display in the program, Windows 'Pixels per Inch' parameter value should be 96.", "Warning", MB_ICONWARNING|MB_OK);

  // --------------------------------------
     BlackBox          = new CBlackBox();
     ComPort1          = new CComPort();
     ComPort2          = new CComPort();
     BaseTimer         = new TmpiTimer();     BaseTimer->Enabled(true);
     //InnaLabsLogo      = new CInnaLabsLogo(Image1);

     Caption = ProjectCaption;


     sprintf(LogFileName, "%sabb_com_port.log", ExtractFilePath(Application->ExeName).c_str());

   // --------- Читаю данные из реестра и востанавливаю параметры предыдущего используемого порта ----
     ReadFromRegestry();

     lRefreshCOMPortList1Click(Sender);
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
   // ---------
     SaveToRegestry();
   // ---------
     delete BlackBox;      BlackBox     = NULL;
     delete ComPort1;      ComPort1     = NULL;
     delete ComPort2;      ComPort2     = NULL;
     delete BaseTimer;     BaseTimer    = NULL;              
   // ---------
}

//---------------------------------------------------------------------------
void TfrmMain::ReadFromRegestry()
{
    sprintf(SaveEventPath, ExtractFilePath(Application->ExeName).c_str());
  // ------------
      AnsiString Name;
      TRegistry *Reg = NULL;
      try {
          try {
             Reg = new TRegistry;
             AnsiString appName = ExtractFileName(Application->ExeName); // --- "DiALab - Digital & Analog Laboratory"; // --- ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);
             appName.SetLength(appName.Length() - 4);

             Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
             Reg->OpenKey("Software\\InnalabsUA\\Automobile MDRS", true); //create a new key >> .ext

             LastUsedDataComPort      = Reg->ReadString("Last Used Data COM Port");
             LastUsedVideoDataComPort = Reg->ReadString("Last Used Video Data COM Port");

             AnsiString as = Reg->ReadString("Last Used Saved Path Name");
             if ( as.data() != NULL) sprintf(SaveEventPath, as.c_str());

       } catch ( ... ){
             LastUsedDataComPort      = "";
             LastUsedVideoDataComPort = "";
             SaveToRegestry();
        }
    } __finally {
        if (Reg != NULL) delete Reg;
    }
}


//---------------------------------------------------------------------------
void TfrmMain::SaveToRegestry()
{
      TRegistry *Reg = NULL;
      try {
         Reg = new TRegistry;
         AnsiString appName = ExtractFileName(Application->ExeName);//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);
         appName.SetLength(appName.Length() - 4);

         Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
         Reg->OpenKey("Software\\InnalabsUA\\Automobile MDRS", true); //create a new key >> .ext

         Reg->WriteString("Last Used Data COM Port"      , LastUsedDataComPort     );
         Reg->WriteString("Last Used Video Data COM Port", LastUsedVideoDataComPort);
         Reg->WriteString("Last Used Saved Path Name"    , SaveEventPath);
      } __finally {
        if (Reg != NULL) delete Reg;
      }
}

//---------------------------------------------------------------------------
void TfrmMain::OutputResult_To_MEM0()
{
     mCOM_EchoList->Lines->BeginUpdate();
     mCOM_EchoList->Clear();

  // -----------------
     if ( CheckCOMText(eCOMText->Text, "bin_read ") == true )
     {
         char buff[4096];
         unsigned int i;
         for (i = 0; i < BlackBox->BytesRead; i++)
         {
            if (BlackBox->ReadBuffer[i] == 0x0A) break;
            buff[i] = BlackBox->ReadBuffer[i];
         }
      // ------- Формирую новую строку для вывода ----
         int EventId = -1;
         sscanf(BlackBox->ReadBuffer, "bin_read %d", &EventId);
         sprintf(&buff[i-1], " successfully fulfilled!\0");
      // ----------
         mCOM_EchoList->Lines->Add(buff);
     }
     else
     {
          mCOM_EchoList->Lines->Add((char*)BlackBox->ReadBuffer);
     }
  // ----
     mCOM_EchoList->Lines->EndUpdate();
}

//---------------------------------------------------------------------------
bool TfrmMain::CheckCOMText(AnsiString as, char *achar)
{
     if ( (unsigned int)as.Length() < strlen(achar)) return false;

     bool aResult = true;
     for (unsigned int i = 0; i < strlen(achar); i++)
       if ( as[i+1] != achar[i]) aResult = false;

     return aResult;
}

void TfrmMain::Draw_and_Decode_frame()
{
  Graphics::TBitmap *aBitmap = new Graphics::TBitmap();
 //aBitmap->Width  = 512;
  //aBitmap->Height = 400;
  aBitmap->Width  = 256;
  aBitmap->Height = 200;

  for (unsigned int i = 0; i < BlackBox->BytesRead; i++)
  {
     //int x = (i%256) * 2;
     //int y = (i/256) * 2;
     int x = i%256;
     int y = i/256;
     aBitmap->Canvas->Pixels[x + 0][y + 0] = (TColor)RGB(BlackBox->ReadBuffer[i], BlackBox->ReadBuffer[i], BlackBox->ReadBuffer[i]);
     //aBitmap->Canvas->Pixels[x + 1][y + 0] = (TColor)RGB(BlackBox->ReadBuffer[i], BlackBox->ReadBuffer[i], BlackBox->ReadBuffer[i]);

     //aBitmap->Canvas->Pixels[x + 0][y + 1] = (TColor)RGB(BlackBox->ReadBuffer[i], BlackBox->ReadBuffer[i], BlackBox->ReadBuffer[i]);
     //aBitmap->Canvas->Pixels[x + 1][y + 1] = (TColor)RGB(BlackBox->ReadBuffer[i], BlackBox->ReadBuffer[i], BlackBox->ReadBuffer[i]);
  }

  iVideo->Picture->Bitmap->Assign(aBitmap);

  delete aBitmap;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::bSendCommandClick(TObject *Sender)
{
     BaseTimer->Reset();

     isCommandSuccesed        = false;
     ProgressBar1->Position = 0;
     OldBytesRead           = 0;
     OldOneSecTime          = 0;

   // ---- Не введенное имя Для Дата порта порта ----
     if ( CheckCOMText(eCOMText->Text, "capture ") == false)
         if ( cbDataCOMPort->ItemIndex == -1 )
         {
             MessageBox(NULL, "Please select DATA port name!", "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
             return;
         }

   // ---- Не введенное имя Для Видео порта порта ----
     if ( CheckCOMText(eCOMText->Text, "capture ") == true)
         if ( cbVideoDataCOMPort->ItemIndex == -1 )
         {
             MessageBox(NULL, "Please select VIDEO port name!", "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
            return;
         }
  // ---------- Ошибка открытия КОМ Порта -------
     unsigned int uiBaudRate = 921600;
     int          iTimeOut   = StrToInt(ComboBox2->Text);

     LastUsedDataComPort      = cbDataCOMPort     ->Items->Strings[cbDataCOMPort     ->ItemIndex];
     LastUsedVideoDataComPort = cbVideoDataCOMPort->Items->Strings[cbVideoDataCOMPort->ItemIndex];

  // --------Открываю порты -----
     if ( cbDataCOMPort->ItemIndex != -1)
         if ( ComPort1->OpenComPort(LastUsedDataComPort.c_str(), uiBaudRate, iTimeOut, iTimeOut) != 0)
         {
             MessageBox(NULL, "Open data COM port failed!", "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
             //return;
         }
     if ( cbVideoDataCOMPort->ItemIndex != -1)
         if ( ComPort2->OpenComPort(LastUsedVideoDataComPort.c_str(), uiBaudRate, 500, 10) != 0)
         {
             MessageBox(NULL, "Open video data COM port failed!", "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
             //return;
         }
     if ( ComPort1->isCOMHandleNULL() == true && ComPort2->isCOMHandleNULL() == true) return;

  // -------------
     bSendCommand->Enabled = false;

  // ------- Выставляю рамер Прогресс бара -----
     if ( CheckCOMText(eCOMText->Text, "read "   ) == true ) ProgressBar1->Max = 822000; else
     if ( CheckCOMText(eCOMText->Text, "capture ") == true ) ProgressBar1->Max = 51200;  else
     ProgressBar1->Max = 280920;

  // ------- Посылаю команду -----
     if ( ComPort2->isCOMHandleNULL() == false ){
             if ( CheckCOMText(eCOMText->Text, "capture ") == true )
             {
                       pVideo->Visible = true;
                       BlackBox->SendCommand(ComPort2, eCOMText->Text.c_str());
                     // ---------
                       Draw_and_Decode_frame();
             }
             ComPort2->CloseComPort();
     }
  // --------------
     if ( ComPort1->isCOMHandleNULL() == false ){
         if ( CheckCOMText(eCOMText->Text, "capture ") == false)
         {
               pVideo->Visible = false;
               BlackBox->SendCommand(ComPort1, eCOMText->Text.c_str());
             // -------  Эхо Лист для Буффера ------
               OutputResult_To_MEM0();
         }
         ComPort1->CloseComPort();
     }
  // ------- Закрываю ком порт ----
  // --------
     bSendCommand->Enabled = true;
     isCommandSuccesed     = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::lCommandClick(TObject *Sender)
{
    if ( ((TLabel*)Sender)->Caption == "erase" )
    {
         if (MessageBox(Handle, "Are you sure you want to erase data?", "MDRS - Question", MB_YESNO|MB_ICONQUESTION) == IDNO) return;
    }

    eCOMText->Text = ((TLabel*)Sender)->Caption;
//    eCOMText->Text = "capture ";

    Application->ProcessMessages();
    //if (((TLabel*)Sender)->Caption != Label1->Caption ) 
    bSendCommandClick(Sender);
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::ComboBox1Change(TObject *Sender)
{
    eCOMText->Text = "read " + IntToStr(ComboBox1->ItemIndex);
 // ----
    bSendCommandClick(Sender);
 // ----
    ComboBox1->OnChange  = NULL;
    ComboBox1->ItemIndex = -1;
    ComboBox1->OnChange  = ComboBox1Change;

    mCOM_EchoList->SetFocus();
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::ComboBox2Change(TObject *Sender)
{
/*    eCOMText->Text = "bin_read " + IntToStr(ComboBox2->ItemIndex);
 // ----
    bSendCommandClick(Sender);
 // ----
    ComboBox2->OnChange  = NULL;
    ComboBox2->ItemIndex = -1;
    ComboBox2->OnChange  = ComboBox2Change;

    mCOM_EchoList->SetFocus();
*/
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::bExportDataClick(TObject *Sender)
{
   frmExport->ShowModal();
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::Timer1Timer(TObject *Sender)
{
    // ------ Количество прочитанных данных --------
          pBytesRead->Caption = "   Bytes read: " + IntToStr(BlackBox->BytesRead);

          float CurTime = BaseTimer->GetTime(); 

       // ---- Сколько времени читаем -------
          if ( BlackBox->isDataReading == true)
          {

            // --- Скорость чтения данных -------
               if ( CurTime - OldOneSecTime  >= 0.25) {
                    pSpeedRead->Caption = "   Data reading rate: " + IntToStr((BlackBox->BytesRead - OldBytesRead) * 4);
                    OldOneSecTime       = CurTime;
                    OldBytesRead        = BlackBox->BytesRead;
               }
            // -------

               pElapsedTime->Caption = "  Elapsed time : " + FloatToStrF(CurTime, ffFixed, 20, 2) + " sec";

               int OffsetBytesRead = ( BlackBox->BytesRead / ProgressBar1->Max ) * ProgressBar1->Max;
               ProgressBar1->Position = BlackBox->BytesRead - OffsetBytesRead;

          } else ProgressBar1->Position = ProgressBar1->Max;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::cbDataCOMPortCloseUp(TObject *Sender)
{
   LastUsedDataComPort      = cbDataCOMPort     ->Items->Strings[cbDataCOMPort     ->ItemIndex];
   LastUsedVideoDataComPort = cbVideoDataCOMPort->Items->Strings[cbVideoDataCOMPort->ItemIndex];
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::lRefreshCOMPortList1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
    ((TLabel*)Sender)->Font->Color = clBlue;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::lRefreshCOMPortList1MouseLeave(TObject *Sender)
{
    ((TLabel*)Sender)->Font->Color = clBlack;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::lRefreshCOMPortList1Click(TObject *Sender)
{
  // ---- Заполняю Комбобокс теми количествами компортов которые есть -----
     ComPort1->ScanPorts();
     cbDataCOMPort->Items->Clear();
     for (int i = 0; i < ComPort1->CountComPortNames; i++)
          cbDataCOMPort->Items->Add(ComPort1->ComPortNames[i]);
 // -----------------------
     int aIndex1 = cbDataCOMPort->Items->IndexOf(LastUsedDataComPort);
     if ( aIndex1 != -1 )
     {
        cbDataCOMPort->ItemIndex = aIndex1;
     }
 // -----------------------
     cbVideoDataCOMPort->Items->Assign(cbDataCOMPort->Items);
     int aIndex2 = cbVideoDataCOMPort->Items->IndexOf(LastUsedVideoDataComPort);
     if ( aIndex2 != -1 )
     {
        cbVideoDataCOMPort->ItemIndex = aIndex2;
     }
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::Panel4DblClick(TObject *Sender)
{
    frmTestBinRead->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::sbResetDataCPClick(TObject *Sender)
{
    cbDataCOMPort->ItemIndex = -1;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::sbResetVideoCPClick(TObject *Sender)
{
    cbVideoDataCOMPort->ItemIndex = -1;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::Button1Click(TObject *Sender)
{
     lRefreshCOMPortList1Click(Sender);

  //-------------
     unsigned int uiBaudRate = 921600;

     LastUsedVideoDataComPort = "";
     LastUsedDataComPort      = "";
     cbDataCOMPort->ItemIndex = -1;
     cbVideoDataCOMPort->ItemIndex = -1;

     for (int i = 0; i < ComPort1->CountComPortNames; i++){
         if (ComPort1->OpenComPort(ComPort1->ComPortNames[i], uiBaudRate, 100, 100) != 0) continue;

         BlackBox->SendCommand(ComPort1, "id");
         if (BlackBox->BytesRead > 0) {
          // ------------
             if (strcmp (BlackBox->ReadBuffer, "id\r\nID=1234567890\r\n") == 0){
                // ----- Значит тут Дата ком --
                LastUsedDataComPort = ComPort1->ComPortNames[i];
                lRefreshCOMPortList1Click(Sender);
             }
          // ------------
             if (strcmp (BlackBox->ReadBuffer, "ID=0987654321\r\n") == 0) {
                // ----- Значит тут Video ком --
                LastUsedVideoDataComPort= ComPort1->ComPortNames[i];
                lRefreshCOMPortList1Click(Sender);
             }
          // ------------
         }
         ComPort1->CloseComPort();
     }
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::FormResize(TObject *Sender)
{
    pVideo->Left = (ClientWidth - pVideo->Width) / 2;
    pVideo->Top  = mCOM_EchoList->Top + (ClientHeight - mCOM_EchoList->Top - pVideo->Height) / 2;
}
//---------------------------------------------------------------------------

