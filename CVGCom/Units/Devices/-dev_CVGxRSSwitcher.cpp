//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGxRSSwitcher.h"

//===========================================================================
static unsigned char dscrc_table[] =
{
    0, 94,188,226, 97, 63,221,131,194,156,126, 32,163,253, 31, 65,
    157,195, 33,127,252,162, 64, 30, 95, 1,227,189, 62, 96,130,220,
    35,125,159,193, 66, 28,254,160,225,191, 93, 3,128,222, 60, 98,
    190,224, 2, 92,223,129, 99, 61,124, 34,192,158, 29, 67,161,255,
    70, 24,250,164, 39,121,155,197,132,218, 56,102,229,187, 89, 7,
    219,133,103, 57,186,228, 6, 88, 25, 71,165,251,120, 38,196,154,
    101, 59,217,135, 4, 90,184,230,167,249, 27, 69,198,152,122, 36,
    248,166, 68, 26,153,199, 37,123, 58,100,134,216, 91, 5,231,185,
    140,210, 48,110,237,179, 81, 15, 78, 16,242,172, 47,113,147,205,
    17, 79,173,243,112, 46,204,146,211,141,111, 49,178,236, 14, 80,
    175,241, 19, 77,206,144,114, 44,109, 51,209,143, 12, 82,176,238,
    50,108,142,208, 83, 13,239,177,240,174, 76, 18,145,207, 45,115,
    202,148,118, 40,171,245, 23, 73, 8, 86,180,234,105, 55,213,139,
    87, 9,235,181, 54,104,138,212,149,203, 41,119,244,170, 72, 22,
    233,183, 85, 11,136,214, 52,106, 43,117,151,201, 74, 20,246,168,
    116, 42,200,150, 21, 75,169,247,182,232, 10, 84,215,137,107, 53
};

/* 
Когда компилятор встречает такую строку:
   #pragma chMSG(Fix this later)

Он выводит такую строку:

  c:\CD\CmnHdr.h(82):Fix this later

Вы можете свободно прыгнуть на указанную строку в коде и изучить окружающий код
*/

CCVGxRSSwithcer::CCVGxRSSwithcer()
{ 

  // ----- Частоты на которых работаем в непрерывном режиме выдачи информации ------
    SamplingFreqsRate.Clear();

    SamplingFreqsRate.Add(  1);
    SamplingFreqsRate.Add(  5);
    SamplingFreqsRate.Add( 10);
    SamplingFreqsRate.Add( 20);
    SamplingFreqsRate.Add( 50);
    SamplingFreqsRate.Add(100);
    SamplingFreqsRate.Add(200);
    SamplingFreqsRate.Add(300);
    SamplingFreqsRate.Add(600);

    SerialPort->BaudRate    = 115200;
    SerialPort->ByteSize    = 8;
    SerialPort->RtsControl  = 0;

    ExtendedParamCount = 3;
    ExtendedParamValues[0] = 4;      ExtendedParamNames[0] = ( isDebugMode == true ) ? strdup("Gyro mode [1..4]:") : strdup("Gyro mode [1..3]:");
    ExtendedParamValues[1] = 0;      ExtendedParamNames[1] = strdup("Controller number:");
    ExtendedParamValues[2] = 10;     ExtendedParamNames[2] = strdup("Data frequency for mode [1],[2]:");
    ExtendedParamValues[3] = 600;
    ExtendedParamValues[4] = 12;   

    GyroMode              = -1;
    ControllerNumber      = -1;
    isFirstThreadInput    = true;
    isStorageInited       = false;
    isDebugGyroModeInited = false;
    OnlineCanalCount      = 0;

  // --------
    QueryPerformanceFrequency(&li_f);

  // --------
    h_file_binlog = NULL;

  // --------

    LoadFromRegistry("CVGxRSSwithcer");
}

//===========================================================================
CCVGxRSSwithcer::~CCVGxRSSwithcer()
{
    if ( h_file_binlog != NULL) fclose( h_file_binlog ); h_file_binlog = NULL;

    SaveDataToRegistry("CVGxRSSwithcer");
}

//===========================================================================
void CCVGxRSSwithcer::Start()
{
   // ----------
    SaveDataToRegistry("CVGxRSSwithcer");

   // ----------
    GyroMode                 = ExtendedParamValues[0];
    ControllerNumber         = ExtendedParamValues[1];
    DeviceFrequency_mode_1_2 = ExtendedParamValues[2];
    DeviceFrequency_mode_3_4 = ExtendedParamValues[3];
    PackedLength             = ExtendedParamValues[4];
    InfoPackedLength         = ExtendedParamValues[4];

   // ----------
    isAutoStart_inBaseClassThread = false;
    isFirstThreadInput            = true;
    isStorageInited               = false;
    isDebugGyroModeInited         = false;
    GyrosCount                    = 1;
    ParametersCount               = 1;

    SummationCount                = DeviceFrequency_mode_3_4 / SamplingFreq;
    if ( SummationCount < 1 ) SummationCount = 1;
    SummationCount_invert         = 1.0 / (double)SummationCount;
    CurrentSummationPoint         = 0;

    Storage->StorageT0[0] = SummationCount / (double) DeviceFrequency_mode_3_4;
    if ( GyroMode == 1 || GyroMode == 2 ) Storage->StorageT0[0] = 1.0 / (double)DeviceFrequency_mode_1_2;

    for ( int i = 0 ; i < CVGX_LOCAL_ARRAY_SIZE; i++)
    {
        OnlineValues[i] = 0;
        SummValues  [i] = 0;
    }

   // ---------- Выставка имен каналов ---------
    sprintf(OnlineNames[0][ 0], "GyroOut\0"        );
    sprintf(OnlineNames[0][ 1], "Temperature\0"    );
    sprintf(OnlineNames[0][ 2], "AntinodePeriod\0"    );
    sprintf(OnlineNames[0][ 3], "ExcitationAmpl\0" );
    sprintf(OnlineNames[0][ 4], "QuadratureAmpl\0" );
    sprintf(OnlineNames[0][ 5], "QuadratureError\0");
    sprintf(OnlineNames[0][ 6], "CoriolisError\0"  );
    sprintf(OnlineNames[0][ 7], "XAmplitude\0"     );
    sprintf(OnlineNames[0][ 8], "YAmplitude\0"     );
    sprintf(OnlineNames[0][ 9], "XMean\0"          );
    sprintf(OnlineNames[0][10], "YMean\0"          );
    sprintf(OnlineNames[0][11], "GyroOut_RAW\0"    );
    sprintf(OnlineNames[0][12], "N_Excitation\0"    );
//         sprintf(OnlineNames[0][10], "g%i_YMean\0"          ,i);
//         sprintf(OnlineNames[0][11], "g%i_GyroOut_RAW\0"    ,i);

   // ------- Формирование Команды ----------
     switch ( GyroMode )
     {
     	case   1 : SendValue = 0x10 + ControllerNumber; break;
     	case   3 : SendValue = 0x20 + ControllerNumber; break;
     	case   4 : SendValue = 0x70 + ControllerNumber; break;
        default : break; // ---- вывод инфы о том, что неправильно заданные режимым --------
     }

   // -------------
     li_freqCounter       = li_f.QuadPart / 200.0;
     li_freqCounter_base  = li_f.QuadPart / (double)DeviceFrequency_mode_1_2;

     QueryPerformanceCounter(&li_q1);

   // -------------
    CBaseDevice::Start();

   // --------------- Debug File ---------------
    unsigned short  year;
    unsigned short  month;
    unsigned short  day;
    AnsiString ts = Now().FormatString("yyyy_mm_dd_(hh_mm_ss)");
    char aNameLogFile[555], aPath[555];

    sprintf( aPath       , "%s\\.PackedLog\0",ApplicationFolder.c_str());
    sprintf( aNameLogFile, "%s\\%s.log\0",aPath, ts.c_str());
    CreateDirectory(aPath, NULL);

    h_file_binlog = fopen(aNameLogFile, "wb");
    fwrite( file_Param.FileName, 1, strlen(file_Param.FileName), h_file_binlog);
    fflush(h_file_binlog);

   // --------- Создаем поток -----------
    mThread = new CThread(this);
    mThread->Create(false, CallBackFunction, -2);
}

//===========================================================================
void CCVGxRSSwithcer::Stop()
{
  // ----- Останавливаю выдачу данных в в РС485 ----
    char SendVal = 0x40;
    DWORD  dWrite;
    if ( SerialPort->isOpen == true && GyroMode != 4)
        for ( int i = 0; i < 50; i++)
            WriteFile( SerialPort->hCom, &SendVal, 1, &dWrite, NULL);

  // -----
    CBaseDevice::Stop();
  // -----
    if ( h_file_binlog != NULL) fclose(h_file_binlog); h_file_binlog = NULL;
}

//===========================================================================
bool CCVGxRSSwithcer::isWorkError( CCVGxRSSwithcer *gd )
{
    try
    {
         if ( gd->SerialPort->hCom == NULL                 ) return false;
         if ( gd->SerialPort->hCom == INVALID_HANDLE_VALUE ) return false;
         if ( gd->isDeviceError    == true                 ) return false;
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
bool CCVGxRSSwithcer::isReadPackedCS_OK( CCVGxRSSwithcer *gd )
{
    DWORD         dRead;
//    DWORD         dwErrors;

//  // ---- Ищу "АА" -----
    ReadFile( gd->SerialPort->hCom, &gd->com_buffer[0], 1, &dRead, 0 );
    if ( dRead             != 1    ) return false;
    if ( gd->com_buffer[0] != 0xAA ) return false;
/*
  // ---- Если нашли , тогда ---
    ReadFile( gd->SerialPort->hCom, &gd->com_buffer[1], 11, &dRead, 0 );

    unsigned short int tv;
    unsigned short int val = 0;
    unsigned short int base_cs;

    base_cs = gd->com_buffer[11];
    memcpy( &tv,      &gd->com_buffer[ 1], 2 ); val += tv;
    memcpy( &tv,      &gd->com_buffer[ 3], 2 ); val += tv;
    memcpy( &tv,      &gd->com_buffer[ 5], 2 ); val += tv;
    memcpy( &tv,      &gd->com_buffer[ 7], 2 ); val += tv;
    memcpy( &tv,      &gd->com_buffer[ 9], 2 ); val += tv;

    if ( (unsigned char)(val & 0xFF) != (unsigned char)base_cs)
    {
        gd->CountErrorPacked++;
        return false;
    }
*/    


  // ---- Если нашли , тогда ---
    ReadFile( gd->SerialPort->hCom, &gd->com_buffer[1], 11, &dRead, 0 );
    unsigned char  crc8    = 0x0;
    unsigned char *buff    = &gd->com_buffer[1];
    unsigned char  base_cs =  gd->com_buffer[11];
    for ( int i = 0; i < 10; i++) crc8 = dscrc_table[ ( crc8 ^ (unsigned char)buff[i] ) ];
    if ( (unsigned char)crc8 != (unsigned char)base_cs)
    {
        gd->CountErrorPacked++;
        return false;
    }

/*
  // ---- Если нашли , тогда ---
    ReadFile( gd->SerialPort->hCom, &gd->com_buffer[1], 12, &dRead, 0 );

    unsigned short int tv;
    unsigned short int val = 0;
    unsigned short int base_cs;

    memcpy( &base_cs, &gd->com_buffer[11], 2 );
    memcpy( &tv,      &gd->com_buffer[ 1], 2 ); val += tv;
    memcpy( &tv,      &gd->com_buffer[ 3], 2 ); val += tv;
    memcpy( &tv,      &gd->com_buffer[ 5], 2 ); val += tv;
    memcpy( &tv,      &gd->com_buffer[ 7], 2 ); val += tv;
    memcpy( &tv,      &gd->com_buffer[ 9], 2 ); val += tv;

    if ( val != base_cs )
    {
        gd->CountErrorPacked++;
        return false;
    }
*/
    return true;
}

//===========================================================================
void CCVGxRSSwithcer::WriteCommand( CCVGxRSSwithcer *gd )
{
    DWORD  dWrite;

  // ------ Непрерывная выдача ----
    if ( ( gd->GyroMode == 3 || gd->GyroMode == 4) && gd->isFirstThreadInput == true )
    {
         gd->isFirstThreadInput = false;
         WriteFile( gd->SerialPort->hCom, &gd->SendValue, 1, &dWrite, NULL);
    }

  // ------ Выдача по Запросу ----
    if ( gd->GyroMode == 1 )
    {
        QueryPerformanceCounter(&gd->li_q2);
        if ( gd->li_q2.QuadPart - gd->li_q1.QuadPart >= gd->li_freqCounter )
        {
            gd->li_q1.QuadPart = gd->li_q2.QuadPart;
            WriteFile( gd->SerialPort->hCom, &gd->SendValue, 1, &dWrite, NULL);
        }
    }
}

//===========================================================================
void CCVGxRSSwithcer::SetupCountDeviceChanels( CCVGxRSSwithcer *gd, int aControllerNumber, int aGyroNumber, int aCanalNumber1, int aCanalNumber2 )
{
  // ---------- Опредиляю количество гириков на Процессоре и
  // ---------- Количество данных по одному гирику,
  // ---------- и заполняю структуру данных
    if ( gd->isStorageInited == false )
    {
        if ( aCanalNumber2 < gd->ParametersCount )
        {
            // ------ Для Режима 1 Востанавливаю частоту после инита ------
            gd->li_freqCounter  = gd->li_freqCounter_base;
            gd->isStorageInited = true;

            // ------ Выставляю количество каналов -----
            gd->Storage->SetItemsCount(gd->ParametersCount);
            Sleep(100); ///
            // ------ Выставляю имена -----
            for ( int i = 0; i < gd->ParametersCount; i++)
                gd->Storage->Items[i]->SetName(gd->OnlineNames[0][i]);

            gd->Storage->Items[0]->SetName(gd->OnlineNames[0][aCanalNumber1]);

            // ------ Открываем для записи файл ---
            gd->OpenDataSaveFile();
        }
        //if ( gd->GyrosCount       <  val1 ) gd->GyrosCount      = val1;
        if ( gd->ParametersCount  <  aCanalNumber2 + 1 ) gd->ParametersCount = aCanalNumber2 + 1; // --- +1 потомучто нумерация с нуля
        if ( gd->isStorageInited == false ) return;
    }
}

//===========================================================================
void CCVGxRSSwithcer::CallBackFunction(void* CS, void* pUserData)
{
  // ----------
    CCVGxRSSwithcer *gd = (CCVGxRSSwithcer *)pUserData;

  // ---------- Проверка на NULL ----
    if ( gd->isWorkError( gd ) == false ) return;

  // ---------- Посылка команды в Ком порт ---
    gd->WriteCommand( gd );

  // ---------- Получение пакета и проверка КС ----
    if ( gd->isReadPackedCS_OK( gd ) == false ) return;

    // ---- Расшифровка пакета ----
    float fValue[2];
    int   id_param_0 = 0;//( (unsigned char)gd->com_buffer[2]       & 0x0F );     
    int   id_param_1 = 0;//( (unsigned char)gd->com_buffer[2]       & 0x0F );
    int   id_param_2 = ( (unsigned char)gd->com_buffer[2]       & 0x0F );        // ---- Номер параметра по первому параметра -----
    int   id_param_3 = (((unsigned char)gd->com_buffer[2] >> 4) & 0x0F );
    memcpy(&fValue[0], &gd->com_buffer[3], 4);
    memcpy(&fValue[1], &gd->com_buffer[7], 4);

    // -------- Проверка на збойные пакеты ------
    if ( fValue[0] > 10000 || fValue[0] < -10000 || fValue[1] > 10000 || fValue[1] < -10000 )
    {
        fwrite(gd->com_buffer, 1, 12, gd->h_file_binlog);
        fflush(gd->h_file_binlog);
        gd->CountBadValues++;
        return;
    }

    // ---- Сэтапю каналы ----
    if ( gd->isStorageInited == false )
    {
       gd->SetupCountDeviceChanels( gd, id_param_0, id_param_1, id_param_2, id_param_3);
       return;
    }

    gd->GlobalPackedCounter++;
    if (  gd->GlobalPackedCounter > 150 ) gd->isDebugGyroModeInited = true;

    gd->OnlineValues[         0] = fValue[0];
    gd->OnlineValues[id_param_3] = fValue[1];

    // ------- Раскидываю по масивам параметры ------
    if ( gd->GyroMode == 3 || gd->GyroMode == 4 )
    {
        if ( gd->isDebugGyroModeInited == false ) return;

        for ( int i = 0; i < gd->ParametersCount; i++ ) gd->SummValues[i] += gd->OnlineValues[i];

        if ( ++ gd->CurrentSummationPoint < gd->SummationCount ) return;

        gd->CurrentSummationPoint = 0;
        for ( int i = 0; i < gd->ParametersCount; i++ )
        {
            gd->OnlineValues[i] =  gd->SummValues[i] * gd->SummationCount_invert;
            gd->SummValues  [i] = 0.0;
        }
    }

    // ----- Закидываю данные в колекцию -------
    for ( int i = 0; i < gd->ParametersCount; i ++)
    	gd->Storage->Items[i]->Add(gd->OnlineValues[i]);

    // --------
    gd->CountSavedPacked++;
    gd->SaveLastDataToStream();
    gd->isDataReady = true;                                                                                                
}
