//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "frmMain.h"
#include "Math.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "Chart"
#pragma link "Series"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
    : TForm(Owner)
{
    DecimalSeparator = '.';
}

void __fastcall TForm1::Button1Click(TObject *Sender)
{
    // ---- 1 -----
	AlgoFreq     = StrToFloat(label_AlgoFreq->Text);
    AlgoT0       = 1.0 / AlgoFreq;
    AlgoCalcTime = StrToFloat(label_AlgoCalcTime->Text);

    // ---- 2 -----
    ResonatorFreq     = StrToFloat(edit_ResonatorFreq->Text);
    AntiNodeAmplitude = StrToFloat(edit_ANodeAmpl->Text);

    // ---- 3 -----
    ACPNoise = StrToInt(edit_ACPNoise->Text);
	sin_a1 = StrToFloat(edit_sin_a1->Text);
	sin_a2 = StrToFloat(edit_sin_a2->Text);
	sin_a3 = StrToFloat(edit_sin_a3->Text);
	sin_f1 = StrToFloat(edit_sin_f1->Text);
	sin_f2 = StrToFloat(edit_sin_f2->Text);
	sin_f3 = StrToFloat(edit_sin_f3->Text);

    // ---- -----
    for ( int i = 0 ; i < Chart1->SeriesCount(); i++) { Chart1->Series[i]->Clear(); Chart1->Series[i]->BeginUpdate(); }
    for ( int i = 0 ; i < Chart2->SeriesCount(); i++) { Chart2->Series[i]->Clear(); Chart2->Series[i]->BeginUpdate(); }
    for ( int i = 0 ; i < Chart3->SeriesCount(); i++) { Chart3->Series[i]->Clear(); Chart3->Series[i]->BeginUpdate(); }
    for ( double t = 0; t < AlgoCalcTime; t = t + AlgoT0)
    {
        double inVal = AntiNodeAmplitude * sin( TWO_PI * ResonatorFreq * t );

        // ----- ����������� ---
        double inErrs  = sin_a1 * sin( TWO_PI * sin_f1 * t );
              inErrs += sin_a2 * sin( TWO_PI * sin_f2 * t );
              inErrs += sin_a3 * sin( TWO_PI * sin_f3 * t );

        if ( CheckBox1->Checked == false ) inErrs = 0;      

        // ---- ������ ---
        Run( inVal + inErrs );

        Chart1->Series[0]->AddXY(t, inErrs);
        if ( t > 0.002 && gyro.pd1.isNewPeriodPresent == true )
        {
            Chart2->Series[0]->AddXY(t, gyro.pd1.Period - AlgoFreq / ResonatorFreq );
            gyro.pd1.isNewPeriodPresent = false;
        }
        if ( t > 0.002 && gyro.pd2.isNewPeriodPresent == true )
        {
            Chart2->Series[1]->AddXY(t, gyro.pd2.Period - AlgoFreq / ResonatorFreq );
            gyro.pd2.isNewPeriodPresent = false;
        }

    }
    for ( int i = 0 ; i < Chart1->SeriesCount(); i++) Chart1->Series[i]->EndUpdate();
    for ( int i = 0 ; i < Chart2->SeriesCount(); i++) Chart2->Series[i]->EndUpdate();
    for ( int i = 0 ; i < Chart3->SeriesCount(); i++) Chart3->Series[i]->EndUpdate();
    Chart1->Repaint();
    Chart2->Repaint();
    Chart3->Repaint();
    Application->ProcessMessages();
}


//---------------------------------------------------------------------------
void calc_PeriodDetector1(TPeriodDetector1 *pd)
{
    if ( pd->x_old <= 0 && pd->x > 0 )
    {
        pd->Period    = pd->delta_x_r + (pd->fTacks - 1.0);
        pd->delta_x_r = pd->x / (pd->x - pd->x_old);
        pd->Period    = pd->Period + (1.0 - pd->delta_x_r);

        pd->fTacks = 0;
        pd->isNewPeriodPresent = true;
    }

    pd->x_old = pd->x;
    pd->fTacks = pd->fTacks + 1;
}

//---------------------------------------------------------------------------
void calc_PeriodDetector2(TGyro *gyro, TPeriodDetector2 *pd)
{
   // ---- ���������������� ������� -----
/*
    double a0 =  ANodeBuffer[zn];
    double a1 =  0.16666666 * ( - 11.0*ANodeBuffer[zn] + 18.0*ANodeBuffer[zn+1] - 9.0*ANodeBuffer[zn+2] + 2.0*ANodeBuffer[zn+3] );
    double a2 = -0.5        * ( -  2.0*ANodeBuffer[zn] +  5.0*ANodeBuffer[zn+1] - 4.0*ANodeBuffer[zn+2] +     ANodeBuffer[zn+3] );
    double a3 =  0.16666666 * ( -      ANodeBuffer[zn] +  3.0*ANodeBuffer[zn+1] - 3.0*ANodeBuffer[zn+2] +     ANodeBuffer[zn+3] );

    double Dest =  a0 + a1*t + a2*t*t + a3*t*t*t;
*/
   // -----

    int zn = 0;
/*
    double a1 =  0.16666666 * ( - 11.0*gyro->ANodeBuffer[zn] + 18.0*gyro->ANodeBuffer[zn+1] - 9.0*gyro->ANodeBuffer[zn+2] + 2.0*gyro->ANodeBuffer[zn+3] );
    double a2 = -0.5        * ( -  2.0*gyro->ANodeBuffer[zn] +  5.0*gyro->ANodeBuffer[zn+1] - 4.0*gyro->ANodeBuffer[zn+2] +     gyro->ANodeBuffer[zn+3] );
    double a3 =  0.16666666 * ( -      gyro->ANodeBuffer[zn] +  3.0*gyro->ANodeBuffer[zn+1] - 3.0*gyro->ANodeBuffer[zn+2] +     gyro->ANodeBuffer[zn+3] );
*/
    double a1 =  - 1.8333333333333333333333333333333*gyro->ANodeBuffer[zn] + 3.0*gyro->ANodeBuffer[zn+1] - 1.5*gyro->ANodeBuffer[zn+2] + 0.33333333333333333333333333333333*gyro->ANodeBuffer[zn+3];
    double a2 =    1.0000000000000000000000000000000*gyro->ANodeBuffer[zn] - 2.5*gyro->ANodeBuffer[zn+1] + 2.0*gyro->ANodeBuffer[zn+2] - 0.50000000000000000000000000000000*gyro->ANodeBuffer[zn+3];
    double a3 =  - 0.1666666666666666666666666666667*gyro->ANodeBuffer[zn] + 0.5*gyro->ANodeBuffer[zn+1] - 0.5*gyro->ANodeBuffer[zn+2] + 0.16666666666666666666666666666667*gyro->ANodeBuffer[zn+3];

    //double Dest_p = a1 + 2*a2*t   + 3*a3*t*t;
    // ---- �� �������� ����� ���� ----
/*
    double p1 = a1;
    double p2 = a1 + 2*a2 + 3*a3;
    if ( p1 > 0 && p2 <= 0 )
    {
        pd->Period    = pd->delta_x_r + (pd->fTacks - 1.0);
        pd->delta_x_r = p1 / (p1 - p2);
        pd->Period    = pd->Period + (1.0 - pd->delta_x_r);

        pd->fTacks = 0;
        pd->isNewPeriodPresent = true;
    }
    pd->fTacks = pd->fTacks + 1;
*/
    // ---- �� ������������� ----
    //double Dest_p = a1 + 2*a2*t   + 3*a3*t*t;
    a2 = a2 * 2.0;
    a3 = a3 * 3.0;
    double D  = a2*a2 - 4*a3*a1;   if ( D < 0 ) return;

    pd->x1 = (-a2 + sqrt(D)) / (2.0*a3);
    pd->x2 = (-a2 - sqrt(D)) / (2.0*a3);
    if ( pd->x2 <= 1.0 && pd->x2 >= 0.0 && pd->fTacks > 4 )
    {
        pd->Period    = (1.0 - pd->x2) + pd->delta_x_r + (pd->fTacks - 1);
        pd->delta_x_r = pd->x2;
        pd->fTacks = 0;
        pd->isNewPeriodPresent = true;
    }
    pd->fTacks = pd->fTacks + 1;

}

int counter  = 0;
int isInited = 0;
//---------------------------------------------------------------------------
void TForm1::Run(double inAntinode)
{
    gyro.inX   = inAntinode;
    gyro.pd1.x = inAntinode;
    // ----
    for ( int i = 64; i > 0; i--) gyro.ANodeBuffer[i] = gyro.ANodeBuffer[i-1];
    gyro.ANodeBuffer[0] = inAntinode;

    // ----

    if ( isInited == 1 )
    {
        calc_PeriodDetector1(&gyro.pd1);
        calc_PeriodDetector2(&gyro, &gyro.pd2);
    }

    if ( counter++ > 10 ) isInited = 1; 
}
//---------------------------------------------------------------------------
