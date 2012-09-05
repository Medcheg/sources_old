//---------------------------------------------------------------------------

#ifndef unit_settingsH
#define unit_settingsH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class Tform_Settings : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label21;
    TEdit *edit_MaximumsCount;
        TLabel *Label16;
    TEdit *edit_CountIntrpolPoints;
    TBitBtn *BitBtn1;
    TLabel *Label19;
    TEdit *edit_DeltaFreq;
    TBevel *Bevel1;
    void __fastcall BitBtn1Click(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
private:	// User declarations
public:		// User declarations
    int MaxsCount;
    int InterpolationPointsCount;
    double DeltaFreq;
	__fastcall Tform_Settings(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Settings *form_Settings;
//---------------------------------------------------------------------------
#endif
