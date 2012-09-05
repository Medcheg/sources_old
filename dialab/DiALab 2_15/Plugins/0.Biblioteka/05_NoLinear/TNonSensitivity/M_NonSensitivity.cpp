//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_NonSensitivity.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TNonSensitivity_Init() { RegisterElement("DiALab - Базовые", "Нелинийные", (int)&TNonSensitivity::Create); }
#pragma startup TNonSensitivity_Init 110 // default 100
//===========================================================================
TNonSensitivity::TNonSensitivity()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Нечувствительность";
     Note        = "";
     CreateDate  = "15.01.2005";

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;

  // ---------
     iPoints->Add("x");
     oPoints->Add("y");

  // ---------
     K = 0;
     A = 0;
}

//===========================================================================
void TNonSensitivity::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K, sizeof(K));
    aStream->Read(&A, sizeof(A));
}

//===========================================================================
void TNonSensitivity::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K, sizeof(K));
    aStream->Write(&A, sizeof(A));
}

//===========================================================================
void TNonSensitivity::DrawElementFace()
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
void TNonSensitivity::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &A;
        dlg->ValueArray[1]          = &K;
        dlg->LabelArray[0]->Caption = "Зона нечувствительности :";
        dlg->LabelArray[1]->Caption = "Коэффициент наклона линейной характеристики :";
        dlg->ParameteresCount       = 2;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TNonSensitivity::Copy(void *aElement) { TElement::Copy(aElement);
   TNonSensitivity *el = (TNonSensitivity*)aElement;

   el->K = K;
   el->A = A;
}

//===========================================================================
void TNonSensitivity::Init() { TElement::Init();
}

//===========================================================================
void TNonSensitivity::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      TFloat *iQueue = iPoints->Items[0]->Queue;

      if (fabs(iQueue[0]) <= A) oPoints->Items[0]->Queue[0] = 0;
         else oPoints->Items[0]->Queue[0] = K * iQueue[0];
}

