using System;
using System.Collections.Generic;
using System.Text;

namespace mcore
{
    public class Digital
    {
        public double t0;
        public Types.Collection coefs;

        private double[] x;
        private double[] y;

        public Digital()
        {
            t0 = 0.0;
            x = null;
            y = null;
            coefs = new Types.Collection(2);
        }
        public void Init()
        {
            x = new double[coefs[0].Count];
            y = new double[coefs[1].Count];
        }
        public double Run(double inValue)
        {
            throw new Exception("Not ready yet");
        }

        public class filter_loPass : Digital
        {
            public filter_loPass(double t0, double freq, double hMax)
            {
                double Alfa = System.Math.Pow(System.Math.Tan(freq* t0 / 2.0 * 2.0 * System.Math.PI), 2.0);

                double A = System.Math.Sqrt(Alfa / (hMax*hMax - 0.5));
                double B = hMax*hMax*A*A;

                coefs[0].Clear();
                coefs[1].Clear();

                double b0 = 1+A+B;
                coefs.Add(0, 1/b0 * (B  ));
                coefs.Add(0, 1/b0 * (2*B));
                coefs.Add(0, 1/b0 * (B  ));

                coefs.Add(1, 1/b0 * (1+A+B   ));
                coefs.Add(1, 1/b0 * (-2*(1-B)));
                coefs.Add(1, 1/b0 * (1-A+B   ));
            }
        }
        public class filter_hiPass : Digital
        {
            public filter_hiPass(double t0, double freq, double hMax)
            {
                // ----- Высокочастотный Цисаржа ----------
                double Alfa = System.Math.Pow(System.Math.Tan(freq * t0 / 2.0 * 2.0 * System.Math.PI), 2);

                double A = System.Math.Sqrt(Alfa / (hMax*hMax - 0.5));
                double B = hMax*hMax*A*A;

                coefs[0].Clear();
                coefs[1].Clear();

                double b0 = 1.0 + A + B;
                coefs.Add(0, 1.0 / b0 * (1.0+A));
                coefs.Add(0, 1.0 / b0 * (-2.0 ));
                coefs.Add(0, 1.0 / b0 * (1.0-A));

                coefs.Add(1, 1.0 / b0 * (1.0 + A + B ));
                coefs.Add(1, 1.0 / b0 * (-2.0*(1.0-B)));
                coefs.Add(1, 1.0 / b0 * (1.0 - A + B ));

                //  // ----- Высокочастотный с книжки ---------
                //{  Alfa = sqr(tan(W0*t0/2*2*pi));

                //  B = sqrt((1 - 1/hMax/hMax)/Alfa);

                //  A = sqrt(2*(B - alfa*B*B));

                //  ZCoefChZn.CoefCh[0] = 1;
                //  ZCoefChZn.CoefCh[1] = -2;
                //  ZCoefChZn.CoefCh[2] = 1;

                //  ZCoefChZn.CoefZn[0] = 1+A+B;
                //  ZCoefChZn.CoefZn[1] = -2*(1-B);
                //  ZCoefChZn.CoefZn[2] = 1-A+B;

                //  ZCoefChZn.CoefZn[2] = 1-A+B;}

            }
        }
        public class filter_bandStop : Digital
        {
            public filter_bandStop(double t0, double freq, double delta_freq)
            {
                // Режекторный фильтр
                double A = System.Math.Tan( 2.0 * System.Math.PI * delta_freq * t0 / 2.0);
                double B = 2.0 * System.Math.Cos( 2.0 * System.Math.PI * freq * t0);

                coefs[0].Clear();
                coefs[1].Clear();

                double b0 = 1.0 + A;
                coefs.Add(0, 1.0 / b0 * (1.0));
                coefs.Add(0, 1.0 / b0 * (-B ));
                coefs.Add(0, 1.0 / b0 * (1.0));

                coefs.Add(1, 1.0 / b0 * (1.0 + A));
                coefs.Add(1, 1.0 / b0 * (-B     ));
                coefs.Add(1, 1.0 / b0 * (1.0 - A));
            }
        }
        public class filter_bandPass : Digital
        {
            public filter_bandPass(double t0, double freq, double delta_freq)
            {
              // Полосовой фильтр 
                double A = System.Math.Tan( 2.0 * System.Math.PI * delta_freq * t0 / 2.0);
                double B = 2.0 * System.Math.Cos( 2.0 * System.Math.PI * freq * t0);

                coefs[0].Clear();
                coefs[1].Clear();

                double b0 = 1.0 + A;
                coefs.Add(0, 1.0 / b0 * ( A));
                coefs.Add(0, 1.0 / b0 * ( 0 ));
                coefs.Add(0, 1.0 / b0 * (-A));

                coefs.Add(1, 1.0 / b0 * (1.0 + A));
                coefs.Add(1, 1.0 / b0 * (-B     ));
                coefs.Add(1, 1.0 / b0 * (1.0 - A));
            }
        }
        public class phase_Corrector : Digital
        {
            public phase_Corrector( double t0, double freq )
            {
              /// ----- Фазовый Коректор ----------
                double B     = System.Math.Cos( 2.0 * System.Math.PI * freq * t0 / 2.0);
                double betta = System.Math.Tan( 2.0 * System.Math.PI * freq * t0 / 2.0);
                double A     = (1.0 - betta) / (1.0 + betta);

                coefs[0].Clear();
                coefs[1].Clear();

                double b0 = 1.0;
                coefs.Add(0, 1.0 / b0 * ( A));
                coefs.Add(0, 1.0 / b0 * (-B*(1.0 + A) ));
                coefs.Add(0, 1.0 / b0 * ( 1.0));

                coefs.Add(1, 1.0 / b0 * ( 1.0));
                coefs.Add(1, 1.0 / b0 * (-B*(1.0 + A)));
                coefs.Add(1, 1.0 / b0 * ( A));

                  //A = tan(DeltaW*T0/2);
                  //B = 2*cos(W0*t0);
            }
        }


    }
}
