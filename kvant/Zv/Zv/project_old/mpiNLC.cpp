//===========================================================================
//=======     Unit �������� =================================================
//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiNLC.h"
#include "mpiRsrchFun.h"
#include "mpiDeclaration.h"
#include "mpiSpecFun.h"
#include "mpiMatFun.h"

//===========================================================================

#pragma package(smart_init)
//=========    Loacal Variable        =======================================
TFloat   rdp,  wdp;
TFloat   Pmem, Fmem;

/*
{
  arr_a=array [1..68] of real;  }
  mfl,nak:byte;
{      q0:arr_a;}

  Pmem,Fmem:real;
 var rdp,wdp:real;
*/
//===========================================================================
//===========================================================================
//===========================================================================
TFloat Pwd(TFloat por, TFloat s)//      {nak}
{
   TFloat x = por / sqr(s) / 2.0;
   TFloat z = exp(-x);
   TFloat r = z;

// !!!!!
   for (int k = 1; k < nak + 1; k++){
      r = r*x / (TFloat)k;
      z = z + r;
   }
   return z;
}
//===========================================================================
//===========================================================================
//===========================================================================
TFloat fun(TFloat x)
{
  return Pwd(2*x, 1) - wdp;
}
//===========================================================================
//===========================================================================
//===========================================================================
TFloat Thld(TFloat F, TFloat s)//        {nak}
{
    wdp = F;
    return 2 * sqr(s) * ZeroFB(0,2,fun,1e-10);
}
//===========================================================================
//===========================================================================
//===========================================================================
TFloat Prdf(TFloat QdB, TFloat F)   //    {nak, mfl}
{
// var q,p,a,a1,r,r1,z,z1:real; n1,:byte; k:word;
    TFloat p, q, a, r1, r, z, a1, z1 = -90909023;
    int    n1, k, aaaaaaaaaa;

   // if Fmem<>F then begin
     Fmem = F;
     Pmem = Thld(F,1) / 2.0;
   // {end};{@@@@@}

       p  = Pmem;
       q  = Power(10,QdB / 10.0);
       n1 = nak - 1;

       switch (ZvData.TypeSignalFluctuation) {
           case 1: a  = nak*q;
                   r1 = exp(-p);
                   if (a < 100) {
                         r  = exp(-a);
                         z  = r * F;
                         a1 = F * 1e-10;
                         for (k = 1; k < n1 + 1; k++) r1 = r1 * p / (TFloat)k;
                         for (k = 1; (long double)z != (long double)z1; k++) {
                            if (r1 > a1){
                               r1 = r1*p / (TFloat)(n1+k);
                               F  += r1;
                            }
                            r = r * a / (TFloat)k;
                            z1 = z;
                            z = z+r*F;
                         }
                   } else {
                         r = sqrt(a);
                         r = sqrt(p)-r-(nak-0.5)/r;
                         z = erfc(r) / 2.0;
                   }
                   break;
// -------- 2 - 3 - ������ ���� ���������
           case 2: a = nak * q;
                     r1 = exp(-p);
                     if (ZvData.TypeSignalFluctuation == 3) a = a / 2.0;
                     a = a / (1 + a);
                     z = F;
                     for (int k = 1; k < n1 + 1; k++)
                              r1 = r1 * p / (TFloat) k;
                     for (int k = 1; (long double)z != (long double)z1; k++) {
                         r1 = r1*p / (TFloat)(n1+k);
                         r  = Power(a, (TFloat)k);
                         if (ZvData.TypeSignalFluctuation == 3){
                             aaaaaaaaaa = (k+1) / 2;
                             r = Power(a, 2 * aaaaaaaaaa) + 2*(1-a)*r*aaaaaaaaaa;
                         }
                         z1 = z;
                         z  = z + r*r1;
                     }
                   break;
           case 3: a = nak * q;
                     r1 = exp(-p);
                     if (ZvData.TypeSignalFluctuation == 3) a = a / 2.0;
                     a = a / (1 + a);
                     z = F;
                     for (int k = 1; k < n1 + 1; k++)
                              r1 = r1 * p / (TFloat) k;
                     for (int k = 1; (long double)z != (long double)z1; k++) {
                         r1 = r1*p / (TFloat)(n1+k);
                         r  = Power(a, (TFloat)k);
                         if (ZvData.TypeSignalFluctuation == 3){
                             aaaaaaaaaa = (k+1) / 2;
                             r = Power(a, 2 * aaaaaaaaaa) + 2*(1-a)*r*aaaaaaaaaa;
                         }
                         z1 = z;
                         z  = z + r*r1;
                     }
                   break;
           case 4: a = 1 + q;
                   p = p / a;
                   r = exp(-p);
                   z = r;
                   for (int k = 1; k < n1 + 1; k++) {
                     r = r * p / (TFloat)k;
                     z = z + r;
                   }
                   break;
           case 5: a1 = q / 2.0;
                   a  = a1 + 1.0;
                   p  = p / a;
                   r1 = exp(-p);
                   z1 = r1;
                   for (int k = 1; k < n1 + 1; k++){
                       r1 = r1*p / (TFloat)k;
                       z1 = z1+r1;
                   }

                      r = pwrr(a,-nak,1); z = z1*r;
                      for (int k = 1; k < nak + 1; k ++){
                           r1 = r1*p / (TFloat)(n1+k);
                           z1 = z1 + r1;
                           r  = r * a1;
                           z  = z + r * z1 * binc(nak, (TFloat)k);
                      }
                   break;
       }
     return z;
}
//===========================================================================
//===========================================================================
//===========================================================================
TFloat ffd(TFloat q)
{
 return Prdf(q , wdp) - rdp;
}
//===========================================================================
//===========================================================================
//===========================================================================
TFloat Qqr(TFloat QdB, TFloat r, TFloat rh)  //       {nak, mfl}
{
  return QdB + 40 * log(rh / r) / log (10);
}

//===========================================================================
//===========================================================================
//===========================================================================
TFloat Qfd(TFloat F, TFloat D)//        {nak, mfl}
{
 wdp = F;
 rdp = D;
 return ZeroFB(-20, 5, ffd, 1e-10);
}


/*
unit unit_NLC;

interface
USES matfun,specfun,RSRCHFUN;
  type FunType = Function(x:real):real;



BEGIN
END.*/