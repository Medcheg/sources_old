//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_AperiodicForce1.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TAperiodicForce1_Init() { RegisterElement("DiALab - Базовые", "Линийные", (int)&TAperiodicForce1::Create); }
#pragma startup TAperiodicForce1_Init 110 // default 100
//===========================================================================
TAperiodicForce1::TAperiodicForce1()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Апериод. звено с форсир.";
     Note        = "Апериодическое звено с форсировкой";
     CreateDate  = "05.01.2005";

  // ---------
      DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
     K  = 1;
     T1 = 1;
     T2 = 1;
  // ---------
}

//===========================================================================
void TAperiodicForce1::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K  , sizeof(K ));
    aStream->Read(&T1 , sizeof(T1));
    aStream->Read(&T2 , sizeof(T2));
}

//===========================================================================
void TAperiodicForce1::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K ));
    aStream->Write(&T1, sizeof(T1));
    aStream->Write(&T2, sizeof(T2));
}

//===========================================================================
void TAperiodicForce1::DrawElementFace()
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
void TAperiodicForce1::Edit()
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
        dlg->LabelArray[0]->Caption = "Коэффициент усиления апериодического звена с форсировкой (K) :";
        dlg->LabelArray[1]->Caption = "Постоянная времени форсировки (T1) :";
        dlg->LabelArray[2]->Caption = "Постоянная времени апериодического звена  с форсировкой (T2) :";
        dlg->ParameteresCount       = 3;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
     // ------
        //if (T1 == 0) MessageDlg("При T1=0 перейдите на элемент : K*(1+T2*S)", mtError, TMsgDlgButtons() << mbOK, 0);

   } __finally { delete dlg; }
}

//===========================================================================
void TAperiodicForce1::Copy(void *aElement) { TElement::Copy(aElement);
   TAperiodicForce1 *el = (TAperiodicForce1*)aElement;
   el->K  = K;
   el->T1 = T1;
   el->T2 = T2;
}

//===========================================================================
void TAperiodicForce1::Init() { TElement::Init();
  Order = 2;

  Gamma1 = 2 * T1 / pProjectParam->AnalogT0;
  Gamma2 = 2 * T2 / pProjectParam->AnalogT0;
  D1     = (Gamma2 - 1) / (1 + Gamma2);
  D2     = K * (1 + Gamma1) / (1 + Gamma2);
  D3     = K * (1 - Gamma1) / (1 + Gamma2);

}

void TAperiodicForce1::InitBeforeRun()
{
   iQueue = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
   oQueue = oPoints->Items[0]->Queue;
//  if (T1 != T2) oPoints->Items[0]->Queue[0] = K * T2 / T1 * oPoints->Items[0]->Queue[0];
   Run();
}

//===========================================================================
void TAperiodicForce1::Run() { if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      oQueue[0] = D1 * oQueue[1] + D2 * iQueue[0] + D3 * iQueue[1];
   // --------------
}

