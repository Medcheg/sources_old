//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#pragma hdrstop

#include "M_Extrapoljator.h"               
#include "Unit_BaseDialog_01.h"
#include "math.h"
#pragma package(smart_init)

//=============================================================================
TExtrapoljator::TExtrapoljator()
{
     DefaultName = "Апериодическое звено";
     Note        = "";
     CreateDate  = "05.01.2005";

   // -------------- Зугрузка ресурса если он есть ----------

      ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
     K  = 1;
     T1 = 1;

}

//===========================================================================
void TExtrapoljator::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K  , sizeof(K ));
    aStream->Read(&T1 , sizeof(T1));
}

//===========================================================================
void TExtrapoljator::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K ));
    aStream->Write(&T1, sizeof(T1));
}

//===========================================================================
void TExtrapoljator::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;

      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;

      dbCanvas->Rectangle(0, 0, aw, ah);

   // -------------- Отрисовка ресурса если он есть ----------
      dbCanvas->Draw((aw - ResourseBitmapFaceElement->Width) / 2, (ah - ResourseBitmapFaceElement->Height) / 2,ResourseBitmapFaceElement);
}

//===========================================================================
void TExtrapoljator::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &K;
        dlg->ValueArray[1]          = &T1;
        dlg->LabelArray[0]->Caption = "Коэффициент усиления апериодического звена (K) :";
        dlg->LabelArray[1]->Caption = "Постоянная времени апериодического звена (T1) :";
        dlg->ParameteresCount       = 2;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TExtrapoljator::Init() { TElement::Init();
  Order = 2;

  A = T1 + *pAnalogT0 / 2.0;
  B =      *pAnalogT0 / 2.0 - T1;
  C =  K * *pAnalogT0 / 2.0;

  D1 = (T1 == 0) ? 0 : exp(-*pAnalogT0 / T1);
  K1 = K * (1 - D1);
}

//===========================================================================
void TExtrapoljator::Run()
{
      if (!*iPoints->Items[0]->EnableCalc) {
          *oPoints->Items[0]->EnableCalc = false;
          return;
      }
    // ---------- РОдиьельский Ран -------
      TElement::Run();
   // --------
      TFloat *iQueue = iPoints->Items[0]->Queue;
      TFloat *oQueue = oPoints->Items[0]->Queue;

      oQueue[0] = D1 * oQueue[1] + K1 * iQueue[0];
   // --------
      *oPoints->Items[0]->EnableCalc = true;
}

