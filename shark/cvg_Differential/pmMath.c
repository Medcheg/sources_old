#include "pmMath.h"
#include <string.h>   // ---- Юнит нужен для функции MemMove ----
#include <gclib.h>

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
void Calc_Period(TPeriodDetector *pd, float u)
{
    if ( pd->u_old < 0 && u >= 0) 
    {
        pd->isTempFlag = 1;
        pd->Period = pd->fTacks - pd->u_old / (u - pd->u_old );
        pd->fTacks =  u / (u - pd->u_old);

        // ----- Усреднение за Заданое количество секунд ----
        // ----- по умолчанию в Ините прописано 5 секунд усреднения ----
        pd->PeriodSumm = pd->PeriodSumm + pd->Period;
        if ( ++pd->Current_PeriodSummPoint >= pd->Count_PeriodSumm )
        {
            pd->isNewPeriodPresent      = 1;
            pd->PeriodMiddle            =  pd->PeriodSumm * pd->Count_PeriodSumm_invert - (float)1.0;
            pd->PeriodSumm              = 0;
            pd->Current_PeriodSummPoint = 0;
        }
    }    

    pd->fTacks = pd->fTacks + (float)1.0;
    pd->u_old = u;
}


//****************************************************************
// **** For one period finds only a 1 crossing through a zero ****
//****************************************************************
void Calc_Phase ( TPhaseDetector *pd, float u1, float u2 )
{

        if ( pd->u1_old < 0 && u1 >= 0 && pd->isFound == 0) 
        {
			pd->fTacks = u1 / (u1 - pd->u1_old);
			pd->isFound = 1;
            return;
        }

    /////////////////		   
        if ( pd->u2_old < 0 && u2 >= 0 && pd->isFound == 1  ) 
        {
			pd->PhaseError = pd->fTacks + pd->u2_old / (pd->u2_old - u2);
			pd->isFound = 0;

            // ----- Усреднение за Заданое количество секунд ----
            // ----- по умолчанию в Ините прописано 5 секунд усреднения ----
            pd->PhaseSumm = pd->PhaseSumm + pd->PhaseError;
            if ( ++pd->Current_PhaseSummPoint >= pd->Count_PhaseSumm )
            {
                pd->BlockOut               =  pd->PhaseSumm * pd->Count_PhaseSumm_invert;
                pd->PhaseSumm              = 0;
                pd->Current_PhaseSummPoint = 0;
            }
        }

	  pd->u1_old = u1;
      pd->u2_old = u2;
	  pd->fTacks = pd->fTacks + (float)1.0;
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
void CalcInputMean( TInputMean *im, float inValue )
{
    if ( im->Old_InputVal < 0 && inValue >= 0 )
    {
        im->PeriodCounter = im->PeriodCounter + 1;
        if ( im->PeriodCounter >= im->PeriodCount )
        {
	        //memmove(&im->SliderBuffer[1], im->SliderBuffer, 16); //4x4
            im->SliderBuffer[4] = im->SliderBuffer[3];
            im->SliderBuffer[3] = im->SliderBuffer[2];
            im->SliderBuffer[2] = im->SliderBuffer[1];
            im->SliderBuffer[1] = im->SliderBuffer[0];

            im->SliderBuffer[0] = im->CurSumm / (float)im->NCounter;

            im->BlockOut = im->SliderBuffer[0] + im->SliderBuffer[1] + im->SliderBuffer[2] + im->SliderBuffer[3] + im->SliderBuffer[4];
            im->BlockOut = im->BlockOut * im->SliderBuffer_invertCount;

            im->CurSumm         = (float)0.0;
            im->PeriodCounter   = 0;
            im->NCounter        = 0;
        }
    }   
    im->CurSumm  = im->CurSumm + inValue;
    im->NCounter = im->NCounter + 1;
    im->Old_InputVal = inValue;
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
            gyro->pUARTfloats[iCounter] = gyro->UART_Summation[iCounter] * gyro->UART_SummationCount_invert;
            gyro->UART_Summation[iCounter] = (float)0.0;
        }
        gyro->isUART_DataPresent  = 1;
        gyro->UART_SummationPoint = 0;
    }
}

//*****************************************************************
//
//*****************************************************************
/*
void Setup_DifferrentFreq( TGyro *gyro )
{
    TSetupDifferentFreq *df = &gyro->SetupDF;

    df->CurTime = df->CurTime + DISCRET_TIME;
    
    Setup_Zn(&gyro->Zn_exc_x);
    Setup_Zn(&gyro->Zn_exc_y);
    Setup_Zn(&gyro->Zn_df_x);
    Setup_Zn(&gyro->Zn_df_y);

    if ( df->CurTime <  df->TimePos0 ) return;
    if ( df->CurTime >= df->TimePos0       )  df->GyroOutSum += gyro->GyroOut;
    if ( df->CurTime >= df->TimePos0 + 1.0 ) 
    {
        Run_PiReg( &df->pi_reg, -df->GyroOutSum * DISCRET_TIME );

        df->GyroOutSum = (float)0.0;
        df->CurTime = df->TimePos0;

        gyro->Zn_cos.zn_curr = df->pi_reg.BlockOut;
    }
}
*/
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
void Run_Algo( TGyro *gyro )
{
    Sint16 iCounter = 0;
    float    znCoef;
    char   *phz;
    char   ch;

   // ----- Фильтрация ------
    Input_Filtration( gyro );

   // ----- Расчет средних зачений, и их вычитание ------

    CalcInputMean( &gyro->XInputMean, gyro->fi_input_x.BlockOut );
    CalcInputMean( &gyro->YInputMean, gyro->fi_input_y.BlockOut );
    //gyro->fi_input_x.BlockOut = gyro->fi_input_x.BlockOut - gyro->XInputMean.BlockOut;
    //gyro->fi_input_y.BlockOut = gyro->fi_input_y.BlockOut - gyro->YInputMean.BlockOut;

   // ----- Расчет периода коледаний ------
   // ---- !!!!!!! ---- Эту функцию нада будет потом нагрузить расчетом среднего периода ----
    Calc_Period        ( &gyro->PeriodD     , gyro->fi_input_x.BlockOut );
    Calc_Phase_180     ( &gyro->PhaseD      , gyro->fi_input_x.BlockOut, gyro->fi_input_y.BlockOut );

    Calc_Phase         ( &gyro->SystemPhaseX, gyro->Exc_X_value, gyro->fi_input_x.BlockOut );
    Calc_Phase         ( &gyro->SystemPhaseY, gyro->Exc_Y_value, gyro->fi_input_y.BlockOut );
 
    // ---- Скользящие буфера -----
	memmove(&gyro->XBuffer[1], gyro->XBuffer, 100); // 100 = 25 * 4
	memmove(&gyro->YBuffer[1], gyro->YBuffer, 100); // 100 = 25 * 4
	gyro->XBuffer[0] = gyro->fi_input_x.BlockOut * gyro->pi_ampl_x1.m_const_invert;
	gyro->YBuffer[0] = gyro->fi_input_y.BlockOut * gyro->pi_ampl_y1.m_const_invert;

   // ----- Демодулирование ------
    Run_Demod( &gyro->fi_demod_x, gyro->XBuffer[0] * gyro->fi_input_x.BlockOut );
	Run_Demod( &gyro->fi_demod_y, gyro->YBuffer[0] * gyro->fi_input_y.BlockOut );

    // ----- Перерасчет значений временных задержек, если пришел новый период -----
    if ( gyro->PeriodD.isNewPeriodPresent == 1  && gyro->isAlgoCounter >= 2 && gyro->DebugMode == 0)
    {
        gyro->PeriodD.isNewPeriodPresent = 0;

        znCoef = gyro->PeriodD.PeriodMiddle * gyro->DefaultPeriod_invert;

        gyro->Zn_exc_x.zn_curr = znCoef * gyro->Zn_exc_x.zn_base;
        gyro->Zn_exc_y.zn_curr = znCoef * gyro->Zn_exc_y.zn_base;

        gyro->Zn_df_x.zn_curr = gyro->Zn_exc_x.zn_curr - (float)0.25 * gyro->PeriodD.PeriodMiddle;
        gyro->Zn_df_y.zn_curr = gyro->Zn_exc_y.zn_curr - (float)0.25 * gyro->PeriodD.PeriodMiddle;

        Setup_Zn(&gyro->Zn_exc_x);
        Setup_Zn(&gyro->Zn_exc_y);
        Setup_Zn(&gyro->Zn_df_x);
        Setup_Zn(&gyro->Zn_df_y);

        // -------- Стабилизация амплитуд -----
        Run_PiReg( &gyro->pi_ampl_x1, gyro->fi_demod_x.BlockOut );
        Run_PiReg( &gyro->pi_ampl_y1, gyro->fi_demod_y.BlockOut );
    }

    // ----- Управление разночастотностью ------
    if ( gyro->PhaseD.isNewPhasePresent == 1 && gyro->isAlgoCounter >= 2 ) 
    {
        gyro->PhaseD.isNewPhasePresent = 0;
        Run_PiReg( &gyro->pi_xy1, gyro->PhaseD.PhaseError );
    }


    

    //----------- Разгон резонатора --------------------------
    gyro->AlgoCounter++;
    if ( gyro->AlgoCounter >  100000 ) { gyro->isAlgoCounter = 2; gyro->PeriodD.isNewPeriodPresent = 1; }
    if ( gyro->AlgoCounter >  300000 )   gyro->isFlag3       = 1;
    if ( gyro->AlgoCounter >  400000 )   gyro->isFlag3       = 2;
    if ( gyro->AlgoCounter >  500000 )   gyro->isFlag3       = 3;
    if ( gyro->isAlgoCounter == 1 )
    {
        Setup_Zn(&gyro->Zn_exc_x);
        Setup_Zn(&gyro->Zn_exc_y);
        Setup_Zn(&gyro->Zn_df_x);
        Setup_Zn(&gyro->Zn_df_y);

        gyro->Exc_X_value = Get_SplineValue( gyro->XBuffer, &gyro->Zn_exc_x);
        gyro->Exc_Y_value = Get_SplineValue( gyro->YBuffer, &gyro->Zn_exc_y);

        //gyro->out_Ux  = ( gyro->XBuffer[ gyro->Zn_exc_x.zn_i ] >= (float)0.0 ) ? (float)gyro->pi_ampl_x1.BlockOut : (float)-gyro->pi_ampl_x1.BlockOut;
        //gyro->out_Uy  = ( gyro->YBuffer[ gyro->Zn_exc_y.zn_i ] >= (float)0.0 ) ? (float)gyro->pi_ampl_y1.BlockOut : (float)-gyro->pi_ampl_y1.BlockOut;
        gyro->out_Ux  = ( gyro->Exc_X_value >= (float)0.0 ) ? (float)1.0 : (float)-1.0;
        //gyro->out_Uy  = ( gyro->Exc_Y_value >= (float)0.0 ) ? (float)1.0 : (float)-1.0;
        //gyro->out_Ux -= gyro->pi_xy1.BlockOut * gyro->XBuffer[ gyro->Zn_df_x.zn_i ];
        //gyro->out_Uy += gyro->pi_xy1.BlockOut * gyro->YBuffer[ gyro->Zn_df_y.zn_i ];

        return;
    }


    // ----- Выходы системы --------
    //gyro->GyroOut    = global_andata;
    //gyro->Quadrature = global_ndata;
    gyro->GyroOut    = gyro->pi_ampl_x1.BlockOut - gyro->pi_ampl_y1.BlockOut;
    gyro->Quadrature = gyro->pi_ampl_x1.BlockOut + gyro->pi_ampl_y1.BlockOut;

    gyro->Exc_X_value = Get_SplineValue( gyro->XBuffer, &gyro->Zn_exc_x);
    gyro->Exc_Y_value = Get_SplineValue( gyro->YBuffer, &gyro->Zn_exc_y);

    gyro->out_Ux     = gyro->pi_ampl_x1.BlockOut * gyro->Exc_X_value;
    gyro->out_Uy     = gyro->pi_ampl_y1.BlockOut * gyro->Exc_Y_value;
    gyro->out_Ux    -= gyro->pi_xy1.BlockOut * Get_SplineValue( gyro->XBuffer, &gyro->Zn_df_x);
    gyro->out_Uy    += gyro->pi_xy1.BlockOut * Get_SplineValue( gyro->YBuffer, &gyro->Zn_df_y);

    // ------ ДАННЫЕ В UART -------
    Setup_UART_data( gyro );

/*
    // ----- переключение на другую ампл накачки ----
    if ( gyro->isFlag3 == 1 && gyro->isInited == 0)
    {
        gyro->pi_ampl_x1.m_const = (float)1.8;
        gyro->pi_ampl_x1.m_const_invert = (float)1.0 / gyro->pi_ampl_x1.m_const;  

    }
    if ( gyro->isFlag3 == 2 && gyro->isInited == 0)
    {
        gyro->pi_ampl_y1.m_const = (float)1.8;
        gyro->pi_ampl_y1.m_const_invert = (float)1.0 / gyro->pi_ampl_y1.m_const;  
    }

    if ( gyro->isFlag3 == 3 && gyro->isInited == 0)
    {
        gyro->isInited = 1;

        gyro->Zn_exc_x.zn_curr = (float)14.6909;
        gyro->Zn_exc_y.zn_curr = (float)14.6909;

        Setup_Zn(&gyro->Zn_exc_x);
        Setup_Zn(&gyro->Zn_exc_y);
        Setup_Zn(&gyro->Zn_df_x);
        Setup_Zn(&gyro->Zn_df_y);
    }
*/


    // ------ ОТЛАДКА -----

//    Setup_DifferrentFreq( gyro );
/*
    gyro->DebugMode = 1;    
    if ( gyro->isFlag3 == 1 && gyro->TempParam >= 8)
    {
        gyro->TempParam = 0;
        gyro->Zn_exc_x.zn_curr += (float)0.000002;
        gyro->Zn_exc_y.zn_curr += (float)0.000002;
        
    }   
    gyro->TempParam++;
    Setup_Zn(&gyro->Zn_exc_x);
    Setup_Zn(&gyro->Zn_exc_y);
    Setup_Zn(&gyro->Zn_df_x);
    Setup_Zn(&gyro->Zn_df_y);
*/
//0.1266677511
//0.0626528562
//0.0640148254
}




