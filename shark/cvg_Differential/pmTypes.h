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

#define SLIDER_BUFFERS_LENGTH   128
#define MAXIMUM_UART_DATA       24

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
} TPhaseDetector;


//////////////////////////////////////////////////////
typedef struct tag_SetupDifferentFreq
{
    float   CurTime;
    float   TimePos0;
    float   TimePos1;
    float   TimePos2;


    float   GyroOutSum;
    float   GyroOutMean[2];
    float   ZnCoefs[2];
    TPiReg  pi_reg;  
}TSetupDifferentFreq;

//////////////////////////////////////////////////////
typedef struct tag_InputMean
{
    Sint16  PeriodCount;
    Sint16  PeriodCounter;
    Sint32  NCounter;

    float   Old_InputVal;
    float   CurSumm;
    float   SliderBuffer[5];
    float   SliderBuffer_invertCount;
    float   BlockOut;
}TInputMean;


//////////////////////////////////////////////////////
typedef struct tag_Gyro
{
    // ------ Temporary Variables -----
    Sint32  AlgoCounter;
    Sint16  isAlgoCounter;
    Sint8   isFlag3;
    Sint8   isInited;
    Sint8   TempParam;
    float   Exc_X_value;
    float   Exc_Y_value;
    // ------
    float    Temperature;
    float    NULL_value;

    // ------ Входные параметры ---
    float    DefaultPeriod;
    float    DefaultPeriod_invert;
    float    DefaultSystemPhaseX;
    float    DefaultSystemPhaseY;
    float    SignOmega;
    Sint32  DebugTime;
    Sint16  DebugMode;

    // -----------------
    TZn     Zn_df_x;
    TZn     Zn_df_y;
    TZn     Zn_exc_x;
    TZn     Zn_exc_y;
    float    XBuffer[ SLIDER_BUFFERS_LENGTH ];
    float    YBuffer[ SLIDER_BUFFERS_LENGTH ];

    // -----------------
    TPeriodDetector PeriodD; // ----- Периодныый детектор ----
    TPhaseDetector  PhaseD;  // ----- Фазовый детектор ----
    TPhaseDetector  SystemPhaseX;  // ----- Фазовый детектор ----
    TPhaseDetector  SystemPhaseY;  // ----- Фазовый детектор ----

    // -----------------
    TInputMean  XInputMean;
    TInputMean  YInputMean;
	TZForm      fi_input_x;
	TZForm      fi_input_y;
	TZForm      fi_demod_x;
	TZForm      fi_demod_y;

    // -----------------
    TPiReg  pi_ampl_x1, pi_ampl_x2;
    TPiReg  pi_ampl_y1, pi_ampl_y2;
    TPiReg  pi_xy1, pi_xy2;

    // --- Результаты моделирования ---
    float    in_Ux_Amplitude;
    float    in_Uy_Amplitude;

    // --- Входы выходы системы ---
    float    in_Ux;
    float    in_Uy;
    float    out_Ux;
    float    out_Uy;
	float    GyroOut;
    float    Quadrature;

    // --- Uart ---
    float     UART_Summation[ MAXIMUM_UART_DATA ];
    float    *UART_Param    [ MAXIMUM_UART_DATA ];
    float    *pUARTfloats;
    Sint32    UART_ParamCount;
    Sint32    UART_SummationPoint;
    Sint32    UART_SummationCount;
    float     UART_SummationCount_invert;
    Sint8   isUART_DataPresent;

    // --- SetupAlgo ---
    TSetupDifferentFreq SetupDF;
}TGyro;

extern TGyro Gyro;
#endif

