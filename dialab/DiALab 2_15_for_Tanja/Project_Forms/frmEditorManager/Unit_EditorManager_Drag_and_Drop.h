//===========================================================================
int TfrmEditorManager::GetElementIndex(TBaseClass *aEl)
{
   // ---------- ������ ��������� �������� ������ ----
      TBaseClass **TempElementList = NULL;
      int          TempElementList_Count = 0;

   // ---------- ��������� ������ �������� ������ -----
      for (int i = 0; i < ElementList_Count; i++)
             if (typeid(*ElementList[i]) == typeid(*aEl)){
                 TempElementList = (TBaseClass **) realloc (TempElementList, sizeof(TBaseClass*) * (++TempElementList_Count));
                 TempElementList[TempElementList_Count - 1] = ElementList[i];
             }

   // ---------- ������ ������ ������������ �������� -----
      int IndexCounter = 1;
      bool Finding;

      while (true) {
            Finding = false;
            for (int i = 0; i < TempElementList_Count; i++)
               if (TempElementList[i]->Index == IndexCounter) Finding = true;
          // ----
            if (!Finding) break;
            IndexCounter ++;
      }
   // ----------
     free (TempElementList);
     return IndexCounter;
}

//===========================================================================
void __fastcall TfrmEditorManager::Image1DragDrop(TObject *Sender,
      TObject *Source, int X, int Y)
{
  // ---- ���� ������������ �� ������ � �� k���, ����� ����� -------
     if ((AnsiString)Source->ClassName() != "TListBox" || (AnsiString)Sender->ClassName() != "TPaintBox") return;

  // ---- ���� ���������� �������� List Boxa == -1 ����� ����� -----
     if (((TListBox *)Source)->ItemIndex == -1) return;

  // ---- ������� ������� ���������� ��������� --------------------
     Free_SelectedList();

  // ----
     TListBox    *lb  = (TListBox *)  Source;
     TElement    *el  = (TElement *)( lb->Items->Objects[lb->ItemIndex] );
     TScrollBar  *sbH = sbHorizontal;
     TScrollBar  *sbV = sbVertical;

  // ---- ���� �������� ��� �������� (�� ����� � �������� �� ����� ����) � ������ ��������� ����� ���� ����� -------
     if (el == NULL) return;


  // ---------- ����������� ������ ��������� � ������� �� ������� ---------
     ElementList  = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));
     FillElementGlobalParam (&ElementList[ElementList_Count - 1], el->ClassName, IdCurrentSubSystemManager);
     el =   ElementList[ElementList_Count - 1]; // --- � ��� ��� ������ ������ ���� :-) ----

  // ---- ����������� ���������� ��������� ���� ---
     //TPoint aMouseCoordinatBinding   = Get_MouseCoordinatBinding(X - el->VisualElementParam->Width  / 2, Y - el->VisualElementParam->Height / 2);
     TPoint aMouseCoordinatBinding   = Get_MouseCoordinatBinding(X, Y);
     aMouseCoordinatBinding.x       += sbHorizontal->Position;
     aMouseCoordinatBinding.y       += sbVertical  ->Position;

  // ---- ��������� �������� �� ���� --------
     el->VisualElementParam->OffsetX = sbH->Position;
     el->VisualElementParam->OffsetY = sbV->Position;
     el->VisualElementParam->Left    = aMouseCoordinatBinding.x;
     el->VisualElementParam->Top     = aMouseCoordinatBinding.y;

  // ---- ������ �������� �� ���������� ����� -------
     el->Index = GetElementIndex(el);

   // ---- ���� ������� "������" TSubSystem �� �������������� ��������� ----
       if (el->ClassName == "TSubSystem") {

            // ----- �o������ ���� ���������� ---------
               int aLeft   = 0.37  * Screen->Width  + el->Index * 32;
               int aTop    = 0.37  * Screen->Height + el->Index * 32;
               int aWidth  = 0.369 * Screen->Width;
               int aHeight = 0.365 * Screen->Height;
             ((TSubSystem*)el)->EditorManager->BoundsRect = Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight);
             ((TSubSystem*)el)->Open                      = false;

            // ----- ���� ���������� --------
               ElementList  = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));
               FillElementGlobalParam (&ElementList[ElementList_Count - 1], "TSubSystemIn", el->Id);
               ElementList[ElementList_Count - 1]->Index                    = GetElementIndex(ElementList[ElementList_Count - 1]);
               ElementList[ElementList_Count - 1]->VisualElementParam->Left = 60;
               ElementList[ElementList_Count - 1]->VisualElementParam->Top  = 95;
               ((TSubSystem*)el)->Add_Input(ElementList[ElementList_Count - 1]);

            // ----- ����� ���������� --------
               ElementList  = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));
               FillElementGlobalParam (&ElementList[ElementList_Count - 1], "TSubSystemOut", el->Id);
               ElementList[ElementList_Count - 1]->Index                    = GetElementIndex(ElementList[ElementList_Count - 1]);
               ElementList[ElementList_Count - 1]->VisualElementParam->Left = aWidth - 125;
               ElementList[ElementList_Count - 1]->VisualElementParam->Top  = 95;
               ((TSubSystem*)el)->Add_OutPut(ElementList[ElementList_Count - 1]);

            // ----- ������� ����� ����� ����� ���������� (������ � ������� ����������) --------
               mp.NumberOut = 0; // --- ���� ���� ���������� �� ������ ���� ������� ----
               mp.NumberIn  = 0; // --- ���������� -------
               BeginLink(ElementList[ElementList_Count - 2]);
               EndLink  (ElementList[ElementList_Count - 1]);
       }

   // ---- ���� ������� "������" TSubSystemIn �� �������������� ��������� ----
       if (el->ClassName == "TSubSystemIn" || el->ClassName == "TSubSystemOut") {
            TElement *elel = FindElementByID(IdCurrentSubSystemManager);
            if (el->ClassName == "TSubSystemIn") ((TSubSystem*)elel)->Add_Input (el);
            if (el->ClassName == "TSubSystemOut") ((TSubSystem*)elel)->Add_OutPut(el);

          // --- ����������� ������������� ���� ------
             if (elel->ParentId != -1) {
                elel->NeedRedraw = true;
                elel = FindElementByID(elel->ParentId);
                ((TSubSystem*)elel)->EditorManager->Draw();
             }

       }

   // ---- ���� ������� "������" TOutPutStandart �� �������������� ��������� ----
       if (el->ClassName == "TOutElementStandart") {
         TOutElementStandart *oes = (TOutElementStandart*)el;
        ((TfrmOutPutStandart*)oes->frmOutPut)->Left += el->Index * 32;
        ((TfrmOutPutStandart*)oes->frmOutPut)->Top  += el->Index * 32;
       }


   // ------ �� ������� ���� ����������, �� �� ������� ------------
       el->Draw(RedrawBitmap->Canvas, IdCurrentSubSystemManager);

       PaintBox1->Canvas->Draw(0,0,RedrawBitmap);

   // ----- �������� ����� �� ������� �������� ---
       SetFocus();
    //Caption = "ElementCount = " + IntToStr(ElementList_Count - 1) + "  |  LinkCount = " + IntToStr(LinkList_Count);
       ProjectModified = true;
}





