//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_Aperiodic.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TAperiodic_Init() { RegisterElement("DiALab - Базовые", "Линийные", (int)&TAperiodic::Create); }
#pragma startup TAperiodic_Init 110 // default 100
//===========================================================================
TAperiodic::TAperiodic()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
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
     K  = 1;
     T1 = 1;
}

//===========================================================================
void TAperiodic::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K  , sizeof(K ));
    aStream->Read(&T1 , sizeof(T1));
}

//===========================================================================
void TAperiodic::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K ));
    aStream->Write(&T1, sizeof(T1));
}

//===========================================================================
void TAperiodic::DrawElementFace()
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
void TAperiodic::Edit()
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
void TAperiodic::Copy(void *aElement) { TElement::Copy(aElement);
   TAperiodic *el = (TAperiodic*)aElement;
   el->K  = K;
   el->T1 = T1;
}

//===========================================================================
void TAperiodic::Init() { TElement::Init();
  Order = 2;

  A = T1 + pProjectParam->AnalogT0 / 2.0;
  B =      pProjectParam->AnalogT0 / 2.0 - T1;
  C =  K * pProjectParam->AnalogT0 / 2.0;

  D1 = (T1 == 0) ? 0 : exp(-pProjectParam->AnalogT0 / T1);
  K1 = K * (1 - D1);
}


//===========================================================================
void TAperiodic::InitBeforeRun()
{
       iQueue = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
       oQueue = oPoints->Items[0]->Queue;
}
//===========================================================================
void TAperiodic::Run() { if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      oQueue[0] = D1 * oQueue[1] + K1 * iQueue[0];
   // --------------
}

