#include <string.h>   // ---- Юнит нужен для функции MemMove ----
#include <gclib.h>

#include "pmLibrary.h"
#include "pmSinCos.h"
#include "kff.h"


#include "pmMath.h"
#include "Math.h"



// *****************************************************************
//
// *****************************************************************
void Setup_Zn(TZn *pZn)
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
 
// *****************************************************************
//
// *****************************************************************

void SetupAlgo( TGyro *gyro )
{
  
    float znCoef;
    
    gyro->CurDebugTime = gyro->CurDebugTime + DISCRET_TIME;

    // ------ Запоминаю высоко частотную инфу -------------
    if ( gyro->DebugMode < 5 )
    {
        if ( gyro->DebugTime - gyro->CurDebugTime <= (float)0.2  ) Debug.isInited = 1;
        if ( Debug.isWork == 1 && Debug.isInited == 1 )
        {

            if ( ++Debug.Decimation_counter >= Debug.Decimation )
            {
                Debug.Decimation_counter = 0;
                Debug.param1[ Debug.work_counter ] = *Debug.debug_value  * Debug.debug_coef;

                if ( ++Debug.work_counter >= Debug.work_count )
                {
                    Debug.isSleep      = 1;
                    Debug.isWork       = 0;
                    Debug.work_counter = 0;
                }
            }
        }
    }


    // -------- Включение прижка -----
    if ( gyro->CurDebugTime >= gyro->DebugTime ) 
    {
        *Debug.debug_constant = Debug.cos_Amplitude * cosf( Debug.freq_base + Debug.phi_base );
        
        if ( ++Debug.freq_pass_counter >= Debug.freq_pass_step )
        {
            Debug.freq_pass_counter = 0;
            Debug.freq_base += Debug.freq_incr; 
            if ( Debug.freq_base >=  TWO_PI ) Debug.freq_base -= TWO_PI;
            if ( Debug.freq_base <= -TWO_PI ) Debug.freq_base += TWO_PI;
        }

        if ( ++Debug.freq_incr_counter >= Debug.freq_incr_step )
        {
            Debug.freq_incr_counter = 0;
            Debug.freq_incr        += Debug.freq_incr_value;
        }

    }
}

// *****************************************************************
//
// *****************************************************************
void Run_Demod( TZForm *f, float in )
{
    // ---- Так как в числителе коефициенты семетричны, тогда собираю подобные -------
    f->y[0] = f->a[0]*(in + f->x[3]) + f->a[1]*(f->x[1] + f->x[2]) -
	         (f->b[1]* f->y[1] + f->b[2]*f->y[2] + f->b[3]*f->y[3]);

    // ---------
    f->x[3] = f->x[2];      f->y[3] = f->y[2];
    f->x[2] = f->x[1];      f->y[2] = f->y[1];
    f->x[1] = in;		    f->y[1] = f->y[0];

    f->BlockOut = f->y[0];
    f->x[0] = (float)0.0;
}
/*
// *****************************************************************
//
// *****************************************************************
void Run_PiReg( TPiReg *pPi, float in )
{
    pPi->Integral.x[0] = pPi->m_const - in;

    pPi->Integral.y[0] = pPi->Integral.a[0]*(pPi->Integral.x[0] + pPi->Integral.x[1]) - pPi->Integral.b[1]*pPi->Integral.y[1];

    pPi->diff =  pPi->Kd * (pPi->Integral.x[0] - pPi->Integral.x[1]);

    pPi->Integral.x[1] = pPi->Integral.x[0];
    pPi->Integral.y[1] = pPi->Integral.y[0];
  // ---- End of Integral Calculation ----
    

    pPi->BlockOut  = pPi->diff + pPi->Integral.y[0] + pPi->Integral.x[0] * pPi->Kp;
}
*/
// *****************************************************************
//
// *****************************************************************
float Get_SplineValue( float *buffer, TZn *pZn)
{
    // ---- Базовая реализация сплайна ------
    //double k0 =  1.0 - 1.833333333*t + t*t - 0.1666666667*t*t*t;
    //double k1 =  3.0*t - 2.5*t*t + 0.5*t*t*t;
    //double k2 = -1.5*t + 2.0*t*t - 0.5*t*t*t;
    //double k3 = 0.3333333333*t - 0.5*t*t + 0.1666666667*t*t*t;
    //double Dest2 = 

    float a1 = pZn->k0 * buffer[pZn->zn_i    ];
    float a2 = pZn->k1 * buffer[pZn->zn_i + 1];
    float a3 = pZn->k2 * buffer[pZn->zn_i + 2];
    float a4 = pZn->k3 * buffer[pZn->zn_i + 3];

    return ( a1 + a2 + a3 + a4 );
}

// *****************************************************************
//
// *****************************************************************
void Calc_Period( TPeriodDetector *pd, float inValue )
{
    float LeftPart;
    if ( pd->u_old < 0 && inValue >= 0 ) // --- Если переход через Ноль -----
    {
        // ----- Расчет периода, и его сумирование ------
        LeftPart    = pd->u_old / (pd->u_old - inValue );
        pd->Period  = pd->fTacks + LeftPart - (float)1.0;
        pd->fTacks  = (float)1.0 - LeftPart;

        pd->isNewValuePresent = 1;
    }   
    pd->fTacks = pd->fTacks + (float)1.0;
    pd->u_old  = inValue;
}

// ****************************************************************
//
// ****************************************************************
void Calc_Phase( TPhaseDetector *im, float Period, float u1, float u2 )
{
     /////////////////		   
        if ( im->u1_old < 0 && u1 >= 0 && im->isFound == 0) 
        //if ( im->u1_old < 0 && u1 >= 0 && im->isCanNextFind == 1) 
        {
			im->fTacks = u1 / (u1 - im->u1_old);
			im->isFound = im->isFound + 1;
        }
        //if ( im->u2_old < 0 && u2 >= 0 ) 
        //    im->isCanNextFind = 1;
        
    /////////////////		   
        if ( im->u2_old < 0 && u2 >= 0 && im->isFound >= 1  ) 
        {

            im->fTacks += im->u2_old / (im->u2_old - u2) - (float)1.0;
			
            im->Phase_rad_old = im->Phase_rad;
            im->Phase_rad  = (float)TWO_PI * im->fTacks / Period;
            

            // --- переход в +/- 180
            if ( im->Phase_rad >= (float)ONE_PI ) im->Phase_rad = im->Phase_rad - TWO_PI;
            //if ( im->Phase_rad >= (float)TWO_PI ) im->Phase_rad = im->Phase_rad - (float)2.0*TWO_PI;
            
            im->Phase_deg = im->Phase_rad * RAD_TO_DEG;

            im->isFound = 0;
            im->isNewValuePresent = 1;
            im->isCanNextFind = 1;
        }

    /////////////////		   
	  im->u1_old = u1;
      im->u2_old = u2;
	  im->fTacks = im->fTacks + (float)1.0;
}

// *****************************************************************
//
// *****************************************************************
void Setup_UART_data( TGyro *gyro )
{
    Sint16 iCounter;

    // ------ ДАННЫЕ В UART -------
    for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ )
        if ( gyro->UART_isNeedSummation[iCounter] == 1 ) 
             gyro->UART_Summation[iCounter] += (*gyro->UART_Param[iCounter]);
        else gyro->UART_Summation[iCounter]  = (*gyro->UART_Param[iCounter]);
    

    if ( ++gyro->UART_SummationPoint_OMEGA >= gyro->UART_SummationCount_OMEGA  )
    {
         gyro->pUARTfloats[0]            = gyro->UART_Summation[0] * gyro->UART_Coefs[0] * gyro->UART_SummationCount_OMEGA_invert;
         gyro->UART_Summation[0]         = (float)0.0;
         gyro->UART_SummationPoint_OMEGA = 0;
    }

    if ( ++gyro->UART_SummationPoint >= gyro->UART_SummationCount )
    {
        gyro->isUART_DataPresent  = 1;
        gyro->UART_SummationPoint = 0;

        //===========================================================================
        for ( iCounter = 1; iCounter < gyro->UART_ParamCount; iCounter++ ) 
        {
            if ( gyro->UART_isNeedSummation[iCounter] == 1 ) 
                 gyro->pUARTfloats[iCounter] = gyro->UART_Summation[iCounter] * gyro->UART_Coefs[iCounter] * gyro->UART_SummationCount_invert;
            else gyro->pUARTfloats[iCounter] = gyro->UART_Summation[iCounter] * gyro->UART_Coefs[iCounter]; 
            
            gyro->UART_Summation[iCounter] = (float)0.0;
        }

        
        //===========================================================================
        if ( Debug.isSleep == 1 && Debug.isInited == 1 )
        {
            gyro->pUARTfloats[gyro->UART_ParamCount - 1] = Debug.param1[Debug.work_counter];
            if ( ++Debug.work_counter >= Debug.work_count )
            {
                Debug.isSleep = 0;
                Debug.isWork  = 1;
                Debug.work_counter = 0;
            }
        }
        //===========================================================================
        
    }
}

// *****************************************************************
//
// *****************************************************************
void Run_Demod_RMNK( TRMNK *prmnk, float in )
{
    float  HQx, HQy;
    float  temp = 0;

    // ----- 5.0 * TWO_PI * DISCRET_TIME = (float)0.0006283185307179586476925286766559

    prmnk->PhaseIncriment  = prmnk->delta_phi + (float)0.2 * TWO_PI_DISCRET_TIME * prmnk->pi_pll_2[0] + prmnk->c4;
    //prmnk->PhaseIncriment1 = prmnk->PhaseIncriment - 1.25493659742810834047352517611e-5; // 0.1 Herz

    prmnk->Frequency = prmnk->PhaseIncriment *  TWO_PI_INVERT_ALGO_FREQUENCY;
    prmnk->NCycles   = TWO_PI / prmnk->PhaseIncriment;
    
    prmnk->phi = prmnk->phi + prmnk->PhaseIncriment; 
    
    if ( prmnk->phi >= TWO_PI ) prmnk->phi = prmnk->phi - TWO_PI;

    //prmnk->phi1 = prmnk->phi1 + prmnk->PhaseIncriment1; 
    //if ( prmnk->phi1 >= TWO_PI ) prmnk->phi1 = prmnk->phi1 - TWO_PI;

    prmnk->base_sin  = sinf( prmnk->phi  );
    prmnk->base_cos  = cosf( prmnk->phi  ); 

   // --------------------------------------------
        HQx          = prmnk->Qx[0] + prmnk->base_sin*prmnk->Qx[1] + prmnk->base_cos*prmnk->Qx[2] - in;
        prmnk->Qx[0] = prmnk->Qx[0] - prmnk->MjuX[0] *                   HQx;
        prmnk->Qx[1] = prmnk->Qx[1] - prmnk->MjuX[1] * prmnk->base_sin * HQx;
        prmnk->Qx[2] = prmnk->Qx[2] - prmnk->MjuX[2] * prmnk->base_cos * HQx;

   // ------ фильтрование -----
        //Run_LowPass_IRFiltr_1rstOrder( prmnk->fi_Xa, prmnk->Qx[1]*prmnk->Qx[1] + prmnk->Qx[2]*prmnk->Qx[2] );
        //Run_LowPass_IRFiltr_1rstOrder( prmnk->fi_Xb, prmnk->Qy[2] );

        prmnk->fi_a[0] = prmnk->Qx[1]*prmnk->Qx[1] + prmnk->Qx[2]*prmnk->Qx[2];
        prmnk->fi_b[0] = prmnk->Qx[2];

        // ------ Регулирование отфильтрованного параметра prmnk->Qx[2] -------
        Run_PiReg_new( prmnk->pi_pll_1,  prmnk->fi_b[0] + temp);
        Run_PiReg_new( prmnk->pi_pll_2, -prmnk->pi_pll_1[0] );
}

// *****************************************************************
// 
// *****************************************************************
void Run_Algo( TGyro *gyro ) 
{
    float cos_freq, sc_argument, local_var;
    Sint8 iCounter;

    // --- 1 ------ НАСРОЙКА ПРИБОРА -----
    if ( gyro->DebugMode != 0 ) 
    {
        SetupAlgo( gyro );

        gyro->ExcitationPhaseAG = gyro->Base_ExcitationPhaseAG +     gyro->c5;
        gyro->ExcitationPhase_x = gyro->Base_ExcitationPhase_x + 2.0*gyro->c6;
        gyro->ExcitationPhase_y = gyro->Base_ExcitationPhase_y + 2.0*gyro->c7;

        //if ( gyro->ExcitationPhaseAG < (float)0.0 ) gyro->ExcitationPhaseAG = (float)0.0;
        //if ( gyro->ExcitationPhase_x < (float)0.0 ) gyro->ExcitationPhase_x = (float)0.0;
        //if ( gyro->ExcitationPhase_y < (float)0.0 ) gyro->ExcitationPhase_x = (float)0.0;

		// ---- debug --- Для определения полосы пропускания -----
	    Debug.TempFrequency = ALGO_FREQUENCY / (Debug.freq_incr * TWO_PI_INVERT * ALGO_FREQUENCY);
	    if ( Debug.TempFrequency == 0 ) Debug.TempFrequency = 1;
	    Calc_Phase( &Debug.Phase, Debug.TempFrequency, gyro->c2, - gyro->pi_y_2[0] );
    }

   // --- 2 ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro );

   // --- 3 ------ Фильтрация входных сигналов ------
    Run_BandPassFiltration_new( gyro->fi_input_x, gyro->in_Ux );
    Run_BandPassFiltration_new( gyro->fi_input_y, gyro->in_Uy );

    // ---- Фаза между X, Y ----
    if ( gyro->DebugMode <= 4 ) 
        Calc_Phase( &gyro->Phase, gyro->rmnk_x.NCycles, gyro->fi_input_x[0], gyro->fi_input_y[0] );

    // --- 4 ------ RMNK ------ (R-рекуррентный M-метод N-наименьших K-квадратов)
    Run_Demod_RMNK( &gyro->rmnk_x, gyro->fi_input_x[0] );
    Run_Demod_RMNK( &gyro->rmnk_y, gyro->fi_input_y[0] );
    gyro->DeltaFrequency = (gyro->rmnk_y.PhaseIncriment - gyro->rmnk_x.PhaseIncriment)*TWO_PI_INVERT_ALGO_FREQUENCY;


    // --- 6 ----- Регулирование амплитуд ----
/*    
    gyro->DebugCounter++;
    if ( gyro->isAlgoCounter >= 4 ) 
    {
        gyro->pi_x_1[3] -= (gyro->DebugCoef * 5e-6);
        gyro->pi_y_1[3] += (gyro->DebugCoef * 5e-6);
        
        if ( gyro->DebugCounter >= 100000 )
        {
            gyro->DebugCounter = 0;
            gyro->DebugCoef    = - gyro->DebugCoef;
        }
        
    }
*/
        
    // --- 7 ----- Регулирование амплитуды колебаний Канала Х,Y ----
    Run_PiReg_new( gyro->pi_x_1,  gyro->rmnk_x.fi_a[0] );  
    Run_PiReg_new( gyro->pi_x_2, -gyro->pi_x_1[0]  );
    
    Run_PiReg_new( gyro->pi_y_1,  gyro->rmnk_y.fi_a[0] );  
	Run_PiReg_new( gyro->pi_y_2, -gyro->pi_y_1[0]  );

   // --- 9 -------- Коррекция амплитуд -----
    if ( gyro->pi_x_2[0] > (float) 9.9 ) gyro->pi_x_2[0] = (float) 9.9;
    if ( gyro->pi_x_2[0] < (float)-9.9 ) gyro->pi_x_2[0] = (float)-9.9;
    if ( gyro->pi_y_2[0] > (float) 9.9 ) gyro->pi_y_2[0] = (float) 9.9;
    if ( gyro->pi_y_2[0] < (float)-9.9 ) gyro->pi_y_2[0] = (float)-9.9;

  // --- 8 ------ Если автогениратор отключился Зануляем разночастотность по фазе ----
    
	if ( gyro->isAlgoCounter >= 3 )     
    { 
        //if ( gyro->isAlgoCounter >= 4 ) gyro->BaseAntinodePhase += ( 360.0 * DISCRET_TIME * 0.05 );
        //if ( gyro->BaseAntinodePhase >= 360.0 ) gyro->BaseAntinodePhase -= 360;
        //Run_LowPass_IRFiltr_1rstOrder ( gyro->fi_Phase, gyro->Phase.Phase_rad );
        
        //Run_PiReg_new( gyro->pi_phi_1,   ONE_PI - gyro->Phase.Phase_rad);
        Run_PiReg_new( gyro->pi_phi_1, - gyro->Phase.Phase_rad);
        Run_PiReg_new( gyro->pi_phi_2, - gyro->pi_phi_1[0] );
    }

   // --- 11 ----------- Управляющие сигналы --------------------------
   
    gyro->out_Ux = - (gyro->pi_x_2  [0] + gyro->c1 ) * cosf( gyro->rmnk_x.phi + gyro->ExcitationPhase_x )
                   -  gyro->pi_phi_2[0] * 1.0        * sinf( gyro->rmnk_x.phi + gyro->ExcitationPhase_x );
                   
    gyro->out_Uy = - (gyro->pi_y_2  [0] + gyro->c2 ) * cosf( gyro->rmnk_y.phi + gyro->ExcitationPhase_y )
                   +  gyro->pi_phi_2[0] * 1.0        * sinf( gyro->rmnk_y.phi + gyro->ExcitationPhase_y ); 
                   
                
    //gyro->out_Uy = (float)0.0;
    gyro->GyroOut    = (float)0.5 * (gyro->pi_x_2[0] - gyro->pi_y_2[0]);
    gyro->Quadrature = (float)0.5 * (gyro->pi_x_2[0] + gyro->pi_y_2[0]);

    // ----- Если сканироваение Стартовой фазы, зануляюcь ------
    if ( gyro->DebugMode == 5 ) gyro->out_Uy = 0;
    if ( gyro->DebugMode == 6 ) gyro->out_Uy = 0;
    if ( gyro->DebugMode == 7 ) gyro->out_Ux = 0;

    // --- 12 ----------- Счетчик и флаг запуска 0.4 сек --------
    gyro->AlgoCounter++;
    if ( gyro->AlgoCounter >=  gyro->StartUpTime  ) gyro->isAlgoCounter = 2;
    if ( gyro->AlgoCounter >=  50000              ) gyro->isAlgoCounter = 3;
    if ( gyro->AlgoCounter >= 500000              ) gyro->isAlgoCounter = 4;
    
   // ******************************************
   // *** 13 **** Разгон(Старт) Гирика *********
   // ******************************************
    Calc_Period( &gyro->rmnk_x.ANodePeriod, gyro->fi_input_x[0] );
    if ( gyro->isAlgoCounter < 2 || gyro->DebugMode == 5 ) 
    {
        // --- Расчет простого периода колебаний системы
        // --- и перенос начального значения инкримента фазы в RMNK ---
        gyro->rmnk_x.delta_phi = TWO_PI / gyro->rmnk_x.ANodePeriod.Period;
        gyro->rmnk_y.delta_phi = gyro->rmnk_x.delta_phi;

        // -- ФАЗА (Задержка) АГ (перасчет для режима сканирование) ----
        if ( gyro->DebugMode == 5 ) 
        {
            gyro->Zn_exc.zn_curr = gyro->DefaultPeriod * gyro->ExcitationPhaseAG * TWO_PI_INVERT;
            Setup_Zn(&gyro->Zn_exc);
        }

        // ---- Скользящий буфера -----
    	memmove(&gyro->XBuffer[1], gyro->XBuffer, 100); 
    	gyro->XBuffer[0] = - gyro->fi_input_x[0];
        
        local_var    = Get_SplineValue( gyro->XBuffer, &gyro->Zn_exc);
        gyro->out_Ux = ( local_var >= (float)0.0 ) ? gyro->pi_x_2[0] : -gyro->pi_x_2[0];
        gyro->out_Uy = (float)0.0;
    }


   // ******************************************
   // ***  14  *****   Отладка *****************
   // ******************************************
    if ( gyro->DebugMode == 0 ) 
    {   // ------ Debug -----
        if ( Debug.init_counter++ >= Debug.init_count ) Debug.isInited = 1;
        if ( Debug.isWork == 1 && Debug.isInited == 1 )
        {
            Debug.param1[ Debug.work_counter ] = *Debug.debug_value;

            if ( ++Debug.work_counter >= Debug.work_count )
            {
                Debug.isSleep      = 1;
                Debug.isWork       = 0;
                Debug.work_counter = 0;
            }
        }
    }
} 



