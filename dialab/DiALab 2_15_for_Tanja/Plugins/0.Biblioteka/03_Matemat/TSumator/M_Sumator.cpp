//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "M_Sumator.h"
#include "mpiLink.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TSumator_Init() { RegisterElement("DiALab - Базовые", "Мат. операции", (int)&TSumator::Create); }
#pragma startup TSumator_Init 110 // default 100
//===========================================================================
TSumator::TSumator()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Сумматор";
     Note        = "Предназачен для сумирования (вычитания) сигналов входов элемента";
     CreateDate  = "26.12.2004";
  // ---------
     DesignPhase = dpAllreadyTesting;
  // ---------
     ShowCaption = false;
  // ---------
     VisualElementParam->Width  = 2.0 * 16;
     VisualElementParam->Height = 3.0 * 16;
  // ---------
     Formula     = NULL;
     fCountInput = 0;

  // --------- Добавляю один выход --------
     oPoints->Add("y");

  // ----------- Выставка параметров формулы (входов элемента) ---------
  // -------------------------------------------------------------------
  // ------ Для того, чтобы добавить или удалить входы сумматора -------
  // ------ необходимо -------------------------------------------------
  // ------ Свойству CountInput присваиваем количество входов , --------
  // ------ А после этого назаначаем формуле "знаки" -------------------
  // -------------------------------------------------------------------
     CountInput = 2;
     Formula[0] = 1;   Formula[1] = 1;
}

//===========================================================================
TSumator::~TSumator()
{
  free (Formula);
}

//===========================================================================
void TSumator::LoadFromStream(TStream *aStream) {
          int aCountInput;

   // ------ Перед загрузкой удаляю ввсе входы -------
          CountInput = 0;

   // ---- Загружаю по родительской очереди ----------
          TElement::LoadFromStream(aStream);

          aStream->Read(&aCountInput, sizeof(aCountInput));

      // ---- Удаляю проинициализированы начально входы ---------
          while (iPoints->Items_Count != 0) iPoints->Delete(0);

      // ---- Сношу загруженные выходы ------

          CountInput = aCountInput;
          aStream->Read( Formula    , sizeof(int)*fCountInput);
}

//===========================================================================
void TSumator::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
      aStream->Write(&fCountInput, sizeof(fCountInput));
      aStream->Write( Formula    , sizeof(int)*fCountInput);
}

//===========================================================================
void TSumator::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;
  // --------
      int x1 = 0.35 * aw;
      int y1 = 0.32 * ah;
      int x2 = 0.35 * aw;
      int y2 = 0.50  * ah;
      int x3 = x2 + (aw - x2 - x1) / 2;
  // --------
      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;
  // --------
      dbCanvas->Rectangle(0, 0, aw, ah);
   // --------- Отрисовка прямоугольника --- (прямокгольник процесса разработки) -----
     if (DesignPhase != dpAllreadyTesting) {
         if (DesignPhase == dpNotTesting  ) {dbCanvas->Pen  ->Color = clRed;}
         if (DesignPhase == dpNeedModified) {dbCanvas->Pen  ->Color = clRed; dbCanvas->Pen  ->Style = psDot;}

         dbCanvas->Rectangle(2, 2, VisualElementParam->Width - 2, VisualElementParam->Height - 2);

         dbCanvas->Pen->Color = clBlack;
         dbCanvas->Pen->Style = psSolid;
      }   
  // --------
      dbCanvas->Pen->Width = 1;
      dbCanvas->MoveTo(aw - x1,      1.1*y1);
      dbCanvas->LineTo(aw - x1,          y1);
      dbCanvas->LineTo(x2     ,          y1);
      dbCanvas->LineTo(x3     ,          y2);
      dbCanvas->LineTo(x2     , ah -     y1);
      dbCanvas->LineTo(aw - x1, ah -     y1);
      dbCanvas->LineTo(aw - x1, ah - 1.1*y1);
      dbCanvas->Pen->Width = 1;
}

//===========================================================================
void TSumator::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;

     // ------
        AnsiString FormulaString = "";
        for (int i = 0; i < iPoints->Items_Count; i++) {
               if (Formula[i] ==  1) FormulaString += "+";
               if (Formula[i] == -1) FormulaString += "-";
        }
     // ------
        dlg->EditArray [0]->Text    = FormulaString;
        dlg->LabelArray[0]->Caption = "Коэффициенты сумматора";
        dlg->ParameteresCount       = 1;
        dlg->BaseDialogFormStyle    = bdfsSumator;
     // ------
        dlg->ShowModal();

     // ------ Выставка нового количества входов ------
        CountInput = dlg->EditArray[0]->Text.Length();

     // ------ Растановка значений формулы ----------
        for (int i = 0; i < CountInput; i++) {
           if (dlg->EditArray[0]->Text[i+1] == '+') Formula[i] =  1;
           if (dlg->EditArray[0]->Text[i+1] == '-') Formula[i] = -1;
        }
     // ------
   } __finally { delete dlg; }
}

//===========================================================================
void TSumator::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void __fastcall TSumator::Set_CountInput(int aCountInput)
{
     if (fCountInput == aCountInput) {
            NeedRedraw = true;
            VisualElementParam->SetGraphicsParam();
       return;
     }


  // ---- Ресайз формулы -----------
     Formula = (int*) realloc (Formula, sizeof(int) * aCountInput);

     // ---- Если элементов стало больше ----------
       if (fCountInput < aCountInput)
           for (int i = fCountInput; i < aCountInput; i++)
               iPoints->Add("Вход №" + IntToStr(i + 1));

     // ---- Если элементов стало меньше ----------
       if (fCountInput > aCountInput)
           while (iPoints->Items_Count != aCountInput) {
                if (iPoints->Items[aCountInput]->Conected) {
                   ((TLink*)iPoints->Items[aCountInput]->CurrentLink)->SecondElement = NULL;
                   ((TLink*)iPoints->Items[aCountInput]->CurrentLink)->NumberInput   = -1;
                }
                iPoints->Delete(aCountInput);
           }

     // --------
       fCountInput = aCountInput;
}

//===========================================================================
void TSumator::Init() { TElement::Init();
}

//===========================================================================
void   TSumator::Draw(TCanvas *aCanvas, int aParentId) {

    if (aParentId != ParentId || ParentId == -1) return;

       TElement::Draw(aCanvas, aParentId);

       int x1, x2, y1, y2;
       TPoint l, r, t, b;

       aCanvas->Pen->Color = clBlack;

       for (int i = 0; i < CountInput; i++) {
           l =  Point(0,0);
           r =  Point(0,0);
           t =  Point(0,0);
           b =  Point(0,0);

           switch (Orientation){
             case oRight : l = Point(VisualElementParam->sLeft + 3    , VisualElementParam->sTop + iPoints->Items[i]->yPos);
                           r = Point(VisualElementParam->sLeft + 3 + 5, VisualElementParam->sTop + iPoints->Items[i]->yPos);
                           if (Formula[i] == 1) {
                                  t = Point(VisualElementParam->sLeft + 3 + 2, VisualElementParam->sTop + iPoints->Items[i]->yPos - 2);
                                  b = Point(VisualElementParam->sLeft + 3 + 2, VisualElementParam->sTop + iPoints->Items[i]->yPos + 2 + 1);
                           } break;
             case oBottom : l = Point(VisualElementParam->sLeft + iPoints->Items[i]->xPos - 2    , VisualElementParam->sTop + 3 + 3);
                            r = Point(VisualElementParam->sLeft + iPoints->Items[i]->xPos - 2 + 5, VisualElementParam->sTop + 3 + 3);
                            if (Formula[i] == 1) {
                                  t = Point(VisualElementParam->sLeft + iPoints->Items[i]->xPos - 0, VisualElementParam->sTop + 3 + 5);
                                  b = Point(VisualElementParam->sLeft + iPoints->Items[i]->xPos - 0, VisualElementParam->sTop + 3);
                            } break;
             case oLeft  :  l = Point(VisualElementParam->sRight - 3    , VisualElementParam->sTop + iPoints->Items[i]->yPos);
                            r = Point(VisualElementParam->sRight - 3 - 5, VisualElementParam->sTop + iPoints->Items[i]->yPos);
                            if (Formula[i] == 1) {
                                  t = Point(VisualElementParam->sRight - 3 - 2, VisualElementParam->sTop + iPoints->Items[i]->yPos - 2);
                                  b = Point(VisualElementParam->sRight - 3 - 2, VisualElementParam->sTop + iPoints->Items[i]->yPos + 2 + 1);
                            } break;
             case oTop   :  l = Point(VisualElementParam->sLeft + iPoints->Items[i]->xPos - 2    , VisualElementParam->sBottom - 3 - 3);
                            r = Point(VisualElementParam->sLeft + iPoints->Items[i]->xPos - 2 + 5, VisualElementParam->sBottom - 3 - 3);
                            if (Formula[i] == 1) {
                                  t = Point(VisualElementParam->sLeft + iPoints->Items[i]->xPos - 0, VisualElementParam->sBottom - 3 - 5);
                                  b = Point(VisualElementParam->sLeft + iPoints->Items[i]->xPos - 0, VisualElementParam->sBottom - 3);
                            } break;
           }

           aCanvas->MoveTo(l.x, l.y); aCanvas->LineTo(r.x, r.y);
           aCanvas->MoveTo(t.x, t.y); aCanvas->LineTo(b.x, b.y);
       }
}


//===========================================================================
void TSumator::Run()
{     if (!isEnabledCalc(&isEnabledOneCalc)) if (!isEnabledOneCalc) return; TElement::Run();
   // --------------

        TFloat *oQueue = oPoints->Items[0]->Queue;
        TFloat *iQueue;
        TFloat  aSum   = 0;

        for (int i = 0; i < iPoints->Items_Count; i ++){
             iQueue = iPoints->Items[i]->Queue;

            // ---- Если входа нет , то он равен 0 ------
             TFloat CurrentInputValue = (iQueue == NULL || *iPoints->Items[i]->EnableCalc == false)? 0 : iQueue[0];

             aSum += Formula[i] * CurrentInputValue;
        }

        oQueue[0] = aSum;
}

