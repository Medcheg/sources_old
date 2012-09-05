//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_BaseDialog_DSTFilters.h"
//---------------------------------------------------------------------------
#pragma link "Unit_BaseDialog"
#pragma link "Unit_BaseDialog"
#pragma link "Unit_BaseDialog"
#pragma resource "*.dfm"
TfrmBaseDialog_DSTFilters *frmBaseDialog_DSTFilters;
//===========================================================================
//---------------------------------------------------------------------------
__fastcall TfrmBaseDialog_DSTFilters::TfrmBaseDialog_DSTFilters(TComponent* Owner)
        : TfrmBaseDialog(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmBaseDialog_DSTFilters::bbOkClick(TObject *Sender) { TfrmBaseDialog::bbOkClick(Sender);

  Close();
}
//---------------------------------------------------------------------------
void __fastcall TfrmBaseDialog_DSTFilters::RadioButton1Click(
      TObject *Sender)
{
      eN    ->Enabled =  RadioButton1->Checked;
      Label3->Enabled =  RadioButton1->Checked;
      Label6->Enabled = !RadioButton1->Checked;
      eN1   ->Enabled = !RadioButton1->Checked;
      eN2   ->Enabled = !RadioButton1->Checked;
      Label7->Enabled = !RadioButton1->Checked;
}
//---------------------------------------------------------------------------

