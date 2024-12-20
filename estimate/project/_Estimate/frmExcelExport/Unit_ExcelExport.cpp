//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_ExcelExport.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmExcelExport *frmExcelExport;
//---------------------------------------------------------------------------
__fastcall TfrmExcelExport::TfrmExcelExport(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TfrmExcelExport::FormActivate(TObject *Sender)
{
  Animate1->Active = true;
//  DecimalSeparator = '.';
}
//---------------------------------------------------------------------------


void __fastcall TfrmExcelExport::Set_CountData(int value)
{
  ProgressBar1->Max      = value;
  fPosition              = 0;
  ProgressBar1->Position = 0;
}

void __fastcall TfrmExcelExport::Set_Position(int value)
{
  fPosition              = value;
  ProgressBar1->Position = value;
}
