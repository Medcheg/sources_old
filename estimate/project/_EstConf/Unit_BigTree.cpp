//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit_BigTree.h"
#include "Unit_Main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmBigTree *frmBigTree;
//---------------------------------------------------------------------------
__fastcall TfrmBigTree::TfrmBigTree(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TfrmBigTree::FormShow(TObject *Sender)
{
  Width  = 500;
  Height = Screen->Height - 60;
  tvElement->OnDeletion = tvElementDeletion;
}
//---------------------------------------------------------------------------
void __fastcall TfrmBigTree::FormClose(TObject *Sender,
      TCloseAction &Action)
{
     ParentTreeView->Items->BeginUpdate();
     ParentTreeView->OnDeletion = NULL;
     ParentTreeView->Items->Assign(tvElement->Items);
     ParentTreeView->OnDeletion = frmMain->tvDeletion;
     ParentTreeView->Items->EndUpdate();

     tvElement->Items->BeginUpdate();
     tvElement->OnDeletion = NULL;
     tvElement->Items->Clear();
     tvElement->Items->EndUpdate();
}
//---------------------------------------------------------------------------
void __fastcall TfrmBigTree::tvElementDragOver(TObject *Sender,
      TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   frmMain->tvDragOver(Sender, Source,X,Y, State, Accept);
}
//---------------------------------------------------------------------------
void __fastcall TfrmBigTree::tvElementDragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
   tvElement->Items->BeginUpdate();
   frmMain->tvDragDrop(Sender, Source,X,Y);
   tvElement->Items->EndUpdate();
}
//---------------------------------------------------------------------------
void __fastcall TfrmBigTree::tvElementDeletion(TObject *Sender,
      TTreeNode *Node)
{
  frmMain->tvDeletion(Sender, Node);
}
//---------------------------------------------------------------------------

void __fastcall TfrmBigTree::tvElementChanging(TObject *Sender,
      TTreeNode *Node, bool &AllowChange)
{
   if (Node == NULL) return;

   Node->ImageIndex    = ((TElement*)Node->Data)->Type;
   Node->SelectedIndex = ((TElement*)Node->Data)->Type;
   Node->StateIndex    = ((TElement*)Node->Data)->Type;
}
//---------------------------------------------------------------------------

