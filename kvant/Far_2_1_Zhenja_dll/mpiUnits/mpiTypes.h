//---------------------------------------------------------------------------
#ifndef mpiTypesH
#define mpiTypesH
//---------------------------------------------------------------------------
#include "Graphics.hpp"
//---------------------------------------------------------------------------
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define _ArcSin_(x) Math::ArcTan2((x),sqrt(fabs(1-(x)*(x))))
#define _ArcCos_(x) Math::ArcTan2(sqrt(fabs(1-(x)*(x))),(x))

#define sqr(x)  ((x)*(x))
#define cube(x) ((x)*(x)*(x))

//typedef double TFloat;


extern const double pi;
extern const double Two_Pi;
extern const double Pi_del_180;
extern const double _180_del_Pi;
extern const int    MyRandSeed;

extern TColor ColorArray[];

typedef double TFloat;
typedef struct {TFloat x,y;} TTwoFloat;

enum TDiagramForm       {dfNone, dfSinH_H  , dfTejlor5, dfCos};
enum TDiagramType       {dtNone, dtActive  , dtPassive};
enum TWorkMode          {wmLocation, wmMonopulse};
enum TBeamLocate        {blFazaFreq, blFaza, blHand};
enum TAperturePowering  {apUpper   , apLower};
enum TOscilatorPowering {opLeft    , opRight};
enum TDirectionScan     {dsNone, dsUpper, dsCenter, dsLower};


// ------- Структура описывающая направляющие косинусы -----
typedef struct {
  TFloat AlfaX;
  TFloat AlfaY;
  TFloat AlfaZ;
} TDirectionalCosines;
// ---------------------------------------------------------

typedef struct {
    // -------- Параметры диаграммы ----------
      struct {
            TDiagramForm    Form;                   // ---- Форма диаграммы ---------
            TDiagramType    Type;                   // ---- Тип диаграмы (актвная, пасивная)
            TFloat          *CutLevel;               // ---- Уровень среза ------
            TFloat          Shir;                   // ---- Програмно Расчитаная ширина диаграмы -------
            TFloat          *KoefPlacingDiagram;     // ---- Коэффициент растоновки лучей (доли от растановки)
      }Diagram;

      TFloat          RotationSpeed;          // ---- Угловая скорость вращения антенны --------
      TFloat          KursAngle0;             // ---- Начальный курсовой угол антенны   --------
      TFloat          T0n;                    // ---- Период выдачи навигационной информации  ----------
      TFloat          HalfScanSector;         // ---- Ширина половины сектора сканирования -------------

   // -------
      TFloat         *DeltaRo1;               // ---- Дискрет изменения угла отклонения по горизонтальной оси ---
      TFloat         *DeltaRo2;               // ---- Дискрет изменения угла отклонения по вертикальной оси ---
      TFloat         MaxTetaAngle;           // ---- Максимальный угол отклонения Тета ----
   // -------
      TFloat         SigmaEkstrapol;         // ---- СКО экстраполированного положения цели -----
   // -------
      TFloat         WorkFreq;               // ---- Рабочая частота  --------

    // ----------
      TFloat         *Sh;                     // ---- Отношение сигнал/шум -----
      TFloat         *Sigma2;                 // ---- Величина квадратического отклонения ----
      TFloat         fNormValue;             // ---- Програмно Расчитаная величина Маштабный коэф (необхадим для расчетов)

     // ------- Геометрия ------------
      TFloat         DiametrFar;             // ---- Диаметр апертуры ФАР ---
      TFloat         *Hx, *Hy, *Hz;             // ---- Смещение антенны относительно центра качания ----
      TFloat         Eps0, DeltaEps0;        // ---- Наклон (ошибка наклона) апертуры антенны к плоскости палубы --------
      TFloat         Nju , DeltaNju;         // ---- Поворот(Ошибка задания поворота) апертуры антенны относительно продольной оси --------
     // -------
} TFarParam;

// ================================================================================
typedef struct {
      TFloat     Q;            // --- пеленг на цель ----------
      TFloat     E;          // --- угол места цели ---
      TFloat     R;          // --- дальность к цели ---------

      TPoint     xy; // ------- Координаты на иедикаторе ---------

      TFloat     MaxErrorQ , MaxErrorE ;
      TFloat     SredErrorQ, SredErrorE;
      TFloat     SKOErrorQ , SKOErrorE ;

      TFloat     fCurSumQ;
      TFloat     fCurSumE;
      void Init(){ Q = E = R = -999; MaxErrorQ = MaxErrorE = SredErrorQ = SredErrorE = SKOErrorQ = SKOErrorE = fCurSumQ = fCurSumE = 0; xy = Point(-999, -999); }
}TTargetsCoord;

/*typedef struct {
    TFloat CurValue;
   // -------------
    TFloat MaxError;
    TFloat SredError;
    TFloat SKOError;
    TFloat LastError;
} TCalcCoord;*/

//=====================================================================================================================
typedef struct{
      TFloat        Time, E1, E2;
      void  Init(){ Time = -999; E1 = -999; E2 = -999;}
} TImpuls;

//=====================================================================================================================
typedef struct{
      TImpuls  *Impuls;              // ----- Пачка  импульсов в одном обращении к цели -
      int       Impuls_Count;        // ----- Коилчество импульсов  пачке  --------
    // -----------
      TImpuls  *CurImpuls;           // ----- Текущий импульс над которым ведется работа ---------

    // -----------
      TTargetsCoord  Ideal_Coord_Far;
      TTargetsCoord  Ideal_Coord_Geo;

      //TCalcCoord     Coord[8];
    // -----------
      struct {
         TTargetsCoord  Far;    // -----------  Текущие (модельные) координаты цели в СК стабилизированной (с учетом ошибок) --------------
         TTargetsCoord  Geo;    // -----------  Текущие (модельные) координаты цели в СК стабилизированной (с учетом ошибок) --------------
         void Init() { Far.Init(); Geo.Init();}
      } Coord_M1;
      struct {
         TTargetsCoord  Far;    // -----------  Текущие (модельные) координаты цели в СК стабилизированной (с учетом ошибок) --------------
         TTargetsCoord  Geo;    // -----------  Текущие (модельные) координаты цели в СК стабилизированной (с учетом ошибок) --------------
         void Init() { Far.Init(); Geo.Init();}
      } Coord_M2;

    // -----------
      void Init() {Impuls = NULL; Impuls_Count = 0; CurImpuls = NULL; Coord_M1.Init(); Coord_M2.Init();}
      void Add_New_Impuls() {
         Impuls_Count++;

         Impuls    = (TImpuls*) realloc (Impuls, sizeof(TImpuls) * Impuls_Count);
         CurImpuls = &Impuls[Impuls_Count - 1];
         CurImpuls->Init();
      }
      void Destroy_Impuls() {free (Impuls); Impuls = NULL; Impuls_Count = 0;}
}TTargetAccess;


typedef struct {
    // -----------------------------------------------------
        int      *pIntCurrentTime;         // ---- Текущее модельное время, с (с точностью до мкс)
        double   *pCurAzimFAR_Korabel;     // ---- Текущий азимут вращения антенны ------
        double   *pEps0;                   // ---- Наклон полотна -----
        double   *pDeltaEps0;              // ---- Ошибка установки наклона полотна -----
        double   *pNju;                    // ---- Разворот полотна (фокал )
        double   *pDeltaNju;               // ---- Ошибка установки Разворот полотна (фокала )
        int       TimeTransformCoef;       // ---- Коеффициент пересчета времени в секунды -

        double   *CutLevel;                // ---- Уровень среза ------
        double   *KoefPlacingDiagram;      // ---- Коэффициент растоновки лучей (доли от растановки)
        double   *Sh;                     // ---- Отношение сигнал/шум -----
        double   *Sigma2;                  // ---- Величина квадратического отклонения ----
        double   *DeltaRo1;                // ---- Дискрет изменения угла отклонения по горизонтальной оси ---
        double   *DeltaRo2;                // ---- Дискрет изменения угла отклонения по вертикальной оси ---
        double   *Hx;                      // ---- Смещение антенны относительно центра качания ----
        double   *Hy;                      // ---- Смещение антенны относительно центра качания ----
        double   *Hz;                      // ---- Смещение антенны относительно центра качания ----


    // ------ Вход DLL -------
        double    TargetPeleng;           // ---- Текущий пеленг цели -----
        double    TargetEpsilon;          // ---- Текущий угол места цели ----
        int       ImpulsCount;            // ---- Число импульсов зондирования (только для режима прерывания обзора)----

    // ---- Выход, изменяющиеся параметры -----
        double    Betta;                 // ----- Куда бросить луч в Азимутальной плоскости -------
        double    Epsilon;               // ----- Куда Бросить луч в Угломестной плоскости -------

        double    DeltaBetta;            // ----- Азиутальная ошибка расположения нормали антенны (ошибка иза качек в горизонтальной плоскости) -------
        double    DeltaEpsilon;          // ----- Угломестная  ошибка расположения нормали антенны (ошибка иза качек в угломестнойм плоскости) -------
        double    MeasureDeltaBetta;     // ----- Ошибки измерения цели в азимутальной плоскости (связанные с ошиками 1. навигационной системы и ошибками 2.самого измерения координат цели (2-ого пока нету))
        double    MeasureDeltaEpsilon;   // ----- Ошибки измерения цели в угломесной плоскости (связанные с ошиками 1. навигационной системы и ошибками 2.самого измерения координат цели (2-ого пока нету))
} TRockingData;
extern TRockingData *RockingData;
/*
  TRockingData = packed record
  PRockingData = ^TRockingData;
*/
//=====================================================================================================================
/*typedef struct TTimeDiagram{
       TFloat   InteruptTime;
       int      TargetIndex;
     // -----------
       int      ZondImpulsCount;    // ------- Количество зондирующих импульсов --------
       int      NumberImpuls;       // ------- Номер текущего зондирующего импульса ------------
       int      CountObr;           // ------- Количество обращений к цели -----------
     // -----------
       bool        Indicator_Redraw; // ----- Можно ли удалять старое отрисованле положение цели ----------

     // ----------- Структура по цели -------------
       struct {
           TTargetsCoord  *Coords;         // -------- Масив отметок Измееных координат цели --------
           int             Coords_Count;   // -------- Количествл измереных координат цели ----------
           TImpuls        *Impulses;           // -------- Инвормация по всем зондирующим импульсам одного (последнего) обращзения к цели  --------
           int             Impulses_Count;     // --------
           char            Name[5];
       } Target;


     // -----------
       void Create() {
           TargetIndex      = -999;
           InteruptTime     = -999;

           ZondImpulsCount  = -999;
           NumberImpuls     = -999;
           CountObr         = -999;

           Indicator_Redraw = false;

           Target.Coords   = NULL;
           Target.Impulses = NULL;
           Target.Coords_Count   = 0;
           Target.Impulses_Count = 0;
       }
       void SaveOldData() {
       }
       void AddCords_Q_Eps_D(TFloat aQ, TFloat aEps, TFloat aD) {
           Target.Coords = (TTargetsCoord*) realloc (Target.Coords, sizeof(TTargetsCoord)*(Target.Coords_Count + 1));

           Target.Coords[Target.Coords_Count].Q   = aQ;
           Target.Coords[Target.Coords_Count].Eps = aEps;
           Target.Coords[Target.Coords_Count].D   = aD;

           Target.Coords_Count++;
           Indicator_Redraw = true;
       }
       TFloat Q  ()     { return Target.Coords[Target.Coords_Count - 1].Q;   }
       TFloat Eps()     { return Target.Coords[Target.Coords_Count - 1].Eps; }
       TFloat D  ()     { return Target.Coords[Target.Coords_Count - 1].D;   }

       TFloat Old_Q  () { if (Target.Coords_Count > 1) return Target.Coords[Target.Coords_Count - 2].Q;   else return -999; }
       TFloat Old_Eps() { if (Target.Coords_Count > 1) return Target.Coords[Target.Coords_Count - 2].Eps; else return -999; }
       TFloat Old_D  () { if (Target.Coords_Count > 1) return Target.Coords[Target.Coords_Count - 2].D;   else return -999; }

       void Set_TargetName (int aIndex) { ShortString aTargetName; if (aIndex < 10)  aTargetName = "Ч-00" + IntToStr(aIndex); else if (aIndex < 100)  aTargetName = "Ч-0" + IntToStr(aIndex); else aTargetName = "Ч-" + IntToStr(aIndex); for (int i = 1; i <= 5; i++) Target.Name[i-1] = aTargetName[i]; }
       void Destroy()   { if (Target.Coords   != NULL) free (Target.Coords  ); if (Target.Impulses != NULL) free (Target.Impulses); Target.Coords_Count   = 0; Target.Impulses_Count = 0; }
       void Set_ImpulsCount(int aCount) {
           if (Target.Impulses != NULL) free (Target.Impulses);

           Target.Impulses = (TImpuls*) malloc (sizeof(TImpuls) * aCount);
           Target.Impulses_Count = aCount;
           ZondImpulsCount       = aCount;
           NumberImpuls          = 0;
       }
}TTimeDiagram;*/

//=====================================================================================================================

typedef struct{
      TFloat  Offset;
      TFloat  VoltValue;
}TDiagramPoint;

/*

typedef struct{
      TImpuls         **ImpulsPack;
      int              *Length_SecondLevelImpulsPack;
      TDirectionScan   *FirstImpulsDirection;
      TFloat           Q_c, Eps_c, Dist;
      TFloat           Real_Q_c, Real_Eps_c, Real_Dist;
      TFloat           Time;

      bool             EnabledDraw;
      int              TargetId;
//      int              NumberRadiation;
}TTargetPoint;*/

#endif
