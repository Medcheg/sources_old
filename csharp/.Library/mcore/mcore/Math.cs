using System;
using System.Collections.Generic;
using System.Text;

namespace mcore
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
        public static double [][] Regression( mcore.Types.Collection y, mcore.Types.Collection x, int[] powers)
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
                
            mcore.Types.Matrix XMat = new mcore.Types.Matrix(ValuesCount, PolinomLevel * xParamCount);
            mcore.Types.Matrix YMat = new mcore.Types.Matrix(ValuesCount, 1);
            mcore.Types.Matrix K    = new Types.Matrix(); 

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
        public static Types.Collection AllanVariance ( double t0, mcore.Types.Collection input, ref bool isBreak, System.Windows.Forms.ProgressBar pb )
        {
            Types.Collection Result_Array = new Types.Collection(2);
            Types.Collection CurrData     = new Types.Collection();

            double invert_sqrt_2 = 1.0 / System.Math.Sqrt(2.0); 

            int    input_ValsCount = input[0].Count;
            int    CountAllanPoint  = input[0].Count / 10;
            int    SumCounter;
            double CurrentSum;

            if ( pb != null )
            {
                pb.Value = 0;
                pb.Maximum =  CountAllanPoint;
            }

            for ( int i = 0; i < CountAllanPoint; i++)
            { 
                CurrData.Clear();
                // ---------
                double OldSum = 0;
                for (int k = 0; k < input_ValsCount; k = k + (i+1))
                {
                        SumCounter = 0;
                        CurrentSum = 0;
                        for ( int z = k; z < k + (i+1); z++)
                            if ( z <= input_ValsCount - 1)
                            {
                                CurrentSum = CurrentSum + input[0][z];
                                SumCounter++;
                            }

                        CurrentSum = CurrentSum / (float)SumCounter;
                    // ---------- Разность соседних сумм -----
                        if ( k > 0 ) CurrData.Add( CurrentSum - OldSum);
                    // ----------
                        OldSum = CurrentSum;
                }
                
                double Mean = CurrData.Vectors[0].get_Mean();
                double SCO  = CurrData.Vectors[0].get_SCO (0, CurrData[0].Count, Mean) * invert_sqrt_2;

                Result_Array.Add(0, t0*(i+1));
                Result_Array.Add(1, SCO);

                if ( pb != null ) pb.Value = i;
                System.Windows.Forms.Application.DoEvents();


                if ( isBreak == true ) 
                    return Result_Array;
            }

            
            return Result_Array;
        }

        /// <summary>
        /// Расчет АЧХ/ФЧХ, по входному полиному (X/Y)
        /// </summary>
        /// <param name="begin_decad">Целое число - начальная декада</param>
        /// <param name="end_decad">Целое число - конечная декада</param>
        /// <param name="in_num_denum">Входной масив данных, вектор "0" - числитель полинома, вектор "1" - знаменатель полинома</param>
        /// <returns>Результат вычилений, вектор "0" - частота, вектор "1" - АЧХ, вектор "2" - ФЧХ</returns>
        public static mcore.Types.Collection Frequency_responce( double begin_freq, double end_freq, double t0, mcore.Types.Collection in_num_denum )
        {
            if ( in_num_denum == null ) return null;

            mcore.Types.Collection result = new Types.Collection(3);

            // preparing frequency list
            double b_decad = System.Math.Floor( System.Math.Log(begin_freq + 0.0001) / System.Math.Log(10) );
            double e_decad = System.Math.Floor( System.Math.Log(end_freq   + 0.0001) / System.Math.Log(10) );

            int    count_decad = Convert.ToInt32( e_decad - b_decad );
            int    screen_width = System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width;
            double count_points_inOneDecad = screen_width / count_decad;

            double freq_offset = 1e-6;

            // ------ Frequency List ------------
            for ( int n = 0; n < count_decad; n++)
                for ( int k = 0; k < count_points_inOneDecad+1; k++)
                    result.Add(0, System.Math.Pow(10, (k / count_points_inOneDecad) + n + b_decad));
                
            int vector_legth = result.Vectors[0].data.Count;
            int   num_length = in_num_denum.Vectors[0].data.Count;
            int denum_length = in_num_denum.Vectors[1].data.Count;

            for ( int i = 0; i < vector_legth; i++)
            {
                double freq = result[0][i] + freq_offset;

                double Re1 = 0.0; 
                double Im1 = 0.0; 
                double Re2 = 0.0; 
                double Im2 = 0.0; 
                //double aOmega = 2 / T0 * Math::ArcTan2(T0 * aLambda, 2);
                double aOmega = freq;

                for ( int k = 0; k < num_length; k++ )
                {
                    double value = in_num_denum[0][k];
                    Re1 += value * System.Math.Cos(k * aOmega * t0 * 2 * System.Math.PI);
                    Im1 -= value * System.Math.Sin(k * aOmega * t0 * 2 * System.Math.PI);
                }

                for ( int k = 0; k < denum_length; k++)
                {
                    double value = in_num_denum[1][k];
                    Re2 += value * System.Math.Cos(k * aOmega * t0 * 2 * System.Math.PI);
                    Im2 -= value * System.Math.Sin(k * aOmega * t0 * 2 * System.Math.PI);
                }

                double val1;
                double val2;
                try {
                    val1 = 20.0 * System.Math.Log10( System.Math.Sqrt(Re1*Re1 + Im1*Im1) / System.Math.Sqrt(Re2*Re2 + Im2*Im2));
                    val2 = System.Math.Atan2(Im1,Re1) - System.Math.Atan2(Im2,Re2);
                } catch {
                    val1 = 0.0;
                    val2 = 0.0;
                }

                result.Add(1, val1);
                result.Add(2, val2 * 180.0 / System.Math.PI);
            }

            return result;
        }

        public static void FFT (Types.Collection in_array, ref double power)
        {
            double  m,Count,e,l,f;
            double  z,c,s,p,q,r,t,w,v,u,k;
            int     o, i, jj,j1,i1;

            power = System.Math.Floor( System.Math.Log(in_array[0].Count) / System.Math.Log(2.0));
            Count = System.Math.Pow( 2.0, power);
            m     = power;
            //------------------- FFT -----------------------
            for ( l = 1; l <= m; l++){
		            e =  System.Math.Round( System.Math.Pow( 2.0, (m+1-l)));
		            f =  System.Math.Round( e / 2.0);
		            u =  1;
		            v =  0;
		            z =  System.Math.PI / (double)f;
		            c =  System.Math.Cos(z);
		            s = -System.Math.Sin(z);
		            for ( int j = 1; j <= f; j++)
		            {
			            i = j;
			            while (i <= Count)
			            {
					            o = (int)(i + f - 1);

					            p = in_array[0][i-1] + in_array[0][o];
                                q = in_array[1][i-1] + in_array[1][o];
                                r = in_array[0][i-1] - in_array[0][o];
                                t = in_array[1][i-1] - in_array[1][o];

                                in_array[0][o]   = r*u - t*v;
                                in_array[1][o]   = t*u + r*v;
                                in_array[0][i-1] = p;
                                in_array[1][i-1] = q;

                                i = (int)(i + e);
                        }
			            w = u*c-v*s;
                        v = v*c+u*s;
                        u = w;
                    }
            }

            // ----- -тюшўэр  яхЁхёЄрэютър ---------
            jj=1;
            for ( i = 1; i < Count; i ++)
            {
                if (i > jj) goto mot1;
                j1 = jj-1;
                i1 = i-1;
                p  = in_array[0][j1];
                q  = in_array[1][j1];
                in_array[0][j1] = in_array[0][i1];
                in_array[1][j1] = in_array[1][i1];
                in_array[0][i1] = p;
                in_array[1][i1] = q;
            mot1:
                k = Count/2.0;
            mot2:
                if (k >= jj) goto mot3;
                jj = jj - (int)System.Math.Round(k);
                k = k / 2.0;
                goto mot2;
            mot3:
                jj = jj + (int)System.Math.Round(k);
            }
        }
    }
}
