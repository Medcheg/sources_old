//---------------------------------------------------------------------------
#ifndef pmSerialPortH
#define pmSerialPortH
//---------------------------------------------------------------------------
class CSerialPort
{
private:

    void Init();
protected:
	HANDLE  hComm;
    HANDLE  hThread_write;
    HANDLE  hThread_read;
	DCB 	dcb;

    bool   isReadThreadStoped;

    char  *pchWriteBuffer;
    DWORD  WriteBufferSize;

  	static DWORD WINAPI WRITE_ThreadFunc(void* lpData);
  	static DWORD WINAPI READ_ThreadFunc(void* lpData);
public:
	bool isOpen;
    bool isEndofTransferFile;

    int    ReaderBufferSize;
    char  *ReaderBuffer;
    int    SendProgress;

    int        BytesTrasfered;
    double     TransferTime; /// second
    int        cbOutQue;

    CSerialPort();
   ~CSerialPort();

    void Close();
    void InitReadBuffer();
    void Open ( char *pchPortName, char *pchOpenParameters );
    void SendFile( char *pchBuffer, DWORD pBufferSize );
};
#endif
