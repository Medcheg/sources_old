//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiZV00.h"
#include "mpiDeclaration.h"
#include "mpiTypes.h"
#include "mpiSigp_J.h"
#include "mpiNLC.h"
#include "Unit_Main.h"
#include "Unit_Table.h"
//===========================================================================
#pragma package(smart_init)
//===========      Block of local Variable   ================================
const int     BorderWidth = 58;

//int   BeginX, BeginY, EndX, EndY;
int    OffsetX;        // ---- Смещения окна отрисовки ----
int    OffsetY;        // ---- Смещения окна отрисовки ----
TFloat CoefX;          // ---- Маштабный коеф отображения данных по горизонтали ----
TFloat CoefY;          // ---- Маштабный коеф отображения данных по вертикальной оси ----
int    aScreenWidth;   // ---- Рeальная ширина екрана ---
int    aScreenHeight;  // ---- Реальна высота екрана ---
int    CountSkipPoint;

TFloat     MaxAltitude, MinAltitude;
TFloat     ddd;
TFloat     ccc;
//TFloat     y2;
TFloat     y;
TFloat     PosZeroLine;
//int        MashtabCoef;
TFloat     dle1;
TFloat     dle2;
TFloat     sg0;
TFloat     q_op, q_op_0;
TFloat     rh2;
TFloat     plt;
//TData      sn,pp;

//===========================================================================
//===========================================================================
//=============       Initialization         ================================
//===========================================================================
void Init()
{
     TFloat  P1,P2,ll,ll_dB,GPer_raz,GPri_raz;
     TFloat  h,aaaaaa,PotR_raz,PotT_raz;

   // ---------------
     trans_reg = 1;
     N_Sh      = 9;
     L_pot_J   = 6.5;
     GPri_sum  = 32;        //(*** dB ***)
     GPri_part = 31.5;      //(*** dB ***)

   // --------------
     for (int i = 1; i < 68 + 1; i++) q0[i] = 0;
     DDist    = 20;
     ll       = sqr(ZvData.Lambda/(4*pi));
     ll_dB    = 10 * log10(ll);
     Tau      = 4e-7;
     T_P      = 4e-6;
     GPer     = 10; //{GPer = 32;}
     GPri     = 10; //{GPri = 32;}

     GPri_raz = exp(GPri * log(10.0)/10.0);
     GPer_raz = exp(GPer * log(10.0)/10.0);
     PPer     = 10;   // (****   dB   ******)
     PPer_raz = exp(PPer * log(10.0)/10.0); // {pwr(10,pper/10)}
     PPri     = 1E-13;
     PPri_min = -125;
     ksi      = 3;
     PotT     = 4;  // (* dB *)
     PotR     = 1;  // (* dB *)
     PotR_raz = exp(PotR * log(10.0)/10.0);
     PotT_raz = exp(PotT * log(10.0)/10.0);
     ksi_raz  = exp(ksi  * log(10.0)/10.0);
     Dsw      = sqrt(PPer_raz * GPer_raz * GPri_raz * ll/(PotT_raz * PotR_raz * ksi_raz * PPri)); //{x}///writeln('Dsw=',Dsw:12:3);

     P1       =  10 * log10(PPer_raz) - /*10*lg(PotT)*/ PotT + 10 * log10(GPer_raz);
     P2       = -10 * log10(PPri    ) - /*10*lg(PotR)*/ PotR + 10 * log10(GPri_raz) - ksi + ll_dB;
     h        = 0.5*exp(log(ZvData.Re*sqr(ZvData.Lambda)/sqr(pi))/3.0);
     aaaaaa   = exp(log(sqr(ZvData.Re)*ZvData.Lambda/pi)/3.0);

     //q0[14]   = SeaSurfaceShum;
     //q0[8]    = ha;
/*     q0[11]   = ZvData.Re;
     q0[12]   = rz;*/
     //q0[13]   = ZvData.Lambda;
     q0[15]   = 3.0*pi_del_180;
     q0[16]   = 0.0211;
     q0[26]   = WorkSeaSurfaceShum * pi / ZvData.Lambda;
     q0[27]   = aaaaaa;
     q0[28]   = h;
     q0[29]   = 2.0 * pi / ZvData.Lambda;
     Line_obn = P1 + P2;  // {x}///writeln(Line_obn:12:6);

     ppol     = 2;
     eps      = 80;

     se       = 0.0005;
     sse_F    = GPri_sum+ll_dB-L_pot_J+204-N_Sh;  // // {x}///writeln('sse_F = ',sse_F:12:6);
     sse_F    = exp(sse_F*log(10.0)/10.0);
     sse_K    = GPri_part+ll_dB-L_pot_J+204-N_Sh; // {x}///writeln('sse_K = ',sse_K:12:6);
     sse_K    = exp(sse_K*log(10.0)/10.0);  // {x}///readln;
}

//===========================================================================
//===========================================================================
//====================       CalcColor       ===============================
//===========================================================================
TColor CalcColor(TFloat aff)
{
/*
     if (aff < 0.005     ) return arver[0]; else
     if (aff < arnver[2] ) return arver[1]; else
     if (aff < arnver[3] ) return arver[2]; else
     if (aff < arnver[4] ) return arver[3]; else
     if (aff < arnver[5] ) return arver[4]; else
     if (aff < arnver[6] ) return arver[5]; else
     if (aff < arnver[7] ) return arver[6]; else
     if (aff < arnver[8] ) return arver[7]; else return arver[8];
*/
//     if (aff < 0.005     ) return arver[0]; else
//     if (aff < arnver[2] ) return arver[1]; else

     if (aff < arnver[3] ) return arver[0]; else
     if (aff < arnver[4] ) return arver[3]; else
     if (aff < arnver[5] ) return arver[4]; else
     if (aff < arnver[6] ) return arver[5]; else
     if (aff < arnver[7] ) return arver[6]; else return arver[7];
//     if (aff < arnver[8] ) return arver[7];// else return arver[8];
}

//===========================================================================
//===========================================================================
//=======================       trouble       ===============================
//===========================================================================
TFloat trouble(TFloat diri, TFloat highi)
{
     TFloat q_2, q1_2, vij, dne, dnw, Result = 0;
  // ------
     if (fabs(highi) < 1e-3) highi = 0;

     TFloat dc = sqrt(sqr(diri)+sqr(highi - (ZvData.Ha + DeltaHa)));

  // --
     TFloat ee = ArcTan2((highi - (ZvData.Ha + DeltaHa)), diri);
  // --

     TFloat hc    = sqrt(sqr(ZvData.Re + highi) + sqr(diri)) - ZvData.Re;
     TFloat drgii = 4.12 * (sqrt(1000 * (ZvData.Ha + DeltaHa)) + sqrt(1000 * hc)); // 4.12 * (sqrt(1000.0 * (ZvData.Ha + DeltaHa)) + sqrt(1000.0 * hc));
  // ------
     if (dc > drgii || ee > dle1 || ee < dle2) Result = 1.2345e-12;
       else {
              dnw = DN_SIN(ZvData.EpsLuch, ee, ZvData.ShirLuchV);
              dnw = 20.0 * log(dnw) / log(10.0);

              foid(dc, highi, ZvData.EpsLuch, ZvData.ShirLuchV, ppol, eps, vij, DN_SIN); // SN_SINb

              dne  = 40.0 * log(vij) / log(10.0);

            // -- !!!
              q1_2 = Qqr(q_op_0, dc, rh2);
            // -- !!!
              q_2  = q1_2 + 2.0*dnw + dne;
             // ---

              if (q_2 >= q_op) Result = ZvData.Pd; else Result = 0.0;

              if (ZvData.OtherPd){
                 Result = Prdf(q_2, plt);
                 if (Result >= 0.99) Result = 0.99;
              }
       }

 return Result;
}

//===========================================================================
//===========================================================================
//===========================================================================
void CalcMashtabCoef()
{
       aScreenWidth  = aWindow.Width()  - 2*BorderWidth;
       aScreenHeight = aWindow.Height() -   BorderWidth;
       OffsetX       = aWindow.Left + BorderWidth;
       OffsetY       = aWindow.Top  + BorderWidth;

       MaxAltitude = (ZvData.Ha + DeltaHa) + ZvData.MaxVerticalDistance;
       MinAltitude = MaxAltitude * 0.15;//sqr(MaxGorizontDistance) / (ZvData.Re * 19.0);
       y                   = MaxAltitude + MinAltitude;
       PosZeroLine         = round( aScreenHeight * MaxAltitude / y);   ////writeln(PosZeroLine:12);readln;

       CountSkipPoint = (Esktrapoling)? 2 : 1;

       CoefX             = ZvData.MaxGorizontDistance / aScreenWidth;
       CoefY             = ZvData.MaxVerticalDistance / PosZeroLine;
}

//===========================================================================
//===========================================================================
//====================     Draw_Net_and_Labels    ===========================
//===========================================================================
void Draw_Net_and_Labels()
{
   // ----------------------------------
     MainCanvas->Pen ->Color  = AxesColor;
     MainCanvas->Font->Color  = FontColor;
     MainCanvas->Font->Style  = TFontStyles();
     MainCanvas->Font->Size   = 8;

   // ----------------------------------
     AnsiString  OutStr;
     int         TextWidth, TextHeight;

   // --------------------------------------------------------------------------------------------
   // --------- Отрисовка наклонной дальности ----------------------------------------------------
   // --------------------------------------------------------------------------------------------

     TPoint *aCurve = NULL;
     int     aCurvePointCount;
     TFloat  FiStep = (!ZvData.OtherPd)? 5e-6:5e-5;
     bool    Finding;
     int     RowCount = 1;
     for (TFloat k = 0; k <= 100.0 * ZvData.MaxVerticalDistance + 0.00001; k = k + ZvData.VerticalAxisValueStep){
            MainCanvas->Pen->Color = BackupColor;
            MainCanvas->Pen->Style = psDot;
            MainCanvas->Brush->Style = bsClear;

            aCurvePointCount = 0;
            Finding          = false; // ---- нашли ли точку ------

         // ------- Расчет угла ФИ -------
            TFloat   CalcFi;
            TFloat   ri        = ZvData.Re + k;
            TFloat   bd        = ZvData.Re - (aWindow.Bottom - PosZeroLine - OffsetY) * CoefY;
            TFloat   dc        = sqrt (ri*ri - bd*bd);
            TFloat   MaxDC     = aWindow.Right - OffsetX - BorderWidth;
            if (dc / CoefX < MaxDC) CalcFi = ArcCos(bd / ri); else CalcFi = ArcSin((MaxDC * CoefX) / ri);
         // ------- End of Расчет угла ФИ -------

          for (TFloat fi = CalcFi * 1.0; fi >= -0.0000010; fi = fi - FiStep) {
                int    rpX = OffsetX + ri / CoefX * sin(fi);
                int    rpY = OffsetY + PosZeroLine - ri / CoefY * cos(fi) + ZvData.Re / CoefY;

             // ---------------------
                if (!ZvData.OtherPd && !Finding && k != 0) {
                           TColor ac = MainCanvas->Pixels[rpX][rpY];
                           if (ac ==  CalcColor(ZvData.Pd)){
                               Finding = true;
                               MainCanvas->Pen->Color = FontColor;
                               MainCanvas->Pen->Style = psSolid;

                               MainCanvas->Ellipse(rpX - 4, rpY - 4, rpX + 4, rpY + 4);

                               MainCanvas->Pen->Color = BackupColor;
                               MainCanvas->Pen->Style = psDot;
                               MainCanvas->Brush->Style = bsClear;

                               RowCount ++;
                               frmTable->StringGrid1->RowCount = RowCount;
                               frmTable->StringGrid1->Cells[0][frmTable->StringGrid1->RowCount - 1] = FloatToStrF( k * 1000.0 , ffFixed, 20, 2);
                               frmTable->StringGrid1->Cells[1][frmTable->StringGrid1->RowCount - 1] = FloatToStrF( (rpX - OffsetX) * CoefX , ffFixed, 20, 2);
                               Application->ProcessMessages();
                           }
                }
             // ----- Проверочки ----
                if (aCurvePointCount == 0 && rpY < OffsetY) {k = 99999999999999; break; }
                if (rpY < aWindow.Top) break;

             // ----- Отрисовка -------
                aCurve = (TPoint*) realloc (aCurve, sizeof(TPoint) * (++aCurvePointCount));
                aCurve[aCurvePointCount-1].x = rpX;
                aCurve[aCurvePointCount-1].y = rpY;
             // ---- Отрисовка Земли ----
                if (k == 0) {
                     MainCanvas->Pen->Color = clRed;
                     MainCanvas->Pen->Style = psSolid;
                    MainCanvas->Ellipse(rpX - 3, rpY - 3, rpX + 3, rpY + 3);
                }
          }
          if (aCurvePointCount > 2 && k != 0) MainCanvas->Polyline(aCurve, aCurvePointCount - 1);
     }
     free (aCurve);

     MainCanvas->Brush->Style = bsSolid;
     MainCanvas->Pen->Color = BgColor;
     MainCanvas->Brush->Color = BgColor;
     MainCanvas->Rectangle(aWindow.Left, aWindow.Top, aWindow.Right, OffsetY);
     MainCanvas->Rectangle(aWindow.Left, aWindow.Top, OffsetX, aWindow.Bottom);
     //MainCanvas->Rectangle(aWindow.Right - BorderWidth, aWindow.Top, aWindow.Right, OffsetY + PosZeroLine);

   // --------------------------------------------------------------------------------------------
   // --------- Отрисовка Цветовой гаммы вероятностей ------------
   // --------------------------------------------------------------------------------------------
     MainCanvas->TextOut(aWindow.Left + 20, OffsetY + PosZeroLine + 30, "Surface");
     if (ZvData.OtherPd) {
         MainCanvas->Brush->Style = bsSolid;
         MainCanvas->Brush->Color = BgColor;
         MainCanvas->Font ->Color = FontColor;
         MainCanvas->TextOut(OffsetX + 20, OffsetY + PosZeroLine + 40,"Detection");
         MainCanvas->TextOut(OffsetX + 20, OffsetY + PosZeroLine + 60,"Probability");

         for (int i = 3; i < 8 ; i ++) {
              MainCanvas->Brush->Color = arver[i];
              MainCanvas->FillRect(Rect(OffsetX + 40*(i-2) + 40, OffsetY + PosZeroLine + 40 , OffsetX +  40*(i-2) + 80,OffsetY + PosZeroLine + 52));

              MainCanvas->Brush->Color = BgColor;
              MainCanvas->Font ->Color = FontColor;
              MainCanvas->TextOut(OffsetX + 40*(i-2) + 45, OffsetY + PosZeroLine + 60, FloatToStr(arnver[i])); //outtextxy(40*(i-2)+110,470,st);
         }
     }

   // --------------------------------------------------------------------------------------------
   // --------- Отрисовка текстухи  ---------------------
   // ----------------------------------
       MainCanvas->Brush->Style = bsSolid;
       MainCanvas->Brush->Color = BgColor;
       MainCanvas->Font ->Color = FontColor;

       AnsiString asR0 = "------";
       if (frmMain->cbCalcBaseDistance->Checked) asR0 = FloatToStrF(ZvData.BasicDistance, ffFixed, 20,2) + " km";

       MainCanvas->TextOut(aWindow.Left  + 10, aWindow.Top + 10              , "H,m");
       MainCanvas->TextOut(aWindow.Right - 30, OffsetY     + PosZeroLine + 20, "R,km");
       MainCanvas->TextOut(aWindow.Right - 100, aWindow.Top + 10, "DeltaHa = " + FloatToStrF(DeltaHa * 1000.0, ffFixed, 20,2) + " m");
       MainCanvas->TextOut(aWindow.Right - 200, aWindow.Top + 10, "Ro = " + asR0  + " km");
       MainCanvas->TextOut(aWindow.Right - 300, aWindow.Top + 10, "R  = " + FloatToStrF(WorkBasicDistance, ffFixed, 20,2) + " km");
       MainCanvas->TextOut(aWindow.Right - 355, aWindow.Top + 10, "N = " + IntToStr(ZvData.ImpulsCount));

   // --------------------------------------------------------------------------------------------
   // --------- Отрисовка вертикальнои осевои линии (слева) ------------
   // --------------------------------------------------------------------------------------------
      MainCanvas->Pen->Color = AxesColor;
      MainCanvas->Pen->Style = psSolid;
      MainCanvas->Brush->Style = bsSolid;
//      MainCanvas->Brush->Color = BgColor;
      MainCanvas->MoveTo(OffsetX, OffsetY + PosZeroLine + 10);
      MainCanvas->LineTo(OffsetX, OffsetY + PosZeroLine - ZvData.MaxVerticalDistance / CoefY - 35);

     for (TFloat k = 0; k <= ZvData.MaxVerticalDistance + 0.00001; k = k + ZvData.VerticalAxisValueStep){
       // ---- Отрисовка тиков -----
          MainCanvas->MoveTo(OffsetX - 2, round(OffsetY + PosZeroLine - k / CoefY));
          MainCanvas->LineTo(OffsetX + 3, round(OffsetY + PosZeroLine - k / CoefY));

          OutStr = FloatToStrF(k * 1000.0, ffFixed, 20, 1);
          TextWidth  = MainCanvas->TextWidth(OutStr);
          TextHeight = MainCanvas->TextHeight(OutStr);

          MainCanvas->TextOut(OffsetX - 10 - TextWidth, OffsetY + PosZeroLine - k / CoefY - TextHeight / 2, OutStr);
     }

   // --------------------------------------------------------------------------------------------
   // --------- Отрисовка Горизонтальной осевои линии (нижней)------------
   // --------------------------------------------------------------------------------------------
     MainCanvas->MoveTo(OffsetX       - 10, OffsetY + PosZeroLine);
     MainCanvas->LineTo(aWindow.Right - 20, OffsetY + PosZeroLine);

     for (TFloat k = 0; k <= ZvData.MaxGorizontDistance + 0.00001; k = k + ZvData.GorizontalAxisValueStep){
       // ---- Отрисовка линий дальности --------
          if (k != 0) {
              MainCanvas->Pen->Color = BackupColor;
              MainCanvas->Brush->Style = bsClear;
              MainCanvas->Pen->Style = psDot;
              MainCanvas->MoveTo(round(OffsetX + k / CoefX), OffsetY );
              MainCanvas->LineTo(round(OffsetX + k / CoefX), OffsetY + PosZeroLine);
          }

       // ---- Отрисовка тиков ----
          MainCanvas->Pen->Style = psSolid;
          MainCanvas->Pen->Color = AxesColor;
          //MainCanvas->Brush->Style = bsSolid;
          MainCanvas->MoveTo(round(OffsetX + k / CoefX), OffsetY + PosZeroLine - 2);
          MainCanvas->LineTo(round(OffsetX + k / CoefX), OffsetY + PosZeroLine + 3);


          OutStr = FloatToStrF(k, ffFixed, 20, 1);
          TextWidth  = MainCanvas->TextWidth(OutStr);
          TextHeight = MainCanvas->TextHeight(OutStr);

          MainCanvas->TextOut(OffsetX + k / CoefX - TextWidth / 2, OffsetY + PosZeroLine + 10, OutStr);
     }

     MainCanvas->Pen->Style = psSolid;
     MainCanvas->Pen->Color = AxesColor;

   // --------------------------------------------------------------------------------------------
   // --------- Отрисовка вертикальнои осевои линии (справа) ------------
   // --------------------------------------------------------------------------------------------
     MainCanvas->MoveTo(aWindow.Right - BorderWidth, round(OffsetY + PosZeroLine));
     MainCanvas->LineTo(aWindow.Right - BorderWidth, round(OffsetY + PosZeroLine - ZvData.MaxVerticalDistance / CoefY));

   // --------------------------------------------------------------------------------------------
   // --------- Отрисовка Горизонтальной осевои линии (вверхней)------------
   // --------------------------------------------------------------------------------------------
     MainCanvas->MoveTo(OffsetX                    , round(OffsetY + PosZeroLine - ZvData.MaxVerticalDistance / CoefY));
     MainCanvas->LineTo(aWindow.Right - BorderWidth, round(OffsetY + PosZeroLine - ZvData.MaxVerticalDistance / CoefY));

   // --------------------------------------------------------------------------------------------
   // --------- Отрисовка yгломестной оси ------------
   // --------------------------------------------------------------------------------------------

     TFloat     FloatPosX = 0, FloatPosY = 0;
     int        PosX      = 0, PosY      = 0;

     for (int i = 0; i < AnglesTickCount; i++) {
        MainCanvas->Pen->Color = AxesColor;

        if (AnglesTick[i].Value > 0 ) FloatPosX = ZvData.MaxVerticalDistance / Tan(AnglesTick[i].Value * pi_del_180); else FloatPosX = ZvData.MaxGorizontDistance;
        if (AnglesTick[i].Value < 90) FloatPosY = Tan(AnglesTick[i].Value * pi_del_180) * ZvData.MaxGorizontDistance; else FloatPosY = ZvData.MaxVerticalDistance;

        if (FloatPosX > ZvData.MaxGorizontDistance) FloatPosX = ZvData.MaxGorizontDistance;
        if (FloatPosY > ZvData.MaxVerticalDistance) FloatPosY = ZvData.MaxVerticalDistance;

        PosX = round(FloatPosX / CoefX);
        PosY = round(FloatPosY / CoefY);

        MainCanvas->MoveTo(OffsetX + PosX - 2, OffsetY + PosZeroLine - PosY);
        MainCanvas->LineTo(OffsetX + PosX + 3, OffsetY + PosZeroLine - PosY);

        MainCanvas->MoveTo(OffsetX + PosX, OffsetY - 2);
        MainCanvas->LineTo(OffsetX + PosX, OffsetY + 3);

       // ------ Отрисовка угломестных линий -------
         if (AnglesLine && i != 0 && i != AnglesTickCount - 1) {
             MainCanvas->Pen->Color = BackupColor;
             MainCanvas->Pen->Style = psDot;
             MainCanvas->Brush->Style = bsClear;
             MainCanvas->MoveTo(OffsetX       , OffsetY + PosZeroLine);
             MainCanvas->LineTo(OffsetX + PosX, OffsetY + PosZeroLine - PosY);
             MainCanvas->Pen->Style = psSolid;
             MainCanvas->Pen->Color = AxesColor;
         }

       // ------ Отрисовка Текстовых угломестных отметок  -------
         if (AnglesTick[i].Visible) {
                MainCanvas->Pen->Color = FontColor;

             //   MainCanvas->Brush->Style = bsSolid;
                OutStr     = FloatToStrF(AnglesTick[i].Value, ffFixed, 20, 1);
                TextWidth  = MainCanvas->TextWidth(OutStr);
                TextHeight = MainCanvas->TextHeight(OutStr);

                 if (PosX == round(ZvData.MaxGorizontDistance / CoefX)) {
                     MainCanvas->TextOut(OffsetX + PosX + 10, OffsetY + PosZeroLine - PosY - TextHeight / 2, OutStr);

                     int x = OffsetX + PosX + 10 + TextWidth + 4;
                     int y = OffsetY + PosZeroLine - PosY - TextHeight / 2;
                     MainCanvas->Ellipse(x, y, x + 5, y + 5);
                 }
                 if (PosY == round(ZvData.MaxVerticalDistance / CoefY)) {
                     int aOffset = (AnglesTick[i].Value == 90)?15:0;
                     MainCanvas->TextOut(OffsetX + aOffset + PosX - TextWidth / 2, OffsetY + PosZeroLine - PosY - 6 - TextHeight, OutStr);

                     int x = OffsetX + aOffset + PosX + TextWidth / 2 + 4;
                     int y = OffsetY + PosZeroLine - PosY - 6 - TextHeight;
                     MainCanvas->Ellipse(x, y, x + 5, y + 5);
                 }
         }
     }
}

//===========================================================================
//===========================================================================
//=======================       Risov        ================================
//===========================================================================
void Risov()
{
     // -------------------
       frmTable->Close();
       Application->ProcessMessages();
     // -------------------
       Init();
     // ---------------------
       dle1         = ZvData.EpsLuch + 1.1*ZvData.ShirLuchV; // -
       dle2         = ZvData.EpsLuch - 1.1*ZvData.ShirLuchV;
     // ---------------------
       plt      = Power(10, -ZvData.Pfa);
       q_op_0   = Qfd(plt, 0.5); //{0.5} //
       q_op     = Qfd(plt, ZvData.Pd); //{0.5} //
       rh2      = WorkBasicDistance * exp(q_op_0 / 40.0)/ exp(q_op / 40.0);
       //por          = thld(plt,sg0); //  // sg0          = 1.0;
     // ---------------------

      // ----------- Ощищая канву ---------
        if (!DynamicModelRun) {
             MainCanvas->Pen  ->Color = BgColor;
             MainCanvas->Brush->Color = BgColor;
             MainCanvas->Rectangle(aWindow.Left, aWindow.Top, aWindow.Right, aWindow.Bottom);
        }

     // ---------------------------------
         CalcMashtabCoef();
         Draw_Net_and_Labels();

     // ----------- Ниже переменные нуные для оптимизации -------
         int    aTempValue1 = aScreenHeight - PosZeroLine;
         TFloat aTempValue2 = aScreenHeight / y;
         TFloat aTempValue3 = sqr(CountSkipPoint * CoefX)/ (ZvData.Re * 2.0);
         TFloat aTempValue4 = CountSkipPoint * CoefX;
         TFloat aTempValue5 = CountSkipPoint * CoefY;

     // -----------
         TColor   ColorValue;
         TFloat   dd = 0, hh = 0, dh, aValue;
         int      PosX, PosY, numsnig = 0;

         frmMain->CGauge1->MaxValue = (aScreenWidth + 1 + 1) / CountSkipPoint - 1;
         frmMain->CGauge1->Progress = 0;
     // -----------
         for (int i = 1; i < (aScreenWidth + 1 + 1) / CountSkipPoint; i ++){
                dh         = i*i*aTempValue3;
                numsnig    = (dh <= MinAltitude) ? round(dh * aTempValue2) : aTempValue1;
              // -------
                for (int j = 2; j < (PosZeroLine + numsnig - 1) / CountSkipPoint ; j ++) {
                        dd = i*aTempValue4;                             // --  Текущая Дальность ----
                        hh = ZvData.MaxVerticalDistance + dh - j*aTempValue5;  // --  Текущая Высота ----
                     // -----------
                        aValue     = trouble(dd, hh);
                        ColorValue = CalcColor(aValue);
                     // -----------
                        if ((ColorValue != 0 || DynamicModelRun) ) {
                                if (aValue < 0.5) ColorValue = BgColor;
                                PosX = OffsetX + i*CountSkipPoint;
                                PosY = j*CountSkipPoint + OffsetY;
                                MainCanvas->Pixels[PosX][PosY] = ColorValue;
                              // ----------
                                if (Esktrapoling) {
                                    MainCanvas->Pixels[PosX - 1][PosY    ] = ColorValue;
                                    MainCanvas->Pixels[PosX - 1][PosY - 1] = ColorValue;
                                    MainCanvas->Pixels[PosX    ][PosY - 1] = ColorValue;
                                }
                        }
                        if (Stoped) break;
                }
              // -------
                frmMain->CGauge1->Progress = i;
                if (Stoped) break;
                Application->ProcessMessages();
         }

   // ------------ Запоминаем то чо нарисовали ---------
       Draw_Net_and_Labels();
       TRect aRect = Rect(0,0,RedrawBitmap->Width, RedrawBitmap->Height);
       RedrawBitmap->Canvas->CopyRect(aRect, MainCanvas, aWindow);
       RedrawBitmap->Canvas->Pixels[0][0] = BgColor;
       RedrawBitmap->Canvas->Pixels[1][0] = BackupColor;
   // --------
      if (!ZvData.OtherPd) frmTable->Show();
}
