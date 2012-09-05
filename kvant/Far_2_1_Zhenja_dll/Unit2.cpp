//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit2.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmShowWave *frmShowWave;
//---------------------------------------------------------------------------
__fastcall TfrmShowWave::TfrmShowWave(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TfrmShowWave::FormShow(TObject *Sender)
{
    Left = 10;
    Top  = 90;
}
//---------------------------------------------------------------------------
