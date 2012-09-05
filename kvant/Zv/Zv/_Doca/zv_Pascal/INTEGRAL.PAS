 Unit Integral;
Interface
 type FunType = Function(x:real):real;
 Procedure QuANC8(Fun:FunType;XS,XF,Abserr,Relerr:real;
                  var Result,Errest:real;
                  var Nofun:integer; var Flag:real);
 Function Simpson(Fun:FunType;XS,XF:real;N:integer):real;
 Function FncR(x:real):real;
 Function Convol(F1,F2:FunType;XS,XF,T,Abserr,Relerr:real):real;
 Function FncM(x:real):real;
 Function MeanVal(F,W:FunType;XS,XF,Abserr,Relerr:real):real;
Implementation
  var Fnc1,Fnc2:FunType;
      sdv:real;
 Function Amax(x,y:real):real;
     Begin if x>y then Amax:=x else Amax:=y End;
 Procedure QuANC8;
     const ww = 14175;
     var w0,w1,w2,w3,w4,area,x0,f0,stone,step,corll,temp,
                    qprev,qnow,qdiff,qleft,esterr,tolerr: real;
         qright      : array[1..31] of real;
         f,x         : array[1..16] of real;
         fsave,xsave : array[1..8,1..30] of real;
         levmin,levmax,levout,nomax,nofin,lev,nim,i,j    : integer;
     label 30,50,60,62,70;
     Begin levmin:=1; levmax:=30; levout:=6; nomax:=5000;
           nofin:=nomax-8*(levmax-levout+round(exp((levout+1)*ln(2))));
           w0:=3956/ww; w1:=23552/ww; w2:=-3712/ww;
           w3:=41984/ww; w4:=-18160/ww;
           flag:=0; result:=0; corll:=0; errest:=0; area:=0; nofun:=0;
           if ABS(XS-XF)<1e-9 then exit;
           lev:=0; nim:=1; x0:=XS; x[16]:=XF; qprev:=0;
           f0:=fun(x0);
           stone:=(XF-XS)/16;
           x[8]:=(x0+x[16])/2; x[4]:=(x0+x[8])/2;   x[12]:=(x[8]+x[16])/2;
           x[2]:=(x0+x[4])/2;  x[6]:=(x[4]+x[8])/2; x[10]:=(x[8]+x[12])/2;
           x[14]:=(x[12]+x[16]);
           for j:=2 to 16 do if not odd(j) then f[j]:=fun(x[j]);
           nofun:=9;
       30: x[1]:=(x0+x[2])/2;
           f[1]:=fun(x[1]);
           for j:=3 to 15 do if odd(j) then
           begin x[j]:=(x[j-1]+x[j+1])/2;
                 f[j]:=fun(x[j])
           end;
           nofun:=nofun+8; step:=(x[16]-x0)/16;
           qleft:=(w0*(f0+f[8])+w1*(f[1]+f[7])+w2*(f[2]+f[6])+
                   w3*(f[3]+f[5])+w4*f[4])*step;
           qright[lev+1]:=(w0*(f[8]+f[16])+w1*(f[9]+f[15])+w2*(f[10]+f[14])+
                           w3*(f[11]+f[13])+w4*f[12])*step;
           qnow:=qleft+qright[lev+1]; qdiff:=qnow-qprev; area:=area+qdiff;
           esterr:=abs(qdiff)/1023;
           tolerr:=Amax(abserr,relerr*abs(area))*(step/stone);
           if lev<levmin then goto 50;
           if lev>=levmax then goto 62;
           if nofun>nofin then goto 60;
           if esterr<=tolerr then goto 70;
       50: nim:=2*nim; lev:=lev+1;
           for i:=1 to 8 do
           begin fsave[i,lev]:=f[i+8]; xsave[i,lev]:=x[i+8]  end;
           qprev:=qleft;
           for i:=1 to 8 do
           begin j:=-i; f[2*j+18]:=f[j+9]; x[2*j+18]:=x[j+9] end; goto 30;
       60: nofin:=2*nofin; levmax:=levout; flag:=flag+(XF-x0)/(XF-XS); goto 70;
       62: flag:=flag+1;
       70: result:=result+qnow;
           errest:=errest+esterr; corll:=corll+qdiff/1023;
           while nim<>2*(nim div 2) do begin nim:=nim div 2; lev:=lev-1 end;
           nim:=nim+1;
           if lev>0 then
           begin qprev:=qright[lev]; x0:=x[16]; f0:=f[16];
             for i:=1 to 8 do
             begin f[2*i]:=fsave[i,lev]; x[2*i]:=xsave[i,lev]  end; goto 30
           end;
           result:=result+corll;
           temp:=abs(result)+errest;
           if errest<>0 then while temp=abs(result) do
                             begin
                                  errest:=errest*2;
                                  temp:=abs(result)+errest
                             end;
     End;
 Function Simpson;
     var h,i:real; k:integer;
     Begin h:=((XF-XS)/n)/2; i:=fun(XS);
           for k:=1 to 2*n-1 do if odd(k) then i:=i+4*fun(XS+k*h)
                                          else i:=i+2*fun(XS+k*h);
           Simpson:=(i+fun(XF))*h/3
     End;
 Function FncR;
     begin FncR:=Fnc1(x)*Fnc2(sdv - x) end;
 Function Convol;
     var Result,Errest,Flag:real;
         NoFun:integer;
     Begin
         Fnc1:=F1; Fnc2:=F2; sdv:=T;
         QuANC8(FncR,XS,XF,AbsErr,RelErr,Result,ErrEst,NoFun,Flag);
         Convol:=Result
     End;
 Function FncM;
     begin FncM:=Fnc1(x)*Fnc2(x) end;
 Function MeanVal;
     var Result,Errest,Flag:real;
         NoFun:integer;
     Begin
         Fnc1:=F; Fnc2:=W;
         QuANC8(FncM,XS,XF,AbsErr,RelErr,Result,ErrEst,NoFun,Flag);
         MeanVal:=Result
     End;
 END.
