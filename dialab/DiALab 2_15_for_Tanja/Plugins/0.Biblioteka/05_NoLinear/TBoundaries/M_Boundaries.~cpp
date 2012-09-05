//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_Boundaries.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TBoundaries_Init() { RegisterElement("DiALab - Базовые", "Нелинийные", (int)&TBoundaries::Create); }
#pragma startup TBoundaries_Init 110 // default 100
//===========================================================================
TBoundaries::TBoundaries()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Ограничение";
     Note        = "";
     CreateDate  = "14.01.2005";

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x");
     oPoints->Add("y");
  // ---------
     K = 0;
     B = 0;
}

//===========================================================================
void TBoundaries::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K, sizeof(K));
    aStream->Read(&B, sizeof(B));
}

//===========================================================================
void TBoundaries::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K, sizeof(K ));
    aStream->Write(&B, sizeof(B));
}

//===========================================================================
void TBoundaries::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;

      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;

      dbCanvas->Rectangle(0, 0, aw, ah);

   // --------- Отрисовка прямоугольника --- (прямокгольник процесса разработки) -----
     if (DesignPhase != dpAllreadyTesting) {
         if (DesignPhase == dpNotTesting  ) {dbCanvas->Pen  ->Color = clRed;}
         if (DesignPhase == dpNeedModified) {dbCanvas->Pen  ->Color = clRed; dbCanvas->Pen  ->Style = psDot;}

         dbCanvas->Rectangle(2, 2, VisualElementParam->Width - 2, VisualElementParam->Height - 2);

         dbCanvas->Pen->Color = clBlack;
         dbCanvas->Pen->Style = psSolid;
      }   
   // -------------- Отрисовка ресурса если он есть ----------
      dbCanvas->Draw((aw - ResourseBitmapFaceElement->Width) / 2, (ah - ResourseBitmapFaceElement->Height) / 2,ResourseBitmapFaceElement);
}

//===========================================================================
void TBoundaries::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &B;
        dlg->ValueArray[1]          = &K;
        dlg->LabelArray[0]->Caption = "Величина ограничения :";
        dlg->LabelArray[1]->Caption = "Коэффициент наклона линейной характеристики :";
        dlg->ParameteresCount       = 2;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TBoundaries::Copy(void *aElement) { TElement::Copy(aElement);
   TBoundaries *el = (TBoundaries*)aElement;
   el->K = K;
   el->B = B;
}

//===========================================================================
void TBoundaries::Init() { TElement::Init();
  WasError = false;
  try {
     C = B / K;
  } catch ( ... ) {
     WasError = false;
     C    = 0;
  }
}

//===========================================================================
void TBoundaries::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      TFloat *iQueue = iPoints->Items[0]->Queue;
      TFloat *oQueue = oPoints->Items[0]->Queue;


      if ( WasError ) oQueue[0] = 0;
        else {
            if (fabs(iQueue[0]) <= C) oQueue[0] =  K * iQueue[0];
            if (     iQueue[0]  >  C) oQueue[0] =  B;
            if (     iQueue[0]  < -C) oQueue[0] = -B;
        }
}

