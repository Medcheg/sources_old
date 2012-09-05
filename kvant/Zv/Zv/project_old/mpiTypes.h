//===========================================================================
#ifndef mpiTypesH
#define mpiTypesH
//===========================================================================
#include "Math.h"
#include "Math.hpp"
//===========================================================================
#define _ArcSin_(x) Math::ArcTan2((x),sqrt(fabs(1-(x)*(x))))
#define _ArcCos_(x) Math::ArcTan2(sqrt(fabs(1-(x)*(x))),(x))

#define round(x)    (((x)-floor((x))>0.5)?ceil((x)):floor((x)))
#define odd(x)      (((x/2)*2==round((x/2.0)*2.0))?false:true)
#define _Sgn_(x)    (((x)>0)?1:((x)<0)?-1:0)

#define sqr(x)      ((x)*(x))
#define cube(x)     ((x)*(x)*(x))

typedef double TFloat;
typedef TFloat TFDN    (TFloat yml, TFloat ymc, TFloat sdn);
typedef TFloat TFunType(TFloat x);

extern const double pi;
extern const double two_pi;
extern const double pi_del_180;
extern const double _180_del_pi;
extern const int    MyRandSeed;
extern const TColor ColorArray[];

// ===========================================================================
typedef struct {
      // ------------- Параметры РЛС --------
      TFloat     Ha;     // ---- Высота установки антенны --------
      TFloat     EpsLuch;   // ---- Угол места луча -----------
      TFloat     ShirLuch;    // ---- Ширина Луча ------
      TFloat     Lambda;         // ---- Рабочая длинна волны (километры)
      TFloat     OmegaA;   // ---- Угловая скорость вращения анетены -----
                 // ---- Тут нужно вставить параметр формы диаграммы направлености ------
      TFloat     BasicDistance;       // ----  Опорная дальность ------------
      TFloat     Pt;       // ------ Импульсная мощность ----------
      TFloat     Gt;       // ------ к-т ДНА на передачу ----------
      TFloat     Gr;       // ------ к-т ДНА на прием -------------
      TFloat     DSink;    // ------ к-т сжатия приемника ---------
      TFloat     NFSink;       // ------ К-т шума приемника
      TFloat     BSink;    // ------ Полоса пропускания приемника -
      TFloat     ASink;    // ------ 19 дБ --
      TFloat     Lt;       // ------ Потери при излучении ---------
      TFloat     Lr;       // ------ Потери при приеме ------------
      TFloat     Ls;       // ------ Потери при обработке ---------
      TFloat     DeltaGa;  // ------ Изменение к-та усиления ДНА, при отклонении оси луча от нормали -------
      // ----------------
      TFloat     TargetEPR; // ----- ЕПР цели ---------
      int        TypeSignalFluctuation; // ----- Тип флюктуации сигнала
      // ----------------
      bool       Esktrapoling;//;
      bool       AnglesLine;
      TFloat     MaxVerticalDistance;      // ----
      TFloat     VerticalAxisValueStep;
      TFloat     MaxGorizontDistance;       // ----
      TFloat     GorizontalAxisValueStep;

      // ----------------
      TFloat     SeaSurfaceShumMeter;  // ---- Величина шероховатости Моря (километры) -----------
      TFloat     SeaSurfaceShumBall;            // ---- Величина волнения моря в баллах -----------
      TFloat     La;                                  // ---- Коеф. двусторонних потерь в атмосфере ----
      TFloat     Lj;                                  // ---- Коеф. прочих потерь ----
      TFloat     Re;                         // ----- Еквивалентный радиус земли ----
      TFloat     Rz;                         // ----- Радиус Земли ----
      // ----------------
      TFloat     Pd;              // ---- Вероятность обнаружения ---------
      int        Pfa;                // ----- Вероятность ложноло обнаружения --------
      bool       OtherPd;      // FmMain.cbver.Checked
} TZvData;
//===========================================================================

typedef struct {
     TFloat   Value;
     bool     Visible;
     void Init () { Value = 0.0; Visible = true;}
} TAnglesTick;
#endif
