//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "mpiFILTRS.h"

//---------------------------------------------------------------------------

#pragma package(smart_init)

TKalman  *Kalman;
TDST1    *DST1;
TDST1    *DST11;
TDST3    *DST3;
TDST3    *DST33;
TDST4    *DST4;
TDST5    *DST5;

TKalman::TKalman()
{
 k1 = 1;
 k2 = 1;
}

void TKalman::Init(TFloat aT0)
{
    fT0 = aT0;
  // --------------------------
    x   [0] = 0; x   [1] = 0; x   [2] = 0;

    y_e  [0] = 0; y_e  [1] = 0; y_e  [2] = 0; y_e  [3] = 0;
    y_o  [0] = 0; y_o  [1] = 0; y_o  [2] = 0; y_o  [3] = 0;
    py_o [0] = 0; py_o [1] = 0; py_o [2] = 0; py_o [3] = 0;

  // -------------------------
    ZCoef_Xe.a[0] = 0.0;  ZCoef_Xe.a[1] = (k1 + k2*fT0) ;  ZCoef_Xe.a[2] = -k1;
    ZCoef_Xe.b[0] = 1.0;  ZCoef_Xe.b[1] = (k1 + k2*fT0-2);  ZCoef_Xe.b[2] = (1-k1);

    ZCoef_Xo.a[0] = k1;   ZCoef_Xo.a[1] =  (k2*fT0 - k1) ;   ZCoef_Xo.a[2] = 0;
    ZCoef_Xo.b[0] = 1.0;  ZCoef_Xo.b[1] = (k1 + k2*fT0-2);  ZCoef_Xo.b[2] = (1-k1);

    ZCoef_pXo.a[0] = k2;   ZCoef_pXo.a[1] =     - k2 ;  ZCoef_pXo.a[2] = 0;
    ZCoef_pXo.b[0] = 1.0;  ZCoef_pXo.b[1] = (k1 + k2*fT0-2);  ZCoef_pXo.b[2] = (1-k1);
}

void TKalman::Run(TFloat Value)
{
       y_e[3] = y_e[2];  y_e[2] = y_e[1];  y_e[1] = y_e[0];
       y_o[3] = y_o[2];  y_o[2] = y_o[1];  y_o[1] = y_o[0];
       py_o[3] = py_o[2];  py_o[2] = py_o[1];  py_o[1] = py_o[0];

       x[2] = x[1];  x[1] = x[0]; x[0] = Value;

     //---------------  ----------
        y_o[0] = -(k1 + k2*fT0 - 2) * y_o[1] - (1 - k1) * y_o[2] + k1 * x[0] + (k2*fT0 - k1) * x[1];

     //---------------  ----------
        y_e[0] = -(k1 + k2*fT0 - 2) * y_e[1] - (1 - k1)*y_e[2] + (k2*fT0 + k1) * x[1] - k1*x[2];

     //--------------- Оценка скорости фильтра Калмана ----------
       py_o[0] = -(k1 + k2*fT0 - 2) * py_o[1] - (1 - k1)*py_o[2] + k2*x[0] - k2 * x[1];
}


TDST1:: TDST1()
{
   x            = NULL;
   ZCoef_Xe .a  = NULL;
   ZCoef_pXo.a  = NULL;
   N            = 2;
   Gamma        = 0;
}
TDST1::~TDST1()
{
   if (x != NULL) free (x);
   if (ZCoef_Xe.a  != NULL) free (ZCoef_Xe.a);
   if (ZCoef_pXo.a != NULL) free (ZCoef_pXo.a);
}
void TDST1::Init(TFloat aT0)
{
   if (x != NULL) free (x);
   if (ZCoef_Xe.a  != NULL) free (ZCoef_Xe.a);
   if (ZCoef_pXo.a != NULL) free (ZCoef_pXo.a);

   x           = (TFloat*) calloc ((N+2+1), sizeof(TFloat ));
   ZCoef_Xe.a  = (TFloat*) calloc ((N+2+1), sizeof(TFloat ));
   ZCoef_pXo.a = (TFloat*) calloc ((N+2+1), sizeof(TFloat ));

    y[0] = 0;  y[1] = 0;  y[2] = 0;
   py[0] = 0; py[1] = 0; py[2] = 0;

   a0 =   2 * (  N * (2*N + 1) + 3 * Gamma * N) / ( N * (N + 1) * (N + 2) );
   a1 = - 2 * (2*N + 3*Gamma) / (N * (N + 1) );
   a2 =   2 * (  N + 3*Gamma) / (N * (N + 1) );
   a3 = - 2 * (  N - 1 + 3*Gamma) / ((N + 1) * (N + 2));
   y[0] = 0; y[1] = 0; y[2] = 0;

   ZCoef_Xe.a[0]   = a0;
   ZCoef_Xe.a[1]   = a1;
   ZCoef_Xe.a[N+1] = a2;
   ZCoef_Xe.a[N+2] = a3;
   ZCoef_Xe.b[0]   = 1.0;
   ZCoef_Xe.b[1]   = -2.0;
   ZCoef_Xe.b[2]   = 1.0;

   y[0] = 0; y[1] = 0; y[2] = 0;

   pa0 =   6 / ( (N + 1) * (N + 2) * aT0);
   pa1 = - 6 / (N * (N + 1) * aT0);
   pa2 =   6 / (N * (N + 1) * aT0 );
   pa3 = - 6 / ( (N + 1) * (N + 2) * aT0);

   ZCoef_pXo.a[0  ] = pa0;
   ZCoef_pXo.a[1  ] = pa1;
   ZCoef_pXo.a[N+1] = pa2;
   ZCoef_pXo.a[N+2] = pa3;
   ZCoef_pXo.b[0]   = 1.0;
   ZCoef_pXo.b[1]   = -2.0;
   ZCoef_pXo.b[2]   = 1.0;
  // -------------------------
}

void TDST1::Run(TFloat Value)
{
        y[2] = y[1];  y[1] = y[0];
        py[2] = py[1];  py[1] = py[0];
        for (int k = N+2; k >= 1; k--) x[k] = x[k-1];


        x[0] = Value;
        y[0] = 2* y[1] -  y[2] +  a0*x[0] +  a1*x[1] +  a2*x[N+1] +  a3*x[N+2];
       py[0] = 2*py[1] - py[2] + pa0*x[0] + pa1*x[1] + pa2*x[N+1] + pa3*x[N+2];

//       if 
}



void TDST3::Init(TFloat aT0)
{
   if (x != NULL) free (x); x = NULL;
   if (a != NULL) free (a); a = NULL;

   x = (TFloat*) calloc ((N+3+1), sizeof(TFloat));
   a = (TFloat*) calloc ((N+3+1), sizeof(TFloat));

   y[0] = 0;  y[1] = 0;  y[2] = 0; y[3] = 0;

   TFloat Sigma0 =  3  * ((N-1)*(N-2) + Gamma*(8*N - 6 + 10*Gamma)) / ((N+1)*(N+2)*(N+3));

   TFloat Sigma1 = -6  * (N*(N-1)*(4*N-3) + Gamma*(28*N*N - 4*N + 6 + 30*N*Gamma)) / (N*(N-1)*(N+1)*(N+2)*(N+3));

   TFloat Sigma2 =  30 * (N*(N-1) + 6*Gamma*(N + Gamma)) / (N*(N-1)*(N+1)*(N+2)*(N+3));

   a[0]   =  Sigma0 + Sigma1*N + Sigma2*N*N;
   a[1]   = -2*Sigma0 - Sigma1*(2*N+1) - Sigma2*(2*N*N + 2*N - 1);
   a[2]   =  Sigma0 + Sigma1*(N+1)+ Sigma2*(N+1)*(N+1);
   a[N+1] =  - Sigma0 + Sigma1 - Sigma2;
   a[N+2] =  2*Sigma0 - Sigma1 - Sigma2;
   a[N+3] =  - Sigma0;

   b[0] =  1;
   b[1] = -3;
   b[2] =  3;
   b[3] = -1;
}

void TDST3::Run(TFloat Value)
{
      y[3] = y[2];  y[2] = y[1];  y[1] = y[0];
      for (int k = N+3; k >= 1; k--) x[k] = x[k-1];

      x[0] = Value;
      y[0] = 3*y[1] - 3*y[2] + y[3] + a[0]*x[0] + a[1]*x[1] + a[2]*x[2] + a[N+1]*x[N+1] + a[N+2]*x[N+2] + a[N+3]*x[N+3];
}


void TDST4::Init(TFloat aT0)
{
   if (x != NULL) free (x); x = NULL;
   if (a != NULL) free (a); a = NULL;

   x = (TFloat*) calloc ((N+3+1), sizeof(TFloat));
   a = (TFloat*) calloc ((N+3+1), sizeof(TFloat));

   y[0] = 0;  y[1] = 0;  y[2] = 0; y[3] = 0;

   a[0]   =  30 / (aT0*aT0*(N+1)*(N+2)*(N+3));
   a[1]   = -60 / (aT0*aT0*N*(N+1)*(N+2));
   a[2]   =  30 / (aT0*aT0*N*(N-1)*(N+1));
   a[N+1] = -a[2];
   a[N+2] = -a[1];
   a[N+3] = -a[0];

   b[0] =  1;
   b[1] = -3;
   b[2] =  3;
   b[3] = -1;
}

void TDST4::Run(TFloat Value)
{
      y[3] = y[2];  y[2] = y[1];  y[1] = y[0];
      for (int k = N+3; k >= 1; k--) x[k] = x[k-1];

      x[0] = Value;
      y[0] = 3*y[1] - 3*y[2] + y[3] + a[0]*x[0] + a[1]*x[1] + a[2]*x[2] + a[N+1]*x[N+1] + a[N+2]*x[N+2] + a[N+3]*x[N+3];
}

void TDST5::Init(TFloat aT0)
{
   if (x != NULL) free (x); x = NULL;
   if (a != NULL) free (a); a = NULL;

   fT0 = aT0;

   x = (TFloat*) calloc ((N+3+1), sizeof(TFloat));
   a = (TFloat*) calloc ((N+3+1), sizeof(TFloat));

   y[0] = 0;  y[1] = 0;  y[2] = 0; y[3] = 0;

/*   a[0]   =  -6*(4*N - 3) / (aT0*(N+1)*(N+2)*(N+3));
   a[1]   =  12*(4*N - 1) / (aT0*N*(N+1)*(N+2));
   a[2]   =  -6*(4*N + 1) / (aT0*N*(N-1)*(N+1));
   a[N+1] =   6*(6*N - 1) / (aT0*N*(N-1)*(N+1));
   a[N+2] = -12*(6*N + 1) / (aT0*N*(N+1)*(N+2));
   a[N+3] =  18*(2*N + 1) / (aT0*(N+1)*(N+2)*(N+3));

   b[0] =  1;
   b[1] = -3;
   b[2] =  3;
   b[3] = -1;
*/
   a[0]   =  1 / (TFloat) (N + 1);
   a[1]   =  0;
   a[2]   =  0;
   a[N+1] = -1 / (TFloat) (N + 1);
   a[N+2] =  0;
   a[N+3] =  0;

   b[0] =  1;
   b[1] = -1;
   b[2] =  0;
   b[3] =  0;


}

void TDST5::Run(TFloat Value)
{
      y[3] = y[2];  y[2] = y[1];  y[1] = y[0];
      for (int k = N+3; k >= 1; k--) x[k] = x[k-1];

      TFloat Diff_C0 = (Value - Value_) / fT0;
      x[0] = Diff_C0;

      y[0] = y[1] + a[0]*x[0] + a[N+1] * x[N+1];


      Value_ = Value;
/*      ;
      x[0]
*/

//      y[0] = 3*y[1] - 3*y[2] + y[3] + a[0]*x[0] + a[1]*x[1] + a[2]*x[2] + a[N+1]*x[N+1] + a[N+2]*x[N+2] + a[N+3]*x[N+3];
}

