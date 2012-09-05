//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "Unit_TargetsParam.h"
#include "mpiDeclaration.h"
#include "Unit_Main.h"
#include "Unit_TargetIndicator.h"
//===========================================================================
#pragma package(smart_init)
#pragma link "FloatEdit"
#pragma link "IntEdit"
#pragma link "GradusEdit"
#pragma resource "*.dfm"
TfrmTargetsParam *frmTargetsParam;
//===========================================================================
__fastcall TfrmTargetsParam::TfrmTargetsParam(TComponent* Owner)
        : TForm(Owner)
{
}
//===========================================================================

void __fastcall TfrmTargetsParam::FormShow(TObject *Sender)
{
    Caption = ProjectCaption + "ѕараметры целей";

  // ------- ¬ыставл€ю длину ToolBara ---------
    ToolBar1->Width = 2;
    for (int i = 0; i < ToolBar1->ButtonCount; i++) ToolBar1->Width += ToolBar1->Buttons[i]->Width;
    ToolBar1->Width += 2;
  // ------- «аполн€ю ListBox -----------
    ListBox1->Clear();
    for (int i = 0; i < Targets_Count; i++) {
        AnsiString asTargetId;

        if (Targets[i]->id < 10 )  asTargetId = "00" + IntToStr(Targets[i]->id);
        if (Targets[i]->id >  100) asTargetId = IntToStr(Targets[i]->id);
        if (Targets[i]->id >= 10  && Targets[i]->id < 100 ) asTargetId = "0" + IntToStr(Targets[i]->id);

        ListBox1->Items->AddObject("  “расса є " + asTargetId, (TObject*)Targets[i]);
    }
  // -------------------------------------
    TargetEdit          = false;
    ListBox1->ItemIndex = -1;
    EnabledDisabledComponents(false);
}
//===========================================================================

void __fastcall TfrmTargetsParam::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmTargetsParam::ListBox1Click(TObject *Sender)
{
   if (ListBox1->ItemIndex == -1) {EnabledDisabledComponents(false); return;}

     EnabledDisabledComponents(true);
   // ----------------
     TTarget *aTarget = (TTarget*) ListBox1->Items->Objects[ListBox1->ItemIndex];

     efR0   ->Set_Float_Value (aTarget->R0);
     efV0   ->Set_Float_Value (aTarget->V0);
     efH0   ->Set_Float_Value (aTarget->H0);
     eiId   ->Set_Int_Value   (aTarget->id);
     egrB0  ->Set_Gradus_Value(aTarget->B0);
     egrK0  ->Set_Gradus_Value(aTarget->K0);
   // ----------------
     EditParamTarget(false);
}

void TfrmTargetsParam::EnabledDisabledComponents(bool aFlag)
{
    Label3 ->Enabled = aFlag;
    efR0   ->Enabled = aFlag;
    Label4 ->Enabled = aFlag;
    Label5 ->Enabled = aFlag;
    efV0   ->Enabled = aFlag;
    Label6 ->Enabled = aFlag;
    efH0   ->Enabled = aFlag;
    Label7 ->Enabled = aFlag;
    eiId   ->Enabled = aFlag;
    Label8 ->Enabled = aFlag;
    Label9 ->Enabled = aFlag;
    Label10->Enabled = aFlag;
    Label11->Enabled = aFlag;
    Label12->Enabled = aFlag;
    Label13->Enabled = aFlag;
    egrB0  ->Enabled = aFlag;
    egrK0  ->Enabled = aFlag;
  // ------------
    if (!aFlag) {
       efR0   ->Text = "----------------------------------";
       efV0   ->Text = "----------------------------------";
       efH0   ->Text = "----------------------------------";
       eiId   ->Text = "----------------------------------";
       egrB0  ->Text = "----------------------------------";
       egrK0  ->Text = "----------------------------------";
       tbDeleteTarget->Enabled = false;

       EditParamTarget(false);
    }

}

void TfrmTargetsParam::EditParamTarget(bool aFlag)
{
    TargetEdit = aFlag;
  // -------
    BitBtn4->Visible = TargetEdit;
    BitBtn3->Visible = TargetEdit;
  // -------
    BitBtn1->Enabled = !TargetEdit;
    Bevel3->Enabled = !TargetEdit;
    ListBox1->Enabled = !TargetEdit;
    ToolBar1->Enabled = !TargetEdit;

    if (ListBox1->ItemIndex == -1) tbDeleteTarget->Enabled = false; else tbDeleteTarget->Enabled = true;

    tbAddTarget->Enabled = !TargetEdit;
    Label1->Enabled = !TargetEdit;
}

//===========================================================================
void __fastcall TfrmTargetsParam::eChange(TObject *Sender) { EditParamTarget(true); }
void __fastcall TfrmTargetsParam::BitBtn4Click(TObject *Sender) { EditParamTarget(false); ListBox1Click(NULL); }
void __fastcall TfrmTargetsParam::FormCloseQuery(TObject *Sender, bool &CanClose) { CanClose = !TargetEdit; }
//===========================================================================


void __fastcall TfrmTargetsParam::BitBtn3Click(TObject *Sender)
{
   bool Result = true;

     TTarget *aTarget = (TTarget*) ListBox1->Items->Objects[ListBox1->ItemIndex];

     efR0   ->Get_Float_Value (&aTarget->R0, &Result); if (!Result) {return;}
     efV0   ->Get_Float_Value (&aTarget->V0, &Result); if (!Result) {return;}
     efH0   ->Get_Float_Value (&aTarget->H0, &Result); if (!Result) {return;}
     eiId   ->Get_Int_Value   (&aTarget->id, &Result); if (!Result) {return;}
     egrB0  ->Get_Gradus_Value(&aTarget->B0, &Result); if (!Result) {return;}
     egrK0  ->Get_Gradus_Value(&aTarget->K0, &Result); if (!Result) {return;}

 // ---------- ¬ыставл€ю јйдишник --------
    AnsiString asTargetId;
    if (aTarget->id < 10 )  asTargetId = "00" + IntToStr(aTarget->id);
    if (aTarget->id >  100) asTargetId = IntToStr(aTarget->id);
    if (aTarget->id >= 10 && aTarget->id < 100 ) asTargetId = "0" + IntToStr(aTarget->id);

    ListBox1->Items->Strings[ListBox1->ItemIndex] = "  “расса є " + asTargetId;
    aTarget->Indicator_Name = "„-" + asTargetId;
   if (Result) EditParamTarget(false);
}
//===========================================================================

void __fastcall TfrmTargetsParam::tbAddTargetClick(TObject *Sender)
{
    Targets_Count ++;
    Targets = (TTarget **) realloc (Targets, sizeof(TTarget *) * Targets_Count);
    Targets[Targets_Count - 1] = new TTarget(&FarParam);

  // ---------------- ќпредел€ю максимальный јйƒи --------
    int MaxId = -1;
    Targets[Targets_Count - 1]->id = -1;
    for (int i = 0; i < Targets_Count; i ++)
          if (MaxId < Targets[i]->id)
                MaxId = Targets[i]->id;

  // ---------------- ¬иставл€ю парамы ---------
    Targets[Targets_Count - 1]->R0 = 10;
    Targets[Targets_Count - 1]->B0 = 0;
    Targets[Targets_Count - 1]->V0 = 0.20;
    Targets[Targets_Count - 1]->H0 = 10;
    Targets[Targets_Count - 1]->K0 = 0;
    Targets[Targets_Count - 1]->id = MaxId + 1;

    AnsiString asTargetId;

    if (Targets[Targets_Count - 1]->id < 10 )  asTargetId = "00" + IntToStr(Targets[Targets_Count - 1]->id);
    if (Targets[Targets_Count - 1]->id >  100) asTargetId = "0"  + IntToStr(Targets[Targets_Count - 1]->id);
    if (Targets[Targets_Count - 1]->id >= 10  && Targets[Targets_Count - 1]->id < 100 ) asTargetId = "0" + IntToStr(Targets[Targets_Count - 1]->id);

    ListBox1->Items->AddObject("  “расса є " + asTargetId, (TObject*)Targets[Targets_Count - 1]);

    ListBox1->ItemIndex = ListBox1->Items->Count - 1;
    ListBox1Click(Sender);
}
//===========================================================================

void __fastcall TfrmTargetsParam::tbDeleteTargetClick(TObject *Sender)
{
    if (ListBox1->ItemIndex == -1) return;
  // ----
    delete Targets[ListBox1->ItemIndex];
  // ----
    for (int i = ListBox1->ItemIndex;  i < Targets_Count - 1; i++)
             Targets[i] = Targets[i + 1];
  // ----
    Targets_Count --;
  // ----
//    Targets = (TTarget **) malloc ( sizeof(TTarget *) * Targets_Count);
    Targets = (TTarget **) realloc (Targets, sizeof(TTarget*)*Targets_Count);
  // ----
    FormShow(Sender);
//    ListBox1->ItemIndex = -1;
//    ListBox1Click(Sender);
}
//===========================================================================


