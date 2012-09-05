//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGxm_gk.h"

//===========================================================================
CCVGxm_gk::CCVGxm_gk()
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
    LoadFromRegistry("CVGxm_gk");
}

//===========================================================================
CCVGxm_gk::~CCVGxm_gk()
{
    SaveDataToRegistry("CVGxm_gk");
}

//===========================================================================
int  CCVGxm_gk::Start()
{
   // ----------
    SaveDataToRegistry("CVGxm_gk");

   // ----------
    UART_Frequency      = ExtendedParamValues[0];
    PackedLength        = ExtendedParamValues[2];
    InfoPackedLength    = ExtendedParamValues[2];
   isRealTimeProcessing = true;

    SummationCount                = UART_Frequency / SamplingFreq;
    if ( SummationCount < 1 ) SummationCount = 1;
    SummationCount_invert         = 1.0 / (double)SummationCount;
    CurrentSummationPoint         = 0;

    Storage->file_Param.StorageT0[0] = SummationCount / (double) UART_Frequency;

    // ---- Сэтапю каналы ----
	CountUARTValues = 19;
    Storage->SetItemsCount( CountUARTValues + 0);

    Storage->Items[ 0]->SetName("GyroOut\0"      );
    Storage->Items[ 1]->SetName("Temperature\0"  );

    Storage->Items[ 2]->SetName("X_Frequency\0"    );
    Storage->Items[ 3]->SetName("Y_Frequency\0"    );

    Storage->Items[ 4]->SetName("X_Excitation\0" );
    Storage->Items[ 5]->SetName("Y_Excitation\0" );

    Storage->Items[ 6]->SetName("X_Antinode\0" );
    Storage->Items[ 7]->SetName("Y_Antinode\0"  );

    Storage->Items[ 8]->SetName("Phase_ADC\0" ); isNeedCalcMiddledValue[8] = false;
    Storage->Items[ 9]->SetName("Phase_DAC\0" ); isNeedCalcMiddledValue[9] = false;

    Storage->Items[10]->SetName("Quadrature\0" );
    Storage->Items[11]->SetName("Error_Phase\0" );
    Storage->Items[12]->SetName("Error_X_Frequency\0" );

    Storage->Items[13]->SetName("Error_Y_Frequency\0" );
    Storage->Items[14]->SetName("DeltaFrequency\0" );

    Storage->Items[15]->SetName("Kxy\0" );

    Storage->Items[16]->SetName("X_Exc_phase\0" );
    Storage->Items[17]->SetName("Y_Exc_phase\0" );

   // -------------
    if ( CBaseDevice::Start()                    == -1 ) return -1;
    if ( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

   // -----
    return 0;
}

//===========================================================================
void CCVGxm_gk::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVGxm_gk::DeCompositeData()
{
   // ---- в ---- gd->LastGoodReadValue[i] --- Находяться последние  прочитанные данные с пакета ----
   // ---- в ---- gd->SumValues        [i] --- Находиться сумма на временном пакете             ----
   // ---- в ---- CountSumPoint            --- Находиться количкство сумм                       ----
        for (int i = 0; i < Storage->ItemsCount; i++)
        	if ( isNeedCalcMiddledValue[i] == true )
            	 Storage->Items[i]->Add(ParentSummValues[i] / float(SummationCount));
            else Storage->Items[i]->Add(ParentSummValues[i]);
}

//===========================================================================
void CCVGxm_gk::RealTimeProcessing(double *in_out_array)
{
}


