//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmSerialPort.h"

#define MAX_WRITE_BUFFER        1024
#define MAX_READ_BUFFER         2048

CSerialPort::CSerialPort()
{
	ReaderBuffer     = (char*) malloc ( 32768 );
    ReaderBufferSize = 0;

	Init();
}

CSerialPort::~CSerialPort()
{
	if ( ReaderBuffer != NULL ) free (ReaderBuffer); ReaderBuffer = NULL;
}

void CSerialPort::Init()
{
	isOpen              = false;
    isReadThreadStoped  = false;
    isEndofTransferFile = false;
    BytesTrasfered       = 0;
    pchWriteBuffer      = NULL;
    WriteBufferSize     = 0;
    SendProgress	    = 0;

    InitReadBuffer();
}

void CSerialPort::InitReadBuffer()
{
	memset(ReaderBuffer, 0, 32768);
	ReaderBufferSize = 0;
}

void CSerialPort::Open( char *pchPortName, char *pchOpenParameters )
{
    COMMTIMEOUTS to;
    Init();

    hComm = CreateFile( pchPortName,
                        GENERIC_READ | GENERIC_WRITE,
                        0,
                    	0,
                    	OPEN_EXISTING,
                    	FILE_FLAG_OVERLAPPED,
                    	0);
	if ( hComm == INVALID_HANDLE_VALUE ) return;

	// ---------
    memset(&dcb, 0, sizeof(dcb));
    dcb.DCBlength = sizeof(dcb);
	if ( BuildCommDCB("115200,n,8,1", &dcb) == false) return;
    //dcb.fDtrControl = 1;
    //dcb.fRtsControl = 1;

    SetCommState(hComm, &dcb );

    SetupComm(hComm, MAX_READ_BUFFER, MAX_WRITE_BUFFER);

/*
    to.ReadIntervalTimeout = 1;
    to.ReadTotalTimeoutMultiplier = 0;
    to.ReadTotalTimeoutConstant = 0;
    to.WriteTotalTimeoutMultiplier = 0;
    to.WriteTotalTimeoutConstant =0;

    SetCommTimeouts(hComm, &to);
*/
  //---------
    DWORD dwThreadId = 0;
  	isReadThreadStoped = false;
    hThread_read = CreateThread( NULL,
                                 0,
                                (LPTHREAD_START_ROUTINE)READ_ThreadFunc,
                                (void *)this,
                                 CREATE_SUSPENDED,
                                 &dwThreadId);
   // -----
    //SetThreadPriority(hThread_read, THREAD_PRIORITY_TIME_CRITICAL);
	//SetThreadPriority(hThread_read, THREAD_PRIORITY_BELOW_NORMAL);
	SetThreadPriority(hThread_read, THREAD_PRIORITY_LOWEST);

   // -----
    ResumeThread( hThread_read );

	isOpen = true;
}

void CSerialPort::Close()
{
  	isReadThreadStoped = true;  Sleep(100);

    if ( hComm        != INVALID_HANDLE_VALUE ) CloseHandle( hComm        );
    if ( hThread_read != INVALID_HANDLE_VALUE ) CloseHandle( hThread_read );

	hThread_read = INVALID_HANDLE_VALUE;
    hComm        = INVALID_HANDLE_VALUE;

	isOpen = false;
}

void CSerialPort::SendFile( char *pchBuffer, DWORD pBufferSize )
{
    if ( isOpen      == false ) return;
    if ( pchBuffer   == NULL ) return;
    if ( pBufferSize <= 0 ) return;

    SendProgress    = 0;
    pchWriteBuffer  = pchBuffer;
    WriteBufferSize = pBufferSize;


    isEndofTransferFile = false;
    BytesTrasfered       = 0;
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
	CSerialPort *sp = (CSerialPort*)lpData;
	OVERLAPPED osWrite = {0};
	DWORD dwWritten;
	DWORD dwRes;
    DWORD  dwBytesSend     = 0;
    //DWORD  dwBytesSend_inc = sp->WriteBufferSize / 1000;
    DWORD  dwBytesSend_inc = MAX_WRITE_BUFFER / 2;
    DWORD  dwBytesSend_inc_base = dwBytesSend_inc;
    DWORD  dwErrors;
    COMSTAT lCOMSTAT;
    bool isDoneSend = false;
    LARGE_INTEGER li_f, li_q1, li_q2;

    QueryPerformanceFrequency(&li_f);
    QueryPerformanceCounter(&li_q1);


    // -------
	osWrite.hEvent = CreateEvent(NULL, true, false, NULL);
	if (osWrite.hEvent == NULL) return FALSE;



            if ( WriteFile(sp->hComm, sp->pchWriteBuffer, sp->WriteBufferSize, &dwWritten, &osWrite) == 0 )
            {
                if ( GetLastError() == ERROR_IO_PENDING )
                {
                    if ( WaitForSingleObject(osWrite.hEvent, INFINITE) == WAIT_OBJECT_0 )
                    {
                    	if ( GetOverlappedResult(sp->hComm, &osWrite, &dwWritten, false) != 0 )
                        {
                            if ( dwWritten != sp->WriteBufferSize )
                                Sleep(1);

                            // Write operation completed successfully.
                            ++sp->SendProgress;
                            dwBytesSend += dwWritten;
                        }
                        else
                        	Sleep(10);
                    }
                    else
                    	Sleep(1);
                }
                else
                  	Sleep(10);
            }
            else
            	Sleep(10);


/*    while ( isDoneSend == false )
    {
            if ( dwBytesSend > sp->WriteBufferSize )
            {
                dwBytesSend_inc -=(dwBytesSend - sp->WriteBufferSize );
            	dwBytesSend     -= dwBytesSend_inc_base;
                isDoneSend       = true;
            }

            if ( WriteFile(sp->hComm, &sp->pchWriteBuffer[dwBytesSend], dwBytesSend_inc, &dwWritten, &osWrite) == 0 )
            {
                if ( GetLastError() == ERROR_IO_PENDING )
                {
                    if ( WaitForSingleObject(osWrite.hEvent, INFINITE) == WAIT_OBJECT_0 )
                    {
                    	//while ( GetOverlappedResult(sp->hComm, &osWrite, &dwWritten, false) == 0 ) {}
                    	if ( GetOverlappedResult(sp->hComm, &osWrite, &dwWritten, false) != 0 )
                        {
                            if ( dwWritten != dwBytesSend_inc )
                                Sleep(1);
                            // Write operation completed successfully.
                            ++sp->SendProgress;
                            dwBytesSend += dwWritten;
                        }
                        else
                        	Sleep(10);
                    }
                    else
                    	Sleep(1);
                }
                else
                  	Sleep(10);
            }
            else
            	Sleep(10);
    }
*/

	sp->BytesTrasfered = dwBytesSend;
	sp->isEndofTransferFile = true;

    QueryPerformanceCounter(&li_q2);

        // ---- Статус бар инфа -----
    sp->TransferTime = ((double)li_q2.QuadPart - (double)li_q1.QuadPart) / (double)li_f.QuadPart;

 	CloseHandle(osWrite.hEvent);
}

DWORD WINAPI CSerialPort::READ_ThreadFunc(void* lpData)
{
	CSerialPort *sp = (CSerialPort*)lpData;
    OVERLAPPED osReader = {0};
    BOOL fWaitingOnRead = false;
    DWORD dwRead;
    DWORD dwRes;
   DWORD         dwErrors;
   COMSTAT       lCOMSTAT;
    char  *localbuff = (char*) malloc ( 10000 );

    // Create the overlapped event. Must be closed before exiting
    // to avoid a handle leak.
    osReader.hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
    if (osReader.hEvent == NULL) return -1;

       // Error creating overlapped event; abort.
    while ( sp->isReadThreadStoped == false )
    {
   		 ClearCommError( sp->hComm, &dwErrors, &lCOMSTAT );
         sp->cbOutQue = lCOMSTAT.cbOutQue;


        if (!fWaitingOnRead) {
           // Issue read operation.
           if ( ReadFile(sp->hComm, localbuff, 1, &dwRead, &osReader) == 0 )
           {
              if (GetLastError() != ERROR_IO_PENDING)     // read not delayed?
              {
                  // Error in communications; report it.
              }
              else
              {
                    dwRes = WaitForSingleObject(osReader.hEvent, 40);
                    // GetOverlappedResult(sp->hComm, &osReader, &dwRead, FALSE);
                    // if ( dwRead > 0 ) Sleep(0);
                    switch(dwRes)
                    {
                      // Read completed.
                      case WAIT_OBJECT_0:
                          if ( GetOverlappedResult(sp->hComm, &osReader, &dwRead, FALSE) == 0)
                          {
                             // Error in communications; report it.
                          }
                          else
                          {
                             // Read completed successfully.
                             //HandleASuccessfulRead(lpBuf, dwRead);
                             memcpy(&sp->ReaderBuffer[sp->ReaderBufferSize], localbuff, dwRead );
                             sp->ReaderBufferSize += dwRead;
                             if ( sp->ReaderBufferSize >= 15 ) sp->ReaderBufferSize = 0;
                          }

                          //  Reset flag so that another opertion can be issued.
                          fWaitingOnRead = FALSE;
                          break;

                      case WAIT_TIMEOUT:
                          break;

                      //default:
                          // Error in the WaitForSingleObject; abort.
                          // This indicates a problem with the OVERLAPPED structure's
                          // event handle.
                      //    break;
                    }

              }
           }
           else {
              // read completed immediately
              // ShowErrorMessage("FileWrite");
              //HandleASuccessfulRead(lpBuf, dwRead);
            }
        }
    }

    free( localbuff );
 	CloseHandle(osReader.hEvent);
}

