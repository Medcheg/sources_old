//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_AchFchParam.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "CSPIN"
#pragma link "cdiroutl"
#pragma link "FloatEdit"
#pragma link "FloatEdit"
#pragma resource "*.dfm"
TfrmAchFchParam *frmAchFchParam;
//---------------------------------------------------------------------------
__fastcall TfrmAchFchParam::TfrmAchFchParam(TComponent* Owner) : TForm(Owner)
{
  ParentForm = (TfrmAchFch*) Owner;
}
//---------------------------------------------------------------------------
void __fastcall TfrmAchFchParam::FormShow(TObject *Sender)
{
   Panel1->Color = ParentForm->AchFchBackGroundColor;
   Panel5->Color = ParentForm->AchColor;
   Panel4->Color = ParentForm->FchColor;
   CSpinEdit1->Value = ParentForm->AchPenWidth;
   CSpinEdit2->Value = ParentForm->FchPenWidth;

   FloatEdit1->Set_Float_Value(ParentForm->BeginFreq);
   FloatEdit2->Set_Float_Value(ParentForm->EndFreq);

    CheckBox4->Checked = ParentForm->AchEnabled;
    CheckBox5->Checked = ParentForm->FchEnabled;
    CheckBox2->Checked = ParentForm->Enable_Label_T0;
    CheckBox1->Checked = ParentForm->RamkaEnabled;
}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::BitBtn1Click(TObject *Sender)
{
   bool Res = true; 

   FloatEdit1->Get_Float_Value(&ParentForm->BeginFreq, &Res);
   FloatEdit2->Get_Float_Value(&ParentForm->EndFreq  , &Res);

  ParentForm->AchEnabled       = CheckBox4->Checked;
  ParentForm->FchEnabled       = CheckBox5->Checked;
  ParentForm->Enable_Label_T0  = CheckBox2->Checked;
  ParentForm->RamkaEnabled     = CheckBox1->Checked;

  if (Res) Close();
}
//---------------------------------------------------------------------------


void __fastcall TfrmAchFchParam::PaintBox1Paint(TObject *Sender)
{
     int cy = PaintBox1->Height / 2;

     PaintBox1->Canvas->Brush->Color = Color;
     PaintBox1->Canvas->Pen->Color   = clBlack;
     PaintBox1->Canvas->Pen->Width   = 1;
     PaintBox1->Canvas->Pen->Style   = psSolid;
     PaintBox1->Canvas->Rectangle(0, 0, PaintBox1->Width, PaintBox1->Height);

     PaintBox1->Canvas->Pen->Color = ParentForm->AchColor;
     PaintBox1->Canvas->Pen->Style = ParentForm->AchPenStyle;
     PaintBox1->Canvas->Pen->Width = ParentForm->AchPenWidth;
     PaintBox1->Canvas->MoveTo(2, cy - 1); PaintBox1->Canvas->LineTo(PaintBox1->Width-2, cy - 1);
     PaintBox1->Canvas->MoveTo(2, cy - 0); PaintBox1->Canvas->LineTo(PaintBox1->Width-2, cy - 0);
     PaintBox1->Canvas->MoveTo(2, cy + 1); PaintBox1->Canvas->LineTo(PaintBox1->Width-2, cy + 1);
}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::PaintBox2Paint(TObject *Sender)
{
     int cy = PaintBox1->Height / 2;

     PaintBox2->Canvas->Brush->Color = Color;
     PaintBox2->Canvas->Pen->Color   = clBlack;
     PaintBox2->Canvas->Pen->Width   = 1;
     PaintBox2->Canvas->Pen->Style   = psSolid;
     PaintBox2->Canvas->Rectangle(0, 0, PaintBox1->Width, PaintBox1->Height);

     PaintBox2->Canvas->Pen->Color = ParentForm->FchColor;
     PaintBox2->Canvas->Pen->Style = ParentForm->FchPenStyle;
     PaintBox2->Canvas->Pen->Width = ParentForm->FchPenWidth;
     PaintBox2->Canvas->MoveTo(2, cy - 1); PaintBox2->Canvas->LineTo(PaintBox2->Width-2, cy - 1);
     PaintBox2->Canvas->MoveTo(2, cy - 0); PaintBox2->Canvas->LineTo(PaintBox2->Width-2, cy - 0);
     PaintBox2->Canvas->MoveTo(2, cy + 1); PaintBox2->Canvas->LineTo(PaintBox2->Width-2, cy + 1);
}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::Panel1Click(TObject *Sender)
{
  ColorDialog1->Color = ParentForm->AchFchBackGroundColor;
  if (ColorDialog1->Execute()){
     if (ColorDialog1->Color == clBlack) return;
     Panel1->Color                     = ColorDialog1->Color;
     ParentForm->AchFchBackGroundColor = ColorDialog1->Color;
  }

}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::Panel5Click(TObject *Sender)
{
  ColorDialog1->Color = ParentForm->AchColor;
  if (ColorDialog1->Execute()){
     if (ColorDialog1->Color == clWhite) return;
     Panel5->Color        = ColorDialog1->Color;
     ParentForm->AchColor = ColorDialog1->Color;
  }
  PaintBox1->Repaint();
}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::Panel4Click(TObject *Sender)
{
  ColorDialog1->Color = ParentForm->FchColor;
  if (ColorDialog1->Execute()){
     if (ColorDialog1->Color == clWhite) return;
     Panel4->Color        = ColorDialog1->Color;
     ParentForm->FchColor = ColorDialog1->Color;
  }
  PaintBox2->Repaint();
}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::CSpinEdit1Change(TObject *Sender)
{
  ParentForm->AchPenWidth = CSpinEdit1->Value;

}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::CSpinEdit2Change(TObject *Sender)
{
  ParentForm->FchPenWidth = CSpinEdit2->Value;

}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::PaintBox1Click(TObject *Sender)
{
  TPoint  CurPoint;

      CurPoint.x = Panel3->Left;
      CurPoint.y = Panel3->Top + Panel3->Height+1;
      CurPoint   = ClientToScreen(CurPoint);
      PopupMenu1->Popup(CurPoint.x, CurPoint.y);
}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::PaintBox2Click(TObject *Sender)
{
  TPoint  CurPoint;

      CurPoint.x = Panel2->Left;
      CurPoint.y = Panel2->Top + Panel2->Height+1;
      CurPoint   = ClientToScreen(CurPoint);
      PopupMenu2->Popup(CurPoint.x, CurPoint.y);
}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::fg1Click(TObject *Sender)
{
  switch (((TComponent*)Sender)->Tag) {
    case 0 : ParentForm->AchPenStyle = psSolid;      break;
    case 1 : ParentForm->AchPenStyle = psDash;       break;
    case 2 : ParentForm->AchPenStyle = psDot;        break;
    case 3 : ParentForm->AchPenStyle = psDashDot;    break;
    case 4 : ParentForm->AchPenStyle = psDashDotDot; break;
  }
  if (ParentForm->AchPenWidth != 1 && ParentForm->AchPenStyle != psSolid) ParentForm->AchPenWidth = 1;

  CSpinEdit1->Value = ParentForm->AchPenWidth;
  PaintBox1->Repaint();
}
//---------------------------------------------------------------------------

void __fastcall TfrmAchFchParam::MenuItem1Click(TObject *Sender)
{
  switch (((TComponent*)Sender)->Tag) {
    case 0 : ParentForm->FchPenStyle = psSolid;      break;
    case 1 : ParentForm->FchPenStyle = psDash;       break;
    case 2 : ParentForm->FchPenStyle = psDot;        break;
    case 3 : ParentForm->FchPenStyle = psDashDot;    break;
    case 4 : ParentForm->FchPenStyle = psDashDotDot; break;
  }
  if (ParentForm->FchPenWidth != 1 && ParentForm->FchPenStyle != psSolid) ParentForm->FchPenWidth = 1;

  CSpinEdit2->Value = ParentForm->FchPenWidth;
  PaintBox2->Repaint();
}
//---------------------------------------------------------------------------





