//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_TDivider2.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TDivider2_Init() { RegisterElement("DiALab - Базовые", "Мат. операции", (int)&TDivider2::Create); }
#pragma startup TDivider2_Init 110 // default 100
//===========================================================================
TDivider2::TDivider2()
{
  // -------------- Зугрузка ресурса если он есть ----------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Делитель";
     Note        = "Делитель Y = X1 / X2";
     CreateDate  = "14.01.2005";

  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     iPoints->Add("x2");
     oPoints->Add("y");
  // ---------
}

//===========================================================================
void TDivider2::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TDivider2::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TDivider2::DrawElementFace()
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
void TDivider2::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ParameteresCount       = 0;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TDivider2::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TDivider2::Init() { TElement::Init();
}

//===========================================================================
void TDivider2::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      if (iPoints->Items[1]->Queue[0] != 0)
         oPoints->Items[0]->Queue[0] = iPoints->Items[0]->Queue[0] / iPoints->Items[1]->Queue[0];
      else
         oPoints->Items[0]->Queue[0] = MaxFloat;
}

