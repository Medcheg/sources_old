#include <21364.h>
#include <sysreg.h>
//#include <stdio.h>
//#include <def21364.h>
//#include <cdef21364.h>
//#include <gclib.h>

#include <string.h>   // ---- Юнит нужен для функции MemMove ----

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
    if ( gyro->DebugMode < 6 )
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

    f->BlockOut = f->y[0] * (float)1e-4;
    f->x[0] = (float)0.0;
}

// *****************************************************************
//
// *****************************************************************
void Run_PiReg( TPiReg *pPi, float in )
{
    pPi->Integral.x[0] = pPi->m_const - in;

    pPi->Integral.y[0] = pPi->Integral.a[0]*(pPi->Integral.x[0] + pPi->Integral.x[1]) - pPi->Integral.b[1]*pPi->Integral.y[1];
    pPi->Integral.x[1] = pPi->Integral.x[0];
    pPi->Integral.y[1] = pPi->Integral.y[0];
  // ---- End of Integral Calculation ----

    pPi->BlockOut  = pPi->Integral.y[0] + pPi->Integral.x[0] * pPi->Kp;
}
 
// *****************************************************************
//
// *****************************************************************
void Run_PiReg_New_2( float *pi_reg, float in )
{
    pi_reg[5] = pi_reg[3] - in;
    pi_reg[7] = pi_reg[4]*(pi_reg[5] + pi_reg[6]) + pi_reg[8];
    pi_reg[6] = pi_reg[5];
    pi_reg[8] = pi_reg[7];
    pi_reg[0] = pi_reg[7] + pi_reg[5]*pi_reg[1];

    pi_reg[15] = pi_reg[13] + pi_reg[0];
    pi_reg[17] = pi_reg[14]*(pi_reg[15] + pi_reg[16]) + pi_reg[18];
    pi_reg[16] = pi_reg[15];
    pi_reg[18] = pi_reg[17];
    pi_reg[10] = pi_reg[17] + pi_reg[15]*pi_reg[11];
}

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
void Input_Filtration_short( TZForm *f, float inValue )
{
    // ----- Результат выполнения фильтра в BlockOut    
    f->BlockOut = f->a[0]*(inValue - f->x[2]) - f->b[1]*f->y[1] - f->b[2]*f->y[2];

    // ----- Сдиговый буфер -----
	f->x[2] = f->x[1];
	f->x[1] = inValue;
	f->y[2] = f->y[1];
	f->y[1] = f->BlockOut;
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
    }   
    pd->fTacks = pd->fTacks + (float)1.0;
    pd->u_old  = inValue;
}

// *****************************************************************
//
// *****************************************************************
void Calc_Means_Values_for_Correction( TGyro *gyro )
{
    Sint8 iCounter, iCounter_1;

    // ----- Инкриментирую ALGO_FREQUENCY / 10 раз ------
    gyro->cf_Freq.dsumm += (gyro->rmnk.XFrequency - gyro->DefaultFrequency);
    gyro->cf_Quad.dsumm += gyro->Quadrature_alfa_q;
    gyro->cf_Temp.dsumm += gyro->Temperature;
    gyro->cf_Exci.dsumm += gyro->Excitation_alfa_e;

    if ( ++gyro->MainSum_counter < ALGO_FREQUENCY_DIV_10 ) return;

    gyro->MainSum_counter = 0;
    
    // ----- Двигаю бухвер --- ТОЛлько если проиничены, зачем лишнюю работу делать ----
    if ( gyro->isMainSumInited == 1 ) 
    {
        #pragma vector_for
        for ( iCounter = 9; iCounter >= 1; iCounter --)
        {
            iCounter_1 = iCounter - 1;
            //gyro->cf_Freq.mean_buffer[iCounter] = gyro->cf_Freq.mean_buffer[ iCounter_1 ];
            gyro->cf_Quad.mean_buffer[iCounter] = gyro->cf_Quad.mean_buffer[ iCounter_1 ];
            gyro->cf_Temp.mean_buffer[iCounter] = gyro->cf_Temp.mean_buffer[ iCounter_1 ];
            gyro->cf_Exci.mean_buffer[iCounter] = gyro->cf_Exci.mean_buffer[ iCounter_1 ];
        }
    }

    // ----- Получаю новое значение ------
    gyro->cf_Freq.mean_buffer[0] = gyro->cf_Freq.dsumm * ALGO_FREQUENCY_DIV_10_INVERT;
    gyro->cf_Quad.mean_buffer[0] = gyro->cf_Quad.dsumm * ALGO_FREQUENCY_DIV_10_INVERT;
    gyro->cf_Temp.mean_buffer[0] = gyro->cf_Temp.dsumm * ALGO_FREQUENCY_DIV_10_INVERT;
    gyro->cf_Exci.mean_buffer[0] = gyro->cf_Exci.dsumm * ALGO_FREQUENCY_DIV_10_INVERT;

    // ------ Жду инита Суммы, (2 такт суммы) ------
    if ( gyro->isMainSumInited == 0 ) 
    {
        if ( ++gyro->MainSumInit_counter >= 2 ) gyro->isMainSumInited = 1;

        for ( iCounter = 9; iCounter >= 1; iCounter --)
        {
            //gyro->cf_Freq.mean_buffer[iCounter] = gyro->cf_Freq.mean_buffer[0];
            gyro->cf_Quad.mean_buffer[iCounter] = gyro->cf_Quad.mean_buffer[0];
            gyro->cf_Temp.mean_buffer[iCounter] = gyro->cf_Temp.mean_buffer[0];
            gyro->cf_Exci.mean_buffer[iCounter] = gyro->cf_Exci.mean_buffer[0];
        }
    }

    // ----- туту считаю среднее буфера -----
    //gyro->cf_Freq.dsumm = gyro->cf_Freq.mean_buffer[0];
    gyro->cf_Quad.dsumm = gyro->cf_Quad.mean_buffer[0];
    gyro->cf_Temp.dsumm = gyro->cf_Temp.mean_buffer[0];
    gyro->cf_Exci.dsumm = gyro->cf_Exci.mean_buffer[0];

    for ( iCounter = 9; iCounter >= 1; iCounter --)
    {
        //gyro->cf_Freq.dsumm += gyro->cf_Freq.mean_buffer[iCounter];
        gyro->cf_Quad.dsumm += gyro->cf_Quad.mean_buffer[iCounter];
        gyro->cf_Temp.dsumm += gyro->cf_Temp.mean_buffer[iCounter];
        gyro->cf_Exci.dsumm += gyro->cf_Exci.mean_buffer[iCounter];
    }

    // ---- Выход блока -----
    //gyro->cf_Freq.BlockOut = gyro->cf_Freq.dsumm * (float)0.1 + gyro->DefaultFrequency;
    gyro->cf_Freq.BlockOut = gyro->cf_Freq.mean_buffer[0] + gyro->DefaultFrequency;
    gyro->cf_Quad.BlockOut = gyro->cf_Quad.dsumm * (float)0.1;
    gyro->cf_Temp.BlockOut = gyro->cf_Temp.dsumm * (float)0.1;
    gyro->cf_Exci.BlockOut = gyro->cf_Exci.dsumm * (float)0.1;
    
    // ----- Обнуление входных сумм -----
    gyro->cf_Freq.dsumm = (float)0.0;
    gyro->cf_Quad.dsumm = (float)0.0;
    gyro->cf_Temp.dsumm = (float)0.0;
    gyro->cf_Exci.dsumm = (float)0.0;

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
 
    if ( ++gyro->UART_SummationPoint >= gyro->UART_SummationCount )
    {
        gyro->isUART_DataPresent  = 1;
        gyro->UART_SummationPoint = 0;

        //===========================================================================
        for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ ) 
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
void Run_Demod_RMNK( TRMNK *prmnk, float inX )
{
    float  HQx;
    float  xa2, xb2;

    // ----- 5.0 * TWO_PI * DISCRET_TIME = (float)0.0006283185307179586476925286766559
    prmnk->XPhaseIncriment = prmnk->delta_phi + (float)0.0006283185307179586476925286766559 * prmnk->pi_pll_x2.BlockOut + prmnk->c4;
    prmnk->XFrequency      = prmnk->XPhaseIncriment *  TWO_PI_INVERT_ALGO_FREQUENCY;

    prmnk->x_phi = prmnk->x_phi + prmnk->XPhaseIncriment; 
    if ( prmnk->x_phi >= TWO_PI ) prmnk->x_phi = prmnk->x_phi - TWO_PI;

    prmnk->x_base_sin = sinf( prmnk->x_phi );
    prmnk->x_base_cos = cosf( prmnk->x_phi ); 

    // --------------------------------------------
        HQx          = prmnk->Qx[0] + prmnk->x_base_sin*prmnk->Qx[1] + prmnk->x_base_cos*prmnk->Qx[2] - inX;
        prmnk->Qx[0] = prmnk->Qx[0] - prmnk->MjuX[0] *                     HQx;
        prmnk->Qx[1] = prmnk->Qx[1] - prmnk->MjuX[1] * prmnk->x_base_sin * HQx;
        prmnk->Qx[2] = prmnk->Qx[2] - prmnk->MjuX[2] * prmnk->x_base_cos * HQx;

        // ------ фильтрование КВАДРАТа ПУЧНОСТИ -----
        xa2 = prmnk->Qx[1]*prmnk->Qx[1] + prmnk->Qx[2]*prmnk->Qx[2];
        xb2 = sqrtf(xa2);

        Run_Z2Coef( &prmnk->fi_Xa, xb2 );  

        // ------ фильтрованный КВАДРАТ ПУЧНОСТИ  -------
        prmnk->XAmpl = prmnk->fi_Xa.BlockOut;

        // ------ фильтрация -------
        Run_Z2Coef( &prmnk->fi_Xb,  prmnk->Qx[2] );

        // ------ Регулирование отфильтрованного параметра prmnk->Qx[2] -------
        Run_PiReg( &prmnk->pi_pll_x1,  prmnk->fi_Xb.BlockOut     );
        Run_PiReg( &prmnk->pi_pll_x2, -prmnk->pi_pll_x1.BlockOut );
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

        gyro->ExcitationPhaseAG = gyro->Base_ExcitationPhaseAG + gyro->c5;
        gyro->ExcitationPhase   = gyro->Base_ExcitationPhase   + gyro->c6;

        if ( gyro->ExcitationPhaseAG < (float)0.0 ) gyro->ExcitationPhaseAG = (float)0.0;
        if ( gyro->ExcitationPhase   < (float)0.0 ) gyro->ExcitationPhase   = (float)0.0;

        // ----- Если сканироваение Стартовой фазы, зануляю УЗЕЛ ------
        if ( gyro->DebugMode == 6 ) gyro->in_Uy = 0;
    }

   // --- 2 ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro );

   // --- 3 Фильтрация входных сигналов ------
    Input_Filtration_short( &gyro->fi_input_x , gyro->in_Ux );
    Input_Filtration_short( &gyro->fi_input_y , gyro->in_Uy );

   // --- 4 ------ RMNK ------ (R-рекуррентный M-метод N-наименьших K-квадратов)
    Run_Demod_RMNK( &gyro->rmnk, gyro->fi_input_x.BlockOut );

   // --- 5 ------ Амплитуда КОЛебаний канала У -----
    if ( gyro->Y_minVal > gyro->fi_input_y.BlockOut ) gyro->Y_minVal = gyro->fi_input_y.BlockOut;
    if ( gyro->Y_maxVal < gyro->fi_input_y.BlockOut ) gyro->Y_maxVal = gyro->fi_input_y.BlockOut;
    if ( ++gyro->Y_CountSumCounter >= gyro->Y_CountSumValues )
    {
        gyro->rmnk.YAmpl =  (float)0.5 * (gyro->Y_maxVal - gyro->Y_minVal);
        gyro->Y_CountSumCounter = 0;
        gyro->Y_minVal = (float) 0.0;
        gyro->Y_maxVal = (float) 0.0;
    }
   
   // --- 6 ------- Демодуляция Кориолиса и Квадратуры ---
    Run_Demod( &gyro->fi_demod_c, - gyro->fi_input_y.BlockOut * gyro->rmnk.x_base_sin );
    Run_Demod( &gyro->fi_demod_q, - gyro->fi_input_y.BlockOut * gyro->rmnk.x_base_cos );//

  // --- 7 ----- Регулирование колебаний амплитуды пучности ----
    //Run_PiReg( &gyro->pi_am_1,  gyro->rmnk.XAmpl       );  
    //Run_PiReg( &gyro->pi_am_2, -gyro->pi_am_1.BlockOut );

      Run_PiReg_New(gyro->pi_ampl_1, gyro->rmnk.XAmpl    );
      Run_PiReg_New(gyro->pi_ampl_2, -gyro->pi_ampl_1[0] );
//       Run_PiReg_New_2(gyro->pi_ampl_1, gyro->rmnk.XAmpl);

    gyro->pi_am_2.BlockOut = gyro->pi_ampl_2[0];

  // --- 8 ------ Если автогениратор отключился тогда переходим на компенсирование узла
    if ( gyro->isAlgoCounter >= 2 ) 
    { 
        Run_PiReg( &gyro->pi_om_1,  gyro->fi_demod_c.BlockOut );   
        Run_PiReg( &gyro->pi_om_2, -gyro->pi_om_1   .BlockOut );
        
        Run_PiReg( &gyro->pi_si_1,  gyro->fi_demod_q.BlockOut );   
        Run_PiReg( &gyro->pi_si_2, -gyro->pi_si_1   .BlockOut );

        gyro->pi_om_2.BlockOut = gyro->pi_om_1.BlockOut;
        gyro->pi_si_2.BlockOut = gyro->pi_si_1.BlockOut;
    }

   // --- 9 -------- Коррекция амплитуд -----
    if ( gyro->pi_am_2.BlockOut > (float) 9.9 ) gyro->pi_am_2.BlockOut = (float) 9.9;
    if ( gyro->pi_am_2.BlockOut < (float)-9.9 ) gyro->pi_am_2.BlockOut = (float)-9.9;
    if ( gyro->pi_om_2.BlockOut > (float) 9.9 ) gyro->pi_om_2.BlockOut = (float) 9.9;
    if ( gyro->pi_om_2.BlockOut < (float)-9.9 ) gyro->pi_om_2.BlockOut = (float)-9.9;
    if ( gyro->pi_si_2.BlockOut > (float) 9.9 ) gyro->pi_si_2.BlockOut = (float) 9.9;
    if ( gyro->pi_si_2.BlockOut < (float)-9.9 ) gyro->pi_si_2.BlockOut = (float)-9.9;

   // --- 10-------- формирование гармонических сигналов ------------
    gyro->cos_exc  = cosf( gyro->rmnk.x_phi + gyro->ExcitationPhase   );//+ gyro->pi_fi_q2.BlockOut
    gyro->cos_comp = cosf( gyro->rmnk.x_phi + gyro->CompensationPhase );
    gyro->sin_comp = sinf( gyro->rmnk.x_phi + gyro->CompensationPhase + gyro->PhiQPhase );//  //

   // --- 11 ----------- Управляющие сигналы --------------------------
    gyro->GyroOutRaw = gyro->k_Omega * gyro->pi_om_2.BlockOut;
    gyro->out_Ux     = - (gyro->pi_am_2.BlockOut + gyro->c1) * gyro->cos_exc;
    gyro->out_Uy     = - (gyro->pi_om_2.BlockOut + gyro->c2) * gyro->cos_comp + (gyro->pi_si_2.BlockOut + gyro->c3) * gyro->sin_comp;
    gyro->out_Uy    *=   gyro->isCompensationPresent; 


    gyro->DebugParamT += DISCRET_TIME;
    //gyro->DebugParam = gyro->DebugParamK * (float)0.002 * gyro->DebugParamT * gyro->DebugParamT;
    //gyro->DebugParam = gyro->DebugParamK * (float)0.033333333333333333333333333333333 * gyro->DebugParamT;
/*
    gyro->c2 = gyro->DebugParam;
    if ( gyro->DebugParam >=  7.0 ) 
    {
        gyro->DebugParamK *= (float)-1.0;
        gyro->DebugParamT = (double)0.0;

    }
    if ( gyro->DebugParam <= -7.0 ) 
    {
        gyro->DebugParamK *= (float)-1.0;
        gyro->DebugParamT = (double)0.0;
    }
*/

    //if ( gyro->isAlgoCounter >= 3 ) 
    if ( gyro->DebugParamT >= 13 && gyro->DebugParamT <= 14 ) gyro->pi_anti_1[3] = -gyro->pi_om_2.BlockOut;
    if ( gyro->DebugParamT >= 15 ) 
    {
        
        Run_PiReg_New(gyro->pi_anti_1, -gyro->pi_om_2.BlockOut );
        Run_PiReg_New(gyro->pi_anti_2, -gyro->pi_anti_1[0] );

        gyro->NULL_value = gyro->pi_anti_1[5];

        //gyro->pi_ampl_1[3] = X_ampl + (float)gyro->pi_anti_1[0] * (float)gyro->pi_anti_1[0];
        gyro->pi_ampl_1[3] = X_ampl + (float)gyro->pi_anti_2[0] * (float)gyro->pi_anti_2[0];
    }


   // --- 12 ----------- Счетчик и флаг запуска 0.4 сек --------
    if ( ++gyro->AlgoCounter >= 20000  ) gyro->isAlgoCounter = 2;
    if ( ++gyro->AlgoCounter >= 500000 ) gyro->isAlgoCounter = 3;

   // ******************************************
   // *** 13 **** Разгон(Старт) Гирика *********
   // ******************************************
    if ( gyro->isAlgoCounter < 2 || gyro->DebugMode == 6 ) 
    {
        // --- Расчет простого периода колебаний системы
        // --- и перенос начального значения инкримента фазы в RMNK ---
        Calc_Period( &gyro->rmnk.ANodePeriod, gyro->fi_input_x.BlockOut );
        gyro->rmnk.delta_phi = TWO_PI / gyro->rmnk.ANodePeriod.Period;

        // -- ФАЗА (Задержка) АГ (перасчет для режима сканирование) ----
        if ( gyro->DebugMode == 6 ) 
        {
            gyro->Zn_exc.zn_curr = gyro->DefaultPeriod * gyro->ExcitationPhaseAG * TWO_PI_INVERT;
            Setup_Zn(&gyro->Zn_exc);
        }

        // ---- Скользящий буфера -----
    	memmove(&gyro->XBuffer[1], gyro->XBuffer, 100); 
    	gyro->XBuffer[0] = - gyro->fi_input_x.BlockOut;
        
        local_var    = Get_SplineValue( gyro->XBuffer, &gyro->Zn_exc);
        gyro->out_Ux = ( local_var >= (float)0.0 ) ? gyro->pi_am_2.BlockOut : -gyro->pi_am_2.BlockOut;
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


   // --- 15 ---------  Усреднение главных параметров ---------
    Calc_Means_Values_for_Correction( gyro );

   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   // ---- 16 --------- Пошаговая система расчета коррекций ------------
    if ( ++gyro->CorrectionOrderCalc >= 50 ) gyro->CorrectionOrderCalc = 0;

    if ( gyro->CorrectionOrderCalc == 0 )
    {
        gyro->f1 = gyro->cf_Freq.BlockOut - corr_f0;
        gyro->f2 = gyro->f1*gyro->f1;     
        gyro->f3 = gyro->f1*gyro->f2;     
        gyro->f4 = gyro->f1*gyro->f3;     
        gyro->f5 = gyro->f1*gyro->f4;     
        gyro->f6 = gyro->f1*gyro->f5;     
    }
    if ( gyro->CorrectionOrderCalc == 1 )
    {
        gyro->q1 = gyro->cf_Quad.BlockOut - corr_q0;
        gyro->q2 = gyro->q1*gyro->q1;     
        gyro->q3 = gyro->q1*gyro->q2;     
        gyro->q4 = gyro->q1*gyro->q3;     
        gyro->q5 = gyro->q1*gyro->q4;     
        gyro->q6 = gyro->q1*gyro->q5;     
    }
    if ( gyro->CorrectionOrderCalc == 2 )
    {
        gyro->e1 = gyro->cf_Exci.BlockOut - corr_e0;
        gyro->e2 = gyro->e1*gyro->e1;     
        gyro->e3 = gyro->e1*gyro->e2;     
        gyro->e4 = gyro->e1*gyro->e3;     
        gyro->e5 = gyro->e1*gyro->e4;     
        gyro->e6 = gyro->e1*gyro->e5;     
    }
    if ( gyro->CorrectionOrderCalc == 3 )
    {
        gyro->t1 = gyro->cf_Temp.BlockOut - corr_t0;
        gyro->t2 = gyro->t1*gyro->t1;     
        gyro->t3 = gyro->t1*gyro->t2;     
        gyro->t4 = gyro->t1*gyro->t3;     
        gyro->t5 = gyro->t1*gyro->t4;     
        gyro->t6 = gyro->t1*gyro->t5;     
    }

    // **************************************************************************************
    if ( gyro->isMainSumInited == 0 ) return;

    // ------- Коррекции влияющие на СИСТЕМУ управления -------
    if ( gyro->CorrectionOrderCalc == 4 )
    { // ------ Полосовик -------
         cos_freq              = -(float)2.0 * cosf(gyro->cf_Freq.BlockOut * TWO_PI_DISCRET_TIME);// 
         gyro->fi_input_x.b[1] = cos_freq * gyro->filter_invertValue_x;
         gyro->fi_input_y.b[1] = cos_freq * gyro->filter_invertValue_y;
    }

    // **************************************************************************************
    if ( gyro->CorrectionOrderCalc == 6 && gyro->isXPhase_corr == 1 )
    { 
        gyro->ExcitationPhase = corr_x_ph_a0 + corr_x_ph_a1 * gyro->f1 + corr_x_ph_a2 * gyro->f2;
    }
    // **************************************************************************************
    if ( gyro->CorrectionOrderCalc == 7 && gyro->isYPhase_corr == 1 )
    { 
        gyro->CompensationPhase = gyro->Base_CompensationPhase + gyro->k_Omega * (corr_y_ph_a0 + corr_y_ph_a1*gyro->f1 + corr_y_ph_a2*gyro->f2);
    }


    // ------- ПОСТ Коррекции не влияющие на СИСТЕМУ управления -------
    // **************************************************************************************
    if ( gyro->CorrectionOrderCalc == 8 && gyro->isAlfaE_f_corr == 1 )
    { 
        sc_argument  = corr_e_f0 + corr_e_f1*gyro->f1 + corr_e_f2*gyro->f2;

        gyro->corr_sin_alfa_e = sinf(sc_argument);
        gyro->corr_cos_alfa_e = cosf(sc_argument);
    }
    if ( gyro->CorrectionOrderCalc == 9 && gyro->isAlfaE_t_corr == 1 )
    { 
        sc_argument  = corr_e_t0 + corr_e_t1*gyro->t1 + corr_e_t2*gyro->t2;

        gyro->corr_sin_alfa_e = sinf(sc_argument);
        gyro->corr_cos_alfa_e = cosf(sc_argument);
    }
    if ( gyro->CorrectionOrderCalc == 10 && gyro->isAlfaQ_f_corr == 1 )
    { 
        sc_argument = corr_q_f0 + corr_q_f1*gyro->f1 + corr_q_f2*gyro->f2;

        gyro->corr_sin_alfa_q = sinf(sc_argument);
        gyro->corr_cos_alfa_q = cosf(sc_argument);
    }
    if ( gyro->CorrectionOrderCalc == 11 && gyro->isAlfaQ_t_corr == 1 )
    { 
        sc_argument = corr_q_t0 + corr_q_t1*gyro->t1 + corr_q_t2*gyro->t2;

        gyro->corr_sin_alfa_q = sinf(sc_argument);
        gyro->corr_cos_alfa_q = cosf(sc_argument);
    }

    // **************************************************************************************
    if ( gyro->CorrectionOrderCalc == 12 && gyro->isStatic1_corr == 1 )
    {
        gyro->GyroOut_corr_st1 = corr_g0 + corr_st1_f1*gyro->f1 + corr_st1_f2*gyro->f2 + corr_st1_f3*gyro->f3 + corr_st1_f4*gyro->f4 + corr_st1_f5*gyro->f5 + corr_st1_f6*gyro->f6
                                         + corr_st1_e1*gyro->e1 + corr_st1_e2*gyro->e2 + corr_st1_e3*gyro->e3 + corr_st1_e4*gyro->e4 + corr_st1_e5*gyro->e5 + corr_st1_e6*gyro->e6
                                         + corr_st1_q1*gyro->q1 + corr_st1_q2*gyro->q2 + corr_st1_q3*gyro->q3 + corr_st1_q4*gyro->q4 + corr_st1_q5*gyro->q5 + corr_st1_q6*gyro->q6
                                         + corr_st1_t1*gyro->t1 + corr_st1_t2*gyro->t2 + corr_st1_t3*gyro->t3 + corr_st1_t4*gyro->t4 + corr_st1_t5*gyro->t5 + corr_st1_t6*gyro->t6;
    }

    // **************************************************************************************
    if ( gyro->CorrectionOrderCalc == 13 && gyro->isStatic2_corr == 1 )
    {
        gyro->GyroOut_corr_st2 = corr_g1 + corr_st2_f1*gyro->f1 + corr_st2_f2*gyro->f2 + corr_st2_f3*gyro->f3 + corr_st2_f4*gyro->f4 + corr_st2_f5*gyro->f5 + corr_st2_f6*gyro->f6
                                         + corr_st2_e1*gyro->e1 + corr_st2_e2*gyro->e2 + corr_st2_e3*gyro->e3 + corr_st2_e4*gyro->e4 + corr_st2_e5*gyro->e5 + corr_st2_e6*gyro->e6
                                         + corr_st2_q1*gyro->q1 + corr_st2_q2*gyro->q2 + corr_st2_q3*gyro->q3 + corr_st2_q4*gyro->q4 + corr_st2_q5*gyro->q5 + corr_st2_q6*gyro->q6
                                         + corr_st2_t1*gyro->t1 + corr_st2_t2*gyro->t2 + corr_st2_t3*gyro->t3 + corr_st2_t4*gyro->t4 + corr_st2_t5*gyro->t5 + corr_st2_t6*gyro->t6;
    }
    // **************************************************************************************
    if ( gyro->CorrectionOrderCalc == 14 && gyro->isDynamic_corr == 1 )
    {
        sc_argument       =   corr_mk1_f1 * gyro->f1 + corr_mk1_f2 * gyro->f2 + corr_mk1_f3 * gyro->f3
                            + corr_mk1_e1 * gyro->e1 + corr_mk1_e2 * gyro->e2 + corr_mk1_e3 * gyro->e3
                            + corr_mk1_q1 * gyro->q1 + corr_mk1_q2 * gyro->q2 + corr_mk1_q3 * gyro->q3
                            + corr_mk1_t1 * gyro->t1 + corr_mk1_t2 * gyro->t2 + corr_mk1_t3 * gyro->t3;
        gyro->GyroOut_MK1 = corr_mk0 / sc_argument;
    }

    // ***** 17 ******** Выход ГИРОСКОПА ********
        // ------ Альфа Е Коррекция ------
        gyro->Excitation_alfa_e = gyro->pi_am_2.BlockOut * gyro->corr_cos_alfa_e - gyro->GyroOutRaw       * gyro->corr_sin_alfa_e;
        gyro->GyroOut_alfa_e    = gyro->GyroOutRaw       * gyro->corr_cos_alfa_e + gyro->pi_am_2.BlockOut * gyro->corr_sin_alfa_e;

        // ------ Альфа Q Коррекция ------
        gyro->Quadrature_alfa_q = gyro->pi_si_2.BlockOut * gyro->corr_cos_alfa_q - gyro->GyroOut_alfa_e    * gyro->corr_sin_alfa_q;
        gyro->GyroOut_alfa_q    = gyro->GyroOut_alfa_e   * gyro->corr_cos_alfa_q + gyro->pi_si_2.BlockOut  * gyro->corr_sin_alfa_q;

        // ------ Остаточная коррекция (сюда должны входить все виды коррекции, статика1, динамика1, статика 2)------
        gyro->GyroOut_corr = (gyro->GyroOut_alfa_q - gyro->GyroOut_corr_st1) * gyro->GyroOut_MK1 - gyro->GyroOut_corr_st2;
        gyro->GyroOut_corr = gyro->GyroOut_alfa_q + gyro->fi_demod_c.BlockOut;
} 



