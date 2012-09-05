//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmFiltration.h"

void CBandPassFiltration::Init(float CenterFreq, float DeltaW, float t0)
{
/*
  // ----- Высокочастотный Цисаржа ----------
  Alfa := sqr(tan(W0*t0/2*2*pi));

  A := sqrt(Alfa / (Hmax*Hmax - 0.5));
  B := HMax*HMax*A*A;

  CoefCh[0] := 1+A;             CoefZn[0] := 1+A+B;
  CoefCh[1] := -2;              CoefZn[1] := -2*(1-B);
  CoefCh[2] := 1-A;             CoefZn[2] := 1-A+B;
*/

    float   filter_arg, filter_A, filter_B;

	filter_arg = DeltaW * TWO_PI * t0 * (float)0.5;
	filter_A   = sin(filter_arg) / cos(filter_arg);
	filter_B   = (float)2.0 * cos(CenterFreq * TWO_PI * t0 );

    f[0] = (float)0.0;  // ----- BlockOut

    f[1] =  (float)1.0 / (float)( 1.0 + filter_A ); // ---- invert value -----

    f[2] =  filter_A * f[1];                   // a0, a1 = 0.0
    f[3] = -filter_A * f[1];                   // a2
    f[4] = -filter_B * f[1];                   // b1, b0 = 1.0
    f[5] =  ((float)1.0 - filter_A) * f[1];    // b2

    f[6] =  (float)0.0;                        // x[1]
    f[7] =  (float)0.0;                        // x[2]
    f[8] =  (float)0.0;                        // y[1]
	f[9] =  (float)0.0;                        // y[2]
}

float CBandPassFiltration::Run( float in )
{
//	// ----- Результат выполнения фильтра в BlockOut
//	f->BlockOut = f->a[0]*(inValue - f->x[2]) - f->b[1]*f->y[1] - f->b[2]*f->y[2];
//
//	// ----- Сдиговый буфер -----
//	f->x[2] = f->x[1];
//	f->x[1] = inValue;
//	f->y[2] = f->y[1];
//	f->y[1] = f->BlockOut;

	f[0] = f[2]*( in - f[7]) - f[4]*f[8] - f[5]*f[9];
	f[7] = f[6];
	f[6] = in;

	f[9] = f[8];
	f[8] = f[0];

	return f[0];
}

void CLowPassFiltration::Init(float Freq, float t0)
{
    float  period_T, period_T2, period_D, period_a0,  period_b1;

    period_T2 = (float)2.0 / (TWO_PI * Freq);
    period_D  = period_T2 + t0;
    period_a0 =  t0 / period_D;
    period_b1 = (t0 - period_T2) / period_D;


    f[0] = (float)0.0;

    f[1] = period_a0;   // a[0]
    f[2] = (float)1.0;  // b[0]
    f[3] = period_b1;   // b[1]

	f[4] = 0.0;     // x[1]
    f[5] = 0.0;     // y[1]
}

float CLowPassFiltration::Run( float in )
{
    f[0] = f[1]*(in + f[4]) - f[3]*f[5];
    f[4] = in;          //x
	f[5] = f[0];        //y

	return f[0];
}


