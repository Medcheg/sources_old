//===========================================================================
#ifndef pmMathH
#define pmMathH
//===========================================================================
extern bool Get_Regression_Coef(int PolinomLevel, float *MNKCoef,
                                float     **xVal, int xValParam,
                                float      *yVal, int XY_Arrays_ValuesCount, bool isCalc_a0);

extern bool Get_LMK_Coef(int PolinomLevel, float *xVal, float *yVal, int ValuesCount, float *MNKCoef);

extern void AlanCalc   ( float T0, CVector<float> *InArray, CCollection<float> *OutArray, TProgressBar *pb, bool *isBrek );
extern void AlanCalc_GU( float T0, CVector<float> *InArray, CCollection<float> *OutArray, TProgressBar *pb, bool *isBrek );
extern void FFT(CCollection<float> *re_im, int *aPower);

extern int round(double aValue);
//===========================================================================
#endif
