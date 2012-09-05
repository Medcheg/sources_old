//---------------------------------------------------------------------------

#ifndef Unit_SetupAngleNetH
#define Unit_SetupAngleNetH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------
//typedef


class TfrmSetupAngleNet : public TForm
{
__published:	// IDE-managed Components
        TListBox *ListBox1;
        TLabel *Label1;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TToolBar *ToolBar1;
        TToolButton *tbDeleteTick;
        TToolButton *tbAddTick;
        TPanel *Panel1;
        TLabel *Label2;
        TEdit *Edit1;
        TCheckBox *CheckBox1;
        TBitBtn *bbApply;
        TBitBtn *bbCancel;
        TLabel *Label3;
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall ListBox1Click(TObject *Sender);
        void __fastcall tbDeleteTickClick(TObject *Sender);
        void __fastcall bbCancelClick(TObject *Sender);
        void __fastcall bbApplyClick(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall tbAddTickClick(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall CheckBox1Click(TObject *Sender);
        void __fastcall Edit1KeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
        void __fastcall ListBox1KeyDown(TObject *Sender, WORD &Key,
          TShiftState Shift);
private:	// User declarations
        TAnglesTick   *CurAngleTick;
        void           AddAndSortItemsListBox();
        void           SetNewArrayAglesTick();
        void           EditedParam(bool flag);
public:		// User declarations
        __fastcall TfrmSetupAngleNet(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmSetupAngleNet *frmSetupAngleNet;
//---------------------------------------------------------------------------
#endif
