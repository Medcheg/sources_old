//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGx48.h"

//===========================================================================
CCVGx48::CCVGx48()
{ 
  // ----- Частоты на которых работаем в непрерывном режиме выдачи информации ------
    SamplingFreqsRate.Clear( );
    SamplingFreqsRate.Add(  1);
    SamplingFreqsRate.Add(  5);
    SamplingFreqsRate.Add( 10);
    SamplingFreqsRate.Add( 20);
    SamplingFreqsRate.Add( 50);
    SamplingFreqsRate.Add(100);
    SamplingFreqsRate.Add(200);

    SerialPort->BaudRate    = 115200;
    SerialPort->ByteSize    = 8;

    ExtendedParamCount     = 0;
    ExtendedParamValues[0] = 200;    ExtendedParamNames[0] = strdup("UART_Frequncy:");
    ExtendedParamValues[2] = 48;
    //ExtendedParamValues[2] = 64;

    Parent_ThreadType = 1;

  // --------
    LoadFromRegistry("CVGx48");
}

//===========================================================================
CCVGx48::~CCVGx48()
{
    SaveDataToRegistry("CVGx48");
}

//===========================================================================
int  CCVGx48::Start()
{
   // ----------
    SaveDataToRegistry("CVGx48");

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
	CountUARTValues = 11;
    Storage->SetItemsCount(CountUARTValues + 0);
    //Storage->SetItemsCount(11);

    Storage->Items[ 0]->SetName("GyroOut");
    Storage->Items[ 1]->SetName("Temperature");
    Storage->Items[ 2]->SetName("AntiNodePeriod");
    Storage->Items[ 3]->SetName("ExcitationDelay");
    Storage->Items[ 4]->SetName("AntiNodeAmplitude");
    Storage->Items[ 5]->SetName("ExcitationAmpl");
    Storage->Items[ 6]->SetName("QuadratureAmpl");
    Storage->Items[ 7]->SetName("QuadratureError");
    Storage->Items[ 8]->SetName("CoriolisError");
    Storage->Items[ 9]->SetName("NodeAmplitude");
    Storage->Items[10]->SetName("GyroOut_RAW");

    memset(fSliderBuffer, 0, sizeof(fSliderBuffer));
    SliderArraySize = 120 * SamplingFreq;
    isSliderBufferInited = false;

   // -------------
    if ( CBaseDevice::Start() == -1 ) return -1;
    if( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

   // -----
    return 0;
}

//===========================================================================
void CCVGx48::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVGx48::DeCompositeData()
{
   // ---- в ---- gd->LastGoodReadValue[i] --- Находяться последние прочитанные данные с пакета ----
   // ---- в ---- gd->SumValues        [i] --- Находиться сумма на временном пакете             ----
   // ---- в ---- CountSumPoint            --- Находиться количкство сумм                       ----

    if ( Storage->Items[0]->ValuesCount >= SliderArraySize && isSliderBufferInited == false )
    {
        if ( h_file[0] != NULL) fclose( h_file[0] );
        h_file[0] = NULL;
        OpenDataSaveFile( &h_file[0], Storage );
        Sleep(300);

        isSliderBufferInited = true;
        for (int i = 0; i < Storage->ItemsCount; i++)
                Storage->Items[i]->Clear();
    }

   // -------
    for (int i = 0; i < Storage->ItemsCount; i++)
    {
        memmove(&fSliderBuffer[i][1], &fSliderBuffer[i][0], SliderArraySize*sizeof(double));
        fSliderBuffer[i][0] = ParentSummValues[i] / float(SummationCount);

        if ( isSliderBufferInited == true )
        {
            double SumVal = 0;
            for ( int k = 0; k < SliderArraySize; k++) SumVal = SumVal + fSliderBuffer[i][k];

            Storage->Items[i]->Add( SumVal / SliderArraySize );
         } else Storage->Items[i]->Add(fSliderBuffer[i][0]);
    }
}


