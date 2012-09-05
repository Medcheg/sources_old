//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_Differ.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TDiffer_Init() { RegisterElement("DiALab - Базовые", "Линийные", (int)&TDiffer::Create); }
#pragma startup TDiffer_Init 110 // default 100
//===========================================================================
TDiffer::TDiffer()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Дифференциатор";
     Note        = "Дифференцирующее звено";
     CreateDate  = "05.01.2005";

     ShowCaption = false;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x");
     oPoints->Add("y");
  // ---------
     K  = 1;
  // ---------
}

//===========================================================================
void TDiffer::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K  , sizeof(K ));
}

//===========================================================================
void TDiffer::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K ));
}

//===========================================================================
void TDiffer::DrawElementFace()
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
void TDiffer::Edit() {
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &K;
        dlg->LabelArray[0]->Caption = "Коэффициент усиления дифференциатора (K) :";
        dlg->ParameteresCount       = 1;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TDiffer::Copy(void *aElement) { TElement::Copy(aElement);
   TDiffer *el = (TDiffer*)aElement;
   el->K  = K;
}

//===========================================================================
void TDiffer::Init() { TElement::Init();
  Order = 2;
}

//===========================================================================
void TDiffer::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------

      TFloat *iQueue = iPoints->Items[0]->Queue;
      TFloat *oQueue = oPoints->Items[0]->Queue;

      oQueue[0] = (iQueue[0] - iQueue[1]) / pProjectParam->AnalogT0;
}
//===========================================================================

