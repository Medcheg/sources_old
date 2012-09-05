//===============================================================================
//===============================================================================
//==== Обязательно при модифицировании кода менять дату модификации элемента ====
//===============================================================================
//===============================================================================

#include <vcl.h>
#include "Math.h"
#pragma hdrstop

#include "M_KalmanBajas.h"
#include "Unit_KalmanBajas.h"
//===========================================================================
void TKalmanBajas_Init() { RegisterElement("DiALab - Фильтры", "БИХ фильтры", (int)&TKalmanBajas::Create); }
#pragma startup TKalmanBajas_Init 110 // default 100
//===========================================================================
TKalmanBajas::TKalmanBajas()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Байесовский фильтр Калмана";
     Note        = "Байесовский фильтр Калмана";
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
     oPoints->Add("p1");
     oPoints->Add("p2");
     oPoints->Add("p3");
  // ---------
      def_p[0][0] = 0.15;        def_p[1][0] = 0.75;        def_p[2][0] = 0.1;

      pi_[0][0] = 0.7;    pi_[0][1] = 0.25;   pi_[0][2] = 0.05;
      pi_[1][0] = 0.1;    pi_[1][1] = 0.8;    pi_[1][2] = 0.1;
      pi_[2][0] = 0.05;   pi_[2][1] = 0.25;   pi_[2][2] = 0.7;

      AMax = 0.0392;
      Qm = 1e-6;
      def_Sigma_x = 0.1;  // ---- Дисперсия ошибок измерения ----------------------------------

      FiltrMethod          = 1;
      CalcFiltrWithDSTFitr = false;
      def_N                = 3;
      def_psi11            = 1;
      def_psi12            = 1;
      def_psi22            = 2;
  // ---------
}

//===========================================================================
void TKalmanBajas::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&CalcFiltrWithDSTFitr , sizeof(CalcFiltrWithDSTFitr));
    aStream->Read(&def_N                , sizeof(def_N));

    aStream->Read(&def_psi11, sizeof(def_psi11));
    aStream->Read(&def_psi12, sizeof(def_psi12));
    aStream->Read(&def_psi22, sizeof(def_psi22));

    aStream->Read(&def_p[0][0], sizeof(def_p[0][0]));
    aStream->Read(&def_p[1][0], sizeof(def_p[1][0]));
    aStream->Read(&def_p[2][0], sizeof(def_p[2][0]));

    aStream->Read(&pi_[0][0], sizeof(pi_[0][0]));
    aStream->Read(&pi_[0][1], sizeof(pi_[0][1]));
    aStream->Read(&pi_[0][2], sizeof(pi_[0][2]));
    aStream->Read(&pi_[1][0], sizeof(pi_[1][0]));
    aStream->Read(&pi_[1][1], sizeof(pi_[1][1]));
    aStream->Read(&pi_[1][2], sizeof(pi_[1][2]));
    aStream->Read(&pi_[2][0], sizeof(pi_[2][0]));
    aStream->Read(&pi_[2][1], sizeof(pi_[2][1]));
    aStream->Read(&pi_[2][2], sizeof(pi_[2][2]));

    aStream->Read(&AMax, sizeof(AMax));
    aStream->Read(&Qm, sizeof(Qm));
    aStream->Read(&def_Sigma_x, sizeof(def_Sigma_x));

    aStream->Read(&FiltrMethod, sizeof(FiltrMethod));
}

//===========================================================================
void TKalmanBajas::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&CalcFiltrWithDSTFitr , sizeof(CalcFiltrWithDSTFitr));
    aStream->Write(&def_N                , sizeof(def_N));

    aStream->Write(&def_psi11, sizeof(def_psi11));
    aStream->Write(&def_psi12, sizeof(def_psi12));
    aStream->Write(&def_psi22, sizeof(def_psi22));

    aStream->Write(&def_p[0][0], sizeof(def_p[0][0]));
    aStream->Write(&def_p[1][0], sizeof(def_p[1][0]));
    aStream->Write(&def_p[2][0], sizeof(def_p[2][0]));

    aStream->Write(&pi_[0][0], sizeof(pi_[0][0]));
    aStream->Write(&pi_[0][1], sizeof(pi_[0][1]));
    aStream->Write(&pi_[0][2], sizeof(pi_[0][2]));
    aStream->Write(&pi_[1][0], sizeof(pi_[1][0]));
    aStream->Write(&pi_[1][1], sizeof(pi_[1][1]));
    aStream->Write(&pi_[1][2], sizeof(pi_[1][2]));
    aStream->Write(&pi_[2][0], sizeof(pi_[2][0]));
    aStream->Write(&pi_[2][1], sizeof(pi_[2][1]));
    aStream->Write(&pi_[2][2], sizeof(pi_[2][2]));

    aStream->Write(&AMax, sizeof(AMax));
    aStream->Write(&Qm, sizeof(Qm));
    aStream->Write(&def_Sigma_x, sizeof(def_Sigma_x));

    aStream->Write(&FiltrMethod, sizeof(FiltrMethod));
}

//===========================================================================
void TKalmanBajas::DrawElementFace()
{
      AnsiString  as       = "ОФК (Б)";

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
void TKalmanBajas::Edit()
{
    TfrmKalmanBajasFilterParam *dlg;

    try {
        dlg = new TfrmKalmanBajasFilterParam(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------

        dlg->FiltrMethod = &FiltrMethod;
        dlg->AMax        = &AMax;
        dlg->Qm          = &Qm;
        dlg->Sigma_x    = &def_Sigma_x;

        dlg->p1           = &def_p[0][0];
        dlg->p2           = &def_p[1][0];
        dlg->p3           = &def_p[2][0];

        dlg->pi_11       = &pi_[0][0];
        dlg->pi_12       = &pi_[0][1];
        dlg->pi_13       = &pi_[0][2];

        dlg->pi_21       = &pi_[1][0];
        dlg->pi_22       = &pi_[1][1];
        dlg->pi_23       = &pi_[1][2];

        dlg->pi_31       = &pi_[2][0];
        dlg->pi_32       = &pi_[2][1];
        dlg->pi_33       = &pi_[2][2];

        dlg->CalcFiltrWithDSTFitr = &CalcFiltrWithDSTFitr;
        dlg->N                    = &def_N;
        dlg->psi11                = &def_psi11;
        dlg->psi12                = &def_psi12;
        dlg->psi22                = &def_psi22;
     // ------
        dlg->ShowModal();
    } __finally { delete dlg; }
}

//===========================================================================
void TKalmanBajas::Copy(void *aElement) { TElement::Copy(aElement);
   TKalmanBajas *el = (TKalmanBajas*)aElement;

   el->CalcFiltrWithDSTFitr  = CalcFiltrWithDSTFitr;
   el->N    = N;

   el->FiltrMethod = FiltrMethod;
   el->AMax        = AMax;
   el->Qm          = Qm;
   el->def_Sigma_x    = def_Sigma_x;

   el->def_p[0][0]     = def_p[0][0];
   el->def_p[2][0]     = def_p[1][0];
   el->def_p[3][0]     = def_p[2][0];

   el->pi_[0][0]   = pi_[0][0];
   el->pi_[0][1]   = pi_[0][1];
   el->pi_[0][2]   = pi_[0][2];

   el->pi_[1][0]   = pi_[1][0];
   el->pi_[1][1]   = pi_[1][1];
   el->pi_[1][2]   = pi_[1][2];

   el->pi_[2][0]   = pi_[2][0];
   el->pi_[2][1]   = pi_[2][1];
   el->pi_[2][2]   = pi_[2][2];
}

//===========================================================================
void TKalmanBajas::Init() { TElement::Init();
     Order     = 3;
     DeltaT    = -999;
     OldTime   = -pProjectParam->AnalogT0;

     NULLValue[0] = 0;
     NULLValue[1] = 0;
     NULLValue[2] = 0;
     NULLValue[3] = 0;

     Sigma2_x = sqr(def_Sigma_x);
  // -----------
    for (int k = 0; k < 3 ; k++) {
         if (CalcFiltrWithDSTFitr) {
             psi_11[k][0] = def_psi11;
             psi_12[k][0] = def_psi12;
             psi_22[k][0] = def_psi22;
         } else {
             psi_11[k][0] = 5*Sigma2_x / 6.0;
             psi_12[k][0] = Sigma2_x / 2.0 / pProjectParam->AnalogT0;
             psi_22[k][0] = Sigma2_x / 2.0 / pProjectParam->AnalogT0 / pProjectParam->AnalogT0;
         }
    }

    if (CalcFiltrWithDSTFitr) {
       N = def_N;
    } else {
       N = 3;
    }


    p[0][0] = def_p[0][0];   p[0][1] = 0;
    p[1][0] = def_p[1][0];   p[1][1] = 0;
    p[2][0] = def_p[2][0];   p[2][1] = 0;
  // -----------
    InputCounter = 0;

  // -----------
    for (int k = 0; k < 3 ; k++) {
          Xk_oc [k][0] = 0;   Xk_oc [k][1] = 0;
          pXk_oc[k][0] = 0;  pXk_oc [k][1] = 0;

          k1[k] = 0;           k2[k] = 0;

           Xke_oc[k][0] = 0;    Xke_oc[k][1] = 0;
          pXke_oc[k][0] = 0;   pXke_oc[k][1] = 0;
          psi_e11[k][0] = 0;   psi_e11[k][1] = 0;
          psi_e12[k][0] = 0;   psi_e12[k][1] = 0;
          psi_e22[k][0] = 0;   psi_e22[k][1] = 0;
    }
 // ----------------

    ppXk[0] = -AMax;  ppXk[1] = 0;  ppXk[2] = AMax;

 // ----------------
}

//===========================================================================
void TKalmanBajas::SaveOldValues()
{
    for (int k = 0; k < 3 ; k++) {
          Xk_oc [k][1] = Xk_oc [k][0];
          pXk_oc[k][1] = pXk_oc[k][0];

           Xke_oc[k][1] = Xke_oc [k][0];
          pXke_oc[k][1] = pXke_oc[k][0];
          psi_e11[k][1] = psi_e11[k][0];
          psi_e12[k][1] = psi_e12[k][0];
          psi_e22[k][1] = psi_e22[k][0];
          psi_11 [k][1] = psi_11 [k][0];
          psi_12 [k][1] = psi_12 [k][0];
          psi_22 [k][1] = psi_22 [k][0];
    }
 // ----------------
    for (int k = 0; k < 3 ; k++) {
          psi_11 [k][1] = psi_11 [k][0];
          psi_12 [k][1] = psi_12 [k][0];
          psi_22 [k][1] = psi_22 [k][0];
    }

    p[0][1] = p[0][0];
    p[1][1] = p[1][0];
    p[2][1] = p[2][0];
}

//===========================================================================
void TKalmanBajas::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


    // -------------  Входы -------------
       TFloat  *Xk_oc_in = (iPoints->Items[0]->Queue != NULL) ? iPoints->Items[0]->Queue : NULLValue;
       TFloat  *C1_oc_in = (iPoints->Items[1]->Queue != NULL) ? iPoints->Items[1]->Queue : NULLValue;
       TFloat  *Xk       = (iPoints->Items[2]->Queue != NULL) ? iPoints->Items[2]->Queue : NULLValue;
       TFloat   Xk_0     = Xk[0];

    // -------------  Выходы -------------
       TFloat  *X_out_sr =  oPoints->Items[0]->Queue;
       TFloat  *p1       =  oPoints->Items[1]->Queue;
       TFloat  *p2       =  oPoints->Items[2]->Queue;
       TFloat  *p3       =  oPoints->Items[3]->Queue;

    // --------- Тут мулька, для запоминания предыдущего значения ----------
       if (!CalcFiltrWithDSTFitr) {
             if (InputCounter < 3) {
//                 Xk[2]       = Xk[1];
//                 Xk[1]       = Xk[0];
                 X_out_sr[0] = Xk_0;
             }
             if (InputCounter == 2) {
                 Xk_oc[0][0] =  Xk_oc[1][0] =  Xk_oc[2][0] = (5*Xk_0 + 2*Xk[1] - Xk[2]) / 6.0;
                pXk_oc[0][0] = pXk_oc[1][0] = pXk_oc[2][0] = (Xk_0 - Xk[2]) / 2.0 / pProjectParam->AnalogT0;
             }
       } else {
           if (InputCounter < N) { // CurModelTime == 0
//                 [2]       = Xk[1];
//                 Xk[1]       = Xk_0;

                 X_out_sr[0] = Xk_0 = Xk_oc_in[0];
                for (int zju = 0; zju < 3; zju++) {
                     Xk_oc[zju][2] =  Xk_oc[zju][1];
                    pXk_oc[zju][2] = pXk_oc[zju][1];
                     Xk_oc[zju][1] =  Xk_oc[zju][0];
                    pXk_oc[zju][1] = pXk_oc[zju][0];

                     Xk_oc[zju][0] = Xk_oc_in[0];
                    pXk_oc[zju][0] = C1_oc_in[0];
                }
             }
       }

    // --------- Коефф. для вычесления весовых функций -----
       TFloat fCoef[3] = {0,0,0};
       TFloat aa[3];
    // ---------------

       TFloat DeltaT = *pCurModelTime - OldTime;  OldTime = *pCurModelTime;

       if (InputCounter == 16)
          Beep();
       if (InputCounter >= N) {
                  // ------------
                    SaveOldValues();
                  // ------------

                   for (int j = 0; j < 3; j++) {
                       // ---- 1. Экстраполяция Оценок выхода фильтра -----
                           Xke_oc[j][0] =  Xk_oc[j][1] + DeltaT * pXk_oc[j][1] + 0.5*sqr(DeltaT)*ppXk[j];
                          pXke_oc[j][0] = pXk_oc[j][1] + DeltaT * ppXk[j];

                       // ---- 2. Экстраполяция значений корреляционных матриц -----
                          psi_e11[j][0] = psi_11[j][1] + 2 * DeltaT * psi_12[j][1] + psi_22[j][1] * sqr(DeltaT) + 0.25*sqr(sqr(DeltaT))*Qm;
                          psi_e12[j][0] = psi_12[j][1] +     DeltaT * psi_22[j][1] + 0.5 * DeltaT*DeltaT*DeltaT*Qm;
                          psi_e22[j][0] = psi_22[j][1] +     DeltaT * DeltaT * Qm;

                      // ----- 3. Коеффициенты усиления фильтра -----
                          k1[j] = psi_e11[j][0] / (psi_e11[j][0] + Sigma2_x);
                          k2[j] = psi_e12[j][0] / (psi_e11[j][0] + Sigma2_x);

                      // -------- 4. Вычисление елементов корреляционных матриц  -----
                          psi_11[j][0] = k1[j] * Sigma2_x;
                          psi_12[j][0] = k2[j] * Sigma2_x;
                          psi_22[j][0] = psi_e22[j][0] - k2[j] * psi_e12[j][0];

                      // -------- 5. Уточненные оценки фильтруемых параметров фильтра -----
                           Xk_oc[j][0] =  Xke_oc[j][0] + k1[j] * (Xk_0 - Xke_oc[j][0]);
                          pXk_oc[j][0] = pXke_oc[j][0] + k2[j] * (Xk_0 - Xke_oc[j][0]);

                     // --------- 6.1. Подготовка вычисление весовых функций -----
                          for (int i = 0; i < 3; i++)
                               fCoef[j] += pi_[i][j] * p[i][1];
                          TFloat ExpValue = -(Xk_0 - Xke_oc[j][0])*(Xk_0 - Xke_oc[j][0]) / (2.0 * (psi_e11[j][0] + Sigma2_x) );
                          aa[j] = exp(ExpValue) * fCoef[j];
                   }
                // --------- 6.2. Вычисление весовых функций -----
                   for (int j = 0; j < 3; j++)
                          if (aa[0] + aa[1] + aa[2] == 0) p[j][0] = 0; else p[j][0] = aa[j] / (aa[0] + aa[1] + aa[2]);

                // ------ 7. Вычисление усредненных параметров оценок  -----
                   X_out_sr[0] = pX_out_sr = ppX_out_sr = 0;
                   for (int j = 0; j < 3; j++) {
                         X_out_sr[0] +=  Xk_oc[j][0] * p[j][0]; /// --- !!!! ---- Выход Системы ---- !!!! ----
                        pX_out_sr    += pXk_oc[j][0] * p[j][0];
                       ppX_out_sr    += ppXk[j]      * p[j][0];
                   }

                // ---- 8.1. Усреднение корреляционной матрици ошибок фильтрации  -----
                   /*
                   psi_11_sr = psi_12_sr = psi_22_sr = 0;
                   for (int j = 0; j < 3; j++) {
                      psi_11_sr += p[j][0] * (psi_11[j][0] + (X_out_sr[0] - Xk_oc[j][0]));
                      psi_12_sr += p[j][0] * (psi_12[j][0] + (X_out_sr[0] - Xk_oc[j][0])*(pX_out_sr - pXk_oc[j][0]));
                      psi_22_sr += p[j][0] * (psi_22[j][0] + (pX_out_sr - pXk_oc[j][0]));
                   }
                   */

                // ---- 9.1. Попровка коеф корреляционной матрици ---------------
                   if (FiltrMethod == 1) {
                       for (int j = 0; j < 3; j++) {
                          psi_11[j][0] = psi_11[j][0] + sqr(X_out_sr[0] - Xk_oc[j][0]);
                          psi_12[j][0] = psi_12[j][0] + (X_out_sr[0] - Xk_oc[j][0])*(pX_out_sr - pXk_oc[j][0]);
                          psi_22[j][0] = psi_22[j][0] + sqr(pX_out_sr - pXk_oc[j][0]);
                       }
                   }

                // ---- 9.2. Дополнительное взешивание оценнок корреляционной функции ---------------
                   if (FiltrMethod == 2) {
                         TFloat  xo      [3] = {0,0,0};
                         TFloat pxo      [3] = {0,0,0};
                         TFloat W     [3][3] = {0,0,0};
                         TFloat TempPsi11[3] = {0,0,0};
                         TFloat TempPsi12[3] = {0,0,0};
                         TFloat TempPsi22[3] = {0,0,0};

                       // -------
                          for (int j = 0; j < 3; j++)
                                for (int i = 0; i < 3; i++ ) {
                                     TFloat Denum = pi_[0][j]*p[0][0] + pi_[1][j]*p[1][0] + pi_[2][j]*p[2][0];
                                     if (Denum == 0) W[j][i] = 0; else W[j][i] = pi_[i][j] *p[i][0] / Denum;
                                }

                        // -------------
                          for (int j = 0; j < 3; j++)
                                for (int i = 0; i < 3; i++ ) {
                                     xo [j] +=  Xk_oc[i][0]*W[j][i];
                                    pxo [j] += pXk_oc[i][0]*W[j][i];
                                }

                        // -------------
                           for (int j = 0; j < 3; j++)
                                for (int i = 0; i < 3; i++ ){
                                   TempPsi11[j] += (psi_11[i][0] + ( Xk_oc[i][0] -  xo[i]) * ( Xk_oc[i][0] -  xo[i])) * W[j][i];
                                   TempPsi12[j] += (psi_12[i][0] + ( Xk_oc[i][0] -  xo[i]) * (pXk_oc[i][0] - pxo[i])) * W[j][i];
                                   TempPsi22[j] += (psi_22[i][0] + (pXk_oc[i][0] - pxo[i]) * (pXk_oc[i][0] - pxo[i])) * W[j][i];
                                }
                        // -------------
                           for (int j = 0; j < 3; j++) {
                              psi_11[j][0] = TempPsi11[j];
                              psi_12[j][0] = TempPsi12[j];
                              psi_22[j][0] = TempPsi22[j];
                           }
                   }
       } // --- if (InputCounter >= 3)  ----

   // ----- Выходы вероятностей -----
       p1[0] = p[0][1];
       p2[0] = p[1][1];
       p3[0] = p[2][1];

       InputCounter++;
}

void TKalmanBajas::DoneRun(){ }

