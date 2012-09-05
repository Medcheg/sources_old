//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_StartJump_and_Boundaries.h"               
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TStartJump_and_Boundaries_Init() { RegisterElement("DiALab - Базовые", "Нелинийные", (int)&TStartJump_and_Boundaries::Create); }
#pragma startup TStartJump_and_Boundaries_Init 110 // default 100
//===========================================================================
TStartJump_and_Boundaries::TStartJump_and_Boundaries()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Нач. скачок и ограничение";
     Note        = "";
     CreateDate  = "05.01.2005";

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
     K = 0;
     A = 0;
     B = 0;
}

//===========================================================================
void TStartJump_and_Boundaries::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K, sizeof(K));
    aStream->Read(&A, sizeof(A));
    aStream->Read(&B, sizeof(B));
}

//===========================================================================
void TStartJump_and_Boundaries::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K, sizeof(K));
    aStream->Write(&A, sizeof(A));
    aStream->Write(&B, sizeof(B));
}

//===========================================================================
void TStartJump_and_Boundaries::DrawElementFace()
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
void TStartJump_and_Boundaries::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &A;
        dlg->ValueArray[1]          = &B;
        dlg->ValueArray[2]          = &K;
        dlg->LabelArray[0]->Caption = "Величина скачка :";
        dlg->LabelArray[1]->Caption = "Величина ограничения :";
        dlg->LabelArray[2]->Caption = "Коэффициент наклона линейной характеристики :";

        dlg->ParameteresCount       = 3;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TStartJump_and_Boundaries::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TStartJump_and_Boundaries::Init() { TElement::Init();
  WasError = false;
  try {
     C = (B - A) / K;
  } catch ( ... ) {
     WasError = false;
     C    = 0;
  }
}

//===========================================================================
void TStartJump_and_Boundaries::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------

      TFloat *iQueue = iPoints->Items[0]->Queue;
      TFloat *oQueue = oPoints->Items[0]->Queue;


      if ( WasError ) oQueue[0] = A*mpiSign(iQueue[0]);
        else {
            if (iQueue[0] >   0 && iQueue[0] <= C) oQueue[0] =  A + K * iQueue[0];
            if (iQueue[0] >   C                  ) oQueue[0] =  B;
            if (iQueue[0] <  -C                  ) oQueue[0] = -B;
            if (iQueue[0] >= -C && iQueue[0] <  0) oQueue[0] = -A + K * iQueue[0];
        }
}

