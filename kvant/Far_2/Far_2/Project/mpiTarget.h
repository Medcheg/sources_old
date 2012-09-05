//===========================================================================
#ifndef mpiTargetH
#define mpiTargetH
#include "mpiTypes.h"
#include "mpiMatrix.h"

//===========================================================================
/*
      bool       *Radiation;    // --- Цель в диаграмме да, не -----
      bool       *EndRadiation; // --- Кончилили мы облучать  -----
      bool       *InSector;     // --- Кончилили мы облучать  -----
      bool       *OutSector;    // --- Кончилили мы облучать  -----

      bool       EnabledCalcPosTarget; // -- Можна ли расчитывать координаты цели ------
      bool       EnabledDrawTarget;    // -- Можна ли Отрисовывать координаты цели ------

      TTargetPoint *IdealPositionTarget;
      TTargetPoint *RealPositionTarget;
      int           CountDataPointTarget;  // ---- Коичество точек в этих масивах -------

      TDiagramPoint  **Pachka1; // ---- Пачки отраженных импульсов текучей цели в каждом луче ---
      TDiagramPoint  **Pachka2; // ---- Пачки отраженных импульсов текучей цели в каждом луче ---

      int             *LengthPachka1;  // ---- Коичество точек в этих масивах -------
      int             *LengthPachka2;  // ---- Коичество точек в этих масивах -------

      void Save_Ideal_And_Real_PositionTarget(TFloat aQ_Ideal, TFloat aEps_Ideal, TFloat aQ_Real, TFloat aEps_Real, TFloat aCurTime);
*/

// ================================================================================
typedef struct {
      TFloat     E1;
      TFloat     E2;
}TValueOffset;

// ================================================================================
class TTarget{
private:
        TFarParam *fpFarParam;
        TFloat     Rz, xi, yi, zi; // ------ Промежуточные переменные требуемые для расчета координат цели -----------
        TFloat     x0, y0, z0, Vx, Vy;
        TFloat     Eps0;   // *** Расчитанный начальный угол места цели ***

        TMatrix3x3  fDirectionalCosines;

        void      Get_Ro_Fi(TImpuls aImpuls, TFloat &aRo, TFloat &aFi);
        void      Get_Ro1_Ro2(TImpuls aImpuls, TFloat &aRo, TFloat &aFi);
        TImpuls   KoefPelengCharacteristic(bool aCalcDirectionalCosines, bool aCalcRelay, TFloat aQ_c, TFloat aEps_c);

public:
        int        id;         // ---------Намер цели (Номер трассы) ----------

     // -----------  Ниже данные держащие все что связано с обращением к цели ---------  
        TTargetAccess *TargetAccess;
        int            TargetAccess_Count;

     // -----------  Заданные начальные значения --------------
        TFloat     R0;         // --- Начальная дальность к цели ------------------
        TFloat     B0;         // --- Начальный пеленг цели  ----------
        TFloat     V0;         // --- Начальная скорость движения цели ----------
        TFloat     H0;         // --- Начальная высота движения цели ----------
        TFloat     K0;         // --- Начальный курс движения цели  ----------

     // --------------------------------------------------------
        TTargetsCoord  Coord;                          // -----------  Текущие (модельные) параметры цели --------------
        TTargetsCoord  Coord_FisrtImpuls;              // -----------  Текущие (модельные) координаты цели в СК географ при первом обращении к цели f(чистинькие) --------------
        TTargetsCoord  Coord_Far_Clear;                // -----------  Текущие (модельные) координаты цели в СК ФАР (чистинькие) --------------

        TTargetsCoord  Coord_Far;          // -----------  Текущие (модельные) координаты цели в СК ФАР (с учетом ошибок) --------------
        TTargetsCoord  Coord_Stab;         // -----------  Текущие (модельные) координаты цели в СК стабилизированной (с учетом ошибок) --------------

        TTargetsCoord  IndicatorCoord;     // -----------  Текущие координаты цели наиндикаторе --------------
        TTargetsCoord  OldIndicatorCoord;  // -----------  Предыдущие координаты цели наиндикаторе --------------
        AnsiString    Indicator_Name;
        bool          Indicator_Redraw;

        TMatrix3x3    tm_Fixed_Geo_Far;
        TMatrix3x3    ___Fixed_Far_Ravnosignal_DirectionalCosines;

     // --------------------------------------------------------
        TMatrix3x3 A_Eps_c;     // --- Матрица угла места цели в географической системе координат ---
        TMatrix3x3 A_Q_c;       // --- Матрица пеленга цели задаваемый в географической системе координат ----------

/*        TFloat     Stab_Eps_c;   // --- Расчитанный угол места цели в системе координат стабилизированной ------
        TFloat     Stab_Q_c;     // --- Расчитанный пеленг цели в системе координат стабилизированной ----------

        TFloat     FAR_Eps_c;   // --- Расчитанный угол места цели в системе координат FAR ------
        TFloat     FAR_Q_c;     // --- Расчитанный пеленг цели в системе координат FAR ----------
        TFloat     FAR_Clear_Eps_c;   // --- Расчитанный угол места цели в системе координат FAR ------
        TFloat     FAR_Clear_Q_c;     // --- Расчитанный пеленг цели в системе координат FAR ----------
  */

        TFloat     Luch_Eps_c;  // --- Расчитанный угол места цели в системе координат Luchа -----------------
        TFloat     Luch_Q_c;    // --- Расчитанный пеленг цели в системе координат Luchа ----------

     // --------------------------------------------------------
        TFloat SkoShum1;   // ---- СКО екстраполированого положения цели ------
        TFloat SkoShum2;   // ---- СКО екстраполированого положения цели ------

     // --------------------------------------------------------
        int        CountZondImpulses;
        bool       Radiation, Radiation1, Radiation2;
        bool       Enabled; /// ------  Возможно ли по цели производить измерения ------
        TFloat     SectorCoef; // --------- В какой части сектора я нахожусь ----------
     // --------------------------------------------------------


        void     Init();
        void     Move();
        void     CalcRadiationValue();
        void     CalcPosition();
         TTarget(TFarParam * apFarParam);
        ~TTarget();
};
//===========================================================================
#endif
