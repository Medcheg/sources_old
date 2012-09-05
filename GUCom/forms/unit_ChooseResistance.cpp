//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unit_ChooseResistance.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
Tform_ChooseResistance *form_ChooseResistance;
//---------------------------------------------------------------------------
__fastcall Tform_ChooseResistance::Tform_ChooseResistance(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall Tform_ChooseResistance::Button1Click(TObject *Sender)
{
    double R2  = StrToFloat(edit_R2->Text);
    double R3  = StrToFloat(edit_R3->Text);
    double R4  = StrToFloat(edit_R4->Text);
    double SF0 = StrToFloat(edit_SFo->Text);
    double SF  = StrToFloat(edit_SF->Text);
    double R4_new;

    double G   = 1 + (R3*R4/(R3+R4))/R2;

    R4_new = (G*SF0/SF - 1) * R2*R3 / ( R3 - R2*(G*SF0/SF - 1) );

    Label4->Caption = "R4(new) = " + FloatToStrF(R4_new, ffFixed, 20, 4);
}
//---------------------------------------------------------------------------
