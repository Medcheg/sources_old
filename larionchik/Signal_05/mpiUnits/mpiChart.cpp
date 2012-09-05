//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================
#include "mpiChart.h"
#include "mpiGlobals.h"
#include "mpiBaseADC.h"

CChart *BChart;
//===========================================================================
CChart::CChart(TPanel *aParentPanel)
{
     isRealTimeWork = false;
     fCanals        = NULL;
     BaseADC        = NULL;

  // -----
     BGColor       = (TColor)0x00154A00;//0x00254A00;
     FrameNetColor = (TColor)0x0011dd11;
     NetColor      = (TColor)0x000c8100;

     aParentPanel->Color = BGColor;
     aParentPanel->DoubleBuffered = true;
     RedrawBitmap = new Graphics::TBitmap();
     aaBitmap     = new Graphics::TBitmap();

     fChartTime  = 10.0;

  // ----- Скрольбары для перемещения графиков ----
     sbMain = new TScrollBar(aParentPanel);
     sbMain->Parent      = aParentPanel;
     sbMain->Enabled     = true;
     sbMain->Max         = 0;
     sbMain->Align       = alBottom;
     sbMain->Min         = 0;
     sbMain->Position    = 0;
     sbMain->SmallChange = 1;
     sbMain->LargeChange = 100;
     sbMain->OnChange    = sbOnChange;

  // -----
     pbMain = new TPaintBox(aParentPanel);
     pbMain->Parent  = aParentPanel;
     pbMain->OnMouseMove = pbMouseMove;
     pbMain->OnMouseDown = pbMouseDown;
     pbMain->OnMouseUp   = pbMouseUp;
     pbMain->OnPaint     = pbOnPaint;
     pbMain->Align       = alClient;
     pbMain->Left        = 0;
     pbMain->Top         = 0;
     pbMain->Width       = aParentPanel->Width;
     pbMain->Height      = aParentPanel->Height;
  // -----

     TimeScales.Clear();
     VoltScales.Clear();

     TimeScalesIndex = 10;
     VoltScalesIndex = 10;

     TimeScales.Add(0.0005);
     TimeScales.Add(0.001);
     TimeScales.Add(0.002);
     TimeScales.Add(0.005);
     TimeScales.Add(0.01);
     TimeScales.Add(0.02);
     TimeScales.Add(0.05);
     TimeScales.Add(0.1);
     TimeScales.Add(0.2);
     TimeScales.Add(0.5);
     TimeScales.Add(1);
     TimeScales.Add(2);
     TimeScales.Add(3);
     TimeScales.Add(5);

     VoltScales.Add(0.0001);
     VoltScales.Add(0.0003);
     VoltScales.Add(0.001);
     VoltScales.Add(0.002);
     VoltScales.Add(0.005);
     VoltScales.Add(0.01);
     VoltScales.Add(0.02);
     VoltScales.Add(0.05);
     VoltScales.Add(0.1);
     VoltScales.Add(0.2);
     VoltScales.Add(0.5);
     VoltScales.Add(1);
     VoltScales.Add(2);
     VoltScales.Add(3);
     VoltScales.Add(5);
}

//===========================================================================
CChart::~CChart()
{
    if ( RedrawBitmap != NULL ) delete RedrawBitmap; RedrawBitmap = NULL;
    if ( aaBitmap     != NULL ) delete aaBitmap;     aaBitmap = NULL;
}

//===========================================================================
void __fastcall CChart::SetChartTime(double aTimeScale)
{
   fChartTime  = aTimeScale * 10.0;

   SetScrollBarPosition(0);
   // ------------
   SetStorageParam(fCanals);
}

//===========================================================================
void __fastcall CChart::Set_CollectionStorage(CCollectionStorage<short int> *aCanals)
{
    fCanals = aCanals;
    SetStorageParam(aCanals);
}

//===========================================================================
void __fastcall CChart::SetStorageParam(CCollectionStorage<short int> *aCanals)
{
     if ( aCanals == NULL ) return;

     for (  int i = 0; i < aCanals->ItemsCount; i++ )
     {
         double MaxMin = (aCanals->Items[i]->gr_MaxY - aCanals->Items[i]->gr_MinY);

         aCanals->Items[i]->gr_Left   = DrawRect.Left;
         aCanals->Items[i]->gr_Top    = DrawRect.Top;
         aCanals->Items[i]->gr_Width  = DrawRect.Width();
         aCanals->Items[i]->gr_Height = DrawRect.Height();
         aCanals->Items[i]->gr_Bottom = aCanals->Items[i]->gr_Top + aCanals->Items[i]->gr_Height;

         aCanals->Items[i]->gr_CoefY  = ( MaxMin == 0 ) ? aCanals->Items[i]->gr_Height : aCanals->Items[i]->gr_Height / MaxMin;
         aCanals->Items[i]->gr_CoefX  = ( aCanals->Items[i]->gr_Width == 0) ? 1 : (fChartTime / aCanals->Items[i]->ValueT0) /(float)aCanals->Items[i]->gr_Width;
         aCanals->Items[i]->gr_Color  = ColorArray[i];
     }

/*     TPoint  gr_Values[3000];
     int     gr_ValuesCount;
     int     gr_Width;
     int     gr_Height;
     float   gr_MaxY;
     float   gr_MinY;
     float   gr_CoefX;
     float   gr_CoefY;
*/     
}

//===========================================================================
void __fastcall CChart::SetScrollBarPosition(int ScrBarPosition)
{
   sbMain->OnChange = NULL;
   sbMain->Position = ScrBarPosition;
   sbMain->OnChange = sbOnChange;
}

//===========================================================================
void __fastcall CChart::sbOnChange(System::TObject* Sender)
{
    if ( isRealTimeWork == true ) return;
    if ( BaseADC        == NULL ) return;

    LastDrawPoint = sbMain->Position + fChartTime * BaseADC->AcpCanalFreq;

    pbOnPaint(NULL);
}

//===========================================================================
void __fastcall CChart::pbMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y)
{
    if ( isRealTimeWork == true ) return;

    XMousePosition = X;
    YMousePosition = Y;

    pbOnPaint(NULL);
    //DrawSeriesValues();
}

//===========================================================================
void __fastcall CChart::pbMouseDown(System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y)
{
    if ( isRealTimeWork == true ) return;
}

//===========================================================================
void __fastcall CChart::pbMouseUp  (System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y)
{
    if ( isRealTimeWork == true ) return;
}

//===========================================================================
void __fastcall CChart::Resizze()
{
  // ----- Рекриейчу Битмап ----
       if ( RedrawBitmap != NULL ) delete RedrawBitmap;
       if ( aaBitmap     != NULL ) delete aaBitmap;
       RedrawBitmap = new Graphics::TBitmap();
       RedrawBitmap->PixelFormat = pf8bit;
       RedrawBitmap->Canvas->Brush->Color = BGColor;
       RedrawBitmap->Width  = pbMain->Width;
       RedrawBitmap->Height = pbMain->Height;

       aaBitmap                       = new Graphics::TBitmap();
       aaBitmap->PixelFormat          = pf8bit;
       aaBitmap->Canvas->Brush->Color = BGColor;
       aaBitmap->Width                = pbMain->Width;
       aaBitmap->Height               = pbMain->Height;

  // ----- Рисую полный БакГроунд ----
       DrawLineRectangle(RedrawBitmap->Canvas, false, clGray  , Rect(0, 0, pbMain->Width-2, pbMain->Height-2));
       DrawLineRectangle(RedrawBitmap->Canvas, false, clGray  , Rect(1, 1, pbMain->Width-3, pbMain->Height-3));
       DrawLineRectangle(RedrawBitmap->Canvas, false, clSilver, Rect(2, 2, pbMain->Width-4, pbMain->Height-4));

  // -----  Оформляю РЕКИ для будущей отрисовки -----
       ClientRect      = Rect( 0,                     0, pbMain->Width   , pbMain->Height        );
       DrawRect        = Rect(59,                    53, pbMain->Width-40, pbMain->Height    - 34);
       //DrawRect        = Rect(90,                    40, pbMain->Width-40, pbMain->Height    - 54);
       //ValuesLineRect  = Rect(90,       DrawRect.Bottom, pbMain->Width-40, DrawRect.Bottom   + 20);
       //TimeLineRect    = Rect(90, ValuesLineRect.Bottom, pbMain->Width-40, ClientRect.Bottom -  6);
            
       RedrawBitmap->Canvas->Pen->Color = (TColor)0x0011dd11;
       DrawLineRectangle(RedrawBitmap->Canvas, false, FrameNetColor, Rect(DrawRect.Left-1, DrawRect.Top-1      , DrawRect.Right+1, DrawRect.Bottom+1    ));
       //DrawLineRectangle(RedrawBitmap->Canvas, false, FrameNetColor, Rect(DrawRect.Left-1, ValuesLineRect.Top+1, DrawRect.Right+1, ValuesLineRect.Bottom));
       //DrawLineRectangle(RedrawBitmap->Canvas, false, FrameNetColor, Rect(DrawRect.Left-1, TimeLineRect.Top    , DrawRect.Right+1, TimeLineRect.Bottom  ));

   // ------ Усатанавливаю коефициенты для будущих маштабирований ------    
       SetStorageParam(fCanals);

       aaBitmap->Canvas->Draw(0, 0, RedrawBitmap);
}

//===========================================================================
void __fastcall CChart::pbOnPaint(System::TObject* Sender)
{
   // ------ Тут нада проверить поменялся ли размер ПаинтБокса, если да, тогда РэКриейтим Рэдрав Битмап -----
     if (  RedrawBitmap->Width != pbMain->Width ||  RedrawBitmap->Height != pbMain->Height ) Resizze();

   // -----
     aaBitmap->Canvas->Draw(0, 0, RedrawBitmap);

   // -----  Отрисовую Сетку ГРафиков, и Сами графики ------
     DrawSeriesValues();
}

//===========================================================================
void __fastcall CChart::DrawNet(TCanvas *aCanvas)
{
       aCanvas->Font->Size  = 8;
       aCanvas->Font->Style = TFontStyles();
       aCanvas->Pen->Color  = NetColor;
       aCanvas->Font->Color = clWhite;
       float yStep = (DrawRect.Bottom  - DrawRect.Top) / 10.0;
       float xStep = (DrawRect.Right  - DrawRect.Left) / 10.0;
       if ( yStep == 0 || xStep == 0) return;
  // ---------------
//         CCollection<double> TimeScales;
         ;
     //TimeScalesIndex = 10;
//     VoltScalesIndex = 10;
       int th = aCanvas->TextWidth("0");
       double BeginVal = VoltScales.Values[VoltScalesIndex] * 5;
       int    iCounter = 0;
       double val;
       for ( float i = DrawRect.Top; i < DrawRect.Bottom; i = i + yStep, iCounter++)
       {
             aCanvas->MoveTo (DrawRect.Left , i);
             aCanvas->LineTo (DrawRect.Right, i);

             val = BeginVal - iCounter*VoltScales.Values[VoltScalesIndex];
             if ( fabs(val) < 1e-5 ) val = 0;
             
             //AnsiString as = FloatToStrF(val, ffFixed, 20, 5);
             AnsiString as = FloatToStr(round(val * 100000) / 100000.0);
             int tw = aCanvas->TextWidth(as);
             aCanvas->TextOut(DrawRect.Left - tw - 8, i - th*0.64, as);
       }

       BeginVal = 0;
       iCounter = 0;
       for ( float i = DrawRect.Left; i <= DrawRect.Right; i = i + xStep, iCounter++ )
       {
             aCanvas->MoveTo(i, DrawRect.Top);
             aCanvas->LineTo(i, DrawRect.Bottom);

             //AnsiString as = FloatToStrF(iCounter*TimeScales.Values[TimeScalesIndex], ffFixed, 20, 5);
             AnsiString as = FloatToStr(round(iCounter*TimeScales.Values[TimeScalesIndex] * 100000) / 100000.0);
             int tw = aCanvas->TextWidth(as);
             aCanvas->TextOut(i - tw * 0.5, DrawRect.Bottom + 8, as);
       }

   // ---- Отрисовка дополнительных отметок ------------
       float CountTicks = 4.0;
       float xStep1 = xStep / CountTicks;
       float yStep1 = yStep / CountTicks;
       short int x1 = DrawRect.Left - 3;
       short int x2 = DrawRect.Left + 3;
       //short int x1 = DrawRect.Left + DrawRect.Width() / 2 - 3;
       //short int x2 = DrawRect.Left + DrawRect.Width() / 2 + 3;
       short int y1 = DrawRect.Top + DrawRect.Height() / 2 - 3;
       short int y2 = DrawRect.Top + DrawRect.Height() / 2 + 3;

    // ------ Горизонтальная ось ---------
       for ( float i = DrawRect.Left + xStep1; i < DrawRect.Right - 2; i = i + xStep1 )
       {
           aCanvas->MoveTo(i, y1);
           aCanvas->LineTo(i, y2);
       }

    // ------ Вертикальная осъ ---------
       for ( float i = DrawRect.Top + yStep1; i < DrawRect.Bottom - 2; i = i + yStep1)
       {
           aCanvas->MoveTo(x1, i);
           aCanvas->LineTo(x2, i);
       }
}

//===========================================================================
void __fastcall CChart::DrawSeriesValues()
{
       Graphics::TCanvas *aCanvas = aaBitmap->Canvas;
     // -----  Отрисовую Сетку ГРафиков ------
       DrawNet(aCanvas);
     // -----
       if ( fCanals != NULL )
       {

         // ----- Если работа в реальном времени, тогда рисуем кривые ----
             for (  int i = 0; i < fCanals->ItemsCount; i++ )
             {
                  if ( Canals->Items[i]->gr_Checked == false ) continue;

                   aCanvas->Pen->Color = (TColor)0x003300;
                   aCanvas->Polyline(fCanals->Items[i]->gr_Values, fCanals->Items[i]->gr_ValuesCount - 1);

                   if ( isRealTimeWork == true ) LastDrawPoint = fCanals->Items[i]->Count;
                   fCanals->Items[i]->Calculate_gr_Values(false, LastDrawPoint );

                   aCanvas->Pen->Color = fCanals->Items[i]->gr_Color;
                   aCanvas->Polyline(fCanals->Items[i]->gr_Values, fCanals->Items[i]->gr_ValuesCount - 1);
             }

         // --------- Отрисовка курсора ----
             if ( isRealTimeWork == false )
             {
                 if ( XMousePosition >= DrawRect.Left && XMousePosition <= DrawRect.Right && YMousePosition >= DrawRect.Top && YMousePosition <= DrawRect.Bottom )
                 {
                     aCanvas->Pen->Color = clWhite;

                     aCanvas->MoveTo(XMousePosition, DrawRect.Top+2);
                     aCanvas->LineTo(XMousePosition, DrawRect.Bottom - 2);

                    AnsiString as1, as2, as_t;
                    bool       isTimeValueDrawed = false;
                    int  CursorIndex = XMousePosition - DrawRect.Left;

                    double val;

                        SetBkMode(aCanvas->Handle, TRANSPARENT);
                        //aCanvas->Font->Size = 10;
                        aCanvas->Font->Style = TFontStyles() << fsBold;
                        for ( int i = 0; i < Canals->ItemsCount; i++)
                        {
                            if (Canals->Items[i]->Count == 0) continue;


                            if ( CursorIndex >= (int)Canals->Items[i]->Count ) CursorIndex = Canals->Items[i]->Count - 1;
                            if ( CursorIndex <  0                            ) CursorIndex = 0;

                            if ( Canals->Items[i]->gr_ValuesCount > 0 )
                            {
                                if ( CursorIndex >= Canals->Items[i]->gr_ValuesCount ) CursorIndex = Canals->Items[i]->gr_ValuesCount - 1;
                                if ( CursorIndex <  0 ) CursorIndex = 0;

                                val  = Canals->Items[i]->Values[Canals->Items[i]->gr_ArrayIndex[CursorIndex]] * Canals->Items[i]->gr_YVoltTransformCoef;
                                as1  = "[V] = " + FloatToStrF(val     , ffFixed, 20, 6);
                                as2  = "[G] = " + FloatToStrF(val*9.81, ffFixed, 20, 5);

                                aCanvas->Font->Color = Canals->Items[i]->gr_Color;
                                aCanvas->TextOut(150 + i*100, 10, as1);
                                aCanvas->TextOut(150 + i*100, 27, as2);
                                if ( isTimeValueDrawed == false )
                                {
                                    isTimeValueDrawed = true;
                                     // ---- Время курсора -----
                                    as_t = FloatToStrF(Canals->Items[i]->gr_ArrayIndex[CursorIndex] / (double)BaseADC->AcpCanalFreq, ffFixed, 20, 5) + " (c)";
                                    aCanvas->Font->Color = clWhite;
                                    aCanvas->TextOut(10, 10, "Время курсора :");
                                    aCanvas->TextOut(10, 27, as_t);
                               }
                            }
                        }
                 }
             }
       }

     // ----- Раскрываем канву ---------
       pbMain->Canvas->Draw(0, 0, aaBitmap);
}


