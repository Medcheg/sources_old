//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiDeclaration.h"

#pragma package(smart_init)
//===========================================================================
const AnsiString MainProjectCaption = "Far 2";
const AnsiString ProjectCaption     = "Far 2 - ";
const AnsiString NameIniFile        = "Far_2.ini";

//TFloat T0;
TFloat CurModelTime;
TFloat CurReviewTime;

COLORREF Indicator_BGColor; // 'Цвет фона'
COLORREF Indicator_RingColor; //'Цвет колец дальности'
COLORREF Indicator_TargetColor;  //'Цвет целевых отметок'
COLORREF Indicator_TargetFontColor; //'Цвет подписей целей'

COLORREF Graph_BGColor; // 'Цвет фона'
COLORREF Graph_TitleColor; //'Цвет шрифта заголовков'
COLORREF Graph_AxisColor; //'Цвет осевых линий'
COLORREF Graph_CurveColor; //'Цвет кривых'


bool Stoped               = true;
bool Paused               = false;
bool ModelStepEnabled     = false;
bool Started              = false;
bool EnableWaveFilter     = true;

bool ProjectParamModified = false;// -----------------
bool WindowsStateTop      = true; // false;
int  OperationCounter     = 0;
int  DelayValue           = 0;

TFloat OmegaXa, OmegaYa, OmegaZa,  Vxa, Vya, Vza, Wxa, Wya, Wza;  


// -------------- Параметры окна индикатора ----------
TFloat TimerRefreshFreq = 23.1;
TFloat TimerRefreshTime = 1.0 / TimerRefreshFreq;

// -------------- Размер шрифта вормуляра ----------
int FormuljarFontSize = 8;


//===================
   TTarget       **Targets;     int Targets_Count;
   TDiagram      **DiagramArray; int Diagram_Count = 5; int OldDiagram_Count = -1; 
   TIndicator     *Indicator;
   TGraph         *Graph;
   TFarParam       FarParam;
   TFar           *aFar;
//===================
  // ------- значения моделирования -----------
      TFloat q_c = 0; // --- Моделируемый текущий угoл направления оптической оси в стабилизированной системе координат ----------
      TFloat Eps_c = 0; // --- Моделируемый текущий угoл направления оптической оси в стабилизированной системе координат ----------
      TFloat teta_k_a = 0; // --- Моделируемый текущий угол поворота оси стабилизации антены по бортовой качке ---
      TFloat psi_a = 0; // --- Моделируемый текущий угол поворота оси стабилизации антенны по килевой качке ---

//===========================================================================
void SetDefaultProjectParam(){
    
/*    FarParam.Antenna.Enabled = true;
    FarParam.Antenna.H1      = 2.185;
    FarParam.Antenna.H2      = 2.185;
    FarParam.Antenna.h       = 3.0;
    FarParam.Antenna.a       = 0.75;
    FarParam.Antenna.ro      = 1.226;
    FarParam.Antenna.Vb      = 45.0;
    FarParam.Antenna.V0      = 0;
    FarParam.Antenna.B       = 0.4;
 */
    FarParam.Diagram.Form        = dfCos; //dfSinH_H
    FarParam.Diagram.Type        = dtActive;//dtPassive;//dtActive;//;
    FarParam.Diagram.CutLevel           = 3.0;
    FarParam.Diagram.KoefPlacingDiagram = 0.7;
//    FarParam.Diagram.DetectorCutLevel   = 6.0;

//    FarParam.WorkMode           = wmAccurateLocation;//wmLocation;//;//;//;//;//;//;//;//;//;//;//
//    FarParam.BeamLocate         = blFazaFreq;// ;//blFreq; //blHand;//

//    FarParam.RotationSpeed      = 0.0 * Pi_del_180;
    FarParam.RotationSpeed      = 72 * Pi_del_180;
    FarParam.KursAngle0         = 0.0;
//    FarParam.kFa                = 1.15;
    FarParam.T0n                = 0.02;
    FarParam.HalfScanSector     = 32 * Pi_del_180;


//    FarParam.BeginImpulsCount   = 2;
//    FarParam.EndImpulsCount     = 3;


    FarParam.sh                 = 14.0;  // 18.0
    FarParam.Sigma2             = 1.0;
//    FarParam.Ka                 = 1.25;
//    FarParam.Ke                 = 1.179;

    FarParam.SigmaEkstrapol     = 0.0  * Pi_del_180;
    FarParam.DeltaRo1           = 0.1  * Pi_del_180;
    FarParam.DeltaRo2           = 0.1  * Pi_del_180;
    FarParam.MaxTetaAngle       = 65.0 * Pi_del_180;


    FarParam.Hx                 = 0.50;
    FarParam.Hy                 = 0.50;
    FarParam.Hz                 = 30.0;

    FarParam.DiametrFar         = 1.5;

    FarParam.Eps0               =  0.0 * Pi_del_180;
    FarParam.DeltaEps0          =  0.0;
    FarParam.Nju                =  0.0 * Pi_del_180;
    FarParam.DeltaNju           =  0.0;

//    FarParam.AperturePowering   = apUpper;
//    FarParam.OscilatorPowering  = opLeft;

//    FarParam.al                 = 0.09;
//    FarParam.dl                 = 0.054;
//    FarParam.nl                 = 0.0;

//    FarParam.as_                = 0.09;
//    FarParam.ss                 = 0.6027;
//    FarParam.ds                 = 0.058;
///    FarParam.ns                 = 5.0;

//    FarParam.BeamCount          = 3;
//    FarParam.BeamNumber         = 10;
//    FarParam.FreqN              = 8.25; // --- ГГц -----
//    FarParam.FreqV              = 8.85; // --- ГГц -----
    FarParam.WorkFreq           = 8.55; // --- ГГц -----

//-------------
/*    FarParam.WFar               = 2.20;
    FarParam.HFar               = 1.184;
    FarParam.Eps0               = 30.0 * Pi_del_180;
    FarParam.Betta              = 2.97 * Pi_del_180;
    FarParam.OscilatorPowering  = opRight;
    FarParam.al                 = 0.0285;
    FarParam.dl                 = 0.025;
    FarParam.nl                 = 0;

    FarParam.as_                = 0.0285;
    FarParam.ss                 = 0.0987;
    FarParam.ds                 = 0.01875;
    FarParam.ns                 = 2.0;
    FarParam.BeamNumber         = 1;
    FarParam.FreqN              = 8.25; // --- ГГц -----
    FarParam.FreqV              = 8.85; // --- ГГц -----
    FarParam.DeltaBeamFreq      = 40.0;    // --- МГц -----*/
//-------------


// -------------- Параметры окна индикатора ----------
    TimerRefreshFreq = 23.3;
    TimerRefreshTime = 1.0 / TimerRefreshFreq;

// -------------- Параметры Окна графиков ----------

//    T0            = 1.0/FarParam.Fa;
    CurModelTime  = 0.0;
    CurReviewTime = 0.0;

    TimerRefreshTime = 0;

    FormuljarFontSize = 8;

    Stoped  = true;
    Started = false;
    Paused  = false;
    ModelStepEnabled = false;
}


