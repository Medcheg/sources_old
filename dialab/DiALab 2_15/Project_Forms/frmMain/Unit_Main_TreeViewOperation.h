//===========================================================================
void TfrmMain::SetupTreeView()
{
    if (TreeNodeList == NULL) {
        TreeView1->Items->Clear();
        return;
    }
 // --------
    TreeView1->Items->BeginUpdate();
    TreeView1->Items->Clear();
 // ---- �� ������ ����� ���������� ������ ������ ��������� Nodu ---------
    for (int i = 0; i < TreeNodeList->Count; i++){
         TTreeNodeElement *tnElement = ((TTreeNodeElement*)TreeNodeList->Items[i]);

         // -------- ��� �������� - ���� ���� ���� ������ ������� � ������� ����� ---
           bool FoundParent = false;
           for  (int z = 0; z < TreeView1->Items->Count; z++) {
               if (TreeView1->Items->Item[z]->Text == tnElement->ParentNodeText) {
                   FoundParent = true;
                   break;
               }
           }

         // -------- ��������� ������� ������� -----
          //if (tnElement->ParentNodeText == "NULL") {
           if (!FoundParent) {
                //TTreeNode *tn = TreeView1->Items->AddObject(NULL, tnElement->NodeText, tnElement->NodeElementList);
                TTreeNode *tn = TreeView1->Items->AddObject(NULL, tnElement->ParentNodeText, NULL);
                tn->ImageIndex    = 0;
                tn->StateIndex    = 0;
                tn->SelectedIndex = 0;
           }

         // -------- ���� �� ������� �������, �� ��� �� �������� �������� � ��� ��� ��� ������ ������� ----
           if (tnElement->ParentNodeText != "NULL") {
              for (int k = 0; k < TreeView1->Items->Count; k++){
                   TTreeNode *tn = TreeView1->Items->Item[k];
                   if (tn->Text == tnElement->ParentNodeText) {
                        tn = TreeView1->Items->AddChildObject(tn, tnElement->NodeText, tnElement->NodeElementList);
                        tn->ImageIndex    = 1;
                        tn->StateIndex    = 1;
                        tn->SelectedIndex = 1;

                        tn->Parent->ImageIndex    = 0;
                        tn->Parent->StateIndex    = 0;
                        tn->Parent->SelectedIndex = 0;
                       break;
                   }
              }
           }
    }
 // ----
    TreeView1->Items->EndUpdate();

 // ---- ���� ������ ��� �������� ������� ����� ������ ------
    if (TreeView1->Items->Count > 1) {
        TreeView1->Selected = TreeView1->Items->Item[1];
        //TreeView1->Selected = TreeView1->Items->Item[0];
    }
    EnabledTVModivication = true;
}

//===========================================================================
void __fastcall TfrmMain::TreeView1MouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
       TTreeNode *Node = TreeView1->GetNodeAt(X, Y);
       if (Node == NULL) return;

      // ----- ���� ���� ������ ��������� � ����� ������, �� ��������� �� �����.��� ������� ������ ----
          if (ListBox1->Items->Count == 0 && EnabledTVModivication) {
             if (Node->AbsoluteIndex < TreeView1->Items->Count - 1) {
                TTreeNode *atn = TreeView1->Items->Item[Node->AbsoluteIndex + 1];
                atn->Selected = true;
             }
          }
       // -----
         EnabledTVModivication = true;
}

//===========================================================================
void __fastcall TfrmMain::TreeView1Collapsing(TObject *Sender,
      TTreeNode *Node, bool &AllowCollapse)
{
  EnabledTVModivication = false;
}


