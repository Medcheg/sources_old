//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_CVG_44_correct.h"

//===========================================================================
CCVG_44_correct::CCVG_44_correct()
{ 

  // ----- ������� �� ������� �������� � ����������� ������ ������ ���������� ------
    SamplingFreqsRate.Clear();
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
    ExtendedParamValues[2] = 44;

    Parent_ThreadType          = 1;

  // --------
    LoadFromRegistry("CVG_44_correct");
}

//===========================================================================
CCVG_44_correct::~CCVG_44_correct()
{
    SaveDataToRegistry("CVG_44_correct");
}

//===========================================================================
int  CCVG_44_correct::Start()
{
   // ----------
    SaveDataToRegistry("CVG_44_correct");

   // ----------
    UART_Frequency   = ExtendedParamValues[0];
    PackedLength     = ExtendedParamValues[2];
    InfoPackedLength = ExtendedParamValues[2];

    SummationCount   = UART_Frequency / SamplingFreq;
    if ( SummationCount < 1 ) SummationCount = 1;
    SummationCount_invert         = 1.0 / (double)SummationCount;
    CurrentSummationPoint         = 0;

    Storage->file_Param.StorageT0[0] = SummationCount / (double) UART_Frequency;

    // ---- ������ ������ ----
	CountUARTValues = 10;
    Storage->SetItemsCount(CountUARTValues + 0);
    //Storage->SetItemsCount(10);

    Storage->Items[ 0]->SetName("Frequency\0"      );
    Storage->Items[ 1]->SetName("GyroOut\0"        );
    Storage->Items[ 2]->SetName("AntinodeSignal\0"  );
    Storage->Items[ 3]->SetName("ExcitationPhase\0"  );
    Storage->Items[ 4]->SetName("NodeVoltage\0"   );
    Storage->Items[ 5]->SetName("NodePhase\0" );
    Storage->Items[ 6]->SetName("QuadratureComponent\0"      );
    Storage->Items[ 7]->SetName("Excitation\0"       );
    Storage->Items[ 8]->SetName("GyroOut_corrected\0"  );
    Storage->Items[ 9]->SetName("Temperature\0");

   // -------------
    if ( CBaseDevice::Start() == -1 ) return -1;
    if( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

   // -----
    return 0;
}

//===========================================================================
void CCVG_44_correct::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CCVG_44_correct::DeCompositeData()
{
   // ---- � ---- gd->LastGoodReadValue[i] --- ���������� ��������� ����������� ������ � ������ ----
   // ---- � ---- gd->SumValues        [i] --- ���������� ����� �� ��������� ������             ----
   // ---- � ---- CountSumPoint            --- ���������� ���������� ����                       ----
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


