//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGk.h"

//===========================================================================
CCVGk::CCVGk()
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
    //SamplingFreqsRate.Add(100);
    //SamplingFreqsRate.Add(200);

    SerialPort->BaudRate    = 115200;
    SerialPort->ByteSize    = 8;

    ExtendedParamCount     = 0;
    ExtendedParamValues[0] = 50;    ExtendedParamNames[0] = strdup("UART_Frequncy:");
    ExtendedParamValues[2] = 56;

    Parent_ThreadType          = 1;

  // --------
    LoadFromRegistry("CVGk");
}

//===========================================================================
CCVGk::~CCVGk()
{
    SaveDataToRegistry("CVGk");
}

//===========================================================================
int  CCVGk::Start()
{
   // ----------
    SaveDataToRegistry("CVGk");

   // ----------
    UART_Frequency   = ExtendedParamValues[0];
    PackedLength     = ExtendedParamValues[2];
    InfoPackedLength = ExtendedParamValues[2];
    //PackedLength     = 48;
    //InfoPackedLength = 48;

    SummationCount                = UART_Frequency / SamplingFreq;
    if ( SummationCount < 1 ) SummationCount = 1;
    SummationCount_invert         = 1.0 / (double)SummationCount;
    CurrentSummationPoint         = 0;

    Storage->file_Param.StorageT0[0] = SummationCount / (double) UART_Frequency;

    // ---- Сэтапю каналы ----
	CountUARTValues = 13;
    Storage->SetItemsCount(CountUARTValues + 0);
    //Storage->SetItemsCount(13);

    Storage->Items[ 0]->SetName("GyroOut\0"       );        Storage->Items[ 0]->isCanalVisible = true;
    Storage->Items[ 1]->SetName("Temperature\0"   );        Storage->Items[ 1]->isCanalVisible = true;
    Storage->Items[ 2]->SetName("Frequency\0"     );        Storage->Items[ 2]->isCanalVisible = isDebugMode;
    Storage->Items[ 3]->SetName("ExcitationAmp\0" );        Storage->Items[ 3]->isCanalVisible = isDebugMode;
    Storage->Items[ 4]->SetName("QuadratureAmpl\0");        Storage->Items[ 4]->isCanalVisible = isDebugMode;
    Storage->Items[ 5]->SetName("GyroOut_RAW\0"   );        Storage->Items[ 5]->isCanalVisible = isDebugMode;
    Storage->Items[ 6]->SetName("GyroOut_cor_SF\0");        Storage->Items[ 6]->isCanalVisible = isDebugMode;
    Storage->Items[ 7]->SetName("GyroOut_cor_F1\0");        Storage->Items[ 7]->isCanalVisible = isDebugMode;
    Storage->Items[ 8]->SetName("CoriolisError\0" );        Storage->Items[ 8]->isCanalVisible = isDebugMode;
    Storage->Items[ 9]->SetName("XAmplitude\0"    );        Storage->Items[ 9]->isCanalVisible = isDebugMode;
    Storage->Items[10]->SetName("YAmplitude\0"    );        Storage->Items[10]->isCanalVisible = isDebugMode;
    Storage->Items[11]->SetName("AntinodePhase\0" );        Storage->Items[11]->isCanalVisible = isDebugMode;
    Storage->Items[12]->SetName("NodePhase\0"     );        Storage->Items[12]->isCanalVisible = isDebugMode;

   // -------------
    if ( CBaseDevice::Start() == -1 ) return -1;
    if( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

    #ifdef NN
    #else
    #endif

   // -----
    return 0;
}

//===========================================================================
void CCVGk::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVGk::DeCompositeData()
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


