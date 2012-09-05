#include <vcl.h>
#pragma hdrstop
//===========================================================================
#include "pmSerialPort.h"
#include "stdio.h"
//===========================================================================
CSerialPort::CSerialPort()
{
      BaudRate   = 19200;
      ByteSize   = 8;
      RtsControl = 1;
      hCom       = INVALID_HANDLE_VALUE;
      isOpen     = false;
}

//===========================================================================
void CSerialPort::OpenComPort(char *aComPortName)
{
       isOpen = false;    

   // --------- Открываем КОМ порты -----
       char aNewComPortName[255];
       sprintf(aNewComPortName, "\\\\.\\%s", aComPortName);

       hCom = CreateFile(aNewComPortName, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL );
       //hCom = CreateFile("c:\\test_cvg.txt", GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL );
       //return;

    // ----- Если не смогли открыть порт -- сигнализируем ----
        if ( hCom == INVALID_HANDLE_VALUE || hCom == NULL ) {
            sprintf(aNewComPortName, "Unable to open port name '%s'", aComPortName);
            MessageBox(NULL, aNewComPortName, "Error", MB_OK);
            return;
        }

   // ---- утанавливаю парметры
       GetCommState(hCom, &BasePortSettings);
       memcpy(&PortSettings, &BasePortSettings, sizeof(DCB));

       if ( BaudRate < 0 ) {
            CloseHandle(hCom);
            hCom = INVALID_HANDLE_VALUE;
            MessageBox(NULL, "Negative Baud Rate value", "Error", MB_OK);
            return; // ---- Не смогли установить параметры ком порта
       }

       PortSettings.ByteSize      = ByteSize;
       PortSettings.BaudRate      = BaudRate;
       PortSettings.Parity        = NOPARITY;
       PortSettings.StopBits      = ONESTOPBIT;
       PortSettings.fBinary       = 1;

       PortSettings.fOutX         = 0; //0
       PortSettings.fInX          = 0; //0
       PortSettings.fErrorChar    = 0; //1
       PortSettings.fNull         = 0; //1
       PortSettings.fRtsControl   = RtsControl;


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
       timeouts.ReadTotalTimeoutConstant  = 300;
       timeouts.WriteTotalTimeoutConstant = 300;
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
   // ----
       isOpen = true;    
}

//===========================================================================
void CSerialPort::CloseComPort()
{
      if ( hCom != INVALID_HANDLE_VALUE  && hCom != NULL )
      {
          SetCommState(hCom, &BasePortSettings);
          ClearComPortError(true);
          CloseHandle(hCom);

          hCom = INVALID_HANDLE_VALUE;
      }
      isOpen = false;
}

//===========================================================================
void CSerialPort::ClearComPortError(bool isFullClear)
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
bool CSerialPort::WriteBuffer(char *pcWrite)
{
   if ( hCom == INVALID_HANDLE_VALUE || hCom == NULL ) return false;
   if ( isOpen == false ) return false;
   // -------
   
   DWORD NumberOfBytesToWrite = strlen(pcWrite);
   DWORD NumberOfBytesWritten;
   if ( WriteFile(hCom, pcWrite, NumberOfBytesToWrite, &NumberOfBytesWritten, NULL) == false )
   {
       ClearComPortError(true);
       return false;
   }

   return true;
}

//===========================================================================
bool CSerialPort::ReadBuffer(char *pcRead)
{
    if ( hCom == INVALID_HANDLE_VALUE || hCom == NULL ) return false;
    if ( isOpen == false ) return false;
   // -------

    DWORD NumberOfBytesToRead = 1024;
    DWORD NumberOfBytesRead = -1;
    DWORD BuffPosition = 0;

    while ( NumberOfBytesRead != 0 )
    {
        if ( ReadFile(hCom, &pcRead[BuffPosition], NumberOfBytesToRead, &NumberOfBytesRead, NULL) == false )
        {
            ClearComPortError(true);
            return false;
        }
        BuffPosition += NumberOfBytesRead;
    }

    return true;
}


