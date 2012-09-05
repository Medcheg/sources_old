//===========================================================================
#ifndef mpiGlobalsH
#define mpiGlobalsH
//===========================================================================
//#include "mpiCollection.h"
#include "Graphics.hpp"
#include "Forms.hpp"

//===========================================================================
typedef struct tag_DefaultACPParam
{
   int            MaxCanalFreq;
   int            MaxCanalCount;

//   CCollection_i  CoefUsil;
} TDefaultACPParam;
//===========================================================================
//===========================================================================
extern char  ProjectCaption[1024];

extern TColor ColorArray[];
extern AnsiString  ProjectFileName;
extern double  ChartBeginFreq, ChartEndFreq;
extern bool    cbFindFFTMaximums;

extern int   round(double aValue);
extern float Get_Mean(float *Values, int count);
extern float Get_SCO(float *Values, int count, float Mean);
extern float Get_Trend(float *Values, int Count, double T0);
extern void  Get_LMK(float *XValues, float *YValues, int Count, double &C0, double &C1);
extern bool  Get_LMK_Coef(int PolinomLevel, float *xVal, float *yVal, int ValuesCount, float *MNKCoef);

extern void  ShowErrorMessage(char *aFuncName);
extern void  SetEnableDisabled_VCL_Group(TForm *aForms, AnsiString ParentName, bool aEnabled);
extern void  DrawLineRectangle(Graphics::TCanvas *aCanvas, bool isDotLise, Graphics::TColor aColor, Types::TRect aRect);
#endif
