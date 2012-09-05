//===========================================================================
#ifndef pmMathH
#define pmMathH
//===========================================================================
extern bool Get_Regression_Coef(int PolinomLevel, float *MNKCoef,
                                float     **xVal, int xValParam,
                                float      *yVal, int XY_Arrays_ValuesCount, bool isCalc_a0);

extern bool Get_LMK_Coef(int PolinomLevel, float *xVal, float *yVal, int ValuesCount, float *MNKCoef);

extern void AlanCalc(CCollection<float> &InArray, CCollection<float> &OutArray, TProgressBar *pb, bool *isBrek);
extern int round(double aValue);

extern void FFT(CCollection<float> *re, CCollection<float> *im, int *aPower);

//===========================================================================
#endif
