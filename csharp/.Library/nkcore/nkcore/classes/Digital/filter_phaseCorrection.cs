using System;
using System.Collections.Generic;
using System.Text;

namespace nkcore.classes.digital
{
    class filter_phaseCorrection
    {
      ///// ----- Фазовый Коректор ----------
      //SetLength(ZCoefChZn.CoefCh, 3);
      //SetLength(ZCoefChZn.CoefZn, 3);

      //B     := cos(W0*t0/2*2*pi);
      //betta := tan(W0*t0/2*2*pi);
      //A     := (1-Betta)/(1+Betta);

      ////A := tan(DeltaW*T0/2);
      ////B := 2*cos(W0*t0);

      //ZCoefChZn.CoefCh[0] := A;
      //ZCoefChZn.CoefCh[1] := -B*(1+A);
      //ZCoefChZn.CoefCh[2] := 1;

      //ZCoefChZn.CoefZn[0] := 1;
      //ZCoefChZn.CoefZn[1] := -B*(1+A);
      //ZCoefChZn.CoefZn[2] := A;

      //ZCoefChZn.CoefZn[2] := A;
    }
}
