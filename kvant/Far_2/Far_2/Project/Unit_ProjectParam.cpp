//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "Unit_ProjectParam.h"
#include "mpiDeclaration.h"
#include "mpiIndicator.h"
//===========================================================================
#pragma package(smart_init)
#pragma link "CGRID"
#pragma resource "*.dfm"
TfrmProjectParam *frmProjectParam;
//===========================================================================
__fastcall TfrmProjectParam::TfrmProjectParam(TComponent* Owner)
        : TForm(Owner)
{

}
//===========================================================================

void __fastcall TfrmProjectParam::FormShow(TObject *Sender)
{
  Caption = ProjectCaption + "Настройки";

//!!!!!!!!!!!!!
//  feTimerRefreshFreq->Set_Float_Value(TimerRefreshFreq);

  Panel1->Color = (TColor)Indicator_BGColor;
  Panel2->Color = (TColor)Indicator_RingColor;
  Panel3->Color = (TColor)Indicator_TargetColor;
  Panel4->Color = (TColor)Indicator_TargetFontColor;

  Panel5->Color = (TColor)Graph_BGColor;
  Panel6->Color = (TColor)Graph_TitleColor;
  Panel7->Color = (TColor)Graph_AxisColor;
  Panel8->Color = (TColor)Graph_CurveColor;
}
//===========================================================================

void __fastcall TfrmProjectParam::FormActivate(TObject *Sender)
{
   DecimalSeparator = '.';
}
//===========================================================================

bool TfrmProjectParam::CheckInputValues()
{
  bool result = true;

//!!!!!!!!!!!!!
//  feTimerRefreshFreq->Get_Float_Value(&TimerRefreshFreq, &result);

  return result;
}
//===========================================================================

void __fastcall TfrmProjectParam::BitBtn1Click(TObject *Sender)
{
  if (!CheckInputValues()) return;

  Close();
}


void __fastcall TfrmProjectParam::Panel1Click(TObject *Sender)
{
  ColorDialog1->Color = Panel1->Color;

  if (ColorDialog1->Execute()) {
     Panel1->Color      = ColorDialog1->Color;
     Indicator_BGColor  = ColorDialog1->Color;

     Graph    ->SetColors();
     Indicator->SetColors();
     Indicator->iResize(Sender);
     Graph    ->iResize(Sender);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmProjectParam::Panel2Click(TObject *Sender)
{
  ColorDialog1->Color = Panel2->Color;

  if (ColorDialog1->Execute()) {
     Panel2->Color       = ColorDialog1->Color;
     Indicator_RingColor = ColorDialog1->Color;

     Graph    ->SetColors();
     Indicator->SetColors();
     Indicator->iResize(Sender);
     Graph    ->iResize(Sender);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmProjectParam::Panel3Click(TObject *Sender)
{
  ColorDialog1->Color = Panel3->Color;

  if (ColorDialog1->Execute()) {
     Panel3->Color         = ColorDialog1->Color;
     Indicator_TargetColor = ColorDialog1->Color;

     Graph    ->SetColors();
     Indicator->SetColors();
     Indicator->iResize(Sender);
     Graph    ->iResize(Sender);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmProjectParam::Panel4Click(TObject *Sender)
{
  ColorDialog1->Color = Panel4->Color;

  if (ColorDialog1->Execute()) {
     Panel4->Color             = ColorDialog1->Color;
     Indicator_TargetFontColor = ColorDialog1->Color;

     Graph    ->SetColors();
     Indicator->SetColors();
     Indicator->iResize(Sender);
     Graph    ->iResize(Sender);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmProjectParam::Panel5Click(TObject *Sender)
{
  ColorDialog1->Color = Panel5->Color;

  if (ColorDialog1->Execute()) {
     Panel5->Color  = ColorDialog1->Color;
     Graph_BGColor  = ColorDialog1->Color;

     Graph    ->SetColors();
     Indicator->SetColors();
     Indicator->iResize(Sender);
     Graph    ->iResize(Sender);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmProjectParam::Panel6Click(TObject *Sender)
{
  ColorDialog1->Color = Panel6->Color;

  if (ColorDialog1->Execute()) {
     Panel6->Color      = ColorDialog1->Color;
     Graph_TitleColor   = ColorDialog1->Color;

     Graph    ->SetColors();
     Indicator->SetColors();
     Indicator->iResize(Sender);
     Graph    ->iResize(Sender);
  }

}
//---------------------------------------------------------------------------

void __fastcall TfrmProjectParam::Panel7Click(TObject *Sender)
{
  ColorDialog1->Color = Panel7->Color;

  if (ColorDialog1->Execute()) {
     Panel7->Color      = ColorDialog1->Color;
     Graph_AxisColor    = ColorDialog1->Color;

     Graph    ->SetColors();
     Indicator->SetColors();
     Indicator->iResize(Sender);
     Graph    ->iResize(Sender);
  }
}
//---------------------------------------------------------------------------


void __fastcall TfrmProjectParam::Panel8Click(TObject *Sender)
{
  ColorDialog1->Color = Panel8->Color;

  if (ColorDialog1->Execute()) {
     Panel8->Color      = ColorDialog1->Color;
     Graph_CurveColor   = ColorDialog1->Color;

     Graph    ->SetColors();
     Indicator->SetColors();
     Indicator->iResize(Sender);
     Graph    ->iResize(Sender);
  }
}
//---------------------------------------------------------------------------

void __fastcall TfrmProjectParam::Button1Click(TObject *Sender)
{
  Panel1->Color = (TColor)Indicator_BGColor         = (TColor)RGB(24,43,43);
  Panel2->Color = (TColor)Indicator_RingColor       = (TColor)RGB(95,95,95);
  Panel3->Color = (TColor)Indicator_TargetColor     = (TColor)RGB(188,188,188);
  Panel4->Color = (TColor)Indicator_TargetFontColor = (TColor)RGB(255,255,255);

  Panel5->Color = (TColor)Graph_BGColor             = (TColor)RGB(24,43,43);
  Panel6->Color = (TColor)Graph_TitleColor          = (TColor)RGB(255,255,255);
  Panel7->Color = (TColor)Graph_AxisColor           = (TColor)RGB(128,128,128);
  Panel8->Color = (TColor)Graph_CurveColor          = (TColor)RGB(255,255,255);

  Graph    ->SetColors();
  Indicator->SetColors();
  Indicator->iResize(Sender);
  Graph    ->iResize(Sender);
}
//---------------------------------------------------------------------------

