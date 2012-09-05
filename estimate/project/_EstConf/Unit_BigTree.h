//---------------------------------------------------------------------------

#ifndef Unit_BigTreeH
#define Unit_BigTreeH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmBigTree : public TForm
{
__published:	// IDE-managed Components
        TTreeView *tvElement;
        void __fastcall tvElementDragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
        void __fastcall tvElementDragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
        void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall tvElementDeletion(TObject *Sender,
          TTreeNode *Node);
        void __fastcall tvElementChanging(TObject *Sender,
          TTreeNode *Node, bool &AllowChange);
private:	// User declarations
public:		// User declarations
        TTreeView *ParentTreeView;
        __fastcall TfrmBigTree(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBigTree *frmBigTree;
//---------------------------------------------------------------------------
#endif
