//===========================================================================
TPoints::TPoints(void *aParentElement, TPointType aPointType)
{
   fPointType     = aPointType;
   fParentElement = aParentElement;
   Items          = NULL;
   Items_Count    = 0;
}

//===========================================================================
TPoints::~TPoints()
{
   if (Items_Count != 0) {
      for (int i = 0; i < Items_Count; i++)
          delete Items[i];
   }
   free (Items);
   Items        = NULL;
   Items_Count  = 0;
}

//===========================================================================
void TPoints::Add(AnsiString aCaption)
{
    Items = (TElementPoint**) realloc (Items, sizeof(TElementPoint*) * (++Items_Count));
    Items[Items_Count - 1] = new TElementPoint(aCaption, fPointType);

    // --- Графическая растоновка входов выходв ------
    ((TElement*)fParentElement)->NeedRedraw = true;
    ((TElement*)fParentElement)->VisualElementParam->SetGraphicsParam();
}

//===========================================================================
void TPoints::Insert(int Index, AnsiString aCaption)
{
    Items = (TElementPoint**) realloc (Items, sizeof(TElementPoint*) * (++Items_Count));

    for (int i = Items_Count - 1; i > Index; i--)
        Items[i] = Items[i - 1];
  // ------
    Items[Index] = new TElementPoint(aCaption, fPointType);

  // --- Графическая растоновка входов выходв ------
      ((TElement*)fParentElement)->VisualElementParam->SetGraphicsParam();
}

//===========================================================================
void TPoints::Delete(int Index)
{
    if (Index > Items_Count - 1) return;
  // ------
    delete Items[Index];
  // ------
    for (int i = Index; i < Items_Count - 1; i++)
        Items[i] = Items[i + 1];
  // ------
    Items = (TElementPoint**) realloc (Items, sizeof(TElementPoint*) * (--Items_Count));

  // --- Графическая растоновка входов выходв ------
    ((TElement*)fParentElement)->NeedRedraw = true;
    ((TElement*)fParentElement)->VisualElementParam->SetGraphicsParam();
}

//===========================================================================
void TPoints::Clear()
{
    for (int i = 0; i < Items_Count; i++)
        delete Items[i];
  // ---------------
    free (Items);
    Items = NULL;
    Items_Count = 0;

  // --- Графическая растоновка входов выходв ------
    ((TElement*)fParentElement)->NeedRedraw = true;
    ((TElement*)fParentElement)->VisualElementParam->SetGraphicsParam();
}

