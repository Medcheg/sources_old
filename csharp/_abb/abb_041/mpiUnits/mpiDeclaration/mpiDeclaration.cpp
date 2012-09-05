//---------------------------------------------------------------------------
#include "mpiDeclaration.h"
#include "stdio.h"
#include "dir.h"
#include "forms.hpp"

char SaveEventPath[4096] = {0};
AnsiString  ProjectCaption = "Motion Data Recording System";

//===========================================================================
void ShowErrorMessage(char *aFuncName)
{
    TCHAR szBuf[1024];
    LPVOID lpMsgBuf;
    DWORD dw = GetLastError();

  // -------------
        FormatMessage(
            FORMAT_MESSAGE_ALLOCATE_BUFFER |
            FORMAT_MESSAGE_FROM_SYSTEM,
            NULL,
            dw,
            MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
            (LPTSTR) &lpMsgBuf,
            0, NULL );
  // -------------
  
    wsprintf(szBuf, "%s failed with error %d: %s", aFuncName, dw, lpMsgBuf);

    MessageBox(NULL, szBuf, "Error", MB_OK);
///
    LocalFree(lpMsgBuf);
    //ExitProcess(dw);
}


void ErrorExit(LPTSTR lpszFunction) 
{ 
    TCHAR szBuf[80]; 
    LPVOID lpMsgBuf;
    DWORD dw = GetLastError(); 

    FormatMessage(
        FORMAT_MESSAGE_ALLOCATE_BUFFER | 
        FORMAT_MESSAGE_FROM_SYSTEM,
        NULL,
        dw,
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
        (LPTSTR) &lpMsgBuf,
        0, NULL );

    wsprintf(szBuf, 
        "%s failed with error %d: %s", 
        lpszFunction, dw, lpMsgBuf); 
 
    MessageBox(NULL, szBuf, "Error", MB_OK); 

    LocalFree(lpMsgBuf);
//    ExitProcess(dw); 
}
//---------------------------------------------------------------------------
int PosNextLine(char *aBuffer, int aPosition)
{
     while (aBuffer[aPosition++] != '\n'){}
  // ----------
     return aPosition;
}

//---------------------------------------------------------------------------
bool DecodeBuffer(TBEvent *aEvent, unsigned char *aBuffer)
{
              bool Result = true;
         // ----------
              if ( BlackBox->BytesRead < 5000 ) {
                  MessageBox(NULL, "Error code 1", "MDRS - Error", MB_OK|MB_ICONERROR|MB_TASKMODAL);
                  aEvent->isCorrectEvent = false;
              }

          // --- Находим позицию Первого вхождения 0хАА, 0х55 ----
              int iPosBuffer = 0;
              for (unsigned int i = 0; i < BlackBox->BytesRead; i++)
                  if (BlackBox->ReadBuffer[i+0] == 0x01 &&
                      BlackBox->ReadBuffer[i+1] == 0x01 &&
                      BlackBox->ReadBuffer[i+2] == 0xAA &&
                      BlackBox->ReadBuffer[i+3] == 0x55 &&
                      BlackBox->ReadBuffer[i+4] == 0x01 &&
                      BlackBox->ReadBuffer[i+5] == 0x01 &&
                      BlackBox->ReadBuffer[i+6] == 0x01 &&
                      BlackBox->ReadBuffer[i+7] == 0x01)
                  {
                      iPosBuffer = i;
                      break;
                  }

          // --- Декодирую данные ---
              aEvent->BlocksCount    = 0;
              aEvent->RealBlockCount = 0;
              while ( BlackBox->ReadBuffer[iPosBuffer+0] == 0x01 &&
                      BlackBox->ReadBuffer[iPosBuffer+1] == 0x01 &&
                      BlackBox->ReadBuffer[iPosBuffer+2] == 0xAA &&
                      BlackBox->ReadBuffer[iPosBuffer+3] == 0x55 &&
                      BlackBox->ReadBuffer[iPosBuffer+4] == 0x01 &&
                      BlackBox->ReadBuffer[iPosBuffer+5] == 0x01 &&
                      BlackBox->ReadBuffer[iPosBuffer+6] == 0x01 &&
                      BlackBox->ReadBuffer[iPosBuffer+7] == 0x01)
              {
                     unsigned char* ptr;

                     int bk = aEvent->BlocksCount;

                     ptr = (unsigned char*)&aEvent->values[bk][0];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 6+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 7+2];

                     ptr = (unsigned char*)&aEvent->values[bk][1];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 8+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 9+2];

                     ptr = (unsigned char*)&aEvent->values[bk][2];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 10+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 11+2];

                     ptr = (unsigned char*)&aEvent->values[bk][3];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 12+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 13+2];

                     ptr = (unsigned char*)&aEvent->values[bk][4];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 14+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 15+2];

                     ptr = (unsigned char*)&aEvent->values[bk][5];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 16+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 17+2];

                     ptr = (unsigned char*)&aEvent->values[bk][6];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 18+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 19+2];

                     ptr = (unsigned char*)&aEvent->values[bk][7];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 20+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 21+2];

                     ptr = (unsigned char*)&aEvent->values[bk][8];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 22+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 23+2];

                     ptr = (unsigned char*)&aEvent->values[bk][9];
                     ptr[1] = BlackBox->ReadBuffer[iPosBuffer + 24+2];
                     ptr[0] = BlackBox->ReadBuffer[iPosBuffer + 25+2];

                     /*if ( aEvent->values[bk][0] == 0 &&
                          aEvent->values[bk][1] == 0 &&
                          aEvent->values[bk][2] == 0 &&
                          aEvent->values[bk][3] == 0 &&
                          aEvent->values[bk][4] == 0 &&
                          aEvent->values[bk][5] == 0 &&
                          aEvent->values[bk][6] == 0 &&
                          aEvent->values[bk][7] == 0 &&
                          aEvent->values[bk][8] == 0 &&
                          aEvent->values[bk][9] == 0) {
                              aEvent->BlocksCount = 0;
                              aEvent->isCorrectEvent = false;
                              MessageBox(NULL, "Event 1 data is incorrect! Please try to export this event again!", "MDRS - Error", MB_ICONERROR|MB_OK|MB_TASKMODAL);
                              return;
                          }
                       */
                   // ---- нахожу следующее положение, АА55 -----
                     int PrevPosition = iPosBuffer;
                     iPosBuffer += 2;   // ---- смещаюсь на +2 от начала перд пакета------

                     while ( iPosBuffer < BlackBox->BytesRead - 15 )
                     {   //  --- asd ---
                         if ( BlackBox->ReadBuffer[iPosBuffer+0] == 0x01 &&
                              BlackBox->ReadBuffer[iPosBuffer+1] == 0x01 &&
                              BlackBox->ReadBuffer[iPosBuffer+2] == 0xAA &&
                              BlackBox->ReadBuffer[iPosBuffer+3] == 0x55 &&
                              BlackBox->ReadBuffer[iPosBuffer+4] == 0x01 &&
                              BlackBox->ReadBuffer[iPosBuffer+5] == 0x01 &&
                              BlackBox->ReadBuffer[iPosBuffer+6] == 0x01 &&
                              BlackBox->ReadBuffer[iPosBuffer+7] == 0x01)
                              {
                                 __asm {nop};
                                 break;
                              }

                        iPosBuffer++;
                     }

                     if ( iPosBuffer < BlackBox->BytesRead - 20 )
                         if (iPosBuffer - PrevPosition != 28){
                              FILE *h_file = fopen(LogFileName, "at");
                                  fprintf(h_file, "\t\t\t\t\tPackNumber = %d\t\tPacketLength = %d\n", aEvent->BlocksCount, iPosBuffer - PrevPosition);
                              fclose(h_file);

                              aEvent->isCorrectEvent = false;
                              Result = false;
                              continue;
                         }

                     aEvent->BlocksCount++;
              }
    return Result;          
}


//---------------------------------------------------------------------------
bool isWrongValue(unsigned short int *aData)
{
   bool Result = true;

   for ( int i = 0; i < COUNT_CONTROL_VALUES; i ++)
      if ( aData[i] != 65535 ) Result = false;

   return Result;    
}

//---------------------------------------------------------------------------
int Get_Array_Position(TBEvent *aEvent, int  aCurrentPoint )
{
     int Result = aCurrentPoint;
     if (aCurrentPoint > aEvent->BlocksCount - 1) Result = aCurrentPoint - aEvent->BlocksCount;
     if (aCurrentPoint < 0) Result = aCurrentPoint + aEvent->BlocksCount;

      return Result;
}

//---------------------------------------------------------------------------
int Correct_DataBuffer(TBEvent *aEvent)
{
  // ----
     int SecondPoint = aEvent->Events_point / 24;
     int ThirdPoint  = (SecondPoint + aEvent->Number_of_byte_after_event / 24) -1;
     int FirstPoint  = ThirdPoint - aEvent->BlocksCount;

  // ----
     int CurrentPoint = FirstPoint;
     //int RealBlockNumber = 0;
     int ArrayPosition;

     aEvent->RealBlockCount = 0;
  // ----
     while (CurrentPoint++ < ThirdPoint) {
         // Выбираю правильную позици ю в в входном бухфере ----
           ArrayPosition = Get_Array_Position(aEvent, CurrentPoint );

         // Проверяем на $FFFF данные в ходном масиве -------
           if ( isWrongValue(aEvent->values[ArrayPosition]) == true)
           {
               aEvent->RealBlockCount = 0;
               continue;
           }

         // Если мы попали в "нулевое время" запоминаем смещение масиива ----  
           if ( CurrentPoint == SecondPoint ) aEvent->zero_time = aEvent->RealBlockCount;

         // перекидываем данные с входного буфера в "правильный" буфер -----  
           for (int i = 0; i < COUNT_CONTROL_VALUES; i++)
                 aEvent->true_values[aEvent->RealBlockCount][i] = aEvent->values[ArrayPosition][i];

           aEvent->RealBlockCount ++;
     }
  // ----
     return 0;
}

// -------------------------------------------------------------------------
void Save_DataEvent_to_Disk(TBEvent *aEvent, int aEventNumber)
{
    // ----- Имя файла и его запись ------
       AnsiString pp = SaveEventPath;

       AnsiString AppPath = pp + "\\" + aEvent->ExportFolderName;

       if ( SetCurrentDirectory(AppPath.c_str()) == 0)
            if ( CreateDirectory(AppPath.c_str(), NULL) != 0 )
                SetCurrentDirectory(AppPath.c_str());
            else ShowErrorMessage("'CreateDirectory()'");


       //mkdir(AppPath.c_str());

       if ( aEvent->isCorrectEvent == false ) return;
    // -----
       AnsiString FileName = AppPath + "\\" + "event_" + IntToStr(aEventNumber) + ".eve";
       FILE *aFile = fopen(FileName.c_str(), "wb");
       //FILE *aFile = fopen(FileName.c_str(), "w");

    // -----------------------
       AnsiString asData = IntToStr(aEvent->month) + "/" + IntToStr(aEvent->day) + "/" + IntToStr(aEvent->year) + " " + IntToStr(aEvent->hour) + ":" + IntToStr(aEvent->min) + ":" + IntToStr(aEvent->sec);
       char *aData = new char[30];   setmem (aData, 30, 32);
       memcpy(aData, asData.c_str(), asData.Length());

       float DeltaT = 2.0;
       short int temperature = aEvent->CurrentTemp;

   // ----- Запись Файла -----
       fwrite( aData            , 30                       , 1, aFile);
       fwrite(&DeltaT           , sizeof(DeltaT)           , 1, aFile);
       fwrite(&aEvent->zero_time, sizeof(aEvent->zero_time), 1, aFile);
       fwrite(&temperature      , sizeof(temperature)      , 1, aFile);

   // ------
       for (int k = 0; k < aEvent->RealBlockCount; k++) {
             //fprintf (aFile, "%f \n",  (float)aDataBuffer[k][14]);

             for (int i = 0; i < COUNT_CONTROL_VALUES; i ++) {
                   fwrite (&aEvent->true_values[k][i], sizeof(unsigned short int), 1, aFile);
             }

       }
   // ------
       fclose(aFile);
}

// -------------------------------------------------------------------------
void Save_VideoEvent_to_Disk(TBEvent *aEvent, int aEventNumber)
{
    // ----- Имя файла и его запись ------
       AnsiString pp = SaveEventPath;
       AnsiString AppPath = pp + "\\" + aEvent->ExportFolderName;

       if ( SetCurrentDirectory(AppPath.c_str()) == 0)
            if ( CreateDirectory(AppPath.c_str(), NULL) != 0 )
                SetCurrentDirectory(AppPath.c_str());
            else ShowErrorMessage("'CreateDirectory()'");

       //mkdir(AppPath.c_str());

    // -----
       AnsiString FileName = AppPath + "\\" + "event_" + IntToStr(aEventNumber) + ".evb";
       FILE *aFile = fopen(FileName.c_str(), "wb");

   // ----- Запись Шапки -----
       fwrite(&VideoHeader, sizeof(VideoHeader), 1, aFile);

   // ------ Найшли мимнимальное значени кадрового АйДи -----
       int MinFrameIdNumber = aEvent->FrameNumber[0];
       for (int i = 1; i < COUNT_VIDEO_FRAME; i++)
          if ( MinFrameIdNumber > aEvent->FrameNumber[i] ) MinFrameIdNumber = aEvent->FrameNumber[i];

   // ----
       int CurFrame = MinFrameIdNumber;
       while ( CurFrame <= MinFrameIdNumber + COUNT_VIDEO_FRAME)
       {
            for (int i = 0; i < COUNT_VIDEO_FRAME; i++) {
                if ( CurFrame == aEvent->FrameNumber[i])
                {
                   // ------- Для коли флипую картинку ------
                      unsigned char* frame = (unsigned char *)aEvent->VideoData[i];
                      unsigned char* flip  = new unsigned char[VIDEO_FRAME_SIZE];
                      unsigned char* dst = flip + VIDEO_FRAME_SIZE - VideoHeader.FrameWdth;

                      for (int k = 0; k < VideoHeader.FrameHeight; k++, frame +=VideoHeader.FrameWdth, dst -= VideoHeader.FrameWdth){
                          memcpy(dst, frame, VideoHeader.FrameWdth);
                      }
                       fwrite(flip, VIDEO_FRAME_SIZE, 1, aFile);
                      delete[] flip;
                }
            }
            CurFrame++;
       }
   // ------
       fclose(aFile);
}

