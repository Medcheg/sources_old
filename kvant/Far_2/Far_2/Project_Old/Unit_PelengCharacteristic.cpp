//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_PelengCharacteristic.h"
#include "Math.h"
#include "Math.hpp"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmPelengCharacteristic *frmPelengCharacteristic;
//---------------------------------------------------------------------------
__fastcall TfrmPelengCharacteristic::TfrmPelengCharacteristic(TComponent* Owner)
        : TForm(Owner)
{
    BeginTeta = 0.0  * Pi_del_180;
    EndTeta   = 75.0 * Pi_del_180;
    TetaStep  = 5.0  * Pi_del_180;
}

//---------------------------------------------------------------------------
void __fastcall TfrmPelengCharacteristic::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';
}

//---------------------------------------------------------------------------
void __fastcall TfrmPelengCharacteristic::FormShow(TObject *Sender)
{
     Caption = ProjectCaption + "Пеленгационные характеристики нормированной ДНА";
   // --------
//!!!!!!!!!!!!!!!!!!!!!
/*    egBeginTeta->Set_Gradus_Value(BeginTeta);
    egEndTeta  ->Set_Gradus_Value(EndTeta);
    egTetaStep ->Set_Gradus_Value(TetaStep);*/
   // --------

     BitBtn1Click(Sender);
}

//---------------------------------------------------------------------------
void TfrmPelengCharacteristic::CreateSeriesAndAddToChart(TChart *aChart, TFloat aVal)
{
 TFastLineSeries *Series;

    Series                 = new TFastLineSeries(this);
    Series->ParentChart    = aChart;
    Series->LinePen->Color = aChart->GetFreeSeriesColor(true);
    Series->LinePen->Width = 2;
    Series->XValues->Order = loNone;
    Series->YValues->Order = loNone;
    Series->Title          = "Teta = " + FloatToStrF(aVal*_180_del_Pi, ffFixed, 20, 2);
}

//---------------------------------------------------------------------------
void __fastcall TfrmPelengCharacteristic::BitBtn1Click(TObject *Sender)
{
    bool Result;
//!!!!!!!!!!!!!!!!!!!!!
/*       egBeginTeta->Get_Gradus_Value(&BeginTeta, &Result);  if (!Result) return;
       egEndTeta  ->Get_Gradus_Value(&EndTeta  , &Result);  if (!Result) return;
       egTetaStep ->Get_Gradus_Value(&TetaStep , &Result);  if (!Result) return;*/
       if (EndTeta  < BeginTeta) {MessageDlg("Начальное значение Тета по величине должно быть меньше за конечное значение Тета.", mtWarning, TMsgDlgButtons() << mbOK, 0); return; }
       if (TetaStep <= 0       ) {MessageDlg("Значение шага по углу Тета должно превышать величину НУЛЯ.", mtWarning, TMsgDlgButtons() << mbOK, 0); return; }
    // +++++++++++++++++++++++++++++++++++

       TFloat aEps_c = 0.07;
       TFloat aQ_c   = 0;
       TFloat CurFi  = 0;
       TFloat aDeltaQ, aDeltaAlfa = 0;
    // +++++++++++++++++++++++++++++++++++
       int i = 0; while ( i < Chart1->SeriesList->Count ) ((TFastLineSeries*)Chart1->SeriesList->Items[0])->Free(); // --------- Удаляю предыдущие отрисованые кривые ----
    // +++++++++++++++++++++++++++++++++++

       for (TFloat CurTeta = BeginTeta; CurTeta <= EndTeta; CurTeta = CurTeta + TetaStep){
               CreateSeriesAndAddToChart(Chart1, CurTeta);
             // --------------

               *aFar->pStrobing = true;
                aFar->Calc_Teta_Fi_DeltaQ_DeltaAlfa(CurTeta, CurFi, aDeltaQ, aDeltaAlfa);
                aFar->Set_DeltaQ_DeltaAlfa(aDeltaQ, aDeltaAlfa);

               for (aQ_c = -0.8 * aFar->FarParam->Diagram.Shir; aQ_c < 0.8 * aFar->FarParam->Diagram.Shir; aQ_c = aQ_c + 0.0007){
                   // ----------- Расчет значений вольтов для каждого из лучей ---------
                     for (int i = 0; i < Diagram_Count; i++) {
                            TFloat aOffsetX = sin(aQ_c  ) - sin(DiagramArray[i]->OffsetX);
                            TFloat aOffsetY = sin(aEps_c) - sin(DiagramArray[i]->OffsetY);

                         // -------- А теперь смещение относительно "нуля" центра луча в радианах-------
                            aOffsetX = _ArcSin_(aOffsetX);
                            aOffsetY = _ArcSin_(aOffsetY);

                         // ------------------- Ниже типа аРадВалуе нуно умножить косинус Тета
                            aRadValue[i] = DiagramArray[i]->Get_SignalStrength(aOffsetX, aOffsetY);
                            //if (aCalcRelay) aRadValue[i] = DiagramArray[i]->Get_RelayValue(aRadValue[i]);
                     }

                   // -------- Теперь расчитаным мощностям в каждом луче расчитываем координаты цели --------
                      TFloat SumRadValue = aRadValue[0] + aRadValue[2]  +  aRadValue[1] + aRadValue[3];
                      E1 = ((aRadValue[1] + aRadValue[3]) - (aRadValue[0] + aRadValue[2])) / SumRadValue;
                      //E2 = ((aRadValue[0] + aRadValue[1]) - (aRadValue[2] + aRadValue[3])) / SumRadValue;

                      Chart1->Series[Chart1->SeriesList->Count - 1]->AddXY(aQ_c * _180_del_Pi, E1, "", clBlack);
               }
       }
}
//---------------------------------------------------------------------------

void __fastcall TfrmPelengCharacteristic::FormDestroy(TObject *Sender)
{
       int i = 0; while ( i < Chart1->SeriesList->Count ) ((TFastLineSeries*)Chart1->SeriesList->Items[0])->Free(); // --------- Удаляю предыдущие отрисованые кривые ----
}
//---------------------------------------------------------------------------

void __fastcall TfrmPelengCharacteristic::Chart1BeforeDrawSeries(
      TObject *Sender)
{
  // --------

      Chart1->Canvas->Pen->Color = clBlack;
      Chart1->Canvas->MoveTo(Chart1->BottomAxis->IStartPos, Chart1->LeftAxis  ->CalcYPosValue(0));
      Chart1->Canvas->LineTo(Chart1->BottomAxis->IEndPos  , Chart1->LeftAxis  ->CalcYPosValue(0));
      Chart1->Canvas->MoveTo(Chart1->BottomAxis->CalcXPosValue(0), Chart1->LeftAxis->IStartPos);
      Chart1->Canvas->LineTo(Chart1->BottomAxis->CalcXPosValue(0), Chart1->LeftAxis->IEndPos);
}
//---------------------------------------------------------------------------

