 UNIT RsrchFun;
 Interface
  Uses MatFun;
  type FunType = Function(x:real):real;
  Function ZeroIn(ax,bx:real; F:FunType; tol:real):real;
  Function ZeroFb(rax,rdx:real; F:FunType; tol:real):real;
  function findzero(a,step:real;F:funtype;del:real):real;
{  Function MinFun(ax,bx:real; F:FunType; tol:real):real;}
 Implementation

function findzero(a,step:real;F:funtype;del:real):real;
var b,c:real;
        aa,bb,cc:byte;
label ll;
begin
    b:=a; a:=a-step;
    repeat
       b:=b+step;
       a:=a+step;
       bb:=sgn(F(b))
    until not(sgn(F(a))=bb);
    if abs(bb)<1e-8 then begin findzero:=b; goto ll end;
    repeat
       c:=a/2+b/2;
       cc:=sgn(F(c));
       if sgn(F(a))=cc
            then a:=c
            else if abs(cc)<1e-8
                 then begin findzero:=c; goto ll   end
                 else b:=c;
    until abs(a-b)<del;
    findzero:=c;
ll:end;


  Function ZeroIn;
    var a,b,c,d,e,eps,fa,fb,fc,tol1,xm,p,q,r,s:real;
    label 30,70;
    Begin  eps:=1; while 1+eps<>1 do eps:=eps/2;
           a:=ax; b:=bx; fa:=F(a); fb:=F(b);
      repeat c:=a; fc:=fa; d:=b-a; e:=d;
        30:  if abs(fc)<abs(fb) then begin a:=b; b:=c; c:=a;
             fa:=fb; fb:=fc; fc:=fa end;
             tol1:=2*eps*abs(b)+tol/2; xm:=(c-b)/2;
             if (abs(xm)<=tol1) or (ABS(fb)<1e-8) then begin ZeroIn:=b; exit end;
             if (abs(e)<tol1) or (abs(fa)<=abs(fb)) then goto 70
                                                    else
                begin if a=c then begin s:=fb/fa; p:=2*xm*s; q:=1-s end
                             else begin q:=fa/fc; r:=fb/fc; s:=fb/fa;
                                        p:=s*(2*xm*q*(q-r) - (b-a)*(r-1));
                                        q:=(q-1)*(r-1)*(s-1)
                                  end;
                      if p>0 then q:=-q;
                      p:=abs(p)
                end;
             if (2*p<3*xm*q-abs(tol1)*q) and (p<abs(e*q/2))
                then begin e:=d; d:=p/q end
                else  begin
        70:                   d:=xm; e:=d end;
             a:=b; fa:=fb;
             if abs(d)>tol1 then b:=b+d
                            else if xm<0 then b:=b-abs(tol1)
                                         else b:=b+abs(tol1);
             fb:=F(b);
             if fb*(fc/abs(fc))<=0 then goto 30
      until false
    End;
  Function ZeroFb;
    var rbx:real; sa,sb:shortint;
    Begin  rbx:=rax;
           sb:=sgn(F(rbx));
           repeat
             rax:=rbx; sa:=sb;
             if abs(sa)<1e-8 then
             begin
               ZeroFb:=rax; exit
             end;
             rbx:=rdx+rax;
             sb:=sgn(F(rbx))
           until  (sa*sb)<0;
           ZeroFb:=ZeroIn(rax,rbx,F,tol)
    End;
{  Function MinFun;
    var a,b,c,d,e,Eps,xm,p,q,r,Tol1,Tol2,
        u,v,w,x,Fu,Fv,Fw,Fx:real;
    label 20,40,50;
    Begin c:=(3-sqrt(5))/2;
          Eps:=1; while 1+Eps/2 <> 1 do Eps:=Eps/2;
          Eps:=sqrt(Eps);
          a:=ax; b:=bx; e:=0;
          v:=a+c*(b-a); w:=v; x:=v;
          Fx:=F(x); Fv:=Fx; Fw:=Fx;
      20: xm:=(a+b)/2; Tol1:=Eps*abs(x)+Tol/3; Tol2:=Tol1*2;
          if abs(x-xm)<=Tol2-(b-a)/2 then begin MinFun:=x; exit end;
          if abs(e)<=Tol1 then goto 40;
          r:=(x-w)*(Fx-Fv);     q:=(x-v)*(Fx-Fw);
          p:=(x-v)*q - (x-w)*r; q:=2*(q-r);
          if q>0 then p:=-p else q:=-q;
          r:=e; e:=d;
          if (abs(p)>=abs(q*r/2)) or (p<=q*(a-x)) or (p>=q*(b-x))
             then goto 40;
          d:=p/q; u:=x+d;
          if (u-a<Tol2) or (b-u<Tol2) then d:=sign(Tol1,xm-x);
          goto 50;
      40: if x>=xm then e:=a-x else e:=b-x;
          d:=c*e;
      50: if abs(d)>=Tol1 then u:=x+d else u:=x + sign(Tol1,d);
          Fu:=F(u);
          if Fu<=Fx then begin if u>=x then a:=x else b:=x;
                               v:=w;   w:=x;   x:=u;
                               Fv:=Fw; Fw:=Fx; Fx:=Fu;
                               goto 20
                          end;
          if u<x then a:=u else b:=u;
          if (Fu<=Fw) or (w=x) then begin v:=w; Fv:=Fw; w:=u; Fw:=Fu end
                               else if (Fu<=Fv) or (v=x) or (v=w)
                                      then begin v:=u; Fv:=Fu end;
          goto 20
    End;}
 END.