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
int errs[4];

/* 
Когда компилятор встречает такую строку:
   #pragma chMSG(Fix this later)

Он выводит такую строку:

  c:\CD\CmnHdr.h(82):Fix this later

Вы можете свободно прыгнуть на указанную строку в коде и изучить окружающий код
*/

void CCVGxRSSwithcer::SetComand( unsigned char *inBuf,  char i1, char i2, char i3, char i4, char i5, char i6 )
{
    inBuf[0] = i1;
    inBuf[1] = i2;
    inBuf[2] = i3;
    inBuf[3] = i4;
    inBuf[4] = i5;
    inBuf[5] = i6;
}

void CCVGxRSSwithcer::SetComand( unsigned char *inBuf, char i1, char i2, char i3, char i4, char i5, char i6, char i7 )
{
    inBuf[0] = i1;
    inBuf[1] = i2;
    inBuf[2] = i3;
    inBuf[3] = i4;
    inBuf[4] = i5;
    inBuf[5] = i6;                                                              
    inBuf[6] = i7;
}

CCVGxRSSwithcer::CCVGxRSSwithcer()
{
    SerialPort->BaudRate    = 921600;//115200;
    SerialPort->ByteSize    = 8;
    SerialPort->isAsyncWork = true;
    SerialPort->ReadIntervalTimeout       = MAXDWORD;
    SerialPort->ReadTotalTimeoutConstant  = 0;
    SerialPort->WriteTotalTimeoutConstant = 0;

    errs[0] = errs[1] = errs[2] = errs[3] = 0; 

  // ---------------
    SetComand(&SwitchCommand_Reset[ 0][0], 0x40, 0x01, 0x00, 0x00, 0x44, 0x24);
    SetComand(&SwitchCommand_Reset[ 1][0], 0x41, 0x01, 0x00, 0x00, 0x45, 0xD8);
    SetComand(&SwitchCommand_Reset[ 2][0], 0x42, 0x01, 0x00, 0x00, 0x45, 0x9C);
    SetComand(&SwitchCommand_Reset[ 3][0], 0x43, 0x01, 0x00, 0x00, 0x44, 0x60);
    SetComand(&SwitchCommand_Reset[ 4][0], 0x44, 0x01, 0x00, 0x00, 0x45, 0x14);
    SetComand(&SwitchCommand_Reset[ 5][0], 0x45, 0x01, 0x00, 0x00, 0x44, 0xE8);
    SetComand(&SwitchCommand_Reset[ 6][0], 0x46, 0x01, 0x00, 0x00, 0x44, 0xAC);
    SetComand(&SwitchCommand_Reset[ 7][0], 0x47, 0x01, 0x00, 0x00, 0x45, 0x50);
    SetComand(&SwitchCommand_Reset[ 8][0], 0x48, 0x01, 0x00, 0x00, 0x46, 0x44);
    SetComand(&SwitchCommand_Reset[ 9][0], 0x49, 0x01, 0x00, 0x00, 0x47, 0xB8);
    SetComand(&SwitchCommand_Reset[10][0], 0x4A, 0x01, 0x00, 0x00, 0x47, 0xFC);
    SetComand(&SwitchCommand_Reset[11][0], 0x4B, 0x01, 0x00, 0x00, 0x46, 0x00);
    SetComand(&SwitchCommand_Reset[12][0], 0x4C, 0x01, 0x00, 0x00, 0x47, 0x74);
    SetComand(&SwitchCommand_Reset[13][0], 0x4D, 0x01, 0x00, 0x00, 0x46, 0x88);
    SetComand(&SwitchCommand_Reset[14][0], 0x4E, 0x01, 0x00, 0x00, 0x46, 0xCC);
    SetComand(&SwitchCommand_Reset[15][0], 0x4F, 0x01, 0x00, 0x00, 0x47, 0x30);
/*
    SetComand(&SwitchCommand_StartGyro[ 0][0], 0x40, 0x05, 0x00, 0x01, 0x06, 0xA4, 0x91);
    SetComand(&SwitchCommand_StartGyro[ 1][0], 0x41, 0x05, 0x00, 0x01, 0x06, 0x99, 0x51);
    SetComand(&SwitchCommand_StartGyro[ 2][0], 0x42, 0x05, 0x00, 0x01, 0x06, 0xDD, 0x51);
    SetComand(&SwitchCommand_StartGyro[ 3][0], 0x43, 0x05, 0x00, 0x01, 0x06, 0xE0, 0x91);
    SetComand(&SwitchCommand_StartGyro[ 4][0], 0x44, 0x05, 0x00, 0x01, 0x06, 0x55, 0x51);
    SetComand(&SwitchCommand_StartGyro[ 5][0], 0x45, 0x05, 0x00, 0x01, 0x06, 0x68, 0x91);
    SetComand(&SwitchCommand_StartGyro[ 6][0], 0x46, 0x05, 0x00, 0x01, 0x06, 0x2C, 0x91);
    SetComand(&SwitchCommand_StartGyro[ 7][0], 0x47, 0x05, 0x00, 0x01, 0x06, 0x11, 0x51);
    SetComand(&SwitchCommand_StartGyro[ 8][0], 0x48, 0x05, 0x00, 0x01, 0x06, 0x45, 0x50);
    SetComand(&SwitchCommand_StartGyro[ 9][0], 0x49, 0x05, 0x00, 0x01, 0x06, 0x78, 0x90);
    SetComand(&SwitchCommand_StartGyro[10][0], 0x4A, 0x05, 0x00, 0x01, 0x06, 0x3C, 0x90);
    SetComand(&SwitchCommand_StartGyro[11][0], 0x4B, 0x05, 0x00, 0x01, 0x06, 0x01, 0x50);
    SetComand(&SwitchCommand_StartGyro[12][0], 0x4C, 0x05, 0x00, 0x01, 0x06, 0xB4, 0x90);
    SetComand(&SwitchCommand_StartGyro[13][0], 0x4D, 0x05, 0x00, 0x01, 0x06, 0x89, 0x50);
    SetComand(&SwitchCommand_StartGyro[14][0], 0x4E, 0x05, 0x00, 0x01, 0x06, 0xCD, 0x50);
    SetComand(&SwitchCommand_StartGyro[15][0], 0x4F, 0x05, 0x00, 0x01, 0x06, 0xF0, 0x90);
*/
    SetComand(&SwitchCommand_StartGyro[ 0][0], 0x40, 0x05, 0x00, 0x01, 0x70, 0x25, 0x77);
    SetComand(&SwitchCommand_StartGyro[ 1][0], 0x41, 0x05, 0x00, 0x01, 0x70, 0x18, 0xB7);
    SetComand(&SwitchCommand_StartGyro[ 2][0], 0x42, 0x05, 0x00, 0x01, 0x70, 0x5C, 0xB7);
    SetComand(&SwitchCommand_StartGyro[ 3][0], 0x43, 0x05, 0x00, 0x01, 0x70, 0x61, 0x77);
    SetComand(&SwitchCommand_StartGyro[ 4][0], 0x44, 0x05, 0x00, 0x01, 0x70, 0xD4, 0xB7);
    SetComand(&SwitchCommand_StartGyro[ 5][0], 0x45, 0x05, 0x00, 0x01, 0x70, 0xE9, 0x77);
    SetComand(&SwitchCommand_StartGyro[ 6][0], 0x46, 0x05, 0x00, 0x01, 0x70, 0xAD, 0x77);
    SetComand(&SwitchCommand_StartGyro[ 7][0], 0x47, 0x05, 0x00, 0x01, 0x70, 0x90, 0xB7);
    SetComand(&SwitchCommand_StartGyro[ 8][0], 0x48, 0x05, 0x00, 0x01, 0x70, 0xC4, 0xB6);
    SetComand(&SwitchCommand_StartGyro[ 9][0], 0x49, 0x05, 0x00, 0x01, 0x70, 0xF9, 0x76);
    SetComand(&SwitchCommand_StartGyro[10][0], 0x4A, 0x05, 0x00, 0x01, 0x70, 0xBD, 0x76);
    SetComand(&SwitchCommand_StartGyro[11][0], 0x4B, 0x05, 0x00, 0x01, 0x70, 0x80, 0xB6);
    SetComand(&SwitchCommand_StartGyro[12][0], 0x4C, 0x05, 0x00, 0x01, 0x70, 0x35, 0x76);
    SetComand(&SwitchCommand_StartGyro[13][0], 0x4D, 0x05, 0x00, 0x01, 0x70, 0x08, 0xB6);
    SetComand(&SwitchCommand_StartGyro[14][0], 0x4E, 0x05, 0x00, 0x01, 0x70, 0x4C, 0xB6);
    SetComand(&SwitchCommand_StartGyro[15][0], 0x4F, 0x05, 0x00, 0x01, 0x70, 0x71, 0x76);

    SetComand(&SwitchCommand_ReadGyroData[ 0][0], 0x40, 0x03, 0x00, 0x00, 0xE5, 0xE4);
    SetComand(&SwitchCommand_ReadGyroData[ 1][0], 0x41, 0x03, 0x00, 0x00, 0xE4, 0x18);
    SetComand(&SwitchCommand_ReadGyroData[ 2][0], 0x42, 0x03, 0x00, 0x00, 0xE4, 0x5C);
    SetComand(&SwitchCommand_ReadGyroData[ 3][0], 0x43, 0x03, 0x00, 0x00, 0xE5, 0xA0);
    SetComand(&SwitchCommand_ReadGyroData[ 4][0], 0x44, 0x03, 0x00, 0x00, 0xE4, 0xD4);
    SetComand(&SwitchCommand_ReadGyroData[ 5][0], 0x45, 0x03, 0x00, 0x00, 0xE5, 0x28);
    SetComand(&SwitchCommand_ReadGyroData[ 6][0], 0x46, 0x03, 0x00, 0x00, 0xE5, 0x6C);
    SetComand(&SwitchCommand_ReadGyroData[ 7][0], 0x47, 0x03, 0x00, 0x00, 0xE4, 0x90);
    SetComand(&SwitchCommand_ReadGyroData[ 8][0], 0x48, 0x03, 0x00, 0x00, 0xE7, 0x84);
    SetComand(&SwitchCommand_ReadGyroData[ 9][0], 0x49, 0x03, 0x00, 0x00, 0xE6, 0x78);
    SetComand(&SwitchCommand_ReadGyroData[10][0], 0x4A, 0x03, 0x00, 0x00, 0xE6, 0x3C);
    SetComand(&SwitchCommand_ReadGyroData[11][0], 0x4B, 0x03, 0x00, 0x00, 0xE7, 0xC0);
    SetComand(&SwitchCommand_ReadGyroData[12][0], 0x4C, 0x03, 0x00, 0x00, 0xE6, 0xB4);
    SetComand(&SwitchCommand_ReadGyroData[13][0], 0x4D, 0x03, 0x00, 0x00, 0xE7, 0x48);
    SetComand(&SwitchCommand_ReadGyroData[14][0], 0x4E, 0x03, 0x00, 0x00, 0xE7, 0x0C);
    SetComand(&SwitchCommand_ReadGyroData[15][0], 0x4F, 0x03, 0x00, 0x00, 0xE6, 0xF0);

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

  // ------
    ExtendedParamCount     = 4;
    ExtendedParamValues[0] = 4;      ExtendedParamNames[0] = ( isDebugMode == true ) ? strdup("Gyro mode [1..4]:") : strdup("Gyro mode [1..3]:");
    ExtendedParamValues[1] = 1;      ExtendedParamNames[1] = strdup("Controllers count:");
    ExtendedParamValues[2] = 1;      ExtendedParamNames[2] = strdup("Count gyro on the one controller:");
    ExtendedParamValues[3] = 10;     ExtendedParamNames[3] = strdup("Sampling frequency for mode [1],[2]:");
    ExtendedParamValues[4] = 600;
    ExtendedParamValues[5] = 12;

    isFirstThreadInput    = true;
    isStorageInited       = false;
    isDebugGyroModeInited = false;

  // --------
    QueryPerformanceFrequency(&li_f);

    LoadFromRegistry("CVGxRSSwithcer");
}

//===========================================================================
CCVGxRSSwithcer::~CCVGxRSSwithcer()
{
    SaveDataToRegistry("CVGxRSSwithcer");
}

//===========================================================================
int CCVGxRSSwithcer::Start()
{
   // ----------
    SaveDataToRegistry("CVGxRSSwithcer");

   // ----------
    GyroMode                  = 4;//ExtendedParamValues[0];
    ControllersCount          = 1;//ExtendedParamValues[1]; // ---- Количество Контроллеров ( нееее свитча ) ----
    GyrosCountOnOneController = 1;

    DeviceFrequency_mode_1_2  = ExtendedParamValues[3];
    DeviceFrequency_mode_3_4  = ExtendedParamValues[4];

    PackedLength              = ExtendedParamValues[5];
    InfoPackedLength          = ExtendedParamValues[5];
   // ----------
   
    isFirstThreadInput            = true;

    isStorageInited               = false;
    isDebugGyroModeInited         = false;

    SummationCount                = 600;
    SummationCount_invert         = 1.0 / (double)SummationCount;
    CurrentSummationPoint         = 0;

    Storage->file_Param.StorageT0[0] = SummationCount / (double) DeviceFrequency_mode_3_4;
    for ( int i = 0; i < 16; i++ )
    {
        StorageSW[i]->file_Param.StorageT0[0] = Storage->file_Param.StorageT0[0];

        SwitchValues[i].com_buffer_length  = 0;
        SwitchValues[i].gyro_buffer_length = 0;

        memset( SwitchValues[i].com_buffer  , 0, 16384 );
        memset( SwitchValues[i].gyro_buffer  , 0, 16384 );
        memset( SwitchValues[i].SummValues  , 0, sizeof(float)*CVGxSW_LOCAL_ARRAY_SIZE );
        memset( SwitchValues[i].OnlineValues, 0, sizeof(float)*CVGxSW_LOCAL_ARRAY_SIZE );

        SwitchValues[i].CurrentSummationPoint = 0;
    }

    Storage->SetItemsCount(Switch_count * 3);

    for ( int i = 0; i < Switch_count; i++ )
    {
        AnsiString as1 = AnsiString(StorageSW[i]->file_Param.DeviceNumber) + "  GyroOut\0";
        AnsiString as2 = AnsiString(StorageSW[i]->file_Param.DeviceNumber) + "  Temperature\0";
        AnsiString as3 = AnsiString(StorageSW[i]->file_Param.DeviceNumber) + "  AntinodePeriod\0";

        Storage->Items[i*3+0]->SetName(as1.c_str());
        Storage->Items[i*3+1]->SetName(as2.c_str());
        Storage->Items[i*3+2]->SetName(as3.c_str());

        StorageSW[i]->SetItemsCount(12);
        // ---------- Выставка имен каналов ---------
        StorageSW[i]->Items[ 0]->SetName("GyroOut\0"        );
        StorageSW[i]->Items[ 1]->SetName("Temperature\0"    );
        StorageSW[i]->Items[ 2]->SetName("AntinodePeriod\0" );
        StorageSW[i]->Items[ 3]->SetName("ExcitationAmpl\0" );
        StorageSW[i]->Items[ 4]->SetName("QuadratureAmpl\0" );
        StorageSW[i]->Items[ 5]->SetName("QuadratureError\0");
        StorageSW[i]->Items[ 6]->SetName("CoriolisError\0"  );
        StorageSW[i]->Items[ 7]->SetName("XAmplitude\0"     );
        StorageSW[i]->Items[ 8]->SetName("YAmplitude\0"     );
        StorageSW[i]->Items[ 9]->SetName("XMean\0"          );
        StorageSW[i]->Items[10]->SetName("YMean\0"          );
        StorageSW[i]->Items[11]->SetName("GyroOut_RAW\0"    );
    }

   // ------- Формирование Команды ----------
   // ******* 
   // ******* в Режиме свитча команду формировать низзя, потомучто гирики уже запущены при чеке Свитчей
   // *******
//     memset(SendValue, 0, 256);
//     for ( int Counter = 0; Counter < ControllersCount; Counter++ )
//     {
//         switch ( GyroMode )
//         {
//            case 1 : SendValue[Counter] = 0x10 + Counter; break;
//            case 3 : SendValue[Counter] = 0x20 + Counter; break;
//            case 4 : SendValue[Counter] = 0x70 + Counter; break;
//
//            default : break; // ---- вывод инфы о том, что неправильно заданные режимым --------
//         }
//     }

   // -------------
    if ( CBaseDevice::Start() == -1 ) return -1;

    for ( int i = 0; i < Switch_count; i++ )
        if( OpenDataSaveFile( &h_file[i], StorageSW[i] ) == -1 ) return -2;

   // --------- Создаем поток -----------
    mThread = new CThread(this);
    mThread->Create(false, CallBackFunction, 0);

    return 0;
}

//===========================================================================
void CCVGxRSSwithcer::Stop()
{
  // ----- Останавливаю выдачу данных в в РС485 ----
    char SendVal = 0x40;
    DWORD  dWrite;
    if ( SerialPort->isOpen == true && GyroMode != 4)
        for ( int i = 0; i < 50; i++)
            WriteFile( SerialPort->hComm, &SendVal, 1, &dWrite, NULL);

  // -----
    CBaseDevice::Stop();
  // -----
}
/*
//===========================================================================
bool CCVGxRSSwithcer::isWorkError( CCVGxRSSwithcer *gd )
{
    try
    {
         if ( gd->SerialPort->hComm == NULL                 ) return false;
         if ( gd->SerialPort->hComm == INVALID_HANDLE_VALUE ) return false;
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
*/
//===========================================================================
bool CCVGxRSSwithcer::isReadPackedCS_OK( CCVGxRSSwithcer *gd )
{
    DWORD         dRead;
//    DWORD         dwErrors;

//  // ---- Ищу "АА" -----
    ReadFile( gd->SerialPort->hComm, &gd->com_buffer[0], 1, &dRead, 0 );
    if ( dRead             != 1    ) return false;
    if ( gd->com_buffer[0] != 0xAA ) return false;
/*
  // ---- Если нашли , тогда ---
    ReadFile( gd->SerialPort->hComm, &gd->com_buffer[1], 11, &dRead, 0 );

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
    ReadFile( gd->SerialPort->hComm, &gd->com_buffer[1], 11, &dRead, 0 );
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
    ReadFile( gd->SerialPort->hComm, &gd->com_buffer[1], 12, &dRead, 0 );

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

/************************************************
 *	MDBS CRC
 *		MDBS CRC
 *			Parameters:		None
 *			Return Value:	None
 ************************************************/
unsigned short int MDBS_CRC(unsigned char* pBuf, unsigned short int Len)
{
    unsigned short int i, j, Crc = 0xFFFF;
	for ( j = 0; j < Len; j++)
	{
		Crc ^= (unsigned short int)pBuf[j];

		for (i = 0; i < 8; i++)
			Crc = (Crc & 1) ? (Crc >>= 1, Crc ^= 0xA001) : (Crc >>= 1);
	};

	return (Crc);
};

//===========================================================================
bool CCVGxRSSwithcer::isCRC_SwitchOk( unsigned char *inBuff, unsigned short int inBuffLength )
{
    if ( inBuffLength < 3 || inBuffLength > 1000 ) return false;

    unsigned short int cur_crc = MDBS_CRC( inBuff, inBuffLength - 2 );
    unsigned short int base_cs;
    memcpy( &base_cs, &inBuff[ inBuffLength - 2 ], 2 );

    return base_cs == cur_crc;
}

//===========================================================================
void CCVGxRSSwithcer::CallBackFunction(void* CS, void* pUserData)
{
  // ----------
    CCVGxRSSwithcer *gd = (CCVGxRSSwithcer *)pUserData;

    // --------- Проверка на NULL ----
    if ( gd->isWorkError( gd ) == false ) return;

    // ----------
    bool isWasCRCError = false;
    for ( int i = 0; i < gd->Switch_count; i++ )
    {
        gd->SerialPort->WriteCommAsync(gd->SwitchCommand_ReadGyroData[gd->Switch_indexes[i]], 6);
        if ( gd->SerialPort->ReadCommAsync(4, 10) == false )
        {
            PurgeComm( gd->SerialPort->hComm, PURGE_TXABORT | PURGE_RXABORT | PURGE_TXCLEAR | PURGE_RXCLEAR );
            errs[0]++;
            isWasCRCError = true;
            continue;
        }
        if (gd->SerialPort->async_com_buffer[1] == 0x83 )
        {
            PurgeComm( gd->SerialPort->hComm, PURGE_TXABORT | PURGE_RXABORT | PURGE_TXCLEAR | PURGE_RXCLEAR );
            errs[1]++;
            isWasCRCError = true;
            continue;
        }
        unsigned short int pack_len = (gd->SerialPort->async_com_buffer[2] << 8) | gd->SerialPort->async_com_buffer[3];
        memcpy(&gd->SwitchValues[i].com_buffer[0], gd->SerialPort->async_com_buffer, gd->SerialPort->async_com_buffer_len);

        if ( gd->SerialPort->ReadCommAsync(pack_len + 2, 10) == false )
        {
            PurgeComm( gd->SerialPort->hComm, PURGE_TXABORT | PURGE_RXABORT | PURGE_TXCLEAR | PURGE_RXCLEAR );
            errs[2]++;
            isWasCRCError = true;
            continue;
        }

        memcpy(&gd->SwitchValues[i].com_buffer[4], gd->SerialPort->async_com_buffer, gd->SerialPort->async_com_buffer_len);

        gd->SwitchValues[i].com_buffer_length = gd->SerialPort->async_com_buffer_len + 4;
        if ( gd->isCRC_SwitchOk( gd->SwitchValues[i].com_buffer, gd->SwitchValues[i].com_buffer_length ) == false )
        {
            PurgeComm( gd->SerialPort->hComm, PURGE_TXABORT | PURGE_RXABORT | PURGE_TXCLEAR | PURGE_RXCLEAR );
            errs[3]++;
            isWasCRCError = true;
            continue;
        }

        /*
        // ---- Посылка команды в Ком порт ----
        gd->SwitchValues[i].com_buffer_length = gd->SerialPort->RSSwitch_ReadWrite(gd->SwitchCommand_ReadGyroData[gd->Switch_indexes[i]], 6, gd->SwitchValues[i].com_buffer);

        // ---- Если контрольная сумма, не правильная ----
        if ( gd->isCRC_SwitchOk(gd->SwitchValues[i].com_buffer, gd->SwitchValues[i].com_buffer_length) == false ) isWasCRCError = true;

        // ---- Если пришло 6 байт, значит ошибка ( гирик остановился) -----
        if ( gd->SwitchValues[i].com_buffer_length == 6 ) isWasCRCError = true;
        */
    }
/*
for ( int i = 0; i < gd->Switch_count; i++ )
   gd->Storage->Items[i]->Add(gd->SwitchValues[i].com_buffer_length);

if ( isWasCRCError == true ) gd->CountErrorPacked++;

gd->TempParam++;
gd->isDataReady = true;
return;
*/

    // ---------- если бы хотя бы по одному была ошибка тогда вываливаемся из цикла ----
    if ( isWasCRCError == true )
    {
        gd->CountErrorPacked++;
        return;
    }

    // ---- Копирую полученную информацию в Базовые буфера ----
    // ---- Копирование по базовым буферам ----
    //for ( int i = 0; i < 1; i++ )
    for ( int i = 0; i < gd->Switch_count; i++ )
    {
        //memcpy(&gd->SwitchValues[i].gyro_buffer[gd->SwitchValues[i].gyro_buffer_length], &gd->SwitchValues[i].com_buffer[4], gd->SwitchValues[i].com_buffer_length - 6);
        //gd->SwitchValues[i].gyro_buffer_length += gd->SwitchValues[i].com_buffer_length;
        memcpy(&gd->SwitchValues[i].gyro_buffer[0], &gd->SwitchValues[i].com_buffer[4], gd->SwitchValues[i].com_buffer_length - 6);
        gd->SwitchValues[i].gyro_buffer_length = gd->SwitchValues[i].com_buffer_length;
    }

    // ---- Расшифровка ----
    //for ( int i = 0; i < 1; i++ )
    for ( int i = 0; i < gd->Switch_count; i++ )
    {
        int cur_buf_pos = 0;
        unsigned char *buff = gd->SwitchValues[i].gyro_buffer;
        while ( cur_buf_pos <= gd->SwitchValues[i].gyro_buffer_length - 12)
        {
            if ( buff[cur_buf_pos] != 0xAA )
            {
                cur_buf_pos ++;
                continue;
            }
            // ====================
            // ====================  Проверка CRC - от гирика 
            // ====================
            unsigned char  crc8    = 0x0;
            for ( int k = 1; k < 11; k++) crc8 = dscrc_table[ ( crc8 ^ (unsigned char)buff[cur_buf_pos + k] ) ];
            if ( (unsigned char)crc8 != (unsigned char)buff[ cur_buf_pos + 11 ])
            {
                cur_buf_pos ++;
                continue;
            }
            // ====================
            // ====================   Расшифровка пакета
            // ====================
            float fValue[2];
            int   id_param_3 = (((unsigned char)buff[cur_buf_pos + 2] >> 4) & 0x0F ); // ---- Номер параметра по второму флоату
            memcpy(&fValue[0], &buff[cur_buf_pos + 3], 4);
            memcpy(&fValue[1], &buff[cur_buf_pos + 7], 4);

            // -------- Проверка на збойные пакеты ------
            if ( fValue[0] > 10000 || fValue[0] < -10000 || fValue[1] > 10000 || fValue[1] < -10000 )
            {
                cur_buf_pos ++;
                gd->CountBadValues++;
                continue;
            }

            // -----
            cur_buf_pos += 12;

            gd->SwitchValues[i].OnlineValues[         0] = fValue[0];
            gd->SwitchValues[i].OnlineValues[id_param_3] = fValue[1];

            // -----
            //if ( i == 0 )
            //{
            //    gd->GlobalPackedCounter++;
            //    if ( gd->GlobalPackedCounter > 20 * 1 ) gd->isDebugGyroModeInited = true;
            //}

            // ----- Сумирование ----
            for ( int k = 0; k < gd->StorageSW[i]->ItemsCount; k++ )
                gd->SwitchValues[i].SummValues[k] += gd->SwitchValues[i].OnlineValues[k];

            // ----- СЕКУНДНАЯ ПРОВЕРКА ------
            // ----- Распиховка данных ------
            if ( ++ gd->SwitchValues[i].CurrentSummationPoint >= gd->SummationCount )// * 0.01
            {

                if ( gd->isDebugGyroModeInited == true )
                {
                    gd->Storage->Items[i*3+0]->Add( gd->SwitchValues[i].SummValues[0] * gd->SummationCount_invert );
                    gd->Storage->Items[i*3+1]->Add( gd->SwitchValues[i].SummValues[1] * gd->SummationCount_invert );
                    gd->Storage->Items[i*3+2]->Add( gd->SwitchValues[i].SummValues[2] * gd->SummationCount_invert );
                }

                    for ( int k = 0; k < gd->StorageSW[i]->ItemsCount; k++ )
                    {
                        if ( gd->isDebugGyroModeInited == true )
                        	gd->StorageSW[i]->Items[k]->Add(gd->SwitchValues[i].SummValues[k] * gd->SummationCount_invert);

                        gd->SwitchValues[i].SummValues  [k] = 0.0;
                    }
                    // ----- Пишу данные, в файл -----
                    if ( gd->isDebugGyroModeInited == true )
                    	gd->SaveLastDataToStream( &gd->h_file[i], gd->StorageSW[i] );

                    gd->SwitchValues[i].CurrentSummationPoint = 0;
                	if ( i == gd->Switch_count - 1 ) gd->isDebugGyroModeInited = true;
            }
            // -----
        }
        // ----- Переношу остальную не обработанную информацию ------
        //memmove( gd->SwitchValues[i].gyro_buffer, &gd->SwitchValues[i].gyro_buffer[cur_buf_pos], gd->SwitchValues[i].gyro_buffer_length - cur_buf_pos );
        //gd->SwitchValues[i].gyro_buffer_length = gd->SwitchValues[i].gyro_buffer_length - cur_buf_pos;
        gd->SwitchValues[i].gyro_buffer_length = 0;
    }

    gd->GlobalPackedCounter++;
    gd->isDataReady = true;
}


