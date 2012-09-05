//---------------------------------------------------------------------------

#ifndef Unit_ProjectParamH
#define Unit_ProjectParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include "IntEdit.h"
#include "FloatEdit.h"
#include "CGRID.h"
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
class TfrmProjectParam : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label5;
        TLabel *Label6;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TBevel *Bevel3;
        TFloatEdit *feTimerRefreshFreq;
        TColorDialog *ColorDialog1;
        TGroupBox *GroupBox1;
        TLabel *Label1;
        TPanel *Panel1;
        TLabel *Label2;
        TPanel *Panel2;
        TLabel *Label3;
        TPanel *Panel3;
        TLabel *Label4;
        TPanel *Panel4;
        TGroupBox *GroupBox2;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label10;
        TPanel *Panel5;
        TPanel *Panel6;
        TPanel *Panel7;
        TPanel *Panel8;
        TButton *Button1;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall Panel1Click(TObject *Sender);
        void __fastcall Panel2Click(TObject *Sender);
        void __fastcall Panel3Click(TObject *Sender);
        void __fastcall Panel4Click(TObject *Sender);
        void __fastcall Panel5Click(TObject *Sender);
        void __fastcall Panel6Click(TObject *Sender);
        void __fastcall Panel7Click(TObject *Sender);
        void __fastcall Panel8Click(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
private:
        bool CheckInputValues();	// User declarations
public:		// User declarations
        __fastcall TfrmProjectParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmProjectParam *frmProjectParam;
//---------------------------------------------------------------------------
#endif
