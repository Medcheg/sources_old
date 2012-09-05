#include "pmInit.h"
#include "KFF.h"

#include "math.h"
#include <string.h>   // ---- Юнит нужен для функции MemSet ----
#include <stdlib.h>   // ---- Юнит нужен для функции MemSet ----

// ==========================================================
void Init_ZForm             ( TZForm *pZForm, float b);
void Init_Zn                ( TZn *pzn, float n);
void Init_PiReg             ( TPiReg *pPi, float BaseVal, float Kp, float Ki, float InitValue, float t0);
void Init_BandPassFiltration( TGyro *gyro );
void Init_UART_Param        ( TGyro *gyro );
void Init_PeriodDetector    ( TPeriodDetector *pd, float DefaulPeriod );
void Init_PhaseDetector     ( TPhaseDetector *pd, float DefaulPeriod );
void Init_Debug_Param       ( TGyro *gyro );
void Init_InputMean         ( TInputMean  *im, Sint16 val1, Sint16 val2, Sint32 ValuesPerSecond, float DefaulResult );
void Init_SliderMean        ( TSliderMean *sm, Sint16 BuffersDepth );

// ==========================================================
void Init_Algo( TGyro *gyro, float *apUARTfloats  )
{
    Sint16   iCounter = 0;
    Sint16   iLength;
    TZn     *pZn;
    TPiReg  *pir[20];
    TZForm  *zform[20];

    gyro->pUARTfloats = apUARTfloats;

    // --- Переприсвоение Дефайнов -----
    gyro->DefaultPeriod             = T_base;
    gyro->SignOmega                 = k_omega;
    gyro->DebugTime                 = TIMES;
    gyro->DebugMode                 = DEBUG_MODE;

    gyro->pll.ExcitationPhase   = PHASE_EXC  * DEG_TO_RAD;
    gyro->pll.CompensationPhase = PHASE_COMP * DEG_TO_RAD;
    gyro->pll.Fc_Ts = (float)TWO_PI / (float)T_base;
    gyro->pll.Kc    = (float)0.5   * (float)TWO_PI * (float)DISCRET_TIME;

    // ----------------- Пегуляторы ------
    // ---- BaseVal, 
    // ---- Kp, 
    // ---- Ki, 
    // ---- InitValue, 
    // ---- t0
    Init_PiReg( &gyro->pi_fr_1,    0.0, Kp_f1, Ki_f1, 0.0, 0.002 );//DISCRET_TIME
    //Init_PiReg( &gyro->pi_fr_1,    0.0, Kp_f1, Ki_f1, 0.0, DISCRET_TIME );//
    
    Init_PiReg( &gyro->pi_phase,   0.0, 0.1  ,   60.3, 0.0, DISCRET_TIME );
    Init_PiReg( &gyro->pi_fr_2,    0.0, Kp_f2, Ki_f2, 0.0, DISCRET_TIME );
    Init_PiReg( &gyro->pi_am_1, X_ampl, Kp_x1, Ki_x1, 0.0, DISCRET_TIME );
    Init_PiReg( &gyro->pi_am_2,    0.0, Kp_x2, Ki_x2, 0.0, DISCRET_TIME );
    Init_PiReg( &gyro->pi_om_1,    0.0, Kp_c1, Ki_c1, 0.0, DISCRET_TIME );
    Init_PiReg( &gyro->pi_om_2,    0.0, Kp_c2, Ki_c2, 0.0, DISCRET_TIME );
    Init_PiReg( &gyro->pi_si_1,    0.0, Kp_q1, Ki_q1, 0.0, DISCRET_TIME );
    Init_PiReg( &gyro->pi_si_2,    0.0, Kp_q2, Ki_q2, 0.0, DISCRET_TIME );

    // ----------------- Структуры средних значений ------
    // 1 val = Midle Values persecond
    // 2 val = Slider mean depth buffer
    // 3 val = Values persecond
    Init_InputMean ( &gyro->FreqMean   ,  10, 50, (float)ALGO_FREQUENCY                      , 0.0 );
    Init_InputMean ( &gyro->ANodePeriod, 100, 50, (float)ALGO_FREQUENCY / gyro->DefaultPeriod, gyro->DefaultPeriod );
    Init_InputMean ( &gyro->XPhase     ,  50, 50, (float)ALGO_FREQUENCY / gyro->DefaultPeriod, 0.0 ); 
    Init_InputMean ( &gyro->YPhase     ,  50, 50, (float)ALGO_FREQUENCY / gyro->DefaultPeriod, 0.0 ); 
    Init_InputMean ( &gyro->XInputMean ,  10, 50, (float)ALGO_FREQUENCY / gyro->DefaultPeriod, 0.0 );
    Init_InputMean ( &gyro->YInputMean ,  10, 50, (float)ALGO_FREQUENCY                      , 0.0 );

    // ----------------- Задержки ------
    Init_Zn( &gyro->Zn_exc , N_exc );  
    gyro->Zn_exc.zn_base = N_exc;
//    Init_Zn( &gyro->Zn_sin2, N_comp                       );
//    Init_Zn( &gyro->Zn_cos2, (float)0.25 * T_base + N_comp);
//    Init_Zn( &gyro->Zn_cos1, (float)0.25 * T_base         );

    // -------------------------
    Init_BandPassFiltration( gyro );
    Init_UART_Param        ( gyro );
    Init_Debug_Param       ( gyro );

    //Init_PeriodDetector( &gyro->PeriodD, gyro->DefaultPeriod );
    //Init_PhaseDetector ( &gyro->PhaseD      , gyro->DefaultPeriod );
    //Init_PhaseDetector ( &gyro->SystemPhaseX, gyro->DefaultPeriod );
    //Init_PhaseDetector ( &gyro->SystemPhaseY, gyro->DefaultPeriod );

    // ------- Второстепенные иниты -------
    gyro->AlgoCounter      = 0;
    gyro->isAlgoCounter    = 1;
    gyro->isFlag3          = 0;
    gyro->CurDebugTime     = (float)0.0;

    gyro->DefaultPeriod_invert = (float)1.0 / (float)gyro->DefaultPeriod;
    gyro->Temperature      = (float)0.0;
    gyro->NULL_value       = (float)0.0;
    gyro->in_Ux_Amplitude  = (float)0.0;
    gyro->in_Uy_Amplitude  = (float)0.0;
    gyro->in_Ux            = (float)0.0;
    gyro->in_Uy            = (float)0.0;
    gyro->out_Ux           = (float)0.5;
    gyro->out_Uy           = (float)0.0;

    gyro->IntegMode_Omega    = (float)0.0;
    gyro->IntegMode_Calib    = (float)0.0;
    gyro->IntegMode_Counter1 = 0;
    gyro->IntegMode_Counter2 = 0;
    gyro->IntegMode_IsWork   = 0;


    memset (gyro->XBuffer, 0, sizeof(float) * SLIDER_BUFFERS_LENGTH); 

    // ------ Демодуляторы ------

    Init_ZForm( &gyro->fi_demod_f, 0.0 );
    Init_ZForm( &gyro->fi_demod_a, 0.0 );
    Init_ZForm( &gyro->fi_demod_c, 0.0 );
    Init_ZForm( &gyro->fi_demod_q, 0.0 );

    zform[0] = &gyro->fi_demod_f;
    zform[1] = &gyro->fi_demod_a;
    zform[2] = &gyro->fi_demod_c;
    zform[3] = &gyro->fi_demod_q;

    for ( iCounter = 0; iCounter < 4; iCounter++)
    { 
        // ------ LowPass DS=1 125Hz ----
        zform[iCounter]->a[0] = (float)(2.0 * 1e6 * 4.769517889121183e-007 );
        zform[iCounter]->a[1] = (float)(2.0 * 1e6 * 1.430855366736355e-006 );
        zform[iCounter]->a[2] = (float)(2.0 * 1e6 * 1.430855366736355e-006 );
        zform[iCounter]->a[3] = (float)(2.0 * 1e6 * 4.769517889121183e-007 );

        zform[iCounter]->b[0] = (float)( 1.000000000000000e+000);
        zform[iCounter]->b[1] = (float)(-2.968584396371834e+000);
        zform[iCounter]->b[2] = (float)( 2.937660325278699e+000);
        zform[iCounter]->b[3] = (float)(-9.690721132925537e-001);
	}

    // -----Амлитуда колебаний У ----
    gyro->Y_minVal = (float) 1000.0; 
    gyro->Y_maxVal = (float)-1000.0; 
    gyro->i_yCounter =   0;
    gyro->iy_Count   = 100;
    gyro->YAmplitude =   0;

    // ------ DEBUG ------
    memset ( Debug.param1, 0, sizeof(float) * 1024);  
    memset ( Debug.param2, 0, sizeof(float) * 1024);  
    memset ( Debug.param3, 0, sizeof(float) * 1024); 
    memset ( Debug.param4, 0, sizeof(float) * 1024); 
    Debug.work_count    = 1024;
    Debug.work_counter  = 0;

    Debug.init_count    = 150000;
    Debug.init_counter  = 0;
    Debug.isInited      = 0;
    Debug.isWork        = 1;
    Debug.isSleep       = 0;

    gyro->MiddleFreqError_summ = (float)0.0;
    gyro->FreqError_counter    = 0;
    gyro->FreqError_count      = 100;


    gyro->debugbb = 0;
    gyro->tt      = 0.0;
    gyro->kk      = 0.0;



    gyro->PeriodD. 
}

// ==========================================================
void Init_ZForm(TZForm *pZForm, float InitValue)
{
	pZForm->a[0] = (float)0.0;    pZForm->b[0] = (float)0.0;
	pZForm->a[1] = (float)0.0;    pZForm->b[1] = (float)0.0;
	pZForm->a[2] = (float)0.0;    pZForm->b[2] = (float)0.0;
	pZForm->a[3] = (float)0.0;    pZForm->b[3] = (float)0.0;
	pZForm->a[4] = (float)0.0;    pZForm->b[4] = (float)0.0;

	pZForm->x[0] = InitValue;    pZForm->y[0] = InitValue;
	pZForm->x[1] = InitValue;    pZForm->y[1] = InitValue;
	pZForm->x[2] = InitValue;    pZForm->y[2] = InitValue;
	pZForm->x[3] = InitValue;    pZForm->y[3] = InitValue;
	pZForm->x[4] = InitValue;    pZForm->y[4] = InitValue;

    pZForm->BlockOut = (float)0.0;
    pZForm->OutScale = (float)1.0;
}

// ======================================================================================
void Init_Zn ( TZn *pzn, float n)
{
    pzn->zn_base = n;
    pzn->zn_curr = n;
    pzn->zn_i    = (Sint8)pzn->zn_curr;
    pzn->t1      = pzn->zn_curr - pzn->zn_i;
    pzn->t2      = pzn->t1 * pzn->t1;
    pzn->t3      = pzn->t1 * pzn->t2;
}

// ======================================================================================
void Init_SliderMean( TSliderMean *sm, Sint16 BuffersDepth )
{
    Sint16 i;

    sm->SliderBuffLength       = BuffersDepth;
    sm->SliderBuffPosition     = 0;
    sm->SliderBuffPosition_old = 0;
    sm->isSliderBufferInited   = 0;

    sm->SliderBuffLength_invert = (float)1.0 / (float)BuffersDepth;

    sm->SliderBuffer            = (float*) malloc( sizeof(float) * BuffersDepth );
    sm->SliderBuffer_invertSumm = (float*) malloc( sizeof(float) * BuffersDepth );
    sm->SliderBufferSumm        = (float)0.0;

    for ( i = 1; i <= BuffersDepth; i++) sm->SliderBuffer_invertSumm[i-1] = 1.0 / (float)i;
}

// ======================================================================================
void Init_InputMean ( TInputMean  *im, Sint16 val1, Sint16 val2, Sint32 ValuesPerSecond, float DefaulResult )
{
    im->PeriodCount          = ValuesPerSecond / val1;
    im->PeriodCount_invert   = (float)1.0 / (float)im->PeriodCount;
    im->CurSumm              = (float)0.0;
    im->u_old                = (float)0.0;
    im->u1_old               = (float)0.0;
    im->u2_old               = (float)0.0;
    im->DeltaMean            = DefaulResult;
    im->GlobalMean           = (float)0.0;
    im->fTacks               = (float)0;
    im->PeriodCounter        = 0;
    im->SummCounter          = 0;
    im->isNewValuePresent    = 0;
    im->isFound              = 0;

    Init_SliderMean( &im->sm, val2 );
}

// ======================================================================================
void Init_PiReg(TPiReg *pPi, float BaseVal, float Kp, float Ki, float InitValue, float t0)
{
    Init_ZForm( &pPi->Integral, InitValue);

    pPi->Kp             = (float)Kp;
    pPi->Ki             = (float)Ki;
    pPi->m_const        = (float)BaseVal;

    if ( pPi->m_const == 0 ) 
         pPi->m_const_invert = (float)0.0;
    else pPi->m_const_invert = (float)1.0 / pPi->m_const;
    

    pPi->Integral.a[0] = (float)pPi->Ki * (float)0.5 * t0;
    pPi->Integral.a[1] = (float)pPi->Ki * (float)0.5 * t0;
    pPi->Integral.b[0] = (float) 1.0;
    pPi->Integral.b[1] = (float)-1.0;

    pPi->CalcOrder      = 0;
    pPi->BlockInput     = (float)0.0;
    pPi->BlockOut       = (float)0.0;
    pPi->d_const        = (float)0.0;

}

// ======================================================================================
void Init_BandPassFiltration( TGyro *gyro )
{
    float   filter_DeltaW;
    float   filter_arg;
    float   filter_A;
    float   filter_invertValue;
    float   filter_B;

    // ----------------- Фильтра -----------------
    Init_ZForm( &gyro->fi_input_x , 0.0 );
    Init_ZForm( &gyro->fi_input_x1, 0.0 );
    Init_ZForm( &gyro->fi_input_x2, 0.0 );
    Init_ZForm( &gyro->fi_input_x3, 0.0 );
    Init_ZForm( &gyro->fi_input_y , 0.0 );
    Init_ZForm( &gyro->fi_input_y1, 0.0 );
    Init_ZForm( &gyro->fi_input_y2, 0.0 );
    Init_ZForm( &gyro->fi_input_y3, 0.0 );

    // ---- BandPass Filter Parameters -------
    filter_DeltaW      = 200.0;
    filter_arg    	   = filter_DeltaW * TWO_PI * DISCRET_TIME * (float)0.5;
    filter_A           = sin(filter_arg) / cos(filter_arg);
    filter_invertValue = (float)1.0 /( 1.0 + filter_A );
    filter_B           = (float)2.0 * cos( TWO_PI / gyro->DefaultPeriod );
    //filter_B           = (float)2.0 * cosf(gyro->ResonationFreq * TWO_PI_DISCRET_TIME);

    gyro->fi_input_x.a[0] = (float)  filter_A * filter_invertValue;
    gyro->fi_input_x.a[1] = (float)  0.0;
    gyro->fi_input_x.a[2] = (float) -filter_A * filter_invertValue;

    gyro->fi_input_x.b[0] = (float)   1.0;
    gyro->fi_input_x.b[1] = (float)  -filter_B  * filter_invertValue;
    gyro->fi_input_x.b[2] = (float)(1-filter_A) * filter_invertValue;

    gyro->fi_input_x1.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_x1.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_x1.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_x1.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_x1.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_x1.b[2] = gyro->fi_input_x.b[2];

    gyro->fi_input_x2.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_x2.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_x2.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_x2.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_x2.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_x2.b[2] = gyro->fi_input_x.b[2];

    gyro->fi_input_x3.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_x3.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_x3.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_x3.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_x3.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_x3.b[2] = gyro->fi_input_x.b[2];

    gyro->fi_input_y .a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_y .b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_y .a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_y .b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_y .a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_y .b[2] = gyro->fi_input_x.b[2];

    gyro->fi_input_y1.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_y1.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_y1.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_y1.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_y1.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_y1.b[2] = gyro->fi_input_x.b[2];

    gyro->fi_input_y2.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_y2.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_y2.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_y2.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_y2.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_y2.b[2] = gyro->fi_input_x.b[2];

    gyro->fi_input_y3.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_y3.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_y3.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_y3.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_y3.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_y3.b[2] = gyro->fi_input_x.b[2];
}

// ======================================================================================
void Init_PeriodDetector( TPeriodDetector *pd, float DefaulPeriod )
{
    pd->u_old        = (float)0.0;
    pd->fTacks       = (float)0.0;
    pd->Period       = DefaulPeriod;
    pd->PeriodMiddle = DefaulPeriod;
    pd->PeriodSumm   = (float)0.0;

    pd->Count_PeriodSumm = 5 * 50000 / DefaulPeriod;
    pd->Count_PeriodSumm_invert = (float)1.0 / (float)pd->Count_PeriodSumm;

    pd->Current_PeriodSummPoint = 0;
    pd->isNewPeriodPresent      = 0;
    pd->isTempFlag              = 0;
}

// ======================================================================================
void Init_PhaseDetector( TPhaseDetector *pd, float DefaulPeriod )
{
    pd->u1_old       = (float)0.0;
    pd->u2_old       = (float)0.0;
    pd->fTacks       = (float)0.0;
    pd->fTacks1      = (float)0.0;
    pd->fTacks2      = (float)0.0;
    pd->PhaseError   = (float)0.0;

    pd->Count_PhaseSumm        = 50000 / DefaulPeriod;
    pd->Count_PhaseSumm_invert = (float)1.0 / (float)pd->Count_PhaseSumm;
    pd->Current_PhaseSummPoint = 0;
    pd->PhaseSumm              = (float)0.0;
    pd->BlockOut               = (float)0.0;

    pd->isNewPhasePresent = 0;
    pd->isFound           = 0;

}

 
// ======================================================================================
void Init_Debug_Param( TGyro *gyro )
{
}

// ======================================================================================
void Init_UART_Param( TGyro *gyro )
{
    Sint16 iCounter;

    gyro->UART_ParamCount      = 19;
    gyro->UART_SummationCount  = 500;
    gyro->UART_SummationPoint  = 0;
    gyro->UART_SummationCount_invert = (float)1.0 / (float)gyro->UART_SummationCount; 

    memset( gyro->UART_Summation, 0, sizeof(float) * MAXIMUM_UART_DATA );
    memset( gyro->UART_Param    , 0, sizeof(float) * MAXIMUM_UART_DATA );



    gyro->UART_Param[ 0] = &gyro->GyroOut;                  // --- Выход гироскопа -----  
    gyro->UART_Param[ 1] = &gyro->Temperature;              // --- Температура -----  
    gyro->UART_Param[ 2] = &gyro->Frequency;                // --- Средний период колебаний ---
    gyro->UART_Param[ 3] = &gyro->ANodePeriod.GlobalMean;   // --- Коефициент разночастности ---

    gyro->UART_Param[ 4] = &gyro->pi_am_2.BlockOut;         // --- Квадратура ----
    gyro->UART_Param[ 5] = &gyro->pi_si_2.BlockOut;         // --- Квадратура ----

    gyro->UART_Param[ 6] = &gyro->fi_demod_a.BlockOut;   // 
    gyro->UART_Param[ 7] = &gyro->YAmplitude;   //  Среднее значение Х
    gyro->UART_Param[ 8] = &gyro->XPhaseDegree;   // 

    gyro->UART_Param[ 9] = &gyro->XInputMean.GlobalMean;           // Косинус в Тактах алгоритма 
    gyro->UART_Param[10] = &gyro->YInputMean.GlobalMean;   // 
    
    gyro->UART_Param[11] = &gyro->fi_demod_f.BlockOut;   // 
    gyro->UART_Param[12] = &gyro->fi_demod_c.BlockOut;   //  Среднее значение Х
    gyro->UART_Param[13] = &gyro->tt;//gyro->pi_phase.BlockOut;   // Среднее значение Y

    gyro->UART_Param[14] = &gyro->YPhaseDegree;   // 

    gyro->UART_Param[15] = &gyro->pll.ExcitationPhase;   // Косинус в Тактах алгоритма 
    gyro->UART_Param[16] = &Debug.curr_param1;   // Фаза Х 
    gyro->UART_Param[17] = &Debug.curr_param2;   // Фаза У
    gyro->UART_Param[18] = &Debug.curr_param3;   // Сырой выход гироскопа
}


