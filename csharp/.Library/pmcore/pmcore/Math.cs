using System;
using System.Collections.Generic;
using System.Text;

namespace pmcore
{
    public static class Math
    {
        public static double min(double a, double b) { return (((a) < (b)) ? (a) : (b)); }
        public static double max(double a, double b) { return (((a) > (b)) ? (a) : (b)); }
        public static double min3(double a, double b, double c) { return (((a) <  (b)) ? (((a)<(c))?(a):(c)) : (((b)<(c))?(b):(c))); }
        public static double max3(double a, double b, double c) { return (((a) >  (b)) ? (((a)>(c))?(a):(c)) : (((b)>(c))?(b):(c))); }
        /// <summary>
        /// Считает коэфициенты регрессии для "У" набором данных "Х"
        /// </summary>
        /// <param name="x">Набор данных Х</param>
        /// <param name="y">К чему стремимся</param>
        /// <param name="power">Степенной ряд, для которого делаем счет</param>
        /// <returns></returns>
        public static double [][] Regression( pmcore.Collection y, pmcore.Collection x, int[] powers)
        {
            if ( x             == null       ) throw new Exception("(x) is null");
            if ( y             == null       ) throw new Exception("(y) is null");
            if ( powers        == null       ) throw new Exception("(powers) is null");
            if ( powers.Length >= y[0].Count ) throw new Exception("Length is small");

            int ValuesCount  = y[0].Count;
            int xParamCount  = x.VectorsCount;
            int PolinomLevel = powers.Length;

            double [][]result = new double[xParamCount][];
            for ( int i = 0; i < xParamCount; i++) result[i] = new double[PolinomLevel];
                
            pmcore.Types.Matrix XMat = new pmcore.Types.Matrix(ValuesCount, PolinomLevel * xParamCount);
            pmcore.Types.Matrix YMat = new pmcore.Types.Matrix(ValuesCount, 1);
            pmcore.Types.Matrix K    = new Types.Matrix(); 

            for ( int i = 0; i < ValuesCount; i++ ) YMat[i][0] = y[0][i];

            for ( int i = 0; i < ValuesCount; i++)
                for ( int z = 0; z < xParamCount; z++)
                    for ( int k = 0; k < PolinomLevel; k++)
                        XMat[i][k + z*(PolinomLevel)] = System.Math.Pow(x[z][i], powers[k]);
            

            K = (XMat.Transpose() * XMat).Inverse()*XMat.Transpose()*YMat;

            // ---------- K.Rows
            for ( int i = 0; i < xParamCount; i++)
                for ( int k = 0; k < PolinomLevel; k++ )
                    result[i][k] = K[k + i*PolinomLevel][0];

            return result;
        }
    }
}
