//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_FiltrParam.h"
#include "mpiFILTRS.h"
#include "math.h"
#include "Unit_AchFch.h"
#include "Unit_DrawPerehodProcess.h"
#include "Unit_Wave.h"
#include "mpiDeclaration.h"
#include "mpiLibrary.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmFiltrParam *frmFiltrParam;
//---------------------------------------------------------------------------
__fastcall TfrmFiltrParam::TfrmFiltrParam(TComponent* Owner)
        : TForm(Owner)
{
    c0 = 3;
    c1 = 2;
    T0 = 1;
    EndCalcTime = 15;
    EndTimeCoefN = 5;
    A  = 0;
    W  = 0;
    Wave = NULL;
}
//---------------------------------------------------------------------------
void __fastcall TfrmFiltrParam::FormShow(TObject *Sender)
{
    Caption = ProjectCaption + "Параметры фильтров";


    efK1   ->Text = FloatToStr(Kalman->k1);
    efK2   ->Text = FloatToStr(Kalman->k2);
    efN    ->Text = IntToStr  (DST1   ->N);
    efT0   ->Text = FloatToStr(T0);
    efT    ->Text = FloatToStr(EndCalcTime);
    efEndTimeCoefN->Text = FloatToStr(EndTimeCoefN);

    RadioButton2->Checked = true;
}

bool TfrmFiltrParam::CheckInputValues()
{
  bool Result = true;

    try { Kalman->k1   = StrToFloat(efK1          ->Text); } catch ( ... ) { ShowWrongEdit(efK1); return false; }
    try { Kalman->k2   = StrToFloat(efK2          ->Text); } catch ( ... ) { ShowWrongEdit(efK2); return false; }
    try { DST1   ->N   = StrToInt  (efN           ->Text); } catch ( ... ) { ShowWrongEdit(efN ); return false; }
    try { T0           = StrToFloat(efT0          ->Text); } catch ( ... ) { ShowWrongEdit(efT0); return false; }
    try { EndCalcTime  = StrToFloat(efT           ->Text); } catch ( ... ) { ShowWrongEdit(efT ); return false; }
    try { EndTimeCoefN = StrToFloat(efEndTimeCoefN->Text); } catch ( ... ) { ShowWrongEdit(efEndTimeCoefN); return false; }

    DST11->N = DST1->N;
    DST33->N = DST1->N;
    DST3 ->N = DST1->N;
    DST4 ->N = DST1->N;
    DST5 ->N = DST1->N;
    
  return Result;
}
//---------------------------------------------------------------------------
void __fastcall TfrmFiltrParam::BitBtn1Click(TObject *Sender)
{
  bool Result = CheckInputValues();

 if (Result) Close();
}
//---------------------------------------------------------------------------

void __fastcall TfrmFiltrParam::FormCreate(TObject *Sender)
{
  Wave = new TWave (&aCurModelTime, &T0, "Параметры тестирования фильтров", rM, 0);
}
//---------------------------------------------------------------------------

void __fastcall TfrmFiltrParam::FormDestroy(TObject *Sender)
{
 if (Wave != NULL) delete Wave;
}
//---------------------------------------------------------------------------

void __fastcall TfrmFiltrParam::BitBtn3Click(TObject *Sender)
{
  if (!CheckInputValues()) return;

  TfrmWave *dlg;

  try {       dlg       = new TfrmWave(this);
              dlg->Wave = Wave;
              dlg->isRandomProcess->Enabled = false;
              dlg->ShowModal();
              }
  __finally { delete dlg;      }
}
//---------------------------------------------------------------------------

void __fastcall TfrmFiltrParam::ButtonClick(TObject *Sender)
{
    if (!CheckInputValues()) return;
  // ---------
    TfrmAchFch             *ACH_Form = NULL;
    TfrmDrawPerehodProcess *PP_Form  = NULL;  PP_Form = new TfrmDrawPerehodProcess(this); PP_Form->Init();
  // ---------
    int  NCounter = 1;
  // ---------
    DST11->Gamma = 1;
    DST33->Gamma = 1;

    DST1->Gamma = 0;
    DST3->Gamma = 0;
    DST4->Gamma = 0;
    DST5->Gamma = 0;

    DST11  ->Init(T0);
    DST33  ->Init(T0);

    Kalman->Init(T0);
    DST1  ->Init(T0);
    DST3  ->Init(T0);
    DST4  ->Init(T0);
    DST5  ->Init(T0);

  try {
        switch ( ((TControl*)Sender)->Tag ){
            case 10 : ACH_Form = new TfrmAchFch(this, T0, Kalman->ZCoef_Xe.a, 3, Kalman->ZCoef_Xe.b, 3);
                      ACH_Form->Caption = ProjectCaption + "АЧХ Екстраполяции положения цели фильтром Калмана"; ACH_Form->Show(); break;
            case 12 : ACH_Form = new TfrmAchFch(this, T0, Kalman->ZCoef_Xo.a, 3, Kalman->ZCoef_Xo.b, 3);
                      ACH_Form->Caption = ProjectCaption + "АЧХ оценки положения цели фильтром Калмана"; ACH_Form->Show(); break;
            case 14 : ACH_Form = new TfrmAchFch(this, T0, Kalman->ZCoef_pXo.a, 3, Kalman->ZCoef_pXo.b, 3);
                      ACH_Form->Caption = ProjectCaption + "АЧХ оценки скорости цели фильтром Калмана"; ACH_Form->Show(); break;

            /*for (int i = 123;  i < 123; i ++ ){
            }*/

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            case 20 : DST1->Gamma = 1; DST1  ->Init(T0);
                      ACH_Form = new TfrmAchFch(this, T0, DST1->ZCoef_Xe.a, DST1->N + 2 + 1, DST1->ZCoef_Xe.b, 3);
                      ACH_Form->Caption = ProjectCaption + "АЧХ DST фильтра екстраполяции положения цели"; ACH_Form->Show();  break;
            case 21 : ACH_Form = new TfrmAchFch(this, T0, DST1->ZCoef_Xe.a, DST1->N + 2 + 1, DST1->ZCoef_Xe.b, 3);
                      ACH_Form->Caption = ProjectCaption + "АЧХ DST фильтра оценки положения цели"; ACH_Form->Show();  break;
            case 22 : ACH_Form = new TfrmAchFch(this, T0, DST1->ZCoef_pXo.a, DST1->N + 2 + 1, DST1->ZCoef_pXo.b, 3);
                      ACH_Form->Caption = ProjectCaption + "АЧХ DST фильтра оценки скорости цели"; ACH_Form->Show(); break;

          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            case 30 : DST3->Gamma = 1; DST3  ->Init(T0);
                      ACH_Form = new TfrmAchFch(this, T0, DST3->a, DST3->N + 3 + 1, DST3->b, 4);
                      ACH_Form->Caption = ProjectCaption + "АЧХ DST фильтра екстраполяции положения цели"; ACH_Form->Show(); break;
            case 31 : ACH_Form = new TfrmAchFch(this, T0, DST3->a, DST3->N + 3 + 1, DST3->b, 4);
                      ACH_Form->Caption = ProjectCaption + "АЧХ DST фильтра оценки положения цели"; ACH_Form->Show(); break;
            case 32 : ACH_Form = new TfrmAchFch(this, T0, DST5->a, DST5->N + 3 + 1, DST5->b, 4);
                      ACH_Form->Caption = ProjectCaption + "АЧХ DST фильтра оценки скорости цели"; ACH_Form->Show(); break;
            case 33 : ACH_Form = new TfrmAchFch(this, T0, DST4->a, DST4->N + 3 + 1, DST4->b, 4);
                      ACH_Form->Caption = ProjectCaption + "АЧХ DST фильтра оценки ускорения цели"; ACH_Form->Show(); break;
            case 40 :
                 for (TFloat i = 0; i < EndCalcTime; i = i + T0) {
                            aCurModelTime = i;
                            Wave->Run();

                            if (NCounter <= EndTimeCoefN && RadioButton2->Checked) {
                                Kalman->k1  = 2*(2*NCounter - 1) / (TFloat)(NCounter * (NCounter + 1));
                                Kalman->k2  = 6 / (TFloat)(T0 * NCounter * (NCounter + 1));
                                NCounter ++;
                            }

                            Kalman->Run(Wave->Value);
                            DST1  ->Run(Wave->Value - Wave->WaveOptions.Polynom.c2*i*i - Wave->WaveOptions.Polynom.c3*i*i*i);
                            DST11 ->Run(Wave->Value - Wave->WaveOptions.Polynom.c2*i*i - Wave->WaveOptions.Polynom.c3*i*i*i);
                            DST3  ->Run(Wave->Value);
                            DST33 ->Run(Wave->Value);
                            DST4  ->Run(Wave->Value);
                            //if (i <= DST5->N*T0 + 0.000000001)
                            DST5->Run(Wave->Value - Wave->WaveOptions.Polynom.c2*i*i - Wave->WaveOptions.Polynom.c3*i*i*i);

                            PP_Form->Chart1->Series[0]->AddXY(i , Wave->Value, "", clRed);
                            PP_Form->Chart1->Series[1]->AddXY(i , Wave->Value, "", clRed);
                            PP_Form->Chart1->Series[2]->AddXY(i , Wave->WaveOptions.Polynom.c1, "", clRed);
                            PP_Form->Chart1->Series[3]->AddXY(i , Wave->Value, "", clRed);
                            PP_Form->Chart1->Series[4]->AddXY(i , Wave->Value, "", clRed);
                            PP_Form->Chart1->Series[5]->AddXY(i , Wave->WaveOptions.Polynom.c1, "", clRed);
                            PP_Form->Chart1->Series[6]->AddXY(i , Wave->Value, "", clRed);
                            PP_Form->Chart1->Series[7]->AddXY(i , Wave->Value, "", clRed);
                            if (i != 0) PP_Form->Chart1->Series[8]->AddXY(i-T0 , Wave->WaveOptions.Polynom.c1, "", clRed);
                            PP_Form->Chart1->Series[9]->AddXY(i , Wave->WaveOptions.Polynom.c2, "", clRed);

                            PP_Form->Chart1->Series[10]->AddXY(i , Kalman->Xe , "", clGreen);
                            PP_Form->Chart1->Series[11]->AddXY(i , Kalman->Xo , "", clGreen);
                            PP_Form->Chart1->Series[12]->AddXY(i , Kalman->pXo, "", clGreen);
                            PP_Form->Chart1->Series[13]->AddXY(i , DST11 ->Xe , "", clGreen);
                            PP_Form->Chart1->Series[14]->AddXY(i , DST1  ->Xe , "", clGreen);
                            PP_Form->Chart1->Series[15]->AddXY(i , DST1  ->pXo, "", clGreen);

                            PP_Form->Chart1->Series[16]->AddXY(i , DST33 ->Out, "", clGreen);
                            PP_Form->Chart1->Series[17]->AddXY(i , DST3  ->Out, "", clGreen);
                            if (i != 0) PP_Form->Chart1->Series[18]->AddXY(i-T0 , DST5  ->Out, "", clGreen);
                            PP_Form->Chart1->Series[19]->AddXY(i , DST4  ->Out, "", clGreen);
                 }
                 PP_Form->Caption = ProjectCaption + "Перходные процесы фильтров";
                 PP_Form->ShowModal(); break;
        }
  } catch ( ... ) {
        delete ACH_Form;
        delete PP_Form;
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmFiltrParam::RadioButton1Click(TObject *Sender)
{
     Label10->Enabled        = !RadioButton1->Checked;
     efEndTimeCoefN->Enabled = !RadioButton1->Checked;
//     Label12->Enabled        = !RadioButton1->Checked;

     efK1->Enabled   = RadioButton1->Checked;
     Label1->Enabled = RadioButton1->Checked;
     efK2->Enabled   = RadioButton1->Checked;
     Label2->Enabled = RadioButton1->Checked;

     Button5->Enabled = RadioButton1->Checked;
     Button3->Enabled = RadioButton1->Checked;
     Button1->Enabled = RadioButton1->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TfrmFiltrParam::RadioButton2Click(TObject *Sender)
{
     Label10->Enabled        = RadioButton2->Checked;
     efEndTimeCoefN->Enabled = RadioButton2->Checked;
//     Label12->Enabled        = RadioButton2->Checked;

     efK1->Enabled   = !RadioButton2->Checked;
     Label1->Enabled = !RadioButton2->Checked;
     efK2->Enabled   = !RadioButton2->Checked;
     Label2->Enabled = !RadioButton2->Checked;

     Button5->Enabled = !RadioButton2->Checked;
     Button3->Enabled = !RadioButton2->Checked;
     Button1->Enabled = !RadioButton2->Checked;
}
//---------------------------------------------------------------------------

