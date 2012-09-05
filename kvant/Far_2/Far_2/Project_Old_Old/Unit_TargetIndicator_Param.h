//===========================================================================

#ifndef Unit_TargetIndicator_ParamH
#define Unit_TargetIndicator_ParamH
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <CheckLst.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <Dialogs.hpp>
#include "FloatEdit.h"
//===========================================================================
typedef struct {
  AnsiString Name;
  bool       Drawing;
  TColor     Color;
} TSelectGraph;
//===========================================================================
class TfrmTargetIndicator_Param : public TForm
{
__published:	// IDE-managed Components
        TBitBtn *BitBtn1;
        TLabel *Label2;
        TPanel *Panel1;
        TColorDialog *ColorDialog1;
        TGroupBox *GroupBox1;
        TCheckListBox *CheckListBox1;
        TGroupBox *GroupBox2;
        TCheckListBox *CheckListBox2;
        TLabel *Label1;
        TPanel *Panel2;
        TLabel *Label3;
        TPanel *Panel4;
        TLabel *Label4;
        TPanel *Panel5;
        TLabel *Label5;
        TPanel *Panel3;
        TLabel *Label6;
        TFloatEdit *FloatEdit1;
        TLabel *Label7;
        TBevel *Bevel1;
        TBevel *Bevel2;
        TBitBtn *BitBtn2;
        TButton *Button1;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall CheckListBox1ClickCheck(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall CheckListBox1Click(TObject *Sender);
        void __fastcall Panel1Click(TObject *Sender);
        void __fastcall CheckListBox2Click(TObject *Sender);
        void __fastcall CheckListBox2ClickCheck(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall Panel2Click(TObject *Sender);
        void __fastcall Panel3Click(TObject *Sender);
        void __fastcall Panel4Click(TObject *Sender);
        void __fastcall Panel5Click(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TfrmTargetIndicator_Param(TComponent* Owner);
};
//===========================================================================
extern PACKAGE TfrmTargetIndicator_Param *frmTargetIndicator_Param;
extern TSelectGraph TargetIndicatorGraphics[8];
extern TSelectGraph UglomernyjIndicatorGraphics[4];
extern TColor TargetIndicatorFonColor;
extern TColor UglomernyjIndicatorFonColor;
extern TColor UglomernyjIndicatorLineColor;
extern TColor UglomernyjIndicatorFontColor;
extern TFloat UglomernyjIndicatorMaxOffset;

//===========================================================================
#endif
