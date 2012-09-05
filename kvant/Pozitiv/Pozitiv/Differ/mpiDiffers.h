//---------------------------------------------------------------------------

#ifndef mpiDiffersH
#define mpiDiffersH
#include "Math.h"
#include "Math.hpp"
#define round(x)    (((x)-floor((x))>0.5)?ceil((x)):floor((x)))
extern const double pi;
extern const double two_pi;
extern const double pi_del_180;
extern const double _180_del_pi;
//---------------------------------------------------------------------------

class TMyDiff {
private:
   double Old_X;
   double Old_Out;
   double Old_Time;
   double ft0, a0, a1;
   int    fAzimMNKCoef;

   double Old_Y;

   double x[490];
   int    Tick;
   double Coef;
   double OutValue;
public:
   TMyDiff (double at0) {
       ft0          = at0;
       Tick         = 0;
       Coef         = 0;
         for (int i = 490 - 1; i >= 0; i--) x[i] = 0;
         Old_X = 0;
         OutValue = 0;
   }

   double Run (double aTime, double X) {
         if (Old_X != X && Tick != 0) {

            Old_X = X;
            Coef = (X - x[Tick]) / Tick;

            if (Tick > 10){
               Beep();
            }

            for (int k = 0; k <= Tick; k++)
                 x[Tick - k] = x[Tick - k] + Coef*k;

            x[0] = X;
            OutValue = 8*x[0] + 8*x[1] + 8*x[2] + 8*x[3] + 8*x[4] - 8*x[5] - 8*x[6] - 8*x[7] - 8*x[8] - 8*x[9];

            Tick = 0;
         };
         for (int i = 490 - 1; i >= 1; i--) x[i] = x[i-1];
         Tick ++;

        return OutValue;
   }
};



class TJanDiff {
private:
   double x[30];
   double ft0;
public:
   // -------------
     TJanDiff (double at0)
     {
        ft0 = at0;
        for (int i =0; i < 30; i ++)
          x[i] = 0;
     }

   // -------------
     double Run (double X) {
         for (int i = 30 - 1; i >= 1; i--) x[i] = x[i-1];
      // -----
         x[0] = X;
      // -----
         return 8*x[0] + 8*x[1] + 8*x[2] + 8*x[3] + 8*x[4] - 8*x[5] - 8*x[6] - 8*x[7] - 8*x[8] - 8*x[9] ;
    }
   // -------------
};

class TAmpl {
private:
    double fAmplValue;
    double fShum;
public:
    TAmpl(double aAmplValue, double aShum) {fAmplValue = aAmplValue; fShum = aShum;};
    double Run(double aValue)
    {
      return round((aValue + RandG(0,fShum)) / fAmplValue) * fAmplValue;
    }
};
#endif
