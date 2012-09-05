#include "pmInit.h"
#include "KFF.h"

#include "math.h"
#include <string.h>   // ---- Юнит нужен для функции MemSet ----

// ==========================================================
void Init_ZForm             ( TZForm *pZForm, float b);
void Init_Zn                ( TZn *pzn, float n );
void Init_PiReg             ( TPiReg *pPi, float BaseVal, float Kp, float Ki, float InitValue);
void Init_BandPassFiltration( TGyro *gyro );
void Init_UART_Param        ( TGyro *gyro );
void Init_PeriodDetector    ( TPeriodDetector *pd, float DefaulPeriod );
void Init_PhaseDetector     ( TPhaseDetector *pd, float DefaulPeriod );
void Init_Debug_Param       ( TGyro *gyro );
void Init_InputMean         ( TInputMean *im, float tbase );

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
    gyro->DefaultPeriod        = T_base;
    gyro->DefaultSystemPhaseX  = N_SystemPhase_x;
    gyro->DefaultSystemPhaseY  = N_SystemPhase_y;
    
    gyro->SignOmega            = k_omega;
    gyro->DebugTime            = TIMES;
    gyro->DebugMode            = DEBUG_MODE;

    // ----------------- Пегуляторы ------
    Init_PiReg( &gyro->pi_ampl_x1, X_ampl, Kp_X1, Ki_X1, 0.0 );
    Init_PiReg( &gyro->pi_ampl_x2,    0.0, Kp_X2, Ki_X2, 0.0 );
    Init_PiReg( &gyro->pi_ampl_y1, Y_ampl, Kp_Y1, Ki_Y1, 0.0 );
    Init_PiReg( &gyro->pi_ampl_y2,    0.0, Kp_Y2, Ki_Y2, 0.0 );
    Init_PiReg( &gyro->pi_xy1    ,    0.0, Kp_F1, Ki_F1, 0.0 );
    Init_PiReg( &gyro->pi_xy2    ,    0.0, Kp_F2, Ki_F2, 0.0 );

    // ----------------- Структуры средних значений ------
    Init_InputMean( &gyro->XInputMean, T_base );
    Init_InputMean( &gyro->YInputMean, T_base );

    // ----------------- Задержки ------
    Init_Zn( &gyro->Zn_exc_x, N_exc_x );
    Init_Zn( &gyro->Zn_exc_y, N_exc_y );
    Init_Zn( &gyro->Zn_df_x , N_exc_x - (float)0.25 * T_base );
    Init_Zn( &gyro->Zn_df_y , N_exc_y - (float)0.25 * T_base );

    // -------------------------
    Init_BandPassFiltration( gyro );
    Init_UART_Param        ( gyro );
    Init_Debug_Param       ( gyro );
    Init_PeriodDetector( &gyro->PeriodD, gyro->DefaultPeriod );

    Init_PhaseDetector ( &gyro->PhaseD      , gyro->DefaultPeriod );
    Init_PhaseDetector ( &gyro->SystemPhaseX, gyro->DefaultPeriod );
    Init_PhaseDetector ( &gyro->SystemPhaseY, gyro->DefaultPeriod );

    // ------- Второстепенные иниты -------
    gyro->AlgoCounter      = 0;
    gyro->isAlgoCounter    = 1;
    gyro->isFlag3          = 0;
    gyro->isInited         = 0; 
    gyro->DefaultPeriod_invert = (float)1.0 / (float)gyro->DefaultPeriod;
    gyro->Temperature      = (float)0.0;
    gyro->NULL_value       = (float)0.0;
    gyro->in_Ux_Amplitude  = (float)0.0;
    gyro->in_Uy_Amplitude  = (float)0.0;
    gyro->in_Ux            = (float)0.0;
    gyro->in_Uy            = (float)0.0;
    gyro->out_Ux           = (float)0.5;
    gyro->out_Uy           = (float)0.0;
	gyro->GyroOut          = (float)0.0;
    gyro->Quadrature       = (float)0.0;

    memset (gyro->XBuffer, 0, sizeof(float) * SLIDER_BUFFERS_LENGTH); 
    memset (gyro->YBuffer, 0, sizeof(float) * SLIDER_BUFFERS_LENGTH); 

    // ------ Демодуляторы ------
    Init_ZForm( &gyro->fi_demod_x, 0.0 );
    Init_ZForm( &gyro->fi_demod_y, 0.0 );

    zform[0] = &gyro->fi_demod_x;
    zform[1] = &gyro->fi_demod_y;
    for ( iCounter = 0; iCounter < 2; iCounter++)
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

//*****************************************************************
//
//*****************************************************************
void Setup_Zn_init(TZn *pZn)
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

// ======================================================================================
void Init_Zn ( TZn *pzn, float n )
{
    pzn->zn_base = n;
    pzn->zn_curr = n;
    pzn->zn_i    = (Sint8)pzn->zn_curr;
    pzn->t1      = pzn->zn_curr - pzn->zn_i;
    pzn->t2      = pzn->t1 * pzn->t1;
    pzn->t3      = pzn->t1 * pzn->t2;

    Setup_Zn_init( pzn );
}

// ======================================================================================
void Init_InputMean( TInputMean *im, float tbase )
{
    im->PeriodCount   = (Sint16)((float)ALGO_FREQUENCY / tbase);
    im->PeriodCounter = 0;

    im->NCounter                 =  0;
    im->CurSumm                  = (float)0.0;
    im->Old_InputVal             = (float)0.0;
    im->SliderBuffer[0]          = (float)0.0;
    im->SliderBuffer[1]          = (float)0.0;
    im->SliderBuffer[2]          = (float)0.0;
    im->SliderBuffer[3]          = (float)0.0;
    im->SliderBuffer[4]          = (float)0.0;
    im->SliderBuffer_invertCount = (float)1.0 / (float)5.0;
    im->BlockOut                 = (float)0.0;
}

// ======================================================================================
void Init_PiReg(TPiReg *pPi, float BaseVal, float Kp, float Ki, float InitValue)
{

    Init_ZForm( &pPi->Integral, InitValue);

    pPi->Kp             = (float)Kp;
    pPi->Ki             = (float)Ki;
    pPi->m_const        = (float)BaseVal;

    if ( pPi->m_const == 0 ) 
         pPi->m_const_invert = (float)0.0;
    else pPi->m_const_invert = (float)1.0 / pPi->m_const;
    

    pPi->Integral.a[0] = (float)pPi->Ki * (float)0.5 * (float)DISCRET_TIME;
    pPi->Integral.a[1] = (float)pPi->Ki * (float)0.5 * (float)DISCRET_TIME;
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

    // ----------------- Фильтра ------
    Init_ZForm( &gyro->fi_input_x, 0.0 );
    Init_ZForm( &gyro->fi_input_y, 0.0 );

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

    gyro->fi_input_y.a[0] = gyro->fi_input_x.a[0];   
    gyro->fi_input_y.a[1] = gyro->fi_input_x.a[1];
    gyro->fi_input_y.a[2] = gyro->fi_input_x.a[2];

    gyro->fi_input_y.b[0] = gyro->fi_input_x.b[0];
    gyro->fi_input_y.b[1] = gyro->fi_input_x.b[1];
    gyro->fi_input_y.b[2] = gyro->fi_input_x.b[2];
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
    TPiReg *pPi = &gyro->SetupDF.pi_reg;

    gyro->SetupDF.CurTime        = (float)  0.0;
    gyro->SetupDF.TimePos0       = (float) 10.0;
    gyro->SetupDF.TimePos1       = (float) 10.0;
    gyro->SetupDF.TimePos2       = (float)  5.0 + gyro->SetupDF.TimePos1;
    gyro->SetupDF.GyroOutSum     = (float)  0.0;
    gyro->SetupDF.GyroOutMean[0] = (float)  0.0;
    gyro->SetupDF.GyroOutMean[1] = (float)  0.0;
    gyro->SetupDF.ZnCoefs[0]     = gyro->Zn_df_x.zn_curr;
    gyro->SetupDF.ZnCoefs[1]     = gyro->Zn_df_x.zn_curr;

    Init_ZForm( &pPi->Integral, gyro->Zn_df_x.zn_curr);

    pPi->Integral.x[0] = (float)0.0;
    pPi->Integral.x[1] = (float)0.0;
    pPi->Integral.y[0] = (float)0.0;
    pPi->Integral.y[1] = (float)-gyro->Zn_df_x.zn_curr;


    pPi->Kp             = (float)0.04;
    pPi->Ki             = (float)0.5;
    pPi->m_const        = (float)0.0;
    pPi->m_const_invert = (float)0.0;

    pPi->Integral.a[0] = (float)pPi->Ki * (float)0.5 * (float)1.0;
    pPi->Integral.a[1] = (float)pPi->Ki * (float)0.5 * (float)1.0;
    pPi->Integral.b[0] = (float) 1.0;
    pPi->Integral.b[1] = (float)-1.0;

    pPi->CalcOrder  = 0;
    pPi->BlockInput = (float)0.0;
    pPi->BlockOut   = (float)0.0;
    pPi->d_const    = (float)0.0;
}

// ======================================================================================
void Init_UART_Param( TGyro *gyro )
{
    Sint16 iCounter;

    //gyro->UART_ParamCount      = 15;
    gyro->UART_ParamCount      = 19;
    gyro->UART_SummationCount  = 500;
    gyro->UART_SummationPoint  = 0;
    gyro->UART_SummationCount_invert = (float)1.0 / (float)gyro->UART_SummationCount; 

    memset( gyro->UART_Summation, 0, sizeof(float) * MAXIMUM_UART_DATA );
    memset( gyro->UART_Param    , 0, sizeof(float) * MAXIMUM_UART_DATA );

    gyro->UART_Param[ 0] = &gyro->GyroOut;               // --- Выход гироскопа -----  
    gyro->UART_Param[ 1] = &gyro->Temperature;           // --- Температура -----  
    gyro->UART_Param[ 2] = &gyro->PeriodD.PeriodMiddle;  // --- Средний период колебаний ---
    gyro->UART_Param[ 3] = &gyro->pi_xy1.BlockOut;       // --- Коефициент разночастности ---
    gyro->UART_Param[ 4] = &gyro->Quadrature;            // --- Квадратура ----
    gyro->UART_Param[ 5] = &gyro->pi_ampl_x1.BlockOut;   // --- OMEGA X ---
    gyro->UART_Param[ 6] = &gyro->pi_ampl_y1.BlockOut;   // --- OMEGA Y ---

    gyro->UART_Param[ 7] = &gyro->PhaseD.PhaseError;            // Ошибка стабилизации Фазы
    gyro->UART_Param[ 8] = &gyro->fi_demod_x.BlockOut;   // Ошибка Регулирования канала Х
    gyro->UART_Param[ 9] = &gyro->fi_demod_y.BlockOut;   // Ошибка Регулирования канала У

    gyro->UART_Param[10] = &gyro->XInputMean.BlockOut;   // Среднее значение Х
    gyro->UART_Param[11] = &gyro->YInputMean.BlockOut;   // Среднее значение Y

    gyro->UART_Param[12] = &gyro->Zn_exc_x.zn_curr;         // Фаза возбуждения Анала Х в Тактах алгоритма 
    gyro->UART_Param[13] = &gyro->Zn_exc_y.zn_curr;         // Фаза возбуждения Анала У в Тактах алгоритма 
    gyro->UART_Param[14] = &gyro->Zn_df_x.zn_curr;           // Косинус в Тактах алгоритма 
    gyro->UART_Param[15] = &gyro->Zn_df_y.zn_curr;           // Косинус в Тактах алгоритма 

    gyro->UART_Param[16] = &gyro->SystemPhaseX.BlockOut;               // Фаза Х 
    gyro->UART_Param[17] = &gyro->SystemPhaseY.BlockOut;               // Фаза У

    gyro->UART_Param[18] = &gyro->GyroOut;   // Сырой выход гироскопа
}


