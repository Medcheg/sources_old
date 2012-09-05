//===========================================================================
#ifndef pmSerialPortH
#define pmSerialPortH
//===========================================================================
#include "windows.h"
//===========================================================================
class CSerialPort
{
private:
    HANDLE hCom;
    DCB    BasePortSettings; // �������� ��������� �����
    DCB    PortSettings;     // ���� ��������� �����
public:
    int    BaudRate;
    int    ByteSize;
    int    RtsControl;
    bool   isOpen;

    CSerialPort();
    
    void OpenComPort(char *aComPortName);
    void CloseComPort();
	void ClearComPortError(bool isFullClear);

	bool WriteBuffer(char *pcWrite);
    bool ReadBuffer(char *pcRead);
};
//===========================================================================
#endif
