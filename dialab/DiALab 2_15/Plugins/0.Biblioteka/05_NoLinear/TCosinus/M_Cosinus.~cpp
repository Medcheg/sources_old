//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_Cosinus.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TCosinus_Init() { RegisterElement("DiALab - Базовые", "Тригонометрия", (int)&TCosinus::Create); }
#pragma startup TCosinus_Init 110 // default 100
//===========================================================================
TCosinus::TCosinus()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Косинус";
     Note        = "y = cos( x )";
     CreateDate  = "14.01.2005";

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
void TCosinus::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TCosinus::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TCosinus::DrawElementFace()
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
void TCosinus::Edit()
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
void TCosinus::Copy(void *aElement) { TElement::Copy(aElement);
}

//===========================================================================
void TCosinus::Init() { TElement::Init();
}

//===========================================================================
void TCosinus::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      oPoints->Items[0]->Queue[0] = cos(iPoints->Items[0]->Queue[0]);
}

