//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "Unit_DebugWindow.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmDebugWindow *frmDebugWindow;
//===========================================================================
__fastcall TfrmDebugWindow::TfrmDebugWindow(TComponent* Owner)
    : TForm(Owner)
{
}

//===========================================================================
void __fastcall TfrmDebugWindow::FormShow(TObject *Sender)
{
   this->Left = Screen->Width - this->Width - 10;
   this->Top  = 54;
}
//===========================================================================
