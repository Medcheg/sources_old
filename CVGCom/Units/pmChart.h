//===========================================================================
#ifndef pmChartH
#define pmChartH

//===========================================================================
#include "pmChartAxis.h"
//===========================================================================
typedef void __fastcall (__closure *TParent_PanelDown)( bool isDown );
//===========================================================================
typedef struct tag_MouseStruct
{
    int ChartMousePos_X, ChartMousePos_Y;
    int PosInGraphArray;
    int IndexInGlobalArray;

    tag_MouseStruct(){Init();}
    void Init()
    {
       ChartMousePos_X = ChartMousePos_Y = PosInGraphArray = IndexInGlobalArray = -1;
    }
    void CopyTo(tag_MouseStruct *ms)
    {
        ms->ChartMousePos_X    = ChartMousePos_X;
        ms->ChartMousePos_Y    = ChartMousePos_Y;
        ms->PosInGraphArray    = PosInGraphArray;
        ms->IndexInGlobalArray = IndexInGlobalArray;
    }
}TMouseStruct;

typedef struct tag_TChartPiece
{
    CCollection<float> *si;
	CChartAxis_pm       LeftAxis;

    TRect               ChartRect;
    TRect               DrawRect;
    TRect               LeftAxisRect;
    TRect               TopAxisRect;
    int                 oldStrorageValuesCount;

    int                 CaptionLeft, CaptionTop, CaptionWidth;
}TChartPiece;

//typedef void __fastcall Panel_SelectInterval_SetDown( bool isDown );
class CChartAxis_pm;
class CChart
{
private:
    Extctrls::TPanel   *fPanel_Parent;
    Extctrls::TPanel   *fpPanel_CursorTimeValue;
    TCheckListBox      *fCheckListBox_SeriesNames;
    TPaintBox          *pbImage;
    Graphics::TBitmap  *BackGroundBitmap;
    Graphics::TBitmap  *RedrawBitmap;

    void __fastcall on_Change_ScrollBar  (TObject* Sender);
    void __fastcall on_Resize_ParentPanel(TObject* Sender);

    void __fastcall on_MouseMove_pb(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
    void __fastcall on_MouseDown_pb(System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
    void __fastcall on_MouseUp_pb  (System::TObject* Sender, TMouseButton Button, Classes::TShiftState Shift, int X, int Y);

    void __fastcall on_Paint_pb(System::TObject* Sender);
private:
	CCollectionStorage<float> *pStorage;  // ------ прочитанные данные с ком порта (все каналы) -
private:
    bool  isChartResizing;
    bool  isParentInit;
    bool  isNeedClear;
    int   isDrawEnabled;
    bool *p_isParentInterfaceInited;

    int   ScrollBar_Position;
    int   DeviceValuesCount;
    int   DeviceValuesCount_old;

    TRect   TimeAxesRect;

    TChartPiece  *fCharts;
    int           fChartsCount;
    int           xMousePos;
    int           xMousePos_gr_old;
    int           yMousePos;
    int           yMousePos_gr_old;

    void DeleteBitmaps();
    void FullFill_BGBitmap();
    void CreateBitmaps();
    void DrawDeviceStorageSelectedPart( Graphics::TCanvas *aCanvas );
    void __fastcall Set_ChartsCount(int aValue);
    void DrawChartCaption(TChartPiece *pChart, float Value, bool isDrawValue);
public:
    //bool  isRealTimeWork;

  // -------- Данные которые нужны при онлайн отрисовки по данному девайсу,
  // -------- По етим данным вычисляем тренды и Т.П. -----------

    int      DrawToStorageItem;
    int      DrawFromStorageItem;
    int      PointOnChart;

    TSelectPart *SelecetStorageParts;
    bool        *isSelecetStorageParts;
    int          CountSelectedStorageParts;
    TScrollBar  *fScrollBar;

    bool     isEngineeringMode;
    bool     isAutoTracking;
    bool     isEditMode;
    bool     isDecimation;
    bool     isFullTimeScale;
    bool     isNeedRepaint;
    bool     isRealTimeWork;


  // --------- Мышка -----
    TMouseStruct   MouseDownPos;      // ----- Предыдущая структура мышки                     ----
    TMouseStruct   OldMousePos;      // ----- Предыдущая структура мышки                     ----
    TMouseStruct   CurrentMousePos;  // ----- Текущая структура мышки                     ----
    TMouseStruct   FirstMousePos;    // ----- Струткру "миши" при первом нажатии на чарте ----
    TMouseStruct   SecondMousePos;   // ----- Струткру "миши" при втором нажатии на чарте ----

    TParent_PanelDown void_Parent_PanelDown;
    void SetEvents( bool isEnabled );
    void ReCalcSize( TObject* Sender );
    void RePaint( TObject* Sender );
    void Init(  CCollectionStorage<float> *apStorage  );
    void Draw();

    CChart( Extctrls::TPanel *afPanel_Parent, TCheckListBox *afCheckListBox_SeriesNames, Extctrls::TPanel   *apPanel_CursorTimeValue, bool *ap_isParentInterfaceInited);
   ~CChart();

   __property int ChartsCount = { read = fChartsCount, write = Set_ChartsCount };

};
//===========================================================================
#endif
