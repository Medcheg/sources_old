//---------------------------------------------------------------------------
#include "pmRMNK.h"
#include "pmTypes.h"
#include "math.h"
#include "windows.h"

//---------------------------------------------------------------------------
CRMNK *rmnk;

void CRMNK::Init( float AlgoFreq, float GyroFreq, float mju )
{
    PhaseIncriment = TWO_PI * GyroFreq / AlgoFreq;

    phi      = 0;
    base_sin = 0;
    base_cos = 0;

    Qx[0] = (float)0.0;
    Qx[1] = (float)0.0;
    Qx[2] = (float)0.0;

    // ------ «начени€ MjuX могут мен€тьс€ (это скорость сходимости) -----
    MjuX[0] = mju;
    MjuX[1] = mju;
    MjuX[2] = mju;
}

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

float CFilter::Run( float in )
{
    // ---- “ак как в числителе коефициенты семетричны, тогда собираю подобные -------
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

