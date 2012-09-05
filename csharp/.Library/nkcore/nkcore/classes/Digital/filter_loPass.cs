using System;
using System.Collections.Generic;
using System.Text;

namespace nkcore.Digital
{
    public class filter_loPass
    {
        public nkcore.Types.Collection coefs;

        /// <summary>
        /// Низкочастотный фильтр
        /// </summary>
        /// <param name="t0">Время дискретизации</param>
        /// <param name="freq">Частота среза</param>
        /// <param name="hMax">Максимальная высока подъема</param>
        public filter_loPass(double t0, double freq, double hMax)
        {
            coefs = new Types.Collection(2);

            double Alfa = System.Math.Pow(System.Math.Tan(freq* t0 / 2.0 * 2.0 * System.Math.PI), 2.0);

            double A = System.Math.Sqrt(Alfa / (hMax*hMax - 0.5));
            double B = hMax*hMax*A*A;

            coefs.Add(0, B  );
            coefs.Add(0, 2*B);
            coefs.Add(0, B  );

            coefs.Add(1, 1+A+B   );
            coefs.Add(1, -2*(1-B));
            coefs.Add(1, 1-A+B   );
        }

        public double Run(double value)
        {
            throw new Exception("not ready");
        }
    }
}
