//===========================================================================

#ifndef mpiDeclarationH
#define mpiDeclarationH
//===========================================================================
#include "mpiTypes.h"
//===========================================================================

typedef TFloat TData   [50 + 1];
typedef TFloat TData_Pd[50 + 1][15 + 1];
typedef TFloat Tnver   [9];
typedef TColor Tver    [9];

// ------------------------------
extern AnsiString ProjectCaption;
extern int     FileVersion;
extern TAnglesTick  *AnglesTick;   // ----- Массив угломестных отметок ---------
extern int           AnglesTickCount; // ----- Количество елементов масива угломестных отметток ----

// ------------------------------
extern TColor     BgColor;
extern TColor     AxesColor;
extern TColor     BackupColor;
extern TColor     FontColor;

// ------------------------------
extern TRect              aWindow;
extern Graphics::TBitmap *RedrawBitmap;
extern bool               DynamicModelRun;
extern TCanvas           *MainCanvas;

// ------------------------------
extern TFloat     DeltaHa;
extern TFloat     WorkBasicDistance;
extern TFloat     WorkSeaSurfaceShum;

// ------------------------------
extern int        nak;
extern int        trans_reg;
extern TFloat     N_Sh;
extern TFloat     L_pot_J;
extern TFloat     GPri_sum;
extern TFloat     GPri_part;
extern TFloat     q0[68 + 1];
extern TFloat     DDist;
extern TFloat     Tau;
extern TFloat     T_P;
extern TFloat     GPer;
extern TFloat     GPri;
extern TFloat     PPer;
extern TFloat     PPer_raz;
extern TFloat     PPri;
extern TFloat     PPri_min;
extern TFloat     ksi;
extern TFloat     ksi_raz;
extern TFloat     PotT;
extern TFloat     PotR;
extern TFloat     Dsw;
extern TFloat     Line_obn;
extern TFloat     ppol;
extern TFloat     eps;
extern TFloat     se;
extern TFloat     sse_F;
extern TFloat     sse_K;

extern Tver     arver;
extern Tnver    arnver;
extern TData Data_S_N;
extern TData_Pd Kriv_obn;

extern TZvData ZvData;
extern double mju_array1[5][5];
extern double mju_array2[5][5];
extern double mju_array3[5][5];

//===========================================================================
#endif
