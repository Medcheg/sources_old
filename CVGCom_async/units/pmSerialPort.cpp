//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmSerialPort.h"

//#define MAX_WRITE_BUFFER        512
//#define MAX_READ_BUFFER         512

#define MAX_WRITE_BUFFER        1024
#define MAX_READ_BUFFER         1024

//#define MAX_WRITE_BUFFER        4096
//#define MAX_READ_BUFFER         4096

CSerialPort::CSerialPort()
{
	hComm         = NULL;
    hThread_write = NULL;
    hThread_read  = NULL;
    memset( &dcb, 0, sizeof(DCB));

    isThreadTerminated.Internal     = 0;
    isThreadTerminated.InternalHigh = 0;
    isThreadTerminated.Offset       = 0;
    isThreadTerminated.OffsetHigh   = 0;
    isThreadTerminated.hEvent       = CreateEvent(NULL, true, false, NULL);

    isReadThreadStoped = false;
    isAsyncWork        = false;
    pchWriteBuffer     = NULL;
    WriteBufferSize    = 0;

	CallBackAction = NULL;

	isOpen   = false;
	cbOutQue = 0;

	Init();
}

CSerialPort::~CSerialPort()
{
 	CloseHandle(isThreadTerminated.hEvent);
}

void CSerialPort::Init()
{
	isOpen              = false;
    isReadThreadStoped  = false;
    pchWriteBuffer      = NULL;
    WriteBufferSize     = 0;
}

int CSerialPort::Open( void* apUserData, unsigned int afCoutReadBytes_FromOne_Request, TThreadCallBackAction cba, char *pchPortName, char *pchOpenParameters )
{
    COMMTIMEOUTS to;
    Init();

    CallBackAction = cba;
    pUserData      = apUserData;

    CoutReadBytes_FromOne_Request = afCoutReadBytes_FromOne_Request;

    char aNewPortName[255];
    sprintf(aNewPortName, "\\\\.\\%s", pchPortName);
    hComm = CreateFile( aNewPortName,
                        GENERIC_READ | GENERIC_WRITE,
                        0,
                    	0,
                    	OPEN_EXISTING,
                    	( isAsyncWork == true ) ? FILE_FLAG_OVERLAPPED : FILE_ATTRIBUTE_NORMAL,// | FILE_FLAG_NO_BUFFERING, //,//
                    	0);
	if ( hComm == INVALID_HANDLE_VALUE ) return -1;

	// ---------
    memset(&dcb, 0, sizeof(dcb));
    dcb.DCBlength = sizeof(dcb);
	if ( BuildCommDCB( pchOpenParameters, &dcb) == false) return -1;

    SetCommState(hComm, &dcb );

    COMMTIMEOUTS m_CommTimeouts;
    GetCommTimeouts(hComm, &m_CommTimeouts);

    m_CommTimeouts.ReadIntervalTimeout         = ( isAsyncWork == true ) ? MAXLONG : 0;
    m_CommTimeouts.ReadTotalTimeoutConstant    = ( isAsyncWork == true ) ? 0       : 100;
    m_CommTimeouts.ReadTotalTimeoutMultiplier  = ( isAsyncWork == true ) ? 0       : 0;
    m_CommTimeouts.WriteTotalTimeoutConstant   = ( isAsyncWork == true ) ? 0       : 100;
    m_CommTimeouts.WriteTotalTimeoutMultiplier = ( isAsyncWork == true ) ? 0       : 0;

    SetCommTimeouts(hComm, &m_CommTimeouts);
    SetupComm(hComm, MAX_READ_BUFFER, MAX_WRITE_BUFFER);
    PurgeComm( hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );

    //---------
    if ( CallBackAction != NULL )
    {
        DWORD dwThreadId = 0;
        isReadThreadStoped = false;
        hThread_read = CreateThread( NULL,
                                     0,
                                    (LPTHREAD_START_ROUTINE)READ_ThreadFunc,
                                    (void *)this,
                                     CREATE_SUSPENDED,
                                     &dwThreadId);
        ResumeThread( hThread_read );
    }
   // -----
    //SetThreadPriority(hThread_read, THREAD_PRIORITY_TIME_CRITICAL);
	//SetThreadPriority(hThread_read, THREAD_PRIORITY_BELOW_NORMAL);
	//SetThreadPriority(hThread_read, THREAD_PRIORITY_LOWEST);
   // -----

	isOpen = true;

    return 0;
}

void CSerialPort::Close()
{
  	isReadThreadStoped = true;

    if ( WaitForSingleObject(isThreadTerminated.hEvent, 100) == WAIT_OBJECT_0 )
    ResetEvent(isThreadTerminated.hEvent);

    if ( hComm        != INVALID_HANDLE_VALUE ) CloseHandle( hComm        );
    if ( hThread_read != INVALID_HANDLE_VALUE ) CloseHandle( hThread_read );

	hThread_read = INVALID_HANDLE_VALUE;
    hComm        = INVALID_HANDLE_VALUE;

	isOpen = false;
}
/*
void CSerialPort::Read( unsigned char *pchBuffer, DWORD pBufferSize )
{
    if ( isOpen      == false ) return;
    if ( pchBuffer   == NULL ) return;
    if ( pBufferSize <= 0 ) return;
}

void CSerialPort::Send( unsigned char *pchBuffer, DWORD pBufferSize )
{
    if ( isOpen      == false ) return;
    if ( pchBuffer   == NULL ) return;
    if ( pBufferSize <= 0 ) return;

    WriteFile(sp->hComm, sp->pchWriteBuffer, sp->WriteBufferSize, &dwWritten, &osWrite) == 0 )
}
*/
void CSerialPort::SendFile( unsigned char *pchBuffer, DWORD pBufferSize )
{
    if ( isOpen      == false ) return;
    if ( pchBuffer   == NULL ) return;
    if ( pBufferSize <= 0 ) return;

    pchWriteBuffer  = pchBuffer;
    WriteBufferSize = pBufferSize;
	DWORD dwWritten = 0;

    WriteFile(hComm, pchWriteBuffer, WriteBufferSize, &dwWritten, NULL);
}

void CSerialPort::SendFile_async( unsigned char *pchBuffer, DWORD pBufferSize )
{
    if ( isOpen      == false ) return;
    if ( pchBuffer   == NULL ) return;
    if ( pBufferSize <= 0 ) return;

    pchWriteBuffer  = pchBuffer;
    WriteBufferSize = pBufferSize;

	// -----
    DWORD dwThreadId = 0;
    hThread_write = CreateThread( NULL,
                                  0,
                                 (LPTHREAD_START_ROUTINE)WRITE_ThreadFunc,
                                 (void *)this,
                                  CREATE_SUSPENDED,
                                 &dwThreadId);
   // -----
    //SetThreadPriority(hThread_write, THREAD_PRIORITY_TIME_CRITICAL);
	//SetThreadPriority(hThread, THREAD_PRIORITY_LOWEST);

   // -----
    ResumeThread( hThread_write );
}

DWORD WINAPI CSerialPort::WRITE_ThreadFunc(void* lpData)
{
	CSerialPort    *sp = (CSerialPort*)lpData;
	OVERLAPPED osWrite = {0};
	DWORD dwWritten;

    // -------
	osWrite.hEvent = CreateEvent(NULL, true, false, NULL);
	if (osWrite.hEvent == NULL) return FALSE;

    if ( WriteFile(sp->hComm, sp->pchWriteBuffer, sp->WriteBufferSize, &dwWritten, &osWrite) == 0 )
        if ( GetLastError() == ERROR_IO_PENDING )
            if ( WaitForSingleObject(osWrite.hEvent, INFINITE) == WAIT_OBJECT_0 )
                if ( GetOverlappedResult(sp->hComm, &osWrite, &dwWritten, false) != 0 )
                    if ( dwWritten != sp->WriteBufferSize )
                               Sleep(1);

 	CloseHandle(osWrite.hEvent);

	return 0;
}

DWORD WINAPI CSerialPort::READ_ThreadFunc(void* lpData)
{
	CSerialPort   *sp = (CSerialPort*)lpData;
    TSubDevice    *sd = (TSubDevice *)sp->pUserData;

    unsigned char *localbuff = (unsigned char *) calloc (8192, 1);
    OVERLAPPED     ovWait;
    COMSTAT        lCOMSTAT  = {0};
    BOOL           res;
    int            WhileCounter = 0;;

    DWORD dwRead;
    DWORD dwErrors;

    ovWait.Internal     = 0;
    ovWait.InternalHigh = 0;
    ovWait.Offset       = 0;
    ovWait.OffsetHigh   = 0;
    ovWait.hEvent       = CreateEvent(NULL, false, false, NULL);
    if (ovWait.hEvent == NULL)
    {
        #ifdef DEBUG
            __asm {int 3};
        #endif
        return -1;   // Error creating overlapped event; abort.
    }

    while ( sp->isReadThreadStoped == false )
    {
        // ---- Для контроля количества отправленных байт ------
   		//ClearCommError( sp->hComm, &dwErrors, &lCOMSTAT );
        //sp->cbOutQue = lCOMSTAT.cbOutQue;

        if ( sp->isAsyncWork == true )
        {
            if ( ReadFile(sp->hComm, localbuff, sp->CoutReadBytes_FromOne_Request, &dwRead, &ovWait) == 0 )
            {
                if ( GetLastError() == ERROR_IO_PENDING )     // read not delayed?
                {
                    if ( WaitForSingleObject(ovWait.hEvent, 10) == WAIT_OBJECT_0 && sp->isReadThreadStoped == false )
                    {
                        if ( GetOverlappedResult(sp->hComm, &ovWait, &dwRead, false) != 0 )
                        {
                            sp->CallBackAction ( sp->pUserData, localbuff, dwRead );
                        }
                        else
                        {
                            __asm {nop};
                        }
                    }
                    else
                    {
                        Sleep(1);//__asm {nop};
                    }
                }
                else
                {
                    __asm {nop};
                }
            }
            else
            {
                __asm {nop};
            }
        }
        else
        {
            dwErrors = 0;
            if ( ClearCommError( sp->hComm, &dwErrors, &lCOMSTAT ) == 0 )
            {
                PurgeComm( sp->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
                // sp->CountNotReadData ++;
                continue;
            }
           if ( dwErrors != 0 )
           {
                switch ( dwErrors )
                {
                    case CE_BREAK    : sd->isBreakConnection = 1; break; //The hardware detected a break condition.
                    case CE_FRAME    : sd->isFrameError      = 1; break; //The hardware detected a framing error.
                    case CE_IOE      : __asm{nop}; break; //An I/O error occurred during communications with the device.
                    case CE_MODE     : __asm{nop}; break; //The requested mode is not supported, or the hFile parameter is invalid. If this value is specified, it is the only valid error.
                    case CE_OVERRUN  : __asm{nop}; break; //A character-buffer overrun has occurred. The next character is lost.
                    case CE_RXOVER   : __asm{nop}; break; //An input buffer overflow has occurred. There is either no room in the input buffer, or a character was received after the end-of-file (EOF) character.
                    case CE_RXPARITY : __asm{nop}; break; //The hardware detected a parity error.
                    case CE_TXFULL   : __asm{nop}; break; //
                    default: sd->isUnknownError = 1; break;
                 }

                //PurgeComm( sp->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
                // sp->CountNotReadData ++;
                //continue;
            }
            if ( lCOMSTAT.cbInQue < sp->CoutReadBytes_FromOne_Request ) Sleep(40);
            ClearCommError( sp->hComm, &dwErrors, &lCOMSTAT );

            // ---- Подождем пока заливаем инфу  -----
            dwRead       = 0;
            //WhileCounter = 0;
            //while ( sd->isWrittingToSP  == true || WhileCounter++ < 3000 ) { Sleep(1); }
            while ( sd->isWrittingToSP  == true ) {}

            sd->isReadingFromSP = true;
            //res = ReadFile( sp->hComm, localbuff, lCOMSTAT.cbInQue, &dwRead, 0 );
            res = ReadFile( sp->hComm, localbuff, sp->CoutReadBytes_FromOne_Request, &dwRead, 0 );
            sd->isReadingFromSP = false;

            if ( res == FALSE )
            {
                PurgeComm( sp->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
                continue;
            }

            // ---- Если прочитал 0 байт, увеличиваю количество ошибок ----
            if ( dwRead == 0 /*|| dRead >= WORK_BUFFER_SIZE*/ )
            {
                //PurgeComm( sp->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
                //sp->CountNotReadData ++;
                continue;
            }

            // ----- Если прочитали пакет -- сбрасываем счетчик не принятых "НОЛЬ" байтов ------
            //sp->CountNotReadData = 0;

            if ( sp->CallBackAction != NULL )
                sp->CallBackAction ( sp->pUserData, localbuff, dwRead );
        }
    }
    free( localbuff );
 	CloseHandle(ovWait.hEvent);

    // --- Подымаю Ивент, СИигнализируючий о том , что вышли из треда, "без базара"
    SetEvent( sp->isThreadTerminated.hEvent );

    return 0;
}


