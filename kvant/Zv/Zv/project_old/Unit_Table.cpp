//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "Unit_Table.h"
#include "Unit_Main.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmTable *frmTable;
//===========================================================================
__fastcall TfrmTable::TfrmTable(TComponent* Owner)
        : TForm(Owner)
{
}
//===========================================================================
void __fastcall TfrmTable::FormShow(TObject *Sender)
{
//     AnsiString as1 = "Высота цели";
//     AnsiString as2 = "Дальность обнаружения цели";

//     Width = StringGrid1->Canvas->TextWidth(as1) + 10 + StringGrid1->Canvas->TextWidth(as2) + 10 + 15;
     Height = 250;

//     StringGrid1->ColWidths[0] = StringGrid1->Canvas->TextWidth(as1) + 10;
//     StringGrid1->ColWidths[1] = StringGrid1->Canvas->TextWidth(as2) + 10;

//     StringGrid1->Cells[0][0] = as1;
//     StringGrid1->Cells[1][0] = as2;

     TPoint aPos = frmMain->ClientToScreen(Point(frmMain->Width - Width - 10, frmMain->cbWork->BoundsRect.Bottom)); //  + GetSystemMetrics(SM_CYCAPTION)
     Left        = aPos.x;
     Top         = aPos.y;
}
//===========================================================================

void __fastcall TfrmTable::FormActivate(TObject *Sender)
{
     DecimalSeparator = '.';
}
//===========================================================================
void __fastcall TfrmTable::ToolButton1Click(TObject *Sender)
{
  TFileStream *aFileStrem = new TFileStream("c:\\ww", fmCreate);


  for (int i = 0; i < StringGrid1->RowCount; i++)
       StringGrid1->Rows[i]->SaveToStream(aFileStrem);

  delete aFileStrem;



}
//===========================================================================
