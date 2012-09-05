//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "M_Multiplier.h"
#include "mpiLink.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TMultiplier_Init() { RegisterElement("DiALab - Базовые", "Мат. операции", (int)&TMultiplier::Create); }
#pragma startup TMultiplier_Init 110 // default 100
//===========================================================================
TMultiplier::TMultiplier()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Умножитель";
     Note        = "Предназачен для перемножения (между собой) сигналов входов элемента";
     CreateDate  = "07.02.2005";
  // ---------
     DesignPhase = dpAllreadyTesting;
  // ---------
     ShowCaption = false;
  // ---------
     VisualElementParam->Width  = 2.0 * 16;
     VisualElementParam->Height = 2.0 * 16;
  // ---------

  // --------- Добавляю один выход --------
     fCountInput = 0;
     CountInput = 2;
     oPoints->Add("y");
}

//===========================================================================
TMultiplier::~TMultiplier()
{
}

//===========================================================================
void TMultiplier::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&fCountInput, sizeof(fCountInput));
}

//===========================================================================
void TMultiplier::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&fCountInput, sizeof(fCountInput));
}

//===========================================================================
void TMultiplier::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;
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
      dbCanvas->Brush->Color = clBlack;
      dbCanvas->Ellipse(aw / 2 - 3, ah / 2 - 3, aw / 2 + 3, ah / 2 + 3);
}

//===========================================================================
void TMultiplier::Edit()
{
   TfrmBaseDialog1 *dlg;
   TFloat           aCountInput = iPoints->Items_Count;
   try {
         dlg = new TfrmBaseDialog1(NULL);
         dlg->Element            = this;
         dlg->GroupBox1->Caption = DefaultName;
         dlg->lTitle   ->Caption = Note;

     // ------
         dlg->LabelArray[0]->Caption = "Количество входов умножителя";
         dlg->ValueArray[0]          = &aCountInput;
         dlg->ParameteresCount       = 1;
         dlg->BaseDialogFormStyle    = bdfsIntegerValues;
         
     // ------
        dlg->ShowModal();
     // ------

       // fCountInput = 0;
        CountInput  = (aCountInput >= 2) ? aCountInput : 2;

    // ------
   } __finally { delete dlg; }
}

//===========================================================================
void TMultiplier::Copy(void *aElement) { TElement::Copy(aElement);
   TMultiplier *el = (TMultiplier*)aElement;

   el->fCountInput = fCountInput;
}

//===========================================================================
void __fastcall TMultiplier::Set_CountInput(int aCountInput)
{
     if (fCountInput == aCountInput) return;

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
void TMultiplier::Init() { TElement::Init();
     NullValue = 0;
}

//===========================================================================
void   TMultiplier::Draw(TCanvas *aCanvas, int aParentId) { TElement::Draw(aCanvas, aParentId);
}


//===========================================================================
void TMultiplier::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


       TFloat *oQueue  = oPoints->Items[0]->Queue;

       oQueue[0] = 1;

       for (int i = 0; i < iPoints->Items_Count; i++)
           if (iPoints->Items[i]->Queue != NULL) oQueue[0] *= iPoints->Items[i]->Queue[0];
}

