//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmTauDetection.h"
#include "pmFiltration.h"
#include "pmRMNK.h"

//===========================================================================
CTau::CTau()
{
	st        = new CCollectionStorage<float>();
	st_sco    = new CCollectionStorage<float>();
	delta_val = new CCollection       <float>();

        rmnk = new CRMNK();

	st    ->SetItemsCount(2);
	st_sco->SetItemsCount(2);
}

//===========================================================================
CTau::~CTau()
{
	delete st;
	delete st_sco;
	delete delta_val;
        delete rmnk;
}

//===========================================================================
void CTau::Init( float GyroFreq, float t0 )
{
        rmnk->Init( GyroFreq, 0.002, t0);
}

//===========================================================================
void CTau::GetTau_sco(CCollection<float> *in, float *tau, float *tau_ampl )
{
    st->Items[0]->Clear();
    st->Items[1]->Clear();

    // ------- Оприделяю огибающею -----
    int incr = in->ValuesCount / 100;

    for ( unsigned int i = 0; i < in->ValuesCount - incr; i++)
    {
        float max = in->Values[i];
        float index = i;
        for ( unsigned int k = i; k < i + incr; k++)
        {
            if ( max < in->Values[k])
            {
                max = in->Values[k];
                index = k;
            }
        }
        st->Items[0]->Add(index);
        st->Items[1]->Add(max);

        i = i + incr;
    }

    // ------ Убираю не правильный начальный участок, тот, который находится в "покое" ----

    int   index = 0;
    for ( unsigned int i = 0; i < st->Items[0]->ValuesCount; i++)
        if ( st->Items[1]->Values[i] < st->Items[1]->Maximum * 0.9 )
            index = i;
        else
            break;

    st->Items[0]->Delete_Diapazon(0, index + 2 );
    st->Items[1]->Delete_Diapazon(0, index + 2 );

    // ------ Достаю експоненту ----
    int   step_count = 50;

	float audio_t0 = 1.0 / 48000.0;
	float end_interval_offs = st->Items[1]->Values[st->Items[1]->ValuesCount - 1 ];
    float delta_tau = 15.0 / (float)step_count;
	float current_tau = 0.1;

	result_tau  = -1;
	result_sco  = -1;

	while ( delta_tau > 0.001 )
	{
		st_sco->Items[0]->Clear();
		st_sco->Items[1]->Clear();

		for ( int i = 0; i < step_count; i++)
		{
			delta_val->Clear();

			float   x = st->Items[0]->Values[0] * audio_t0 / current_tau;
			*tau_ampl = (st->Items[1]->Values[0] - end_interval_offs) / exp(-x);

			for ( unsigned int i = 0; i < st->Items[0]->ValuesCount; i++)
            {
                float x = st->Items[0]->Values[i] * audio_t0 / current_tau;

                float     val = st->Items[1]->Values[i];
                float exp_val = end_interval_offs + *tau_ampl * exp(-x);

                delta_val->Add( exp_val - val );
            }
            st_sco->Items[0]->Add(current_tau);
            st_sco->Items[1]->Add(delta_val->Get_SCO(0, false));

            //int z = st_sco->Items[0]->ValuesCount - 1;
            //chart->Series[0]->AddXY(st_sco->Items[0]->Values[z], st_sco->Items[1]->Values[z]);

            current_tau = current_tau + delta_tau;
        }
        // 1. опредиляю минимум по SCO
        // 2. нахожу новое delta_tau
        // 3. задаю начальное tau (current_tau)

        float min, tau1, tau2;
        int   ind, ind1, ind2;
        st_sco->Items[1]->Get_Minimum_ext(&min, &ind);

        ind1 = ind - 1;
        ind2 = ind + 1;

		if ( ind1 <= 0) ind1 = 0;
		if ( ind2 > (int)st_sco->Items[0]->ValuesCount - 1 ) ind2 = (int)st_sco->Items[0]->ValuesCount - 1;

		tau1 = st_sco->Items[0]->Values[ind1];
		tau2 = st_sco->Items[0]->Values[ind2];

		current_tau = tau1;
		delta_tau   = (tau2 - tau1) / (float)step_count;

		result_tau = st_sco->Items[0]->Values[ind];
		result_sco = st_sco->Items[1]->Values[ind];
	}

	*tau = result_tau;
}


//===========================================================================
void CTau::GetTau_demod(CCollection<float> *in, CCollectionStorage<float> *out, float t1, float t2, float *tau )
{
    CCollection<float> local_ampls;
    CCollection<float> local_freqs;
    st->Items[0]->Clear();
    st->Items[1]->Clear();

    out->Items[0]->Clear(); // ---- Times (points)
    out->Items[1]->Clear(); // ---- Demod Signal
    out->Items[2]->Clear(); // ---- Demod Signal - Aproximation
    out->Items[3]->Clear(); // ---- Demod Signal - Analitic Simusoid
    out->Items[4]->Clear(); // ---- Log ( DemodSignal )
    out->Items[5]->Clear(); // ---- Log ( DemodSignal ) - Aproximation
    out->Items[5]->Clear(); // ---- Frequency

    *tau = 0.0;

    //   Запускаю РМНК, с опредиление частоты (пи регуляторы)
    //   Результат закидываю local_ampls, для того что бы посчитать минимум
    //   изза того что бы потом этот минимум добавить к масиву, изза ошибок LOG
    int OffsetFromBeginingArray = -1;
    for ( unsigned int i = 0; i < in->ValuesCount; i++)
    {
        rmnk->Run_pireg(in->Values[i]);

        //   откидываем переходной процесс
        if ( i >= 0.5 / rmnk->T0 ){
            if ( OffsetFromBeginingArray == -1 ) OffsetFromBeginingArray = i;
            local_ampls.Add( rmnk->Ampl );
            local_freqs.Add( rmnk->CalculatedFrequency );
        }
    }

    //    формирую новый масив данных, скоректированный так, чтобы масс небыл с отрицательными членами
    float min_val = ( local_ampls.Minimum < 0 ) ? -local_ampls.Minimum*1.05 : 0;
    for ( unsigned int i = 0; i < local_ampls.ValuesCount; i++)
        local_ampls.Values[i] += min_val;

    local_ampls.RecalcMinMax();

    //    ФОрмирую массив усредненных данных, гдето 2000 точек
    int iterrator_step = (local_ampls.ValuesCount < 2000) ? 1: local_ampls.ValuesCount * 0.0005;
    ///int iterrator_step = 1;
    for ( unsigned int i = 1; i < local_ampls.ValuesCount - iterrator_step; i = i + iterrator_step )
    {
        float val_a = local_ampls.Get_Mean(i, i + iterrator_step);
        float val_f = local_freqs.Get_Mean(i, i + iterrator_step);
        float t     = i*rmnk->T0;

        if ( t >= t1 && t <= t2 ){
            out->Items[0]->Add(t);  // ---- привожу ось Х ко времени ---
            out->Items[1]->Add(val_a);
            out->Items[4]->Add(log(val_a));
            out->Items[6]->Add(val_f);
        }
    }

    //    формирую данные для МНК
    float   RegCoef[100] = {0};
    float  *fx = out->Items[0]->Get_Array();
    float  *fy = out->Items[4]->Get_Array();

//    Get_Regression_Coef( 1, RegCoef, &fx, 1, fy, out->Items[0]->ValuesCount, true );
    Get_LMK_Coef(1, fx, fy, out->Items[0]->ValuesCount, RegCoef);

    // ---- Апроксимационные кривые ----
    for ( unsigned int i = 0; i < out->Items[0]->ValuesCount; i++){
        float t = out->Items[0]->Values[i];
        out->Items[2]->Add( exp(RegCoef[0])*exp(t * RegCoef[1]) );
        //out->Items[3]->Add( exp(RegCoef[0])*exp(t * RegCoef[1]) * sin( TWO_PI * rmnk->GyroFreq * t ) );
        out->Items[3]->Add( in->Values[(int)(OffsetFromBeginingArray + out->Items[0]->Values[i] / rmnk->T0)] );
        out->Items[5]->Add( RegCoef[0] +  RegCoef[1] * t );
    }

    *tau = - 1.0 / RegCoef[1];
}

