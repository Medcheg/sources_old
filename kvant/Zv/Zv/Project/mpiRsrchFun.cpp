//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiRsrchFun.h"
#include "mpiMatFun.h"
//===========================================================================

#pragma package(smart_init)
//===========================================================================
//===========================================================================
//===========================================================================
TFloat ZeroIn(TFloat ax, TFloat bx, TFunType F, TFloat tol)
{
    TFloat c, fc, d, e, tol1, xm, s, p, q, r;

    TFloat eps = 1;
    TFloat a = ax;
    TFloat b = bx;
    TFloat fa = F(a);
    TFloat fb = F(b);

    while (1 + eps != 1) eps = eps / 2.0;
    while (true) {
          c  = a;
          fc = fa;
          d = b-a;
          e = d;
          _30_:  if (fabs(fc) < fabs(fb)){
                      a = b;
                      b = c;
                      c = a;
                      fa = fb;
                      fb = fc;
                      fc = fa;
                 }

               // --------
                 tol1 = 2*eps*abs(b)+tol / 2.0;
                 xm   = (c-b) / 2.0;

               // --------
                 if (fabs(xm) <= tol1 || fabs(fb) < 1e-8) return b;
                 if (fabs(e) < tol1 || fabs(fa) <= fabs(fb)){
                    goto _70_;
                 } else {
                    if (a == c) {
                          s = fb/fa;
                          p = 2*xm*s;
                          q = 1-s;
                    } else {
                          q = fa / fc;
                          r = fb / fc;
                          s = fb / fa;
                          p = s*(2*xm*q*(q-r) - (b-a)*(r-1));
                          q = (q-1)*(r-1)*(s-1);
                    }
                    if (p > 0) q = -q;
                    p = fabs(p);
                 }

               if (2*p < 3*xm*q - fabs(tol1)*q && p < fabs(e*q/2.0)) {
                  e = d;
                  d = p / q;
               } else {
                  _70_: d = xm;
                        e = d;
               }
               a  = b;
               fa = fb;
               if (fabs(d) > tol1) b = b + d;
                  else if (xm < 0) b = b - fabs(tol1);
                          else b = b + fabs(tol1);
               fb = F(b);
               if (fb*( fc / fabs(fc) ) <= 0) goto _30_;
    }
}
//===========================================================================
//===========================================================================
//===========================================================================
TFloat ZeroFB(TFloat rax, TFloat rdx, TFunType F, TFloat tol)
{
    TFloat rbx;
    int    sa, sb;
  // ---
    rbx = rax;
    sb = _Sgn_(F(rbx));
  // ---
    do {
       rax = rbx;
       sa  = sb;
       if (fabs(sa) < 1e-8) return rax;
       rbx = rdx + rax;
       sb  = _Sgn_(F(rbx));
    } while (sa * sb >= 0);
    
    return  ZeroIn(rax, rbx, F, tol);
}
//===========================================================================
//===========================================================================
//===========================================================================
/*
 UNIT RsrchFun;
 Interface
  Uses MatFun;
  type FunType = Function(x:real):real;


  function findzero(a,step:real;F:funtype;del:real):real;
{  Function MinFun(ax,bx:real; F:FunType; tol:real):real;}


 Implementation
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function findzero(a,step:real;F:funtype;del:real):real;
    var b,c:real;
        aa,bb,cc:byte;
    label ll;
begin
    b = a; a = a-step;
    repeat
       b = b+step;
       a = a+step;
       bb = sgn(F(b))
    until not(sgn(F(a))=bb);
    if abs(bb)<1e-8 then begin findzero = b; goto ll end;
    repeat
       c = a/2.0+b/2.0;
       cc = sgn(F(c));
       if sgn(F(a))=cc
            then a = c
            else if abs(cc)<1e-8
                 then begin findzero = c; goto ll   end
                 else b = c;
    until abs(a-b)<del;
    findzero = c;
ll:
end;
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
{  Function MinFun;
var a,b,c,d,e,Eps,xm,p,q,r,Tol1,Tol2,
u,v,w,x,Fu,Fv,Fw,Fx:real;
label 20,40,50;
Begin c = (3-sqrt(5))/2.0;
          Eps = 1; while 1+Eps/2.0 <> 1 do Eps = Eps/2.0;
          Eps = sqrt(Eps);
          a = ax; b = bx; e = 0;
          v = a+c*(b-a); w = v; x = v;
          Fx = F(x); Fv = Fx; Fw = Fx;
      20: xm = (a+b)/2.0; Tol1 = Eps*abs(x)+Tol/3.0; Tol2 = Tol1*2;
          if abs(x-xm)<=Tol2-(b-a)/2.0 then begin MinFun = x; exit end;
          if abs(e)<=Tol1 then goto 40;
          r = (x-w)*(Fx-Fv);     q = (x-v)*(Fx-Fw);
          p = (x-v)*q - (x-w)*r; q = 2*(q-r);
          if q>0 then p = -p else q = -q;
          r = e; e = d;
          if (abs(p)>=abs(q*r/2.0)) or (p<=q*(a-x)) or (p>=q*(b-x))
             then goto 40;
          d = p/q; u = x+d;
          if (u-a<Tol2) or (b-u<Tol2) then d = sign(Tol1,xm-x);
          goto 50;
      40: if x>=xm then e = a-x else e = b-x;
          d = c*e;
      50: if abs(d)>=Tol1 then u = x+d else u = x + sign(Tol1,d);
          Fu = F(u);
          if Fu<=Fx then begin if u>=x then a = x else b = x;
                               v = w;   w = x;   x = u;
                               Fv = Fw; Fw = Fx; Fx = Fu;
                               goto 20
                          end;
          if u<x then a = u else b = u;
          if (Fu<=Fw) or (w=x) then begin v = w; Fv = Fw; w = u; Fw = Fu end
                               else if (Fu<=Fv) or (v=x) or (v=w)
                                      then begin v = u; Fv = Fu end;
          goto 20
    End;}
 END.*/
