//===========================================================================

#include <vcl.h>
#include <windows.h>
#pragma hdrstop
#pragma argsused
//===========================================================================
#include "mpiSetupWaves.h"
#include "mpiSetupMatrix.h"
#include "Unit_SetupWaves.h"
#include "Unit_ShowWave.h"

//===========================================================================
#if defined(__cplusplus)
extern "C" {
#endif
void   __stdcall __declspec( dllexport ) Rocking_InitDLL(TRockingData *aRockingData);
void   __stdcall __declspec( dllexport ) Rocking_SetParameters();
void   __stdcall __declspec( dllexport ) Rocking_ShowModelResult();
void   __stdcall __declspec( dllexport ) Rocking_Run();                                                      
void   __stdcall __declspec( dllexport ) Rocking_Get_Betta_Epsilon();
void   __stdcall __declspec( dllexport ) Rocking_Get_Betta_Epsilon_and_TargetError();
#if defined(__cplusplus)
}
#endif

// =============================================================================
// =============================================================================
// =============================================================================

TImpuls       Impuls[100];
TMatrix3x3    zzDirectionalCosines;
TFloat        ClearBetta;
TFloat        ClearEpsilon;


// =============================================================================
// ========================    ������ ������������ ���������  ==================
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
}

// =============================================================================
// ========================    TransformCoordinates    =========================
//==============================================================================
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
// ========================        =============================================
//==============================================================================
int __fastcall round(double aValue)
{
  int aFloor = floor(aValue);

  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
}

// =============================================================================
// ======================== KoefPelengCharacteristic ===========================
//==============================================================================
TImpuls KoefPelengCharacteristic(bool aCalcDirectionalCosines, bool aCalcRelay, TFloat aQ_c, TFloat aEps_c)
{
   TFloat   *aRadValue = (TFloat*) malloc (sizeof(TFloat) * Diagram_Count);
   TImpuls   Res;

   // ----------- ������ �������� ������� ��� ������� �� ����� ---------
     for (int i = 0; i < Diagram_Count; i++) {
            TFloat     aOffsetX, aOffsetY;
            if (aCalcDirectionalCosines) {

                 // -------- �������� ������������ "����" ������ ���� � ������������ ���������-------
                    aOffsetX = zzDirectionalCosines.cell[1][0] - DiagramArray[i]->DirectionalCosines.cell[1][0];
                    aOffsetY = zzDirectionalCosines.cell[2][0] - DiagramArray[i]->DirectionalCosines.cell[2][0];
            } else {
                    aOffsetX = sin(aQ_c  ) - sin(DiagramArray[i]->OffsetX);
                    aOffsetY = sin(aEps_c) - sin(DiagramArray[i]->OffsetY);
            }

         // -------- � ������ �������� ������������ "����" ������ ���� � ��������-------
            aOffsetX = _ArcSin_(aOffsetX);
            aOffsetY = _ArcSin_(aOffsetY);


            //aOffsetX = aOffsetX*cos(DiagramArray[i]->Fi) - aOffsetY*sin(DiagramArray[i]->Fi);
            //aOffsetY = aOffsetY*cos(DiagramArray[i]->Fi) + aOffsetX*sin(DiagramArray[i]->Fi);


         // ------------------- ���� ���� ��������� ���� �������� ������� ����
            aRadValue[i] = DiagramArray[i]->Get_SignalStrength(aOffsetX, aOffsetY);
            if (aCalcRelay) aRadValue[i] = DiagramArray[i]->Get_RelayValue(aRadValue[i]);
     }

   // -------- ������ ���������� ��������� � ������ ���� ����������� ���������� ���� --------
      TFloat SumRadValue =   aRadValue[0] + aRadValue[2]  +  aRadValue[1] + aRadValue[3];

      if (SumRadValue != 0) {
          Res.E1 = ((aRadValue[1] + aRadValue[3]) - (aRadValue[0] + aRadValue[2])) / SumRadValue;
          Res.E2 = ((aRadValue[0] + aRadValue[1]) - (aRadValue[2] + aRadValue[3])) / SumRadValue;
      } else {
          Res.E1 = 0;
          Res.E2 = 0;
      }

      free (aRadValue);
      return Res;
}

//===========================================================================
void Get_Ro1_Ro2(TImpuls aImpuls, TFloat &aRo1, TFloat &aRo2)
{
      int    k1 = 1;
      int    k2 = 1;
      if (*FarParam.DeltaRo1 < 0.0005) *FarParam.DeltaRo1 = 0.0005;
      if (*FarParam.DeltaRo2 < 0.0005) *FarParam.DeltaRo2 = 0.0005;
      TFloat aEndRo   = round((1.4 * FarParam.Diagram.Shir) / *FarParam.DeltaRo1) * *FarParam.DeltaRo1;

   // -----------  ��������� �������� � ������� �������� ---------
      aImpuls.E1 = round(aImpuls.E1 * 10000000000.0) / 10000000000.0;   // -------- ������ ������ ����������� ---------
      aImpuls.E2 = round(aImpuls.E2 * 10000000000.0) / 10000000000.0;   // -------- ������ ������ ����������� ---------

      *FarParam.DeltaRo1 = fabs(*FarParam.DeltaRo1); // --- �������� � �������� ��������� �������� ---
      *FarParam.DeltaRo2 = fabs(*FarParam.DeltaRo2); // --- �������� � �������� ��������� �������� ---�

      if (aImpuls.E1 <  0 && aImpuls.E2 >= 0) { *FarParam.DeltaRo1 = -*FarParam.DeltaRo1; k1 = -1;}
      if (aImpuls.E1 <  0 && aImpuls.E2 <  0) { *FarParam.DeltaRo1 = -*FarParam.DeltaRo1; k1 = -1; *FarParam.DeltaRo2 = -*FarParam.DeltaRo2; k2 = -1;}
      if (aImpuls.E1 >  0 && aImpuls.E2 <  0) { *FarParam.DeltaRo2 = -*FarParam.DeltaRo2; k2 = -1;}

     TImpuls k[4];
     for (TFloat CurRo2 = 0; fabs(CurRo2) < fabs(k2*aEndRo); CurRo2 = CurRo2 + *FarParam.DeltaRo2) {
         for (TFloat CurRo1 = 0; fabs(CurRo1) < fabs(k1*aEndRo); CurRo1 = CurRo1 + *FarParam.DeltaRo1) {

              // ----------- ����������� ������������� ������� �������� ���������� ---------
                  k[0] = KoefPelengCharacteristic(false, false, CurRo1                     , CurRo2                     );
                  k[1] = KoefPelengCharacteristic(false, false, CurRo1 + *FarParam.DeltaRo1, CurRo2                     );
                  k[2] = KoefPelengCharacteristic(false, false, CurRo1 + *FarParam.DeltaRo1, CurRo2 + *FarParam.DeltaRo2);
                  k[3] = KoefPelengCharacteristic(false, false, CurRo1                     , CurRo2 + *FarParam.DeltaRo2);

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

                     aRo1 = CurRo1 + *FarParam.DeltaRo1 * aKoefK1;
                     aRo2 = CurRo2 + *FarParam.DeltaRo2 * aKoefK2;
                     aRo1 = CurRo1 + *FarParam.DeltaRo1 * aKoefK1;
                     aRo2 = CurRo2 + *FarParam.DeltaRo2 * aKoefK2;

                     return;
                  }
         }
     }
}


//===========================================================================
//===========================================================================
//===========================================================================
void   __stdcall Rocking_InitDLL(TRockingData *aRockingData)
{
          RockingData = aRockingData;

          FarParam.DiametrFar = 1.5;
          FarParam.Diagram.Form        = dfCos; //dfSinH_H
          FarParam.Diagram.Type        = dtActive;//dtPassive;//dtActive;//;

          FarParam.Diagram.CutLevel           = RockingData->CutLevel;
          FarParam.Diagram.KoefPlacingDiagram = RockingData->KoefPlacingDiagram;
          FarParam.Sh                         = RockingData->Sh;
          FarParam.Sigma2                     = RockingData->Sigma2;
          FarParam.DeltaRo1                   = RockingData->DeltaRo1;
          FarParam.DeltaRo2                   = RockingData->DeltaRo2;
          FarParam.Hx                         = RockingData->Hx;
          FarParam.Hy                         = RockingData->Hy;
          FarParam.Hz                         = RockingData->Hz;

          FarParam.SigmaEkstrapol             = 0.0  * Pi_del_180;

          FarParam.DiametrFar                 = 1.5;
          FarParam.WorkFreq                   = 8.55;
          FarParam.fNormValue                 = sqrt(pow(10.0, *FarParam.Sh / 10.0)*2);



    // ------- ������ ������ ���� ---------
          FarParam.Diagram.Shir = 1.3 * 0.3 / FarParam.DiametrFar / FarParam.WorkFreq;

    // --------
         if (DiagramArray != NULL) Destroy_Diagrams();

         Diagram_Count = 4;
         DiagramArray  = (TDiagram**) malloc (sizeof(TDiagram*) * (Diagram_Count));
     // --------
         DiagramArray[0] = new TDiagram(&FarParam, dpTopLeft);
         DiagramArray[1] = new TDiagram(&FarParam, dpTopRight);
         DiagramArray[2] = new TDiagram(&FarParam, dpBottomLeft);
         DiagramArray[3] = new TDiagram(&FarParam, dpBottomRight);


     // --------


        frmShowWave->Init();
}

//===========================================================================
//===========================================================================
//===========================================================================
void __stdcall Rocking_SetParameters()
{
     TfrmSetupWaves *dlg;

     try {
        dlg = new TfrmSetupWaves(NULL);
        dlg->ShowModal();
     } __finally {
        delete dlg;
     }
}

//===========================================================================
//===========================================================================
//===========================================================================
void __stdcall Rocking_ShowModelResult()
{
  try {
     frmShowWave->Show();
  } catch ( ... ) {
  }
}

//===========================================================================
//===========================================================================
//===========================================================================
void   __stdcall Rocking_Run()
{
  // ------ ������� ��������� ����� -----------
      CurModelTime = (TFloat) *RockingData->pIntCurrentTime / (TFloat) RockingData->TimeTransformCoef;
  // ------ ������� ��������� ����� -----------
      Calc_Wave();

  // ------ ���������� ������ -----------
      frmShowWave->Add();
      frmShowWave->Draw();
}

void   __stdcall Rocking_Get_Betta_Epsilon()
{
   // ------ ������ ����� -----------
      Rocking_Run();
   // ------- ������ ������� ������ ---------
      Calc_Matrixs();

   // --------- ������ ������� �������� �� ��� � �� ���
      Matrix_Geo_Stab       =    A_delta_Teta_k * A_Teta_k * A_delta_Psi * A_Psi * A_delta_K_k * A_K_k;
      Matrix_Clear_Geo_Stab =                     A_Teta_k               * A_Psi               * A_K_k;

      Matrix_Geo_Far        =    A_delta_Nju * A_Nju * A_delta_Eps0 * A_Eps0 * A_delta_Q_a * A_Q_a * Matrix_Geo_Stab;
      Matrix_Clear_Geo_Far  =                  A_Nju                * A_Eps0               * A_Q_a * Matrix_Clear_Geo_Stab;

   // ----------
      TFloat ClearQ = 0;
      TFloat ClearE = 0;
      TFloat Q      = 0;
      TFloat E      = 0;

   // ----------
      TransformCoordinates(Matrix_Clear_Geo_Far, RockingData->TargetPeleng, RockingData->TargetEpsilon, ClearQ, ClearE);
      TransformCoordinates(Matrix_Geo_Far      , RockingData->TargetPeleng, RockingData->TargetEpsilon, Q     , E);

   // ------------------ ����� ���� ������� -----
      ClearBetta           = ClearQ;
      ClearEpsilon         = ClearE;
      RockingData->Betta   = Q;
      RockingData->Epsilon = E;

      RockingData->DeltaBetta   = Q - ClearQ;
      RockingData->DeltaEpsilon = E - ClearE;
}

//===========================================================================
void   __stdcall Rocking_Get_Betta_Epsilon_and_TargetError()
{
    ///////////////////////////////////////
        Rocking_Get_Betta_Epsilon();
    ///////////////////////////////////////

     // -------- ������������ ������� ��������� ���� � �� ��� -------
       Calc_DirectionalCosines(Ravnosignal_DirectionalCosines, RockingData->Betta, RockingData->Epsilon);
       Calc_DirectionalCosines(zzDirectionalCosines, ClearBetta, ClearEpsilon);
       
    // ----- ��������� ��������, ��������� ��� ������� �������� --------------
       for (int i = 0; i < RockingData->ImpulsCount; i++) {
       
          // --- Calc_DirectionalCosines(fDirectionalCosines, Coord_Far_Clear.Q, Coord_Far_Clear.E); ---
              Impuls[i].Init();
              Impuls[i].Time = CurModelTime;
              Impuls[i]      = KoefPelengCharacteristic(true, true, RockingData->Betta, RockingData->Epsilon);
              //Impuls[i]      = KoefPelengCharacteristic(true, false, RockingData->Betta, RockingData->Epsilon);

       }

       TImpuls      aImpuls;
       TFloat       aRo1, aRo2;
       TMatrix3x3   fDirectionalCosines;
       TFloat       Q_FAR, Eps_FAR;
       TFloat       Q_Geo, Eps_Geo;

   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // -------------- ������ ��������� �� ������ �2 "����������� ��������� ���� �� ������ ���������� ��������"---------------
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       for (int i = 0; i < RockingData->ImpulsCount; i ++) {
           aImpuls.E1 += Impuls[i].E1;
           aImpuls.E2 += Impuls[i].E2;
       }
       aImpuls.E1 = aImpuls.E1 / (TFloat) RockingData->ImpulsCount;
       aImpuls.E2 = aImpuls.E2 / (TFloat) RockingData->ImpulsCount;

   // -----------------------------
       Get_Ro1_Ro2(aImpuls, aRo1, aRo2);


      // -----------------------------
          fDirectionalCosines.cell[1][0] = -sin(aRo1) + Ravnosignal_DirectionalCosines.cell[1][0];
          fDirectionalCosines.cell[2][0] =  sin(aRo2) + Ravnosignal_DirectionalCosines.cell[2][0];
          fDirectionalCosines.cell[0][0] = sqrt(1 - sqr(fDirectionalCosines.cell[1][0]) - sqr(fDirectionalCosines.cell[2][0]));

       // --------- ��������� ���� � ������� ��������� ��� ---------
          Calc_Angle(fDirectionalCosines, Q_FAR, Eps_FAR);

       // --------- ��������� ���� � ������� ��������� GEO ---------
          TransformCoordinates(tm(Matrix_Geo_Far), Q_FAR, Eps_FAR
                                                 , Q_Geo, Eps_Geo);

   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ///////////////////////////////////////

      RockingData->MeasureDeltaBetta   = Q_Geo   - RockingData->TargetPeleng;
      RockingData->MeasureDeltaEpsilon = Eps_Geo - RockingData->TargetEpsilon;
}

//===========================================================================
void Initialization()
{
    Create_Wave();

     if (frmShowWave == NULL) frmShowWave = new TfrmShowWave(NULL);
}

//===========================================================================
void Finalization()
{
   Destroy_Diagrams();
   if (frmShowWave != NULL) delete frmShowWave;

   try {  Destroy_Wave();  } catch ( ... ) { }
}

//===========================================================================
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void* lpReserved)
{
    switch(reason)
    {
	case DLL_PROCESS_ATTACH:  Initialization(); break;
	case DLL_PROCESS_DETACH:  Finalization  (); break;
    }
    return 1;
}
//===========================================================================

