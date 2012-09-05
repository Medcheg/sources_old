//===========================================================================
               
#include <vcl.h>
#pragma hdrstop     

#include "Unit_BaseDialog_01.h"
//===========================================================================
#pragma link "Unit_BaseDialog"
#pragma resource "*.dfm"
TfrmBaseDialog1 *frmBaseDialog1;
//===========================================================================
//===========================================================================
__fastcall TfrmBaseDialog1::TfrmBaseDialog1(TComponent* Owner)
        : TfrmBaseDialog(Owner)
{
    BaseDialogFormStyle = bdfsNone;

    LabelArray[0] = ParamCaption1;    EditArray[0] = ParamEdit1;
    LabelArray[1] = ParamCaption2;    EditArray[1] = ParamEdit2;
    LabelArray[2] = ParamCaption3;    EditArray[2] = ParamEdit3;
    LabelArray[3] = ParamCaption4;    EditArray[3] = ParamEdit4;
    LabelArray[4] = ParamCaption5;    EditArray[4] = ParamEdit5;
    LabelArray[5] = ParamCaption6;    EditArray[5] = ParamEdit6;
    LabelArray[6] = ParamCaption7;    EditArray[6] = ParamEdit7;
    LabelArray[7] = ParamCaption8;    EditArray[7] = ParamEdit8;
}

void __fastcall TfrmBaseDialog1::Set_ParameteresCount(int aValue)
{
     if (aValue == 0) CheckBox2->Checked = true;

     fParameteresCount = aValue;

     for (int i = 0; i < fParameteresCount; i++) {
        LabelArray[i]->Visible = true;
        EditArray [i]->Visible = true;

        LabelArray[i]->Top = 8 + 40*i;
        EditArray [i]->Top = LabelArray[i]->Top + 16;

        if (BaseDialogFormStyle == bdfsFloatValues)
               EditArray [i]->Text = FloatToStr(*ValueArray[i]);
        if (BaseDialogFormStyle == bdfsIntegerValues)
               EditArray [i]->Text = IntToStr(int(*ValueArray[i]));
     }
}

void __fastcall TfrmBaseDialog1::bbOkClick(TObject *Sender) { TfrmBaseDialog::bbOkClick(Sender);

       bool Result = true;

     // --------- Проверка параметров диалога, если значения типа Float----------
         if (BaseDialogFormStyle == bdfsFloatValues) {
               for (int i = 0; i < fParameteresCount; i++) {
                      try   {*ValueArray[i] = StrToFloat(EditArray[i]->Text);}
                      catch ( ... ) {
                            Result = false;
                            EditArray[i]->SetFocus();
                            EditArray[i]->SelectAll();
                            InputError_None_Digital_Value(Handle);
                     }
               }
         }

     // --------- Проверка параметров диалога, если значения типа Integer ----------
         if (BaseDialogFormStyle == bdfsIntegerValues) {
               for (int i = 0; i < fParameteresCount; i++) {
                      try   {
                         *ValueArray[i] = StrToInt(EditArray[i]->Text);}
                      catch ( ... ) {
                            Result = false;
                            EditArray[i]->SetFocus();
                            EditArray[i]->SelectAll();
                            InputError_None_Integer_Value(Handle);
                     }
               }
         }

     // ---------- Проверка параметров диалога если он сумматор ----------
         if (BaseDialogFormStyle == bdfsSumator) {
               // ----
                  for (int i = 1; i <= EditArray[0]->Text.Length(); i++)
                      if (EditArray[0]->Text[i] != '+' && EditArray[0]->Text[i] != '-') Result = false;
               // ----
                  if (!Result) {
                         EditArray[0]->SetFocus();
                         EditArray[0]->SelectAll();
                         InputError_SumatorParam1(Handle);
                  }
               // ----
                  if (EditArray[0]->Text == "") {
                         InputError_SumatorParam2(Handle);
                         Result = false;
                  }
         }

     if (Result) Close();
}
//===========================================================================

void __fastcall TfrmBaseDialog1::FormShow(TObject *Sender) { TfrmBaseDialog::FormShow(Sender);

   // ---- Переставляем значения редакторов --------
     Set_ParameteresCount(fParameteresCount);
}
//===========================================================================


