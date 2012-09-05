//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVGx_test_rs485.h"

//===========================================================================
CCVGx_test_rs485::CCVGx_test_rs485()
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
    LoadFromRegistry("CVGx_test_rs485");
}

//===========================================================================
CCVGx_test_rs485::~CCVGx_test_rs485()
{
    SaveDataToRegistry("CVGx_test_rs485");
}

//===========================================================================
int  CCVGx_test_rs485::Start()
{
   // ----------
    SaveDataToRegistry("CVGx_test_rs485");

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

    Storage->Items[ 0]->SetName("value_01\0"        );
    Storage->Items[ 1]->SetName("value_02\0"    );
    Storage->Items[ 2]->SetName("value_03\0"    );
    Storage->Items[ 3]->SetName("value_04\0" );
    Storage->Items[ 4]->SetName("value_05\0" );
    Storage->Items[ 5]->SetName("value_06\0" );
    Storage->Items[ 6]->SetName("value_07\0"  );
	Storage->Items[ 7]->SetName("value_08\0"         );
    Storage->Items[ 8]->SetName("value_09\0");
    Storage->Items[ 9]->SetName("value_10\0");
    Storage->Items[10]->SetName("value_11\0");

   // -------------
    if ( CBaseDevice::Start() == -1 ) return -1;
    if( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

   // -----
    return 0;
}

//===========================================================================
void CCVGx_test_rs485::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVGx_test_rs485::DeCompositeData()
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


