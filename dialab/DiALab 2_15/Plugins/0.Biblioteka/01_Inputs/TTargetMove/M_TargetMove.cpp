//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "Math.hpp"
#include "Math.h"
#pragma hdrstop

#include "M_TargetMove.h"
#include "mpiManeuver.h"
#include "Unit_TargetMove.h"
//===========================================================================
void TTargetMove_Init() { RegisterElement("DiALab - Базовые", "Входы", (int)&TTargetMove::Create); }
#pragma startup TTargetMove_Init 110 // default 100
//===========================================================================
TTargetMove::TTargetMove()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Вираж на Н=const";
     Note        = "... Нет данных ...";
     CreateDate  = "20.07.2005";

  // ---------
     DesignPhase = dpNotTesting;

  // --------- Коэффициенты поллтнома ------
     R0       = 80;
     Betta0   = 90.0 * pi / 180.0;
     H0       = 3;

     V0       = 1;
     K0       = - 90.0 * pi / 180.0;

     t1       = 5; // --- Время до розворота -----
     fi       = 60.0 * pi / 180.0;; // ---- Угол разворота ----
     GLoad    = 5;      // ---- Перегрузка на развороте ------
     radius   = 7;      // ---- радиус разворота *-----
     a1       = 0;      // ---- ускорение на 1 участке ------
     a3       = 0;      // ---- ускорение на 3 участке ------

     sigma1   = 0.0;      // ---- Шум в канале дальности ----
     sigma2   = 0.0;      // ---- Шум в азимутальном канале ----
     sigma3   = 0.0;      // ---- Шум в угломестном канале ---

  // ---------

     TargetTraektory = new TTargetTraektory(pCurModelTime, H0, R0, Betta0, V0);

  // ---------
     VisualElementParam->Width  = 5 * 16;
     VisualElementParam->Height = 6 * 16;

     ShowInOutHint = true;

     for (int i = 0; i < 12 ; i ++) {
     }

     oPoints->Add("R ");
     oPoints->Add("Betta ");
     oPoints->Add("Eps ");

     oPoints->Add("x ");
     oPoints->Add("y ");
     oPoints->Add("z ");
  // ---------

}

//===========================================================================
TTargetMove::~TTargetMove()
{
     if (TargetTraektory != NULL) delete TargetTraektory;
}

//===========================================================================
void TTargetMove::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&R0    , sizeof(R0));
    aStream->Read(&Betta0, sizeof(Betta0));
    aStream->Read(&H0    , sizeof(H0));
    aStream->Read(&V0    , sizeof(V0));
    aStream->Read(&K0    , sizeof(K0));
    aStream->Read(&t1    , sizeof(t1));
    aStream->Read(&fi    , sizeof(fi));
    aStream->Read(&GLoad , sizeof(GLoad));
    aStream->Read(&radius, sizeof(radius));
    aStream->Read(&a1    , sizeof(a1));
    aStream->Read(&a3    , sizeof(a3));
    aStream->Read(&sigma1, sizeof(sigma1));
    aStream->Read(&sigma2, sizeof(sigma2));
    aStream->Read(&sigma3, sizeof(sigma3));
}

//===========================================================================
void TTargetMove::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&R0    , sizeof(R0));
    aStream->Write(&Betta0, sizeof(Betta0));
    aStream->Write(&H0    , sizeof(H0));
    aStream->Write(&V0    , sizeof(V0));
    aStream->Write(&K0    , sizeof(K0));
    aStream->Write(&t1    , sizeof(t1));
    aStream->Write(&fi    , sizeof(fi));
    aStream->Write(&GLoad , sizeof(GLoad));
    aStream->Write(&radius, sizeof(radius));
    aStream->Write(&a1    , sizeof(a1));
    aStream->Write(&a3    , sizeof(a3));
    aStream->Write(&sigma1, sizeof(sigma1));
    aStream->Write(&sigma2, sizeof(sigma2));
    aStream->Write(&sigma3, sizeof(sigma3));
}

//===========================================================================
void TTargetMove::DrawElementFace()
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
void TTargetMove::Edit()
{
   TfrmTargetMove *dlg;

   try {
        dlg = new TfrmTargetMove(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------

        dlg->H0     = &H0;
        dlg->Betta0 = &Betta0;
        dlg->V0     = &V0;
        dlg->R0     = &R0;
        dlg->K0     = &K0;
        dlg->t1     = &t1;
        dlg->GLoad  = &GLoad;
        dlg->fi     = &fi;
        dlg->radius = &radius;
        dlg->a1     = &a1;
        dlg->a3     = &a3;

        dlg->sigma1 = &sigma1;
        dlg->sigma2 = &sigma2;
        dlg->sigma3 = &sigma3;

     // ------
        dlg->ShowModal();
     // ------
   } __finally { delete dlg; }
}


//===========================================================================
void TTargetMove::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TTargetMove::Init() { TElement::Init();
     if (TargetTraektory != NULL) delete TargetTraektory;

     TargetTraektory = new TTargetTraektory(pCurModelTime, H0, R0, Betta0, V0);
     TargetTraektory->Add_Maneuver(0.0, t1, K0);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime - pProjectParam->AnalogT0,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs - fi, GLoad);

      TargetTraektory->Add_Maneuver(TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime - pProjectParam->AnalogT0,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndTime + 22222222,
                                    TargetTraektory->Maneuver[TargetTraektory->Maneuver_count-1]->EndKurs);


      TargetTraektory->Init();
}

//===========================================================================
void TTargetMove::InitBeforeRun(){};

//===========================================================================
void TTargetMove::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------

      TargetTraektory->Run();

      oPoints->Items[0]->Queue[0] = TargetTraektory->D   + RandG(0, sigma1);
      oPoints->Items[1]->Queue[0] = TargetTraektory->K   + RandG(0, sigma2);
      oPoints->Items[2]->Queue[0] = TargetTraektory->Eps + RandG(0, sigma3);

      oPoints->Items[3]->Queue[0] = oPoints->Items[0]->Queue[0] * cos(oPoints->Items[1]->Queue[0]);
      oPoints->Items[4]->Queue[0] = oPoints->Items[0]->Queue[0] * sin(oPoints->Items[1]->Queue[0]);
      oPoints->Items[5]->Queue[0] = oPoints->Items[0]->Queue[0] * sin(oPoints->Items[2]->Queue[0]);
}

