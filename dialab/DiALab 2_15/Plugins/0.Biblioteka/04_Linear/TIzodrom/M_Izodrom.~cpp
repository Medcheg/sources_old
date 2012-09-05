//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================
#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_Izodrom.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TIzodrom_Init() { RegisterElement("DiALab - Базовые", "Линийные", (int)&TIzodrom::Create); }
#pragma startup TIzodrom_Init 110 // default 100
//===========================================================================
TIzodrom::TIzodrom()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Изодром";
     Note        = "";
     CreateDate  = "05.01.2005";

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
void TIzodrom::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K  , sizeof(K ));
    aStream->Read(&T1 , sizeof(T1));
}

//===========================================================================
void TIzodrom::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K ));
    aStream->Write(&T1, sizeof(T1));
}

//===========================================================================
void TIzodrom::DrawElementFace()
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
void TIzodrom::Edit()
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
void TIzodrom::Copy(void *aElement) { TElement::Copy(aElement);
   TIzodrom *el = (TIzodrom*)aElement;

   el->K  = K;
   el->T1 = T1;
}

//===========================================================================
void TIzodrom::Init() { TElement::Init();
  Order = 2;

  if (T1 == 0) {
      K1 = K2 = K;
  } else {
      K1 =  K + K * pProjectParam->AnalogT0 / 2.0 / T1;
      K2 =  K - K * pProjectParam->AnalogT0 / 2.0 / T1;
  }
}

//===========================================================================
void TIzodrom::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      TFloat *iQueue = iPoints->Items[0]->Queue;
      TFloat *oQueue = oPoints->Items[0]->Queue;


      oQueue[0] = oQueue[1] + K1 * iQueue[0] - K2 * iQueue[1];
}

