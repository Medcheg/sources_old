//---------------------------------------------------------------------------
#include "pmMatrix.h"
#include "Math.h"

// ---- Перемножение двух матриц -----
void matrix_mul( Uint16 Rows1, Uint16 Columns1 , float *m1, Uint16 Rows2, Uint16 Columns2, float *m2, float *out_Matrix )
{
    float value;

    for(unsigned short int  i = 0; i < Rows1; i++)
        for(unsigned short int  j = 0; j < Columns2; j++) {
             value = 0;
             for (unsigned short int  k = 0; k < Rows2; k++)
                  value += m1[i*Columns1 + k]*m2[k*Columns2 + j];

             out_Matrix[i*Columns2 + j] = value;
        }
}

// ----Транспонирование матрици ----
void matrix_transponce( Uint16 Rows , Uint16 Columns  , float *in_Matrix, float *out_Matrix )
{
    for( unsigned short int i = 0; i < Rows; i++)
       for( unsigned short int j = 0; j < Columns; j++)
           out_Matrix[j*Rows + i] = in_Matrix[i*Columns + j];
}

// ---- Сумирование матриц ----
void matrix_summ( Uint16 Rows , Uint16 Columns  , float *m1, float *m2, float *out_Matrix )
{
	unsigned short int index;

      for(unsigned short int  i = 0; i < Rows; i++)
          for(unsigned short int  j = 0; j < Columns; j++)
          {
          	index = i*Columns;
            out_Matrix[index + j] = m1[index + j] + m2[index + j];
          }
}

// ---- Вычитание матриц -----
void matrix_sub( Uint16 Rows , Uint16 Columns  , float *m1, float *m2, float *out_Matrix )
{
	unsigned short int index;

    for(unsigned short int  i = 0; i < Rows; i++)
        for(unsigned short int  j = 0; j < Columns; j++)
        {
            index = i*Columns;
            out_Matrix[index + j] = m1[index + j] - m2[index + j];
        }

}

// ---- Обратная матрица Zhordan_0----
void matrix_invers( Uint16 Rows , float *in_Matrix, float *out_Matrix )
{
    for( unsigned short int i = 0; i < Rows; i++)
       for( unsigned short int k = 0; k < Rows; k++)
           out_Matrix[i*Rows + k] = in_Matrix[i*Rows + k];

    int    i, k, j;
    double d1, d2;

    for( i = 0; i < Rows; i++)
    {
        int iRows = i*Rows;

        d1 = ( out_Matrix[iRows + i] != 0) ? -((double)1.0 / out_Matrix[iRows + i]) : -1.0;
        for (k = 0; k < Rows; k++) out_Matrix[k*Rows + i] *= d1;

        d1 = -d1;
        out_Matrix[iRows + i] = d1;
        for(j = i-1; j >= 0; j--)
        {
            d2 = out_Matrix[iRows + j];

            for (k = i - 1; k >=   0; k--) out_Matrix[k*Rows + j] += out_Matrix[k*Rows + i] * d2;
            for (k = i + 1; k < Rows; k++) out_Matrix[k*Rows + j] += out_Matrix[k*Rows + i] * d2;

            out_Matrix[iRows + j] *= d1;
        }
        for(j = i + 1; j < Rows; j++)
        {
            d2 = out_Matrix[iRows + j];

            for (k = i - 1; k >=   0; k--) out_Matrix[k*Rows + j] += out_Matrix[k*Rows + i] * d2;
            for (k = i + 1; k < Rows; k++) out_Matrix[k*Rows + j] += out_Matrix[k*Rows + i] * d2;

            out_Matrix[iRows + j] *= d1;
        }
    }
}

// ---- Перемножение двух матриц -----
void matrix_mul( Uint16 Rows1, Uint16 Columns1  , double *m1, Uint16 Rows2, Uint16 Columns2  , double *m2, double *out_Matrix )
{
    double value;

    for(unsigned short int  i = 0; i < Rows1; i++)
        for(unsigned short int  j = 0; j < Columns2; j++) {
             value = 0;
             for (unsigned short int  k = 0; k < Rows2; k++)
                  value += m1[i*Columns1 + k]*m2[k*Columns2 + j];

             out_Matrix[i*Columns2 + j] = value;
        }
}

// ----Транспонирование матрици ----
void matrix_transponce( Uint16 Rows , Uint16 Columns   , double *in_Matrix, double *out_Matrix )
{
    for( unsigned short int i = 0; i < Rows; i++)
       for( unsigned short int j = 0; j < Columns; j++)
           out_Matrix[j*Rows + i] = in_Matrix[i*Columns + j];
}

// ---- Сумирование матриц ----
void matrix_summ( Uint16 Rows , Uint16 Columns   , double *m1, double *m2, double *out_Matrix )
{
	unsigned short int index;

      for(unsigned short int  i = 0; i < Rows; i++)
          for(unsigned short int  j = 0; j < Columns; j++)
          {
          	index = i*Columns;
            out_Matrix[index + j] = m1[index + j] + m2[index + j];
          }
}

// ---- Вычитание матриц -----
void matrix_sub( Uint16 Rows , Uint16 Columns   , double *m1, double *m2, double *out_Matrix )
{
	unsigned short int index;

    for(unsigned short int  i = 0; i < Rows; i++)
        for(unsigned short int  j = 0; j < Columns; j++)
        {
            index = i*Columns;
            out_Matrix[index + j] = m1[index + j] - m2[index + j];
        }

}

// ---- Обратная матрица Zhordan_0----
void matrix_invers( Uint16 Rows , double *in_Matrix, double *out_Matrix )
{
    for( unsigned short int i = 0; i < Rows; i++)
       for( unsigned short int k = 0; k < Rows; k++)
           out_Matrix[i*Rows + k] = in_Matrix[i*Rows + k];

    int    i, k, j;
    double d1, d2;

    for( i = 0; i < Rows; i++)
    {
        int iRows = i*Rows;

        d1 = ( out_Matrix[iRows + i] != 0) ? -((double)1.0 / out_Matrix[iRows + i]) : -1.0;
        for (k = 0; k < Rows; k++) out_Matrix[k*Rows + i] *= d1;

        d1 = -d1;
        out_Matrix[iRows + i] = d1;
        for(j = i-1; j >= 0; j--)
        {
            d2 = out_Matrix[iRows + j];

            for (k = i - 1; k >=   0; k--) out_Matrix[k*Rows + j] += out_Matrix[k*Rows + i] * d2;
            for (k = i + 1; k < Rows; k++) out_Matrix[k*Rows + j] += out_Matrix[k*Rows + i] * d2;

            out_Matrix[iRows + j] *= d1;
        }
        for(j = i + 1; j < Rows; j++)
        {
            d2 = out_Matrix[iRows + j];

            for (k = i - 1; k >=   0; k--) out_Matrix[k*Rows + j] += out_Matrix[k*Rows + i] * d2;
            for (k = i + 1; k < Rows; k++) out_Matrix[k*Rows + j] += out_Matrix[k*Rows + i] * d2;

            out_Matrix[iRows + j] *= d1;
        }
    }
}










/*
//===========================================================================
CMatrix CMatrix::Inverse_Zhordan_0()
{
   if ( Data == NULL   ) return CMatrix();
   if ( Rows != Columns) return CMatrix();

   CMatrix Result = CMatrix(Rows, Rows);

  // ----------- Копирование матрици ----
    for (int i = 0; i < Rows; i++)
       for (int k = 0; k < Rows; k++)
          Result.Data[i][k]  =  Data[i][k];

  // -----------

      int    i, k, j;
      double d1, d2;

      for( i = 0; i < Rows; i++)
      {
            d1 = (Result.Data[i][i] != 0) ? -((double)1.0 / Result.Data[i][i]) : -1.0;
            for (k = 0; k < Rows; k++) Result.Data[k][i] *= d1;

            d1 = -d1;
            Result.Data[i][i] = d1;
            for(j = i-1; j >= 0; j--)
            {
              d2 = Result.Data[i][j];

              for (k = i - 1; k >= 0; k--) Result.Data[k][j] += Result.Data[k][i] * d2;
              for (k = i + 1; k < Rows; k++) Result.Data[k][j] += Result.Data[k][i] * d2;

              Result.Data[i][j] *= d1;
            }
            for(j = i + 1; j < Rows; j++)
            {
              d2 = Result.Data[i][j];

              for (k = i - 1; k >= 0; k--) Result.Data[k][j] += Result.Data[k][i] * d2;
              for (k = i + 1; k < Rows; k++) Result.Data[k][j] += Result.Data[k][i] * d2;

              Result.Data[i][j] *= d1;
            }
      }

  // ---------
   return Result;
}
*/

//===========================================================================
void Inverse_Matrix_ucvV(float z, float *Vn1, int n, float *Wn1) // {  Умножение вектора на комплексное число  }       {2.6}
{
     for (int i = 0; i < n; i++)
         Wn1[i] = z * Vn1[i];
}

//===========================================================================
void Inverse_Matrix_suv(float *an1, float *bn1, int n, float *p) // {  Скалярное умножение векторов }              {2.7}
{
  float Wn1[20];

  for (int i = 0; i < n; i++) Wn1[i] = bn1[i];

  *p = 0.0;

   float c;
   for (int i = 0; i < n; i++) {
      c  = an1[i] * Wn1[i];
      *p = c + *p;
   }
}

//===========================================================================
void Inverse_Matrix_eV(float *an1, int n, float *eN1)   // {   Процедура нормировки вектора}                  {2.9}
{
// ---  {  Норма вектора}                   {2.8}
  float g = 0.0;
  for (int i = 0; i < n; i++) g += an1[i]*an1[i];
  g = 1.0 / sqrt(g);

  for (int i = 0; i < n; i++) eN1[i] = an1[i] * g;
}

void Get_Inverse_Matrix(unsigned short int aSize, float *aInMatrix, float *aOutMatrix)
{
      if ( aInMatrix == NULL ) return;
      if ( aSize     > 20    ) __asm { int 3};
  // -----------
      float cv;
  // -----------
      float aIn[20][20];
      float aOut[20][20];
      for (int i = 0; i < aSize; i++)
         for (int k = 0; k < aSize; k++)
            aIn[i][k] = aInMatrix[i*aSize + k];
  // -----------

      float Vp[20];
      float Vk[20];
      float Pv[20];
      float H0[20];
      float Sv[20];
      float Mvs[20][20];
      float Mv[20][20];

  // -----------
      if (aSize == 1) {
         aOutMatrix[0] = 1 / aIn[0][0];
         return;
      }

  // -----------
        for (int i = 0; i < aSize; i++)
             H0[i] = (i+1)*(i+1) + 1.0f; // ---- !!!! ---- hz 1  ()

        for (int l = 0; l < aSize; l++){
              for (int k = 0; k < aSize - 1; k++)
                   for (int i = 0; i < aSize; i++)
                        if (k < l) Mvs[i][k] = aIn[i][k  ];
                              else Mvs[i][k] = aIn[i][k+1];
             // -------
              for (int i = 0; i < aSize; i++) Pv[i] = Mvs[i][0];

              Inverse_Matrix_eV(Pv, aSize, Vp);

              for (int i = 0; i < aSize; i++) Mv[i][0] = Vp[i];
              for (int k = 1; k < aSize - 1; k++){
                    for (int i = 0; i < aSize; i++) Pv[i] = Mvs[i][k];
                    for (int i = 0; i < aSize; i++) Sv[i] = 0.0;
                    for (int m = 0; m <= k - 1; m++) {
                          for (int i = 0; i < aSize; i++) Vp[i] = Mv[i][m];
                          Inverse_Matrix_suv (Pv, Vp, aSize, &cv);
                          Inverse_Matrix_ucvV(cv, Vp, aSize,  Vk);
                          for (int i = 0; i < aSize; i++) Sv[i] = Vk[i]+Sv[i];
                    }
                    for (int i = 0; i < aSize; i++) Vk[i] = Pv[i]-Sv[i];
                    Inverse_Matrix_eV(Vk, aSize, Vp);
                    for (int i = 0; i < aSize; i++) Mv[i][k] = Vp[i];
              }
              float cv = 0.0;
              for (int i = 0; i < aSize; i++) Sv[i] = cv;
              for (int m = 0; m < aSize - 1; m++){
                    for (int i = 0; i < aSize; i++) Vp[i] = Mv[i][m];
                    Inverse_Matrix_suv (H0, Vp, aSize, &cv);
                    Inverse_Matrix_ucvV(cv, Vp, aSize,  Pv);
                    for (int i = 0; i < aSize; i++) Sv[i] = Pv[i] + Sv[i];
              }

              for (int i = 0; i < aSize; i++) Pv[i] = H0[i]-Sv[i];
              Inverse_Matrix_eV(Pv, aSize, Vp);
              for (int i = 0; i < aSize; i++) Pv[i] = aIn[i][l];

              Inverse_Matrix_suv (Vp, Pv, aSize, &cv);
              Inverse_Matrix_ucvV(cv, Vp, aSize,  Vk);
              float mad = cv * cv;
              for (int i = 0; i < aSize; i++)
                       aOut[i][l] = Vk[i] / mad;
        }

        for (int i = 0; i < aSize; i++)
            for (int j = 0; j < aSize; j++)
                Mv[i][j] = aOut[j][i];

        for (int i = 0; i < aSize; i++)
            for (int j = 0; j < aSize; j++){
                 aOut[i][j] = Mv[i][j];
                 //mData[i*aSize + j] = aOut[i][j];
            }

  // -----------
      for (int i = 0; i < aSize; i++)
         for (int k = 0; k < aSize; k++)
            aOutMatrix[i*aSize + k] = aOut[i][k];
}

