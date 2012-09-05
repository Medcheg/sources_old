//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================
#include <vcl.h>
#include "Math.h"
#pragma hdrstop

#include "M_ArcTanges.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TArcTanges_Init() { RegisterElement("DiALab - Базовые", "Тригонометрия", (int)&TArcTanges::Create); }
#pragma startup TArcTanges_Init 110 // default 100
//===========================================================================
TArcTanges::TArcTanges()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "АркТангес";
     Note        = "АркТангес (-pi/2 ... +pi/2), y = ArcTan( x )";
     CreateDate  = "13.01.2005";
  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x");
     oPoints->Add("y");
  // ---------
}

//===========================================================================
void TArcTanges::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TArcTanges::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TArcTanges::DrawElementFace()
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
void TArcTanges::Edit()
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
void TArcTanges::Copy(void *aElement) { TElement::Copy(aElement);
}

//===========================================================================
void TArcTanges::Init() { TElement::Init();
}

//===========================================================================
void TArcTanges::InitBeforeRun()
{
   iQueue = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
   oQueue = oPoints->Items[0]->Queue;
}

//===========================================================================
void TArcTanges::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------

      oQueue[0] = atan(iQueue[0]);
}

