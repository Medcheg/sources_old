//---------------------------------------------------------------------------
#ifndef pmChartManagerH
#define pmChartManagerH
//---------------------------------------------------------------------------
#define MAX_COLLECTION_COUNT 10
#define MAX_CHARTS_COUNT 10
#define MAX_SERIES_COUNT 10
#define MAX_POINTS_ONCHART 2000
//---------------------------------------------------------------------------
typedef struct tag_MouseStruct
{
    TChart *chart;
    int     xPos, yPos;

    // ------------
    void Init()
    {
        chart = NULL;
        xPos = -1;
        yPos = -1;
    }
    // ------------
    void CopyTo(tag_MouseStruct *ms)
    {
        ms->xPos   = xPos;
        ms->yPos   = yPos;
    }
    // ------------
    tag_TChartMouse()
    {
        Init();
    }
}TMouseStruct;

class CChartManager
{
private:
    TPanel *ParentPanel;
    int     fChartsCount;
    CCollection<float> *fCollection[MAX_COLLECTION_COUNT];
    int     fCollectionCount;

private:
    TCheckListBox   *CheckListBox_SeriesNames;
    TPanel          *panel_Chart;
    TPanel          *panel_ScrollBar;
    TScrollBar      *scrollbar_Offset;
    TScrollBar      *scrollbar_Scale;

private:
    char LabelText[256];
    int  VectorIndexs[MAX_CHARTS_COUNT];
    TMouseStruct     mouse;
    float   VisiblePointsPercent;
    int     DrawFromPoint;
    int     DrawToPoint;

    bool            fCanDraw;


    void __fastcall chart_onResize(TObject *Sender);
    void __fastcall set_ChartCount( int chartsCount );
    void __fastcall set_Collection(int index, CCollection<float> *collection);

    void __fastcall on_Draw_CheckListBox(Controls::TWinControl* Control, int Index, const Types::TRect &aRect, TOwnerDrawState State);
    void __fastcall on_ClickCheck_CheckListBox(TObject *Sender);
    void __fastcall on_MouseMove (System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
    void __fastcall on_MouseDown (System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
    void __fastcall on_MouseUp   (System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
    void __fastcall on_MouseLeave(System::TObject* Sender);
    void __fastcall on_Zoom_Scroll_undoZoom(System::TObject *Sender);
    void __fastcall on_UndoZoom(System::TObject *Sender);
    void __fastcall on_Scroll(TObject *Sender);

    void __fastcall on_Change_scrollBar(System::TObject* Sender);
public:
    TChart *ChartArray[MAX_CHARTS_COUNT];

    void Collection_add(CCollection<float> *collection);
    void Collection_clear();

    void Init();
    void Draw();
    CChartManager(TPanel *aBasePanel);

    __property int                 ChartsCount = { write = set_ChartCount };
};
//---------------------------------------------------------------------------
#endif
