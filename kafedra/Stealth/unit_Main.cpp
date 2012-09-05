//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "unit_Main.h"
//------------------------------------------------------------------------
#include "mpiGuardant.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
TStringList *ClickList;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
     ClickList = new TStringList;
     FirstPaint = true;
//     KeyBaseSetup();
}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormDestroy(TObject *Sender)
{
//     KeyBaseDelete();
     delete ClickList;
}

//---------------------------------------------------------------------------
void __fastcall TForm1::FormPaint(TObject *Sender)
{
   if (FirstPaint) {
      FirstPaint = false;
      if (!SecureKeyPressent) {
          ShowMessage("Nah");
          Close();
      }
   }
}
//---------------------------------------------------------------------------

void TForm1::FindFile(AnsiString dir, AnsiString mask, AnsiString ff)
{
}


