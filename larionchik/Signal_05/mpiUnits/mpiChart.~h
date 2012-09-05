//---------------------------------------------------------------------------
#ifndef mpiChartH
#define mpiChartH
//---------------------------------------------------------------------------
#include "mpiCollection.h"
//---------------------------------------------------------------------------
class CBaseADC;
class CChart
{
private:
         Graphics::TBitmap   *RedrawBitmap;
         Graphics::TBitmap   *aaBitmap;

         CCollectionStorage<short int> *fCanals;

         double  fChartTime;
         int     XMousePosition;
         int     YMousePosition;
         HDC     hDC;

         void __fastcall SetStorageParam(CCollectionStorage<short int> *aCanals);
         void __fastcall DrawNet(TCanvas *aCanvas);
         void __fastcall Resizze();
         void __fastcall pbMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
         void __fastcall pbMouseDown(System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
         void __fastcall pbMouseUp  (System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
         void __fastcall pbOnPaint  (System::TObject* Sender);
         void __fastcall sbOnChange (System::TObject* Sender);
         void __fastcall Set_CollectionStorage(CCollectionStorage<short int> *aCanals);
         double __fastcall Get_ChartTime();
public:
         TPaintBox           *pbMain;
         TScrollBar          *sbMain;
   // ------ Паретры настройки чартов --------
         TColor       BGColor;
         TColor       NetColor;
         TColor       FrameNetColor;
         CCollection<double> TimeScales;
         CCollection<double> VoltScales;
         int                 TimeScalesIndex;
         int                 VoltScalesIndex;

   // ------------------
         TRect        ClientRect;
         TRect        DrawRect;
         TRect        ValuesLineRect;
         TRect        TimeLineRect;
   // ------------------
         int LastDrawPoint; // ----- Последняя точка, которая была отрисована -----

   // ------------------ Chart Device -----
         CBaseADC     *BaseADC;
   // ------------------
         bool         isNeedFullRepaint;
         bool         isCanDrawing;
         bool         isRealTimeWork;

         CChart(TPanel *aParentPanel);
        ~CChart();

         void __fastcall DrawSeriesValues();
         void __fastcall SetScrollBarPosition(int ScrBarPosition);
         void __fastcall SetChartTime(double aTimeScale);

         __property CCollectionStorage<short int> *Canals    = { read  = fCanals, write = Set_CollectionStorage};
};
extern CChart *BChart;
//---------------------------------------------------------------------------
#endif
