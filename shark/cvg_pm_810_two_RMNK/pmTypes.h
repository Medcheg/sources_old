#ifndef pmTypesH
#define pmTypesH 

typedef          char  Sint8;
typedef unsigned char  Uint8;
typedef          short Sint16;
typedef unsigned short Uint16;
typedef          int   Sint32;
typedef unsigned int   Uint32;
//typedef          float float;

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
	float   param2[ DEBUG_ARRAY_DEPTH ];

	float   curr_param1;
	float   curr_param2;

    float   TempFrequency;

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

/*
//////////////////////////////////////////////////////
typedef struct tag_PiReg
{
   TZForm       Integral;
   Sint8        CalcOrder; // --- Если включена система прореживания ----

   float		m_const;

   float	    Kd, diff;
   float	    Kp;
   float	    Ki;
    // --- Block Out ---
   float	    BlockInput;
   float	    BlockOut;
} TPiReg; // ---------- Описание структуры ПИ - регулятора --------
*/

//////////////////////////////////////////////////////
typedef struct tag_CascadFiltration
{
    double dsumm;
    float  mean_buffer[10];
    float BlockOut;        
} TCascadFiltration;

//////////////////////////////////////////////////////
typedef struct tag_PeriodDetector
{
    float       u_old;
    float       Period;
    float       fTacks;
    Sint8       isNewValuePresent;
/*
    float       Period_invert;
    Sint16      PeriodCountSumm;
    float       PeriodCountSumm_invert;
    Sint16      PeriodCounter;

    float       CurSumm;
    double       dCurSumm;
    Sint16      SummCounter;
    

    float       pll_phase_incriment, pll_phase, exc_phase;
*/
} TPeriodDetector;


//////////////////////////////////////////////////////
typedef struct tag_RMNK
{
    TPeriodDetector ANodePeriod;

    float XFrequency  , XPhaseIncriment;
    float XFrequency_m, XPhaseIncriment_m, delta_phi_m, x_phi_m, x_base_cos_m;
    
    //TPiReg  pi_pll_x1, pi_pll_x2;
    //TPiReg  pi_freq_1, pi_freq_2;
    float  pi_pll_x1[9], pi_pll_x2[9];
    float  pi_freq_1[9], pi_freq_2[9];

    float   fi_Xa[6], fi_Xb[6];
    float   fi_Ya[6], fi_Yb[6];
	//TZForm  fi_demod_ph;

    float Qx2_summ;
    Sint32 Qx2_counter;

    float Qx[3], MjuX[3];
    float Qy[3], MjuY[3];

    float YAmpl, x_phi, delta_phi, x_base_sin, x_base_cos;

    //float YAmpl, XAmpl, x_phi_m, delta_phi, x_base_sin, x_base_cos, PhaseAB;

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
typedef struct tag_PhaseDetector
{
    float       fTacks;
    float       u1_old, u2_old;
    Sint8       isFound;
    Sint8       isNewValuePresent;

    float       Phase_rad;
    float       Phase_deg;
} TPhaseDetector;


//////////////////////////////////////////////////////
typedef struct tag_Gyro
{
    // ------ Temporary Variables -----
    float           NULL_value;
    float           c1, c2, c3, c5, c6, c10, c11;
    TPhaseDetector  Phase;
    float           excitation_ampl;


    // ------ Counters --------
    Sint32  AlgoCounter;
    Sint16  isAlgoCounter;

    // -----------
    float   Base_ExcitationPhaseAG;
    float   Base_ExcitationPhase;
    float   Base_CompensationPhase;
    float   Base_PhiQPhase;
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

    Sint8    isXPhase_corr; 
    Sint8    isYPhase_corr; 

    Sint8    isPhiQ_corr;

    Sint8    isAlfaE_f_corr;
    Sint8    isAlfaQ_f_corr;
    Sint8    isAlfaE_t_corr;
    Sint8    isAlfaQ_t_corr;
    Sint8    isStatic1_corr;
    Sint8    isStatic2_corr;
    Sint8    isDynamic_1_corr;
    Sint8    isDynamic_2_corr;

    Sint8    CorrectionOrderCalc;
    // -----------------
    TZn     Zn_exc;
    float   K_PhaseScan;
    float   XBuffer    [ SLIDER_BUFFERS_LENGTH ];
    float   cos_exc, sin_comp, cos_comp;
    
    // -----------------

    float       KXPhase;

	float      fi_input_x[11];
	float      fi_input_y[11];

	TZForm      fi_demod_c;
	TZForm      fi_demod_q;

    // ------ Regulators
    float pi_ampl_1[9], pi_ampl_2[9];
    float pi_corr_1[9], pi_corr_2[9];
    float pi_quad_1[9], pi_quad_2[9];
    //TPiReg pi_om;
/*
    TPiReg  pi_am_1, pi_am_2;
    TPiReg  pi_om_1, pi_om_2;
    TPiReg  pi_si_1, pi_si_2;
    TPiReg  pi_fi_q1, pi_fi_q2;
*/
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
    float   GyroOut_MK2;

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
    Sint32    UART_SummationPoint_OMEGA;
    Sint32    UART_SummationCount;
    Sint32    UART_SummationCount_OMEGA;
    float     UART_SummationCount_invert;
    float     UART_SummationCount_OMEGA_invert;

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

    // ----- New PHapch ------
    float DebugCounter;
    float DebugCoef;

    float tPhase;
}TGyro;

extern TGyro Gyro;
extern TDebug Debug;
#endif

