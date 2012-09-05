//---------------------------------------------------------------------------

#ifndef dlg__OutPutStandartH
#define dlg__OutPutStandartH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "CSPIN.h"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
#include "Unit_BaseDialog.h"
//---------------------------------------------------------------------------
class TdlgOutPutStandart : public TfrmBaseDialog
{
__published:	// IDE-managed Components
        TBevel *Bevel2;
        TBevel *Bevel1;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label11;
        TListBox *ListBox1;
        TEdit *eGraphName;
        TEdit *eMax;
        TEdit *eMin;
        TPanel *Panel3;
        TPaintBox *PaintBox1;
        TCSpinEdit *CSpinEdit2;
        TColorBox *ColorBox1;
        TCheckBox *CheckBox1;
        TEdit *Edit3;
        TUpDown *CSpinEdit1;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall ListBox1Click(TObject *Sender);
        void __fastcall CSpinEdit2Change(TObject *Sender);
        void __fastcall eGraphNameChange(TObject *Sender);
        void __fastcall ColorBox1Change(TObject *Sender);
        void __fastcall CSpinEdit1Change(TObject *Sender);
        void __fastcall bbOkClick(TObject *Sender);
        void __fastcall CSpinEdit1Click(TObject *Sender,
          TUDBtnType Button);
private:	// User declarations
        void *Cur_mpi_Series;
        void  SetUpListBox();
public:		// User declarations
        long double *pMinY, *pMaxY;
        __fastcall TdlgOutPutStandart(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TdlgOutPutStandart *dlgOutPutStandart;
//---------------------------------------------------------------------------
#endif
