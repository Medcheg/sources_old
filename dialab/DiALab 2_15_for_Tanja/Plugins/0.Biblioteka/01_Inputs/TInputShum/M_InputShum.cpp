//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "Math.h"
#include "Math.hpp"
#pragma hdrstop

#include "M_InputShum.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TInputShum_Init() { RegisterElement("DiALab - Базовые", "Входы", (int)&TInputShum::Create); }
#pragma startup TInputShum_Init 110 // default 100
//===========================================================================
TInputShum::TInputShum()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Гаусовский шум";
     Note        = "Шум с Гаусовской функциий распредиления... ";
     CreateDate  = "26.01.2005";

  // ---------
      DesignPhase = dpAllreadyTesting;

  // --------- Коэффициенты поллтнома ------
     Ampl          = 1;
     Basa          = 0;
     mpiRandomSeed = -1;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;

     oPoints->Add("y");
  // ---------
}

//===========================================================================
void TInputShum::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&Ampl, sizeof(Ampl));
    aStream->Read(&Basa, sizeof(Basa));
    aStream->Read(&mpiRandomSeed, sizeof(mpiRandomSeed));
}

//===========================================================================
void TInputShum::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&Ampl         , sizeof(Ampl));
    aStream->Write(&Basa         , sizeof(Basa));
    aStream->Write(&mpiRandomSeed, sizeof(mpiRandomSeed));
}

//===========================================================================
void TInputShum::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width ;
      int         ah       = VisualElementParam->Height;
      if (ah == 0) return;

   // ---------- График ---------

      int    PointCount = ((aw-8) / 2) + 1;
      if (PointCount <= 1) PointCount = 2;

      TPoint *DrawArray = (TPoint*) malloc (sizeof(TPoint) * PointCount);
      for (int i = 0; i < PointCount - 1; i++) {
          DrawArray[i].x = 5 + i*2;
          DrawArray[i].y = -RandG(0, 100 * ah / 2.0 / 4.0);  //
      }
      // ---- Нахожу максимум выноса ----

         TFloat amax = -1111110;
         TFloat amin = 11110;
         for (int i = 0; i < PointCount - 1; i++){
              if (amax < DrawArray[i].y) amax = DrawArray[i].y;
              if (amin > DrawArray[i].y) amin = DrawArray[i].y;
         }

      // ---- Коэффициент преобразования -----
         //TFloat CoefY =  (ah - 6) / ((amax > amin) ? amax : amin) / 2.0;
         TFloat CoefY =  (ah - 6) / (fabs(amax) + fabs(amin));

         for (int i = 0; i < PointCount - 1; i++)
              DrawArray[i].y = 3 + CoefY * amax - CoefY * DrawArray[i].y;


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
      dbCanvas->MoveTo(2, 3 + CoefY * amax);   dbCanvas->LineTo(aw - 2, 3 + CoefY * amax);

      dbCanvas->Pen->Color = clBlue;
      dbCanvas->Polyline(DrawArray, PointCount - 2);

      free(DrawArray);


   // ----------
      dbCanvas->Pen->Color = clBlack;
}

//===========================================================================
void TInputShum::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &Ampl;
        dlg->ValueArray[1]          = &Basa;
        dlg->ValueArray[2]          = &mpiRandomSeed;
        dlg->LabelArray[0]->Caption = "СКО шума";
        dlg->LabelArray[1]->Caption = "Смещени нуля шума";
        dlg->LabelArray[2]->Caption = "База случайного процесса";
        dlg->ParameteresCount       = 3;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
     // ------
   } __finally { delete dlg; }
}

//===========================================================================
void TInputShum::Copy(void *aElement) { TElement::Copy(aElement);
   TInputShum *el = (TInputShum*)aElement;

   el->Ampl          = Ampl;
   el->Basa          = Basa;
   el->mpiRandomSeed = mpiRandomSeed;
}

//===========================================================================
void TInputShum::Init() { TElement::Init();
   if (mpiRandomSeed >= 0) RandSeed = mpiRandomSeed;
}

//===========================================================================
void TInputShum::InitBeforeRun()
{
/*   for (int i = Order - 1; i >= 0; i--){
       *pCurModelTime = (- 1 - i) * *pAnalogT0;
       Run();
   }*/
}

//===========================================================================
void TInputShum::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


       oPoints->Items[0]->Queue[0] = RandG(Basa, Ampl);
}

