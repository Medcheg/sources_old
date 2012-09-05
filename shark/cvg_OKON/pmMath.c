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
    
void SetupAlgo( TGyro *gyro, TZn *Zn_exc, TZn *Zn_sin2,TZn *Zn_cos2, TZn *Zn_cos1 )
{
    float znCoef;

    gyro->CurDebugTime = gyro->CurDebugTime + DISCRET_TIME;

    Setup_Zn( Zn_exc  );
    Setup_Zn( Zn_cos1 );
    Setup_Zn( Zn_sin2 );
    Setup_Zn( Zn_cos2 );
   
    if ( gyro->CurDebugTime < gyro->DebugTime ) return;

    if ( gyro->DebugMode == 1 ) gyro->pi_am_1.d_const = Aa;
    if ( gyro->DebugMode == 2 ) gyro->pi_om_1.d_const = Ac;
    if ( gyro->DebugMode == 3 ) gyro->pi_si_1.d_const = Aq;
    if ( gyro->DebugMode == 7 ) 
    {
        if ( gyro->DebugCounter++ >= 8 )
        {
            gyro->DebugCounter = 0;
            Zn_exc->zn_curr += (float)0.000001;
        }
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
void Calc_Phase_180 ( TPhaseDetector *pd, float u1, float u2 )
{

        if ( pd->u1_old < 0 && u1 >= 0 && pd->isNewPhasePresent == 0 ) 
        {
			pd->fTacks = u1 / (u1 - pd->u1_old);
			pd->isFound = 0;
        }
    /////////////////		   
        if ( pd->u1_old > 0 && u1 <= 0 && pd->isNewPhasePresent == 0 ) 
        {
			pd->fTacks1 = pd->fTacks + pd->u1_old / (pd->u1_old - u1);

			if ( pd->isFound == 1 ) 
			{
			    pd->PhaseError = pd->fTacks1 - pd->fTacks2;
			    pd->isNewPhasePresent = 1;
			}
			pd->isFound = 1;
        }
    /////////////////		   
        if ( pd->u2_old > 0 && u2 <= 0 && pd->isNewPhasePresent == 0 ) 
        {
			pd->fTacks2 = pd->fTacks + pd->u2_old / (pd->u2_old - u2);

			if ( pd->isFound == 1 ) 
			{
			    pd->PhaseError = pd->fTacks1 - pd->fTacks2;
			    pd->isNewPhasePresent = 1;
			}
			pd->isFound = 1;
        }

	  pd->u1_old = u1;
      pd->u2_old = u2;
	  pd->fTacks = pd->fTacks + (float)1.0;
}

//****************************************************************
//****************************************************************
//****************************************************************
void Get_PhaseInvert_180( TPhaseDetector *pPD, float u1, float u2)
{
        if ( pPD->u1_old < 0 && u1 >= 0 && pPD->isNewPhasePresent == 0 ) 
        {
			pPD->fTacks = u1 / (u1 - pPD->u1_old);
			pPD->isFound = 0;
        }
/////////////////		   
        if ( pPD->u1_old > 0 && u1 <= 0 && pPD->isNewPhasePresent == 0 ) 
        {
			pPD->fTacks1 = pPD->fTacks + pPD->u1_old / (pPD->u1_old - u1);

			if ( pPD->isFound == 1 ) 
			{
			    pPD->PhaseError = pPD->fTacks1 - pPD->fTacks2;
			    pPD->isNewPhasePresent = 1;
			}
			pPD->isFound = 1;
        }
/////////////////		   
        if ( pPD->u2_old < 0 && u2 >= 0 && pPD->isNewPhasePresent == 0 ) 
        {
			pPD->fTacks2 = pPD->fTacks + pPD->u2_old / (pPD->u2_old - u2);

			if ( pPD->isFound == 1 ) 
			{
			    pPD->PhaseError = pPD->fTacks1 - pPD->fTacks2;
			    pPD->isNewPhasePresent = 1;
			}
			pPD->isFound = 1;
        }

	  pPD->u1_old = u1;
      pPD->u2_old = u2;
	  pPD->fTacks = pPD->fTacks + (float)1.0;
}

//*****************************************************************
//
//*****************************************************************
void Setup_UART_data( TGyro *gyro )
{
    Sint16 iCounter;

    // ---- У амлп ----
    if ( gyro->minVal > gyro->fi_input_y.BlockOut  ) gyro->minVal = gyro->fi_input_y.BlockOut;
    if ( gyro->maxVal < gyro->fi_input_y.BlockOut  ) gyro->maxVal = gyro->fi_input_y.BlockOut;

    // ------ ДАННЫЕ В UART -------
    for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ )
        gyro->UART_Summation[iCounter] += (*gyro->UART_Param[iCounter]);

    if ( ++gyro->UART_SummationPoint >= gyro->UART_SummationCount )
    {

        for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ ) 
        {
            gyro->pUARTfloats[iCounter]    = gyro->UART_Summation[iCounter] * gyro->UART_SummationCount_invert;
            gyro->UART_Summation[iCounter] = (float)0.0;
        }
        gyro->isUART_DataPresent  = 1;
        gyro->UART_SummationPoint = 0;


       // ---- У амлп ----
        gyro->YAmplitude = (gyro->maxVal - gyro->minVal) * (float)0.5;
        gyro->minVal =  10000.0;
        gyro->maxVal = -10000.0;

        //===========================================================================
        //===========================================================================
        //===========================================================================
        //===========================================================================
/*
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
*/
        //===========================================================================
        //===========================================================================
        //===========================================================================
        //===========================================================================

    }
}


//****************************************************************
// **** For one period finds only a 1 crossing through a zero ****
//****************************************************************
void Calc_Phase ( TInputMean *im, float u1, float u2 )
{
    /////////////////		   
        if ( im->u1_old < 0 && u1 >= 0 && im->isFound == 0) 
        {
			im->fTacks = u1 / (u1 - im->u1_old);
			im->isFound = 1;
            return;
        }

    /////////////////		   
        if ( im->u2_old < 0 && u2 >= 0 && im->isFound == 1  ) 
        {
			im->CurSumm = im->CurSumm + im->fTacks + im->u2_old / (im->u2_old - u2) - (float)1.0;
			im->isFound = 0;

            if ( ++im->PeriodCounter >= im->PeriodCount )
            {
                im->GlobalMean    = im->CurSumm * im->PeriodCount_invert;
                im->CurSumm       = (float)0.0;
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
    float LeftPart, in_filtr_value, ANodePeriod_Invert;
    if ( pd->u_old < 0 && inValue >= 0 ) // --- Если переход через Ноль -----
    {
        // ----- Расчет периода, и его сумирование ------
        LeftPart = pd->u_old / (pd->u_old - inValue );
        pd->CurSumm = pd->CurSumm + pd->fTacks + LeftPart - 1.0;
        pd->fTacks  = (float)1.0 - LeftPart;

        if ( ++pd->PeriodCounter >= pd->PeriodCountSumm )
        {
            in_filtr_value = pd->CurSumm * pd->PeriodCountSumm_invert;

            Run_Z5Coef( &pd->fi_period, in_filtr_value ); 

            //if ( ABS( in_filtr_value - pd->fi_period.BlockOut ) >  0.001) pd->fi_period.BlockOut = in_filtr_value;

            pd->Period              = pd->fi_period.BlockOut;

            ANodePeriod_Invert      = (float)1.0 / pd->Period;
            pd->Frequency           = ANodePeriod_Invert * ALGO_FREQUENCY; 
            pd->pll_phase_incriment = ANodePeriod_Invert * TWO_PI;

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
    float *in_x, *in_y, *out_x, *out_y, *pDefaultPeriod_invert, *Go;
    TZn     *Zn_exc , *Zn_sin2, *Zn_cos1, *Zn_cos2;
    float    mod_exc, znCoef, mod_s1, mod_c1, mod_s2, mod_c2, val1, val2;

  // -----    
    Zn_cos1 = &gyro->Zn_cos1;

    if ( gyro->isWorkCanalX == 1 )
    {
        in_x    = &gyro->in_Ux;      out_x   = &gyro->out_Ux;
        in_y    = &gyro->in_Uy;      out_y   = &gyro->out_Uy;
        pDefaultPeriod_invert = &gyro->DefaultPeriod_invert_x;
        Zn_exc  = &gyro->Zn_exc_x;   
        Zn_cos2 = &gyro->Zn_cos2_x;  Zn_sin2 = &gyro->Zn_sin2_x;

        Go = &gyro->Gx;
    }
    else
    {
        in_x    = &gyro->in_Uy;      out_x   = &gyro->out_Uy;
        in_y    = &gyro->in_Ux;      out_y   = &gyro->out_Ux;
        pDefaultPeriod_invert = &gyro->DefaultPeriod_invert_y;
        Zn_exc  = &gyro->Zn_exc_y;   
        Zn_cos2 = &gyro->Zn_cos2_y;  Zn_sin2 = &gyro->Zn_sin2_y;

        Go = &gyro->Gy;
    }

    gyro->NULL_value = (float)gyro->isWorkCanalX;

    //gyro->amax = ( gyro->amax < gyro->fi_demod_c.BlockOut ) ? gyro->fi_demod_c.BlockOut : gyro->amax;
/*
    val1 = gyro->fi_demod_c.BlockOut;
    val2 = gyro->amax; if ( val2 < val1 ) val2= val1; gyro->amax = val2; 
    val2 = gyro->amin; if ( val2 > val1 ) val2= val1; gyro->amin = val2; 
    if ( gyro->isEnabledUartSend == 0 )
    {
        if ( ++gyro->PhaseSummCounter > 25000 )
        {
            if ( gyro->amax < (float) 0.0001 && gyro->amax > (float)0.0 )
            if ( gyro->amin > (float)-0.0001 && gyro->amin < (float)0.0 )
            if ( fabsf(gyro->amax + gyro->amin) < 1e-5 )
            {
                gyro->isEnabledUartSend = 1;
            }    
    

            gyro->PhaseSummCounter = 0;
            gyro->amin = (float) 123;
            gyro->amax = (float)-123;
            gyro->MinuteCounter = 0;
        }
    }
*/
//gyro->NULL_value = (float)gyro->MinuteCounter * (float)0.001;
    //if ( gyro->isEnabledUartSend == 1 )
    //{                               
        if ( ++gyro->MinuteCounter >= 3000000 )
        {
            gyro->MinuteCounter     = 0; 
            gyro->isEnabledUartSend = 0;
            if ( gyro->isWorkCanalX == 1 ) 
                  gyro->isWorkCanalX = 0; 
            else gyro->isWorkCanalX = 1; 
        }
    //}

    // ------ ДАННЫЕ В UART -------
    //if ( gyro->isEnabledUartSend == 1 ) 
        Setup_UART_data( gyro );

    // ----- Фильтрация входных сигнаов ------
    Input_Filtration_short( &gyro->fi_input_x , *in_x );
    Input_Filtration_short( &gyro->fi_input_y , *in_y );

    // ----- Базовый скользящий буффер  ------
	memmove(&gyro->XBuffer[1], gyro->XBuffer, 200); 
	gyro->XBuffer[0] = gyro->fi_input_x.BlockOut * gyro->pi_am_1.m_const_invert;

    // ---- Период Колебаний ----- 
    Calc_Period( &gyro->ANodePeriod, gyro->fi_input_x.BlockOut );  

    // ---- Сигналы Модуляции и Демодуляции ---- 
    mod_s1  = gyro->XBuffer[0];
    mod_c1  = Get_SplineValue( gyro->XBuffer, Zn_cos1);
    mod_s2  = Get_SplineValue( gyro->XBuffer, Zn_sin2);
    mod_c2  = Get_SplineValue( gyro->XBuffer, Zn_cos2);
    mod_exc = Get_SplineValue( gyro->XBuffer, Zn_exc );

    // ----- Демодулирование ------
    Run_Demod( &gyro->fi_demod_a , gyro->fi_input_x.BlockOut * gyro->XBuffer[0] );
	Run_Demod( &gyro->fi_demod_c , gyro->fi_input_y.BlockOut * gyro->XBuffer[0] );
	Run_Demod( &gyro->fi_demod_q , gyro->fi_input_y.BlockOut * mod_c1           );

    // -------- Стабилизация амплитуд -----
    Run_PiReg( &gyro->pi_am_1,  gyro->fi_demod_a.BlockOut );
    Run_PiReg( &gyro->pi_om_1,  gyro->fi_demod_c.BlockOut * gyro->isCompensationPresent );
    Run_PiReg( &gyro->pi_si_1,  gyro->fi_demod_q.BlockOut * gyro->isCompensationPresent );

    Run_PiReg( &gyro->pi_am_2,  -gyro->pi_am_1.BlockOut );
    Run_PiReg( &gyro->pi_om_2,  -gyro->pi_om_1.BlockOut );
    Run_PiReg( &gyro->pi_si_2,  -gyro->pi_si_1.BlockOut );



    // -------- Коррекция амплитуд -----
    if ( gyro->pi_am_2.BlockOut > (float) 9.5 ) gyro->pi_am_2.BlockOut = (float) 9.5;
    if ( gyro->pi_am_2.BlockOut < (float)-9.5 ) gyro->pi_am_2.BlockOut = (float)-9.5;
    if ( gyro->pi_om_2.BlockOut > (float) 9.5 ) gyro->pi_om_2.BlockOut = (float) 9.5;
    if ( gyro->pi_om_2.BlockOut < (float)-9.5 ) gyro->pi_om_2.BlockOut = (float)-9.5;
    if ( gyro->pi_si_2.BlockOut > (float) 9.5 ) gyro->pi_si_2.BlockOut = (float) 9.5;
    if ( gyro->pi_si_2.BlockOut < (float)-9.5 ) gyro->pi_si_2.BlockOut = (float)-9.5;

    // ---- Сигналы Модуляции и Демодуляции ---- 
    // ----- Перерасчет значений временных задержек, если пришел новый период -----
    // ----- и управление фазой ------
    if ( gyro->ANodePeriod.isNewValuePresent == 1 && gyro->DebugMode != 7 )
    {
        gyro->ANodePeriod.isNewValuePresent = 0;

        // ----- Остальные коеффициенты коррекции
        znCoef = gyro->ANodePeriod.Period * *pDefaultPeriod_invert; 
 
        Zn_sin2->zn_curr = znCoef * Zn_sin2->zn_base;
        Zn_exc ->zn_curr = znCoef * Zn_exc ->zn_base;

        Zn_cos1->zn_curr = (float)0.25 * gyro->ANodePeriod.Period;
        Zn_cos2->zn_curr = Zn_cos1->zn_curr + Zn_sin2->zn_curr;

        Setup_Zn( Zn_exc  );
        Setup_Zn( Zn_sin2 );
        Setup_Zn( Zn_cos2 );
        Setup_Zn( Zn_cos1 );
    }
    
    // -------- Управляющие сигналы ------------
    gyro->GyroOutRaw = gyro->pi_om_2.BlockOut * gyro->SignOmega;
    gyro->GyroOut    = gyro->GyroOutRaw;
    *Go = gyro->GyroOut;
    
    *out_x  = gyro->pi_am_2.BlockOut * mod_exc;
    *out_y  = gyro->pi_si_2.BlockOut * mod_s2;
    *out_y -= gyro->pi_om_2.BlockOut * mod_c2;
    //----------- Разгон резонатора --------------------------
    gyro->AlgoCounter++;
    if ( gyro->AlgoCounter > 20000 ) gyro->isAlgoCounter = 2; 
    if ( gyro->isAlgoCounter == 1 )
    {
        *out_x  = ( mod_exc >= (float)0.0 ) ? gyro->pi_am_2.BlockOut : -gyro->pi_am_2.BlockOut;
        *out_y  = gyro->pi_si_2.BlockOut * mod_s2;
        *out_y -= gyro->pi_om_2.BlockOut * mod_c2;
    }
    // ------ ОТЛАДКА -----
    if ( gyro->DebugMode != 0 ) SetupAlgo( gyro, Zn_exc, Zn_sin2, Zn_cos2, Zn_cos1 );

/*
    // ------ Debug -----
    if ( Debug.init_counter++ >= Debug.init_count ) Debug.isInited = 1;
    if ( Debug.isWork == 1 && Debug.isInited == 1 )
    {
        Debug.param1[ Debug.work_counter ] = gyro->pi_om_2.BlockOut;
        Debug.param2[ Debug.work_counter ] = mod_s2; //gyro->fi_input_x.BlockOut;//gyro->RMNK.phi;//mod_s2;//out_y;
        Debug.param3[ Debug.work_counter ] = gyro->fi_demod_c.BlockOut;//;//gyro->RMNK.phi;//mod_s2;//out_y;

        if ( ++Debug.work_counter >= Debug.work_count )
        {
            Debug.isSleep      = 1;
            Debug.isWork       = 0;
            Debug.work_counter = 0;
        }
    }
*/
} 
