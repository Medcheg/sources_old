 UNIT SpecFun;
 Interface
 Uses MatFun,RsrchFun;

   function erf(x:real):real;
   function erfc(x:real):real;
   function   fz(x:real):real;
   function rerf(x:real):real;
   function rerfc(x:real):real;
 Implementation
   function serf(x:real; n:shortint):real;
   const c1=4.613135e-1; c3=9.999216e-2; c5=2.883894e-3;
         c2=1.901635e-1; c4=1.7844927;   c6=5.5253437;
         a1=5.124242e-1; a2=2.752551e-1; a3=5.176536e-2; a4=2.724745;
   var r,s,z:real; k:word;
   BEGIN z:=sqr(x); if abs(x)<=3
    then begin k:=1; r:=2*n*x*exp(-z)/sqrt(pi); s:=(1-n) div 2 +r;
           while abs(s)<>abs(s+r) do
           begin inc(k,2); r:=2*z/k*r; s:=s+r  end;
         end
    else begin r:=abs(x);
               if r<=6 then s:=c1/(c2+z)+c3/(c4+z)+c5/(c6+z)
                            else s:=a1/(a2+z)+a3/(a4+z);
              if z>200 then z:=0
                       else z:=n*s*exp(-z);
               if x>0  then s:=(1+n) div 2 - x*z
                       else s:=(1-n)-(1+n) div 2 + r*z
         end;
         serf:=s
   END;
   (*************  serf ************************)
   function erf;
   begin erf:=serf(x,1) end;
   function erfc;
   begin erfc:=serf(x,-1) end;
   var bc:boolean;
        r:real;
   function fz;
   begin  if bc then fz:=erfc(x)-r
                else fz:=r-erf(x)
   end;
   function rvrc(x:real):real;
     var s,s1,s2,h:real;
                 z:array[1..20] of real;
          k,m,m2,n:word;
     begin s:=0;
           if bc then if (x<=0) or (x>=1) then begin x:=1-x; bc:=false end;
           if x=s then begin rvrc:=s; exit end;
           r:=abs(x);
           if r>=9.999999999999999999e-1 then
             begin writeln(' x=',x,' - вне области определения rerf(x)');
                   halt
             end                      else
             begin s:=ZeroFb(0,5,Fz,0.01);
                   z[1]:=s;
                   z[2]:=exp(sqr(s))*fz(s)*sqrt(pi)/2;
                   s2:=s+z[2]; n:=0;
                repeat inc(n); s:=s2;
                   h:=n*(n+1)/2.0; s1:=0;
                   for k:=0 to n-1 do
                   begin s2:=0;
                         for m:=0 to k do
                         begin m2:=k+1-m;
                               s2:=s2+z[m+2]*z[m2+1]*(m+1)*m2/h
                         end;
                         s1:=s1+s2*z[n-k]
                   end;
                   z[n+2]:=s1; s2:=s+s1
                until s=s2;
                rvrc:=sign(s,x)
             end
     end;
   Function rerf;
     begin bc:=false;
           rerf:=rvrc(x)
     end;
   Function rerfc;
     begin bc:=true;
           rerfc:=rvrc(x)
     end;
 End.

