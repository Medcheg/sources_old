//---------------------------------------------------------------------------
#ifndef pmTauDetectionH
#define pmTauDetectionH
//---------------------------------------------------------------------------
class CRMNK;
class CpiReg;
class CTau
{
private:
	CCollectionStorage<float> *st_sco;
	CCollection<float> *delta_val;

        // ƒл€ сложной демодул€ции ----
        CRMNK  *rmnk;
public:
    CCollectionStorage<float> *st;

	float result_tau;
	float result_sco;

	CTau();
	~CTau();
        void Init( float GyroFreq, float t0 );
    void GetTau_sco  ( CCollection<float> *in, float *tau, float *tau_ampl );
    void GetTau_demod( CCollection<float> *in, CCollectionStorage<float> *out, float t1, float t2, float *tau );
};
//---------------------------------------------------------------------------
#endif
