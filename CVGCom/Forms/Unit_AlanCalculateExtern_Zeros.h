//---------------------------------------------------------------------------

#ifndef Unit_AlanCalculateExtern_ZerosH
#define Unit_AlanCalculateExtern_ZerosH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class Tfrm_AlanCalculateExtern_Zeros : public TForm
{
__published:	// IDE-managed Components
	TComboBox *cbPar2;
	TComboBox *cbPar1;
	TComboBox *cbPar3;
	TComboBox *cbPar4;
	TComboBox *cbPar6;
	TComboBox *cbPar5;
	TEdit *ePar1_Zero;
	TEdit *ePar2_Zero;
	TEdit *ePar4_Zero;
	TEdit *ePar3_Zero;
	TEdit *ePar5_Zero;
	TEdit *ePar6_Zero;
	TButton *Button1;
	TComboBox *cbCorrectedParam;
	TEdit *ePar0_Zero;
	TButton *Button2;
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
    TComboBox *ComboBox_array[7];
    TEdit     *EditBox_array[7];

	__fastcall Tfrm_AlanCalculateExtern_Zeros(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tfrm_AlanCalculateExtern_Zeros *frm_AlanCalculateExtern_Zeros;
//---------------------------------------------------------------------------
#endif
