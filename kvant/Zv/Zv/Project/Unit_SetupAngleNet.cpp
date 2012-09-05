//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "Unit_SetupAngleNet.h"
#include "Unit_Main.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmSetupAngleNet *frmSetupAngleNet;
//===========================================================================
__fastcall TfrmSetupAngleNet::TfrmSetupAngleNet(TComponent* Owner)
        : TForm(Owner)
{
   AnglesTickCount = 33;

   AnglesTick = (TAnglesTick*) malloc (sizeof(TAnglesTick) * AnglesTickCount);

   AnglesTick[ 0].Value = 0.1;     AnglesTick[ 0].Visible = true;
   AnglesTick[ 1].Value = 0.2;     AnglesTick[ 1].Visible = true;
   AnglesTick[ 2].Value = 0.3;     AnglesTick[ 2].Visible = true;
   AnglesTick[ 3].Value = 0.4;     AnglesTick[ 3].Visible = true;
   AnglesTick[ 4].Value = 0.5;     AnglesTick[ 4].Visible = true;
   AnglesTick[ 5].Value = 0.6;     AnglesTick[ 5].Visible = true;
   AnglesTick[ 6].Value = 0.7;     AnglesTick[ 6].Visible = true;
   AnglesTick[ 7].Value = 0.8;     AnglesTick[ 7].Visible = true;
   AnglesTick[ 8].Value = 0.9;     AnglesTick[ 8].Visible = true;
   AnglesTick[ 9].Value = 1.0;     AnglesTick[ 9].Visible = true;
   AnglesTick[10].Value = 1.2;     AnglesTick[10].Visible = true;
   AnglesTick[11].Value = 1.4;     AnglesTick[11].Visible = true;
   AnglesTick[12].Value = 1.6;     AnglesTick[12].Visible = true;
   AnglesTick[13].Value = 1.8;     AnglesTick[13].Visible = true;
   AnglesTick[14].Value = 2.0;     AnglesTick[14].Visible = true;
   AnglesTick[15].Value = 2.5;     AnglesTick[15].Visible = true;
   AnglesTick[16].Value = 3.0;     AnglesTick[16].Visible = true;
   AnglesTick[17].Value = 3.5;     AnglesTick[17].Visible = false;
   AnglesTick[18].Value = 4.0;     AnglesTick[18].Visible = true;
   AnglesTick[19].Value = 5.0;     AnglesTick[19].Visible = true;
   AnglesTick[20].Value = 6.0;     AnglesTick[20].Visible = false;
   AnglesTick[21].Value = 7.0;     AnglesTick[21].Visible = false;
   AnglesTick[22].Value = 8.0;     AnglesTick[22].Visible = false;
   AnglesTick[23].Value = 9.0;     AnglesTick[23].Visible = false;
   AnglesTick[24].Value = 10.0;    AnglesTick[24].Visible = true;
   AnglesTick[25].Value = 20.0;    AnglesTick[25].Visible = false;
   AnglesTick[26].Value = 30.0;    AnglesTick[26].Visible = false;
   AnglesTick[27].Value = 40.0;    AnglesTick[27].Visible = false;
   AnglesTick[28].Value = 50.0;    AnglesTick[28].Visible = false;
   AnglesTick[29].Value = 60.0;    AnglesTick[29].Visible = false;
   AnglesTick[30].Value = 70.0;    AnglesTick[30].Visible = false;
   AnglesTick[31].Value = 80.0;    AnglesTick[31].Visible = false;
   AnglesTick[32].Value = 90.0;    AnglesTick[32].Visible = true;

//   for (int i = 0; i < AnglesTickCount; i++) AnglesTick[i].IndexInMainArray = i;
}

//===========================================================================
void TfrmSetupAngleNet::AddAndSortItemsListBox()
{
  CurAngleTick = NULL;

  ListBox1->Items->Clear();
  ListBox1->Items->BeginUpdate();
     // -------------
        for (int i = 0; i < AnglesTickCount; i ++){
             for (int k = i; k < AnglesTickCount; k ++){
                  if (AnglesTick[i].Value > AnglesTick[k].Value) {
                      TAnglesTick TempTick = AnglesTick[i];
                      AnglesTick[i]        = AnglesTick[k];
                      AnglesTick[k]        = TempTick;
                  }
             }
             ListBox1->Items->AddObject(FloatToStrF(AnglesTick[i].Value, ffFixed, 20, 2), (TObject*)&AnglesTick[i]);
        }
     // -------------
  ListBox1->Items->EndUpdate();
}

//===========================================================================
void TfrmSetupAngleNet::SetNewArrayAglesTick()
{
    AnglesTickCount = ListBox1->Items->Count;
    TAnglesTick  *NewTickArray = (TAnglesTick*) malloc (sizeof(TAnglesTick) * AnglesTickCount);

    for (int i = 0; i < ListBox1->Items->Count; i ++)
        NewTickArray[i] = *(TAnglesTick*)ListBox1->Items->Objects[i];


    free (AnglesTick);  AnglesTick = NewTickArray;
}

//===========================================================================
void __fastcall TfrmSetupAngleNet::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmSetupAngleNet::FormDestroy(TObject *Sender)
{
  free (AnglesTick);
}
//===========================================================================
void __fastcall TfrmSetupAngleNet::FormShow(TObject *Sender)
{
  AddAndSortItemsListBox();
}
//===========================================================================
void __fastcall TfrmSetupAngleNet::ListBox1Click(TObject *Sender)
{
     if (ListBox1->ItemIndex == -1) return;

     CurAngleTick = (TAnglesTick*)ListBox1->Items->Objects[ListBox1->ItemIndex];

     Edit1    ->Text    = FloatToStrF(CurAngleTick->Value, ffFixed, 20, 2);
     CheckBox1->Checked = CurAngleTick->Visible;

     bool flag = false;

     Label2->Enabled = !flag;
     Edit1 ->Enabled = !flag;
     Label3->Enabled = !flag;
     CheckBox1->Enabled = !flag;

     tbDeleteTick->Enabled = true;
}
//===========================================================================

void TfrmSetupAngleNet::EditedParam(bool flag)
{
/*    ListBox1->Enabled = !flag;

    CheckBox1   ->Enabled = flag;
    tbDeleteTick->Enabled = flag;
    Label2      ->Enabled = flag;
    Edit1       ->Enabled = flag;
    CheckBox1   ->Enabled = flag;
    Label3      ->Enabled = flag;

    bbApply->Visible = flag;
    bbCancel->Visible = flag;

    BitBtn1->Enabled = !flag;
    BitBtn2->Enabled = !flag;*/
}

void __fastcall TfrmSetupAngleNet::tbDeleteTickClick(TObject *Sender)
{
//    Caption = ListBox1->ItemIndex;

    if (ListBox1->ItemIndex == -1) return;
  // --------
    CurAngleTick = NULL;

    ListBox1->Items->Delete(ListBox1->ItemIndex);

    SetNewArrayAglesTick();
    AddAndSortItemsListBox();
  // --------

    Edit1       ->Text    = "";
    ListBox1    ->ItemIndex = -1;
    tbDeleteTick->Enabled = false;
    CurAngleTick          = NULL;
  // --------

    frmMain->Repaint();
}

//===========================================================================
void __fastcall TfrmSetupAngleNet::CheckBox1Click(TObject *Sender)
{
    if (CurAngleTick != NULL )CurAngleTick->Visible = CheckBox1->Checked;
    frmMain->Repaint();
}

//===========================================================================
void __fastcall TfrmSetupAngleNet::Edit1KeyDown(TObject *Sender, WORD &Key,
      TShiftState Shift)
{
  bool flag = false;

  BitBtn1     ->Enabled = flag;
  BitBtn2     ->Enabled = flag;
  ListBox1    ->Enabled = flag;
  tbDeleteTick->Enabled = flag;
  tbAddTick   ->Enabled = flag;


  Label2->Enabled = !flag;
  Edit1 ->Enabled = !flag;
  Label3->Enabled = !flag;
  bbApply->Visible = !flag;
  bbCancel->Visible = !flag;

}

//===========================================================================
void __fastcall TfrmSetupAngleNet::bbCancelClick(TObject *Sender)
{
  bool flag = true;

  BitBtn1     ->Enabled = flag;
  BitBtn2     ->Enabled = flag;
  ListBox1    ->Enabled = flag;
  tbDeleteTick->Enabled = flag;
  tbAddTick   ->Enabled = flag;

  Label2->Enabled = !flag;
  Edit1 ->Enabled = !flag;
  Label3->Enabled = !flag;
  bbApply->Visible = !flag;
  bbCancel->Visible = !flag;

  ListBox1    ->ItemIndex = -1;
  tbDeleteTick->Enabled = false;
  CurAngleTick          = NULL;

  ListBox1Click(Sender);
}

//===========================================================================
void __fastcall TfrmSetupAngleNet::FormCloseQuery(TObject *Sender, bool &CanClose)
{
    CanClose = BitBtn1->Enabled;
}
//===========================================================================
void __fastcall TfrmSetupAngleNet::tbAddTickClick(TObject *Sender)
{
       CurAngleTick = NULL;
   // ------
       Edit1->Text        = "0.0";
       CheckBox1->Checked = true;
   // ------
      Edit1KeyDown(Sender, 0, TShiftState());
}

//===========================================================================
void __fastcall TfrmSetupAngleNet::bbApplyClick(TObject *Sender)
{
   // ---------- Проверка ввода ----------
      if (CurAngleTick == NULL) CurAngleTick = (TAnglesTick*) malloc (sizeof(TAnglesTick));

      CurAngleTick->Value   = StrToFloat (Edit1->Text);
      CurAngleTick->Visible = CheckBox1->Checked;

      ListBox1->Items->AddObject(FloatToStrF(CurAngleTick->Value, ffFixed, 20, 2), (TObject*)CurAngleTick);

      SetNewArrayAglesTick();
      AddAndSortItemsListBox();
  // ---------- Проверка ввода ----------

  bool flag = true;

  BitBtn1     ->Enabled = flag;
  BitBtn2     ->Enabled = flag;
  ListBox1    ->Enabled = flag;
  tbDeleteTick->Enabled = flag;
  tbAddTick   ->Enabled = flag;

  Label2->Enabled = !flag;
  Edit1 ->Enabled = !flag;
  Label3->Enabled = !flag;
  bbApply->Visible = !flag;
  bbCancel->Visible = !flag;

  ListBox1    ->ItemIndex = -1;
  tbDeleteTick->Enabled = false;
  CurAngleTick          = NULL;

  frmMain->Repaint();
}

//===========================================================================


//---------------------------------------------------------------------------


void __fastcall TfrmSetupAngleNet::ListBox1KeyDown(TObject *Sender,
      WORD &Key, TShiftState Shift)
{
     if (ListBox1->ItemIndex == -1) return;

     int ii = ListBox1->ItemIndex;
     if (Key == 46) tbDeleteTickClick(Sender);
     if (ListBox1->Items->Count <= ii) ii = ListBox1->Items->Count - 1;

     ListBox1->ItemIndex = ii;
     ListBox1Click(Sender);

}
//---------------------------------------------------------------------------

