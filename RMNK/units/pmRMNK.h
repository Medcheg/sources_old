//---------------------------------------------------------------------------
#ifndef pmRMNKH
#define pmRMNKH
//---------------------------------------------------------------------------
class CRMNK
{
private:
    float PhaseIncriment;

    float MjuX[3];
    float phi, delta_phi;

    float fi_a[6], fi_b[6];
public:
    float Qx[3];
    float Ampl;

    float  base_sin, base_cos;

    void Init( float AlgoFreq, float GyroFreq, float mju );
    void Run( float in );
};

class CFilter
{
private:
public:
    float f[9];
    CFilter(float Freq, float InitVal, float t0 );
    float Run( float in );
};

class CAmplMean
{
private:
    float SlideBuffer[100];
    int   BytesToMove;
    int   SlidePosition;
    bool  isSlideBufferInited;

    bool  isFindMax;

    bool  isMaxInited, isMinInited;
    float fMinValue;
    float fMaxValue;
    float __fastcall GetPeakPeak();
    float __fastcall GetAmplitude();
    float __fastcall GetMeanValue();
public:
    CAmplMean();

    void Put(float inValue);
    __property float PeakPeak = { read = GetPeakPeak };
    __property float Ampl     = { read = GetAmplitude };
    __property float Mean     = { read = GetMeanValue };
};

class CPhaseDetector
{
private:
    float       fTacks;
    float       u1_old, u2_old;
    bool        isFound;
    bool        isNewValuePresent;

    float       fPhase_rad;
    float       fPhase_deg;

    float __fastcall GetPhaseDeg();
    float __fastcall GetPhaseRad();
public:
    CPhaseDetector();

    void Put(float Period, float u1, float u2);
    __property float Phase_deg = { read = GetPhaseDeg };
    __property float Phase_rad = { read = GetPhaseRad };
};

extern CRMNK *rmnk;
//---------------------------------------------------------------------------
#endif
