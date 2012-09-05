//---------------------------------------------------------------------------
#include "mpiComPort.h"
#include "stdio.h"

CComPort *ComPort1;
CComPort *ComPort2;
//---------------------------------------------------------------------------

static DWORD ReadThreadProc(LPVOID param);
//---------------------------------------------------------------------------
CComPort::CComPort()
{
   h_ComPort         = INVALID_HANDLE_VALUE;
   ComPortNames      = NULL;
   CountComPortNames = 0;
   ThreadPackedSize  = 0;
   CountErrorPacked  = 0;

}

/*
WS_DLL int wsGetPortInfo(unsigned int uiIndexCOM, WS_PROTOTYPE1::PortInfo *pPortInfoOut)
{
  DWORD lResult = -1;

     DWORD dwGuids = 0;

     SetupDiClassGuidsFromName( "Ports", 0, 0, &dwGuids );

     GUID* pGuids = new GUID[dwGuids];

     //Call the function again
     SetupDiClassGuidsFromName( "Ports", pGuids, dwGuids, &dwGuids );

     HDEVINFO hDevInfoSet = SetupDiGetClassDevs( pGuids, NULL, NULL, DIGCF_PRESENT );

     delete [] pGuids;

     BOOL bMoreItems = TRUE;
     int nIndex = 0;
     unsigned int uiCurrIndex = 0;

     SP_DEVINFO_DATA devInfo;

     devInfo.cbSize = sizeof( SP_DEVINFO_DATA );

     while( SetupDiEnumDeviceInfo( hDevInfoSet, nIndex, &devInfo ) && ( uiIndexCOM != -1 ) )
     {
          HKEY hDeviceKey = SetupDiOpenDevRegKey( hDevInfoSet, &devInfo, DICS_FLAG_GLOBAL, 0, DIREG_DEV, KEY_QUERY_VALUE );

          if( hDeviceKey )
          {
               char pszPortName[256];
               char pszFriendlyName[256];

               DWORD dwSize = sizeof(pszPortName);
               DWORD dwType = 0;

               if( ( 
                    ( RegQueryValueEx( hDeviceKey, "PortName", NULL, &dwType, reinterpret_cast<LPBYTE>( pszPortName ), &dwSize ) == ERROR_SUCCESS ) ) && 
                    ( dwType == REG_SZ )
                    )
               {
                    size_t nLen = strlen( pszPortName );

                    if (nLen > 3)
                    {
                         if ( _strnicmp( pszPortName, "COM", 3 ) == 0 )
                         {
                              char lsStr[256];

                              dwSize = sizeof( pszFriendlyName );

                              SetupDiGetDeviceRegistryProperty( hDevInfoSet, &devInfo, SPDRP_DEVICEDESC, &dwType, reinterpret_cast<PBYTE>( pszFriendlyName ), dwSize, &dwSize );

                              sprintf( lsStr, "%s : %s", pszPortName, pszFriendlyName );
                              unsigned int uiIndexCOM_Cur = 0;
                              sscanf(pszPortName, "COM%d", &uiIndexCOM_Cur);

            if(uiIndexCOM_Cur == uiIndexCOM){
              unsigned int uiComIndex = 0;
              sscanf(pszPortName, "COM%d", &uiComIndex);
              
              pPortInfoOut->uiPortID = uiComIndex;
              strcpy(pPortInfoOut->pcsDescription, pszFriendlyName);
              
              return 0;
            }
              
            uiCurrIndex++;
                         }
                    }
               }
               RegCloseKey(hDeviceKey);
          }
          ++nIndex;
     }
     SetupDiDestroyDeviceInfoList( hDevInfoSet );
     return -1;
}
*/
//---------------------------------------------------------------------------
CComPort::~CComPort()
{
    RegestryPortInfoDelete();
}

//---------------------------------------------------------------------------
bool CComPort::isCOMHandleNULL()
{
  return (h_ComPort == INVALID_HANDLE_VALUE || h_ComPort == NULL);
}

//---------------------------------------------------------------------------
void CComPort::RegestryPortInfoDelete()
{
   if (ComPortNames == NULL) return;
   
   for ( int i = 0; i < CountComPortNames; i ++){
      free(ComPortNames[i]);
      ComPortNames[i] = NULL;
   }
   free(ComPortNames);
   ComPortNames = NULL;
   CountComPortNames = 0;
}

//---------------------------------------------------------------------------
int CComPort::OpenComPort (const char *aComName, int aBaudRate, int aWriteTimeOut, int aReadTimeOut)
{
        CountErrorPacked  = 0;
      // -------
        char aNewComName[255];
        sprintf(aNewComName, "\\\\.\\%s", aComName);
        //sprintf(aNewComName, "%s", aComName);
        h_ComPort  = CreateFile(aNewComName, GENERIC_READ | GENERIC_WRITE, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0 );
      // -------
        if ( h_ComPort == INVALID_HANDLE_VALUE) {
            sprintf(aNewComName, "Unable to open port name  '%s'", aComName);
            MessageBox(h_ComPort, aNewComName, "Error", MB_OK);
            return -1;
        }
     // ---- утанавливаю парметры
         GetCommState(h_ComPort, &BasePortSettings);
         memcpy(&PortSettings, &BasePortSettings, sizeof(DCB));

         PortSettings.ByteSize      = 8;
         PortSettings.BaudRate      = aBaudRate;
         PortSettings.Parity        = NOPARITY;
         PortSettings.StopBits      = ONESTOPBIT;
         PortSettings.fOutX         = 0;
         PortSettings.fInX          = 0;
         PortSettings.fErrorChar    = 0;
         PortSettings.fNull         = 0;
               
       // ----- Задаю БОД рейт ----
         if(SetCommState(h_ComPort, &PortSettings) == false) {
              CloseHandle(h_ComPort);   h_ComPort = INVALID_HANDLE_VALUE;
              sprintf(aNewComName, "Unable to set parameters of port name '%s'", aComName);
              return - 1; // ---- Не смогли установить параметры ком порта
         }

      // -------
         COMMTIMEOUTS timeouts;
         if ( GetCommTimeouts(h_ComPort, &timeouts) == false )
         {
              CloseHandle(h_ComPort);    h_ComPort = INVALID_HANDLE_VALUE;
              sprintf(aNewComName, "Unable to get time parameters of port name '%s'", aComName);
              return -1; // Can't get COM-port timeout settings
         }
               
     // -----------
         timeouts.ReadTotalTimeoutConstant  = aWriteTimeOut;
         timeouts.WriteTotalTimeoutConstant = aReadTimeOut;
         if(SetCommTimeouts(h_ComPort, &timeouts) == false)
         {
              CloseHandle(h_ComPort);
              h_ComPort = INVALID_HANDLE_VALUE;

              sprintf(aNewComName, "Unable to set time parameters of port name '%s'", aComName);
                 
             return -1; // Can't set COM-port timeout settings (SetCommTimeouts)
         }
      // -------------
      // Remove any 'old' data in buffer
         PurgeComm(h_ComPort, PURGE_TXCLEAR | PURGE_RXCLEAR);
    // -------
      return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CComPort::CloseComPort(void)
{
   //---------------
     int aResult = 0;
     if(SetCommState(h_ComPort, &BasePortSettings) == false)
         aResult = -1;
   //---------------
     CloseHandle(h_ComPort);
     h_ComPort = INVALID_HANDLE_VALUE;

     return aResult;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CComPort::ScanPorts(void)
{
      RegestryPortInfoDelete();
  // ------ Выставляю Тайм ауты для всех виртуальных портов --
      char *KeyName[4] = {"SYSTEM\\CURRENTCONTROLSET\\Enum\\FTDIBUS", "SYSTEM\\ControlSet001\\Enum\\FTDIBUS",/*, "SYSTEM\\ControlSet002\\Enum\\FTDIBUS",*/
                          "SYSTEM\\CURRENTCONTROLSET\\Enum\\USB", "SYSTEM\\ControlSet001\\Enum\\USB"/*, "SYSTEM\\ControlSet002\\Enum\\USB"*/};

      for ( int k = 0; k < 4; k ++) {
                  HKEY hKeyLocalMachine = NULL;
                  if(RegConnectRegistry(NULL,HKEY_LOCAL_MACHINE,&hKeyLocalMachine)==ERROR_SUCCESS){
                    HKEY hKeyComm = NULL;
                    if(RegOpenKey(hKeyLocalMachine,KeyName[k],&hKeyComm)==ERROR_SUCCESS){
                      unsigned int i=0;
                      char pcsName[4096];
                      while(RegEnumKey(hKeyComm,i,pcsName,4096)==ERROR_SUCCESS){
                        HKEY hCurrentDevice = NULL;
                        RegOpenKey(hKeyComm,pcsName,&hCurrentDevice);
                        if(hCurrentDevice==NULL) {
                          i++;
                          continue;
                        }


                        HKEY hCurr = NULL;
                        RegOpenKey(hCurrentDevice,"0000\\Device Parameters",&hCurr);

                        if(hCurr==NULL) {
                          i++;
                          continue;
                        }

                        DWORD dwTime = 2;
                        RegSetValueEx(hCurr,"LatencyTimer",0,REG_DWORD,(const BYTE*)&dwTime,sizeof(DWORD));

                        RegCloseKey(hCurr);
                        RegCloseKey(hCurrentDevice);

                        i++;
                      }

                      RegCloseKey(hKeyComm);
                    }
                    RegCloseKey(hKeyLocalMachine);
                  }
      }

  // ------------------
      HKEY hKeyLocalMachine;
      HKEY hKey;
      CountComPortNames = 0;
   // ----- в реестре нахожу порты ---

       if ( RegConnectRegistry(NULL,HKEY_LOCAL_MACHINE,&hKeyLocalMachine) == ERROR_SUCCESS )
       {
            if ( RegOpenKey(hKeyLocalMachine, "HARDWARE\\DEVICEMAP\\SERIALCOMM", &hKey ) == ERROR_SUCCESS )
            {
                 int    IndexCounter = 0;
                 char   Buffer[4096];
                 char   szVal [4096];
                 DWORD  dwSize = 4096, dwType, dwSizeVal = 4096;
                 while ( RegEnumValue(hKey, IndexCounter, Buffer, &dwSize, NULL, &dwType, (BYTE*)&szVal, &dwSizeVal) == ERROR_SUCCESS )
                 {
                       if (dwType == REG_SZ)
                       {
                           ComPortNames = (char**) realloc (ComPortNames, sizeof(char*) * (++CountComPortNames));

                           ComPortNames[CountComPortNames - 1] = (char*) malloc(dwSizeVal + 1);

                           memcpy(ComPortNames[CountComPortNames - 1], szVal, dwSizeVal);
                           ComPortNames[CountComPortNames - 1][dwSizeVal] = 0;

                           IndexCounter++;
                           dwSizeVal = 4096;
                           dwSize    = 4096;
                       }
                 }
                 RegCloseKey(hKey);
            }
            RegCloseKey(hKeyLocalMachine);
       }
   return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CComPort::WriteData(unsigned char *aBuffer, UINT aCountData  )
{
    DWORD uBytesWritten = 0;

    if ( WriteFile(h_ComPort, aBuffer, aCountData, &uBytesWritten, NULL) == 0) {
        __asm {nop};
        return -1;
    }

    return uBytesWritten;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CComPort::ReadData (unsigned char *aBuffer, UINT uCountData)
{
     DWORD BytesRead = 0;

    if ( ReadFile(h_ComPort, aBuffer, uCountData, &BytesRead, NULL) == 0 ) return -1;

    return BytesRead;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int CComPort::SetTimeouts( int iMs)
{
      if ( h_ComPort == INVALID_HANDLE_VALUE ) return -1;
  // ---------
      COMMTIMEOUTS timeouts;
      if(GetCommTimeouts(h_ComPort, &timeouts) == FALSE)
      {
           return -2; // Can't get COM-port timeout settings
      }
  // ---------
     timeouts.ReadTotalTimeoutConstant  = iMs;
     timeouts.WriteTotalTimeoutConstant = iMs;
  // ---------
     if(SetCommTimeouts(h_ComPort, &timeouts) == FALSE)
     {
          return -3; // Can't set COM-port timeout settings
     }

   return 0;
}

int CComPort::StartReadThread (TCallBack apHandler, void* pUserData, BYTE *pSignature, UINT pSignatureSize, UINT aPacketSize)
{
      pCallBack_UserData = pUserData;
      ThreadPackedSize   = aPacketSize;
      pHandler           = apHandler;

   // --------- Создаем поток -----------
      DWORD dwThread;

      h_KillThread     = CreateEvent (NULL, TRUE, false, "p1");
      h_isThreadKilled = CreateEvent (NULL, TRUE, false, "p2");
      h_ReadThread     = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE )ReadThreadProc, this, 0, &dwThread);
      
      return 0;
}

int CComPort::StopReadThread  (void)
{
     SetEvent( h_KillThread );

     if ( WaitForSingleObject(h_isThreadKilled , 30000 ) == WAIT_OBJECT_0) {};

     ResetEvent(h_KillThread);
     ResetEvent(h_isThreadKilled);

     CloseHandle(h_KillThread);
     CloseHandle(h_isThreadKilled);
     CloseHandle(h_ReadThread);
     
     h_ReadThread     = NULL;
     h_KillThread     = NULL;
     h_isThreadKilled = NULL;

     return 0;
}

static bool ValidateStream(unsigned char* stream, int aSize)
{
    unsigned short control = 0;
    unsigned char* ch = stream;
    for(int i = aSize; i > 0; i--, ch++) control = control + (unsigned short)*ch;
    unsigned short valid = (ch[0] << 8) | (ch[1]);
    return (control == valid);
}

static bool isBreak(unsigned int* sig)
{
  return ((sig[0] == 0x20494441) && (sig[1] == 0x20323438) && (sig[2] == 0x32562020) && (sig[3] == 0x0A0D3730));
}

static DWORD ReadThreadProc(LPVOID param)
{
      CComPort *aComPort = (CComPort*)param;

      char          StreamBuffer[16384];
      char          ReadBuffer[16384];

      bool          ThreadFlag = true;

      int           aStreamBufferSize = 0;
      int           CountSkipByte = 0;
  // -----------------------------
      while ( ThreadFlag == true) {
          // -------- Обработка события кила потока ------
              if ( WaitForSingleObject(aComPort->h_KillThread , 0 ) == WAIT_OBJECT_0)
              {
                 aComPort->pCallBack_UserData = NULL;
                 SetEvent(aComPort->h_isThreadKilled);
                 break;
              }

           // ------ Читаю данные с порта ----
              int CountReadByte = aComPort->ReadData(ReadBuffer, aComPort->ThreadPackedSize + 4);
              if (CountReadByte <= 0) continue;

           // ----- Копирую прочитанные данные с ReadBuffer в StreamBuffer -----
              memcpy(&StreamBuffer[aStreamBufferSize], ReadBuffer, CountReadByte);

           // -------
              aStreamBufferSize += CountReadByte;

           // ----- Если нету достаточного количества данных --- продолжаем -----
              if( aStreamBufferSize < aComPort->ThreadPackedSize ) continue;

           // ----- Ведем обработку по всем данным --------   
              int i = 0;
              while (i <= aStreamBufferSize - aComPort->ThreadPackedSize)
              {
                   char* ptr = &StreamBuffer[i];
                   if ( ValidateStream(ptr, aComPort->ThreadPackedSize - 2) == true ) {
                      // ------ если нашли валидный пакет, тогда отдаем наобработку ----
                        aComPort->pHandler(aComPort->pCallBack_UserData, ptr, aComPort->ThreadPackedSize - 2);

                      //------- перемещаем кусок необработанных данных в начало буфера ----
                        memmove(&StreamBuffer[0], &StreamBuffer[i+aComPort->ThreadPackedSize], aStreamBufferSize);

                      // ------ уменьшаем размер поточного буфера на размер прочитанного пакета -----
                        aStreamBufferSize = aStreamBufferSize - i - aComPort->ThreadPackedSize;

                      // ------
                        i = 0;
                   }
                   else
                   {
                       i++;
                     // ----- инкриментируем количество пропущенных байт ----  
                       CountSkipByte++;

                     // ----- расчитываем количество пропущенных пакетов ----
                       aComPort->CountErrorPacked = CountSkipByte / aComPort->ThreadPackedSize;
                   }
              }
      }
      ExitThread(0);
      return 0;
}

