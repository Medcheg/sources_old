//---------------------------------------------------------------------------

#ifndef Unit_Result_1_ReportH
#define Unit_Result_1_ReportH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class Tform_Result_1_Report : public TForm
{
__published:	// IDE-managed Components
	TMemo *Memo1;
private:	// User declarations
public:		// User declarations
	__fastcall Tform_Result_1_Report(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Result_1_Report *form_Result_1_Report;
//---------------------------------------------------------------------------
#endif
