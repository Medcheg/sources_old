//---------------------------------------------------------------------------
#include "mpiElement.h"
#include <Types.hpp>
#include "mpiPoints.h"
#include "mpiVisualElementParam.h"
//---------------------------------------------------------------------------
//===========================================================================
//===========================================================================
//===========================================================================
/*TElement  **ElementList;       // ---- Список элементо на схеме ---
int         ElementList_Count; // ----- Количество элементов на схеме ----

//===========================================================================
TElement *FindElementByID(int aId)
{
   TElement *Result = NULL;

   for (int i = 0; i < ElementList_Count; i++)
       if (ElementList[i] != NULL)
           if (ElementList[i]->Id == aId) {
               Result = ElementList[i];
               break;
           }

   return Result;
}

//===========================================================================
//=======     Креатор элемента ==============================================
//===========================================================================
TElement::TElement()
{
     fDesignPhase = dpNotTesting;

     fOrientation        = oRight;

     fVisualElementParam = new TVisualElementParam(this);
     fInPoints           = new TPoints            (this, tInput);
     fOutPoints          = new TPoints            (this, tOutput);

     fShowInOutHint      = false;
     fNeedRedraw         = false;
     fShadow             = true;

   // -------------- Зугрузка ресурса если он есть ----------
     fResourseBitmapFaceElement = new Graphics::TBitmap();
}

//=============================================================================
//=== Уничтожитель, удалитель, дестроер, (ну... топором по голове) Элемента ===
//=============================================================================
TElement::~TElement()
{
      delete fVisualElementParam;
      delete fInPoints;
      delete fOutPoints;
      delete fResourseBitmapFaceElement;
}
*/
//===========================================================================
//==========      Вращение Элемента     =====================================
//===========================================================================
void TElement::RotateElemenet()
{
      TOrientation         or;
      TVisualElementParam *vep = VisualElementParam;
      int                  TempSize;
   // --- Тут надо инвертировать (поменять) размеры элемента ----------


      VisualElementParam-> sdRect = TmpiRect(-1, -1, -1, -1);
      VisualElementParam->osdRect = TmpiRect(-1, -1, -1, -1);

      switch (fOrientation) {
         case oRight  : fOrientation = oBottom; TempSize = vep->Width;  vep->Width  =  vep->Height; vep->Height = TempSize; break;
         case oBottom : fOrientation = oLeft;   TempSize = vep->Height; vep->Height =  vep->Width ; vep->Width  = TempSize; break;
         case oLeft   : fOrientation = oTop;    TempSize = vep->Width;  vep->Width  =  vep->Height; vep->Height = TempSize;   break;
         case oTop    : fOrientation = oRight;  TempSize = vep->Height; vep->Height =  vep->Width ; vep->Width  = TempSize; break;
      }

      VisualElementParam->SetGraphicsParam();
}
/*
//===========================================================================
//==========      Отрисовка Тени        =====================================
//===========================================================================
void TElement::Draw_Shadow(TCanvas *aCanvas)
{
       if (!Shadow) return;
   // --------
       TVisualElementParam *vep = VisualElementParam;  // --- Шоб меньше букв писать ------

       aCanvas->Brush->Color = clGray;
       aCanvas->Pen  ->Color = clGray;

   // ---- Если входы или выходы подсистемы --------
//       AnsiString ClassName = typeid(*this).name();
       if (ClassName == "TSubSystemIn" || ClassName == "TSubSystemOut") {
            int MinSide = min (vep->Width, vep->Height) * 2 / 3;
            aCanvas->RoundRect(vep->sLeft + 3, vep->sTop + 3, vep->sRight + 3, vep->sBottom + 3, MinSide, MinSide);
            return;
       }

     // ------
       aCanvas->FillRect(Rect(vep->sLeft + 3, vep->sTop + 3, vep->sRight + 3, vep->sBottom + 3));
}

//===========================================================================
//==========      Отрисовка Подписи элемента ================================
//===========================================================================
void TElement::Draw_Caption(TCanvas *aCanvas)
{
        if (!ShowCaption) return;
    // --------
        TVisualElementParam *vep = VisualElementParam; // --- Шоб меньше букв писать ------

        //Caption = "ID = " + IntToStr(Id) + "   ParentID = " + IntToStr(ParentId);

        int xPos, yPos;
    // --------- ПОзиционирование подписи элемента --------
        switch (Orientation) {
             case oRight  : SetTextAlign(aCanvas->Handle, TA_CENTER|TA_TOP);
                            xPos = vep->sLeft + vep->Width / 2;
                            yPos = vep->sBottom + 2;
                            break;
             case oBottom : SetTextAlign(aCanvas->Handle, TA_RIGHT|TA_TOP);
                            xPos = vep->sLeft - 2;
                            yPos = vep->sTop + (vep->Height - aCanvas->TextHeight(Caption)) / 2;
                            break;
             case oLeft   : SetTextAlign(aCanvas->Handle, TA_CENTER|TA_BOTTOM);
                            xPos = vep->sLeft + vep->Width / 2;
                            yPos = vep->sTop - 2;
                            break;
             case oTop    : SetTextAlign(aCanvas->Handle, TA_LEFT|TA_TOP);
                            xPos = vep->sRight + 2;
                            yPos = vep->sTop + (vep->Height - aCanvas->TextHeight(Caption)) / 2;
                            break;
        }

    // --------- Отрисовка Подписи элемента --------
        SetBkMode   (aCanvas->Handle, TRANSPARENT);

        aCanvas->Font->Color = clBlack;
        aCanvas->TextOut(xPos, yPos,  Caption.c_str());
}

//===========================================================================
//==========      Отрисовка входов элемента ================================
//===========================================================================
void TElement::Draw_In(TCanvas *aCanvas)
{
     TVisualElementParam *vep = VisualElementParam;   // --- Шоб меньше букв писать :) ------
     int xPos, yPos;

     aCanvas->Pen->Color = clBlack;
  // --------- Отрисовка входов  --------
     for (int i = 0; i <  iPoints->Items_Count; i ++) {
           if (!iPoints->Items[i]->Conected && iPoints->Items[i]->Visible) {

                xPos = vep->sLeft + iPoints->Items[i]->xPos;
                yPos = vep->sTop  + iPoints->Items[i]->yPos;
                switch (Orientation) {
                     case oRight  : aCanvas->MoveTo(xPos + 9, yPos);    aCanvas->LineTo(xPos + 5, yPos - 4);
                                    aCanvas->MoveTo(xPos + 9, yPos);    aCanvas->LineTo(xPos + 5, yPos + 4);
                                    break;
                     case oBottom : aCanvas->MoveTo(xPos, yPos + 9);    aCanvas->LineTo(xPos - 4, yPos + 5);
                                    aCanvas->MoveTo(xPos, yPos + 9);    aCanvas->LineTo(xPos + 4, yPos + 5);
                                    break;
                     case oLeft   : aCanvas->MoveTo(xPos - 7, yPos);    aCanvas->LineTo(xPos - 3, yPos - 4);
                                    aCanvas->MoveTo(xPos - 7, yPos);    aCanvas->LineTo(xPos - 3, yPos + 4);
                                    break;
                     case oTop    : aCanvas->MoveTo(xPos, yPos - 7);    aCanvas->LineTo(xPos - 4, yPos - 3);
                                    aCanvas->MoveTo(xPos, yPos - 7);    aCanvas->LineTo(xPos + 4, yPos - 3);
                                    break;
                }
           }
     }
}

//===========================================================================
//==========      Отрисовка выходов элемента ================================
//===========================================================================
void TElement::Draw_Out(TCanvas *aCanvas)
{
     TVisualElementParam *vep = VisualElementParam;   // --- Шоб меньше букв писать ------
     int xPos, yPos;

     for (int i = 0; i < oPoints->Items_Count; i ++) {
           if (!oPoints->Items[i]->Conected && oPoints->Items[i]->Visible) {
                xPos = vep->sLeft + oPoints->Items[i]->xPos;
                yPos = vep->sTop  + oPoints->Items[i]->yPos;
                switch (Orientation) {
                     case oRight  : aCanvas->MoveTo(xPos - 3, yPos);    aCanvas->LineTo(xPos - 7, yPos - 4);
                                    aCanvas->MoveTo(xPos - 3, yPos);    aCanvas->LineTo(xPos - 7, yPos + 4);
                                    break;
                     case oBottom : aCanvas->MoveTo(xPos, yPos - 3);    aCanvas->LineTo(xPos - 4, yPos - 7);
                                    aCanvas->MoveTo(xPos, yPos - 3);    aCanvas->LineTo(xPos + 4, yPos - 7);
                                    break;
                     case oLeft   : aCanvas->MoveTo(xPos + 5, yPos);    aCanvas->LineTo(xPos + 9, yPos - 4);
                                    aCanvas->MoveTo(xPos + 5, yPos);    aCanvas->LineTo(xPos + 9, yPos + 4);
                                    break;
                     case oTop    : aCanvas->MoveTo(xPos, yPos + 5);    aCanvas->LineTo(xPos - 4, yPos + 9);
                                    aCanvas->MoveTo(xPos, yPos + 5);    aCanvas->LineTo(xPos + 4, yPos + 9);
                                    break;
                }
           }
     }
}

//===========================================================================
//==========      Отрисовка  подписей входов            =====================
//===========================================================================
void TElement::Draw_InHint(TCanvas *aCanvas)
{
     if (!ShowInOutHint) return;

     TVisualElementParam *vep = VisualElementParam;   // --- Шоб меньше букв писать ------
     int xPos, yPos;

     SetTextAlign(aCanvas->Handle, TA_LEFT|TA_TOP|TA_NOUPDATECP);

     for (int i = 0; i < iPoints->Items_Count; i ++) {
           if (iPoints->Items[i]->Visible) {
                xPos = vep->sLeft + iPoints->Items[i]->xPos;
                yPos = vep->sTop  + iPoints->Items[i]->yPos;

                int TextHeight = aCanvas->TextHeight(iPoints->Items[i]->Caption);
                int TextWidth  = aCanvas->TextWidth (iPoints->Items[i]->Caption);

                switch (Orientation) {
                     case oRight  : aCanvas->TextOut(vep->sLeft + 3, yPos - TextHeight / 2, iPoints->Items[i]->Caption); break;
                     case oBottom : aCanvas->TextOut(xPos - TextWidth / 2, vep->sTop + 3, iPoints->Items[i]->Caption);    break;
                     case oLeft   : aCanvas->TextOut(vep->sRight - 3 - TextWidth, yPos - TextHeight / 2, iPoints->Items[i]->Caption); break;
                     case oTop    : aCanvas->TextOut(xPos - TextWidth / 2, vep->sBottom - 3 - TextHeight, iPoints->Items[i]->Caption);   break;
                }
           }
     }

}

//===========================================================================
//==========      Отрисовка  подписей входов            =====================
//===========================================================================
void TElement::Draw_OutHint(TCanvas *aCanvas)
{
    if (!ShowInOutHint) return;

     TVisualElementParam *vep = VisualElementParam;   // --- Шоб меньше букв писать ------
     int xPos, yPos;

     SetTextAlign(aCanvas->Handle, TA_LEFT|TA_TOP|TA_NOUPDATECP);

     for (int i = 0; i < oPoints->Items_Count; i ++) {
           if (oPoints->Items[i]->Visible) {
                xPos = vep->sLeft + oPoints->Items[i]->xPos;
                yPos = vep->sTop  + oPoints->Items[i]->yPos;

                int TextHeight = aCanvas->TextHeight(oPoints->Items[i]->Caption);
                int TextWidth  = aCanvas->TextWidth (oPoints->Items[i]->Caption);

                switch (Orientation) {
                     case oRight  : aCanvas->TextOut(vep->sRight - 3 - TextWidth, yPos - TextHeight / 2, oPoints->Items[i]->Caption); break;
                     case oBottom : aCanvas->TextOut(xPos - TextWidth / 2, vep->sBottom - 3 - TextHeight, oPoints->Items[i]->Caption);    break;
                     case oLeft   : aCanvas->TextOut(vep->sLeft + 3, yPos - TextHeight / 2, oPoints->Items[i]->Caption); break;
                     case oTop    : aCanvas->TextOut(xPos - TextWidth / 2, vep->sTop + 3, oPoints->Items[i]->Caption);   break;
                }
           }
     }
}

//===========================================================================
//==========      Глобальная  Отрисовка =====================================
//===========================================================================
void TElement::Draw(TCanvas *aCanvas, int aParentId)
{
    if (aParentId != ParentId || ParentId == -1) return;


    Draw_Shadow (aCanvas);
    Draw_Caption(aCanvas);
    Draw_In     (aCanvas);
    Draw_Out    (aCanvas);

    aCanvas->Draw(VisualElementParam->sLeft , VisualElementParam->sTop, VisualElementParam->Bitmap);

   // --------- Отрисовка прямоугольника --- (прямокгольник процесса разработки) -----

    aCanvas->Brush->Color = pManagerParam->FonColor;
    Draw_InHint (aCanvas);
    Draw_OutHint(aCanvas);

//    if (SelectedParam.Selected) Draw_SelectedElement(aCanvas);   // ---- Если элемент выделен, то надо сделать соответствующие выводы ------

    fNeedRedraw = false;
}

//===========================================================================
//==========       Отрисовка выделенного битмапа    =========================
//===========================================================================
void TElement::Draw_SelectedElement(TCanvas *aCanvas)
{
    aCanvas->Pen->Mode    = pmNot;
    aCanvas->Pen->Color   = (TColor)RGB (255, 128, 0);
    aCanvas->Brush->Color = (TColor)RGB (255, 128, 0);

        aCanvas->Rectangle(VisualElementParam->sLeft  - 1, VisualElementParam->sTop    - 1, VisualElementParam->sLeft  + 4, VisualElementParam->sTop    + 4);
        aCanvas->Rectangle(VisualElementParam->sRight + 1, VisualElementParam->sTop    - 1, VisualElementParam->sRight - 4, VisualElementParam->sTop    + 4);
        aCanvas->Rectangle(VisualElementParam->sLeft  - 1, VisualElementParam->sBottom + 1, VisualElementParam->sLeft  + 4, VisualElementParam->sBottom - 4);
        aCanvas->Rectangle(VisualElementParam->sRight + 1, VisualElementParam->sBottom + 1, VisualElementParam->sRight - 4, VisualElementParam->sBottom - 4);

    aCanvas->Pen->Mode = pmCopy;
}

//===========================================================================
//=======     Определяю положение мыши относительно элемента ================
//===========================================================================
TBaseClass *TElement::WhereMouse(int aParentId, TMouseParam &mp, int xPos, int yPos)
{
    // ---- Обнуляем значения -----
        mp.ClearValues();

    // -------- Эсли чужой папа тогда нафиг --------
        if (aParentId != ParentId || ParentId == -1) return NULL;

    // --- Проверка углов -----
        if (SelectedParam.Selected) {

              if (xPos > VisualElementParam->sLeft  - 2  && yPos > VisualElementParam->sTop    - 2 && xPos < VisualElementParam->sLeft  + 4  && yPos < VisualElementParam->sTop    + 4) {
                  mp.Cursor   = crSizeNWSE;
                  mp.wm       = wmCorner;
                  mp.wmc      = wmcConerUpLeft;
                  return this;
              }
              if (xPos > VisualElementParam->sRight - 3  && yPos > VisualElementParam->sTop    - 2 && xPos < VisualElementParam->sRight + 2  && yPos < VisualElementParam->sTop    + 4) {
                  mp.Cursor = crSizeNESW;
                  mp.wm       = wmCorner;
                  mp.wmc      = wmcConerUpRight;
                  return this;
              }
              if (xPos > VisualElementParam->sLeft  - 2  && yPos > VisualElementParam->sBottom - 4 && xPos < VisualElementParam->sLeft  + 4  && yPos < VisualElementParam->sBottom + 2) {
                  mp.Cursor = crSizeNESW;
                  mp.wm       = wmCorner;
                  mp.wmc      = wmcConerDownLeft;
                  return this;
              }
              if (xPos > VisualElementParam->sRight - 4  && yPos > VisualElementParam->sBottom - 4 && xPos < VisualElementParam->sRight + 2  && yPos < VisualElementParam->sBottom + 2) {
                  mp.Cursor = crSizeNWSE;
                  mp.wm       = wmCorner;
                  mp.wmc      = wmcConerDownRight;
                  return this;
              }
        }
    // ---------------------------------------------------------
    // --- Проверка входов, выходов ----------------------------
    // ---------------------------------------------------------

         int axOffset, ayOffset;
         int axPos, ayPos;

      // ---- Эти смещения нужны для того, что бы вход и выход цеплялись подле элемента -------
         switch (Orientation) {
               case oRight  : axOffset =  4; ayOffset = 0; break;
               case oBottom : axOffset =  0; ayOffset = 4; break;
               case oLeft   : axOffset = -4; ayOffset = 0; break;
               case oTop    : axOffset =  0; ayOffset =-4; break;
         }
      // -----
         for (int i = 0; i < iPoints->Items_Count; i ++) {
               axPos = VisualElementParam->sLeft + iPoints->Items[i]->xPos + axOffset;
               ayPos = VisualElementParam->sTop  + iPoints->Items[i]->yPos + ayOffset;
               if (xPos > axPos -  5 && yPos > ayPos - 5 && xPos < axPos +  5 && yPos < ayPos + 5) {
                   if (iPoints->Items[i]->Conected) return NULL;
                   if (!iPoints->Items[i]->Visible) return NULL;

                   mp.Cursor   = crHandPoint;
                   mp.NumberIn = i;
                   mp.wm       = wmInPoint;
                   return this;
               }
         }
      // -----
         for (int i = 0; i < oPoints->Items_Count; i ++) {
               axPos = VisualElementParam->sLeft + oPoints->Items[i]->xPos - axOffset;
               ayPos = VisualElementParam->sTop  + oPoints->Items[i]->yPos - ayOffset;
               if (xPos > axPos -  5 && yPos > ayPos - 5 && xPos < axPos +  5 && yPos < ayPos + 5) {
                   if (!oPoints->Items[i]->Visible) return NULL;
                   mp.Cursor   = crHandPoint;
                   mp.NumberOut = i;
                   mp.wm       = wmOutPoint;
                   return this;
               }
         }

    // ----------------------------------
    // --- Ну наконецто самого галимого оставили на конец - догадайтесь кого ? - правильно, это элемент (Проверка на тело элемента)  ---
    // ----------------------------------
        if (xPos > VisualElementParam->sLeft  && yPos > VisualElementParam->sTop &&
            xPos < VisualElementParam->sRight && yPos < VisualElementParam->sBottom)
        {
            mp.wm       = wmElement;
            return this;
        }
        return NULL;

}

//===========================================================================
//=======   Отработка перемещения элемента ==================================
//===========================================================================
void TElement::MoveElement(TCanvas *aCanvas, int aOffsetX, int aOffsetY)
{
     if (VisualElementParam->sdRect.Left == -1) VisualElementParam->sdRect  = VisualElementParam->sRect;

     VisualElementParam->sdRect.Left   += aOffsetX;
     VisualElementParam->sdRect.Top    += aOffsetY;
     VisualElementParam->sdRect.Right  += aOffsetX;
     VisualElementParam->sdRect.Bottom += aOffsetY;

     aCanvas->Pen->Color   = clSilver;
     aCanvas->Pen->Style   = psDot;
     aCanvas->Pen->Mode    = pmNot;
     aCanvas->Brush->Style = bsClear;

     if (VisualElementParam->osdRect.Left != -1)
     aCanvas->Rectangle(VisualElementParam->osdRect);
     aCanvas->Rectangle(VisualElementParam->sdRect);

     VisualElementParam->osdRect = VisualElementParam->sdRect;

     NeedRedraw = true;
}

//===========================================================================
//=======   Конец обработки перемещения мыши  ===============================
//===========================================================================
void TElement::EndMoveElement()
{
     VisualElementParam->Left = VisualElementParam->sdRect.Left + VisualElementParam->OffsetX;
     VisualElementParam->Top  = VisualElementParam->sdRect.Top  + VisualElementParam->OffsetY;

     VisualElementParam->sdRect = Rect(-1,-1,-1,-1);
}
*/
//=======================================================================================================
//=======   Находится ли элемент в выделяем контуре , если есть то выделяем его и возвращаем правду =====
//=======================================================================================================
bool TElement::IsElementInSelectedRegion(int aParentId, int ax1, int ay1, int ax2, int ay2)
{
    if (aParentId != ParentId || ParentId == -1) return false;

    int MinX = min (ax1,  ax2);
    int MaxX = max (ax1,  ax2);
    int MinY = min (ay1,  ay2);
    int MaxY = max (ay1,  ay2);

    TmpiRect  sr = fVisualElementParam->sRect;
            if ( (sr.Bottom > MinY && sr.Top < MinY && sr.Right > MinX && sr.Left < MinX) ||
                 (sr.Bottom > MinY && sr.Top < MinY && sr.Right > MaxX && sr.Left < MaxX) ||
                 (sr.Bottom > MaxY && sr.Top < MaxY && sr.Right > MinX && sr.Left < MinX) ||
                 (sr.Bottom > MaxY && sr.Top < MaxY && sr.Right > MaxX && sr.Left < MaxX) ||

                 (sr.Bottom > MinY && sr.Top < MinY && sr.Right < MaxX && sr.Left > MinX) ||
                 (sr.Bottom > MaxY && sr.Top < MaxY && sr.Right < MaxX && sr.Left > MinX) ||
                 (sr.Bottom < MaxY && sr.Top > MinY && sr.Right > MinX && sr.Left < MinX) ||
                 (sr.Bottom < MaxY && sr.Top > MinY && sr.Right > MaxX && sr.Left < MaxX) ||

                 (sr.Bottom < MaxY && sr.Top > MinY && sr.Right > MaxX && sr.Left < MinX) ||
                 (sr.Bottom > MaxY && sr.Top < MinY && sr.Right < MaxX && sr.Left > MinX) ||

                 (sr.Bottom < MaxY && sr.Top > MinY && sr.Right < MaxX && sr.Left > MinX)
               ) { return true;}
    return false;
}

//===========================================================================
//===========   Установка разрера очереи данных  ============================
//===========================================================================
void __fastcall TElement::Set_Order(int aValue)
{
//    if (fOrder == aValue) return;

  // ------- Выставляю длину очериди  ---------
    fOrder = aValue;

    for (int i = 0; i < oPoints->Items_Count; i++)
            oPoints->Items[i]->SetQueueSize(aValue);

  // ------- Инициализирую очередь нулями ---------
    for (int i = 0; i < oPoints->Items_Count; i++)
        for (int k = 0; k < aValue; k++)
            oPoints->Items[i]->Queue[k] = 0;
}

//==============================================================================
//===========        Init элемента, Обязателен перед счетом елемента ===========
//==============================================================================
void TElement::Init()
{
  // -------- Обязательно выставляем размер очереди      ------
  // -------- По умолчанию он равен 1, если надо больше, ------
  // -------- то в дочерном елементе нужно указать какой ------
     Order = 1;

  // --------
     for (int i = 0; i < iPoints->Items_Count; i++)  {
        iPoints->Items[i]->EnableCalc = NULL; // ---- Очищаем указатель "возможности счета" по входу ---
        iPoints->Items[i]->Queue      = NULL; // ---- Очищаем указатель потока по входу ----------
     }
     for (int i = 0; i < oPoints->Items_Count; i++) *oPoints->Items[i]->EnableCalc = true;
}

//===========================================================================
//========================        Счет элемента   ============================
//===========================================================================
void TElement::Run()
{
   // ---------- Каждий метод дочерний RUN вызывает родительский для переприсвоения очереди ---------
    for (int i = 0; i < oPoints->Items_Count; i++)
        for (int k = 0; k < Order - 1; k++)
              oPoints->Items[i]->Queue[Order - 1 - k] = oPoints->Items[i]->Queue[Order - 2 - k];

}

//===========================================================================
//== Проверка можно ли считать елемент (задел для разнотактовой системы) ====
//===========================================================================
bool TElement::isEnabledCalc()
{
    // ---------- Опредиляем можно ли считать -------
       bool afEnableCalc = true;
       for (int i = 0; i < iPoints->Items_Count; i++)
          if (iPoints->Items[i]->EnableCalc != NULL)
             if (!*iPoints->Items[i]->EnableCalc) afEnableCalc = false;

    // ---------- Разрешаем или запрещаем счет по выходам елемента  --------------
       for (int i = 0; i < oPoints->Items_Count; i++)
            *oPoints->Items[i]->EnableCalc = afEnableCalc;

       return afEnableCalc;
}

//===========================================================================
//========================    Загрузка элемента из потока ===================
//===========================================================================
//===========================================================================
void TElement::LoadFromStream(FILE *aStream)  { TBaseClass::LoadFromStream(aStream);
///!!!!!!!!!!!!!!!!!!
/*   int TempInt;

   aStream->Read(&TempInt, sizeof(TempInt));  VisualElementParam->Left    = TempInt;
   aStream->Read(&TempInt, sizeof(TempInt));  VisualElementParam->Top     = TempInt;
   aStream->Read(&TempInt, sizeof(TempInt));  VisualElementParam->Width   = TempInt;
   aStream->Read(&TempInt, sizeof(TempInt));  VisualElementParam->Height  = TempInt;
   aStream->Read(&TempInt, sizeof(TempInt));  VisualElementParam->OffsetX = TempInt;
   aStream->Read(&TempInt, sizeof(TempInt));  VisualElementParam->OffsetY = TempInt;

   aStream->Read(&fOrientation, sizeof(TOrientation));

  // ----------------------------------------------------------------------------------
    if (ClassName != "TSubSystem") {
        int        aPointCount;
        AnsiString aCaptionString;
        bool       aVisible;

      // ---- Удаляю проинициализированы начально входы ---------
          while (iPoints->Items_Count != 0) iPoints->Delete(0);


      // ---- Загружаю входы --------
          aStream->Read(&aPointCount, sizeof(aPointCount));
          for (int i = 0; i < aPointCount; i++){
              LoadAnsiSringFromStream(aStream, aCaptionString);
              aStream->Read(&aVisible, sizeof(aVisible));

              iPoints->Add(aCaptionString);

              iPoints->Items[i]->Caption = aCaptionString;
              iPoints->Items[i]->Visible = aVisible;
          }

      // ----------------------------------------------------------------------------------
          while (oPoints->Items_Count != 0) oPoints->Delete(0);

          aStream->Read(&aPointCount, sizeof(aPointCount));
          for (int i = 0; i < aPointCount; i++){
              LoadAnsiSringFromStream(aStream, aCaptionString);
              aStream->Read(&aVisible, sizeof(aVisible));

              oPoints->Add(aCaptionString);

              oPoints->Items[i]->Caption = aCaptionString;
              oPoints->Items[i]->Visible = aVisible;
          }
    }

  // ----------------------------------------------------------------------------------
     aStream->Read(&fShowInOutHint, sizeof(fShowInOutHint));
     aStream->Read(&fShadow       , sizeof(fShadow));
     aStream->Read(&fDesignPhase  , sizeof(fDesignPhase));

  // ----------------------------------------------------------------------------------
     VisualElementParam->SetGraphicsParam();*/
}

//===========================================================================
//========================    Зaпись элемента в поток     ===================
//===========================================================================

void TElement::SaveToStream(FILE *aStream) { TBaseClass::SaveToStream(aStream);
///!!!!!!!!!!!!!!!!!!
/*   int TempInt;

   TempInt = VisualElementParam->Left;     aStream->Write(&TempInt, sizeof(TempInt));
   TempInt = VisualElementParam->Top;      aStream->Write(&TempInt, sizeof(TempInt));
   TempInt = VisualElementParam->Width  ;  aStream->Write(&TempInt, sizeof(TempInt));
   TempInt = VisualElementParam->Height ;  aStream->Write(&TempInt, sizeof(TempInt));
   TempInt = VisualElementParam->OffsetX;  aStream->Write(&TempInt, sizeof(TempInt));
   TempInt = VisualElementParam->OffsetY;  aStream->Write(&TempInt, sizeof(TempInt));

   aStream->Write(&fOrientation, sizeof(TOrientation));

  // ----------------------------------------------------------------------------------
    if (ClassName != "TSubSystem") {
        aStream->Write(&iPoints->Items_Count, sizeof(iPoints->Items_Count));
        for (int i = 0; i < iPoints->Items_Count; i++){
            SaveAnsiSringToStream(aStream, iPoints->Items[i]->Caption);
            aStream->Write(&iPoints->Items[i]->Visible, sizeof(iPoints->Items[i]->Visible));
        }

      // ----------------------------------------------------------------------------------
        aStream->Write(&oPoints->Items_Count, sizeof(oPoints->Items_Count));
        for (int i = 0; i < oPoints->Items_Count; i++){
            SaveAnsiSringToStream(aStream, oPoints->Items[i]->Caption);
            aStream->Write(&oPoints->Items[i]->Visible, sizeof(oPoints->Items[i]->Visible));
        }
    }
  // ----------------------------------------------------------------------------------
     aStream->Write(&fShowInOutHint, sizeof(fShowInOutHint));
     aStream->Write(&fShadow       , sizeof(fShadow));
     aStream->Write(&fDesignPhase  , sizeof(fDesignPhase));*/
}

//===========================================================================
void TElement::Copy(void *aElement) { TBaseClass::Copy(aElement);
///!!!!!!!!!!!!!!!!!!

     // ----- Собственно копирование елемента ---------------
     // ----- Нада вызвать, сделать методы копирования отдельно по входам и выходам элемента --------------

/*   TElement *el = (TElement*)aElement;

   // --- TVisualElementParam  -------------------------
      el->VisualElementParam->Width   = fVisualElementParam->Width;
      el->VisualElementParam->Height  = fVisualElementParam->Height;

      el->VisualElementParam->OffsetX = fVisualElementParam->OffsetX;
      el->VisualElementParam->OffsetY = fVisualElementParam->OffsetY;  // --- Смещения от скрольбаров (реальные, в смысле 0...9345342) ----

      // --- Ниже, те две строчки над, которыми надо подумать ---------    !!!!!!!!!!!!!!!!!!!!!!1
        el->VisualElementParam->Left    = fVisualElementParam->sdRect.Left;
        el->VisualElementParam->Top     = fVisualElementParam->sdRect.Top;
        fVisualElementParam->sdRect     = Rect(-1,-1,-1,-1);
         //ElementList[ElementList_Count - 1]->VisualElementParam->Left    = SelectedList[i]->VisualElementParam->sdRect.left;
         //ElementList[ElementList_Count - 1]->VisualElementParam->Top     = SelectedList[i]->VisualElementParam->sdRect.Top;
      //el->VisualElementParam->Left    = fVisualElementParam->Left;
      //el->VisualElementParam->Top     = fVisualElementParam->Top;

   // --- TElement ----
      el->fOrientation = fOrientation;

     // ---- Если не одинаковое количество входов и видов -----
         bool iPortsEqual = el->iPoints->Items_Count == iPoints->Items_Count;
         bool oPortsEqual = el->oPoints->Items_Count == oPoints->Items_Count;

         if (!iPortsEqual) while (el->iPoints->Items_Count != 0) el->iPoints->Delete(0);
         if (!oPortsEqual) while (el->oPoints->Items_Count != 0) el->oPoints->Delete(0);

      // --- input TPoints -----  *fInPoints ;   // --- Входы элемента  (In Points)-----

         for (int i = 0; i < iPoints->Items_Count; i++){
             if ( iPortsEqual) el->iPoints->Items[i]->Caption  = iPoints->Items[i]->Caption;
             if (!iPortsEqual) el->iPoints->Add(iPoints->Items[i]->Caption);
             el->iPoints->Items[i]->Visible  = iPoints->Items[i]->Visible;

             //el->iPoints->Items[i]->Conected = iPoints->Items[i]->Conected;
             el->iPoints->Items[i]->Conected = false; // !!!!!!!!!!!
         }

      // --- output TPoints -----  *fOnPoints ;   // --- Выходы элемента  (Out Points)-----
         for (int i = 0; i < oPoints->Items_Count; i++){
             if ( oPortsEqual) el->oPoints->Items[i]->Caption  = oPoints->Items[i]->Caption;
             if (!oPortsEqual) el->oPoints->Add(oPoints->Items[i]->Caption);
             el->oPoints->Items[i]->Visible  = oPoints->Items[i]->Visible;

             //el->oPoints->Items[i]->Conected = oPoints->Items[i]->Conected;
             el->oPoints->Items[i]->Conected = false;// !!!!!!!!!!!!!!!!!
         }


       el->ShowInOutHint      =  fShowInOutHint;
       el->Shadow             =  fShadow;
       el->CreateAdress       =  CreateAdress;
       el->pElementList       =  pElementList;
       el->pElementList_Count =  pElementList_Count;
       el->pLinkList          =  pLinkList;
       el->pLinkList_Count    =  pLinkList_Count;
*/
}

