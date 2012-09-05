//===========================================================================
int TfrmEditorManager::GetElementIndex(TBaseClass *aEl)
{
   // ---------- Список элементов текущего класса ----
      TBaseClass **TempElementList = NULL;
      int          TempElementList_Count = 0;

   // ---------- Определяю список текущего класса -----
      for (int i = 0; i < ElementList_Count; i++)
             if (typeid(*ElementList[i]) == typeid(*aEl)){
                 TempElementList = (TBaseClass **) realloc (TempElementList, sizeof(TBaseClass*) * (++TempElementList_Count));
                 TempElementList[TempElementList_Count - 1] = ElementList[i];
             }

   // ---------- Нахожу индекс отбражаемого элемента -----
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
  // ---- Эсли перекидываем не оттуда и не kуда, тогда навиг -------
     if ((AnsiString)Source->ClassName() != "TListBox" || (AnsiString)Sender->ClassName() != "TPaintBox") return;

  // ---- Елси ИтемИндекс элемента List Boxa == -1 тогда нафиг -----
     if (((TListBox *)Source)->ItemIndex == -1) return;

  // ---- Очищаем списиок выделенных еэементов --------------------
     Free_SelectedList();

  // ----
     TListBox    *lb  = (TListBox *)  Source;
     TElement    *el  = (TElement *)( lb->Items->Objects[lb->ItemIndex] );
     TScrollBar  *sbH = sbHorizontal;
     TScrollBar  *sbV = sbVertical;

  // ---- Если случайно нет элемента (но етого в принципе не может быть) в Айтэме ЛистБокса тогда тоже нафиг -------
     if (el == NULL) return;


  // ---------- Увеличиваем список элементов в проекте на единицу ---------
     ElementList  = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));
     FillElementGlobalParam (&ElementList[ElementList_Count - 1], el->ClassName, IdCurrentSubSystemManager);
     el =   ElementList[ElementList_Count - 1]; // --- а это шоб меньше текста было :-) ----

  // ---- Опредиление оточненных координат Мыши ---
     //TPoint aMouseCoordinatBinding   = Get_MouseCoordinatBinding(X - el->VisualElementParam->Width  / 2, Y - el->VisualElementParam->Height / 2);
     TPoint aMouseCoordinatBinding   = Get_MouseCoordinatBinding(X, Y);
     aMouseCoordinatBinding.x       += sbHorizontal->Position;
     aMouseCoordinatBinding.y       += sbVertical  ->Position;

  // ---- Положение элемента на поле --------
     el->VisualElementParam->OffsetX = sbH->Position;
     el->VisualElementParam->OffsetY = sbV->Position;
     el->VisualElementParam->Left    = aMouseCoordinatBinding.x;
     el->VisualElementParam->Top     = aMouseCoordinatBinding.y;

  // ---- Индекс елемента на глобальной схеме -------
     el->Index = GetElementIndex(el);

   // ---- Если который "ДРАГИН" TSubSystem то дополнительные установки ----
       if (el->ClassName == "TSubSystem") {

            // ----- Пoзицияя окна подсистемы ---------
               int aLeft   = 0.37  * Screen->Width  + el->Index * 32;
               int aTop    = 0.37  * Screen->Height + el->Index * 32;
               int aWidth  = 0.369 * Screen->Width;
               int aHeight = 0.365 * Screen->Height;
             ((TSubSystem*)el)->EditorManager->BoundsRect = Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight);
             ((TSubSystem*)el)->Open                      = false;

            // ----- Вход подсистемы --------
               ElementList  = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));
               FillElementGlobalParam (&ElementList[ElementList_Count - 1], "TSubSystemIn", el->Id);
               ElementList[ElementList_Count - 1]->Index                    = GetElementIndex(ElementList[ElementList_Count - 1]);
               ElementList[ElementList_Count - 1]->VisualElementParam->Left = 60;
               ElementList[ElementList_Count - 1]->VisualElementParam->Top  = 95;
               ((TSubSystem*)el)->Add_Input(ElementList[ElementList_Count - 1]);

            // ----- Выход подсистемы --------
               ElementList  = (TElement **) realloc (ElementList, sizeof(TElement *) * (++ElementList_Count));
               FillElementGlobalParam (&ElementList[ElementList_Count - 1], "TSubSystemOut", el->Id);
               ElementList[ElementList_Count - 1]->Index                    = GetElementIndex(ElementList[ElementList_Count - 1]);
               ElementList[ElementList_Count - 1]->VisualElementParam->Left = aWidth - 125;
               ElementList[ElementList_Count - 1]->VisualElementParam->Top  = 95;
               ((TSubSystem*)el)->Add_OutPut(ElementList[ElementList_Count - 1]);

            // ----- Создаем связь между двумя элементами (входом и выходом подсистемы) --------
               mp.NumberOut = 0; // --- Типа миша находиться на выходе пред елмента ----
               mp.NumberIn  = 0; // --- аналогично -------
               BeginLink(ElementList[ElementList_Count - 2]);
               EndLink  (ElementList[ElementList_Count - 1]);
       }

   // ---- Если который "ДРАГИН" TSubSystemIn то дополнительные установки ----
       if (el->ClassName == "TSubSystemIn" || el->ClassName == "TSubSystemOut") {
            TElement *elel = FindElementByID(IdCurrentSubSystemManager);
            if (el->ClassName == "TSubSystemIn") ((TSubSystem*)elel)->Add_Input (el);
            if (el->ClassName == "TSubSystemOut") ((TSubSystem*)elel)->Add_OutPut(el);

          // --- Перерисовка родительского окна ------
             if (elel->ParentId != -1) {
                elel->NeedRedraw = true;
                elel = FindElementByID(elel->ParentId);
                ((TSubSystem*)elel)->EditorManager->Draw();
             }

       }

   // ---- Если который "ДРАГИН" TOutPutStandart то дополнительные установки ----
       if (el->ClassName == "TOutElementStandart") {
         TOutElementStandart *oes = (TOutElementStandart*)el;
        ((TfrmOutPutStandart*)oes->frmOutPut)->Left += el->Index * 32;
        ((TfrmOutPutStandart*)oes->frmOutPut)->Top  += el->Index * 32;
       }


   // ------ Ну наверно надо нарисовать, то чо навояли ------------
       el->Draw(RedrawBitmap->Canvas, IdCurrentSubSystemManager);

       PaintBox1->Canvas->Draw(0,0,RedrawBitmap);

   // ----- Перевожу фокус на текущий редактор ---
       SetFocus();
    //Caption = "ElementCount = " + IntToStr(ElementList_Count - 1) + "  |  LinkCount = " + IntToStr(LinkList_Count);
       ProjectModified = true;
}





