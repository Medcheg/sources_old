//---------------------------------------------------------------------------
#include "mpiBlackBox.h"
#include "mpiComPort.h"
#include "stdio.h"

//---------------------------------------------------------------------------
CBlackBox    *BlackBox;
TBEvent      *Events;
int           EventCount;
SVideoHeader  VideoHeader;
char          LogFileName[4096];

//---------------------------------------------------------------------------
TBEvent::TBEvent()
{
   isCorrectEvent = true;
   
   for (int i = 0; i < COUNT_VALUES; i++)
       for (int k = 0; k < COUNT_CONTROL_VALUES; k++)
       {
              values     [i][k] = 0;
              true_values[i][k] = 0;
       }
}

//---------------------------------------------------------------------------
CBlackBox::CBlackBox()
{
   VideoHeader.Description[0] = 'B';
   VideoHeader.Description[1] = 'B';
   VideoHeader.Version        = 1;
   VideoHeader.FrameFrequency = 4;
   VideoHeader.reserved       = 0;
   VideoHeader.FrameWdth      = 256;
   VideoHeader.FrameHeight    = 200;
   VideoHeader.FramesCount    = COUNT_VIDEO_FRAME;
 // ---------------
   isDataReading = false;
   BytesRead = 0;
   ReadBuffer = new unsigned char[1300000];
}

//---------------------------------------------------------------------------
CBlackBox::~CBlackBox()
{
   delete []ReadBuffer;
}

//---------------------------------------------------------------------------
void CBlackBox::SendCommand(CComPort *aComPort, unsigned char *aCommand)
{
  // --------- ƒќбавл€ем ризнак конца строки к команде -------
     char  newCommand[4096];
     sprintf(newCommand, "%s\n\0", aCommand);
     
  // ---------
     if ( aComPort->WriteData(newCommand, strlen(newCommand)) < (int)strlen(newCommand) )
     {
       // --- Error ----
     }
  // -------
     int   BytesReadLocal = -1;

     isDataReading = true;
     BytesRead     = 0;

  // -----------
     while (BytesReadLocal != 0)
     {
         BytesReadLocal  = aComPort->ReadData(&ReadBuffer[BytesRead], 113);
         BytesRead      += BytesReadLocal;

         if ( BytesReadLocal == -1 ) break;

         if (BytesRead % 10 == 0)  Application->ProcessMessages();
     }
  // -----------

     AnsiString as = DateTimeToStr(Date() + Time());
///
     FILE *h_file = fopen(LogFileName, "at");
        fprintf(h_file, "DateTime = %s\t\tCommand = %12s\t\tByte read = %d\n", as.c_str(), aCommand, BytesRead);
     fclose(h_file);
  // -----------

     isDataReading = false;
     ReadBuffer[BytesRead] = 0;
     Application->ProcessMessages();
}
