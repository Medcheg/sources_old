 Unit PSPS;
 Interface
 Uses crt,graph,RsrchFun,Integral,SpecFun,MatFun;
 type
     arr2_5s=array[1..2,1..5] of real;
     arr3_4s=array[1..3,1..4] of real;
     arr4_3s=array[1..4,1..3] of real;
     arr7_10s=array[1..7,1..10] of real;
     arr13b=array[1..13] of byte;
     arr4b=array[1..4] of byte;
     arr11bool=array[1..11] of boolean;
     arr4s=array[1..4] of real;
 const
     pf :arr2_5s=((0.25,-0.5,0.25,1.0,0.0),(0.25,-0.5,0.25,1.0,0.0));
 var
     Pmem,Fmem:real;
     nkp,ik,nrf,ivob,mfl,nak:byte;
     ibx:arr4b;
     pbx:arr4_3s;

 function  nbappo(b:arr11bool):byte;
 function  nbapo2(nbpo:byte):byte;
 function  nkanal(nbz:byte; pict:real):byte;
 procedure   ving(hb:real; var nv:byte; var v:real);
 procedure   mxsp(nv:byte; bg:boolean; fi,te:real; var fw,fw0:real);
 procedure   dxsp(nd:byte; brv,brd:boolean; var fw,fw0:real);
 procedure   gxsp(ng:byte; ta,dc,ec,v:real; var fw,fw0:real);
 procedure zapmrf(nbpo,nball:byte; var mrf: arr4b);
 function   zafi0(nbpo:byte; fw0:arr4s):real;
 procedure   zapf(mrf:arr4b; axf,axf1:arr3_4s; fi0:real);
 procedure    zzz(nbpo:byte; pict,sigm,ti,fcf:real; var yo,dk:real;
                   var bprk:boolean);
 Function   Rfacx(df:real):real;    {nrf, pf}
 Function   Vobrf(df:real):real;    {nrf, pf}
 function     fsi(x:real):real;
 function     fso(x:real):real;
 Function     Pwd(por,s:real):real;      {nak}
 Function     fun(x:real):real;
 Function    Thld(F,s:real):real;        {nak}
 Function    Prdp(QdB,por,s:real; nm:word):real;  {nak, mfl}
 Function    Prdf(QdB,F:real):real;      {nak, mfl}
 function     ffd(q:real):real;
 Function     Qfd(F,D:real):real;        {nak, mfl}
 Function     Qqr(QdB,r,rh:real):real;        {nak, mfl}
 Function    Prdr(r,rh,F,d:real;nm:byte):real; {nak, mfl}
 Procedure   AAZM(nbz,nkz:byte;q,aka,pst,r0,amg,spsh,sist,uo,v,fsh,
                  fcf,frf:real;npr:integer;sdc,sdog:real;var dq:real);
 Procedure   DELP(nbz,nkz:byte;var dp:real;fsf,fshp,frf,ak:real;
                  bprk:boolean;dips:real;
                  ny:integer;r0,pqst,sxip,shp,sst,skp,vog,qpod,q,xss,dsgk,
                  dso:real);
 procedure    Blt(pict,v:real; var pltr:real; nbz,nkz:byte; pv,sish,
                  qip,tip,txip,dips,qbz,fsf,fshp,ak,frf,r0,pqst:real;
                  ny:integer; q,xss,vog:real; bprk:boolean;
                  qpod,shp,sxip,sst,dsgk,dsc,skp:real;
                  var a:real);
 function    poyk(q,td,t_o,tk:real; i_f:integer): real;
 
 Implementation
 var rdp,wdp:real;
 function nbappo;
{
                         п/п зашифровки вариантов
 присваивает порядковый номер одному из 16 возможных вариантов
 входные параметры:
 b[1..4] - логический подмассив признаков наличия пассивных помех (bpom)
     [1] -            морской поверхности,
     [2] -            диполей,
     [3] -            гидрометеоров,
     [4] -            "ангелов";
 b[5..7] - логический подмассив признаков наличия активных помех (bakt)
     [5] -            прямошумовая помеха,
     [6] -            хип,
     [7] -            пип;
 b[8]    - логический признак наличия взаимной помехи (bprbz).
 выходные параметры:
 nbpo    - присвоенный номер варианта.
}
var
 n: word;
begin
 n:=0;
 if b[5] then n:=n+ 1; if b[6] then n:=n+  2; if b[7] then n:=n+ 4;
 if b[1] then n:=n+ 8; if b[2] then n:=n+ 16; if b[3] then n:=n+32;
 if b[4] then n:=n+64; if b[8] then n:=n+128;
 case n of
    0: nbappo:= 0;    1: nbappo:= 2;    2: nbappo:= 1;    3: nbappo:=12;
    4: nbappo:= 3;    8: nbappo:= 4;    9: nbappo:= 9;   10: nbappo:=14;
   13: nbappo:=25;   16: nbappo:= 5;   17: nbappo:=10;   19: nbappo:=13;
   20: nbappo:=15;   24: nbappo:= 8;   25: nbappo:=23;   32: nbappo:= 6;
   33: nbappo:=24;   41: nbappo:=26;   45: nbappo:=27;   59: nbappo:=16;
   61: nbappo:=28;   64: nbappo:= 7;  128: nbappo:=22;  129: nbappo:=17;
  130: nbappo:=11;  136: nbappo:=18;  144: nbappo:=19;  160: nbappo:=20;
  168: nbappo:=21
  else begin
        nbappo:=99;
        writeln('  входная обстановка не имеет номера варианта');
        writeln('                   nbappo =  99')
       end
 end {case}
end { nbappo };
 function nbapo2;
{
 Программа введения соответствия между номером варианта помеховой обстановки
 (nbpo) и номером входного воздействия сигнального процессора.
}
begin
 case nbpo of
               0: nbapo2:=1;
       1,3,11,12: nbapo2:=3;
               2: nbapo2:=2;
   9,10,23,24,26: nbapo2:=9;
              12: nbapo2:=10;
  13,16,25,27,28: nbapo2:=11;
           14,15: nbapo2:=6;
              17: nbapo2:=8;
     18,19,20,21: nbapo2:=7;
              22: nbapo2:=4
  else          nbapo2:=5
 end
end {nbapo2};
 function nkanal;
{
 П/п перевода номера входа (nbz) в номер канала (nkz)
  pict - вероятность правильного выбора nkz
}
begin
 nkanal:=2;
 if pict>=0.9 then
   case nbz of
    1,2:      nkanal:=1;
    3,10:     nkanal:=3;
    4:        nkanal:=5;
    6,11:     nkanal:=4;
    7:        nkanal:=6
   end
end { nkanal };
procedure ving;               { входные параметры hb - высота волны, м.
                           выходные параметры: nv - условный номер скорости
                             ветра, v - скорость ветра, узлы.}
const
 vm: array[1..8] of real=(5.0,10.0,14.0,17.0,21.0,26.75,29.7,32.67);
begin
 nv:=1;
 if (hb>8.0)
  then
   nv:=8
  else
   if (hb>6.0)
    then
     nv:=7
    else
     if (hb>4.0)
      then
       nv:=6
      else
       if (hb>2.7)
        then
         nv:=5
        else
         if (hb>1.7)
          then
           nv:=4
          else
           if (hb>1.0)
            then
             nv:=3
            else
             if (hb>0.3)
              then
               nv:=2;
 v:=vm[nv]
end { ving };
procedure mxsp;      { входные параметры:
                          nv - условный номер скорости ветра,
                          bg - признак горизонтальной поляризации излучения,
                          fi - угол между лучем и направлением ветра,
                          te - угол скольжения луча.
                        выходные параметры:
                          fw - ширина спектра отражения от моря,
                          fw0  сдвиг центральной частоты спектра.}
const
 g=9.8;
 x=418.879;
 x1=7.15534e-6;
 x2=5.699317e-6;
 w: array[1..8,1..2] of real=((13.0,50.0),(75.0,106.0),
                               (140.0,140.0),(140.0,140.0),
                               (50.0,90.0),(90.0,140.0),
                               (200.0,200.0),(200.0,200.0));
 dv: array[1..8,1..2] of real=((0.3,0.6),(0.8,0.9),
                                (1.3,1.3),(1.3,1.3),
                                (1.0,1.5),(2.0,2.0),
                                (2.3,2.3),(2.3,2.3));
 dt: array[1..10,1..2] of real=((1.0,0.9),(0.85,0.8),
                                 (0.75,0.65),(0.5,0.4),(0.25,0.1),
                                 (2.0,1.9),(1.85,1.8),
                                 (1.6,1.4),(1.2,0.9),(0.4,0.1));
var
 l,nt: byte;
 s,vdt,vdv: real;
begin
 if (bg) then l:=2 else l:=1;
 fw:=w[nv,l];
 vdv:=dv[nv,l]; s:=18.0*te/pi;
 if s>1 then nt:=trunc(s)+2
        else if (s<0.5) then nt:=1
                        else nt:=2;
 vdt:=dt[nt,l]; s:=x*cos(fi); s:=g*s+x1*sqr(s)*s;
 fw0:=sqrt(s*x2+sqr(vdv)+sqr(vdt))/0.015
end {mxsp};
procedure dxsp;
{
 входные параметры:
  nd -   условный номер "ленточек",
  brv -  признак наличия флюктуаций скорости ветра,
  brd -  признак наличия флюктуаций скорости "ленточек".
 выходные параметры:
  fw  -  ширина спектра,отраженного от ленточки,
  fw0 -  сдвиг центральной частоты спектра.
}
const
 w: array[1..4] of real=(20.0,50.0,70.0,100.0);
var
 dvr,p,vr,vr1,vr2: real;

begin
 if ((nd<1) or (nd>4)) then
   begin writeln('  Ленточек ndip= ',nd:3,' не знаю,далее ndip=4');
         nd:=4
   end;
 fw:=w[nd]/10;
 dvr:=2; vr:=5;
 if brd then begin p:=random; dvr:=2*p+5*(1-p) end;
 if brv then begin p:=random;  vr:=p+5*(1-p)   end;
 vr1:=vr-dvr;
 if vr1<0 then vr1:=0;
 vr2:=vr+dvr;
 p:=random; vr:=p*vr1+(1-p)*vr2;
 fw0:=vr/15
end { dxsp };
procedure gxsp;
{
 входные параметры:
  ng  - условный номер осадков,
  ta  - ширина диаграммы направленности антинны, рад,
  dc  - дальность до центра осадков,
  ec  - угол места центра осадков,
  v   - скорость ветра, узлы.
 выходные параметры:
  fw  - ширина спектра отражения от осадков,
  fw0 - сдвиг центральной частоты спектра.
}
const
 a: array[1..5,1..2] of real = ((1.2,1.7),(2.2,3),(4,1.4),(2,3),(4,5));
var
 xk,sv,sf,h,sh,ds,a1,s: real;
 l,j: byte;
begin
 if (ng<1) or (ng>12) then
           begin writeln('  осадков ngid= ',ng:3,',не знаю, далее ngid=12');
                 ng:=12
           end;
 fw0:=0;
 xk:=5.7; sv:=1.0; sf:=1.0; h:=sin(ec);
 if ng<=7 then sf:=sqr(h)
          else if ng<=9 then sf:=0.25;
 h:=dc*h;
 if h>=2 then xk:=4.0;
 if h>=3 then sv:=0.49;
 sh:=0.42*xk*dc*sin(ta);
 s:=sqrt(sqr(sh)+sv+sf+0.25);
 if xk<5 then l:=1 else l:=2;
 j:=round(dc/18.0);
 if j>5 then j:=5;
 ds:=abs(a[j,l]-s);
 if (ds>=0.7) and ((ds>=20) or (v<=20) or (s<=5))
  then begin if j>1 then a1:=a[j-1,l] else a1:=1;
             s:=(a[j,l]-a1)/2
       end;
 fw:=s/0.015/10
end { gxsp };
procedure zapmrf;
{
 nbpo  - номер варианта помеховой обстановки,
 nball - номер в таблице бальности,
 mrf[4]  массив признаков структуры режекторного фильтра.
}
begin
 mrf[1]:=1;
 if (nbpo in [4,9,14,18]) and (nball>3)
  then
   mrf[1]:=5;
 if (nbpo in [8,16,21])
  then
   if (nball>3)
    then
     mrf[1]:=6
    else
     mrf[1]:=7;
 mrf[2]:=1;
 mrf[3]:=1;
 if (nbpo in [9,10,13,14,15,16,18])
  then
   mrf[4]:=0
  else
   mrf[4]:=1
end { zapmrf };
 function zafi0;
{
 п/п формирования центральной частоты суммарной помехи.
 входные параметры:
 nbpo  - номер варианта помеховой обстановки,
 fw0[4]  массив центральных частот спектров пассивных помех.
 выходные параметры:
 zafi0   - центральная частота суммарного спектра.
}
begin
 case nbpo of
  4,9,14,18:    zafi0:=fw0[1];
  6,20:         zafi0:=fw0[3];
  7:            zafi0:=fw0[4];
  8:            zafi0:=0.5*(fw0[1]+fw0[2]);
  16:           zafi0:=(fw0[1]+fw0[2]+fw0[3])/3.0;
  21:           zafi0:=0.5*(fw0[1]+fw0[3])
  else          zafi0:=fw0[2]
 end
end { zafi0 };
procedure zapf;
var
 j,nomrf,nf,nrf0: byte;

begin
 for j:=1 to 2 do
  begin
   pf[j,4]:=1.0;
   pf[j,5]:=0.0;
  end;
 nomrf:=mrf[1];
 nf:=mrf[2];
 nrf0:=mrf[3];
 nrf:=1;
 case nomrf of
 1:   begin
       pf[1,1]:=1.0;
       pf[1,2]:=-1.0;
       pf[1,3]:=0.0
      end;
 2:   begin
       pf[1,1]:=1.0;
       pf[1,2]:=-2.0;
       pf[1,3]:=1.0
      end;
 3:   begin
       pf[1,1]:=1.0;
       pf[1,2]:=-2.0;
       pf[1,3]:=1.0;
       pf[1,5]:=fi0
      end;
 5:   begin
       for j:=1 to 3 do
        begin
         pf[1,j]:=axf[j,nf];
         pf[2,j]:=axf1[j,nrf0]
        end;
       nrf:=2
      end;
 6:   begin
       pf[1,1]:=1.0;
       pf[1,2]:=-1.0;
       pf[1,3]:=0.0;
       pf[2,1]:=1.0;
       pf[2,2]:=-2.0;
       pf[2,3]:=1.0;
       pf[2,5]:=fi0;
       nrf:=2
      end;
 7:   begin
       pf[1,1]:=1.0;
       pf[1,2]:=-2.0;
       pf[1,3]:=1.0;
       pf[2,1]:=1.0;
       pf[2,2]:=-2.0;
       pf[2,3]:=1.0;
       pf[2,5]:=fi0;
       nrf:=2
      end;
 9:   begin
       pf[1,1]:=axf[1,nf];
       pf[1,2]:=axf[2,nf];
       pf[1,3]:=axf[3,nf];
       pf[2,1]:=1.0;
       pf[2,2]:=-2.0;
       pf[2,3]:=1.0;
       pf[2,5]:=fi0;
       nrf:=2
      end
 end
end { zapf };
procedure zzz;
{
 входные параметры:
 nbpo - номер варианта входной обстановки,
 pict - вероятность чистоты,
 sigm - дисперсия шума,
 ti   - длительность импульса,
 fcf  - ширина полосы согласованного фильтра.
 выходные параметры:
 yo   - уровень ограничения,
 dk   - дельта (    ) компенсатора,
 bprk - признак компенсатора.
}
{ задание коэффициента сжатия и уровня ограничения }
begin
 if pict<>0.5
  then
   yo:=sigm
  else
   yo:=3.0*sigm;
 case nbpo of
  1..3,9..16,18:    if pict<>0.0
                     then
                      begin
                       dk:=17.0;
                       bprk:=true
                      end
                     else
                      begin
                       yo:=10.0*sigm;
                       dk:=0.0;
                       bprk:=false
                      end;
  4..8,17,19..23:   begin
                     if pict=1.0
                      then
                       yo:=10.0*sigm;
                      dk:=0;
                      bprk:=false
                     end
 end
end { zzz };
 Function Rfacx;
 var a,b,d,z,v:real; k:byte;
 Begin v:=1; for k:=1 to nrf do
    begin z:=pf[k,2]*pf[k,4];        d:=pf[k,1]*sqr(pf[k,4]);
          a:=sqr(d-pf[k,3])+sqr(z);  b:=2*z*(d+pf[k,3]);
          d:=4*d*pf[k,3];            z:=cos(2*pi*df-pf[k,5]);
          v:=v*(a+(b+d*z)*z)
    end;
    Rfacx:=v
 End;
 Function Vobrf;
 const t1=0.929752; t2=0.991736; t3=1.078512;
 var  w:real; k:byte;
 function fpr(c,q:real; i:byte):real;
 begin df:=2*pi*df;
    fpr:=sqr(pf[i,1])+sqr(pf[i,2])+sqr(pf[i,3])+2*pf[i,1]*pf[i,2]*cos(df*c)
           +2*pf[i,2]*pf[i,3]*cos(df*q)+2*pf[i,1]*pf[i,3]*cos(df*(c+q)) end;
 Begin  w:=1; for k:=1 to nrf do
   w:=w/3*(fpr(t1,t2,k)+fpr(t3,t1,k)+fpr(t2,t3,k));
   Vobrf:=w
 End; 
 
 function fsi;
 var y:real;
 begin  y:=abs(x-pbx[ik,3])/pbx[ik,2];
  Case ibx[ik] of
         0: if y<33 then fsi:=exp(-sqr(y)) else fsi:=0;
         1: if y<1000 then fsi:=exp(-y) else fsi:=0;
     2,3,4: fsi:=1/(1+pwr(y,ibx[ik]));
  end;
 end;
 function fso;
 begin if ivob=0 then fso:=fsi(x)*Rfacx(x)
                 else fso:=fsi(x)*Vobrf(x);
 end;
 
 Function     Pwd(por,s:real):real;      {nak}
 var x,r,z:real; k:byte;
 begin x:=por/sqr(s)/2; z:=exp(-x); r:=z;
       for k:=1 to nak-1 do begin r:=r*x/k; z:=z+r end;
       pwd:=z
 end;
 Function fun(x:real):real;
 begin fun:=Pwd(2*x,1)-wdp end;
 Function Thld;
 Begin wdp:=f; Thld:=2*sqr(s)*ZeroFb(0,2,fun,1e-10)
 End;
 Function Prdp;
 var q,p,a,a1,r,r1,z,z1,f:real;
     n1,l:byte; 
     k:word;
 Begin p:=por/sqr(s)/2;
  q:=pwr(10,QdB/10); n1:=nak-1; mfl:=nm;
   Case mfl of
 1,2,3: begin a:=nak*q; f:=Pwd(por,s); r1:=exp(-p);
          Case mfl of
        1: begin if a<100 then
             begin r:=exp(-a); z:=r*f; a1:=f*1e-10;
               for k:=1 to n1 do r1:=r1*p/k; k:=0;
               repeat inc(k); if r1>a1 then
                 begin r1:=r1*p/(n1+k); f:=f+r1 end;
                 r:=r*a/k; z1:=z; z:=z+r*f
               until ((abs(z-z1)<=1e-7) AND (z1>f))
             end else
             begin r:=sqrt(a); r:=sqrt(p)-r-(nak-0.5)/r; z:=erfc(r)/2 end
           end;
      2,3: begin if mfl=3 then a:=a/2; a:=a/(1+a); z:=f;
             for k:=1 to n1 do r1:=r1*p/k; k:=0;
             repeat inc(k); r1:=r1*p/(n1+k); r:=pwr(a,k);
            if mfl=3 then begin l:=(k+1) div 2; r:=pwr(a,2*l)+2*(1-a)*r*l end;
               z1:=z; z:=z+r*r1
             until ((abs(z-z1)<=1e-7) AND (z1>f))
            end
          end
         end;
   4: begin a:=1+q; p:=p/a; r:=exp(-p); z:=r;
        for k:=1 to n1 do begin r:=r*p/k; z:=z+r end
      end;
   5: begin a1:=q/2; a:=a1+1; p:=p/a; r1:=exp(-p); z1:=r1;
        for k:=1 to n1 do begin r1:=r1*p/k; z1:=z1+r1 end;
        r:=pwrr(a,-nak,1); z:=z1*r;
        for k:=1 to nak do begin r1:=r1*p/(n1+k); z1:=z1+r1; r:=r*a1;
                               z:=z+r*z1*binc(nak,k) end
      end
     end;
     Prdp:=z
 End;
 Function Prdf;
 var q,p,a,a1,r,r1,z,z1:real; n1,l:byte; k:word;
 Begin {if Fmem<>F then begin} Fmem:=F; Pmem:=Thld(F,1)/2 {end};{@@@@@}
       p:=Pmem; q:=pwr(10,QdB/10); n1:=nak-1;
   Case mfl of
     1: begin a:=nak*q; r1:=exp(-p);
              if a<100 then begin r:=exp(-a); z:=r*f; a1:=f*1e-10;
                                  for k:=1 to n1 do r1:=r1*p/k; k:=0;
                                  repeat inc(k); if r1>a1 then
                                     begin r1:=r1*p/(n1+k); f:=f+r1 end;
                                     r:=r*a/k; z1:=z; z:=z+r*f
                                  until z=z1
                            end
                       else begin r:=sqrt(a); r:=sqrt(p)-r-(nak-0.5)/r;
                                  z:=erfc(r)/2
                            end
        end;
   2,3: begin a:=nak*q; r1:=exp(-p);
              if mfl=3 then a:=a/2;
              a:=a/(1+a); z:=f;
              for k:=1 to n1 do r1:=r1*p/k; k:=0;
              repeat inc(k); r1:=r1*p/(n1+k); r:=pwr(a,k);
                     if mfl=3 then begin l:=(k+1) div 2;
                                         r:=pwr(a,2*l)+2*(1-a)*r*l
                                   end;
                     z1:=z; z:=z+r*r1
              until z=z1
        end;
     4: begin a:=1+q; p:=p/a; r:=exp(-p); z:=r;
              for k:=1 to n1 do begin r:=r*p/k; z:=z+r end
        end;
     5: begin a1:=q/2; a:=a1+1; p:=p/a; r1:=exp(-p); z1:=r1;
              for k:=1 to n1 do begin r1:=r1*p/k; z1:=z1+r1 end;
              r:=pwrr(a,-nak,1); z:=z1*r;
              for k:=1 to nak do begin r1:=r1*p/(n1+k); z1:=z1+r1; r:=r*a1;
                                       z:=z+r*z1*binc(nak,k)
                                 end
        end
   end;
     Prdf:=z
 End;
 function ffd;
 begin ffd:=prdf(q,wdp)-rdp end;
 Function Qfd;
 Begin wdp:=f; rdp:=d; Qfd:=ZeroFB(-20,5,ffd,1e-10)
 End;
 Function Qqr(QdB,r,rh:real):real;
 Begin
      Qqr:=QdB + 40*ln(rh/r)/ln(10);
 end;
 Function Prdr;
 var q:real;
 Begin if nm>5 then Prdr:=d
               else begin mfl:=nm;
                          q:=Qfd(f,0.5) + 40*ln(rh/r)/ln(10);
                          Prdr:=Prdf(q,f)
                     end;
 End;
Procedure AAZM;
(*      входные параметры
 nbz  - номер входа,
 nkz  - номер канала,
 q    - коэффициент сжатия ,
 v    - весовая обработка,
 aka  - дельта (  ) компенсатора,
 pst  - вероятность структурной помехи,
 r0   - коэффициент,определяющий прохождение структурной помехи через СФ,
 amg  - дельта (  ) сглаживания фильтра,dB,
 spsh - дисперсия (сигма   ) активной помехи,
 sist - дисперсия (сигма   ) структурной помехи,
 uo   - уровень ограничения,
 fsh  - ширина полосы широкополосного фильтра,
 fcf  - ширина полосы согласованного фильтра,
 frf  - ширина полосы режекторного фильтра,
 npr  -
 sdc  - дельта (    ) СДЦ (dB),
 sdog - дельта сдц ограничителя (dB).
        выходные параметры
 dq   - значение выигрыша соотношения сигнал-шум.
*)
var
 a,dsf,dstr,dstrco,dsos,dog,dstro,dpo,dps,dog1:real;
 i:byte;
begin
 { формирование матрицы сигнал-шум }
 dstr:=0.0;
 dstrco:=0.0;
 dsos:=0.0;
 dog:=0.0;
 a:=1.0/ln(10.0);
  { задание производных величин по константам каналов }
 dsf:=10.0*a*ln(q*v);
 if (pst<>0.0) and (r0<>0.0) and (sist<>0.0)
  then
   begin
    dstr:=10.0*a*ln(pst*r0)+dsf;
    dstro:=10.0*a*ln(sqr(sist)*pst/sqr(uo));
    dstrco:=10.0*a*ln(fcf/frf*pst)
   end;
 if (spsh<>0.0)
  then
   begin
    dsos:=10.0*a*ln(fsh/fcf*sqr(spsh)/sqr(uo)*q*v);
    dog:=20.0*a*ln(spsh/uo)
   end;
 dpo:=20.0*a*ln(npr);
 dps:=10.0*a*ln(fsh/fcf);
 dog1:=1.0;

 i:=6*(nbz-1)+nkz;
 case i of
  1,2,25:        dq:=dsf;
  3,4,5,6,27:    dq:=dsf-dog1;
  7,8,49,55,61:  dq:=dsf+aka+dps;
  9,10,11,51,
  57,58,59,63:   dq:=aka+dsos-dog1;
  12:            dq:=aka-dpo+dog+dsf-dog1;
  13,31:         dq:=dsf+dps;
  14:            dq:=dsf+dps-dpo;
  15,16,33:      dq:=dsos-dog1;
  17:            dq:=dsos-dog1-amg;
  18:            dq:=-dpo+dog+dsf+aka;
  19,37:         dq:=dsf-dstr;
  20:            dq:=dsf-dstr-dpo;
  21,24:         dq:=dsf-dog1-(dstr-dstro);
  22:            dq:=dsf-dog1-(dstr-dstro)-dpo;
  23:            dq:=dsf-dog1-(dstr-dstro)+amg;
  26:            dq:=dsf+sdc-amg;
  28:            dq:=dsf-dog1+sdc-sdog;
  29:            dq:=dsf-dog1+sdc-sdog-amg;
  30:            dq:=dsf-dog1+sdc;
  32:            dq:=dsf+dps+sdc-dpo;
  34,35:         dq:=dsos-dog1+sdc+sdog;
  36:            dq:=dsos-dog1+sdc;
  38:            dq:=dsf-dstr+sdc-dpo;
  39:            dq:=dsf-dog1+dstr-dstrco;
  40:            dq:=dsf-dog1-(dstr-dstro)+sdc-sdog-dstrco-dpo;
  41:            dq:=dsf-dog1-(dstr-dstro)+sdc-sdog;
  42:            dq:=dsf-dog1+sdc-(dstr-dstro)-dstrco;
  43:            dq:=aka+(dsf-dstr)+dps;
  44:            dq:=aka+(dsf-dstr)+dps-dpo;
  45,47:         dq:=aka-dog1+dsos-(dstr-dstro);
  46:            dq:=aka-dog1+dsos-(dstr-dstro)-dpo;
  48:            dq:=aka-dog1-(dstr-dstro)-dpo+dsf+dog;
  50:            dq:=dsf+sdc+dps+aka;
  52,64,65:      dq:=dsos-dog1+sdc-sdog+aka;
  53:            dq:=dsos-dog1+sdc-sdog-amg+aka;
  54,66:         dq:=dsf-dog1+sdc+aka-dpo+dog;
  56:            dq:=dps+dsf+aka-dpo;
  60:            dq:=aka-dpo+dog+dsf-dog1;
  62:            dq:=dsf+sdc+dps+aka-dpo;
  67:            dq:=dps+dsf+dstr;
  68:            dq:=dps+dsf+dstr-dpo;
  69:            dq:=dsos-dog1-(dstr-dstro);
  70:            dq:=dsos-dog1-(dstr-dstro)-dpo;
  71:            dq:=dsos-dog1-(dstr-dstro)+amg;
  72:            dq:=-dpo+dog-dog1-(dstr-dstro)+dsf;
 end{case}
end{AAZM};
Procedure DELP;
(*
 nbz  - номер входа,
 nkz  - номер канала,
 fsf  - ширина полосы согласованного фильтра,
 fshp - ширина полосы широкополосной помехи,
 frf  - ширина полосы режекторного фильтра,
 ak   - d (       )  автокомпенсатора,
 bprk - признак ак (true - ak=17 dB, false - ak=0 dB),
 dips - d (       ) сглаживания импульсной помехи,
 txip - длительность ХИП,
 r0   - коэффициент,определяющий прохождение структурной помехи через СФ,
 pqst - вероятность структурной помехи,
 ny   - коэффициент некогеррентного усиления РФ,
 sxip - дисперсия ХИП,
 shp  - дисперсия шумовой помехи,
 sst  - дисперсия структурной помехи,
 skp  - дисперсия коррелированной помехи,
 vog  - уровень ограничения,
 qpod - коэффициент подавления коррелированной помехи в фильтре СДЦ,dB,
 q    - коэффициент сжатия СФ,
 xss  - коэффициент подавления структурной помехи в сглаживающем фильтре,
 dsgk - d (     ) сглаживания коррелированной помехи,dB,
 dso  - d (     ) ограничителя СДЦ,dB,
*)
var
 dsgs,dps,dpr,dst,dk,dox,doh,dos,dok:real;
 i:integer;
 a:real;
(*              *)
begin
 a:=1.0/ln(10.0);
 dps:=10.0*a*ln(fshp/fsf);
 dpr:=20.0*a*ln(ny);
 dst:=20.0*a*ln(r0*pqst*q);
 if (sxip>1.0e-6)
  then
   dox:=20*a*ln(sxip/vog);
 if (shp>1.0e-6)
  then
   doh:=20.0*a*ln(shp/vog);
 if (sst>1.0e-6)
  then
   dos:=20.0*a*ln(sst/vog);
 if (skp>1.0e-6)
  then
   dok:=20.0*a*ln(skp/vog);
 dsgs:=20.0*a*ln(xss*r0*pqst*q);
 dk:=0.0;
 dp:=0.0;
 if (bprk)
  then
   dk:=ak;
(*              *)
 i:=6*(nbz-1)+nkz;
 case i of
  7,8,49,55,61:dp:=-dps-dk;
  9,10,11,12: dp:=-dps-dk-doh;
  13,31:      dp:=-dps;
  14:         dp:=-dps-dips;
  15,16,17,18:dp:=-dps-dox;
  19,37:      dp:=dst;
  20:         dp:=dst-dsgs;
  21:         dp:=dst-dos;
  22,24:      dp:=dst-dos+dpr;
  23:         dp:=dst-dos-dsgs;
  25:         dp:=0.0;
  26:         dp:=-qpod+dsgk;
  27:         dp:=-dok;
  28:         dp:=-dok-qpod+dso;
  29:         dp:=-dok-qpod+dsgk+dso;
  30:         dp:=-qpod;
  32:         dp:=-dps-qpod-dips;
  33:         dp:=-dox-dok-dps;
  34,35:      dp:=-dok-qpod+dso-dox-dps;
  36:         dp:=-dps-qpod-dox+dpr;
  38:         dp:=dst-qpod-dsgs;
  39:         dp:=dst-dos-dok;
  40:         dp:=dst-qpod-dos-dok+dso+dpr;
  41:         dp:=dst-qpod-dsgs-dos-dok+dso;
  42:         dp:=dst-dos+dpr-qpod;
  43:         dp:=dst-dps-dk;
  44:         dp:=dst-dps-dk-dsgs;
  45:         dp:=dst-dps-dk-doh-dos;
  46,48:      dp:=dst-dps-dk-doh+dpr-dos;
  47:         dp:=dst-dps-dk-dsgs-doh-dos;
  50:         dp:=-qpod-dps-dk+dsgk;
  51:         dp:=-dps-dk-doh-dok;
  52:         dp:=dso-dps-dk-doh-dok-qpod;
  53:         dp:=-qpod-dps-doh-dok+dso-dk;
  54:         dp:=-dps-doh-qpod-dk;
  56:         dp:=-dk-dps-dips;
  57,58,59,60:dp:=-dox-doh-dk-dps;
  62:         dp:=-qpod-dps-dk-dips;
  63:         dp:=-dps-dox-doh-dk-dok;
  64,65:      dp:=-dox-dps-dk-doh-dok-qpod+dso;
  66:         dp:=-dps-qpod-doh-dox-dk;
  67:         dp:=-dps+dst;
  68:         dp:=-dps+dst-dsgs-dips;
  69,72:      dp:=-dps+dst-dox-dos;
  70,71:      dp:=-dps+dst-dox-dos+dpr;
 end (*case*)
end (*delp*);
 procedure Blt;
 var dp:real;
 Begin Case round(10*pict) of
     10: pltr:=Pwd(v,sish);
      0: begin a:=(1+pwr(10,pv/20))*sish; pltr:=Pwd(v,a) end;
      5: begin Delp(nbz,nkz,dp,fsf,fshp,frf,ak,bprk,dips,ny,r0,pqst,
                    sxip,shp,sst,skp,vog,qpod,q,xss,dsgk,dsc);
               a:=sish*(1+pwr(10,(pv+dp)/20)); pltr:=Pwd(v,a);
               Case nbz of
         3,6,10,11: pltr:=pltr+tip/txip/qip;
             4,7,8: pltr:=pltr+1/qbz;
                12: pltr:=pltr+tip/txip/qip+1/qbz;
               end;
         end;
       Else writeln(' Ошибка задания PIST');
       end;
 End;
 function poyk;
 const
  pi2=pi*2;
 var
  x,y,spi: real;
 begin
 spi:=sqrt(pi);
 if (i_f<>0)
  then
   begin
    x:=sqr(td*t_o/tk/pi2);
    y:=sqrt(1.0+x);
    x:=y/sqr(q)+(4.0-pi)*x/pi2/(sqr(y)*y);
    poyk:=td*sqrt(x)/spi
   end
  else
   poyk:=td/spi/q
end { poyk };

End.

