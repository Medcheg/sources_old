//===========================================================================
void TfrmEditorManager::FindElementInSelectedRegion(TRect ar)
{
/*    int MinX = min (ar.Left,  ar.Right );
    int MaxX = max (ar.Left,  ar.Right );
    int MinY = min (ar.Top ,  ar.Bottom);
    int MaxY = max (ar.Top ,  ar.Bottom);
    TRect  esr;
    for (int i = 0; i < ElementList_Count; i ++)
        if (ElementList[i]->ParentLayer == ParentSubSystem){
            esr = ElementList[i]->ep->sRect;
            if ( (esr.Bottom > MinY && esr.Top < MinY && esr.Right > MinX && esr.Left < MinX) ||
                 (esr.Bottom > MinY && esr.Top < MinY && esr.Right > MaxX && esr.Left < MaxX) ||
                 (esr.Bottom > MaxY && esr.Top < MaxY && esr.Right > MinX && esr.Left < MinX) ||
                 (esr.Bottom > MaxY && esr.Top < MaxY && esr.Right > MaxX && esr.Left < MaxX) ||

                 (esr.Bottom > MinY && esr.Top < MinY && esr.Right < MaxX && esr.Left > MinX) ||
                 (esr.Bottom > MaxY && esr.Top < MaxY && esr.Right < MaxX && esr.Left > MinX) ||
                 (esr.Bottom < MaxY && esr.Top > MinY && esr.Right > MinX && esr.Left < MinX) ||
                 (esr.Bottom < MaxY && esr.Top > MinY && esr.Right > MaxX && esr.Left < MaxX) ||

                 (esr.Bottom < MaxY && esr.Top > MinY && esr.Right > MaxX && esr.Left < MinX) ||
                 (esr.Bottom > MaxY && esr.Top < MinY && esr.Right < MaxX && esr.Left > MinX) ||

                 (esr.Bottom < MaxY && esr.Top > MinY && esr.Right < MaxX && esr.Left > MinX)
               ) {
                     SelectedList = (TElement **) realloc (SelectedList, sizeof(TElement*) * (++SelectedList_Count));
                     SelectedList[SelectedList_Count - 1] = ElementList[i];
                     SelectedList[SelectedList_Count - 1]->Selected = true;

                     // ---- Тут нуно вставить функцию драв ----
               }
        }*/
}

//===========================================================================
//======================   ELEMEMT  =========================================
//===========================================================================
void TfrmEditorManager::SelectedList_ItemDelete(TBaseClass *aElement)
{
      aElement->SelectedParam = TSelectedParam(false, PaintBox1->Canvas);

   // ---- Проверка на присутствие элемента в SelectedList -------
      for (int i = 0; i < SelectedList_Count; i ++)
         if (aElement == SelectedList[i]) {

               for (int k = i; k < SelectedList_Count - 1; k ++)  {
                    SelectedList[k] = SelectedList[k+1];
               }

               SelectedList = (TBaseClass **) realloc (SelectedList, sizeof(TBaseClass*) * (--SelectedList_Count));
               return;
         }
    // ---
      if  (SelectedList_Count == 0) {
          aRotateElement->Enabled = false;
          aDeleteElement->Enabled = false;
          aFogElement   ->Enabled = false;

          if (SelectedList_Count == 1)
               aParamElement ->Enabled = true;
          else aParamElement ->Enabled = false;
      }


}

//===========================================================================
//======================   ELEMEMT  =========================================
//===========================================================================
void TfrmEditorManager::SelectedList_ItemAdd(TBaseClass *aElement)
{
      if (aElement == NULL) return;
   // ---- Расширяю список выделенных элементов ---------
      SelectedList = (TBaseClass **) realloc (SelectedList, sizeof(TBaseClass*) * (++SelectedList_Count));

      SelectedList[SelectedList_Count - 1] = aElement;
      SelectedList[SelectedList_Count - 1]->SelectedParam = TSelectedParam(true, PaintBox1->Canvas);

      aRotateElement->Enabled = true;
      aDeleteElement->Enabled = true;
      aFogElement   ->Enabled = true;
      if (SelectedList_Count == 1)
           aParamElement ->Enabled = true;
      else aParamElement ->Enabled = false;
}

//===========================================================================
//======================   ELEMEMT  =========================================
//===========================================================================
bool TfrmEditorManager::SelectedList_ItemPresent(TBaseClass *aElement)
{
   bool Result = false;
   // ---- Проверка на присутствие элемента в SelectedList -------
      for (int i = 0; i < SelectedList_Count; i ++)
         if (MouseElement == SelectedList[i]) {
           Result = true;
           break;
         }
    // ---
    return Result;
}

//===========================================================================
//======================   ELEMEMT  =========================================
//===========================================================================
void TfrmEditorManager::Free_SelectedList()
{
    for (int i = 0; i < SelectedList_Count; i ++ )
         SelectedList[i]->SelectedParam = TSelectedParam(false, PaintBox1->Canvas);

    if (SelectedList  != NULL) free(SelectedList);

    SelectedList       = NULL;
    SelectedList_Count = 0;

    aRotateElement->Enabled = false;
    aDeleteElement->Enabled = false;
    aFogElement   ->Enabled = false;
    
    if (SelectedList_Count == 1)
         aParamElement ->Enabled = true;
    else aParamElement ->Enabled = false;
}

//===========================================================================

