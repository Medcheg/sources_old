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


// ------- ��������� ����������� ������������ �������� -----
typedef struct {
  TFloat AlfaX;
  TFloat AlfaY;
  TFloat AlfaZ;
} TDirectionalCosines;
// ---------------------------------------------------------

typedef struct {
    // -------- ��������� ��������� ----------
      struct {
            TDiagramForm    Form;                   // ---- ����� ��������� ---------
            TDiagramType    Type;                   // ---- ��� �������� (�������, ��������)
            TFloat          *CutLevel;               // ---- ������� ����� ------
            TFloat          Shir;                   // ---- ��������� ���������� ������ �������� -------
            TFloat          *KoefPlacingDiagram;     // ---- ����������� ���������� ����� (���� �� ����������)
      }Diagram;

      TFloat          RotationSpeed;          // ---- ������� �������� �������� ������� --------
      TFloat          KursAngle0;             // ---- ��������� �������� ���� �������   --------
      TFloat          T0n;                    // ---- ������ ������ ������������� ����������  ----------
      TFloat          HalfScanSector;         // ---- ������ �������� ������� ������������ -------------

   // -------
      TFloat         *DeltaRo1;               // ---- ������� ��������� ���� ���������� �� �������������� ��� ---
      TFloat         *DeltaRo2;               // ---- ������� ��������� ���� ���������� �� ������������ ��� ---
      TFloat         MaxTetaAngle;           // ---- ������������ ���� ���������� ���� ----
   // -------
      TFloat         SigmaEkstrapol;         // ---- ��� ������������������� ��������� ���� -----
   // -------
      TFloat         WorkFreq;               // ---- ������� �������  --------

    // ----------
      TFloat         *Sh;                     // ---- ��������� ������/��� -----
      TFloat         *Sigma2;                 // ---- �������� ��������������� ���������� ----
      TFloat         fNormValue;             // ---- ��������� ���������� �������� ��������� ���� (��������� ��� ��������)

     // ------- ��������� ------------
      TFloat         DiametrFar;             // ---- ������� �������� ��� ---
      TFloat         *Hx, *Hy, *Hz;             // ---- �������� ������� ������������ ������ ������� ----
      TFloat         Eps0, DeltaEps0;        // ---- ������ (������ �������) �������� ������� � ��������� ������ --------
      TFloat         Nju , DeltaNju;         // ---- �������(������ ������� ��������) �������� ������� ������������ ���������� ��� --------
     // -------
} TFarParam;

// ================================================================================
typedef struct {
      TFloat     Q;            // --- ������ �� ���� ----------
      TFloat     E;          // --- ���� ����� ���� ---
      TFloat     R;          // --- ��������� � ���� ---------

      TPoint     xy; // ------- ���������� �� ���������� ---------

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
      TImpuls  *Impuls;              // ----- �����  ��������� � ����� ��������� � ���� -
      int       Impuls_Count;        // ----- ���������� ���������  �����  --------
    // -----------
      TImpuls  *CurImpuls;           // ----- ������� ������� ��� ������� ������� ������ ---------

    // -----------
      TTargetsCoord  Ideal_Coord_Far;
      TTargetsCoord  Ideal_Coord_Geo;

      //TCalcCoord     Coord[8];
    // -----------
      struct {
         TTargetsCoord  Far;    // -----------  ������� (���������) ���������� ���� � �� ����������������� (� ������ ������) --------------
         TTargetsCoord  Geo;    // -----------  ������� (���������) ���������� ���� � �� ����������������� (� ������ ������) --------------
         void Init() { Far.Init(); Geo.Init();}
      } Coord_M1;
      struct {
         TTargetsCoord  Far;    // -----------  ������� (���������) ���������� ���� � �� ����������������� (� ������ ������) --------------
         TTargetsCoord  Geo;    // -----------  ������� (���������) ���������� ���� � �� ����������������� (� ������ ������) --------------
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
        int      *pIntCurrentTime;         // ---- ������� ��������� �����, � (� ��������� �� ���)
        double   *pCurAzimFAR_Korabel;     // ---- ������� ������ �������� ������� ------
        double   *pEps0;                   // ---- ������ ������� -----
        double   *pDeltaEps0;              // ---- ������ ��������� ������� ������� -----
        double   *pNju;                    // ---- �������� ������� (����� )
        double   *pDeltaNju;               // ---- ������ ��������� �������� ������� (������ )
        int       TimeTransformCoef;       // ---- ����������� ��������� ������� � ������� -

        double   *CutLevel;                // ---- ������� ����� ------
        double   *KoefPlacingDiagram;      // ---- ����������� ���������� ����� (���� �� ����������)
        double   *Sh;                     // ---- ��������� ������/��� -----
        double   *Sigma2;                  // ---- �������� ��������������� ���������� ----
        double   *DeltaRo1;                // ---- ������� ��������� ���� ���������� �� �������������� ��� ---
        double   *DeltaRo2;                // ---- ������� ��������� ���� ���������� �� ������������ ��� ---
        double   *Hx;                      // ---- �������� ������� ������������ ������ ������� ----
        double   *Hy;                      // ---- �������� ������� ������������ ������ ������� ----
        double   *Hz;                      // ---- �������� ������� ������������ ������ ������� ----


    // ------ ���� DLL -------
        double    TargetPeleng;           // ---- ������� ������ ���� -----
        double    TargetEpsilon;          // ---- ������� ���� ����� ���� ----
        int       ImpulsCount;            // ---- ����� ��������� ������������ (������ ��� ������ ���������� ������)----

    // ---- �����, ������������ ��������� -----
        double    Betta;                 // ----- ���� ������� ��� � ������������ ��������� -------
        double    Epsilon;               // ----- ���� ������� ��� � ����������� ��������� -------

        double    DeltaBetta;            // ----- ����������� ������ ������������ ������� ������� (������ ��� ����� � �������������� ���������) -------
        double    DeltaEpsilon;          // ----- �����������  ������ ������������ ������� ������� (������ ��� ����� � ������������ ���������) -------
        double    MeasureDeltaBetta;     // ----- ������ ��������� ���� � ������������ ��������� (��������� � ������� 1. ������������� ������� � �������� 2.������ ��������� ��������� ���� (2-��� ���� ����))
        double    MeasureDeltaEpsilon;   // ----- ������ ��������� ���� � ���������� ��������� (��������� � ������� 1. ������������� ������� � �������� 2.������ ��������� ��������� ���� (2-��� ���� ����))
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
       int      ZondImpulsCount;    // ------- ���������� ����������� ��������� --------
       int      NumberImpuls;       // ------- ����� �������� ������������ �������� ------------
       int      CountObr;           // ------- ���������� ��������� � ���� -----------
     // -----------
       bool        Indicator_Redraw; // ----- ����� �� ������� ������ ����������� ��������� ���� ----------

     // ----------- ��������� �� ���� -------------
       struct {
           TTargetsCoord  *Coords;         // -------- ����� ������� �������� ��������� ���� --------
           int             Coords_Count;   // -------- ���������� ��������� ��������� ���� ----------
           TImpuls        *Impulses;           // -------- ���������� �� ���� ����������� ��������� ������ (����������) ���������� � ����  --------
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

       void Set_TargetName (int aIndex) { ShortString aTargetName; if (aIndex < 10)  aTargetName = "�-00" + IntToStr(aIndex); else if (aIndex < 100)  aTargetName = "�-0" + IntToStr(aIndex); else aTargetName = "�-" + IntToStr(aIndex); for (int i = 1; i <= 5; i++) Target.Name[i-1] = aTargetName[i]; }
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
