//===========================================================================

#include <vcl.h>
#include "Math.h"
#include "Math.hpp"

#pragma hdrstop

#include "mpiFar.h"
#include "mpiSetupMatrix.h"
#include "Unit_GraphicList.h"
#include "mpiDeclaration.h"
#include "Unit_Main.h"
#include "mpiGraph.h"

//===========================================================================

#pragma package(smart_init)

// =============================================================================
// ========================    ������ ������������ ���������  =================
//==============================================================================
void Calc_DirectionalCosines(TMatrix3x3 &aVector, TFloat inX, TFloat inY)
{
    aVector.cell[0][0] =  cos(inX) * cos(inY);   aVector.cell[0][1] = 0;   aVector.cell[0][2] = 0;
    aVector.cell[1][0] = -sin(inX) * cos(inY);   aVector.cell[1][1] = 0;   aVector.cell[1][2] = 0;
    aVector.cell[2][0] =  sin(inY);              aVector.cell[2][1] = 0;   aVector.cell[2][2] = 0;
}
// =============================================================================
// ========================    ������ ����� �� �������������� ���������  =======
//==============================================================================
void Calc_Angle(TMatrix3x3 &aVector, TFloat &OutX, TFloat &OutY)
{
   OutX = - Math::ArcTan2(aVector.cell[1][0], aVector.cell[0][0]);
   OutY =   _ArcSin_(aVector.cell[2][0]);
   //OutY =   Math::ArcTan2(aVector.cell[2][0], sqrt(fabs(1 - aVector.cell[2][0]*aVector.cell[2][0])));
}
// =============================================================================
// ========================    TransformCoordinates    =========================
//===========================================================================
void TransformCoordinates(TMatrix3x3 &aMatrix, TFloat inX, TFloat inY, TFloat &OutX, TFloat &OutY)
{
     TMatrix3x3  Vector;
  // -----------------

     Calc_DirectionalCosines(Vector, inX, inY);
  // -----------------

     Vector = aMatrix * Vector;
  // -----------------
     Calc_Angle(Vector, OutX, OutY);
}
// =============================================================================
// ===========================    Calc Teta Fi      ============================
// ==============================================================================
void TFar::Calc_DeltaQ_DeltaAlfa_Teta_Fi(TFloat aDeltaQ, TFloat aDeltaAlfa, TFloat &aTeta, TFloat &aFi)
{
  TFloat aq = aDeltaQ;
  TFloat aa = aDeltaAlfa;

  aTeta = _ArcCos_(cos(aa)*cos(aq));
  aFi   = Math::ArcTan2(sin(aa), cos(aa)*sin(aq));
/*  aTeta = _ArcCos_(cos(aDeltaAlfa)*cos(aDeltaQ));
  aFi   = aDeltaAlfa;*/
}
// =============================================================================
// ===========================    Calc DeltaQ DeltaAlfa     ====================
//==============================================================================
void TFar::Calc_Teta_Fi_DeltaQ_DeltaAlfa(TFloat aTeta, TFloat aFi, TFloat &aDeltaQ, TFloat &aDeltaAlfa)
{
  TFloat at = aTeta;
  TFloat af = aFi;

  aDeltaQ    = Math::ArcTan2(cos(af), cos(at));
  aDeltaAlfa = Math::ArcTan2(sin(af)*cos(aDeltaQ), cos(at));
  
/*  aDeltaQ    = _ArcCos_(cos(aTeta)/cos(aFi));
  aDeltaAlfa = aFi;*/
}

// =============================================================================
// ========================    Constructor TFar    =============================
// =============================================================================
TFar::TFar(TFloat *apCurTime, TFarParam *apFarParam)
{
     fpCurTime     = apCurTime;
     fpFarParam    = apFarParam;

     pCurAzimFAR_Geo       = &fCurAzimFAR_Geo;
     pCurAzimLuch_Geo      = &fCurAzimLuch_Geo;
     pStrobing             = &fStrobing;
     pLuchDistance         = &fLuchDistance;

  // --------
     Init();
}

// =============================================================================
// ========================    Destructor TFar    ==============================
// =============================================================================
TFar::~TFar()
{
//   if (DiagramArray != NULL) free(DiagramArray);
//   FreeAllArrays();
//   fOldBeamCount = -1;
}

//===========================================================================
void __fastcall TFar::Set_CurAzimFAR_Korabel(TFloat value)
{
     TMatrix3x3 Matrix_Geo_Korabel_t;
     TFloat     TempVariable;

  // -------------------------------------------------------

     TFloat fOldCurAzimFAR = fCurAzimFAR_Korabel;
     fCurAzimFAR_Korabel   = value;
     fCurAzimFAR_Korabel  -= int(fCurAzimFAR_Korabel/Two_Pi)*Two_Pi;

     if (fCurAzimFAR_Korabel > pi) fCurAzimFAR_Korabel -= Two_Pi;
     if (fOldCurAzimFAR < 0 && fCurAzimFAR_Korabel > 0) {
            fCountReview ++;
            CurReviewTime = 0;
     }

  // ------- ������ ������� ������ ---------
     Calc_Matrixs(this);

  // --------- ������ ������� �������� �� ��� � �� ���
/*      A_delta_Teta_k.cell[0][0] = 41;  A_delta_Teta_k.cell[0][1] = 13;   A_delta_Teta_k.cell[0][2] = 1;
      A_delta_Teta_k.cell[1][0] = 31;  A_delta_Teta_k.cell[1][1] = 12;   A_delta_Teta_k.cell[1][2] = 31;
      A_delta_Teta_k.cell[2][0] = 21;  A_delta_Teta_k.cell[2][1] = -1;   A_delta_Teta_k.cell[2][2] = 21;

      A_Teta_k.cell[0][0] = 231;  A_Teta_k.cell[0][1] = 11;   A_Teta_k.cell[0][2] = 21;
      A_Teta_k.cell[1][0] = 341;  A_Teta_k.cell[1][1] = 41;   A_Teta_k.cell[1][2] = 31;
      A_Teta_k.cell[2][0] = 231;  A_Teta_k.cell[2][1] = 31;   A_Teta_k.cell[2][2] = -1;

      Matrix_Geo_Stab       =    A_delta_Teta_k * A_Teta_k;
*/
      Matrix_Geo_Stab       =    A_delta_Teta_k * A_Teta_k * A_delta_Psi * A_Psi * A_delta_K_k * A_K_k;
      Matrix_Clear_Geo_Stab =                     A_Teta_k               * A_Psi               * A_K_k;
      Matrix_Geo_Far        =    A_delta_Nju * A_Nju * A_delta_Eps0 * A_Eps0 * A_delta_Q_a * A_Q_a * Matrix_Geo_Stab;
      Matrix_Clear_Geo_Far  =                  A_Nju                * A_Eps0               * A_Q_a * Matrix_Clear_Geo_Stab;

  // --------- ������ ��������� �������� �� �������� �� ��� � �� ���
     TransformCoordinates(tm(Matrix_Clear_Geo_Stab), fCurAzimFAR_Korabel, 0, fCurAzimFAR_Geo, TempVariable);
     //fCurAzimFAR_Geo      = fCurAzimFAR_Korabel;
}

void TFar::Set_DeltaQ_DeltaAlfa(TFloat aDeltaQ, TFloat aDeltaAlfa)
{
   if (DeltaQ != aDeltaQ || DeltaAlfa != aDeltaAlfa) {
        // ------- ������ ������� ������� ---------
           /*if (aDeltaAlfa <   5 * Pi_del_180) FarParam->WorkFreq = 8.85;
           if (aDeltaAlfa >=  5 * Pi_del_180 && aDeltaAlfa < 35 * Pi_del_180) FarParam->WorkFreq = 8.55;
           if (aDeltaAlfa >= 35 * Pi_del_180) FarParam->WorkFreq = 8.25;*/
           FarParam->WorkFreq = 8.55;

        // ------- ������ ������ ���� ---------
           FarParam->Diagram.Shir = 1.3 * 0.3 / FarParam->DiametrFar / FarParam->WorkFreq;

           DeltaQ    = aDeltaQ;
           DeltaAlfa = aDeltaAlfa;
           Calc_DeltaQ_DeltaAlfa_Teta_Fi(aDeltaQ, aDeltaAlfa, Teta, Fi);

           if (fStrobing) Calc_DirectionalCosines(Ravnosignal_DirectionalCosines, aDeltaQ, aDeltaAlfa);
        // ------------------------------------
           Graph->EllipseRedraw = true;
        // ------- ����� ���������� ����� -----
           if ( fStrobing) ReCreateDiagrams(4);
           //if (!fStrobing && Diagram_Count != 1) ReCreateDiagrams(1);

        // ------- ������ ����� ��������� �������� ������� ����� -----
           for (int i = 0; i < Diagram_Count; i ++) DiagramArray[i]->Calc_CutEllipse(DeltaQ, DeltaAlfa);
   }
}

//===========================================================================
void TFar::Init()
{
   *fpCurTime           = 0;
    fCountReview        = 0;
    fCurAzimFAR_Korabel = fpFarParam->KursAngle0;
    fCurAzimFAR_Geo     = 0;
    fCurAzimLuch_Geo    = 0;
    fCountReview        = 0;
    RandSeed            = MyRandSeed;
    DeltaAlfa = DeltaQ = Teta = Fi = -999;
    fStrobing           = false;

    Fa                     = int(300000.0/2.0/150.0/1.15);
    fpFarParam->fNormValue = sqrt(pow(10.0, fpFarParam->sh/10.0)*2);
}

//===========================================================================
void TFar::Calc_SpeedsFAR()
{
               OmegaXa = Teta_k->pValue + K_k->pValue*sin(Psi->Value);
               OmegaYa = Psi->pValue*cos(Teta_k->Value) - K_k->pValue*sin(Teta_k->Value)*cos(Psi->Value);
               OmegaZa = Psi->pValue*sin(Teta_k->Value) + K_k->pValue*cos(Teta_k->Value)*cos(Psi->Value);

             // ----------
               TFloat EpsX = Teta_k->ppValue + K_k->ppValue*sin(Psi->Value) + K_k->pValue*Psi->pValue*cos(Psi->Value);
               TFloat EpsY = Psi->ppValue*cos(Teta_k->Value) - Psi->pValue*Teta_k->pValue*sin(Teta_k->Value) - K_k->ppValue*sin(Teta_k->Value)*cos(Psi->Value) - K_k->pValue*Teta_k->pValue*cos(Teta_k->Value)*cos(Psi->Value) + K_k->pValue*Psi->pValue*sin(Teta_k->Value)*sin(Psi->Value);
               TFloat EpsZ = Psi->ppValue*sin(Teta_k->Value) + Psi->pValue*Teta_k->pValue*cos(Teta_k->Value) + K_k->ppValue*cos(Teta_k->Value)*cos(Psi->Value) - K_k->pValue*Teta_k->pValue*sin(Teta_k->Value)*cos(Psi->Value) - K_k->pValue*Psi->pValue*cos(Teta_k->Value)*sin(Psi->Value);

               TMatrix3x3 eeMatrix, VMatrix, WMatrix, kosOmega, kosEps;

               eeMatrix.cell[0][0] = fpFarParam->Hx;   eeMatrix.cell[0][1] = 0;  eeMatrix.cell[0][2] = 0;
               eeMatrix.cell[1][0] = fpFarParam->Hy;   eeMatrix.cell[1][1] = 0;  eeMatrix.cell[1][2] = 0;
               eeMatrix.cell[2][0] = fpFarParam->Hz;   eeMatrix.cell[2][1] = 0;  eeMatrix.cell[2][2] = 0;

               kosOmega.cell[0][0] =       0;    kosOmega.cell[0][1] = -OmegaZa;  kosOmega.cell[0][2] =  OmegaYa;
               kosOmega.cell[1][0] =  OmegaZa;   kosOmega.cell[1][1] =       0;  kosOmega.cell[1][2] = -OmegaXa;
               kosOmega.cell[2][0] = -OmegaYa;   kosOmega.cell[2][1] =  OmegaXa;  kosOmega.cell[2][2] =       0;

               kosEps.cell[0][0] =     0;   kosEps.cell[0][1] = -EpsZ;  kosEps.cell[0][2] =  EpsY;
               kosEps.cell[1][0] =  EpsZ;   kosEps.cell[1][1] =     0;  kosEps.cell[1][2] = -EpsX;
               kosEps.cell[2][0] = -EpsY;   kosEps.cell[2][1] =  EpsX;  kosEps.cell[2][2] =     0;

               VMatrix = kosOmega * eeMatrix;
               WMatrix = kosEps   * eeMatrix + kosOmega * VMatrix;

               Vxa = VMatrix.cell[0][0];
               Vya = VMatrix.cell[1][0];
               Vza = VMatrix.cell[2][0];

               Wxa = WMatrix.cell[0][0];
               Wya = WMatrix.cell[1][0];
               Wza = WMatrix.cell[2][0];
}

//===========================================================================
void TFar::Next()
{
  // ------- ������ �������� ������� ������� ---------
     CurAzimFAR_Korabel   = fpFarParam->KursAngle0 + fpFarParam->RotationSpeed * *fpCurTime;

  // ------- ������ ������� ��������, ��������� ������ ������� --------
     Calc_SpeedsFAR();

  // ----------------------------
     for (int i = 0; i < Targets_Count; i++){
       // ------- ������ ���� -------
          Targets[i]->Move();

       // ------- ������ ��������� ���� � �� ��� -------------
          TFloat aTeta, aFi;
          TransformCoordinates(Matrix_Clear_Geo_Far, Targets[i]->Coord.Q, Targets[i]->Coord.E, Targets[i]->Coord_Far_Clear.Q, Targets[i]->Coord_Far_Clear.E);
          TransformCoordinates(Matrix_Geo_Far      , Targets[i]->Coord.Q, Targets[i]->Coord.E, Targets[i]->Coord_Far.Q      , Targets[i]->Coord_Far.E      );
          Calc_DeltaQ_DeltaAlfa_Teta_Fi(Targets[i]->Coord_Far.Q, Targets[i]->Coord_Far.E, aTeta, aFi);

       // ----------------
          if (fStrobing && Targets[i]->Radiation || !fStrobing && !Targets[i]->Radiation) {

                  TFloat CheckValue = Targets[i]->SectorCoef * fpFarParam->HalfScanSector * 0.7;

                  if (     Targets[i]->Enabled && // --- ���� ���� � ���� ���������� ---------
                           aTeta < fpFarParam->MaxTetaAngle && // ----- ���� ���� �� ������ ������������� ���� ---
                           Targets[i]->Coord_Far.Q < CheckValue && // --- ���� ���� � ������� -----------
                      fabs(Targets[i]->Coord_Far.Q) <= fpFarParam->HalfScanSector && // ------
                      (!Targets[i]->Radiation1 && Targets[i]->Coord_Far.Q > 0 || Targets[i]->Radiation1 && Targets[i]->Coord_Far.Q <= 0)) {

                    // ----------------
                      if (Targets[i]->CountZondImpulses > 0) {
                            if (Targets[i]->CountZondImpulses == 20) {
                                       Targets[i]->Indicator_Redraw = true;

                                       Targets[i]->Coord_FisrtImpuls = Targets[i]->Coord;

                                    // ------- ������ ��������� ���� � �� ��� -------------
                                       TransformCoordinates(Matrix_Geo_Stab, Targets[i]->Coord_FisrtImpuls.Q, Targets[i]->Coord_FisrtImpuls.E, Targets[i]->Coord_Stab.Q, Targets[i]->Coord_Stab.E);

                                    // ------- ��� ���������� ��������� ������ -------------------
                                       Targets[i]->Coord_Stab.R               = Targets[i]->Coord.R;
                                       Targets[i]->Coord_Far_Clear.R          = Targets[i]->Coord.R;

                                       Targets[i]->IndicatorCoord             = Targets[i]->Coord;
                                       //Targets[i]->IndicatorCoord             = Targets[i]->Coord_Stab;

                                       Targets[i]->Radiation = fStrobing = true;
                                       fLuchDistance         = Targets[i]->Coord.R;

                                       fCurAzimLuch_Geo      = Targets[i]->Coord.Q;
                                       //fCurAzimLuch_Geo      = Targets[i]->Coord_Stab.Q;
                                    // ----------------------------------------------------
                                       Fa                    = int(300000.0 / 2.0 / fLuchDistance/1.15);     // -------- ����� ������� ���������� ��������� ------

                                    // -----------------------------
                                       Targets[i]->TargetAccess_Count++;

                                       Targets[i]->TargetAccess     = (TTargetAccess*) realloc (Targets[i]->TargetAccess, sizeof(TTargetAccess) * Targets[i]->TargetAccess_Count);

                                       Targets[i]->TargetAccess[Targets[i]->TargetAccess_Count - 1].Init();
                                       Targets[i]->TargetAccess[Targets[i]->TargetAccess_Count - 1].Ideal_Coord_Far = Targets[i]->Coord_Far_Clear;
                                       Targets[i]->TargetAccess[Targets[i]->TargetAccess_Count - 1].Ideal_Coord_Geo = Targets[i]->Coord;
                            }

                             // ------- (����, ���� ���������� ���) ���������� ���������� ���� � ���� ��� ��������� ������� ������������ �������� -------------
                               TFloat aDeltaQ, aDeltaAlfa;
                               TransformCoordinates(Matrix_Geo_Far, Targets[i]->Coord_FisrtImpuls.Q, Targets[i]->Coord_FisrtImpuls.E, aDeltaQ, aDeltaAlfa);

                             ///////////////////////// �������� ���� ��� � ������ ������ ������������������� ��������� ���� (���� � ������� ����� ������� ��� ��������� - �� ���������e ) //////////////////////////
                               if (Targets[i]->CountZondImpulses == 20) {
                                     Targets[i]->SkoShum1 = RandG(0,fpFarParam->SigmaEkstrapol);
                                     Targets[i]->SkoShum2 = RandG(0,fpFarParam->SigmaEkstrapol);
                               }
                             // ---- ���������� ���� �������� ���� -------  
                               Set_DeltaQ_DeltaAlfa(aDeltaQ + Targets[i]->SkoShum1, aDeltaAlfa + Targets[i]->SkoShum2);
                             /////////////////////////

                          // ----- ������ ��������� ������������� �������� ������� ����������� �� ���� ----------
                             if (Targets[i]->CountZondImpulses == 20) {
                                 Targets[i]->tm_Fixed_Geo_Far = tm(Matrix_Clear_Geo_Far);
                                 Targets[i]->___Fixed_Far_Ravnosignal_DirectionalCosines = Ravnosignal_DirectionalCosines;
                             }

                          // -------
                             Targets[i]->TargetAccess[Targets[i]->TargetAccess_Count - 1].Add_New_Impuls();
                             Targets[i]->CalcRadiationValue();
                          // -------
                             Targets[i]->CountZondImpulses --;

                      } else {
                              if (Targets[i]->SectorCoef > 0) { Targets[i]->Radiation1 = true;  Targets[i]->SectorCoef = -0.70;
                              } else { Targets[i]->Radiation1 = Targets[i]->Radiation2 = false; Targets[i]->SectorCoef = 1.0; }
                              Targets[i]->CountZondImpulses = 20;
                              Targets[i]->Radiation     = fStrobing = false;

                            // ---- ������ ��������� ���� �� ������ ����������� ��������� ----------
                              Targets[i]->CalcPosition();
                      }
                  } else {
                    Targets[i]->Radiation = fStrobing = false;
                  }
                  // if (Targets[i]->Enabled && Targets[i]->FAR_Q_c < Targets[i]->SectorCoef * fpFarParam->HalfScanSector * 0.7 && (!Targets[i]->Radiation1 && Targets[i]->FAR_Q_c > 0 || Targets[i]->Radiation1 && Targets[i]->FAR_Q_c < 0))
          }// --- if (fStrobing && Targets[i]->Radiation || !fStrobing && !Targets[i]->Radiation) { ---
     } // --- for (int i = 0; i < Targets_Count; i++){ ------

   // --------------------- ����� �����������  ----------
     if (!fStrobing) {
          fLuchDistance             = 150;
          fCurAzimLuch_Geo          = fCurAzimFAR_Geo + 5 * Pi_del_180;
          Fa                        = int(300000.0/2.0/150.0/1.15);

         ///////////////////////// �������� ���� ��� //////////////////////////
          Set_DeltaQ_DeltaAlfa(5 * Pi_del_180, 0);
         /////////////////////////
     }
}
//===========================================================================

