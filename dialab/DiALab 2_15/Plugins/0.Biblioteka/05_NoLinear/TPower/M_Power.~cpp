//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.hpp"
#pragma hdrstop

#include "M_Power.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TPower_Init() { RegisterElement("DiALab - Базовые", "Мат. операции", (int)&TPower::Create); }
#pragma startup TPower_Init 110 // default 100
//===========================================================================
TPower::TPower()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Возведение в степень";
     Note        = "";
     CreateDate  = "05.01.2005";

  // ---------
     DesignPhase = dpNeedModified;
     //DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
     N  = 1;
}

//===========================================================================
void TPower::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&N  , sizeof(N));
}

//===========================================================================
void TPower::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&N , sizeof(N));
}

//===========================================================================
void TPower::DrawElementFace()
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
void TPower::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &N;
        dlg->LabelArray[0]->Caption = "Коэффициент возведения в степень :";
        dlg->ParameteresCount       = 1;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TPower::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TPower::Init() { TElement::Init();
}

//===========================================================================
void TPower::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      try {
        int Znak = mpiSign(iPoints->Items[0]->Queue[0]);
        oPoints->Items[0]->Queue[0] = Power(Znak * iPoints->Items[0]->Queue[0], N);
        //oPoints->Items[0]->Queue[0] *= Znak;

      } catch ( ... ) {
          oPoints->Items[0]->Queue[0] = 0;
          //MessageDlg("Во время счета схемы на елементе <" + Caption + "> возникло числовое переполнение",mtError,TMsgDlgButtons() << mbOK, 0);
      }
}

