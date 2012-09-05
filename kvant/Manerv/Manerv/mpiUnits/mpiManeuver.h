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
////////////   Координатная сетка следующая :        /////////////
////////////   X - Направлена По носу объекта        /////////////
////////////   Y - Направлена на борт объекта        /////////////
////////////   Z - Направлена вeртикально вверх      /////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//#include "mpiManeuver.h"

class TManeuver {
public:
     // ----------
         TFloat *pCurModelTime;  // ----------- Текущее модельное время ---
     // ----------
         TFloat    BeginTime;    // --- Время начала участка маневра -------
         TFloat    EndTime;      // --- Время конца участка маневра -------
     // ----------
         TFloat    BeginKurs;    // --- Начальный курс движение объекта -------
         TFloat    EndKurs;      // --- Конечный курс движение объекта -------
         TFloat    HGLoad;        // --- Перегрузка на вираже ---
         TFloat    HRadius;       // --- Радиус виража (опредиляется во время счета схемы) -----
         TFloat    HOmega;        // --- Угловая скорость виража (опредиляется во время счета схемы) -----
         TFloat    HManevrZnak;
     // ----------
         TFloat    BeginFi;    // --- Начальный курс движение объекта -------
         TFloat    EndFi;      // --- Конечный курс движение объекта -------
         TFloat    VGLoad;        // --- Перегрузка на вираже ---
         TFloat    VRadius;       // --- Радиус виража (опредиляется во время счета схемы) -----
         TFloat    VOmega;        // --- Угловая скорость виража (опредиляется во время счета схемы) -----
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
         TFloat   *CurD;    // ----- Текущее значение дальности -----
         TFloat   *CurK;    // ----- Текущее значение курса ---------
         TFloat   *CurX;    // ----- Текущее значения движения объекта в по координате Х (в горизонтальной плоскости) ----
         TFloat   *CurY;    // ----- Текущее значения движения объекта в по координате Y (в горизонтальной плоскости) ----

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
         TFloat *pCurModelTime;          // ---- Текущее модельное время ---
         int     fManeuver_count;        // ---- Количество маневров (длина масива маневров) ------

     // ----------
//         TFloat  D0;                     // ---- Начальная дальность к объекту ---
  //       TFloat  K0;                     // ---- Начальный курс движения объекта ----
    //     TFloat  V0;                     // ---- Начальная (заданная) скорость движения объекта ----

     // ----------
       void __fastcall ResetValues(TManeuver *m);
       void __fastcall Set_Maneuver_count ( int aManeuver_count);
public:
     // ----------
         TManeuver **Maneuver;           // ---- Список маневров ------
     // ----------
         TFloat   H;    // ----- Текущее значение высоты -----
         TFloat   D;    // ----- Текущее значение дальности -----
         TFloat   K;    // ----- Текущее значение курса ---------
         TFloat   V;    // ----- Текущее значение курса ---------

         TFloat   X;    // ----- Текущее значения движения объекта в по координате Х (в горизонтальной плоскости) ----
         TFloat   Y;    // ----- Текущее значения движения объекта в по координате Y (в горизонтальной плоскости) ----
         TFloat   Z;    // ----- Текущее значения движения объекта в по координате Z (в горизонтальной плоскости) ----

     // ----------
         TTargetTraektory( TFloat *apCurModelTime, TFloat  aH0, TFloat  aD0, TFloat  aK0, TFloat  aV0);
        ~TTargetTraektory();

     // ----------
/*         void __fastcall Add_Line_Move(TFloat aBeginTime , TFloat aEndTime  , TFloat aKurs   , TFloat aFi);           // --- Для задания прямолинейного движения -----
         void __fastcall Add_H_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad);  // --- Для задания прямолинейного движения -----
         void __fastcall Add_V_Maneuver(TFloat aBeginTime, TFloat aBeginFi  , TFloat aEndFi  , TFloat aGLoad);  // --- Для задания прямолинейного движения -----
         void __fastcall Add_H_Line_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad);  // --- Для задания прямолинейного движения -----
         void __fastcall Add_HV_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aHGLoad, TFloat aBeginFi  , TFloat aEndFi, TFloat aVGLoad);  // --- Для задания прямолинейного движения -----
  */
         void __fastcall Add_Maneuver(TFloat aBeginTime, TFloat aEndTime  , TFloat aKurs);                    // --- Для задания прямолинейного движения -----
         void __fastcall Add_Maneuver(TFloat aBeginTime, TFloat aBeginKurs, TFloat aEndKurs, TFloat aGLoad);  // --- Для задания движения типа маневр -----
         //void __fastcall Add_HManeuver(TFloat aBeginTime, TFloat aDeltaKurs, TFloat aGLoad);  // --- Для задания движения типа маневр -----

     // ----------
         void __fastcall Init(){ for (int i = 0; i < Maneuver_count; i++) Maneuver[i]->Init();}
         void __fastcall Run (){ for (int i = 0; i < Maneuver_count; i++) Maneuver[i]->Run ();}

     // ----------
       __property int Maneuver_count = { read = fManeuver_count, write = Set_Maneuver_count};
};


#endif
