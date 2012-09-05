//---------------------------------------------------------------------------

#ifndef Unit_DrawPerehodProcessH
#define Unit_DrawPerehodProcessH
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
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TfrmDrawPerehodProcess : public TForm
{
__published:	// IDE-managed Components
        TChart *Chart1;
        TLineSeries *Series1;
        TLineSeries *Series2;
        TPanel *Panel1;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TLabel *Label1;
        TRadioButton *RadioButton3;
        TLabel *Label2;
        TRadioButton *RadioButton4;
        TLabel *Label3;
        TRadioButton *RadioButton5;
        TRadioButton *RadioButton6;
        TRadioButton *RadioButton7;
        TLineSeries *Series3;
        TLineSeries *Series4;
        TLineSeries *Series5;
        TLineSeries *Series6;
        TLineSeries *Series7;
        TLineSeries *Series8;
        TLineSeries *Series9;
        TLineSeries *Series10;
        TRadioButton *RadioButton8;
        TLineSeries *Series11;
        TLineSeries *Series12;
        TLineSeries *Series13;
        TLineSeries *Series14;
        TLineSeries *Series15;
        TLineSeries *Series16;
        TLineSeries *Series17;
        TLineSeries *Series18;
        TLineSeries *Series19;
        TLineSeries *Series20;
        TPanel *Panel2;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TRadioButton *RadioButton9;
        TRadioButton *RadioButton10;
        void __fastcall RadioButtonClick(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        void Init();
        __fastcall TfrmDrawPerehodProcess(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmDrawPerehodProcess *frmDrawPerehodProcess;
//---------------------------------------------------------------------------
#endif
