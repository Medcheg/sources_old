//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unit_Main.h"
#include "mpi_rep_SerialInfo.h"
#include "stdio.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

TForm1 *Form1;
//===========================================================================
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
    Timer1->Interval = 1000;
    Timer1->Enabled = false;
}

//===========================================================================
void __fastcall TForm1::FormCreate(TObject *Sender)
{
  nsPortInfo::Get_SerialPorts(cbCOMName->Items, false);
}

//===========================================================================
void __fastcall TForm1::ClearComPortError(bool isFullClear)
{
    // Setup a mask that allows us to tell if the port is done transmitting
    // the current buffer of data
    // --- Remove any 'old' data in buffer ---
          if ( isFullClear == true )
          {
             SetCommMask (hCom, EV_TXEMPTY);
             PurgeComm(hCom, PURGE_TXCLEAR | PURGE_RXCLEAR);
          }
    // ---------
          DWORD   dwErrors;
          COMSTAT lCOMSTAT;
          ClearCommError( hCom, &dwErrors, &lCOMSTAT );
}


//===========================================================================
void __fastcall TForm1::OpenComPort(char *aComPortName, int aByteSize,  int aComPortBaudRate, int rto, int wto)
{
   // --------- Открываем КОМ порты -----
       char aNewComPortName[255];
       sprintf(aNewComPortName, "\\\\.\\%s", aComPortName);


       hCom = CreateFile(aNewComPortName, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL );
       //hCom = CreateFile("c:\\test_cvg.txt", GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL );
       //return;

    // ----- Если не смогли открыть порт -- сигнализируем ----
        if ( hCom == INVALID_HANDLE_VALUE) {
            sprintf(aNewComPortName, "Unable to open port name '%s'", aComPortName);
            MessageBox(NULL, aNewComPortName, "Error", MB_OK);
            return;
        }

   // ---- утанавливаю парметры
       GetCommState(hCom, &BasePortSettings);
       memcpy(&PortSettings, &BasePortSettings, sizeof(DCB));

       if ( aComPortBaudRate < 0 ) {
            CloseHandle(hCom);
            hCom = INVALID_HANDLE_VALUE;
            MessageBox(NULL, "Negative Baud Rate value", "Error", MB_OK);
            return; // ---- Не смогли установить параметры ком порта
       }

       PortSettings.ByteSize      = aByteSize;
       PortSettings.BaudRate      = aComPortBaudRate;
       PortSettings.Parity        = NOPARITY;
       PortSettings.StopBits      = ONESTOPBIT;
       PortSettings.fBinary       = 1;

       PortSettings.fOutX         = 0; //0
       PortSettings.fInX          = 0; //0
       PortSettings.fErrorChar    = 0; //1
       PortSettings.fNull         = 0; //1


     // ----- Задаю БОД рейт ----
       if(SetCommState(hCom, &PortSettings) == false) {
            CloseHandle(hCom);
            hCom = INVALID_HANDLE_VALUE;
            sprintf(aNewComPortName, "Unable to open port name '%s'", aComPortName);
            MessageBox(NULL, aNewComPortName, "Error", MB_OK);
            return; // ---- Не смогли установить параметры ком порта
       }

    // -------
       COMMTIMEOUTS timeouts;
       if ( GetCommTimeouts(hCom, &timeouts) == false )
       {
            CloseHandle(hCom);
            hCom = INVALID_HANDLE_VALUE;

            sprintf(aNewComPortName, "Unable to get time parameters of port name '%s'", aComPortName);
            MessageBox(NULL, aNewComPortName, "Error", MB_OK);

            return; // Can't get COM-port timeout settings
       }

   // -----------
       timeouts.ReadTotalTimeoutConstant  = rto;
       timeouts.WriteTotalTimeoutConstant = wto;
       timeouts.ReadIntervalTimeout       = 0;
       //timeouts.ReadIntervalTimeout       = 100;
       if(SetCommTimeouts(hCom, &timeouts) == false)
       {
            CloseHandle(hCom);
            hCom = INVALID_HANDLE_VALUE;
            sprintf(aNewComPortName, "Unable to set time parameters of port name '%s'", aComPortName);
            MessageBox(NULL, aNewComPortName, "Error", MB_OK);

            return; // Can't set COM-port timeout settings (SetCommTimeouts)
       }

   // --------------- sbrasyvaju ves` musor s COM porta ---------
       ClearComPortError(true);
}

//===========================================================================
void __fastcall TForm1::CloseComPort()
{
      if ( hCom != INVALID_HANDLE_VALUE ) {
          SetCommState(hCom, &BasePortSettings);
          CloseHandle(hCom);
          hCom = INVALID_HANDLE_VALUE;
      }
}

void TForm1::writecom(char *hz)
{
    DWORD uBytesWritten = 0;

    WriteFile(hCom, hz, strlen(hz), &uBytesWritten, NULL);

    Sleep(100);
}
//===========================================================================
void __fastcall TForm1::StartClick(TObject *Sender)
{
   nsPortInfo::TSerialPortInfo Port;
   nsPortInfo::GetPortInfo(cbCOMName->ItemIndex, &Port);

   Series1->Clear();

  // ----- Открываю Ком порт ------
   OpenComPort(Port.pcWindowsPortName, 8, 9600, 300, 300);
   AnsiString FileName = ExtractFilePath(Application->ExeName) + Edit1->Text;
   h_file = fopen(FileName.c_str(), "wt");

  // ----- посылаю  команду в Ком порт  ------
    writecom("\r\n");
    writecom("RES\r\n");
    writecom("FA1\r\n");
    writecom("FB1\r\n");
    writecom("STP\r\n");
    writecom("STR\r\n");
    writecom("PHA\r\n");
    writecom("WDA\r\n");
    //writecom("FREQA\r\n");
    //writecom("PHF\r\n");
    //writecom("PHF\r\n");
/*
    writecom("\n\r");
    writecom("RES\n\r");
    writecom("FA1\n\r");
    writecom("FB1\n\r");
    writecom("STP\n\r");
    writecom("STR\n\r");
    //writecom("PHA\n\r");
    writecom("FREQA\n\r");
    //writecom("PHF\n\r");
    //writecom("PHF\n\r");

*/

/*      char *str;
      char *str1 = "RES\n";  str = str1;
      char *str1 = "PHA\n";  WriteFile(hCom, str1, strlen(str1), &uBytesWritten, NULL);
      char *str2 = "\n";  WriteFile(hCom, str2, strlen(str2), &uBytesWritten, NULL);
      char *str3 = "FB0\n";  WriteFile(hCom, str3, strlen(str3), &uBytesWritten, NULL);
*/
  // ---
    Timer1->Enabled = true;
    QueryPerformanceFrequency(&qpf);
    QueryPerformanceCounter(&qpc1);
    Start->Enabled = false;
    Button1->Enabled = true;
}

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
    Timer1->Enabled = false;
    writecom("\n\r");
    writecom("RES\n\r");
    writecom("STP\n\r");
    CloseComPort();
    if ( h_file != NULL) fclose(h_file   );
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
    Start->Enabled = true;
    Button1->Enabled = false;
    Timer1->Enabled = false;
    CloseComPort();
    if ( h_file != NULL) fclose(h_file   );
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Timer1Timer(TObject *Sender)
{
    char ReadBuffer[64];
    char Buffer[64];
    setmem(ReadBuffer, 64, 0);
  // ----- посылаю  команду в Ком порт  ------
    //writecom("XMT\n\r");
    writecom("XMT\r\n");

  // ----- Считываю команды с Ком порта ------
    DWORD  BytesReadLocal = -1;
    ReadFile(hCom, ReadBuffer, 300, &BytesReadLocal, NULL);
    ReadBuffer[BytesReadLocal] = '\0';

  // ------------ Время -------
    QueryPerformanceFrequency(&qpf);
    QueryPerformanceCounter(&qpc2);
    float CurTime = (float)(qpc2.QuadPart - qpc1.QuadPart) / (double) qpf.QuadPart;

    Label1->Caption = ReadBuffer;
    Caption = "HAMEG 8123 - [ " + FloatToStrF(CurTime, ffFixed, 10, 2) + " сек ]";

    // -------------- Запись в файл --------
    float val;
    int  aa = sscanf(ReadBuffer, "%f %s", &val, Buffer);

    if ( aa >= 2 )
    {
      fprintf(h_file, "%f\t%f\n", CurTime, val);
      fflush (h_file);
    }

    if ( Series1->XValues->Count < 20000 ) Series1->AddXY(CurTime, val);
    else Chart1->BottomAxis->SetMinMax(0, CurTime);
}
//---------------------------------------------------------------------------

