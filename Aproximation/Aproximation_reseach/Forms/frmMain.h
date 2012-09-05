//---------------------------------------------------------------------------

#ifndef frmMainH
#define frmMainH
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
#define TWO_PI 6.283185307179586476925286766559



typedef struct tag_Zn
{
    double x, x_old;
    double delta_x_r;
    double fTacks;

    double Period;
    bool  isNewPeriodPresent;
} TZn;

typedef struct tag_PeriodDetector1
{
    double x, x_old;
    double delta_x_r;
    double fTacks;

    double Period;
    bool  isNewPeriodPresent;
} TPeriodDetector1;

typedef struct tag_PeriodDetector2
{
    double x, x_old;
    double delta_x_r;
    double fTacks;

    double x1, x2;

    double Period;
    bool  isNewPeriodPresent;
} TPeriodDetector2;


typedef struct tag_gyro
{
    double inX;

    TPeriodDetector1 pd1;
    TPeriodDetector2 pd2;

    double ANodeBuffer[1024];
} TGyro;



//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TButton *Button1;
    TGroupBox *GroupBox1;
    TLabel *Label1;
    TLabel *Label3;
    TEdit *label_AlgoFreq;
    TEdit *label_AlgoCalcTime;
    TGroupBox *GroupBox2;
    TLabel *Label4;
    TLabel *Label2;
    TEdit *edit_ANodeAmpl;
    TEdit *edit_ResonatorFreq;
    TGroupBox *GroupBox3;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TLabel *Label8;
    TLabel *Label9;
    TLabel *Label10;
    TEdit *edit_ACPNoise;
    TEdit *edit_sin_a1;
    TEdit *edit_sin_a2;
    TEdit *edit_sin_a3;
    TEdit *edit_sin_f1;
    TEdit *edit_sin_f2;
    TEdit *edit_sin_f3;
    TCheckBox *CheckBox1;
    TChart *Chart1;
    TLineSeries *Series1;
    TChart *Chart2;
    TLineSeries *Series2;
    TLineSeries *Series3;
    TChart *Chart3;
    TLineSeries *Series4;
    TLineSeries *Series5;
    void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
	TGyro gyro;

    double  AlgoFreq;
    double  AlgoT0;
    double  AlgoCalcTime;

    double  ResonatorFreq;
    double  AntiNodeAmplitude;

    int    ACPNoise;
    double  sin_a1;
    double  sin_a2;
    double  sin_a3;
    double  sin_f1;
    double  sin_f2;
    double  sin_f3;

    void Run(double inAntinode);
public:		// User declarations
    __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
