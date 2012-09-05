//===========================================================================
#include "pmPCH.h"
#pragma hdrstop

//===========================================================================
#include "dev_UE1.h"

//===========================================================================
CUE1::CUE1()
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
    SamplingFreqsRate.Add(250);
    SamplingFreqsRate.Add(500);

  // ------
    SerialPort->BaudRate    = 230400;

  // ------
    ExtendedParamCount     = 0;   // ---- ����, �� ������� --- ���������� ������� �������������� ���������� ---
    ExtendedParamValues[0] = 500; // ---- ������� ������� � ����� ----
    ExtendedParamValues[2] = 36;  // ---- ����� ������ ����� ---- 0xAA, 0x55, 4_floats, 0xCS, 0xCS ----- 2 + 32 + 2

  // ------
    Parent_ThreadType = 1; // ---- ����, �� ������� --- ��� ������������� ������ ----

  // ------
    LoadFromRegistry("UE1");
}

//===========================================================================
CUE1::~CUE1()
{
    SaveDataToRegistry("UE1");
}

//===========================================================================
int  CUE1::Start()
{
   // ----------
    SaveDataToRegistry("UE1");

   // ----------
    UART_Frequency      = ExtendedParamValues[0];
    PackedLength        = ExtendedParamValues[2];
    InfoPackedLength    = ExtendedParamValues[2];

   isRealTimeProcessing = true;

    SummationCount = UART_Frequency / SamplingFreq; if ( SummationCount < 1 ) SummationCount = 1;
    SummationCount_invert = 1.0 / (double)SummationCount;
    CurrentSummationPoint = 0;

    Storage->file_Param.StorageT0[0] = SummationCount / (double) UART_Frequency;

    // ---- ������ ������ ----
	CountUARTValues = 8;
    Storage->SetItemsCount(CountUARTValues + 9);

    Storage->Items[ 0]->SetName("in_0\0"     );
    Storage->Items[ 1]->SetName("in_1\0"     );
    Storage->Items[ 2]->SetName("in_2\0"     );
    Storage->Items[ 3]->SetName("in_3\0"     );
    Storage->Items[ 4]->SetName("in_4\0"     );
    Storage->Items[ 5]->SetName("in_5\0"     );
    Storage->Items[ 6]->SetName("in_6\0"     );
    Storage->Items[ 7]->SetName("in_7\0"     );

    Storage->Items[ 8]->SetName("process_0\0");
    Storage->Items[ 9]->SetName("process_1\0");
    Storage->Items[10]->SetName("process_2\0");
    Storage->Items[11]->SetName("process_3\0");
    Storage->Items[12]->SetName("process_4\0");
    Storage->Items[13]->SetName("process_5\0");
    Storage->Items[14]->SetName("process_6\0");
    Storage->Items[15]->SetName("process_7\0");
    Storage->Items[16]->SetName("process_8\0");

  // ------
    if ( CBaseDevice::Start() == -1 ) return -1;
    if( OpenDataSaveFile( &h_file[0], Storage ) == -1 ) return -2;

  // ------
    return 0;
}

//===========================================================================
void CUE1::Stop()
{
    CBaseDevice::Stop();
}

//===========================================================================
void CUE1::DeCompositeData()
{
   // ---- � ---- gd->LastGoodReadValue[i] --- ���������� ��������� ����������� ������ � ������ ----
   // ---- � ---- gd->SumValues        [i] --- ���������� ����� �� ��������� ������             ----
   // ---- � ---- CountSumPoint            --- ���������� ���������� ����                       ----
        for (int i = 0; i < Storage->ItemsCount; i++)
            Storage->Items[i]->Add(ParentSummValues[i] / float(SummationCount));
}

//===========================================================================
// ---- ������� ����������� ����� ������� ������ ������ � �����, ��������� ��� ----
//
//in_out_array[0]     //  ---- In Values -----
//in_out_array[1]     //  ---- In Values -----
//...........
//in_out_array[n]     //  ---- In Values -----
//in_out_array[n + 1] //  ---- Output Values -----
//in_out_array[n + 2] //  ---- Output Values -----
//...........
//in_out_array[n + m] //  ---- Output Values -----
//
//
// ��� n, m ��������� � ������� (����), ������ "int CUE1::Start()" � �������
// Storage->SetItemsCount(CountUARTValues + 9);
// ���, n = CountUARTValues --- ���������� ������� ���������� � �����
// ���, m = 9               --- ���������� �������������� (���������, �������������, ��������� ��� ������ � ������) ����������, (����� ����� ������ � �������� ��������, ������ ���� ������ "����")
void CUE1::RealTimeProcessing(double *in_out_array)
{
    // ---- ������� ������ ������� ---
	func1();
	func2();
	func3();
}

//===========================================================================
// ����� ������� � ���������� ������� � ������ ����� �����, ������ ���������� �-�� ���� (� ������ �����)
// ������� � ���������� ������ ������ � �������� ������ � ������� "Private", ��������� ������������ ������ � ���������� �� ���������, ��������� � ������
void CUE1::func1(){};
void CUE1::func2(){};
void CUE1::func3(){};

