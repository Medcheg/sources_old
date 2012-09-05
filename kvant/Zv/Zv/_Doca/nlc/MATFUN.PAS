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
 Function binc(n,m:word):longint;
 Function pwr(x,y:real):real;
 Function pwrr(x:real;n,m:integer):real;
Implementation
 Function sgn;
    begin if x>0 then sgn:=1
                 else if x<0 then sgn:=-1
                             else sgn:=0
    end;
 Function sign;
    begin if y<0 then sign:=-abs(x) else sign:=abs(x) end;
 Function lg;
    const c=2.30258509299404568402;
    begin lg:=ln(x)/c end;
 Function log2;
    const c=1.44269504088896340736;
    begin log2:=ln(x)*c end;
 Function tg;
    begin tg:=sin(x)/cos(x)  end;
 Function arctg;
    var r:real;
    begin if abs(x)<1e-8 then if y>=0 then arctg:=pi/2
                              else arctg:=-pi/2
                 else begin r:=arctan(y/x);
                            if x>0 then arctg:=r
                                   else if y>=0 then arctg:=r+pi
                                                else arctg:=r-pi
                      end
    end;
 Function sh;
    begin  sh:=0.5*(exp(x)-exp(-x)) end;
 Function ch;
    begin  ch:=0.5*(exp(x)+exp(-x)) end;
 Function arsh;
    begin  arsh:=ln(x+sqrt(sqr(x)+1)) end;
 Function arch;
    begin  arch:=ln(x+sqrt(sqr(x)-1)) end;
 Function arth;
    begin  arth:=0.5*ln((1+x)/(1-x)) end;
 Function arcth;
    begin  arcth:=0.5*ln((x+1)/(x-1)) end;
 Function arcsin;
    begin  if x=1 then arcsin:=pi/2 else
           if x=-1 then arcsin:=-pi/2 else
                 arcsin:=arctan(x/sqrt(1-sqr(x))) end;
 Function arccos;
    begin   if abs(x)<1e-8 then arccos:=pi/2 else
              arccos:=arctan(sqrt(1-sqr(x))/x) end;
 Function binc;
    var q,k:word;
          p:longint;
    begin p:=1; q:=0; k:=n-m;
          if k<m then k:=m;
          for k:=k+1 to n do begin inc(q); p:=p*k div q end;
          binc:=p
    end;
 Function pwr;
   var vv:string;
    begin if x>0 then if abs(y)<1e-8 then pwr:=1
                             else
    begin
                             pwr:=exp(y*ln(x));end
                 else pwr:=0
    end;
 Function pwrr(x:real;n,m:integer):real;
    begin if (x<>0) and (n=0) then pwrr:=1
                              else
          if (x>0) or (x<0) and not odd(n) then pwrr:=exp(n*ln(abs(x))/m)
                                           else
                                 if odd(m) then pwrr:=-exp(n*ln(abs(x))/m)
                                           else pwrr:=0
    end;
 end.
