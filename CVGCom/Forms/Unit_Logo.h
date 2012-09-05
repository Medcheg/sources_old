//---------------------------------------------------------------------------

#ifndef Unit_LogoH
#define Unit_LogoH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <jpeg.hpp>
//---------------------------------------------------------------------------
class TfrmLogo : public TForm
{
__published:	// IDE-managed Components
	TImage *Image1;
	TTimer *Timer1;
    TLabel *Label1;
    TLabel *Label2;
	void __fastcall tt(TObject *Sender);
	void __fastcall Timer1Timer(TObject *Sender);
private:	// User declarations
public:		// User declarations
	__fastcall TfrmLogo(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmLogo *frmLogo;
//---------------------------------------------------------------------------
#endif
