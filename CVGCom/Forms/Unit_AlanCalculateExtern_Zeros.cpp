//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_AlanCalculateExtern_Zeros.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
Tfrm_AlanCalculateExtern_Zeros *frm_AlanCalculateExtern_Zeros;
//---------------------------------------------------------------------------
__fastcall Tfrm_AlanCalculateExtern_Zeros::Tfrm_AlanCalculateExtern_Zeros(TComponent* Owner)
	: TForm(Owner)
{
    ComboBox_array[0] = cbCorrectedParam;
    ComboBox_array[1] = cbPar1;
    ComboBox_array[2] = cbPar2;
    ComboBox_array[3] = cbPar3;
    ComboBox_array[4] = cbPar4;
    ComboBox_array[5] = cbPar5;
    ComboBox_array[6] = cbPar6;

    EditBox_array[0] = ePar0_Zero;
    EditBox_array[1] = ePar1_Zero;
    EditBox_array[2] = ePar2_Zero;
    EditBox_array[3] = ePar3_Zero;
    EditBox_array[4] = ePar4_Zero;
    EditBox_array[5] = ePar5_Zero;
    EditBox_array[6] = ePar6_Zero;
}
//---------------------------------------------------------------------------
void __fastcall Tfrm_AlanCalculateExtern_Zeros::Button1Click(TObject *Sender)
{
   for ( int i = 0; i < 6; i++)
   	    EditBox_array[i+1]->Text = "0.0";
}
//---------------------------------------------------------------------------
void __fastcall Tfrm_AlanCalculateExtern_Zeros::Button2Click(TObject *Sender)
{
    Close();
}
//---------------------------------------------------------------------------
