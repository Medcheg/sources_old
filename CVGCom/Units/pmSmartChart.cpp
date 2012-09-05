//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmSmartChart.h"
//===========================================================================
CSmartChart::CSmartChart(TChart *pChart)
{
	fParentChart = pChart;
    fLineWidth	 = 2;
}

//===========================================================================
void CSmartChart::SeriesClear()
{
    if ( fParentChart == NULL  ) return;

    int SeriesCount = fParentChart->SeriesCount();
    for ( int i = 0; i < SeriesCount; i++ )
    {
    	fParentChart->Series[i]->Clear();
    	fParentChart->Series[i]->Visible = false;
    }
}

//===========================================================================
void CSmartChart::Set_LineWidth(int aValue)
{
    if ( fParentChart == NULL  ) return;
    if ( fLineWidth   == aValue) return;

    fLineWidth = aValue;

    int SeriesCount = fParentChart->SeriesCount();
    for ( int i = 0; i < SeriesCount; i++ )
        ((TLineSeries*)fParentChart->Series[i])->LinePen->Width = fLineWidth;
}

//===========================================================================
void CSmartChart::Draw_ChartSeries(int SeriesIndex, bool isGraphDecimation, bool isShowLeftAxisTitle, int DecimationPointCount, float LeftAxisValueOffset, int iBeginArrayIndex, int iEndArrayIndex, CCollection<float> *ax, CCollection<float> *ay)
{
  // ------ Если на Чарти Графиков меньше чем индекс тогда Дебаг БРЕАК --------
     if ( ay == NULL) return;
     if ( ay->ValuesCount == 0 ) return;
     if ( ax != NULL ) if ( ax->ValuesCount == 0 ) return;
     if ( SeriesIndex > fParentChart->SeriesList->Count - 1 ) __asm { int 3};

  // ----------
     fParentChart->Series[SeriesIndex]->Clear();
     fParentChart->Series[SeriesIndex]->Visible = true;
  // ----------

    fMinLeftAxis   =  10000000.0;
    fMaxLeftAxis   = -10000000.0;
    fMinBottomAxis =  10000000.0;
    fMaxBottomAxis = -10000000.0;

  // ---------- Если уже на чарте есть кривая, тогда опредиляем ее максимумы и миммумы  ----
  // ---------- Но только когда есть данные на сериях ----------
	for ( int i = 0; i < fParentChart->SeriesList->Count; i++)
    {
    	if ( fParentChart->Series[i]->Visible       == false ) continue;
		if (((TLineSeries*)fParentChart->Series[i])->YValues->Count == 0     ) continue;

        TChartSeries *ser = fParentChart->Series[i];
        if ( fMaxBottomAxis < ser->MaxXValue() ) fMaxBottomAxis = ser->MaxXValue();
        if ( fMinBottomAxis > ser->MinXValue() ) fMinBottomAxis = ser->MinXValue();
        if ( fMaxLeftAxis   < ser->MaxYValue() ) fMaxLeftAxis   = ser->MaxYValue();
        if ( fMinLeftAxis   > ser->MinYValue() ) fMinLeftAxis   = ser->MinYValue();
	}

  // ----------
//    if ( ax != NULL ) fParentChart->BottomAxis->Title->Caption = ax->Name;  else fParentChart->BottomAxis->Title->Caption = "";
//    if ( ay != NULL  && isShowLeftAxisTitle == true ) fParentChart->LeftAxis  ->Title->Caption = ay->Name;  else fParentChart->LeftAxis  ->Title->Caption = "";

  // ----------
    float *xVal = NULL, *yVal = NULL;

  // ----------

    if ( ax != NULL ) xVal = ax->gr_Values;
    if ( ay != NULL ) yVal = ay->gr_Values;
    if ( ax != NULL ) ax->CalculateGraphicsValues( false, true, iBeginArrayIndex, iEndArrayIndex, DecimationPointCount );
    if ( ay != NULL ) ay->CalculateGraphicsValues( false, true, iBeginArrayIndex, iEndArrayIndex, DecimationPointCount );
/*
    if ( ax == NULL )
    {
        fMinBottomAxis = 0;
        fMaxBottomAxis = fMaxBottomAxis;
    }
    else
    {
        fMinBottomAxis =  1000000;
        fMaxBottomAxis = -1000000;
    }
*/
	fParentChart->Series[SeriesIndex]->BeginUpdate();
        for ( int i = 0; i < ay->gr_ValuesCount; i++)
        {
            if ( ax != NULL )
            {
                if ( fMinBottomAxis > xVal[i] ) fMinBottomAxis = xVal[i];
                if ( fMaxBottomAxis < xVal[i] ) fMaxBottomAxis = xVal[i];
            }
            else
            {
                if ( fMinBottomAxis > ay->gr_ValuesIndex[i] ) fMinBottomAxis = ay->gr_ValuesIndex[i];
                if ( fMaxBottomAxis < ay->gr_ValuesIndex[i] ) fMaxBottomAxis = ay->gr_ValuesIndex[i];
            }

            if ( fMinLeftAxis > yVal[i] ) fMinLeftAxis = yVal[i];
            if ( fMaxLeftAxis < yVal[i] ) fMaxLeftAxis = yVal[i];

            if ( ax == NULL )
                 fParentChart->Series[SeriesIndex]->AddXY(ay->gr_ValuesIndex[i], yVal[i]);
            else fParentChart->Series[SeriesIndex]->AddXY(xVal[i]              , yVal[i]);
        }
	fParentChart->Series[SeriesIndex]->EndUpdate();

  // ----------
     if ( fMinLeftAxis == 0 && fMaxLeftAxis == 0 )
     {
         fMinLeftAxis = -1.1;
         fMaxLeftAxis =  1.1;
     }
     fParentChart->LeftAxis  ->SetMinMax( fMinLeftAxis - ((fMaxLeftAxis - fMinLeftAxis) * 0.06), fMaxLeftAxis + ((fMaxLeftAxis - fMinLeftAxis) * 0.06) );
     fParentChart->BottomAxis->SetMinMax( LeftAxisValueOffset + fMinBottomAxis - ((fMaxBottomAxis - fMinBottomAxis) * 0.06), LeftAxisValueOffset + fMaxBottomAxis + ((fMaxBottomAxis - fMinBottomAxis) * 0.06) );
}




