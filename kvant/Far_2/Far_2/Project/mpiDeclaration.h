//---------------------------------------------------------------------------

#ifndef mpiDeclarationH
#define mpiDeclarationH
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include "mpiIndicator.h"
#include "mpiGraph.h"
#include "mpiFar.h"
#include "mpiTarget.h"
#include "mpiDiagram.h"
//---------------------------------------------------------------------------
extern const AnsiString MainProjectCaption;
extern const AnsiString ProjectCaption;
extern const AnsiString NameIniFile;

extern TFloat CurModelTime;
extern TFloat CurReviewTime;

extern COLORREF Indicator_BGColor; // '÷вет фона'
extern COLORREF Indicator_RingColor; //'÷вет колец дальности'
extern COLORREF Indicator_TargetColor;  //'÷вет целевых отметок'
extern COLORREF Indicator_TargetFontColor; //'÷вет подписей целей'

extern COLORREF Graph_BGColor; // '÷вет фона'
extern COLORREF Graph_TitleColor; //'÷вет шрифта заголовков'
extern COLORREF Graph_AxisColor; //'÷вет осевых линий'
extern COLORREF Graph_CurveColor; //'÷вет кривых'

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


extern TTarget      **Targets;      extern int Targets_Count;
extern TDiagram     **DiagramArray; extern int Diagram_Count; extern int OldDiagram_Count;
extern TIndicator    *Indicator;
extern TGraph        *Graph;
extern TFarParam      FarParam;
extern TFar          *aFar;

  // ------- значени€ моделировани€ -----------
extern TFloat q_c;
extern TFloat Eps_c;
extern TFloat teta_k_a;
extern TFloat psi_a;

extern void SetDefaultProjectParam();

#endif
