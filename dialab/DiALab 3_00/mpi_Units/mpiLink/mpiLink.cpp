//---------------------------------------------------------------------------
#include "mpiLink.h"
//---------------------------------------------------------------------------
//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
TLink::TLink()
{
    fOffsetX       = -1;
    fOffsetY       = -1;

    fFirstElement  = NULL;
    fSecondElement = NULL;

    fNumberOutput  = -1;
    fNumberInput   = -1;

    fPoints        = NULL;
    fPoints_Count  = 0;

    fIdSecondElement = -999;
    fIdFirstElement  = -999;

    Conecting        = false;

    //fLinkPenColor    = clBlack;
    fLinkPenWidth    = 1;
}

TLink::~TLink()
{
  for (int i = 0; i < fPoints_Count; i++){
     delete fPoints[i];
  }
  free (fPoints);
}
/*
//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void __fastcall TLink::Set_OffsetX(int aOffsetX)
{
    if (fOffsetX == aOffsetX) return;
    fOffsetX = aOffsetX;

    for (int i = 0; i < fPoints_Count; i++)
        fPoints[i]->OffsetX = aOffsetX;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void __fastcall TLink::Set_OffsetY(int aOffsetY)
{
    if (fOffsetY == aOffsetY) return;
    fOffsetY = aOffsetY;

    for (int i = 0; i < fPoints_Count; i++)
        fPoints[i]->OffsetY = aOffsetY;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::AddPoint(int axPos, int ayPos)
{
   fPoints = (TLinkPoint**) realloc (fPoints, sizeof(TLinkPoint*) * (++fPoints_Count));
   fPoints[fPoints_Count-1] = new TLinkPoint(axPos, ayPos, fOffsetX, fOffsetY);
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::Edit()
{
     frmLinkPropertiesWindow->Link = this;
     frmLinkPropertiesWindow->ShowModal();
}

//===========================================================================
//==========       Отрисовка выделенной связи    =========================
//===========================================================================
void TLink::Draw_SelectedElement(TCanvas *aCanvas)
{
    aCanvas->Pen->Mode    = pmNot;
    aCanvas->Pen->Color   = (TColor)RGB (255, 128, 0);
    aCanvas->Brush->Color = (TColor)RGB (255, 128, 0);

       for (int i = 0; i < fPoints_Count; i++)
                aCanvas->Rectangle(fPoints[i]->sx - 1,
                                   fPoints[i]->sy - 1,
                                   fPoints[i]->sx + 4,
                                   fPoints[i]->sy + 4);

    aCanvas->Pen->Mode = pmCopy;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::BindingToFirstElement()
{
      if (fFirstElement == NULL) return;

      TElement *el = (TElement*)fFirstElement;

      Points[0]->x = el->VisualElementParam->Left + el->oPoints->Items[NumberOutput]->xPos;
      Points[0]->y = el->VisualElementParam->Top  + el->oPoints->Items[NumberOutput]->yPos;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::BindingToSecondElement()
{
      if (fSecondElement == NULL) return;

      TElement *el = (TElement*)fSecondElement;

      Points[fPoints_Count - 1]->x = el->VisualElementParam->Left + el->iPoints->Items[NumberInput]->xPos;
      Points[fPoints_Count - 1]->y = el->VisualElementParam->Top  + el->iPoints->Items[NumberInput]->yPos;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::Draw_Link(TCanvas *aCanvas)
{
    aCanvas->Pen->Color   = fLinkPenColor;
    aCanvas->Pen->Width   = fLinkPenWidth;
    aCanvas->Pen->Mode    = pmCopy;
    aCanvas->Brush->Color = clWhite;

    if (fFirstElement == NULL || fSecondElement == NULL) {
       aCanvas->Pen->Color = clRed;
       aCanvas->Pen->Style = psDot;
       aCanvas->Pen->Width = 1;
    }

    aCanvas->MoveTo(Points[0]->sx, Points[0]->sy);
    for (int i = 0; i < fPoints_Count; i++) aCanvas->LineTo(Points[i]->sx, Points[i]->sy);

    aCanvas->Pen->Width = 1;
    aCanvas->Pen->Style = psSolid;

    if (fFirstElement == NULL) 
       aCanvas->Ellipse (Points[0]->sx-3, Points[0]->sy-3, Points[0]->sx+3, Points[0]->sy+3);
    if (fSecondElement == NULL)
       aCanvas->Ellipse (Points[fPoints_Count - 1]->sx-3, Points[fPoints_Count - 1]->sy-3, Points[fPoints_Count - 1]->sx+3, Points[fPoints_Count - 1]->sy+3);

    aCanvas->Pen->Color = clBlack;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::Draw_BeginLink(TCanvas *aCanvas)
{
      if (fFirstElement == NULL) return;

      TElement *el = (TElement*)fFirstElement;

      switch (el->Orientation) {
         case oRight  : aCanvas->MoveTo(el->VisualElementParam->sRight, Points[0]->sy ); break;
         case oBottom : aCanvas->MoveTo(Points[0]->sx, el->VisualElementParam->sBottom); break;
         case oLeft   : aCanvas->MoveTo(el->VisualElementParam->sLeft,   Points[0]->sy); break;
         case oTop    : aCanvas->MoveTo(Points[0]->sx, el->VisualElementParam->sTop   ); break;
      }
      aCanvas->LineTo(Points[0]->sx, Points[0]->sy);
      aCanvas->Ellipse(Points[0]->sx - 2, Points[0]->sy - 2, Points[0]->sx + 2, Points[0]->sy + 2);
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::Draw_EndLink(TCanvas *aCanvas)
{
      if (fSecondElement == NULL) return;

      TElement *el = (TElement*)fSecondElement;
      TPoint    aPoints[3];

      aCanvas->Pen->Color   = clBlack;
      aCanvas->Pen->Width   = 1;
      aCanvas->Brush->Color = clBlack;

      aCanvas->MoveTo(Points[fPoints_Count - 1]->sx, Points[fPoints_Count - 1]->sy);

      switch (el->Orientation) {
         case oRight  : aCanvas->LineTo(el->VisualElementParam->sLeft, Points[fPoints_Count - 1]->sy);
                        aPoints[0] = Point(el->VisualElementParam->sLeft    , Points[fPoints_Count - 1]->sy    );
                        aPoints[1] = Point(el->VisualElementParam->sLeft - 5, Points[fPoints_Count - 1]->sy - 3);
                        aPoints[2] = Point(el->VisualElementParam->sLeft - 5, Points[fPoints_Count - 1]->sy + 3);
                        break;

         case oBottom : aCanvas->LineTo(Points[fPoints_Count - 1]->sx, el->VisualElementParam->sTop);
                        aPoints[0] = Point(Points[fPoints_Count - 1]->sx    , el->VisualElementParam->sTop    );
                        aPoints[1] = Point(Points[fPoints_Count - 1]->sx - 3, el->VisualElementParam->sTop - 5);
                        aPoints[2] = Point(Points[fPoints_Count - 1]->sx + 3, el->VisualElementParam->sTop - 5);
                        break;

         case oLeft   : aCanvas->LineTo(el->VisualElementParam->sRight, Points[fPoints_Count - 1]->sy);
                        aPoints[0] = Point(el->VisualElementParam->sRight    , Points[fPoints_Count - 1]->sy    );
                        aPoints[1] = Point(el->VisualElementParam->sRight + 5, Points[fPoints_Count - 1]->sy - 3);
                        aPoints[2] = Point(el->VisualElementParam->sRight + 5, Points[fPoints_Count - 1]->sy + 3);
                        break;

         case oTop    : aCanvas->LineTo(Points[fPoints_Count - 1]->sx, el->VisualElementParam->sBottom);
                        aPoints[0] = Point(Points[fPoints_Count - 1]->sx    , el->VisualElementParam->sBottom);
                        aPoints[1] = Point(Points[fPoints_Count - 1]->sx - 3, el->VisualElementParam->sBottom + 5);
                        aPoints[2] = Point(Points[fPoints_Count - 1]->sx + 3, el->VisualElementParam->sBottom + 5);
                        break;
      }
//
      aCanvas->Polygon(aPoints, 2);
}

//====================================================================================================================
//============        Добавление промежуточных точек    =============================================================
//====================================================================================================================
void TLink::AddTwoMiddleLinkPoint(int x1, int y1, int x2, int y2)
{
    int xx = min(x1, x2) + (max(x1, x2) - min(x1, x2)) / 2;
    int yy1, yy2;
  // ------------
    if (y1 > y2) {
        yy1 = max(y1, y2);
        yy2 = min(y1, y2);
    } else {
        yy1 = min(y1, y2);
        yy2 = max(y1, y2);
    }
  // ------------
    fPoints_Count = fPoints_Count + 2;
    fPoints = (TLinkPoint**) realloc (fPoints, sizeof(TLinkPoint*) * (fPoints_Count));


    fPoints[fPoints_Count - 1] = fPoints[fPoints_Count - 3];
    fPoints[fPoints_Count - 2] = new TLinkPoint(xx, yy2, fOffsetX, fOffsetY);
    fPoints[fPoints_Count - 3] = new TLinkPoint(xx, yy1, fOffsetX, fOffsetY);
  // ------------
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::CorrectLinkValue()
{
  // ---------- Проверка на перпендикулярность, паралельность точек -------
      // --- Если во свей связи токо две точки и присутсвуют оба элемента то добавляем новые две точки --------
            if (Points_Count == 2) { AddTwoMiddleLinkPoint(Points[0]->x, Points[0]->y, Points[1]->x, Points[1]->y); return; }

            if (SecondElement == NULL) return;
            TElement *el = (TElement*)SecondElement;

      // ---- Ориентация второго элемента --------
            bool Horizontal = true;
            if (el->Orientation == oRight || el->Orientation == oLeft  ) Horizontal = true;
            if (el->Orientation == oTop   || el->Orientation == oBottom) Horizontal = false;

      // --- Иначе, Если три точки (т.е. BeginElement, MiddlePoiint, EndElement) добавляем новою (предпоследнею) точку ------
            if (Points_Count == 3) {
                  fPoints = (TLinkPoint**) realloc (fPoints, sizeof(TLinkPoint*) * (++fPoints_Count));
                  fPoints[fPoints_Count - 1] = fPoints[fPoints_Count - 2];

                  if ( Horizontal )
                      fPoints[fPoints_Count - 2] = new TLinkPoint(fPoints[fPoints_Count - 3]->x, fPoints[fPoints_Count - 1]->y, fOffsetX, fOffsetY);
                  if (!Horizontal )
                      fPoints[fPoints_Count - 2] = new TLinkPoint(fPoints[fPoints_Count - 1]->x, fPoints[fPoints_Count - 3]->y, fOffsetX, fOffsetY);
                  return;
            }

      // --- Если текущая и предыдущаи точки одинаковы по координатам , тогда нафиг -----
            if ( Horizontal && fPoints[fPoints_Count - 1]->y == fPoints[fPoints_Count - 2]->y && fPoints[0]->y == fPoints[1]->y) return;
            if (!Horizontal && fPoints[fPoints_Count - 1]->x == fPoints[fPoints_Count - 2]->x && fPoints[0]->x == fPoints[1]->x) return;

      // --- Иначе, (если больше трех точек) поправляем предыдущую точку ------
            if (  Horizontal ) {
                fPoints[                1]->y = fPoints[                0]->y;
                fPoints[fPoints_Count - 2]->y = fPoints[fPoints_Count - 1]->y;
            }
            if ( !Horizontal ) {
                fPoints[                1]->x = fPoints[                0]->x;
                fPoints[fPoints_Count - 2]->x = fPoints[fPoints_Count - 1]->x;
            }


//frmMain->Caption = fPoints_Count;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::ReDraw_DrawingLink(TCanvas *aCanvas)
{
    aCanvas->Pen->Color   = fLinkPenColor;
    aCanvas->Pen->Width   = fLinkPenWidth;
    aCanvas->Pen->Mode    = pmCopy;
    aCanvas->Brush->Color = clWhite;

    aCanvas->Pen->Style = psDot;

    aCanvas->MoveTo(Points[0]->sx, Points[0]->sy);
    for (int i = 0; i < fPoints_Count; i++) aCanvas->LineTo(Points[i]->sx, Points[i]->sy);

    aCanvas->Pen->Style = psSolid;
}
//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::Draw(TCanvas *aCanvas, int aParentId)
{
      if (aParentId != ParentId || ParentId == -1)  return;
      if (Conecting) { ReDraw_DrawingLink(aCanvas); return;}
      if (fFirstElement  != NULL) if ( !((TElement*)fFirstElement)->oPoints->Items[NumberOutput]->Visible ) return;
      if (fSecondElement != NULL) if ( !((TElement*)fSecondElement)->iPoints->Items[NumberInput]->Visible ) return;
  // ----------

      BindingToFirstElement();    // ---- Привязка к первому элементу  -----
      BindingToSecondElement();   // ---- Привязка ко второму элементу -----
      CorrectLinkValue();
      Draw_Link     (aCanvas);    // ---- Прорисовка самой  связи -----------
      Draw_BeginLink(aCanvas);    // ---- Прорисовка начала связи -----------
      Draw_EndLink  (aCanvas);    // ---- Прорисовка конца  связи -----------

  // ---- Если элемент выделен, то надо сделать соответствующие выводы ------
     if (SelectedParam.Selected) Draw_SelectedElement(aCanvas);
}

bool TLink::PointInLine(int x, int y, int x1, int y1, int x2, int y2)
{
   if (x < min(x1, x2) - 2 || x > max(x1, x2) + 2 || y < min(y1, y2) - 2 || y > max(y1, y2) + 2) return false;

   double  dV = 3.0;
   double  p;
   // -------
       if (x1 != x2) {
           p = (double)(x - x1) / (double)(x2 - x1);
           return (fabs(y1 + p*(y2 - y1) - y) < dV);

       }
   // -------
       if (y1 != y2) {
           p = (double)(y - y1) / (double)(y2 - y1);
           return (fabs(x1 + p*(x2 - x1) - x) < dV);
       }
   // -------

       return (x == x1) && (y == y1);
}


 //====================================================================================================================
//====================================================================================================================
//====================================================================================================================
TBaseClass *TLink::WhereMouse(int aParentId, TMouseParam &mp, int xPos, int yPos)
{
    // ---- Обнуляем значения -----
        mp.ClearValues();

    // --------
        if (aParentId != ParentId || ParentId == -1) return NULL;

    // --- Проверка углов cвязи -----
       for (int i = 0; i < fPoints_Count; i++) {
              if (xPos > fPoints[i]->sx - 2 &&
                  yPos > fPoints[i]->sy - 2 &&
                  xPos < fPoints[i]->sx + 2 &&
                  yPos < fPoints[i]->sy + 2) {

                   mp.Cursor   = crHandPoint;
                   mp.wm       = wmLinkPoint;
                   return this;
              }
       }
    // --- Проверка на тело cвязи  ---
       for (int i = 0; i < fPoints_Count - 1; i++) {
           if (PointInLine(xPos, yPos, fPoints[i]->sx, fPoints[i]->sy, fPoints[i+1]->sx, fPoints[i+1]->sy)){
                   mp.wm       = wmLink;
                   //Beep();
                   return this;
           }
       }
   // --------------
       return NULL;
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::MoveElement(TCanvas *aCanvas, int aOffsetX, int aOffsetY)
{
       for (int i = 0; i < fPoints_Count - 1; i++) {
           fPoints[i]->x += aOffsetX;
           fPoints[i]->y += aOffsetY;
       }
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
void TLink::EndMoveElement()
{
}

//====================================================================================================================
//====================================================================================================================
//====================================================================================================================
bool TLink::IsElementInSelectedRegion(int aParentId, int ax1, int ay1, int ax2, int ay2)
{
    if (aParentId != ParentId || ParentId == -1) return false;

    bool Result = false;

    int MinX = min (ax1,  ax2);
    int MaxX = max (ax1,  ax2);
    int MinY = min (ay1,  ay2);
    int MaxY = max (ay1,  ay2);

       for (int i = 0; i < fPoints_Count; i++) {
              if (MinX < fPoints[i]->sx &&
                  MaxX > fPoints[i]->sx &&
                  MinY < fPoints[i]->sy &&
                  MaxY > fPoints[i]->sy) {
                  Result = true;
                  }
       }

    return Result;
}

//===========================================================================
//========================    Загрузка элемента из потока ===================
//===========================================================================
//===========================================================================
void TLink::LoadFromStream(TStream *aStream) { TBaseClass::LoadFromStream(aStream);
   int x, y, aPointCount;

   aStream->Read(&fNumberOutput   , sizeof(fNumberOutput)   );
   aStream->Read(&fNumberInput    , sizeof(fNumberInput)    );
   aStream->Read(&fIdFirstElement , sizeof(fIdFirstElement) );
   aStream->Read(&fIdSecondElement, sizeof(fIdSecondElement));
   aStream->Read(&fLinkPenColor   , sizeof(fLinkPenColor)   );
   aStream->Read(&fLinkPenWidth   , sizeof(fLinkPenWidth)   );
   aStream->Read(&aPointCount     , sizeof(aPointCount)   );

  // ********** Raise Exception *************
    if (fabs(aPointCount) > 100000) aPointCount = aPointCount / 0.0;
  // ********** End of Raise Exception *************

   // ---
      if (fPoints != NULL) {
          for (int i = 0; i < fPoints_Count; i++) delete fPoints[i];
          free (fPoints);
          fPoints = NULL;
      }
   // ---


   for (int i = 0; i < aPointCount; i++){
       aStream->Read(&x, sizeof(x));
       aStream->Read(&y, sizeof(y));

       AddPoint(x, y);
   }
}

//===========================================================================
//========================    Зaпись элемента в поток     ===================
//===========================================================================

void TLink::SaveToStream(TStream *aStream) { TBaseClass::SaveToStream(aStream);
   int x, y;

   aStream->Write(&fNumberOutput   , sizeof(fNumberOutput)   );
   aStream->Write(&fNumberInput    , sizeof(fNumberInput)    );
   aStream->Write(&fIdFirstElement , sizeof(fIdFirstElement) );
   aStream->Write(&fIdSecondElement, sizeof(fIdSecondElement));
   aStream->Write(&fLinkPenColor   , sizeof(fLinkPenColor)   );
   aStream->Write(&fLinkPenWidth   , sizeof(fLinkPenWidth)   );
   aStream->Write(&fPoints_Count   , sizeof(fPoints_Count)   );

   for (int i = 0; i < fPoints_Count; i++){
       x = fPoints[i]->x;
       y = fPoints[i]->y;
       aStream->Write(&x, sizeof(x));
       aStream->Write(&y, sizeof(y));
   }
}
*/ 
