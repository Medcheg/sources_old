Unit matfun;
Interface
 Function sgn(x:extended):shortint;
 Function sign(x,y:extended):extended;
 Function lg(x:extended):extended;
 Function log2(x:extended):extended;
 Function arctg(y,x:extended):extended;
 Function sh(x:extended):extended;
 Function ch(x:extended):extended;
 Function arsh(x:extended):extended;
 Function arch(x:extended):extended;
 Function arth(x:extended):extended;
 Function arcth(x:extended):extended;
 Function arcsin(x:extended):extended;
 Function arccos(x:extended):extended;
 Function binc(n,m:word):longint;
 Function pwr(x,y:extended):extended;
 Function pwrr(x:extended;n,m:integer):extended;
Implementation
 Function sgn;
    begin
    if x>0 then sgn:=1
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
 Function arctg;
    var r:extended;
    begin if x=0 then if y>=0 then arctg:=pi/2
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
    begin  arcsin:=arctan(x/sqrt(1-sqr(x))) end;
 Function arccos;
    begin  arccos:=arctan(sqrt(1-sqr(x))/x) end;
 Function binc;
    var q,k:word;
          p:longint;
    begin p:=1; q:=0; k:=n-m;
          if k<m then k:=m;
          for k:=k+1 to n do begin inc(q); p:=p*k div q end;
          binc:=p
    end;
 Function pwr;
    begin if x>0 then if y=0 then pwr:=1
                             else pwr:=exp(y*ln(x))
                 else pwr:=0
    end;
 Function pwrr;
    begin if (x<>0) and (n=0) then pwrr:=1
                              else
          if (x>0) or (x<0) and not odd(n) then pwrr:=exp(n*ln(abs(x))/m)
                                           else
                                 if odd(m) then pwrr:=-exp(n*ln(abs(x))/m)
                                           else pwrr:=0
    end;
 end.