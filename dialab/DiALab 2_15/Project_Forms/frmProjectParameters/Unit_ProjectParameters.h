//---------------------------------------------------------------------------
#ifndef Unit_ProjectParametersH
#define Unit_ProjectParametersH
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmProjectParameters : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TEdit *eEndCalcTime;
        TLabel *Label2;
        TLabel *Label3;
        TEdit *eAnalogT0;
        TLabel *Label4;
        TLabel *Label5;
        TCheckBox *CheckBox1;
        TLabel *Label6;
        TBevel *Bevel1;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TPanel *pNetColor;
        TPanel *pManagerColor;
        TColorDialog *ColorDialog1;
        TButton *bSetDefaultParam;
        TCheckBox *CheckBox2;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall pNetColorClick(TObject *Sender);
        void __fastcall pManagerColorClick(TObject *Sender);
        void __fastcall bSetDefaultParamClick(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall CheckBox1Click(TObject *Sender);
        void __fastcall CheckBox2Click(TObject *Sender);
private:	// User declarations
        void   SetGraphicParameters();
public:		// User declarations
        __fastcall TfrmProjectParameters(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmProjectParameters *frmProjectParameters;
//---------------------------------------------------------------------------
#endif
