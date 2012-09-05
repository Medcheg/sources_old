#include "inv_Sharov.h"
#include "Math.h"

//===========================================================================
void ucvV(TFloat z, TFloat *Vn1, int n, TFloat *Wn1) // {  Умножение вектора на комплексное число  }       {2.6}
{
     for (int i = 0; i < n; i++)
            Wn1[i] = z * Vn1[i];
}

//===========================================================================
void suv(TFloat *an1, TFloat *bn1, int n, TFloat *p) // {  Скалярное умножение векторов }              {2.7}
{
  if (n > 20) __asm {int 3};
  TFloat Wn1[20];

  for (int i = 0; i < n; i++)
       Wn1[i] = bn1[i];

  *p = 0.0;

   TFloat c = 0;
   for (int i = 0; i < n; i++) {
      c  = an1[i] * Wn1[i];
      *p = c + *p;
   }
}

//===========================================================================
TFloat normav(TFloat *vn1, int n) // ---  {  Норма вектора}                   {2.8}
{
  TFloat g = 0.0;

  for (int i = 0; i < n; i++)
      g = g + vn1[i]*vn1[i];

  return sqrt(g);
}

//===========================================================================
void eV(TFloat *an1, int n, TFloat *eN1)   // {   Процедура нормировки вектора}                  {2.9}
{
  TFloat g = normav(an1,n) + 1E-10f;

  for (int i = 0; i < n; i++)
      eN1[i] = an1[i] / g;
}

//================== По шарову =========================================================
void inv_Sharov(int Size, TFloat *inMatrix, TFloat *outMatrix)
{
      //if ( inMatrix == NULL ) return;
      if ( Size     > 20    ) __asm { int 3};
  // -----------
      TFloat cv;
  // -----------
      TFloat aIn[20][20];
      TFloat aOut[20][20];
      for (int i = 0; i < Size; i++)
         for (int k = 0; k < Size; k++)
            aIn[i][k] = inMatrix[i*Size + k];
  // -----------
  
      TFloat Vp[20];
      TFloat Vk[20];
      TFloat Pv[20];
      TFloat H0[20];
      TFloat Sv[20];
      TFloat Mvs[20][20];
      TFloat Mv[20][20];

  // -----------
      if (Size == 1) {
         outMatrix[0] = 1 / aIn[0][0];
         return;
      }

  // -----------
        for (int i = 0; i < Size; i++)
             H0[i] = (i+1)*(i+1) + 1.0f; // ---- !!!! ---- hz 1  ()

        for (int l = 0; l < Size; l++){
              for (int k = 0; k < Size - 1; k++)
                   for (int i = 0; i < Size; i++)
                        if (k < l) Mvs[i][k] = aIn[i][k  ];
                              else Mvs[i][k] = aIn[i][k+1];
             // -------
              for (int i = 0; i < Size; i++) Pv[i] = Mvs[i][0];

              eV(Pv, Size, Vp);

              for (int i = 0; i < Size; i++) Mv[i][0] = Vp[i];
              for (int k = 1; k < Size - 1; k++){
                    for (int i = 0; i < Size; i++) Pv[i] = Mvs[i][k];
                    for (int i = 0; i < Size; i++) Sv[i] = 0.0;
                    for (int m = 0; m <= k - 1; m++) {
                          for (int i = 0; i < Size; i++) Vp[i] = Mv[i][m];
                          suv (Pv, Vp, Size, &cv);
                          ucvV(cv, Vp, Size,  Vk);
                          for (int i = 0; i < Size; i++) Sv[i] = Vk[i]+Sv[i];
                    }
                    for (int i = 0; i < Size; i++) Vk[i] = Pv[i]-Sv[i];
                    eV(Vk, Size, Vp);
                    for (int i = 0; i < Size; i++) Mv[i][k] = Vp[i];
              }
              TFloat cv = 0.0;
              for (int i = 0; i < Size; i++) Sv[i] = cv;
              for (int m = 0; m < Size - 1; m++){
                    for (int i = 0; i < Size; i++) Vp[i] = Mv[i][m];
                    suv (H0, Vp, Size, &cv);
                    ucvV(cv, Vp, Size,  Pv);
                    for (int i = 0; i < Size; i++) Sv[i] = Pv[i] + Sv[i];
              }

              for (int i = 0; i < Size; i++) Pv[i] = H0[i]-Sv[i];
              eV(Pv, Size, Vp);
              for (int i = 0; i < Size; i++) Pv[i] = aIn[i][l];

              suv (Vp, Pv, Size, &cv);
              ucvV(cv, Vp, Size,  Vk);
              TFloat mad = cv * cv;
              for (int i = 0; i < Size; i++)
                       aOut[i][l] = Vk[i] / mad;
        }

        for (int i = 0; i < Size; i++)
            for (int j = 0; j < Size; j++)
                Mv[i][j] = aOut[j][i];

        for (int i = 0; i < Size; i++)
            for (int j = 0; j < Size; j++){
                 aOut[i][j] = Mv[i][j];
                 //mData[i*Size + j] = aOut[i][j];
            }
        
  // -----------      
      for (int i = 0; i < Size; i++)
         for (int k = 0; k < Size; k++)
            outMatrix[i*Size + k] = aOut[i][k];
}