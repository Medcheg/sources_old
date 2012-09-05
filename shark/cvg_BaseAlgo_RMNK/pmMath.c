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
    float    znCoef;
    float    mod_exc;
    float    mod_s1, mod_c1;
    float    mod_s2, mod_c2;
    float    arg_sin, arg_sin2, sin1, sin2, cos1, cos2, re1, re2, im1, im2, sqrt_filtr_nu, sqrt_filtr_de;
    float    k, b, c;
    float    invert_anp;

    // ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro );

   // ----- Вычитаю средние значения со входов системы ------
    //gyro->in_Ux -= gyro->RMNK.Qx_raw[0];
    //gyro->in_Uy -= gyro->RMNK.Qy_raw[0];

   // ----- Фильтрация входных сигнаов ------
    Input_Filtration_short( &gyro->fi_input_x , gyro->in_Ux );
    Input_Filtration_short( &gyro->fi_input_y , gyro->in_Uy );

   // ----- Демодуляция рекурсивным МНК -----
    Run_Demod_RMNK(&gyro->RMNK, gyro->fi_input_x.BlockOut, gyro->fi_input_y.BlockOut, gyro->in_Ux, gyro->in_Uy );

   // ----- Коэфициент передачи полосового фильтра ------- 
    //gyro->fi_input_x.BlockOut *= gyro->in_Kx;
    //gyro->fi_input_y.BlockOut *= gyro->in_Ky;

   // ----- Базовый скользящий буффер  ------
	memmove(&gyro->XBuffer[1], gyro->XBuffer, 200); // 100 = 25 * 4
	gyro->XBuffer[0] = gyro->fi_input_x.BlockOut * gyro->pi_am_1.m_const_invert;

   // ---- Фазовый Скользящий буфер -----
	memmove(&gyro->XBufferCorr[1], gyro->XBufferCorr, 200); 
	gyro->XBufferCorr[0] = Get_SplineValue( gyro->XBuffer, &gyro->Zn_phase_x);
 
   // ---- Период Колебаний ----- 
    Calc_Period2( &gyro->ANodePeriod, gyro->fi_input_x.BlockOut );   // ----- Расчет периода коледаний ------

   // ---- Сигналы Модуляции и Демодуляции ---- 
    //mod_s1  = gyro->XBuffer[0];
    //mod_c1  = Get_SplineValue( gyro->XBuffer    , &gyro->Zn_cos1);
    //mod_s2  = Get_SplineValue( gyro->XBufferCorr, &gyro->Zn_sin2);
    //mod_c2  = Get_SplineValue( gyro->XBufferCorr, &gyro->Zn_cos2);
    //mod_exc = gyro->XBufferCorr[0];

   // ----- Демодулирование ------
    Run_Demod( &gyro->fi_demod_a , gyro->fi_input_x.BlockOut * gyro->XBuffer[0] );
    //Run_Demod( &gyro->fi_demod_fi, mod_exc * gyro->in_Ux * gyro->pi_am_1.m_const_invert );
	//Run_Demod( &gyro->fi_demod_c , gyro->fi_input_y.BlockOut * gyro->XBuffer[0] );
	//Run_Demod( &gyro->fi_demod_q , gyro->fi_input_y.BlockOut * mod_c1           );
/*                                                        
    // -------- Стабилизация амплитуд -----
    Run_PiReg( &gyro->pi_am_1,  gyro->fi_demod_a.BlockOut );
    Run_PiReg( &gyro->pi_am_2, -gyro->pi_am_1.BlockOut );

    //Run_PiReg( &gyro->pi_om_1,  gyro->fi_demod_c.BlockOut * gyro->isCompensationPresent );
    //Run_PiReg( &gyro->pi_si_1,  gyro->fi_demod_q.BlockOut * gyro->isCompensationPresent );
    //Run_PiReg( &gyro->pi_om_2,  -gyro->pi_om_1.BlockOut );
    //Run_PiReg( &gyro->pi_si_2,  -gyro->pi_si_1.BlockOut );

    // -------- Коррекция амплитуд -----
    if ( gyro->pi_am_2.BlockOut > (float) 9.5 ) gyro->pi_am_2.BlockOut = (float) 9.5;
    if ( gyro->pi_am_2.BlockOut < (float)-9.5 ) gyro->pi_am_2.BlockOut = (float)-9.5;
    if ( gyro->pi_om_2.BlockOut > (float) 9.5 ) gyro->pi_om_2.BlockOut = (float) 9.5;
    if ( gyro->pi_om_2.BlockOut < (float)-9.5 ) gyro->pi_om_2.BlockOut = (float)-9.5;
    if ( gyro->pi_si_2.BlockOut > (float) 9.5 ) gyro->pi_si_2.BlockOut = (float) 9.5;
    if ( gyro->pi_si_2.BlockOut < (float)-9.5 ) gyro->pi_si_2.BlockOut = (float)-9.5;
    
    // ----- Перерасчет значений временных задержек, если пришел новый период -----
    // ----- и управление фазой ------
    gyro->PhaseSumm += gyro->fi_demod_fi.BlockOut;
    gyro->PhaseSummCounter++; 
    if ( gyro->ANodePeriod.isNewValuePresent == 1 )
    {
        // ======== 
        // ======== Phase
        // ======== 
        gyro->PhaseMean        = gyro->PhaseSumm / (float)gyro->PhaseSummCounter;
        gyro->PhaseSummCounter = 0;
        gyro->PhaseSumm        = (float)0.0;
        Run_PiReg( &gyro->pi_phase,  gyro->PhaseMean - gyro->InitialSPh );
        //if ( gyro->DebugMode != 7 && gyro->isPhaseCorrectionPresent == 1 && gyro->isAlgoCounter != 1) 
        //       gyro->Zn_phase_x.zn_curr = gyro->Zn_phase_x.zn_base + gyro->pi_phase.BlockOut;
        // ======== 
        // ======== End of calc Phase
        // ======== 

        Run_Z4Coef( &gyro->fi_period, gyro->ANodePeriod.GlobalMean );
        gyro->ANodePeriod.GlobalMean = gyro->fi_period.BlockOut;
        invert_anp  = (float)1.0 / gyro->ANodePeriod.GlobalMean;
        gyro->ANodePeriod.isNewValuePresent = 0;
        gyro->Frequency      = ALGO_FREQUENCY * invert_anp; 
        gyro->RMNK.delta_phi = TWO_PI * invert_anp;

        // -------- Коррекция пусности --------------
        //k = ((float)1.7622277752 - (float)2.5736291274)/((float)4324.779754 - (float)4284.048542) * (gyro->Frequency - (float)4300.8092650104);
        //b =  gyro->pi_am_2.BlockOut;
        //k = ((float)-0.0199207607656717) * (gyro->Frequency - (float)4300.8092650104);
        //k =  k * gyro->pi_am_1.m_const;
        //c =  k / b;

        //if ( gyro->isAlgoCounter != 1 )
        //    gyro->pi_am_1.m_const = (float)X_ampl - (4300.8092650104 - gyro->Frequency) / (4300.8092650104 - 4284.0041620422) * 0.039056550851732352205952993000003;
        //    gyro->pi_am_1.m_const = (float)X_ampl - (4300.8092650104 - gyro->Frequency) / (4300.8092650104 - 4284.0041620422) * 0.15;

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
    }

    // -------- Управляющие сигналы ------------
    gyro->GyroOutRaw = gyro->pi_om_2.BlockOut * gyro->SignOmega;
    gyro->GyroOut    = gyro->GyroOutRaw;
    
    gyro->out_Ux  = gyro->pi_am_2.BlockOut * mod_exc;
    gyro->out_Uy  = gyro->pi_si_2.BlockOut * mod_s2;
    gyro->out_Uy -= gyro->pi_om_2.BlockOut * mod_c2;

    //----------- Разгон резонатора --------------------------
    gyro->AlgoCounter++;
    if ( gyro->AlgoCounter > 20000 ) gyro->isAlgoCounter = 2; 
    if ( gyro->isAlgoCounter == 1 )
    {
        gyro->out_Ux  = ( mod_exc >= (float)0.0 ) ? gyro->pi_am_2.BlockOut : -gyro->pi_am_2.BlockOut;
        gyro->out_Uy  = gyro->pi_si_2.BlockOut * mod_s2;
        gyro->out_Uy -= gyro->pi_om_2.BlockOut * mod_c2;
    }
    gyro->out_Uy  = (float)0.0;
*/
    // ------ ОТЛАДКА -----
    if ( gyro->DebugMode != 0 ) SetupAlgo( gyro );

    // ------- Запуск гирика
/*
    gyro->out_Ux  = cosf(gyro->t);
    gyro->out_Uy  = (float)0.0;
    gyro->t = gyro->t + TWO_PI * DISCRET_TIME * (float)4299.7;
    if ( gyro->t > TWO_PI ) gyro->t = gyro->t - TWO_PI;
*/
    gyro->RMNK.delta_phi = TWO_PI * DISCRET_TIME * (float)4207.7323907104;
    Gyro.out_Ux  = gyro->RMNK.h[2];
    Gyro.out_Uy  = (float)0.0;

    // ------ Debug -----
    if ( Debug.init_counter++ >= Debug.init_count ) Debug.isInited = 1;
    Debug.isInited = 1;
    if ( Debug.isWork == 1 && Debug.isInited == 1 )
    {
        Debug.param1[ Debug.work_counter ] = gyro->RMNK.P[0]; //gyro->fi_input_y.BlockOut;
        Debug.param2[ Debug.work_counter ] = gyro->RMNK.P[4]; //gyro->fi_input_x.BlockOut;//gyro->RMNK.phi;//mod_s2;//gyro->out_Uy;
        Debug.param3[ Debug.work_counter ] = gyro->RMNK.P[8]; //gyro->fi_input_x.BlockOut;//gyro->RMNK.phi;//mod_s2;//gyro->out_Uy;

        if ( ++Debug.work_counter >= Debug.work_count )
        {
            Debug.isSleep      = 1;
            Debug.isWork       = 0;
            Debug.work_counter = 0;
        }
    }
} 

