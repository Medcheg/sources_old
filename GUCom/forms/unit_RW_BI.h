//===========================================================================
#ifndef unit_RW_BIH
#define unit_RW_BIH
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <ComCtrls.hpp>
#include <Dialogs.hpp>
#include <Menus.hpp>
//===========================================================================
class Tform_RWBI : public TForm
{
__published:	// IDE-managed Components
	TPanel *Panel1;
	TLabel *Label1;
	TLabel *Label2;
	TLabel *Label9;
	TLabel *lShortTerm_Result;
	TLabel *lShortTerm;
	TLabel *Label11;
	TLabel *Label15;
	TLabel *Label18;
	TEdit *eSummation1;
	TPanel *Panel5;
	TPanel *Panel6;
	TLabel *Label6;
	TLabel *Label10;
	TBitBtn *bCalculate;
	TEdit *eSamplingTime;
	TBitBtn *bStop;
	TProgressBar *ProgressBar1;
    TPanel *Panel4;
    TLabel *Label3;
    TLabel *Label4;
	TLabel *label_MeanValue_c;
	TLabel *label_MeanValue;
	TLabel *label_PeakPeak_c;
	TLabel *label_PeakPeak;
    TGridPanel *GridPanel1;
    TGridPanel *GridPanel2;
    TPageControl *PageControl2;
    TTabSheet *TabSheet3;
    TChart *Chart2;
    TTabSheet *TabSheet4;
    TChart *Chart3;
    TChart *chart_AllanVar;
    TFastLineSeries *Series2;
    TFastLineSeries *Series3;
    TFastLineSeries *Series5;
    TPageControl *PageControl1;
    TTabSheet *TabSheet1;
    TTabSheet *TabSheet2;
    TPanel *pCorrection;
    TLabel *lRegressionOrder;
    TUpDown *udRegressionOrder;
    TEdit *eRegressionOrder;
    TComboBox *cbPar1;
    TCheckBox *checkbox_Par1;
    TComboBox *cbPar3;
    TCheckBox *checkbox_Par3;
    TComboBox *cbPar2;
    TCheckBox *checkbox_Par2;
    TComboBox *cbPar4;
    TCheckBox *checkbox_Par4;
    TCheckBox *cbCorrection;
    TPanel *Panel2;
    TLabel *Label7;
    TEdit *eScaleFactor;
    TComboBox *cbCorrectedParam;
    TCheckBox *cbIndex;
    TEdit *eBeginPoint;
    TEdit *eEndPoint;
    TCheckBox *CheckBox1;
    TFastLineSeries *Series1;
    TLabel *Label5;
    TPopupMenu *PopupMenu1;
    TMenuItem *SaveAllanVarianceforFile1;
    TSaveDialog *SaveDialog1;
	void __fastcall cbIndexClick(TObject *Sender);
	void __fastcall cbCorrectionClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall checkbox_ParameterClick(TObject *Sender);
	void __fastcall bCalculateClick(TObject *Sender);
	void __fastcall chart_AllanVarAfterDraw(TObject *Sender);
	void __fastcall chart_AllanVarBeforeDrawSeries(TObject *Sender);
	void __fastcall chart_AllanVarExit(TObject *Sender);
	void __fastcall chart_AllanVarMouseMove(TObject *Sender, TShiftState Shift, int X,
          int Y);
	void __fastcall bStopClick(TObject *Sender);
	void __fastcall ChartAfterDraw(TObject *Sender);
    void __fastcall SaveAllanVarianceforFile1Click(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
private:	// User declarations
     float   RegCoefZeros[100];
     float   RegCoef[100];

    int    LogMouseX, LogMouseY;
    bool   isAllanCalculated;

    double BiasInstability;

    int    BeginPoint;
    int    EndPoint;
    double SampleTimeValues;

    CCollection<float> *AlanData;

    double ScaleFactor, ShortTermSummationCount;
    int    BeginCalcIndex, EndCalcIndex;

    AnsiString DimensionStr;

    bool   isGlobalBreak;
    bool   isMouseOnTheAllan;

    TComboBox *ComboBox_array[5];
    TCheckBox *CheckBox_array[4];

    bool __fastcall CheckEditedData();
    void __fastcall ChartClear();
    void __fastcall Get_BeginEndIntervals(int *bIndex, int *eIndex);
    void  __fastcall CalculateRegressionTermoCorection( CCollection<float> *base,
                                                        CCollection<float> **cor, int ParamCount,
                                                        CCollection<float> *c1,
                                                        CCollection<float> *c2 );
    float __fastcall BICalcBySCO( int SummationCount, bool isCalcMean, CCollection<float> *InArray, TProgressBar *pb );
    void  __fastcall AlanCalc_Draw(TChart *chart, CCollection<float> *alanData);
    void __fastcall  DrawLogTicks(TChartAxis *BaseAxis, TChartAxis *noBaseAxis, bool isFirstAxisVertical); 

public:		// User declarations
    CCollection<float> *Data;
	__fastcall Tform_RWBI(TComponent* Owner);
};
//===========================================================================
extern PACKAGE Tform_RWBI *form_RWBI;
//===========================================================================
#endif
