//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGx_old.h"

//===========================================================================
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
/*
static unsigned char crc8_table[] =
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
*/
//===========================================================================
CCVGx_old::CCVGx_old()
{

  // ----- ������� �� ������� �������� � ����������� ������ ������ ���������� ------
    SamplingFreqsRate.Clear();
    SamplingFreqsRate.Add(0.2);
    SamplingFreqsRate.Add(0.4);
    SamplingFreqsRate.Add(0.5);
    SamplingFreqsRate.Add(1);
    SamplingFreqsRate.Add(5);
    SamplingFreqsRate.Add(10);
    SamplingFreqsRate.Add(20);
    SamplingFreqsRate.Add(50);
    SamplingFreqsRate.Add(100);
    SamplingFreqsRate.Add(200);
    SamplingFreqsRate.Add(300);
    SamplingFreqsRate.Add(600);

    SerialPort->BaudRate    = 115200;
    SerialPort->ByteSize    = 8;


    ExtendedParamCount     = 4;

   	if ( isDebugMode == true )
    {
	    ExtendedParamValues[0] = 4;
        ExtendedParamNames [0] = strdup("Gyro mode [0..4] (default_4) :");
    }
    else
    {
	    ExtendedParamValues[0] = 3;
 		ExtendedParamNames [0] = strdup("Gyro mode [1..3] (default_3):");
     }

    ExtendedParamValues[1] = 1;      ExtendedParamNames[1] = strdup("Controllers count:");
    ExtendedParamValues[2] = 1;      ExtendedParamNames[2] = strdup("Count gyro on the one controller:");
    ExtendedParamValues[3] = 10;     ExtendedParamNames[3] = strdup("Sampling frequency for mode [0..2]:");
    ExtendedParamValues[4] = 600;
    ExtendedParamValues[5] = 12;


    GyroMode                  = -1;
    ControllersCount          = -1;
    GyrosCountOnOneController = -1;
    SendValueType_to_gyro[0]  = -1;
    SendValueType_to_gyro[1]  = -1;

    isFirstThreadInput    = true;
    //isStorageInited       = false;
    isDebugGyroModeInited = false;
    OnlineCanalCountForOneGyro = 0;

    for ( int i = 0; i < 64; i++ )
        memset( BaseCanalsName[i], 0, CVGx_OLD_LOCAL_ARRAY_SIZE );

  // --------
    sprintf(BaseCanalsName[ 0], "GyroOut\0"        );
    sprintf(BaseCanalsName[ 1], "Temperature\0"    );
    sprintf(BaseCanalsName[ 2], "AntinodePeriod\0" );
    sprintf(BaseCanalsName[ 3], "ExcitationAmpl\0" );
    sprintf(BaseCanalsName[ 4], "QuadratureAmpl\0" );
    sprintf(BaseCanalsName[ 5], "QuadratureError\0");
    sprintf(BaseCanalsName[ 6], "CoriolisError\0"  );
    sprintf(BaseCanalsName[ 7], "XAmplitude\0"     );
    sprintf(BaseCanalsName[ 8], "YAmplitude\0"     );
    sprintf(BaseCanalsName[ 9], "XMean\0"          );
    sprintf(BaseCanalsName[10], "YMean\0"          );
    sprintf(BaseCanalsName[11], "GyroOut_RAW\0"    );
    sprintf(BaseCanalsName[12], "N_Excitation\0"   );

  // --------
    QueryPerformanceFrequency(&li_f);


    Parent_ThreadType = 2;

  // --------
    LoadFromRegistry("CVGx_old");
}

//===========================================================================
CCVGx_old::~CCVGx_old()
{
    SaveDataToRegistry("CVGx_old");
}

//===========================================================================
int  CCVGx_old::Start()
{
   // ----------
    SaveDataToRegistry("CVGx_old");

   // ----------
    GyroMode                  = ExtendedParamValues[0];
    ControllersCount          = ExtendedParamValues[1];
    GyrosCountOnOneController = ExtendedParamValues[2];

    DeviceFrequency_mode_1_2  = ExtendedParamValues[3];
    DeviceFrequency_mode_3_4  = ExtendedParamValues[4];

    PackedLength              = ExtendedParamValues[5];
    InfoPackedLength          = ExtendedParamValues[5];

    // ----- �������� ����� ����������� ���� ----
    if ( GyrosCountOnOneController < 1 || GyrosCountOnOneController > 3 )
    {
        MessageBoxA( fHandleParenWindow, "rus: ������� ���������� ���������� �� ����� ����������� �� �����.", "CVGCom - Error", MB_OK|MB_ICONERROR );
        return -1;
    }
    if ( GyroMode < 0 || GyroMode > 7 )
    {
        MessageBoxA( fHandleParenWindow, "rus: ( GyroMode >= 0 && GyroMode <= 6)", "CVGCom - Error", MB_OK|MB_ICONERROR );
        return -1;
    }

    if ( ( GyroMode == 3 || GyroMode == 4 ) && ControllersCount != 1 )
    {
        MessageBoxA( fHandleParenWindow, "rus: � ������ ����������� ������, ��������� �������� ������ � ����� ������������. ��������� ���������� ���������.", "CVGCom - Error", MB_OK|MB_ICONERROR );
         return -1;
    }

   // ----------
    isFirstThreadInput            = true;
    //isStorageInited               = false;
    isDebugGyroModeInited         = false;
    //GyrosCount                    = 1;

   // ----------
    SummationCount = DeviceFrequency_mode_3_4 / SamplingFreq;
    if ( SummationCount < 1 ) SummationCount = 1;
    SummationCount_invert = 1.0 / (double)SummationCount;
    CurrentSummationPoint = 0;

   // ----------
    Storage->file_Param.StorageT0[0] = SummationCount / (double) DeviceFrequency_mode_3_4;
    if ( GyroMode == 0 || GyroMode == 1 || GyroMode == 2 ) Storage->file_Param.StorageT0[0] = 1.0 / (double)DeviceFrequency_mode_1_2;


    // ---- ������ ������ ----
    OnlineCanalCountForOneGyro = ( GyroMode != 4 ) ? 2 : 12;
    Storage->SetItemsCount(ControllersCount * GyrosCountOnOneController * OnlineCanalCountForOneGyro);
    int  CanalsCounter = 0;
    char AdditionalControllerString[16];  memset(AdditionalControllerString, 0, 16);
    char AdditionalGyroString[16];        memset(AdditionalGyroString      , 0, 16);

    // ----- ���� �� ������������ ------
    for ( int i = 0; i < ControllersCount; i++ )
    {
        // ----- ����� ��������������� ��������� ������ ----
        if ( ControllersCount != 1 )
        {
            if ( GyrosCountOnOneController == 1 )
                 sprintf( AdditionalControllerString, "c%i_", i+1 );
            else sprintf( AdditionalControllerString, "c%i", i+1 );
        }
        // ----- ���� �� ���������� ------
        for ( int k = 0; k < GyrosCountOnOneController; k++ )
        {
            // ----- ����� ��������������� ��������� ������ ----
            if ( GyrosCountOnOneController != 1 )
                 sprintf( AdditionalGyroString, "g%i_", k+1 );

            for ( int z = 0; z < OnlineCanalCountForOneGyro; z++)
            {
               char StorageItemName[256]; memset( StorageItemName, 0, 256);
               sprintf(StorageItemName, "%s%s%s", AdditionalControllerString, AdditionalGyroString, BaseCanalsName[z] );

               Storage->Items[CanalsCounter++]->SetName(StorageItemName);
            }

        }
    }

   // ------- ������������ ������� ----------
     memset(SendValue1, 0, 256);
     memset(SendValue2, 0, 256);
     memset(SendValue3, 0, 256);
     SendValueType_to_gyro[0] = 2;
     SendValueType_to_gyro[1] = 2;
     for ( int ControllersCounter = 0; ControllersCounter < ControllersCount; ControllersCounter++ )
     {
         switch ( GyroMode )
         {
            case 0 : SendValue1[ControllersCounter] = 0x01;  // ----- request ----
            		 SendValue2[ControllersCounter] = 0x02;  // ----- reset integrator ----
                     SendValue3[ControllersCounter] = 0x03;  // ----- Calibrate ----
                     SendValueType_to_gyro[0] = 2;
                     break;

            case 5 : SendValue1[ControllersCounter] = 0x82; break;
            case 6 : SendValue1[ControllersCounter] = 0x42; break;
            case 7 : SendValue1[ControllersCounter] = 0x22; break;

            case 1 : SendValue1[ControllersCounter] = 0x10 + ControllersCounter; break;
            case 3 : SendValue1[ControllersCounter] = 0x20 + ControllersCounter; break;
            case 4 : SendValue1[ControllersCounter] = 0x70 + ControllersCounter; break;

            default : break; // ---- ����� ���� � ���, ��� ����������� �������� ������� --------
         }
     }

   // -------------
     li_freqCounter = li_f.QuadPart / (double)DeviceFrequency_mode_1_2;
     QueryPerformanceCounter(&li_q1);

   // -------------
    if ( CBaseDevice::Start() == -1 ) return -1;
    if ( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2; ;

    return 0;
}

//===========================================================================
void CCVGx_old::Stop()
{
  // ----- ������������ ������ ������ � � ��485 ----
    char SendVal = 0x40;
    DWORD  dWrite;
    if ( SerialPort->isOpen == true && GyroMode != 4)
        for ( int i = 0; i < 50; i++)
            WriteFile( SerialPort->hComm, &SendVal, 1, &dWrite, NULL);

  // -----
    CBaseDevice::Stop();
  // -----
//    if ( h_file_binlog != NULL) fclose(h_file_binlog); h_file_binlog = NULL;
}
/*
//===========================================================================
bool CCVGx_old::isWorkError( CCVGx_old *gd )
{
    try
    {
         if ( gd->SerialPort->hComm == NULL                 ) return false;
         if ( gd->SerialPort->hComm == INVALID_HANDLE_VALUE ) return false;
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
*/

//===========================================================================
void CCVGx_old::InitDeviceBeforeStart()
{
}

//===========================================================================
bool CCVGx_old::WriteCommand()
{
    DWORD  dWrite;
    DWORD  inCounter;

  // ------ ������ ----
    if ( ( GyroMode == 3 ||
           GyroMode == 4 ||
           GyroMode == 5 ||
           GyroMode == 6 ||
           GyroMode == 7 )
        && isFirstThreadInput == true )
    {
        isFirstThreadInput = false;
        inCounter = 0;
        dWrite    = 0;
        while ( dWrite == 0 && inCounter < 10 )
        {
            WriteFile( SerialPort->hComm, &SendValue1[0], 1, &dWrite, NULL);
            inCounter++;
        }
    }

  // ------ ������ �� �������  ----
    if ( GyroMode == 0 )
    {
        QueryPerformanceCounter(&li_q2);
        if ( li_q2.QuadPart - li_q1.QuadPart >= li_freqCounter  )
        {
	        li_q1.QuadPart = li_q2.QuadPart;

            if ( SendValueType_to_gyro[0] == 1 )
            {
				inCounter = 0;
                dWrite    = 0;
                while ( dWrite == 0 && inCounter < 10 )
                {
                 	WriteFile( SerialPort->hComm, &SendValue1[0], 1, &dWrite, NULL);
                    inCounter++;
                }
            }

            if ( SendValueType_to_gyro[0] == 2 )
            {
				inCounter = 0;
                dWrite    = 0;
                while ( dWrite == 0 && inCounter < 10 )
                {
                	WriteFile( SerialPort->hComm, &SendValue2[0], 1, &dWrite, NULL);
                    inCounter++;
                }
            }
            if ( SendValueType_to_gyro[0] == 3 )
            {
                WriteFile( SerialPort->hComm, &SendValue3[0], 1, &dWrite, NULL);
                Sleep(2000);
            }
            SendValueType_to_gyro[0] = SendValueType_to_gyro[1];
        }
    }

  // ------ ������ �� �������  ----
    if ( GyroMode == 1 )
    {
        QueryPerformanceCounter(&li_q2);
        if ( li_q2.QuadPart - li_q1.QuadPart >= li_freqCounter )
        {
            li_q1.QuadPart = li_q2.QuadPart;
            WriteFile( SerialPort->hComm, &SendValue1[0], 1, &dWrite, NULL);
        }
    }

    return true;
}

//===========================================================================
void CCVGx_old::DeCompositeData()
{
}

//===========================================================================
void CCVGx_old::RealTimeProcessing(double *in_out_array)
{
}

/*
//===========================================================================
bool CCVGx_old::isReadPackedCS_OK( CCVGx_old *gd )
{
    DWORD         dRead;
//    DWORD         dwErrors;

//  // ---- ��� "��" -----
    ReadFile( SerialPort->hComm, &com_buffer[0], 1, &dRead, 0 );
    if ( dRead             != 1    ) return false;
    if ( com_buffer[0] != 0xAA ) return false;

  // ---- ���� �����, ����� ---
    ReadFile( SerialPort->hComm, &com_buffer[1], 11, &dRead, 0 );

    unsigned char  crc8    = 0x0;
    unsigned char *buff    = &com_buffer[1];
    unsigned char  base_cs =  com_buffer[11];

    for ( int i = 0; i < 10; i++) crc8 = crc8_table[ ( crc8 ^ (unsigned char)buff[i] ) ];

    if ( (unsigned char)crc8 != (unsigned char)base_cs)
    {
        CountErrorPacked++;
        return false;
    }
    return true;
}

//===========================================================================
void CCVGx_old::CallBackFunction(void* CS, void* pUserData)
{
  // ----------
    CCVGx_old *gd = (CCVGx_old *)pUserData;

  // ---------- �������� �� NULL ----
    if ( isWorkError() == false ) return;

  // ---------- ������� ������� � ��� ���� ---
    WriteCommand( gd );

  // ------- ��������, ��������� �� � ����� 12 ���� ? -----
    COMSTAT lCOMSTAT;
    DWORD   dwErrors;
    ClearCommError( SerialPort->hComm, &dwErrors, &lCOMSTAT );
    if ( lCOMSTAT.cbInQue < 12 )
    {
       //TempParam++;
       Sleep(5);
       return;
    }
    
  // ---------- ��������� ������ � �������� �� ----
    if ( isReadPackedCS_OK( gd ) == false )
    {
    	return;
    }

    // ---- ����������� ������ ----
        float fValue[2];
        //int   id_param_0 = ( (unsigned char)com_buffer[1]       & 0x0F ); // ---- ����� ������ �� ����������� -----
        //int   id_param_1 = (((unsigned char)com_buffer[1] >> 4) & 0x0F ); // ---- ����� ����������� ----
        int   id_param_2 = ( (unsigned char)com_buffer[2]       & 0x0F ); // ---- ����� ��������� �� ������� ������ -----
        int   id_param_3 = (((unsigned char)com_buffer[2] >> 4) & 0x0F ); // ---- ����� ��������� �� ������� ������
        memcpy(&fValue[0], &com_buffer[3], 4);
        memcpy(&fValue[1], &com_buffer[7], 4);

    // -------- �������� �� ������� ������ ------

       if ( GyroMode == 3 || GyroMode == 4 )
       {
            if ( fValue[0] > 22500 || fValue[0] < -22500 || fValue[1] > 22500 || fValue[1] < -22500 )
            {
                if ( isDebugMode == true )
                {
                    fwrite(com_buffer, 1, 12, h_file_binlog);
                    fflush(h_file_binlog);
                    CountBadValues++;
                }
                return;
            }
       }

// pipec: ���� ���������� ��������������� ���������� ----
    OnlineValues[          0 ] = fValue[0];
    OnlineValues[ id_param_3 ] = fValue[1];

    //------ �������� �� ������ ������� ������, ( ������ �� ������ � 4 ������, � ������ � 3 ������)
    if ( GyroMode == 4 && GlobalPackedCounter > 120 && GlobalPackedCounter < 320)
    {
        if ( OnlineValues[ 2 ] == 0.0 &&
        	 OnlineValues[ 3 ] == 0.0 &&
        	 OnlineValues[ 4 ] == 0.0 &&
        	 OnlineValues[ 5 ] == 0.0 &&
        	 OnlineValues[ 6 ] == 0.0 &&
        	 OnlineValues[ 7 ] == 0.0 &&
        	 OnlineValues[ 8 ] == 0.0 ) isErrorSatrtGyro = true;
    }

    // --- ����� ����� ������� ��������� ��� ����� ������ ----------
    GlobalPackedCounter++;
    if ( isDebugGyroModeInited == false && GyroMode >= 0 && GyroMode <= 2 )
    {
        isDebugGyroModeInited = true;
        return;
    }
    if ( isDebugGyroModeInited == false && GyroMode == 4 )
    {
        if ( GlobalPackedCounter > 20 * 1 ) isDebugGyroModeInited = true;
        if ( id_param_2 != 0 && Storage->Items[0]->ValuesCount <= 1 )
            Storage->Items[0]->SetName(BaseCanalsName[id_param_2]);
            
        return;
    }

    // ------- ���������� �� ������� ��������� ------
    if ( GyroMode == 3 || GyroMode == 4 )
    {
        for ( int i = 0; i < Storage->ItemsCount; i++ ) SummValues[i] += OnlineValues[i];

        if ( ++ CurrentSummationPoint < SummationCount ) return;

        CurrentSummationPoint = 0;
        for ( int i = 0; i < Storage->ItemsCount; i++ )
        {
            OnlineValues[i] =  SummValues[i] * SummationCount_invert;
            SummValues  [i] = 0.0;
        }
    }

    // ----- ��������� ������ � �������� -------
    for ( int i = 0; i < Storage->ItemsCount; i ++)
    	Storage->Items[i]->Add(OnlineValues[i]);

    // --------
    CountSavedPacked++;
    SaveLastDataToStream( &h_file[0], Storage );
    isDataReady = true;
}
*/
