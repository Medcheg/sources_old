using System;
using System.Collections.Generic;
using System.Text;



namespace nkcore.Types
{
    public class Matrix
    {
    // Matrix GetBlock(int I, int J, int rows, int columns);
    // void    SetBlock(int I, int J, const Matrix& m);
    // void MatrixNM::Dump(void* file = 0)
    // double  *Get_GL_Matrix();
    //Matrix operator = (const Matrix &m);

        private List<List<double>> data;
        private int columns;
        private int rows;
        
        public List<double> this[int index]
        {
            get { return data[index]; }
        }
        public int Rows
        {
            get { return rows; }
        }
        public int Columns
        {
            get { return columns; }
        }


        private void delete_Matrix()
        {
            if ( data == null) return;
          //
            for (int i = 0; i < rows; i++)
                data[i].Clear();

            data.Clear(); 
            data = null;

            rows    = 0;
            columns = 0;

            GC.Collect();
        }

        private Matrix set_Size(int _rows, int _columns)
        {
            if (_rows    <= 0) return null;
            if (_columns <= 0) return null;
            
            // ----
            if (data != null ) delete_Matrix();
            // ----

            data = new List<List<double>>();
            for (int i = 0; i < _rows; i++)
            {
                data.Add(new List<double>());
                for (int k = 0; k < _columns; k++)
                    data[i].Add(0);
            }

            rows    = _rows;
            columns = _columns;

            return this;
        }

        public Matrix() 
        {
            data = null;
            columns = 0;
            rows = 0;
        }

        public Matrix( Matrix source_matrix)
        {
            if ( source_matrix.data == null )  throw new Exception("Input matrix is null");

            if ( set_Size(source_matrix.rows, source_matrix.columns ) == null) 
                throw new Exception("Somthing wrong with matrix dimension");

            for (int i = 0; i < rows; i++)
                for (int j = 0; j < columns; j++)
                    data[i][j] = source_matrix.data[i][j];
        }

        public Matrix(int _rows, int _columns, double []adata)
        {
            if (adata == null) return;
            if (_rows <= 0) return;
            if (_columns <= 0) return;

            if ( set_Size( _rows, _columns) == null )
                throw new Exception("Somthing wrong with matrix dimension");

            int counter = 0;
            for (int i = 0; i < _rows; i++)
                for (int j = 0; j < _columns; j++, counter++)
                    data[i][j] = adata[counter];
        }

        public Matrix(int _rows, int _columns)
        {
            if (_rows <= 0) return;
            if (_columns <= 0) return;

            if (set_Size(_rows, _columns) == null)
                throw new Exception("Somthing wrong with matrix dimension");
        }

        /// <summary>
        /// Транспорирование матрици.
        /// Исходную матрицу не трогает, возвращает новую
        /// </summary>
        public Matrix Transpose()
        {
            if (data == null)
                throw new Exception("Input matrix is null");

            Matrix result_matrix = new Matrix(columns, rows);

            for ( int i = 0; i < rows; i++)
                for(int j = 0; j < columns; j++ )
                    result_matrix.data[j][i] = data[i][j];

            return result_matrix;
        }

        /// <summary>
        /// Обнуляет элементы проинициализированной матрицы
        /// </summary>
        public void Clear()
        {
            if (data == null)
                throw new Exception("Input matrix is null");

            for (int i = 0; i < rows; i++)
                for (int j = 0; j < columns; j++)
                    data[i][j] = 0.0;
        }

        /// <summary>
        /// Возвращает детерминант матрици
        /// </summary>
        public double Det()
        {
            if (data == null)
                throw new Exception("Input matrix is null");
            if (data == null)
                throw new Exception("Matrix isnt square");

            if ( rows == 1 ) return  data[0][0];
            if ( rows == 2 ) return (data[0][0]*data[1][1] - data[1][0]*data[0][1]);

            Matrix Sub = new Matrix( rows - 1, columns - 1);
            //
            double result = 0.0;
            //
            for(int n = 0; n < columns; n++) 
            {
                for(int i = 1; i < rows; i++) 
                {
                    int counter = 0;
                    for ( int j = 0; j < columns; j++) 
                    {
                        if ( j == n ) continue;
                        
                        Sub.data[i-1][counter] = data[i][j];
                        counter++;
                    }
                }
                //
                double det = Sub.Det();
                
                if ( (n & 1) == 1 ) det = -det;
                
                result += data[0][n] * det;
            }

            return result;
        }

        /// <summary>
        /// Возвращает единичную матрицу
        /// </summary>
        public Matrix Identity()
        {
            if (data == null)
                throw new Exception("Input matrix is null");

            Clear();

            int min_side = (rows < columns) ? rows : columns;

            for ( int i = 0; i < min_side; i++)
                data[i][i] = 1;

            return this;
        }

        /// <summary>
        /// Сумирование двух матриц М1,М2, результат новая матрица
        /// </summary>
        public static Matrix operator + (Matrix m1, Matrix m2)
        {
            if (m1.data    == null      ) throw new Exception("m1: data is null");
            if (m2.data    == null      ) throw new Exception("m2: data is null");
            if (m2.rows     < m1.rows   ) throw new Exception("ma1, m2 size isn't equal");
            if (m2.columns  < m1.columns) throw new Exception("ma1, m2 size isn't equal");
            //
            Matrix result = new Matrix(m1.rows, m1.columns);
            //
            for (int i = 0; i < m1.rows; i++)
                for (int k = 0; k < m1.columns; k++)
                {
                    result.data[i][k] = m1.data[i][k] + m1.data[i][k];
            }

          return result;            
        }

        /// <summary>
        /// Вычитание из матрици М1,М2, результат новая матрица
        /// </summary>
        public static Matrix operator - (Matrix m1, Matrix m2)
        {
            if (m1.data == null) throw new Exception("m1: data is null");
            if (m2.data == null) throw new Exception("m2: data is null");
            if (m2.rows < m1.rows) throw new Exception("ma1, m2 size isn't equal");
            if (m2.columns < m1.columns) throw new Exception("ma1, m2 size isn't equal");
            //
            Matrix result = new Matrix(m1.rows, m1.columns);
            //
            for (int i = 0; i < m1.rows; i++)
                for (int k = 0; k < m1.columns; k++)
                {
                    result.data[i][k] = m1.data[i][k] - m1.data[i][k];
                }

            return result;
        }

        /// <summary>
        /// Умножение двух матриц М1 на М2, результат новая матрица
        /// </summary>
        public static Matrix operator * (Matrix m1, Matrix m2)
        {
            if (m1.data    == null     ) throw new Exception("m1: data is null");
            if (m2.data    == null     ) throw new Exception("m2: data is null");
            if (m2.rows    < m1.columns) throw new Exception("m2.rows != m1.columns size isn't equal");
            //
            Matrix result = new Matrix(m1.rows, m2.columns);
            //
            for ( int i = 0; i < m1.rows; i++ )
                 for ( int j = 0; j < m2.columns; j++ )
                    for ( int k = 0; k < m1.columns; k++ )
                        result.data[i][j] += m1.data[i][k]*m2.data[k][j];

            return result;
        }

        /// <summary>
        /// Умножение матрици М1 на константу, результат новая матрица
        /// </summary>
        public static Matrix operator * (Matrix m1, double val)
        {
            if (m1.data    == null     ) throw new Exception("m1: data is null");
            //
            Matrix result = new Matrix(m1.rows, m1.columns);
            //
            for ( int i = 0; i < m1.rows; i++ )
                 for ( int k = 0; k < m1.columns; k++ )
                        result.data[i][k] = m1.data[i][k]*val;

            return result;
        }

        /// <summary>
        /// Умножение константы на матрицу М1, результат новая матрица
        /// </summary>
        public static Matrix operator * (double val, Matrix m1 )
        {
            if (m1.data    == null     ) throw new Exception("m1: data is null");
            //
            Matrix result = new Matrix(m1.rows, m1.columns);
            //
            for ( int i = 0; i < m1.rows; i++ )
                 for ( int k = 0; k < m1.columns; k++ )
                        result.data[i][k] = m1.data[i][k]*val;

            return result;
        }

        /// <summary>
        /// Деление матрици М1 на константу, результат новая матрица
        /// </summary>
        public static Matrix operator / (Matrix m1, double val)
        {
            if (m1.data == null ) throw new Exception("m1: data is null");
            if (val     == 0.0  ) throw new Exception("divide by 0");
            //
            Matrix result = new Matrix(m1.rows, m1.columns);
            //
            for ( int i = 0; i < m1.rows; i++ )
                 for ( int k = 0; k < m1.columns; k++ )
                        result.data[i][k] = m1.data[i][k] / val;

            return result;
        }

        /// <summary>
        /// Обратное преобразование матрици по методу Жордана, результат новая матрица
        /// </summary>
        public Matrix Inverse()
        {
            if ( data == null   ) throw new Exception("input data is null");
            if ( rows != columns) throw new Exception("Matrix isn`t square");

            // Копирование матрици 
            Matrix result = new Matrix(this);

            // -----------
            int    i, k, j;
            double d1, d2;

            for( i = 0; i < rows; i++)
            {
                d1 = ( result.data[i][i] != 0) ? -((double)1.0 / result.data[i][i]) : -1.0;
                for (k = 0; k < rows; k++) 
                    result.data[k][i] *= d1;

                d1 = -d1;
                result.data[i][i] = d1;
                for(j = i-1; j >= 0; j--)
                {
                    d2 = result.data[i][j];

                    for (k = i - 1; k >= 0; k--) result.data[k][j] += result.data[k][i] * d2;
                    for (k = i + 1; k < rows; k++) result.data[k][j] += result.data[k][i] * d2;

                    result.data[i][j] *= d1;
                }
                for(j = i + 1; j < rows; j++)
                {
                d2 = result.data[i][j];

                for (k = i - 1; k >= 0; k--) result.data[k][j] += result.data[k][i] * d2;
                for (k = i + 1; k < rows; k++) result.data[k][j] += result.data[k][i] * d2;

                result.data[i][j] *= d1;
                }
            }

            // ---------
            return result;
        }

        /// <summary>
        /// ПРеобразование матрици в строку
        /// </summary>
        public override string ToString()
        {
            if ( data == null   ) throw new Exception("input data is null");

            string ss = "";
            for ( int i = 0; i < rows; i++ )
            {
                for ( int k = 0; k < columns; k++ )
                    if ( k == 0)
                         ss += data[i][k].ToString("f9");
                    else ss += "\t" + data[i][k].ToString("f9");

                ss += System.Environment.NewLine;
            }

            return ss;
        }
       
////*******************************************************************
//// void MatrixNM::Dump(void* file = 0)
////-------------------------------------------------------------------
//// DESCRIPTION:
////  Вывод информации о матрице в файл
////
////  Выводится информация о собдержимом матрицы в файл. Если файл не
////  задан (передано значение 0), то происходит вывод на консоль
////-------------------------------------------------------------------
//// PARAMETERS:
////  file - дескриптор файла, куда будет выполнен вывод. По умолчанию
////         равен null
////*******************************************************************
//void CBaseType::DumpMatrix(void* file)
//{
//  FILE* output;
//  if(file == null) output = stdout;
//  else output = (FILE *)file;

//  if (data == null) {
//      fprintf(output, "Matrix is not valid\n");
//      return;
//  }

//  fprintf(output, "rows : %d\tcolumns %d\n", rows, columns);
//  for(int i = 0; i < rows; i++)
//  {
//    for(int j = 0; j < columns; j++) fprintf(output, "%g ", data[i][j]);
//    fprintf(output, "\n");
//  }
//}

    
////===========================================================================
//double *Matrix::Get_GL_Matrix()
//{
//    bool ResultFlag = true;
//    if (data    == null) ResultFlag = false;
//    if (rows    != 3   ) ResultFlag = false;
//    if (columns != 3   ) ResultFlag = false;

//    if (ResultFlag == true) {
//        for (int i = 0; i < 3; i ++)
//           for (int k = 0; k < 3; k ++)
//               GLMatrix[i*4 + k] = data[i][k];

//        GLMatrix[0*4 + 3] = 0;
//        GLMatrix[1*4 + 3] = 0;
//        GLMatrix[2*4 + 3] = 0;

//        GLMatrix[3*4 + 0] = 0;
//        GLMatrix[3*4 + 1] = 0;
//        GLMatrix[3*4 + 2] = 0;
//        GLMatrix[3*4 + 3] = 1;
//    } else {
//        for (int i = 0; i < 16; i ++) GLMatrix[i] = 0;
//        GLMatrix[ 0] = 1.0;
//        GLMatrix[ 5] = 1.0;
//        GLMatrix[10] = 1.0;
//        GLMatrix[15] = 1.0;
//    }

//    return GLMatrix;
//}

////===========================================================================
//Matrix diad(const CVector& v1, const CVector& v2)
//{
//     double aRes[9];

//     aRes[0] = v1.data[0][0] * v2.data[0][0];    aRes[1] = v1.data[0][0] * v2.data[1][0];   aRes[2] = v1.data[0][0] * v2.data[2][0];
//     aRes[3] = v1.data[1][0] * v2.data[0][0];    aRes[4] = v1.data[1][0] * v2.data[1][0];   aRes[5] = v1.data[1][0] * v2.data[2][0];
//     aRes[6] = v1.data[2][0] * v2.data[0][0];    aRes[7] = v1.data[2][0] * v2.data[1][0];   aRes[8] = v1.data[2][0] * v2.data[2][0];

//     return Matrix(3, 3, aRes);
//}

////===========================================================================
//Matrix CSop(const CVector& v)
//{
//     double aRes[9];

//     aRes[0] =  0.0;                aRes[1] = -v.data[2][0];       aRes[2] =  v.data[1][0];
//     aRes[3] =  v.data[2][0];       aRes[4] =  0.0;                aRes[5] = -v.data[0][0];
//     aRes[6] = -v.data[1][0];       aRes[7] =  v.data[0][0];       aRes[8] =  0.0;

//     return Matrix(3, 3, aRes);
//}


////===========================================================================
//void ucvV(double z, Matrix *Vn1, int n, Matrix *Wn1) // {  Умножение вектора на комплексное число  }       {2.6}
//{
//     for (int i = 0; i < n; i++)
//            Wn1->data[i][0] = z * Vn1->data[i][0];
//}

////===========================================================================
//void suv(Matrix *an1, Matrix *bn1, int n, double *p) // {  Скалярное умножение векторов }              {2.7}
//{
//  Matrix Wn1 = Matrix (n, 1);

//  for (int i = 0; i < n; i++)
//       Wn1.data[i][0] = bn1->data[i][0];

//  *p = 0.0;

//   double c;
//   for (int i = 0; i < n; i++) {
//      c  = an1->data[i][0] * Wn1.data[i][0];
//      *p = c + *p;
//   }
//}

////===========================================================================
//double normav(Matrix *vn1, int n) // ---  {  Норма вектора}                   {2.8}
//{
//  double g = 0.0;

//  for (int i = 0; i < n; i++)
//      g = g + vn1->data[i][0]*vn1->data[i][0];

//  return sqrt(g);
//}

////===========================================================================
//void eV(Matrix *an1, int n, Matrix *eN1)   // {   Процедура нормировки вектора}                  {2.9}
//{
//  double g = normav(an1,n) + 1E-10;

//  for (int i = 0; i < n; i++)
//      eN1->data[i][0] = an1->data[i][0] / g;
//}

////================== По шарову =========================================================
//Matrix Matrix::Inverse_Sharov()
//{
//      if ( data == null   ) return Matrix();
//      if ( rows != columns) return Matrix();
//  // -----------
//      double cv;
//  // -----------

//      Matrix Vp     = Matrix(rows, 1);
//      Matrix Vk     = Matrix(rows, 1);
//      Matrix Pv     = Matrix(rows, 1);
//      Matrix H0     = Matrix(rows, 1);
//      Matrix Sv     = Matrix(rows, 1);
//      Matrix Result = Matrix(rows, rows);
//      Matrix Mvs    = Matrix(rows, rows);
//      Matrix Mv     = Matrix(rows, rows);

//  // -----------
//      if (rows == 1) {
//         result.data[0][0] = 1 / data[0][0];
//         return Result;
//      }

//  // -----------
//        for (int i = 0; i < rows; i++)
//             H0.data[i][0] = (i+1)*(i+1) + 1; // ---- !!!! ---- hz 1  ()

//        for (int l = 0; l < rows; l++){
//              for (int k = 0; k < rows - 1; k++)
//                   for (int i = 0; i < rows; i++)
//                        if (k < l) Mvs.data[i][k] = data[i][k  ];
//                              else Mvs.data[i][k] = data[i][k+1];
//             // -------
//              for (int i = 0; i < rows; i++) Pv.data[i][0] = Mvs.data[i][0];

//              eV(&Pv, rows, &Vp);

//              for (int i = 0; i < rows; i++) Mv.data[i][0] = Vp.data[i][0];
//              for (int k = 1; k < rows - 1; k++){
//                    for (int i = 0; i < rows; i++) Pv.data[i][0] = Mvs.data[i][k];
//                    for (int i = 0; i < rows; i++) Sv.data[i][0] = 0.0;
//                    for (int m = 0; m <= k - 1; m++) {
//                          for (int i = 0; i < rows; i++) Vp.data[i][0] = Mv.data[i][m];
//                          suv(&Pv, &Vp, rows, &cv);
//                          ucvV(cv,&Vp, rows, &Vk);
//                          for (int i = 0; i < rows; i++) Sv.data[i][0] = Vk.data[i][0]+Sv.data[i][0];
//                    }
//                    for (int i = 0; i < rows; i++) Vk.data[i][0] = Pv.data[i][0]-Sv.data[i][0];
//                    eV(&Vk, rows,&Vp);
//                    for (int i = 0; i < rows; i++) Mv.data[i][k] = Vp.data[i][0];
//              }
//              double cv = 0.0;
//              for (int i = 0; i < rows; i++) Sv.data[i][0] = cv;
//              for (int m = 0; m < rows - 1; m++){
//                    for (int i = 0; i < rows; i++) Vp.data[i][0] = Mv.data[i][m];
//                    suv(&H0,&Vp, rows, &cv);
//                    ucvV(cv,&Vp, rows, &Pv);
//                    for (int i = 0; i < rows; i++) Sv.data[i][0] = Pv.data[i][0] + Sv.data[i][0];
//              }

//              for (int i = 0; i < rows; i++) Pv.data[i][0] = H0.data[i][0]-Sv.data[i][0];
//              eV(&Pv, rows, &Vp);
//              for (int i = 0; i < rows; i++) Pv.data[i][0] = data[i][l];

//              suv(&Vp,&Pv, rows, &cv);
//              ucvV(cv, &Vp, rows, &Vk);
//              double mad = cv * cv;
//              for (int i = 0; i < rows; i++) {
//                    result.data[i][l] = ( mad != 0 ) ? Vk.data[i][0] / mad : 0;
//              }
//        }

//        for (int i = 0; i < rows; i++)
//            for (int j = 0; j < rows; j++)
//                Mv.data[i][j] = result.data[j][i];

//        for (int i = 0; i < rows; i++)
//            for (int j = 0; j < rows; j++){
//                 result.data[i][j] = Mv.data[i][j];
//            }


//   return Result;
//}


    }
}
