//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "mpiMatFun.h"

//---------------------------------------------------------------------------

#pragma package(smart_init)

// Function pwr; // ---- Аналог "С" - Power(a, b);

TFloat pwrr(TFloat x, int n, int m)
{
   if (x != 0 && n == 0) return 1;
      else if (x > 0 || x < 0 && !odd(n)) return exp(n*log(fabs(x)) / (TFloat) m);
              else if (odd(m)) return -exp(n * log(fabs(x)) / (TFloat)m);
                                           else return 0;
}

int binc(int n, int m)
{
    int p = 1;
    int q = 0;
    int k1 = n-m;
    if (k1 < m) k1 = m;

    for (int k = k1+1; k < n + 1; k++){
       q ++;
       p = p * (TFloat)k / (TFloat)q;
    }
    return p;
}


/*
Unit matfun;
Interface
 Function sgn(x:real):shortint;
 Function sign(x,y:real):real;
 Function lg(x:real):real;
 Function log2(x:real):real;
 Function tg(x:real):real;
 Function arctg(y,x:real):real;
 Function sh(x:real):real;
 Function ch(x:real):real;
 Function arsh(x:real):real;
 Function arch(x:real):real;
 Function arth(x:real):real;
 Function arcth(x:real):real;
 Function arcsin(x:real):real;
 Function arccos(x:real):real;
Implementation
 Function sgn;
    begin if x>0 then sgn = 1
                 else if x<0 then sgn = -1
                             else sgn = 0
    end;
 Function sign;
    begin if y<0 then sign = -abs(x) else sign = abs(x) end;
 Function lg;
    const c=2.30258509299404568402;
    begin lg = ln(x)/c end;
 Function log2;
    const c=1.44269504088896340736;
    begin log2 = ln(x)*c end;
 Function tg;
    begin tg = sin(x)/cos(x)  end;
 Function arctg;
    var r:real;
    begin if abs(x)<1e-8 then if y>=0 then arctg = pi/2.0
                              else arctg = -pi/2.0
                 else begin r = arctan(y/x);
                            if x>0 then arctg = r
                                   else if y>=0 then arctg = r+pi
                                                else arctg = r-pi
                      end
    end;
 Function sh;
    begin  sh = 0.5*(exp(x)-exp(-x)) end;
 Function ch;
    begin  ch = 0.5*(exp(x)+exp(-x)) end;
 Function arsh;
    begin  arsh = ln(x+sqrt(sqr(x)+1)) end;
 Function arch;
    begin  arch = ln(x+sqrt(sqr(x)-1)) end;
 Function arth;
    begin  arth = 0.5*ln((1+x)/(1-x)) end;
 Function arcth;
    begin  arcth = 0.5*ln((x+1)/(x-1)) end;
 Function arcsin;
    begin  if x=1 then arcsin = pi/2.0 else
           if x=-1 then arcsin = -pi/2.0 else
                 arcsin = arctan(x/sqrt(1-sqr(x))) end;
 Function arccos;
    begin   if abs(x)<1e-8 then arccos = pi/2.0 else
              arccos = arctan(sqrt(1-sqr(x))/x) end;
 end.*/
