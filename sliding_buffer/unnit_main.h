//---------------------------------------------------------------------------

#ifndef unnit_mainH
#define unnit_mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
//---------------------------------------------------------------------------
class TForm6 : public TForm
{
__published:	// IDE-managed Components
	TListBox *ListBox1;
	TListBox *ListBox2;
	TListBox *ListBox3;
	TChart *Chart1;
	TLineSeries *Series1;
	TLineSeries *Series2;
	TLineSeries *Series3;
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TForm6(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm6 *Form6;
//---------------------------------------------------------------------------
#endif
