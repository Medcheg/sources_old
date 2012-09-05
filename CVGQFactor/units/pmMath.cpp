//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmMath.h"
#include "Math.h"

//===========================================================================

bool Get_Regression_Coef(int PolinomLevel, float *MNKCoef,
                         float     **xVal, int xParamCount,
                         float      *yVal, int ValsCount, bool isCalc_a0)
{
    if ( ValsCount == 0 ) return false;
    if ( PolinomLevel >= ValsCount) {
       _asm {int 3};
       return false;
    }
    // true :
    //          k1=1; k2=0;
    // false:
    //          k1=0; k2=1;

    int k1 = ( isCalc_a0 == true  ) ? 1 : 0;
    //int k2 = ( isCalc_a0 == false ) ? 1 : 0;

    CMatrix XMat = CMatrix(ValsCount, (PolinomLevel + k1) * xParamCount);
    CMatrix YMat = CMatrix(ValsCount, 1);
    CMatrix K;
  // ----------
    for ( int i = 0; i < ValsCount; i++) YMat.Data[i][0] = yVal[i];

    for ( int i = 0; i < ValsCount; i++)
        for ( int z = 0; z < xParamCount; z++)
            for ( int k = 0; k < PolinomLevel + k1; k++)
                XMat.Data[i][k + z*(PolinomLevel)] = pow(xVal[z][i], (k+1));
                //XMat.Data[i][k + z*(PolinomLevel)] = pow(xVal[z][i], (k+k2));
                //XMat.Data[i][k + z*(PolinomLevel)] = exp((k+k2) * log (xVal[z][i]));

  // ----------
    K = (XMat.Transpose() * XMat).Inverse_Zhordan_0()*XMat.Transpose()*YMat;

  // ----------
    for ( int i = 0; i < K.Rows; i++)
       MNKCoef[i] = K.Data[i][0];

    return true;
}


//===========================================================================
bool Get_LMK_Coef(int PolinomLevel, float *xVal, float *yVal, int ValuesCount, float *MNKCoef)
{
	if ( ValuesCount == 0 ) return false;
	if ( PolinomLevel >= ValuesCount) {
	   _asm {int 3};
	   return false;
	}
	CMatrix XMat = CMatrix(ValuesCount, PolinomLevel+1);
	CMatrix YMat = CMatrix(ValuesCount, 1);
	CMatrix K;
  // ----------
	for ( int i = 0; i < ValuesCount; i++) YMat.Data[i][0] = yVal[i];

	for ( int i = 0; i < ValuesCount; i++)
			  for ( int k = PolinomLevel; k >= 0; k--) XMat.Data[i][k] = pow(xVal[i], k);

  // ----------
	K = (XMat.Transpose() * XMat).Inverse_Zhordan_0()*XMat.Transpose()*YMat;

  // ----------
	for ( int i = 0; i < K.Rows; i++)
	   MNKCoef[i] = K.Data[i][0];

	return true;
}

//===========================================================================
int round(double aValue)
{
  int aFloor = floor(aValue);

  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
}

//===========================================================================
void AlanCalc(CCollection<float> &InArray, CCollection<float> &OutArray, TProgressBar *pb, bool *isBrek)
{
    // -----
       CCollection<float> CurData;
       double invert_sqrt_2 = 1.0 / sqrt(2); 

    // -----
       int   CountAlanPoint = InArray.ValuesCount / 10.0;
       int   SumCounter;
       float CurrentSum;

       if ( pb != NULL )
       {
           pb->Position = 0;
           pb->Max =  CountAlanPoint;
       }

    // -----
       for ( int i = 0; i < CountAlanPoint; i++)
       {
               CurData.Clear();
             // ---------
               float OldSum = 0;
               for (unsigned int k = 0; k < InArray.ValuesCount; k = k + (i+1))
               {
                      SumCounter = 0;
                      CurrentSum = 0;
                      for ( unsigned int z = k; z < k + (i+1); z++)
                         if ( z <= InArray.ValuesCount - 1)
                         {
                             CurrentSum = CurrentSum + InArray.Values[z];
                             SumCounter++;
                         }

                      CurrentSum = CurrentSum / float(SumCounter);
                    // ---------- �������� �������� ���� -----
                      if ( k > 0 ) CurData.Add( CurrentSum - OldSum);
                    // ----------
                      OldSum = CurrentSum;
               }

               double Mean = CurData.Get_Mean(0, CurData.ValuesCount);
               double SCO  = CurData.Get_SCO (0, CurData.ValuesCount, Mean) * invert_sqrt_2;

               OutArray.Add(SCO); //* 3600

               if ( pb != NULL ) pb->Position = i;
               Application->ProcessMessages();

               if ( *isBrek == true ) return;
       }
}

// =============================================================================
void FFT(CCollection<float> *re, CCollection<float> *im, int *aPower)
{
	double    m,Count,e,l,f;
	double    z,c,s,p,q,r,t,w,v,u,k;
	int      o, i, j,j1,i1;

	*aPower = floor(std::log((double)re->ValuesCount) / (double)std::log(2.0));
	Count   = exp(*aPower * std::log(2.0));
	m       = *aPower;
	//------------------- FFT -----------------------
	for ( l = 1; l <= m; l++){
		  e =  round(exp((m+1-l)*std::log(2.0)));
		  f =  round(e/2.0);
		  u =  1;
		  v =  0;
		  z =  M_PI / (double)f;
		  c =  cos(z);
		  s = -sin(z);
		  for ( int j = 1; j <= f; j++)
		  {
				i = j;
				while (i <= Count)
				{
					  o = i + f - 1;

					  p = re->Values[i-1] + re->Values[o];
                      q = im->Values[i-1] + im->Values[o];
                      r = re->Values[i-1] - re->Values[o];
                      t = im->Values[i-1] - im->Values[o];

                      re->Values[o]   = r*u - t*v;
                      im->Values[o]   = t*u + r*v;
                      re->Values[i-1] = p;
                      im->Values[i-1] = q;

                      i = i + e;
                }
				w = u*c-v*s;
                v = v*c+u*s;
                u = w;
          }
    }

    // ----- -������ ������������ ---------
    j=1;
    for ( i = 1; i < Count; i ++)
    {
      if (i > j) goto mot1;
      j1 = j-1;
      i1 = i-1;
      p  = re->Values[j1];
      q  = im->Values[j1];
      re->Values[j1] = re->Values[i1];
      im->Values[j1] = im->Values[i1];
      re->Values[i1] = p;
      im->Values[i1] = q;
  mot1:
      k = Count/2.0;
  mot2:
      if (k >= j) goto mot3;
      j = j - round(k);
      k = k/2.0;
      goto mot2;
  mot3:
      j = j + round(k);
    }
}


