#include "pmMath.h"
#include <string.h>   // ---- Юнит нужен для функции MemMove ----
#include <gclib.h>
#include "math.h"
#include "kff.h"


float Get_SliderMean_bad( TSliderMean *sm, float inValue );

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
 
// DEBUG_MODE 1 ----- Настройка регулятора Амплитудного контура  -----
// DEBUG_MODE 2 ----- Настройка регулятора Кориолисового контура ---
// DEBUG_MODE 3 ----- Настройка регулятора Квадратурного контура -----
// DEBUG_MODE 4 ----- Настройка регулятора Контура Частоты -----
// DEBUG_MODE 5 ----- Настройка регулятора Контура Фазовой коррекции -----
// DEBUG_MODE 7 ----- АЧХ возбуждения (фаза возбуждения) -----

    Setup_Zn(&gyro->Zn_exc);
    Setup_Zn(&gyro->Zn_sin2);
    Setup_Zn(&gyro->Zn_cos1);
    Setup_Zn(&gyro->Zn_cos2);

    if ( gyro->CurDebugTime < gyro->DebugTime ) return;

    if ( gyro->DebugMode == 1 ) gyro->pi_am_1.d_const = Aa;
    if ( gyro->DebugMode == 2 ) gyro->pi_om_1.d_const = Ac;
    if ( gyro->DebugMode == 3 ) gyro->pi_si_1.d_const = Aq;
    if ( gyro->DebugMode == 4 ) gyro->rmnk.pi_pll_x1.d_const = Af;
    if ( gyro->DebugMode == 5 ) gyro->pi_XPhase.d_const = Ap;
 
   if ( gyro->DebugMode == 7 ) 
    {
        if ( gyro->DebugCounter++ >= 10 )
        {
            gyro->DebugCounter = 0;
            gyro->ExcitationPhase += (float)2e-6;
        }
    }
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

    f->BlockOut = f->y[0] * (float)1e-4;
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
    pPi->Integral.x[0] = (float)1000.0 * (pPi->m_const*pPi->k_m_const + pPi->d_const - in);

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
void Run_PiDReg( TPiReg *pPi, float in )
{
  // ---- Integral Calculation ----
    pPi->Integral.x[0] = (float)1000.0 * (pPi->m_const + pPi->d_const - in);
    pPi->Differ  .x[0] = pPi->Integral.x[0];

    pPi->Integral.y[0] = pPi->Integral.a[0]*(pPi->Integral.x[0] + pPi->Integral.x[1]) + pPi->Integral.y[1];
    pPi->Differ  .y[0] = pPi->Differ  .a[0]*(pPi->Differ  .x[0] - pPi->Differ  .x[1]) - pPi->Differ  .y[1];

    pPi->Integral.x[1] = pPi->Integral.x[0];    pPi->Differ.x[1] = pPi->Differ.x[0];
    pPi->Integral.y[1] = pPi->Integral.y[0];    pPi->Differ.y[1] = pPi->Differ.y[0];

    pPi->BlockOut  = pPi->Integral.y[0] + pPi->Differ.y[0] + pPi->Integral.x[0] * pPi->Kp;
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
//
//****************************************************************
void Calc_Phase( TInputMean *im, float Period, float PeriodInv, Sint8 isPhase_p000_p360, float u1, float u2 )
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
            if ( CurPhase >= (float)0.5 * Period && isPhase_p000_p360 == 0 ) CurPhase = CurPhase - Period;
			im->CurSumm = im->CurSumm + CurPhase;
			im->isFound = 0;

            if ( ++im->PeriodCounter >= im->PeriodCount )
            {
                im->GlobalMean = PeriodInv * (im->CurSumm * im->PeriodCount_invert);
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

        for ( iCounter = 0; iCounter < gyro->UART_ParamCount; iCounter++ ) 
        {
            if ( gyro->UART_isNeedSummation[iCounter] == 1 ) 
                 gyro->pUARTfloats[iCounter] = gyro->UART_Summation[iCounter] * gyro->UART_Coefs[iCounter] * gyro->UART_SummationCount_invert;
            else gyro->pUARTfloats[iCounter] = gyro->UART_Summation[iCounter] * gyro->UART_Coefs[iCounter]; 
            
            gyro->UART_Summation[iCounter] = (float)0.0;
        }
        gyro->isUART_DataPresent  = 1;
        gyro->UART_SummationPoint = 0;


/*

        gyro->pUARTfloats[10] = gyro->rmnk.pi_pll.BlockOut;
        gyro->pUARTfloats[11] = gyro->rmnk.Qx[0];
        gyro->pUARTfloats[12] = gyro->rmnk.Qy[0];
        gyro->pUARTfloats[13] = gyro->rmnk.XAmpl;
        gyro->pUARTfloats[14] = gyro->rmnk.CAmpl;
        gyro->pUARTfloats[15] = gyro->rmnk.QAmpl;
*/


        //===========================================================================
        //===========================================================================
        //===========================================================================
        //===========================================================================
        if ( Debug.isSleep == 1 && Debug.isInited == 1 )
        {
            gyro->pUARTfloats[gyro->UART_ParamCount - 4] = Debug.param1[Debug.work_counter];
            gyro->pUARTfloats[gyro->UART_ParamCount - 3] = Debug.param2[Debug.work_counter];
            gyro->pUARTfloats[gyro->UART_ParamCount - 2] = Debug.param3[Debug.work_counter];

            if ( ++Debug.work_counter >= Debug.work_count )
            {
                Debug.isSleep = 0;
                Debug.isWork  = 1;
                Debug.work_counter = 0;
            }
        }
        else
        {
            gyro->pUARTfloats[gyro->UART_ParamCount - 4] = Debug.param1[Debug.work_count - 1];
            gyro->pUARTfloats[gyro->UART_ParamCount - 3] = Debug.param2[Debug.work_count - 1];
            gyro->pUARTfloats[gyro->UART_ParamCount - 2] = Debug.param3[Debug.work_count - 1];
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
void Run_Demod_RMNK( TRMNK *prmnk, float inX_raw, float inX, float inY )
{
    float  HQx_raw, HQx, HQy, HQyP;
    float  MjuX_raw[3], MjuX[3], MjuY[3], MjuYP[3];
    float  XPhaseIncriment, YPhaseIncriment;

    MjuX_raw[0] = (float)1e-5;
    MjuX_raw[1] = (float)0.005;
    MjuX_raw[2] = (float)0.005;

    MjuX[0] = (float)1e-5;
    MjuX[1] = (float)0.001;
    MjuX[2] = (float)0.001;

    MjuY[0] = (float)1e-4;
    MjuY[1] = (float)0.003;
    MjuY[2] = (float)0.003;

    //MjuYP[0] = (float)0.0001;
    //MjuYP[1] = (float)0.001;
    //MjuYP[2] = (float)0.001;

    XPhaseIncriment = prmnk->delta_phi + prmnk->pi_pll_x2.BlockOut;
    prmnk->XPeriod_invert = XPhaseIncriment *  TWO_PI_INVERT;
    prmnk->XPeriod        = TWO_PI / XPhaseIncriment;
    prmnk->XFrequency     = prmnk->XPeriod_invert * ALGO_FREQUENCY;
    prmnk->x_phi          = prmnk->x_phi + XPhaseIncriment;
    if ( prmnk->x_phi >= TWO_PI ) prmnk->x_phi -= TWO_PI;
    prmnk->x_base_sin     = sinf(prmnk->x_phi);
    prmnk->x_base_cos     = cosf(prmnk->x_phi);
/*
    YPhaseIncriment = prmnk->delta_phi + prmnk->pi_pll_y.BlockOut;
    prmnk->YPeriod_invert = YPhaseIncriment *  TWO_PI_INVERT;
    prmnk->YPeriod        = TWO_PI / YPhaseIncriment;
    prmnk->YFrequency     = prmnk->YPeriod_invert * ALGO_FREQUENCY;
    prmnk->y_phi           = prmnk->y_phi + YPhaseIncriment;
    if ( prmnk->y_phi >= TWO_PI ) prmnk->y_phi -= TWO_PI;
    prmnk->y_base_sin = sinf(prmnk->y_phi);
    prmnk->y_base_cos = cosf(prmnk->y_phi);
*/
    // *****************************************************************
    // ******  Оценка амплитуды сигнала перед Полосовым фильтром   *****
    // *****************************************************************
    // ---------- Только для Оценки Коефиициента К --------
        HQx_raw          = prmnk->Qx_raw[0] + prmnk->x_base_sin*prmnk->Qx_raw[1] + prmnk->x_base_cos*prmnk->Qx_raw[2] - inX_raw;
        prmnk->Qx_raw[0] = prmnk->Qx_raw[0] - MjuX_raw[0] *                     HQx_raw;
        prmnk->Qx_raw[1] = prmnk->Qx_raw[1] - MjuX_raw[1] * prmnk->x_base_sin * HQx_raw;
        prmnk->Qx_raw[2] = prmnk->Qx_raw[2] - MjuX_raw[2] * prmnk->x_base_cos * HQx_raw;

        prmnk->XAmpl = sqrtf(prmnk->Qx_raw[1]*prmnk->Qx_raw[1] + prmnk->Qx_raw[2]*prmnk->Qx_raw[2]);
    
    // *****************************************************************
    // ******  Оценка фильтрованных параметров Канала X   **************
    // *****************************************************************
    // -------- СТРОЮ ПЛЛ по нему Возбуждение и компенсация ---------
        HQx          = prmnk->Qx[0] + prmnk->x_base_sin*prmnk->Qx[1] + prmnk->x_base_cos*prmnk->Qx[2] - inX;
        prmnk->Qx[0] = prmnk->Qx[0] - MjuX[0] *                     HQx;
        prmnk->Qx[1] = prmnk->Qx[1] - MjuX[1] * prmnk->x_base_sin * HQx;
        prmnk->Qx[2] = prmnk->Qx[2] - MjuX[2] * prmnk->x_base_cos * HQx;

        // ----- Построение ФАпча X -------
        Run_PiReg( &prmnk->pi_pll_x1,  prmnk->Qx[2]              );
        Run_PiReg( &prmnk->pi_pll_x2, -prmnk->pi_pll_x1.BlockOut );

        // ---- Коефициент передачи полосового фильтра ------
        //prmnk->KFilter = - prmnk->base_XAmpl / prmnk->Qx[1];
        prmnk->KFilter = - prmnk->XAmpl / prmnk->Qx[1];
        prmnk->XMean   =   prmnk->Qx[0];
        //prmnk->XAmpl   = - prmnk->Qx[1];


    // ******************************************************************
    // ******  Оценка фильтрованных параметров Канала Y    **************
    // ******************************************************************
        HQy          = prmnk->Qy[0] + prmnk->x_base_sin*prmnk->Qy[1] + prmnk->x_base_cos*prmnk->Qy[2] - inY;
        prmnk->Qy[0] = prmnk->Qy[0] - MjuY[0] *                     HQy;
        prmnk->Qy[1] = prmnk->Qy[1] - MjuY[1] * prmnk->x_base_sin * HQy;
        prmnk->Qy[2] = prmnk->Qy[2] - MjuY[2] * prmnk->x_base_cos * HQy;

        prmnk->YMean =  prmnk->Qy[0];
        //prmnk->YAmpl =  sqrtf( prmnk->Qy[1]*prmnk->Qy[1] + prmnk->Qy[2]*prmnk->Qy[2] );
        //prmnk->CAmpl = -prmnk->Qy[1];
        //prmnk->QAmpl = -prmnk->Qy[2];
        prmnk->YAmpl =  sqrtf( prmnk->Qy[1]*prmnk->Qy[1] + prmnk->Qy[2]*prmnk->Qy[2] ) * prmnk->KFilter;
        //prmnk->CAmpl = -prmnk->Qy[1] * prmnk->KFilter;
        //prmnk->QAmpl = -prmnk->Qy[2] * prmnk->KFilter;

    // ******************************************************************
    // ******  Оценка фильтрованных параметров Канала Y    **************
    // ******************************************************************
/*
        HQyP          = prmnk->QyP[0] + prmnk->y_base_sin*prmnk->QyP[1] + prmnk->y_base_cos*prmnk->QyP[2] - inY;
        prmnk->QyP[0] = prmnk->QyP[0] - MjuYP[0] *                     HQyP;
        prmnk->QyP[1] = prmnk->QyP[1] - MjuYP[1] * prmnk->y_base_sin * HQyP;
        prmnk->QyP[2] = prmnk->QyP[2] - MjuYP[2] * prmnk->y_base_cos * HQyP;

        // ----- Построение ФАпча X -------
        Run_PiReg( &prmnk->pi_pll_y, prmnk->QyP[2] );

        prmnk->YMean =  prmnk->Qy[0];
        prmnk->YAmpl =  sqrtf( prmnk->Qy[1]*prmnk->Qy[1] + prmnk->Qy[2]*prmnk->Qy[2] ) * prmnk->KFilter;
*/

//        prmnk->x_base_sin = - prmnk->x_base_sin;
//        prmnk->x_base_cos = - prmnk->x_base_cos;
}



//*****************************************************************
// 
//*****************************************************************
void Run_Algo( TGyro *gyro ) 
{
    // ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro );

    //gyro->in_Ux *= (float)1.0;
    //gyro->in_Uy *= gyro->rmnk.KFilter;

    //if ( gyro->isAlgoCounter >= 4 )
    //{
    //    gyro->pi_am_1.k_m_const = gyro->rmnk.KFilter;
    //    gyro->rmnk.X2Ampl       = gyro->pi_am_1.m_const * gyro->pi_am_1.k_m_const* gyro->pi_am_1.m_const * gyro->pi_am_1.k_m_const;
    //}

   // ----- Фильтрация входных сигнаов ------
    Input_Filtration_short( &gyro->fi_input_x , gyro->in_Ux );
    Input_Filtration_short( &gyro->fi_input_y , gyro->in_Uy );
    Input_Filtration_short( &gyro->fi_input_x1, gyro->fi_input_x.BlockOut );
    Input_Filtration_short( &gyro->fi_input_y1, gyro->fi_input_y.BlockOut );
    Input_Filtration_short( &gyro->fi_input_x2, gyro->fi_input_x1.BlockOut );
    Input_Filtration_short( &gyro->fi_input_y2, gyro->fi_input_y1.BlockOut );
    Input_Filtration_short( &gyro->fi_input_x3, gyro->fi_input_x2.BlockOut );
    Input_Filtration_short( &gyro->fi_input_y3, gyro->fi_input_y2.BlockOut );
    gyro->fi_input_x.BlockOut = gyro->fi_input_x3.BlockOut;
    gyro->fi_input_y.BlockOut = gyro->fi_input_y3.BlockOut;

//    gyro->fi_input_x.BlockOut = gyro->in_Ux;
//    gyro->fi_input_y.BlockOut = gyro->in_Uy;
 
    // ------ RMNK -----
    Run_Demod_RMNK( &gyro->rmnk      , gyro->in_Ux, gyro->fi_input_x.BlockOut,      gyro->fi_input_y.BlockOut );

    // ------- Демодуляция и Маштабирование ---
    Run_Demod     ( &gyro->fi_demod_c, gyro->fi_input_y.BlockOut * gyro->rmnk.x_base_sin );
    Run_Demod     ( &gyro->fi_demod_q, gyro->fi_input_y.BlockOut * gyro->rmnk.x_base_cos );
    //Run_Demod     ( &gyro->fi_demod_c, gyro->fi_input_y.BlockOut * gyro->rmnk.x_base_sin * gyro->rmnk.KFilter );
    //Run_Demod     ( &gyro->fi_demod_q, gyro->fi_input_y.BlockOut * gyro->rmnk.x_base_cos * gyro->rmnk.KFilter );

   // ----- Регулирование ----
    if ( gyro->isAlgoCounter >= 4 )
    {
        Run_PiReg( &gyro->pi_am_1, gyro->rmnk.XAmpl          );  Run_PiReg( &gyro->pi_am_2, -gyro->pi_am_1.BlockOut );
        Run_PiReg( &gyro->pi_om_1, gyro->fi_demod_c.BlockOut );  Run_PiReg( &gyro->pi_om_2, -gyro->pi_om_1.BlockOut );sss
        Run_PiReg( &gyro->pi_si_1, gyro->fi_demod_q.BlockOut );  Run_PiReg( &gyro->pi_si_2, -gyro->pi_si_1.BlockOut );
    }

    // -------- Коррекция амплитуд -----
    if ( gyro->pi_am_2.BlockOut > (float) 9.5 ) gyro->pi_am_2.BlockOut = (float) 9.5;
    if ( gyro->pi_am_2.BlockOut < (float)-9.5 ) gyro->pi_am_2.BlockOut = (float)-9.5;
    if ( gyro->pi_om_2.BlockOut > (float) 9.5 ) gyro->pi_om_2.BlockOut = (float) 9.5;
    if ( gyro->pi_om_2.BlockOut < (float)-9.5 ) gyro->pi_om_2.BlockOut = (float)-9.5;
    if ( gyro->pi_si_2.BlockOut > (float) 9.5 ) gyro->pi_si_2.BlockOut = (float) 9.5;
    if ( gyro->pi_si_2.BlockOut < (float)-9.5 ) gyro->pi_si_2.BlockOut = (float)-9.5;

    // --------
    gyro->X_Phase_Algo = gyro->ExcitationPhase   + gyro->K_XPhase * gyro->pi_XPhase.BlockOut;
    gyro->Y_Phase_Algo = gyro->CompensationPhase + gyro->K_XPhase * gyro->pi_XPhase.BlockOut;

    // -------- Управляющие сигналы ------------
    gyro->sin_exc  = - sinf( gyro->rmnk.x_phi + gyro->X_Phase_Algo );
    gyro->sin_comp = - sinf( gyro->rmnk.x_phi + gyro->Y_Phase_Algo );
    gyro->cos_comp = - cosf( gyro->rmnk.x_phi + gyro->Y_Phase_Algo );

    gyro->GyroOutRaw = k_omega * gyro->pi_om_2.BlockOut;
    gyro->GyroOut    = gyro->GyroOutRaw;

    gyro->out_Ux     = gyro->pi_am_2.BlockOut * gyro->sin_exc;
    gyro->out_Uy     = gyro->pi_si_2.BlockOut * gyro->sin_comp;
    gyro->out_Uy    -= gyro->pi_om_2.BlockOut * gyro->cos_comp;
    gyro->out_Uy    *= gyro->isCompensationPresent; 
    if ( gyro->isKFilter_CORR == 1 ) gyro->out_Uy    *= gyro->rmnk.KFilter; 

    Calc_Phase ( &gyro->XPhase, gyro->rmnk.XPeriod, gyro->rmnk.XPeriod_invert, 0, gyro->sin_exc, gyro->in_Ux               );
    Calc_Phase ( &gyro->YPhase, gyro->rmnk.XPeriod, gyro->rmnk.XPeriod_invert, 0, gyro->sin_exc, gyro->fi_input_x.BlockOut );
    if ( gyro->XPhase.isNewValuePresent == 1 && gyro->isAlgoCounter >= 5 && gyro->isPhaseCorrectionPresent == 1)
    {
        gyro->XPhase.isNewValuePresent = 0;
        Run_PiReg( &gyro->pi_XPhase, gyro->XPhase.Phase_rad - gyro->ExcitationPhase );
    }

    //----------- Разгон резонатора --------------------------
    gyro->AlgoCounter++;
    if (   gyro->AlgoCounter   >= 20000  ) gyro->isAlgoCounter = 2;
    if (   gyro->AlgoCounter   >= 30000  ) gyro->isAlgoCounter = 3;
    if (   gyro->AlgoCounter   >= 50000  ) gyro->isAlgoCounter = 4;
    if (   gyro->AlgoCounter   >= 500000 ) gyro->isAlgoCounter = 5;

    if ( gyro->isAlgoCounter <= 2 )
    {
        // ---- Скользящий буфера -----
    	memmove(&gyro->XBuffer[1], gyro->XBuffer, 100); 
    	gyro->XBuffer[0] = gyro->fi_input_x.BlockOut * gyro->pi_am_1.m_const_invert;
        gyro->out_Ux     = ( gyro->XBuffer[ gyro->Zn_exc.zn_i ] >= (float)0.0 ) ? (float)7.0 : (float)-7.0;
        gyro->out_Uy     = (float)0.0;
    }

    if ( gyro->isAlgoCounter == 4 && gyro->isIntegCorrected == 0)
    {
        gyro->isIntegCorrected = 1;

        gyro->pi_am_1.Integral.a[0] = gyro->pi_am_1.Integral.a[0] * (float)20.0;
        gyro->pi_om_1.Integral.a[0] = gyro->pi_om_1.Integral.a[0] * (float)20.0;
        gyro->pi_si_1.Integral.a[0] = gyro->pi_si_1.Integral.a[0] * (float)20.0;
        //gyro->rmnk.pi_pll_x1.Integral.a[0] = gyro->rmnk.pi_pll_x1.Integral.a[0] * (float)20.0;

        gyro->pi_am_1.Integral.a[1] = gyro->pi_am_1.Integral.a[0];
        gyro->pi_om_1.Integral.a[1] = gyro->pi_om_1.Integral.a[0];
        gyro->pi_si_1.Integral.a[1] = gyro->pi_si_1.Integral.a[0];
        //gyro->rmnk.pi_pll_x2.Integral.a[0] = gyro->rmnk.pi_pll_x1.Integral.a[0];
    }

    if ( gyro->isAlgoCounter >= 5 && gyro->isIntegCorrected == 1)
    {
        gyro->isIntegCorrected = 2;

        gyro->pi_am_1.Integral.a[0] = gyro->pi_am_1.Integral.a[0] * (float)0.05;
        gyro->pi_om_1.Integral.a[0] = gyro->pi_om_1.Integral.a[0] * (float)0.05;
        gyro->pi_si_1.Integral.a[0] = gyro->pi_si_1.Integral.a[0] * (float)0.05;
        //gyro->rmnk.pi_pll_x1.Integral.a[0] = gyro->rmnk.pi_pll_x1.Integral.a[0] * (float)0.05;

        gyro->pi_am_1.Integral.a[1] = gyro->pi_am_1.Integral.a[0];
        gyro->pi_om_1.Integral.a[1] = gyro->pi_om_1.Integral.a[0];
        gyro->pi_si_1.Integral.a[1] = gyro->pi_si_1.Integral.a[0];
        //gyro->rmnk.pi_pll_x2.Integral.a[0] = gyro->rmnk.pi_pll_x1.Integral.a[0];
    }


    // ------ ОТЛАДКА -----
    if ( gyro->DebugMode != 0 ) SetupAlgo( gyro );
    
    // ------ Debug -----

    if ( Debug.init_counter++ >= Debug.init_count ) Debug.isInited = 1;

    if ( Debug.isWork == 1 && Debug.isInited == 1 )
    {
        //Debug.param1[ Debug.work_counter ] = gyro->rmnk.XAmpl;
        //Debug.param2[ Debug.work_counter ] = gyro->fi_demod_c.BlockOut; //gyro->fi_input_x.BlockOut;//gyro->RMNK.phi;//mod_s2;//gyro->out_Uy;
        //Debug.param3[ Debug.work_counter ] = gyro->fi_demod_q.BlockOut;//;//gyro->RMNK.phi;//mod_s2;//gyro->out_Uy;

        Debug.param1[ Debug.work_counter ] = gyro->pi_am_2.BlockOut;
        Debug.param2[ Debug.work_counter ] = gyro->pi_om_2.BlockOut; //gyro->fi_input_x.BlockOut;//gyro->RMNK.phi;//mod_s2;//gyro->out_Uy;
        Debug.param3[ Debug.work_counter ] = gyro->pi_si_2.BlockOut;//;//gyro->RMNK.phi;//mod_s2;//gyro->out_Uy;

        if ( ++Debug.work_counter >= Debug.work_count )
        {
            Debug.isSleep      = 1;
            Debug.isWork       = 0;
            Debug.work_counter = 0;
        }
    }

} 
