//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_ReleThird.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TReleThird_Init() { RegisterElement("DiALab - Базовые", "Нелинийные", (int)&TReleThird::Create); }
#pragma startup TReleThird_Init 110 // default 100
//===========================================================================
TReleThird::TReleThird()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Трехпозиционное реле";
     Note        = "";
     CreateDate  = "15.01.2005";

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x");
     oPoints->Add("y");
  // ---------
     A1 = 0.5;
     A2 = 1;
     B  = 1;
}

//===========================================================================
void TReleThird::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&A1  , sizeof(A1));
    aStream->Read(&A2  , sizeof(A2));
    aStream->Read(&B   , sizeof(B ));
}

//===========================================================================
void TReleThird::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&A1  , sizeof(A1));
    aStream->Write(&A2  , sizeof(A2));
    aStream->Write(&B   , sizeof(B ));
}

//===========================================================================
void TReleThird::DrawElementFace()
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
void TReleThird::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &A1;
        dlg->ValueArray[1]          = &A2;
        dlg->ValueArray[1]          = &B;
        dlg->LabelArray[0]->Caption = "Зона нечувствительности значение A1 :";
        dlg->LabelArray[1]->Caption = "Зона нечувствительности значение A2 :";
        dlg->LabelArray[2]->Caption = "Величина насыщение :";
        dlg->ParameteresCount       = 3;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TReleThird::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TReleThird::Init() { TElement::Init();
  Order = 2;
}

//===========================================================================
void TReleThird::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      TFloat *iQueue = iPoints->Items[0]->Queue;
      TFloat *oQueue = oPoints->Items[0]->Queue;

      TFloat ZnakSpeed = iQueue[0] - iQueue[1];

      if (ZnakSpeed > 0) {
         if (iQueue[0] >=  A2                   ) oQueue[0] =  B;
         if (iQueue[0] <   A2 && iQueue[0] > -A1) oQueue[0] =  0;
         if (iQueue[0] <= -A2                   ) oQueue[0] = -B;
      }
      if (ZnakSpeed < 0) {
         if (iQueue[0] >=  A1                   ) oQueue[0] =  B;
         if (iQueue[0] <   A1 && iQueue[0] > -A2) oQueue[0] =  0;
         if (iQueue[0] <= -A1                   ) oQueue[0] = -B;
      }
      if (ZnakSpeed == 0) oQueue[0] = oQueue[1];
}

