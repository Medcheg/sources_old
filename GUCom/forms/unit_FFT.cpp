//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "unit_FFT.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "Series"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
Tform_FreqAnalysis *form_FreqAnalysis;
//---------------------------------------------------------------------------
__fastcall Tform_FreqAnalysis::Tform_FreqAnalysis(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall Tform_FreqAnalysis::bCalculateClick(TObject *Sender)
{
    int   DataIndex    = StrToInt(Edit1->Text);
    float SamplintTime = StrToFloat(eSamplingTime->Text);
    float minFreq = 1;
    float maxFreq = 2.0 / SamplintTime;
    float WorkFreq = 1.0 / SamplintTime;
    int aPower;

    CCollection<float> in_FFT_array(2);
    CCollection<float> out_FFT(2);

    for ( unsigned int i = 0; i < Data->Vectors[DataIndex]->Length; i++)
    {
        in_FFT_array.Vectors[0]->Add(Data->Vectors[DataIndex]->Values[i]);
        in_FFT_array.Vectors[1]->Add(0);
    }

    // ******************
        FFT(&in_FFT_array, &aPower);
    // ******************

// -----
    int DataCount = exp(aPower * std::log(2.0));
    float *re = (float*)in_FFT_array.Vectors[0]->Values;
    float *im = (float*)in_FFT_array.Vectors[1]->Values;

     for ( int i = 0; i < DataCount / 2; i++)
     {
         double xVal = i / (double)DataCount * WorkFreq;
         if ( xVal >= minFreq && xVal < maxFreq )
         {
             double yVal = sqrt(re[i]*re[i] + im[i]*im[i])*2.0 / (double)DataCount;
             out_FFT.Vectors[0]->Add(xVal);
             out_FFT.Vectors[1]->Add(yVal);
         }
    }

    double *xarr, *yarr, *temp;
    int     cnt = 2000;
    int    visible_points = out_FFT.Vectors[0]->Length;
    out_FFT.Vectors[0]->GetChartArray(SamplintTime, cnt, visible_points, 0, 0, &temp, &xarr);
    out_FFT.Vectors[1]->GetChartArray(SamplintTime, cnt, visible_points, 0, 0, &temp, &yarr);

    Chart5->Series[0]->Clear();
    Chart5->Series[0]->AddArray( xarr, cnt-1, yarr, cnt-1);
    Chart5->Refresh();
}
//---------------------------------------------------------------------------
void __fastcall Tform_FreqAnalysis::checkbox_isLogarithmicScaleClick(TObject *Sender)
{
    if ( checkbox_isLogarithmicScale->Checked == true )
         Chart5->BottomAxis->Minimum = 1;
    else Chart5->BottomAxis->Minimum = 0;

    Chart5->BottomAxis->Logarithmic = checkbox_isLogarithmicScale->Checked;

    Application->ProcessMessages();
}
//---------------------------------------------------------------------------
void __fastcall Tform_FreqAnalysis::Chart5Zoom(TObject *Sender)
{
//
}
//---------------------------------------------------------------------------
