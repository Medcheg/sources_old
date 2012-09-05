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
      // ------------- ��������� ��� --------
      TFloat     Ha;     // ---- ������ ��������� ������� --------
      TFloat     EpsLuch;   // ---- ���� ����� ���� -----------
      TFloat     ShirLuch;    // ---- ������ ���� ------
      TFloat     Lambda;         // ---- ������� ������ ����� (���������)
      TFloat     OmegaA;   // ---- ������� �������� �������� ������� -----
                 // ---- ��� ����� �������� �������� ����� ��������� ������������� ------
      TFloat     BasicDistance;       // ----  ������� ��������� ------------
      TFloat     Pt;       // ------ ���������� �������� ----------
      TFloat     Gt;       // ------ �-� ��� �� �������� ----------
      TFloat     Gr;       // ------ �-� ��� �� ����� -------------
      TFloat     DSink;    // ------ �-� ������ ��������� ---------
      TFloat     NFSink;       // ------ �-� ���� ���������
      TFloat     BSink;    // ------ ������ ����������� ��������� -
      TFloat     ASink;    // ------ 19 �� --
      TFloat     Lt;       // ------ ������ ��� ��������� ---------
      TFloat     Lr;       // ------ ������ ��� ������ ------------
      TFloat     Ls;       // ------ ������ ��� ��������� ---------
      TFloat     DeltaGa;  // ------ ��������� �-�� �������� ���, ��� ���������� ��� ���� �� ������� -------
      // ----------------
      TFloat     TargetEPR; // ----- ��� ���� ---------
      int        TypeSignalFluctuation; // ----- ��� ���������� �������
      // ----------------
      bool       Esktrapoling;//;
      bool       AnglesLine;
      TFloat     MaxVerticalDistance;      // ----
      TFloat     VerticalAxisValueStep;
      TFloat     MaxGorizontDistance;       // ----
      TFloat     GorizontalAxisValueStep;

      // ----------------
      TFloat     SeaSurfaceShumMeter;  // ---- �������� ������������� ���� (���������) -----------
      TFloat     SeaSurfaceShumBall;            // ---- �������� �������� ���� � ������ -----------
      TFloat     La;                                  // ---- ����. ������������ ������ � ��������� ----
      TFloat     Lj;                                  // ---- ����. ������ ������ ----
      TFloat     Re;                         // ----- ������������� ������ ����� ----
      TFloat     Rz;                         // ----- ������ ����� ----
      // ----------------
      TFloat     Pd;              // ---- ����������� ����������� ---------
      int        Pfa;                // ----- ����������� ������� ����������� --------
      bool       OtherPd;      // FmMain.cbver.Checked
} TZvData;
//===========================================================================

typedef struct {
     TFloat   Value;
     bool     Visible;
     void Init () { Value = 0.0; Visible = true;}
} TAnglesTick;
#endif
