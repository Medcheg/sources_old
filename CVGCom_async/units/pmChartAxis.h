//===========================================================================
#ifndef pmChartAxisH
#define pmChartAxisH
//===========================================================================
enum TChartAxisOrientation { ecaoNone = 0, ecaoHorizontal = 1, ecaoVertical = 2 };
class CChartAxis_pm
{
private:
    double fMinimum;
    double fMaximum;

    int    ibase_CountAxisValues;
    int    ibase_MinPointsBetweenNetLines;
    int    iAxisLength;
    int    iStartPos;
    int    iEndPos;
public:
    TRect  parent_ChartRect;
    TRect  parent_DrawRect;
    TRect  parent_LeftAxesRect;

    TChartAxisOrientation Orientation;

    int    ValuesCount;
    float  Values[1024];
    int    ValuesPosition[1024];


    CChartAxis_pm();
   ~CChartAxis_pm();

    void Init();
    void CalculatePosition( double minVal, double maxVal );
    void Draw( Graphics::TCanvas *aCanvas, TColor clColor );
};
//===========================================================================
#endif
