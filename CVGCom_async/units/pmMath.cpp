//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmMath.h"
#include "Math.hpp"
#include "pmMatrix.h"





//===========================================================================
bool Get_Regression_Coef(int PolinomLevel, float *MNKCoef,
                         float     **xVal, int xValParam,
                         float      *yVal, int XY_Arrays_ValuesCount)
{
    if ( XY_Arrays_ValuesCount == 0 ) return false;
    if ( PolinomLevel >= XY_Arrays_ValuesCount) {
       _asm {int 3};
       return false;
    }

    int Xrows = XY_Arrays_ValuesCount, Xcols = PolinomLevel * xValParam;

    double *n_Xmat  = (double*) calloc ( Xrows * Xcols, sizeof(double) );
    double *XMatTr  = (double*) calloc ( Xrows * Xcols, sizeof(double) );
    double *Mat2    = (double*) calloc ( Xcols * Xcols, sizeof(double) );
    double *Mat3    = (double*) calloc ( Xrows * Xcols, sizeof(double) );
    double *Mat_inv = (double*) calloc ( Xcols * Xcols, sizeof(double) );
    double *n_Ymat  = (double*) calloc ( Xrows        , sizeof(double) );
    double *MNK     = (double*) calloc ( Xcols        , sizeof(double) );

    for ( int i = 0; i < XY_Arrays_ValuesCount; i++ )
    {
        n_Ymat[i] = yVal[i];
        for ( int z = 0; z < xValParam; z++)
            for ( int k = 0; k < PolinomLevel; k++)
                n_Xmat[ i*xValParam*PolinomLevel + k + z*PolinomLevel ] = Power(xVal[z][i], (k+1));//xVal[z][i]
    }

    //K = (XMat.Transpose() * XMat).Inverse_Zhordan_0()*XMat.Transpose()*YMat;
    matrix_transponce( Xrows, Xcols, n_Xmat, XMatTr );
    matrix_mul       ( Xcols, Xrows, XMatTr, Xrows, Xcols, n_Xmat, Mat2 );
    matrix_invers    ( Xcols, Mat2, Mat_inv );
    matrix_mul       ( Xcols, Xcols, Mat_inv, Xcols, Xrows, XMatTr, Mat3);
    matrix_mul       ( Xcols, Xrows, Mat3   , Xrows,     1, n_Ymat, MNK);

    for ( int i = 0; i < Xcols; i++) MNKCoef[i] = MNK[i];

    free( n_Xmat  );
    free( XMatTr  );
    free( Mat2    );
    free( Mat3    );
    free( Mat_inv );
    free( n_Ymat  );
    free( MNK     );

/*
    CMatrix XMat = CMatrix(XY_Arrays_ValuesCount, PolinomLevel * xValParam);
    CMatrix YMat = CMatrix(XY_Arrays_ValuesCount, 1);
    CMatrix K;
  // ----------
    for ( int i = 0; i < XY_Arrays_ValuesCount; i++) YMat.Data[i][0] = yVal[i];

    for ( int i = 0; i < XY_Arrays_ValuesCount; i++)
    {
         //for ( int z = 0; z < xValParam; z++)
         //   for ( int k = 0; k <= PolinomLevel; k++)
         //        XMat.Data[i][k + z*(PolinomLevel+1)] = Power(xVal[z][i], k);

         for ( int z = 0; z < xValParam; z++)
            for ( int k = 0; k < PolinomLevel; k++)
                 XMat.Data[i][k + z*(PolinomLevel+0)] = Power(xVal[z][i], (k+1));
    }

  // ----------
    K = (XMat.Transpose() * XMat).Inverse_Zhordan_0()*XMat.Transpose()*YMat;

  // ----------
    for ( int i = 0; i < K.Rows; i++) MNKCoef[i] = K.Data[i][0];
*/
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
              for ( int k = PolinomLevel; k >= 0; k--) XMat.Data[i][k] = Power(xVal[i], k);

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
                    // ---------- Разность соседних сумм -----
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

