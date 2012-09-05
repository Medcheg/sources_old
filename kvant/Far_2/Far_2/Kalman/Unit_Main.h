//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "FloatEdit.h"
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TChart *Chart1;
        TLabel *Label1;
        TLabel *Label2;
        TFloatEdit *FloatEdit1;
        TFloatEdit *FloatEdit2;
        TButton *Button1;
        TLabel *Label7;
        TLabel *Label8;
        TFloatEdit *FloatEdit3;
        TFloatEdit *FloatEdit4;
        TLineSeries *Series1;
        TLineSeries *Series2;
        TLineSeries *Series3;
        TCheckBox *CheckBox1;
        TCheckBox *CheckBox2;
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall Chart1AfterDraw(TObject *Sender);
private:	// User declarations
        float max, min, oldMax, oldMin;
        bool  EnabledResize;
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
