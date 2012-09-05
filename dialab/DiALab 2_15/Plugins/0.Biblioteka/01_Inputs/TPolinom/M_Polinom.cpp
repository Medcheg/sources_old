//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "Math.hpp"
#pragma hdrstop

#include "M_Polinom.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TPolinom_Init() { RegisterElement("DiALab - Базовые", "Входы", (int)&TPolinom::Create); }
#pragma startup TPolinom_Init // default 100
//===========================================================================
TPolinom::TPolinom()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Полином";
     Note        = "... Нет данных ...";
     CreateDate  = "01.12.2004";

  // ---------
     DesignPhase = dpAllreadyTesting;

  // --------- Коэффициенты поллтнома ------
     Polinom[0] = 1.0;
     Polinom[1] = 0.0;
     Polinom[2] = 0.0;
     Polinom[3] = 0.0;
     Polinom[4] = 0.0;
     Polinom[5] = 0.0;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;

     oPoints->Add("y");
  // ---------
}

//===========================================================================
void TPolinom::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&Polinom, sizeof(Polinom));
}

//===========================================================================
void TPolinom::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&Polinom, sizeof(Polinom));
}

//===========================================================================
void TPolinom::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width ;
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

      dbCanvas->MoveTo(5, 2     );   dbCanvas->LineTo(5, ah - 2);
      dbCanvas->MoveTo(2, ah - 5);   dbCanvas->LineTo(aw - 2, ah - 5);

      dbCanvas->Pen->Color = clBlue;
      dbCanvas->MoveTo(8, ah - 10);   dbCanvas->LineTo(aw - 4, 6);

      dbCanvas->Pen->Color = clBlack;
}

//===========================================================================
void TPolinom::Init() { TElement::Init();
}


//===========================================================================
void TPolinom::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &Polinom[0];
        dlg->ValueArray[1]          = &Polinom[1];
        dlg->ValueArray[2]          = &Polinom[2];
        dlg->ValueArray[3]          = &Polinom[3];
        dlg->ValueArray[4]          = &Polinom[4];
        dlg->ValueArray[5]          = &Polinom[5];
        dlg->LabelArray[0]->Caption = "Коэффициент полинома [C0] при t^0";
        dlg->LabelArray[1]->Caption = "Коэффициент полинома [С1] при t^1";
        dlg->LabelArray[2]->Caption = "Коэффициент полинома [C2] при t^2";
        dlg->LabelArray[3]->Caption = "Коэффициент полинома [C3] при t^3";
        dlg->LabelArray[4]->Caption = "Коэффициент полинома [C4] при t^4";
        dlg->LabelArray[5]->Caption = "Коэффициент полинома [C5] при t^5";
        dlg->ParameteresCount       = 6;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
     // ------
   } __finally { delete dlg; }
}


//===========================================================================
void TPolinom::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TPolinom::InitBeforeRun()
{
/*   for (int i = Order - 1; i >= 0; i--){
       *pCurModelTime = (- 1 - i) * *pAnalogT0;
       Run();
   }*/
};

//===========================================================================
void TPolinom::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


       TFloat *Queue = oPoints->Items[0]->Queue;

       Queue[0] = Polinom[0];
       for (int i = 1; i < 6; i++)
            if (Polinom[i] != 0)
              Queue[0] += Polinom[i] * IntPower(*pCurModelTime, i);
}

