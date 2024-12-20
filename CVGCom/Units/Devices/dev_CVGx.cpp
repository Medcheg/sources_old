//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGx.h"

//===========================================================================
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
CCVGx::CCVGx()
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

  // --------
    for ( int i = 0; i < 64; i++ )
        memset( BaseCanalsName[i], 0, sizeof(BaseCanalsName[i]) );

  // --------
    sprintf(BaseCanalsName[ 0], "GyroOut\0"        );
    sprintf(BaseCanalsName[ 1], "Temperature\0"    );
    sprintf(BaseCanalsName[ 2], "Frequency\0" );
    sprintf(BaseCanalsName[ 3], "ExcitationAmpl\0" );
    sprintf(BaseCanalsName[ 4], "QuadratureAmpl\0" );
    sprintf(BaseCanalsName[ 5], "RAW_GyroOut\0");
    sprintf(BaseCanalsName[ 6], "RAW_ExcitationAmpl\0");
    sprintf(BaseCanalsName[ 7], "RAW_QuadratureAmpl\0");
    sprintf(BaseCanalsName[ 8], "GyroOut_corr_st1\0");
    sprintf(BaseCanalsName[ 9], "XAmplitude\0");
    sprintf(BaseCanalsName[10], "YAmplitude\0");
    sprintf(BaseCanalsName[11], "XPhase\0");
    sprintf(BaseCanalsName[12], "YPhase\0");
    sprintf(BaseCanalsName[13], "Error_(Coriolis)\0");
    sprintf(BaseCanalsName[14], "Error_(Quadrature)\0");
    sprintf(BaseCanalsName[15], "Error_(Frequency)\0");

  // --------

    Parent_ThreadType = 2;

  // --------
    LoadFromRegistry("CVGx");
}

//===========================================================================
CCVGx::~CCVGx()
{
    SaveDataToRegistry("CVGx");
}

//===========================================================================
int CCVGx::Start()
{
   // ----------
    SaveDataToRegistry("CVGx");

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
    OnlineCanalCountForOneGyro = ( GyroMode != 4 ) ? 2 : 16;
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

   // --------------- Debug File ---------------
    return 0;
}

//===========================================================================
void CCVGx::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVGx::InitDeviceBeforeStart()
{
}

//===========================================================================
bool CCVGx::WriteCommand()
{
    DWORD  dWrite, dRead ;
    DWORD  inCounter;
    char   cVal;
    bool   b_result;

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
        dRead     = 0;

        //while ( /*dWrite == 0 && inCounter < 10*/ )
        SerialPort->TimeOuts_Save();
        SerialPort->TimeOuts_Set(1);
        while ( dRead == 0 && mThread != NULL )
        {
            if ( mThread->IsKilled()   == true ) return false;
            if ( mThread               == NULL )  return false;
            if ( mThread->IsFinished() == true ) return false;

            WriteFile( SerialPort->hComm, &SendValue1[0], 1, &dWrite, NULL);

            if ( mThread               == NULL )  return false;
            if ( mThread->IsKilled()   == true ) return false;
            if ( mThread               == NULL )  return false;
            if ( mThread->IsFinished() == true ) return false;

            b_result = ReadFile( SerialPort->hComm, &cVal, 1, &dRead, 0 );

            if ( b_result == false ) return false; //--- ������ �������� ----

            inCounter++;
        }
        SerialPort->TimeOuts_Restore();
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

//==========================================================================
void CCVGx::DeCompositeData()
{
}

//===========================================================================
void CCVGx::RealTimeProcessing(double *in_out_array)
{
}

