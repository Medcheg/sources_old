//---------------------------------------------------------------------------

#ifndef Unit_BaseDialog_DSTFiltersH
#define Unit_BaseDialog_DSTFiltersH
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include "Unit_BaseDialog.h"
//---------------------------------------------------------------------------
class TfrmBaseDialog_DSTFilters : public TfrmBaseDialog
{
__published:	// IDE-managed Components
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TEdit *eRo;
        TEdit *eGamma;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TEdit *eN;
        TLabel *Label6;
        TEdit *eN1;
        TLabel *Label7;
        TEdit *eN2;
        TBevel *Bevel1;
        void __fastcall bbOkClick(TObject *Sender);
        void __fastcall RadioButton1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TfrmBaseDialog_DSTFilters(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBaseDialog_DSTFilters *frmBaseDialog_DSTFilters;
//---------------------------------------------------------------------------
#endif
