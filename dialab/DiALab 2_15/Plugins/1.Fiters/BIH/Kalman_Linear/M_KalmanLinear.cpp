//===============================================================================
//===============================================================================
//==== Обязательно при модифицировании кода менять дату модификации элемента ====
//===============================================================================
//===============================================================================

#include <vcl.h>
#pragma hdrstop

#include "M_KalmanLinear.h"
#include "Unit_KalanFilterParam.h"
//===========================================================================
void TKalmanLinear_Init() { RegisterElement("DiALab - Фильтры", "БИХ фильтры", (int)&TKalmanLinear::Create); }
#pragma startup TKalmanLinear_Init 110 // default 100
//===========================================================================
TKalmanLinear::TKalmanLinear()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Линейный фильтр Калмана";
     Note        = "Линейный фильтр Калмана";
     CreateDate  = "20.02.2005";

  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 8 * 16;
     VisualElementParam->Height = 4 * 16;

     ShowInOutHint = true;
  // ---------
     iPoints->Add("X_oc");   
     iPoints->Add("C1_oc");  
     iPoints->Add("X");

     iPoints->Items[0]->Visible = false;
     iPoints->Items[1]->Visible = false;

     oPoints->Add("X_oc");
     oPoints->Add("C1_oc");
  // ---------
      CalcFiltrWithBeginInit = true;
      PFil  = 10;
      N     = 4;
      p11   = 0;
      p12   = 0;
      p22   = 0;
  // ---------
}

//===========================================================================
void TKalmanLinear::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&CalcFiltrWithBeginInit ,  sizeof(CalcFiltrWithBeginInit));
    aStream->Read(&PFil                   ,  sizeof(PFil                  ));
    aStream->Read(&N                      ,  sizeof(N));
    aStream->Read(&p11                    ,  sizeof(p11));
    aStream->Read(&p12                    ,  sizeof(p12));
    aStream->Read(&p22                    ,  sizeof(p22));
}

//===========================================================================
void TKalmanLinear::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&CalcFiltrWithBeginInit ,  sizeof(CalcFiltrWithBeginInit));
    aStream->Write(&PFil                   ,  sizeof(PFil                  ));
    aStream->Write(&N                      ,  sizeof(N));
    aStream->Write(&p11                    ,  sizeof(p11));
    aStream->Write(&p12                    ,  sizeof(p12));
    aStream->Write(&p22                    ,  sizeof(p22));
}

//===========================================================================
void TKalmanLinear::DrawElementFace()
{
      AnsiString  as       = "ОФК (Л)";

      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;

      int         FontSize   = dbCanvas->Font->Size;
      AnsiString  FontName   = dbCanvas->Font->Name;
      TFontStyles FontStyles = dbCanvas->Font->Style;
      TColor      FontColor  = dbCanvas->Font->Color;


      dbCanvas->Font->Style = TFontStyles();
      dbCanvas->Font->Style = TFontStyles() << fsBold;
      dbCanvas->Font->Color = clMaroon;
      if (dbCanvas->TextWidth(as) > aw - 4) dbCanvas->Font->Name = "Times New Roman";
      while (dbCanvas->TextWidth(as) > aw - 4)  dbCanvas->Font->Size--;

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
      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2, (ah - dbCanvas->TextHeight(as))/2, as);

      dbCanvas->Font->Size = FontSize;
      dbCanvas->Font->Name = FontName;
      dbCanvas->Font->Style = FontStyles;
      dbCanvas->Font->Color = FontColor;
}

//===========================================================================
void TKalmanLinear::Edit()
{
    TfrmKalanFilterParam *dlg;

    try {
        dlg = new TfrmKalanFilterParam(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------

        dlg->CalcFiltrWithBeginInit = &CalcFiltrWithBeginInit;
        dlg->p11                    = &p11;
        dlg->p12                    = &p12;
        dlg->p22                    = &p22;
        dlg->N                      = &N;
        dlg->PFil                   = &PFil;

     // ------
        dlg->ShowModal();
    } __finally { delete dlg; }
}

//===========================================================================
void TKalmanLinear::Copy(void *aElement) { TElement::Copy(aElement);
   TKalmanLinear *el = (TKalmanLinear*)aElement;

   el->CalcFiltrWithBeginInit  = CalcFiltrWithBeginInit;
   el->PFil = PFil;
   el->N    = N;
   el->p11  = p11;
   el->p12  = p12;
   el->p22  = p22;
}

//===========================================================================
void TKalmanLinear::Init() { TElement::Init();
     Order     = 2;
     tk        = 0;
     tk_1      = -pProjectParam->AnalogT0;
     NULLValue[0] = 0;
     NULLValue[1] = 0;
     NULLValue[2] = 0;
     NULLValue[3] = 0;

  // -----------
     if (CalcFiltrWithBeginInit) {
         Cur_p11 = 1;
         Cur_p12 = 1 / pProjectParam->AnalogT0;
         Cur_p22 = 2 / pProjectParam->AnalogT0 / pProjectParam->AnalogT0;
     } else {
         Cur_p11 = p11;
         Cur_p12 = p12;
         Cur_p22 = p12;
     }

  // -----------
    InputCounter = 0;
}

//===========================================================================
void TKalmanLinear::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      // iPoints->Items[0] ---- Вход фильтра "Х"  ----
      // iPoints->Items[1] ---- Вход фильтра "Y"  ----
      // iPoints->Items[2] ---- Вход фильтра "Z"  ----

      // oPoints->Items[0] ---- Выход фильтра "Х"  ----
      // oPoints->Items[1] ---- Выход фильтра "Y"  ----
      // oPoints->Items[2] ---- Выход фильтра "Z"  ----
      // oPoints->Items[3] ---- Выход фильтра "pХ" ----
      // oPoints->Items[4] ---- Выход фильтра "pY" ----
      // oPoints->Items[5] ---- Выход фильтра "pZ  ----
      // oPoints->Items[6] ---- Выход фильтра "K1" ----
      // oPoints->Items[7] ---- Выход фильтра "K2  ----

   // ------------

      TFloat  *X_oc      = (iPoints->Items[0]->Queue != NULL) ? iPoints->Items[0]->Queue : NULLValue;
      TFloat  *C1_oc     = (iPoints->Items[1]->Queue != NULL) ? iPoints->Items[1]->Queue : NULLValue;
      TFloat  *Xk        = (iPoints->Items[2]->Queue != NULL) ? iPoints->Items[2]->Queue : NULLValue;

      TFloat  *Xk_oc_out =  oPoints->Items[0]->Queue;
      TFloat *pXk_oc_out =  oPoints->Items[1]->Queue;
      TFloat k1, k2;
    // -------------

      tk            = *pCurModelTime;
      TFloat DeltaT = tk - tk_1;
    // -------------
         if (CalcFiltrWithBeginInit){
              if (InputCounter == 0)  Xk_oc_out[0] =  Xk[0];
              if (InputCounter == 1)  Xk_oc_out[0] =  Xk[0];
              if (InputCounter == 1) pXk_oc_out[0] = (Xk[0] - Xk[1]) / DeltaT;
         }
         if (!CalcFiltrWithBeginInit && InputCounter < N){
               Xk_oc_out[0] =  X_oc[0];
              pXk_oc_out[0] = C1_oc[0];
         }

    // -------------
         if ((CalcFiltrWithBeginInit && InputCounter >= 2) || ( InputCounter >= N && !CalcFiltrWithBeginInit)) {

            TFloat Xke_oc = Xk_oc_out[1] + pXk_oc_out[1] * DeltaT;

            TFloat pe11 = Cur_p11 + 2 * Cur_p12 * DeltaT + Cur_p22 * DeltaT*DeltaT;
            TFloat pe12 = Cur_p12 +     Cur_p22 * DeltaT;
            TFloat pe22 = Cur_p22;
            TFloat Fs   = 1 / (pe11 + 1.0);

            Cur_p11 = pe11 * Fs;
            Cur_p12 = pe12 * Fs;
            Cur_p22 = pe22  - pe12 * pe12 * Fs;

            k1 = Cur_p11;
            k2 = Cur_p12;

            c1  = 2.0 * (2.0 * PFil - 1) / (PFil * (PFil + 1));
            c2  = 6.0 / (DeltaT * PFil * (PFil + 1));

            if (k1 < c1) { k1 = c1; k2 = c2; }

            //k1 = c1;
            //k2 = c2;

             Xk_oc_out[0] = Xke_oc        + k1 * (Xk[0] - Xke_oc);
            pXk_oc_out[0] = pXk_oc_out[0] + k2 * (Xk[0] - Xke_oc);
         }

         tk_1 = tk;
         InputCounter++;
}


