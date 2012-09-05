//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "math.h"

#include "mpiDeclaration.h"
#include "mpiFAR.h"
#include "Unit_TargetList.h"
#include "Unit_TargetIndicator.h"
#include "mpiLibrary.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmTargetIndicator *frmTargetIndicator;
//===========================================================================
__fastcall TfrmTargetIndicator::TfrmTargetIndicator(TComponent* Owner)
        : TForm(Owner)
{
}

//===========================================================================
void __fastcall TfrmTargetIndicator::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
//  frmTargetsParam->CheckListBox1->ItemIndex = ParentItemIndex;
//  Application->ProcessMessages();
}

//===========================================================================
void __fastcall TfrmTargetIndicator::FormCreate(TObject *Sender)
{
  aCaption = ProjectCaption + "Угломерный индикатор, ошибки измерений трассы №";
  Width  = 410;
  Height = 157;

  Left = frmTargetList->aCurrentWindowPos.x;
  Top  = frmTargetList->aCurrentWindowPos.y;

  MaxVisibleTime = 45;

  TargetId = -999;
  ParentItemIndex = -999;

  Init();
}

//===========================================================================
void __fastcall TfrmTargetIndicator::FormDestroy(TObject *Sender)
{
//
}

//===========================================================================
void __fastcall TfrmTargetIndicator::FormResize(TObject *Sender)
{
  Chart1->Width = ClientWidth - ClientHeight;// - Panel3->Width
  if (Panel5->Visible){
    Chart1->Width = ClientWidth - ClientHeight + Panel5->Height;
  }
}

//===========================================================================
void TfrmTargetIndicator::Init()
{
      for (int i = 0; i < Chart1->SeriesList->Count; i++)
            Chart1->Series[i]->Clear();
   // -----
      lMaxError ->Caption = "---------";
      lSredError->Caption = "---------";
      lSKOError ->Caption = "---------";
      lCurError ->Caption = "---------";

      if (aFar->FarParam->RotationSpeed == 0) MaxVisibleTime = 5;
                                         else MaxVisibleTime = Two_Pi/aFar->FarParam->RotationSpeed * 20.0 - 5.0;

   // -------------------------------------------
      Chart1->Color     = TargetIndicatorFonColor;
      Chart1->BackColor = TargetIndicatorFonColor;
      Chart1->BottomAxis->SetMinMax(0, MaxVisibleTime);
      Chart1->LeftAxis  ->SetMinMax(-1.3 * aFar->FarParam->Diagram.Shir * _180_del_Pi, 1.3 * aFar->FarParam->Diagram.Shir * _180_del_Pi);

      Chart2->Color     = UglomernyjIndicatorFonColor;
      Chart2->BackColor = UglomernyjIndicatorFonColor;
      /*Chart2->BottomAxis->SetMinMax(-1.3 * aFar->FarParam->Diagram.Shir * _180_del_Pi, 1.3 * aFar->FarParam->Diagram.Shir * _180_del_Pi);
      Chart2->LeftAxis  ->SetMinMax(-1.3 * aFar->FarParam->Diagram.Shir * _180_del_Pi, 1.3 * aFar->FarParam->Diagram.Shir * _180_del_Pi);*/
      Chart2->BottomAxis->SetMinMax(-UglomernyjIndicatorMaxOffset, UglomernyjIndicatorMaxOffset);
      Chart2->LeftAxis  ->SetMinMax(-UglomernyjIndicatorMaxOffset, UglomernyjIndicatorMaxOffset);

   // -------------------------------------------

   // ----------
      SetComboBoxParam();
}

//===========================================================================
void TfrmTargetIndicator::Draw()
{
  if (TargetId < 0) return;
  if (Targets[TargetId - 1]->TargetAccess == NULL) return;
  if (ComboBox1->ItemIndex == -1) return;

  Draw_1();
  Draw_2();
}

//===========================================================================
void __fastcall TfrmTargetIndicator::Draw_1()
{
   // -------------------
      TTargetAccess ta      = Targets[TargetId - 1]->TargetAccess[Targets[TargetId - 1]->TargetAccess_Count - 1];
      if (ta.Impuls == NULL) return;
   // -------------------

      TFloat        EndTime = ta.Impuls[0].Time;
      TFloat        odds, odds_q, odds_e;
      TFloat        OutValue, CurMax = 0;
      int           CBindex = (int) ComboBox1->Items->Objects[ComboBox1->ItemIndex];
      TFloat        sred, max, sko;


   // --- Отрисовка угломерного ииндекатора -----------

       for (int i = 0; i < Chart1->SeriesList->Count; i++) Chart1->Series[i]->Clear();
       for (int k = 0; k < 8; k ++){
          if (TargetIndicatorGraphics[k].Drawing) {

               ((TLineSeries*)Chart1->Series[k])->Pointer->Brush->Color = TargetIndicatorGraphics[k].Color;
               ((TLineSeries*)Chart1->Series[k])->LinePen->Color = TargetIndicatorGraphics[k].Color;
               for (int i = 0; i < Targets[TargetId - 1]->TargetAccess_Count; i++){
                         TTargetAccess ta = Targets[TargetId - 1]->TargetAccess[i];
                      // ------------------
                         if (ta.Coord_M1.Far.Q != -999 && ta.Coord_M2.Far.Q != -999 && ta.Coord_M1.Geo.Q != -999 && ta.Coord_M2.Geo.Q != -999){
                             if (k == 0) OutValue = ta.Coord_M1.Far.Q;
                             if (k == 1) OutValue = ta.Coord_M1.Far.E;
                             if (k == 2) OutValue = ta.Coord_M1.Geo.Q;
                             if (k == 3) OutValue = ta.Coord_M1.Geo.E;
                             if (k == 4) OutValue = ta.Coord_M2.Far.Q;
                             if (k == 5) OutValue = ta.Coord_M2.Far.E;
                             if (k == 6) OutValue = ta.Coord_M2.Geo.Q;
                             if (k == 7) OutValue = ta.Coord_M2.Geo.E;

                             if (CBindex == 0) { sred = ta.Coord_M1.Far.SredErrorQ; max = ta.Coord_M1.Far.MaxErrorQ; sko = ta.Coord_M1.Far.SKOErrorQ; }
                             if (CBindex == 1) { sred = ta.Coord_M1.Far.SredErrorE; max = ta.Coord_M1.Far.MaxErrorE; sko = ta.Coord_M1.Far.SKOErrorE; }
                             if (CBindex == 2) { sred = ta.Coord_M1.Geo.SredErrorQ; max = ta.Coord_M1.Geo.MaxErrorQ; sko = ta.Coord_M1.Geo.SKOErrorQ; }
                             if (CBindex == 3) { sred = ta.Coord_M1.Geo.SredErrorE; max = ta.Coord_M1.Geo.MaxErrorE; sko = ta.Coord_M1.Geo.SKOErrorE; }
                             if (CBindex == 4) { sred = ta.Coord_M2.Far.SredErrorQ; max = ta.Coord_M2.Far.MaxErrorQ; sko = ta.Coord_M2.Far.SKOErrorQ; }
                             if (CBindex == 5) { sred = ta.Coord_M2.Far.SredErrorE; max = ta.Coord_M2.Far.MaxErrorE; sko = ta.Coord_M2.Far.SKOErrorE; }
                             if (CBindex == 6) { sred = ta.Coord_M2.Geo.SredErrorQ; max = ta.Coord_M2.Geo.MaxErrorQ; sko = ta.Coord_M2.Far.SKOErrorQ; }
                             if (CBindex == 7) { sred = ta.Coord_M2.Geo.SredErrorE; max = ta.Coord_M2.Geo.MaxErrorE; sko = ta.Coord_M2.Far.SKOErrorE; }

                             OutValue = OutValue * _180_del_Pi;
                             Chart1->Series[k]->AddXY(ta.Impuls[0].Time, OutValue, "", TargetIndicatorGraphics[k].Color);

                             if (CurMax < fabs(OutValue)) CurMax = fabs(OutValue);
                           // ------
                         }
               }
          }
       }
     lCurError ->Caption = FloatToStrF(OutValue          , ffFixed, 10, 3);
     lSredError->Caption = FloatToStrF(sred * _180_del_Pi, ffFixed, 10, 3);
     lMaxError ->Caption = FloatToStrF(max  * _180_del_Pi, ffFixed, 10, 3);
     lSKOError ->Caption = FloatToStrF(sko  * _180_del_Pi, ffFixed, 10, 3);
  // ------------------
     CurMax = round(CurMax * 100000000) / 100000000.0; 
     if (CurMax == 0) CurMax = 0.15;
     Chart1->LeftAxis->SetMinMax(- CurMax * 2.2, CurMax * 2.2);
     if (MaxVisibleTime < EndTime) Chart1->BottomAxis->SetMinMax(EndTime - MaxVisibleTime, EndTime + 1);
                            else Chart1->BottomAxis->SetMinMax(-0.01, MaxVisibleTime+0.01);
}

//===========================================================================
void __fastcall TfrmTargetIndicator::Chart2AfterDraw(TObject *Sender)
{
  AnsiString OutStr1 = "(" + FloatToStrF(Chart2->BottomAxis->Minimum, ffFixed, 6,2) + "," + FloatToStrF(Chart2->LeftAxis->Minimum, ffFixed, 6,2) + ")";
  AnsiString OutStr2 = "(" + FloatToStrF(Chart2->BottomAxis->Maximum, ffFixed, 6,2) + "," + FloatToStrF(Chart2->LeftAxis->Maximum, ffFixed, 6,2) + ")";
  TRect      Rect1;
  TRect      Rect2;

 // ----------- Закраска зоны вывода надписей  -------
  Chart2->Canvas->Font->Size  = 8;
  Chart2->Canvas->Font->Color  = UglomernyjIndicatorFontColor;
  Chart2->Canvas->Brush->Color = Chart2->Color;
  Chart2->Canvas->Pen  ->Color = Chart2->Color;

  Rect1.Left   = 6;
  Rect1.Top    = Chart2->Height - 6 - Chart2->Canvas->TextHeight(OutStr1);
  Rect1.Right  = Rect1.Left + Chart2->Canvas->TextWidth (OutStr1);
  Rect1.Bottom = Rect1.Top  + Chart2->Canvas->TextHeight(OutStr1);

  Rect2.Left   = Chart2->Width - 6 - Chart2->Canvas->TextWidth(OutStr2);
  Rect2.Top    = 6;
  Rect2.Right  = Rect2.Left + Chart2->Canvas->TextWidth (OutStr2);
  Rect2.Bottom = Rect2.Top  + Chart2->Canvas->TextHeight(OutStr2);

  Chart2->Canvas->Rectangle(Rect1.Left, Rect1.Top, Rect1.Right, Rect1.Bottom);
  Chart2->Canvas->Rectangle(Rect2.Left, Rect2.Top, Rect2.Right, Rect2.Bottom);

 // ----------- Вывод подписей максимумов и минимумов -------
  Chart2->Canvas->TextOut3D(Rect1.Left, Rect1.Top, 0, OutStr1);
  Chart2->Canvas->TextOut3D(Rect2.Left, Rect2.Top, 0, OutStr2);

}

//===========================================================================
void __fastcall TfrmTargetIndicator::Chart2BeforeDrawSeries(
      TObject *Sender)
{
      int x1, y1, x2, y2;
      TFloat CurMaxX, CurMaxY;
  // --------

      Chart2->Canvas->Pen->Color = UglomernyjIndicatorLineColor;
  // --------
      for (TFloat k = 1; k > 0; k = k - 0.2){
          CurMaxX = UglomernyjIndicatorMaxOffset * k;
          CurMaxY = UglomernyjIndicatorMaxOffset * k;
          x1 = Chart2->BottomAxis->CalcXPosValue(-CurMaxX);
          x2 = Chart2->BottomAxis->CalcXPosValue( CurMaxX);
          y1 = Chart2->LeftAxis  ->CalcYPosValue(-CurMaxY);
          y2 = Chart2->LeftAxis  ->CalcYPosValue( CurMaxY);

          Chart2->Canvas->Rectangle(x1, y1, x2, y2);
      }
  // --------
      Chart2->Canvas->MoveTo(Chart2->BottomAxis->CalcXPosValue(-UglomernyjIndicatorMaxOffset), Chart2->LeftAxis  ->CalcYPosValue(                            0));
      Chart2->Canvas->LineTo(Chart2->BottomAxis->CalcXPosValue( UglomernyjIndicatorMaxOffset), Chart2->LeftAxis  ->CalcYPosValue(                            0));
      Chart2->Canvas->MoveTo(Chart2->BottomAxis->CalcXPosValue(                            0), Chart2->LeftAxis  ->CalcYPosValue(-UglomernyjIndicatorMaxOffset));
      Chart2->Canvas->LineTo(Chart2->BottomAxis->CalcXPosValue(                            0), Chart2->LeftAxis  ->CalcYPosValue( UglomernyjIndicatorMaxOffset));
}

//===========================================================================
void __fastcall TfrmTargetIndicator::Draw_2()
{
/*   // -------------------
      TTargetAccess ta      = Targets[TargetId - 1]->TargetAccess[Targets[TargetId - 1]->TargetAccess_Count - 1];
      if (ta.Impuls == NULL) return;
   // -------------------

      TFloat        EndTime = ta.Impuls[0].Time;
      TFloat        odds, odds_q, odds_e;
      int           CBindex = (int) ComboBox1->Items->Objects[ComboBox1->ItemIndex];
      TFloat        sred, max, sko;
*/
      TFloat        OutValueX, OutValueY;

   // --- Отрисовка угломерного ииндекатора -----------

       for (int i = 0; i < Chart2->SeriesList->Count; i++) Chart2->Series[i]->Clear();
       for (int k = 0; k < 4; k ++){
          if (UglomernyjIndicatorGraphics[k].Drawing) {

               ((TLineSeries*)Chart2->Series[k])->Pointer->Brush->Color = UglomernyjIndicatorGraphics[k].Color;
               ((TLineSeries*)Chart2->Series[k])->LinePen->Color = UglomernyjIndicatorGraphics[k].Color;
               for (int i = 0; i < Targets[TargetId - 1]->TargetAccess_Count; i++){
                         TTargetAccess ta = Targets[TargetId - 1]->TargetAccess[i];
                      // ------------------
                         if (ta.Coord_M1.Far.Q != -999 && ta.Coord_M2.Far.Q != -999 && ta.Coord_M1.Geo.Q != -999 && ta.Coord_M2.Geo.Q != -999){
                             if (k == 0) {OutValueX = ta.Coord_M1.Far.Q; OutValueY = ta.Coord_M1.Far.E;}
                             if (k == 1) {OutValueX = ta.Coord_M1.Geo.Q; OutValueY = ta.Coord_M1.Geo.E;}
                             if (k == 2) {OutValueX = ta.Coord_M2.Far.Q; OutValueY = ta.Coord_M2.Far.E;}
                             if (k == 3) {OutValueX = ta.Coord_M2.Geo.Q; OutValueY = ta.Coord_M2.Geo.E;}

                             OutValueX = OutValueX * _180_del_Pi;
                             OutValueY = OutValueY * _180_del_Pi;

                             Chart2->Series[k]->AddXY(OutValueX, OutValueY, "", UglomernyjIndicatorGraphics[k].Color);
                           // ------
                         }
               }
          }
       }



}

//===========================================================================
void __fastcall TfrmTargetIndicator::N1Click(TObject *Sender)
{
   N1->Checked     = !N1->Checked;
   Panel5->Visible =  N1->Checked;
   if ( Panel5->Visible) {
      Height += Panel5->Height;
      SetComboBoxParam();
   }
   if (!Panel5->Visible) Height -= Panel5->Height;
}

//===========================================================================
void __fastcall TfrmTargetIndicator::Panel2MouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
     Panel2->BevelOuter = bvLowered;
}
//===========================================================================

void __fastcall TfrmTargetIndicator::Panel2MouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
     Panel2->BevelOuter = bvRaised;
     TPoint aPoint = Panel2->ClientToScreen(Point(0, Panel2->Height));
     PopupMenu1->Popup(aPoint.x,aPoint.y);
}
//===========================================================================

void __fastcall TfrmTargetIndicator::SetComboBoxParam()
{
   ComboBox1->Items->BeginUpdate();
      ComboBox1->Items->Clear();
      for (int i = 0; i < 8; i++)
           if (TargetIndicatorGraphics[i].Drawing)
               ComboBox1->Items->AddObject(TargetIndicatorGraphics[i].Name, (TObject*)i);

   ComboBox1->Items->EndUpdate();
   ComboBox1->ItemIndex = 0;
   ComboBox1Change(NULL);
}

void __fastcall TfrmTargetIndicator::ComboBox1Change(TObject *Sender)
{
  int index = (int) ComboBox1->Items->Objects[ComboBox1->ItemIndex];

  Panel1->Color = TargetIndicatorGraphics[index].Color;

  Draw();
}
//===========================================================================

void __fastcall TfrmTargetIndicator::FormClose(TObject *Sender,
      TCloseAction &Action)
{
//  delete ((TfrmTargetIndicator*)frmTargetList->TargetIndicatorList->Items[ParentItemIndex]);
//          frmTargetList->TargetIndicatorList->Delete(ParentItemIndex);
//          frmTargetList->CheckListBox1->Checked[ParentItemIndex] = false;

//  frmTargetList->SetParamTargetWindow(ParentItemIndex);
}
//===========================================================================

void __fastcall TfrmTargetIndicator::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
  CanClose = false;
}
//===========================================================================

void __fastcall TfrmTargetIndicator::N3Click(TObject *Sender)
{
    frmTargetList->CheckListBox1->Checked[ParentItemIndex] = false;
    frmTargetList->CheckListBox1->ItemIndex = ParentItemIndex;
    frmTargetList->CheckListBox1ClickCheck(NULL);
}
//===========================================================================


void __fastcall TfrmTargetIndicator::N5Click(TObject *Sender)
{
     frmTargetIndicator_Param->ShowModal();

}
//===========================================================================
//===========================================================================

