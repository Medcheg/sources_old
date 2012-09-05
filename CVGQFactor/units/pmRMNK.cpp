//===========================================================================
#include "pmRMNK.h"
#include "pmTypes.h"
#include "math.h"
#include "windows.h"

//===========================================================================
CRMNK *rmnk;

//===========================================================================
CRMNK::CRMNK()
{
        pi_reg = new CpiReg();
}

//===========================================================================
CRMNK::~CRMNK()
{
        delete pi_reg;
}

//===========================================================================
void CRMNK::Init( float GyroFreq, float mju, float ft0 )
{
    t0 = ft0;
    fGyroFreq = GyroFreq;
    PhaseIncriment = base_PahseIncriment = TWO_PI * GyroFreq * t0;

    phi      = 0;
    base_sin = 0;
    base_cos = 0;

    Qx[0] = (float)0.0;
    Qx[1] = (float)0.0;
    Qx[2] = (float)0.0;

    // ------ Значения MjuX могут меняться (это скорость сходимости) -----
    MjuX[0] = mju;
    MjuX[1] = mju;
    MjuX[2] = mju;

    pi_reg->Init( 0.0, 15, 10, t0 );
}

//===========================================================================
void CRMNK::Run( float in )
{
    float HQx;

    phi = phi + PhaseIncriment;
    phi = MOD_2PI(phi);

    base_sin  = sin( phi );
    base_cos  = cos( phi );

    HQx   = Qx[0] + base_sin*Qx[1] + base_cos*Qx[2] - in;

    Qx[0] = Qx[0] - MjuX[0] * HQx;
    Qx[1] = Qx[1] - MjuX[1] * base_sin * HQx;
    Qx[2] = Qx[2] - MjuX[2] * base_cos * HQx;

    Ampl = sqrt(Qx[1]*Qx[1] + Qx[2]*Qx[2]);
}

//===========================================================================
void CRMNK::Run_pireg( float in )
{
    float HQx;

/*
    float  HQx;
    float  xa2, xb2;
    float  k = 10000.0;

    // ----- 5.0 * TWO_PI * DISCRET_TIME = (float)0.0006283185307179586476925286766559

    prmnk->XPhaseIncriment = prmnk->delta_phi + (float)0.2 * TWO_PI_DISCRET_TIME * prmnk->pi_pll_x2[0] + prmnk->c4;
    prmnk->XFrequency      = prmnk->XPhaseIncriment *  TWO_PI_INVERT_ALGO_FREQUENCY;
    prmnk->x_NTakts        = TWO_PI / prmnk->XPhaseIncriment;
    prmnk->x_phi           = prmnk->x_phi + prmnk->XPhaseIncriment;
*/

    PhaseIncriment      = base_PahseIncriment + (float)0.2 * t0 * pi_reg->f[0];
    CalculatedFrequency = PhaseIncriment  / ( TWO_PI * t0 );

    phi = phi + PhaseIncriment;
    phi = MOD_2PI(phi);

    base_sin  = sin( phi );
    base_cos  = cos( phi );

    HQx   = Qx[0] + base_sin*Qx[1] + base_cos*Qx[2] - in;

    Qx[0] = Qx[0] - MjuX[0] * HQx;
    Qx[1] = Qx[1] - MjuX[1] * base_sin * HQx;
    Qx[2] = Qx[2] - MjuX[2] * base_cos * HQx;

// ------ Регулирование отфильтрованного параметра prmnk->Qx[2] -------
//        Run_PiReg_new( prmnk->pi_pll_x1,  prmnk->fi_Xb[0]     );
//        Run_PiReg_new( prmnk->pi_pll_x2, -prmnk->pi_pll_x1[0] );

    pi_reg->Run(Qx[2]);

//    Ampl = sqrt( Qx[1]*Qx[1] + Qx[2]*Qx[2] );
      Ampl = Qx[1];
}

//===========================================================================
CFilter::CFilter(float Freq, float InitVal, float t0 )
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

//===========================================================================
float CFilter::Run( float in )
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

    return f[0];
}

//===========================================================================
void CpiReg::Init( float InitVal, float Kp, float Ki, float t0)
{

    //f[0] - Выход блока = "0"
    //f[1] - Kp          = "KFF.h"
    //f[2] - Ki          = "KFF.h"
    //f[3] - m_const     = "BaseVal"
    //f[4] - a[0]        = "Ki * (float)0.5 * t0;"

    //f[5] - x[0]        = "0"
    //f[6] - x[1]        = "BaseVal"
    //f[7] - y[0]        = "0"
    //f[8] - y[1]        = "BaseVal"

    f[0] = (float)0.0;
    f[1] = Kp;
    f[2] = Ki;
    f[3] = InitVal;
    f[4] = Ki * (float)0.5 * t0;

    f[5] = (float)0.0;
    f[6] = InitVal;
    f[7] = (float)0.0;
    f[8] = InitVal;
}

//===========================================================================
float CpiReg::Run( float in )
{
    // ---- Так как в числителе коефициенты семетричны, тогда собираю подобные -------
    //f->y[0] = f->a[0]*in + f->a[1]*f->x[1] - f->b[1]* f->y[1];
    // ---------
    //f->x[1] = in;
    //f->y[1] = f->y[0];
    //f->BlockOut = f->y[0];

    f[5] = in - f[3];
    f[7] = f[4]*(f[5] + f[6]) + f[8];
    f[6] = f[5];
    f[8] = f[7];
    f[0] = f[7] + f[5]*f[1];

    return f[0];
}

//===========================================================================
CAmplMean::CAmplMean()
{
    isSlideBufferInited = false;
    isFindMax = true;
    isMaxInited = false;
    isMinInited = false;
    SlidePosition = 0;
    memset(SlideBuffer, 0, sizeof(SlideBuffer));
    BytesToMove = sizeof(SlideBuffer) - sizeof(SlideBuffer[0]);

    fMaxValue = 0;
    fMinValue = 0;
}

//===========================================================================
void CAmplMean::Put(float inValue)
{
    int pos = 12;

    SlidePosition++;
    if ( SlidePosition >= pos )
        isSlideBufferInited = true;

    // -----
    memmove(&SlideBuffer[1], &SlideBuffer[0], BytesToMove );
    SlideBuffer[0] = inValue;

    // -----
    if ( isSlideBufferInited == true  )
    {
        if (  isFindMax && SlideBuffer[pos] > SlideBuffer[0] ) {
            isFindMax = false;
            isMaxInited = true;
            fMaxValue = SlideBuffer[pos];
        }
        if ( !isFindMax && SlideBuffer[pos] < SlideBuffer[0] ) {
            isFindMax = true;
            isMinInited = true;
            fMinValue = SlideBuffer[pos];
        }
    }
}

float __fastcall CAmplMean::GetPeakPeak()
{
    if ( isMinInited == false || isMaxInited == false ) return -1;

    return 0.5*(fMaxValue - fMinValue);
}

float __fastcall CAmplMean::GetMeanValue()
{
    if ( isMinInited == false || isMaxInited == false ) return -1;
    return 0.5*(fMaxValue + fMinValue);
}

float __fastcall CAmplMean::GetAmplitude()
{
    if ( isMinInited == false || isMaxInited == false ) return -1;
    return GetMeanValue() + GetPeakPeak();
}


CPhaseDetector::CPhaseDetector()
{
    fTacks = 0.0;
    u1_old = 0.0;
    u2_old = 0.0;
    isFound = false;
    isNewValuePresent = false;

    fPhase_rad = 0.0;
    fPhase_deg = 0.0;
}

void CPhaseDetector::Put(float Period, float u1, float u2)
{
     /////////////////
        if ( u1_old < 0 && u1 >= 0 && isFound == 0)
        {
			fTacks = u1 / (u1 - u1_old);
			isFound = 1;
        }

    /////////////////
        if ( u2_old < 0 && u2 >= 0 && isFound == 1  )
        {

            fTacks += u2_old / (u2_old - u2) - (float)1.0;

            fPhase_rad  = (float)TWO_PI * fTacks / Period;
            fPhase_deg  = (float)360.0  * fTacks / Period;

            isFound = 0;
        }

    /////////////////
	  u1_old = u1;
      u2_old = u2;
	  fTacks = fTacks + (float)1.0;
}

float __fastcall CPhaseDetector::GetPhaseDeg()
{
    return fPhase_deg;
}

float __fastcall CPhaseDetector::GetPhaseRad()
{
    return fPhase_rad;
}

