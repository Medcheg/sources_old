#include "pmMath.h"
#include <string.h>   // ---- Юнит нужен для функции MemMove ----
#include <gclib.h>
#include "math.h"
 
float Get_SliderMean( TSliderMean *sm, float inValue );
void  CalcInputMean( TInputMean *im, float inValue, Sint8 isZeroWait );
//*****************************************************************
//
//*****************************************************************
float MOD_float_small(float x)
{
   if ( x > TWO_PI ) return x - TWO_PI;
   if ( x <      0 ) return x + TWO_PI;
   return x;
}

//*****************************************************************
//
//*****************************************************************
void PLL(TPLL *pPll, TInputMean *im,  float inValue, float inPhase)
{
    pPll->Freq    = pPll->Kc * inValue + pPll->Fc_Ts;
    pPll->mod     = pPll->Freq + pPll->mod;
 
    // -------------
    pPll->mod                    = MOD_float_small( pPll->mod                           );
    pPll->mod_base               = MOD_float_small( pPll->mod                           );
    pPll->mod_ExcitationPhase    = MOD_float_small( pPll->mod + pPll->ExcitationPhase   + inPhase );
    pPll->mod_CompensationPhase  = MOD_float_small( pPll->mod + pPll->CompensationPhase + inPhase );//

    // -------------
	pPll->s1     =  sinf( pPll->mod_base               ); 
	pPll->c1     =  cosf( pPll->mod_base               );
	pPll->exc    =  cosf( pPll->mod_ExcitationPhase    );
    pPll->exc_90 =  sinf( pPll->mod_ExcitationPhase    );
	pPll->s2     =  sinf( pPll->mod_CompensationPhase  );
	pPll->c2     =  cosf( pPll->mod_CompensationPhase  );
}

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

    Setup_Zn(&gyro->Zn_exc );
    Setup_Zn(&gyro->Zn_sin2);
    Setup_Zn(&gyro->Zn_cos1);
    Setup_Zn(&gyro->Zn_cos2);

    if ( gyro->CurDebugTime < gyro->DebugTime ) return;

    if ( gyro->DebugMode == 1 ) gyro->pi_fr_1.d_const = -0.17453292519943295769236907684886;
    if ( gyro->DebugMode == 2 ) gyro->pi_am_1.d_const = 0.100;
    if ( gyro->DebugMode == 3 ) gyro->pi_om_1.d_const = 0.002;
    if ( gyro->DebugMode == 4 ) gyro->pi_si_1.d_const = 0.010;
    if ( gyro->DebugMode == 7 ) 
    {
        if ( gyro->DebugCounter++ >= 8 )
        {
            gyro->DebugCounter = 0;
            //gyro->Zn_exc.zn_curr = gyro->Zn_exc.zn_base + gyro->Zn_exc.zn_additional + gyro->XPhase.GlobalMean
            gyro->Zn_exc.zn_curr += (float)0.000001;

            gyro->pll.ExcitationPhase += (float)0.000001;
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
float Get_SliderMean( TSliderMean *sm, float inValue )
{
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
			im->CurSumm = im->CurSumm + im->fTacks + im->u2_old / (im->u2_old - u2);
			im->isFound = 0;

            if ( ++im->PeriodCounter >= im->PeriodCount )
            {
                im->GlobalMean    =  Get_SliderMean( &im->sm, (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );
                //im->GlobalMean    = im->CurSumm * im->PeriodCount_invert  - (float)1.0;
                im->CurSumm       = (float)0.0;
                im->PeriodCounter = 0;
                im->isNewValuePresent = 1;
            }
        }

    /////////////////		   
	  im->u1_old = u1;
      im->u2_old = u2;
	  im->fTacks = im->fTacks + (float)1.0;

/*
    if ( im->Old_InputVal < 0 && inValue >= 0 )
    {
        // ----- Расчет периода, и его сумирование ------
          im->CurSumm = im->CurSumm + im->fTacks - im->Old_InputVal / (inValue - im->Old_InputVal );
          im->fTacks  =  inValue / (inValue - im->Old_InputVal);

        // -------
        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            im->GlobalMean        = Get_SliderMean( &im->sm, (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );

            im->CurSumm           = (float)0.0;
            im->PeriodCounter     = 0;
            im->isNewValuePresent = 1;
        }
    }   
    im->fTacks = im->fTacks + (float)1.0;
    im->Old_InputVal = inValue;
*/
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
void Calc_Period( TInputMean *im, float inValue )
{
    if ( im->u_old < 0 && inValue >= 0 )
    {
        // ----- Расчет периода, и его сумирование ------
          im->CurSumm = im->CurSumm + im->fTacks + im->u_old / (im->u_old - inValue );
          im->fTacks  =  inValue / (inValue - im->u_old);

        // -------
        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            im->GlobalMean        = Get_SliderMean( &im->sm, (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );
            //im->GlobalMean        = Get_SliderMean( &im->sm, im->CurSumm * im->PeriodCount_invert );

            im->CurSumm           = (float)0.0;
            im->PeriodCounter     = 0;
            im->isNewValuePresent = 1;
        }
    }   
    im->fTacks = im->fTacks + (float)1.0;
    im->u_old  = inValue;
}

//*****************************************************************
//
//*****************************************************************
void Calc_Period2( TInputMean *im, float inValue )
{
    if ( im->u_old * inValue < 0 ) // --- Если переход через Ноль -----
    {
        // ----- Расчет периода, и его сумирование ------
          im->CurSumm = im->CurSumm + im->fTacks + im->u_old / (im->u_old - inValue );
          im->fTacks  =  inValue / (inValue - im->u_old);

        // -------
        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            im->GlobalMean        = Get_SliderMean( &im->sm, (float)2.0 * (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );
            //im->GlobalMean        = (float)2.0 * (im->CurSumm * im->PeriodCount_invert  - (float)1.0);

            im->CurSumm           = (float)0.0;
            im->PeriodCounter     = 0;
            im->isNewValuePresent = 1;
        }
    }   
    im->fTacks = im->fTacks + (float)1.0;
    im->u_old  = inValue;

/*
    if ( im->u_old < 0 && inValue >= 0 )
    {
        // ----- Расчет периода, и его сумирование ------
          im->CurSumm = im->CurSumm + im->fTacks + im->u_old / (im->u_old - inValue );
          im->fTacks  =  inValue / (inValue - im->u_old);

        // -------
        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            im->GlobalMean        = Get_SliderMean( &im->sm, (float)2.0 * (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );

            im->CurSumm           = (float)0.0;
            im->PeriodCounter     = 0;
            im->isNewValuePresent = 1;
        }
    }   

    if ( im->u_old > 0 && inValue <= 0 )
    {
        // ----- Расчет периода, и его сумирование ------
          im->CurSumm = im->CurSumm + im->fTacks + im->u_old / (im->u_old - inValue );
          im->fTacks  =  inValue / (inValue - im->u_old);

        // -------
        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            im->GlobalMean        = Get_SliderMean( &im->sm, (float)2.0 * (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );

            im->CurSumm           = (float)0.0;
            im->PeriodCounter     = 0;
            im->isNewValuePresent = 1;
        }
    }   
    im->fTacks = im->fTacks + (float)1.0;
    im->u_old  = inValue;
*/
}

//*****************************************************************
//
//*****************************************************************
void Calc_Period_Discremenant( TInputMean *im, float *buff, float inValue )
{
    float D, x2;
    float a1, a2, a3;

    a1 =  - 1.8333333333333333333333333333333 * buff[0] + 3.0 * buff[1] - 1.5*buff[2] + 0.33333333333333333333333333333333*buff[3];
    a2 =    2.0 * buff[0] - 5.0 * buff[1] + 4.0*buff[2] -     buff[3];
    a3 =  - 0.5 * buff[0] + 1.5 * buff[1] - 1.5*buff[2] + 0.5*buff[3];
/*
    a2 =    1.0000000000000000000000000000000 * buff[0] - 2.5 * buff[1] + 2.0*buff[2] - 0.50000000000000000000000000000000*buff[3];
    a3 =  - 0.1666666666666666666666666666667 * buff[0] + 0.5 * buff[1] - 0.5*buff[2] + 0.16666666666666666666666666666667*buff[3];
    a2 = a2 * 2.0;
    a3 = a3 * 3.0;
*/
    D  = a2*a2 - 4*a3*a1;
    if ( D >= 0 )
    {
        x2 = (float)0.5 * (-a2 - sqrt(D)) / a3;

        if ( x2 >= 0.0 && x2 <= 1.0  )
        {
            // ----- Расчет периода, и его сумирование ------
              im->CurSumm = im->CurSumm + (1.0 - x2) + (im->fTacks - 1.0);
              im->fTacks  = x2;
            // -------
            if ( ++im->PeriodCounter >= im->PeriodCount )
            {
                //im->GlobalMean = Get_SliderMean( &im->sm, (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );
                im->GlobalMean = Get_SliderMean( &im->sm, im->CurSumm * im->PeriodCount_invert);

                im->CurSumm           = (float)0.0;
                im->PeriodCounter     = 0;
                im->isNewValuePresent = 1;
            }
        }
    }
    im->fTacks = im->fTacks + (float)1.0;
}

//*****************************************************************
//
//*****************************************************************
void Setup_UART_data( TGyro *gyro )
{
    Sint16 iCounter;
  
    // ------ Суммирование данных для UART -------
    for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ )
        gyro->UART_Summation[iCounter] += (*gyro->UART_Param[iCounter]);

    // ------ ДАННЫЕ В UART -------
    if ( ++gyro->UART_SummationPoint >= gyro->UART_SummationCount )
    {

        for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ ) 
        {
            gyro->pUARTfloats[iCounter] = gyro->UART_Summation[iCounter] * gyro->UART_SummationCount_invert;
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
            gyro->pUARTfloats[gyro->UART_ParamCount - 2] = Debug.param1[Debug.work_count - 1];
            gyro->pUARTfloats[gyro->UART_ParamCount - 1] = Debug.param2[Debug.work_count - 1];
        }
        //===========================================================================
        //===========================================================================
        //===========================================================================
        //===========================================================================
    }
}

//*****************************************************************
//
//*****************************************************************
void Run_Algo( TGyro *gyro )
{
    float    znCoef;

    // ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro ); 

    // ------ ОТЛАДКА -----
    if ( gyro->DebugMode != 0 ) SetupAlgo( gyro );
 
    // ----- Расчет средних зачений, и их вычитание ------
    CalcInputMean( &gyro->XInputMean, gyro->in_Ux, 1 );
    CalcInputMean( &gyro->YInputMean, gyro->in_Uy, 0 );

    // ------ Расчет колебаний амлитуды У -------
    if ( gyro->X_minVal > gyro->in_Ux  ) gyro->X_minVal = gyro->in_Ux;
    if ( gyro->X_maxVal < gyro->in_Ux  ) gyro->X_maxVal = gyro->in_Ux;
    if ( gyro->Y_minVal > gyro->in_Uy  ) gyro->Y_minVal = gyro->in_Uy;
    if ( gyro->Y_maxVal < gyro->in_Uy  ) gyro->Y_maxVal = gyro->in_Uy;
    if ( ++gyro->i_yCounter >= gyro->iy_Count )
    {
        gyro->XAmplitude = (gyro->X_maxVal - gyro->X_minVal) * (float)0.5;
        gyro->XMean      = (gyro->X_maxVal + gyro->X_minVal) * (float)0.5;
        gyro->YAmplitude = (gyro->Y_maxVal - gyro->Y_minVal) * (float)0.5;
        gyro->YMean      = (gyro->Y_maxVal + gyro->Y_minVal) * (float)0.5;

        gyro->i_yCounter = 0;
        gyro->X_minVal =  10000.0;
        gyro->X_maxVal = -10000.0;
        gyro->Y_minVal =  10000.0;
        gyro->Y_maxVal = -10000.0;
    }

   // ----- Вычитаю средние значения со входов системы ------
    gyro->in_Ux = gyro->in_Ux - gyro->XInputMean.GlobalMean;
    gyro->in_Uy = gyro->in_Uy - gyro->YInputMean.GlobalMean;
  
    // ------ Debug -----
    if ( Debug.init_counter++ >= Debug.init_count ) Debug.isInited = 1;
    if ( Debug.isWork == 1 && Debug.isInited == 1 )
    {
        Debug.param1[ Debug.work_counter ] = 0.0;
        Debug.param2[ Debug.work_counter ] = gyro->in_Ux;
        Debug.param3[ Debug.work_counter ] = gyro->in_Uy;

        if ( ++Debug.work_counter >= Debug.work_count )
        {
            Debug.isSleep      = 1;
            Debug.isWork       = 0;
            Debug.work_counter = 0;
        }
    }

   // ----- Фильтрация ------
    Input_Filtration_short( &gyro->fi_input_x, gyro->in_Ux );
    Input_Filtration_short( &gyro->fi_input_y, gyro->in_Uy );

   // ----- Расчет периода коледаний ------
    Calc_Period2( &gyro->ANodePeriod, gyro->fi_input_x.BlockOut );

   // ----- Фаза системы ------ 
    Calc_Phase ( &gyro->XPhase, gyro->in_Ux, gyro->out_Ux );
    Calc_Phase ( &gyro->YPhase, gyro->in_Ux, gyro->in_Uy );

    // ----- Демодулирование ------
    Run_Demod( &gyro->fi_demod_f, gyro->pll.c1 * gyro->fi_input_x.BlockOut * gyro->pi_am_1.m_const_invert );
    Run_Demod( &gyro->fi_demod_a, gyro->pll.s1 * gyro->fi_input_x.BlockOut );
    Run_Demod( &gyro->fi_demod_c, gyro->pll.s1 * gyro->fi_input_y.BlockOut );
    Run_Demod( &gyro->fi_demod_q, gyro->pll.c1 * gyro->fi_input_y.BlockOut );
                                           
    // --------
    gyro->MiddleFreqError_summ += gyro->fi_demod_f.BlockOut;
    if ( ++gyro->FreqError_counter >= gyro->FreqError_count )
    {
        Run_PiReg( &gyro->pi_fr_1, -gyro->MiddleFreqError_summ * (float)0.01 );
        gyro->MiddleFreqError_summ = (float)0.0;
        gyro->FreqError_counter = 0;
    }
         
    // -------- Стабилизация амплитуд -----
    //Run_PiReg( &gyro->pi_fr_1, -gyro->fi_demod_f.BlockOut );
    Run_PiReg( &gyro->pi_am_1,  gyro->fi_demod_a.BlockOut );
    Run_PiReg( &gyro->pi_am_2, -gyro->pi_am_1.BlockOut    );
    Run_PiReg( &gyro->pi_om_1,  gyro->fi_demod_c.BlockOut );
    Run_PiReg( &gyro->pi_om_2, -gyro->pi_om_1.BlockOut    );
    Run_PiReg( &gyro->pi_si_1,  gyro->fi_demod_q.BlockOut );
    Run_PiReg( &gyro->pi_si_2, -gyro->pi_si_1.BlockOut    );

    // -----
    if ( gyro->pi_am_2.BlockOut > (float) 9.5 ) gyro->pi_am_2.BlockOut = (float) 9.5;
    if ( gyro->pi_am_2.BlockOut < (float)-9.5 ) gyro->pi_am_2.BlockOut = (float)-9.5;
    if ( gyro->pi_om_2.BlockOut > (float) 9.5 ) gyro->pi_om_2.BlockOut = (float) 9.5;
    if ( gyro->pi_om_2.BlockOut < (float)-9.5 ) gyro->pi_om_2.BlockOut = (float)-9.5;
    if ( gyro->pi_si_2.BlockOut > (float) 9.5 ) gyro->pi_si_2.BlockOut = (float) 9.5;
    if ( gyro->pi_si_2.BlockOut < (float)-9.5 ) gyro->pi_si_2.BlockOut = (float)-9.5;

    // ----- PLL ------
    
    PLL( &gyro->pll, &gyro->FreqMean,  gyro->pi_fr_1.BlockOut, 0.0 );

    // ----- Перерасчет значений временных задержек, если пришел новый период -----

    if ( gyro->ANodePeriod.isNewValuePresent == 1 && gyro->DebugMode != 7 )
    {
        gyro->ANodePeriod.isNewValuePresent = 0;
        gyro->XPhaseDegree = (float)360.0 / gyro->ANodePeriod.GlobalMean * gyro->XPhase.GlobalMean;
        gyro->YPhaseDegree = (float)360.0 / gyro->ANodePeriod.GlobalMean * gyro->YPhase.GlobalMean;

        // ---- PLL ------
        //gyro->pll.Fc_Ts = (float)TWO_PI / (float)gyro->ANodePeriod.GlobalMean + 0.1 *gyro->pi_phase.BlockOut * DEG_TO_RAD;
        gyro->pll.Fc_Ts = (float)TWO_PI / (float)gyro->ANodePeriod.GlobalMean;
        gyro->Frequency = gyro->pll.Freq * ALFO_FREQ_DIV_2PI;

    
        znCoef = gyro->ANodePeriod.GlobalMean * gyro->DefaultPeriod_invert;
        gyro->Zn_exc .zn_curr = znCoef * gyro->Zn_exc.zn_base;// + gyro->XPhase.GlobalMean;
        Setup_Zn(&gyro->Zn_exc );
    }

    // -------- Управляющие сигналы ------------
    gyro->GyroOutRaw = gyro->pi_om_2.BlockOut * gyro->SignOmega;
    gyro->GyroOut    = gyro->GyroOutRaw;
    
    gyro->out_Ux  = gyro->pi_am_2.BlockOut * gyro->pll.exc;
    gyro->out_Uy  = gyro->pi_om_2.BlockOut * gyro->pll.c2;
    gyro->out_Uy -= gyro->pi_si_2.BlockOut * gyro->pll.s2;

    //----------- Разгон резонатора --------------------------
    gyro->AlgoCounter++;
    if ( gyro->AlgoCounter > 20000 ) gyro->isAlgoCounter = 2; 
    if ( gyro->isAlgoCounter == 1 )
    {
        // ---- Скользящий буфера -----
    	memmove(&gyro->XBuffer[1], gyro->XBuffer, 100); // 100 = 25 * 4
    	gyro->XBuffer[0] = gyro->fi_input_x.BlockOut * gyro->pi_am_1.m_const_invert;

        gyro->out_Ux  = ( gyro->XBuffer[ gyro->Zn_exc.zn_i ] >= (float)0.0 ) ? gyro->pi_am_2.BlockOut : -gyro->pi_am_2.BlockOut;
        gyro->out_Uy  = (float)0.0;
    } else gyro->kk = 1.0;
} 

