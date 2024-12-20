//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiDeclaration.h"
//===========================================================================
#pragma package(smart_init)
//===========================================================================
AnsiString ProjectCaption = "Zv - ";

// ------------  ��������� ����������� --------------
TRect              aWindow;              // --------- ���� ���� � ������� ����� ------
Graphics::TBitmap *RedrawBitmap = NULL;  // --------- ������� ������ -----------------

// ------------------------
bool               DynamicModelRun  = false;  // ---- ������� �� ������������ ����� --------
TCanvas           *MainCanvas       = NULL;   // ---- ����� �� ������� ����� ---------------

// ------------------------
TZvData       ZvData;               // ----- ��������� ������ ��������� ---------
int           FileVersion;          // ----- ������ ����� ������ ----------------
TAnglesTick  *AnglesTick = NULL;   // ----- ������ ����������� ������� ---------
int           AnglesTickCount = 0; // ----- ���������� ��������� ������ ����������� �������� ----

TColor     BgColor;
TColor     AxesColor;
TColor     BackupColor;
TColor     FontColor;

// ---------------- ��������� ������� ������������� ��� ���� ��� ������� �9 ------------
TFloat     WorkBasicDistance     =  0.0;       // ----  ������� ��������� �� ������� �������� ------------
TFloat     WorkSeaSurfaceShum    =  0.0;       // ---- �� �������� �� ������� ������� ---------
TFloat     DeltaHa               =  0.0;       // ---- ����� ������ ������� ��-�� �������� ���� -------

// --------------------------------------------------
// ---------- ������ ���������� ��������� -----------
// --------------------------------------------------
int        nak = 1;

int        trans_reg;
TFloat     N_Sh;
TFloat     L_pot_J;
TFloat     GPri_sum;
TFloat     GPri_part;
TFloat     q0[68 + 1];
TFloat     DDist;
TFloat     Tau;
TFloat     T_P;
TFloat     GPer;
TFloat     GPri;
TFloat     PPer;
TFloat     PPer_raz;
TFloat     PPri;
TFloat     PPri_min;
TFloat     ksi;
TFloat     ksi_raz;
TFloat     PotT;
TFloat     PotR;
TFloat     Dsw;
TFloat     Line_obn;
TFloat     ppol;
TFloat     eps;
TFloat     se;
TFloat     sse_F;
TFloat     sse_K;
                                                                                //clTeal
//Tver     arver    = {clBlack,clGray,clNavy,clBlue,clOlive,clAqua,clGreen,clLime,clYellow};
Tver     arver    = {clBlack,clGray,clNavy,/**/ clLime,clGreen,clAqua,0x004080FF ,clBlue,/**/clYellow};
Tnver    arnver   = {0.0    ,0.1   ,0.3   ,/**/ 0.5   ,0.7    ,0.9   ,0.95   ,0.99  ,/**/0.999   };
TData    Data_S_N = {-10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2 , 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40};


double mju_array1[5][5] = {{ 6.12,  7.62,   9.4, 10.15, 11.35},  // [Pfa][Pd]
                           { 8.07,  9.27, 10.75, 11.40, 12.45},
                           { 9.40, 10.42, 11.75, 12.30, 13.30},
                           {10.43, 11.35, 12.53, 13.05, 13.95},
                           {11.20, 12.08, 13.18, 13.65, 14.50},
                          };
double mju_array2[5][5] = {{ 7.50, 10.75, 16.30, 19.45, 26.40},
                           { 9.52, 12.65, 18.10, 21.25, 28.20},
                           {10.90, 13.95, 19.35, 22.50, 29.45},
                           {11.95, 14.95, 20.35, 23.45, 30.40},
                           {12.78, 15.77, 21.15, 24.25, 31.32},
                         };
double mju_array3[5][5] = {{ 6.76,  9.14, 12.75, 14.65, 18.50},
                           { 8.73, 10.95, 14.40, 16.25, 20.05},
                           {10.80, 12.20, 15.60, 17.45, 21.20},
                           {11.13, 13.20, 16.53, 18.35, 22.10},
                          {11.95, 13.98, 17.30, 19.10, 22.85},
                          };

TData_Pd Kriv_obn = {{0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.016, 0.017, 0.017, 0.002, 0.002, 0.002, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.018, 0.019, 0.018, 0.002, 0.003, 0.002, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.02 , 0.022, 0.021, 0.003, 0.003, 0.003, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.023, 0.025, 0.024, 0.003, 0.004, 0.004, 0.000, 0.001, 0.001, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.028, 0.03 , 0.029, 0.004, 0.005, 0.005, 0.001, 0.001, 0.001, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.033, 0.037, 0.035, 0.005, 0.007, 0.006, 0.001, 0.001, 0.001, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.04 , 0.047, 0.044, 0.007 ,0.01 , 0.008, 0.001, 0.002, 0.002, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.051, 0.059, 0.056, 0.009 ,0.014, 0.012, 0.002, 0.004, 0.002, 0.000, 0.001, 0.000, 0.000, 0.000, 0.000},
                     {0.000, 0.065, 0.077, 0.072, 0.013, 0.021, 0.017, 0.002, 0.006, 0.004, 0.000, 0.002, 0.001, 0.000, 0.000, 0.000},
                     {0.000, 0.084, 0.1  , 0.094, 0.018, 0.032, 0.025, 0.004, 0.01 , 0.007, 0.001, 0.003, 0.002, 0.000, 0.001, 0.000},
                     {0.000, 0.112, 0.13 , 0.124, 0.027, 0.047, 0.038, 0.006, 0.017, 0.011, 0.001, 0.006, 0.003, 0.000, 0.002, 0.001},
                     {0.000, 0.15 , 0.168, 0.164, 0.041, 0.069, 0.057, 0.01 , 0.028, 0.019, 0.002, 0.012, 0.006, 0.000, 0.005, 0.002},
                     {0.000, 0.203, 0.215, 0.215, 0.062, 0.1  , 0.086, 0.017, 0.046, 0.033, 0.004, 0.021, 0.012, 0.001, 0.01 , 0.004},
                     {0.000, 0.275, 0.269, 0.277, 0.097, 0.14 , 0.127, 0.029, 0.073, 0.055, 0.008, 0.038, 0.023, 0.002, 0.02 , 0.010},
                     {0.000, 0.369, 0.331, 0.351, 0.15 , 0.19 , 0.182, 0.052, 0.109, 0.09 , 0.016, 0.063, 0.043, 0.005, 0.036, 0.020},
                     {0.000, 0.485, 0.397, 0.434, 0.23 , 0.25 , 0.252, 0.092, 0.157, 0.14 , 0.033, 0.099, 0.076, 0.011, 0.062, 0.040},
                     {0.000, 0.616, 0.465, 0.521, 0.343, 0.317, 0.336, 0.161, 0.216, 0.208, 0.066, 0.147, 0.125, 0.025, 0.1  , 0.074},
                     {0.000, 0.749, 0.533, 0.608, 0.49 , 0.389, 0.429, 0.271, 0.284, 0.292, 0.13 , 0.207, 0.194, 0.056, 0.151, 0.127},
                     {0.000, 0.864, 0.598, 0.689, 0.656, 0.462, 0.526, 0.427, 0.357, 0.389, 0.243, 0.276, 0.281, 0.123, 0.213, 0.200},
                     {0.000, 0.942, 0.658, 0.761, 0.81 , 0.534, 0.62 , 0.616, 0.433, 0.491, 0.414, 0.351, 0.381, 0.248, 0.285, 0.292},
                     {0.000, 0.983, 0.713, 0.822, 0.922, 0.602, 0.705, 0.798, 0.508, 0.591, 0.626, 0.429, 0.487, 0.444, 0.362, 0.396},
                     {0.000, 0.997, 0.761, 0.87 , 0.978, 0.664, 0.778, 0.925, 0.579, 0.683, 0.823, 0.505, 0.591, 0.679, 0.44 , 0.505},
                     {0.000, 1.000, 0.803, 0.908, 0.997, 0.719, 0.838, 0.983, 0.644, 0.762, 0.946, 0.577, 0.684, 0.874, 0.517, 0.609},
                     {0.000, 1.000, 0.838, 0.936, 1.000, 0.768, 0.884, 0.998, 0.703, 0.826, 0.991, 0.644, 0.764, 0.972, 0.589, 0.702},
                     {0.000, 1.000, 0.868, 0.956, 1.000, 0.809, 0.919, 1.000, 0.754, 0.876, 0.999, 0.703, 0.829, 0.997, 0.655, 0.779},
                     {0.000, 1.000, 0.893, 0.971, 1.000, 0.844, 0.945, 1.000, 0.798, 0.914, 1.000, 0.754, 0.879, 1.000, 0.713, 0.841},
                     {0.000, 1.000, 0.914, 0.98 , 1.000, 0.874, 0.963, 1.000, 0.835, 0.941, 1.000, 0.798, 0.916, 1.000, 0.763, 0.889},
                     {0.000, 1.000, 0.931, 0.987, 1.000, 0.898, 0.975, 1.000, 0.866, 0.96 , 1.000, 0.836, 0.943, 1.000, 0.806, 0.923},
                     {0.000, 1.000, 0.944, 0.992, 1.000, 0.918, 0.984, 1.000, 0.892, 0.974, 1.000, 0.867, 0.962, 1.000, 0.842, 0.948},
                     {0.000, 1.000, 0.944, 0.992, 1.000, 0.918, 0.984, 1.000, 0.892, 0.974, 1.000, 0.867, 0.962, 1.000, 0.842, 0.948},
                     {0.000, 1.000, 0.955, 0.995, 1.000, 0.934, 0.989, 1.000, 0.913, 0.983, 1.000, 0.892, 0.975, 1.000, 0.872, 0.965},
                     {0.000, 1.000, 0.964, 0.996, 1.000, 0.947, 0.993, 1.000, 0.93 , 0.989, 1.000, 0.913, 0.983, 1.000, 0.897, 0.977},
                     {0.000, 1.000, 0.972, 0.998, 1.000, 0.958, 0.996, 1.000, 0.944, 0.993, 1.000, 0.93 , 0.989, 1.000, 0.917, 0.985},
                     {0.000, 1.000, 0.977, 0.999, 1.000, 0.966, 0.997, 1.000, 0.955, 0.995, 1.000, 0.944, 0.993, 1.000, 0.933, 0.99 },
                     {0.000, 1.000, 0.982, 0.999, 1.000, 0.973, 0.998, 1.000, 0.964, 0.997, 1.000, 0.955, 0.995, 1.000, 0.947, 0.994},
                     {0.000, 1.000, 0.986, 0.999, 1.000, 0.978, 0.999, 1.000, 0.971, 0.998, 1.000, 0.964, 0.997, 1.000, 0.957, 0.996},
                     {0.000, 1.000, 0.989, 1.000, 1.000, 0.983, 0.999, 1.000, 0.977, 0.999, 1.000, 0.972, 0.998, 1.000, 0.966, 0.997},
                     {0.000, 1.000, 0.991, 1.000, 1.000, 0.986, 1.000, 1.000, 0.982, 0.999, 1.000, 0.977, 0.999, 1.000, 0.973, 0.998},
                     {0.000, 1.000, 0.993, 1.000, 1.000, 0.989, 1.000, 1.000, 0.986, 0.999, 1.000, 0.982, 0.999, 1.000, 0.978, 0.999},
                     {0.000, 1.000, 0.994, 1.000, 1.000, 0.991, 1.000, 1.000, 0.988, 1.000, 1.000, 0.986, 1.000, 1.000, 0.983, 0.999},
                     {0.000, 1.000, 0.995, 1.000, 1.000, 0.993, 1.000, 1.000, 0.991, 1.000, 1.000, 0.989, 1.000, 1.000, 0.986, 1.000},
                     {0.000, 1.000, 0.996, 1.000, 1.000, 0.995, 1.000, 1.000, 0.993, 1.000, 1.000, 0.991, 1.000, 1.000, 0.989, 1.000},
                     {0.000, 1.000, 0.997, 1.000, 1.000, 0.996, 1.000, 1.000, 0.994, 1.000, 1.000, 0.993, 1.000, 1.000, 0.991, 1.000},
                     {0.000, 1.000, 0.998, 1.000, 1.000, 0.997, 1.000, 1.000, 0.995, 1.000, 1.000, 0.994, 1.000, 1.000, 0.993, 1.000},
                     {0.000, 1.000, 0.998, 1.000, 1.000, 0.997, 1.000, 1.000, 0.996, 1.000, 1.000, 0.995, 1.000, 1.000, 0.995, 1.000},
                     {0.000, 1.000, 0.999, 1.000, 1.000, 0.998, 1.000, 1.000, 0.997, 1.000, 1.000, 0.996, 1.000, 1.000, 0.996, 1.000},
                     {0.000, 1.000, 0.999, 1.000, 1.000, 0.998, 1.000, 1.000, 0.998, 1.000, 1.000, 0.997, 1.000, 1.000, 0.997, 1.000},
                     {0.000, 1.000, 0.999, 1.000, 1.000, 0.999, 1.000, 1.000, 0.998, 1.000, 1.000, 0.998, 1.000, 1.000, 0.997, 1.000},
                     {0.000, 1.000, 0.999, 1.000, 1.000, 0.999, 1.000, 1.000, 0.999, 1.000, 1.000, 0.998, 1.000, 1.000, 0.998, 1.000},
                     {0.000, 1.000, 1.000, 1.000, 1.000, 0.999, 1.000, 1.000, 0.999, 1.000, 1.000, 0.999, 1.000, 1.000, 0.999, 1.000}};

/*

const
     Hs:array[1..3] of real=(20*1e-3,15*1e-3,7.5*1e-3);
var
 lam,real;
 ,,sse,,,:real;
*/


/*
type
     ver=array [1..8] of TColor;
     nver=array [1..8] of real;
     Data=array [1..50] of Extended;
     Data_Pd=array[1..50,1..15] of Extended;
 const

      Data_Pd_2M:Data= (0.016,0.018,0.02,0.023,0.028,0.033,0.04,0.051,
                        0.065,0.084,0.112,0.15,0.203,0.275,0.369,0.485,
                        0.616,0.749,0.864,0.942,0.983,0.997,1,1,1,1,1,
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
      Data_Pd_2S1:Data=(0.017,0.019,0.022,0.025,0.03,0.037,0.047,0.059,
                        0.077,0.1,0.13,0.168,0.215,0.269,0.331,0.397,0.465,
                        0.533,0.598,0.658,0.713,0.761,0.803,0.838,0.868,
                        0.893,0.914,0.931,0.944,0.955,0.964,0.972,0.977,
                        0.982,0.986,0.989,0.991,0.993,0.994,0.995,0.996,
                        0.997,0.998,0.998,0.999,0.999,0.999,0.999,0.999,1);
      Data_Pd_2S2:Data=(0.017,0.018,0.021,0.024,0.029,0.035,0.044,0.056,
                        0.072,0.094,0.124,0.164,0.215,0.277,0.351,0.434,
                        0.521,0.608,0.689,0.761,0.822,0.87,0.908,0.936,
                        0.956,0.971,0.98,0.987,0.992,0.995,0.996,0.998,
                        0.999,0.999,0.999,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
      Data_Pd_3M:Data= (0.002,0.002,0.003,0.003,0.004,0.005,0.007,0.009,
                        0.013,0.018,0.027,0.041,0.062,0.097,0.15,0.23,0.343,
                        0.49,0.656,0.81,0.922,0.978,0.997,1,1,1,1,1,1,1,1,1,
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
      Data_Pd_3S1:Data=(0.002,0.003,0.003,0.004,0.005,0.007,0.01,0.014,0.021,
                        0.032,0.047,0.069,0.1,0.14,0.19,0.25,0.317,0.389,
                        0.462,0.534,0.602,0.664,0.719,0.768,0.809,0.844,0.874,
                        0.898,0.918,0.934,0.947,0.958,0.966,0.973,0.978,0.983,
                        0.986,0.989,0.991,0.993,0.995,0.996,0.997,0.997,0.998,
                        0.998,0.999,0.999,0.999,0.999);
      Data_Pd_3S2:Data=(0.002,0.002,0.003,0.004,0.005,0.006,0.008,0.012,0.017,
                        0.025,0.038,0.057,0.086,0.127,0.182,0.252,0.336,0.429,
                        0.526,0.62,0.705,0.778,0.838,0.884,0.919,0.945,0.963,
                        0.975,0.984,0.989,0.993,0.996,0.997,0.998,0.999,0.999,
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1);
      Data_Pd_4M:Data= (0,0,0,0,0.001,0.001,0.001,0.002,0.002,0.004,0.006,0.01,
                        0.017,0.029,0.052,0.092,0.161,0.271,0.427,0.616,0.798,
                        0.925,0.983,0.998,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                        1,1,1,1,1,1,1,1);
      Data_Pd_4S1:Data=(0,0,0,0.001,0.001,0.001,0.002,0.004,0.006,0.01,0.017,
                        0.028,0.046,0.073,0.109,0.157,0.216,0.284,0.357,0.433,
                        0.508,0.579,0.644,0.703,0.754,0.798,0.835,0.866,0.892,
                        0.913,0.93,0.944,0.955,0.964,0.971,0.977,0.982,0.986,
                        0.988,0.991,0.993,0.994,0.995,0.996,0.997,0.998,0.998,
                        0.999,0.999,0.999);
      Data_Pd_4S2:Data=(0,0,0,0.001,0.001,0.001,0.002,0.002,0.004,0.007,0.011,
                        0.019,0.033,0.055,0.09,0.14,0.208,0.292,0.389,0.491,
                        0.591,0.683,0.762,0.826,0.876,0.914,0.941,0.96,0.974,
                        0.983,0.989,0.993,0.995,0.997,0.998,0.999,0.999,0.999,
                        1,1,1,1,1,1,1,1,1,1,1,1);
      Data_Pd_5M:Data= (0,0,0,0,0,0,0,0,0,0.001,0.001,0.002,0.004,0.008,0.016,
                        0.033,0.066,0.13,0.243,0.414,0.626,0.823,0.946,0.991,
                        0.999,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
      Data_Pd_5S1:Data=(0,0,0,0,0,0,0,0.001,0.002,0.003,0.006,0.012,0.021,
                        0.038,0.063,0.099,0.147,0.207,0.276,0.351,0.429,0.505,
                        0.577,0.644,0.703,0.754,0.798,0.836,0.867,0.892,0.913,
                        0.93,0.944,0.955,0.964,0.972,0.977,0.982,0.986,0.989,
                        0.991,0.993,0.994,0.995,0.996,0.997,0.998,0.998,0.999,
                        0.999);
      Data_Pd_5S2:Data=(0,0,0,0,0,0,0,0,0.001,0.002,0.003,0.006,0.012,0.023,
                        0.043,0.076,0.125,0.194,0.281,0.381,0.487,0.591,0.684,
                        0.764,0.829,0.879,0.916,0.943,0.962,0.975,0.983,0.989,
                        0.993,0.995,0.997,0.998,0.999,0.999,1,1,1,1,1,1,1,1,1,
                        1,1,1);
      Data_Pd_6M:Data= (0,0,0,0,0,0,0,0,0,0,0,0,0.001,0.002,0.005,0.011,0.025,
                        0.056,0.123,0.248,0.444,0.679,0.874,0.972,0.997,1,1,1,
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
      Data_Pd_6S1:Data=(0,0,0,0,0,0,0,0,0,0.001,0.002,0.005,0.01,0.02,0.036,
                        0.062,0.1,0.151,0.213,0.285,0.362,0.44,0.517,0.589,
                        0.655,0.713,0.763,0.806,0.842,0.872,0.897,0.917,0.933,
                        0.947,0.957,0.966,0.973,0.978,0.983,0.986,0.989,0.991,
                        0.993,0.995,0.996,0.997,0.997,0.998,0.998,0.999);
      Data_Pd_6S2:Data=(0,0,0,0,0,0,0,0,0,0,0.001,0.002,0.004,0.01,0.02,0.04,
                        0.074,0.127,0.2,0.292,0.396,0.505,0.609,0.702,0.779,
                        0.841,0.889,0.923,0.948,0.965,0.977,0.985,0.99,0.994,
                        0.996,0.997,0.998,0.999,0.999,1,1,1,1,1,1,1,1,1,1,1);
*/

