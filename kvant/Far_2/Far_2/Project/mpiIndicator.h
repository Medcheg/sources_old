//---------------------------------------------------------------------------
#ifndef mpiIndicatorH
#define mpiIndicatorH
//---------------------------------------------------------------------------
#include <ComCtrls.hpp>
#include "mpiTypes.h"
// --------------------------------------------------
class TIndicator{
private:
      // -----------------  Криэйтные переменные ------------
        HWND                fMainFormHandle;                 // -------- Нэндел панели ---------
        TFarParam          *fpFarParam;
        TFloat             *fpCurAzimPosNormalFar;           // -------- Указатель на текучий азимутальный угол нормали -----
        TFloat             *fpCurAzimPosLuchFar;             // -------- Указатель на текущий азимутпльный угол луча антенны -------
        bool               *fpStrobing;                      // -------- Влаг отвечающий за присутствие строба ----------
        TFloat             *fpLuchDistance;                  // -------- Указатель  Дальность луча --------
        TStatusBar         *fsbWork;                         // -------- Статус бар главной формы --------
      // ---------------------------------------------------------
        HDC                 fMainDC;                        // -------- Контекст главной формы -----------

        TRect               fParentRect;            // --------
        int                 fiWidth;                // -------- индикатора -----
        int                 fiHeight;               // -------- индикатора -----
        bool                fPauseState;            // ---------- Проверка нажатия клавиши пауза --------

      // --------- Координаты мыши на индикаторе (Азимут дальность) -----------
        float               mDistance;
        float               mAzim;
      // ---------------------------------------------------------
        TFloat              fIndicatorDistance;
        TFloat              fDistanceCoef;       // ------ Маштабный, базовый коэффиуиент по дальности ---------

        TPoint              fIndicatorCenter;    // ------ Базовый центр индекатора в пикселях -----------
        TPoint              fCurIndicatorCenter; // ------ Текущий центр индекатора в пикселях -----------

        TPoint              CirclePoint[7][20 + 720 + 20];
        TPoint              SectorLine[7][13];

      // -------- Переменные сектора ----------
        TPoint              OldPosNormal;
        TPoint                 PosNormal;
        TPoint              OldPosLeftSideSector;
        TPoint                 PosLeftSideSector;
        TPoint              OldPosRightSideSector;
        TPoint                 PosRightSideSector;
        TPoint              OldPosLuch;
        TPoint                 PosLuch;
        TPoint              LinePoints[2];

      // -----  Переменные позволяющие вести обработку изменений индикатора ------
        bool                fRightButtonMouseDown;  // ------ Нажата ли правая клавиша мыши ------------
        bool                fLeftButtonMouseDown;   // ------ Нажата ли левая клавиша мыши ----------
        TPoint              fMouseDownPos;
        TPoint              fOldBeginDragPos;
        TPoint              fOldEndDragPos;
        TFloat              fMastabCoef;   // ------ Коэф масштабирования индикатора -------

      // ---------------------------------------------------------
        HDC                 fRedrawBitmapDC;
        HBITMAP             fRedrawBitmap;
      //
      //
        HPEN                fPen_Black;
        HPEN                fPen_DarkGray;
        HPEN                fPen_Gray;
        HPEN                fPen_White;
        HPEN                fPen_Yellow;
        HPEN                fPen_Black2;
        HPEN                fPen_DarkRed;
        HPEN                fPen_DarkGreen;
        HFONT               fFont_Target;

        HBRUSH              fBGBrush_Color;
        HPEN                fBGPen_Color;
        HPEN                fPen_RingColor;
        HBRUSH              fBGBrush_TargetColor;

        void Changed();
        void DrawLine(HPEN aPen, TFloat aAngle, TFloat aDistance, TPoint *OldPos, TPoint *CurPos);
        void DrawAzimutalLine(TFloat aAngle);
        void ClearOldPosValues();
        void __fastcall SetMastabCoef(TFloat value);
        void DrawTargets();
        void DrawGraphic(int aOffsetX, int aOffsetY, TFloat * aaaaaa);

        // -------------- Окна графиков ---------
public:

        TIndicator(HWND aMainFormHandle, TFarParam * apFarParam, TFloat *apCurAzimPosNormalFar, TFloat *apCurAzimPosLuchFar, bool *apStrobing, TFloat *apLuchDistance, TStatusBar *asbWork);
        ~TIndicator();


        void __fastcall iResize(TObject *Sender);
        void __fastcall iPaint(TObject *Sender);
        void __fastcall iMouseDown(TObject *Sender, TMouseButton Button, TShiftState Shift, int X, int Y);
        void __fastcall iMouseMove(TObject *Sender, TShiftState Shift  , int X, int Y);
        void __fastcall iMouseUp(TObject *Sender, TMouseButton Button  , TShiftState Shift, int X, int Y);

        void Draw();
        void ReDraw();
        void Init();
        void SetColors();

        __property TFloat   MastabCoef  = { read = fMastabCoef, write = SetMastabCoef };
/*
        void ReSize();
        void Draw();
        void Init();

        __property TPixelFormat PixelFormat = {read = fPixelFormat, write = Set_PixelFormat};
        __property TFloat       Distance    = {read = fDistance   , write = Set_Distance};*/
};
//---------------------------------------------------------------------------
#endif
