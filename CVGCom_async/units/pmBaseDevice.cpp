//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmBaseDevice.h"

CBaseDevice *WorkDevice = NULL;

//===========================================================================
CBaseDevice::CBaseDevice( HANDLE aHandleParentWindow )
{
    HandleParentWindow = aHandleParentWindow;

	// -----  Идл Поток ---
    DWORD dwThreadId = 0;
    isThreadStoped = false;
    hThread = CreateThread( NULL, 0, (LPTHREAD_START_ROUTINE)ThreadFunc, (void *)this, CREATE_SUSPENDED, &dwThreadId);
	SetThreadPriority(hThread, THREAD_PRIORITY_IDLE);
    ResumeThread( hThread );

    // --------
    Storage = new CCollectionStorage<float>;

    StorageSamplingFreq = 1.0;

    // --------
    SubDeviceCount  = 0;
    LastSavedIndex  = 0;
    isDeviceWorking = false;
    foo1 = 0;
    foo2 = 0;
    foo_min_delta = 0;
    foo_max_delta = 0;

    // --------
    LoadFromRegistry();
}

//===========================================================================
CBaseDevice::~CBaseDevice()
{
    isThreadStoped = true; Sleep(100);

    // ------
    SaveDataToRegistry();

    // ------
    if ( Storage != NULL ) delete Storage; Storage = NULL;

    // ------
    for ( int i = 0; i < SubDeviceCount; i++ )
    {
        delete SubDevice[i]; SubDevice[i] = NULL;
    }

}

//===========================================================================
void CBaseDevice::LoadFromRegistry()
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
        try {
           Reg = new TRegistry;
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);
           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\InnalabsUA\\" + appName, true);

//           for ( int i = 0; i < nsPortInfo::CountPortInfo; i++ )
  //              Registry_SerialPort_DeviceName[i] = Reg->ReadFloat( nsPortInfo::PortInfoArray[i].pcPortName );

           StorageSamplingFreq                = Reg->ReadFloat("SamplingFreq");
           Storage->file_Param.asDeviceNumber = Reg->ReadString ("Storage.file_Param.DeviceNumber" );
       } catch ( ... )
       {
           SaveDataToRegistry();
       }
    } __finally {
        if (Reg != NULL) delete Reg; Reg = NULL;
    }
}

//===========================================================================
void CBaseDevice::SaveDataToRegistry()
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
           Reg = new TRegistry;
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);
           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\InnalabsUA\\" + appName, true);


           Reg->WriteFloat  ( "SamplingFreq", StorageSamplingFreq );
           //Reg->WriteString ( "ComPortName" , ComPortName  );
           Reg->WriteString ( "Storage.file_Param.DeviceNumber", Storage->file_Param.asDeviceNumber );
    } __finally {
        if (Reg != NULL) delete Reg;
    }
}

//===========================================================================
int CBaseDevice::Start()
{
    int ItemsCount = 0;
    LastSavedIndex = 0;

    // -----
    for ( int i = 0; i < 16; i++) h_file[i] = NULL;

    // -----
    for ( int i = 0; i < SubDeviceCount; i++)
    {
        SubDevice[i]->Init_BeforeRun();
        ItemsCount += SubDevice[i]->CanalsCount;
    }

    // ----- Инитю коллекцию ------
    Storage->SetItemsCount(ItemsCount + 2);
    int ItemsCounter = 0;
    for ( int i = 0; i < SubDeviceCount; i++)
    {
        for (int k = 0; k < SubDevice[i]->CanalsCount; k++ )
            Storage->Items[ItemsCounter++]->SetName(SubDevice[i]->BaseCanalsName[k]);
    }
    Storage->Items[ItemsCount + 0]->SetName("pm_Debug_1\0");
    Storage->Items[ItemsCount + 1]->SetName("pm_Debug_2\0");

    Storage->file_Param.StorageT0[0] = 1.0 / StorageSamplingFreq;

    // ----- Записываю в реестр
    for ( int i = 0; i < SubDeviceCount; i++)
    {
    }


    // ----- Запускаю -----
    for ( int i = 0; i < SubDeviceCount; i++)
    {
        // ---- Единождый запуск старт ------
        if ( SubDevice[i]->DeviceOpen != NULL )
            SubDevice[i]->DeviceOpen((void*)SubDevice[i]);

        // ---- Сериал Порт ----
        if ( SubDevice[i]->isDeviceUsedComPort == true && SubDevice[i]->DeviceSerialPortCallBack != NULL )
        {
            CSerialPort *sp = SubDevice[i]->SerialPort;
            sp->Open( SubDevice[i],
                      SubDevice[i]->ExtParam[2].Value,
                      SubDevice[i]->DeviceSerialPortCallBack,
                      SubDevice[i]->SerialPortPortName,
                      SubDevice[i]->SerialPortParameters );

            if ( sp->isOpen == false)
                __asm {nop};
        }

    }

    OpenDataSaveFile( &h_file[0], Storage );

    isDeviceWorking = true;

    return 0;
}

//===========================================================================
void CBaseDevice::Stop()
{
    isDeviceWorking = false;

    int aSubDeviceCount = SubDeviceCount;
    SubDeviceCount = 0;
    for ( int i = 0; i < aSubDeviceCount; i++)
    {
        if ( SubDevice[i]->DeviceClose != NULL ) SubDevice[i]->DeviceClose((void*)SubDevice[i]);
        SubDevice[i]->SerialPort->Close();
    }
    SubDeviceCount = aSubDeviceCount;

  // ------------
      for ( int i = 0; i < 16; i++)
      {
         if ( h_file[i] != NULL)
             fclose( h_file[i] );
         h_file[i] = NULL;
      }
  // ------------

}

//===========================================================================
void CBaseDevice::OpenDataSaveFile    ( FILE **pFile, CCollectionStorage<float> *pStorage )
{
    // ---------- Открываю файл для записи, если он есть конечно ----
    if ( pStorage->file_Param.FileName == NULL ) return;

    float temp_float = 0.4;

   // ---------------
    *pFile = fopen(pStorage->file_Param.FileName, "wt");

    // -----------------
    fprintf(*pFile, "FileVersion\t\t= %d\n", pStorage->file_Param.FileVersion );
    fprintf(*pFile, "SamplingTime[seconds]\t= %1.9f\n", pStorage->file_Param.StorageT0[0] );
    //fprintf(*pFile, "ScaleFactor\t\t= %1.9f\n", pStorage->file_Param.ScaleFactor[0] );
    fprintf(*pFile, "ScaleFactor\t\t= %1.9f\n", temp_float );
    fprintf(*pFile, "CanalCount\t\t= %d\n", pStorage->GetCountVisibleCanal() );
    fprintf(*pFile, "CanalNames\t\t");

    // -----------------
    for (int i = 0; i < pStorage->ItemsCount; i++)
    {
        if ( pStorage->Items[i]->isCanalVisible == false ) continue;
        fprintf(*pFile, "%s ", pStorage->Items[i]->Name );
    }

    // -----------------
    fprintf(*pFile, "\n\n");
}

//===========================================================================
void CBaseDevice::SaveLastDataToStream( FILE **pFile, CCollectionStorage<float> *pStorage )
{
    if ( *pFile == NULL ) return;

  // ----- и Наконецто пишем в  Файл -----
    try
    {
        bool isFirstTab = true;
        for (int i = 0; i < pStorage->ItemsCount; i++)
        {
        	if ( pStorage->Items[i]->isCanalVisible == false ) continue;

            if ( isFirstTab == true )
            {
                    isFirstTab = false;
                    fprintf( *pFile, "\n%1.9f", pStorage->Items[i]->LastValue );
            }
            else
            {
                if ( i >= pStorage->ItemsCount - 2 )
                {
                    bool b_val1 = strcmp( Storage->Items[i]->Name, "pm_Debug_1" );
                    bool b_val2 = strcmp( Storage->Items[i]->Name, "pm_Debug_2" );
                    if ( b_val1 == 0 || b_val2 == 0 )
                        fprintf( *pFile, "\t%1.1f", pStorage->Items[i]->LastValue);
                }
                else fprintf( *pFile, "\t%1.9f", pStorage->Items[i]->LastValue);
            }
        }
        fflush ( *pFile );
    } catch ( ... ) {}
}

//===========================================================================
DWORD WINAPI CBaseDevice::ThreadFunc(void* lpData)
{
	CBaseDevice *dev = (CBaseDevice*)lpData;

    float   float_Value;
    int     DatasCount_min, DatasCount_max;
    bool    isOnlyInstantValues;
    bool    isAllDeviceHasOnePacked;

    // --------
    LARGE_INTEGER li_f, li_q1, li_q2;
    QueryPerformanceFrequency(&li_f);
    double HERZ_20_counter = li_f.QuadPart * 0.05;

    // --------
    while ( dev->isThreadStoped == false )
    {
        Sleep(50);
        // ----- Idle Update Timer -------
        QueryPerformanceCounter(&li_q2);
        if ( li_q2.QuadPart - li_q1.QuadPart >= HERZ_20_counter )
        {
            li_q1.QuadPart = li_q2.QuadPart;
            PostMessage((HWND__*)dev->HandleParentWindow, MESSAGE_UPDATE_EVENT  ,    0,   0);
        }
        if ( dev->isDeviceWorking == false ) continue;


    // ***********************************************************
    // ***********************************************************
    // ***********************************************************
    // ***********************************************************
        // ----- Запускаю давайсы (запрос и т.п.), проверка ошибок ----
		for ( int i = 0; i < dev->SubDeviceCount; i++ )
        {
            TSubDevice *sd = dev->SubDevice[i];

            // ---- Запись в устройство значения ----
            if ( sd->DeviceRequestData != NULL ) sd->DeviceRequestData(sd);

        	// ---- Ошибка запуска гириков, подымаю мессагу ----
            if ( sd->isErrorStart == true ) {
                PostMessage((HWND__*)dev->HandleParentWindow, MESSAGE_START_DEVICE_ERROR, 0, 0);
                continue;
            }
            if ( sd->isBreakConnection == 1 )
            {
                char *ch = &DeviceNames[sd->DeviceType][0];
                PostMessage((HWND__*)dev->HandleParentWindow, MESSAGE_DEVICE_BREAK_CONNECTION, (unsigned int)ch, 0);
                sd->isBreakConnection = 2;
                sd->isWasDeviceError  = true; // --- Перевожу в режим мгновенных значений ----
            }
            if ( sd->isFrameError == 1 )
            {
                char *ch = &DeviceNames[sd->DeviceType][0];
                PostMessage((HWND__*)dev->HandleParentWindow, MESSAGE_DEVICE_BREAK_CONNECTION, (unsigned int)ch, 0);
                sd->isFrameError      = 2;
                sd->isWasDeviceError  = true; // --- Перевожу в режим мгновенных значений ----
            }
            if ( sd->isUnknownError == 1 )
            {
                char *ch = &DeviceNames[sd->DeviceType][0];
                PostMessage((HWND__*)dev->HandleParentWindow, MESSAGE_DEVICE_UNKNOWN_ERROR, (unsigned int)ch, 0);
                sd->isUnknownError    = 2;
                sd->isWasDeviceError  = true; // --- Перевожу в режим мгновенных значений ----
            }

        }


    // ***********************************************************
    // ***********************************************************
    // ***********************************************************
    // ***********************************************************
        // ----- Проверяю, все ли девайсы юзают мгновенные значения ----
        isOnlyInstantValues = true;
		for ( int i = 0; i < dev->SubDeviceCount; i++ )
        {
            TSubDevice *sd = dev->SubDevice[i];
            if ( sd->isDeviceGetInstantValues == false && sd->isWasDeviceError == false )
                isOnlyInstantValues = false;
        }

        // ----- Проверяю, все девасы собрали ли, хотябы один пакет ----
        isAllDeviceHasOnePacked = true;
		for ( int i = 0; i < dev->SubDeviceCount; i++ )
            if ( dev->SubDevice[i]->DeviceInfo.GlobalPackedCounter_stored == 0 )
                isAllDeviceHasOnePacked = false;
        if ( isAllDeviceHasOnePacked == false ) continue;

    // ***********************************************************
    // ***********************************************************
    // ***********************************************************
    // ***********************************************************
	    DatasCount_min      = 0x7FFFFFFF;
	    DatasCount_max      = 0;
		for ( int i = 0; i < dev->SubDeviceCount; i++ )
        {
            TSubDevice     *sd = dev->SubDevice[i];
            tag_DeviceInfo *di = &sd->DeviceInfo;

            if ( sd->isDeviceGetInstantValues == false )
            {
                if ( DatasCount_min > di->GlobalPackedCounter_stored  ) DatasCount_min = di->GlobalPackedCounter_stored;
                if ( DatasCount_max < di->GlobalPackedCounter_stored  ) DatasCount_max = di->GlobalPackedCounter_stored;
            }

            if ( isOnlyInstantValues == true )
            {
                if ( DatasCount_min > di->GlobalPackedCounter_stored  ) DatasCount_min = di->GlobalPackedCounter_stored;
                if ( DatasCount_max < di->GlobalPackedCounter_stored  ) DatasCount_max = di->GlobalPackedCounter_stored;
            }

            /*
            // ----- Если с давайса нада использловать только мнговенные значения -- ----
            if ( sd->isDeviceGetInstantValues == false )
            {
                isOnlyInstantValues = false;
                // ---- минимальное КОличество данных собранных по девайсам----
                if ( DatasCount_min > di->GlobalPackedCounter_stored  ) DatasCount_min = di->GlobalPackedCounter_stored;
                if ( DatasCount_max < di->GlobalPackedCounter_stored  ) DatasCount_max = di->GlobalPackedCounter_stored;

            }
            if ( isOnlyInstantValues == true )
            {
                //DatasCount_max = DatasCount_min = sd->DeviceInfo.GlobalPackedCounter_stored;
            }
*/
        }

        // --- Собираю данные с разных девайсов ---
        unsigned int CanalCounter = 0;
        for ( int i = 0; i < dev->SubDeviceCount; i++ )
        {
            tag_DeviceInfo *di = &dev->SubDevice[i]->DeviceInfo;
        	for ( int z = 0; z < dev->SubDevice[i]->CanalsCount; z++, CanalCounter++ )
            {
                dev->foo_min_delta = DatasCount_min - dev->LastSavedIndex;
                dev->foo_max_delta = DatasCount_max - dev->LastSavedIndex;
        		for ( int k = dev->LastSavedIndex; k < DatasCount_min; k++ )
            	{
                    int circle_buff_offset = di->GlobalPackedCounter_stored - k;
                    int circle_buff_pos    = dev->SubDevice[i]->CircleBuffer[0].index_curr - circle_buff_offset;
                    if ( circle_buff_pos < 0 ) circle_buff_pos += CIRCLE_BUFFER_DEPTH;

                    if ( dev->SubDevice[i]->isDeviceGetInstantValues == false )
                	     float_Value = dev->SubDevice[i]->CircleBuffer[z].values[circle_buff_pos];
                    else float_Value = dev->SubDevice[i]->CircleBuffer[z].values[0];

                	dev->Storage->Items[CanalCounter]->Add( float_Value );

                    // ------ Временные, ошибки  -----
                    if ( z == 0 ) {
                    	dev->Storage->Items[ dev->Storage->ItemsCount - 2 ]->Add( dev->foo_min_delta );
                	    dev->Storage->Items[ dev->Storage->ItemsCount - 1 ]->Add( dev->foo_max_delta );
                    }
                }
            }
        }
        // ------
        if ( CanalCounter != 0 && dev->LastSavedIndex != DatasCount_min )
        {
        	dev->SaveLastDataToStream( &dev->h_file[0], dev->Storage );
            dev->LastSavedIndex = DatasCount_min;
        }
    }
    return 0;
}

