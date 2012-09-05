//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_ReleNonSensitivity.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TReleNonSensitivity_Init() { RegisterElement("DiALab - Базовые", "Нелинийные", (int)&TReleNonSensitivity::Create); }
#pragma startup TReleNonSensitivity_Init 110 // default 100
//===========================================================================
TReleNonSensitivity::TReleNonSensitivity()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Реле";
     Note        = "Реле с зоной нечуствительности и насыщением";
     CreateDate  = "15.01.2005";

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
     A = 1;
     B = 1;
}

//===========================================================================
void TReleNonSensitivity::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&A, sizeof(A));
    aStream->Read(&B, sizeof(B));
}

//===========================================================================
void TReleNonSensitivity::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&A, sizeof(A));
    aStream->Write(&B, sizeof(B));
}

//===========================================================================
void TReleNonSensitivity::DrawElementFace()
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
void TReleNonSensitivity::Edit()
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
        dlg->LabelArray[0]->Caption = "Зона нечувствительности :";
        dlg->LabelArray[1]->Caption = "Величина насыщение :";
        dlg->ParameteresCount       = 2;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TReleNonSensitivity::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TReleNonSensitivity::Init() { TElement::Init();
}

//===========================================================================
void TReleNonSensitivity::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      TFloat *iQueue = iPoints->Items[0]->Queue;

      if (     iQueue[0] >=  A) oPoints->Items[0]->Queue[0] =  B;
      if (fabs(iQueue[0]) <  A) oPoints->Items[0]->Queue[0] =  0;
      if (     iQueue[0] <= -A) oPoints->Items[0]->Queue[0] = -B;
}

