//===========================================================================
#ifndef mpiGlobalsH
#define mpiGlobalsH
//===========================================================================
#include <Chart.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>

#include "stdio.h"
//#include "mpiStorage.h"
//===========================================================================
enum  TDeviceType { edtNone           = -1,
                    edtIMU            =  0,
                    edtSingleAxisGyro =  1,
                    edtGyroDevice     =  2,
                    edtJapan1         =  3 };
                    
enum  TmpiValueType { evtFloat, evtUInt};


//===========================================================================
class CStorage;
class CmpiThread;

//===========================================================================
extern char ProjectCaption[1024];
extern char GyroCorrectionFileName[1024];

extern char  DeviceNames[][255];
extern bool  isUsedInnaLabsUA;
extern bool  isTestingDeviceWork;
extern int   CountSumPoint;
extern TColor ColorArray[];

extern AnsiString GetTimeString(double aTime);

extern float Get_Mean(float *Values, int count);
extern float Get_SCO(float *Values, int count, float Mean);
extern float Get_Trend(float *Values, int Count, double T0);
extern void  Get_LMK(float *XValues, float *YValues, int Count, double &C0, double &C1);

extern bool Get_Regression_Coef(int PolinomLevel, float **xVal, int xValParam, float *yVal, int ValuesCount, float *MNKCoef);

extern bool  Get_LMK_Coef(int PolinomLevel, float *xVal, float *yVal, int ValuesCount, float *MNKCoef);

//extern void  LoadStringFromStream(FILE *h_file, char *&aLoadStr);
//extern void  SaveStringFromStream(FILE *h_file, char *aSaveStr);
extern void  ShowErrorMessage(char *aFuncName);
extern void  SetEnableDisabled_VCL_Group(TForm *aForms, AnsiString ParentName, bool aEnabled);
extern void  DrawLineRectangle(Graphics::TCanvas *aCanvas, bool isDotLise, Graphics::TColor aColor, Types::TRect aRect);

//extern void Draw_ChartSeries(TChart *aChart, int SeriesIndex, bool isGraphDecimation, int DecimationPointCount, CStorageItem *ax, CStorageItem *ay);
extern void *hzVoid;
//===========================================================================
#endif
