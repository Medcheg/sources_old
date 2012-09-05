//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiIndicator.h"
#include <math.h>
#include <Math.hpp>
#include "mpiDeclaration.h"
#include "Unit_TargetsParam.h"
#include "Unit_Wave.h"

//===========================================================================

#pragma package(smart_init)

//===========================================================================
TIndicator::TIndicator(HWND aMainFormHandle, TFarParam * apFarParam, TFloat *apCurAzimPosNormalFar, TFloat *apCurAzimPosLuchFar, bool *apStrobing, TFloat *apLuchDistance, TStatusBar *asbWork)
{
    fMainFormHandle        = aMainFormHandle;
    fpFarParam             = apFarParam;
    fpCurAzimPosNormalFar  = apCurAzimPosNormalFar;
    fpCurAzimPosLuchFar    = apCurAzimPosLuchFar;
    fpStrobing             = apStrobing;
    fpLuchDistance         = apLuchDistance;
    fsbWork                = asbWork;
  // ----------------
    fIndicatorDistance = 150.0;
    fDistanceCoef      = 1.0;
    fMastabCoef        = 1.0;
    mDistance          = -999;
    mAzim              = -999;
    fRightButtonMouseDown = false;
    fLeftButtonMouseDown  = false;

  // ----------------
    fMainDC                    = GetDC(fMainFormHandle);
  // ----------------
    fRedrawBitmapDC            = NULL;
    fBGBrush_Color             = NULL;
  // ----------------
    fRedrawBitmapDC            = CreateCompatibleDC(fMainDC);
//    fBGBrush_Black             = CreateSolidBrush(clBlack);
//    fBGBrush_Color             = CreateSolidBrush(RGB(17,17,41));

//    fBGColor                   = RGB(24,43,43);
    fBGBrush_Color             = CreateSolidBrush(Indicator_BGColor);
    fBGPen_Color               = CreatePen(PS_SOLID, 1, Indicator_BGColor);
    fBGBrush_TargetColor       = CreateSolidBrush(Indicator_TargetColor);
    fPen_RingColor             = CreatePen(PS_SOLID, 1, Indicator_RingColor);

/*        HBRUSH              fBGBrush_Color;
        HPEN                fIndicator_RingColor;
        HBRUSH              ;
        HPEN                fIndicator_TargetFontColor;*/


    fPen_Black                 = GetStockObject(BLACK_PEN);
//    fPen_DarkGray              = CreatePen(PS_SOLID, 1, RGB(128,128,128)); // RGB(65,65,65)

    fPen_DarkGray              = CreatePen(PS_SOLID, 1, RGB(95,95,95)   ); //
    fPen_DarkRed               = CreatePen(PS_SOLID, 1, RGB(255,0,0));
    fPen_DarkGreen             = CreatePen(PS_SOLID, 1, RGB(0,255,0));

    fPen_Black2                = CreatePen(PS_SOLID, 1, RGB(0,0,0)); // RGB(65,65,65)
    fPen_Gray                  = CreatePen(PS_SOLID, 1, RGB(128,128,128)); // RGB(65,65,65)
    fPen_White                 = GetStockObject(WHITE_PEN);
    fPen_Yellow                = CreatePen(PS_SOLID, 1, clYellow        );

    fFont_Target               = CreateFont(13,0,0,0,FW_NORMAL, FALSE, FALSE,FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH|FF_DONTCARE, "Arial");//MS Sans Serif
  // ----------------
    iResize(NULL);
}

//===========================================================================
TIndicator::~TIndicator()
{
  if (fRedrawBitmap != NULL) DeleteObject(fRedrawBitmap); fRedrawBitmap = NULL;

  DeleteObject(fRedrawBitmapDC);
  DeleteObject(fBGBrush_Color);
  DeleteObject(fBGPen_Color);
  DeleteObject(fBGBrush_TargetColor);
  DeleteObject(fPen_RingColor);

  DeleteObject(fPen_Black);
  DeleteObject(fPen_DarkGray);
  DeleteObject(fPen_Gray);
  DeleteObject(fPen_White);

  DeleteObject(fPen_Yellow);
  DeleteObject(fPen_Black2);

  DeleteObject(fPen_DarkRed);
  DeleteObject(fPen_DarkGreen);

  DeleteObject(fFont_Target);
}

//===========================================================================
void TIndicator::SetColors()
{
  DeleteObject(fBGBrush_Color);
  DeleteObject(fBGPen_Color);
  DeleteObject(fPen_RingColor);
  DeleteObject(fBGBrush_TargetColor);

    fBGBrush_Color             = CreateSolidBrush(Indicator_BGColor);
    fBGPen_Color               = CreatePen(PS_SOLID, 1, Indicator_BGColor);
    fPen_RingColor             = CreatePen(PS_SOLID, 1, Indicator_RingColor);
    fBGBrush_TargetColor       = CreateSolidBrush(Indicator_TargetColor);
}
//===========================================================================
void TIndicator::Init()
{
  // -------
/*    int aWidth  = fiWidth;
    int aHeight = (fiHeight - fiTop - (fiHeight - fiBottom));
   ?????????????
    fMinImageSide         = min(aWidth, aHeight);
    fIndicatorCenter      = Point(aWidth - fMinImageSide + fMinImageSide / 2, fiTop + aHeight / 2);
 */
   // ----------

   // ----------
    fRightButtonMouseDown = false;
    fLeftButtonMouseDown  = false;
    fMouseDownPos         = Point(-999,-999);
    fOldBeginDragPos      = Point(-999, -999);
    fOldEndDragPos        = Point(-999, -999);
    fMastabCoef           = 1.0;

/*
  fSelectRegion         = false;
  fOldLuchCoord         = Point(-999, -999);
  fIndicatorCenter      = Point(-999, -999);
  fCurIndicatorCenter   = Point(-999, -999);

  ReSize();

  fCurIndicatorCenter = fIndicatorCenter;

  PrepareImageToDraw();
*/

  Changed();
  iPaint(NULL);
}

//===========================================================================
void __fastcall TIndicator::SetMastabCoef(TFloat value)
{
  if (value == -999){
     fCurIndicatorCenter   = fIndicatorCenter;
     value = 1;
  }
  if (value < 1) value = 1;

  fMastabCoef = value;

  ClearOldPosValues();
  Changed();
  iPaint(NULL);
}

//===========================================================================
void TIndicator::Changed()
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

    fRedrawBitmap = CreateDIBSection(fRedrawBitmapDC, &aBitmapInfo, DIB_RGB_COLORS, NULL, NULL, 0);

    SelectObject(fRedrawBitmapDC, fRedrawBitmap);
    SelectObject(fRedrawBitmapDC, fPen_RingColor);


  // ------- Заполнение чорным цветом ----------
    FillRect(fRedrawBitmapDC, &fParentRect, fBGBrush_Color);

  // ---------------- Отрисовка колец дальности ---------------
    TFloat  aRingDistanceStep = fIndicatorDistance / 7.0;
    TFloat  aValue            = aRingDistanceStep * fDistanceCoef * fMastabCoef;
       for (int i = 0; i < 7; i++) {
          for (int k = -20; k < 720 + 20; k++){

             TFloat aOffsetX = fCurIndicatorCenter.x + sin(k/2.0*Pi_del_180) * (i+1) * aValue;
             TFloat aOffsetY = fCurIndicatorCenter.y - cos(k/2.0*Pi_del_180) * (i+1) * aValue;

             CirclePoint[i][20 + k] = Point(aOffsetX, aOffsetY);
          }

        Polyline(fRedrawBitmapDC, CirclePoint[i], 20 + 720 + 20);
       }

  // ---------------- Отрисовка азимутальных отметок ---------------

    TFloat  aAzimStep = 30 * Pi_del_180;
    TFloat  aCurAzim  = 0;
    int     x2, y2;
    TPoint  aPoints[2];

    for (int i = 0; i < 12; i++, aCurAzim += aAzimStep) {
       x2 = fCurIndicatorCenter.x + fDistanceCoef * fMastabCoef*(fIndicatorDistance*1.02)*sin(aCurAzim);
       y2 = fCurIndicatorCenter.y - fDistanceCoef * fMastabCoef*(fIndicatorDistance*1.02)*cos(aCurAzim);

       aPoints[0] = Point(fCurIndicatorCenter.x, fCurIndicatorCenter.y);
       aPoints[1] = Point(x2                   , y2);

       Polyline(fRedrawBitmapDC, aPoints, 2);
    }
}

//===========================================================================
void TIndicator::DrawAzimutalLine(TFloat aAngle)
{
  LinePoints[1].x = LinePoints[0].x + fDistanceCoef * fMastabCoef*(fIndicatorDistance*1.02)*sin(aAngle);
  LinePoints[1].y = LinePoints[0].y - fDistanceCoef * fMastabCoef*(fIndicatorDistance*1.02)*cos(aAngle);

  Polyline(fMainDC, LinePoints, 2);
}

//===========================================================================
void TIndicator::DrawLine(HPEN aPen, TFloat aAngle, TFloat aDistance, TPoint *OldPos, TPoint *CurPos)
{
    CurPos->x = fCurIndicatorCenter.x + int(sin(aAngle) * aDistance * fDistanceCoef * fMastabCoef);
    CurPos->y = fCurIndicatorCenter.y - int(cos(aAngle) * aDistance * fDistanceCoef * fMastabCoef);

   // ---------- Закраска старого положения линии -------
    if (OldPos->y != -999) {
      SelectObject(fMainDC, fBGPen_Color);

      LinePoints[1] = *OldPos;
      Polyline(fMainDC, LinePoints, 2);
    };

    *OldPos = *CurPos;

  // ---------------- Отрисовка колец дальности ---------------

     SelectObject(fMainDC, fPen_RingColor);
     int ak = aAngle*_180_del_Pi * 2.0;
     if (ak < 0      ) ak += 720;
     ak += 20; // {+ 20} --- Смещение относительно Нуля -----

   for (int i = 0; i < 7; i++) {

        SectorLine[i][12] = CirclePoint[i][ak-8];
        SectorLine[i][11] = CirclePoint[i][ak-7];
        SectorLine[i][10] = CirclePoint[i][ak-6];
        SectorLine[i][ 9] = CirclePoint[i][ak-5];
        SectorLine[i][ 8] = CirclePoint[i][ak-4];
        SectorLine[i][ 7] = CirclePoint[i][ak-3];
        SectorLine[i][ 6] = CirclePoint[i][ak-2];
        SectorLine[i][ 5] = CirclePoint[i][ak-1];


        SectorLine[i][ 4] = CirclePoint[i][ak+0];
        SectorLine[i][ 3] = CirclePoint[i][ak+1];
        SectorLine[i][ 2] = CirclePoint[i][ak+2];
        SectorLine[i][ 1] = CirclePoint[i][ak+3];
        SectorLine[i][ 0] = CirclePoint[i][ak+4];

        Polyline(fMainDC, SectorLine[i], 13);
   }

  // ---------------- Отрисовка азимутальных отметок ---------------

     SelectObject(fMainDC, fPen_RingColor);


     ak = (ak - 20) / 2;
     if (ak >  25 && ak <  35) DrawAzimutalLine( 30 * Pi_del_180);
     if (ak >  55 && ak <  65) DrawAzimutalLine( 60 * Pi_del_180);
     if (ak >  85 && ak <  95) DrawAzimutalLine( 90 * Pi_del_180);
     if (ak > 115 && ak < 125) DrawAzimutalLine(120 * Pi_del_180);
     if (ak > 145 && ak < 155) DrawAzimutalLine(150 * Pi_del_180);
     if (ak > 175 && ak < 185) DrawAzimutalLine(180 * Pi_del_180);
     if (ak > 205 && ak < 215) DrawAzimutalLine(210 * Pi_del_180);
     if (ak > 235 && ak < 245) DrawAzimutalLine(240 * Pi_del_180);
     if (ak > 265 && ak < 275) DrawAzimutalLine(270 * Pi_del_180);
     if (ak > 295 && ak < 305) DrawAzimutalLine(300 * Pi_del_180);
     if (ak > 325 && ak < 335) DrawAzimutalLine(330 * Pi_del_180);
     if ((ak > 355 || ak <   5) && ak != 0) DrawAzimutalLine(  0 * Pi_del_180);

   // ---------- Отрисовка нового положения линии -------
      SelectObject(fMainDC, aPen);

      LinePoints[1] = *CurPos;
      Polyline(fMainDC, LinePoints, 2);

}

//===========================================================================
void TIndicator::DrawTargets()
{
  int xx, yy;


/*  for (int i = 0; i < TimeDiagram_Items_Count; i++){
     // ------


      if (TimeDiagram[i].Indicator_Redraw){
          xx = fCurIndicatorCenter.x + int(sin(TimeDiagram[i].Old_Q()) * TimeDiagram[i].Old_D() * fDistanceCoef * fMastabCoef);
          yy = fCurIndicatorCenter.y - int(cos(TimeDiagram[i].Old_Q()) * TimeDiagram[i].Old_D() * fDistanceCoef * fMastabCoef);

          if  (TimeDiagram[i].Old_Q() != -999)
             BitBlt(fMainDC, xx - 5, yy - 25, 50, 40, fRedrawBitmapDC, xx - 5, yy - 25, SRCCOPY); //копирование битмапа на экран

          TimeDiagram[i].SaveOldData();
          TimeDiagram[i].Indicator_Redraw  = false;
      }
     // ---------
      if (TimeDiagram[i].Q() != -999){
          xx = fCurIndicatorCenter.x + int(sin(TimeDiagram[i].Q()) * TimeDiagram[i].D() * fDistanceCoef * fMastabCoef);
          yy = fCurIndicatorCenter.y - int(cos(TimeDiagram[i].Q()) * TimeDiagram[i].D() * fDistanceCoef * fMastabCoef);

          Ellipse(fMainDC, xx - 3, yy - 3, xx + 3, yy + 3);
        // ---------
          SetBkMode(fMainDC, TRANSPARENT);

             SelectObject(fMainDC, fFont_Target);
             SetTextColor(fMainDC, clWhite);
             SetTextAlign(fMainDC, TA_BOTTOM);

             TextOut(fMainDC, xx + 1, yy - 1, TimeDiagram[i].Target.Name,5);

          SetBkMode(fMainDC, OPAQUE);
      }
  }*/

  for (int i = 0; i < Targets_Count; i++){
     // ------
      if (Targets[i]->Indicator_Redraw){
          xx = fCurIndicatorCenter.x + int(sin(Targets[i]->OldIndicatorCoord.Q) * Targets[i]->OldIndicatorCoord.R * fDistanceCoef * fMastabCoef);
          yy = fCurIndicatorCenter.y - int(cos(Targets[i]->OldIndicatorCoord.Q) * Targets[i]->OldIndicatorCoord.R * fDistanceCoef * fMastabCoef);

          BitBlt(fMainDC, xx - 5, yy - 25, 50, 40, fRedrawBitmapDC, xx - 5, yy - 25, SRCCOPY); //копирование битмапа на экран

          Targets[i]->OldIndicatorCoord = Targets[i]->IndicatorCoord;
          Targets[i]->Indicator_Redraw  = false;
      }
     // ---------
      if (Targets[i]->IndicatorCoord.Q != -999){
          //xx = fCurIndicatorCenter.x + int(sin(Targets[i]->Coord.Q_c) * Targets[i]->Coord.Ri * fDistanceCoef * fMastabCoef);
          //yy = fCurIndicatorCenter.y - int(cos(Targets[i]->Coord.Q_c) * Targets[i]->Coord.Ri * fDistanceCoef * fMastabCoef);
          xx = fCurIndicatorCenter.x + int(sin(Targets[i]->IndicatorCoord.Q) * Targets[i]->IndicatorCoord.R * fDistanceCoef * fMastabCoef);
          yy = fCurIndicatorCenter.y - int(cos(Targets[i]->IndicatorCoord.Q) * Targets[i]->IndicatorCoord.R * fDistanceCoef * fMastabCoef);
// !!!!!!!!1
            SelectObject(fMainDC, fBGPen_Color);
            SelectObject(fMainDC, fBGBrush_TargetColor);
            Ellipse(fMainDC, xx - 4, yy - 4, xx + 4, yy + 4);
        // ---------
          SetBkMode(fMainDC, TRANSPARENT);

             SelectObject(fMainDC, fFont_Target);
             SetTextColor(fMainDC, Indicator_TargetFontColor);
             SetTextAlign(fMainDC, TA_BOTTOM);

             TextOut(fMainDC, xx + 1, yy - 1, Targets[i]->Indicator_Name.c_str(), Targets[i]->Indicator_Name.Length());

           SetBkMode(fMainDC, OPAQUE);
      }
  }

}

//===========================================================================
void TIndicator::ReDraw()
{
  iPaint(NULL);
}

//===========================================================================
void TIndicator::ClearOldPosValues()
{
    OldPosLeftSideSector  = Point(-999,-999);
    PosLeftSideSector     = Point(-999,-999);
    OldPosRightSideSector = Point(-999,-999);
    PosRightSideSector    = Point(-999,-999);
    OldPosNormal          = Point(-999,-999);
    PosNormal             = Point(-999,-999);
    OldPosLuch            = Point(-999,-999);
    PosLuch               = Point(-999,-999);
    LinePoints[0]         = fCurIndicatorCenter;
    LinePoints[1]         = Point(-999,-999);
}

//===========================================================================
void __fastcall TIndicator::iResize(TObject *Sender)
{
    GetClientRect(fMainFormHandle, &fParentRect);

    fiHeight    = fParentRect.Height();
    fiWidth     = fParentRect.Width();

    int fMinImageSide   = min (fiWidth, fiHeight);
    fIndicatorCenter    = Point(fiWidth / 2, fiHeight / 2);
    fCurIndicatorCenter = fIndicatorCenter;
    fDistanceCoef       = fMinImageSide / (fIndicatorDistance + fIndicatorDistance*0.03) / 2.0;

   // ----------
    ClearOldPosValues();
   // ----------

    Changed();
    iPaint(NULL);
}

//===========================================================================
void __fastcall TIndicator::iPaint(TObject *Sender)
{
  // ------------------------------------------------------
   BitBlt(fMainDC, 0, 0, fiWidth, fiHeight, fRedrawBitmapDC, 0, 0, SRCCOPY); //копирование битмапа на экран
  // ------------------------------------------------------

   Draw();
}

//===========================================================================
void __fastcall TIndicator::iMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  if (!fLeftButtonMouseDown && !fRightButtonMouseDown) fPauseState = Paused;
  if (!fPauseState) Paused = true;

  if (Button == mbLeft)  fLeftButtonMouseDown  = true;
  if (Button == mbRight) fRightButtonMouseDown = true;

  fMouseDownPos    = Point(X, Y);
  fOldBeginDragPos = Point(X, Y);
}

//===========================================================================
void __fastcall TIndicator::iMouseMove(TObject *Sender, TShiftState Shift,
      int X, int Y)
{
 // -------- Обработка союытия от правой нажатой клавиши мыши-------
    if (fRightButtonMouseDown) {
     // -------
        fCurIndicatorCenter.x = fCurIndicatorCenter.x + X - fMouseDownPos.x;
        fCurIndicatorCenter.y = fCurIndicatorCenter.y + Y - fMouseDownPos.y;
     // -------
        ClearOldPosValues();
        Changed();
        iPaint(NULL);

        fMouseDownPos = Point(X, Y);

        return;
    }
  // ----- Обработка левой нажатой клавишы ----------
    if (fLeftButtonMouseDown) {
       fOldEndDragPos.x   = X;
       fOldEndDragPos.y   = Y;
       return;
    }
 // ------ Обработка чистого передвежения мыши ---------
    // ---------Вычиляю азимут мыши на индикаторе ------------
    int aX = X - fCurIndicatorCenter.x;
    int aY = Y - fCurIndicatorCenter.y;
    int aaX = abs(aX);
    int aaY = abs(aY);

    if (aX  > 0 && aY  < 0) mAzim = -Math::ArcTan2(aaY, aaX) + pi / 2.0;
    if (aX  > 0 && aY  > 0) mAzim =  Math::ArcTan2(aaY, aaX) + pi / 2.0;
    if (aX  < 0 && aY  > 0) mAzim = -Math::ArcTan2(aaY, aaX) + 3.0*pi/2.0;
    if (aX  < 0 && aY  < 0) mAzim =  Math::ArcTan2(aaY, aaX) + 3.0*pi/2.0;
    if (aX  > 0 && aY == 0) mAzim =  pi / 2.0;
    if (aX  < 0 && aY == 0) mAzim =  3.0*pi/2.0;
    if (aX == 0 && aY  < 0) mAzim =  0.0;
    if (aX == 0 && aY  > 0) mAzim =  pi;
    if (aX == 0 && aY == 0) mAzim =  0.0;

    mDistance = sqrt(aaX*aaX + aaY*aaY) / fDistanceCoef / fMastabCoef;

    TStatusPanels *sp =  fsbWork->Panels;

    sp->Items[3]->Text = " D : " + FloatToStrF(mDistance, ffFixed, 10,3) + " км";
    sp->Items[4]->Text = " Az : " + FloatToStrF(mAzim*_180_del_Pi, ffFixed, 10,1) + "°";
}

//===========================================================================
void __fastcall TIndicator::iMouseUp(TObject *Sender, TMouseButton Button,
      TShiftState Shift, int X, int Y)
{
  // -----------------------------------
    if (fLeftButtonMouseDown) {
         int aWRect = fOldEndDragPos.x - fMouseDownPos.x;
         int aHRect = fOldEndDragPos.y - fMouseDownPos.y;

        // ----- Возращение в нудевую позицию ----------
        if (aWRect < -30 && aHRect < -30){
             fCurIndicatorCenter = fIndicatorCenter;
             fMastabCoef         = 1;
             ClearOldPosValues();
        }
    }
  // -----------------------------------

    fRightButtonMouseDown = false;
    fLeftButtonMouseDown  = false;


    fOldBeginDragPos     = Point(-999, -999);
    fOldEndDragPos       = Point(-999, -999);
    fMouseDownPos        = Point(-999, -999);


    Changed();
    iPaint(NULL);

    Paused                = fPauseState;
}

//===========================================================================
void TIndicator::Draw()
{
     if (CurModelTime != 0)
       if (*fpStrobing) DrawLine(fPen_Yellow, *fpCurAzimPosLuchFar, *fpLuchDistance, &OldPosLuch, &PosLuch);
       else             DrawLine(fPen_White , *fpCurAzimPosLuchFar, *fpLuchDistance, &OldPosLuch, &PosLuch);
   // ---------------------
                                                         
     DrawLine(fPen_DarkGreen, *fpCurAzimPosNormalFar                             , fIndicatorDistance, &OldPosNormal         , &PosNormal         ); // --------- Отрисовка нормали ФАР ------
     DrawLine(fPen_DarkRed  , *fpCurAzimPosNormalFar - fpFarParam->HalfScanSector, fIndicatorDistance, &OldPosLeftSideSector , &PosLeftSideSector ); // --------- Отрисовка Левой части сектора ------
     DrawLine(fPen_DarkRed  , *fpCurAzimPosNormalFar + fpFarParam->HalfScanSector, fIndicatorDistance, &OldPosRightSideSector, &PosRightSideSector); // --------- Отрисовка Правой части сектора ------
   // ---------------------
  
     if (CurModelTime != 0)
        DrawTargets();

   // --------------------  Отрисовка графиков -------------
     DrawGraphic(10,10,NULL);     
}
//===========================================================================

void TIndicator::DrawGraphic(int aOffsetX, int aOffsetY, TFloat * aaaaaa)
{
/*  SelectObject(fMainDC1, GetStockObject(DKGRAY_BRUSH));
//                    frmMain->
  Rectangle(fMainDC1, 20, 20, 100, 100);
/*   TPoint asd[2];

   asd[0].x = fCurIndicatorCenter.x - fMinImageSide / 2 + 5;
   asd[0].y = aOffsetY;

   asd[1].x = fCurIndicatorCenter.x - fMinImageSide / 2 + 5;
   asd[1].y = aOffsetY + 100;

  Polyline(fMainDC, asd, 2);*/
}
//===========================================================================

