//---------------------------------------------------------------------------
#ifndef mpiManeuverH
#define mpiManeuverH
//---------------------------------------------------------------------------
/*typedef long double TFloat;
#define sqr(a)     ((a)*(a))
#define mpiSign(a)  ((a)==(0))?(0):((a)>0)?(1):(-1)
int __fastcall round(double aValue)
{
  int aFloor = floor(aValue);

  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
} */
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
////////////   ������������ ����� ��������� :        /////////////
////////////   X - ���������� �� ���� �������        /////////////
////////////   Y - ���������� �� ���� �������        /////////////
////////////   Z - ���������� �e��������� �����      /////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//#include "mpiManeuver.h"

class TManeuver {
public:
     // ----------
         TFloat *pCurModelTime;  // ----------- ������� ��������� ����� ---
     // ----------
         TFloat    BeginTime;    // --- ����� ������ ������� ������� -------
         TFloat    EndTime;      // --- ����� ����� ������� ������� -------
     // ----------
         TFloat    BeginKurs;    // --- ��������� ���� �������� ������� -------
         TFloat    EndKurs;      // --- �������� ���� �������� ������� -------
         TFloat    HGLoad;        // --- ���������� �� ������ ---
         TFloat    HRadius;       // --- ������ ������ (������������ �� ����� ����� �����) -----
         TFloat    HOmega;        // --- ������� �������� ������ (������������ �� ����� ����� �����) -----
         TFloat    HManevrZnak;
     // ----------
         TFloat    BeginFi;    // --- ��������� ���� �������� ������� -------
         TFloat    EndFi;      // --- �������� ���� �������� ������� -------
         TFloat    VGLoad;        // --- ���������� �� ������ ---
         TFloat    VRadius;       // --- ������ ������ (������������ �� ����� ����� �����) -----
         TFloat    VOmega;        // --- ������� �������� ������ (������������ �� ����� ����� �����) -----
         TFloat    VManevrZnak;
     // ----------

         TFloat    Vx;
         TFloat    Vy;
         TFloat    Vz;

         TFloat    X0;
         TFloat    Y0;
         TFloat    Z0;

         TFloat    Xc;
         TFloat    Yc;
         TFloat    Zc;

         bool      FistInput;
     // ----------
         TFloat   *CurD;    // ----- ������� �������� ��������� -----
         TFloat   *CurK;    // ----- ������� �������� ����� ---------
         TFloat   *CurX;    // ----- ������� �������� �������� ������� � �� ���������� � (� �������������� ���������) ----
         TFloat   *CurY;    // ----- ������� �������� �������� ������� � �� ���������� Y (� �������������� ���������) ----

         TFloat   BaseX;
         TFloat   BaseY;
         TFloat   BaseK;
     // ----------
         TManeuver ( TFloat *apCurModelTime ){ pCurModelTime = apCurModelTime; FistInput = true;}
         void __fastcall Init() {FistInput = true;};
         void __fastcall Run();

};
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
class TTargetTraektory{
private:
     // ----------
         TFloat *pCurModelTime;          // ---- ������� ��������� ����� ---
         int     fManeuver_count;        // ---- ���������� �������� (����� ������ ��������) ------

     // ----------
//         TFloat  D0;                     // ---- ��������� ��������� � ������� ---
  //       TFloat  K0;                     // ---- ��������� ���� �������� ������� ----
    //     TFloat  V0;                     // ---- ��������� (��������) �������� �������� ������� ----

     // ----------
       void __fastcall ResetValues(TManeuver *m);
       void __fastcall Set_Maneuver_count ( int aManeuver_count);
public:
     // ----------
         TManeuver **Maneuver;           // ---- ������ �������� ------
     // ----------
         TFloat   H;    // ----- ������� �������� ������ -----
         TFloat   D;    // ----- ������� �������� ��������� -----
         TFloat   K;    // ----- ������� �������� ����� ---------
         TFloat   V;    // ----- ������� �������� ����� ---------

         TFloat   X;    // ----- ������� �������� �������� ������� � �� ���������� � (� �������������� ���������) ----
         TFloat   Y;    // ----- ������� �������� �������� ������� � �� ���������� Y (� �������������� ���������) ----
         TFloat   Z;    // ----- ������� �������� �������� ������� � �� ���������� Z (� �������������� ���������) ----

     // ----------
         TTargetTraektory( TFloat *apCurModelTime, TFloat  aH0, TFloat  aD0, TFloat  aK0, TFloat  aV0);
        ~TTargetTraektory();

     // ----------
/*         void __fastcall Add_Line_Move(TFloat aBeginTime , TFloat aEndTime  , TFloat aKurs   , TFloat aFi);           // --- ��� ������� �������������� �������� -----
         void __fastcall Add_H_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad);  // --- ��� ������� �������������� �������� -----
         void __fastcall Add_V_Maneuver(TFloat aBeginTime, TFloat aBeginFi  , TFloat aEndFi  , TFloat aGLoad);  // --- ��� ������� �������������� �������� -----
         void __fastcall Add_H_Line_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad);  // --- ��� ������� �������������� �������� -----
         void __fastcall Add_HV_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aHGLoad, TFloat aBeginFi  , TFloat aEndFi, TFloat aVGLoad);  // --- ��� ������� �������������� �������� -----
  */
         void __fastcall Add_Maneuver(TFloat aBeginTime, TFloat aEndTime  , TFloat aKurs);                    // --- ��� ������� �������������� �������� -----
         void __fastcall Add_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad);  // --- ��� ������� �������� ���� ������ -----
         //void __fastcall Add_HManeuver(TFloat aBeginTime, TFloat aDeltaKurs, TFloat aGLoad);  // --- ��� ������� �������� ���� ������ -----

     // ----------
         void __fastcall Init(){ for (int i = 0; i < Maneuver_count; i++) Maneuver[i]->Init();}
         void __fastcall Run (){ for (int i = 0; i < Maneuver_count; i++) Maneuver[i]->Run ();}

     // ----------
       __property int Maneuver_count = { read = fManeuver_count, write = Set_Maneuver_count};
};


#endif
