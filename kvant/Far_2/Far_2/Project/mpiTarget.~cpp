//===========================================================================

#include <vcl.h>
#include "Math.h"
#include <Math.hpp>
#pragma hdrstop

#include "mpiTarget.h"
#include "mpiFar.h"
#include "mpiSetupMatrix.h"
#include "mpiLibrary.h"
#include "Unit_Main.h"
#include "Unit_GraphicList.h"

//===========================================================================

#pragma package(smart_init)

//===========================================================================
TTarget::TTarget(TFarParam * apFarParam)
{
  fpFarParam = apFarParam;
  Radiation  = false;
  TargetAccess = NULL;
  TargetAccess_Count = 0;

  x0 = y0 = z0 = Vx = Vy = R0 = B0 = V0 = H0 = K0 = 1;
}

//===========================================================================
TTarget::~TTarget()
{
   if (TargetAccess != NULL) {
        for (int i = 0; i < TargetAccess_Count; i ++) TargetAccess[i].Destroy_Impuls();
      // --------
        free(TargetAccess);
   }
}

//===========================================================================
void TTarget::Init()
{
    xi = yi = zi = Rz = Eps0 = -999;

  // ---------------------------------
    Coord.Init();

  // ---------------------------------
    IndicatorCoord = OldIndicatorCoord = Coord_Far_Clear = Coord_Far = Coord;
    Indicator_Redraw      = false;

  // ---------------------------------
    Radiation = Radiation1 = Radiation2 = false;
    CountZondImpulses = 20;
    Enabled           = true;
    SectorCoef        = 1.0;

  // ---------------------------------
    for (int i = 0; i < TargetAccess_Count; i ++) TargetAccess[i].Destroy_Impuls();
    if (TargetAccess_Count != 0) {
       free(TargetAccess);
    }
    TargetAccess = NULL;
    TargetAccess_Count = 0;
  // ---------------- Начальные значения ---------
    Rz = 999912345.0;

    z0 = H0 - fpFarParam->Hz * 0.001; /* - R0*R0/2.0/Rz*/ Eps0 = _ArcSin_(z0/R0);
    x0 = R0*sin(B0)*cos(Eps0);
    y0 = R0*cos(B0)*cos(Eps0);

    Vx = V0 * sin(K0);
    Vy = V0 * cos(K0);
}

//===========================================================================
void TTarget::Move()
{

  // --------- Эсли нулевой момент времени --------
    if (xi == -999) {  xi = x0;  yi = y0;  zi = z0; Coord.R = R0; }

/*    xi = xi + (_Vx + Vx)*1/150.0;
    yi = yi + (_Vy + Vy)*1/150.0;
    zi = H0 - sqr(Coord.R) / 2.0 / Rz - (fpFarParam->Hz * 0.001 + VerticalSpeedShip->Value);*/

    xi = xi + (Vx - Vxa * 0.001 - SpeedShip->Value * cos( K_k->Value ) * 0.001) / (TFloat) aFar->Fa;
    yi = yi + (Vy - Vya * 0.001 - SpeedShip->Value * sin( K_k->Value ) * 0.001) / (TFloat) aFar->Fa;
    zi = zi + (   - Vza * 0.001                                               ) / (TFloat) aFar->Fa - VerticalSpeedShip->Value * 0.001; // - sqr(Coord.R) / 2.0 / Rz

  // ----------------------------------------------
    Coord.R = sqrt(xi*xi + yi*yi + zi*zi);
    Coord.Q = Math::ArcTan2(yi , xi);
    Coord.E = _ArcSin_( zi / Coord.R);

  // -----------------------------------------------
    if (IndicatorCoord.Q == -999) {
        IndicatorCoord    = Coord;
        OldIndicatorCoord = Coord;
    }

  // -----------------------------------------------
    if (Coord.R >= 150) {
      Enabled            = false;
      Indicator_Redraw   = true;
      IndicatorCoord.Q   = -999;
      IndicatorCoord.E   = -999;
      IndicatorCoord.R   = -999;
    }
}

//===========================================================================
void TTarget::Get_Ro1_Ro2(TImpuls aImpuls, TFloat &aRo1, TFloat &aRo2)
{
      int    k1 = 1;
      int    k2 = 1;
      TFloat aEndRo   = round((1.4 * fpFarParam->Diagram.Shir) / fpFarParam->DeltaRo1) * fpFarParam->DeltaRo1;

   // -----------  Определяю четверть в которой работаем ---------
      aImpuls.E1 = round(aImpuls.E1 * 10000000000.0) / 10000000000.0;   // -------- Убираю ошибку вычислителя ---------
      aImpuls.E2 = round(aImpuls.E2 * 10000000000.0) / 10000000000.0;   // -------- Убираю ошибку вычислителя ---------

      fpFarParam->DeltaRo1 = fabs(fpFarParam->DeltaRo1); // --- возращаю в исходное положение смещения ---
      fpFarParam->DeltaRo2 = fabs(fpFarParam->DeltaRo2); // --- возращаю в исходное положение смещения ---м

      if (aImpuls.E1 <  0 && aImpuls.E2 >= 0) { fpFarParam->DeltaRo1 = -fpFarParam->DeltaRo1; k1 = -1;}
      if (aImpuls.E1 <  0 && aImpuls.E2 <  0) { fpFarParam->DeltaRo1 = -fpFarParam->DeltaRo1; k1 = -1; fpFarParam->DeltaRo2 = -fpFarParam->DeltaRo2; k2 = -1;}
      if (aImpuls.E1 >  0 && aImpuls.E2 <  0) { fpFarParam->DeltaRo2 = -fpFarParam->DeltaRo2; k2 = -1;}

     TImpuls k[4];
     for (TFloat CurRo2 = 0; fabs(CurRo2) < fabs(k2*aEndRo); CurRo2 = CurRo2 + fpFarParam->DeltaRo2) {
         for (TFloat CurRo1 = 0; fabs(CurRo1) < fabs(k1*aEndRo); CurRo1 = CurRo1 + fpFarParam->DeltaRo1) {

              // ----------- Расчитываем нормированные сигналы углового отклонения ---------
                  k[0] = KoefPelengCharacteristic(false, false, CurRo1            , CurRo2);
                  k[1] = KoefPelengCharacteristic(false, false, CurRo1 + fpFarParam->DeltaRo1, CurRo2);
                  k[2] = KoefPelengCharacteristic(false, false, CurRo1 + fpFarParam->DeltaRo1, CurRo2 + fpFarParam->DeltaRo2);
                  k[3] = KoefPelengCharacteristic(false, false, CurRo1            , CurRo2 + fpFarParam->DeltaRo2);

                  TFloat minK1 =  10000000;
                  TFloat maxK1 = -10000000;
                  TFloat minK2 =  10000000;
                  TFloat maxK2 = -10000000;
                  for (int i = 0; i < 4; i++) {
                      if (minK1 > k[i].E1) minK1 = k[i].E1;
                      if (minK2 > k[i].E2 ) minK2 = k[i].E2;
                      if (maxK1 < k[i].E1) maxK1 = k[i].E1;
                      if (maxK2 < k[i].E2 ) maxK2 = k[i].E2;
                  }

                  if (aImpuls.E1 >= minK1 && aImpuls.E1 < maxK1 && aImpuls.E2 >= minK2 && aImpuls.E2 < maxK2){
                     TFloat aKoefK1 = (aImpuls.E1 - minK1) / (maxK1 - minK1);
                     TFloat aKoefK2 = (aImpuls.E2 - minK2) / (maxK2 - minK2);

                     aRo1 = CurRo1 + fpFarParam->DeltaRo1 * aKoefK1;
                     aRo2 = CurRo2 + fpFarParam->DeltaRo2 * aKoefK2;
                     aRo1 = CurRo1 + fpFarParam->DeltaRo1 * aKoefK1;
                     aRo2 = CurRo2 + fpFarParam->DeltaRo2 * aKoefK2;

                     return;
                  }
         }
     }
}

//===========================================================================
TImpuls TTarget::KoefPelengCharacteristic(bool aCalcDirectionalCosines, bool aCalcRelay, TFloat aQ_c, TFloat aEps_c)
{
   TFloat   *aRadValue = (TFloat*) malloc (sizeof(TFloat) * Diagram_Count);
   TImpuls   Res;

   // ----------- Расчет значений вольтов для каждого из лучей ---------
     for (int i = 0; i < Diagram_Count; i++) {
            TFloat     aOffsetX, aOffsetY;
            if (aCalcDirectionalCosines) {

                 // -------- Смещение относительно "нуля" центра луча В НАПРАВЛЯЮЩИХ КОСИНУСАХ-------
                    aOffsetX = fDirectionalCosines.cell[1][0] - DiagramArray[i]->DirectionalCosines.cell[1][0];
                    aOffsetY = fDirectionalCosines.cell[2][0] - DiagramArray[i]->DirectionalCosines.cell[2][0];
            } else {
                    aOffsetX = sin(aQ_c  ) - sin(DiagramArray[i]->OffsetX);
                    aOffsetY = sin(aEps_c) - sin(DiagramArray[i]->OffsetY);
            }

         // -------- А теперь смещение относительно "нуля" центра луча в радианах-------
            aOffsetX = _ArcSin_(aOffsetX);
            aOffsetY = _ArcSin_(aOffsetY);


            //aOffsetX = aOffsetX*cos(DiagramArray[i]->Fi) - aOffsetY*sin(DiagramArray[i]->Fi);
            //aOffsetY = aOffsetY*cos(DiagramArray[i]->Fi) + aOffsetX*sin(DiagramArray[i]->Fi);


         // ------------------- Ниже типа аРадВалуе нуно умножить косинус Тета
            aRadValue[i] = DiagramArray[i]->Get_SignalStrength(aOffsetX, aOffsetY);
            if (aCalcRelay) aRadValue[i] = DiagramArray[i]->Get_RelayValue(aRadValue[i]);
     }

   // -------- Теперь расчитаным мощностям в каждом луче расчитываем координаты цели --------
      TFloat SumRadValue =   aRadValue[0] + aRadValue[2]  +  aRadValue[1] + aRadValue[3];
      Res.E1 = ((aRadValue[1] + aRadValue[3]) - (aRadValue[0] + aRadValue[2])) / SumRadValue;
      Res.E2 = ((aRadValue[0] + aRadValue[1]) - (aRadValue[2] + aRadValue[3])) / SumRadValue;

      free (aRadValue);
      return Res;
}

//===========================================================================
void TTarget::CalcRadiationValue()
{
   // -------- Направляющий косинус положения цели в СК ФАР -------
      Calc_DirectionalCosines(fDirectionalCosines, Coord_Far_Clear.Q, Coord_Far_Clear.E);

   // -----------------------------
      TargetAccess[TargetAccess_Count - 1].Impuls[TargetAccess[TargetAccess_Count - 1].Impuls_Count - 1]      = KoefPelengCharacteristic(true, true, Coord_Far_Clear.Q, Coord_Far_Clear.E);
      TargetAccess[TargetAccess_Count - 1].Impuls[TargetAccess[TargetAccess_Count - 1].Impuls_Count - 1].Time = CurModelTime;
      //TargetAccess[TargetAccess_Count - 1].CurImpuls->Time = CurModelTime;
}

//===========================================================================
void TTarget::CalcPosition()
{
   TTargetAccess *ta = &TargetAccess[TargetAccess_Count - 1];


   TImpuls aImpuls;
   TFloat  aRo, aFi, aRo1, aRo2;
   TFloat  aTempQ = 0, aTempE = 0;
   TFloat  aSumQ = 0, aSumE = 0;
   // -----------------------------
       aImpuls.E1   = 0;
       aImpuls.E2   = 0;
       aImpuls.Time = 0;


   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // -------------- Расчет координат по методу №1 ---------------
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          for (int i = 0; i < ta->Impuls_Count; i ++) {
                Get_Ro1_Ro2(ta->Impuls[i], aRo1, aRo2);
                //Get_Ro_Fi(ta->Impuls[i], aRo, aFi);

             // ----------------------------------------------------------
                fDirectionalCosines.cell[1][0] = -sin(aRo1) + ___Fixed_Far_Ravnosignal_DirectionalCosines.cell[1][0];
                fDirectionalCosines.cell[2][0] =  sin(aRo2) + ___Fixed_Far_Ravnosignal_DirectionalCosines.cell[2][0];
                fDirectionalCosines.cell[0][0] = sqrt(1 - sqr(fDirectionalCosines.cell[1][0]) - sqr(fDirectionalCosines.cell[2][0]));
                /*fDirectionalCosines.cell[1][0] = sin(aRo*cos(aFi)) + ___Fixed_Far_Ravnosignal_DirectionalCosines.cell[1][0];
                fDirectionalCosines.cell[2][0] = sin(aRo*sin(aFi)) + ___Fixed_Far_Ravnosignal_DirectionalCosines.cell[2][0];
                fDirectionalCosines.cell[0][0] = sqrt(1 - sqr(fDirectionalCosines.cell[1][0]) - sqr(fDirectionalCosines.cell[2][0]));*/

             // --------- Положение цели в системе координат ФАР ---------
                Calc_Angle(fDirectionalCosines, aTempQ, aTempE);
                aSumQ = aSumQ + aTempQ;
                aSumE = aSumE + aTempE;
          }
       // --------- Положение цели в системе координат ФАР ---------
          aSumQ = aSumQ / (TFloat) ta->Impuls_Count;
          aSumE = aSumE / (TFloat) ta->Impuls_Count;
          ta->Coord_M1.Far.Q = aSumQ;
          ta->Coord_M1.Far.E = aSumE;
       // --------- Положение цели в системе координат GEO ---------
          TransformCoordinates(tm_Fixed_Geo_Far, ta->Coord_M1.Far.Q, ta->Coord_M1.Far.E
                                               , ta->Coord_M1.Geo.Q, ta->Coord_M1.Geo.E);

   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // -------------- Расчет координат по методу №2 "Опредиление координат цели по методу накопления амплитуд"---------------
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          for (int i = 0; i < ta->Impuls_Count; i ++) {
             aImpuls.E1 += ta->Impuls[i].E1;
             aImpuls.E2 += ta->Impuls[i].E2;
          }
          aImpuls.E1 = aImpuls.E1 / (TFloat) ta->Impuls_Count;
          aImpuls.E2 = aImpuls.E2 / (TFloat) ta->Impuls_Count;

       // -----------------------------
          Get_Ro1_Ro2(aImpuls, aRo1, aRo2);
          //Get_Ro_Fi(aImpuls, aRo, aFi);

       // -----------------------------
          fDirectionalCosines.cell[1][0] = -sin(aRo1) + ___Fixed_Far_Ravnosignal_DirectionalCosines.cell[1][0];
          fDirectionalCosines.cell[2][0] =  sin(aRo2) + ___Fixed_Far_Ravnosignal_DirectionalCosines.cell[2][0];
          fDirectionalCosines.cell[0][0] = sqrt(1 - sqr(fDirectionalCosines.cell[1][0]) - sqr(fDirectionalCosines.cell[2][0]));
          /*fDirectionalCosines.cell[1][0] = sin(aRo*cos(aFi)) + ___Fixed_Far_Ravnosignal_DirectionalCosines.cell[1][0];
          fDirectionalCosines.cell[2][0] = sin(aRo*sin(aFi)) + ___Fixed_Far_Ravnosignal_DirectionalCosines.cell[2][0];
          fDirectionalCosines.cell[0][0] = sqrt(1 - sqr(fDirectionalCosines.cell[1][0]) - sqr(fDirectionalCosines.cell[2][0]));*/

       // --------- Положение цели в системе координат ФАР ---------
          Calc_Angle(fDirectionalCosines, ta->Coord_M2.Far.Q, ta->Coord_M2.Far.E);

       // --------- Положение цели в системе координат GEO ---------
          TransformCoordinates(tm_Fixed_Geo_Far, ta->Coord_M2.Far.Q, ta->Coord_M2.Far.E
                                               , ta->Coord_M2.Geo.Q, ta->Coord_M2.Geo.E);
       // --------- Расчет Таненых Тета Фи  ---------
       // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       // Внимание тут наколка -
          TFloat aa, bb;
          aFar->Calc_DeltaQ_DeltaAlfa_Teta_Fi(ta->Ideal_Coord_Far.Q, ta->Ideal_Coord_Far.E, aa, bb);
              ta->Ideal_Coord_Far.Q = aa; ta->Ideal_Coord_Far.E = bb;
          aFar->Calc_DeltaQ_DeltaAlfa_Teta_Fi(ta->Coord_M1.Far.Q,    ta->Coord_M1.Far.E,    aa, bb);
              ta->Coord_M1.Far.Q = aa;    ta->Coord_M1.Far.E = bb;
          aFar->Calc_DeltaQ_DeltaAlfa_Teta_Fi(ta->Coord_M2.Far.Q,    ta->Coord_M2.Far.E,    aa, bb);
              ta->Coord_M2.Far.Q = aa;    ta->Coord_M2.Far.E = bb;
       // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

       // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

          ta->Coord_M1.Far.Q -= ta->Ideal_Coord_Far.Q;
          ta->Coord_M1.Far.E -= ta->Ideal_Coord_Far.E;
          ta->Coord_M1.Geo.Q -= ta->Ideal_Coord_Geo.Q;
          ta->Coord_M1.Geo.E -= ta->Ideal_Coord_Geo.E;

          ta->Coord_M2.Far.Q -= ta->Ideal_Coord_Far.Q;
          ta->Coord_M2.Far.E -= ta->Ideal_Coord_Far.E;
          ta->Coord_M2.Geo.Q -= ta->Ideal_Coord_Geo.Q;
          ta->Coord_M2.Geo.E -= ta->Ideal_Coord_Geo.E;

   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // --------  Расчет текущих ошибок ------------
      if (TargetAccess_Count > 0) {
         // ------ Расчет средних значений ----
           for (int i = 0; i < TargetAccess_Count; i++){
             ta->Coord_M1.Far.fCurSumQ += TargetAccess[i].Coord_M1.Far.Q;
             ta->Coord_M1.Far.fCurSumE += TargetAccess[i].Coord_M1.Far.E;
             ta->Coord_M1.Geo.fCurSumQ += TargetAccess[i].Coord_M1.Geo.Q;
             ta->Coord_M1.Geo.fCurSumE += TargetAccess[i].Coord_M1.Geo.E;

             ta->Coord_M2.Far.fCurSumQ += TargetAccess[i].Coord_M2.Far.Q;
             ta->Coord_M2.Far.fCurSumE += TargetAccess[i].Coord_M2.Far.E;
             ta->Coord_M2.Geo.fCurSumQ += TargetAccess[i].Coord_M2.Geo.Q;
             ta->Coord_M2.Geo.fCurSumE += TargetAccess[i].Coord_M2.Geo.E;
           }
             ta->Coord_M1.Far.SredErrorQ = ta->Coord_M1.Far.fCurSumQ / (TFloat) TargetAccess_Count;
             ta->Coord_M1.Far.SredErrorE = ta->Coord_M1.Far.fCurSumE / (TFloat) TargetAccess_Count;
             ta->Coord_M1.Geo.SredErrorQ = ta->Coord_M1.Geo.fCurSumQ / (TFloat) TargetAccess_Count;
             ta->Coord_M1.Geo.SredErrorE = ta->Coord_M1.Geo.fCurSumE / (TFloat) TargetAccess_Count;

             ta->Coord_M2.Far.SredErrorQ = ta->Coord_M2.Far.fCurSumQ / (TFloat) TargetAccess_Count;
             ta->Coord_M2.Far.SredErrorE = ta->Coord_M2.Far.fCurSumE / (TFloat) TargetAccess_Count;
             ta->Coord_M2.Geo.SredErrorQ = ta->Coord_M2.Geo.fCurSumQ / (TFloat) TargetAccess_Count;
             ta->Coord_M2.Geo.SredErrorE = ta->Coord_M2.Geo.fCurSumE / (TFloat) TargetAccess_Count;
        // ---
           TFloat odds;
           for (int i = 0; i < TargetAccess_Count; i++){
             odds  = TargetAccess[i].Coord_M1.Far.Q - ta->Coord_M1.Far.SredErrorQ;  ta->Coord_M1.Far.SKOErrorQ += odds*odds;
             odds  = TargetAccess[i].Coord_M1.Far.E - ta->Coord_M1.Far.SredErrorE;  ta->Coord_M1.Far.SKOErrorE += odds*odds;
             odds  = TargetAccess[i].Coord_M1.Geo.Q - ta->Coord_M1.Geo.SredErrorQ;  ta->Coord_M1.Geo.SKOErrorQ += odds*odds;
             odds  = TargetAccess[i].Coord_M1.Geo.E - ta->Coord_M1.Geo.SredErrorE;  ta->Coord_M1.Geo.SKOErrorE += odds*odds;

             odds  = TargetAccess[i].Coord_M2.Far.Q - ta->Coord_M2.Far.SredErrorQ;  ta->Coord_M2.Far.SKOErrorQ += odds*odds;
             odds  = TargetAccess[i].Coord_M2.Far.E - ta->Coord_M2.Far.SredErrorE;  ta->Coord_M2.Far.SKOErrorE += odds*odds;
             odds  = TargetAccess[i].Coord_M2.Geo.Q - ta->Coord_M2.Geo.SredErrorQ;  ta->Coord_M2.Geo.SKOErrorQ += odds*odds;
             odds  = TargetAccess[i].Coord_M2.Geo.E - ta->Coord_M2.Geo.SredErrorE;  ta->Coord_M2.Geo.SKOErrorE += odds*odds;
           }
      }
      ta->Coord_M1.Far.SKOErrorQ = sqrt(ta->Coord_M1.Far.SKOErrorQ / (TFloat) TargetAccess_Count);
      ta->Coord_M1.Far.SKOErrorE = sqrt(ta->Coord_M1.Far.SKOErrorE / (TFloat) TargetAccess_Count);
      ta->Coord_M1.Geo.SKOErrorQ = sqrt(ta->Coord_M1.Geo.SKOErrorQ / (TFloat) TargetAccess_Count);
      ta->Coord_M1.Geo.SKOErrorE = sqrt(ta->Coord_M1.Geo.SKOErrorE / (TFloat) TargetAccess_Count);

      ta->Coord_M2.Far.SKOErrorQ = sqrt(ta->Coord_M2.Far.SKOErrorQ / (TFloat) TargetAccess_Count);
      ta->Coord_M2.Far.SKOErrorE = sqrt(ta->Coord_M2.Far.SKOErrorE / (TFloat) TargetAccess_Count);
      ta->Coord_M2.Geo.SKOErrorQ = sqrt(ta->Coord_M2.Geo.SKOErrorQ / (TFloat) TargetAccess_Count);
      ta->Coord_M2.Geo.SKOErrorE = sqrt(ta->Coord_M2.Geo.SKOErrorE / (TFloat) TargetAccess_Count);
    // ----------

      for (int i = 0; i < TargetAccess_Count; i++){
          if (ta->Coord_M1.Far.MaxErrorQ < fabs(TargetAccess[i].Coord_M1.Far.Q)) ta->Coord_M1.Far.MaxErrorQ = fabs(TargetAccess[i].Coord_M1.Far.Q);
          if (ta->Coord_M1.Far.MaxErrorE < fabs(TargetAccess[i].Coord_M1.Far.E)) ta->Coord_M1.Far.MaxErrorE = fabs(TargetAccess[i].Coord_M1.Far.E);
          if (ta->Coord_M1.Geo.MaxErrorQ < fabs(TargetAccess[i].Coord_M1.Geo.Q)) ta->Coord_M1.Geo.MaxErrorQ = fabs(TargetAccess[i].Coord_M1.Geo.Q);
          if (ta->Coord_M1.Geo.MaxErrorE < fabs(TargetAccess[i].Coord_M1.Geo.E)) ta->Coord_M1.Geo.MaxErrorE = fabs(TargetAccess[i].Coord_M1.Geo.E);
          if (ta->Coord_M2.Far.MaxErrorQ < fabs(TargetAccess[i].Coord_M2.Far.Q)) ta->Coord_M2.Far.MaxErrorQ = fabs(TargetAccess[i].Coord_M2.Far.Q);
          if (ta->Coord_M2.Far.MaxErrorE < fabs(TargetAccess[i].Coord_M2.Far.E)) ta->Coord_M2.Far.MaxErrorE = fabs(TargetAccess[i].Coord_M2.Far.E);
          if (ta->Coord_M2.Geo.MaxErrorQ < fabs(TargetAccess[i].Coord_M2.Geo.Q)) ta->Coord_M2.Geo.MaxErrorQ = fabs(TargetAccess[i].Coord_M2.Geo.Q);
          if (ta->Coord_M2.Geo.MaxErrorE < fabs(TargetAccess[i].Coord_M2.Geo.E)) ta->Coord_M2.Geo.MaxErrorE = fabs(TargetAccess[i].Coord_M2.Geo.E);
      }
}

