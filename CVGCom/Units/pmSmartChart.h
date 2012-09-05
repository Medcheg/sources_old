//===========================================================================
#ifndef pmSmartChartH
#define pmSmartChartH
//===========================================================================
class CSmartChart
{
private:
    TChart *fParentChart;

private:
	int fLineWidth;


    double  fMinLeftAxis;
    double  fMaxLeftAxis;
    double  fMinBottomAxis;
    double  fMaxBottomAxis;

private:
    void Set_LineWidth(int aValue);
public:
    void SeriesClear();
    void Draw_ChartSeries(int SeriesIndex, bool isGraphDecimation, bool isShowLeftAxisTitle, int DecimationPointCount, float LeftAxisValueOffset, int iBeginArrayIndex, int iEndArrayIndex, CCollection<float> *ax, CCollection<float> *ay);

	CSmartChart(TChart *pChart);

    __property int LineWidth = {read = fLineWidth, write = Set_LineWidth};
};
#endif
