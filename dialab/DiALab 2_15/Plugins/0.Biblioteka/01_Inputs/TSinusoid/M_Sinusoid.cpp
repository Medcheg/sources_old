//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "Math.h"
#pragma hdrstop

#include "M_Sinusoid.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TSinusoid_Init() { RegisterElement("DiALab - Базовые", "Входы", (int)&TSinusoid::Create); }
#pragma startup TSinusoid_Init 110 // default 100
//===========================================================================
TSinusoid::TSinusoid()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Гармоническое возд.";
     Note        = "Задание воздействия ввида : y(t) = A * e^Alfa * sin(2 * pi * F * t + Fi)";
     CreateDate  = "26.12.2004";

  // ---------
     DesignPhase = dpAllreadyTesting;

  // --------- Коэффициенты поллтнома ------
     A    = 1;
     Alfa = 0;
     F    = 1;
     Fi   = 0;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;

     oPoints->Add("y");
  // ---------
}

//===========================================================================
void TSinusoid::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&A   , sizeof(A   ));
    aStream->Read(&Alfa, sizeof(Alfa));
    aStream->Read(&F   , sizeof(F   ));
    aStream->Read(&Fi  , sizeof(Fi  ));
}

//===========================================================================
void TSinusoid::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&A   , sizeof(A   ));
    aStream->Write(&Alfa, sizeof(Alfa));
    aStream->Write(&F   , sizeof(F   ));
    aStream->Write(&Fi  , sizeof(Fi  ));
}

//===========================================================================
void TSinusoid::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width ;
      int         ah       = VisualElementParam->Height;
   // ----------
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
   // ---------- Сетка --------
      dbCanvas->MoveTo(5, 2     );   dbCanvas->LineTo(5, ah - 2);
      dbCanvas->MoveTo(2, ah / 2);   dbCanvas->LineTo(aw - 2, ah / 2);

   // ---------- График ---------
      dbCanvas->Pen->Color = clBlue;

      dbCanvas->MoveTo(5, ah / 2);
      for (int i = 0; i < aw - 7; i++)
             dbCanvas->LineTo(5 + i, ah / 2 - ((ah / 2) - 4) * sin (7.2 * i / (TFloat)(aw - 7)));
                                               

   // ----------
      dbCanvas->Pen->Color = clBlack;
}

//===========================================================================
void TSinusoid::Edit()
{
   TfrmBaseDialog1 *dlg;
   TFloat           aFi = Fi * 180.0 / pi;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &A;
        dlg->ValueArray[1]          = &Alfa;
        dlg->ValueArray[2]          = &F;
        dlg->ValueArray[3]          = &aFi;
        dlg->LabelArray[0]->Caption = "Амплитуда синусоиды [A]";
        dlg->LabelArray[1]->Caption = "Декримент затухания [Alfa]";
        dlg->LabelArray[2]->Caption = "Частота [F, герц]";
        dlg->LabelArray[3]->Caption = "Фаза [Fi, градус]";
        dlg->ParameteresCount       = 4;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();

        Fi = aFi * pi / 180.0;
     // ------
   } __finally { delete dlg; }
}

//===========================================================================
void TSinusoid::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TSinusoid::Init() { TElement::Init();
    A_Exponenet_Alfa = A * exp(Alfa);
    Two_Pi_F         = two_pi * F;
}

//===========================================================================
void TSinusoid::InitBeforeRun()
{
/*   for (int i = Order - 1; i >= 0; i--){
       *pCurModelTime = (- 1 - i) * *pAnalogT0;
       Run();
   }*/
}

//===========================================================================
void TSinusoid::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------

       oPoints->Items[0]->Queue[0] = A * exp(Alfa * *pCurModelTime) * sin(Two_Pi_F * *pCurModelTime + Fi);
}

