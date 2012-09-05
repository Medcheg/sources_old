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
void Init_PhaseDetector     ( TPhaseDetector *pd, float DefaultGyroFreq );
void Init_InputMean         ( TInputMean  *im, Sint16 val1, Sint16 val2, Sint32 ValuesPerSecond, float DefaulResult );
void Init_InputMean_n       ( TInputMean  *im, Sint16 val1, Sint32 ValuesPerSecond, float DefaulResult );
void Init_PeriodDetector    ( TPeriodDetector *pd, float val1, float DefaultPeriod );
void Init_SliderMean        ( TSliderMean *sm, Sint16 BuffersDepth );
void Init_DebugParam        ( TGyro *gyro );
void Init_RMNK              ( TRMNK *prmnk, float DefaultPeriod, float xValue ) ;

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
    gyro->DefaultFrequency         = (float)Base_Frequency;
    gyro->DefaultPeriod            = (float)ALGO_FREQUENCY / gyro->DefaultFrequency;
    gyro->Frequency                = gyro->DefaultFrequency;
    gyro->SinPeriod                = gyro->DefaultPeriod;
    gyro->SinPeriod_invert         = (float)1.0 / gyro->DefaultPeriod;
    gyro->pll_phase                = TWO_PI / gyro->DefaultPeriod;
    gyro->SignOmega                = k_omega;
    gyro->DebugTime                = TIMES;
    gyro->DebugMode                = DEBUG_MODE;
    gyro->isCompensationPresent    = (float)COMPESATION;

    gyro->ExcitationPhase   = (float)X_Phase_algo;
    gyro->CompensationPhase = (float)Y_Phase_algo;

    // ----------------- Пегуляторы ------
    Init_PiReg( &gyro->pi_am_1 , X_ampl, Kp_x1, Ki_x1,  X_ampl, (float)DISCRET_TIME );  
    Init_PiReg( &gyro->pi_am_2 ,    0.0, Kp_x2, Ki_x2,  0.0   , (float)DISCRET_TIME );
    Init_PiReg( &gyro->pi_om_1 ,    0.0, Kp_c1, Ki_c1,  0.0   , (float)DISCRET_TIME );
    Init_PiReg( &gyro->pi_om_2 ,    0.0, Kp_c2, Ki_c2,  0.0   , (float)DISCRET_TIME );
    Init_PiReg( &gyro->pi_si_1 ,    0.0, Kp_q1, Ki_q1,  0.0   , (float)DISCRET_TIME );
    Init_PiReg( &gyro->pi_si_2 ,    0.0, Kp_q2, Ki_q2,  0.0   , (float)DISCRET_TIME );

    Init_PiReg( &gyro->pi_phase_base,  0.0,   0.5,   1.0,  0.0   , (float)0.01      );
    Init_PiReg( &gyro->pi_XPhase    ,  0.0,   0.1,   1.0,  0.0   , (float)0.01      );

    // ----------------- Структуры средних значений ------
    // 1 val = Values persecond
    // 2 val = Slider mean depth buffer
    Init_InputMean ( &gyro->XInputMean ,  10, 50, gyro->DefaultFrequency, 0.0 );
    Init_InputMean ( &gyro->YInputMean ,  10, 50, gyro->DefaultFrequency, 0.0 );

    Init_InputMean_n( &gyro->GPhase   , 100, gyro->DefaultFrequency, 0.0 );
    Init_InputMean_n( &gyro->XPhase   , 100, gyro->DefaultFrequency, 0.0 );
    Init_InputMean_n( &gyro->BPFPhase ,  10, gyro->DefaultFrequency, 0.0 );

    Init_PeriodDetector ( &gyro->ANodePeriod, 100.0, gyro->DefaultFrequency );

    Init_SliderMean( &gyro->FilterCoef, 20 );
    Init_SliderMean( &gyro->PhaseSM   , 5  );

    // ----------------- Задержки ------
    Init_Zn( &gyro->Zn_exc, ( gyro->ExcitationPhase * DEG_TO_RAD * gyro->DefaultPeriod * TWO_PI_INVERT + (float)0.25 * gyro->DefaultPeriod) );  

    // -------------------------
    Init_BandPassFiltration( gyro );
    Init_UART_Param        ( gyro );

    // ------- Второстепенные иниты -------
    gyro->AlgoCounter      = 0;
    gyro->isAlgoCounter    = 1;
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
    gyro->in_Kx            = (float)1.0;
    gyro->in_Ky            = (float)1.0;
    gyro->KXPhase          = (float)0.0;
    gyro->KFiltr1          = (float)1.0;
    gyro->KFiltr2          = (float)1.0;
    gyro->K_XPhase         = ( gyro->DebugMode == 7 ) ? (float)0.0 : (float)1.0;

    gyro->IntegMode_Omega    = (float)0.0;
    gyro->IntegMode_Calib    = (float)0.0;
    gyro->IntegMode_Counter1 = 0;
    gyro->IntegMode_Counter2 = 0;
    gyro->IntegMode_IsWork   = 0;


    memset (gyro->XBufferCorr, 0, sizeof(float) * SLIDER_BUFFERS_LENGTH); 
    memset (gyro->XBuffer    , 0, sizeof(float) * SLIDER_BUFFERS_LENGTH); 
    memset (gyro->YBuffer    , 0, sizeof(float) * SLIDER_BUFFERS_LENGTH); 

    // ------ Демодуляторы ------
    Init_ZForm( &gyro->fi_demod_a , 0.0 );
    Init_ZForm( &gyro->fi_demod_c , 0.0 );
    Init_ZForm( &gyro->fi_demod_q , 0.0 );
    Init_ZForm( &gyro->fi_demod_fi, 0.0 );
    Init_ZForm( &gyro->fi_KxKy    , 0.0 );

    zform[0] = &gyro->fi_demod_a;
    zform[1] = &gyro->fi_demod_c;
    zform[2] = &gyro->fi_demod_q;
    zform[3] = &gyro->fi_demod_fi;
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
    // ------- LowPass Fs=100Hz, Pass=10Hz
    gyro->fi_KxKy.a[0] = (float)(0.018098933007514 );
    gyro->fi_KxKy.a[1] = (float)(0.054296799022543 );
    gyro->fi_KxKy.a[2] = (float)(0.054296799022543 );
    gyro->fi_KxKy.a[3] = (float)(0.018098933007514 );
    gyro->fi_KxKy.b[0] = (float)( 1.000000000000000e+000);
    gyro->fi_KxKy.b[1] = (float)(-1.760041880343169);
    gyro->fi_KxKy.b[2] = (float)( 1.182893262037831);
    gyro->fi_KxKy.b[3] = (float)(-0.278059917634547);


    // -----
    Init_DebugParam( gyro );


    // -----
    gyro->PhaseSumm        = (float)0.0;
    gyro->PhaseMean        = (float)0.0;
    gyro->PhaseSummCounter = 0;
    gyro->PhaseSummCount   = 10000;
    gyro->PhaseSummCount_invert   = (float)1.0 / (float)gyro->PhaseSummCount;
    gyro->t = (float)0.0;

    // ------ DEBUG ------
    memset ( Debug.param1, 0, sizeof(float) * 1024);  
    memset ( Debug.param2, 0, sizeof(float) * 1024);  
    memset ( Debug.param3, 0, sizeof(float) * 1024); 
    Debug.work_count    = 1024;
    Debug.work_counter  = 0;

    Debug.init_count    = 150000;
    Debug.init_counter  = 0;
    Debug.isInited      = 0;
    Debug.isWork        = 1;
    Debug.isSleep       = 0;

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
void Init_InputMean_n ( TInputMean  *im, Sint16 val1, Sint32 ValuesPerSecond, float DefaulResult )
{
    im->PeriodCount          = ValuesPerSecond / val1;
    im->PeriodCount_invert   = (float)1.0 / (float)im->PeriodCount;
    im->CurSumm              = (float)0.0;
    im->u_old                = (float)0.0;
    im->u1_old               = (float)0.0;
    im->u2_old               = (float)0.0;
    im->DeltaMean            = DefaulResult;
    im->GlobalMean           = (float)DefaulResult;
    im->fTacks               = (float)0;
    im->PeriodCounter        = 0;
    im->SummCounter          = 0;
    im->isNewValuePresent    = 0;
    im->isFound              = 0;
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
    filter_arg    	   = filter_DeltaW * TWO_PI_DISCRET_TIME * (float)0.5;
    filter_A           = sinf(filter_arg) / cosf(filter_arg);
    filter_invertValue = (float)1.0 / (float)( 1.0 + filter_A );
    //filter_B           = (float)2.0 * cosf( TWO_PI / gyro->DefaultPeriod );
    filter_B           = (float)2.0 * cosf(gyro->DefaultFrequency * TWO_PI_DISCRET_TIME);
    //filter_B           = (float)2.0 * cosf((gyro->DefaultFrequency + 100.0) * TWO_PI_DISCRET_TIME);
/*
    gyro->fi_input_x.a[0] = (float) 0.01241106;
    gyro->fi_input_x.a[1] = (float) 0.0;ss
    gyro->fi_input_x.a[2] = (float)-0.01241106;

    gyro->fi_input_x.b[0] = (float) 1.0;
    gyro->fi_input_x.b[1] = (float)-1.693768;
    gyro->fi_input_x.b[2] = (float) 0.9751779;
*/

    gyro->fi_input_x.a[0] = (float)  filter_A * filter_invertValue;
    gyro->fi_input_x.a[1] = (float)  0.0;
    gyro->fi_input_x.a[2] = (float) -filter_A * filter_invertValue;

    gyro->fi_input_x.b[0] = (float)   1.0;
    gyro->fi_input_x.b[1] = (float)  -filter_B  * filter_invertValue;
    gyro->fi_input_x.b[2] = (float)(1.0 - filter_A) * filter_invertValue;

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

    gyro->fi_input_x1.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_x1.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_x1.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_x1.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_x1.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_x1.b[2] = gyro->fi_input_x.b[2];
    gyro->fi_input_x2.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_x2.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_x2.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_x2.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_x2.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_x2.b[2] = gyro->fi_input_x.b[2];
    gyro->fi_input_x3.a[0] = gyro->fi_input_x.a[0];    gyro->fi_input_x3.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_x3.a[1] = gyro->fi_input_x.a[1];    gyro->fi_input_x3.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_x3.a[2] = gyro->fi_input_x.a[2];    gyro->fi_input_x3.b[2] = gyro->fi_input_x.b[2];

}

// ======================================================================================
void Init_PeriodDetector( TPeriodDetector   *pd, float val1, float DefaultGyroFreq )
{
    float loc_DefFreq = DefaultGyroFreq;
    float loc_val1    = DefaultGyroFreq;

    pd->Period    = ALGO_FREQUENCY / loc_DefFreq ;
    pd->PeriodCountSumm = loc_DefFreq / loc_val1;
    pd->PeriodCountSumm_invert = loc_val1 / loc_DefFreq;
    pd->PeriodCounter   = 0;
    pd->pll_phase_incriment =(float)0.0;
    pd->pll_phase = (float)0.0;
    pd->fTacks    = (float)0.0;

    pd->CurSumm = (float)0.0;
    pd->SummCounter = 0;
    pd->isNewValuePresent = 0;
    pd->u_old = 0.0;

    Init_ZForm( &pd->fi_period  , pd->Period );

    pd->fi_period.a[0] = (float)(0.00414769743610353 );
    pd->fi_period.a[1] = (float)(0.00829539487220706 );
    pd->fi_period.a[2] = (float)(0.00414769743610353 );
    pd->fi_period.a[3] = (float)(0.0);
    pd->fi_period.a[4] = (float)(0.0 );
    pd->fi_period.b[0] = (float)( 1.000000000000000e+000);
    pd->fi_period.b[1] = (float)(-1.82908703902933);
    pd->fi_period.b[2] = (float)(0.845677828773748);
    pd->fi_period.b[3] = (float)(0.0);
    pd->fi_period.b[4] = (float)(0.0);

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
void Init_RMNK( TRMNK *prmnk, float DefaultPeriod, float xValue)
{
    float dd1, dd2, dd3;

    dd1 = (float)0.80000;
    dd2 = (float)0.80000;
    dd3 = (float)0.80000;

    prmnk->phi       = (float)0.0;
    prmnk->delta_phi = (float)TWO_PI / DefaultPeriod;

    prmnk->h[0] = (float)1.0;
    prmnk->h[1] = (float)sinf(prmnk->phi);
    prmnk->h[2] = (float)cosf(prmnk->phi);

    prmnk->P[0] = (float)dd1;  
    prmnk->P[1] = (float)0.0;     
    prmnk->P[2] = (float)0.0;
    prmnk->P[3] = (float)0.0;  
    prmnk->P[4] = (float)dd2;     
    prmnk->P[5] = (float)0.0;
    prmnk->P[6] = (float)0.0;  
    prmnk->P[7] = (float)0.0;     
    prmnk->P[8] = (float)dd3;

    prmnk->Qx[0] = (float)0.0;
    prmnk->Qx[1] = (float)0.0;
    prmnk->Qx[2] = (float)1.0;//xValue;

    prmnk->Qy[0] = (float)0.0;
    prmnk->Qy[1] = (float)0.0; 
    prmnk->Qy[2] = (float)0.0;

    prmnk->Qx_raw[0] = (float)0.0;
    prmnk->Qx_raw[1] = (float)0.0;
    prmnk->Qx_raw[2] = (float)1.0;//xValue;

    prmnk->Qy_raw[0] = (float)0.0;
    prmnk->Qy_raw[1] = (float)0.0; 
    prmnk->Qy_raw[2] = (float)0.0;

    prmnk->XMean = (float)0.0;
    prmnk->YMean = (float)0.0;

}

// ======================================================================================
void Init_DebugParam(  TGyro *gyro  )
{
    gyro->BaseVal = 0.0;
    gyro->Counter = 0;
}

// ======================================================================================
void Init_UART_Param( TGyro *gyro )
{
    Sint16 iCounter;
    Sint16 dats = MAXIMUM_UART_DATA;

    gyro->UART_ParamCount      = 19;
    gyro->UART_SummationCount  = 500;
    gyro->UART_SummationPoint  = 0;
    gyro->UART_SummationCount_invert = (float)1.0 / (float)gyro->UART_SummationCount; 

    memset( gyro->UART_Summation, 0, sizeof(float) * MAXIMUM_UART_DATA );
    memset( gyro->UART_Param    , 0, sizeof(float) * MAXIMUM_UART_DATA );

    gyro->UART_Coefs[ 0] = (float)1.0;
    gyro->UART_Coefs[ 1] = (float)1.0;
    gyro->UART_Coefs[ 2] = (float)1.0;
    gyro->UART_Coefs[ 3] = (float)1.0;
    gyro->UART_Coefs[ 4] = (float)1.0;
    gyro->UART_Coefs[ 5] = (float)1.0;
    gyro->UART_Coefs[ 6] = (float)1.0;
    gyro->UART_Coefs[ 7] = (float)1.0;
    gyro->UART_Coefs[ 8] = (float)1.0;
    gyro->UART_Coefs[ 9] = (float)1.0;
    gyro->UART_Coefs[10] = (float)1.0;
    gyro->UART_Coefs[11] = (float)1.0;
    gyro->UART_Coefs[12] = (float)1.0;
    gyro->UART_Coefs[13] = (float)1.0;
    gyro->UART_Coefs[14] = (float)1.0;
    gyro->UART_Coefs[15] = (float)1.0;
    gyro->UART_Coefs[16] = (float)1.0;
    gyro->UART_Coefs[17] = (float)1.0;
    gyro->UART_Coefs[18] = (float)1.0;
    
    gyro->UART_Param[ 0] = &gyro->GyroOut;//gyro->pi_phase_base.BlockOut;//gyro->GyroOut;               // --- Выход гироскопа -----  
    gyro->UART_Param[ 1] = &gyro->Temperature;           // --- Температура -----  
    gyro->UART_Param[ 2] = &gyro->Frequency;         // Фаза возбуждения Анала Х в Тактах алгоритма 

    gyro->UART_Param[ 3] = &gyro->pi_am_2.BlockOut;      // --- Коефициент разночастности ---
    gyro->UART_Param[ 4] = &gyro->pi_si_2.BlockOut;//gyro->GPhase.Phase_deg;//gyro->pi_si_2.BlockOut;      // --- Квадратура ----
    gyro->UART_Param[ 5] = &gyro->X_Phase_Algo; //gyro->XPhase.Phase_deg;//gyro->Zn_phase_x.zn_curr;//gyro->GyroOutRaw;   // Сырой выход гироскопа
    gyro->UART_Param[ 6] = &gyro->Y_Phase_Algo; //gyro->BPFPhase.Phase_deg;   // 

    gyro->UART_Param[ 7] = &gyro->fi_demod_a.BlockOut;//gyro->ExcitationPhase;//gyro->fi_demod_c.BlockOut;   // 
    gyro->UART_Param[ 8] = &gyro->YAmplitude;   // 

    gyro->UART_Param[ 9] = &gyro->ANodePeriod.Period;// --- Средний период колебаний ---
    gyro->UART_Param[10] = &gyro->KFiltr1;//gyro->Zn_exc.zn_curr;           // Косинус в Тактах алгоритма 

    gyro->UART_Param[11] = &gyro->fi_demod_c.BlockOut;//gyro->XPhase.GlobalMean;//gyro->PhaseMean;//gyro->Zn_cos1.zn_curr;           // Фаза Х 
    gyro->UART_Param[12] = &gyro->fi_demod_q.BlockOut;//gyro->ANodePeriod.pll_phase_incriment;//gyro->pi_phase_x.BlockOut;//gyro->YAmplitude;              //  Среднее значение Х

    gyro->UART_Param[13] = &gyro->NULL_value;//gyro->KFiltr1;//gyro->NULL_value;//gyro->XInputMean.GlobalMean;   //  Среднее значение Х
    gyro->UART_Param[14] = &gyro->NULL_value;//gyro->KFiltr2;//gyro->NULL_value;//gyro->YInputMean.GlobalMean;   //  Среднее значение Y

    gyro->UART_Param[15] = &gyro->BPFPhase.Phase_deg;//gyro->NULL_value;//gyro->Zn_sin2.zn_curr;           // Косинус в Тактах алгоритма 
    gyro->UART_Param[16] = &gyro->NULL_value;//NULL_value;//gyro->pi_am_1.m_const;//gyro->Zn_cos1.zn_curr;           // Косинус в Тактах алгоритма 
    gyro->UART_Param[17] = &gyro->Zn_cos2.zn_curr;           // Косинус в Тактах алгоритма 
    gyro->UART_Param[18] = &gyro->GyroOutRaw;           // Косинус в Тактах алгоритма 


    gyro->UART_Coefs[ 5] = RAD_TO_DEG;
    gyro->UART_Coefs[ 6] = RAD_TO_DEG;
}

