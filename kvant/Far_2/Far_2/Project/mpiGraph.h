//---------------------------------------------------------------------------
#ifndef mpiGraphH
#define mpiGraphH
//---------------------------------------------------------------------------
#include "mpiTypes.h"
//---------------------------------------------------------------------------
typedef struct {
  // ---------------------------
    TRect       GraphRect;
    TRect       PoleRect;
    TPoint      TopLabelPos;
  // ---------------------------
    TFloat     *Values;

    TPoint     *DrawValues;
    TPoint     *OldDrawValues;

    int         ValuesCount;
  // ---------------------------
    int         ZeroPos;
    TFloat      Max, Min, Coef, OldCoef;
    TPoint      OldTextPos;

  // -------- Вход ----------
    AnsiString        GraphName;             // --------- Заданое имя графика -------
    int               GlobalGraphIndex;          // --------- Индекс (порядковый номер в глобальном списке) -------
    TFloat            *Value, TransformCoef; // --------- Адрес по которому находиться знаение и его коефициент преобразования -------
  // -------- End of Вход ----------
    void Setup(AnsiString aGraphName, int aGlobalGraphIndex, TFloat *aValue, TFloat aTransformCoef)
    {
       GraphName     = aGraphName;
       Value         = aValue;
       TransformCoef = aTransformCoef;
       GlobalGraphIndex = aGlobalGraphIndex;
    }
} TGraphWindow;

class TGraph{
private:
      // -----------------  Криэйтные переменные ------------
        HWND                fMainFormHandle;                 // -------- Нэндел панели ---------
        HDC                 fMainDC;                        // -------- Контекст главной формы -----------
        bool               *fpStrobing;                      // -------- Влаг отвечающий за присутствие строба ----------
        TFloat             *fpLuchDistance;                  // -------- Указатель  Дальность луча --------
      // ---------------------------------------------------------

        TRect               fParentRect;            // --------
        int                 fiWidth;                // -------- индикатора -----
        int                 fiHeight;               // -------- индикатора -----
        bool                fPauseState;            // ---------- Проверка нажатия клавиши пауза --------

      // -----  Переменные позволяющие вести обработку изменений индикатора ------
        bool                fRightButtonMouseDown;  // ------ Нажата ли правая клавиша мыши ------------
        bool                fLeftButtonMouseDown;   // ------ Нажата ли левая клавиша мыши ----------
        bool                OnPaint;
        TPoint              fMouseDownPos;
        TPoint              fOldBeginDragPos;
        TPoint              fOldEndDragPos;
        TFloat              fMastabCoef;   // ------ Коэф масштабирования индикатора -------
      // ---------------------------------------------------------
        int                 DropCount;
      // ---------------------------------------------------------
        HDC                 fRedrawBitmapDC;
        HBITMAP             fRedrawBitmap;
      //
        //COLORREF            fBGColor;
        HBRUSH              fBGBrush_Color;
        HBRUSH              fBGB1;
        HPEN                fBGPen_Color;
      //
        //HBRUSH              fBGBrush_Color_Black;
        HBRUSH              fBrush_Color_Red;
        HBRUSH              fBrush_Color_Yellow;
        HPEN                fPen_Black;
        HPEN                fPen_DarkGray;

        HPEN                fPen_Gray;
        HPEN                fPen_AxisColor;
        HPEN                fPen_CurveColor;

        HPEN                fPen_Red;
        HPEN                fPen_Green;
        HPEN                fPen_Blue;
        HPEN                fPen_Yellow;
        HPEN                fPen_White;
        HPEN                fPen_Black2;
        HFONT               fFont_Title;
        HFONT               fFont_Other;

        HPEN                hPenArray[6];
      // --------------
        TPoint         MousePos, OldMousePos[3];
      // --------------
        TPoint *OutPointArray[8];
        TFloat  MinAzimOffset;
        TFloat  MaxAzimOffset;
        TFloat  MinEpsOffset;
        TFloat  MaxEpsOffset;
        TFloat  CoefX;
        TFloat  CoefY;
        TPoint  RavnosignalPos;
      // --------------- Парматр прореживания графика ----------------
        int ConstDropCount;




        void Changed();
        void DrawGraphic();
        void DrawEllpses();
        void _TextOut_(HDC aHDC, int x, int y, unsigned int aTextAlign, int iBkMode, HFONT aFont, TColor aColor, AnsiString *aString);
  //      void SetBGColor(COLORREF aColor) {if (fBGBrush_Color != NULL ) DeleteObject(fBGBrush_Color); if (fBGPen_Color   != NULL ) DeleteObject(fBGPen_Color); fBGBrush_Color = CreateSolidBrush(aColor); fBGPen_Color   = CreatePen(PS_SOLID, 1, aColor); fBGColor       = aColor;}
public:
        TGraphWindow  GraphWindow[3];
        bool          EllipseRedraw;  /// ------- Нуно ли перерисовывать еллипсы --------

        TGraph(HWND aMainFormHandle, bool *apStrobing, TFloat *apLuchDistance);
        ~TGraph();


        void __fastcall iResize(TObject *Sender);
        void __fastcall iPaint(TObject *Sender);
        void __fastcall iMouseDown(TObject *Sender, TMouseButton Button, TShiftState Shift, int X, int Y);
        void __fastcall iMouseMove(TObject *Sender, TShiftState Shift  , int X, int Y);
        void __fastcall iMouseUp(TObject *Sender, TMouseButton Button  , TShiftState Shift, int X, int Y);
        void __fastcall iMouseOnClick(TObject *Sender);
        void __fastcall iMouseOnDblClick(TObject *Sender);

        void Draw();
        void ReDraw();
        void Init();
        void SetColors();

  //      __property COLORREF BGColor     = { read = fBGColor   , write = SetBGColor    };
};
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
#endif
