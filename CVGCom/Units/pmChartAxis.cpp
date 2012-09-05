//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmChartAxis.h"
#include "math.hpp"

//===========================================================================
CChartAxis_pm::CChartAxis_pm()
{
    fMinimum  =  1000000.0;
    fMaximum  = -1000000.0;

    ValuesCount = 0;

    Orientation = ecaoVertical;
}

//===========================================================================
CChartAxis_pm::~CChartAxis_pm()
{
}

//===========================================================================
void CChartAxis_pm::Init()
{
    ibase_CountAxisValues          = 15;
    ibase_MinPointsBetweenNetLines = 36;

    if ( Orientation == ecaoVertical )
    {
        iAxisLength = parent_DrawRect.Height() - 2;
        iStartPos   = parent_DrawRect.Bottom   - 1;
        iEndPos     = parent_DrawRect.Top      + 1;
    }
    else
    {
        iAxisLength = parent_DrawRect.Width() - 2;
        iStartPos   = parent_DrawRect.Left    + 1;
        iEndPos     = parent_DrawRect.Right   - 1;
    }

    if ( iAxisLength / ibase_CountAxisValues < ibase_MinPointsBetweenNetLines  ) ibase_CountAxisValues = iAxisLength / ibase_MinPointsBetweenNetLines;
    if ( iAxisLength == 0 ) ibase_CountAxisValues = 15;


    ValuesCount = 0;
}

//===========================================================================
void CChartAxis_pm::CalculatePosition( double minVal, double maxVal )
{
    if ( fMinimum == minVal && fMaximum == maxVal && fMinimum != fMaximum ) return;

    fMinimum = minVal;
    fMaximum = maxVal;

    if ( fMinimum == fMaximum )
    {
    	fMinimum = fMinimum - 0.1;
        fMaximum = fMaximum + 0.1;
    }

    ValuesCount = 0;

    // ------------- Расчет новых положений линий ----
    double ChartMaxMin       = ( fMaximum - fMinimum == 0) ? 0.0001 : fMaximum - fMinimum;
    double Scale             = iAxisLength / ChartMaxMin;
    double FloatTickStep     = ( ibase_CountAxisValues == 0 ) ? 1.0 : ChartMaxMin / (double)ibase_CountAxisValues;
    if ( FloatTickStep <= 0 ) FloatTickStep = 1;

    double aPower            = (FloatTickStep >= 0) ? ceil(  log10( FloatTickStep ) ) : floor( log10( FloatTickStep ) );
    double Exp10             =  Power( 10, aPower );
    double NormalizeIncValue = ( Exp10 == 0 ) ? 0    :  floor( FloatTickStep / Exp10 *10.0 ) / 10.0;
    double TickStep          = ( Exp10 == 0 ) ? 1000 : NormalizeIncValue * Exp10;
    double BeginValue        = ((int)(fMinimum / TickStep)) * TickStep;
    // --------

    if ( Orientation == ecaoVertical ) Scale = -Scale;
    double  CurrentValue = BeginValue;
    while ( CurrentValue < fMaximum )
    {
        int Pos = iStartPos + (int)((CurrentValue - fMinimum) * Scale);
        bool isZeroLine = (fabs(CurrentValue) < 1e-9);

        if ( ( Pos > iStartPos + 1 && Pos < iEndPos   - 1 && iEndPos > iStartPos ) ||
             ( Pos > iEndPos   + 1 && Pos < iStartPos - 1 && iEndPos < iStartPos ))
        {
           // ---
            ValuesPosition[ValuesCount] = Pos;
            Values        [ValuesCount] = CurrentValue;

            if ( isZeroLine == false || Orientation == ecaoHorizontal )ValuesCount++;

        }

        // ------- Декрементирую тип позитион ------
        CurrentValue = CurrentValue + TickStep;
    }
}

//===========================================================================
void CChartAxis_pm::Draw( Graphics::TCanvas *aCanvas, TColor clColor )
{

}

