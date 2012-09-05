//---------------------------------------------------------------------------
#ifndef _mpiWaveH_
#define _mpiWaveH_

#include "Math.h"
#include "Math.hpp"
#include "mpiTypes.h"

//---------------------------------------------------------------------------
extern const TFloat     RazmernostCoef [];

extern const AnsiString RazmernostLabel[];

extern const TFloat     cMin_To_Rad;  // ---- Переход Минут в радианы ----
extern const TFloat     cGrad_To_Rad; // ---- Переход градусов в радианы -------

extern const TFloat     cRad_To_Min;  // ---- Переход из Радиан в Минуты -------
extern const TFloat     cRad_To_Grad; // ---- Преход из Радиан в градусы -------

extern const AnsiString  Directory;
//extern const int         MyRandSeed;  // ----- База слуяайного процесса ------

enum TRazmernost {rMin, rGrad, rRad, rM};

// ------------------------------------------------
  typedef struct {
      TFloat     TbPrev;   AnsiString Comments_TbPrev;
      TFloat     TePrev;   AnsiString Comments_TePrev;
      struct { bool Enabled; AnsiString Caption; TFloat c0, c1, c2, c3; AnsiString Comments_C0, Comments_C1, Comments_C2, Comments_C3; } Polynom;

      struct {
          bool Enabled;  AnsiString Caption;
          struct { bool Enabled; AnsiString Caption; TFloat a, alfa, f, w; AnsiString Comments_a, Comments_alfa, Comments_f, Comments_w; } Sinus1;
          struct { bool Enabled; AnsiString Caption; TFloat a, alfa, f, w; AnsiString Comments_a, Comments_alfa, Comments_f, Comments_w; } Sinus2;
          struct { bool Enabled; AnsiString Caption; TFloat a, alfa, f, w; AnsiString Comments_a, Comments_alfa, Comments_f, Comments_w; } Sinus3;
      } Sinus;

      struct { bool Enabled;  AnsiString Caption; TFloat k, Te;      AnsiString Comments_k, Comments_Te;             } Saw;
      struct { bool Enabled;  AnsiString Caption; TFloat a, Tb, L;   AnsiString Comments_a, Comments_Tb, Comments_L; } Impuls;
      struct { bool Enabled;  AnsiString Caption; TFloat /*Mean,*/ SKO;  AnsiString Comments_Mean, Comments_Sko;         } Gause;
      struct { bool Enabled;  AnsiString Caption; TFloat Tf, SigmaU; AnsiString Comments_Tf, Comments_SigmaU;        } RandomProcess;
  } TWaveOptions;

// =============================================================================
// ========================    Classify TWave      =============================
// =============================================================================
class TWave {
private:
     // ============ Параметры необходимые для расчета Марковского процесса =================
       AnsiString fNameIniFile;
       TFloat      Lambda;          // ---- Преобладающая частота ----
       TFloat      A;
       TFloat      mju;
       TFloat      Ts;              // ---- Внутрений такт дескритезации -----
       int         Counter;         // ---- Счетчик для соответсвующий внутреннему такту дискретизации ---
       TFloat      PowerWhiteNoise; // ---- Интенсивность белого шума ----
       TFloat      Sko;             // ---- Средне квадратическое отклонение --------

      ////////// Коеффициенты колебательного звена ///////////////7
       TFloat      K;
       TFloat      T1, Ksi1;
       TFloat      B1, D1, K1;

       TFloat      Shum; // ---- Дистреное значение Белого шума от Ts
       TFloat      y[3]; // y : array [-2..0] of TFloat;


       TFloat WaveZvenoRun(TFloat Value);
     // ============ End of Параметры необходимые для расчета Марковского процесса =================


     // ============== Параметры для апроксимации качки ==========
       TFloat x[50], px[50], ppx[50], a[50], yy[50], pyy[50], ppyy[50];  // -------- Вход фильтра с запомнеными старыми значениями , и , коеффициенты фильтра ------------
       int    N; // -------- Порядок Фильтра -----------
     // ============== End of Параметры для апроксимации качки ==========

       TFloat   fOld_Value;// ============ Переменная для расчета Скорости качки=================
       TFloat   fOld_P_Value;// ============ Переменная для расчета Ускорения качки=================
       TFloat   fOldCurTime;
       TFloat  CorrectCurTime;

       void Read_Ini_File();
       void Write_Ini_File();
       void RandomProcessInit();
       void FiltrInit();
public:
       TWaveOptions WaveOptions; // ------ Усе параметры блока -----------

       TFloat      *pCurTime;    // ------ Указательна текучее время системы ------------
       TFloat      *pT0;         // ------ Указатель на такт дескритезации системы --------
       bool        *pFiltrationEnabled; // ----------- Включена ли фильтрация сигнала ---------

       AnsiString  Caption;     // ------ Имя блока --------
       TRazmernost  Razmernost;  // ------ Размерность данных блока ----------
       int          Tag;         // ------ Tag Блока ----------

      // ------------
       TFloat       Value;          // ---- Выход блока в радианах
       TFloat       pValue;         // ---- Выход блока в Радианах / сек (Скорость)
       TFloat       ppValue;        // ---- Выход блока в Радианах / сек (Ускорение)
       TFloat       Value_inGraph;  // ---- Выход блока в единицах которых делали задание ---------------
      // ------------

       TFloat Run();  // ---- Выход блока -------------
       void   Edit(); // ---- Диалог параметров блока -------------

        TWave (TFloat *apCurTime, TFloat *apT0, bool *apFiltrationEnabled, AnsiString aCaption, TRazmernost aRazmernost, int aTag);
        TWave (TFloat *apCurTime, TFloat *apT0, AnsiString aCaption, TRazmernost aRazmernost, int aTag);
       ~TWave ();
};

//---------------------------------------------------------------------------
#endif
