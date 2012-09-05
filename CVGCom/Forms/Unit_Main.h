//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <jpeg.hpp>
#include <ToolWin.hpp>
#include <ActnList.hpp>
#include <Menus.hpp>
#include <Dialogs.hpp>
#include <ExtDlgs.hpp>
#include "Spin.hpp"
//---------------------------------------------------------------------------
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
	TLabel *lComName;
	TLabel *lPackedLength;
	TLabel *lTimeElabsed;
	TLabel *labelFalsPacked;
    TTimer *Timer_onIdleTimer;
    TActionList *ActionList1;
    TAction *Action_Start;
    TAction *Action_Stop;
    TAction *Action_DeviceParam;
    TLabel *lCountData;
    TAction *Action_AllanCalculate;
    TPopupMenu *pmFile;
    TMenuItem *miOpenDataFile;
    TMenuItem *N2;
    TMenuItem *miExit;
    TAction *Action_OpenDataFile;
    TAction *Action_Close;
    TOpenDialog *OpenDialog1;
    TProgressBar *ProgressBar1;
    TPopupMenu *pmAnalisys;
    TMenuItem *N0Gpraphs1;
    TMenuItem *mi2DCharts;
    TMenuItem *miRezonatorTemperature;
    TMenuItem *miTermoCorrection;
    TMenuItem *N3;
    TMenuItem *miGyroTransformFactor;
    TMenuItem *N1;
    TMenuItem *FFTTransform1;
    TAction *Action_Graphs;
    TToolButton *tbDeviceAndPortSetting_RSSwitch;
    TAction *Action_DeviceParamSW;
	TPanel *panel_ExternalDeviceCommand;
	TButton *button_ResetIntegrator;
	TButton *button_Calibrate;
	TRadioButton *RadioButton1;
	TRadioButton *RadioButton2;
	TToolButton *tbTools;
	TAction *Action_OpenDataFile_ext;
	TMenuItem *Opendatafileextended1;
	TPopupMenu *pmTools;
	TMenuItem *miMultiAnalys;
	TMenuItem *miCalcRegresionCoef;
	TMenuItem *N4;
	TMenuItem *RWBIbyAllan1;
	TMenuItem *Savedata1;
	TAction *Action_SaveDataFile;
	TSaveDialog *SaveDialog1;
	TPanel *panel_error;
    TPopupMenu *pmCorretion;
    TMenuItem *miAlfaQAlfaECorrection;
    TMenuItem *miScaleFactorCorrection;
    TMenuItem *miStaticCorrection;
    TMenuItem *SendDataToCCGProg;
    TMenuItem *N5;
    TMenuItem *ResonatorResearch1;
	void __fastcall FormCreate(TObject *Sender);
	void __fastcall FormDestroy(TObject *Sender);
	void __fastcall FormActivate(TObject *Sender);
	void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall Timer_onIdleTimerTimer(TObject *Sender);
    void __fastcall Action_StartExecute(TObject *Sender);
    void __fastcall Action_StopExecute(TObject *Sender);
    void __fastcall Action_DeviceParamExecute(TObject *Sender);
    void __fastcall bStartClick(TObject *Sender);
    void __fastcall bStopClick(TObject *Sender);
    void __fastcall Action_AllanCalculateExecute(TObject *Sender);
    void __fastcall Action_OpenDataFileExecute(TObject *Sender);
    void __fastcall Action_CloseExecute(TObject *Sender);
    void __fastcall Action_GraphsExecute(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
	void __fastcall RadioButton1Click(TObject *Sender);
	void __fastcall RadioButton2Click(TObject *Sender);
	void __fastcall button_ResetIntegratorClick(TObject *Sender);
	void __fastcall button_CalibrateClick(TObject *Sender);
	void __fastcall Action_OpenDataFile_extExecute(TObject *Sender);
	void __fastcall miMultiAnalysClick(TObject *Sender);
	void __fastcall miCalcRegresionCoefClick(TObject *Sender);
	void __fastcall miCVGDataEditorClick(TObject *Sender);
	void __fastcall Action_SaveDataFileExecute(TObject *Sender);
    void __fastcall SendDataToCCGProgClick(TObject *Sender);
    void __fastcall ResonatorResearch1Click(TObject *Sender);
private:	// User declarations
    LARGE_INTEGER li_f, li_q1, li_q2;

    CChartManager *ChartManager;
    bool          isComDataReading;

    void ReadDataFromRegistry();
    void SaveDataToRegistry();
    void SetProjectCaption();
	void Show_Hide_ExternalDeviceCommand( bool isShowPanel );

    void __fastcall AppMessage (tagMSG &msg, bool &handled);
public:		// User declarations
	__fastcall Tform_Main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Main *form_Main;
//---------------------------------------------------------------------------
#endif
