//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "Math.h"
#include "Math.hpp"
#pragma hdrstop

#include "Unit_BaseDialog_01.h"
#include "M_ArcTanges360.h"
//===========================================================================
void TArcTanges360_Init() { RegisterElement("DiALab - Базовые", "Тригонометрия", (int)&TArcTanges360::Create); }
#pragma startup TArcTanges360_Init 110 // default 100
//===========================================================================
TArcTanges360::TArcTanges360()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "АркТангес (0...+2*pi)";
     Note        = "выход = ArcTan( y / x )";
     CreateDate  = "13.01.2005";
  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("х");
     iPoints->Add("у");
     oPoints->Add("выход");
}

//===========================================================================
void TArcTanges360::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TArcTanges360::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TArcTanges360::DrawElementFace()
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
void TArcTanges360::Edit()
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
void TArcTanges360::Copy(void *aElement) { TElement::Copy(aElement);
}

//===========================================================================
void TArcTanges360::Init() { TElement::Init();

}

//===========================================================================
void TArcTanges360::InitBeforeRun()
{
   iQueue1 = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
   iQueue2 = (iPoints->Items[1]->Queue) ? iPoints->Items[1]->Queue : &ZerroValue;
   oQueue   = oPoints->Items[0]->Queue;
}

//===========================================================================
void TArcTanges360::Run() { if (!isEnabledCalc()) return; TElement::Run();
   // --------
      if (iQueue2[0] == 0 && iQueue1[0] == 0)  {oQueue[0] =  0; return; } /// --- Неопредиленное значение ---

      if (iQueue2[0] >  0 && iQueue1[0] == 0)  {oQueue[0] = 0;            return; }
      if (iQueue2[0] <  0 && iQueue1[0] == 0)  {oQueue[0] = pi;           return; }
      if (iQueue2[0] == 0 && iQueue1[0] >  0)  {oQueue[0] = pi_div_2;     return; }
      if (iQueue2[0] == 0 && iQueue1[0] <  0)  {oQueue[0] = tri_pi_div_2; return; }

      oQueue[0] =  atan(fabs(iQueue2[0] / iQueue1[0]));

      if (iQueue2[0] > 0 && iQueue1[0] > 0)  oQueue[0] =          oQueue[0];
      if (iQueue2[0] > 0 && iQueue1[0] < 0)  oQueue[0] = two_pi - oQueue[0];
      if (iQueue2[0] < 0 && iQueue1[0] < 0)  oQueue[0] = pi     + oQueue[0];
      if (iQueue2[0] < 0 && iQueue1[0] > 0)  oQueue[0] = pi     - oQueue[0];


/*       if (iQueue2[0] < 0) oQueue[0] = atan(iQueue1[0] / iQueue2[0]) + M_PI;
          else if (iQueue2[0] < 0) oQueue[0] = atan(iQueue1[0] / iQueue2[0]);
              else oQueue[0] = atan(iQueue1[0] / iQueue2[0]) + 2*M_PI;
*/
}

