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
            gyro->Zn_phase_x.zn_curr += (float)0.000001;
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
                //im->GlobalMean    =  Get_SliderMean( &im->sm, (im->CurSumm * im->PeriodCount_invert);
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
/*
    if ( im->Old_InputVal < 0 && inValue >= 0 )
    {
        // ----- Расчет периода, и его сумирование ------
          im->CurSumm = im->CurSumm + im->fTacks - im->Old_InputVal / (inValue - im->Old_InputVal );
          im->fTacks  =  inValue / (inValue - im->Old_InputVal);

        // -------
        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            //im->GlobalMean        = Get_SliderMean( &im->sm, (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );

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
            gyro->pUARTfloats[iCounter] = gyro->UART_Summation[iCounter] * gyro->UART_SummationCount_invert;
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
        if ( Debug.isSleep == 1 && Debug.isInited == 1 )
        {
            gyro->pUARTfloats[gyro->UART_ParamCount - 2] = Debug.param1[Debug.work_counter];
            gyro->pUARTfloats[gyro->UART_ParamCount - 1] = Debug.param2[Debug.work_counter];

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
    float LeftPart;
    if ( im->u_old < 0 && inValue >= 0 )
    {
        // ----- Расчет периода, и его сумирование ------
        LeftPart = im->u_old / (im->u_old - inValue );
        im->CurSumm = im->CurSumm + im->fTacks + LeftPart;
        im->fTacks  = (float)1.0 - LeftPart;

        // -------
        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            //im->GlobalMean        = Get_SliderMean( &im->sm, (im->CurSumm * im->PeriodCount_invert  - (float)1.0) );
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
    float LeftPart;
    if ( im->u_old < 0 && inValue >= 0 ) // --- Если переход через Ноль -----
    {
        // ----- Расчет периода, и его сумирование ------
        LeftPart = im->u_old / (im->u_old - inValue );
        im->CurSumm = im->CurSumm + im->fTacks + LeftPart - 1.0;
        im->fTacks  = (float)1.0 - LeftPart;

        if ( ++im->PeriodCounter >= im->PeriodCount )
        {
            im->GlobalMean        = im->CurSumm * im->PeriodCount_invert;
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
void Calc_Period_External( TPeriodDetectorNew *pd, float inValue )
{
    if ( pd->u_old < (float)0.0 && inValue >= (float)0.0 ) // --- Если переход через Ноль -----
    {

        pd->as1 = pd->as2;
        pd->bs1 = pd->bs2;
        pd->as2 = inValue;
        pd->bs2 = pd->u_old;

        if ( pd->bs1 > pd->bs2 ) 
        {
            pd->as1 = pd->as2   - pd->bs1;
            pd->as2 = inValue   - pd->bs1;
            pd->bs2 = pd->u_old - pd->bs1;
            pd->bs1 = (float)0.0;

            pd->PeriodMiddle = pd->bs2 / (pd->bs2 - pd->as2) + (float)pd->ts;
        }
        if ( pd->bs1 <= pd->bs2 ) 
        {
            pd->as1 = pd->as2   - pd->bs2;
            pd->as2 = inValue   - pd->bs2;
            pd->bs1 = pd->u_old - pd->bs2;
            pd->bs2 = (float)0.0;
            
            pd->PeriodMiddle = pd->as1 / (pd->as1 - pd->bs1) + (float)pd->ts;

        }

         pd->ts = 0;   

/*
        //pd->a_old = inValue;
        //pd->b_old = pd->u_old;

        // --- 
        if ( ++pd->SummCounter >= pd->SummCount)
        {//
            //pd->PeriodMiddle = (pd->bs2 / (pd->bs2 - pd->as2) + ((float)pd->ts - (float)1.0) + pd->as1 / (pd->as1 - pd->bs1)) * pd->InvertSumm;
            //pd->PeriodMiddle = Get_SliderMean( &pd->sm, (pd->bs2 / (pd->bs2 - pd->as2) + ((float)pd->ts - (float)1.0) + pd->as1 / (pd->as1 - pd->bs1)) * pd->InvertSumm );
            pd->as1 = (float)0.0;
            pd->bs1 = (float)0.0;
            pd->as2 = (float)0.0;
            pd->bs2 = (float)0.0;
            pd->ts  = 0;
            pd->SummCounter = 0;
        }
*/
    }        
    pd->ts++;
    pd->u_old  = inValue;
}

//*****************************************************************
//
//*****************************************************************
/*
void Calc_Period_Discremenant( TInputMean *im, float *buff, float inValue )
{
    float D, x2;
    float a1, a2, a3;

    a1 =  - 1.8333333333333333333333333333333 * buff[0] + 3.0 * buff[1] - 1.5*buff[2] + 0.33333333333333333333333333333333*buff[3];
    a2 =    2.0 * buff[0] - 5.0 * buff[1] + 4.0*buff[2] -     buff[3];
    a3 =  - 0.5 * buff[0] + 1.5 * buff[1] - 1.5*buff[2] + 0.5*buff[3];

//    a2 =    1.0000000000000000000000000000000 * buff[0] - 2.5 * buff[1] + 2.0*buff[2] - 0.50000000000000000000000000000000*buff[3];
//    a3 =  - 0.1666666666666666666666666666667 * buff[0] + 0.5 * buff[1] - 0.5*buff[2] + 0.16666666666666666666666666666667*buff[3];
//    a2 = a2 * 2.0;
//    a3 = a3 * 3.0;

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
*/
//*****************************************************************
//
//*****************************************************************
void Run_Algo( TGyro *gyro )
{
    float    znCoef;
    float    mod_exc;
    float    mod_s1, mod_c1;
    float    mod_s2, mod_c2;
    float    arg_sin, arg_sin2, sin1, sin2, cos1, cos2, re1, re2, im1, im2, sqrt_filtr_nu, sqrt_filtr_de;
    float    k, b, c;

    // ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro );

   // ----- Расчет средних зачений по Входам ------
    CalcInputMean( &gyro->XInputMean, gyro->in_Ux, 1 );
    CalcInputMean( &gyro->YInputMean, gyro->in_Uy, 0 );

   // ----- Вычитаю средние значения со входов системы ------
    //gyro->in_Ux = gyro->in_Ux - gyro->XInputMean.GlobalMean;
    //gyro->in_Uy = gyro->in_Uy - gyro->YInputMean.GlobalMean;
   
   // ----- Фильтрация входных сигнаов ------
    Input_Filtration_short( &gyro->fi_input_x , gyro->in_Ux );
    Input_Filtration_short( &gyro->fi_input_y , gyro->in_Uy );

   // ----- Коэфициент передачи полосового фильтра ------- 
    gyro->fi_input_x.BlockOut *= gyro->in_Kx;
    gyro->fi_input_y.BlockOut *= gyro->in_Ky;

   // ----- Базовый скользящий буффер  ------
	memmove(&gyro->XBuffer[1], gyro->XBuffer, 200); // 100 = 25 * 4
	gyro->XBuffer[0] = gyro->fi_input_x.BlockOut * gyro->pi_am_1.m_const_invert;

   // ---- Фазовый Скользящий буфер -----
	memmove(&gyro->XBufferCorr[1], gyro->XBufferCorr, 200); 
	gyro->XBufferCorr[0] = Get_SplineValue( gyro->XBuffer, &gyro->Zn_phase_x);
 
   // ---- Период Колебаний ----- 
    Calc_Period2( &gyro->ANodePeriod, gyro->fi_input_x.BlockOut );   // ----- Расчет периода коледаний ------

   // ---- Сигналы Модуляции и Демодуляции ---- 
    mod_s1  = gyro->XBuffer[0];
    mod_c1  = Get_SplineValue( gyro->XBuffer    , &gyro->Zn_cos1);
    mod_s2  = Get_SplineValue( gyro->XBufferCorr, &gyro->Zn_sin2);
    mod_c2  = Get_SplineValue( gyro->XBufferCorr, &gyro->Zn_cos2);
    mod_exc = gyro->XBufferCorr[0];
    //mod_s2  = Get_SplineValue( gyro->XBuffer    , &gyro->Zn_sin2);
    //mod_c2  = Get_SplineValue( gyro->XBuffer    , &gyro->Zn_cos2);
    //mod_exc = Get_SplineValue( gyro->XBufferCorr, &gyro->Zn_exc );
    //mod_s2  = Get_SplineValue( gyro->XBufferCorr, &gyro->Zn_sin2);
    //mod_c2  = Get_SplineValue( gyro->XBufferCorr, &gyro->Zn_cos2);

   // ----- Демодулирование ------
    Run_Demod( &gyro->fi_demod_a , gyro->fi_input_x.BlockOut * gyro->XBuffer[0] );
	Run_Demod( &gyro->fi_demod_c , gyro->fi_input_y.BlockOut * gyro->XBuffer[0] );
	Run_Demod( &gyro->fi_demod_q , gyro->fi_input_y.BlockOut * mod_c1           );
    Run_Demod( &gyro->fi_demod_fi, mod_exc * gyro->in_Ux * gyro->pi_am_1.m_const_invert );
                                                        
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
    
    // ----- Перерасчет значений временных задержек, если пришел новый период -----
    // ----- и управление фазой ------
    if ( gyro->ANodePeriod.isNewValuePresent == 1 )
    {
        gyro->ANodePeriod.isNewValuePresent = 0;

        // ----- Остальные коеффициенты коррекции
        znCoef = gyro->ANodePeriod.GlobalMean * gyro->DefaultPeriod_invert;
 
        gyro->Zn_sin2.zn_curr = znCoef * gyro->Zn_sin2.zn_base;
        gyro->Zn_cos2.zn_curr = (float)0.25 * gyro->ANodePeriod.GlobalMean + gyro->Zn_sin2.zn_curr;
        gyro->Zn_cos1.zn_curr = (float)0.25 * gyro->ANodePeriod.GlobalMean;
        //gyro->Zn_exc .zn_curr = (float)0.25 * gyro->ANodePeriod.GlobalMean;
        gyro->Zn_exc .zn_curr = gyro->Zn_phase_x.zn_curr;

        Setup_Zn(&gyro->Zn_exc     );
        Setup_Zn(&gyro->Zn_sin2    );
        Setup_Zn(&gyro->Zn_cos1    );
        Setup_Zn(&gyro->Zn_cos2    );
        Setup_Zn(&gyro->Zn_phase_x );

       // --------- 
        if ( gyro->DebugMode != 7 && gyro->isPhaseCorrectionPresent == 1 && gyro->isAlgoCounter != 1) 
        {   
            arg_sin  = TWO_PI / gyro->ANodePeriod.GlobalMean;
            arg_sin2 = (float)2.0 * arg_sin;
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
                }
        }
    }



    // -------- Управляющие сигналы ------------
    gyro->GyroOutRaw = gyro->pi_om_2.BlockOut * gyro->SignOmega;
    gyro->GyroOut    = gyro->GyroOutRaw;
    
    gyro->out_Ux  = gyro->pi_am_2.BlockOut * mod_exc;
    gyro->out_Uy  = gyro->pi_si_2.BlockOut * mod_s2;
    gyro->out_Uy -= gyro->pi_om_2.BlockOut * mod_c2;

    //----------- Разгон резонатора --------------------------
    gyro->AlgoCounter++;
    if ( gyro->AlgoCounter > 50000 ) gyro->isAlgoCounter = 2; 
    if ( gyro->isAlgoCounter == 1 )
    {
        gyro->out_Ux  = ( mod_exc >= (float)0.0 ) ? gyro->pi_am_2.BlockOut : -gyro->pi_am_2.BlockOut;
        gyro->out_Uy  = gyro->pi_si_2.BlockOut * mod_s2;
        gyro->out_Uy -= gyro->pi_om_2.BlockOut * mod_c2;
    }

    // ------ ОТЛАДКА -----
    if ( gyro->DebugMode != 0 ) SetupAlgo( gyro );

/*
    // ------- Запуск гирика
    gyro->out_Ux  = cos(gyro->t);
    gyro->out_Uy  = (float)0.0;
    gyro->t = gyro->t + TWO_PI * DISCRET_TIME * (float)4299.7;
    if ( gyro->t > TWO_PI ) gyro->t = gyro->t - TWO_PI;
*/    
    // ------ Debug -----
    if ( Debug.init_counter++ >= Debug.init_count ) Debug.isInited = 1;
    if ( Debug.isWork == 1 && Debug.isInited == 1 )
    {
        Debug.param1[ Debug.work_counter ] = gyro->fi_input_y.BlockOut;
        Debug.param2[ Debug.work_counter ] = mod_s2;//gyro->out_Uy;

        if ( ++Debug.work_counter >= Debug.work_count )
        {
            Debug.isSleep      = 1;
            Debug.isWork       = 0;
            Debug.work_counter = 0;
        }
    }
    //gyro->pi_si_1.m_const = 0.001;
} 

