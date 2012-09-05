#ifndef pmTypesH
#define pmTypesH 

typedef          char  Sint8;
typedef unsigned char  Uint8;
typedef          short Sint16;
typedef unsigned short Uint16;
typedef          int   Sint32;
//typedef          float float;

#define ALGO_FREQUENCY (float) 50000.0
#define DISCRET_TIME   (float) 0.00002

#define TWO_PI        (float) 6.283185307179586476925286766559000
#define ONE_PI        (float) 3.141592653589793238462643383279500
#define PI_DIV_TWO 	  (float) 1.570796326794896619231321691639800
#define RAD_TO_DEG 	  (float)57.295779513082320876798154814105000
#define DEG_TO_RAD 	  (float) 0.017453292519943295769236907684886
#define TWO_PI_INVERT (float) 0.159154943091895335768883763372510

#define ALFO_FREQ_DIV_2PI  ( ALGO_FREQUENCY / TWO_PI );

#define SLIDER_BUFFERS_LENGTH   128
#define MAXIMUM_UART_DATA       24


//////////////////////////////////////////////////////
typedef struct tag_Debug
{
    // --- Float part ---
	float   param1[ 1024 ];
	float   param2[ 1024 ];
	float   param3[ 1024 ];
	float   param4[ 1024 ];

	float   curr_param1;
	float   curr_param2;
	float   curr_param3;
	float   curr_param4;

    Sint16  work_count;
    Sint16  work_counter;
    Sint8   isWork, isSleep;

    Sint32  init_count;
    Sint32  init_counter;
    Sint32  isInited;
} TDebug;
//////////////////////////////////////////////////////
typedef struct tag_ZForm
{
    // --- Float part ---
	float a[5];
	float b[5];
	float x[5];
	float y[5];

    // --- Block Out ---
	float OutScale;
	float BlockOut;
} TZForm;

//////////////////////////////////////////////////////
typedef struct tag_PiReg
{
   TZForm   Integral;
   Sint8    CalcOrder; // --- Если включена система прореживания ----

   float		m_const;
   float		m_const_invert;
   float		d_const;

   float	    Kp;
   float	    Ki;

    // --- Block Out ---
   float	    BlockInput;
   float	    BlockOut;
} TPiReg; // ---------- Описание структуры ПИ - регулятора --------

//////////////////////////////////////////////////////
typedef struct tag_Zn
{
    float  zn_base;
    float  zn_curr;

    Sint8 zn_i;
    float  t1, t2, t3;
    float  k0, k1, k2, k3;
}TZn;

//////////////////////////////////////////////////////
typedef struct tag_PeriodDetector
{
    float  u_old;
    float  fTacks;

    float  Period;
    Sint8 isNewPeriodPresent;
    Sint8 isTempFlag;

    // ------ Частота -------
    float   PeriodMiddle;
    float   PeriodSumm;

    Sint16  Count_PeriodSumm;
    float   Count_PeriodSumm_invert;

    Sint16  Current_PeriodSummPoint;
} TPeriodDetector;

//////////////////////////////////////////////////////
typedef struct tag_SliderMean
{
    Sint16  SliderBuffLength;
    Sint16  SliderBuffPosition;
    Sint16  SliderBuffPosition_old;
    Sint8   isSliderBufferInited;

    float   SliderBuffLength_invert;

    float   *SliderBuffer;
    float   *SliderBuffer_invertSumm;
    float    SliderBufferSumm;
}TSliderMean;


//////////////////////////////////////////////////////
//typedef struct tag_FrequencyMismatch
typedef struct tag_PhaseDetector
{
    float  u1_old, u2_old;
    float  fTacks, fTacks1, fTacks2;

    Sint8 isNewPhasePresent;
    Sint8 isFound;

    Sint16  Count_PhaseSumm;
    float   Count_PhaseSumm_invert;
    float   PhaseSumm;
    Sint16  Current_PhaseSummPoint;

    float  PhaseError;
    float  BlockOut;

    TSliderMean sm;
} TPhaseDetector;

//////////////////////////////////////////////////////
typedef struct tag_InputMean
{
    TSliderMean sm;

    Sint32      PeriodCount;
    float       PeriodCount_invert;
    Sint32      PeriodCounter;
    float       fTacks;

    float       CurSumm;
    Sint32      SummCounter;
    Sint8       isNewValuePresent;
    Sint8       isFound;

    float       u_old, u1_old, u2_old;

    float       DeltaMean;
    float       GlobalMean;
}TInputMean;


typedef struct tag_PLL
{
	// ---------------
    float	Freq;
    float	Fc_Ts;
    float	Kc;
    float	Fc_Ts_new;
    float	Kc_new;

    float	mod, mod_base;
    float	mod_ExcitationPhase;
    float	mod_CompensationPhase;
    float	mod_SystemPhase;

    float	CompensationPhase;
    float	ExcitationPhase;
    float	DemodPhaseCompesation;

    // ---- Block Out ----
    float	exc;
    float	exc_90;
    float	c1;
    float	s1;
    float	c2;
    float	s2;
}TPLL;

//////////////////////////////////////////////////////
typedef struct tag_Gyro
{
    // ------ Counters --------
    Sint32  AlgoCounter;
    Sint16  isAlgoCounter;
    float   floatDebugCounter;

    // ------ Temporary Variables -----
    Sint8   isFlag3;
    Sint8   TempParam;
    float   XPhaseDegree;
    float   YPhaseDegree;
    float   Frequency;

    // ------
    float    Temperature;
    float    NULL_value;

    // ------ Входные параметры ---
    float    DefaultPeriod;
    float    DefaultPeriod_invert;
    float    SignOmega;

    float    DebugTime;
    float    CurDebugTime;
    Sint16   DebugMode;
    Sint16   DebugCounter;
    TDebug   Debug;


    // -----------------
    TZn     Zn_exc;
    TZn     Zn_cos1;
    TZn     Zn_sin2;
    TZn     Zn_cos2;
    float   XBuffer[ SLIDER_BUFFERS_LENGTH ];

    // -----------------
    //TPeriodDetector PeriodD; // ----- Периодныый детектор ----
    //TPhaseDetector  PhaseD;  // ----- Фазовый детектор ----
    //TPhaseDetector  SystemPhaseX;  // ----- Фазовый детектор ----
    //TPhaseDetector  SystemPhaseY;  // ----- Фазовый детектор ----

    // -----------------
    TInputMean  XInputMean;
    TInputMean  YInputMean;
    TInputMean  ANodePeriod;
    TInputMean  FreqMean;
    TInputMean  XPhase;
    TInputMean  YPhase;

	TZForm      fi_input_x, fi_input_x1, fi_input_x2, fi_input_x3;
	TZForm      fi_input_y, fi_input_y1, fi_input_y2, fi_input_y3;
	TZForm      fi_demod_f;
	TZForm      fi_demod_a;
	TZForm      fi_demod_c;
	TZForm      fi_demod_q;

    TPLL        pll;

    // -----------------
    TPiReg  pi_fr_1, pi_fr_2;
    TPiReg  pi_am_1, pi_am_2;
    TPiReg  pi_om_1, pi_om_2;
    TPiReg  pi_si_1, pi_si_2;
    TPiReg  pi_phase;

    // -----Амлитуда колебаний У ----
    float   Y_minVal, Y_maxVal;
    float   X_minVal, X_maxVal;
    Sint16  i_yCounter, iy_Count;
    float   XAmplitude, XMean;
    float   YAmplitude, YMean;

    // ----- Средня ошибка частота -----
    float   MiddleFreqError_summ;
    Sint16  FreqError_count;
    Sint16  FreqError_counter;

    // --- Результаты моделирования ---
    float    in_Ux_Amplitude;
    float    in_Uy_Amplitude;
    float    GyroOut;
    float    GyroOutRaw;

    // --- Входы выходы системы ---
    float    in_Ux;
    float    in_Uy;
    float    out_Ux;
    float    out_Uy;

    // --- Uart ---
    float     UART_Summation[ MAXIMUM_UART_DATA ];
    float    *UART_Param    [ MAXIMUM_UART_DATA ];
    float    *pUARTfloats;
    Sint32    UART_ParamCount;
    Sint32    UART_SummationPoint;
    Sint32    UART_SummationCount;
    float     UART_SummationCount_invert;
    Sint8   isUART_DataPresent;

    // --- Integrator ---
    float     IntegMode_Omega;
    float     IntegMode_OmegaUart;
    float     IntegMode_Calib;
    Sint32    IntegMode_Counter1;
    Sint32    IntegMode_Counter2;
    Sint32    IntegMode_IsWork;

    // --- DebugAlgo ---
    Sint32    debugbb;
    float     tt, kk;
}TGyro;

extern TGyro Gyro;
extern TDebug Debug;
#endif

