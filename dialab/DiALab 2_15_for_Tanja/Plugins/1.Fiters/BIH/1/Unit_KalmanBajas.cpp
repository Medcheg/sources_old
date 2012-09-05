//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_KalmanBajasFilterParam.h"
#include "mpiErrors_and_Warning.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmKalmanBajasFilterParam *frmKalmanBajasFilterParam;
//---------------------------------------------------------------------------
__fastcall TfrmKalmanBajasFilterParam::TfrmKalmanBajasFilterParam(TComponent* Owner)
        : TfrmBaseDialog(Owner)
{
        RadioButton1->Checked = true;

/*
         bool       CalcFiltrWithBeginInit;  // -- ���� ��, �� ������ � ��������� ������� ���������� ���������� ---
         TFloat     N;                       // --- ���������� ����� ��������� ���������� ����������
         TFloat  ppXk[3];                    // --- ������� ������������ �������� ------

      // ---- ���������� ������� -------

         TFloat   Xke_oc[3][2];     // ---- ������ ����������������� �������� ������� ������� ------
         TFloat  pXke_oc[3][2];     // ---- ������ ����������������� �������� ������� ������� ------

         TFloat  Xk_oc [3][2];  // ---- ������ ������� ������� ------
         TFloat  pXk_oc[3][2];  // ---- ������ ������� ������� ------

         TFloat psi_e11[3][2];    // ---- ����������������� �������� ������������� �������������� ������� -----
         TFloat psi_e12[3][2];    // ---- ����������������� �������� ������������� �������������� ������� -----
         TFloat psi_e22[3][2];    // ---- ����������������� �������� ������������� �������������� ������� -----

         TFloat psi_11 [3][2];    // ---- �������� ������������� �������������� ������� -----
         TFloat psi_12 [3][2];    // ---- �������� ������������� �������������� ������� -----
         TFloat psi_22 [3][2];    // ---- �������� ������������� �������������� ������� -----

      // ---- ��������� ������ -----
         TFloat    X_out_sr;      // ---- ����������� ������ ���������� ���������------
         TFloat   pX_out_sr;      // ---- ����������� ������ ���������� �������� ------
         TFloat  ppX_out_sr;      // ---- ����������� ������ ���������� ��������� ------
         TFloat  psi_11_sr;       // ---- ����������� �����, ������� ������ ���������� ------
         TFloat  psi_12_sr;       // ---- ����������� �����, ������� ������ ���������� ------
         TFloat  psi_22_sr;       // ---- ����������� �����, ������� ������ ���������� ------

      // ----
         TFloat     NULLValue[4];
         int        InputCounter;
         TFloat     DeltaT, OldTime;
*/
}

//---------------------------------------------------------------------------
void __fastcall TfrmKalmanBajasFilterParam::RadioButton1Click(TObject *Sender)
{
       SetEnabledsAndDisabledsComponenets();
}

//---------------------------------------------------------------------------
void TfrmKalmanBajasFilterParam::SetEnabledsAndDisabledsComponenets()
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



void __fastcall TfrmKalmanBajasFilterParam::FormShow(TObject *Sender)
{
    RadioButton1->Checked =  *CalcFiltrWithBeginInit;
    RadioButton2->Checked = !*CalcFiltrWithBeginInit;
//    eP11        ->Text    = FloatToStr(*p11);
//    eP12        ->Text    = FloatToStr(*p12);
//    eP22        ->Text    = FloatToStr(*p22);
    eN          ->Text    = FloatToStr(*N);
//    ePFil       ->Text    = FloatToStr(*PFil);
}
//---------------------------------------------------------------------------

void __fastcall TfrmKalmanBajasFilterParam::bbOkClick(TObject *Sender) { TfrmBaseDialog::bbOkClick(Sender);

   bool Result = true;

//   try {*p11  = StrToFloat(eP11->Text); } catch ( ... ) { Result = false; eP11 ->SetFocus(); eP11 ->SelectAll(); InputError_None_Digital_Value(Handle);}
//   try {*p12  = StrToFloat(eP12->Text); } catch ( ... ) { Result = false; eP12 ->SetFocus(); eP12 ->SelectAll(); InputError_None_Digital_Value(Handle);}
//   try {*p22  = StrToFloat(eP22->Text); } catch ( ... ) { Result = false; eP22 ->SetFocus(); eP22 ->SelectAll(); InputError_None_Digital_Value(Handle);}
   try {*N    = StrToFloat(eN->Text);   } catch ( ... ) { Result = false; eN   ->SetFocus(); eN   ->SelectAll(); InputError_None_Digital_Value(Handle);}
//   try {*PFil = StrToFloat(ePFil->Text);} catch ( ... ) { Result = false; ePFil->SetFocus(); ePFil->SelectAll(); InputError_None_Digital_Value(Handle);}
   *CalcFiltrWithBeginInit = RadioButton1->Checked;

   if (Result) Close();
}
//---------------------------------------------------------------------------

