//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmMatrix.h"

//===========================================================================
CBaseType::CBaseType()
{
   Rows    = 0;
   Columns = 0;
   Data    = NULL;
}

//===========================================================================
CBaseType::~CBaseType()
{
   DeleteMatrix();
}

//===========================================================================
void CBaseType::DeleteMatrix()
{
   if (Data == NULL) return;
  //
   for (int i = 0; i < Rows; i++)
        if (Data[i] != NULL )delete [] Data[i];
   delete [] Data;
  //
   Data    = NULL;
   Rows    = 0;
   Columns = 0;
}

//===========================================================================
CBaseType *CBaseType::SetSize(int aRows, int aColumns)
{
      if (aRows    < 0) return NULL;
      if (aColumns < 0) return NULL;
    // ----
      if (Data != NULL) DeleteMatrix();
    // ----
      Data = new double*[aRows];
      if (Data == NULL) return NULL;

      for (int i = 0; i < aRows; i++) {
         Data[i] = new double[aColumns];
         if (Data != NULL) {
            memset(Data[i], 0, sizeof(double)*aColumns);
            continue;
         }

        // --- Если совсем плохо удалем строки ----
         for (int k = 0; k < i; k++) delete[] Data[k];
         delete[] Data;
         return NULL;
      }

    // ----
      Rows    = aRows;
      Columns = aColumns;

      //for (int i = 0; i < aRows*aColumns; i++) mData[i] = 0;

      return this; // --- Если все удачно возвращаем указатель на структуру -----
}

//===========================================================================
double& CBaseType::operator () (int row, int column)
{
    if ((row    < 0 ) || (row    >= Rows   )) DEBUG_BREAK();
    if ((column < 0 ) || (column >= Columns)) DEBUG_BREAK();

    //mData[row * Columns + column] =  Data[row][column];
    return Data[row][column];
}
/*
//===========================================================================
//*******************************************************************
// void CMatrixNM::Dump(void* file = 0)
//-------------------------------------------------------------------
// DESCRIPTION:
//  Вывод информации о матрице в файл
//
//  Выводится информация о собдержимом матрицы в файл. Если файл не
//  задан (передано значение 0), то происходит вывод на консоль
//-------------------------------------------------------------------
// PARAMETERS:
//  file - дескриптор файла, куда будет выполнен вывод. По умолчанию
//         равен NULL
//*******************************************************************
void CBaseType::DumpMatrix(void* file)
{
  FILE* output;
  if(file == NULL) output = stdout;
  else output = (FILE *)file;

  if (Data == NULL) {
      fprintf(output, "Matrix is not valid\n");
      return;
  }

  fprintf(output, "Rows : %d\tColumns %d\n", Rows, Columns);
  for(int i = 0; i < Rows; i++)
  {
    for(int j = 0; j < Columns; j++) fprintf(output, "%g ", Data[i][j]);
    fprintf(output, "\n");
  }
}
  */

//===========================================================================
CMatrix::CMatrix()
{
}

//===========================================================================
CMatrix::CMatrix(int aRows, int aColumns)
{
   if (SetSize(aRows, aColumns) == NULL) { DEBUG_BREAK(); return; }
}

//===========================================================================
CMatrix::CMatrix(const CMatrix& Src)
{
   if (Src.Data == NULL) return;

   if ( SetSize(Src.Rows, Src.Columns) == NULL) { DEBUG_BREAK(); return; }

   for(int i = 0; i < Rows; i++)
     for(int j = 0; j < Columns; j++) {
          Data[i][j] = Src.Data[i][j];
     }
}

//===========================================================================
CMatrix::CMatrix(int aRows, int aColumns, double *aData)
{
   if ( aData    == NULL ) return;
   if ( aRows    <= 0    ) return;
   if ( aColumns <= 0    ) return;

   if ( SetSize( aRows, aColumns ) == NULL ) { DEBUG_BREAK(); return; }

   int counter = 0;
   for( int i = 0; i < Rows; i++ )
     for( int j = 0; j < Columns; j++, counter++) {
          Data[i][j] = aData[counter];
     }
}

//===========================================================================
CMatrix CMatrix::operator = (const CMatrix &m)
{
        if (&m == this) return *this;
        if (Data != NULL) DeleteMatrix();
        if (m.Data == NULL) return *this;
    // -----
        if ( SetSize(m.Rows, m.Columns) == NULL ) { DEBUG_BREAK(); return *this; }
    // -----
        for(int i = 0; i < Rows; i++)
          for(int j = 0; j < Columns; j++) {
               Data[i][j] = m.Data[i][j];
          }
// -----
        return *this;
}

//===========================================================================
CMatrix CMatrix::operator + (const CMatrix& m)
{
   if (  Data    == NULL   ) { DEBUG_BREAK(); return CMatrix(); }
   if (m.Data    == NULL   ) { DEBUG_BREAK(); return CMatrix(); }
   if (m.Rows     < Rows   ) { DEBUG_BREAK(); return CMatrix(); }
   if (m.Columns  < Columns) { DEBUG_BREAK(); return CMatrix(); }
 //
   CMatrix Result(Rows, Columns);
 //
   for (int i = 0; i < Rows; i++)
        for (int k = 0; k < Columns; k++){
               Result.Data[i][k] = Data[i][k] + m.Data[i][k];
        }
 //
   return Result;
}

//===========================================================================
CMatrix CMatrix::operator - (const CMatrix &m)
{
   if (  Data    == NULL   ) { DEBUG_BREAK(); return CMatrix(); }
   if (m.Data    == NULL   ) { DEBUG_BREAK(); return CMatrix(); }
   if (m.Rows     < Rows   ) { DEBUG_BREAK(); return CMatrix(); }
   if (m.Columns  < Columns) { DEBUG_BREAK(); return CMatrix(); }
 //
   CMatrix Result(Rows, Columns);
 //
   for (int i = 0; i < Rows; i++)
        for (int k = 0; k < Columns; k++) {
               Result.Data[i][k] = Data[i][k] - m.Data[i][k];
        }
//
   return Result;
}

//===========================================================================
CMatrix CMatrix::operator * (const CMatrix& m)
{
  //  -   умножение двух матриц A (MxN) и B (KxL), определено только для N=K. C=AB. => C – матрица размерности MxL.
   if (  Data    == NULL   ) { DEBUG_BREAK(); return CMatrix(); }
   if (m.Data    == NULL   ) { DEBUG_BREAK(); return CMatrix(); }
   if (m.Rows    != Columns) { DEBUG_BREAK(); return CMatrix(); }
 //
   CMatrix Result(Rows, m.Columns);
 //
    for(int i = 0; i < Rows; i++)
         for(int j = 0; j < m.Columns; j++) {
            for(int k = 0; k < Columns; k++)
                  Result.Data[i][j] += Data[i][k]*m.Data[k][j];

         }
 //
   return Result;
}

//===========================================================================
CMatrix CMatrix::operator * (const double ss)
{
   if ( Data == NULL) { DEBUG_BREAK(); return CMatrix(); }
 // ---
   CMatrix Result(Rows, Columns);
 // ---
   for (int i = 0; i < Rows; i++)
        for (int k = 0; k < Columns; k++) {
            Result.Data[i][k] = Data[i][k] * ss;
        }
 // ---
   return Result;
}

//===========================================================================
CMatrix CMatrix::operator / (const double ss)
{
   if ( Data == NULL) { DEBUG_BREAK(); return CMatrix(); }
   if (    ss == 0   ) { DEBUG_BREAK(); return CMatrix(); }
 // ---
   CMatrix Result(Rows, Columns);
   if(Result.Data == NULL) return CMatrix();
 // ---
   for (int i = 0; i < Rows; i++)
        for (int k = 0; k < Columns; k++){
               Result.Data[i][k] = Data[i][k] / ss;
        }
 // ---
   return Result;
}

//===========================================================================
double* CMatrix::operator [] (int row)
{
   //if ((row    < 0 ) || (row    >= Rows   )) DEBUG_BREAK();
   //if ((column < 0 ) || (column >= Columns)) DEBUG_BREAK();

    return Data[row];
}

//===========================================================================
CMatrix CMatrix::Transpose()
{
    if(Data == NULL) { DEBUG_BREAK(); return CMatrix(); }
  //
    CMatrix Result(Columns, Rows);
    if(Result.Data == NULL) return CMatrix();
  //
    for(int i = 0; i < Rows; i++)
        for(int j = 0; j < Columns; j++) {
            Result.Data[j][i] = Data[i][j];
        }

  //
    return Result;
}

//===========================================================================
void ucvV(double z, CMatrix *Vn1, int n, CMatrix *Wn1) // {  Умножение вектора на комплексное число  }       {2.6}
{
     for (int i = 0; i < n; i++)
            Wn1->Data[i][0] = z * Vn1->Data[i][0];
}

//===========================================================================
void suv(CMatrix *an1, CMatrix *bn1, int n, double *p) // {  Скалярное умножение векторов }              {2.7}
{
  CMatrix Wn1 = CMatrix (n, 1);

  for (int i = 0; i < n; i++)
       Wn1.Data[i][0] = bn1->Data[i][0];

  *p = 0.0;

   double c;
   for (int i = 0; i < n; i++) {
      c  = an1->Data[i][0] * Wn1.Data[i][0];
      *p = c + *p;
   }
}

//===========================================================================
double normav(CMatrix *vn1, int n) // ---  {  Норма вектора}                   {2.8}
{
  double g = 0.0;

  for (int i = 0; i < n; i++)
      g = g + vn1->Data[i][0]*vn1->Data[i][0];

  return sqrt(g);
}

//===========================================================================
void eV(CMatrix *an1, int n, CMatrix *eN1)   // {   Процедура нормировки вектора}                  {2.9}
{
  double g = normav(an1,n) + 1E-10;

  for (int i = 0; i < n; i++)
      eN1->Data[i][0] = an1->Data[i][0] / g;
}

//================== По шарову =========================================================
CMatrix CMatrix::Inverse_Sharov()
{
      if ( Data == NULL   ) return CMatrix();
      if ( Rows != Columns) return CMatrix();
  // -----------
      double cv;
  // -----------

      CMatrix Vp     = CMatrix(Rows, 1);
      CMatrix Vk     = CMatrix(Rows, 1);
      CMatrix Pv     = CMatrix(Rows, 1);
      CMatrix H0     = CMatrix(Rows, 1);
      CMatrix Sv     = CMatrix(Rows, 1);
      CMatrix Result = CMatrix(Rows, Rows);
      CMatrix Mvs    = CMatrix(Rows, Rows);
      CMatrix Mv     = CMatrix(Rows, Rows);

  // -----------
      if (Rows == 1) {
         Result.Data[0][0] = 1 / Data[0][0];
         return Result;
      }

  // -----------
        for (int i = 0; i < Rows; i++)
             H0.Data[i][0] = (i+1)*(i+1) + 1; // ---- !!!! ---- hz 1  ()

        for (int l = 0; l < Rows; l++){
              for (int k = 0; k < Rows - 1; k++)
                   for (int i = 0; i < Rows; i++)
                        if (k < l) Mvs.Data[i][k] = Data[i][k  ];
                              else Mvs.Data[i][k] = Data[i][k+1];
             // -------
              for (int i = 0; i < Rows; i++) Pv.Data[i][0] = Mvs.Data[i][0];

              eV(&Pv, Rows, &Vp);

              for (int i = 0; i < Rows; i++) Mv.Data[i][0] = Vp.Data[i][0];
              for (int k = 1; k < Rows - 1; k++){
                    for (int i = 0; i < Rows; i++) Pv.Data[i][0] = Mvs.Data[i][k];
                    for (int i = 0; i < Rows; i++) Sv.Data[i][0] = 0.0;
                    for (int m = 0; m <= k - 1; m++) {
                          for (int i = 0; i < Rows; i++) Vp.Data[i][0] = Mv.Data[i][m];
                          suv(&Pv, &Vp, Rows, &cv);
                          ucvV(cv,&Vp, Rows, &Vk);
                          for (int i = 0; i < Rows; i++) Sv.Data[i][0] = Vk.Data[i][0]+Sv.Data[i][0];
                    }
                    for (int i = 0; i < Rows; i++) Vk.Data[i][0] = Pv.Data[i][0]-Sv.Data[i][0];
                    eV(&Vk, Rows,&Vp);
                    for (int i = 0; i < Rows; i++) Mv.Data[i][k] = Vp.Data[i][0];
              }
              double cv = 0.0;
              for (int i = 0; i < Rows; i++) Sv.Data[i][0] = cv;
              for (int m = 0; m < Rows - 1; m++){
                    for (int i = 0; i < Rows; i++) Vp.Data[i][0] = Mv.Data[i][m];
                    suv(&H0,&Vp, Rows, &cv);
                    ucvV(cv,&Vp, Rows, &Pv);
                    for (int i = 0; i < Rows; i++) Sv.Data[i][0] = Pv.Data[i][0] + Sv.Data[i][0];
              }

              for (int i = 0; i < Rows; i++) Pv.Data[i][0] = H0.Data[i][0]-Sv.Data[i][0];
              eV(&Pv, Rows, &Vp);
              for (int i = 0; i < Rows; i++) Pv.Data[i][0] = Data[i][l];

              suv(&Vp,&Pv, Rows, &cv);
              ucvV(cv, &Vp, Rows, &Vk);
              double mad = cv * cv;
              for (int i = 0; i < Rows; i++) {
                    Result.Data[i][l] = ( mad != 0 ) ? Vk.Data[i][0] / mad : 0;
              }
        }

        for (int i = 0; i < Rows; i++)
            for (int j = 0; j < Rows; j++)
                Mv.Data[i][j] = Result.Data[j][i];

        for (int i = 0; i < Rows; i++)
            for (int j = 0; j < Rows; j++){
                 Result.Data[i][j] = Mv.Data[i][j];
            }


   return Result;
}

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

//===========================================================================
void CMatrix::Clear()
{
    if(Data == NULL) return;

    for(int i = 0; i < Rows; i++)
       memset(Data[i], 0, sizeof(double)*Columns);
}

//===========================================================================
CMatrix &CMatrix::Identity()
{
    if ( Data == NULL ) { DEBUG_BREAK(); return *this;}

  // --- Обнуляю матрицу ----
     for (int i = 0; i < Rows; i++)
         memset(Data[i], 0, sizeof(double) * Columns);

  // -- Опредиляю минимальное значение размера масива ----
     int aMin = min(Rows, Columns);
     for (int i = 0; i <aMin; i ++) {
            Data[i][i] = 1;
     }
  // ----
     return *this;
}

//===========================================================================
double CMatrix::Det()
{
    if(Data == NULL   ) return -999;  // --- numeric_limits<double>::quiet_NaN();
    if(Rows != Columns) return -999;  // --- numeric_limits<double>::quiet_NaN();
  //
    if(Rows == 1) return  Data[0][0];
    if(Rows == 2) return (Data[0][0]*Data[1][1] - Data[1][0]*Data[0][1]);
  //
    CMatrix Sub(Rows - 1, Columns - 1);
   //
    double Result = 0.0;
   //
    for(int n = 0; n < Columns; n++) {
         for(int i = 1; i < Rows; i++) {
              int Counter = 0;
              for(int j = 0; j < Columns; j++) {
                  if(j == n) continue;
                  Sub.Data[i-1][Counter] = Data[i][j];
                  Counter++;
              }
         }
        //
         double det = Sub.Det();
         if ((n & 1) == 1) det = -det;
         Result += Data[0][n] * det;
    }
   //
    return Result;
}

//===========================================================================
double *CMatrix::Get_GL_Matrix()
{
    bool ResultFlag = true;
    if (Data    == NULL) ResultFlag = false;
    if (Rows    != 3   ) ResultFlag = false;
    if (Columns != 3   ) ResultFlag = false;

    if (ResultFlag == true) {
        for (int i = 0; i < 3; i ++)
           for (int k = 0; k < 3; k ++)
               GLMatrix[i*4 + k] = Data[i][k];

        GLMatrix[0*4 + 3] = 0;
        GLMatrix[1*4 + 3] = 0;
        GLMatrix[2*4 + 3] = 0;

        GLMatrix[3*4 + 0] = 0;
        GLMatrix[3*4 + 1] = 0;
        GLMatrix[3*4 + 2] = 0;
        GLMatrix[3*4 + 3] = 1;
    } else {
        for (int i = 0; i < 16; i ++) GLMatrix[i] = 0;
        GLMatrix[ 0] = 1.0;
        GLMatrix[ 5] = 1.0;
        GLMatrix[10] = 1.0;
        GLMatrix[15] = 1.0;
    }

    return GLMatrix;
}

//===========================================================================
CMatrix operator * (double ss, CMatrix& m)
{
  return CMatrix(m * ss);
}

/*
//===========================================================================
CMatrix diad(const CVector& v1, const CVector& v2)
{
     double aRes[9];

     aRes[0] = v1.Data[0][0] * v2.Data[0][0];    aRes[1] = v1.Data[0][0] * v2.Data[1][0];   aRes[2] = v1.Data[0][0] * v2.Data[2][0];
     aRes[3] = v1.Data[1][0] * v2.Data[0][0];    aRes[4] = v1.Data[1][0] * v2.Data[1][0];   aRes[5] = v1.Data[1][0] * v2.Data[2][0];
     aRes[6] = v1.Data[2][0] * v2.Data[0][0];    aRes[7] = v1.Data[2][0] * v2.Data[1][0];   aRes[8] = v1.Data[2][0] * v2.Data[2][0];

     return CMatrix(3, 3, aRes);
}

//===========================================================================
CMatrix CSop(const CVector& v)
{
     double aRes[9];

     aRes[0] =  0.0;                aRes[1] = -v.Data[2][0];       aRes[2] =  v.Data[1][0];
     aRes[3] =  v.Data[2][0];       aRes[4] =  0.0;                aRes[5] = -v.Data[0][0];
     aRes[6] = -v.Data[1][0];       aRes[7] =  v.Data[0][0];       aRes[8] =  0.0;

     return CMatrix(3, 3, aRes);
}
*/
//===========================================================================
