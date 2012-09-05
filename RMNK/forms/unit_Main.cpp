//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unit_Main.h"
#include "pmTypes.h"
#include "pmRMNK.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma link "Series"
#pragma resource "*.dfm"
TForm25 *Form25;

#include "math.h"

CAmplMean      *AmplMean;
CPhaseDetector *Phase;

float AlgoFreq = 50000.0;
float GyroFreq = 4335.12;
float X_ampl = 1.0;
float mju    = 0.03;
float T0;

// ======================================================================================
__fastcall TForm25::TForm25(TComponent* Owner)
    : TForm(Owner)
{
    Application->Title = "RMNK - ìîäåëèðîâàíèå";
    this->Caption      = "RMNK - ìîäåëèðîâàíèå";

    T0 = 1.0 / AlgoFreq;

    rmnk     = new CRMNK();
    AmplMean = new CAmplMean();
    Phase    = new CPhaseDetector();


}


void __fastcall TForm25::FormShow(TObject *Sender)
{
    Edit1->Text = mju;
    Edit2->Text = AlgoFreq;
    Edit3->Text = GyroFreq;
}

// ======================================================================================
void __fastcall TForm25::FormDestroy(TObject *Sender)
{
    delete rmnk;
    delete AmplMean;
    delete Phase;
}

void TForm25::SeriesClear(TChart *chart)
{
    for ( int i = 0; i < chart->SeriesCount(); i++)
        chart->Series[i]->Clear();
}

// ======================================================================================
void __fastcall TForm25::Button1Click(TObject *Sender)
{
    mju      = StrToFloat(Edit1->Text);
    AlgoFreq = StrToFloat(Edit2->Text);
    GyroFreq = StrToFloat(Edit3->Text);

    rmnk->Init(AlgoFreq, GyroFreq, mju);

    SeriesClear(Chart1);
    SeriesClear(Chart2);
    SeriesClear(Chart3);
    SeriesClear(Chart4);

    Memo1->Clear();
    Memo1->Lines->Add("mju = " + FloatToStr(mju));

    Application->ProcessMessages();

    int counter = 0;
    float ModulationFreq = 1.0;
    int   AlgoStep = 0;


    for ( int i = 0; true; i++ )
    {
        float rand       = 0.000*(float)random(100);
        float signal     = rmnk->base_sin;
        float modulation = 0.5 + 0.1*sin(TWO_PI * ModulationFreq *i*T0);
        float sum        = modulation*signal + rand;

        int AlgoTakts = 4 * AlgoFreq / ModulationFreq;

        if ( AlgoStep++ >= AlgoTakts  )
        {
            AlgoStep = 0;
            ModulationFreq ++;
            if ( ModulationFreq >= 300 ) break;

            Chart4->Series[0]->AddXY(i, AmplMean->PeakPeak / 0.1 );
            Chart3->Series[0]->AddXY(i, ModulationFreq);
            Chart2->Series[0]->AddXY(i, Phase->Phase_deg);
        }

        rmnk->Run(sum);
        AmplMean->Put(rmnk->Ampl);
        //Phase->Put(AlgoFreq/GyroFreq , rmnk->base_cos, rmnk->base_sin );
        Phase->Put(AlgoFreq / ModulationFreq, modulation - 0.5, rmnk->Ampl - 0.5);

        if ( counter++ >= 150 ) {
            counter = 0;
            Chart1->Series[1]->AddXY(i, rmnk->Ampl);
            Chart1->Series[0]->AddXY(i, modulation);
        }
    }

    // ---
    TLineSeries *ls_ampl = (TLineSeries *)Chart4->Series[0];
    TLineSeries *ls_phas = (TLineSeries *)Chart2->Series[0];
    TLineSeries *ls_freq = (TLineSeries *)Chart3->Series[0];

    bool isFound = false;
    for ( int i = 0; i < ls_ampl->Count(); i++ )
        if ( ls_ampl->YValues->Value[i] <= 0.707 ) {
            double xVal = ls_ampl->XValues->Value[i];

            for ( int k = 0; k < ls_freq->Count(); k++ )
                if ( ls_freq->XValues->Value[i] >= xVal ) {
                    double freq = ls_freq->YValues->Value[i];
                    Memo1->Lines->Add("ÏÎ À×Õ ... Frequency  = " + FloatToStr(freq) + "Hz \t ampl = " + FloatToStr(ls_ampl->YValues->Value[i]));
                    isFound = true;
                    break;
                }

            break;
        }
    if ( isFound == false ) Memo1->Lines->Add("ÏÎ À×Õ ... Frequency  > 300 Hz ");

    isFound = false;
    for ( int i = 0; i < ls_ampl->Count(); i++ )
        if ( ls_phas->YValues->Value[i] >= 90.0 ) {
            double xVal = ls_phas->XValues->Value[i];

            for ( int k = 0; k < ls_freq->Count(); k++ )
                if ( ls_freq->XValues->Value[i] >= xVal ) {
                    double freq = ls_freq->YValues->Value[i];
                    Memo1->Lines->Add("ÏÎ Ô×Õ ... Frequency  = " + FloatToStr(freq) + "Hz \t phase = " + FloatToStr(ls_phas->YValues->Value[i]));
                    isFound = true;
                    break;
                }

            break;
        }
    if ( isFound == false ) Memo1->Lines->Add("ÏÎ Ô×Õ ... Frequency  > 300 Hz ");

    Memo1->SelStart = 0;
    Memo1->SelLength = 0;
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

