#include "pmMath.h"
#include <string.h>   // ---- Юнит нужен для функции MemMove ----
#include <gclib.h>
#include "math.h"
#include "kff.h"


float Get_SliderMean_bad( TSliderMean *sm, float inValue );
void  CalcInputMean( TInputMean *im, float inValue, Sint8 isZeroWait );

//*****************************************************************
//
//*****************************************************************
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
 
//*****************************************************************
//
//*****************************************************************
void SetupAlgo( TGyro *gyro )
{
    float znCoef;

    gyro->CurDebugTime = gyro->CurDebugTime + DISCRET_TIME;

    Setup_Zn(&gyro->Zn_exc);
    Setup_Zn(&gyro->Zn_sin2);
    Setup_Zn(&gyro->Zn_cos1);
    Setup_Zn(&gyro->Zn_cos2);

    if ( gyro->CurDebugTime < gyro->DebugTime ) return;

    if ( gyro->DebugMode == 1 ) gyro->pi_am_1.d_const = Aa;
    if ( gyro->DebugMode == 2 ) gyro->pi_om_1.d_const = Ac;
    if ( gyro->DebugMode == 3 ) gyro->pi_si_1.d_const = Aq;
    if ( gyro->DebugMode == 7 ) 
    {
        if ( gyro->DebugCounter++ >= 8 )
        {
            gyro->DebugCounter = 0;
            //gyro->Zn_exc.zn_curr     += (float)0.000001;
            gyro->ExcitationPhase += (float)0.0001;
        }

        //znCoef = gyro->Zn_exc.zn_curr * gyro->Zn_exc .zn_base;
        //gyro->Zn_sin2.zn_curr = znCoef * gyro->Zn_sin2.zn_base;
        //gyro->Zn_cos1.zn_curr = znCoef * gyro->Zn_cos1.zn_base;
        //gyro->Zn_cos2.zn_curr = znCoef * gyro->Zn_cos2.zn_base;
    }
}

//*****************************************************************
//
//*****************************************************************
float Get_SliderMean_bad( TSliderMean *sm, float inValue )
{
/*
    float  summ;
    Sint16 i;

    summ = 0;
    for ( i = sm->SliderBuffLength-1; i > 0; i--) 
    {
        sm->SliderBuffer[i] = sm->SliderBuffer[i-1];
        summ = summ + sm->SliderBuffer[i];
    }

    sm->SliderBuffer[0] = inValue;
    summ = summ + sm->SliderBuffer[0];
 
    return summ * sm->SliderBuffLength_invert;
*/
    float retValue;


    if ( sm->SliderBuffPosition > sm->SliderBuffLength-1 ) 
    {
        sm->isSliderBufferInited = 1;
        sm->SliderBuffPosition   = 0;
    }

    // ----- Если не проиничены ------- 
    if ( sm->isSliderBufferInited == 0 )
    {
        sm->SliderBuffer[sm->SliderBuffPosition] =  inValue;
        sm->SliderBufferSumm  = sm->SliderBufferSumm + inValue;
    
        retValue = sm->SliderBufferSumm * sm->SliderBuffer_invertSumm[sm->SliderBuffPosition];
    }
    else
    {
        sm->SliderBufferSumm = sm->SliderBufferSumm - sm->SliderBuffer[sm->SliderBuffPosition_old];
        sm->SliderBufferSumm = sm->SliderBufferSumm + inValue;
        sm->SliderBuffer[sm->SliderBuffPosition] = inValue;

        retValue = sm->SliderBufferSumm * sm->SliderBuffLength_invert;
    }

    sm->SliderBuffPosition_old = sm->SliderBuffPosition;
    sm->SliderBuffPosition++;

    return retValue;
}

//*****************************************************************
//
//*****************************************************************
void Run_Demod( TZForm *f, float in )
{
    // ---- Так как в числителе коефициенты семетричны, тогда собираю подобные -------
    f->y[0] = f->a[0]*(in + f->x[3]) + f->a[1]*(f->x[1] + f->x[2]) -
	         (f->b[1]* f->y[1] + f->b[2]*f->y[2] + f->b[3]*f->y[3]);

    // ---------
    f->x[3] = f->x[2];      f->y[3] = f->y[2];
    f->x[2] = f->x[1];      f->y[2] = f->y[1];
    f->x[1] = in;		    f->y[1] = f->y[0];

    f->BlockOut = f->y[0] * 1e-6;
    f->x[0] = (float)0.0;
}

//*****************************************************************
//
//*****************************************************************
void Run_Z3Coef( TZForm *f, float in )
{
    // ---- Так как в числителе коефициенты семетричны, тогда собираю подобные -------
    f->y[0] = f->a[0]*in + f->a[1]*f->x[1] + f->a[2]*f->x[2] - (f->b[1]* f->y[1] + f->b[2]*f->y[2]);

    // ---------
    f->x[2] = f->x[1];      f->y[2] = f->y[1];
    f->x[1] = in;		    f->y[1] = f->y[0];

    f->BlockOut = f->y[0];
}


//*****************************************************************
//
//*****************************************************************
void Run_Z4Coef( TZForm *f, float in )
{
    // ---- Так как в числителе коефициенты семетричны, тогда собираю подобные -------
    f->y[0] = f->a[0]*in + f->a[1]*f->x[1] + f->a[2]*f->x[2] + f->a[3]*f->x[3] -
	         (f->b[1]* f->y[1] + f->b[2]*f->y[2] + f->b[3]*f->y[3]);

    // ---------
    f->x[3] = f->x[2];      f->y[3] = f->y[2];
    f->x[2] = f->x[1];      f->y[2] = f->y[1];
    f->x[1] = in;		    f->y[1] = f->y[0];

    f->BlockOut = f->y[0];
}

//*****************************************************************
//
//*****************************************************************
void Run_Z5Coef( TZForm *f, float in )
{
    // ---- Так как в числителе коефициенты семетричны, тогда собираю подобные -------
    f->y[0] = f->a[0]*in + f->a[1]*f->x[1] + f->a[2]*f->x[2] + f->a[3]*f->x[3]  + f->a[4]*f->x[4]-
	         (f->b[1]* f->y[1] + f->b[2]*f->y[2] + f->b[3]*f->y[3] + f->b[4]*f->y[4]);

    // ---------
    f->x[4] = f->x[3];      f->y[4] = f->y[3];
    f->x[3] = f->x[2];      f->y[3] = f->y[2];
    f->x[2] = f->x[1];      f->y[2] = f->y[1];
    f->x[1] = in;		    f->y[1] = f->y[0];

    f->BlockOut = f->y[0];
}

//*****************************************************************
//
//*****************************************************************
void Run_PiReg( TPiReg *pPi, float in )
{
  // ---- Integral Calculation ----
    pPi->Integral.x[0] = (float)1000.0 * (pPi->m_const + pPi->d_const - in);

    pPi->Integral.y[0] = pPi->Integral.a[0]*(pPi->Integral.x[0] + pPi->Integral.x[1]) - pPi->Integral.b[1]*pPi->Integral.y[1];
    pPi->Integral.x[1] = pPi->Integral.x[0];
    pPi->Integral.y[1] = pPi->Integral.y[0];
  // ---- End of Integral Calculation ----

    pPi->BlockOut  = pPi->Integral.y[0] + pPi->Integral.x[0] * pPi->Kp;
    pPi->BlockOut *= (float)0.001;
}
 
//*****************************************************************
//
//*****************************************************************
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

    return a1 + a2 + a3 + a4;
}

//*****************************************************************
//
//*****************************************************************

void Input_Filtration_short( TZForm *f, float inValue )
{
    f->BlockOut = f->a[0] * (inValue - f->x[2]) - f->b[1] * f->y[1] - f->b[2] * f->y[2];

	f->x[2] = f->x[1];
	f->x[1] = inValue;
	f->y[2] = f->y[1];
	f->y[1] = f->BlockOut;
}

void Input_Filtration( TGyro *gyro )
{
	// --------- X Canal -----------
    gyro->fi_input_x.BlockOut =   gyro->fi_input_x.a[0] * (gyro->in_Ux - gyro->fi_input_x.x[2])
                                - gyro->fi_input_x.b[1] * gyro->fi_input_x.y[1]
                                - gyro->fi_input_x.b[2] * gyro->fi_input_x.y[2];

	gyro->fi_input_x.x[2] = gyro->fi_input_x.x[1];
	gyro->fi_input_x.x[1] = gyro->in_Ux;
	gyro->fi_input_x.y[2] = gyro->fi_input_x.y[1];
	gyro->fi_input_x.y[1] = gyro->fi_input_x.BlockOut;

	// --------- Y Canal -----------
    gyro->fi_input_y.BlockOut =   gyro->fi_input_y.a[0] * (gyro->in_Uy - gyro->fi_input_y.x[2])
                                - gyro->fi_input_y.b[1] *  gyro->fi_input_y.y[1]
                                - gyro->fi_input_y.b[2] *  gyro->fi_input_y.y[2];

	gyro->fi_input_y.x[2] = gyro->fi_input_y.x[1];
	gyro->fi_input_y.x[1] = gyro->in_Uy;
	gyro->fi_input_y.y[2] = gyro->fi_input_y.y[1];
	gyro->fi_input_y.y[1] = gyro->fi_input_y.BlockOut;

}


//*****************************************************************
//
//*****************************************************************
void CalcInputMean( TInputMean *im, float inValue, Sint8 isZeroWait )
{
    if ( (im->u_old < 0 && inValue >= 0) || isZeroWait == 0 )
    {
        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            //im->DeltaMean  = Get_SliderMean( &im->sm, im->CurSumm / (float)im->SummCounter );
            im->DeltaMean  = im->CurSumm / (float)im->SummCounter;

            im->CurSumm         = (float)0.0;
            im->PeriodCounter   = 0;
            im->SummCounter     = 0;

            im->GlobalMean = im->DeltaMean;
        }
    }   
    im->CurSumm     = im->CurSumm + inValue;
    im->SummCounter = im->SummCounter + 1;
    im->u_old       = inValue;
}

//*****************************************************************
//
//*****************************************************************
void Setup_UART_data( TGyro *gyro )
{
    Sint16 iCounter;

    // ------ ДАННЫЕ В UART -------
    for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ )
        gyro->UART_Summation[iCounter] += (*gyro->UART_Param[iCounter]);
 
    if ( ++gyro->UART_SummationPoint >= gyro->UART_SummationCount )
    {

        for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ ) 
        {
            gyro->pUARTfloats[iCounter]    = gyro->UART_Summation[iCounter] * gyro->UART_SummationCount_invert * gyro->UART_Coefs[iCounter];
            gyro->UART_Summation[iCounter] = (float)0.0;
        }
        gyro->isUART_DataPresent  = 1;
        gyro->UART_SummationPoint = 0;


        //===========================================================================
        //===========================================================================
        //===========================================================================
        //===========================================================================
        if ( Debug.isSleep == 1 && Debug.isInited == 1 )
        {
            gyro->pUARTfloats[gyro->UART_ParamCount - 3] = Debug.param1[Debug.work_counter];
            gyro->pUARTfloats[gyro->UART_ParamCount - 2] = Debug.param2[Debug.work_counter];
            gyro->pUARTfloats[gyro->UART_ParamCount - 1] = Debug.param3[Debug.work_counter];

            if ( ++Debug.work_counter >= Debug.work_count )
            {
                Debug.isSleep = 0;
                Debug.isWork  = 1;
                Debug.work_counter = 0;
            }
        }
        else
        {
            gyro->pUARTfloats[gyro->UART_ParamCount - 3] = Debug.param1[Debug.work_count - 3];
            gyro->pUARTfloats[gyro->UART_ParamCount - 2] = Debug.param1[Debug.work_count - 2];
            gyro->pUARTfloats[gyro->UART_ParamCount - 1] = Debug.param2[Debug.work_count - 1];
        }
        //===========================================================================
        //===========================================================================
        //===========================================================================
        //===========================================================================
    }
}

//****************************************************************
//
//****************************************************************
void Calc_Phase( TInputMean *im, float per, float per_inv, Sint8 isPhase_p000_p360, float u1, float u2 )
{
    float CurPhase;

    /////////////////		   
        if ( im->u1_old < 0 && u1 >= 0 && im->isFound == 0) 
        {
			im->fTacks = u1 / (u1 - im->u1_old);
			im->isFound = 1;
        }

    /////////////////		   
        if ( im->u2_old < 0 && u2 >= 0 && im->isFound == 1  ) 
        {

            CurPhase = im->fTacks + im->u2_old / (im->u2_old - u2) - (float)1.0;
            if ( CurPhase >= (float)0.5 * per && isPhase_p000_p360 == 0 ) CurPhase = CurPhase - per;
			im->CurSumm = im->CurSumm + CurPhase;
			im->isFound = 0;

/*
                im->GlobalMean = per_inv * im->CurSumm;
                im->Phase_rad  = (float)TWO_PI * im->GlobalMean;
                im->Phase_deg  = (float)360.0  * im->GlobalMean;

                im->CurSumm       = (float) 0.0;
                im->PeriodCounter = 0;
                im->isNewValuePresent = 1;
*/

            if ( ++im->PeriodCounter >= im->PeriodCount )
            {
                im->GlobalMean = per_inv * (im->CurSumm * im->PeriodCount_invert);
                im->Phase_rad  = (float)TWO_PI * im->GlobalMean;
                im->Phase_deg  = (float)360.0  * im->GlobalMean;

                im->CurSumm       = (float) 0.0;
                im->PeriodCounter = 0;
                im->isNewValuePresent = 1;
            }
        }

    /////////////////		   
	  im->u1_old = u1;
      im->u2_old = u2;
	  im->fTacks = im->fTacks + (float)1.0;
}

//*****************************************************************
//
//*****************************************************************
void Calc_Period( TPeriodDetector *pd, float inValue )
{
    float LeftPart, in_filtr_value;
    if ( pd->u_old < 0 && inValue >= 0 ) // --- Если переход через Ноль -----
    {
        // ----- Расчет периода, и его сумирование ------
        LeftPart = pd->u_old / (pd->u_old - inValue );
        pd->CurSumm = pd->CurSumm + pd->fTacks + LeftPart - (float)1.0;
        pd->fTacks  = (float)1.0 - LeftPart;

        if ( ++pd->PeriodCounter >= pd->PeriodCountSumm )
        {
            in_filtr_value = pd->CurSumm * pd->PeriodCountSumm_invert;

            Run_Z5Coef( &pd->fi_period, in_filtr_value ); 

            //if ( ABS( in_filtr_value - pd->fi_period.BlockOut ) >  0.001) pd->fi_period.BlockOut = in_filtr_value;

            pd->Period              = pd->fi_period.BlockOut;
            pd->Period_invert       = (float)1.0 / pd->Period;
            pd->pll_phase_incriment = pd->Period_invert * TWO_PI;

            pd->CurSumm           = (float)0.0;
            pd->PeriodCounter     = 0;
            pd->isNewValuePresent = 1;
        }


    }   

    pd->fTacks = pd->fTacks + (float)1.0;
    pd->u_old  = inValue;
}

//*****************************************************************
//
//*****************************************************************
void Mul_Matrix(Sint16 aRows1, Sint16 aCol1, float *m1,
                Sint16 aRows2, Sint16 aCol2, float *m2, float *out_Matrix)
{
  //  -   умножение двух матриц A (MxN) и B (KxL), определено только для N=K. C=AB. => C - матрица размерности MxL.
    Sint16 i, j, k, row_index1;
    float value;
/*

    for( i = 0; i < aRows1; i++ )
    {
        row_index1 = i*aCol1;
        for( j = 0; j < aCol2; j++ ) 
        {
             value = 0;
             for ( k = 0; k < aRows2; k++ )
                  value += m1[row_index1 + k]*m2[k*aCol2 + j];

             out_Matrix[i*aCol2 + j] = value;
        }
    }
*/

    for( i = 0; i < aRows1; i++)
        for( j = 0; j < aCol2; j++) 
        {
             value = 0;
             for ( k = 0; k < aRows2; k++)
                  value += m1[i*aCol1 + k]*m2[k*aCol2 + j];

             out_Matrix[i*aCol2 + j] = value;
        }

}

//*****************************************************************
//
//*****************************************************************
void Run_Demod_RMNK( TRMNK *rmnk, float inX, float inY, float inX_raw, float inY_raw )
{
    float  temp_9[9];
    float  p_num [9];
    float  temp_3[3];
    float  temp_1[1];
    float  temp_x[1], temp_y[1], temp_x_raw[1], temp_y_raw[1];
    float  div_value; 
    Sint16 z;

    // ---- Инкримент фазы ------
    rmnk->phi = rmnk->phi + rmnk->delta_phi;
    if ( rmnk->phi >= TWO_PI ) rmnk->phi = rmnk->phi - TWO_PI;
    if ( rmnk->phi <  0      ) rmnk->phi = rmnk->phi + TWO_PI;

    rmnk->h[0] = (float)1.0;
    rmnk->h[1] = sinf(rmnk->phi);
    rmnk->h[2] = cosf(rmnk->phi);

/*
    //if ( rmnk->P[0] < (float)0.00001 )  rmnk->P[0] = (float)0.001;
    //if ( rmnk->P[4] < (float)0.00001 )  rmnk->P[4] = (float)0.001;
    //if ( rmnk->P[8] < (float)0.00001 )  rmnk->P[8] = (float)0.001;

//    inX = 1.5*cos(1.0001*rmnk->phi) + 0.0001*cos(2.2*rmnk->phi);
//    inX = inX_raw;

    rmnk->Ph[0] = rmnk->P[0]*rmnk->h[0] + rmnk->P[1]*rmnk->h[1] + rmnk->P[2]*rmnk->h[2];
    rmnk->Ph[1] = rmnk->P[3]*rmnk->h[0] + rmnk->P[4]*rmnk->h[1] + rmnk->P[5]*rmnk->h[2];
    rmnk->Ph[2] = rmnk->P[6]*rmnk->h[0] + rmnk->P[7]*rmnk->h[1] + rmnk->P[8]*rmnk->h[2];

    temp_9[0] = rmnk->Ph[0] * rmnk->h[0];
    temp_9[1] = rmnk->Ph[0] * rmnk->h[1];
    temp_9[2] = rmnk->Ph[0] * rmnk->h[2];

    temp_9[3] = rmnk->Ph[1] * rmnk->h[0];
    temp_9[4] = rmnk->Ph[1] * rmnk->h[1];
    temp_9[5] = rmnk->Ph[1] * rmnk->h[2];

    temp_9[6] = rmnk->Ph[2] * rmnk->h[0];
    temp_9[7] = rmnk->Ph[2] * rmnk->h[1];
    temp_9[8] = rmnk->Ph[2] * rmnk->h[2];

    p_num[0] = temp_9[0]*rmnk->P[0] + temp_9[1]*rmnk->P[3] + temp_9[2]*rmnk->P[6];
    p_num[1] = temp_9[0]*rmnk->P[1] + temp_9[1]*rmnk->P[4] + temp_9[2]*rmnk->P[7];
    p_num[2] = temp_9[0]*rmnk->P[2] + temp_9[1]*rmnk->P[5] + temp_9[2]*rmnk->P[8];

    p_num[3] = temp_9[3]*rmnk->P[0] + temp_9[4]*rmnk->P[3] + temp_9[5]*rmnk->P[6];
    p_num[4] = temp_9[3]*rmnk->P[1] + temp_9[4]*rmnk->P[4] + temp_9[5]*rmnk->P[7];
    p_num[5] = temp_9[3]*rmnk->P[2] + temp_9[4]*rmnk->P[5] + temp_9[5]*rmnk->P[8];

    p_num[6] = temp_9[6]*rmnk->P[0] + temp_9[7]*rmnk->P[3] + temp_9[8]*rmnk->P[6];
    p_num[7] = temp_9[6]*rmnk->P[1] + temp_9[7]*rmnk->P[4] + temp_9[8]*rmnk->P[7];
    p_num[8] = temp_9[6]*rmnk->P[2] + temp_9[7]*rmnk->P[5] + temp_9[8]*rmnk->P[8];

    temp_3[0] = rmnk->h[0]*rmnk->P[0] + rmnk->h[1]*rmnk->P[3] + rmnk->h[2]*rmnk->P[6];
    temp_3[1] = rmnk->h[0]*rmnk->P[1] + rmnk->h[1]*rmnk->P[4] + rmnk->h[2]*rmnk->P[7];
    temp_3[2] = rmnk->h[0]*rmnk->P[2] + rmnk->h[1]*rmnk->P[5] + rmnk->h[2]*rmnk->P[8];

    temp_1[0] = temp_3[0]*rmnk->h[0] + temp_3[1]*rmnk->h[1] + temp_3[2]*rmnk->h[2];

    div_value = (float)1.0 / ((float)1.0 + temp_1[0]);
    //for ( z = 0; z < 9; z++) rmnk->P[z] = rmnk->P[z] - p_num[z] * div_value ;
    rmnk->P[0] = rmnk->P[0] - p_num[0] * div_value;
    rmnk->P[1] = rmnk->P[1] - p_num[1] * div_value;
    rmnk->P[2] = rmnk->P[2] - p_num[2] * div_value;

    rmnk->P[3] = rmnk->P[3] - p_num[3] * div_value;
    rmnk->P[4] = rmnk->P[4] - p_num[4] * div_value;
    rmnk->P[5] = rmnk->P[5] - p_num[5] * div_value;

    rmnk->P[6] = rmnk->P[6] - p_num[6] * div_value;
    rmnk->P[7] = rmnk->P[7] - p_num[7] * div_value;
    rmnk->P[8] = rmnk->P[8] - p_num[8] * div_value;

   // ====================== QQQQQQQQQQQQQQQQQQQQQQQQQQQ =============================
    temp_x    [0] = rmnk->h[0]*rmnk->Qx    [0] + rmnk->h[1]*rmnk->Qx    [1] + rmnk->h[2]*rmnk->Qx    [2];
    temp_y    [0] = rmnk->h[0]*rmnk->Qy    [0] + rmnk->h[1]*rmnk->Qy    [1] + rmnk->h[2]*rmnk->Qy    [2];
    temp_x_raw[0] = rmnk->h[0]*rmnk->Qx_raw[0] + rmnk->h[1]*rmnk->Qx_raw[1] + rmnk->h[2]*rmnk->Qx_raw[2];
    temp_y_raw[0] = rmnk->h[0]*rmnk->Qy_raw[0] + rmnk->h[1]*rmnk->Qy_raw[1] + rmnk->h[2]*rmnk->Qy_raw[2];

    rmnk->Ph[0] = rmnk->P[0]*rmnk->h[0] + rmnk->P[1]*rmnk->h[1] + rmnk->P[2]*rmnk->h[2];
    rmnk->Ph[1] = rmnk->P[3]*rmnk->h[0] + rmnk->P[4]*rmnk->h[1] + rmnk->P[5]*rmnk->h[2];
    rmnk->Ph[2] = rmnk->P[6]*rmnk->h[0] + rmnk->P[7]*rmnk->h[1] + rmnk->P[8]*rmnk->h[2];

    rmnk->Qx[0] = rmnk->Qx[0] - rmnk->Ph[0]*(temp_x[0] - inX);
    rmnk->Qx[1] = rmnk->Qx[1] - rmnk->Ph[1]*(temp_x[0] - inX);
    rmnk->Qx[2] = rmnk->Qx[2] - rmnk->Ph[2]*(temp_x[0] - inX);

    rmnk->Qy[0] = rmnk->Qy[0] - rmnk->Ph[0]*(temp_y[0] - inY);
    rmnk->Qy[1] = rmnk->Qy[1] - rmnk->Ph[1]*(temp_y[0] - inY);
    rmnk->Qy[2] = rmnk->Qy[2] - rmnk->Ph[2]*(temp_y[0] - inY);

    rmnk->Qx_raw[0] = rmnk->Qx_raw[0] - rmnk->Ph[0]*(temp_x_raw[0] - inX_raw);
    rmnk->Qx_raw[1] = rmnk->Qx_raw[1] - rmnk->Ph[1]*(temp_x_raw[0] - inX_raw);
    rmnk->Qx_raw[2] = rmnk->Qx_raw[2] - rmnk->Ph[2]*(temp_x_raw[0] - inX_raw);
    rmnk->Qy_raw[0] = rmnk->Qy_raw[0] - rmnk->Ph[0]*(temp_y_raw[0] - inY_raw);
    rmnk->Qy_raw[1] = rmnk->Qy_raw[1] - rmnk->Ph[1]*(temp_y_raw[0] - inY_raw);
    rmnk->Qy_raw[2] = rmnk->Qy_raw[2] - rmnk->Ph[2]*(temp_y_raw[0] - inY_raw);
*/

    Mul_Matrix(3, 3, rmnk->P , 3, 1, rmnk->h, rmnk->Ph );
    Mul_Matrix(3, 1, rmnk->Ph, 1, 3, rmnk->h, temp_9   );
    Mul_Matrix(3, 3, temp_9  , 3, 3, rmnk->P, p_num    );
    Mul_Matrix(1, 3, rmnk->h , 3, 3, rmnk->P, temp_3   );
    Mul_Matrix(1, 3, temp_3  , 3, 1, rmnk->h, temp_1   );
    div_value = (float)1.0 / ((float)1.0 + temp_1[0]);
    for ( z = 0; z < 9; z++) rmnk->P[z] = rmnk->P[z] - p_num[z] * div_value ;

    Mul_Matrix(1, 3, rmnk->h, 3, 1, rmnk->Qx, temp_x );
    Mul_Matrix(3, 3, rmnk->P, 3, 1, rmnk->h, rmnk->Ph );
    for ( z = 0; z < 3; z++) rmnk->Qx[z] = rmnk->Qx[z] - rmnk->Ph[z] * (temp_x[0] - inX );

    rmnk->x2Ampl = sqrtf(rmnk->Qx[1]*rmnk->Qx[1] + rmnk->Qx[2]*rmnk->Qx[2]);
    //rmnk->x2Ampl = (rmnk->Qx[1]*rmnk->Qx[1] + rmnk->Qx[2]*rmnk->Qx[2]);
}

//*****************************************************************
//
//*****************************************************************
void Run_Algo( TGyro *gyro ) 
{
    float sin_base, sin_demod, cos_demod, sin_exc, sin_comp, cos_comp, sin_base_k, ss;
    float    arg_sin, arg_sin2, sin1, sin2, cos1, cos2, re1, re2, im1, im2, sqrt_filtr_nu, sqrt_filtr_de;

    // ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro );

   // ----- Фильтрация входных сигнаов ------
    Input_Filtration_short( &gyro->fi_input_x , gyro->in_Ux * gyro->in_Kx );
    Input_Filtration_short( &gyro->fi_input_y , gyro->in_Uy * gyro->in_Ky );

    // ---- У амлп ----
    if ( gyro->minVal > gyro->fi_input_y.BlockOut  ) gyro->minVal = gyro->fi_input_y.BlockOut;
    if ( gyro->maxVal < gyro->fi_input_y.BlockOut  ) gyro->maxVal = gyro->fi_input_y.BlockOut;

   // ---- У амлп ----
    if ( ++gyro->YAmpl_Counter >= 100 )
    {
        gyro->YAmplitude = (gyro->maxVal - gyro->minVal) * (float)0.5;
        gyro->minVal  = (float) 10000.0;
        gyro->maxVal  = (float)-10000.0;
        gyro->YAmpl_Counter = 0;
    }

   // ---- Период Колебаний ----- 
    Calc_Period( &gyro->ANodePeriod, gyro->fi_input_x.BlockOut );   // ----- Расчет периода коледаний ------

                // ----- PLL PLL PLL PLL PLL --------
                gyro->pll_phase        = gyro->ANodePeriod.pll_phase_incriment + (float)0.001 * gyro->pi_phase_base.BlockOut;
                gyro->ANodePeriod.pll_phase = gyro->ANodePeriod.pll_phase + gyro->pll_phase;
                if ( gyro->ANodePeriod.pll_phase >= TWO_PI ) gyro->ANodePeriod.pll_phase -= TWO_PI;
                // ====
                sin_base  = sinf( gyro->ANodePeriod.pll_phase);
                // ====
                Calc_Phase( &gyro->GPhase, gyro->SinPeriod, gyro->SinPeriod_invert, 0, gyro->in_Ux,  sin_base );

                if ( gyro->GPhase.isNewValuePresent == 1 )
                {
                    gyro->GPhase.isNewValuePresent = 0;
                    Run_PiReg( &gyro->pi_phase_base, -gyro->GPhase.Phase_rad );
                    // ----
                    
                    gyro->Frequency        = gyro->pll_phase * ALGO_FREQUENCY * TWO_PI_INVERT;
                    gyro->SinPeriod        = ALGO_FREQUENCY / gyro->Frequency;
                    gyro->SinPeriod_invert = gyro->Frequency * DISCRET_TIME;


                    // =============================
                    // ========    KF         ======
                    // =============================
                    if ( gyro->DebugMode != 7 && gyro->isAlgoCounter != 1) //gyro->isPhaseCorrectionPresent == 1 && 
                    {   
                        arg_sin  = gyro->pll_phase;
                        arg_sin2 = (float)2.0 * gyro->pll_phase;
                        sin1     = sinf(arg_sin );
                        sin2     = sinf(arg_sin2);
                        cos1     = cosf(arg_sin );
                        cos2     = cosf(arg_sin2);

                        re1 =   gyro->fi_input_x.a[0] + gyro->fi_input_x.a[2]*cos2;
                        re2 =   gyro->fi_input_x.b[0] + gyro->fi_input_x.b[1]*cos1 + gyro->fi_input_x.b[2]*cos2;
                        im1 = - gyro->fi_input_x.a[2]*sin2;
                        im2 = - gyro->fi_input_x.b[1]*sin1 - gyro->fi_input_x.b[2]*sin2;

                        sqrt_filtr_nu = re1*re1 + im1*im1;
                        sqrt_filtr_de = re2*re2 + im2*im2;


                        if ( sqrt_filtr_de != (float)0.0 )
                            if ( sqrt_filtr_nu * sqrt_filtr_de > 0 )
                            {   
                                Run_Z4Coef( &gyro->fi_KxKy, (float)1.0 / sqrt((re1*re1 + im1*im1)/(re2*re2 + im2*im2)) );
                                gyro->in_Kx = gyro->fi_KxKy.BlockOut;
                                gyro->in_Ky = gyro->in_Kx;
                                gyro->KFiltr1 = gyro->in_Kx;
                            }
                    }


                }

    Input_Filtration_short( &gyro->fi_input_x1, sin_base );
    ss = sinf( gyro->ANodePeriod.pll_phase - gyro->BPFPhase.Phase_rad );
    if ( ss > (float)0.1 || ss < (float)-0.1) gyro->KFiltr2 = ss / gyro->fi_input_x1.BlockOut;
    

    // =============================
    // ========    BPF        ======
    // =============================
    Calc_Phase( &gyro->BPFPhase, gyro->SinPeriod, gyro->SinPeriod_invert, 0, sin_base, gyro->fi_input_x.BlockOut );
    sin_demod = sinf( gyro->ANodePeriod.pll_phase - gyro->BPFPhase.Phase_rad );
    cos_demod = cosf( gyro->ANodePeriod.pll_phase - gyro->BPFPhase.Phase_rad );

    // =============================
    // ========    XPhase     ======
    // =============================
    Calc_Phase ( &gyro->XPhase , gyro->SinPeriod, gyro->SinPeriod_invert, 1, gyro->out_Ux, sin_base );
    if ( gyro->XPhase.isNewValuePresent == 1 )
    {
        gyro->XPhase.isNewValuePresent = 0;
        Run_PiReg( &gyro->pi_XPhase, gyro->XPhase.Phase_rad - (float)119.984188 * DEG_TO_RAD );
        
        gyro->X_Phase_Algo = gyro->ExcitationPhase  *DEG_TO_RAD + gyro->pi_XPhase.BlockOut * gyro->K_XPhase;
        //gyro->Y_Phase_Algo = gyro->CompensationPhase*DEG_TO_RAD + gyro->pi_XPhase.BlockOut;
        gyro->Y_Phase_Algo = gyro->CompensationPhase*DEG_TO_RAD;

    }
    
   // ----- Демодулирование ------
    Run_Demod( &gyro->fi_demod_a , gyro->fi_input_x.BlockOut * sin_demod );
    Run_Demod( &gyro->fi_demod_c , gyro->fi_input_y.BlockOut * sin_demod );
    Run_Demod( &gyro->fi_demod_q , gyro->fi_input_y.BlockOut * cos_demod );

    Run_PiReg( &gyro->pi_am_1, gyro->fi_demod_a.BlockOut );  Run_PiReg( &gyro->pi_am_2, -gyro->pi_am_1.BlockOut );
    Run_PiReg( &gyro->pi_om_1, gyro->fi_demod_c.BlockOut );  Run_PiReg( &gyro->pi_om_2, -gyro->pi_om_1.BlockOut );
    Run_PiReg( &gyro->pi_si_1, gyro->fi_demod_q.BlockOut );  Run_PiReg( &gyro->pi_si_2, -gyro->pi_si_1.BlockOut );

    // -------- Коррекция амплитуд -----
    if ( gyro->pi_am_2.BlockOut > (float) 9.5 ) gyro->pi_am_2.BlockOut = (float) 9.5;
    if ( gyro->pi_am_1.BlockOut < (float)-9.5 ) gyro->pi_am_2.BlockOut = (float)-9.5;
    if ( gyro->pi_om_2.BlockOut > (float) 9.5 ) gyro->pi_om_2.BlockOut = (float) 9.5;
    if ( gyro->pi_om_1.BlockOut < (float)-9.5 ) gyro->pi_om_2.BlockOut = (float)-9.5;
    if ( gyro->pi_si_2.BlockOut > (float) 9.5 ) gyro->pi_si_2.BlockOut = (float) 9.5;
    if ( gyro->pi_si_1.BlockOut < (float)-9.5 ) gyro->pi_si_2.BlockOut = (float)-9.5;

    
    // -------- Управляющие сигналы ------------
    sin_exc  = sinf( gyro->ANodePeriod.pll_phase + gyro->X_Phase_Algo );
    sin_comp = sinf( gyro->ANodePeriod.pll_phase + gyro->Y_Phase_Algo );
    cos_comp = cosf( gyro->ANodePeriod.pll_phase + gyro->Y_Phase_Algo );

    gyro->GyroOutRaw = (float)gyro->pi_om_2.BlockOut;
    gyro->GyroOut    = (float)gyro->pi_om_2.BlockOut;
    gyro->out_Ux     = gyro->pi_am_2.BlockOut * sin_exc;
    gyro->out_Uy     = gyro->pi_om_2.BlockOut * cos_comp;
    gyro->out_Uy    -= gyro->pi_si_2.BlockOut * sin_comp;

    //----------- Разгон резонатора --------------------------
    gyro->AlgoCounter++;
    if (   gyro->AlgoCounter   >= 10000 ) gyro->isAlgoCounter = 2; 
    if (   gyro->AlgoCounter   >= 100000 ) gyro->isAlgoCounter = 3;  
    if (   gyro->isAlgoCounter <= 2 )
    {
        // ---- Скользящий буфера -----
    	memmove(&gyro->XBuffer[1], gyro->XBuffer, 100); 

    	gyro->XBuffer[0] = gyro->fi_input_x.BlockOut * gyro->pi_am_1.m_const_invert;
        gyro->out_Ux     = ( gyro->XBuffer[ gyro->Zn_exc.zn_i ] >= (float)0.0 ) ? gyro->pi_am_2.BlockOut : -gyro->pi_am_2.BlockOut;
    }


    // ------ ОТЛАДКА -----
    if ( gyro->DebugMode != 0 ) SetupAlgo( gyro );


    // ------ Debug -----
    if ( Debug.init_counter++ >= Debug.init_count ) Debug.isInited = 1;

    if ( Debug.isWork == 1 && Debug.isInited == 1 )
    {
        Debug.param1[ Debug.work_counter ] = gyro->in_Ux;
        Debug.param2[ Debug.work_counter ] = sin_demod; //gyro->fi_input_x.BlockOut;//gyro->RMNK.phi;//mod_s2;//gyro->out_Uy;
        Debug.param3[ Debug.work_counter ] = gyro->fi_input_x.BlockOut;//;//gyro->RMNK.phi;//mod_s2;//gyro->out_Uy;

        if ( ++Debug.work_counter >= Debug.work_count )
        {
            Debug.isSleep      = 1;
            Debug.isWork       = 0;
            Debug.work_counter = 0;
        }
    }
} 
