//---------------------------------------------------------------------------
#include "mpiPoints.h"
#include "mpiElement.h"
//---------------------------------------------------------------------------
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
void TPoints::Add(std::string aCaption)
{
    Items = (TInOutPoint**) realloc (Items, sizeof(TInOutPoint*) * (++Items_Count));
    Items[Items_Count - 1] = new TInOutPoint(fParentElement,  &Items_Count, aCaption, fPointType);

    // --- Графическая растоновка входов выходв ------
//    ((TElement*)fParentElement)->NeedRedraw = true;
//    ((TElement*)fParentElement)->VisualElementParam->SetGraphicsParam();
}

//===========================================================================
void TPoints::Insert(int Index, std::string aCaption)
{
    Items = (TInOutPoint**) realloc (Items, sizeof(TInOutPoint*) * (++Items_Count));

    for (int i = Items_Count - 1; i > Index; i--)
        Items[i] = Items[i - 1];
  // ------
    Items[Index] = new TInOutPoint(fParentElement, &Items_Count, aCaption, fPointType);

  // --- Графическая растоновка входов выходв ------
//      ((TElement*)fParentElement)->VisualElementParam->SetGraphicsParam();
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
    Items = (TInOutPoint**) realloc (Items, sizeof(TInOutPoint*) * (--Items_Count));

  // --- Графическая растоновка входов выходв ------
//    ((TElement*)fParentElement)->NeedRedraw = true;
//    ((TElement*)fParentElement)->VisualElementParam->SetGraphicsParam();
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
//    ((TElement*)fParentElement)->NeedRedraw = true;
//    ((TElement*)fParentElement)->VisualElementParam->SetGraphicsParam();
}

//===========================================================================
void TPoints::Draw()
{
    for (int i = 0; i < Items_Count; i++)
        Items[i]->Draw();
}

