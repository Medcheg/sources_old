//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_AlanResult.h"
//---------------------------------------------------------------------------
#pragma resource "*.dfm"
TfrmAlanResult *frmAlanResult;
//===========================================================================
/*void TfrmAlanResult_init() { Beep(); }
#pragma startup TfrmAlanResult_init 110 // default 100*/
//===========================================================================
//---------------------------------------------------------------------------
__fastcall TfrmAlanResult::TfrmAlanResult(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmAlanResult::FormActivate(TObject *Sender)
{
   Caption = "DiALab - " + Element->DefaultName + " - " + Element->Caption;
   DecimalSeparator = '.';
}
//---------------------------------------------------------------------------
void __fastcall TfrmAlanResult::FormShow(TObject *Sender)
{
    Caption = "DiALab - " + Element->DefaultName + " - " + Element->Caption;
}
//---------------------------------------------------------------------------
