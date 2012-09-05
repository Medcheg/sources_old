//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "Math.hpp"
#include "Math.h"
#pragma hdrstop

#include "M_Alan.h"
#include "Unit_AlanResult.h"
//===========================================================================
void TAlan_Init() { RegisterElement("DiALab - Базовые", "Мат.Статисткика", (int)&TAlan::Create); }
#pragma startup TAlan_Init 110 // default 100
//===========================================================================
TAlan::TAlan()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Преобразование Алана";
     Note        = "";
     CreateDate  = "14.11.2005";

  // ---------
     DesignPhase   = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 24;
     VisualElementParam->Height = 2 * 16;
  // ---------

     iPoints->Add("x");
  // ---------

     frmAlanResult         = new TfrmAlanResult(NULL);
     ((TfrmAlanResult*)frmAlanResult)->Left    = (Screen->Width  - ((TfrmAlanResult*)frmAlanResult)->Width ) / 2;
     ((TfrmAlanResult*)frmAlanResult)->Top     = (Screen->Height - ((TfrmAlanResult*)frmAlanResult)->Height) / 2;
     ((TfrmAlanResult*)frmAlanResult)->Element = this;

     Values  = NULL;
     Counter = 0;
}

//===========================================================================
TAlan::~TAlan()
{
   if (Values != NULL) free(Values); Values = NULL;
   if (frmAlanResult != NULL) delete (TfrmAlanResult*)frmAlanResult; frmAlanResult = NULL;
}

//===========================================================================
void TAlan::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TAlan::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TAlan::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width ;
      int         ah       = VisualElementParam->Height;
      AnsiString  as       = "Alan";
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

   // ----------  --------
      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as)) / 2, (ah - dbCanvas->TextHeight(as)) / 2, as);

   // ----------
      dbCanvas->Pen->Color = clBlack;
}

//===========================================================================
void TAlan::Edit()
{
/*   TfrmBaseDialog_Alan *dlg;

   try {
        dlg = new TfrmBaseDialog_Alan(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;

        dlg->Alan = this;
     // ------
        //dlg->ParameteresCount       = 0;
        //dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();

     // ------
   } __finally { delete dlg; }*/
}

//===========================================================================
void TAlan::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TAlan::Init() { TElement::Init();
   if (Values != NULL) free(Values); Values = NULL;

   Values  = (TFloat *) malloc (sizeof (TFloat) * pProjectParam->EndCalcTime / pProjectParam->AnalogT0);
   Counter = 0;
}

//===========================================================================
void TAlan::InitBeforeRun()
{
}

//===========================================================================
void TAlan::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      if (Counter < pProjectParam->EndCalcTime / pProjectParam->AnalogT0)
           Values[Counter++] = iPoints->Items[0]->Queue[0];
}

//===========================================================================
void TAlan::DoneRun()
{
     int CountData = Counter;
     Values = (TFloat *) realloc (Values, sizeof (TFloat) * CountData);

   // ------------ Преобразование Алана ---------
     TFloat BeginTime = 0.01, IncreaseTime;
     TFloat EndDecadTime;
     int    BeginDecad, EndDecad;

     BeginTime    = 0.01;
     BeginDecad   = floor(log(BeginTime)/log(10));
     EndDecad     = BeginDecad + 1;
     EndDecadTime = Power(10, EndDecad);
     IncreaseTime = (Power(10, EndDecad) - Power(10, BeginDecad)) / 50.0;
     if (IncreaseTime < pProjectParam->AnalogT0) IncreaseTime = pProjectParam->AnalogT0;


     ((TfrmAlanResult*)frmAlanResult)->Chart1->UndoZoom();
     ((TfrmAlanResult*)frmAlanResult)->Chart1->BottomAxis->SetMinMax(0.01, Power(10, floor(log(CountData * pProjectParam->AnalogT0)/log(10))));

  // ----------------------- % Инициализация массивов ----------------
     int     LengthOutPutArray = 0;
     int     Mmax = CountData;
     TFloat *tau  = (TFloat *) malloc (sizeof(TFloat) * Mmax);
     TFloat *AL   = (TFloat *) malloc (sizeof(TFloat) * CountData);
     TFloat *AL2A = (TFloat *) malloc (sizeof(TFloat) * Mmax);

     for (int m = 0; m < Mmax; m = m + IncreaseTime / pProjectParam->AnalogT0) {
        // ---- Переменный щаг расчета :) -----------
           if (m*pProjectParam->AnalogT0 >= EndDecadTime) {
               BeginDecad   = EndDecad;
               EndDecad     = BeginDecad + 1;
               EndDecadTime = Power(10, EndDecad);
               int Divider = 50;
               if (EndDecad >= 1) Divider = 70;
               if (EndDecad >= 2) Divider = 120;
               if (EndDecad >= 3) Divider = 150;

               IncreaseTime = (Power(10, EndDecad) - Power(10, BeginDecad)) / (TFloat)Divider;

               if (IncreaseTime < pProjectParam->AnalogT0) IncreaseTime = pProjectParam->AnalogT0;
               if (m + IncreaseTime / pProjectParam->AnalogT0 >= Mmax)
                         IncreaseTime = Mmax*pProjectParam->AnalogT0 - m*pProjectParam->AnalogT0;
           }

          int k = CountData / (m + 1);
        // ------------------
          for (int rk = 0; rk < k; rk++) {
               TFloat sum = 0;
               for (int zz = rk*(m+1); zz <= (rk+1)*(m+1) - 1; zz ++)
                  sum = sum + Values[zz];

               AL[rk] = sum / (TFloat)(m + 1);
          }
       // ------------------
          TFloat Razn, sum1 = 0;
          for (int rk = 0; rk < k-1; rk++) {
               Razn = AL[rk+1] - AL[rk];
               sum1 = sum1 + Razn*Razn;
          }
       // ------------------
         //if (sum1 == 0) sum1 = fabs(AL[0]);
         if (sum1 != 0) {
             AL2A[LengthOutPutArray] = sqrt(0.5/(TFloat)k * sum1);
             tau [LengthOutPutArray] = m * pProjectParam->AnalogT0;
             LengthOutPutArray ++;
         }
         //else AL2A[LengthOutPutArray] = AL2A[LengthOutPutArray - 1];
     }

  // -----------

     ((TfrmAlanResult*)frmAlanResult)->Chart1->Series[0]->Clear();

     for (int i = 0; i < LengthOutPutArray; i++)
         ((TfrmAlanResult*)frmAlanResult)->Chart1->Series[0]->AddXY(tau[i], AL2A[i]);
         //((TfrmAlanResult*)frmAlanResult)->Chart1->Series[aIndex]->AddXY(tau[i], 10*Log10(AL2A[i]));

    ((TfrmAlanResult*)frmAlanResult)->Show();     
}

