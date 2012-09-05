//===========================================================================
#ifndef Unit_AlanCalculateH
#define Unit_AlanCalculateH
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
//===========================================================================
class Tform_AllanCalculate : public TForm
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
	TLabel *lLongTerm;
	TLabel *lLongTerm_Result;
	TLabel *Label18;
	TLabel *Label19;
	TEdit *eSummation1;
	TEdit *eSummation2;
	TPanel *Panel5;
	TPanel *Panel6;
	TLabel *Label6;
	TLabel *Label10;
	TBitBtn *bCalculate;
	TEdit *eSamplingTime;
	TBitBtn *bStop;
	TProgressBar *ProgressBar1;
	TPageControl *PageControl1;
	TTabSheet *TabSheet1;
	TTabSheet *TabSheet2;
	TMemo *Memo1;
	TEdit *Edit1;
	TEdit *Edit2;
	TEdit *Edit3;
    TPanel *Panel4;
    TLabel *Label3;
    TLabel *Label4;
	TButton *button_MNK;
	TGridPanel *GridPanel1;
	TGridPanel *GridPanel2;
	TChart *Chart1;
	TLineSeries *Series1;
	TPanel *Panel2;
	TLabel *Label7;
	TEdit *eScaleFactor;
	TCheckBox *cbScaleFactor;
	TComboBox *cbCorrectedParam;
	TCheckBox *cbIndex;
	TEdit *eBeginPoint;
	TEdit *eEndPoint;
	TPanel *pCorrectionBG;
	TCheckBox *cbCorrection;
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
	TComboBox *cbPar5;
	TComboBox *cbPar6;
	TCheckBox *checkbox_Par5;
	TCheckBox *checkbox_Par6;
	TChart *Chart3;
	TLineSeries *Series4;
	TLineSeries *Series2;
	TChart *Chart2;
	TLineSeries *LineSeries1;
	TLineSeries *LineSeries2;
	TCheckBox *cb_Zeros;
	TButton *button_Zeros;
	TCheckBox *CheckBox1;
	TLabel *label_MeanValue_c;
	TLabel *label_MeanValue;
	TLabel *label_PeakPeak_c;
	TLabel *label_PeakPeak;
	void __fastcall cbScaleFactorClick(TObject *Sender);
	void __fastcall cbIndexClick(TObject *Sender);
	void __fastcall cbCorrectionClick(TObject *Sender);
	void __fastcall FormShow(TObject *Sender);
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
	void __fastcall checkbox_Par1Click(TObject *Sender);
	void __fastcall bCalculateClick(TObject *Sender);
	void __fastcall Chart1AfterDraw(TObject *Sender);
	void __fastcall Chart1BeforeDrawSeries(TObject *Sender);
	void __fastcall Chart1Exit(TObject *Sender);
	void __fastcall Chart1MouseMove(TObject *Sender, TShiftState Shift, int X,
          int Y);
	void __fastcall bStopClick(TObject *Sender);
	void __fastcall cbCorrectedParamCloseUp(TObject *Sender);
	void __fastcall ChartAfterDraw(TObject *Sender);
	void __fastcall button_MNKClick(TObject *Sender);
	void __fastcall button_ZerosClick(TObject *Sender);
	void __fastcall cb_ZerosClick(TObject *Sender);
private:	// User declarations
     float   RegCoefZeros[100];
     float   RegCoef[100];

	 int    LogMouseX, LogMouseY;
	 bool   isAllanCalculateSucces;

	 double BiasInstability;
	 double RandomWalk;

	 int    BaseIndex_RandomWalk;
	 double BaseValue_RandomWalk;

	int    BeginPoint;
	int    EndPoint;
    double ScaleFactor, SummationCount1, SummationCount2;
    int    BeginCalcIndex, EndCalcIndex;

    bool   isGlobalBreak;
    bool   isMouseOnTheAllan;

    TComboBox *ComboBox_array[7];
    TCheckBox *CheckBox_array[6];

    bool __fastcall CheckEditedData();
    void __fastcall ChartClear();
    void __fastcall CoefficientCorrectionOut();
    void __fastcall Get_BeginEndIntervals(int *bIndex, int *eIndex);
    void  __fastcall CalculateRegressionTermoCorection( CCollection<float> *base,
                                                        CCollection<float> **cor, int ParamCount,
                                                        CCollection<float> *c1,
                                                        CCollection<float> *c2 );
    float __fastcall BICalcBySCO( int SummationCount, bool isCalcMean, CCollection<float> *InArray, TProgressBar *pb );
    void  __fastcall AlanCalc_Draw(CCollection<float> *aAlanData);
    void __fastcall  DrawLogTicks(TChartAxis *BaseAxis, TChartAxis *noBaseAxis, bool isFirstAxisVertical); 

public:		// User declarations
	__fastcall Tform_AllanCalculate(TComponent* Owner);
};
//===========================================================================
extern PACKAGE Tform_AllanCalculate *form_AllanCalculate;
//===========================================================================
#endif
