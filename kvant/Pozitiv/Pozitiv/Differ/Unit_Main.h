//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TChart *Chart1;
        TLineSeries *Series1;
        TLineSeries *Series2;
        TLineSeries *Series3;
        TLineSeries *Series4;
        TLineSeries *Series5;
        TLabel *Label9;
        TLabel *Label11;
        TLabel *Label12;
        TLabel *Label13;
        TLabel *Label14;
        TLabel *Label15;
        TEdit *Edit5;
        TEdit *Edit6;
        TEdit *Edit7;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label10;
        TBitBtn *BitBtn1;
        TPanel *Panel2;
        TPanel *Panel3;
        TPanel *Panel4;
        TEdit *Edit3;
        TEdit *Edit4;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TCheckBox *CheckBox1;
        TCheckBox *CheckBox2;
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall CheckBox1Click(TObject *Sender);
        void __fastcall CheckBox2Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
