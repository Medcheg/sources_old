//---------------------------------------------------------------------------
#ifndef pmSerialPortH
#define pmSerialPortH
//---------------------------------------------------------------------------
typedef void (*TThreadCallBackAction)(void*, char*, int);
class CSerialPort
{
private:
    void Init();
protected:
	HANDLE  hComm;
    HANDLE  hThread_write;
    HANDLE  hThread_read;
	DCB 	dcb;

    OVERLAPPED  isThreadTerminated;

    bool   isReadThreadStoped;
    bool   isAsyncWork;

    unsigned int CoutReadBytes_FromOne_Request;

    unsigned char  *pchWriteBuffer;
    DWORD           WriteBufferSize;


  	static DWORD WINAPI WRITE_ThreadFunc(void* lpData);
  	static DWORD WINAPI READ_ThreadFunc(void* lpData);

	TThreadCallBackAction  CallBackAction;
    void                  *pUserData;
public:
	bool isOpen;
	int  cbOutQue;

    CSerialPort();
   ~CSerialPort();

    int  Open ( void *apUserData, unsigned int afCoutReadBytes_FromOne_Request, TThreadCallBackAction cba, char *pchPortName, char *pchOpenParameters );
    void Close();

    void SendFile       ( unsigned char *pchBuffer, DWORD pBufferSize );
    void SendFile_async ( unsigned char *pchBuffer, DWORD pBufferSize );
};
#endif
