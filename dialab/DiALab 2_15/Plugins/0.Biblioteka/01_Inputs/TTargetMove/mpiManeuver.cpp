//---------------------------------------------------------------------------
#include <vcl.h>
#include <math.h>
//#include <Algorith.h>
#include <math.hpp>
#pragma hdrstop

#include "mpiManeuver.h"

/*
    z0 = H0 - fpFarParam->Hz * 0.001 - R0*R0/2.0/Rz;   Eps0 = _ArcSin_(z0/R0);
    x0 = R0*sin(B0)*cos(Eps0);
    y0 = R0*cos(B0)*cos(Eps0);

    Vx = V0 * sin(K0);
    Vy = V0 * cos(K0);
*/

//===========================================================================
/*void TTargetTraektory_init() { Beep(); }
#pragma startup TTargetTraektory_init 110 // default 100*/
//===========================================================================
//---------------------------------------------------------------------------
TTargetTraektory::TTargetTraektory( TFloat *apCurModelTime, TFloat  aH0, TFloat  aD0, TFloat  aK0, TFloat  aV0)
{
      pCurModelTime = apCurModelTime;

      H = aH0;
      D = aD0;
      K = aK0;
      V = aV0;

      Z   = H;
      Eps = Math::ArcTan2((aH0 / aD0), sqrt(fabs(1 - (aH0 / aD0)*(aH0 / aD0))));

      Maneuver        = NULL;
      fManeuver_count = 0;
}

//---------------------------------------------------------------------------
TTargetTraektory::~TTargetTraektory()
{
    for (int i = 0; i < fManeuver_count; i++)
        delete Maneuver[i];

    free (Maneuver);
};

//---------------------------------------------------------------------------
void __fastcall TTargetTraektory::Set_Maneuver_count ( int aManeuver_count)
{
      fManeuver_count = aManeuver_count;
  // ---- Расширяем месив маневров -------
      Maneuver                     = (TManeuver**) realloc (Maneuver, sizeof (TManeuver*) * fManeuver_count);
      Maneuver[fManeuver_count - 1] = new TManeuver(pCurModelTime);

      if (Maneuver == NULL) return;

   // ------------ Инициализация переменных нового маневра --------
      Maneuver[fManeuver_count - 1]->CurD               = &D;
      Maneuver[fManeuver_count - 1]->CurK               = &K;
      Maneuver[fManeuver_count - 1]->CurE               = &Eps;

      Maneuver[fManeuver_count - 1]->CurX               = &X;
      Maneuver[fManeuver_count - 1]->CurY               = &Y;
      Maneuver[fManeuver_count - 1]->CurZ               = &Z;

      Maneuver[fManeuver_count - 1]->HGLoad      = 0;
      Maneuver[fManeuver_count - 1]->HRadius     = 0;
      Maneuver[fManeuver_count - 1]->HOmega      = 0;
      Maneuver[fManeuver_count - 1]->HManevrZnak = 0;

      Maneuver[fManeuver_count - 1]->VGLoad      = 0;
      Maneuver[fManeuver_count - 1]->VRadius     = 0;
      Maneuver[fManeuver_count - 1]->VOmega      = 0;
      Maneuver[fManeuver_count - 1]->VManevrZnak = 0;

      Maneuver[fManeuver_count - 1]->Xc          = 0;
      Maneuver[fManeuver_count - 1]->Yc          = 0;
      Maneuver[fManeuver_count - 1]->Zc          = 0;

      Maneuver[fManeuver_count - 1]->Vx = 0;
      Maneuver[fManeuver_count - 1]->Vy = 0;
      Maneuver[fManeuver_count - 1]->Vz = 0;
}

/*//---------------------------------------------------------------------------
void __fastcall TTargetTraektory::Add_Line_Move(TFloat aBeginTime , TFloat aEndTime  , TFloat aKurs   , TFloat aFi)
{
      Maneuver_count++;
      TManeuver *m = Maneuver[Maneuver_count - 1];

    ///////////////////
      m->BeginTime = aBeginTime;
      m->EndTime   = aEndTime;

      m->BeginKurs = aKurs;
      m->EndKurs   = aKurs;

      m->BeginFi   = aFi;
      m->EndFi     = aFi;

      m->Vx = V * cos(aKurs) * cos(aFi);
      m->Vy = V * sin(aKurs) * cos(aFi);
      m->Vz = V * sin(aFi);
}

//---------------------------------------------------------------------------
void __fastcall TTargetTraektory::Add_H_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad)
{
      Maneuver_count++;
      TManeuver *m = Maneuver[Maneuver_count - 1];

      m->HRadius    = sqr(V * 1000.0) / 9.81 / sqrt (sqr(aGLoad) - 1) / 1000.0;

      m->BeginTime = aBeginTime;
      m->EndTime   = aBeginTime + fabs(aEndKurs - aBeginKurs) * m->HRadius / V;

      m->BeginKurs = aBeginKurs;
      m->EndKurs   = aEndKurs;
      m->HGLoad    = aGLoad;

      m->HManevrZnak = mpiSign(aEndKurs - aBeginKurs);
      m->HOmega      = m->HManevrZnak * V / m->HRadius;

////////// Обнуляем, такб как для виража эти парметры ненужны -----
      m->Xc = - m->HManevrZnak * m->HRadius * sin (aBeginKurs);
      m->Yc =   m->HManevrZnak * m->HRadius * cos (aBeginKurs);
      m->Zc =   0;
//////////
}

//---------------------------------------------------------------------------
void __fastcall TTargetTraektory::Add_V_Maneuver(TFloat aBeginTime, TFloat aBeginFi  , TFloat aEndFi  , TFloat aGLoad)
{
}

//---------------------------------------------------------------------------
void __fastcall TTargetTraektory::Add_H_Line_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad)
{
}

//---------------------------------------------------------------------------
void __fastcall Add_HV_Maneuver(TFloat aBeginTime,
                                TFloat aBeginKurs, TFloat aEndKurs, TFloat aHGLoad,
                                TFloat aBeginFi  , TFloat aEndFi  , TFloat aVGLoad)
{

}
*/
void __fastcall TTargetTraektory::ResetValues(TManeuver *m)
{
      m->BeginTime   = 0;
      m->EndTime     = 0;
      m->BeginKurs   = 0;
      m->EndKurs     = 0;

      m->HGLoad      = 0;
      m->HRadius     = 0;
      m->HOmega      = 0;
      m->HManevrZnak = 0;
      m->Xc         = 0;
      m->Yc         = 0;

      m->Vx = 0;
      m->Vy = 0;
}

//---------------------------------------------------------------------------
void __fastcall TTargetTraektory::Add_Maneuver(TFloat aBeginTime, TFloat aEndTime, TFloat aKurs){
      Maneuver_count++;
      TManeuver *m = Maneuver[Maneuver_count - 1];

    // ----------
        ResetValues(m);
    // ----------
        m->BeginTime = aBeginTime;
        m->EndTime   = aEndTime;
        m->BeginKurs = aKurs;
        m->EndKurs   = aKurs;

      //////////  ЛИНЕЙНЫЙ МАНЕВР //////////////////
          m->Vx = V * cos(aKurs);
          m->Vy = V * sin(aKurs);
      /////////////////////////////////////////////
}

//---------------------------------------------------------------------------
void __fastcall TTargetTraektory::Add_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad)
{
      Maneuver_count++;
      TManeuver *m = Maneuver[Maneuver_count - 1];

    // ----------
      ResetValues(m);
    // ----------

      m->HRadius    = sqr(V * 1000.0) / 9.81 / sqrt (sqr(aGLoad) - 1) / 1000.0;

      m->BeginTime = aBeginTime;
      m->EndTime   = aBeginTime + fabs(aEndKurs - aBeginKurs) * m->HRadius / V;

      m->BeginKurs = aBeginKurs;
      m->EndKurs   = aEndKurs;
      m->HGLoad     = aGLoad;

      m->HManevrZnak = mpiSign(aEndKurs - aBeginKurs);
      m->HOmega      = m->HManevrZnak * V / m->HRadius;

      ////////// Горизонтальный вираж ///////////////////
         m->Xc = - m->HManevrZnak * m->HRadius * sin (aBeginKurs);
         m->Yc =   m->HManevrZnak * m->HRadius * cos (aBeginKurs);
      ///////////////////////////////////////////////////
}

//---------------------------------------------------------------------------
void __fastcall TManeuver::Run()
{
   // ---- Если время маневра не наступило, тогда выход ----
      if (*pCurModelTime < BeginTime || *pCurModelTime >= EndTime) return;

   // ----
      if (FistInput) {
           FistInput = false;
           X0 = *CurD * cos(*CurK);// * cos (eps0)
           Y0 = *CurD * sin(*CurK);
         // -----
           Z0 = *CurZ;
      }

      TFloat TimeOffset = *pCurModelTime - BeginTime;      // --- текущее время манывра ----
      TFloat gammaT     = BeginKurs + HOmega * TimeOffset;  // --- угол разворота -----------

      *CurX = X0 + (Vx*TimeOffset) + (Xc + HManevrZnak*HRadius*sin(gammaT));
      *CurY = Y0 + (Vy*TimeOffset) + (Yc - HManevrZnak*HRadius*cos(gammaT));
      *CurZ = *CurZ;

      *CurD  = sqrt(sqr(*CurX) + sqr(*CurY) + sqr(*CurZ));
      *CurK  = Math::ArcTan2(*CurY, *CurX);
      //*CurE  = Math::ArcTan2(*CurZ, *CurX);
     // *CurE  = Math::ArcTan2(( *CurZ / *CurD), sqrt(fabs(1 - ( *CurZ / *CurD)*( *CurZ / *CurD))));
       if (*CurD != 0 ) *CurE = Math::ArcSin(*CurZ / *CurD); else *CurE = 0;
}

