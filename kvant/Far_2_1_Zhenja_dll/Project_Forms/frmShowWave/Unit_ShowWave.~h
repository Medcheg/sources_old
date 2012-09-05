//---------------------------------------------------------------------------

#ifndef Unit_ShowWaveH
#define Unit_ShowWaveH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
#include "mpiSetupWaves.h"
//---------------------------------------------------------------------------
class TMyGraph {
private:
     int        fCountData;
     int        Height, Width, Left, Top;

     __fastcall void Set_CountData(int aCountData)
     {
        fCountData = aCountData;

        ValueData    = (double*) realloc (ValueData   , sizeof (double) * fCountData);
        TimeArray    = (double*) realloc (TimeArray   , sizeof (double) * fCountData);
        GraphData    = (TPoint*) realloc (GraphData   , sizeof (TPoint) * fCountData);
        OldGraphData = (TPoint*) realloc (OldGraphData, sizeof (TPoint) * fCountData);
     }
public:
     int       CurretSaveData;
     TRect     DrawRect;

     double   *ValueData;
     double   *TimeArray;
     TPoint   *GraphData;
     TPoint   *OldGraphData;

     int      iRazmernost;

     double    MinY, MaxY;
     double    OldCoefY, CoefY;
     double    OldMinY, OldMaxY;

       TMyGraph(int aRazmernost) { iRazmernost = aRazmernost; ValueData  = NULL; TimeArray  = NULL; GraphData  = NULL; fCountData = 0 ; }
      ~TMyGraph() {
            if (ValueData    != NULL) free(ValueData);    ValueData = NULL;
            if (TimeArray    != NULL) free(TimeArray);    TimeArray = NULL;
            if (GraphData    != NULL) free(GraphData);    GraphData = NULL;
            if (OldGraphData != NULL) free(OldGraphData); OldGraphData = NULL;

            fCountData = 0;
      }

      void Init() {
             CurretSaveData =  0;
             MinY           =  100000;
             MaxY           = -100000;
             Height         =  DrawRect.Height();
             Width          =  DrawRect.Width();
             Left           =  DrawRect.Left;
             Top            =  DrawRect.Top;
             for (int i = 0;  i < fCountData; i++) {
                 ValueData   [i]   = 0;
                 TimeArray   [i]   = 0;
                 GraphData   [i].x = Left + i;
                 GraphData   [i].y = Height / 2;
                 OldGraphData[i]   = GraphData[i];
             }
      }

      void Add(double aValue, double aCurModelTime) {
             aValue = aValue / RazmernostCoef[iRazmernost];
         // --------------- Предыдущие значния кривой -------
             OldMinY  = MinY;
             OldMaxY  = MaxY;
             OldCoefY = CoefY;
             for (int i = 0; i < CurretSaveData; i++) OldGraphData[i].y = GraphData[i].y;

          // -------------- Динамический масштабный коеефициент ---------
             if (MinY > aValue) MinY = aValue;
             if (MaxY < aValue) MaxY = aValue;


             CoefY = (MaxY - MinY) / (double)(DrawRect.Height() - 1);
             if (CoefY == 0) CoefY = 1;


         // --------------- Если маштабный коеффициент поменялся ------- тода - :) --------
             if (OldCoefY != CoefY) {
                  for (int i = 0; i < CurretSaveData; i++) {
                     GraphData[i].y = Top + (MaxY - ValueData[i]) / CoefY;
                  }
             }

          // -------------- Запоинаем значения в масив данных -----------
             if (CurretSaveData >= fCountData) {
                  for (int i = 0; i < fCountData - 1; i++) {
                     ValueData[i]   = ValueData[i + 1];
                     TimeArray[i]   = TimeArray[i + 1];
                     GraphData[i].y = GraphData[i + 1].y;
                  }
             } else CurretSaveData++;

         // --------------- Заполняем новыми значениями ----------
             ValueData[CurretSaveData - 1]   =  aValue;
             TimeArray[CurretSaveData - 1]   =  aCurModelTime;
             GraphData[CurretSaveData - 1].y = Top + (MaxY - aValue) / CoefY;
      }

     __property int CountData = { read = fCountData, write = Set_CountData};
};

//---------------------------------------------------------------------------
class TfrmShowWave : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel2;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TRadioButton *RadioButton3;
        TRadioButton *RadioButton4;
        TRadioButton *RadioButton5;
        TRadioButton *RadioButton6;
        TBevel *Bevel1;
        TToolBar *ToolBar1;
        TToolButton *ToolButton1;
        void __fastcall FormShow        (TObject *Sender);
        void __fastcall RadioButtonClick(TObject *Sender);
        void __fastcall FormDestroy     (TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall FormPaint(TObject *Sender);
        void __fastcall ToolButton1Click(TObject *Sender);
        void __fastcall Panel2DblClick(TObject *Sender);
private:	// User declarations
        TRect   DrawRect;
        int     CountGraph;

        Graphics::TBitmap *BGBitmap;
        Graphics::TBitmap *ReDrawBitmap;


        TMyGraph *GraphArray[6];
        TMyGraph *CurrentGraph;


public:		// User declarations
        void    __fastcall Init();
        void    __fastcall Add();
        void    __fastcall Draw();
        __fastcall TfrmShowWave(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmShowWave *frmShowWave;
//---------------------------------------------------------------------------
#endif
