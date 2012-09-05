//===========================================================================
//#include "mpiPCH.h"
#include <vcl.h>
#pragma hdrstop
//===========================================================================
#include <setupapi.h>
#include <stdio.h>
#include "mpi_rep_SerialInfo.h"


//===========================================================================
namespace nsPortInfo
{
TSerialPortInfo PortInfoArray[255];// ------
int             CountPortInfo;         // -----

//===========================================================================
void Get_SerialPorts(Classes::TStrings *aStrings, bool bCheckConnected)
{
  // ---------- Чищу, СтринЛист ------
    aStrings->BeginUpdate();
    aStrings->Clear();

    CountPortInfo = 0;
    for ( int i = 0; GetPortInfo (i , &PortInfoArray[i]) == 0 ; i++)
        {
          aStrings->AddObject(PortInfoArray[i].pcPortName_FriendlyName, (TObject*)&PortInfoArray[i]);

       // ----- Проверяем, подключенный ли ПОРТ, Простым подсоединением ---------
          if ( bCheckConnected == false ) PortInfoArray[i].isPortAlreadyConnected = false;
          else {
                   HANDLE aComHandle = CreateFile(PortInfoArray[i].pcWindowsPortName, GENERIC_READ | GENERIC_WRITE, 0, 0, OPEN_EXISTING, 0, 0 );//FILE_FLAG_OVERLAPPED
                   PortInfoArray[i].isPortAlreadyConnected = ( aComHandle == INVALID_HANDLE_VALUE );
                   CloseHandle(aComHandle);
          }
          CountPortInfo++;
    }

    aStrings->EndUpdate();
}

//===========================================================================
int GetPortInfo ( unsigned int uiIndexFromZero, TSerialPortInfo *pPortInfoOut)
{
    // -------
        setmem(pPortInfoOut->pcPortName             , NAMESIZE, '\0');
        setmem(pPortInfoOut->pcWindowsPortName      , NAMESIZE, '\0');
        setmem(pPortInfoOut->pcFriendlyName         , NAMESIZE, '\0');
        setmem(pPortInfoOut->pcPortName_FriendlyName, NAMESIZE, '\0');
    // -------
        //DWORD lResult = -1;

	DWORD dwGuids = 0;

	SetupDiClassGuidsFromName( "Ports", 0, 0, &dwGuids );

	GUID* pGuids = new GUID[dwGuids];

	//Call the function again
	SetupDiClassGuidsFromName( "Ports", pGuids, dwGuids, &dwGuids );

	HDEVINFO hDevInfoSet = SetupDiGetClassDevs( pGuids, NULL, NULL, DIGCF_PRESENT );

	delete [] pGuids;

	//BOOL bMoreItems = TRUE;
	int nIndex = 0;
	unsigned int uiCurrIndex = 0;

	SP_DEVINFO_DATA devInfo;

	devInfo.cbSize = sizeof( SP_DEVINFO_DATA );

	while( SetupDiEnumDeviceInfo( hDevInfoSet, nIndex, &devInfo ) && ( uiIndexFromZero != -1 ) )
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
					if ( strnicmp( pszPortName, "COM", 3 ) == 0 )
					{
						char lsStr[256];

						dwSize = sizeof( pszFriendlyName );

						SetupDiGetDeviceRegistryProperty( hDevInfoSet, &devInfo, SPDRP_DEVICEDESC, &dwType, reinterpret_cast<PBYTE>( pszFriendlyName ), dwSize, &dwSize );

						sprintf( lsStr, "%s : %s", pszPortName, pszFriendlyName );

                                                if( uiCurrIndex == uiIndexFromZero ){
                                                  unsigned int uiComIndex = 0;
                                                  sscanf(pszPortName, "COM%d", &uiComIndex);

                                                  pPortInfoOut->uiPortID = uiComIndex;

                                                  strcpy (pPortInfoOut->pcPortName    , pszPortName);
                                                  sprintf(pPortInfoOut->pcWindowsPortName, "\\\\.\\%s", pszPortName);
                                                  strcpy (pPortInfoOut->pcFriendlyName, pszFriendlyName);
                                                  sprintf(pPortInfoOut->pcPortName_FriendlyName, "%s : %s", pszPortName, pszFriendlyName);

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

void Set_FTDIBUS_LatemcyTime( unsigned int uiLatencyTime)
{
      HKEY lhKey;

      if( ERROR_SUCCESS == RegOpenKeyEx(
              HKEY_LOCAL_MACHINE,
              "SYSTEM\\CurrentControlSet\\Enum\\FTDIBUS",
              0,
              KEY_ENUMERATE_SUB_KEYS,
              &lhKey ) )
      {
              char lpKeyName[250];
              HKEY lpSubKey;

              DWORD lpccKeyName = sizeof( lpKeyName );

              DWORD lData = 2;

              for( int i = 0; ERROR_SUCCESS == RegEnumKeyEx( lhKey, i, lpKeyName, &lpccKeyName, 0, 0, 0, 0 ); i++ )
              {
                      strcat( lpKeyName, "\\0000\\Device Parameters" );

                      if( ERROR_SUCCESS == RegOpenKeyEx( lhKey, lpKeyName, 0, KEY_SET_VALUE, &lpSubKey ) )
                      {
                              RegSetValueEx( lpSubKey, "LatencyTimer", 0, REG_DWORD, (const BYTE*)&lData, sizeof( lData ) );
                              RegCloseKey( lpSubKey );
                      }
              }

              RegCloseKey( lhKey );
      }
}

} //  ---- End of NameSpace -----

// ------------------------------------------------
void SetupPortsLatencyTime(int aLatencyTime)
{
  // ------ Выставляю Тайм ауты для всех виртуальных портов --
      char *KeyName[4] = {"SYSTEM\\CURRENTCONTROLSET\\Enum\\FTDIBUS", "SYSTEM\\ControlSet001\\Enum\\FTDIBUS",/*, "SYSTEM\\ControlSet002\\Enum\\FTDIBUS",*/
                          "SYSTEM\\CURRENTCONTROLSET\\Enum\\USB", "SYSTEM\\ControlSet001\\Enum\\USB"/*, "SYSTEM\\ControlSet002\\Enum\\USB"*/};

  // ------
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

                        DWORD dwTime = aLatencyTime;
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
}

void LoadSystemCOMName(char **&COMArray, int &COMCount)
{
    // ---- !!! РАБОТАЕТ ТОЛЬКО ПОД (Windows Server 2003, Windows XP, Windows 2000, or Windows NT) -----
    // ---- Для версии винды юзать "OSVERSIONINFO" -----
    //Используем QueryDosDevice для просмотра всех устройств похожих на COMx. 
    char szDevices[65535];
    if ( QueryDosDevice(NULL, szDevices, 65535) > 0 )  {
          int i = 0;
          while ( szDevices[i] != 0) {

                //Получаем текущее имя устройства
                char* pszCurrentDevice = &szDevices[i];

                //Если похоже на "COMX" ----- тода грабаем
                if (strncmp("COM", pszCurrentDevice, 3) == 0){
                    COMArray = (char**) realloc (COMArray, sizeof (char*) * (++COMCount));
                    COMArray[COMCount-1] = strdup(pszCurrentDevice);
                }

                // Перехожу к следующему сиволу терминатору
                while(szDevices[i] != 0) i++;
                i++;
          }
    }
}

void LoadSystemCOMName_fromRegistry(char **&COMArray, int &COMCount)
{
      HKEY hKeyLocalMachine;
      HKEY hKey;

   // ----- в реестре нахожу порты ---
       if ( RegConnectRegistry(NULL,HKEY_LOCAL_MACHINE,&hKeyLocalMachine) == ERROR_SUCCESS ) {
            if ( RegOpenKey(hKeyLocalMachine, "HARDWARE\\DEVICEMAP\\SERIALCOMM", &hKey ) == ERROR_SUCCESS ) {
                  int    IndexCounter = 0;
                  char   Buffer[4096];
                  char   szVal [4096];
                // -----
                  DWORD  dwType;
                  DWORD  dwSize = 4096, dwSizeVal = 4096;
                // -----
                  while ( RegEnumValue(hKey, IndexCounter, Buffer, &dwSize, NULL, &dwType, (BYTE*)&szVal, &dwSizeVal) == ERROR_SUCCESS ) {
                       if (dwType == REG_SZ) {

                            COMArray = (char**) realloc (COMArray, sizeof (char*) * (++COMCount));
                            COMArray[COMCount-1] = strdup(szVal);
                            IndexCounter  ++;

                            dwSize = dwSizeVal = 4096;
                       }
                  }
                // -----
                  RegCloseKey(hKey);
             }
             RegCloseKey(hKeyLocalMachine);
       }
}

