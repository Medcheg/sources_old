//---------------------------------------------------------------------------

#ifndef Unit_AchFchParamH
#define Unit_AchFchParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "CSPIN.h"
#include <Buttons.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "cdiroutl.h"
#include <Grids.hpp>
#include <Outline.hpp>
//---------------------------------------------------------------------------
#include "Unit_AchFch.h"
#include "FloatEdit.h"
//---------------------------------------------------------------------------
class TfrmAchFchParam : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TBevel *Bevel2;
        TLabel *Label9;
        TLabel *Label10;
        TLabel *Label11;
        TBevel *Bevel1;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TCheckBox *CheckBox2;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TCheckBox *CheckBox4;
        TCheckBox *CheckBox5;
        TPanel *Panel1;
        TPanel *Panel2;
        TPaintBox *PaintBox2;
        TPanel *Panel4;
        TPanel *Panel3;
        TPaintBox *PaintBox1;
        TPanel *Panel5;
        TColorDialog *ColorDialog1;
        TPopupMenu *PopupMenu1;
        TMenuItem *fg1;
        TMenuItem *N1;
        TMenuItem *N4;
        TMenuItem *N2;
        TMenuItem *N3;
        TPopupMenu *PopupMenu2;
        TMenuItem *MenuItem1;
        TMenuItem *MenuItem2;
        TMenuItem *MenuItem3;
        TMenuItem *MenuItem4;
        TMenuItem *MenuItem5;
        TImageList *ImageList1;
        TCSpinEdit *CSpinEdit1;
        TCSpinEdit *CSpinEdit2;
        TCheckBox *CheckBox1;
        TFloatEdit *FloatEdit1;
        TFloatEdit *FloatEdit2;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall PaintBox1Paint(TObject *Sender);
        void __fastcall PaintBox2Paint(TObject *Sender);
        void __fastcall Panel1Click(TObject *Sender);
        void __fastcall Panel5Click(TObject *Sender);
        void __fastcall Panel4Click(TObject *Sender);
        void __fastcall CSpinEdit1Change(TObject *Sender);
        void __fastcall CSpinEdit2Change(TObject *Sender);
        void __fastcall PaintBox1Click(TObject *Sender);
        void __fastcall PaintBox2Click(TObject *Sender);
        void __fastcall fg1Click(TObject *Sender);
        void __fastcall MenuItem1Click(TObject *Sender);
private:	// User declarations
        TfrmAchFch *ParentForm;
public:		// User declarations
        __fastcall TfrmAchFchParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmAchFchParam *frmAchFchParam;
//---------------------------------------------------------------------------
#endif
