//---------------------------------------------------------------------------

#ifndef Unit_LogoEstimateH
#define Unit_LogoEstimateH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <jpeg.hpp>
//---------------------------------------------------------------------------
class TfrmLogoEstimate : public TForm
{
__published:	// IDE-managed Components
        TImage *Image1;
private:	// User declarations
public:		// User declarations
        __fastcall TfrmLogoEstimate(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmLogoEstimate *frmLogoEstimate;
//---------------------------------------------------------------------------
#endif
