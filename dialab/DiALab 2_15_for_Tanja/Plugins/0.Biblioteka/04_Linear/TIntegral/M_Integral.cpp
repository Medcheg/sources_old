//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
//#include <typeinfo.h>
#pragma hdrstop

#include "M_Integral.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TIntegral_Init() { RegisterElement("DiALab - Базовые", "Линийные", (int)&TIntegral::Create); }
#pragma startup TIntegral_Init 110 // default 100
//===========================================================================
TIntegral::TIntegral()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Интегрирующее звено";
     Note        = "Предназначен для интегрирования входного сигнала";
     CreateDate  = "05.01.2005";

     ShowCaption = false;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");

     oPoints->Add("y1");
  // ---------
     K  = 1;
     C0 = 0;
  // ---------
}

//===========================================================================
void TIntegral::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K , sizeof(K ));
    aStream->Read(&C0, sizeof(C0));
}

//===========================================================================
void TIntegral::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K ));
    aStream->Write(&C0, sizeof(C0));
}

//===========================================================================
void TIntegral::DrawElementFace()
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
void TIntegral::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &K;
        dlg->ValueArray[1]          = &C0;
        dlg->LabelArray[0]->Caption = "Коэффициент усиления интегрирующего звена :";
        dlg->LabelArray[1]->Caption = "Начальное условие :";
        dlg->ParameteresCount       = 2;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TIntegral::Copy(void *aElement) { TElement::Copy(aElement);
   TIntegral *el = (TIntegral*)aElement;

   el->K  = K;
   el->C0 = C0;
}

//===========================================================================
void TIntegral::Init() { TElement::Init();
     Order = 2;

     K_AnalogT0_05 = K * pProjectParam->AnalogT0 / 2.0;
}


void TIntegral::InitBeforeRun()
{
  // -------------
     iQueue = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
     oQueue = oPoints->Items[0]->Queue;
  // ---- Начальные условия ----
     oPoints->Items[0]->Queue[0] = C0;
}

//===========================================================================
void TIntegral::Run() { if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      oQueue[0] = oQueue[1] +  K_AnalogT0_05 *(iQueue[0] + iQueue[1]);

      //oQueue[0] = oQueue[1] +  pProjectParam->AnalogT0 * iQueue[1];
   // --------------
}

