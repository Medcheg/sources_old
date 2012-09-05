//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "mpiGraph.h"
#include "Math.h"
#include "mpiDeclaration.h"
#include "Unit_GraphicList.h"
#include "Unit_Main.h"

//---------------------------------------------------------------------------

#pragma package(smart_init)
//===========================================================================
TGraph::TGraph(HWND aMainFormHandle, bool *apStrobing, TFloat *apLuchDistance)
{
    fMainFormHandle = aMainFormHandle;
    fMainDC         = GetDC(fMainFormHandle);
    fpStrobing      = apStrobing;
    fpLuchDistance  = apLuchDistance;
  // ----------------

    GraphWindow[0].DrawValues    = NULL; GraphWindow[0].ValuesCount = 0;
    GraphWindow[1].DrawValues    = NULL; GraphWindow[1].ValuesCount = 0;
    GraphWindow[0].Values        = NULL;
    GraphWindow[1].Values        = NULL;
    GraphWindow[0].OldDrawValues = NULL;
    GraphWindow[1].OldDrawValues = NULL;

    OutPointArray[0] = (TPoint*) malloc (sizeof(TPoint) * (CountEllipsePoint + 2));
    OutPointArray[1] = (TPoint*) malloc (sizeof(TPoint) * (CountEllipsePoint + 2));
    OutPointArray[2] = (TPoint*) malloc (sizeof(TPoint) * (CountEllipsePoint + 2));
    OutPointArray[3] = (TPoint*) malloc (sizeof(TPoint) * (CountEllipsePoint + 2));
    OutPointArray[4] = (TPoint*) malloc (sizeof(TPoint) * (CountEllipsePoint + 2));
    OutPointArray[6] = (TPoint*) malloc (sizeof(TPoint) * (CountEllipsePoint + 2));
    OutPointArray[7] = (TPoint*) malloc (sizeof(TPoint) * (CountEllipsePoint + 2));

//    GraphWindow[2].DrawValues  = NULL; GraphWindow[2].ValuesCount = 0;

  // ----------------
  // ----------------
    fRedrawBitmapDC            = NULL;
  // ----------------
    fRedrawBitmapDC            = CreateCompatibleDC(fMainDC);
//   fBGBrush_Color_Black       = CreateSolidBrush(clBlack);

//    fBGColor                   = RGB(24, 43, 43);
    fBrush_Color_Red           = CreateSolidBrush(clRed);
    fBrush_Color_Yellow        = CreateSolidBrush(clYellow);
//    fBGB1                      = CreateSolidBrush(RGB(255, 0, 0));
    fBGBrush_Color             = CreateSolidBrush(Graph_BGColor);
    fBGPen_Color               = CreatePen(PS_SOLID, 1, Graph_BGColor);
    fPen_AxisColor             = CreatePen(PS_SOLID, 1, Graph_AxisColor);
    fPen_CurveColor            = CreatePen(PS_SOLID, 1, Graph_CurveColor);


    fPen_Black                 = GetStockObject(BLACK_PEN);
    fPen_DarkGray              = CreatePen(PS_SOLID, 1, RGB(75,75,75)   ); //

    fPen_Black2                = CreatePen(PS_SOLID, 1, RGB(0,0,0)); // RGB(65,65,65)
    fPen_Gray                  = CreatePen(PS_SOLID, 1, RGB(128,128,128)); // RGB(65,65,65)

    fPen_Red                   = CreatePen(PS_SOLID, 1, RGB(255,0,0));
    fPen_Green                 = CreatePen(PS_SOLID, 1, RGB(0,255,0));
    fPen_Blue                  = CreatePen(PS_SOLID, 1, RGB(0,0,255));
    fPen_Yellow                = CreatePen(PS_SOLID, 1, clYellow);
    fPen_White                 = CreatePen(PS_SOLID, 1, clWhite );

    hPenArray[0]               = fPen_White;
    hPenArray[1]               = fPen_Red;
    hPenArray[2]               = fPen_Green;
    hPenArray[3]               = fPen_Blue;
    hPenArray[4]               = fPen_Yellow;
    hPenArray[5]               = fPen_White;

    fFont_Other               = CreateFont(13,0,0,0,FW_NORMAL, FALSE, FALSE,FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH|FF_DONTCARE, "Arial");//
    fFont_Title               = CreateFont(13,0,0,0,FW_BOLD, FALSE, FALSE,FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH|FF_DONTCARE, "MS Sans Serif");//
  // ----------------
    iResize(NULL);
}

//===========================================================================
TGraph::~TGraph()
{
  if (GraphWindow[0].DrawValues != NULL) free (GraphWindow[0].DrawValues);
  if (GraphWindow[1].DrawValues != NULL) free (GraphWindow[1].DrawValues);
  if (GraphWindow[0].Values != NULL) free (GraphWindow[0].Values);
  if (GraphWindow[1].Values != NULL) free (GraphWindow[1].Values);
  if (GraphWindow[0].OldDrawValues != NULL) free (GraphWindow[0].OldDrawValues);
  if (GraphWindow[1].OldDrawValues != NULL) free (GraphWindow[1].OldDrawValues);

  free (OutPointArray[0]);
  free (OutPointArray[1]);
  free (OutPointArray[2]);
  free (OutPointArray[3]);
  free (OutPointArray[4]);
  free (OutPointArray[6]);
  free (OutPointArray[7]);

//  if (GraphWindow[2].DrawValues != NULL) free (GraphWindow[2].DrawValues);
  GraphWindow[0].ValuesCount = 0;
  GraphWindow[1].ValuesCount = 0;
//  GraphWindow[2].ValuesCount = 0;

  if (fRedrawBitmap != NULL) DeleteObject(fRedrawBitmap); fRedrawBitmap = NULL;

  DeleteObject(fRedrawBitmapDC);
  DeleteObject(fBGBrush_Color);
  DeleteObject(fBrush_Color_Red);
  DeleteObject(fBrush_Color_Yellow);
//*  DeleteObject(fBGB1);
//  DeleteObject(fBGBrush_Color_Black);

  DeleteObject(fBGPen_Color);

  DeleteObject(fPen_AxisColor);
  DeleteObject(fPen_CurveColor);

  DeleteObject(fPen_Black);
  DeleteObject(fPen_DarkGray);
  DeleteObject(fPen_Gray);
  DeleteObject(fPen_Black2);

  DeleteObject(fPen_Red);
  DeleteObject(fPen_Green);
  DeleteObject(fPen_Blue);
  DeleteObject(fPen_Yellow);
  DeleteObject(fPen_White);

  DeleteObject(fFont_Title);
  DeleteObject(fFont_Other);
}

void TGraph::SetColors()
{
  DeleteObject(fBGBrush_Color);
  DeleteObject(fBGPen_Color);
  DeleteObject(fPen_AxisColor);
  DeleteObject(fPen_CurveColor);

    fBGBrush_Color             = CreateSolidBrush(Graph_BGColor);
    fBGPen_Color               = CreatePen(PS_SOLID, 1, Graph_BGColor);
    fPen_AxisColor             = CreatePen(PS_SOLID, 1, Graph_AxisColor);
    fPen_CurveColor            = CreatePen(PS_SOLID, 1, Graph_CurveColor);
}

void TGraph::Init()
{
  for (int i = 0 ; i < 2; i ++){
       if (GraphWindow[i].DrawValues    != NULL) free (GraphWindow[i].DrawValues);
       if (GraphWindow[i].Values    != NULL) free (GraphWindow[i].Values);
       if (GraphWindow[i].OldDrawValues != NULL) free (GraphWindow[i].OldDrawValues);
       GraphWindow[i].DrawValues = NULL;
       GraphWindow[i].Values = NULL;
       GraphWindow[i].OldDrawValues = NULL;
       GraphWindow[i].ValuesCount = 0;
       GraphWindow[i].Max     =  0.000000001;
       GraphWindow[i].Min     = -0.00000000001;
       GraphWindow[i].Coef    = -999999.0;
       GraphWindow[i].OldCoef = -1;
       GraphWindow[i].OldTextPos = Point(-1,-1);
  }

  OutPointArray[0][0].x = -999;
  OutPointArray[0][0].y = -999;
  ConstDropCount        = 8;

  // --------------- Коеффициенты необходимые для расчета еллипсов ---------
  CoefY = CoefX = 1;

  MinEpsOffset = MinAzimOffset =  9999999;
  MaxEpsOffset = MaxAzimOffset = -9999999;

  DropCount = 0;
  OnPaint   = false;
  OldMousePos[0] = OldMousePos[1] = OldMousePos[2] = MousePos    = Point(-1,-1);

  iPaint(NULL);
}

void TGraph::Changed()
{
    if (fRedrawBitmap != NULL) DeleteObject(fRedrawBitmap); fRedrawBitmap = NULL;

  // ----------
    BITMAPINFO aBitmapInfo;
  // ----------

    aBitmapInfo.bmiHeader.biSize          = sizeof(BITMAPINFOHEADER);
    aBitmapInfo.bmiHeader.biWidth         = fiWidth;
    aBitmapInfo.bmiHeader.biHeight        = fiHeight;
    aBitmapInfo.bmiHeader.biPlanes        = 1;
    aBitmapInfo.bmiHeader.biBitCount      = 16;
    aBitmapInfo.bmiHeader.biCompression   = BI_RGB;
    aBitmapInfo.bmiHeader.biSizeImage     = 0;
    aBitmapInfo.bmiHeader.biXPelsPerMeter = 0;
    aBitmapInfo.bmiHeader.biYPelsPerMeter = 0;
    aBitmapInfo.bmiHeader.biClrUsed       = 0;
    aBitmapInfo.bmiHeader.biClrImportant  = 0;
    aBitmapInfo.bmiColors[0].rgbBlue      = 0;
    aBitmapInfo.bmiColors[0].rgbGreen     = 0;
    aBitmapInfo.bmiColors[0].rgbRed       = 0;
    aBitmapInfo.bmiColors[0].rgbReserved  = 0;
  // ----------

  // ---------------
    fRedrawBitmap = CreateDIBSection(fRedrawBitmapDC, &aBitmapInfo, DIB_RGB_COLORS, NULL, NULL, 0);

    SelectObject(fRedrawBitmapDC, fRedrawBitmap);
    SelectObject(fRedrawBitmapDC, fPen_DarkGray);
    SelectObject(fRedrawBitmapDC, fBGBrush_Color);


  // ------- Заполнение чорным цветом ----------
    //FillRect(fRedrawBitmapDC, &fMainFormRect, fBGBrush_Color);

  // ---------------- Отрисовка Трех рабочих полей  ---------------
    int aPoleHeight = fiHeight / 3.3;

    for (int i = 0 ; i < 2; i++) {
         GraphWindow[i].GraphRect = Rect (0, i * aPoleHeight - i, fiWidth, (i + 1)*aPoleHeight);
         GraphWindow[i].PoleRect  = Rect (GraphWindow[i].GraphRect.Left + 43, GraphWindow[i].GraphRect.Top + 27,  GraphWindow[i].GraphRect.Right - 25, GraphWindow[i].GraphRect.Bottom - 25);
         GraphWindow[i].ZeroPos   =  GraphWindow[i].PoleRect.Top + GraphWindow[i].PoleRect.Height() / 2;

      // -------- Граници графиков ---------
        SelectObject(fRedrawBitmapDC, fPen_DarkGray);
        SelectObject(fRedrawBitmapDC, fBGBrush_Color);
        Rectangle(fRedrawBitmapDC, GraphWindow[i].GraphRect.Left, GraphWindow[i].GraphRect.Top, GraphWindow[i].GraphRect.Right, GraphWindow[i].GraphRect.Bottom);

//        FillRect(fRedrawBitmapDC, &GraphWindow[i].PoleRect, fBGBrush_Color_Black);

      // -------- Левая Ось -----------
        SelectObject(fRedrawBitmapDC, fPen_AxisColor);
        MoveToEx(fRedrawBitmapDC, GraphWindow[i].PoleRect.Left    , GraphWindow[i].PoleRect.Bottom + 4, NULL);
        LineTo  (fRedrawBitmapDC, GraphWindow[i].PoleRect.Left    , GraphWindow[i].PoleRect.Top - 20);
        LineTo  (fRedrawBitmapDC, GraphWindow[i].PoleRect.Left - 3, GraphWindow[i].PoleRect.Top +  0);

        MoveToEx(fRedrawBitmapDC, GraphWindow[i].PoleRect.Left    , GraphWindow[i].PoleRect.Top - 20, NULL);
        LineTo  (fRedrawBitmapDC, GraphWindow[i].PoleRect.Left + 3, GraphWindow[i].PoleRect.Top +  0);

      // -------- Оtрисовкап нуля -----------
        SelectObject(fRedrawBitmapDC, fPen_AxisColor);
        MoveToEx(fRedrawBitmapDC, GraphWindow[i].PoleRect.Left  - 3 , GraphWindow[i].ZeroPos, NULL);
        LineTo  (fRedrawBitmapDC, GraphWindow[i].PoleRect.Right + 4 , GraphWindow[i].ZeroPos);
        LineTo  (fRedrawBitmapDC, GraphWindow[i].PoleRect.Right - 14, GraphWindow[i].ZeroPos - 3);
        LineTo  (fRedrawBitmapDC, GraphWindow[i].PoleRect.Right + 4 , GraphWindow[i].ZeroPos);
        LineTo  (fRedrawBitmapDC, GraphWindow[i].PoleRect.Right - 14, GraphWindow[i].ZeroPos + 3);

      // -------- Отрисовка Названия графика -----------
        if (GraphWindow[i].GraphName.data() != NULL)
        _TextOut_(fRedrawBitmapDC, (GraphWindow[i].GraphRect.Right - GraphWindow[i].GraphRect.Left) / 2 , GraphWindow[i].GraphRect.Top + 5, TA_CENTER, TRANSPARENT, fFont_Title, (TColor)Graph_TitleColor, &GraphWindow[i].GraphName);

    }
  // ------------------ Отрисовка нижжнего прямоуглоника ----------

     GraphWindow[2].GraphRect = Rect (0, GraphWindow[1].GraphRect.Bottom - 1, fiWidth, fiHeight - 2);
     GraphWindow[2].PoleRect  = Rect (GraphWindow[2].GraphRect.Left + 43, GraphWindow[2].GraphRect.Top + 47,  GraphWindow[2].GraphRect.Right - 35, GraphWindow[2].GraphRect.Bottom - 45);

     SelectObject(fRedrawBitmapDC, fPen_DarkGray);
     SelectObject(fRedrawBitmapDC, fBGBrush_Color);
     Rectangle   (fRedrawBitmapDC, GraphWindow[2].GraphRect.Left, GraphWindow[2].GraphRect.Top, GraphWindow[2].GraphRect.Right, GraphWindow[2].GraphRect.Bottom);
     // Ellipse (fRedrawBitmapDC, GraphWindow[2].GraphRect.Left, GraphWindow[2].GraphRect.Bottom, GraphWindow[2].GraphRect.Right, GraphWindow[2].GraphRect.Bottom);

  // ------------ Отрисовка Осей -----------
      SelectObject(fRedrawBitmapDC, fPen_AxisColor);
      MoveToEx(fRedrawBitmapDC, GraphWindow[2].PoleRect.Left  - 12, GraphWindow[2].PoleRect.Bottom + 2, NULL);
      LineTo  (fRedrawBitmapDC, GraphWindow[2].PoleRect.Right + 20, GraphWindow[2].PoleRect.Bottom + 2);
      LineTo  (fRedrawBitmapDC, GraphWindow[2].PoleRect.Right +  0, GraphWindow[2].PoleRect.Bottom + 5);
      MoveToEx(fRedrawBitmapDC, GraphWindow[2].PoleRect.Right + 20, GraphWindow[2].PoleRect.Bottom + 2, NULL);
      LineTo  (fRedrawBitmapDC, GraphWindow[2].PoleRect.Right +  0, GraphWindow[2].PoleRect.Bottom - 1);

      MoveToEx(fRedrawBitmapDC, GraphWindow[2].PoleRect.Left - 2, GraphWindow[2].PoleRect.Bottom + 12, NULL);
      LineTo  (fRedrawBitmapDC, GraphWindow[2].PoleRect.Left - 2, GraphWindow[2].PoleRect.Top - 20);
      LineTo  (fRedrawBitmapDC, GraphWindow[2].PoleRect.Left - 5, GraphWindow[2].PoleRect.Top +  0);

      MoveToEx(fRedrawBitmapDC, GraphWindow[2].PoleRect.Left - 2, GraphWindow[2].PoleRect.Top - 20, NULL);
      LineTo  (fRedrawBitmapDC, GraphWindow[2].PoleRect.Left + 1, GraphWindow[2].PoleRect.Top +  0);

  // -------- Отрисовка Названия графика -----------
      AnsiString aText1 = "Сечение лучей ДНА системе координат ФАР";
     _TextOut_(fRedrawBitmapDC, (GraphWindow[2].GraphRect.Right - GraphWindow[2].GraphRect.Left) / 2 , GraphWindow[2].GraphRect.Top + 5, TA_CENTER, TRANSPARENT, fFont_Title, (TColor)Graph_TitleColor, &aText1);

  // -------- Отрисовка подписей -----------
      AnsiString aText2 = "Teta = ";
      AnsiString aText3 = "Fi = ";
     _TextOut_(fRedrawBitmapDC, GraphWindow[2].GraphRect.Left + 80                                  , GraphWindow[2].GraphRect.Bottom - 20, TA_RIGHT, TRANSPARENT, fFont_Title, (TColor)Graph_TitleColor, &aText2);
     _TextOut_(fRedrawBitmapDC, 20 + (GraphWindow[2].GraphRect.Right - GraphWindow[2].GraphRect.Left) / 2, GraphWindow[2].GraphRect.Bottom - 20, TA_RIGHT, TRANSPARENT, fFont_Title, (TColor)Graph_TitleColor, &aText3);
}

//===========================================================================
void TGraph::ReDraw()
{
    iPaint(NULL);
}

//===========================================================================
void __fastcall TGraph::iResize(TObject *Sender)
{
    Init();
   // ----------

    GetClientRect(fMainFormHandle, &fParentRect);

    fiHeight    = fParentRect.Height();
    fiWidth     = fParentRect.Width();

   // ----------
    Changed();
    iPaint(NULL);
}

//===========================================================================
void __fastcall TGraph::iPaint(TObject *Sender)
{
   OnPaint = true;
   EllipseRedraw = true;
  // ------------------------------------------------------
   BitBlt(fMainDC, 0, 0, fiWidth, fiHeight, fRedrawBitmapDC, 0, 0, SRCCOPY); //копирование битмапа на экран
  // ------------------------------------------------------
   Draw();
  // ------------------------------------------------------
   OnPaint = false;
}

//===========================================================================
void __fastcall TGraph::iMouseMove (TObject *Sender, TShiftState Shift, int X, int Y)
{
   MousePos = Point(X, Y);
   /////////////////////////
      for (int i = 0; i < 2; i ++){
            if (OldMousePos[i].x != -1) {
                 // -------- Закраска отрисовки старых координат -------------
                    SelectObject(fMainDC, fBGPen_Color);
                    MoveToEx(fMainDC, GraphWindow[i].PoleRect.Left + 1, OldMousePos[i].y, NULL); LineTo(fMainDC, GraphWindow[i].PoleRect.Right - 12, OldMousePos[i].y);
                    BitBlt  (fMainDC, 1, GraphWindow[i].PoleRect.Top - 2, GraphWindow[i].PoleRect.Left, GraphWindow[i].PoleRect.Height() + 3, fRedrawBitmapDC, 1, GraphWindow[i].PoleRect.Top - 2, SRCCOPY); //копирование битмапа на экран
                    _TextOut_(fMainDC, GraphWindow[i].PoleRect.Left - 7, GraphWindow[i].ZeroPos, TA_RIGHT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &IntToStr(0));
                // --------------
                    OldMousePos[i] = Point(-1,-1);
            }
            if ( X > GraphWindow[i].PoleRect.Left + 5 && X < GraphWindow[i].PoleRect.Right - 5 && Y > GraphWindow[i].PoleRect.Top + 5 && Y < GraphWindow[i].PoleRect.Bottom - 5) {
                  int OffsetY = GraphWindow[i].PoleRect.Bottom - Y;

                 SelectObject(fMainDC, fPen_AxisColor);
                 MoveToEx(fMainDC, GraphWindow[i].PoleRect.Left + 1, Y, NULL); LineTo(fMainDC, GraphWindow[i].PoleRect.Right - 12, Y);
               // -------- Нулевая линия --------
                 MoveToEx(fMainDC, GraphWindow[i].PoleRect.Left - 3  , GraphWindow[i].ZeroPos, NULL); LineTo  (fMainDC, GraphWindow[i].PoleRect.Right + 4 , GraphWindow[i].ZeroPos);


                  TFloat aValue = (OffsetY / GraphWindow[i].Coef + GraphWindow[i].Min) * _180_del_Pi;
               /////////////
                 AnsiString strValue = FloatToStrF(aValue, ffFixed, 10, 2);
                 if (GraphWindow[i].Coef < -9999) strValue = "0.00";
                 //BitBlt  (fMainDC, 1, GraphWindow[i].PoleRect.Top - 2, GraphWindow[i].PoleRect.Left, GraphWindow[i].PoleRect.Height() + 3, fRedrawBitmapDC, 1, GraphWindow[i].PoleRect.Top - 2, SRCCOPY); //копирование битмапа на экран
                _TextOut_(fMainDC, GraphWindow[i].PoleRect.Left - 6, Y, TA_RIGHT | TA_BASELINE,TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &strValue);
               /////////////

                 SelectObject(fMainDC, fPen_CurveColor);
                 Polyline(fMainDC, GraphWindow[i].OldDrawValues, GraphWindow[i].ValuesCount - ConstDropCount - 1);

                 OldMousePos[i] = MousePos;
          }
      }
   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if (OldMousePos[2].x != -1) {
         // -------- Закраска отрисовки старых координат -------------
            SelectObject(fMainDC, fBGPen_Color);
            MoveToEx(fMainDC, GraphWindow[2].PoleRect.Left , OldMousePos[2].y, NULL); LineTo(fMainDC, GraphWindow[2].PoleRect.Right + 8, OldMousePos[2].y);
            MoveToEx(fMainDC, OldMousePos[2].x, GraphWindow[2].PoleRect.Top  - 8, NULL); LineTo(fMainDC, OldMousePos[2].x, GraphWindow[2].PoleRect.Bottom );

            BitBlt  (fMainDC, 1, GraphWindow[2].GraphRect.Top, GraphWindow[2].PoleRect.Left, GraphWindow[2].GraphRect.Height(), fRedrawBitmapDC, 1, GraphWindow[2].GraphRect.Top, SRCCOPY); //копирование битмапа на экран
            BitBlt  (fMainDC, GraphWindow[2].PoleRect.Left, GraphWindow[2].PoleRect.Bottom, GraphWindow[2].PoleRect.Width() + 15, GraphWindow[2].GraphRect.Bottom - GraphWindow[2].PoleRect.Bottom, fRedrawBitmapDC, GraphWindow[2].PoleRect.Left, GraphWindow[2].PoleRect.Bottom, SRCCOPY); //копирование битмапа на экран
//            BitBlt  (fRedrawBitmapDC, GraphWindow[2].GraphRect.Left + 60                                  , GraphWindow[2].GraphRect.Bottom - 20, TA_LEFT, TRANSPARENT, fFont_Title, (TColor)Graph_TitleColor, &strTeta);
 //           BitBlt  (fRedrawBitmapDC, (GraphWindow[2].GraphRect.Right - GraphWindow[2].GraphRect.Left) / 2, GraphWindow[2].GraphRect.Bottom - 20, TA_LEFT, TRANSPARENT, fFont_Title, (TColor)Graph_TitleColor, &strFi);

        // --------------
            OldMousePos[2] = Point(-1,-1);
            EllipseRedraw = true;
            DrawEllpses();
      }
      if ( X > GraphWindow[2].PoleRect.Left + 5 && X < GraphWindow[2].PoleRect.Right - 5 && Y > GraphWindow[2].PoleRect.Top + 5 && Y < GraphWindow[2].PoleRect.Bottom - 5) {
            int OffsetX = X - GraphWindow[2].PoleRect.Left;
            int OffsetY = GraphWindow[2].PoleRect.Bottom - Y;

            SelectObject(fMainDC, fPen_AxisColor);
            MoveToEx(fMainDC, GraphWindow[2].PoleRect.Left - 8, Y, NULL); LineTo(fMainDC, GraphWindow[2].PoleRect.Right + 8, Y);
            MoveToEx(fMainDC, X, GraphWindow[2].PoleRect.Top  - 8, NULL); LineTo(fMainDC, X, GraphWindow[2].PoleRect.Bottom + 8);

            TFloat aaTeta, aaFi;
            TFloat aaZ    = (OffsetX / CoefX + MinAzimOffset);
            TFloat aaE    = (OffsetY / CoefY + MinEpsOffset);
            aFar->Calc_DeltaQ_DeltaAlfa_Teta_Fi(aaZ, aaE, aaTeta, aaFi);
         /////////////

           AnsiString strE    = FloatToStrF(aaE    * _180_del_Pi, ffFixed, 10, 2);
           AnsiString strZ    = FloatToStrF(aaZ    * _180_del_Pi, ffFixed, 10, 2);
           AnsiString strTeta = FloatToStrF(aaTeta * _180_del_Pi, ffFixed, 10, 2) + " гр";
           AnsiString strFi   = FloatToStrF(aaFi   * _180_del_Pi, ffFixed, 10, 2) + " гр";

           if (fabs(aaE) > 9999 || fabs(aaZ) > 9999) {
              strE = "0.00";
              strZ = "0.00";
              strTeta = "0.00 гр";
              strFi   = "0.00 гр";
           }
          _TextOut_(fMainDC, GraphWindow[2].PoleRect.Left - 6, Y, TA_RIGHT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &strE);
          _TextOut_(fMainDC, X, GraphWindow[2].PoleRect.Bottom + 6 , TA_CENTER, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &strZ);

          _TextOut_(fMainDC, GraphWindow[2].GraphRect.Left + 80                                  , GraphWindow[2].GraphRect.Bottom - 20, TA_LEFT, TRANSPARENT, fFont_Title, (TColor)Graph_TitleColor, &strTeta);
          _TextOut_(fMainDC, 20 + (GraphWindow[2].GraphRect.Right - GraphWindow[2].GraphRect.Left) / 2, GraphWindow[2].GraphRect.Bottom - 20, TA_LEFT, TRANSPARENT, fFont_Title, (TColor)Graph_TitleColor, &strFi);

          OldMousePos[2] = MousePos;
    }
}

void __fastcall TGraph::iMouseDown      (TObject *Sender, TMouseButton Button, TShiftState Shift, int X, int Y) { }
void __fastcall TGraph::iMouseUp        (TObject *Sender, TMouseButton Button, TShiftState Shift, int X, int Y) { }
void __fastcall TGraph::iMouseOnDblClick(TObject *Sender) { }
void __fastcall TGraph::iMouseOnClick   (TObject *Sender)
{
  for (int i = 0; i < 2; i++)
     if (MousePos.x > GraphWindow[i].PoleRect.Left && MousePos.x < GraphWindow[i].PoleRect.Right &&
         MousePos.y > GraphWindow[i].PoleRect.Top  && MousePos.y < GraphWindow[i].PoleRect.Bottom){

         frmGraphicList->NumberControlGraphic = i;
         frmGraphicList->GraphIndex = GraphWindow[i].GlobalGraphIndex;
         frmGraphicList->Show();
    }
}

//===========================================================================
void TGraph::_TextOut_(HDC aHDC, int x, int y, unsigned int aTextAlign, int iBkMode, HFONT aFont, TColor aColor, AnsiString *aString)
{
   SetBkMode(aHDC, iBkMode);
       SelectObject(aHDC, aFont);
       SetTextColor(aHDC, aColor);
       SetTextAlign(aHDC, aTextAlign);

       TextOut(aHDC, x, y, aString->c_str(), aString->Length());

   SetBkMode(aHDC, OPAQUE);
}

//===========================================================================
void TGraph::DrawGraphic()
{
   // -------------- Закраска предыдучей Кривой -----------
      if (DropCount > ConstDropCount || Paused) {
         SelectObject(fMainDC, fBGPen_Color);
         for (int i = 0 ; i < 2; i++) {
            Polyline(fMainDC, GraphWindow[i].OldDrawValues, GraphWindow[i].ValuesCount - ConstDropCount - 1);

            if (GraphWindow[i].OldTextPos.y != -1){
                int x1 = GraphWindow[i].OldTextPos.x;
                int y1 = GraphWindow[i].OldTextPos.y-15;
                int width = 55;
                int height = 25;
                SelectObject(fMainDC, GetStockObject(GRAY_BRUSH));
                //Rectangle(fMainDC, x1, y1, x1 + width, y1 + height);
                BitBlt   (fMainDC, x1, y1,      width,      height, fRedrawBitmapDC, x1, y1, SRCCOPY); //копирование битмапа на экран
            }
         }
      }

 // ------------------------
    for (int i = 0 ; i < 2; i++) {
       // ------------ Заполнение Данными ---------------
        if (GraphWindow[i].ValuesCount < GraphWindow[i].PoleRect.Width()){
               GraphWindow[i].ValuesCount ++;
               GraphWindow[i].DrawValues    = (TPoint*) realloc (GraphWindow[i].DrawValues   , sizeof(TPoint) * GraphWindow[i].ValuesCount);
               GraphWindow[i].Values        = (TFloat*) realloc (GraphWindow[i].Values       , sizeof(TFloat) * GraphWindow[i].ValuesCount);
               GraphWindow[i].OldDrawValues = (TPoint*) realloc (GraphWindow[i].OldDrawValues, sizeof(TPoint) * GraphWindow[i].ValuesCount);

               GraphWindow[i].DrawValues[GraphWindow[i].ValuesCount - 1].x = GraphWindow[i].PoleRect.Left + GraphWindow[i].ValuesCount;
        } else {
               for (int k = 0 ; k < GraphWindow[i].ValuesCount - 1; k++) GraphWindow[i].DrawValues[k].y = GraphWindow[i].DrawValues[k+1].y;
               for (int k = 0 ; k < GraphWindow[i].ValuesCount - 1; k++) GraphWindow[i].Values[k]       = GraphWindow[i].Values[k+1];
        }

       // ------- Расчет Максимумов и минимумов , Коэфициентов и текущих щначений ---------
          if (GraphWindow[i].Max < *GraphWindow[i].Value || GraphWindow[i].Min > *GraphWindow[i].Value || OnPaint) {
              GraphWindow[i].Max = (*GraphWindow[i].Value >  fabs(GraphWindow[i].Min)) ? *GraphWindow[i].Value : fabs(GraphWindow[i].Min);
              GraphWindow[i].Min = (*GraphWindow[i].Value < -fabs(GraphWindow[i].Max)) ? *GraphWindow[i].Value : -fabs(GraphWindow[i].Max);

              TFloat ValueMax = GraphWindow[i].Max * GraphWindow[i].TransformCoef;
              TFloat ValueMin = GraphWindow[i].Min * GraphWindow[i].TransformCoef;
              int    CountDigitMax = 1;
              int    CountDigitMin = 1;

              if (ValueMax < 0.01) CountDigitMax = 3;
                 else if (ValueMax < 0.1 ) CountDigitMax = 2;
                      else if (ValueMax < 1   ) CountDigitMax = 1;
              if (ValueMin >-0.01) CountDigitMin = 3;
                 else if (ValueMin >-0.1 ) CountDigitMin = 2;
                      else if (ValueMin >-1   ) CountDigitMin = 1;

              BitBlt   (fMainDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].PoleRect.Top - 14, 40, 40, fRedrawBitmapDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].PoleRect.Top - 14, SRCCOPY); //копирование битмапа на экран
             _TextOut_(fMainDC, GraphWindow[i].PoleRect.Left - 7, GraphWindow[i].PoleRect.Top - 4, TA_RIGHT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &FloatToStrF(GraphWindow[i].Max * GraphWindow[i].TransformCoef, ffFixed, 2, CountDigitMax));
              BitBlt   (fMainDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].PoleRect.Bottom - 10, 40, 40, fRedrawBitmapDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].PoleRect.Bottom - 10, SRCCOPY); //копирование битмапа на экран
             _TextOut_(fMainDC, GraphWindow[i].PoleRect.Left - 7, GraphWindow[i].PoleRect.Bottom + 8, TA_RIGHT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &FloatToStrF(GraphWindow[i].Min * GraphWindow[i].TransformCoef, ffFixed, 2, CountDigitMin));

              BitBlt   (fMainDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].ZeroPos - 10, 40, 40, fRedrawBitmapDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].ZeroPos - 10, SRCCOPY); //копирование битмапа на экран
             _TextOut_(fMainDC, GraphWindow[i].PoleRect.Left - 7, GraphWindow[i].ZeroPos, TA_RIGHT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &IntToStr(0));
/*
              BitBlt   (fMainDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].PoleRect.Top - 10, 40, 40, fRedrawBitmapDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].PoleRect.Top - 10, SRCCOPY); //копирование битмапа на экран
             _TextOut_(fMainDC, GraphWindow[i].PoleRect.Left - 7, GraphWindow[i].PoleRect.Top, TA_RIGHT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &FloatToStrF(GraphWindow[i].Max * GraphWindow[i].TransformCoef, ffFixed, 2, CountDigitMax));
              BitBlt   (fMainDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].PoleRect.Bottom - 10, 40, 40, fRedrawBitmapDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].PoleRect.Bottom - 10, SRCCOPY); //копирование битмапа на экран
             _TextOut_(fMainDC, GraphWindow[i].PoleRect.Left - 7, GraphWindow[i].PoleRect.Bottom, TA_RIGHT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &FloatToStrF(GraphWindow[i].Min * GraphWindow[i].TransformCoef, ffFixed, 2, CountDigitMin));
              BitBlt   (fMainDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].ZeroPos - 10, 40, 40, fRedrawBitmapDC, GraphWindow[i].GraphRect.Left,  GraphWindow[i].ZeroPos - 10, SRCCOPY); //копирование битмапа на экран
             _TextOut_(fMainDC, GraphWindow[i].PoleRect.Left - 7, GraphWindow[i].ZeroPos, TA_RIGHT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &IntToStr(0));
*/          }

          GraphWindow[i].Coef                                         =  GraphWindow[i].PoleRect.Height()/(GraphWindow[i].Max - GraphWindow[i].Min);

          GraphWindow[i].Values[GraphWindow[i].ValuesCount - 1]       = *GraphWindow[i].Value;
          GraphWindow[i].DrawValues[GraphWindow[i].ValuesCount - 1].y =  GraphWindow[i].ZeroPos - *GraphWindow[i].Value*GraphWindow[i].Coef;
       // -------------  Отрисовка ---------------
        if (DropCount > ConstDropCount || Paused) {
             if (GraphWindow[i].OldCoef != GraphWindow[i].Coef)
                 for (int k = 0; k < GraphWindow[i].ValuesCount; k++) GraphWindow[i].DrawValues[k].y  = GraphWindow[i].ZeroPos - GraphWindow[i].Values[k]*GraphWindow[i].Coef;

           // -------- Нулевая линия --------
             SelectObject(fMainDC, fPen_AxisColor );
             MoveToEx(fMainDC, GraphWindow[i].PoleRect.Left - 3  , GraphWindow[i].ZeroPos, NULL);
             LineTo  (fMainDC, GraphWindow[i].PoleRect.Right + 4 , GraphWindow[i].ZeroPos);
             LineTo  (fMainDC, GraphWindow[i].PoleRect.Right - 14, GraphWindow[i].ZeroPos - 3);
             LineTo  (fMainDC, GraphWindow[i].PoleRect.Right + 4 , GraphWindow[i].ZeroPos);
             LineTo  (fMainDC, GraphWindow[i].PoleRect.Right - 14, GraphWindow[i].ZeroPos + 3);
           // -------- Кривая графика --------

             SelectObject(fMainDC, fPen_CurveColor);  Polyline(fMainDC, GraphWindow[i].DrawValues, GraphWindow[i].ValuesCount - ConstDropCount - 1);

          // --------- Вывод тукущего значения кривой ----------
              int Index = GraphWindow[i].ValuesCount - ConstDropCount - 2;
              if (Index >= 0) {
                  GraphWindow[i].OldTextPos = Point(GraphWindow[i].DrawValues[Index].x + 5, GraphWindow[i].DrawValues[Index].y);
                 _TextOut_(fMainDC, GraphWindow[i].OldTextPos.x, GraphWindow[i].OldTextPos.y, TA_LEFT | TA_BASELINE, TRANSPARENT, fFont_Other, (TColor)Graph_TitleColor, &FloatToStrF(GraphWindow[i].Values[Index] * GraphWindow[i].TransformCoef, ffFixed, 2, 2));
              }
           // ----------- Old Values --------
             GraphWindow[i].OldCoef    = GraphWindow[i].Coef;
             for (int k = 0; k < GraphWindow[i].ValuesCount; k++) GraphWindow[i].OldDrawValues[k] = GraphWindow[i].DrawValues[k];
        }
    }

  // --------------- Парматр прореживания графика ----------------
//    if (Paused) ConstDropCount = 0; else ConstDropCount = 8;
    if (DropCount > ConstDropCount) DropCount = -1;
    DropCount ++;
}

//===========================================================================
void TGraph::DrawEllpses()
{
     if (DiagramArray[0]->EllipseArray[0].x == -999 || !EllipseRedraw) return;
  // ------------------
        if (OutPointArray[0][0].x != -999){
            SelectObject(fMainDC, fBGPen_Color);
            SelectObject(fMainDC, fBGBrush_Color);
            for (int i = 0; i < Targets_Count;    i++) Ellipse(fMainDC, Targets[i]->Coord_Far_Clear.xy.x - 5, Targets[i]->Coord_Far_Clear.xy.y - 5, Targets[i]->Coord_Far_Clear.xy.x + 5, Targets[i]->Coord_Far_Clear.xy.y + 5);
            for (int i = 0; i < OldDiagram_Count; i++){ /// !!!
               Polyline(fMainDC, &OutPointArray[i][1], CountEllipsePoint + 1);
               Ellipse(fMainDC, OutPointArray[i][0].x-2, OutPointArray[i][0].y-2, OutPointArray[i][0].x+2, OutPointArray[i][0].y+2);
            }
            MoveToEx(fMainDC, RavnosignalPos.x - 10, RavnosignalPos.y    , NULL); LineTo(fMainDC, RavnosignalPos.x + 10, RavnosignalPos.y    );
            MoveToEx(fMainDC, RavnosignalPos.x    , RavnosignalPos.y - 10, NULL); LineTo(fMainDC, RavnosignalPos.x    , RavnosignalPos.y + 10);
        }

  // -------------------
     MinAzimOffset =  9999999;
     MaxAzimOffset = -9999999;
     MinEpsOffset  =  9999999;
     MaxEpsOffset  = -9999999;

  // -------- Нахожу глобальные максимумы и минимумы ------------
     for (int i = 0; i < Diagram_Count; i++){
           if (MinAzimOffset > DiagramArray[i]->eMinAzimOffset) MinAzimOffset = DiagramArray[i]->eMinAzimOffset;
           if (MaxAzimOffset < DiagramArray[i]->eMaxAzimOffset) MaxAzimOffset = DiagramArray[i]->eMaxAzimOffset;
           if (MinEpsOffset  > DiagramArray[i]->eMinEpsOffset ) MinEpsOffset  = DiagramArray[i]->eMinEpsOffset;
           if (MaxEpsOffset  < DiagramArray[i]->eMaxEpsOffset ) MaxEpsOffset  = DiagramArray[i]->eMaxEpsOffset;
     }

   // --------- Если  один луч ------ То выставляю параметры маштабирования так как нада ---------
     if (Diagram_Count == 1) {
        MinAzimOffset -= aFar->FarParam->Diagram.Shir*0.3;
        MaxAzimOffset += aFar->FarParam->Diagram.Shir*0.3;
        MinEpsOffset  -= aFar->FarParam->Diagram.Shir*0.3;
        MaxEpsOffset  += aFar->FarParam->Diagram.Shir*0.3;
     }

     MaxAzimOffset += (MaxAzimOffset - MinAzimOffset) * 0.071;
     MinAzimOffset -= (MaxAzimOffset - MinAzimOffset) * 0.071;
     MaxEpsOffset  += (MaxEpsOffset  - MinEpsOffset ) * 0.071;
     MinEpsOffset  -= (MaxEpsOffset  - MinEpsOffset ) * 0.071;
  // ------------- Расчет коэффициентов маштабирования ---------------
     CoefX = GraphWindow[2].PoleRect.Width () / (MaxAzimOffset - MinAzimOffset);
     CoefY = GraphWindow[2].PoleRect.Height() / (MaxEpsOffset  - MinEpsOffset );


  // --------- Отрисовка еллипсов ----------
     SelectObject(fMainDC, fPen_Gray);
     for (int k = 0; k <  Diagram_Count; k++) {
         if (*fpStrobing) SelectObject(fMainDC, hPenArray[k + 1]);
         for (int i = 0; i <= CountEllipsePoint; i++) {
             OutPointArray[k][i].x = GraphWindow[2].PoleRect.Left   + (DiagramArray[k]->EllipseArray[i].x - MinAzimOffset) * CoefX;
             OutPointArray[k][i].y = GraphWindow[2].PoleRect.Bottom - (DiagramArray[k]->EllipseArray[i].y - MinEpsOffset) * CoefY;
         }
        OutPointArray[k][CountEllipsePoint+1].x = OutPointArray[k][1].x;
        OutPointArray[k][CountEllipsePoint+1].y = OutPointArray[k][1].y;

        Polyline(fMainDC, &OutPointArray[k][1], CountEllipsePoint + 1);

        // ---------- Отрисовка центра еллипса --------
        Ellipse(fMainDC, OutPointArray[k][0].x-2, OutPointArray[k][0].y-2, OutPointArray[k][0].x+2, OutPointArray[k][0].y+2);
     }
  // ---------- Отрисовка равносигналки --------
     RavnosignalPos.x = GraphWindow[2].PoleRect.Left   + (aFar->DeltaQ    - MinAzimOffset) * CoefX;
     RavnosignalPos.y = GraphWindow[2].PoleRect.Bottom - (aFar->DeltaAlfa - MinEpsOffset) * CoefY;

     // ------- Если не в стробе то длина крестика очень маленькая ----------
     int aWidth = 4;
     if (*fpStrobing) aWidth = 10;
     SelectObject(fMainDC, hPenArray[0]);
     MoveToEx(fMainDC, RavnosignalPos.x - aWidth + 1, RavnosignalPos.y             , NULL); LineTo(fMainDC, RavnosignalPos.x + aWidth, RavnosignalPos.y    );
     MoveToEx(fMainDC, RavnosignalPos.x             , RavnosignalPos.y - aWidth + 1, NULL); LineTo(fMainDC, RavnosignalPos.x    , RavnosignalPos.y + aWidth);


  // -------- Отрисовка целей ---------
         for (int i = 0; i < Targets_Count; i ++ ){
             // --------- если Цель в диапазоне Еллпсов ---------

              if (Targets[i]->Coord_Far_Clear.Q <= MaxAzimOffset && Targets[i]->Coord_Far_Clear.Q >= MinAzimOffset && Targets[i]->Coord_Far_Clear.E <= MaxEpsOffset && Targets[i]->Coord_Far_Clear.E >= MinEpsOffset){

                    //if (*fpStrobing && Targets[i]->Coord_Far_Clear.Ri >= 0.9* *fpLuchDistance && Targets[i]->Coord_Far_Clear.Ri <= 1.1* *fpLuchDistance) SelectObject(fMainDC, fBrush_Color_Red);
                    //else SelectObject(fMainDC, fBrush_Color_Yellow);

                    SelectObject(fMainDC, fBrush_Color_Red);

                    Targets[i]->Coord_Far_Clear.xy.x = GraphWindow[2].PoleRect.Left   + (Targets[i]->Coord_Far_Clear.Q - MinAzimOffset) * CoefX;
                    Targets[i]->Coord_Far_Clear.xy.y = GraphWindow[2].PoleRect.Bottom - (Targets[i]->Coord_Far_Clear.E - MinEpsOffset) * CoefY;

                    if (*fpStrobing)
                    Ellipse(fMainDC, Targets[i]->Coord_Far_Clear.xy.x - 5, Targets[i]->Coord_Far_Clear.xy.y - 5, Targets[i]->Coord_Far_Clear.xy.x + 5, Targets[i]->Coord_Far_Clear.xy.y + 5);
              }
         }
  // ------------
     EllipseRedraw = false;
}

//===========================================================================
void TGraph::Draw()
{
    if (!Started) return;

  // -------- Отрисовка графиков --------
     DrawGraphic();

  // -------- Отрисовка срезов лучей ----------
     DrawEllpses();
  // --------
     iMouseMove (NULL, TShiftState(), MousePos.x, MousePos.y);
}
