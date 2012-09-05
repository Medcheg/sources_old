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
        {
			im->fTacks = u1 / (u1 - im->u1_old);
			im->isFound = 1;
        }

    /////////////////		   
        if ( im->u2_old < 0 && u2 >= 0 && im->isFound == 1  ) 
        {

            im->fTacks += im->u2_old / (im->u2_old - u2) - (float)1.0;
			
            im->Phase_rad  = (float)TWO_PI * im->fTacks / Period;
            im->Phase_deg  = (float)360.0  * im->fTacks / Period;

            im->isFound = 0;
        }

    /////////////////		   
	  im->u1_old = u1;
      im->u2_old = u2;
	  im->fTacks = im->fTacks + (float)1.0;
}

// *****************************************************************
//
// *****************************************************************
void Calc_Means_Values_for_Correction( TGyro *gyro )
{
    Sint8 iCounter, iCounter_1;

    // ----- Инкриментирую ALGO_FREQUENCY / 10 раз ------
    gyro->cf_Freq.dsumm = gyro->cf_Freq.dsumm + (gyro->rmnk.XFrequency - gyro->DefaultFrequency);
    gyro->cf_Quad.dsumm = gyro->cf_Quad.dsumm + gyro->Quadrature_alfa_q;
    gyro->cf_Temp.dsumm = gyro->cf_Temp.dsumm + gyro->Temperature;
    gyro->cf_Exci.dsumm = gyro->cf_Exci.dsumm + gyro->Excitation_alfa_e;

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
void Run_Demod_RMNK( TRMNK *prmnk, float inX )
{
    float  HQx;
    float  xa2, xb2;
    float  k = 10000.0;

    // ----- 5.0 * TWO_PI * DISCRET_TIME = (float)0.0006283185307179586476925286766559

    prmnk->XPhaseIncriment = prmnk->delta_phi + (float)0.2 * TWO_PI_DISCRET_TIME * prmnk->pi_pll_x2[0] + prmnk->c4;

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

        // ------ фильтрование -----
        Run_LowPass_IRFiltr_1rstOrder( prmnk->fi_Xa,  prmnk->Qx[1]*prmnk->Qx[1] + prmnk->Qx[2]*prmnk->Qx[2] );  
        Run_LowPass_IRFiltr_1rstOrder( prmnk->fi_Xb,  prmnk->Qx[2] );
        //prmnk->fi_Xa[0] = prmnk->Qx[1]*prmnk->Qx[1] + prmnk->Qx[2]*prmnk->Qx[2];
        //prmnk->fi_Xb[0] = prmnk->Qx[2];

        // ------ Регулирование отфильтрованного параметра prmnk->Qx[2] -------
        Run_PiReg_new( prmnk->pi_pll_x1,  prmnk->fi_Xb[0]     );
        Run_PiReg_new( prmnk->pi_pll_x2, -prmnk->pi_pll_x1[0] );
}

// *****************************************************************
// 
// *****************************************************************
float fi = 0;
float a = 2;
void Run_Algo( TGyro *gyro ) 
{
    float cos_freq, sc_argument, local_var;
    Sint8 iCounter;

   // --- 2 ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro );

   // --- 3 ------ Фильтрация входных сигналов ------
    Run_BandPassFiltration_new( gyro->fi_input_x, gyro->in_Ux );
    Run_BandPassFiltration_new( gyro->fi_input_y, gyro->in_Uy );

    //n  = 11.806082729944121810439174471471
    //fi = 30.492756000000000000000000000003
    
   // --- 6 ------- Демодуляция Кориолиса и Квадратуры ---
    Run_Demod( &gyro->fi_demod_x, gyro->fi_input_x[0] * gyro->fi_input_x[0] );
    Run_Demod( &gyro->fi_demod_c, gyro->fi_input_y[0] * sinf( fi ) );
    Run_Demod( &gyro->fi_demod_q, gyro->fi_input_y[0] * cosf( fi ) );//

  // --- 7 ----- Регулирование колебаний амплитуды пучности ----
    Run_PiReg_new( gyro->pi_ampl_1,  gyro->rmnk.fi_Xa[0] );  

   // --- 
    //fi = fi + 0.53219899020725605172717333222976;
        Run_PiReg_new( gyro->pi_corr_1,  gyro->fi_demod_c.BlockOut );   
        Run_PiReg_new( gyro->pi_corr_2, -gyro->pi_corr_1[0] );
        //gyro->pi_corr_2[0] = gyro->pi_corr_1[0];
       
        Run_PiReg_new( gyro->pi_quad_1,  gyro->fi_demod_q.BlockOut );   
        Run_PiReg_new( gyro->pi_quad_2, -gyro->pi_quad_1[0] );
    
    
    fi = fi + TWO_PI / (50000.0 / 4235.1023983226 );
    if ( fi >= TWO_PI ) fi = fi - TWO_PI;
    
    a = a - 5e-7;
    
    gyro->pi_ampl_2[0] = a;
    
    gyro->out_Ux = a*sinf(fi);
    gyro->out_Uy = - gyro->pi_corr_2[0] * cosf(fi + 180.0 * DEG_TO_RAD );
                   + gyro->pi_quad_2[0] * sinf(fi + 180.0 * DEG_TO_RAD );
} 



