//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmBaseDevice.h"
CBaseDevice *WorkDevice = NULL;

const unsigned char crc8_table[256] = {
    0x00,0x5E,0xBC,0xE2,0x61,0x3F,0xDD,0x83,0xC2,0x9C,0x7E,0x20,0xA3,0xFD,0x1F,0x41,
    0x9D,0xC3,0x21,0x7F,0xFC,0xA2,0x40,0x1E,0x5F,0x01,0xE3,0xBD,0x3E,0x60,0x82,0xDC,
    0x23,0x7D,0x9F,0xC1,0x42,0x1C,0xFE,0xA0,0xE1,0xBF,0x5D,0x03,0x80,0xDE,0x3C,0x62,
    0xBE,0xE0,0x02,0x5C,0xDF,0x81,0x63,0x3D,0x7C,0x22,0xC0,0x9E,0x1D,0x43,0xA1,0xFF,
    0x46,0x18,0xFA,0xA4,0x27,0x79,0x9B,0xC5,0x84,0xDA,0x38,0x66,0xE5,0xBB,0x59,0x07,
    0xDB,0x85,0x67,0x39,0xBA,0xE4,0x06,0x58,0x19,0x47,0xA5,0xFB,0x78,0x26,0xC4,0x9A,
    0x65,0x3B,0xD9,0x87,0x04,0x5A,0xB8,0xE6,0xA7,0xF9,0x1B,0x45,0xC6,0x98,0x7A,0x24,
    0xF8,0xA6,0x44,0x1A,0x99,0xC7,0x25,0x7B,0x3A,0x64,0x86,0xD8,0x5B,0x05,0xE7,0xB9,
    0x8C,0xD2,0x30,0x6E,0xED,0xB3,0x51,0x0F,0x4E,0x10,0xF2,0xAC,0x2F,0x71,0x93,0xCD,
    0x11,0x4F,0xAD,0xF3,0x70,0x2E,0xCC,0x92,0xD3,0x8D,0x6F,0x31,0xB2,0xEC,0x0E,0x50,
    0xAF,0xF1,0x13,0x4D,0xCE,0x90,0x72,0x2C,0x6D,0x33,0xD1,0x8F,0x0C,0x52,0xB0,0xEE,
    0x32,0x6C,0x8E,0xD0,0x53,0x0D,0xEF,0xB1,0xF0,0xAE,0x4C,0x12,0x91,0xCF,0x2D,0x73,
    0xCA,0x94,0x76,0x28,0xAB,0xF5,0x17,0x49,0x08,0x56,0xB4,0xEA,0x69,0x37,0xD5,0x8B,
    0x57,0x09,0xEB,0xB5,0x36,0x68,0x8A,0xD4,0x95,0xCB,0x29,0x77,0xF4,0xAA,0x48,0x16,
    0xE9,0xB7,0x55,0x0B,0x88,0xD6,0x34,0x6A,0x2B,0x75,0x97,0xC9,0x4A,0x14,0xF6,0xA8,
    0x74,0x2A,0xC8,0x96,0x15,0x4B,0xA9,0xF7,0xB6,0xE8,0x0A,0x54,0xD7,0x89,0x6B,0x35};

//===========================================================================
CBaseDevice::CBaseDevice()
{
    DeviceType  = edtNone;
    SamplingFreqsRate.Clear();

  // -------- Параметры ---------
    HandleParenWindow         = NULL;
    onAlarmStop               = NULL;
    mThread                   = NULL;
    GyroScaleFactor           = 1.0;
    GyroScaleFactorArrayIndex = 0;
    isGyroScaleFactorPresent  = false;
    SummationCount            = 1;
    SummationCount_invert     = 1.0;
    CurrentSummationPoint     = 0;
    Switch_count			  = 0;

    for ( int i = 0; i < 16; i++)
    {
    	h_file[i]          = NULL;
        Switch_indexes[16] = -1;
    }

    InfoPackedLength = PackedLength = 0;
    CurrentSummationPoint 			= 0;
    isTestingDeviceWork   		    = false;
	isExternalGyroCommandPresent    = false;
    isRealTimeProcessing 		    = false;
    isSapmlingStoped                = false;

    SamplingFreq             =  0;
    WorkTime                 =  20;
    isWorkTimeEnabled        = false;
    Switch_count             =  0;
    Parent_ThreadType        = -1;
    CountUARTValues          =  0;
    SendValueType_to_gyro[0] = -1;
    SendValueType_to_gyro[1] = -1;

    ZeroChar[0] = 0x0D;
    ZeroChar[1] = 0x0A;


  // ----- ExtendedParam --------
    ExtendedParamCount = 0;
    for (int i = 0; i < 255; i++)
    {
        ExtendedParamValues[i] = 0.0;
        ExtendedParamNames [i] = NULL;
    }


    ParentOnlineValues     = (double*) malloc (sizeof(double) * 2400);
    ParentSummValues       = (double*) malloc (sizeof(double) * 2400);
    isNeedCalcMiddledValue = (bool  *) malloc (sizeof(bool  ) * 2400);

    memset( ParentOnlineValues      ,    0, sizeof(ParentOnlineValues    [0]) * 2400 );
    memset( ParentSummValues        ,    0, sizeof(ParentSummValues      [0]) * 2400 );
    memset( isNeedCalcMiddledValue  , true, sizeof(isNeedCalcMiddledValue[0]) * 2400 );

    com_buffer  = (unsigned char *) calloc (WORK_BUFFER_SIZE, sizeof(unsigned char));
    work_buffer = (unsigned char *) calloc (WORK_BUFFER_SIZE, sizeof(unsigned char));

    SummationCount = 0;


  // --------
    h_file_binlog = NULL;
  // --------
    SerialPort = new CSerialPort();
    Storage    = new CCollectionStorage<float>();
    for ( int i = 0; i < 16; i++)
        StorageSW[i] = new CCollectionStorage<float>();


    QueryPerformanceFrequency(&li_f);
}

//===========================================================================
CBaseDevice::~CBaseDevice()
{
    if ( Storage     != NULL ) delete Storage;     Storage     = NULL;
    if ( SerialPort  != NULL ) delete SerialPort;  SerialPort  = NULL;
    if ( com_buffer  != NULL ) free (com_buffer);  com_buffer  = NULL;
    if ( work_buffer != NULL ) free (work_buffer); work_buffer = NULL;

    if ( ParentOnlineValues     != NULL ) { free (ParentOnlineValues    ); ParentOnlineValues     = NULL; }
    if ( ParentSummValues       != NULL ) { free (ParentSummValues      ); ParentSummValues       = NULL; }
    if ( isNeedCalcMiddledValue != NULL ) { free (isNeedCalcMiddledValue); isNeedCalcMiddledValue = NULL; }

    if ( h_file_binlog != NULL) fclose( h_file_binlog ); h_file_binlog = NULL;

    for ( int i = 0; i < 16; i++)
    {
        if ( StorageSW[i] != NULL )
            delete StorageSW[i];
        StorageSW[i] = NULL;
    }

  // -------- ExtendedParam -------
     for ( int i = 0; i < 255; i++ )
     {
          ExtendedParamValues[i] = 0.0;
          if ( ExtendedParamNames[i] != NULL ) free(ExtendedParamNames[i]);  ExtendedParamNames[i] = NULL;
     }

     ExtendedParamCount = 0;
}

//===========================================================================
void CBaseDevice::LoadFromRegistry(AnsiString strDeviceType)
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
        try {
           Reg = new TRegistry;
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);
           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\InnalabsUA\\CVGCom\\"+strDeviceType, true);

           WorkTime          = Reg->ReadFloat( "WorkTime" );
           isWorkTimeEnabled = Reg->ReadBool ( "isWorkTimeEnabled" );
           SamplingFreq      = Reg->ReadFloat("SamplingFreq");
           ComPortName       = AnsiString(Reg->ReadString ("ComPortName" )).c_str();

           Storage->file_Param.DeviceNumber   = Reg->ReadString ("Storage.file_Param.DeviceNumber" );
           Storage->file_Param.ScaleFactor[0] = Reg->ReadFloat  ("Storage.file_Param.ScaleFactor" );

           for ( int i = 0; i < 16; i++ )
           {
               AnsiString val1 = "StorageSW[" + IntToStr(i) + "].file_Param.DeviceNumber";
               AnsiString val2 = "StorageSW[" + IntToStr(i) + "].file_Param.ScaleFactor";
               StorageSW[i]->file_Param.DeviceNumber   = Reg->ReadString ( val1 );
               StorageSW[i]->file_Param.ScaleFactor[0] = Reg->ReadFloat ( val2 );
           }
       } catch ( ... ){
           Reg->CloseKey();
           SaveDataToRegistry(strDeviceType);
        }
    } __finally {
        Reg->CloseKey();
        if (Reg != NULL)
                delete Reg;
        Reg = NULL;
    }              
}

//===========================================================================
void CBaseDevice::SaveDataToRegistry(AnsiString strDeviceType)
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
           Reg = new TRegistry;
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);
           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\InnalabsUA\\CVGCom\\"+strDeviceType, true);


           Reg->WriteFloat( "WorkTime", WorkTime );
           Reg->WriteBool( "isWorkTimeEnabled", isWorkTimeEnabled );

           Reg->WriteFloat( "SamplingFreq", SamplingFreq );
           Reg->WriteString ( "ComPortName" , ComPortName  );

           Reg->WriteString ( "Storage.file_Param.DeviceNumber", Storage->file_Param.DeviceNumber );
           Reg->WriteFloat  ( "Storage.file_Param.ScaleFactor" , Storage->file_Param.ScaleFactor[0] );

           for ( int i = 0; i < 16; i++ )
           {
               AnsiString val1 = "StorageSW[" + IntToStr(i) + "].file_Param.DeviceNumber";
               AnsiString val2 = "StorageSW[" + IntToStr(i) + "].file_Param.ScaleFactor";
               Reg->WriteString ( val1, StorageSW[i]->file_Param.DeviceNumber   );
               Reg->WriteFloat  ( val2, StorageSW[i]->file_Param.ScaleFactor[0] );
           }
    } __finally {
        Reg->CloseKey();

        if (Reg != NULL) delete Reg;
    }
}
//===========================================================================
char* __fastcall CBaseDevice::Get_ComportName()
{
	if ( SerialPort == NULL ) return NULL;

    return SerialPort->ComPortName; 
}

//===========================================================================
void __fastcall CBaseDevice::Set_ComportName(char *aComName)
{
	if ( SerialPort == NULL ) return;

    SerialPort->ComPortName = aComName; 
}

//===========================================================================
int CBaseDevice::Start()
{
  // ----------
    isDataReady               = false;
    isDeviceError             = false;
    isSapmlingStoped          = false;
    isBeginStoping            = false;
    CurrentSumPoint           = 0;
    CountErrorPacked          = 0;
    CountBadValues            = 0;
    CountNotReadData          = 0;
    GlobalPackedCounter       = 0;
    CountSavedPacked          = 0;
    com_buffer_pos            = 0;
    TempParam                 = 0;
    isErrorSatrtGyro          = false;

    for ( int i = 0; i < 16; i++) h_file[i] = NULL;

    memset( ParentOnlineValues      ,    0, sizeof(ParentOnlineValues    [0]) * 2400 );
    memset( ParentSummValues        ,    0, sizeof(ParentSummValues      [0]) * 2400 );

    // ----------
    if ( SerialPort->OpenComPort() == false ) return -1;

   // --------------- Debug File ---------------
    if ( isDebugMode == true )
    {
        unsigned short  year;
        unsigned short  month;
        unsigned short  day;
        AnsiString ts = Now().FormatString("yyyy_mm_dd_(hh_mm_ss)");
        char aNameLogFile[555], aPath[555];

        sprintf( aPath       , "%s\\.PackedLog\0",AnsiString(ApplicationFolder).c_str());
        sprintf( aNameLogFile, "%s\\%s.log\0",aPath, AnsiString(ts).c_str());
        CreateDirectory(aPath, NULL);

        h_file_binlog = fopen(aNameLogFile, "wb");
        fwrite( Storage->file_Param.FileName, 1, strlen(Storage->file_Param.FileName), h_file_binlog);
        fflush(h_file_binlog);
    }

    SerialPort->ClearComPortError(true);

    InitDeviceBeforeStart();

   // --------- Создаем поток -----------
    mThread = new CThread(this);
    switch ( Parent_ThreadType )
    {
        case  1 : { mThread->Create(false, ThreadFunction_Type1,  0); break; }
        case  2 : { mThread->Create(false, ThreadFunction_Type2, -2); break; }
        case  3 : { mThread->Create(false, ThreadFunction_Type3, -2); break; }
        default : return -1;
    }

    return 0;
}

//===========================================================================
void CBaseDevice::Stop()
{
    isBeginStoping = true;

  // ----- Убиваю поток ------
      if ( mThread != NULL )
      {
           mThread->Kill();
           delete mThread;
           mThread = NULL;
           Sleep(56);
      }

  // ------------ Закрываю КОМ порты -----
      SerialPort->CloseComPort();
      Sleep(25);

  // ------------
      for ( int i = 0; i < 16; i++)
      {
         if ( h_file[i] != NULL)
             fclose( h_file[i] );
         h_file[i] = NULL;
      }
  // ------------

    if ( h_file_binlog != NULL) fclose(h_file_binlog); h_file_binlog = NULL;
}

//===========================================================================
int CBaseDevice::OpenDataSaveFile( FILE **pFile, CCollectionStorage<float> *pStorage )
{
    // ---------- Открываю файл для записи, если он есть конечно ----
    if ( pStorage->file_Param.FileName == NULL ) return -1;

    for ( unsigned int i = 0; i < strlen(pStorage->file_Param.FileName); i++)
        if ( pStorage->file_Param.FileName[i] == '/' )
            pStorage->file_Param.FileName[i] = '_';
   // ---------------
    try {
        *pFile = fopen(pStorage->file_Param.FileName, "wt");
    } catch (...) {
        return -1;
    }
    if ( pFile == NULL ) return -1;



    // -----------------
    fprintf(*pFile, "FileVersion\t\t= %d\n",            pStorage->file_Param.FileVersion );
    fprintf(*pFile, "SamplingTime[seconds]\t= %1.9f\n", pStorage->file_Param.StorageT0[0] );
    fprintf(*pFile, "ScaleFactor\t\t= %1.9f\n",         pStorage->file_Param.ScaleFactor[0] );
    fprintf(*pFile, "CanalCount\t\t= %d\n",             pStorage->GetCountVisibleCanal() );
    fprintf(*pFile, "CanalNames\t\t");
    
    // ----------------- 
    for (int i = 0; i < pStorage->ItemsCount; i++)
    {
        if ( pStorage->Items[i]->isCanalVisible == false ) continue;
        fprintf(*pFile, "%s ", pStorage->Items[i]->Name  );
    }

    // -----------------
    fprintf(*pFile, "\n\n");

    return 0;
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
            } else  fprintf( *pFile, "\t%1.9f", pStorage->Items[i]->LastValue);
        }
        fflush ( *pFile );
    } catch ( ... ) {}
}

//===========================================================================
bool CBaseDevice::isWorkError( CBaseDevice *gd )
{
    try
    {
         if ( gd                    == NULL                 ) return false;
         if ( gd->SerialPort        == NULL                 ) return false;
         if ( gd->SerialPort->hComm == INVALID_HANDLE_VALUE ) return false;
         if ( gd->SerialPort->hComm == NULL                 ) return false;
         if ( gd->isDeviceError     == true                 ) return false;
    }
    catch (...)
    {
        char mess[1024];
        sprintf (mess, "Error code 1: Data not present' %s '", gd->ComPortName);
        MessageBox(gd->fHandleParenWindow, mess, "Error", MB_ICONERROR|MB_OK);

        return false;
    }
  // ----------
    return true;
}

//===========================================================================
bool CBaseDevice::isCRC_Ok( unsigned char* pBuf, unsigned short int Len )
{
   // -----
	 if ( Len < 3 || Len > 1000 ) return false;
   // -----

    unsigned short int val           = 0;
    unsigned short int CheckSumValue = 0;
    unsigned short int CurValue      = 0;
   // -------
    memcpy(&CheckSumValue , &pBuf[Len - 2], 2);
   // -------
    for ( int BuffPosCounter = 2; BuffPosCounter < Len - 2; BuffPosCounter = BuffPosCounter + 2 )
    {
      memcpy(&CurValue , &pBuf[BuffPosCounter], 2);
      val = val + CurValue;
    }

    return (val == CheckSumValue);
//    return true;
}

//===========================================================================
void CBaseDevice::InitDeviceBeforeStart()
{
}

//===========================================================================
bool CBaseDevice::WriteCommand()
{
}

//===========================================================================
void CBaseDevice::DeCompositeData()
{
}

//===========================================================================
void CBaseDevice::RealTimeProcessing(double *in_out_array)
{
}

//===========================================================================
void CBaseDevice::ThreadFunction_Type1(void* CS, void* pUserData)
{

  // ----------
   DWORD         dRead;
   DWORD         dwErrors;
   COMSTAT       lCOMSTAT;
   unsigned char cVal[1024];
  // ----------
   CBaseDevice *gd = (CBaseDevice *)pUserData;

  // ---------- Проверка на NULL ----
    if ( gd->isWorkError( gd ) == false ) return;

  // ------- Проверяю, собралось ли в Порте 12 байт ? -----
   if ( ClearCommError( gd->SerialPort->hComm, &dwErrors, &lCOMSTAT ) == 0 )
   {
        //int aa = GetLastError();
      PurgeComm( gd->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
      gd->CountNotReadData ++;
      return;
   }

   if ( dwErrors != 0 )
   {
      PurgeComm( gd->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
      gd->CountNotReadData ++;
      return;
   }

   if ( lCOMSTAT.cbInQue < 12 )
   {
       Sleep(5);
       return;
   }

  // ----------
    if ( gd->CountNotReadData >= 120  )
    {
           gd->CountNotReadData = 0;
           gd->isDeviceError = true;
           gd->mThread->SetPriotity(THREAD_PRIORITY_IDLE);
    }

    // ----- Количество информации которую могу зараз читать, привязываюсь к размеру пакету ------
    int NeadRead = ( gd->PackedLength / 2 < 4) ? 4 : gd->PackedLength / 2;

//    COMSTAT    	ComStat;
//    DWORD 		dw_Errors;
//    ClearCommError( gd->SerialPort->hComm, &dw_Errors, &ComStat);
//    int NeadRead = ComStat.cbInQue;
//    if ( NeadRead == 0 ) { Sleep(1); return; }
//    //gd->InfoPackedLength = ComStat.cbInQue - 2;
////    if (  != 0 && GetLastError() != ERROR_IO_PENDING) continue;
//	gd->InfoPackedLength = GetLastError();
//
//    //    char aaa[1024];
////    NeadRead = ComStat.cbInQue;
////    sprintf(aaa, "&i\n\0", &ComStat.cbInQue);
////    fwrite(aaa, 1,  strlen(aaa),gd->h_file_binlog);
////    fflush(gd->h_file_binlog);

    dRead = 0;
    bool b_result = ReadFile( gd->SerialPort->hComm, &cVal, NeadRead, &dRead, 0 );

    // --------
      if ( b_result == false )
            PurgeComm( gd->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );


    // ---- Если прочитал 0 байт, увеличиваю количество ошибок ----
      if ( dRead == 0 || dRead >= WORK_BUFFER_SIZE )
      {
          PurgeComm( gd->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
          gd->CountNotReadData ++;
          return;
      } else gd->CountNotReadData = 0;


    // ----- Если прочитали пакет -- сбрасываем счетчик не принятых "НОЛЬ" байтов ------
      gd->CountNotReadData = 0;

    // --------
        memcpy (&gd->com_buffer[gd->com_buffer_pos],  cVal, dRead);
        gd->com_buffer_pos = gd->com_buffer_pos + dRead;

    // ---- это что внизу == хреново ----
        if ( gd->com_buffer_pos >= WORK_BUFFER_SIZE - 1000 ){
             gd->com_buffer_pos = 0;
             gd->isDeviceError = true;
             gd->mThread->SetPriotity(THREAD_PRIORITY_IDLE);
             return;
        }

    // ----- если прочитано только 2 байта -- тогда вон ------
        if ( gd->com_buffer_pos < 2) return;

    // ---- ищу признак начала следующего пакета -------
        bool isPresent = false;
        int  posPacked = -1;
        for ( unsigned int i = 1; i <= gd->com_buffer_pos; i++)
        {
           // --- Если нашел признак начала нового пакета, фиксирую его положение начала ------
            if ( gd->com_buffer[i] == 0xAA && gd->com_buffer[i+1] == 0x55 && i >= (unsigned int)gd->PackedLength - 2 ){
                isPresent = true;
                posPacked = i;
                //gd->InfoPackedLength = i;
                break;
            }
        }

     // ------ если такого нету -- тогда нафик ------
        if ( isPresent == false) return;

      // ------------- Если получили признак начала "покета" на обработку -----
        memset (gd->work_buffer, 0, 100);
        memcpy (gd->work_buffer, gd->com_buffer            , posPacked + 2);
        memmove(gd->com_buffer , &gd->com_buffer[posPacked], gd->com_buffer_pos);

        gd->com_buffer_pos = gd->com_buffer_pos - posPacked;

     ///////////////////////////////////////////////////////////////////////////
     //                        ПРОВЕРКА ПАКЕТА                                //
     ///////////////////////////////////////////////////////////////////////////
     // ---- Если первый пакет, сразы вываливаемся, потомучто он всегда битый ( не полный тобишь ) -----
      if ( gd->GlobalPackedCounter      == 0               ) { gd->GlobalPackedCounter++; return; }
     // ----------- Расшифровую данные (Если пакет не нормальный --- пользуюсь старым пакетом ) ------
     // ----- Проверка на контрольную сумму ----------

        if ( gd->isCRC_Ok( gd->work_buffer, gd->PackedLength ) == false )
        {
            gd->CountErrorPacked++;
            /*
            if ( isDebugMode == true )
            {
                fwrite(gd->ZeroChar, 1,         2, gd->h_file_binlog);
                BinToHex( gd->com_buffer, gd->HexBuff, posPacked);
                fwrite(gd->HexBuff , 1, strlen(gd->HexBuff), gd->h_file_binlog);
                fflush(gd->h_file_binlog);
            }
            */
            return;
        }

        // ----- Если буфер по какойто причине засорен мусоров , очень сильно, и прочитали удачно пакет, тогда сьрасываем буффер -----
        if ( gd->com_buffer_pos > 3000 ) gd->com_buffer_pos = 1;

        // -----
        float fValue  = 0;
        // -----
        int   bPosition = 2;
        //for (int i = 0; i < gd->Storage->ItemsCount; i++)
        for (int i = 0; i < gd->CountUARTValues; i++)
        {
            memcpy(&fValue , &gd->work_buffer[bPosition], 4);
            gd->ParentOnlineValues[i] =  fValue; bPosition += 4;
            // --- Если сбойное значение ---
            if ( fValue >= 1e5 || fValue <= -1e5 )
            {
                gd->CountErrorPacked++;
                if ( isDebugMode == true )
                {
                    fwrite(gd->ZeroChar, 1,         2, gd->h_file_binlog);
                    BinToHex( gd->com_buffer, gd->HexBuff, posPacked );
                    fwrite(gd->HexBuff , 1, strlen(gd->HexBuff), gd->h_file_binlog);
                    fflush(gd->h_file_binlog);
                }
               return;
            }
        }

        if ( gd->isRealTimeProcessing == true )
        {
            gd->RealTimeProcessing(gd->ParentOnlineValues);
        }

       // ----- Сумирую ----
		for (int i = 0; i < gd->Storage->ItemsCount; i++)
            if ( gd->isNeedCalcMiddledValue[i] == true )
             	 gd->ParentSummValues[i] = gd->ParentSummValues[i] + gd->ParentOnlineValues[i];
            else gd->ParentSummValues[i] = gd->ParentOnlineValues[i];

       // ---- Если количество сумирований совпало , тогда записуем данные ----
          if ( ++gd->CurrentSumPoint >= gd->SummationCount )
          {
                 // -------- Отсылаю данные дочерним классам на обработку данных ------
                   gd->DeCompositeData();

                  // ------ Обнуляю суммы -----
                    for (int i = 0; i < gd->Storage->ItemsCount; i++) gd->ParentSummValues[i] = 0;

                  // ----- SaveData ---
                    gd->SaveLastDataToStream( &gd->h_file[0], gd->Storage );

                 // --- Данные для отображения готовы ----
                    gd->isDataReady     = true;
                    gd->CurrentSumPoint = 0;
                    gd->CountSavedPacked++;
                 // ---
          }
          gd->GlobalPackedCounter++;
}

//===========================================================================
bool CBaseDevice::isReadPackedCS_OK( CBaseDevice  *gd )
{
    DWORD         dRead;
//    DWORD         dwErrors;

//  // ---- Ищу "АА" -----
    ReadFile( gd->SerialPort->hComm, &gd->com_buffer[0], 1, &dRead, 0 );
    if ( dRead             != 1    )
    {
        Sleep(0);
        return false;
    }
    if ( gd->com_buffer[0] != 0xAA )
    {
        gd->CountErrorPacked++;
        Sleep(0);
        return false;
    }

  // ---- Если нашли, тогда ---
    ReadFile( gd->SerialPort->hComm, &gd->com_buffer[1], 11, &dRead, 0 );

    unsigned char  crc8    = 0x0;
    unsigned char *buff    = &gd->com_buffer[1];
    unsigned char  base_cs =  gd->com_buffer[11];

    for ( int i = 0; i < 10; i++) crc8 = crc8_table[ ( crc8 ^ (unsigned char)buff[i] ) ];
/*
    crc8    = 0xFF;
	for ( int k = 0; k < 10; k++)
    {
        crc8 ^= (unsigned char)buff[k];
        for (int i = 0; i < 8; i++)
            crc8 = (crc8 & 0x80) ? (crc8 << 1) ^ temp_crc_base : crc8 << 1;
    }
*/

    if ( (unsigned char)crc8 != (unsigned char)base_cs)
    {
        gd->CountErrorPacked++;
        return false;
    }
    return true;
}

//===========================================================================
void CBaseDevice::ThreadFunction_Type2(void* CS, void* pUserData)
{
  // ----------
    CBaseDevice *gd = (CBaseDevice *)pUserData;

  // ---------- Проверка на NULL ----
    if ( gd->isWorkError( gd ) == false ) return;

    if ( gd->isWorkTimeEnabled == true )
        if ( gd->GlobalPackedCounter / (gd->SummationCount*gd->SamplingFreq)  >= gd->WorkTime )
        {
            gd->isSapmlingStoped = true;
            return;
        }

  // ---------- Посылка команды в Ком порт ---
    if ( gd->WriteCommand() == false ) return;

    try {
        if ( gd->mThread               == NULL ) return;
        if ( gd->mThread->IsKilled()   == true ) return;
        if ( gd->mThread               == NULL ) return;
        if ( gd->mThread->IsFinished() == true ) return;
    } catch ( ... ) {
        return;
    }

  // ------- Проверяю, собралось ли в Порте 12 байт ? -----
    COMSTAT lCOMSTAT;
    DWORD   dwErrors;
    ClearCommError( gd->SerialPort->hComm, &dwErrors, &lCOMSTAT );
    if ( lCOMSTAT.cbInQue < 12 )
    {
       //gd->TempParam++;
       Sleep(5);
       return;
    }
 //iSkipPackedCounter
  // ---------- Получение пакета и проверка КС ----
    if ( gd->isReadPackedCS_OK( gd ) == false )
    {
    	return;
    }

    // ---- Расшифровка пакета ----
        float fValue[2];
        //int   id_param_0 = ( (unsigned char)gd->com_buffer[1]       & 0x0F ); // ---- Номер гирика на контролерре -----
        //int   id_param_1 = (((unsigned char)gd->com_buffer[1] >> 4) & 0x0F ); // ---- Номер контроллера ----
        int   id_param_2 = ( (unsigned char)gd->com_buffer[2]       & 0x0F ); // ---- Номер параметра по первому флоату -----
        int   id_param_3 = (((unsigned char)gd->com_buffer[2] >> 4) & 0x0F ); // ---- Номер параметра по второму флоату
        memcpy(&fValue[0], &gd->com_buffer[3], 4);
        memcpy(&fValue[1], &gd->com_buffer[7], 4);

    // -------- Проверка на збойные пакеты ------

       if ( gd->GyroMode == 3 || gd->GyroMode == 4 )
       {
            if ( fValue[0] > 22500 || fValue[0] < -22500 || fValue[1] > 22500 || fValue[1] < -22500 )
            {
                if ( isDebugMode == true )
                {
                    fwrite(gd->com_buffer, 1, 12, gd->h_file_binlog);
                    fflush(gd->h_file_binlog);
                    gd->CountBadValues++;
                }
                //return;
            }
       }

// pipec: нада доработать Распихуевывание параметров ----
    gd->ParentOnlineValues[          0 ] = fValue[0];
    gd->ParentOnlineValues[ id_param_3 ] = fValue[1];

    //------ Проверка на ошибку запуска гирика, ( тобишь не запуск в 4 режиме, а запуск в 3 режиме)
    if ( gd->GyroMode == 4 && gd->GlobalPackedCounter > 120 && gd->GlobalPackedCounter < 320)
    {
        if ( gd->ParentOnlineValues[ 2 ] == 0.0 &&
        	 gd->ParentOnlineValues[ 3 ] == 0.0 &&
        	 gd->ParentOnlineValues[ 4 ] == 0.0 &&
        	 gd->ParentOnlineValues[ 5 ] == 0.0 &&
        	 gd->ParentOnlineValues[ 6 ] == 0.0 &&
        	 gd->ParentOnlineValues[ 7 ] == 0.0 &&
        	 gd->ParentOnlineValues[ 8 ] == 0.0 ) gd->isErrorSatrtGyro = true;
    }

    // --- Сэтап имени первого параметра для дэбаг режима ----------
    gd->GlobalPackedCounter++;
    if ( gd->isDebugGyroModeInited == false && gd->GyroMode >= 0 && gd->GyroMode <= 2 )
    {
        gd->isDebugGyroModeInited = true;
        return;
    }
    if ( gd->isDebugGyroModeInited == false && gd->GyroMode == 4 )
    {
        if ( gd->GlobalPackedCounter > 20 * 1 ) gd->isDebugGyroModeInited = true;
        if ( id_param_2 != 0 && gd->Storage->Items[0]->ValuesCount <= 1 )
            gd->Storage->Items[0]->SetName(gd->BaseCanalsName[id_param_2]);

        return;
    }

    // ------- Раскидываю по масивам параметры ------
    if ( gd->GyroMode == 3 || gd->GyroMode == 4 )
    {
        for ( int i = 0; i < gd->Storage->ItemsCount; i++ ) gd->ParentSummValues[i] += gd->ParentOnlineValues[i];

        if ( ++ gd->CurrentSummationPoint < gd->SummationCount ) return;

        gd->CurrentSummationPoint = 0;
        for ( int i = 0; i < gd->Storage->ItemsCount; i++ )
        {
            gd->ParentOnlineValues[i] =  gd->ParentSummValues[i] * gd->SummationCount_invert;
            gd->ParentSummValues  [i] = 0.0;
        }
    }

    // ----- Закидываю данные в колекцию -------
    for ( int i = 0; i < gd->Storage->ItemsCount; i ++)
    	gd->Storage->Items[i]->Add(gd->ParentOnlineValues[i]);

    // --------
    gd->CountSavedPacked++;
    gd->SaveLastDataToStream( &gd->h_file[0], gd->Storage );
    gd->isDataReady = true;
}

//===========================================================================
void CBaseDevice::ThreadFunction_Type3(void* CS, void* pUserData)
{
    // ----------
    DWORD         dRead;
    DWORD         dwErrors;
    COMSTAT       lCOMSTAT;
    unsigned char cVal[1024];
    // ----------
    CBaseDevice *gd = (CBaseDevice *)pUserData;

    if ( gd->isBeginStoping  == true )  return;
    if ( gd->isWorkError( gd ) == false ) return;
    if ( gd->mThread->IsKill() == true ) return;

/*
    // ---------- Проверка на NULL ----
    if ( gd->isWorkError( gd ) == false ) return;

    // ------- Проверяю, собралось ли в Порте 12 байт ? -----
    if ( ClearCommError( gd->SerialPort->hComm, &dwErrors, &lCOMSTAT ) == 0 ) {
        PurgeComm( gd->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
        gd->CountNotReadData ++;
        return;
    }

    if ( dwErrors != 0 ) {
        PurgeComm( gd->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
        gd->CountNotReadData ++;
        return;
    }
*/
    gd->WriteCommand();
    gd->DeCompositeData();


/*
    // --------
    dRead = 0;
	int NeadRead  = 10;
	bool b_result = ReadFile( gd->SerialPort->hComm, &cVal, NeadRead, &dRead, 0 );

    // --------
    if ( b_result == false )
        PurgeComm( gd->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );

    // ---- Если прочитал 0 байт, увеличиваю количество ошибок ----
      if ( dRead == 0 || dRead >= WORK_BUFFER_SIZE ) {
         PurgeComm( gd->SerialPort->hComm, PURGE_TXCLEAR | PURGE_RXCLEAR );
          gd->CountNotReadData ++;
          return;
      } else gd->CountNotReadData = 0;

    // ----- Если прочитали пакет -- сбрасываем счетчик не принятых "НОЛЬ" байтов ------
    gd->CountNotReadData = 0;

    // --------
    memcpy (&gd->com_buffer[gd->com_buffer_pos],  cVal, dRead);
    gd->com_buffer_pos = gd->com_buffer_pos + dRead;

    // ---- это что внизу == хреново ----
    if ( gd->com_buffer_pos >= WORK_BUFFER_SIZE - 1000 ){
        gd->com_buffer_pos = 0;
        gd->isDeviceError = true;
        gd->mThread->SetPriotity(THREAD_PRIORITY_IDLE);
        return;
    }

    // ----- Если буфер по какойто причине засорен мусоров , очень сильно, и прочитали удачно пакет, тогда сьрасываем буффер -----
    if ( gd->com_buffer_pos > 3000 ) gd->com_buffer_pos = 1;

*/
}

