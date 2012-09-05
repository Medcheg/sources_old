//---------------------------------------------------------------------------
#ifndef mpiIndicatorH
#define mpiIndicatorH
//---------------------------------------------------------------------------
#include <ComCtrls.hpp>
#include "mpiTypes.h"
// --------------------------------------------------
class TIndicator{
private:
      // -----------------  ��������� ���������� ------------
        HWND                fMainFormHandle;                 // -------- ������ ������ ---------
        TFarParam          *fpFarParam;
        TFloat             *fpCurAzimPosNormalFar;           // -------- ��������� �� ������� ������������ ���� ������� -----
        TFloat             *fpCurAzimPosLuchFar;             // -------- ��������� �� ������� ������������ ���� ���� ������� -------
        bool               *fpStrobing;                      // -------- ���� ���������� �� ����������� ������ ----------
        TFloat             *fpLuchDistance;                  // -------- ���������  ��������� ���� --------
        TStatusBar         *fsbWork;                         // -------- ������ ��� ������� ����� --------
      // ---------------------------------------------------------
        HDC                 fMainDC;                        // -------- �������� ������� ����� -----------

        TRect               fParentRect;            // --------
        int                 fiWidth;                // -------- ���������� -----
        int                 fiHeight;               // -------- ���������� -----
        bool                fPauseState;            // ---------- �������� ������� ������� ����� --------

      // --------- ���������� ���� �� ���������� (������ ���������) -----------
        float               mDistance;
        float               mAzim;
      // ---------------------------------------------------------
        TFloat              fIndicatorDistance;
        TFloat              fDistanceCoef;       // ------ ���������, ������� ����������� �� ��������� ---------

        TPoint              fIndicatorCenter;    // ------ ������� ����� ���������� � �������� -----------
        TPoint              fCurIndicatorCenter; // ------ ������� ����� ���������� � �������� -----------

        TPoint              CirclePoint[7][20 + 720 + 20];
        TPoint              SectorLine[7][13];

      // -------- ���������� ������� ----------
        TPoint              OldPosNormal;
        TPoint                 PosNormal;
        TPoint              OldPosLeftSideSector;
        TPoint                 PosLeftSideSector;
        TPoint              OldPosRightSideSector;
        TPoint                 PosRightSideSector;
        TPoint              OldPosLuch;
        TPoint                 PosLuch;
        TPoint              LinePoints[2];

      // -----  ���������� ����������� ����� ��������� ��������� ���������� ------
        bool                fRightButtonMouseDown;  // ------ ������ �� ������ ������� ���� ------------
        bool                fLeftButtonMouseDown;   // ------ ������ �� ����� ������� ���� ----------
        TPoint              fMouseDownPos;
        TPoint              fOldBeginDragPos;
        TPoint              fOldEndDragPos;
        TFloat              fMastabCoef;   // ------ ���� ��������������� ���������� -------

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

        // -------------- ���� �������� ---------
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
