//---------------------------------------------------------------------------

#ifndef Unit_TableH
#define Unit_TableH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <Grids.hpp>
#include <ToolWin.hpp>
//---------------------------------------------------------------------------
class TfrmTable : public TForm
{
__published:	// IDE-managed Components
        TToolBar *ToolBar1;
        TToolButton *ToolButton1;
        TStringGrid *StringGrid1;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall ToolButton1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TfrmTable(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmTable *frmTable;
//---------------------------------------------------------------------------
#endif
