//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
                                                                                  
//---------------------------------------------------------------------------
#include "Unit_TargetMove.h"
#include "mpiErrors_and_Warning.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TfrmTargetMove *frmTargetMove;
//===========================================================================
/*void TfrmTargetMove_init() { Beep(); }
#pragma startup TfrmTargetMove_init 110 // default 100*/
//===========================================================================
//---------------------------------------------------------------------------
__fastcall TfrmTargetMove::TfrmTargetMove(TComponent* Owner)
        : TfrmBaseDialog(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmTargetMove::FormShow(TObject *Sender) { TfrmBaseDialog::FormShow(Sender);
        eH0    ->Text = FloatToStr(*H0);
        eBetta0->Text = FloatToStr(*Betta0 * 180.0 / pi);
        eV0    ->Text = FloatToStr(*V0);
        eR0    ->Text = FloatToStr(*R0);
        eK0    ->Text = FloatToStr(*K0 * 180.0 / pi);       
        et1    ->Text = FloatToStr(*t1);
        eGLoad ->Text = FloatToStr(*GLoad);
        efi    ->Text = FloatToStr(*fi * 180.0 / pi);
//        eRadius->Text = FloatToStr(*radius);
        eA1    ->Text = FloatToStr(*a1);
        eA3    ->Text = FloatToStr(*a3);

        eSigma1->Text = FloatToStr(*sigma1);
        eSigma2->Text = FloatToStr(*sigma2);
        eSigma3->Text = FloatToStr(*sigma3 * 180.0 / pi);

/*
    eP11        ->Text    = FloatToStr(*11);
    eP12        ->Text    = FloatToStr(*p12);
    eP22        ->Text    = FloatToStr(*p22);
    eN          ->Text    = FloatToStr(*N);
    ePFil       ->Text    = FloatToStr(*PFil);
*/
}
//---------------------------------------------------------------------------

void __fastcall TfrmTargetMove::bbOkClick(TObject *Sender){ TfrmBaseDialog::bbOkClick(Sender);
   bool Result = true;

   try {*H0      = StrToFloat(eH0->Text);     } catch ( ... ) { Result = false; eH0->SetFocus();     eH0->SelectAll();     InputError_None_Digital_Value(Handle);}
   try {*Betta0  = StrToFloat(eBetta0->Text); } catch ( ... ) { Result = false; eBetta0->SetFocus(); eBetta0->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*V0      = StrToFloat(eV0->Text);     } catch ( ... ) { Result = false; eV0->SetFocus();     eV0->SelectAll();     InputError_None_Digital_Value(Handle);}
   try {*R0      = StrToFloat(eR0->Text);     } catch ( ... ) { Result = false; eR0->SetFocus();     eR0->SelectAll();     InputError_None_Digital_Value(Handle);}
   try {*K0      = StrToFloat(eK0->Text);     } catch ( ... ) { Result = false; eK0->SetFocus();     eK0->SelectAll();     InputError_None_Digital_Value(Handle);}
   try {*t1      = StrToFloat(et1->Text);     } catch ( ... ) { Result = false; et1->SetFocus();     et1->SelectAll();     InputError_None_Digital_Value(Handle);}
   try {*GLoad   = StrToFloat(eGLoad->Text);  } catch ( ... ) { Result = false; eGLoad->SetFocus();  eGLoad->SelectAll();  InputError_None_Digital_Value(Handle);}
   try {*fi      = StrToFloat(efi->Text);     } catch ( ... ) { Result = false; efi->SetFocus();     efi->SelectAll();     InputError_None_Digital_Value(Handle);}
//   try {*radius  = StrToFloat(eRadius->Text); } catch ( ... ) { Result = false; eRadius->SetFocus(); eRadius->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*a1      = StrToFloat(eA1->Text);     } catch ( ... ) { Result = false; eA1->SetFocus();     eA1->SelectAll();     InputError_None_Digital_Value(Handle);}
   try {*a3      = StrToFloat(eA3->Text);     } catch ( ... ) { Result = false; eA3->SetFocus();     eA3->SelectAll();     InputError_None_Digital_Value(Handle);}
   try {*sigma1  = StrToFloat(eSigma1->Text); } catch ( ... ) { Result = false; eSigma1->SetFocus(); eSigma1->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*sigma2  = StrToFloat(eSigma2->Text); } catch ( ... ) { Result = false; eSigma2->SetFocus(); eSigma2->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*sigma3  = StrToFloat(eSigma3->Text); } catch ( ... ) { Result = false; eSigma3->SetFocus(); eSigma3->SelectAll(); InputError_None_Digital_Value(Handle);}


   *Betta0 = *Betta0 * pi / 180.0;
   *K0     = *K0 * pi / 180.0;
   *fi     = *fi * pi / 180.0;
   *sigma3 = *sigma3 * pi / 180.0;

   if (Result) Close();
}
//---------------------------------------------------------------------------

