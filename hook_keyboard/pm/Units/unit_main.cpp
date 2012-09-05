//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unit_main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_Main *form_Main;
//---------------------------------------------------------------------------
__fastcall Tform_Main::Tform_Main(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall Tform_Main::FormCreate(TObject *Sender)
{
    Caption = "PM(Project Manager) - []";

    MainTable_draw();
}
//---------------------------------------------------------------------------

void Tform_Main::MainTable_draw()
{
    StringGrid1->RowHeights[0] = 21;    StringGrid1->ColWidths[0] = 19;     StringGrid1->Cells[0][0] = " id";
    StringGrid1->Objects[1][1] = Memo1;

     ((TMemo*)StringGrid1->Objects[1][1])->Lines

}
//---------------------------------------------------------------------------
