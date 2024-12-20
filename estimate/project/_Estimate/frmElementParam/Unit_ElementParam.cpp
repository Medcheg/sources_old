//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_ElementParam.h"
#include "Unit_Main.h"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmElementParam *frmElementParam;

//---------------------------------------------------------------------------
__fastcall TfrmElementParam::TfrmElementParam(TComponent* Owner)
        : TForm(Owner)
{
}

//---------------------------------------------------------------------------
void __fastcall TfrmElementParam::mpiShowModal( TTreeNode *aNode  )
{
   // --------------------------
      SetWindowParam( aNode );
   // --------------------------
      //if (Element->Type == etElement) return;
   // --------------------------
      ShowModal();
   // --------------------------
}

void TfrmElementParam::SetWindowParam( TTreeNode *aNode )
{
   // --------------------------
      for (int i = 10; i < 10; i ++) {
      }
   // --------------------------

      fNode   = aNode;
      frmMain->tv2->Selected = fNode;
      Element = (TElement*)aNode->Data;
   // --------------------------
      TTreeNode   *TempNode   = aNode;
      AnsiString   TempString;
      AnsiString   OutString;
      Label7->Caption = TempNode->Text;

      while (TempNode->Parent != NULL) {
         TempNode = TempNode->Parent;
         OutString  = "- " + TempNode->Text + " -\n" + TempString;
         TempString = OutString;
      }

      OutString.SetLength(OutString.Length() - 1);
  // ----------
      Label1->AutoSize = false;
      Label1->Width    = 800;
      Label1->Height   = 500;
      Label1->Caption  = OutString;
      Label1->AutoSize = true;

   // --------  ������ ------------------
      int MaxWidth = (Label1->Width > Label7->Width) ? Label1->Width : Label7->Width + 7;
      ClientWidth = (2*Label1->Left + MaxWidth < 300) ? 300 : 2*Label1->Left + MaxWidth;

      BitBtn2->Left = ClientWidth - BitBtn1->Left - BitBtn2->Width;
      Panel2->Left = ClientWidth - Panel2->Width - Edit1->Left;

      Edit1->Width   = Panel2->Left - 2*Edit1->Left;
      Edit2->Width   = ClientWidth - 2 * Edit2->Left;
      Edit3->Width   = ClientWidth - 2 * Edit3->Left;

   // -------  ��� �������  -------------------
      Label1  ->Top = Label2->BoundsRect.Bottom + 6;
      Label7  ->Top = Label1->BoundsRect.Bottom + 2;
      //Label3  ->Top = Label7->BoundsRect.Bottom + 6;
      //Label4  ->Top = Label3->Top;
      Label5  ->Top = Label7->BoundsRect.Bottom + 6;
      Edit1   ->Top = Label5->BoundsRect.Bottom + 6;
      Panel2->Top = Edit1 ->Top - (Panel2->Height - Edit1->Height) / 2;



   // -----------------------------------------------
      if ( Element->Type == etElement ) {
           ToolButton1->Enabled = true;

           Label5->Enabled      = true;
           Edit1 ->Enabled      = true;

           Label6->Enabled      = false;
           Edit2 ->Enabled      = false;

           Label8->Enabled      = false;
           Edit3 ->Enabled       = false;
      } else {
           ToolButton1->Enabled = true;

           Label5->Enabled      = true;
           Edit1->Enabled       = true;

           Label6->Enabled      = true;
           Edit2->Enabled       = true;

           Label8->Enabled      = Element->Data.CompareRoomHeight;
           Edit3 ->Enabled      = Element->Data.CompareRoomHeight;
      }

    // -----------------
      Label6  ->Visible = Element->Type == etWork;
      Edit2   ->Visible = Element->Type == etWork;

      Label8  ->Visible = Element->Data.CompareRoomHeight;
      Edit3   ->Visible = Element->Data.CompareRoomHeight;

    // -----------------
        int bbTop = Edit1 ->BoundsRect.Bottom + 6;

    // -----------------
        if ( Element->Type == etWork ) {
            Label6  ->Top = Edit1 ->BoundsRect.Bottom + 6;
            Edit2   ->Top = Label6->BoundsRect.Bottom + 6;
            bbTop = Edit2 ->BoundsRect.Bottom + 6;
        }

    // -----------------
        if ( Element->Data.CompareRoomHeight ) {
            Label8  ->Top = Edit1 ->BoundsRect.Bottom + 6;
            Edit3   ->Top = Label8->BoundsRect.Bottom + 6;
            bbTop = Edit3->BoundsRect.Bottom + 6;
        }

    // -----------------
        BitBtn1 ->Top = bbTop;
        BitBtn2 ->Top = bbTop;

      //ToolBar2->Top = BitBtn1->Top - (BitBtn1->Height - ToolBar2->Height) / 2;

   // --------------------------
      ClientHeight  = BitBtn2->BoundsRect.Bottom + 6;
   // --------------------------

      Label3->Caption = ElementType_Str[ Element->Type ];
   // --------------------------

      if (frmMain->tv2->Items->Count == 1) {
          tbNext->Enabled = false;
          tbPrev->Enabled = false;
      }
   // --------�������� ���� �����  -------------------

      ToolButton1->Down    = false;
      ToolButton1->Enabled = false;
      tbNext->Enabled      = true;
      tbPrev->Enabled      = true;

      if ( fNode->HasChildren /*&& Element->Type != etElement */     ) ToolButton1->Enabled = true;
      if ( fNode->AbsoluteIndex == 0                             ) tbPrev->Enabled = false;
      if ( fNode->AbsoluteIndex == frmMain->tv2->Items->Count - 1) tbNext->Enabled = false;

   // -------- ��������� ���������� ����� -------------------
      Edit1->Text = FloatToStr(Element->CountUEPOD);
      Edit2->Text = FloatToStr(Element->Complexity);
      Edit3->Text = FloatToStr(Element->Data.RoomHeight);
}

//---------------------------------------------------------------------------
void __fastcall TfrmElementParam::tbNextPrevClick(TObject *Sender)
{
    int aTag = ((TComponent*)Sender)->Tag;
    if ( aTag > 0 && !tbNext->Enabled) return;
    if ( aTag < 0 && !tbPrev->Enabled) return;

  // ------------------ �������� ����� -----------
     double TempValue1, TempValue2, TempValue3;
     try {
         TempValue1 = StrToFloat(Edit1->Text);
         TempValue2 = StrToFloat(Edit2->Text);
         TempValue3 = StrToFloat(Edit3->Text);
     } catch ( ... ) {
         return;
     }
     Element->CountUEPOD      = TempValue1;
     Element->Complexity      = TempValue2;
     Element->Data.RoomHeight = TempValue3;

  // ------------------ ���� ���� ���������� �� ���� ������ ����� ����� ��������  -----------
     if ( ToolButton1->Down ) {
           //int        CurLevel     = fNode->Level;
           int        aIndex       = fNode->AbsoluteIndex + 1;
           TTreeNode *TempNode     = frmMain->tv2->Items->Item[aIndex];

           while (TempNode->Level > fNode->Level) {
               TElement *el = (TElement*)TempNode->Data;

               el->CountUEPOD = Element->CountUEPOD;

               if (aIndex == frmMain->tv2->Items->Count - 1) break;
               TempNode   = frmMain->tv2->Items->Item[++aIndex];
           }
     }

  // ------- ���� ��� ����� ����� -----------
    if (aTag == 100) {
       frmMain->UpdateMemos();
       Close();
       return; // ---- ����� �� ---
    }

  // ----------------------------------------
    int Index = fNode->AbsoluteIndex + aTag;
    SetWindowParam( frmMain->tv2->Items->Item[Index] );
}

//---------------------------------------------------------------------------

void __fastcall TfrmElementParam::BitBtn1Click(TObject *Sender)
{
//
}
//---------------------------------------------------------------------------


