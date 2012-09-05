Unit matfun;
interface
 function sgn(x:real):shortint;
 function sign(x,y:real):real;
 function lg(x:real):real;
 function log2(x:real):real;
 function tg(x:real):real;
 function arctg(y,x:real):real;
 function sh(x:real):real;
 function ch(x:real):real;
 function arsh(x:real):real;
 function arch(x:real):real;
 function arth(x:real):real;
 function arcth(x:real):real;
 function arcsin(x:real):real;
 function arccos(x:real):real;
 function binc(n,m:word):longint;
 function pwr(x,y:real):real;
 function pwrr(x:real;n,m:integer):real;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
implementation
// ==========================================================================
function sgn;
begin
   if x>0 then sgn:=1
          else if x<0 then sgn:=-1
                      else sgn:=0
end;

// ==========================================================================
function sign;
begin
   if y<0 then sign:=-abs(x)
          else sign:=abs(x)
end;

// ==========================================================================
function lg;
const c=2.30258509299404568402;
begin
  lg:=ln(x)/c
end;

// ==========================================================================
function log2;
const c=1.44269504088896340736;
begin
   log2:=ln(x)*c
end;

// ==========================================================================
function tg;
begin
  tg:=sin(x)/cos(x)
end;

// ==========================================================================
function arctg;
var r:real;
begin
   if abs(x)<1e-8 then begin
       if y>=0 then arctg:=pi/2
               else arctg:=-pi/2
   end else begin
               r:=arctan(y/x);
               if x>0 then arctg:=r
                      else if y>=0 then arctg:=r+pi
                                   else arctg:=r-pi
            end
end;

// ==========================================================================
function sh;
begin
  sh:=0.5*(exp(x)-exp(-x))
end;

// ==========================================================================
function ch;
begin
  ch:=0.5*(exp(x)+exp(-x))
end;

// ==========================================================================
function arsh;
begin
   arsh:=ln(x+sqrt(sqr(x)+1))
end;

// ==========================================================================
function arch;
begin
  arch:=ln(x+sqrt(sqr(x)-1))
end;

// ==========================================================================
function arth;
begin
  arth:=0.5*ln((1+x)/(1-x))
end;

// ==========================================================================
function arcth;
begin
  arcth:=0.5*ln((x+1)/(x-1))
end;

// ==========================================================================
function arcsin;
begin
  if x=1 then begin
     arcsin:=pi/2
  end else  if x=-1 then arcsin:=-pi/2
                    else arcsin:=arctan(x/sqrt(1-sqr(x)))
end;
// ==========================================================================
function arccos;
begin
   if abs(x)<1e-8 then arccos:=pi/2
                  else arccos:=arctan(sqrt(1-sqr(x))/x)
end;

// ==========================================================================
function binc;
var q,k:word;
    p:longint;
begin
   p := 1;
   q := 0;
   k := n-m;
   if k < m then k:=m;
   for k:=k+1 to n do begin
       inc(q);
       p:=p*k div q
   end;
   binc:=p
end;

// ==========================================================================
function pwr;
var
   vv : string;
begin
   if x>0 then begin
      if abs(y)<1e-8 then pwr:=1
                     else pwr:=exp(y*ln(x));
   end else pwr:=0
end;

// ==========================================================================
function pwrr(x:real;n,m:integer):real;
begin
   if (x<>0) and (n=0)
       then pwrr:=1
       else if (x>0) or (x<0) and not odd(n)
               then pwrr:=exp(n*ln(abs(x))/m)
               else if odd(m)
                       then pwrr:=-exp(n*ln(abs(x))/m)
                       else pwrr:=0
end;

end.
