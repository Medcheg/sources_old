//---------------------------------------------------------------------------

#ifndef mpiDeclarationH
#define mpiDeclarationH
//---------------------------------------------------------------------------
#include "mpiTypes.h"
//#include "mpiIndicator.h"
//#include "mpiGraph.h"
//#include "mpiFar.h"
//#include "mpiTarget.h"
#include "mpiDiagram.h"
//---------------------------------------------------------------------------
extern const AnsiString MainProjectCaption;
extern const AnsiString ProjectCaption;
extern const AnsiString NameIniFile;

extern TFloat T0;
extern TFloat CurModelTime;
extern TFloat CurReviewTime;

extern bool   Stoped;
extern bool   Started;
extern bool   Paused;
extern bool   ModelStepEnabled;
extern bool   EnableWaveFilter;


extern bool ProjectParamModified;
extern bool WindowsStateTop;
extern int  OperationCounter;
extern int  DelayValue;

extern TFloat OmegaXa, OmegaYa, OmegaZa,  Vxa, Vya, Vza, Wxa, Wya, Wza;

extern TFloat TimerRefreshFreq;
extern TFloat TimerRefreshTime;

extern int FormuljarFontSize;

////////////////////
extern double CurModelTime;
////////////////////
extern TMatrix3x3      Ravnosignal_DirectionalCosines;

extern TDiagram      **DiagramArray;
extern int Diagram_Count;
extern int OldDiagram_Count;
extern TFarParam       FarParam;
////////////////////

  // ------- значения моделирования -----------
extern TFloat q_c;
extern TFloat Eps_c;
extern TFloat teta_k_a;
extern TFloat psi_a;
#endif
