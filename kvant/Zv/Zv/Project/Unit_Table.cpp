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
     Top         = aPos.y + 58;
}
//===========================================================================

void __fastcall TfrmTable::FormActivate(TObject *Sender)
{
     DecimalSeparator = '.';
}
//===========================================================================
void __fastcall TfrmTable::ToolButton1Click(TObject *Sender)
{
  // --- Параметры Save Диалога ----
    SaveDialog1->Filter     = "Table files (*.txt)|*.txt";
    SaveDialog1->Title      = "Save Table";
    SaveDialog1->InitialDir =  ExtractFilePath( Application -> ExeName );
    SaveDialog1->FileName   = "";

  if (SaveDialog1->Execute()){
         AnsiString aFileName = SaveDialog1->FileName;
         if (ExtractFileExt(aFileName) == "") aFileName = aFileName + ".txt";
       // ------
         TFileStream* FileStream;
         try { FileStream = new TFileStream(aFileName, fmCreate);
         } catch ( ... ) {
             MessageBox(NULL, " Cannot save data", " Write error ...", MB_OK|MB_ICONERROR|MB_APPLMODAL);
             return;
         }
       // ------

         AnsiString as0 = "\n";
         AnsiString as_ = "\t";
         for (int i =0; i < StringGrid1->RowCount; i++){
              AnsiString as1 = StringGrid1->Cells[0][i];
              AnsiString as2 = StringGrid1->Cells[1][i];
              FileStream->Write(as1.data(), as1.Length());
              FileStream->Write(as_.data(), as_.Length());

              FileStream->Write(as2.data(), as2.Length());
              FileStream->Write(as0.data(), as0.Length());
         }

       // ------
       delete FileStream;
  }
}
//===========================================================================

