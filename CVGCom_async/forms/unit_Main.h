//---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <jpeg.hpp>
#include <Menus.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class CChartManager;
class Tform_Main : public TForm
{
__published:	// IDE-managed Components
    TToolBar *ToolBar1;
    TToolButton *tbFile;
    TToolButton *tbDeviceAndPortSetting;
    TToolButton *tbAnalisys;
    TToolButton *tbAllan;
    TToolButton *tbWindow;
    TPanel *Panel_Info;
    TImage *Image2;
    TImage *Image1;
    TBitBtn *bStop;
    TBitBtn *bStart;
    TPanel *panel_ChartManager;
    TStatusBar *StatusBar1;
    TLabel *lUrl;
    TLabel *lTimeElabsed;
    TProgressBar *ProgressBar1;
    TPanel *panel_error;
    TActionList *ActionList1;
    TAction *Action_Start;
    TAction *Action_Stop;
    TAction *Action_DeviceParam;
    TAction *Action_AllanCalculate;
    TAction *Action_OpenDataFile;
    TAction *Action_Close;
    TAction *Action_Graphs;
    TAction *Action_SaveDataFile;
    TPopupMenu *pmFile;
    TMenuItem *miOpenDataFile;
    TMenuItem *Opendatafileextended1;
    TMenuItem *RWBIbyAllan1;
    TMenuItem *Savedata1;
    TMenuItem *N2;
    TMenuItem *miExit;
    TOpenDialog *OpenDialog1;
    TPopupMenu *pmAnalisys;
    TMenuItem *N0Gpraphs1;
    TMenuItem *mi2DCharts;
    TMenuItem *miRezonatorTemperature;
    TMenuItem *miTermoCorrection;
    TMenuItem *N3;
    TMenuItem *miGyroTransformFactor;
    TMenuItem *N1;
    TMenuItem *FFTTransform1;
    TPopupMenu *pmTools;
    TMenuItem *miCalcRegresionCoef;
    TMenuItem *N4;
    TMenuItem *miMultiAnalys;
    TSaveDialog *SaveDialog1;
    TToolButton *tollbutton_DeviceMonitor;
    TAction *Action_DeviceMonitor;
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall Action_StartExecute(TObject *Sender);
    void __fastcall Action_StopExecute(TObject *Sender);
    void __fastcall Action_DeviceParamExecute(TObject *Sender);
    void __fastcall bStartClick(TObject *Sender);
    void __fastcall bStopClick(TObject *Sender);
    void __fastcall Action_AllanCalculateExecute(TObject *Sender);
    void __fastcall Action_OpenDataFileExecute(TObject *Sender);
    void __fastcall Action_CloseExecute(TObject *Sender);
    void __fastcall Action_SaveDataFileExecute(TObject *Sender);
    void __fastcall Action_GraphsExecute(TObject *Sender);
    void __fastcall Action_DeviceMonitorExecute(TObject *Sender);
private:	// User declarations
    CChartManager *ChartManager;
    void ReadDataFromRegistry();
    void SaveDataToRegistry();
    void SetProjectCaption();

    void __fastcall NewWndProc(TMessage &Msg);
public:		// User declarations
    __fastcall Tform_Main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Main *form_Main;
//---------------------------------------------------------------------------
#endif
