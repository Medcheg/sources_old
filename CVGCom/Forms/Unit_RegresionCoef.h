//---------------------------------------------------------------------------

#ifndef Unit_RegresionCoefH
#define Unit_RegresionCoefH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Chart.hpp"
#include "Series.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmRegressionCoef : public TForm
{
__published:	// IDE-managed Components
	TLabel *Label1;
	TMemo *Memo1;
	TLabel *Label2;
	TMemo *Memo2;
	TLabel *lRegressionOrder;
	TEdit *eRegressionOrder;
	TUpDown *udRegressionOrder;
	TLabel *Label3;
	TMemo *Memo3;
	TChart *Chart1;
	TLineSeries *Series1;
	TPointSeries *Series2;
	TLabel *Label4;
	TButton *Button1;
	TEdit *Edit1;
	TLabel *Label5;
	TEdit *Edit2;
	TLabel *Label6;
	TLabel *Label7;
	TEdit *Edit3;
	TLabel *Label8;
	TEdit *Edit4;
	TEdit *Edit5;
	TLabel *Label9;
	TEdit *Edit6;
	TLabel *Label10;
	TLabel *Label11;
	TEdit *Edit7;
	TLabel *Label12;
	TLabel *Label13;
    TComboBox *ComboBox1;
    TLabel *Label14;
	void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
    float *fx, *fy, *mnkCoef;

    int    PolinomLevel;
    int    ValuesCount;
    int    XParamCount;
public:		// User declarations
	__fastcall TfrmRegressionCoef(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmRegressionCoef *frmRegressionCoef;
//---------------------------------------------------------------------------
#endif
