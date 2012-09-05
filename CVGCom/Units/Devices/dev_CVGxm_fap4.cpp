//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGxm_fap4.h"

//===========================================================================
CCVGxm_fap4::CCVGxm_fap4()
{ 
  // ----- Частоты на которых работаем в непрерывном режиме выдачи информации ------
    SamplingFreqsRate.Clear( );
    SamplingFreqsRate.Add(0.2);
    SamplingFreqsRate.Add(0.4);
    SamplingFreqsRate.Add(0.5);
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
    LoadFromRegistry("CVGxm_fap4");
}

//===========================================================================
CCVGxm_fap4::~CCVGxm_fap4()
{
    SaveDataToRegistry("CVGxm_fap4");
}

//===========================================================================
int  CCVGxm_fap4::Start()
{
   // ----------
    SaveDataToRegistry("CVGxm_fap4");

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
    Storage->SetItemsCount(19);
    Storage->Items[ 0]->SetName("GyroOut\0"        );
    Storage->Items[ 1]->SetName("Temperature\0"    );
    Storage->Items[ 2]->SetName("Frequency\0" );
    Storage->Items[ 3]->SetName("AntinodePeriod\0" );

    Storage->Items[ 4]->SetName("ExcitationAmpl\0" );
    Storage->Items[ 5]->SetName("QuadratureAmpl\0");

    Storage->Items[ 6]->SetName("XAmplitude\0" );
    Storage->Items[ 7]->SetName("YAmplitude\0" );
    Storage->Items[ 8]->SetName("X_Phase\0"    );

    Storage->Items[ 9]->SetName("XMean\0");
    Storage->Items[10]->SetName("YMean\0");

    Storage->Items[11]->SetName("error_freq\0"      );
    Storage->Items[12]->SetName("error_coriolis\0"  );
    Storage->Items[13]->SetName("error_quadrature\0");

	Storage->Items[14]->SetName("null\0"  );
	Storage->Items[15]->SetName("param1\0");
    Storage->Items[16]->SetName("param2\0");
    Storage->Items[17]->SetName("param3\0");
    Storage->Items[18]->SetName("param4\0");

   // -------------
    if ( CBaseDevice::Start() == -1 ) return -1;
    if( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

   // -----
    return 0;
}

//===========================================================================
void CCVGxm_fap4::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVGxm_fap4::DeCompositeData()
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


