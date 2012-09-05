//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_ReleGisteresis.h"               
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TReleGisteresis_Init() { RegisterElement("DiALab - Базовые", "Нелинийные", (int)&TReleGisteresis::Create); }
#pragma startup TReleGisteresis_Init 110 // default 100
//===========================================================================
TReleGisteresis::TReleGisteresis()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Релейный элемент";
     Note        = "Релейный элемент (двухпозиционное поляризованное реле)";
     CreateDate  = "05.01.2005";

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
void TReleGisteresis::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&A, sizeof(A));
    aStream->Read(&B, sizeof(B));
}

//===========================================================================
void TReleGisteresis::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&A, sizeof(A));
    aStream->Write(&B, sizeof(B));
}

//===========================================================================
void TReleGisteresis::DrawElementFace()
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
void TReleGisteresis::Edit()
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
void TReleGisteresis::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TReleGisteresis::Init() { TElement::Init();
  Order = 2;
}

//===========================================================================
void TReleGisteresis::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      TFloat *iQueue = iPoints->Items[0]->Queue;
      TFloat *oQueue = oPoints->Items[0]->Queue;

      TFloat ZnakSpeed = iQueue[0] - iQueue[1];

      if (ZnakSpeed >  0) if (iQueue[0] >= A) oQueue[0] = B; else oQueue[0] = -B;
      if (ZnakSpeed <  0) if (iQueue[0] < -A) oQueue[0] = B; else oQueue[0] = -B;
      if (ZnakSpeed == 0)                     oQueue[0] = oQueue[1];
}

