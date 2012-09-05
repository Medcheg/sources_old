//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================
#include <vcl.h>
#include "math.hpp"
#include "math.h"
#pragma hdrstop

#include "M_Luft.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TLuft_Init() { RegisterElement("DiALab - Базовые", "Нелинийные", (int)&TLuft::Create); }
#pragma startup TLuft_Init 110 // default 100
//===========================================================================
TLuft::TLuft()
{
     DefaultName = "Апериодическое звено";
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

}

//===========================================================================
void TLuft::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K, sizeof(K));
    aStream->Read(&A, sizeof(A));
}

//===========================================================================
void TLuft::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K, sizeof(K));
    aStream->Write(&A, sizeof(A));
}

//===========================================================================
void TLuft::DrawElementFace()
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
void TLuft::Edit()
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
        dlg->LabelArray[0]->Caption = "Зона люфта :";
        dlg->LabelArray[1]->Caption = "Коэффициент наклона линейной характеристики :";
        dlg->ParameteresCount       = 2;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TLuft::Copy(void *aElement) { TElement::Copy(aElement);
   TLuft *el = (TLuft*)aElement;

   el->K = K;
   el->A = A;
}

//===========================================================================
void TLuft::Init() { TElement::Init();
  C = A * K;
}

//===========================================================================
void TLuft::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      x1 =      iPoints->Items[0]->Queue[0];
      x2 = x1 - iPoints->Items[0]->Queue[1];

      if (x2 == 0) oPoints->Items[0]->Queue[0] = - C * mpiSign(x1) + K * x1;
      if (x2  > 0) oPoints->Items[0]->Queue[0] = - C               + K * x1;
      if (x2  < 0) oPoints->Items[0]->Queue[0] =   C               + K * x1;
}

