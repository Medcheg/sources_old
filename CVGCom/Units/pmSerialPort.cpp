//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmSerialPort.h"
#include "Unit_DebugWindow.h"
#include "pmTimer.h"

//===========================================================================
CSerialPort::CSerialPort()
{
    BaudRate     = 19200;
    ByteSize     = 8;
    XonChar      = 0;
    XoffChar     = 0;
    XonLim       = 0;
    XoffLim      = 0;
    RtsControl   = RTS_CONTROL_DISABLE;
    DtrControl   = DTR_CONTROL_DISABLE;
    ReadTotalTimeoutConstant  = 100;
    WriteTotalTimeoutConstant = 100;
    ReadIntervalTimeout       = 0;

    hComm         = INVALID_HANDLE_VALUE;
    isOpen       = false;
    isAsyncWork  = false;
    fPortName = NULL;

    QueryPerformanceFrequency(&li_f);
    TimeOutCounter = 10.0 * li_f.QuadPart * 0.001;

    async_com_buffer        = (unsigned char*) malloc (32768);
    async_local_com_buffer  = (unsigned char*) malloc (32768);

    ovWait.Internal = 0;
    ovWait.InternalHigh = 0;
    ovWait.Offset = 0;
    ovWait.OffsetHigh = 0;
    ovWait.hEvent = CreateEvent(NULL, FALSE, FALSE, NULL);
}

//===========================================================================
CSerialPort::~CSerialPort()
{
    if ( async_com_buffer       != NULL ) free (async_com_buffer      ); async_com_buffer       = NULL;
    if ( async_local_com_buffer != NULL ) free (async_local_com_buffer); async_local_com_buffer = NULL;

    if ( fPortName != NULL ) free(fPortName); fPortName = NULL;
      CloseHandle(ovWait.hEvent);
}

//===========================================================================
char* __fastcall CSerialPort::Get_ComportName()
{
    return fPortName;
}

//===========================================================================
void __fastcall CSerialPort::Set_ComportName(char *aComName)
{
    if ( fPortName != NULL )
        try
        {
            free(fPortName);
        }
        __finally
        {
            fPortName = NULL;
        }


    if ( aComName != NULL )
        try
        {
            fPortName = strdup(aComName);
        }
        catch ( ... )
        {
            fPortName = NULL;
        }
}

//===========================================================================
bool CSerialPort::OpenComPort( )
{
   // ---------
       isOpen = false;

   // ---------
       if ( fPortName == NULL ) return false;

   // --------- Открываем КОМ порты -----
       char aNewPortName[255];
       sprintf(aNewPortName, "\\\\.\\%s", fPortName);

       if ( isAsyncWork == true )
            hComm = CreateFile(aNewPortName, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, NULL );
       else hComm = CreateFile(aNewPortName, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL );

    // ----- Если не смогли открыть порт -- сигнализируем ----
        if ( hComm == INVALID_HANDLE_VALUE || hComm == NULL )
        {
            sprintf(aNewPortName, "Unable to open port name '%s'", fPortName);
            MessageBox(NULL, aNewPortName, "Error", MB_OK);
            return false;
        }

   // ---- Буфера ----
        if ( isAsyncWork == true  )
            if ( SetupComm( hComm ,1024,1024) == false )
            {
                sprintf(aNewPortName, "Unable setup '%s' buffers ", fPortName);
                MessageBox(NULL, aNewPortName, "Error", MB_OK);
                return false;
            }

        // ---- Маски ---
        if ( SetCommMask( hComm, EV_RXCHAR ) == false )
        {
            sprintf(aNewPortName, "Unable setup '%s' events mask", fPortName);
            MessageBox(NULL, aNewPortName, "Error", MB_OK);
            return false;
        }

        // ----- Чищу буфера ----
        if ( PurgeComm( hComm, PURGE_TXCLEAR | PURGE_RXCLEAR ) == false )
        {
            sprintf(aNewPortName, "Unable setup clear '%s' buffers", fPortName);
            MessageBox(NULL, aNewPortName, "Error", MB_OK);
            return false;
        }

   // ---- утанавливаю парметры
       GetCommState( hComm, &BasePortSettings);
       memcpy(&PortSettings, &BasePortSettings, sizeof(DCB));

       if ( BaudRate < 0 ) {
            CloseHandle(hComm);
            hComm = INVALID_HANDLE_VALUE;
            MessageBox(NULL, "Negative Baud Rate value", "Error", MB_OK);
            return false; // ---- Не смогли установить параметры ком порта
       }

       PortSettings.ByteSize      = ByteSize;
       PortSettings.BaudRate      = BaudRate;

       PortSettings.Parity        = NOPARITY;
       PortSettings.StopBits      = ONESTOPBIT;
       PortSettings.fBinary       = 1;

       PortSettings.fOutX           = 0; //0
       PortSettings.fInX            = 0; //0
       PortSettings.fErrorChar      = 0; //1
       PortSettings.fNull           = 0; //1
       PortSettings.XonChar   = XonChar;
       PortSettings.XoffChar  = XoffChar;
       PortSettings.XonLim    = XonLim;
       PortSettings.XoffLim   = XoffLim;
       PortSettings.fDsrSensitivity = 0;
       PortSettings.fOutxCtsFlow    = 0;
       PortSettings.fOutxDsrFlow    = 0;
       PortSettings.fRtsControl     = RtsControl;
       PortSettings.fDtrControl     = DtrControl;
       //PortSettings.fRtsControl     = 0;
       //PortSettings.fDtrControl     = 0;

     // ----- Задаю БОД рейт ----
       if ( SetCommState( hComm, &PortSettings) == false )
       {
            CloseHandle(hComm);
            hComm = INVALID_HANDLE_VALUE;
            sprintf(aNewPortName, "Unable to open port name '%s'", fPortName);
            MessageBox(NULL, aNewPortName, "Error", MB_OK);
            return false; // ---- Не смогли установить параметры ком порта
       }

    // -------
       if ( GetCommTimeouts( hComm, &timeouts ) == false )
       {
            CloseHandle(hComm);
            hComm = INVALID_HANDLE_VALUE;

            sprintf(aNewPortName, "Unable to get time parameters of port name '%s'", fPortName);
            MessageBox(NULL, aNewPortName, "Error", MB_OK);

            return false; // Can't get COM-port timeout settings
       }

   // ----------- Тайм ауты ------
        if ( isAsyncWork == true  )
        {
            timeouts.ReadIntervalTimeout         = MAXDWORD; //
            timeouts.ReadTotalTimeoutMultiplier  = 0;
            timeouts.ReadTotalTimeoutConstant    = 0;
            timeouts.WriteTotalTimeoutMultiplier = 0;
            timeouts.WriteTotalTimeoutConstant   = 0;
        }
        else
        {
            timeouts.ReadTotalTimeoutConstant  = ReadTotalTimeoutConstant;
            timeouts.WriteTotalTimeoutConstant = WriteTotalTimeoutConstant;
            timeouts.ReadIntervalTimeout       = ReadIntervalTimeout;
        }
        if ( SetCommTimeouts( hComm, &timeouts ) == false )
        {
            CloseHandle(hComm);
            hComm = INVALID_HANDLE_VALUE;
            sprintf(aNewPortName, "Unable to set time parameters of port name '%s'", fPortName);
            MessageBox(NULL, aNewPortName, "Error", MB_OK);

            return false; // Can't set COM-port timeout settings (SetCommTimeouts)
        }

   // --------------- sbrasyvaju ves` musor s COM porta ---------
       //ClearComPortError(true);

   // ----
       isOpen = true;

       return true;    
}

//===========================================================================
void CSerialPort::CloseComPort()
{
      if ( hComm != INVALID_HANDLE_VALUE  && hComm != NULL )
      {
          //SetCommMask (hComm, 0);
          SetCommState(hComm, &BasePortSettings);
          PurgeComm   (hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
          CloseHandle (hComm);

          hComm = INVALID_HANDLE_VALUE;
      }
      isOpen = false;
}

void CSerialPort::TimeOuts_Save()
{
    if ( isOpen == false ) return;

    memcpy(&Saved_timeouts, &timeouts, sizeof(timeouts));
}

void CSerialPort::TimeOuts_Restore()
{
    if ( isOpen == false ) return;

    char aNewPortName[255];

    memcpy(&timeouts, &Saved_timeouts, sizeof(timeouts));

    if ( SetCommTimeouts( hComm, &timeouts ) == false )
    {
        CloseHandle(hComm);
        hComm = INVALID_HANDLE_VALUE;
        sprintf(aNewPortName, "Unable to set time parameters of port name '%s'", fPortName);
        MessageBox(NULL, aNewPortName, "Error", MB_OK);
    }
}

void CSerialPort::TimeOuts_Set(int value)
{
    if ( isOpen == false ) return;

    char aNewPortName[255];

    timeouts.ReadTotalTimeoutConstant  = value;
    timeouts.WriteTotalTimeoutConstant = value;

    if ( SetCommTimeouts( hComm, &timeouts ) == false )
    {
        CloseHandle(hComm);
        hComm = INVALID_HANDLE_VALUE;
        sprintf(aNewPortName, "Unable to set time parameters of port name '%s'", fPortName);
        MessageBox(NULL, aNewPortName, "Error", MB_OK);
    }
}

//===========================================================================
void CSerialPort::ClearComPortError(bool isFullClear)
{
  // Setup a mask that allows us to tell if the port is done transmitting
  // the current buffer of data
  // --- Remove any 'old' data in buffer ---
    if ( isFullClear == true )
    {
        EscapeCommFunction( hComm, CLRRTS );
        EscapeCommFunction( hComm, SETDTR );
        
        //EV_BREAK  	Состояние разрыва приемной линии
        //EV_CTS 	Изменение состояния линии CTS
        //EV_DSR 	Изменение состояния линии DSR
        //EV_ERR 	Ошибка обрамления, перебега или четности
        //EV_RING 	Входящий звонок на модем (сигнал на линии RI порта)
        //EV_RLSD 	Изменение состояния линии RLSD (DCD)
        //EV_RXCHAR 	Символ принят и помещен в приемный буфер
        //EV_RXFLAG 	Принят символ заданый полем EvtChar структуры DCB использованой для настройки режимов работы порта
        //EV_TXEMPTY 	Из буфера передачи передан последний символ
        SetCommMask ( hComm, 0 );
        PurgeComm(hComm, PURGE_TXCLEAR | PURGE_RXCLEAR);
    }
  // ---------
    DWORD   dwErrors;
    COMSTAT lCOMSTAT;
    ClearCommError( hComm, &dwErrors, &lCOMSTAT );
}
/*
//===========================================================================
bool CSerialPort::ReadBuffer(char *pcRead, int cByte)
{
    if ( hComm == INVALID_HANDLE_VALUE || hComm == NULL ) return false;
    if ( isOpen == false ) return false;
   // -------
    DWORD NumberOfBytesRead = -1;

    return ReadFile(hComm, pcRead, cByte, &NumberOfBytesRead, NULL);
}
*/
//===========================================================================
int CSerialPort::ReadBuffer(char *pcRead, DWORD NumberBytesOfRead)
{
    if ( hComm == INVALID_HANDLE_VALUE || hComm == NULL ) return false;
    if ( isOpen == false ) return false;

   // -------
    //DWORD NumberOfBytesToRead =  100;
    DWORD NumberOfBytesRead   = -1;
    DWORD BuffPosition        =  0;

//    while ( NumberOfBytesRead != 0 )
//    {
//        if ( ReadFile(hComm, &pcRead[BuffPosition], NumberOfBytesToRead, &NumberOfBytesRead, NULL) == false )
//        {
//            ClearComPortError(true);
//            return false;
//        }
//        BuffPosition += NumberOfBytesRead;
//    }

    if ( ReadFile(hComm, &pcRead[BuffPosition], NumberBytesOfRead, &NumberOfBytesRead, NULL) == false )
    {
        ClearComPortError(true);
        return false;
    }
    return NumberOfBytesRead;
}

//===========================================================================
//int CSerialPort::WriteBuffer(char *pcWrite, DWORD NumberOfBytesToWrite )
int CSerialPort::WriteBuffer(char *pcWrite)
{
   if ( hComm == INVALID_HANDLE_VALUE || hComm == NULL ) return false;
   if ( isOpen == false ) return false;
   // -------

   DWORD NumberOfBytesWritten;
   DWORD NumberOfBytesToWrite = strlen(pcWrite);
   if ( WriteFile(hComm, pcWrite, NumberOfBytesToWrite, &NumberOfBytesWritten, NULL) == false )
   {
       ClearComPortError(true);
       return false;
   }

   return NumberOfBytesWritten;
}

//===========================================================================
int CSerialPort::Read( char *pcRead, DWORD NumberOfBytesToRead )
{
    if ( hComm == INVALID_HANDLE_VALUE || hComm == NULL ) return false;
    if ( isOpen == false ) return false;

   // -------
    DWORD NumberOfBytesRead = -1;
    DWORD BuffPosition = 0;

   // -------
    if ( ReadFile(hComm, &pcRead[BuffPosition], NumberOfBytesToRead, &NumberOfBytesRead, NULL) == false )
    {
        ClearComPortError(true);
        return -1;
    }

    return NumberOfBytesToRead;
}

/************************************************
 *	MDBS CRC
 *		MDBS CRC
 *			Parameters:		None
 *			Return Value:	None
 ************************************************/
unsigned short int MDBS_CRC(unsigned char* pBuf, unsigned short int Len)
{
    unsigned short int i, j, Crc = 0xFFFF;

	for ( j = 0; j < Len; j++)
	{
		Crc ^= (unsigned short int)pBuf[j];

		for (i = 0; i < 8; i++)
			Crc = (Crc & 1) ? (Crc >>= 1, Crc ^= 0xA001) : (Crc >>= 1);
	};

	return (Crc);
};
//===========================================================================
int CSerialPort::GetCountInQueueBytes()
{
    if ( hComm == INVALID_HANDLE_VALUE || hComm == NULL ) return false;
    if ( isOpen == false ) return false;

    DWORD   Errors;
    ClearCommError(hComm, &Errors, &ComStat);

    return ComStat.cbInQue;
}

//===========================================================================
bool isCRC_SwitchOk( unsigned char *inBuff, unsigned short int inBuffLength )
{
    if ( inBuffLength < 3 || inBuffLength > 1000 ) return false;

    unsigned short int cur_crc = MDBS_CRC( inBuff, inBuffLength - 2 );

    unsigned short int base_cs;
    memcpy( &base_cs, &inBuff[ inBuffLength - 2 ], 2 );

    return base_cs == cur_crc;
}

//===========================================================================
int CSerialPort::RSSwitch_ReadWrite( char* WriteCommand, int LengthWC, char *ReadBuffer )
{
    DWORD   dw_local;
    DWORD   dw_ByteReaded;
    DWORD   dw_NeadRead;
    DWORD   dw_Errors;
    DWORD   dw_CommEvent;
    COMSTAT lCOMSTAT;

    lCOMSTAT.cbOutQue = 0;
    WriteFile(hComm, WriteCommand, LengthWC, &dw_local, NULL);

    dw_ByteReaded = 0;
    dw_local      = -1;
    bool isFirstInput = true;
    
    while ( dw_local != 0 )
    {
        ClearCommError( hComm, &dw_Errors, &lCOMSTAT );
        dw_NeadRead = ( lCOMSTAT.cbInQue > 1 ) ? lCOMSTAT.cbInQue : 1;
        if ( isFirstInput == false && dw_NeadRead == 0 ) return dw_ByteReaded;

        ReadFile(hComm, &ReadBuffer[dw_ByteReaded], dw_NeadRead, &dw_local, NULL);

        dw_ByteReaded += dw_local;

        isFirstInput = false;
    }
    
    return dw_ByteReaded;
}

//===========================================================================
void CSerialPort::WriteCommAsync(const unsigned char *WriteBuffer, int BufferLength)
{
    if ( isOpen == false ) return;

    DWORD   dw_local;

    WriteFile(hComm, WriteBuffer, BufferLength, &dw_local, &ovWait);

    if ( GetLastError() == ERROR_IO_PENDING )
    {
        if ( WaitForSingleObject(ovWait.hEvent, INFINITE) == WAIT_OBJECT_0 )
        {
            GetOverlappedResult( hComm, &ovWait, &dw_local, false);
            //ResetEvent(ovWait.hEvent);

        }
    }
}

//===========================================================================
bool CSerialPort::ReadCommAsync(unsigned short int CountBt, unsigned short int TimeOutMsec)
{
    DWORD dw_CommMask;
    DWORD dw_Errors;
    DWORD dw_Local;
    DWORD dw_Readed;
    DWORD dw_NeadRead;

    async_com_buffer_len = 0;
    while ( async_com_buffer_len < CountBt )
    {
        WaitCommEvent( hComm, &dw_CommMask, &ovWait );
        // ------
        //if ( GetLastError() == ERROR_IO_PENDING )
        {
            if ( WaitForSingleObject( ovWait.hEvent, TimeOutMsec ) == WAIT_OBJECT_0 )
            {
                GetOverlappedResult( hComm, &ovWait, &dw_Local, true);
                ClearCommError( hComm, &dw_Errors, &ComStat);
                if ( ComStat.cbInQue == 0 ) continue;

                dw_NeadRead = ( (DWORD)ComStat.cbInQue > (DWORD)CountBt ) ? CountBt : ComStat.cbInQue;
                ReadFile(hComm, async_local_com_buffer,  dw_NeadRead, &dw_Readed, &ovWait);
                if ( GetLastError() != 0 && GetLastError() != ERROR_IO_PENDING) continue;

                memcpy( &async_com_buffer[async_com_buffer_len], async_local_com_buffer, dw_Readed);
                async_com_buffer_len += dw_Readed;

                if ( async_com_buffer_len == CountBt ) return true;
            }
            else
            {
                break;
            }
        }
    }
    return ( async_com_buffer_len == CountBt);
}


