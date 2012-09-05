//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGx_analog.h"

//===========================================================================
//===========================================================================
CCVGx_analog::CCVGx_analog()
{

  // ----- Частоты на которых работаем в непрерывном режиме выдачи информации ------
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
        memset( BaseCanalsName[i], 0, sizeof(BaseCanalsName[i]) );

  // --------
    sprintf(BaseCanalsName[ 0], "X_ampl\0"        );
    sprintf(BaseCanalsName[ 1], "Y_ampl\0"    );
    sprintf(BaseCanalsName[ 2], "Temperature\0" );
    sprintf(BaseCanalsName[ 3], "X_mean\0" );
    sprintf(BaseCanalsName[ 4], "Y_mean\0" );
    sprintf(BaseCanalsName[ 5], "X_phase\0");
    sprintf(BaseCanalsName[ 6], "Y_phase\0");
    sprintf(BaseCanalsName[ 7], "null_1\0");
    sprintf(BaseCanalsName[ 8], "null_2\0");
    sprintf(BaseCanalsName[ 9], "null_3\0");
    sprintf(BaseCanalsName[10], "null_4\0");
    sprintf(BaseCanalsName[11], "null_5\0");
    sprintf(BaseCanalsName[12], "null_6\0");
    sprintf(BaseCanalsName[13], "null_7\0");
    sprintf(BaseCanalsName[14], "null_8\0");
    sprintf(BaseCanalsName[15], "null_9\0");
  // --------

    Parent_ThreadType = 2;

  // --------
    LoadFromRegistry("CVGx_analog");
}

//===========================================================================
CCVGx_analog::~CCVGx_analog()
{
    SaveDataToRegistry("CVGx_analog");
}

//===========================================================================
int  CCVGx_analog::Start()
{
   // ----------
    SaveDataToRegistry("CVGx_analog");

   // ----------
    GyroMode                  = ExtendedParamValues[0];
    ControllersCount          = ExtendedParamValues[1];
    GyrosCountOnOneController = ExtendedParamValues[2];

    DeviceFrequency_mode_1_2  = ExtendedParamValues[3];
    DeviceFrequency_mode_3_4  = ExtendedParamValues[4];

    PackedLength              = ExtendedParamValues[5];
    InfoPackedLength          = ExtendedParamValues[5];

    // ----- Проверки ввода правильнрой инфы ----
    if ( GyrosCountOnOneController < 1 || GyrosCountOnOneController > 3 )
    {
        MessageBoxA( fHandleParenWindow, "rus: Заданое количество гироскопов на одном контроллере не верно.", "CVGCom - Error", MB_OK|MB_ICONERROR );
        return -1;
    }
    if ( GyroMode < 0 || GyroMode > 7 )
    {
        MessageBoxA( fHandleParenWindow, "rus: ( GyroMode >= 0 && GyroMode <= 6)", "CVGCom - Error", MB_OK|MB_ICONERROR );
        return -1;
    }

    if ( ( GyroMode == 3 || GyroMode == 4 ) && ControllersCount != 1 )
    {
        MessageBoxA( fHandleParenWindow, "rus: В режиме непрерывной выдачи, программа работает только с одним контроллером. Исправьте пожалуйста установки.", "CVGCom - Error", MB_OK|MB_ICONERROR );
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

    // ---- Сэтапю каналы ----
    OnlineCanalCountForOneGyro = ( GyroMode != 4 ) ? 2 : 16;
    Storage->SetItemsCount(ControllersCount * GyrosCountOnOneController * OnlineCanalCountForOneGyro);
    int  CanalsCounter = 0;
    char AdditionalControllerString[16];  memset(AdditionalControllerString, 0, 16);
    char AdditionalGyroString[16];        memset(AdditionalGyroString      , 0, 16);

    // ----- Цикл по контроллерам ------
    for ( int i = 0; i < ControllersCount; i++ )
    {
        // ----- Сэтап дополнительнгой начальной строки ----
        if ( ControllersCount != 1 )
        {
            if ( GyrosCountOnOneController == 1 )
                 sprintf( AdditionalControllerString, "c%i_", i+1 );
            else sprintf( AdditionalControllerString, "c%i", i+1 );
        }
        // ----- Цикл по гироскопам ------
        for ( int k = 0; k < GyrosCountOnOneController; k++ )
        {
            // ----- Сэтап дополнительнгой начальной строки ----
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

   // ------- Формирование Команды ----------
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

            default : break; // ---- вывод инфы о том, что неправильно заданные режимым --------
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
void CCVGx_analog::Stop()
{
  // ----- Останавливаю выдачу данных в в РС485 ----
    char SendVal = 0x40;
    DWORD  dWrite;
    if ( SerialPort->isOpen == true && GyroMode != 4)
        for ( int i = 0; i < 50; i++)
            WriteFile( SerialPort->hComm, &SendVal, 1, &dWrite, NULL);

  // -----
    SerialPort->ClearComPortError(true);
  // -----
    CBaseDevice::Stop();
  // -----
//    if ( h_file_binlog != NULL) fclose(h_file_binlog); h_file_binlog = NULL;
}
/*
//===========================================================================
bool CCVGx_analog::isWorkError( CCVGx_analog *gd )
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

