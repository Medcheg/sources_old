//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGxm.h"

//===========================================================================
CCVGxm::CCVGxm()
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
    LoadFromRegistry("CVGxm");
}

//===========================================================================
CCVGxm::~CCVGxm()
{
    SaveDataToRegistry("CVGxm");
}

//===========================================================================
int  CCVGxm::Start()
{
   // ----------
    SaveDataToRegistry("CVGxm");

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
    Storage->SetItemsCount(CountUARTValues + 0);

    Storage->Items[ 0]->SetName("GyroOut\0"        );

    Storage->Items[ 1]->SetName("Temperature\0"    );		isNeedCalcMiddledValue[1] = false;
    Storage->Items[ 2]->SetName("Frequency\0"    );         isNeedCalcMiddledValue[2] = false;
    Storage->Items[ 3]->SetName("ExcitationAmpl\0" );		isNeedCalcMiddledValue[3] = false;
    Storage->Items[ 4]->SetName("QuadratureAmpl\0" );		isNeedCalcMiddledValue[4] = false;

    Storage->Items[ 5]->SetName("RAW_GyroOut\0"  );
    Storage->Items[ 6]->SetName("RAW_ExcitationAmpl\0"  );

    Storage->Items[ 7]->SetName("XAmplitude\0"  );
    Storage->Items[ 8]->SetName("YAmplitude\0"  );

    Storage->Items[ 9]->SetName("XPhase\0" );
    Storage->Items[10]->SetName("YPhase\0" );

    Storage->Items[11]->SetName("Error_(Coriolis)\0"   );
    Storage->Items[12]->SetName("Error_(Quadrature)\0" );
    Storage->Items[13]->SetName("Error_(Frequency)\0"  );

    Storage->Items[14]->SetName("RAW_Frequency\0"      );
    Storage->Items[15]->SetName("RAW_QuadratureAmpl\0" );
	Storage->Items[16]->SetName("PhaseXY\0"            );

    Storage->Items[17]->SetName("debug_param\0"        );
    Storage->Items[18]->SetName("debug_param\0"        );
   // -------------
    if ( CBaseDevice::Start()                    == -1 ) return -1;
    if ( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

   // -----
    return 0;
}

//===========================================================================
void CCVGxm::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVGxm::DeCompositeData()
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
void CCVGxm::RealTimeProcessing(double *in_out_array)
{
}


