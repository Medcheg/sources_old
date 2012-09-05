//===========================================================================
#ifndef pmChartManagerH
#define pmChartManagerH
//===========================================================================
#include <CheckLst.hpp>
#include <Buttons.hpp>
//===========================================================================

class CChart;
class CChartManager
{
private:
    Extctrls::TPanel   *Panel_Parent;
    Extctrls::TPanel   *Panel_Menu;
    Extctrls::TPanel   *Panel_MainBGChart;
    Extctrls::TPanel   *Panel_Chart;
    Extctrls::TPanel   *Panel_StringGrid;
    Extctrls::TPanel   *Panel_SeriesNames;
    Extctrls::TPanel   *Panel_CursorTimeValue;

    TScrollBar         *ScrollBar_StringGrid;

    TStringGrid        *StringGrid_Data;

    TCheckListBox      *CheckListBox_SeriesNames;
    TTabControl        *TabControl_SeriesTable;

    TButton            *Button_SelectAllSeries;
    TButton            *Button_DeSelectAllSeries;

    TLabel             *Label_PointOnChart; 
    TEdit              *Edit_PointOnChart; 
    TSpeedButton       *SpeedButton_PointOnChart;

    TCheckBox          *CheckBox_FullTimeScale;
    TCheckBox          *CheckBox_Decimation;
    TCheckBox          *CheckBox_AutoTracking;
    TCheckBox          *CheckBox_EditMode;
    TCheckBox          *CheckBox_XCursor;
    TCheckBox          *CheckBox_YCursor;


    Extctrls::TPanel   *Panel_SelectInterval;
    TButton            *Button_ShowIntervalResults;

    void __fastcall TabControl_SeriesTable_onClick(TObject *Sender);
    void __fastcall on_Click_Button_PointOnChart(TObject *Sender);
    void __fastcall isFullTimeScaleChecked(TObject *Sender);
    void __fastcall isDecimationChecked(TObject *Sender);
    void __fastcall on_Checked_isAutoTracking(TObject *Sender);
    void __fastcall on_Checked_isEditMode(TObject *Sender);
	void __fastcall on_Draw_CheckListBox(Controls::TWinControl* Control, int Index, const Types::TRect &aRect, TOwnerDrawState State);
	void __fastcall on_ClickCheck_CheckListBox(TObject *Sender);
    void __fastcall on_Click_Button_ShowIntervalResults(TObject *Sender);
	void __fastcall on_Click_Button_SelectAllSeries(TObject *Sender);
	void __fastcall on_Click_Button_DeSelectAllSeries(TObject *Sender);
    void __fastcall on_Click_Panel_SelectInterval(TObject *Sender);
	void __fastcall on_Resize_Panel_Parent(TObject *Sender);
private:
    char LabelText[256];

private:
    bool    isPanel_SelectIntervalDown;
    bool    isTableShow;
    bool    CheckListBoxIndexesChecked[1024];

    bool    isInterfaceInited;
	CCollectionStorage<float> *pStorage;  // ------ прочитанные данные с ком порта (все каналы) -

    unsigned int  StorageValuesCount_Previous;

    void __fastcall InitChartManagerInterface();
    void __fastcall Panel_SelectInterval_SetDown( bool isDown );
    void __fastcall Set_AutoTracking( bool Value );
    void __fastcall Set_RealTimeWork( bool Value );
public:
    CChart   *Chart;

    void __fastcall BaseInit( CCollectionStorage<float> *apStorage );
	void __fastcall RealTimeUpdate();
	void __fastcall Update( );

    void ClearAndClose_form_Result();
	CChartManager(Extctrls::TPanel *aParentPanel);
   ~CChartManager();

   __property bool isAutoTracking = { write = Set_AutoTracking };
   __property bool isRealTimeWork = { write = Set_RealTimeWork };
};
//===========================================================================
#endif

