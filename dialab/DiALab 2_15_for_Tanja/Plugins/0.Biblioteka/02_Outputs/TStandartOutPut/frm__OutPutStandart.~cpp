//===========================================================================
#include <vcl.h>
#include <math.hpp>
#include <math.h>
#pragma hdrstop

#include "frm__OutPutStandart.h"
//#include "mpiLibrary.h"
#include "M_OutPutStandart.h"
//===========================================================================
#pragma resource "*.dfm"
TfrmOutPutStandart *frmOutPutStandart;
//===========================================================================
int __fastcall round(long double aValue)
{
  int aFloor = floor(aValue);
  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
}

//===========================================================================
__fastcall TfrmOutPutStandart::TfrmOutPutStandart(TComponent* Owner)
        : TForm(Owner)
{
   fmyWindowState = wsFull;
   RedrawBitmap   = new Graphics::TBitmap;
   FonBitmap      = new Graphics::TBitmap;
   EnabledCursor  = false;

   lCaption[0] = lCaption1;    lValue[0] = lValue1;    lValue[0]->Caption = "-----";
   lCaption[1] = lCaption2;    lValue[1] = lValue2;    lValue[1]->Caption = "-----";
   lCaption[2] = lCaption3;    lValue[2] = lValue3;    lValue[2]->Caption = "-----";
   lCaption[3] = lCaption4;    lValue[3] = lValue4;    lValue[3]->Caption = "-----";
   lCaption[4] = lCaption5;    lValue[4] = lValue5;    lValue[4]->Caption = "-----";
   lCaption[5] = lCaption6;    lValue[5] = lValue6;    lValue[5]->Caption = "-----";

   lTime->Caption = "Время = ------- c.";

  // ------
   SpeedButton3Click(NULL);
  // ------
   for (int i = 0; i < 6; i ++)
         Values[i] = NULL;
}

//===========================================================================
void __fastcall TfrmOutPutStandart::FormDestroy(TObject *Sender)
{
  delete RedrawBitmap;
  delete FonBitmap;

  for (int i = 0; i < 6; i ++)
       if (Values[i] != NULL) {
         free (Values[i]);
         Values[i] = NULL;
       }
}

//===========================================================================

void __fastcall TfrmOutPutStandart::FormActivate(TObject *Sender)
{
   Caption = "DiALab - " + ((TElement*)Element)->DefaultName + " - " + ((TElement*)Element)->Caption;
   DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmOutPutStandart::FormShow(TObject *Sender)
{
    TElement *el = (TElement *)Element;
    Caption = "DiALab - " + el->DefaultName + " - " + el->Caption;
    if (Sender != NULL) myWindowState     = wsShort;
    pCaption->Caption = el->Caption;

    // ---- Обнуляем видимость ----
        for (int i = 0; i < 6; i ++){
             lCaption[i]->Visible = false;
             lValue  [i]->Visible = false;
        }
    // ---- Показываем видимым, то, что надо ---------
        for (int i = 0; i < ((TElement*)Element)->iPoints->Items_Count; i ++){
             if (mpiSeries != NULL) lCaption[i]->Font->Color = ((TmpiSeries*)mpiSeries[i])->Color;
             lCaption[i]->Visible = true;
             lCaption[i]->Caption = ((TElement*)Element)->iPoints->Items[i]->Caption;

             if (mpiSeries != NULL) lValue  [i]->Font->Color = ((TmpiSeries*)mpiSeries[i])->Color;
             lValue  [i]->Visible     = true;
             lValue  [i]->Caption     = "-----";
        }
}

//===========================================================================
void __fastcall TfrmOutPutStandart::Set_myWindowState(TmyWindowState amyWindowState)
{
  if (fmyWindowState == amyWindowState) return;
  fmyWindowState = amyWindowState;

  if (fmyWindowState == wsShort) {
     SpeedButton5->Caption = ">>>";
     Panel1->Visible = false;
     ClientWidth    -= Panel1->Width;
  }
  if (fmyWindowState == wsFull) {
     SpeedButton5->Caption = "<<<";
     Panel1->Visible = true;
     Width        += Panel1->Width;
  }
}

//===========================================================================
void __fastcall TfrmOutPutStandart::SpeedButton5Click(TObject *Sender)
{
   OnResize = NULL;

   if (myWindowState == wsShort) { myWindowState = wsFull ; OnResize = FormResize; return; }
   if (myWindowState == wsFull ) { myWindowState = wsShort; OnResize = FormResize; return; }
}

//===========================================================================
void __fastcall TfrmOutPutStandart::PaintBox1Paint(TObject *Sender)
{
   PaintBox1->Canvas->Draw(0,0,RedrawBitmap);
}

//===========================================================================
void __fastcall TfrmOutPutStandart::FormResize(TObject *Sender)
{
   FonBitmap->Width  = PaintBox1->Width;
   FonBitmap->Height = PaintBox1->Height;

   PrepareRedrawBitmap_and_coeff();

   if (mpiSeries == NULL) return;

   for (int i = 0; i < ((TElement*)Element)->iPoints->Items_Count; i++){
       if (((TmpiSeries*)mpiSeries[i])->XValues != NULL && ((TmpiSeries*)mpiSeries[i])->XValues != NULL) {
           for (int k = 0; k < ((TmpiSeries*)mpiSeries[i])->Values_Count; k++){
               AddXYValue(i, k, false);
           }
       }
   }
}

//===========================================================================
void __fastcall TfrmOutPutStandart::PaintBox1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
   AnsiString as = Sender->ClassName();
   TElement  *el = (TElement  *)Element;

   if (as == "TPaintBox" && X >= GraphRect.left && X <= GraphRect.Right && Y >= GraphRect.Top && Y <= GraphRect.Bottom) {
       // ---- Расчитываю положение курсора положения курсора -------
          TFloat XPercentPos = (X - GraphRect.Left) / (TFloat)GraphRect.Width();

       // ---- Время под курсором -----
          TFloat CursorTime  = XPercentPos * ((TElement*)Element)->pProjectParam->EndCalcTime * TimeScale;

       // ---- Привязка Времени курсора к Такту дескиртизации ситемы  -----
          //CursorTime = ceil(CursorTime / ProjectParam.AnalogT0) * ProjectParam.AnalogT0;
          CursorTime = round(CursorTime / el->pProjectParam->AnalogT0) * el->pProjectParam->AnalogT0;

       // ---------
          XPercentPos = CursorTime / el->pProjectParam->EndCalcTime / TimeScale;
          X           = XPercentPos * (TFloat)GraphRect.Width() + GraphRect.Left;

       // ---- Очичаю подложку ---
          if (OldXPositionMouseCursor != X) PaintBox1->Canvas->Draw(0,0,RedrawBitmap);
          OldXPositionMouseCursor = X;

       // ---- Вывожу линию ------
          PaintBox1->Canvas->Pen->Color = clBlack;
          PaintBox1->Canvas->Pen->Width = 1;
          PaintBox1->Canvas->MoveTo(X, GraphRect.Top + 2);
          PaintBox1->Canvas->LineTo(X, GraphRect.Bottom - 2);

          lTime->Caption = "Время = " + FloatToStrF(CursorTime, ffFixed, 20, 6) + " c.";

          for (int i = 0; i < ((TElement*)Element)->iPoints->Items_Count; i++){
              int Index = XPercentPos * el->pProjectParam->EndCalcTime / el->pProjectParam->AnalogT0;

              if (mpiSeries != NULL) {
                         if (Index > ((TmpiSeries*)mpiSeries[i])->Values_Count) lValue[i]->Caption = "-----------";
                   else lValue[i]->Caption = FloatToStrF(((TmpiSeries*)mpiSeries[i])->YValues[Index] , ffFixed, 20, 8);
              }    else lValue[i]->Caption = "-----------";


          }
          EnabledCursor = true;
   } else {
       if (EnabledCursor) {
           EnabledCursor = false;

           PaintBox1->Canvas->Draw(0,0,RedrawBitmap);
           PaintBox1MouseMove(Sender, Shift, -1, -1);
       }
   }
}

//===========================================================================
void TfrmOutPutStandart::Init()
{
   FormShow(NULL);

   PrepareRedrawBitmap_and_coeff();

   CoefX = GraphRect.Width()  / ((TElement*)Element)->pProjectParam->EndCalcTime;
   CoefY = GraphRect.Height() / fabs(*pMaxY - *pMinY);

   PaintBox1->Canvas->Draw(0,0,RedrawBitmap);
}

//===========================================================================
void TfrmOutPutStandart::PrepareGraphicMassive()
{
      for (int i = 0; i < 6; i ++)
           if (Values[i] != NULL) {
             free (Values[i]);
             Values[i] = NULL;
           }

   // ---- Выставляю длинны масивов для выводих графиков ---
      for (int i = 0; i < ((TElement*)Element)->iPoints->Items_Count; i ++)
          Values[i] = (TPoint*) malloc (sizeof(TPoint) * GraphRect.Width());

   // ---- Подготавливаю массивы ----
      for (int i = 0; i < ((TElement*)Element)->iPoints->Items_Count; i ++)
           for (int k = 0; k < GraphRect.Width(); k ++){
               Values[i][k].x = GraphRect.Left + k;
               Values[i][k].y = ZeroPos;
           }
}

//===========================================================================
void TfrmOutPutStandart::PrepareRedrawBitmap_and_coeff()
{
   // --- Очистка канвы ------
      FonBitmap->Canvas->FillRect(PaintBox1->ClientRect);

   // ---- Опредиляю левый отступ окна графика (зависит от мин, макс значения оси У) ----------
      // ---- Опредиляю матису числа ---
         int WidthMaxValue = FonBitmap->Canvas->TextWidth(FloatToStr(*pMaxY));
         int WidthMinValue = FonBitmap->Canvas->TextWidth(FloatToStr(*pMinY));

         int MaxWidth  = (WidthMaxValue > WidthMinValue) ? WidthMaxValue : WidthMinValue;
         int LeftOffset  = 12 + MaxWidth;

   // ---- Параметры окна вывода графика ----
      GraphRect = Rect (LeftOffset, 10 + 1, PaintBox1->Width - 10 - 1, PaintBox1->Height - 10 - 1);

   // ---- Зачистка територии --------
      FonBitmap->Canvas->Rectangle(GraphRect.left - 1, GraphRect.Top - 1, GraphRect.Right + 1, GraphRect.Bottom + 1);

   // ---- Маштабные коеффициенты -----
      if (((TElement*)Element)->pProjectParam->EndCalcTime == 0) CoefX = 1; else CoefX = GraphRect.Width()  / ((TElement*)Element)->pProjectParam->EndCalcTime;
      if (*pMaxY == *pMinY) {
        *pMaxY = 0.1;
        *pMinY = -0.1;
      }
      CoefY = GraphRect.Height() / fabs(*pMaxY - *pMinY);

   // ---- Нулевая линия --------
      ZeroPos = GraphRect.Top + CoefY * *pMaxY;

   // ---- Сетка --------
      FonBitmap->Canvas->Pen->Color = clSilver;
      int    CountHorizontalLines = 10;
      TFloat YStep   = GraphRect.Width() / (TFloat)CountHorizontalLines / 2;

      // ----- Горизонтальные линии -----
          TFloat YPos = ZeroPos - YStep;
          while (YPos > GraphRect.Top) {
              if (YPos < GraphRect.Bottom) {
                 FonBitmap->Canvas->MoveTo(GraphRect.Left , YPos);
                 FonBitmap->Canvas->LineTo(GraphRect.Right, YPos);
              }
              YPos -= YStep;
          }
          YPos = ZeroPos + YStep;
          while (YPos < GraphRect.Bottom) {
              if (YPos > GraphRect.Top) {
                 FonBitmap->Canvas->MoveTo(GraphRect.Left , YPos);
                 FonBitmap->Canvas->LineTo(GraphRect.Right, YPos);
              }   
              YPos += YStep;
          }
      // ----- Вертикальные линии -----
          TFloat CurXPos = GraphRect.Left + YStep;
          while (CurXPos < GraphRect.Right) {
              FonBitmap->Canvas->MoveTo(CurXPos, GraphRect.Top    + 1);
              FonBitmap->Canvas->LineTo(CurXPos, GraphRect.Bottom - 1);

              CurXPos += YStep;
          }


   // ---- Отрисовка значений максимумов и минимумов по си Y --------
      AnsiString aMax = FloatToStr(*pMaxY);
      AnsiString aMin = FloatToStr(*pMinY);

      FonBitmap->Canvas->TextOut(GraphRect.Left - FonBitmap->Canvas->TextWidth(aMax) - 6, GraphRect.Top    - FonBitmap->Canvas->TextHeight(aMax) / 2, aMax);
      FonBitmap->Canvas->TextOut(GraphRect.Left - FonBitmap->Canvas->TextWidth(aMin) - 6, GraphRect.Bottom - FonBitmap->Canvas->TextHeight(aMin) / 2, aMin);
      FonBitmap->Canvas->TextOut(GraphRect.Left - FonBitmap->Canvas->TextWidth("0")  - 6, ZeroPos          - FonBitmap->Canvas->TextHeight("0")  / 2, "0");

   // ---- Нулевая линия --------
      FonBitmap->Canvas->Pen->Color = clBlack;
      FonBitmap->Canvas->MoveTo(GraphRect.Left, ZeroPos);
      FonBitmap->Canvas->LineTo(GraphRect.Right, ZeroPos);
  //  --  Шлб не мучаться то прорисовываю врхнею и нижнею линии, ----
      FonBitmap->Canvas->MoveTo(GraphRect.Left , GraphRect.Top   );
      FonBitmap->Canvas->LineTo(GraphRect.Right, GraphRect.Top   );
      FonBitmap->Canvas->MoveTo(GraphRect.Left , GraphRect.Bottom);
      FonBitmap->Canvas->LineTo(GraphRect.Right, GraphRect.Bottom);

   //---------------
      RedrawBitmap->Assign(FonBitmap);

   //---------------
      PrepareGraphicMassive();
}

void TfrmOutPutStandart::AddXYValue(int NumberInput, int ValueIndex, bool DrawToPaintBox)
{
   TmpiSeries *CurSeries = (TmpiSeries*)mpiSeries[NumberInput];
  // ---------
    int CurX = round(GraphRect.Left + CurSeries->XValues[ValueIndex] * CoefX / TimeScale);
    int CurY = round(ZeroPos        - CurSeries->YValues[ValueIndex] * CoefY);

  // ------ Проверка CurY Вылез ли он за Пределы экрна -------
    if (CurY < -100                 ) CurY = -100;
    if (CurY > 2 * PaintBox1->Height) CurY = 2 * PaintBox1->Height;
    if (CurX >= GraphRect.Right) return;

  // --------- Если первая точка
    if (ValueIndex == 0) {
        CurSeries->OldValueScreenX = CurX;
        CurSeries->OldValueScreenY = CurY;
    }

  // --------- Если нужно рисовать в ПаинБокс ------
    if (DrawToPaintBox) {
       PaintBox1->Canvas->Pen->Width = CurSeries->PenWidth;
       PaintBox1->Canvas->Pen->Color = CurSeries->Color;

       PaintBox1->Canvas->MoveTo(CurSeries->OldValueScreenX , CurSeries->OldValueScreenY);
       PaintBox1->Canvas->LineTo(CurX, CurY);

       if (((TOutElementStandart*)Element)->DrawDots) PaintBox1->Canvas->Ellipse(CurX-2, CurY-2, CurX+2, CurY+2);
    }

  // ---- Рисуем на Редрав Битмап ---------
    RedrawBitmap->Canvas->Pen->Width = CurSeries->PenWidth;
    RedrawBitmap->Canvas->Pen->Color = CurSeries->Color;

    RedrawBitmap->Canvas->MoveTo(CurSeries->OldValueScreenX , CurSeries->OldValueScreenY);
    RedrawBitmap->Canvas->LineTo(CurX, CurY);

    if (((TOutElementStandart*)Element)->DrawDots) RedrawBitmap->Canvas->Ellipse(CurX-2, CurY-2, CurX+2, CurY+2);

  // --- Переприсванивание предыдущих позиций прорисовки ----
    if (CurSeries->OldValueScreenX != CurX) CurSeries->OldValueScreenX = CurX;
    if (CurSeries->OldValueScreenY != CurY) CurSeries->OldValueScreenY = CurY;
}

//===========================================================================
void __fastcall TfrmOutPutStandart::SpeedButton3Click(TObject *Sender)
{
     TrackBar1->Position = TrackBar1->Max;
     TrackBar2->Position = 0;
     TrackBar3->Position = 0;
     TrackBar4->Position = 0;

     TimeScale = 1;
}

//===========================================================================
void __fastcall TfrmOutPutStandart::TrackBar1Change(TObject *Sender)
{
   TimeScale = (double) TrackBar1->Position / 1000.0;

//   ReDrawSeries();

   if (mpiSeries == NULL) return;

   RedrawBitmap->Assign(FonBitmap);

   for (int i = 0; i < ((TElement*)Element)->iPoints->Items_Count; i++){
       if (((TmpiSeries*)mpiSeries[i])->XValues != NULL && ((TmpiSeries*)mpiSeries[i])->XValues != NULL) {
           for (int k = 0; k < ((TmpiSeries*)mpiSeries[i])->Values_Count; k++){
               AddXYValue(i, k, false);
           }
       }
   }

   PaintBox1->Canvas->Draw(0,0,RedrawBitmap);
}
//---------------------------------------------------------------------------

