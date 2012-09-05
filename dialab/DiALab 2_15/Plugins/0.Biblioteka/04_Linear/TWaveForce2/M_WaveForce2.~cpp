//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_WaveForce2.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TWaveForce2_Init() { RegisterElement("DiALab - Базовые", "Линийные", (int)&TWaveForce2::Create); }
#pragma startup TWaveForce2_Init 110 // default 100
//===========================================================================
TWaveForce2::TWaveForce2()
{
  // -------------- Зугрузка ресурса если он есть ----------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Колебательное звено с ФФП";
     Note        = "Колебательное звено с форсировкой второго порядка";
     CreateDate  = "05.01.2005";

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
     K  = 1;
     T1   = 1;
     T2   = 1;
     Ksi1 = 0.5;
     Ksi2 = 0.5;
  // ---------
}

//===========================================================================
void TWaveForce2::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K   , sizeof(K ));
    aStream->Read(&T1  , sizeof(T1));
    aStream->Read(&T2  , sizeof(T2));
    aStream->Read(&Ksi1, sizeof(Ksi1));
    aStream->Read(&Ksi2, sizeof(Ksi2));
}

//===========================================================================
void TWaveForce2::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K ));
    aStream->Write(&T1, sizeof(T1));
    aStream->Write(&T2, sizeof(T2));
    aStream->Write(&Ksi1, sizeof(Ksi1));
    aStream->Write(&Ksi2, sizeof(Ksi2));
}

//===========================================================================
void TWaveForce2::DrawElementFace()
{
      TCanvas    *dbCanvas         = VisualElementParam->Bitmap->Canvas;
      int         aw               = VisualElementParam->Width;
      int         ah               = VisualElementParam->Height;
   // ---------
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
void TWaveForce2::Edit()
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
        dlg->ValueArray[2]          = &T2;
        dlg->ValueArray[3]          = &Ksi1;
        dlg->ValueArray[4]          = &Ksi2;
        dlg->LabelArray[0]->Caption = "Коэффициент усиления колебательного звена (K) :";
        dlg->LabelArray[1]->Caption = "Постоянная времени колебательного звена (T1) :";
        dlg->LabelArray[2]->Caption = "Постоянная времени форсировки колебательного звена (T2) :";
        dlg->LabelArray[3]->Caption = "Коэффициент демпфирования колебательного звена (Ksi1) :";
        dlg->LabelArray[4]->Caption = "Коэффициент демпфирования колебательного звена (Ksi2) :";

        dlg->ParameteresCount       = 5;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TWaveForce2::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TWaveForce2::Init() { TElement::Init();
  Order = 3;

  if (fabs(Ksi1) > 1.0) Ksi1 = 1.0;

  try { B1 = 2*exp(-Ksi1* pProjectParam->AnalogT0/T1)*cos( pProjectParam->AnalogT0/T1*sqrt(1-Ksi1*Ksi1)); } catch ( ... ) { B1 = 0; };
  try { B2 = 2*exp(-Ksi2* pProjectParam->AnalogT0/T2)*cos( pProjectParam->AnalogT0/T2*sqrt(1-Ksi2*Ksi2)); } catch ( ... ) { B2 = 0; };
  try { D1 = exp(-2*Ksi1* pProjectParam->AnalogT0/T1); } catch ( ... ) { D1 = 0; };
  try { D2 = exp(-2*Ksi2* pProjectParam->AnalogT0/T2); } catch ( ... ) { D2 = 0; };

  K1 = (1-B1+D1) / (1-B2+D2);
  K2 = K1 * B2;
  K3 = K1 * D2;
}

//===========================================================================
void TWaveForce2::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------

      TFloat *iQueue = iPoints->Items[0]->Queue;
      TFloat *oQueue = oPoints->Items[0]->Queue;

      oQueue[0] = -999;
      oQueue[0] = B1 * oQueue[1] - D1 * oQueue[2] + K1 * iQueue[0] - K2 * iQueue[1] + K3 * iQueue[2];
}

