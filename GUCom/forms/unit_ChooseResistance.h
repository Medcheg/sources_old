//---------------------------------------------------------------------------

#ifndef unit_ChooseResistanceH
#define unit_ChooseResistanceH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
//---------------------------------------------------------------------------
class Tform_ChooseResistance : public TForm
{
__published:	// IDE-managed Components
    TImage *Image1;
    TButton *Button1;
    TEdit *edit_R2;
    TLabel *Label1;
    TLabel *Label2;
    TEdit *edit_R3;
    TLabel *Label4;
    TEdit *edit_SFo;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TLabel *Label8;
    TLabel *Label10;
    TLabel *Label11;
    TEdit *edit_SF;
    TLabel *Label3;
    TLabel *Label9;
    TEdit *edit_R4;
    void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall Tform_ChooseResistance(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_ChooseResistance *form_ChooseResistance;
//---------------------------------------------------------------------------
#endif
