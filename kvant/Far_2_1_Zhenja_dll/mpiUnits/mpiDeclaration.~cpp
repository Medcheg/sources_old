//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiDeclaration.h"

#pragma package(smart_init)
//===========================================================================
const AnsiString MainProjectCaption = "Far 2";
const AnsiString ProjectCaption     = "Far 2 - ";
const AnsiString NameIniFile        = "Far_2.ini";

TFloat T0 = 0.02;
TFloat CurModelTime;
TFloat CurReviewTime;

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


/////////////////
TMatrix3x3      Ravnosignal_DirectionalCosines;
TDiagram      **DiagramArray; int Diagram_Count = 5; int OldDiagram_Count = -1;
TFarParam       FarParam;
/////////////////


// -------------- ѕараметры окна индикатора ----------
TFloat TimerRefreshFreq = 23.1;
TFloat TimerRefreshTime = 1.0 / TimerRefreshFreq;

  // ------- значени€ моделировани€ -----------
      TFloat q_c = 0; // --- ћоделируемый текущий угoл направлени€ оптической оси в стабилизированной системе координат ----------
      TFloat Eps_c = 0; // --- ћоделируемый текущий угoл направлени€ оптической оси в стабилизированной системе координат ----------
      TFloat teta_k_a = 0; // --- ћоделируемый текущий угол поворота оси стабилизации антены по бортовой качке ---
      TFloat psi_a = 0; // --- ћоделируемый текущий угол поворота оси стабилизации антенны по килевой качке ---

