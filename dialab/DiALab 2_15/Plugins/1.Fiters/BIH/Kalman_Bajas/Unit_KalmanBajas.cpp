//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_KalmanBajas.h"
#include "mpiErrors_and_Warning.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TfrmKalmanBajasFilterParam *frmKalmanBajasFilterParam;
//===========================================================================
/*void TfrmKalmanBajasFilterParam_init() { Beep(); }
#pragma startup TfrmKalmanBajasFilterParam_init 110 // default 100*/
//===========================================================================
//---------------------------------------------------------------------------
__fastcall TfrmKalmanBajasFilterParam::TfrmKalmanBajasFilterParam(TComponent* Owner)
        : TfrmBaseDialog(Owner)
{
        RadioButton1->Checked = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmKalmanBajasFilterParam::RadioButton2Click(TObject *Sender)
{
       SetEnabledsAndDisabledsComponenets();
}

//---------------------------------------------------------------------------
void TfrmKalmanBajasFilterParam::SetEnabledsAndDisabledsComponenets()
{
      Label11->Enabled = !RadioButton1->Checked;
      eN     ->Enabled = !RadioButton1->Checked;
      Label4 ->Enabled = !RadioButton1->Checked;
      ePsi11 ->Enabled = !RadioButton1->Checked;
      ePsi12 ->Enabled = !RadioButton1->Checked;
      ePsi22 ->Enabled = !RadioButton1->Checked;
      Label5 ->Enabled = !RadioButton1->Checked;
      Label6 ->Enabled = !RadioButton1->Checked;
      Label7 ->Enabled = !RadioButton1->Checked;
      Label8 ->Enabled = !RadioButton1->Checked;
      Label9 ->Enabled = !RadioButton1->Checked;
      Label16->Enabled = !RadioButton1->Checked;
}



void __fastcall TfrmKalmanBajasFilterParam::FormShow(TObject *Sender) {  TfrmBaseDialog::FormShow(Sender);

    rbFiltrMethod1->Checked = (*FiltrMethod == 1);
    rbFiltrMethod2->Checked = (*FiltrMethod == 2);
    eAMax         ->Text    = FloatToStr(*AMax);
    eQm           ->Text    = FloatToStr(*Qm);
    eSigma_x     ->Text     = FloatToStr(*Sigma_x);


    ep1           ->Text    = FloatToStr(*p1);
    ep2           ->Text    = FloatToStr(*p2);
    ep3           ->Text    = FloatToStr(*p3);

    ep_11         ->Text    = FloatToStr(*pi_11);
    ep_12         ->Text    = FloatToStr(*pi_12);
    ep_13         ->Text    = FloatToStr(*pi_13);
    ep_21         ->Text    = FloatToStr(*pi_21);
    ep_22         ->Text    = FloatToStr(*pi_22);
    ep_23         ->Text    = FloatToStr(*pi_23);
    ep_31         ->Text    = FloatToStr(*pi_31);
    ep_32         ->Text    = FloatToStr(*pi_32);
    ep_33         ->Text    = FloatToStr(*pi_33);

    RadioButton1->Checked = !*CalcFiltrWithDSTFitr;
    RadioButton2->Checked =  *CalcFiltrWithDSTFitr;
    eN          ->Text    = FloatToStr(*N);
    ePsi11      ->Text    = FloatToStr(*psi11);
    ePsi12      ->Text    = FloatToStr(*psi12);
    ePsi22      ->Text    = FloatToStr(*psi22);
}
//---------------------------------------------------------------------------

void __fastcall TfrmKalmanBajasFilterParam::bbOkClick(TObject *Sender) { TfrmBaseDialog::bbOkClick(Sender);

   bool Result = true;

   try {*N    = StrToFloat(eN->Text);   } catch ( ... ) { Result = false; eN   ->SetFocus(); eN   ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*AMax    = StrToFloat(eAMax->Text);   } catch ( ... ) { Result = false; eAMax   ->SetFocus(); eAMax   ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*Qm    = StrToFloat(eQm->Text);   } catch ( ... ) { Result = false; eQm   ->SetFocus(); eQm   ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*Sigma_x    = StrToFloat(eSigma_x->Text);   } catch ( ... ) { Result = false; eSigma_x   ->SetFocus(); eSigma_x   ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*p1    = StrToFloat(ep1->Text);   } catch ( ... ) { Result = false; ep1   ->SetFocus(); ep1   ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*p2    = StrToFloat(ep2->Text);   } catch ( ... ) { Result = false; ep2   ->SetFocus(); ep2   ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*p3    = StrToFloat(ep3->Text);   } catch ( ... ) { Result = false; ep3   ->SetFocus(); ep3   ->SelectAll(); InputError_None_Digital_Value(Handle);}

   try {*pi_11 = StrToFloat(ep_11->Text);   } catch ( ... ) { Result = false; ep_11->SetFocus(); ep_11->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*pi_12 = StrToFloat(ep_12->Text);   } catch ( ... ) { Result = false; ep_12->SetFocus(); ep_12->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*pi_13 = StrToFloat(ep_13->Text);   } catch ( ... ) { Result = false; ep_13->SetFocus(); ep_13->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*pi_21 = StrToFloat(ep_21->Text);   } catch ( ... ) { Result = false; ep_21->SetFocus(); ep_21->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*pi_22 = StrToFloat(ep_22->Text);   } catch ( ... ) { Result = false; ep_22->SetFocus(); ep_22->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*pi_23 = StrToFloat(ep_23->Text);   } catch ( ... ) { Result = false; ep_23->SetFocus(); ep_23->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*pi_31 = StrToFloat(ep_31->Text);   } catch ( ... ) { Result = false; ep_31->SetFocus(); ep_31->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*pi_32 = StrToFloat(ep_32->Text);   } catch ( ... ) { Result = false; ep_32->SetFocus(); ep_32->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*pi_33 = StrToFloat(ep_33->Text);   } catch ( ... ) { Result = false; ep_33->SetFocus(); ep_33->SelectAll(); InputError_None_Digital_Value(Handle);}

   try {*psi11 = StrToFloat(ePsi11->Text);   } catch ( ... ) { Result = false; ePsi11->SetFocus(); ePsi11->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*psi12 = StrToFloat(ePsi12->Text);   } catch ( ... ) { Result = false; ePsi12->SetFocus(); ePsi12->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*psi22 = StrToFloat(ePsi22->Text);   } catch ( ... ) { Result = false; ePsi22->SetFocus(); ePsi22->SelectAll(); InputError_None_Digital_Value(Handle);}


   *FiltrMethod = ( rbFiltrMethod1->Checked ) ? 1 : 2;
   *CalcFiltrWithDSTFitr = !RadioButton1->Checked;

   if (Result) Close();
}
//---------------------------------------------------------------------------

