//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmMath.h"
#include "Math.h"
#include "pmMatrix.h"

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
    int k2 = ( isCalc_a0 == false ) ? 1 : 0;

    CMatrix XMat = CMatrix(ValsCount, (PolinomLevel + k1) * xParamCount);
    CMatrix YMat = CMatrix(ValsCount, 1);
    CMatrix K;
  // ----------
    for ( int i = 0; i < ValsCount; i++) YMat.Data[i][0] = yVal[i];

    for ( int i = 0; i < ValsCount; i++)
        for ( int z = 0; z < xParamCount; z++)
            for ( int k = 0; k < PolinomLevel + k1; k++)
                XMat.Data[i][k + z*(PolinomLevel)] = pow(xVal[z][i], (k+k2));

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
void AlanCalc( float T0, CVector<float> *InArray, CCollection<float> *OutArray, TProgressBar *pb, bool *isBrek )
{
    // -----
       CVector<float> CurData;
       double invert_sqrt_2 = 1.0 / sqrt(2);

    // -----
       int   CountAlanPoint = InArray->Length / 4.0;
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
               for (int k = 0; k < InArray->Length; k = k + (i+1))
               {
                      SumCounter = 0;
                      CurrentSum = 0;
                      for ( int z = k; z < k + (i+1); z++)
                         if ( z <= InArray->Length - 1)
                         {
                             CurrentSum = CurrentSum + InArray->Values[z];
                             SumCounter++;
                         }

                      CurrentSum = CurrentSum / float(SumCounter);
                    // ---------- Разность соседних сумм -----
                      if ( k > 0 ) CurData.Add( CurrentSum - OldSum);
                    // ----------
                      OldSum = CurrentSum;
               }

               double Mean = CurData.GetMean(0, CurData.Length);
               double SCO  = CurData.GetSCO (0, CurData.Length, Mean) * invert_sqrt_2;

               //TODO --- доработать индексы -----
               OutArray->Vectors[0]->Add((i+1)*T0); //* 3600
               OutArray->Vectors[1]->Add(SCO); //* 3600

               if ( pb != NULL ) pb->Position = i;
               Application->ProcessMessages();

               if ( *isBrek == true ) break;
       }
}

//===========================================================================
void AlanCalc_GU( float T0, CVector<float> *InArray, CCollection<float> *OutArray, TProgressBar *pb, bool *isBrek )
{
    // -----
       CVector<float> CurData;
       double invert_sqrt_2 = 1.0 / sqrt(2);

    // -----
       int   MaxPointForSum = InArray->Length / 4.0;
       float Sum, Sum1;
       int   SumCounter;

       if ( pb != NULL )
       {
           pb->Position = 0;
           pb->Max =  MaxPointForSum;
       }

    // -----
       for ( int i = 0; i < MaxPointForSum; i++)
       {
               CurData.Clear();
             // ---------
               Sum = 0;
               for (int k = 0; k < InArray->Length; k = k + (i+1))
               {
                      Sum = 0;
                      SumCounter = 0;
                      for ( int z = k; z < k + (i+1); z++)
                         if ( z <= InArray->Length - 1)
                         {
                             Sum += InArray->Values[z];
                             SumCounter++;
                         }

                    Sum = Sum / float(SumCounter);
                    if ( k >= 1 )
                        CurData.Add( (Sum - Sum1)*(Sum - Sum1) );

                    Sum1 = Sum;
               }

               double tau  = (i+1)*T0;
               double SCO  = sqrt(0.5 * CurData.GetMean());
               //TODO --- доработать индексы -----

               OutArray->Vectors[0]->Add(tau); //* 3600
               OutArray->Vectors[1]->Add(SCO); //* 3600

               if ( pb != NULL ) pb->Position = i;
               Application->ProcessMessages();

               if ( *isBrek == true ) break;
       }
}

// =============================================================================
void FFT(CCollection<float> *re_im, int *aPower)
{
    double    m,Count,e,l,f;
    double    z,c,s,p,q,r,t,w,v,u,k;
    int      o, i, j,j1,i1;

    int    vector_length = re_im->Vectors[0]->Length;
    float *re = (float*)re_im->Vectors[0]->Values;
    float *im = (float*)re_im->Vectors[1]->Values;

    *aPower = floor(std::log((double)vector_length) / (double)std::log(2.0));
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

                      p = re[i-1] + re[o];
                      q = im[i-1] + im[o];
                      r = re[i-1] - re[o];
                      t = im[i-1] - im[o];

                      re[o]   = r*u - t*v;
                      im[o]   = t*u + r*v;
                      re[i-1] = p;
                      im[i-1] = q;

                      i = i + e;
                }
				w = u*c-v*s;
                v = v*c+u*s;
                u = w;
          }
    }

    // ----- -тюшўэр  яхЁхёЄрэютър ---------
    j=1;
    for ( i = 1; i < Count; i ++)
    {
      if (i > j) goto mot1;
      j1 = j-1;
      i1 = i-1;
      p  = re[j1];
      q  = im[j1];
      re[j1] = re[i1];
      im[j1] = im[i1];
      re[i1] = p;
      im[i1] = q;
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

