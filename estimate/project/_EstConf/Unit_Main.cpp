//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"

#include "Unit_About.h"
#include "Unit_BigTree.h"
#include "mpiSaveDSTParam.h"
#include "mpiErrors_and_Warning.h"
#include "mpiLibrary.h"
#include "mpiGuardant.h"

//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmMain *frmMain;

int iCounter = 0;
//===========================================================================
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
       ApplicationName = ExtractFileName(Application->ExeName).SetLength(ExtractFileName(Application->ExeName).Length() - 4);

  // -----
       if (CheckSerialNumber1()) {
          ppppppTemp->Visible = true;
          Button1->Visible    = true;
          Button2->Visible    = true;
       }
  // -----
       SecureTimer->Enabled = true;
}

//===========================================================================
void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
  // ----------
     SaveDTSParam();
  // ----------
     //DecimalSeparator = '.';
  // ----------
     GlobalElementCounter        = 0;
     GlobalMaterialCounter       = 0;
     GlobalMashineCounter        = 0;

     GlobalEnergoCounter         = 0;
     GlobalElementID             = 0;

     ControlKeyDown                = false;
     isProjectModified             = false;
     fLastFocusedControl           = NULL;
     BufferElementList             = NULL;
     BufferElementList_Items_Count = 0;
  // ----------
     tbData2->Caption  = Type_Str[0];
     /*tbData11->Caption = Type_Str[0];
     tbData12->Caption = Type_Str[1];*/

  // ----------
     StatusBar1->Panels->Items[0]->Text = " TimeLoad = " + Load_Base (ExtractFilePath(Application->ExeName) + "Estimate.dat", tvMainTree, tvMaterial, tvMashine, tvEnergo);
  // ----------
     Application->OnMessage = WM_Control;
  // ----------
     Enable_Disable_ElementBlock(false);
     Enable_Disable_DataBlock(false);
     Set_Action_Enabled();
  // ----------
     Caption = Application->Title;
}

//===========================================================================
void __fastcall TfrmMain::FormDestroy(TObject *Sender)
{
  if (MaterialListID  != NULL) free(MaterialListID);
  if (RashodnikListID != NULL) free(RashodnikListID);
  if (MashineListID   != NULL) free(MashineListID);
  if (EnergoListID    != NULL) free(EnergoListID);
  if (ServiseListID   != NULL) free(ServiseListID);
/*
    tvMaterial->Items->Clear();
    tvMashine ->Items->Clear();
    tvEnergo  ->Items->Clear();

    tvMainTree->Items->Clear();

    if (BufferElementList != NULL) free (BufferElementList);*/
//    KeyBaseDelete();
}

//===========================================================================
void __fastcall TfrmMain::FormCloseQuery(TObject *Sender, bool &CanClose)
{
  CanClose = false;

  if (isProjectModified) {
      int Result = MessageBox(Handle ,"��������� ��������� � ���� ?", "EstConf", MB_YESNOCANCEL|MB_ICONQUESTION|MB_TASKMODAL);
      if (Result == IDYES) { aAllActions(aSaveBase); Close(); }
      if (Result == IDNO) CanClose = true;

  } else CanClose = true;

  if (CanClose) {
        tvMaterial->Items->Clear();
        tvMashine ->Items->Clear();
        tvEnergo  ->Items->Clear();

        tvMainTree->Items->Clear();

        if (BufferElementList != NULL) free (BufferElementList);
  }
}

//===========================================================================
void __fastcall TfrmMain::FormShow(TObject *Sender)
{
    tbMainMenu->Width = 0;
    ToolBar3  ->Width = 0;
    for (int i = 0; i < tbMainMenu->ButtonCount; i++ ) tbMainMenu->Width += tbMainMenu->Buttons[i]->Width;
    for (int i = 0; i < ToolBar1->ButtonCount  ; i++ ) ToolBar1->Width   += ToolBar1->  Buttons[i]->Width;
    for (int i = 0; i < ToolBar3->ButtonCount  ; i++ ) if (ToolBar3->Buttons[i]->Visible) ToolBar3->Width   += ToolBar3->  Buttons[i]->Width;

//    ToolBar2->SetFocus();

  // ----- �������� ������ �������� � �������� ----
    tvMashine ->Selected = tvMashine ->Items->Item[0];
    tvEnergo  ->Selected = tvEnergo  ->Items->Item[0];
    tvMaterial->Selected = tvMaterial->Items->Item[0];
    tvMainTree->Selected = tvMainTree->Items->Item[0];
}

//===========================================================================
void __fastcall TfrmMain::FormActivate(TObject *Sender)
{
    //DecimalSeparator = '.';
}

//===========================================================================
void __fastcall TfrmMain::WM_Control(tagMSG & Msg, bool & Handled)
{
    if (Msg.message == WM_KEYDOWN) if (Msg.wParam == VK_CONTROL) { ControlKeyDown = true ; Handled = true; }
    if (Msg.message == WM_KEYUP  ) if (Msg.wParam == VK_CONTROL) { ControlKeyDown = false; Handled = true; }
    if (Msg.message == WM_SYSKEYUP) {
         if (LOWORD(Msg.lParam) == 1) {
            if (!tbMainMenu->Focused()){
                fLastFocusedControl = this->ActiveControl;
                tbMainMenu->SetFocus();
                tbMainMenu->TrackMenu(NULL);
            } else {
                this->FocusControl(fLastFocusedControl);
            }
            Handled = true;
         }
    }
}

//===========================================================================
void __fastcall TfrmMain::tvDragOver(TObject *Sender, TObject *Source, int X, int Y, TDragState State, bool &Accept)
{
   Accept = false; if (Source->ClassNameIs("TTreeView") && ControlKeyDown) Accept = true;
}

//===========================================================================
void __fastcall TfrmMain::tvDeletion(TObject *Sender, TTreeNode *Node)
{
   free  ((TElement*)Node->Data);
}

//===========================================================================
void __fastcall TfrmMain::tvExit(TObject *Sender)
{
   Set_Action_Enabled();
}

//===========================================================================
void __fastcall TfrmMain::tvChange(TObject *Sender, TTreeNode *Node)
{
    if (Node == NULL) return;

  // --------
    Node->ImageIndex    = ((TElement*)Node->Data)->Type;
    Node->SelectedIndex = ((TElement*)Node->Data)->Type;
    Node->StateIndex    = ((TElement*)Node->Data)->Type;

  // --------
    TTreeView *atv = ((TTreeView*)Sender);

    tvMainTree->Selected = (Sender != tvMainTree) ? NULL : Node;
    tvMaterial->Selected = (Sender != tvMaterial) ? NULL : Node;
    tvMashine ->Selected = (Sender != tvMashine ) ? NULL : Node;
    tvEnergo  ->Selected = (Sender != tvEnergo  ) ? NULL : Node;

    SelectedNode  = Node;
    atv->Selected = Node;
    atv->SetFocus();
  // --------

   if (atv->Name == "tvMainTree") Set_Element_Param(); else Set_Data_Param();

  // --------
    Show_ID((TElement*)Node->Data);
  // --------
}

//===========================================================================
void __fastcall TfrmMain::aAllActions(TObject *Sender)
{
  switch (((TControl*)Sender)->Tag) {
     // ------- ���� ���� -------
        case 10  : Save_Base(ptEstConf, ExtractFilePath(Application->ExeName) + "Estimate.dat", tvMainTree, tvMaterial, tvMashine, tvEnergo); MessageBox(Handle, " ���� ��������� ", " ���������� ...", MB_ICONINFORMATION); isProjectModified = false; break;
        case 11  : OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName); if (OpenDialog1->Execute()) LoadOldBaseMaterial(OpenDialog1->FileName, tvMaterial);  break;
        case 13  : OpenDialog1->InitialDir = ExtractFilePath(Application->ExeName); if (OpenDialog1->Execute()) LoadOldBaseWork(OpenDialog1->FileName, tvMainTree);  break;
        case 12  : Close();  break;

     // ------- ���� ������ -------
        case 21  : MessageBox(Handle, " ��� ���� ����� �����\n\n'������� ... ����� ����'", " ���������� ...", MB_ICONINFORMATION); break;
        case 22  : frmAbout->ShowModal(); break;

     // ------- ������������� ����� ��������� ������ � ���������� -------

        case 30  : tvMaterial->BringToFront(); tbData2->Caption = Type_Str[0]; SelectedNode = NULL; tvMaterial->Selected = NULL; tvMashine->Selected = NULL; tvEnergo->Selected = NULL; Enable_Disable_DataBlock(false); break;
        case 31  : tvMashine ->BringToFront(); tbData2->Caption = Type_Str[2]; SelectedNode = NULL; tvMaterial->Selected = NULL; tvMashine->Selected = NULL; tvEnergo->Selected = NULL; Enable_Disable_DataBlock(false); break;
        case 32  : tvEnergo  ->BringToFront(); tbData2->Caption = Type_Str[3]; SelectedNode = NULL; tvMaterial->Selected = NULL; tvMashine->Selected = NULL; tvEnergo->Selected = NULL; Enable_Disable_DataBlock(false); break;

     // ------- ������� ������� -------
        /*case 500 : eChangeMaterialProperty(tbMaterial2); break; // Ctrl+M
        case 501 :  if (tvMainTree ->Selected != NULL) eChangeElementProperty(tbWork1); break; // Ctrl+W
        case 502 :  if (tvMainTree ->Selected != NULL) eChangeElementProperty(tbElement1); if (tvMaterial->Selected != NULL) eChangeMaterialProperty(tbElement2); break; // Ctrl+E*/
        case 503 :  Execute_Copy_Action();          break; // Ctrl+C
        case 504 :  Execute_Paste_Action();         break; // Ctrl+V
        case 505 :  Execute_Trash_Action();         break; // Ctrl+X
        case 506 :  Execute_Find_Action();          break; // Ctrl+F
        case 507 :  Execute_Replace_Action();       break; // Ctrl+R
        case 508 :  Execute_AddElement_Action(508); break; //
        case 509 :  Execute_AddElement_Action(509); break; //
        case 510 :  Execute_BigTree_Action();       break; //
  }
}

//===========================================================================
void __fastcall TfrmMain::tvDragDrop(TObject *Sender, TObject *Source, // Source -> Sender
      int X, int Y)
{
     TTreeView  *tv1      = (TTreeView*)Source;
     TTreeView  *tv2      = (TTreeView*)Sender;
     TTreeNodes *aItems1  = tv1->Items;
     TTreeNodes *aItems2  = tv2->Items;
     TTreeNode  *CurNode1 = tv1->Selected;         if (CurNode1 == NULL) return;
     TTreeNode  *CurNode2 = tv2->GetNodeAt(X, Y);  if (CurNode2 == NULL) return;
     TTreeNode  *Node     = NULL;

       // ------------ ������ ���� � ����� ������ ������ ------
          int BeginIndex    = CurNode1->AbsoluteIndex;
          int NewBeginIndex = CurNode2->AbsoluteIndex;
       // ------------
          int EndIndex     = -1;
          for (int i = BeginIndex + 1; i < aItems1->Count; i++){
             if (aItems1->Item[i]->Level == CurNode1->Level) break;
             if (aItems1->Item[i]->Level >  CurNode1->Level) EndIndex = i;
          }
       // -----
          EndIndex = (EndIndex < BeginIndex) ? BeginIndex : EndIndex;
       // ----- �������� �� �������� --------
          if (tv1->Name == tv2->Name) if (NewBeginIndex > BeginIndex && NewBeginIndex < EndIndex) {MessageBox(Handle, " ���������� ����� '���� � ����' �� �����������", " ������ ...", MB_ICONWARNING); return;}
       // --------- �������� ������ ��� ����������� ����� --------
          TElement *ElementList = (TElement*) malloc (sizeof(TElement)*(EndIndex - BeginIndex + 1));
       // --------- ���������� ��������� ����� ������� --------
          for (int i = BeginIndex; i <= EndIndex; i++) ElementList[i - BeginIndex] = (*((TElement*)aItems1->Item[i]->Data));
                                  

        // -------- ��������� ������ ---------
          int OldLevel = -11l;
          aItems2->BeginUpdate();
        // --------------
          for (int i = BeginIndex; i <= EndIndex; i++){
             TElement  *Element = (TElement*) malloc (sizeof(TElement)); *Element = ElementList[i - BeginIndex];

             if (ElementList[i - BeginIndex].Level == OldLevel ) Node = Node->Parent;
             if (ElementList[i - BeginIndex].Level < OldLevel  ) for (int k = OldLevel; k >= ElementList[i - BeginIndex].Level; k--) Node = Node->Parent;


             if (i == BeginIndex){
                  if (Element->Type != etMaterial) Node = aItems2->InsertObject  (CurNode2, Element->Name, Element);
                                              else Node = aItems2->AddChildObject(CurNode2, Element->Name, Element);
                  tv2->Selected = Node;
             }
             else Node = aItems2->AddChildObject(Node,Element->Name, Element);

             Node->ImageIndex = Element->Type;
             Node->StateIndex = Element->Type;

             OldLevel       = Element->Level;
             Element->Level = Node->Level;
             Element->ParentId = (Node->Parent != NULL) ? ((TElement*) Node->Parent->Data)->Id : -1;

             if (tv1->Name != tv2->Name && tv1->Name != "tvElement")
                  Element->Id = ++GlobalElementCounter;
          }
          if (tv1->Name == tv2->Name) CurNode1->Delete();
          aItems2->EndUpdate();
          free (ElementList);
       // ------------
    ControlKeyDown = false;
}

//===========================================================================
void TfrmMain::Set_Data_Param()
{
    if (tvMaterial->Selected == NULL && tvMashine->Selected == NULL && tvEnergo->Selected == NULL) return;
  // ----------
    Enable_Disable_ElementBlock(false);
    Enable_Disable_DataBlock(true);

  // ----------
    TElement *Element = (TElement*)SelectedNode->Data;

    eName2           ->Text = Element->Name;
    eDimension2      ->Text = Element->Data.Dimension;
    eCatalogNumber2  ->Text = Element->Data.CatalogNumber;
    eParent2         ->Text = Element->Data.Parent;
    eNomenklatNumber2->Text = Element->Data.NomenklatNumber;
    ePriceMaterial   ->Text = FloatToStr(Element->Data.Price);
    eScaleFactorMaterial->Text = FloatToStr(Element->Data.ScaleFactorMaterial);

  // ----------

    if (Element->Type == etElement) { Panel2->Visible = false; tbElement2->Down = true; }
    if (Element->Type != etElement) { Panel2->Visible = true;  tbData2   ->Down = true; }

    Set_Action_Enabled();
}

//===========================================================================
void __fastcall TfrmMain::Change_Data_Property(TObject *Sender)
{
  if (SelectedNode       == NULL) return;
  if (SelectedNode->Data == NULL) return;

  TElement *Element = (TElement*)SelectedNode->Data;

  switch (((TControl*) Sender)->Tag) {
      case 1000 : Element->Type = etElement;  tbElement2 ->Down = true; Panel2->Visible = false;  break;
      case 1001 : if (tvMaterial->Selected != NULL) Element->Type = etMaterial;
                  if (tvMashine ->Selected != NULL) Element->Type = etMashine;
                  if (tvEnergo  ->Selected != NULL) Element->Type = etEnergo;
                  tbData2->Down = true;
                  Panel2->Visible  = true; break;

      case 1010 : Element->Name                 = eName2 ->Text;           break;
      case 1011 : Element->Data.Price           = StrToFloat(ePriceMaterial->Text); break;
      case 1012 : Element->Data.Dimension       = eDimension2->Text;       break;
      case 1013 : Element->Data.CatalogNumber   = eCatalogNumber2->Text;   break;
      case 1014 : Element->Data.Parent          = eParent2->Text;          break;
      case 1015 : Element->Data.NomenklatNumber = eNomenklatNumber2->Text; break;
      case 1016 : Element->Data.ScaleFactorMaterial = StrToFloat(eScaleFactorMaterial->Text); break;

  }

    SelectedNode->ImageIndex    = Element->Type;
    SelectedNode->SelectedIndex = Element->Type;
    SelectedNode->StateIndex    = Element->Type;
    SelectedNode->Text          = Element->Name;
  // ----------
    isProjectModified = true;
}

//==========================================================================
void TfrmMain::Set_Element_Param()
{
    if (SelectedNode         == NULL) return;
    if (tvMainTree->Selected == NULL) return;

  // ----------
    Enable_Disable_ElementBlock(true);
    Enable_Disable_DataBlock(false);


  // ----------
    TElement *el = (TElement*)SelectedNode->Data;

 // -------
    cbExcelEnable->Checked = el->ShowInExcel;

 // -------
    for (int i = 0; i < ToolBar3->ButtonCount; i++ ) {
       ToolBar3->Buttons[i]->Enabled = true;
       ToolBar3->Buttons[i]->Visible = false;
       ToolBar3->Buttons[i]->Down    = false;
    }

    //tbData12->Visible = false;
    Panel1  ->Visible = false;
    if (el->Type == etElement  ) {tbElement1  ->Visible = true; tbWork1 ->Visible = true; tbWork2    ->Visible = true; tbElement1 ->Down = true; }
    if (el->Type == etWork     ) {tbElement1  ->Visible = true; tbWork1 ->Visible = true; tbWork2    ->Visible = true; tbWork1    ->Down = true; Panel1->Visible = true;} //
    if (el->Type == etServise  ) {tbElement1  ->Visible = true; tbWork1 ->Visible = true; tbWork2    ->Visible = true; tbWork2    ->Down = true; Panel1->Visible = true;} //
    if (el->Type == etMaterial ) {tbData11    ->Visible = true; tbData12->Visible = true; tbData11   ->Down = true; } // cbExcelEnable->Checked = true; cbExcelEnable->Enabled = false;
    if (el->Type == etRashodnik) {tbData11    ->Visible = true; tbData12->Visible = true; tbData12   ->Down = true; } // cbExcelEnable->Checked = true; cbExcelEnable->Enabled = false;
    if (el->Type == etMashine  ) {ToolButton18->Visible = true; ToolButton18->Down = true; } // cbExcelEnable->Checked = true; cbExcelEnable->Enabled = false;
    if (el->Type == etEnergo   ) {ToolButton19->Visible = true; ToolButton19->Down = true; } // cbExcelEnable->Checked = true; cbExcelEnable->Enabled = false;

    ToolBar3->Width = 0;
    for (int i = 0; i < ToolBar3->ButtonCount; i++ ) if (ToolBar3->Buttons[i]->Visible) ToolBar3->Width   += ToolBar3->  Buttons[i]->Width;

 // -------
    if (el->Type == etElement || el->Type == etWork || el->Type == etWork || el->Type == etServise) pWork->BringToFront();
      else pMaterial1->BringToFront();
    eWorkPrice->Text = FloatToStr(el->Data.Price);
    eName1->Text         = el->Name;
    eWorkDimension->Text = el->Data.Dimension;

 // -------


    lMaterialName->Caption      = el->Name;
    lMaterialName->Hint         = el->Name;
    lMaterialPrice->Caption     = el->Data.Price;
    lMaterialDimension->Caption = el->Data.Dimension;
    lParent->Caption            = el->Data.Parent;
    lCatalogNumber->Caption     = el->Data.CatalogNumber;
    lNomenklatNumber->Caption   = el->Data.NomenklatNumber;
    lUEM_UER2->Caption          = el->Data.ScaleFactorMaterial;
    eCoefRashod->Text           = FloatToStr(el->Data.CoefRashod);
    cbBlockParamCountUEPOD->Checked = el->Data.BlockParamCountUEPOD;
    cbCompareRoomHeight   ->Checked = el->Data.CompareRoomHeight;

 // -------
    Set_Action_Enabled();
}

//===========================================================================
void __fastcall TfrmMain::Change_Element_Property(TObject *Sender)
{
  if (SelectedNode       == NULL) return;
  if (SelectedNode->Data == NULL) return;

  TElement *el = (TElement*)SelectedNode->Data;

  switch (((TControl*) Sender)->Tag) {
      case 4000 : el->Type = etElement;  Panel1->Visible = false; break;
      case 4001 : el->Type = etWork;     Panel1->Visible = true; break;
      case 4013 : el->Type = etServise;  Panel1->Visible = true; break;
      case 4002 : el->Type = etMaterial;  break;
      case 4003 : el->Type = etRashodnik; break;
      case 4014 : el->Type = etMashine;   break;
      case 4015 : el->Type = etEnergo;    break;

      case 4004 : el->ShowInExcel = cbExcelEnable->Checked;  break;

      case 4005 : el->Name = eName1->Text; SelectedNode->Text = el->Name; break;

      case 4006 : el->Type = etWork;    break;
      case 4007 : el->Type = etServise; break;

      case 4008 : el->Data.Price = StrToFloat(eWorkPrice->Text); break;
      case 4009 : el->Data.Dimension = eWorkDimension->Text; break;

      case 4010 : el->Data.BlockParamCountUEPOD = cbBlockParamCountUEPOD->Checked; break;
      case 4011 : el->Data.CompareRoomHeight = cbCompareRoomHeight->Checked; break;
      case 4012 : el->Data.CoefRashod = StrToFloat(eCoefRashod->Text ); break;
  }

    SelectedNode->ImageIndex    = el->Type;
    SelectedNode->SelectedIndex = el->Type;
    SelectedNode->StateIndex    = el->Type;
  // ----------
    isProjectModified = true;
}

//===========================================================================
void TfrmMain::Show_ID(TElement *el)
{
     Label30->Caption = "Id           = " + IntToStr(el->Id);
     Label31->Caption = "ParentId = "     + IntToStr(el->ParentId);
     Label32->Caption = "Level      = "   + IntToStr(el->Level);
     Label11->Caption = "GlobalId = "   + IntToStr(el->GlobalElementId);
}

//===========================================================================
void TfrmMain::Enable_Disable_DataBlock(bool flag)
{
     tbElement2       -> Enabled = flag;
     tbData2          -> Enabled = flag;
     Label14          -> Enabled = flag;
     ToolBar4         -> Enabled = flag;
     pMaterial2       -> Enabled = flag;
     Label15          -> Enabled = flag;
     Panel2           -> Enabled = flag;
     Label17          -> Enabled = flag;
     Label18          -> Enabled = flag;
     Label19          -> Enabled = flag;
     Label20          -> Enabled = flag;
     Label25          -> Enabled = flag;
     Label40          -> Enabled = flag;
     eDimension2      -> Enabled = flag;
     eCatalogNumber2  -> Enabled = flag;
     eNomenklatNumber2-> Enabled = flag;
     ePriceMaterial   -> Enabled = flag;
     eParent2           -> Enabled = flag;
     eScaleFactorMaterial-> Enabled = flag;
     eName2             -> Enabled = flag;
}

void TfrmMain::Enable_Disable_ElementBlock(bool flag)
{
     Label6                -> Enabled = flag;
     ToolBar3              -> Enabled = flag;
     tbElement1            -> Enabled = flag;
     tbWork1               -> Enabled = flag;
     tbWork2               -> Enabled = flag;
     tbData11              -> Enabled = flag;
     tbData12              -> Enabled = flag;

     cbExcelEnable         -> Enabled = flag;

     pWork                 -> Enabled = flag;
     Label8                -> Enabled = flag;
     eName1                -> Enabled = flag;
     Panel1                -> Enabled = flag;
     Label4                -> Enabled = flag;
     Label9                -> Enabled = flag;
     eWorkDimension        -> Enabled = flag;
//!!!!!!!!!     efWorkPrice           -> Enabled = flag;

     pMaterial1            -> Enabled = flag;
     Label10               -> Enabled = flag;
     Label12               -> Enabled = flag;
     Label13               -> Enabled = flag;
     Label21               -> Enabled = flag;
     Label22               -> Enabled = flag;
     Label23               -> Enabled = flag;
     lMaterialName         -> Enabled = flag;
     lMaterialPrice        -> Enabled = flag;
     lMaterialDimension    -> Enabled = flag;
     lCatalogNumber        -> Enabled = flag;
     lNomenklatNumber      -> Enabled = flag;
     Label24               -> Enabled = flag;
     lParent               -> Enabled = flag;
     eCoefRashod           -> Enabled = flag;
     cbBlockParamCountUEPOD-> Enabled = flag;
     cbCompareRoomHeight   -> Enabled = flag;
     lUEM_UER2             -> Enabled = flag;
     Label7                -> Enabled = flag;

}

//===========================================================================
void TfrmMain::Set_Action_Enabled()
{
   bool flag1  = (tvMainTree->Focused()) ? true : false;
   bool flag2  = (tvMaterial->Focused()) ? true : false;
   bool flag3  = (tvMashine ->Focused()) ? true : false;
   bool flag4  = (tvEnergo  ->Focused()) ? true : false;
   bool flag10 = (flag1 || flag2 || flag3 || flag4) ? true : false;

   aAddElement   ->Enabled = flag10;
   aAddSubElement->Enabled = flag10;
   aBigTree      ->Enabled = flag10;
   aCut          ->Enabled = flag10;
/////////////////////
   aCopy         ->Enabled = flag10;
   aPaste        ->Enabled = flag10;
/////////////////////

   if (flag1 && tvMainTree ->Items->Count == 0) {
     aAddSubElement->Enabled = false;
     aBigTree      ->Enabled = false;
     aCut          ->Enabled = false;
   };
   if (flag2 && tvMaterial->Items->Count == 0) {
     aAddSubElement->Enabled = false;
     aBigTree      ->Enabled = false;
     aCut          ->Enabled = false;
   };
   if (flag3 && tvMashine->Items->Count == 0) {
     aAddSubElement->Enabled = false;
     aBigTree      ->Enabled = false;
     aCut          ->Enabled = false;
   };
   if (flag4 && tvEnergo->Items->Count == 0) {
     aAddSubElement->Enabled = false;
     aBigTree      ->Enabled = false;
     aCut          ->Enabled = false;
   };
   if (flag1 && tvMainTree->Selected == NULL) aCut ->Enabled = false;
   if (flag2 && tvMaterial->Selected == NULL) aCut ->Enabled = false;
   if (flag3 && tvMashine ->Selected == NULL) aCut ->Enabled = false;
   if (flag4 && tvEnergo  ->Selected == NULL) aCut ->Enabled = false;
}

//---------------------------------------------------------------------------

void TfrmMain::Execute_Trash_Action()
{

    TTreeView *aTreeView = (TTreeView*)SelectedNode->TreeView;
    if (aTreeView->Selected != NULL && aTreeView->Items->Count > 0) {
         int fIndex = aTreeView->Selected->AbsoluteIndex;

         // --------
           CopyNode(aTreeView);
         // --------

         aTreeView->Items->BeginUpdate();
         aTreeView->Items->Delete(aTreeView->Selected);
         aTreeView->Items->EndUpdate();

         if (fIndex >= aTreeView->Items->Count) fIndex = aTreeView->Items->Count - 1;
         if (fIndex >= 0 ) aTreeView->Selected = aTreeView->Items->Item[fIndex];
         if (fIndex == -1) {
               SelectedNode = NULL;
               if (aTreeView->Name == "tvMainTree" ) Enable_Disable_ElementBlock(false);
               if (aTreeView->Name != "tvMainTree" ) Enable_Disable_DataBlock   (false);
               Set_Action_Enabled();
         }
    }
}

//===========================================================================
void TfrmMain::Execute_Copy_Action()
{
   if (tvMainTree->Focused()) CopyNode(tvMainTree);
   if (tvMaterial->Focused()) CopyNode(tvMaterial);
   if (tvMashine ->Focused()) CopyNode(tvMashine);
   if (tvEnergo  ->Focused()) CopyNode(tvEnergo);
}

//===========================================================================
void TfrmMain::Execute_Paste_Action()
{
   TTreeView *aTreeView;
   if (tvMainTree->Focused()) PasteNode(ptEstConf, tvMainTree, GlobalElementCounter);
   if (tvMaterial->Focused()) PasteNode(ptEstConf, tvMaterial, GlobalMaterialCounter);
   if (tvMashine ->Focused()) PasteNode(ptEstConf, tvMashine , GlobalMashineCounter);
   if (tvEnergo  ->Focused()) PasteNode(ptEstConf, tvEnergo  , GlobalEnergoCounter);
}

//===========================================================================
void TfrmMain::Execute_Find_Action()
{
}

//===========================================================================
void TfrmMain::Execute_Replace_Action()
{
}

//===========================================================================
void TfrmMain::Execute_AddElement_Action(int aTag)
{
     TTreeView  *aTreeView = NULL;
     int         Counter;

     ++GlobalElementID;

     if (tvMainTree->Focused()) {aTreeView = tvMainTree; Counter = ++GlobalElementCounter; }
     if (tvMaterial->Focused()) {aTreeView = tvMaterial; Counter = ++GlobalMaterialCounter;}
     if (tvMashine ->Focused()) {aTreeView = tvMashine;  Counter = ++GlobalMashineCounter; }
     if (tvEnergo  ->Focused()) {aTreeView = tvEnergo;   Counter = ++GlobalEnergoCounter; }



   // -------
     TElement   *Element;

   // -------
     Element = (TElement*) malloc (sizeof(TElement));
     Element->Init();
     Element->Id = Counter;
     Element->GlobalElementId = GlobalElementID;
   // -------- ��������� �������� -------
     if (SelectedNode == NULL) {
            Element->ParentId = -1;
            Element->Level    = 0;
     } else {
            if (aTag == 508) {
               Element->ParentId = ((TElement*)SelectedNode->Data)->ParentId;
               Element->Level    = SelectedNode->Level;
            } else {                
               Element->ParentId = ((TElement*)SelectedNode->Data)->Id;
               Element->Level    = SelectedNode->Level + 1;
            }
     }

     if (aTag == 508 && SelectedNode != NULL)
          aTreeView->Selected = aTreeView->Items->InsertObject(SelectedNode, Element->Name, Element);
     else aTreeView->Selected = aTreeView->Items->AddChildObject(SelectedNode, Element->Name, Element);
   // -------
     aTreeView->OnChange(aTreeView, aTreeView->Selected);
}

//===========================================================================
void TfrmMain::Execute_BigTree_Action()
{
   TTreeView *aTreeView;
   if (tvMainTree->Focused()) aTreeView = tvMainTree;
   if (tvMaterial->Focused()) aTreeView = tvMaterial;
   if (tvMashine ->Focused()) aTreeView = tvMashine;
   if (tvEnergo  ->Focused()) aTreeView = tvEnergo;

        frmBigTree->ParentTreeView = aTreeView;
        frmBigTree->tvElement->Items->BeginUpdate();
        frmBigTree->tvElement->Items->Assign(aTreeView->Items);
        frmBigTree->tvElement->Items->EndUpdate();
        frmBigTree->ShowModal();
}

//===========================================================================

void __fastcall TfrmMain::tvMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
  TTreeView *tv = (TTreeView*)Sender;

  if (Button == mbLeft ) {SelectedNode = NULL; tv->OnChange(tv, tv->Selected);}
  if (Button == mbRight) {

       if (tv->Items->Count == 0) aAddElement->Enabled = true;
       tv->Selected   = tv->GetNodeAt(X, Y);

       TPoint  aPoint = tv->ClientToScreen(Point(X, Y));
       pmEdit->Popup(aPoint.x,aPoint.y);
  }
}
//===========================================================================

void __fastcall TfrmMain::Label30Click(TObject *Sender)
{
  // ---------- �������� �� ���������� �� ������ --------------
  for (int i = 0; i < tvMainTree->Items->Count; i++) {
     if (((TElement*)tvMainTree->Items->Item[i]->Data)->Level != tvMainTree->Items->Item[i]->Level){
         Beep();
         tvMainTree->Selected = tvMainTree->Items->Item[i];
         ShowMessage("Ploho");
         return;

     }
  }
 // -----------------------------
  for (int i = 0; i < tvMaterial->Items->Count; i++) {
     if (((TElement*)tvMaterial->Items->Item[i]->Data)->Level != tvMaterial->Items->Item[i]->Level){
         Beep();
         tvMaterial->Selected = tvMaterial->Items->Item[i];
         ShowMessage("Ploho");
         return;
     }
  }
 // -----------------------------
  for (int i = 0; i < tvMashine->Items->Count; i++) {
     if (((TElement*)tvMashine->Items->Item[i]->Data)->Level != tvMashine->Items->Item[i]->Level){
         Beep();
         tvMashine->Selected = tvMashine->Items->Item[i];
         ShowMessage("Ploho");
         return;
     }
  }
 // -----------------------------
  for (int i = 0; i < tvEnergo->Items->Count; i++) {
     if (((TElement*)tvEnergo->Items->Item[i]->Data)->Level != tvEnergo->Items->Item[i]->Level){
         Beep();
         tvEnergo->Selected = tvEnergo->Items->Item[i];
         ShowMessage("Ploho");
         return;
     }
  }
  ShowMessage("Everything right");
}
//---------------------------------------------------------------------------


//---------------------------------------------------------------------------


void __fastcall TfrmMain::Button2Click(TObject *Sender)
{
     GlobalElementID = 0;

  // ----- �������� �������� ������ ------
     for (int k = 0; k < tvMainTree->Items->Count; k++) 
         ((TElement*)tvMainTree->Items->Item[k]->Data)->GlobalElementId = -999;

  // ----- �������� ---------
     for (int i = 0; i < tvMaterial->Items->Count; i ++) {
             TElement *Element = (TElement*)tvMaterial->Items->Item[i]->Data;

             Element->GlobalElementId = ++GlobalElementID;

             for (int k = 0; k < tvMainTree->Items->Count; k++) {
                 TElement *ElementMT = (TElement*)tvMainTree->Items->Item[k]->Data;
                 if (AnsiString(ElementMT->Name) == AnsiString(Element->Name))
                     ElementMT->GlobalElementId = Element->GlobalElementId;
             }
     }
  // -------------- ������ � ��������� ------------
     for (int i = 0; i < tvMashine->Items->Count; i ++) {
             TElement *Element = (TElement*)tvMashine->Items->Item[i]->Data;

             Element->GlobalElementId = ++GlobalElementID;

             for (int k = 0; k < tvMainTree->Items->Count; k++) {
                 TElement *ElementMT = (TElement*)tvMainTree->Items->Item[k]->Data;
                 if (AnsiString(ElementMT->Name) == AnsiString(Element->Name))
                     ElementMT->GlobalElementId = Element->GlobalElementId;
             }
     }

  // ----- ������ ������� ------------
     for (int i = 0; i < tvEnergo->Items->Count; i ++) {
             TElement *Element = (TElement*)tvEnergo->Items->Item[i]->Data;

             Element->GlobalElementId = ++GlobalElementID;

             for (int k = 0; k < tvMainTree->Items->Count; k++) {
                 TElement *ElementMT = (TElement*)tvMainTree->Items->Item[k]->Data;
                 if (AnsiString(ElementMT->Name) == AnsiString(Element->Name))
                     ElementMT->GlobalElementId = Element->GlobalElementId;
             }
     }
  // --------- ���������� �� � ���������� ������ ---------
     for (int k = 0; k < tvMainTree->Items->Count; k++) {
         TElement *Element = (TElement*)tvMainTree->Items->Item[k]->Data;
         if (Element->GlobalElementId == -999) {
            Element->GlobalElementId = ++GlobalElementID;
         }
     }
     ShowMessage("����������� �����������");
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::SecureTimerTimer(TObject *Sender)
{
     if (!SecureKeyPressent  && !CheckSerialNumber1()) {
                SecureTimer->Enabled = false;
                MessageBox(Handle, "�� ������������ ������ ��������� ... . \n\n �� �������� ������������ �������� ����������� ������ info@dst.com.ua", "Estimate - ������ ��������", MB_APPLMODAL|MB_OK|MB_ICONWARNING);
                ExitProcess(0);
     }
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::Button1Click(TObject *Sender)
{
  // ----- �������� ---------
     for (int i = 0; i < tvMaterial->Items->Count; i ++) {
             TElement *Element = (TElement*)tvMaterial->Items->Item[i]->Data;

             if (Element->Type != etElement && Element->Type != etWork) {
                if (Element->GlobalElementId == -999) {
                    ShowMessage(" " + Element->Name + "' �� = -999" );
                }
             }
     }
  // -------------- ������ � ��������� ------------
     ShowMessage("�������� �����������");
}
//---------------------------------------------------------------------------

