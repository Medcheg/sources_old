//---------------------------------------------------------------------------

#ifndef Unit_AlanCalculateExternH
#define Unit_AlanCalculateExternH
//---------------------------------------------------------------------------
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
//---------------------------------------------------------------------------
#include "mpi_rep_Collection.h"
//---------------------------------------------------------------------------
class TfrmAllanCalculateExtern : public TForm
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
	TPanel *Panel4;
	TLabel *Label3;
	TLabel *Label4;
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
	TPanel *Panel3;
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
	TChart *Chart3;
	TLineSeries *Series4;
	TLineSeries *Series2;
	TChart *Chart2;
	TLineSeries *LineSeries1;
	TLineSeries *LineSeries2;
	TChart *Chart1;
	TLineSeries *Series1;
	TMemo *Memo1;
	TEdit *Edit1;
	TEdit *Edit2;
	TEdit *Edit3;
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

    TComboBox *ComboBox_array[5];
    TCheckBox *CheckBox_array[4];

    bool __fastcall CheckEditedData();
    void __fastcall ChartClear();
    void __fastcall CoefficientCorrectionOut();
    void __fastcall Get_BeginEndIntervals(int *bIndex, int *eIndex);
    void  __fastcall CalculateRegressionTermoCorection( CStorageItem *base, CStorageItem **cor, int ParamCount, CStorageItem *c1, CStorageItem *c2 );
    float __fastcall BICalcBySCO( int SummationCount, bool isCalcMean, CStorageItem *InArray, TProgressBar *pb );
    void  __fastcall AlanCalc_Draw(CCollection<float> *aAlanData);
    void __fastcall DrawLogTicks(TChartAxis *BaseAxis, TChartAxis *noBaseAxis, bool isFirstAxisVertical); 

public:		// User declarations
	__fastcall TfrmAllanCalculateExtern(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmAllanCalculateExtern *frmAllanCalculateExtern;
//---------------------------------------------------------------------------
#endif
