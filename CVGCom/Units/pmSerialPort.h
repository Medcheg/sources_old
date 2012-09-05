//===========================================================================
#ifndef pmSerialPortH
#define pmSerialPortH

//===========================================================================
#include "windows.h"

//===========================================================================
class CSerialPort
{
private:
    DCB        BasePortSettings; // исходные настройки порта
    DCB        PortSettings;     // наши настройки порта
    COMSTAT    ComStat;
    OVERLAPPED ovWait;

    COMMTIMEOUTS timeouts;
    COMMTIMEOUTS Saved_timeouts;

    char  *fPortName;      // ---- Имя ком порта --------
    char* __fastcall Get_ComportName();
    void  __fastcall Set_ComportName(char *aComName);

    LARGE_INTEGER li_f, li_q1, li_q2;
    double TimeOutCounter;

    unsigned char     *async_local_com_buffer;
public:
    int    BaudRate;
    int    ByteSize;
    int    XonChar;
    int    XoffChar;
    int    XonLim;
    int    XoffLim;
    int    RtsControl;
    int    DtrControl;

    unsigned long ReadTotalTimeoutConstant;
    unsigned long WriteTotalTimeoutConstant;
    unsigned long ReadIntervalTimeout;

    bool   isOpen;
    bool   isAsyncWork;

    HANDLE hComm;

    unsigned char     *async_com_buffer;
    unsigned short int async_com_buffer_len;

    CSerialPort();
   ~CSerialPort();

    bool  OpenComPort ();
    void  CloseComPort();
	void  ClearComPortError(bool isFullClear);

    int  ReadBuffer (char *pcRead, DWORD NumberBytesOfRead);
    //int  WriteBuffer(char *pcWrite, DWORD NumberOfBytesToWrite );
    int  WriteBuffer(char *pcWrite);

    int  Read ( char *pcRead, DWORD NumberOfBytesToRead );
    int  GetCountInQueueBytes();
    int  RSSwitch_ReadWrite( char* WriteCommand, int LengthWC, char *ReadBuffer );

    void WriteCommAsync(const unsigned char *WriteBuffer, int BufferLength);
    bool ReadCommAsync(unsigned short int CountBt, unsigned short int TimeOutMsec);

    void TimeOuts_Save();
    void TimeOuts_Restore();
    void TimeOuts_Set(int value);

    __property char *ComPortName = {read = Get_ComportName, write = Set_ComportName };
};
//===========================================================================
#endif
