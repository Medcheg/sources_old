#ifndef pmTypesH
#define pmTypesH 

typedef          char  Sint8;
typedef unsigned char  Uint8;
typedef          short Sint16;
typedef unsigned short Uint16;
typedef          int   Sint32;
typedef unsigned int   Uint32;
//typedef          float float;

#define TWO_PI        (float) 6.283185307179586476925286766559000
#define ONE_PI        (float) 3.141592653589793238462643383279500
#define PI_DIV_TWO 	  (float) 1.570796326794896619231321691639800
#define RAD_TO_DEG 	  (float)57.295779513082320876798154814105000
#define DEG_TO_RAD 	  (float) 0.017453292519943295769236907684886
#define TWO_PI_INVERT (float) 0.159154943091895335768883763372510

#define ABS(a)   ((a) >= 0) ? (a) : (-a)

#define ALGO_FREQUENCY               (float) 50000.0
#define ALGO_FREQUENCY_DIV_10        (float) 5000.0
#define ALGO_FREQUENCY_DIV_10_INVERT (float) 0.0002
#define TWO_PI_INVERT_ALGO_FREQUENCY (float) 7957.7471545947667884441881686

#define DISCRET_TIME          (float) 0.00002
#define TWO_PI_DISCRET_TIME   (float) 1.2566370614359172953850573533118e-4

#define SLIDER_BUFFERS_LENGTH      256
#define SLIDER_BUFFERS_LENGTH_M4   124
#define MAXIMUM_UART_DATA       24

#define DEBUG_ARRAY_DEPTH 5000

//////////////////////////////////////////////////////
#define pm_sqr(a) ((a)*(a))
//////////////////////////////////////////////////////

typedef struct tag_Debug
{

    // --- Float part ---
	float   param1[ DEBUG_ARRAY_DEPTH ];
	//float   param2[ DEBUG_ARRAY_DEPTH ];

	float   curr_param1;
	float   curr_param2;

    Sint16  work_count;
    Sint16  work_counter;
    Sint8   isWork, isSleep;

    Sint32  init_count;
    Sint32  init_counter;
    Sint32  isInited;

    Sint32  DataFreq;
    Sint32  Decimation;
    Sint32  Decimation_counter;  

    // **************************
    // **************************
    // **************************
        float    *debug_constant;
        float    *debug_value;
        float     debug_coef;

        float   cos_Amplitude; 

        float   freq_base;
        float   freq_incr;

        Sint32  freq_incr_step;
        Sint32  freq_incr_counter;
        float   freq_incr_value;

        Sint32  freq_pass_counter;
        Sint32  freq_pass_step;

        float   phi_base;
    // **************************
    // **************************
    // **************************
} TDebug;

//////////////////////////////////////////////////////
typedef struct tag_Correction
{
    float f0;
    float a1, a2, a3, a4, a5, a6;
    float b1, b2, b3, b4, b5, b6;
    float c1, c2, c3, c4, c5, c6;

    Sint8 CalcOrder;
    float BlockOutCoef;
    float BlockOut;
}TCorrection;

typedef struct tag_Correction_1
{
    float f0;

    float rph_a0;
    float rph_a1;
    float rph_a2;

    float qph_a0;
    float qph_a1;
    float qph_a2;

    float alfa_q_t0;
    float alfa_q_t1;
    float alfa_q_t2;
    float alfa_q_f0;
    float alfa_q_f1;
    float alfa_q_f2;

    float alfa_e_f0;
    float alfa_e_f1;
    float alfa_e_f2;
    float alfa_e_t0;
    float alfa_e_t1;
    float alfa_e_t2;
}TCorrection_1;

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
typedef struct tag_CascadFiltration
{
    TZForm fi_1; 
    TZForm fi_2; 
    TZForm fi_3;

    Sint32 counter_1, dec_point_1;
    Sint32 counter_2, dec_point_2;
    Sint32 counter_3, dec_point_3;

    double dsumm;
    float  summ;
    float  mean_buffer[10];
    

   
    float BlockOut;        
} TCascadFiltration;

//////////////////////////////////////////////////////
typedef struct tag_PiReg
{
   TZForm       Integral;
   Sint8        CalcOrder; // --- Если включена система прореживания ----

   float		m_const;

   float	    Kp;
   float	    Ki;
    // --- Block Out ---
   float	    BlockInput;
   float	    BlockOut;
} TPiReg; // ---------- Описание структуры ПИ - регулятора --------

//////////////////////////////////////////////////////
typedef struct tag_PeriodDetector
{
    float       u_old;
    float       Period;
    float       fTacks;
/*
    float       Period_invert;
    Sint16      PeriodCountSumm;
    float       PeriodCountSumm_invert;
    Sint16      PeriodCounter;

    float       CurSumm;
    double       dCurSumm;
    Sint16      SummCounter;
    Sint8       isNewValuePresent;
    

    float       pll_phase_incriment, pll_phase, exc_phase;
*/
} TPeriodDetector;


//////////////////////////////////////////////////////
typedef struct tag_RMNK
{
    TPeriodDetector ANodePeriod;

    float XFrequency, XPhaseIncriment;
    
    TPiReg  pi_pll_x1, pi_pll_x2;
	TZForm  fi_Xa, fi_Xb;

    float Qx[3], MjuX[3];

    float YAmpl, XAmpl, x_phi, delta_phi, x_base_sin, x_base_cos;

    float c4, c11;


    // ------- dddddddddddd-------
    Sint32  Counter;
    float   Summ;
    float   val;
}TRMNK;



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

    Sint16      PeriodCount;
    float       PeriodCount_invert;
    Sint16      PeriodCounter;
    float       fTacks;

    float       CurSumm;
    Sint16      SummCounter;
    Sint8       isNewValuePresent;
    Sint8       isFound;

    float       u_old, u1_old, u2_old;

    float       DeltaMean;
    float       GlobalMean;
    float       Phase_rad;
    float       Phase_deg;
} TInputMean;


//////////////////////////////////////////////////////
typedef struct tag_Gyro
{
    // ------ Temporary Variables -----
    float    NULL_value;
    float    filter_invertValue_x;
    float    filter_invertValue_y;
    float    c1, c2, c3, c5, c6, c10;
    TInputMean  Phase;
    float    excitation_ampl;


    // ------ Counters --------
    Sint32  AlgoCounter;
    Sint16  isAlgoCounter;
    Sint32  FilterCorrectionCounter;
    Sint8   tempcounter;

    // -----------
    float   Base_ExcitationPhaseAG;
    float   Base_ExcitationPhase;
    float   Base_CompensationPhase;
    float   ExcitationPhaseAG;
    float   ExcitationPhase;
    float   CompensationPhase;//, CompensationPhase;
    //float   CompPhase2Scan;
    float   Temperature;
    float   PhiQPhase;
    Sint32  StartUpTime;

    // ------ Входные параметры ---
    float    DefaultFrequency;
    float    DefaultPeriod;
    float    k_Omega;
    float    InitialSPh;

    float    isCompensationPresent;

    Sint8    isXPhase_corr; 
    Sint8    isYPhase_corr; 

    Sint8    isPhiQ_corr;

    Sint8    isAlfaE_f_corr;
    Sint8    isAlfaQ_f_corr;
    Sint8    isAlfaE_t_corr;
    Sint8    isAlfaQ_t_corr;
    Sint8    isStatic1_corr;
    Sint8    isStatic2_corr;
    Sint8    isDynamic_corr;

    Sint8    CorrectionOrderCalc;
    // -----------------
    TZn     Zn_exc;
    float   K_PhaseScan;
    float   XBuffer    [ SLIDER_BUFFERS_LENGTH ];
    float   cos_exc, sin_comp, cos_comp;
    
    // -----------------

    float       KXPhase;

	TZForm      fi_input_x;// fi_input_x1, fi_input_x2, fi_input_x3;
	TZForm      fi_input_y;//, fi_input_y1, fi_input_y2, fi_input_y3;
	TZForm      fi_demod_c;
	TZForm      fi_demod_q;

    // -----------------
    TPiReg  pi_am_1, pi_am_2;
    TPiReg  pi_om_1, pi_om_2;
    TPiReg  pi_si_1, pi_si_2;
    TPiReg  pi_fi_q1, pi_fi_q2;

    // ----- RMNK ------
    TRMNK   rmnk;

    // --- Результаты моделирования ---
    float   GyroOutRaw;
    float   GyroOutSt1;
    float   GyroOut_corr;

    float   GyroOut_alfa_e;
    float   GyroOut_alfa_q;
    float   Excitation_alfa_e;
    float   Quadrature_alfa_q;

    float   GyroOut_corr_st1;
    float   GyroOut_corr_st1_a;
    float   GyroOut_corr_st1_b;
    float   GyroOut_corr_st1_c;
    
    float   GyroOut_corr_st2;
    float   GyroOut_corr_st2_a;
    float   GyroOut_corr_st2_b;
    float   GyroOut_corr_st2_c;

    float   GyroOut_MK1;


    float   corr_cos_alfa_e;
    float   corr_sin_alfa_e;
    float   corr_cos_alfa_q;
    float   corr_sin_alfa_q;

    float   Frequency;

    // --- Входы выходы системы ---
    float    in_Ux;
    float    in_Uy;

    float    out_Ux;
    float    out_Uy;

    // -----
    //TCorrection_1 Correction;

    // --- Uart ---
    float     UART_Summation      [ MAXIMUM_UART_DATA ];
    float    *UART_Param          [ MAXIMUM_UART_DATA ];
    float     UART_Coefs          [ MAXIMUM_UART_DATA ];
    Sint8     UART_isNeedSummation[ MAXIMUM_UART_DATA ];
    float    *pUARTfloats;
    Sint32    UART_ParamCount;
    Sint32    UART_SummationPoint;
    Sint32    UART_SummationCount;
    float     UART_SummationCount_invert;
    Sint8   isUART_DataPresent;

    // -----Амлитуда колебаний У ----
    Sint16    Y_CountSumValues;
    Sint16    Y_CountSumCounter;
    float     Y_CountSumValues_invert;
    float     Y_minVal, Y_maxVal;

    // --- Debug MM ---
    float    DebugTime;
    float    CurDebugTime;
    Sint16   DebugMode;
    Sint16   YAmpl_Counter;

    // ---- 
    TCascadFiltration cf_Freq;
    TCascadFiltration cf_Quad;
    TCascadFiltration cf_Temp;
    TCascadFiltration cf_Exci;

    // ---- Correction ------
    float f1, f2, f3, f4, f5, f6;
    float e1, e2, e3, e4, e5, e6;
    float q1, q2, q3, q4, q5, q6;
    float t1, t2, t3, t4, t5, t6;
    // ---- Sum Main Param
    Sint32 MainSum_counter;
    Sint8  MainSumInit_counter;
    Sint8  isMainSumInited;

    // ----- New PHapch ------
    float kfreq;        
        
}TGyro;

extern TGyro Gyro;
extern TDebug Debug;
#endif

