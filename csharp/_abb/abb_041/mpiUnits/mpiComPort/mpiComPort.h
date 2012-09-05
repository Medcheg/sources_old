//---------------------------------------------------------------------------
#ifndef mpiComPortH
#define mpiComPortH
//---------------------------------------------------------------------------
#include "Windows.h"

#define EMPTY_WAITS_IN_THREAD 50
//---------------------------------------------------------------------------
typedef void (*TCallBack )(void *pUserData, unsigned char *pData, unsigned int uiByteCount);
//---------------------------------------------------------------------------
class CComPort
{
private:
      DCB   BasePortSettings;
      DCB   PortSettings;

      void RegestryPortInfoDelete();
public:
      HANDLE          h_ComPort;
      char          **ComPortNames;
      int             CountComPortNames;
      int             CountErrorPacked;

    // ----- Мои глобальные ----
      HANDLE          h_KillThread;
      HANDLE          h_isThreadKilled;
      HANDLE          h_ReadThread;
      TCallBack       pHandler;
      int             ThreadPackedSize;
      void           *pCallBack_UserData;
    // --------

      CComPort();
     ~CComPort();

      int OpenComPort (const char *aComName, int aBaudRate, int aWriteTimeOut, int aReadTimeOut);
      int CloseComPort(void);
      int ScanPorts(void);
      int WriteData(unsigned char *aBuffer, UINT aCountData);
      int ReadData (unsigned char *aBuffer, UINT uCountData);
      //int StartReadThread (TRaw_CallBack pRawHandler, TAlgo_CallBack pAlgoHandler, void* pUserData, BYTE *pSignature, UINT pSignatureSize, UINT aPacketSize);
      int StartReadThread (TCallBack apHandler, void* pUserData, BYTE *pSignature, UINT pSignatureSize, UINT aPacketSize);
      int StopReadThread  (void);
      int SetTimeouts( int iMs);

      bool isCOMHandleNULL();
};
//---------------------------------------------------------------------------
extern CComPort *ComPort1;
extern CComPort *ComPort2;
#endif
