unit unit_NLC;
interface

uses matfun,specfun,RSRCHFUN;
type
   FunType = function(x:real):real; // --- arr_a=array [1..68] of real; ---
var
   mfl,nak:byte;  // --- q0 : arr_a;

   Pmem,Fmem:real;

   function     Thld(F,s:real):real;        {nak}
   function     Pwd(por,s:real):real;      {nak}
   function     fun(x:real):real;
   function     Qqr(QdB,r,rh:real):real;        {nak, mfl}
   function     Qfd(F,D:real):real;        {nak, mfl}
   function     ffd(q:real):real;
   function     Prdf(QdB,F:real):real;      {nak, mfl}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
implementation

var
  rdp,wdp:real;

//===================================================================
function Qfd;
begin
   wdp:=f;
   rdp:=d;
   Qfd:=ZeroFB(-20,5,ffd,1e-10)
end;
//===================================================================
function ffd;
begin
   ffd:=prdf(q,wdp)-rdp
end;
//===================================================================
function Qqr(QdB,r,rh:real):real;
begin
      Qqr:=QdB + 40*ln(rh/r)/ln(10);
end;
//===================================================================
function fun(x:real):real;
begin
   fun:=Pwd(2*x, 1)-wdp
end;
//===================================================================
function Thld;
begin
   wdp:=f;
   Thld:=2*sqr(s)*ZeroFb(0,2,fun,1e-10)
end;
//===================================================================
function Pwd(por,s:real):real;      {nak}
var x,r,z:real;
    k:byte;
begin
   x:=por/sqr(s)/2;
   z:=exp(-x);
   r:=z;

   for k:=1 to nak do begin
      r:=r*x/k;
      z:=z+r
   end;
   pwd:=z
end;
//===================================================================
function Prdf;
var
  q,p,a,a1,r,r1,z,z1:real;
  n1,EL:byte;
  k:word;
begin
  {if Fmem<>F then begin}
    Fmem := F;
    Pmem := Thld(F,1)/2
  {end};{@@@@@}

   p  := Pmem;
   q  := pwr(10,QdB/10);
   n1 := nak-1;

   Case mfl of
     1: begin
            a  := nak*q;
            r1 := exp(-p);
            if a<100 then begin
                r  := exp(-a);
                z  := r * f;
                a1 := f * 1e-10;

                for k := 1 to n1 do r1 := r1*p/k;

                k := 0;
                repeat
                   inc(k);
                   if r1>a1 then begin
                       r1 := r1*p/(n1+k);
                       f  := f+r1
                   end;
                   r  := r*a/k;
                   z1 := z;
                   z  := z+r*f
                until z=z1
            end else begin
                r := sqrt(a);
                r := sqrt(p)-r-(nak-0.5)/r;
                z := erfc(r)/2
            end
        end;
   2,3: begin
            a := nak*q;
            r1 := exp(-p);
            if mfl=3 then a := a / 2;
            a := a/(1+a);
            z := f;

            for k := 1 to n1 do r1 := r1*p/k;

            k := 0;
            repeat
               inc(k);
               r1 := r1*p/(n1+k);
               r  := pwr(a,k);
               if mfl=3 then begin
                   EL := (k+1) div 2;
                   r  := pwr(a,2*EL)+2*(1-a)*r*EL
               end;
               z1 := z;
               z := z+r*r1
            until z=z1
        end;
     4: begin
            a := 1+q;
            p := p/a;
            r := exp(-p);
            z := r;
            for k := 1 to n1 do begin
                r := r*p/k;
                z := z+r
            end
        end;
     5: begin
            a1 := q/2;
            a  := a1+1;
            p  := p/a;
            r1 := exp(-p);
            z1 := r1;
            for k := 1 to n1 do begin
                r1 := r1*p/k;
                z1 := z1+r1
            end;
            r := pwrr(a,-nak,1);
            z := z1*r;
            for k  := 1 to nak do begin
                r1 := r1*p/(n1+k);
                z1 := z1+r1;
                r  := r*a1;
                z  := z+r*z1*binc(nak,k)
            end
        end
   end;
   Prdf := z
end;

begin
end.