//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGxm_Diff.h"

//===========================================================================
CCVGxm_Diff::CCVGxm_Diff()
{ 
  // ----- Частоты на которых работаем в непрерывном режиме выдачи информации ------
    SamplingFreqsRate.Clear( );
    SamplingFreqsRate.Add(  1);
    SamplingFreqsRate.Add(  5);
    SamplingFreqsRate.Add( 10);
    SamplingFreqsRate.Add( 20);
    SamplingFreqsRate.Add( 50);
    SamplingFreqsRate.Add(100);

    SerialPort->BaudRate    = 115200;
    SerialPort->ByteSize    = 8;

    ExtendedParamCount     = 0;
    ExtendedParamValues[0] = 100;    ExtendedParamNames[0] = strdup("UART_Frequncy:");
    ExtendedParamValues[2] = 80;
    //ExtendedParamValues[2] = 64;

    Parent_ThreadType = 1;

  // --------
    LoadFromRegistry("CVGd");
}

//===========================================================================
CCVGxm_Diff::~CCVGxm_Diff()
{
    SaveDataToRegistry("CVGd");
}

//===========================================================================
int  CCVGxm_Diff::Start()
{
   // ----------
    SaveDataToRegistry("CVGd");

   // ----------
    UART_Frequency   = ExtendedParamValues[0];
    PackedLength     = ExtendedParamValues[2];
    InfoPackedLength = ExtendedParamValues[2];

    SummationCount                = UART_Frequency / SamplingFreq;
    if ( SummationCount < 1 ) SummationCount = 1;
    SummationCount_invert         = 1.0 / (double)SummationCount;
    CurrentSummationPoint         = 0;

    Storage->file_Param.StorageT0[0] = SummationCount / (double) UART_Frequency;

    // ---- Сэтапю каналы ----
	CountUARTValues = 19;
    Storage->SetItemsCount(CountUARTValues + 0);

    Storage->Items[ 0]->SetName("GyroOut\0"        );
    Storage->Items[ 1]->SetName("Temperature\0"    );
    Storage->Items[ 2]->SetName("AntinodePeriod\0" );
    Storage->Items[ 3]->SetName("K_DifferentFreq\0");
    Storage->Items[ 4]->SetName("Quadrature\0"     );
    Storage->Items[ 5]->SetName("Omega_X\0"        );
    Storage->Items[ 6]->SetName("Omega_Y\0"        );
    Storage->Items[ 7]->SetName("DF_error\0"        );
    Storage->Items[ 8]->SetName("Amplitude_x\0"    );
    Storage->Items[ 9]->SetName("Amplitude_y\0"    );
    Storage->Items[10]->SetName("InputMean_x\0"         );
    Storage->Items[11]->SetName("InputMean_y\0"         );
    Storage->Items[12]->SetName("ExcPhase_x\0"    );
    Storage->Items[13]->SetName("ExcPhase_y\0"    );
	Storage->Items[14]->SetName("KDFPhase_x\0"     );
	Storage->Items[15]->SetName("KDFPhase_y\0"     );
    Storage->Items[16]->SetName("SystemPhase_x\0"   );
    Storage->Items[17]->SetName("SystemPhase_y\0"   );
    Storage->Items[18]->SetName("GyroOut_RAW\0"    );
   // -------------
    if ( CBaseDevice::Start() == -1 ) return -1;
    if( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

   // -----
    return 0;
}

//===========================================================================
void CCVGxm_Diff::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVGxm_Diff::DeCompositeData()
{
   // ---- в ---- gd->LastGoodReadValue[i] --- Находяться последние прочитанные данные с пакета ----
   // ---- в ---- gd->SumValues        [i] --- Находиться сумма на временном пакете             ----
   // ---- в ---- CountSumPoint            --- Находиться количкство сумм                       ----
//    if ( isShowGraphics == true )
//    {
        for (int i = 0; i < Storage->ItemsCount; i++)
            Storage->Items[i]->Add(ParentSummValues[i] / float(SummationCount));
/*
    }
    else
    {
        for (int i = 0; i < Storage->ItemsCount - CounAdditionalData; i++)
        {
            Storage->Items[i]->Values[0] =  SumValues[i] / float(CountSumPoint);
            SumValues[i] = 0;
        }
        if ( pTemperatura != NULL  ) Storage->Items[Storage->ItemsCount - CounAdditionalData]->Values[0] = *pTemperatura;
    }
*/
}


