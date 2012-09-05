using System;
using System.Collections.Generic;
using System.Text;

namespace nkcore.Digital
{
    public class filter_hiPass
    {
        public filter_hiPass()
        {
            throw new Exception ("no yet");
//  /// ----- Высокочастотный фильтр ----------
//  SetLength(ZCoefChZn.CoefCh, 3);
//  SetLength(ZCoefChZn.CoefZn, 3);

//  // ----- Высокочастотный Цисаржа ----------
//  Alfa := sqr(tan(W0*t0/2*2*pi));

//  A := sqrt(Alfa / (Hmax*Hmax - 0.5));
//  B := HMax*HMax*A*A;

//  ZCoefChZn.CoefCh[0] := 1+A;
//  ZCoefChZn.CoefCh[1] := -2;
//  ZCoefChZn.CoefCh[2] := 1-A;

//  ZCoefChZn.CoefZn[0] := 1+A+B;
//  ZCoefChZn.CoefZn[1] := -2*(1-B);
//  ZCoefChZn.CoefZn[2] := 1-A+B;
//  // ----- Высокочастотный с книжки ---------
//{  Alfa := sqr(tan(W0*t0/2*2*pi));

//  B := sqrt((1 - 1/Hmax/Hmax)/Alfa);

//  A := sqrt(2*(B - alfa*B*B));

//  ZCoefChZn.CoefCh[0] := 1;
//  ZCoefChZn.CoefCh[1] := -2;
//  ZCoefChZn.CoefCh[2] := 1;

//  ZCoefChZn.CoefZn[0] := 1+A+B;
//  ZCoefChZn.CoefZn[1] := -2*(1-B);
//  ZCoefChZn.CoefZn[2] := 1-A+B;

//  ZCoefChZn.CoefZn[2] := 1-A+B;}

        }
    }
}
