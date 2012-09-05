#include "pmLibrary.h"
#include "math.h"


// *****************************************************************
//
// *****************************************************************
void Init_LowPass_IRFiltr_1rstOrder( float *f,  float Freq, float InitVal, float t0 )
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

    f[4] = InitVal;     // x[1]
    f[5] = InitVal;     // y[1]
}

// **************************************** *************************
//
// *****************************************************************
void Run_LowPass_IRFiltr_1rstOrder( float *f, float in )
{
    // ---- Так как в числителе коефициенты семетричны, тогда собираю подобные -------
    //f->y[0] = f->a[0]*in + f->a[1]*f->x[1] - f->b[1]* f->y[1];
    // ---------
    //f->x[1] = in;		    
    //f->y[1] = f->y[0];
    //f->BlockOut = f->y[0];

    f[0] = f[1]*(in + f[4]) - f[3]*f[5];
    f[4] = in;          //x
    f[5] = f[0];        //y
}


// *****************************************************************
//
// *****************************************************************
void Init_BandPassFiltration_new ( float *f, float CenterFreq, float DeltaW, float t0  )
{
    float   filter_arg, filter_A, filter_B;

    filter_arg = DeltaW * TWO_PI * t0 * (float)0.5;
    filter_A   = sinf(filter_arg) / cosf(filter_arg);
    filter_B   = (float)2.0 * cosf(CenterFreq * TWO_PI * t0 );
/*
    gyro->fi_input_x.a[0] = (float)  filter_A * filter_invertValue;
    gyro->fi_input_x.a[1] = (float)  0.0;
    gyro->fi_input_x.a[2] = (float) -filter_A * filter_invertValue;

    gyro->fi_input_x.b[0] = (float)   1.0;
    gyro->fi_input_x.b[1] = (float)  -filter_B      * filter_invertValue;
    gyro->fi_input_x.b[2] = (float)(1.0 - filter_A) * filter_invertValue;
*/
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

// *****************************************************************
//
// *****************************************************************
void Run_BandPassFiltration_new( float *f, float in )
{
/*
    // ----- Результат выполнения фильтра в BlockOut    
    f->BlockOut = f->a[0]*(inValue - f->x[2]) - f->b[1]*f->y[1] - f->b[2]*f->y[2];

    // ----- Сдиговый буфер -----
	f->x[2] = f->x[1];
	f->x[1] = inValue;
	f->y[2] = f->y[1];
	f->y[1] = f->BlockOut;
*/
    f[0] = f[2]*( in - f[7]) - f[4]*f[8] - f[5]*f[9];
    f[7] = f[6];
    f[6] = in;

    f[9] = f[8];
    f[8] = f[0];
}

// *****************************************************************
//
// *****************************************************************
void Init_PiReg_new( float *pi_reg, float InitVal, float Kp, float Ki, float t0)
{

    //pi_reg[0] - Выход блока = "0"
    //pi_reg[1] - Kp          = "KFF.h"
    //pi_reg[2] - Ki          = "KFF.h"
    //pi_reg[3] - m_const     = "BaseVal"
    //pi_reg[4] - a[0]        = "Ki * (float)0.5 * t0;"

    //pi_reg[5] - x[0]        = "0"
    //pi_reg[6] - x[1]        = "BaseVal"
    //pi_reg[7] - y[0]        = "0"
    //pi_reg[8] - y[1]        = "BaseVal"

    pi_reg[0] = (float)0.0;
    pi_reg[1] = Kp;
    pi_reg[2] = Ki;
    pi_reg[3] = InitVal;
    pi_reg[4] = Ki * (float)0.5 * t0;

    pi_reg[5] = (float)0.0;
    pi_reg[6] = InitVal;
    pi_reg[7] = (float)0.0;
    pi_reg[8] = InitVal;
}


// *****************************************************************
//
// *****************************************************************
void Run_PiReg_new( float *pi_reg, float in )
{
    pi_reg[5] = in - pi_reg[3];
    pi_reg[7] = pi_reg[4]*(pi_reg[5] + pi_reg[6]) + pi_reg[8];
    pi_reg[6] = pi_reg[5];
    pi_reg[8] = pi_reg[7];
    pi_reg[0] = pi_reg[7] + pi_reg[5]*pi_reg[1];
}

