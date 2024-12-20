//---------------------------------------------------------------------------

#ifndef Unit_mainH
#define Unit_mainH
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
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TChart *Chart1;
    TLineSeries *Series1;
    TLineSeries *Series2;
    TPanel *Panel1;
    TUpDown *UpDown1;
    TEdit *Edit1;
    TEdit *Edit2;
    TUpDown *UpDown2;
    TLabel *Label1;
    TLabel *Label3;
    TPointSeries *Series3;
    TEdit *Edit3;
    TEdit *Edit4;
	TPointSeries *Series4;
    void __fastcall UpDown1Click(TObject *Sender, TUDBtnType Button);
    void __fastcall UpDown2Click(TObject *Sender, TUDBtnType Button);
private:	// User declarations
public:		// User declarations
    __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
