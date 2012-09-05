#include "pmInit.h"
#include "pmLibrary.h"
#include "KFF.h"

#include "pmSinCos.h"
#include "pmMath.h"
#include "Math.h"

// ==========================================================
void Init_ZForm             ( TZForm *pZForm, float b);
void Init_BandPassFiltration( TGyro *gyro );
void Init_UART_Param        ( TGyro *gyro );
void Init_PhaseDetector     ( TPhaseDetector *pd, float DefaultGyroFreq );
void Init_PeriodDetector    ( TPeriodDetector *pd, float DefaultGyroFreq ); 
void Init_RMNK( TRMNK *prmnk, float DefaultPeriod, float BaseXAmpl, float DefaultFreq );
void Init_CascadFiltration  ( TCascadFiltration *cf );
void Init_DebugMode         ( TGyro *gyro, TDebug *debug );
void Init_Zn(TZn *pZn);
//void Init_PiReg(TPiReg *pPi, float BaseVal, float Kp, float Ki, float Kd, float t0);

// ==========================================================
void Init_Algo( TGyro *gyro, float *apUARTfloats  )
{
    Sint16   iCounter = 0;

    gyro->pUARTfloats = apUARTfloats;

    // --- Переприсвоение Дефайнов -----
    gyro->DefaultFrequency         = (float)Base_Frequency;
    gyro->DefaultPeriod            = (float)ALGO_FREQUENCY / gyro->DefaultFrequency;
    gyro->Frequency                = gyro->DefaultFrequency;
    gyro->k_Omega                  = k_omega;
    gyro->DebugTime                = TIMES;
    gyro->DebugMode                = DEBUG_MODE;
    gyro->StartUpTime              = (Sint32)(GYRO_StartUp_Time * ALGO_FREQUENCY);
/////////////
    gyro->isXPhase_corr            = CORR_X_PHASE;
    gyro->isYPhase_corr            = CORR_Y_PHASE;

    gyro->isAlfaE_f_corr           = CORR_ALFA_E_f;
    gyro->isAlfaQ_f_corr           = CORR_ALFA_Q_f;
    gyro->isAlfaE_t_corr           = CORR_ALFA_E_t;
    gyro->isAlfaQ_t_corr           = CORR_ALFA_Q_t;
    gyro->isPhiQ_corr              = CORR_PhiQ;

    gyro->isStatic1_corr           = CORR_STATIC_1;
    gyro->isStatic2_corr           = CORR_STATIC_2;
    gyro->isDynamic_1_corr         = CORR_DYNAMIC_1;
    gyro->isDynamic_2_corr         = CORR_DYNAMIC_2;
/////////////
    gyro->GyroOut_corr_st1         = (float)0.0;
    gyro->GyroOut_corr_st2         = (float)0.0;
    gyro->GyroOut_corr_st1_a       = (float)0.0;
    gyro->GyroOut_corr_st1_b       = (float)0.0;
    gyro->GyroOut_corr_st1_c       = (float)0.0;
    
    gyro->GyroOut_corr_st2_a       = (float)0.0;
    gyro->GyroOut_corr_st2_b       = (float)0.0;
    gyro->GyroOut_corr_st2_c       = (float)0.0;

    gyro->GyroOut_MK1              = (float)1.0;  // Единица
    gyro->GyroOut_MK2              = (float)1.0;  // Единица

    gyro->corr_cos_alfa_e          = (float)1.0;  // Единица
    gyro->corr_sin_alfa_e          = (float)0.0;
    gyro->corr_cos_alfa_q          = (float)1.0;  // Единица
    gyro->corr_sin_alfa_q          = (float)0.0;

    gyro->CorrectionOrderCalc      = 0;
/////////////


    gyro->Base_ExcitationPhaseAG = (float)PHASE_AG           * DEG_TO_RAD;
    gyro->Base_ExcitationPhase   = (float)PHASE_EXCITIATION  * DEG_TO_RAD;
    gyro->Base_CompensationPhase = (float)PHASE_COMPENSATION * DEG_TO_RAD;
    gyro->Base_PhiQPhase         = (float)PHASE_PHIQ         * DEG_TO_RAD;

    gyro->ExcitationPhaseAG = gyro->Base_ExcitationPhaseAG;
    gyro->ExcitationPhase   = gyro->Base_ExcitationPhase;
    gyro->CompensationPhase = gyro->Base_CompensationPhase;
    gyro->PhiQPhase         = gyro->Base_PhiQPhase;

    gyro->MainSum_counter     = 0;
    gyro->MainSumInit_counter = 0;
    gyro->isMainSumInited     = 0;

   // -- ФАЗА (Задержка) АГ ----
    gyro->Zn_exc.zn_curr = (ALGO_FREQUENCY / Base_Frequency) * gyro->ExcitationPhaseAG * TWO_PI_INVERT;
    Init_Zn( &gyro->Zn_exc );

   // -------- Инит коррекционных переменных --------
    gyro->f1 = (float)0.0;    gyro->e1 = (float)0.0;    gyro->q1 = (float)0.0;    gyro->t1 = (float)0.0;
    gyro->f2 = (float)0.0;    gyro->e2 = (float)0.0;    gyro->q2 = (float)0.0;    gyro->t2 = (float)0.0;
    gyro->f3 = (float)0.0;    gyro->e3 = (float)0.0;    gyro->q3 = (float)0.0;    gyro->t3 = (float)0.0;
    gyro->f4 = (float)0.0;    gyro->e4 = (float)0.0;    gyro->q4 = (float)0.0;    gyro->t4 = (float)0.0;
    gyro->f5 = (float)0.0;    gyro->e5 = (float)0.0;    gyro->q5 = (float)0.0;    gyro->t5 = (float)0.0;
    gyro->f6 = (float)0.0;    gyro->e6 = (float)0.0;    gyro->q6 = (float)0.0;    gyro->t6 = (float)0.0;

   // ----------------- Пегуляторы ------
    Init_PiReg_new( gyro->pi_ampl_1, (float)X_ampl*X_ampl, Kp_x1, Ki_x1, (float)DISCRET_TIME );  
    Init_PiReg_new( gyro->pi_ampl_2, (float)          0.0, Kp_x1, Ki_x1, (float)DISCRET_TIME );
    Init_PiReg_new( gyro->pi_corr_1, (float)       C_ampl, Kp_c1, Ki_c1, (float)DISCRET_TIME );
    Init_PiReg_new( gyro->pi_corr_2, (float)          0.0, Kp_c1, Ki_c1, (float)DISCRET_TIME );
    Init_PiReg_new( gyro->pi_quad_1, (float)       Q_ampl, Kp_q1, Ki_q1, (float)DISCRET_TIME );
    Init_PiReg_new( gyro->pi_quad_2, (float)          0.0, Kp_q1, Ki_q1, (float)DISCRET_TIME );

    Init_PiReg_new( gyro->rmnk.pi_pll_x1, 0.0,  Kp_f1, Ki_f1,  (float)DISCRET_TIME );
    Init_PiReg_new( gyro->rmnk.pi_pll_x2, 0.0,  Kp_f1, Ki_f1,  (float)DISCRET_TIME );
    Init_PiReg_new( gyro->rmnk.pi_freq_1, 0.0,  Kp_f1, Ki_f1,  (float)DISCRET_TIME );
    Init_PiReg_new( gyro->rmnk.pi_freq_2, 0.0,  Kp_f1, Ki_f1,  (float)DISCRET_TIME );

    //Init_PiReg( &gyro->pi_om, 0.0,  600.0, 180.0, (float)-0.11, (float)DISCRET_TIME );
    

   // ----------------- 
    Init_CascadFiltration  ( &gyro->cf_Freq );
    Init_CascadFiltration  ( &gyro->cf_Quad );
    Init_CascadFiltration  ( &gyro->cf_Temp );
    Init_CascadFiltration  ( &gyro->cf_Exci );

   // ----------------- 
    Init_PeriodDetector ( &gyro->rmnk.ANodePeriod, gyro->DefaultFrequency );

   // ----------------- Задержки ------
    Init_PhaseDetector( &gyro->Phase, gyro->DefaultFrequency);

   // -------------------------
    Init_RMNK( &gyro->rmnk, gyro->DefaultPeriod, (float)X_ampl*X_ampl, gyro->DefaultFrequency );
 
    gyro->Temperature      = (float)0.0;
    gyro->NULL_value       = (float)0.0;
    gyro->in_Ux            = (float)0.0;
    gyro->in_Uy            = (float)0.0;
    gyro->out_Ux           = (float)0.5;
    gyro->out_Uy           = (float)0.0;
    gyro->KXPhase          = (float)0.0;
    gyro->K_PhaseScan      = (float)1.0;

    // -------------------------
    Init_DebugMode              ( gyro, &Debug );
    Init_BandPassFiltration_new ( gyro->fi_input_x, gyro->DefaultFrequency,  50.0, (float)DISCRET_TIME );
    Init_BandPassFiltration_new ( gyro->fi_input_y, gyro->DefaultFrequency,1200.0, (float)DISCRET_TIME ); // Фаза задержки на 100 Гц 7 градусов
    //Init_BandPassFiltration_new ( gyro->fi_input_y, gyro->DefaultFrequency,1000.0, (float)DISCRET_TIME ); // Фаза задержки на 100 Гц 11.5 градусов
    //Init_BandPassFiltration_new ( gyro->fi_input_y, gyro->DefaultFrequency, 800.0, (float)DISCRET_TIME ); // Фаза задержки на 100 Гц 14 градусов
    Init_UART_Param             ( gyro );

    // ------- Второстепенные иниты -------
    gyro->AlgoCounter      = 0;
    gyro->isAlgoCounter    = 1;
    gyro->CurDebugTime     = (float)0.0;
 
    // ---------
    #pragma vector_for
    for ( iCounter = 0; iCounter < SLIDER_BUFFERS_LENGTH; iCounter++)
        gyro->XBuffer    [iCounter] = (float)0.0; 

    // ------ Демодуляторы ------
    Init_ZForm( &gyro->fi_demod_x    , 0.0 );
    Init_ZForm( &gyro->fi_demod_c    , 0.0 );
    Init_ZForm( &gyro->fi_demod_q    , 0.0 );

/*
    // ------ LowPass  125Hz ----  Батерворда
    gyro->fi_demod_c.a[0] = (float)(2.0 * 4.769517889121183e-007 );
    gyro->fi_demod_c.a[1] = (float)(2.0 * 1.430855366736355e-006 );
    gyro->fi_demod_c.a[2] = (float)(2.0 * 1.430855366736355e-006 );
    gyro->fi_demod_c.a[3] = (float)(2.0 * 4.769517889121183e-007 );

    gyro->fi_demod_c.b[0] = (float)( 1.000000000000000e+000);
    gyro->fi_demod_c.b[1] = (float)(-2.968584396371834e+000);
    gyro->fi_demod_c.b[2] = (float)( 2.937660325278699e+000);
    gyro->fi_demod_c.b[3] = (float)(-9.690721132925537e-001);
*/
/*
    // ------ LowPass  800Hz ----  Батерворда
    gyro->fi_demod_c.a[0] = (float)(2.0 * 0.115140745768740e-003 );
    gyro->fi_demod_c.a[1] = (float)(2.0 * 0.345422237306219e-003 );
    gyro->fi_demod_c.a[2] = (float)(2.0 * 0.345422237306219e-003 );
    gyro->fi_demod_c.a[3] = (float)(2.0 * 0.115140745768740e-003 );

    gyro->fi_demod_c.b[0] = (float)( 1.000000000000000);
    gyro->fi_demod_c.b[1] = (float)(-2.799022014673303);
    gyro->fi_demod_c.b[2] = (float)( 2.617735500922233);
    gyro->fi_demod_c.b[3] = (float)(-0.817792360282780);
*/
/*
    // ------ LowPass  800Hz ----  Чебышева 1 рода неравномерность в ПП 0.01 ( на частоте среза 100 герц фаза задержки 8 градусов )
    gyro->fi_demod_c.a[0] = (float)(2.0 * 0.000564097865179 );
    gyro->fi_demod_c.a[1] = (float)(2.0 * 0.001692293595536 );
    gyro->fi_demod_c.a[2] = (float)(2.0 * 0.001692293595536 );
    gyro->fi_demod_c.a[3] = (float)(2.0 * 0.000564097865179 );

    gyro->fi_demod_c.b[0] = (float)( 1.000000000000000);
    gyro->fi_demod_c.b[1] = (float)(-2.674500367830047);
    gyro->fi_demod_c.b[2] = (float)( 2.405749073388438);
    gyro->fi_demod_c.b[3] = (float)(-0.726735922636962);
*/


    // ------ LowPass  500Hz ----  Чебышева 1 рода неравномерность в ПП 0.01 ( на частоте среза 100 герц фаза задержки 13 градусов )
    gyro->fi_demod_x.a[0] = (float)(2.0 * 0.146146574414762 * 1.0e-003 );
    gyro->fi_demod_x.a[1] = (float)(2.0 * 0.438439723244285 * 1.0e-003 );
    gyro->fi_demod_x.a[2] = (float)(2.0 * 0.438439723244285 * 1.0e-003 );
    gyro->fi_demod_x.a[3] = (float)(2.0 * 0.146146574414762 * 1.0e-003 );

    gyro->fi_demod_x.b[0] = (float)( 1.000000000000000);
    gyro->fi_demod_x.b[1] = (float)(-2.797716356193668);
    gyro->fi_demod_x.b[2] = (float)( 2.617914892232589);
    gyro->fi_demod_x.b[3] = (float)(-0.8190293634436032780);

        // ------ LowPass  500Hz ----  Чебышева 1 рода неравномерность в ПП 0.01 ( на частоте среза 100 герц фаза задержки 13 градусов )
    gyro->fi_demod_c.a[0] = (float)(2.0 * 0.146146574414762 * 1.0e-003 );
    gyro->fi_demod_c.a[1] = (float)(2.0 * 0.438439723244285 * 1.0e-003 );
    gyro->fi_demod_c.a[2] = (float)(2.0 * 0.438439723244285 * 1.0e-003 );
    gyro->fi_demod_c.a[3] = (float)(2.0 * 0.146146574414762 * 1.0e-003 );

    gyro->fi_demod_c.b[0] = (float)( 1.000000000000000);
    gyro->fi_demod_c.b[1] = (float)(-2.797716356193668);
    gyro->fi_demod_c.b[2] = (float)( 2.617914892232589);
    gyro->fi_demod_c.b[3] = (float)(-0.8190293634436032780);
/*
    // ------ LowPass  400Hz ----  Чебышева 1 рода неравномерность в ПП 0.01 ( на частоте среза 100 герц фаза задержки 16 градусов )
    gyro->fi_demod_c.a[0] = (float)(2.0 * 0.146146574414762 * 1.0e-003 );
    gyro->fi_demod_c.a[1] = (float)(2.0 * 0.438439723244285 * 1.0e-003 );
    gyro->fi_demod_c.a[2] = (float)(2.0 * 0.438439723244285 * 1.0e-003 );
    gyro->fi_demod_c.a[3] = (float)(2.0 * 0.146146574414762 * 1.0e-003 );

    gyro->fi_demod_c.b[0] = (float)( 1.000000000000000);
    gyro->fi_demod_c.b[1] = (float)(-2.797716356193668);
    gyro->fi_demod_c.b[2] = (float)( 2.617914892232589);
    gyro->fi_demod_c.b[3] = (float)(-0.8190293634436032780);
*/
    // w0 = 5 HMax = 0715      -3dB = 34Hz 
    gyro->fi_demod_q.a[0] = (float)( 2.0 * 0.202050324201413 * 1e-5 );
    gyro->fi_demod_q.a[1] = (float)( 2.0 * 0.404100648402826 * 1e-5 );
    gyro->fi_demod_q.a[2] = (float)( 2.0 * 0.202050324201413 * 1e-5 );
    gyro->fi_demod_q.a[3] = (float)( 0.0 );

    gyro->fi_demod_q.b[0] = (float)( 1.000000000000000 );
    gyro->fi_demod_q.b[1] = (float)(-1.996074539047090 );
    gyro->fi_demod_q.b[2] = (float)( 0.996082621060058 );
    gyro->fi_demod_q.b[3] = (float)( 0.0 );
/*
    // ------ LowPass  800Hz ----  Чебышева 2 рода неравномерность в ПП 0.01 ( на частоте среза 100 герц фаза задержки 8 градусов )
    gyro->fi_demod_q.a[0] = (float)(2.0 * 0.000564097865179 );
    gyro->fi_demod_q.a[1] = (float)(2.0 * 0.001692293595536 );
    gyro->fi_demod_q.a[2] = (float)(2.0 * 0.001692293595536 );
    gyro->fi_demod_q.a[3] = (float)(2.0 * 0.000564097865179 );

    gyro->fi_demod_q.b[0] = (float)( 1.000000000000000);
    gyro->fi_demod_q.b[1] = (float)(-2.674500367830047);
    gyro->fi_demod_q.b[2] = (float)( 2.405749073388438);
    gyro->fi_demod_q.b[3] = (float)(-0.726735922636962);
*/
    // -----Амлитуда колебаний У ----
    gyro->Y_CountSumValues  = gyro->DefaultFrequency * 0.1;
    gyro->Y_CountSumCounter = 0;
    gyro->Y_CountSumValues_invert = (float)1.0 / (float)gyro->Y_CountSumValues;
    gyro->Y_minVal = (float) 0.0;
    gyro->Y_maxVal = (float) 0.0;


    gyro->DebugCounter = (float)0.0;
    gyro->DebugCoef    = (float)1.0;
}

// ==========================================================
void Init_ZForm(TZForm *pZForm, float InitValue)
{
	
    pZForm->a[0] = (float)0.0;    pZForm->b[0] = (float)0.0;
	pZForm->a[1] = (float)0.0;    pZForm->b[1] = (float)0.0;
	pZForm->a[2] = (float)0.0;    pZForm->b[2] = (float)0.0;
	pZForm->a[3] = (float)0.0;    pZForm->b[3] = (float)0.0;
	pZForm->a[4] = (float)0.0;    pZForm->b[4] = (float)0.0;

	pZForm->x[0] = InitValue;     pZForm->y[0] = InitValue;
	pZForm->x[1] = InitValue;     pZForm->y[1] = InitValue;
	pZForm->x[2] = InitValue;     pZForm->y[2] = InitValue;
	pZForm->x[3] = InitValue;     pZForm->y[3] = InitValue;
	pZForm->x[4] = InitValue;     pZForm->y[4] = InitValue;

    pZForm->BlockOut = (float)0.0;
    pZForm->OutScale = (float)1.0;
}

//*****************************************************************
//
//*****************************************************************
void Init_PeriodDetector( TPeriodDetector *pd, float DefaultGyroFreq )
{
    pd->Period    = ALGO_FREQUENCY / DefaultGyroFreq ;
    pd->fTacks    = (float)0.0;
    pd->u_old = 0.0;
}

//*****************************************************************
//
//*****************************************************************
void Init_Zn(TZn *pZn)
{
    pZn->zn_i = (Sint8)pZn->zn_curr;

    pZn->t1   = pZn->zn_curr - pZn->zn_i;
    pZn->t2   = pZn->t1 * pZn->t1;
    pZn->t3   = pZn->t2 * pZn->t1;

    pZn->k0   = (float) 1.0 - (float)1.833333333*pZn->t1 + pZn->t2 - (float)0.1666666667*pZn->t3;
    pZn->k1   = (float) 3.0*pZn->t1 - (float)2.5*pZn->t2 + (float)0.5*pZn->t3;
    pZn->k2   = (float)-1.5*pZn->t1 + (float)2.0*pZn->t2 - (float)0.5*pZn->t3;
    pZn->k3   = (float)0.3333333333*pZn->t1 - (float)0.5*pZn->t2 + (float)0.1666666667*pZn->t3;
}
 
/*
// ======================================================================================
void Init_PiReg(TPiReg *pPi, float BaseVal, float Kp, float Ki, float Kd, float t0)
{

    Init_ZForm( &pPi->Integral, BaseVal);

    pPi->Kp             = (float)Kp;
    pPi->Ki             = (float)Ki;
    pPi->Kd             = (float)Kd / t0;
    pPi->m_const        = (float)BaseVal;

    pPi->Integral.a[0] = (float)pPi->Ki * (float)0.5 * t0;
    pPi->Integral.a[1] = (float)pPi->Ki * (float)0.5 * t0;

    pPi->Integral.b[0] = (float) 1.0;
    pPi->Integral.b[1] = (float)-1.0;


    pPi->diff = 0; 

    pPi->CalcOrder      = 0;
    pPi->BlockInput     = (float)0.0;
    pPi->BlockOut       = (float)0.0;
}
*/

// ======================================================================================
void Init_PhaseDetector( TPhaseDetector *pd, float DefaulPeriod )
{
    pd->u1_old       = (float)0.0;
    pd->u2_old       = (float)0.0;
    pd->fTacks       = (float)0.0;

    pd->isNewValuePresent = 0;
    pd->isFound           = 0;
}


// ======================================================================================
void Init_RMNK( TRMNK *prmnk, float DefaultPeriod, float BaseXAmpl, float DefaultFreq )
{
    // ----- Инициализация переменных ------
    prmnk->x_phi     = (float)0.0;
    prmnk->delta_phi = (float)TWO_PI / DefaultPeriod;
    prmnk->delta_phi_m = prmnk->delta_phi;

    prmnk->Qx[0] = (float)0.0;
    prmnk->Qx[1] = BaseXAmpl;
    prmnk->Qx[2] = (float)0.0;

    // ------ Значения MjuX могут меняться (это скорость сходимости) -----
    prmnk->MjuX[0] = (float)1e-3;
    prmnk->MjuX[1] = (float)0.008;
    prmnk->MjuX[2] = (float)0.008;

    Init_LowPass_IRFiltr_1rstOrder( prmnk->fi_Xa, 250.0,  BaseXAmpl, DISCRET_TIME );
    Init_LowPass_IRFiltr_1rstOrder( prmnk->fi_Xb, 250.0, (float)0.0, DISCRET_TIME );
}

// ======================================================================================
void Init_CascadFiltration  ( TCascadFiltration *cf )
{
    cf->dsumm          = (double)0.0;
    cf->BlockOut       = (float)0.0;

    cf->mean_buffer[0] = (float)0.0;
    cf->mean_buffer[1] = (float)0.0;
    cf->mean_buffer[2] = (float)0.0;
    cf->mean_buffer[3] = (float)0.0;
    cf->mean_buffer[4] = (float)0.0;
    cf->mean_buffer[5] = (float)0.0;
    cf->mean_buffer[6] = (float)0.0;
    cf->mean_buffer[7] = (float)0.0;
    cf->mean_buffer[8] = (float)0.0;
    cf->mean_buffer[9] = (float)0.0;
}

// ======================================================================================
void Init_DebugMode ( TGyro *gyro, TDebug *debug )
{
    Sint32 iCounter;

    gyro->c1      = (float)0.0;
    gyro->c2      = (float)0.0;
    gyro->c3      = (float)0.0;
    gyro->rmnk.c4 = (float)0.0;
    gyro->c5      = (float)0.0;
    gyro->c6      = (float)0.0;

    debug->debug_value     = &gyro->fi_input_y[0];
    //debug->debug_value     = &gyro->rmnk.fi_Xb.BlockOut;

    debug->debug_constant  = 0;
    debug->debug_coef      = (float)1.0;


    debug->cos_Amplitude     = (float)1.0;
    debug->freq_base         = (float)0.0;
    debug->freq_incr         = (float)0.0;
    debug->phi_base          = (float)ONE_PI;

    debug->freq_incr_step    = 0;
    debug->freq_incr_counter = 0;
    debug->freq_incr_value   = (float)0.0;
    debug->freq_pass_counter = 0;
    debug->freq_pass_step    = 30;

    if ( gyro->DebugMode == 1 ) 
    {
        debug->debug_value    = &gyro->pi_ampl_2[0];
        debug->debug_constant = &gyro->c1;
    }

    if ( gyro->DebugMode == 2 ) 
    {
        //debug->cos_Amplitude  = (float)0.04;
        debug->debug_value    = &gyro->pi_corr_2[0];
        debug->debug_constant = &gyro->c2;
    }

    if ( gyro->DebugMode == 3 ) 
    {
        debug->debug_value    = &gyro->pi_quad_2[0];
        debug->debug_constant = &gyro->c3;
    }

    if ( gyro->DebugMode == 4 ) 
    {
        debug->debug_value    = &gyro->rmnk.pi_pll_x2[0];
        debug->debug_constant = &gyro->rmnk.c4;
        debug->cos_Amplitude  = (float)DISCRET_TIME * TWO_PI;
    }

    if ( gyro->DebugMode == 6 ) 
    {
        debug->debug_value    = &gyro->ExcitationPhaseAG;
        debug->debug_constant = &gyro->c5;
        debug->debug_coef     = RAD_TO_DEG;
        debug->phi_base       = (float)PI_DIV_TWO;
        //debug->freq_incr      = (float)-0.003 * TWO_PI * DISCRET_TIME;
        debug->freq_incr      = (float)-0.009 * TWO_PI * DISCRET_TIME;
        debug->cos_Amplitude  = (float) 180.0 * DEG_TO_RAD;
    }

    if ( gyro->DebugMode == 7 ) 
    {
        debug->debug_value    = &gyro->ExcitationPhase;
        debug->debug_constant = &gyro->c6;
        debug->debug_coef     = RAD_TO_DEG;
        debug->phi_base       = (float)PI_DIV_TWO;
        //debug->freq_incr      = (float)-0.003 * TWO_PI * DISCRET_TIME;
        debug->freq_incr      = (float)-0.009 * TWO_PI * DISCRET_TIME;
        debug->cos_Amplitude  = (float) 180.0 * DEG_TO_RAD;
    }

    if ( gyro->DebugMode == 8 ) 
    {
        //gyro->c2 = (float)1.0;
        debug->debug_value     = &debug->freq_incr;
        debug->debug_constant  = &gyro->c2;
        debug->phi_base        = (float)PI_DIV_TWO;
        debug->freq_incr       = (float)1.0 * TWO_PI * DISCRET_TIME;
        debug->freq_incr_value = (float)1.0 * TWO_PI * DISCRET_TIME;
        
        debug->debug_coef      = ALGO_FREQUENCY * TWO_PI_INVERT;

        debug->cos_Amplitude   = (float)1.0;

        debug->freq_incr_step    = 1 * ALGO_FREQUENCY;
        debug->freq_incr_counter = 0;
        debug->freq_pass_step    = 1;
    }

    if ( gyro->DebugMode == 9 ) 
    {
        debug->debug_value    = &gyro->ExcitationPhase;
        debug->debug_constant = &gyro->c6;
        debug->debug_coef     = RAD_TO_DEG;
        debug->phi_base       = (float)PI_DIV_TWO;
        debug->freq_incr      = (float)-0.05 * TWO_PI * DISCRET_TIME;
        debug->cos_Amplitude  = (float) 12.0 * DEG_TO_RAD;
    }

    if ( gyro->DebugMode == 10 ) 
    {
        debug->debug_value    = &gyro->PhiQPhase;
        debug->debug_constant = &gyro->c10;
        debug->debug_coef     = RAD_TO_DEG;
        debug->phi_base       = (float)PI_DIV_TWO;
        debug->freq_incr      = (float) 2.0e-9 * TWO_PI * DISCRET_TIME;
        debug->cos_Amplitude  = (float) 180.0 * DEG_TO_RAD;
    }

    if ( gyro->DebugMode == 11 ) 
    {
        debug->debug_value    = &gyro->rmnk.c11;
        debug->debug_constant = &gyro->rmnk.c11;
        debug->debug_coef     = RAD_TO_DEG;
        debug->phi_base       = (float)PI_DIV_TWO + (float)5.0 * DEG_TO_RAD;
        debug->freq_incr      = (float)-0.02 * TWO_PI * DISCRET_TIME;
        debug->cos_Amplitude  = (float) 180.0 * DEG_TO_RAD;
    }


    #pragma vector_for
    for ( iCounter = 0; iCounter < DEBUG_ARRAY_DEPTH; iCounter++)
    {
        debug->param1[iCounter] = (float)0.0;
    }

    debug->isInited      = 0;
    debug->isWork        = 1;

    debug->init_count    = 150000;
    debug->init_counter  = 0;
    debug->isSleep       = 0;

    debug->DataFreq           = DEBUG_PARAM_FREQ;
    debug->Decimation         = ALGO_FREQUENCY / DEBUG_PARAM_FREQ;
    debug->Decimation_counter = 0;

    debug->work_count    = DEBUG_ARRAY_DEPTH;
    debug->work_counter  = 0;

}

// ======================================================================================
void Init_UART_Param( TGyro *gyro )
{
    Sint16 iCounter;
    Sint16 dats = MAXIMUM_UART_DATA;

    gyro->UART_ParamCount           = 19;
    gyro->UART_SummationCount       = 500;
    gyro->UART_SummationCount_OMEGA = 50;
    gyro->UART_SummationPoint  = 0;

    gyro->UART_SummationCount_invert       = (float)1.0 / (float)gyro->UART_SummationCount; 
    gyro->UART_SummationCount_OMEGA_invert = (float)1.0 / (float)gyro->UART_SummationCount_OMEGA; 

    #pragma vector_for
    for ( iCounter = 0; iCounter < MAXIMUM_UART_DATA; iCounter++ )
    {
        gyro->UART_Summation      [iCounter] = (float)0.0;
        gyro->UART_Param          [iCounter] = 0;
        gyro->UART_Coefs          [iCounter] = (float)1.0; 
        gyro->UART_isNeedSummation[iCounter] = 1;
    }

    gyro->UART_Param[ 0] = &gyro->pi_corr_2[0];       

    gyro->UART_Param[ 1] = &gyro->cf_Temp.BlockOut; 
    gyro->UART_Param[ 2] = &gyro->cf_Freq.BlockOut; 
    gyro->UART_Param[ 3] = &gyro->cf_Exci.BlockOut; 
    gyro->UART_Param[ 4] = &gyro->pi_quad_2[0]; 

    gyro->UART_Param[ 5] = &gyro->pi_corr_2[0];
    gyro->UART_Param[ 6] = &gyro->pi_ampl_2[0];

    gyro->UART_Param[ 7] = &gyro->rmnk.fi_Xa[0];
    gyro->UART_Param[ 8] = &gyro->rmnk.YAmpl;      
    
    gyro->UART_Param[ 9] = &gyro->ExcitationPhase;
    gyro->UART_Param[10] = &gyro->CompensationPhase;

    gyro->UART_Param[11] = &gyro->fi_demod_c.BlockOut;
    gyro->UART_Param[12] = &gyro->fi_demod_q.BlockOut;
    gyro->UART_Param[13] = &gyro->rmnk.fi_Xb[0];
    
    gyro->UART_Param[14] = &gyro->rmnk.XFrequency;
    gyro->UART_Param[15] = &gyro->pi_quad_2[0];
    gyro->UART_Param[16] = &gyro->PhiQPhase; //gyro->rmnk.XFrequency_m;

    gyro->UART_Param[17] = &gyro->Phase.Phase_deg;
    gyro->UART_Param[18] = Debug.debug_value;

    /////////////////////////
    gyro->UART_Coefs[ 9] = RAD_TO_DEG;
    gyro->UART_Coefs[10] = RAD_TO_DEG;
    gyro->UART_Coefs[16] = RAD_TO_DEG;
    //gyro->UART_Coefs[17] = RAD_TO_DEG;
    gyro->UART_Coefs[18] = Debug.debug_coef;
    /////////////////////////

    gyro->UART_isNeedSummation[ 0] = 1;
    gyro->UART_isNeedSummation[ 1] = 0;
    gyro->UART_isNeedSummation[ 2] = 0;
    gyro->UART_isNeedSummation[ 3] = 0;
    gyro->UART_isNeedSummation[ 4] = 0;

    gyro->UART_isNeedSummation[ 5] = ( gyro->DebugMode == 8 ) ? 0 : 1; // 
    gyro->UART_isNeedSummation[ 6] = 1;
    gyro->UART_isNeedSummation[ 7] = 1;
    gyro->UART_isNeedSummation[ 8] = 1;

    gyro->UART_isNeedSummation[ 9] = 0;
    gyro->UART_isNeedSummation[10] = 0;
    gyro->UART_isNeedSummation[11] = 0;

    gyro->UART_isNeedSummation[12] = 0;
    gyro->UART_isNeedSummation[13] = 0;
    gyro->UART_isNeedSummation[14] = 0;
    gyro->UART_isNeedSummation[15] = 1;
    gyro->UART_isNeedSummation[16] = 0;
    gyro->UART_isNeedSummation[17] = 0;
    gyro->UART_isNeedSummation[18] = 0;

}
