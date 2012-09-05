//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include <Math.hpp>
#include <Math.h>
#pragma hdrstop

#include "M_Dst_C0_C1t.h"
#include "Unit_BaseDialog_DSTFilters.h"
//===========================================================================
void TDst_C0_C1t_Init() { RegisterElement("DiALab - Фильтры", "КИХ фильтры", (int)&TDst_C0_C1t::Create); }
#pragma startup TDst_C0_C1t_Init 110 // default 100
//===========================================================================
TDst_C0_C1t::TDst_C0_C1t()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "DST фильтр C0 + С1*t";
     Note        = "DST Фильтр C0 + С1*t, для оценки параметров движения объекта (С0), (С1), (С0 + С1*t). Предсказание движения цели. Экспоненциальное оценивание параметров";
     CreateDate  = "09.02.2005";

  // ---------
      DesignPhase = dpNeedModified;

  // ---------
     VisualElementParam->Width  = 8 * 16;
     VisualElementParam->Height = 4 * 16;

     ShowCaption   = false;
     ShowInOutHint = true;
  // ---------
     iPoints->Add("X");
     oPoints->Add("X_oc");
     oPoints->Add("C0_oc");
     oPoints->Add("C1_oc");

     oPoints->Items[1]->Visible = false;
  // ---------
      N     = 2;
      Gamma = 0;
      ro    = 1;

      ChangingCoef = false;
      N1     = 2;
      N2     = 10;
  // ---------
/*
    Rz = 6400; //km
    z0   = H0 - R0*R0/2.0/Rz;
    Eps0 = _ArcSin_(z0/R0);
    x0   = R0*sin(B0)*cos(Eps0);
    y0   = R0*cos(B0)*cos(Eps0);


    Coord.R = sqrt(xi*xi + yi*yi + zi*zi);
    Coord.Q = Math::ArcTan2(yi , xi);
    Coord.E = _ArcSin_( zi / Coord.R);

*/
}

//===========================================================================
void TDst_C0_C1t::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&N    , sizeof(N    ));
    aStream->Read(&Gamma, sizeof(Gamma));
    aStream->Read(&ro   , sizeof(ro   ));
    aStream->Read(&ChangingCoef, sizeof(ChangingCoef));
    aStream->Read(&N1   , sizeof(N1));
    aStream->Read(&N2   , sizeof(N2));
}

//===========================================================================
void TDst_C0_C1t::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&N    , sizeof(N    ));
    aStream->Write(&Gamma, sizeof(Gamma));
    aStream->Write(&ro   , sizeof(ro   ));
    aStream->Write(&ChangingCoef, sizeof(ChangingCoef));
    aStream->Write(&N1   , sizeof(N1));
    aStream->Write(&N2   , sizeof(N2));
}

//===========================================================================
void TDst_C0_C1t::DrawElementFace()
{
      AnsiString  as       = "DST (C0+С1t)";

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

      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2, (ah - dbCanvas->TextHeight(as)) / 2, as);

      dbCanvas->Font->Size = FontSize;
      dbCanvas->Font->Name = FontName;
      dbCanvas->Font->Style = FontStyles;
      dbCanvas->Font->Color = FontColor;
}

//===========================================================================
void TDst_C0_C1t::Edit()
{
    TfrmBaseDialog_DSTFilters *dlg;

    try {
        dlg = new TfrmBaseDialog_DSTFilters(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------

        dlg->eN    ->Text = IntToStr(N);
        dlg->eN1   ->Text = IntToStr(N1);
        dlg->eN2   ->Text = IntToStr(N2);
        dlg->eGamma->Text = FloatToStr(Gamma);
        dlg->eRo   ->Text = FloatToStr(ro);

        dlg->RadioButton1->Checked = !ChangingCoef;
        dlg->RadioButton2->Checked =  ChangingCoef;
     // ------
        dlg->ShowModal();
     // ------
        bool aShowMessage = false;
        try {N  = StrToFloat(dlg->eN->Text);        } catch ( ... ) { aShowMessage = true; N  = 2;}
        try {N1 = StrToFloat(dlg->eN1->Text);       } catch ( ... ) { aShowMessage = true; N1 = 2;}
        try {N2 = StrToFloat(dlg->eN2->Text);       } catch ( ... ) { aShowMessage = true; N2 = 10;}
        try {Gamma = StrToFloat(dlg->eGamma->Text); } catch ( ... ) { aShowMessage = true; Gamma = 0;}
        try {ro = StrToFloat(dlg->eRo->Text);       } catch ( ... ) { aShowMessage = true; ro    = 1;}

        if (aShowMessage) MessageBox(NULL, "Ошибка ввода параметров фильтра. Проверте правильность ввода параметров" , "DiALab - Ошибка ввода параметров", MB_APPLMODAL|MB_OK|MB_ICONERROR);

        ChangingCoef = dlg->RadioButton2->Checked;

     // -----------
        N = (N < 1) ? 1 : N;
        if (Gamma < 0) Gamma = 0;
        if (ro <= 0) ro = 0.001;
        if (ro >= 1) ro = 1;
     // -----------
    } __finally { delete dlg; }
}

//===========================================================================
void TDst_C0_C1t::Copy(void *aElement) { TElement::Copy(aElement);
   TDst_C0_C1t *el = (TDst_C0_C1t*)aElement;

   el->N            = N;
   el->Gamma        = Gamma;
   el->ro           = ro;
   el->ChangingCoef = ChangingCoef;
   el->N1           = N1;
   el->N2           = N2;
}

//===========================================================================
void TDst_C0_C1t::CalcCoef(int aN)
{
//   TFloat aT0 = *pAnalogT0;

/*   if (round(ro*100000) == 1*100000) {
       ///// C0+C1 (gamma, ro==1)///
         a0 =   2 * (  aN * (2*aN + 1) + 3 * Gamma * aN) / (TFloat)( aN * (aN + 1) * (aN + 2) );
         a1 = - 2 * (2*aN + 3*Gamma) / (TFloat)(aN * (aN + 1) );
         a2 =   2 * (  aN + 3*Gamma) / (TFloat)(aN * (aN + 1) );
         a3 = - 2 * (  aN - 1 + 3*Gamma) / (TFloat)((aN + 1) * (aN + 2));

       ///// C0 (ro==1)///
         a0_c0 = - 2*(aN-1) / (TFloat)((aN+1) * (aN+2));
         a1_c0 =   2/(TFloat)(aN+1);
         a2_c0 = - 4/(TFloat)(aN+1);
         a3_c0 =   2*(2*aN+1) / (TFloat)((aN+1)*(aN+2));

         ///// C1 (ro==1)///
         a0_c1 =   6 / (TFloat)(    (aN + 1) * (aN + 2) * aT0);
         a1_c1 = - 6 / (TFloat)(aN * (aN + 1)           * aT0);
         a2_c1 =   6 / (TFloat)(aN * (aN + 1)           * aT0);
         a3_c1 = - 6 / (TFloat)(    (aN + 1) * (aN + 2) * aT0);
   } else {

        a1_ =  sqr(1-ro)*(1-ro)*(1 - Power(ro, aN+1)) /
               (TFloat)(  ro - sqr(aN+1)*Power(ro, aN+1) + 2*aN*(aN+2)*Power(ro, aN+2) - sqr(aN+1)*Power(ro, aN+3) + Power(ro, 2*aN+3)); //!!!!

        a2_ =  sqr(1-ro)*(Power(ro, aN+1) - (aN+1)*ro + aN) /
               (TFloat)(  ro - sqr(aN+1)*Power(ro, aN+1) + 2*aN*(aN+2)*Power(ro, aN+2) - sqr(aN+1)*Power(ro, aN+3) + Power(ro, 2*aN+3)); //!!!!

        a3_ =  (1-ro)*(aN*aN - (2*aN*aN + 2*aN - 1)*ro + sqr(aN+1)*ro*ro - Power(ro, aN+1) - Power(ro, aN+2)) /
               (TFloat)(  ro - sqr(aN+1)*Power(ro, aN+1) + 2*aN*(aN+2)*Power(ro, aN+2) - sqr(aN+1)*Power(ro, aN+3) + Power(ro, 2*aN+3));


       ///// C0 + C1 (gamma, ro!=1)///
        Sigma0 = a3_ - (aN + Gamma)*a2_;
        Sigma1 = (aN + Gamma)*a1_ - a2_;

        a0 =      (Sigma0 + aN*Sigma1);    ///!!!!!
        a1 = -ro * (Sigma0 + (aN+1)*Sigma1);
        a2 = Power(ro, aN+1)*(Sigma1 - Sigma0);
        a3 = Power(ro, aN+2)*Sigma0;

       ///// C0 (ro!=1)///
        a0_c0 =      (a3_ - aN*a2_); //!!!!
        a1_c0 =  ro * ((aN+1)*a2_ - a3_);
        a2_c0 =  Power(-ro, aN+1)*(a2_ + a3_);
        a3_c0 =  Power(ro, aN+2)*a3_;

       ///// C1 (ro!=1)///
        a0_c1 =       ( aN*a1_ - a2_) / *pAnalogT0; //!!!!
        a1_c1 =  ro * ( a2_ - a1_*(aN+1)) / *pAnalogT0;
        a2_c1 =  Power( ro, aN+1)*(a1_ + a2_) / *pAnalogT0;
        a3_c1 = -Power( ro, aN+2)*a2_ / *pAnalogT0;
   }

      oQueue1[0] = 2*ro*oQueue1[1] - ro*ro*oQueue1[2] +  a0   *iQueue[0] + a1   *iQueue[1] + a2   *iQueue[CurrentN+1] +  a3   *iQueue[CurrentN+2];
      //oQueue2[0] = 2*ro*oQueue2[1] - ro*ro*oQueue2[2] +  a0_c0*iQueue[0] + a1_c0*iQueue[1] + a2_c0*iQueue[CurrentN+1] +  a3_c0*iQueue[CurrentN+2];
      oQueue3[0] = 2*ro*oQueue3[1] - ro*ro*oQueue3[2] +  a0_c1*iQueue[0] + a1_c1*iQueue[1] + a2_c1*iQueue[CurrentN+1] +  a3_c1*iQueue[CurrentN+2];
*/

           if (Ro_Equal_One) {
                a3_ = 2.0*(2.0*aN + 1) / (TFloat) (     (aN + 1)*(aN + 2));
                a2_ = 6.0              / (TFloat) (     (aN + 1)*(aN + 2));
                a1_ = 12.0             / (TFloat) (aN * (aN + 1)*(aN + 2));

                Sigma0 = (2*(1 - aN) - 6*Gamma) / (TFloat) (           (aN + 1)*(aN + 2));
                Sigma1 = 6*(aN + 2*Gamma)       / (TFloat) (aN * (aN + 1)*(aN + 2));

                //alfa1   = Sigma0 + Sigma1*(aN - i);
                //alfa3   = (a2_*(aN - i) - a1_) / *pAnalogT0;
           } else {
                a1_ =  sqr(1-ro)*(1-ro)*(1 - Power(ro, aN+1)) /
                       (TFloat)(  ro - sqr(aN+1)*Power(ro, aN+1) + 2*aN*(aN+2)*Power(ro, aN+2) - sqr(aN+1)*Power(ro, aN+3) + Power(ro, 2*aN+3)); //!!!!

                a2_ =  sqr(1-ro)*(Power(ro, aN+1) - (aN+1)*ro + aN) /
                       (TFloat)(  ro - sqr(aN+1)*Power(ro, aN+1) + 2*aN*(aN+2)*Power(ro, aN+2) - sqr(aN+1)*Power(ro, aN+3) + Power(ro, 2*aN+3)); //!!!!

                a3_ =  (1-ro)*(aN*aN - (2*aN*aN + 2*aN - 1)*ro + sqr(aN+1)*ro*ro - Power(ro, aN+1) - Power(ro, aN+2)) /
                       (TFloat)(  ro - sqr(aN+1)*Power(ro, aN+1) + 2*aN*(aN+2)*Power(ro, aN+2) - sqr(aN+1)*Power(ro, aN+3) + Power(ro, 2*aN+3));

               ///// C0 + C1 (gamma, ro!=1)///
                Sigma0 = a3_ - (aN + Gamma)*a2_;
                Sigma1 = (aN + Gamma)*a1_ - a2_;

                //alfa1 = Power( ro, i ) * (Sigma0 + Sigma1*(aN - i));
                //alfa3 = Power( ro, i ) * (Sigma0 + Sigma1*(aN - i));
           }

}

//===========================================================================
void TDst_C0_C1t::Init() { TElement::Init();
   TFloat MaxOrder = 0;

   Ro_Equal_One = (fabs(ceil(ro*1000000) - ro*1000000) <= 0.000001);

   if (!ChangingCoef) MaxOrder = N;
   if ( ChangingCoef) MaxOrder = (N1 > N2) ? N1 : N2;

   Order = MaxOrder + 2 + 1;
   CountInput = 0;

   if (!ChangingCoef) CurrentN = N;
   if ( ChangingCoef) CurrentN = N1;

   CalcCoef(CurrentN);
}

//===========================================================================
void TDst_C0_C1t::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


    // --------
        TFloat *iQueue  = iPoints->Items[0]->Queue;
        TFloat *oQueue1 = oPoints->Items[0]->Queue;
        TFloat *oQueue2 = oPoints->Items[1]->Queue;
        TFloat *oQueue3 = oPoints->Items[2]->Queue;

    // ---- Если меняющийся коеффициент ----------
        if ( CountInput > N1 - 1 && ChangingCoef && CurrentN <= N2) CalcCoef(CurrentN);
    // ----

        oQueue1[0] = 0;
        oQueue2[0] = 0;
        oQueue3[0] = 0;

        for (int i = 0; i <= CurrentN; i++ ){
                if ( Ro_Equal_One) {
                     alfa1 = Sigma0 + Sigma1*(CurrentN - i);
                     //alfa2 = (a3_ - a2_*(CurrentN - i));
                     alfa3 = (a1_*(CurrentN - i) - a2_) / pProjectParam->AnalogT0;
                } else {
                     alfa1 = Power(ro,i)*(Sigma0 + Sigma1*(CurrentN - i));
                     //alfa2 = Power(ro,i)*(a3_ - a2_*(CurrentN - i));
                     alfa3 = Power(ro,i)*(Sigma0 + Sigma1*(CurrentN - i));
                }

                oQueue1[0] += alfa1 * iQueue[i];
                //oQueue2[0] += alfa2 * iQueue[i];
                oQueue3[0] += alfa3 * iQueue[i];
       }
       oQueue2[0] = oQueue1[0] - oQueue3[0]* *pCurModelTime;

    // ----
       if ( CountInput > N1 - 1 && ChangingCoef && CurrentN < N2) CurrentN ++;
    // ----
       if (CountInput == 0) {
           oQueue1[0] = iQueue[0];
           oQueue2[0] = 0;
           oQueue3[0] = 0;
       }

       CountInput++;
}

