using System;
using System.Collections.Generic;
using System.Text;

namespace nkcore.classes.digital
{
    class filter_cutOff
    {

        ///// ----- Режекторный фильтр ----------
        //SetLength(ZCoefChZn.CoefCh, 3);
        //SetLength(ZCoefChZn.CoefZn, 3);

        //A := tan(DeltaW*2*pi*T0/2);
        //B := 2*cos(W0*t0*2*pi);

        ////A := tan(DeltaW*T0/2);
        ////B := 2*cos(W0*t0);

        //ZCoefChZn.CoefCh[0] := 1;
        //ZCoefChZn.CoefCh[1] := -B;
        //ZCoefChZn.CoefCh[2] := 1;

        //ZCoefChZn.CoefZn[0] := 1+A;
        //ZCoefChZn.CoefZn[1] := -B;
        //ZCoefChZn.CoefZn[2] := 1-A;
    }
}
