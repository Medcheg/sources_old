void TfrmEditorManager::Action_DeleteElements_DeleteLinkFromSubSystem(TBaseClass *aSS, TBaseClass *aElement)
{
   for (int i = 0; i < ((TSubSystem*)aSS)->InputList->Count; i++)
      if (((TSubSystem*)aSS)->InputList->Items[i] == aElement) {
             for (int k = 0; k < LinkList_Count; k ++){
                    if (LinkList[k] != NULL ) {
                         if (((TSubSystem*)aSS)->iPoints->Items[i]->CurrentLink == LinkList[k]) {
                               LinkList[k]->SecondElement = NULL;
                         }
                     }
             }
             return;
      }
}

void TfrmEditorManager::Action_DeleteElements_CheckLinkToPressentElement(TBaseClass *aElement)
{
  // --------- ���� ��������� ������� �� �����, ������� ������������� �����, �������������� ---------
    for (int k = 0; k < LinkList_Count; k ++){
          if (LinkList[k] != NULL ) {
                 if (aElement == LinkList[k]->FirstElement )
                                 LinkList[k]->FirstElement  = NULL;
                 if (aElement == LinkList[k]->SecondElement)
                                 LinkList[k]->SecondElement = NULL;
          }
    }
}

//============================================================================================================
void TfrmEditorManager::Action_DeleteElements_CheckElementToPressentLink(TLink *aLink)
{
  // ------------- ���� ������������� �� ��� ��������� ������� �� ����������� ����� ��������� ���������� ������ (�������) ------

     // ----- ������������� �������� ������ ----------
        if (aLink->SecondElement != NULL) {
            ((TElement*)aLink->SecondElement)->iPoints->Items[aLink->NumberInput ]->Conected = false;
            ((TElement*)aLink->SecondElement)->NeedRedraw = true;
        }

     // ----- ������������� �������� ������� (�� ��� �������, ������-���, � ������ ������ ����� ���� ���� ������)----------
        if (aLink->FirstElement != NULL) {
              bool flag = false;

              for (int k = 0; k < LinkList_Count; k++) {

                 if (LinkList[k] != NULL)
                     // --- ���� � ������ ����� ������ ����� ������� ���� ��� ���������� � ������ , ����� ----
                     if (aLink->FirstElement == LinkList[k]->FirstElement &&
                         aLink != LinkList[k] &&
                         aLink->NumberOutput == LinkList[k]->NumberOutput) {

                        flag = true;
                        break;
                     }
              }
              ((TElement*)aLink->FirstElement)->oPoints->Items[aLink->NumberOutput]->Conected = flag;
              ((TElement*)aLink->FirstElement)->NeedRedraw = true;

        }
}

//============================================================================================================
void TfrmEditorManager::Action_DeleteElements_DeleteElement(TBaseClass *aElement)
{
  // ---------------
     if (aElement->ClassName != "TLink") {
         for (int k = 0; k < ElementList_Count; k ++)
                    if (ElementList[k] == aElement) {
                            // ---- ������ ������� �� ������ ������ ��������� -----
                               Action_DeleteElements_CheckLinkToPressentElement(ElementList[k]);

                            // ---- ���� ������� ���� ��� ����� ���������� , �� ����� ���������� ������(�������) ��������� ----
                               if (ElementList[k]->ClassName == "TSubSystemIn" || ElementList[k]->ClassName == "TSubSystemOut"){
                                  TSubSystem *ss = (TSubSystem*)FindElementByID(ElementList[k]->ParentId);
                                  if (ss != NULL){ // --- ���� ���������� ��� �������� �� ������� �� ----------
                                       if (ElementList[k]->ClassName == "TSubSystemIn" ) {
                                          int aNumberInputSS = ((TSubSystemIn*)ElementList[k])->InputIndex - 1;
                                          if (ss->iPoints->Items[aNumberInputSS]->CurrentLink != NULL)
                                              ((TLink*)ss->iPoints->Items[aNumberInputSS]->CurrentLink)->SecondElement = NULL;

                                          // --- ������� �����, ������� ����������� ����� ����������, � �� � �������� �������� ���� �������� - �������� �� ������� -----------
                                             for (int z = 0; z < LinkList_Count; z ++)
                                                 if ( LinkList[z] != NULL)
                                                      if (LinkList[z]->SecondElement == ss && LinkList[z]->NumberInput > aNumberInputSS)
                                                         LinkList[z]->NumberInput = LinkList[z]->NumberInput - 1;

                                          ss->Delete_Input (ElementList[k]);
                                       }
                                     // --- � ��� ������� ���� ����� ��� ����� � ���������� �������� ----
                                       if (ElementList[k]->ClassName == "TSubSystemOut") {
                                          int aNumberOutPutSS = ((TSubSystemOut*)ElementList[k])->OutputIndex - 1;

                                          // --- ����� ---
                                          // --- ������� �����, ������� ����������� ����� ���������� � ���������� �������, � �������� �� ������ ������� --
                                             for (int z = 0; z < LinkList_Count; z ++)
                                                 if ( LinkList[z] != NULL)
                                                      if (LinkList[z]->FirstElement == ss && LinkList[z]->NumberOutput == aNumberOutPutSS)
                                                         LinkList[z]->FirstElement = NULL;
                                          // --- ������� �����, ������� ����������� ����� ����������, � �� � �������� ������������ ���� �������� - �������� �� ������� -----------
                                             for (int z = 0; z < LinkList_Count; z ++)
                                                 if ( LinkList[z] != NULL)
                                                      if (LinkList[z]->FirstElement == ss && LinkList[z]->NumberOutput > aNumberOutPutSS)
                                                         LinkList[z]->NumberOutput = LinkList[z]->NumberOutput - 1;

                                          ss->Delete_OutPut(ElementList[k]);
                                       }
                                       ss->NeedRedraw = true;
                                  }
                               }

                               ElementList[k] = NULL;
                               break;
                    }
         for (int k = 0; k < ElementList_Count; k ++)
               if (ElementList[k] != NULL)

                  // --- ���� ������� ���� ���������� -----------
                    if (ElementList[k]->ParentId == aElement->Id) {
                           // -------- ���������� �� ���������� �������� -------
                              Action_DeleteElements_DeleteElement(ElementList[k]);

                           // -------- ������ ��� ����� � ���������� ----
                              for (int z = 0; z < LinkList_Count; z ++)
                                   if (LinkList[z] != NULL)
                                       if (LinkList[z]->ParentId == aElement->Id){
                                            delete LinkList[z];
                                            LinkList[z] = NULL;
                                       }
                    }
     }
  // ---------------
     if (aElement->ClassName == "TLink") {
         for (int k = 0; k < LinkList_Count; k ++)
                 if (LinkList[k] == aElement) {
                         Action_DeleteElements_CheckElementToPressentLink(LinkList[k]);
                         LinkList[k] = NULL;
                         break;
                 }
     }
  // ---------------
      delete aElement;
}

//============================================================================================================
void TfrmEditorManager::PackList(TBaseClass **&aList, int &aCount)
{
     if (aCount == 0) return;

  // -------
     bool isAllNULL = false;

  // -------
     for (int k = 0; k < aCount; k++){

          while (aList[k] == NULL) {
               isAllNULL = true;
               for (int z = k; z < aCount - 1; z ++){
                 aList[z] = aList[z+1];
                 if (aList[z] != NULL) isAllNULL = false;
               }
               aList[aCount - 1] = NULL;
               if (isAllNULL) break;
          }
          if (isAllNULL) break;
     }

  // -------
     int CountDelete = 0;
     for (int k = 0; k < aCount; k++) if (aList[k] == NULL) CountDelete ++;

  // -------
     aCount -= CountDelete;
     aList  = (TBaseClass**) realloc (aList, sizeof(TBaseClass*) * aCount);
}
//============================================================================================================
void TfrmEditorManager::Action_DeleteElements()
{
      if (SelectedList_Count == 0) return;

   // ---- �������� �� ����������� �������� � SelectedList -------
      for (int i = 0; i < SelectedList_Count; i ++){
          Action_DeleteElements_DeleteElement(SelectedList[i]);
          SelectedList[i] = NULL;
     }

  // -----------
     SelectedList_Count = 0; free (SelectedList); SelectedList = NULL;

     PackList((TBaseClass**)ElementList, ElementList_Count);   // ----- ����������� ElementList ------
     PackList((TBaseClass**)LinkList   , LinkList_Count   );   // ----- ����������� LinkList ------

     aRotateElement->Enabled = false;
     aDeleteElement->Enabled = false;
     aFogElement   ->Enabled = false;
     aParamElement ->Enabled = false;

  // ---------  ������ �� ����� ---------------------------------------------------
  // ---- ������,  ��� �������� ���� ������� �������(���� ��� ����� ����������) ---
  // ---- ����� ����������� ������������ ���� (������� ���� ��� ��������) ---------
     for (int i = 0; i < ElementList_Count; i++){
        if (ElementList[i]->ClassName == "TSubSystem")
            ((TSubSystem*)ElementList[i])->EditorManager->Draw();
     }
  // ---------
   // Caption = "ElementCount = " + IntToStr(ElementList_Count - 1) + "  |  LinkCount = " + IntToStr(LinkList_Count);
  // ---------
     ProjectModified = true;
}
