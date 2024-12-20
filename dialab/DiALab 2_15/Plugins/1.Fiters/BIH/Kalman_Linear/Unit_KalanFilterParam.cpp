//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_KalanFilterParam.h"
#include "mpiErrors_and_Warning.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TfrmKalanFilterParam *frmKalanFilterParam;

//===========================================================================
/*void TfrmKalanFilterParam_init() { Beep(); }
#pragma startup TfrmKalanFilterParam_init 110 // default 100*/
//===========================================================================
//---------------------------------------------------------------------------
__fastcall TfrmKalanFilterParam::TfrmKalanFilterParam(TComponent* Owner)
        : TfrmBaseDialog(Owner)
{
   RadioButton1->Checked = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmKalanFilterParam::RadioButton1Click(TObject *Sender)
{
       SetEnabledsAndDisabledsComponenets();
}

//---------------------------------------------------------------------------
void TfrmKalanFilterParam::SetEnabledsAndDisabledsComponenets()
{
       Label4      ->Enabled = !RadioButton1->Checked;
       eP11        ->Enabled = !RadioButton1->Checked;
       Label5      ->Enabled = !RadioButton1->Checked;
       eP12        ->Enabled = !RadioButton1->Checked;
       Label6      ->Enabled = !RadioButton1->Checked;
       eP22        ->Enabled = !RadioButton1->Checked;
       Label7      ->Enabled = !RadioButton1->Checked;
       Label8      ->Enabled = !RadioButton1->Checked;
       Label9      ->Enabled = !RadioButton1->Checked;
       Label11     ->Enabled = !RadioButton1->Checked;
       eN          ->Enabled = !RadioButton1->Checked;
}

//---------------------------------------------------------------------------
void __fastcall TfrmKalanFilterParam::FormShow(TObject *Sender) { TfrmBaseDialog::FormShow(Sender);

    RadioButton1->Checked =  *CalcFiltrWithBeginInit;
    RadioButton2->Checked = !*CalcFiltrWithBeginInit;
    eP11        ->Text    = FloatToStr(*p11);
    eP12        ->Text    = FloatToStr(*p12);
    eP22        ->Text    = FloatToStr(*p22);
    eN          ->Text    = FloatToStr(*N);
    ePFil       ->Text    = FloatToStr(*PFil);
}

//---------------------------------------------------------------------------
void __fastcall TfrmKalanFilterParam::bbOkClick(TObject *Sender) { TfrmBaseDialog::bbOkClick(Sender);

   bool Result = true;

   try {*p11  = StrToFloat(eP11->Text); } catch ( ... ) { Result = false; eP11 ->SetFocus(); eP11 ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*p12  = StrToFloat(eP12->Text); } catch ( ... ) { Result = false; eP12 ->SetFocus(); eP12 ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*p22  = StrToFloat(eP22->Text); } catch ( ... ) { Result = false; eP22 ->SetFocus(); eP22 ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*N    = StrToFloat(eN->Text);   } catch ( ... ) { Result = false; eN   ->SetFocus(); eN   ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*PFil = StrToFloat(ePFil->Text);} catch ( ... ) { Result = false; ePFil->SetFocus(); ePFil->SelectAll(); InputError_None_Digital_Value(Handle);}
   *CalcFiltrWithBeginInit = RadioButton1->Checked;

   if (Result) Close();
}
//---------------------------------------------------------------------------

