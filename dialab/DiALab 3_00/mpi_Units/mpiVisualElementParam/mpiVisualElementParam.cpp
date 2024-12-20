//---------------------------------------------------------------------------
#include "mpiVisualElementParam.h"
#include "math.h"
//---------------------------------------------------------------------------
//===========================================================================
TVisualElementParam::TVisualElementParam(void *aParentElement)
{
   fParentElement = aParentElement;
//!!!!!!!!!!!!
//   fBitmap        = new Graphics::TBitmap;
   fWidth         = 0;
   fHeight        = 0;
   fLeft          = 0;
   fTop           = 0;
   fOffsetX       = 0;
   fOffsetY       = 0;
   fRect          = TmpiRect(-1, -1, -1, -1);
   fsRect         = fRect;
   fsdRect        = fRect;
   fosdRect       = fRect;

   fCalcPositionInOut = true; //
}
//===========================================================================
TVisualElementParam::~TVisualElementParam()
{
//   delete fBitmap;
}

//===========================================================================
void __fastcall TVisualElementParam::Set_Width(int aWidth)
{
    if (fWidth  == aWidth ) return;

    if (aWidth < 0) {
       Left   = Left + aWidth;
       aWidth = abs(aWidth);
    }

    fWidth          = aWidth;
    //fBitmap->Width  = aWidth;

    // --- ����������� �������� ------
      ((TElement*)fParentElement)->DrawElementFace();

    // ---- ������ ��������� ������ ������� ----------
      SetGraphicsParam();
    // ----
      SetElementGraphicVariable();
}

//===========================================================================
void __fastcall TVisualElementParam::Set_Height(int aHeight)
{
    if (fHeight == aHeight) return;

    if (aHeight < 0) {
       Top     = Top + aHeight;
       aHeight = abs(aHeight);
    }

    fHeight         = aHeight;
    fBitmap->Height = aHeight;

    // --- ����������� �������� ------
      ((TElement*)fParentElement)->DrawElementFace();

    // ---- ������ ��������� ������ ������� ----------
      SetGraphicsParam();

    // ----
      SetElementGraphicVariable();
}

//===========================================================================
void __fastcall Set_Left(int aLeft)
{
   fLeft    = aLeft;
   SetElementGraphicVariable();
}

//===========================================================================
void __fastcall Set_Top(int aTop)
{
  fTop     = aTop;
  SetElementGraphicVariable();
}

//===========================================================================
void __fastcall Set_OffsetX(int aOffsetX)
{
  fOffsetX = aOffsetX;
  SetElementGraphicVariable();
}

//===========================================================================
void __fastcall Set_OffsetY(int aOffsetY)
{
    fOffsetY = aOffsetY;
    SetElementGraphicVariable();
}

//===========================================================================
void TVisualElementParam::SetElementGraphicVariable()
{
     fRight  = fLeft + fWidth;
     fBottom = fTop  + fHeight;
     fRect   = Rect(fLeft, fTop, fRight, fBottom);

     fsLeft   = fLeft   - fOffsetX;
     fsTop    = fTop    - fOffsetY;
     fsRight  = fRight  - fOffsetX;
     fsBottom = fBottom - fOffsetY;
     fsRect   = Rect(fsLeft, fsTop, fsRight, fsBottom);
}
//===========================================================================
void TVisualElementParam::SetGraphicsParam()
{ // --- ������ ��������� ������ ������� ------
     if (!CalcPositionInOut) return;

     TElement* el          = ((TElement*)fParentElement);
     int       PosBeetween = 12;
     int       InputCount  = el->iPoints->Items_Count;
     int       OutputCount = el->oPoints->Items_Count;

     int       PosCounter;

  // --- ���������� ������� ������ � ������� --------
     int       CountVisibleInput  = 0;
     int       CountVisibleOutput = 0;
     for (int i = 0; i < InputCount ; i ++)  if (el->iPoints->Items[i]->Visible) CountVisibleInput++;
     for (int i = 0; i < OutputCount; i ++)  if (el->oPoints->Items[i]->Visible) CountVisibleOutput++;

   // =======================================================================================
   // =======================================================================================
   // =======================================================================================
     if (el->Orientation == oRight || el->Orientation == oLeft){
         // --------- ������ ��������� ������  --------
             if (InputCount != 0) {
               // ---- ���� �� �� �� ������ ������ �������� ----
                 if (fHeight < CountVisibleInput * PosBeetween) Height = InputCount * PosBeetween;

                 PosCounter = 0;
                 float aStep = fHeight / (float)(CountVisibleInput + 1);
                 for (int i = 0; i < InputCount; i ++) {
                      if (el->iPoints->Items[i]->Visible) {
                            if (el->Orientation == oRight) {
                               el->iPoints->Items[i]->xPos = -11;
                               el->iPoints->Items[i]->yPos = aStep * (PosCounter + 1);
                            }
                            if (el->Orientation == oLeft ) {
                               el->iPoints->Items[i]->xPos = fWidth + 10;
                               el->iPoints->Items[i]->yPos = el->VisualElementParam->Height - aStep * (PosCounter + 1);
                            }
                            PosCounter++;
                      }
                 }
             }
          // --------- ������ ��������� � �������  --------
             if (OutputCount != 0) {
                 if (fHeight < CountVisibleOutput * PosBeetween) {Height = OutputCount * PosBeetween;};

                 PosCounter = 0;
                 float aStep = fHeight / (float)(CountVisibleOutput + 1);
                 for (int i = 0; i < OutputCount; i ++) {
                      if (el->oPoints->Items[i]->Visible) {
                          if (el->Orientation == oRight) {
                             el->oPoints->Items[i]->xPos = fWidth + 10;
                             el->oPoints->Items[i]->yPos = aStep * (PosCounter + 1);
                          }
                          if (el->Orientation == oLeft ) {
                             el->oPoints->Items[i]->xPos = -11;
                             el->oPoints->Items[i]->yPos = el->VisualElementParam->Height - aStep * (PosCounter + 1);
                          }
                          PosCounter++;
                      }
                 }
             }
         // ----------------------------------------------------
     }
   // =======================================================================================
   // =======================================================================================
   // =======================================================================================
     if (el->Orientation == oBottom || el->Orientation == oTop){
         // --------- ������ ��������� ������  --------
             if (InputCount != 0) {
               // ---- ���� �� �� �� ������ ������ �������� ----
                 if (fWidth < CountVisibleInput * PosBeetween) Width = InputCount * PosBeetween;

                 PosCounter = 0;
                 float aStep = fWidth / (float)(CountVisibleInput + 1);
                 for (int i = 0; i < InputCount; i ++) {
                      if (el->iPoints->Items[i]->Visible) {
                          if (el->Orientation == oBottom) {
                             el->iPoints->Items[i]->xPos = el->VisualElementParam->Width - aStep * (PosCounter + 1);
                             el->iPoints->Items[i]->yPos = -11;
                          }
                          if (el->Orientation == oTop   ) {
                             el->iPoints->Items[i]->xPos = aStep * (PosCounter + 1);
                             el->iPoints->Items[i]->yPos = fHeight + 10;
                          }
                          PosCounter++;
                      }
                 }
             }
          // --------- ������ ��������� � �������  --------
             if (OutputCount != 0) {
                 if (fWidth < CountVisibleOutput * PosBeetween) {Width = OutputCount * PosBeetween;};

                 PosCounter = 0;
                 float aStep = fWidth / (float)(CountVisibleOutput + 1);
                 for (int i = 0; i < OutputCount; i ++) {
                      if (el->oPoints->Items[i]->Visible) {
                          if (el->Orientation == oBottom) {
                              el->oPoints->Items[i]->xPos = el->VisualElementParam->Width - aStep * (PosCounter + 1);
                              el->oPoints->Items[i]->yPos = fHeight + 10;
                          }
                          if (el->Orientation == oTop   ) {
                              el->oPoints->Items[i]->xPos = aStep * (PosCounter + 1);
                              el->oPoints->Items[i]->yPos = -11;
                          }
                          PosCounter++;
                      }
                 }
             }
     }
}


