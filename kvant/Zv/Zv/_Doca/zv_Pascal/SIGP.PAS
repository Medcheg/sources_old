unit sigp;

{---------------------------------------------------------------------------}

INTERFACE

uses
glob_2,matfun;

type
 preal=^real;
 FDN=function(yml,ymc,sdn:real):real;
const
 size_ext=sizeof(real);
procedure fosld(d,e,h,el1,sdn1:real;ppol:byte;var q:arr_a; var v,ko:real;DN:FDN);
procedure fosldn(ind:byte;d,e,h,el1,sdn1:real;ppol:byte;var q:arr_a; var v,ko:real;DN:FDN);
procedure foid(d,h,el1,sdn1,ppol,eps:real;var q:arr_a; var v,v2,sss,ddd,ccc,ggg:real;DN:FDN);
function DNZW(yml,ymc,sdn:real):real;
function DN_EXP(ymc,sdn:real):real;
function DN_CS(ymc,sdn:real):real;
function COSEC(yml,ymc,sdn:real):real;
function DNZWM(yml,ymc,sdn:real):real;
function DNZE(yml,ymc,sdn:real):real;
function DNZE_L1(yml,ymc,sdn:real):real;
function DNZE_L2(yml,ymc,sdn:real):real;
function DN_COS(yml,ymc,sdn:real):real;
function DN_SIN(yml,ymc,sdn:real):real;
function DN_SINN(yml,ymc,sdn:real):real;
function DN_SINb(yml,ymc,sdn:real):real;
function DN_SINg(yml,ymc,sdn:real):real;
function DNZEM(yml,ymc,sdn:real):real;
function DN_zp(yml,ymc,sdn:real):real;
function DNGO_TAB(yml,ymc,sdn:real):real;
function DNzp_TAB(yml,ymc,sdn:real):real;
function DNop_MA_1(yml,ymc,sdn:real):real;
function DNop_MA_2(yml,ymc,sdn:real):real;
function DN_OBEN(yml,ymc,sdn:real):real;
function DN_UNTEN(yml,ymc,sdn:real):real;
procedure fosid(d,h,el1,sdn1,ppol,eps:real;var ind:byte;var q:arr_a; var v,v2:real;DN:FDN);
procedure foslju(d,h,el1,sdn1,ppol,eps:real;var q:arr_a; var v,v2,sss,ddd,ccc,ggg:real;DN:FDN);
{---------------------------------------------------------------------------}
IMPLEMENTATION
  procedure foslju;
 label w1,w2,d0,aaa,bbb,nnn;
var
 ah,c1,d1,de,dg,dr,ffo,ffp,fo,fp,gam,h2,ha,ki,
 ksi,l,mm,r,re,rm1,rm2,rz,rum,sq,u,drg,l1,dcp,
 hap,hcp,ll,mv4,yb,zzz,e,h3,km:real;
 flg:boolean;
 nl,kk,ind: integer;
 k,ymdn,ymn,v1:real;
begin
  flg:=true;
  nl:=40;
 re:=q[11];
 rz:=q[12];
 ha:=q[8];
 de:=q[15];
 sq:=sqrt(h)+sqrt(ha);
 drg:=4.12*(sqrt(ha*1000)+sqrt(h*1000));
 ah:=q[28];
 ll:=q[13];
 l:=q[27];
 dcp:=d/l; hap:=ha/ah; hcp:=h/ah;
 if (abs(h-ha)>=0.95*d) then begin v:=1; goto aaa; end else begin
 dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
   zzz:=sqr(re+h)-sqr(dg); zzz:=sqrt(zzz)-re-ha;
   if zzz/d>0.95 then e:=pi/2 else e:=arcsin(zzz/d);
 l1:=pwrr((pi*q[11]/q[13]),1,3)*(q[8]+h)*(1/d-d/sqr(drg));
 rum:=sqrt(2.0*re)*(sqrt(ha+0.56*ah)+sqrt(h+0.56*ah))-1.5*l;
   ind:=1;
   v2:=1;
   sss:=e/pi*180;
 if (d>rum)  then begin
          mv4:=d;
          kk:=trunc((mv4-rum)/1)+1;{ /1=/ на шаг по дальности в fosld}
          d:=d-kk*1;dcp:=d/l;
          dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
          zzz:=sqr(re+h)-sqr(dg); zzz:=sqrt(zzz)-re-ha;
          if zzz/d>0.95 then e:=pi/2 else e:=arcsin(zzz/d);
          ind:=0;
          goto d0;
    w1:   kk:=kk-1;
          d:=mv4-kk*0.5;dcp:=d/l;
          dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
          zzz:=sqr(re+h)-sqr(dg); zzz:=sqrt(zzz)-re-ha;
          if zzz/d>0.95 then e:=pi/2 else e:=arcsin(zzz/d);
          if (kk=0) then ind:=1;
              if flg then begin
                     v1:=40*lg(v);
                     v1:=v1+10*lg(hcp);
                     v1:=v1-20*lg(dcp);
                     v1:=abs(v1);     flg:=false; end;
      ksi:=dcp-sqrt(hcp);
     if (ll<=3.5e-4) then
         v1:=v1+2+(35-ll*100000)/10.5;

      if (ll>3.5e-4)and (ll<=3.5e-3) then
                v1:=v1+1.2+(350-ll*100000)/(393+6/8) ;

       v:=pwr(10,(-v1/40));
         v:=sqrt(sqrt(sqr(dcp)/hcp))*v;
         v:=0.8*exp(-sqr(1/(sqrt(2)*rum)*d));
   if ppol=1 then begin

      if (ksi>1.5) then v2:=280-40*sqrt(hap-0.1)-(7-ksi)*35.7;
      if (ksi<=1.5) and (ksi>1.0) then v2:=68-40*sqrt(hap-0.1)-(1-ksi)*32;
      if (ksi<=1.0) and (ksi>0.5) then v2:=68-40*sqrt(hap-0.1)-(1-ksi)*24;
      if (ksi<=0.5) then v2:=56-40*sqrt(hap-0.1)-(0.5-ksi)*20;
   end;
   if ppol=2 then begin

      if (ksi<=0.75)  then v2:=4-2*hap+(ksi-0.5)*8;
      if (ksi>0.75) and (ksi<=1.0)  then v2:=7-2.5*hap+(ksi-0.75)*11;
      if (ksi>1.0) and (ksi<=1.25)  then v2:=10-3*hap+(ksi-1)*12;
      if (ksi>1.25) and (ksi<=1.75)  then v2:=13.5-3.3*hap+(ksi-1.25)*14;
      if (ksi>1.75) and (ksi<=2.0)  then v2:=21-4.1*hap+(ksi-1.75)*16;
      if (ksi>2.0)   then v2:=25-4.25*hap+(ksi-2)*15.4;
   end;
      ggg:=ksi;
             if (ind=0) then goto w1;
         v2:=pwr(10,(-v2/40));
         v2:=sqrt(sqrt(sqr(dcp)/hcp))*v2;
      if v<v2 then v:=v2;

         v:=v2;{**** отсутствие коментария даст горбы *****}

   w2:    end {fosd}
 {?????????}(*****************     else begin
{** расчет по Голеву **}
d0: rm1:=sqrt(ha)/sq*dg; rm2:=sqrt(h)/sq*dg;
 h2:=ha-sqr(rm1)/(2.0*re);
 h3:=h-sqr(rm2)/(2.0*re);
     dr:=sqrt(sqr(dg)+sqr(h2+h3))-sqrt(sqr(dg)+sqr(h3-h2));
 gam:=q[29]*dr;
 u:=ha/rm1-rm1/(2.0*re);
 ksi:=arctan(u/sqrt(1.0-sqr(u)));
 k:=ppol;
 if (ppol=2) then begin
    if (ll<10.00e-5) then begin
                         k:=-10.8*ksi+1;
       if (ksi>pi/180*3.2) then k:=-5.4*ksi+0.7;
       if (ksi>pi/30) then k:=0.15;
       if (ksi>pi/180*8) then k:=1.17*ksi+0.04;
       if (ksi>pi/18) then k:=0.2;
   end;
   if(ll>=1.00e-4) and (ll<3.00e-4) then begin
                       k:=-14.3*ksi+1;
       if (ksi>pi/90) then k:=-7.4*ksi+0.76;
       if (ksi>pi/180*4) then k:=-3.14*ksi+0.48;
       if (ksi>pi/180*6) then k:=2.14*ksi-0.075;
       if (ksi>pi/18) then k:=0.3;
   end;
   if(ll>=3.00e-4) and (ll<4.50e-4) then begin
                       k:=-15*ksi+1;
       if (ksi>pi/180*2.0) then k:=-6.5*ksi+0.7;
       if (ksi>pi/180*4.4) then k:=2.08*ksi+0.4;
       if (ksi>pi/18) then k:=0.37;
   end;
   if(ll>=4.50e-4) and (ll<6.00e-4) then begin
                       k:=-15*ksi+1;
       if (ksi>pi/180*2) then k:=-6.5*ksi+0.7;
       if (ksi>pi/180*4.0) then k:=1.64*ksi+0.13;
       if (ksi>pi/18) then k:=0.42;
   end;
   if(ll>=6.00e-4) and (ll<1.00e-3) then begin
                       k:=-21*ksi+1;
       if (ksi>pi/180*1.1) then k:=-10.55*ksi+0.8;
       if (ksi>pi/180*2.0) then k:=-8*ksi+0.71;
       if (ksi>pi/180*3.0) then k:=2.1*ksi+0.18;
       if (ksi>pi/18) then k:=0.53;
   end;
   if(ll>=1.00e-3) and (ll<1.50e-3) then begin
                       k:=-22.85*ksi+1;
       if (ksi>pi/180*1.0) then k:=-11.43*ksi+0.8;
       if (ksi>pi/180*2.0) then k:=-4.3*ksi+0.5;
       if (ksi>pi/180*3.0) then k:=2.36*ksi+0.2;
       if (ksi>pi/18) then k:=0.61;
   end;
   if(ll>=1.50e-3) and (ll<3.00e-3) then begin
                       k:=-28.5*ksi+1;
       if (ksi>pi/180*0.8) then k:=-13.57*ksi+0.79;
       if (ksi>pi/180*1.7) then k:=-3.7*ksi+0.5;
       if (ksi>pi/180*2.3) then k:=2.5*ksi+0.27;
       if (ksi>pi/18) then k:=0.71;
   end;
   if(ll>=3.00e-3) then begin
                       k:=-29.4*ksi+1;
       if (ksi>pi/180) then k:=-5.7*ksi+0.6;
       if (ksi>pi/90) then k:=2.43*ksi+0.316;
       if (ksi>pi/18) then k:=0.73;
   end;
 end;
 c1:=k*exp(-8.0*sqr(q[26]*sin(ksi)));
 u:=1.0/(1.0+ha/rz)*cos(ksi);
 yb:=arctan(u/sqrt(1.0-sqr(u)));
  d1:=1.0/sqrt(1.0+2.0*rm1*rm2/(re*(rm1+rm2)*sin(ksi)));
  fo:=-(pi/2.0-yb);
    ffp:=DN(el1,e,sdn1);
    ffo:=DN_SIN(el1,fo,sdn1);ffp:=1; ffo:=1;
    if ffp<0.001 then mm:=0 else
    mm:=c1*d1*ffo/ffp;
    if (2.0*mm*cos(gam)-sqr(mm))>1 then
      v:=1.0e-3
    else
      v:=sqrt(1.0-2.0*mm*cos(gam)+sqr(mm)); if ind=0 then goto w1;
  end{fosl}  {????????????}************)
     else begin
d0: rm1:=sqrt(ha)/sq*dg;
 rm2:=sqrt(h)/sq*dg;
 u:=d/drg; dr:=2*ha*h*sqr(1.0-u*u)/u/drg;
 gam:=q[29]*dr;
 { h=ha }
 {gam:=4*pi*ha*h*sqr(1-sqr(dg)/4/q[11]/h)/ll/dg;}
{ else                                      }
 { h>>ha }
{ gam:=4*pi*ha*h*(1-sqr(dg)/2/q[11]/h)/ll/dg;}
 ccc:=gam;
 u:=dg/drg;u:=(1-u*u)/u;
 u:=u*(ha+h)/drg;
 ksi:=arctan(u/sqrt(1.0-sqr(u)));
 {**************************************************************}
 if ppol=1 then begin
{    k:=sqrt(eps-1);
    k:=1-2*sin(ksi)/k;}
    k:=sin(ksi)+sqrt(eps-sqr(cos(ksi)));
    k:=(-sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
 end;

 if ppol=2 then begin
{    k:=sqrt(eps-1);
    k:=1-2*sin(ksi)*eps/k;}
    k:=eps*sin(ksi)+sqrt(eps-sqr(cos(ksi)));
    k:=(-eps*sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
 end;
 ddd:=k;
 k:=1;
 {**************************************************************}
 if (u>ll/(5*q[14])) then begin v:=1; goto aaa; end;

  c1:=k*exp(-8.0*sqr(q[26]*sin(ksi)));
  u:=re*cos(ksi)/(re+ha);
  yb:=arctan(u/sqrt(1.0-sqr(u)));
  fo:=-(pi/2-yb);
 u:=d/drg;   dr:=u/(1-u*u);
 if h>ha then h2:=ha/h else h2:=h/ha;
 d1:=1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(h2))/(sqr(1+h2)*(1+h2)));
{ d1:=1.0/sqrt(1.0+2.0*rm1*rm2/(re*(rm1+rm2)*sin(ksi)));}

    ffp:=DN(el1,e,sdn1);
    ffo:=DN(el1,fo,sdn1); ffp:=1; ffo:=1;
    if ffp<0.0001 then mm:=0 else  mm:=c1*d1*(ffo/ffp);
        if (2.0*mm*cos(gam)-sqr(mm))>1 then
      v:=1.0e-3
    else

 {  if (k<0) and (ppol=2)  then
      v:=sqrt(1.0-2.0*mm*cos(gam-pi)+sqr(mm))
   else}
      v:=sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));
    if (d<=rum) then v2:=v;


      if (e<ll/4/ha) then begin
         v2:=v;
      end;
  if (ind=0) then goto w1;
  end;{fosl}
aaa: end;
end;
 procedure fosid;
 label w1,w2,d0,aaa,bbb,nnn;
var
 ah,c1,d1,mv1,mv2,mv3,de,dg,dr,ffo,ffp,fo,fp,gam,h2,ha,ki,
 ksi,l,mm,r,re,rm1,rm2,rz,drum,rum,sq,u,drg,l1,dcp,ccc,ddd,ggg,sss,
 hap,hcp,ll,mv4,yb,zzz,e,h3,km:real;
 flg:boolean;
 nl,kk: integer;
 k,ymdn,ymn,v1:real;
begin
  flg:=true;
  nl:=40;
 re:=q[11];
 rz:=q[12];
 ha:=q[8];
 de:=q[15];
 sq:=sqrt(h)+sqrt(ha);
 drg:=4.12*(sqrt(ha*1000)+sqrt(h*1000));
 ah:=q[28];
 ll:=q[13];
 l:=q[27];
 dcp:=d/l; hap:=ha/ah; hcp:=h/ah;
 if (abs(h-ha)>=0.95*d) then begin v:=1; goto aaa; end;
 dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
   zzz:=sqr(re+h)-sqr(dg); zzz:=sqrt(zzz)-re-ha;
   if zzz/d>0.95 then e:=pi/2 else e:=arcsin(zzz/d);
 l1:=pwrr((pi*q[11]/q[13]),1,3)*(q[8]+h)*(1/d-d/sqr(drg));
 rum:=sqrt(2.0*re)*(sqrt(ha+0.56*ah)+sqrt(h+0.56*ah))-1.5*l;
 drum:=rum-rum*ll/(4*ha);
{  rum:=rum-3; }
   v2:=1;
          if d<=rum then begin
          goto d0;end;
          if (d>rum) AND (ind=1) then begin
          drum:=d;
          D:=rum;ind:=0;goto D0;
          end;
      ksi:=dcp-sqrt(hcp);
         mv1:=40*lg(ggg*1000/ccc);
      mv2:=209-mv1;mv3:=sss-ggg;
      v2:=d*mv2/mv3+mv1-ggg*mv2/mv3;
       (************  перевод в разы      ********)
    v2:= d*1000/(pwr(10,v2/40));

{           if ppol=1 then begin
      if (ksi>1.5) then v2:=280-40*sqrt(hap-0.1)-(7-ksi)*35.7;
      if (ksi<=1.5) and (ksi>1.0) then v2:=68-40*sqrt(hap-0.1)-(1-ksi)*32;
      if (ksi<=1.0) and (ksi>0.5) then v2:=68-40*sqrt(hap-0.1)-(1-ksi)*24;
      if (ksi<=0.5) then v2:=56-40*sqrt(hap-0.1)-(0.5-ksi)*20;
   end;
   if ppol=2 then begin
      if (ksi<=0.75)  then v2:=4-2*hap+(ksi-0.5)*8;
      if (ksi>0.75) and (ksi<=1.0)  then
       v2:=7-2.5*hap+(ksi-0.75)*11;
      if (ksi>1.0) and (ksi<=1.25)  then v2:=10-3*hap+(ksi-1)*12;
      if (ksi>1.25) and (ksi<=1.75)  then v2:=13.5-3.3*hap+(ksi-1.25)*14;
      if (ksi>1.75) and (ksi<=2.0)  then v2:=21-4.1*hap+(ksi-1.75)*16;
      if (ksi>2.0)   then v2:=25-4.25*hap+(ksi-2)*15.4;
   end;
            ggg:=ksi;
         v2:=pwr(10,(-v2/40));
         v2:=sqrt(sqrt(sqr(dcp)/hcp))*v2;}
         (*******    диффракция     ********)
         v:=v2;{**** отсутствие коментария даст горбы *****}
     goto aaa;
d0: rm1:=sqrt(ha)/sq*dg;
 rm2:=sqrt(h)/sq*dg;
 u:=d/drg; dr:=2*ha*h*sqr(1.0-u*u)/u/drg;
 gam:=q[29]*dr;
 ccc:=gam;
 u:=dg/drg;u:=(1-u*u)/u;
 u:=u*(ha+h)/drg;
 ksi:=arctan(u/sqrt(1.0-sqr(u)));
 {**************************************************************}
 if ppol=1 then begin
    k:=sin(ksi)+sqrt(eps-sqr(cos(ksi)));
    k:=(-sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
 end;
 if ppol=2 then begin
    k:=eps*sin(ksi)+sqrt(eps-sqr(cos(ksi)));
    k:=(-eps*sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
 end;
 ddd:=k;
 k:=1;
 {**************************************************************}
 if (u>ll/(5*q[14])) then begin v:=1; goto aaa; end;
  c1:=k*exp(-8.0*sqr(q[26]*sin(ksi)));
  u:=re*cos(ksi)/(re+ha);
  yb:=arctan(u/sqrt(1.0-sqr(u)));
  fo:=-(pi/2-yb);
 u:=d/drg;   dr:=u/(1-u*u);
 if h>ha then h2:=ha/h else h2:=h/ha;
 d1:=1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(h2))/(sqr(1+h2)*(1+h2)));
    ffp:=DN(el1,e,sdn1);
    ffo:=DN(el1,fo,sdn1);{ ffp:=1; ffo:=1;}
    if ffp<0.0001 then mm:=0 else  mm:=c1*d1*(ffo/ffp);
        if (2.0*mm*cos(gam)-sqr(mm))>1 then
      v:=1.0e-3
    else
      v:=sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));
    if (d<=rum) then begin v2:=v;
    end;
      if (e<ll/4/ha) then begin
         v2:=v;
      end;
  if (ind=0) then begin
  mv4:=v;d:=drum;end;
 aaa:
 sss:=drg; ggg:=rum;ccc:=mv4;
 end;

{---------------------------------------------------------------------------}
           function DN_SINB;
       var
           sdngr,d_l,delta,x,y:real;
       begin
             sdngr:=sdn*180/pi;    (* перевод из радиан в градусы *)
             ymc:=ymc*180/pi;
             yml:=yml*180/pi;
             delta:=(yml-ymc)/sdngr;
             if ABS(delta)<1e-8 then
                 DN_SINb:=1
                 else

                 begin
                 x:=2.7831*delta;
                 y:=sin(x)/x;
                 DN_SINb:=abs(y);
               end;
       end;

      function DN_SING;
       var
           sdngr,d_l,delta,x,y:real;
       label
            k1;
       begin
           sdngr:=sdn*180/pi;
           d_l:=50.8/sdngr;
           delta:=ABS(ymc-yml);
           if delta<1e-8 then
             begin
                 DN_SING:=1;goto k1;
             end;
               if delta<=sdn then
                begin
                 x:=pi*d_l*(sin(yml)-sin(ymc));
                 y:=sin(x)/x;
                 DN_SING:=abs(y)
                 end
                 else
                 if (delta<=2.2*sdn) and (delta>sdn)
                   then
                      dn_sinG:=pwr(10,-1.25)
                   else
                      dn_sinG:=pwr(10,-1.5);
    k1:        end;
function DNzp_TAB;
     const

        data_DN:array[1..77] of real=
(-25.0,-24.3,-24.1,-23.5,-22.6,-22.2,-23.2,-26.9,-27.4,
 -18.7,-13.1,-9.2,-6.3,-4.2,-2.7,-1.6,-0.8,-0.3,
 -0.1,0,0,-0.2,-0.4,-0.8,-1.3,-2.0,-2.8,
 -3.8,-4.9,-5.9,-6.8,-7.6,-8.3,-9.0,-9.6,-10.4,
 -11.1,-11.7,-12.0,-12.2,-12.1,-12.0,-11.9,-12.0,-12.1,
 -12.3,-12.5,-12.5,-12.3,-12.0,-11.8,-11.7,-11.8,-12.0,
 -12.3,-12.6,-12.8,-12.8,-12.8,-12.7,-12.6,- 12.7,-12.8,
 -13.0,-13.2,-14.2,-15.2,-16.2,-17.7,-19.6,-21.7,-23.8,
 -25.9,-28.0,-30.0,-34.6,-37.9 );
       data_ym:array[1..77] of real=
(-3.9,-3.6,-3.2,-2.8,-2.5,-2.1,-1.8,-1.4,-1.1,
 -0.7,-0.4,0,0.4,0.7,1.1,1.4,1.8,2.1,
 2.5,2.8,3.2,3.6,3.9,4.3,4.6,5.0,5.3,
 5.7,6.1,6.4,6.8,7.1,7.5,7.9,8.2,8.6,
 8.9,9.3,9.7,10.0,10.4,10.7,11.1,11.5,11.8,
 12.2,12.6,12.9,13.3,13.6,14.0,14.4,14.8,15.1,
 15.5,15.9,16.2,16.6,17.0,17.3,17.7,18.1,18.5,
 18.8,21.9,25.4,30.6,31.0,31.4,31.9,32.3,32.7,
 33.1,33.6,34.0,34.4,34.8);
     type
       dt_ym=array[1..77] of real;
     var
        arrym:dt_ym;
        delta,a,b,y:real;

        i:byte;
        label k1;
      begin
        for i:=1 to 77 do arrym[i]:=data_ym[i]*pi/180;
            if ymc<arrym[1] then
             begin
             y:=arrym[1];goto k1;
             end;
            if ymc>arrym[77] then
             begin
             y:=arrym[77];goto k1;
             end;
        delta:=ymc;
        for i:=1 to 76 do
          begin
            if (delta>=arrym[i]) and (delta<=arrym[i+1]) then
              begin
                a:=(Data_dn[i+1]-Data_dn[i])/(arrym[i+1]-arrym[i]);
                b:=Data_dn[i]-arrym[i]*a;
                y:=delta*a+b;
              end;
            end;

k1:          DNzp_tab:=pwr(10,y/20)
      end;
function DN_UNTEN;
     const
        data_YM:array[1..44] of real=
(-5.0,-4.0,-3.0,-2.0,-1.0, 0.0, 0.5, 1.0, 1.5, 2.0, 2.5,
  3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0,
  8.5, 9.0, 9.5,10.0,10.5,11.0,11.5,12.0,12.5,13.0,13.5,
 14.0,14.5,15.0,15.5,16.0,16.5,17.0,17.5,18.0,18.5,19.0);
       data_DN:array[1..44] of real=
(24.0,27.0,31.0,17.0, 9.6, 4.4, 2.7, 1.3, 0.5, 0.2, 0.0,
  0.0, 0.0, 0.3, 0.7, 1.4, 2.0, 2.7, 3.3, 3.8, 4.6, 5.8,
  6.6, 7.4, 8.1, 9.0,10.2,11.2,11.2,11.2,11.7,12.7,13.8,
 14.0,13.8,14.3,15.3,16.8,17.2,16.9,17.3,18.4,19.6,19.4);
     type
       dt_ym=array[1..44] of real;
     var
        arrym,dt:dt_ym;
        delta,a,b,y:real;

        i:byte;
        label k1;
      begin
        for i:=1 to 44 do arrym[i]:=data_ym[i]*pi/180;
        for i:=1 to 44 do Dt[i]:=-data_dn[i];
            if ymc<arrym[1] then
             begin
             y:=DT[1];goto k1;
             end;
            if ymc>arrym[44] then
             begin
             y:=DT[44];goto k1;
             end;
        delta:=ymc;
        for i:=1 to 43 do
          begin
            if (delta>=arrym[i]) and (delta<=arrym[i+1]) then
              begin
                a:=(Dt[i+1]-Dt[i])/(arrym[i+1]-arrym[i]);
                b:=Dt[i]-arrym[i]*a;
                y:=delta*a+b;
              end;
            end;

k1:          DN_UNTEN:=pwr(10,y/20)
      end;
function DN_OBEN;
     const
        data_YM:array[1..31] of real=
(17.0,17.5,18.0,18.5,19.0,19.5,20.0,20.5,21.0,21.5,22.0,
22.5,23.0,23.5,24.0,24.5,25.0,25.5,26.0,26.5,27.0,27.0,
28.0,28.5,29.0,29.5,30.0,30.5,31.0,31.5,32.0);
       data_DN:array[1..31] of real=
(2.8, 1.4, 0.7, 0.3, 0.0, 0.0, 0.1, 0.4, 0.9, 1.4, 2.2,
 2.7, 3.0, 3.2, 3.4, 3.6, 3.9, 4.4, 4.8, 5.2, 5.4, 5.5,
 5.7, 5.9, 6.2, 6.5, 6.7, 6.9, 7.3, 8.1, 9.5 );
     type
       dt_ym=array[1..31] of real;
     var
        arrym,dt:dt_ym;
        delta,a,b,y:real;

        i:byte;
        label k1;
      begin
        for i:=1 to 31 do arrym[i]:=data_ym[i]*pi/180;
        for i:=1 to 31 do Dt[i]:=-data_dn[i];
            if ymc<arrym[1] then
             begin
             y:=DT[1];goto k1;
             end;
            if ymc>arrym[31] then
             begin
             y:=DT[31];goto k1;
             end;
        delta:=ymc;
        for i:=1 to 30 do
          begin
            if (delta>=arrym[i]) and (delta<=arrym[i+1]) then
              begin
                a:=(Dt[i+1]-Dt[i])/(arrym[i+1]-arrym[i]);
                b:=Dt[i]-arrym[i]*a;
                y:=delta*a+b;
              end;
            end;

k1:          DN_OBEN:=pwr(10,y/20)
      end;

function DNop_MA_1;
     const

        data_DN:array[1..10] of real=
(-5.3,-8.0,-10.0,-11.0,-11.7,-12.0,-12.0,-12.0,-12.0,-12.0 );
       data_ym:array[1..10] of real=
(4,4.5,5,5.5,6,6.5,7,7.5,8,15);
     type
       dt_ym=array[1..10] of real;
     var
        arrym,dt_dn:dt_ym;
        delta,a,b,y:real;

        i:byte;
        label k1;
      begin
        for i:=1 to 10 do arrym[i]:=data_ym[i]*pi/180;
        for i:=1 to 10 do dt_dn[i]:=pwr(10,data_dn[i]/20);
        delta:=ymc;
            if delta<arrym[1] then
             begin
             y:=dn_sin(yml,ymc,sdn);goto k1;
             end;
            if delta>arrym[10] then
             begin
             y:=DT_dn[10];goto k1;
             end;
        for i:=1 to 9 do
          begin
            if (delta>=arrym[i]) and (delta<=arrym[i+1]) then
              begin
                a:=(Dt_dn[i+1]-Dt_dn[i])/(arrym[i+1]-arrym[i]);
                b:=Dt_dn[i]-arrym[i]*a;
                y:=delta*a+b;
              end;
            end;

k1:          DNop_MA_1:=y;
      end;
function DNop_MA_2;
     const

        data_DN:array[1..13] of real=
(-4.0,-5.3,-6.7,-8.5,-9.75,-10.5,-11.0,-11.3,-11.5,-11.7,-11.9,
-12.0,-12.0 );
       data_ym:array[1..13] of real=
(7.5,8,8.5,9,9.5,10,10.5,11,11.5,12,13,14,15);
     type
       dt_ym=array[1..13] of real;
     var
        arrym,dt_dn:dt_ym;
        delta,a,b,y:real;

        i:byte;
        label k1;
      begin
        for i:=1 to 13 do arrym[i]:=(data_ym[i])*pi/180;
        for i:=1 to 13 do dt_dn[i]:=pwr(10,data_dn[i]/20);
        delta:=ymc;
            if delta<arrym[1] then
             begin
             y:=dn_sin(yml,ymc,sdn);goto k1;
             end;
            if delta>arrym[13] then
             begin
             y:=DT_dn[13];goto k1;
             end;
        for i:=1 to 12 do
          begin
            if (delta>=arrym[i]) and (delta<=arrym[i+1]) then
              begin
                a:=(Dt_dn[i+1]-Dt_dn[i])/(arrym[i+1]-arrym[i]);
                b:=Dt_dn[i]-arrym[i]*a;
                y:=delta*a+b;
              end;
            end;

k1:          DNop_MA_2:=y;
      end;



function DNGO_TAB;
     const

        data_DN:array[1..233] of real=
(-50.0,-50.0,-50.0,-50.0,-50.0,-50.0,-50.0,-50.0,-50.0,
 -50.0,-50.0,-50.0,-50.0,-50.0,-50.0,-48.9,-46.3,-44.0,
 -42.0,-40.2,-38.6,-37.1,-35.7,-34.4,-33.1,-32.0,-30.9,
 -29.8,-28.8,-27.9,-27.0,-26.1,-25.3,-24.5,-23.7,-22.9,
 -22.2,-21.5,-20.8,-20.2,-19.6,-18.9,-18.4,-17.8,-17.2,
 -16.7,-16.2,-15.6,-15.1,-14.7,-14.2,-13.7,-13.3,-12.8,
 -12.4,-12.0,-11.6,-11.2,-10.8,-10.5,-10.1,- 9.8,- 9.4,
 - 9.1,- 8.7,- 8.4,- 8.1,- 7.8,- 7.5,- 7.2,- 6.9,- 6.7,
 - 6.4,- 6.1,- 5.9,- 5.6,- 5.4,- 5.2,- 4.9,- 4.7,- 4.5,
 - 4.3,- 4.1,- 3.9,- 3.7,- 3.5,- 3.3,- 3.2,- 3.0,- 2.8,
 - 2.7,- 2.5,- 2.4,- 2.2,- 2.1,- 1.9,- 1.8,- 1.7,- 1.6,
 - 1.4,- 1.3,- 1.2,- 1.1,- 1.0,- 0.9,- 0.8,- 0.8,- 0.7,
 - 0.6,- 0.5,- 0.5,- 0.4,- 0.4,- 0.3,- 0.3,- 0.2,- 0.2,
 - 0.1,- 0.1,- 0.1,- 0.1,  0.0,  0.0,  0.0,  0.0,  0.0,
   0.0,  0.0,  0.0,  0.0,- 0.1,- 0.1,- 0.1,- 0.1,- 0.2,
 - 0.2,- 0.3,- 0.3,- 0.4,- 0.4,- 0.5,- 0.5,- 0.6,- 0.7,
 - 0.8,- 0.8,- 0.9,- 1.0,- 1.1,- 1.2,- 1.3,- 1.4,- 1.6,
 - 1.7,- 1.8,- 1.9,- 2.1,- 2.2,- 2.4,- 2.5,- 2.7,- 2.8,
 - 3.0,- 3.2,- 3.3,- 3.5,- 3.7,- 3.9,- 4.1,- 4.3,- 4.5,
 - 4.7,- 4.9,- 5.2,- 5.4,- 5.6,- 5.9,- 6.1,- 6.4,- 6.7,
 - 6.9,- 7.2,- 7.5,- 7.8,- 8.1,- 8.4,- 8.7,- 9.1,- 9.4,
 - 9.8,-10.1,-10.5,-10.8,-11.2,-11.6,-12.0,-12.4,-12.8,
 -13.3,-13.7,-14.2,-14.7,-15.1,-15.6,-16.2,-16.7,-17.2,
 -17.8,-18.4,-18.9,-19.6,-20.2,-20.8,-21.5,-22.2,-22.9,
 -23.7,-24.5,-25.3,-26.1,-27.0,-27.9,-28.8,-29.8,-30.9,
 -32.0,-33.1,-34.4,-35.7,-37.1,-38.6,-40.2,-42.0);
       data_ym:array[1..233] of real=
(-58.9,-58.2,-57.5,-56.7,-56.0,-55.3,-54.6,-54.0,-53.3,
 -52.7,-52.0,-51.4,-50.8,-50.1,-49.5,-48.9,-48.3,-47.7,
 -47.2,-46.6,-46.0,-45.5,-44.9,-44.3,-43.8,-43.3,-42.7,
 -42.2,-41.7,-41.1,-40.6,-40.1,-39.6,-39.1,-38.6,-38.1,
 -37.6,-37.1,-36.6,-36.1,-35.6,-35.1,-34.7,-34.2,-33.7,
 -33.2,-32.8,-32.3,-31.8,-31.4,-30.9,-30.5,-30.0,-29.6,
 -29.1,-28.7,-28.2,-27.8,-27.3,-26.9,-26.5,-26.0,-25.6,
 -25.1,-24.7,-24.3,-23.8,-23.4,-23.0,-22.6,-22.1,-21.7,
 -21.3,-20.9,-20.5,-20.0,-19.6,-19.2,-18.8,-18.4,-18.0,
 -17.5,-17.1,-16.7,-16.3,-15.9,-15.5,-15.1,-14.7,-14.3,
 -13.9,-13.5,-13.1,-12.7,-12.3,-11.9,-11.5,-11.1,-10.7,
 -10.3,- 9.9,- 9.5,- 9.1,- 8.7,- 8.3,- 7.9,- 7.5,- 7.1,
 - 6.7,- 6.3,- 5.9,- 5.5,- 5.1,- 4.7,- 4.3,- 3.9,- 3.5,
 - 3.1,- 2.7,- 2.4,- 2.0,- 1.6,- 1.2,- 0.8,- 0.4,  0.0,
   0.4,  0.8,  1.2,  1.6,  2.0,  2.4,  2.7,  3.1,  3.5,
   3.9,  4.3,  4.7,  5.1,  5.5,  5.9,  6.3,  6.7,  7.1,
   7.5,  7.9,  8.3,  8.7,  9.1,  9.5,  9.9, 10.3, 10.7,
  11.1, 11.5, 11.9, 12.3, 12.7, 13.1, 13.5, 13.9, 14.3,
  14.7, 15.1, 15.5, 15.9, 16.3, 16.7, 17.1, 17.5, 18.0,
  18.4, 18.8, 19.2, 19.6, 20.0, 20.5, 20.9, 21.3, 21.7,
  22.1, 22.6, 23.0, 23.4, 23.8, 24.3, 24.7, 25.1, 25.6,
  26.0, 26.5, 26.9, 27.3, 27.8, 28.2, 28.7, 29.1, 29.6,
  30.0, 30.5, 30.9, 31.4, 31.8, 32.3, 32.8, 33.2, 33.7,
  34.2, 34.7, 35.1, 35.6, 36.1, 36.6, 37.1, 37.6, 38.1,
  38.6, 39.1, 39.6, 40.1, 40.6, 41.1, 41.7, 42.2, 42.7,
  43.3, 43.8, 44.3, 44.9, 45.5, 46.0, 46.6, 47.2);
     type
       dt_ym=array[1..233] of real;
     var
        arrym:dt_ym;
        delta,a,b,y:real;
        i:byte;
      begin
        for i:=1 to 233 do arrym[i]:=data_ym[i]*pi/180;
        delta:=ymc-yml;
        for i:=1 to 232 do
          begin
            if (delta>=arrym[i]) and (delta<=arrym[i+1]) then
              begin
                a:=(Data_dn[i+1]-Data_dn[i])/(arrym[i+1]-arrym[i]);
                b:=Data_dn[i]-arrym[i]*a;
                y:=delta*a+b;
              end;
            end;
          DNGO_tab:=pwr(10,y/20)
      end;


     function DN_COS;
       var
           sdngr,d_l,delta,x,y:real;
       begin
           sdngr:=sdn*180/pi;
           d_l:=50.8/sdngr;
           delta:=ABS(ymc-yml);
           if delta >sdn  then DN_COS:=-40 else
             begin
               x:=pi*d_l*sin(delta);
               y:=cos(x);
               if y<1e-8 then DN_COS:=-40 else
               DN_COS:=20*lg(y);
             end
        end;
     function DN_EXP;
       var
           delta,x:real;
       begin
           delta:=sqr(1.2/sdn*ymc);
             x:= exp(-delta);
             if x>1e-6 then  DN_exp:=x else DN_EXP:=1e-6;
        end;
     function DN_cs;
       var
           delta,x,y:real;
       begin
             x:= SQR(sin(sdn/2));
             y:= SQR(sin(ymc));
             if y<1e-8 then y:=1e-7;
              DN_CS:=x/y ;
        end;
     function COSEC;
     var
          x:real;
     begin
          if ymc<Yml+0.525*sdn then COSEC:=DN_SIN(yml,ymc,sdn)
          else
          begin
          x:=sin(yml)/sin(ymc);
          COSEC:=x;
          end;
     end;

     function DN_SIN;
       var
           sdngr,d_l,delta,x,y:real;
       label
            k1;
       begin
           sdngr:=sdn*180/pi;
           d_l:=50.8/sdngr;
           delta:=ABS(ymc-yml);
           if delta<1e-8 then
             begin
                 DN_SIN:=1;goto k1;
             end;
               if delta<=sdn then
                begin
                 x:=pi*d_l*(sin(yml)-sin(ymc));
                 y:=sin(x)/x;
                 DN_SIN:=abs(y)
                 end
                 else
                  dn_sin:=1e-6;
    k1:        end;
     function DN_SINN;
       var
           sdngr,d_l,delta,x,y:real;
       label
            k1;
       begin
           sdngr:=sdn*180/pi;
           d_l:=50.8/sdngr;
           delta:=ABS(ymc-yml);
           if delta<1e-8 then
             begin
                 DN_SINN:=1;goto k1;
             end;
                 begin
                 x:=pi*d_l*(ymc-yml);
                 y:=sin(x)/x;
                 DN_SINN:=abs(y);
               end;
    k1:        end;
     function DNZW;
       type
          arr_TAB=array[1..9] of real;
       const
           yy:arr_TAB =(-3,-5,-7,-9,-11,-12.7,-13.5,-13.8,-14);
       var
           delta,d_l,x,y,a,b,sdngr:real;
           i:byte;
           xx,ff:arr_TAB;
        label
            k1;
       begin
           sdngr:=sdn*180/pi;                      {* перевод градусов в радианы *}
           d_l:=50.8/sdngr;                        {*   размер апертуры   *}
           for i:=1 to 9 do
             begin
               ff[i]:=pwr(10,yy[i]/20);
               xx[i]:=yml+sdn/2+(i-1)*pi/180;
             end;
           delta:=ABS(ymc-yml);
           if delta<1e-8 then
             begin
                 DNZW:=1;goto k1;
             end;
          if( ymc<=yml+ sdn/2) AND ( ymc>=yml-sdn) then
             begin
                 x:=pi*d_l*(sin(yml)-sin(ymc));
                 y:=sin(x)/x;
                 DNZW:=y;goto k1;
            end;
           if ymc<yml-sdn then
             begin
                DNZW:=1e-6;goto k1;
             end;
           for i:=1 to 8 do
             begin
                if (ymc>xx[i]) AND (ymc<=xx[i+1]) then
                   begin
                      a:=(ff[i+1]-ff[i])/(xx[i+1]-xx[i]);
                      b:=ff[i]-xx[i]*a;
                      DNZW:=ymc*a+b;
                      goto k1;
                   end;
              end;
          if ymc>xx[9] then DNZW:=ff[9];
       k1:end;
     function DNZWM;
       type
          arr_TAB=array[1..7] of real;
       const
           yy:arr_TAB =(-7,-9,-11,-13,-15,-16.7,-17.6);
       var
           delta,d_l,x,y,a,b,sdngr:real;
           i:byte;
           xx:arr_TAB;
        label
            k1;
       begin
           sdngr:=sdn*180/pi;
           d_l:=50.8/sdngr;
           for i:=0 to 6 do xx[i+1]:=sdn/2+i*pi/180;
           delta:=ABS(ymc-yml);
           if ymc<=yml+sdn/2 then
             begin
                 DNZWM:=DN_COS(yml,ymc,sdn)-4;goto k1;
             end;
           if delta> xx[7] then
             begin
                DNZWM:=-18;goto k1;
             end;
           for i:=1 to 6 do
             begin
                if (delta>xx[i]) AND (delta<=xx[i+1]) then
                   begin
                      a:=(yy[i+1]-yy[i])/(xx[i+1]-xx[i]);
                      b:=yy[i]-xx[i]*a;
                      DNZWM:=delta*a+b;
                      goto k1;
                   end;
              end;
       k1:end;
     function DNZE_L1;
       type
           arr_TAB=array[1..7] of real;
       const
           yy:arr_TAB =(-3,-6,-8,-10,-11,-12.7,-13.6);
       var
           delta,d_l,x,y,a,b,sdngr:real;
           i:byte;
           xx:arr_TAB;
        label
            k1;
       begin
           sdngr:=sdn*180/pi;                      {* перевод градусов в радианы *}
           d_l:=50.8/sdngr;                        {*   размер апертуры   *}
           for i:=0 to 6 do xx[i+1]:=sdn/2+i*pi/180;
           delta:=abs(ymc-yml);
           if delta<1e-8 then
             begin
                 DNZE_L1:=0;goto k1;
             end;
           if delta<= sdn/2 then
             begin
                 x:=pi*d_l*(sin(yml)-sin(ymc));
                 y:=sin(x)/x;
                 DNZE_L1:=20*lg(y);goto k1;
             end;
           if delta> xx[7] then
             begin
                DNZE_L1:=-36;goto k1;
             end;
           for i:=1 to 6 do
             begin
                if (delta>xx[i]) AND (delta<=xx[i+1]) then
                   begin
                      a:=(yy[i+1]-yy[i])/(xx[i+1]-xx[i]);
                      b:=yy[i]-xx[i]*a;
                      DNZE_L1:=delta*a+b;
                      goto k1;
                   end;
              end;
       k1:end;

     function DNZE_L2;
       type
           arr_TAB=array[1..7] of real;
           arr_MDN=array[1..2] of real;
       const
           yy:arr_TAB =(-3,-6,-8,-10,-11,-12.7,-13.6);
       var
           delta,d_l,x,y,a,b,sdngr:real;
           i:byte;
           xx1,xx2:arr_TAB;
           mdn:arr_MDN;
        label
            k1;
       begin
           for i:=1 to 2 do mdn[i]:=yml+(i-1)*4*pi/180;
           sdngr:=sdn*180/pi;                      {* перевод градусов в радианы *}
           d_l:=50.8/sdngr;                        {*   размер апертуры   *}
           for i:=0 to 6 do xx1[i+1]:=mdn[1]-sdn/2-i*pi/180;
           for i:=0 to 6 do xx2[i+1]:=mdn[2]+sdn/2+i*pi/180;
           for i:=1 to 2 do
             begin
               delta:=abs(mdn[i]-ymc);
               if delta<1e-8 then
                   begin
                     DNZE_L2:=0;goto k1;
                   end;
               if delta<= sdn/2 then
                   begin
                      x:=pi*d_l*(sin(mdn[i])-sin(ymc));
                      y:=sin(x)/x;
                      DNZE_L2:=8.68*ln(y);goto k1;
                   end;
               end;

               if ymc> xx2[7]  then
                   begin
                     DNZE_L2:=-14;goto k1;
                   end;
                for i:=1 to 6 do
                   begin
                     if (ymc>xx2[i]) AND (ymc<=xx2[i+1]) then
                        begin
                            a:=(yy[i+1]-yy[i])/(xx2[i+1]-xx2[i]);
                            b:=yy[i]-xx2[i]*a;
                            DNZE_L2:=ymc*a+b;
                            goto k1;
                        end;
                    end;
                for i:=1 to 6 do
                   begin
                     if (ymc<xx1[i]) AND (ymc>=xx1[i+1]) then
                        begin
                            a:=(yy[i]-yy[i+1])/(xx1[i]-xx1[i+1]);
                            b:=yy[i+1]-xx1[i+1]*a;
                            DNZE_L2:=ymc*a+b;
                            goto k1;
                        end;
                    end;
       k1:end;
     function DNZE;
       type
           arr_TAB=array[1..7] of real;
           arr_MDN=array[1..8] of real;
       const
           yy:arr_TAB =(-3,-6,-8,-10,-11,-12.7,-13.6);
       var
           delta,d_l,x,y,a,b,sdngr:real;
           i:byte;
           xx1,xx2:arr_TAB;
           mdn:arr_MDN;
        label
            k1;
       begin
           for i:=1 to 8 do mdn[i]:=yml+(i-1)*4*pi/180;
           sdngr:=sdn*180/pi;                      {* перевод градусов в радианы *}
           d_l:=50.8/sdngr;                        {*   размер апертуры   *}
           for i:=0 to 6 do xx1[i+1]:=mdn[1]-sdn/2-i*pi/180;
           for i:=0 to 6 do xx2[i+1]:=mdn[8]+sdn/2+i*pi/180;
           for i:=1 to 8 do
             begin
               delta:=abs(mdn[i]-ymc);
               if delta<1e-8 then
                   begin
                     DNZE:=0;goto k1;
                   end;
               if delta<= sdn/2 then
                   begin
                      x:=pi*d_l*(sin(mdn[i])-sin(ymc));
                      y:=sin(x)/x;
                      DNZE:=8.68*ln(y);goto k1;
                   end;
               end;

               if( ymc> xx2[7]) OR (ymc<xx1[7])  then
                   begin
                     DNZE:=-14;goto k1;
                   end;
                for i:=1 to 6 do
                   begin
                     if (ymc>xx2[i]) AND (ymc<=xx2[i+1]) then
                        begin
                            a:=(yy[i+1]-yy[i])/(xx2[i+1]-xx2[i]);
                            b:=yy[i]-xx2[i]*a;
                            DNZE:=ymc*a+b;
                            goto k1;
                        end;
                    end;
                for i:=1 to 6 do
                   begin
                     if (ymc<xx1[i]) AND (ymc>=xx1[i+1]) then
                        begin
                            a:=(yy[i]-yy[i+1])/(xx1[i]-xx1[i+1]);
                            b:=yy[i+1]-xx1[i+1]*a;
                            DNZE:=ymc*a+b;
                            goto k1;
                        end;
                    end;
       k1:end;

     function DN_zp;
       var
           sdngr,d_l,delta,x,y,z:real;
       label
            k1;
       begin
           sdngr:=sdn*180/pi;
           d_l:=50.8/sdngr;
           delta:=ABS(ymc-yml);
           if delta<1e-8 then
             begin
                 DN_zp:=1;goto k1;
             end;
                 begin
                  x:=pi*d_l*(sin(yml)-sin(ymc));
                  y:=sin(x)/x;
                  y:=abs(y);
                  z:=20*lg(y);
                  if z<=-13 then DN_zp:=pwrr(10,-13,20)
                  else
                  DN_zp:=y;
                 end;
    k1:        end;
     function DNZEM;
       type
           arr_MDN=array[1..11] of real;
       var
           delta,d_l,x,y,a,b,sdngr:real;
           i:byte;
           mdn:arr_MDN;
        label
            k1;
       begin
           for i:=1 to 11 do mdn[i]:=yml+(i-1)*sdn;
           sdngr:=sdn*180/pi;                      {* перевод градусов в радианы *}
           d_l:=50.8/sdngr;                        {*   размер апертуры   *}
           for i:=1 to 11 do
             begin
               delta:=ABS(mdn[i]-ymc);
               if delta<=sdn/2 then
                 begin
                     DNZEM:=DN_SIN(mdn[i],ymc,sdn);
                     goto k1;
                 end;
              end;
            if ymc<mdn[1]-sdn/2 then
               begin
                 DNZEM:=DN_SIN(mdn[1],ymc,sdn);
                 goto k1;
               end;
            if ymc>mdn[11]+sdn/2 then
               begin
                 DNZEM:=DN_SIN(mdn[11],ymc,sdn);
                 goto k1;
               end;

       k1:end;


(****        procedure fosld;
 label w1,w2,d0;
var
 ah,c1,d1,dg,dr,ffo,ffp,fo,fp,gam,h2,h3,ha,
 ksi,l,mm,re,rm1,rm2,rz,rum,sq,u,drg,l1,dcp,
 hap,hcp,kci,mv4,yb,ll:real;
 nl,kk,ind: integer;
 k,ki,v1:real;
 flg:boolean;
begin
   flg:=true;
   nl:=40;
   re:=q[11];
   rz:=q[12];
   ha:=q[8];
   dg:=d*cos(e);
   sq:=sqrt(h)+sqrt(ha);
   drg:=4.12*(sqrt(ha*1000)+sqrt(h*1000));
   ah:=q[28];
   ll:=q[13];
   l:=q[27];
   dcp:=d/l; hap:=ha/ah; hcp:=h/ah;
   l1:=pwrr((pi*q[12]/q[13]),1,3)*(q[8]+h)*(1/d-d/sqr(drg));
   rum:=sqrt(2.0*re)*(sqrt(ha+0.56*ah)+sqrt(h+0.56*ah))-1.5*l;
   ind:=1;
                    ki:=0.55*drg;
  if (drg>=20) then ki:=0.60*drg;
  if (drg>=40) then ki:=0.71*drg;
  if (drg>=65) then ki:=0.82*drg;
  if (drg>95) then ki:=0.84*drg;
  if (drg>160) then ki:=0.90*drg;
  if (drg>200) then ki:=0.92*drg;
  if (drg>400) then ki:=0.94*drg;
  if (drg>900) then ki:=0.95*drg;

 if (d>=ki)  then
    begin ksi:=dcp-sqrt(hcp);
          mv4:=d;
          kk:=trunc((mv4-ki)/1)+1;
          d:=d-kk*1;dcp:=d/l;
          e:=sqrt(ha)/sqrt(2*re)*((hcp/hap-1)/dcp*sqrt(hap)-dcp/sqrt(hap));
          dg:=d*cos(e); ind:=0;
          goto d0;
    w1:   kk:=kk-1;
          d:=mv4-kk*1;dcp:=d/l;
          e:=sqrt(ha)/sqrt(2*re)*((hcp/hap-1)/dcp*sqrt(hap)-dcp/sqrt(hap));
          dg:=d*cos(e); if (kk=0) then ind:=1;
              if flg then begin
                     if (v>=0.95) then goto d0;
                     v1:=40*lg(v);
                     v1:=v1+10*lg(hcp);
                     v1:=v1-20*lg(dcp);
                     v1:=abs(v1);     flg:=false; end;
          ksi:=dcp-sqrt(hcp);

      if (ll<=3.5e-4) then
                v1:=v1+2+(35-ll*100000)/10.5;
      if (ll>3.5e-4)and (ll<=3.5e-3) then
                v1:=v1+1.2+(350-ll*100000)/(393+6/8) ;
      if (ll>3.5e-3) then
                v1:=v1+1.2;
         v:=pwr(10,(-v1/40));
         v:=sqrt(sqrt(sqr(dcp)/hcp))*v;

             if (v<=0.01) then  goto w2;
             if (ind=0) then goto w1;
   w2:    end {fosd}
      else begin

{** расчет по Голеву **}
d0: rm1:=sqrt(ha)/sq*dg; rm2:=sqrt(h)/sq*dg;
 h2:=ha-sqr(rm1)/(2.0*re);
 h3:=h-sqr(rm2)/(2.0*re);
     dr:=sqrt(sqr(dg)+sqr(h2+h3))-sqrt(sqr(dg)+sqr(h3-h2));
 gam:=q[29]*dr;
 u:=ha/rm1-rm1/(2.0*re);
 ksi:=arctan(u/sqrt(1.0-sqr(u)));
 k:=ppol;
 if (ppol=2) then begin
    if (ll<10.00e-5) then begin
                         k:=-10.8*ksi+1;
       if (ksi>pi/180*3.2) then k:=-5.4*ksi+0.7;
       if (ksi>pi/30) then k:=0.15;
       if (ksi>pi/180*8) then k:=1.17*ksi+0.04;
       if (ksi>pi/18) then k:=0.2;
   end;
   if(ll>=1.00e-4) and (ll<3.00e-4) then begin
                       k:=-14.3*ksi+1;
       if (ksi>pi/90) then k:=-7.4*ksi+0.76;
       if (ksi>pi/180*4) then k:=-3.14*ksi+0.48;
       if (ksi>pi/180*6) then k:=2.14*ksi-0.075;
       if (ksi>pi/18) then k:=0.3;
   end;
   if(ll>=3.00e-4) and (ll<4.50e-4) then begin
                       k:=-15*ksi+1;
       if (ksi>pi/180*2.0) then k:=-6.5*ksi+0.7;
       if (ksi>pi/180*4.4) then k:=2.08*ksi+0.4;
       if (ksi>pi/18) then k:=0.37;
   end;
   if(ll>=4.50e-4) and (ll<6.00e-4) then begin
                       k:=-15*ksi+1;
       if (ksi>pi/180*2) then k:=-6.5*ksi+0.7;
       if (ksi>pi/180*4.0) then k:=1.64*ksi+0.13;
       if (ksi>pi/18) then k:=0.42;
   end;
   if(ll>=6.00e-4) and (ll<1.00e-3) then begin
                       k:=-21*ksi+1;
       if (ksi>pi/180*1.1) then k:=-10.55*ksi+0.8;
       if (ksi>pi/180*2.0) then k:=-8*ksi+0.71;
       if (ksi>pi/180*3.0) then k:=2.1*ksi+0.18;
       if (ksi>pi/18) then k:=0.53;
   end;
   if(ll>=1.00e-3) and (ll<1.50e-3) then begin
                       k:=-22.85*ksi+1;
       if (ksi>pi/180*1.0) then k:=-11.43*ksi+0.8;
       if (ksi>pi/180*2.0) then k:=-4.3*ksi+0.5;
       if (ksi>pi/180*3.0) then k:=2.36*ksi+0.2;
       if (ksi>pi/18) then k:=0.61;
   end;
   if(ll>=1.50e-3) and (ll<3.00e-3) then begin
                       k:=-28.5*ksi+1;
       if (ksi>pi/180*0.8) then k:=-13.57*ksi+0.79;
       if (ksi>pi/180*1.7) then k:=-3.7*ksi+0.5;
       if (ksi>pi/180*2.3) then k:=2.5*ksi+0.27;
       if (ksi>pi/18) then k:=0.71;
   end;
   if(ll>=3.00e-3) then begin
                       k:=-29.4*ksi+1;
       if (ksi>pi/180) then k:=-5.7*ksi+0.6;
       if (ksi>pi/90) then k:=2.43*ksi+0.316;
       if (ksi>pi/18) then k:=0.73;
   end;
 end;
 c1:=k*exp(-8.0*sqr(q[26]*sin(ksi)));
 u:=1.0/(1.0+ha/rz)*cos(ksi);
 yb:=arctan(u/sqrt(1.0-sqr(u)));
  d1:=1.0/sqrt(1.0+2.0*rm1*rm2/(re*(rm1+rm2)*sin(ksi)));
  fo:=-(pi/2.0-yb);
    ffp:=DN(el1,e,sdn1);
    ffo:=DN_SIN(el1,fo,sdn1);ffp:=1; ffo:=1;
    mm:=c1*d1*ffo/ffp;
    if (2.0*mm*cos(gam)-sqr(mm))>1 then
      v:=1.0e-3
    else
      v:=sqrt(1.0-2.0*mm*cos(gam)+sqr(mm)); if ind=0 then goto w1;
  end;{fosl}
end; ****)


 procedure fosld;
 label w1,w2,d0,aaa;
var
 ah,c1,d1,de,dg,dr,ffo,ffp,fo,fp,gam,h2,ha,
 ksi,l,mm,r,re,rm1,rm2,rz,rum,sq,u,drg,l1,dcp,
 hap,hcp,ll,mv4,yb,zzz,sss,ccc:real;
 flg:boolean;
 nl,kk,ind: integer;
 k,ymdn,v1,eps1:real;
begin
  eps1:=5;
  flg:=true;
  nl:=40;
 re:=q[11];
 rz:=q[12];
 ha:=q[8];
 de:=q[15];
 sq:=sqrt(h)+sqrt(ha);
 drg:=4.12*(sqrt(ha*1000)+sqrt(h*1000));
 ah:=q[28];
 ll:=q[8]/q[13];
 l:=q[27];
 dcp:=d/l; hap:=ha/ah; hcp:=h/ah;
 if (abs(h-ha)>=0.95*d) then begin v:=1; goto aaa; end else begin

 dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
 {  zzz:=sqr(re+h)-sqr(dg); zzz:=sqrt(zzz)-re-ha;
   if zzz/d>0.95 then e:=pi/2 else e:=arcsin(zzz/d);}
{ l1:=pwrr((pi*q[12]/q[13]),1,3);
 l1:=l1*(q[8]+h)*(1/d-d/sqr(drg));}
 rum:=sqrt(2.0*re)*(sqrt(ha+0.56*ah)+sqrt(h+0.56*ah))-1.5*l;
   ind:=1;
{ if h<0.5 then rum:=rum*0.9;
 if h<0.2 then rum:=rum*0.85;}


 if (d>rum)  then begin
          mv4:=d;
          kk:=trunc((mv4-rum)/1)+1;
          d:=d-kk*1;dcp:=d/l;
          dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
          zzz:=sqr(re+h)-sqr(dg); zzz:=sqrt(zzz)-re-ha;
          if zzz/d>0.95 then e:=pi/2 else e:=arcsin(zzz/d);
          ind:=0;
          goto d0;
    w1:   kk:=kk-1;
          d:=mv4-kk*1;dcp:=d/l;
          dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
          zzz:=sqr(re+h)-sqr(dg); zzz:=sqrt(zzz)-re-ha;
          if zzz/d>0.95 then e:=pi/2 else e:=arcsin(zzz/d);
          if (kk=0) then ind:=1;
              if flg then begin
                     if (v>=0.95) then goto d0;
                     v1:=40*lg(v);
                     v1:=v1+10*lg(hcp);
                     v1:=v1-20*lg(dcp);
                     v1:=abs(v1);     flg:=false; end;
          ksi:=dcp-sqrt(hcp);

      if (ll<=3.5e-4) then
                v1:=v1+2+(35-ll*100000)/10.5;
      if (ll>3.5e-4)and (ll<=3.5e-3) then
                v1:=v1+1.2+(350-ll*100000)/(393+6/8) ;

         v:=pwr(10,(-v1/40));
         v:=sqrt(sqrt(sqr(dcp)/hcp))*v;
             if (v<=0.01) then  goto w2;
             if (ind=0) then goto w1;
   w2:    end {fosd}

   else begin
d0: rm1:=sqrt(ha)/sq*dg;
 rm2:=sqrt(h)/sq*dg;
{ u:=d/drg; dr:=2*ha*h*sqr(1.0-u*u)/u/drg;
 gam:=q[29]*dr;}

 { h много больше ha
 gam:=4*pi*ha*h*(1-sqr(dg)/2/q[11]/h)/ll/dg;}
 { h = ha}
{ gam:=4*pi*ha*h*sqr(1-sqr(dg)/4/q[11]/h)/ll/dg;}
 {  разные высоты
 gam:=4*pi*ha*h*(1-sqr(rm1)/2/q[11]/ha)*(1-sqr(rm2)/2/q[11]/h)/ll/dg;}


 {*******************}
     gam:=4*pi*ha*h*(1-sqr(dg)/2/q[11]/h)/ll/dg;
     sss:=gam;
{     gam:=4*pi*ha*h*(1-sqr(dg)/2/q[11]/h)/ll/dg;
     ccc:=gam;}
 { h много больше ha}
{ if ha>h then
     gam:=4*pi*ha*h*sqr(1-sqr(dg)/4/q[11]/h)/ll/dg
 else
    gam:=4*pi*ha*h*(1-sqr(dg)/2/q[11]/h)/ll/dg;}
   u:=dg/drg;u:=(1-u*u)/u;
   u:=u*(ha+h)/drg;
 if (u>1/(5*q0[14])) then begin v:=1; goto aaa; end
 else  ksi:=arctan(u/sqrt(1.0-sqr(u)));
 if ppol=1 then begin
    k:=sin(ksi)+sqrt(eps1-sqr(cos(ksi)));
    k:=(-sin(ksi)+sqrt(eps1-sqr(cos(ksi))))/k;
 end;
 if ppol=2 then begin
    k:=eps1*sin(ksi)+sqrt(eps1-sqr(cos(ksi)));
    k:=(-eps1*sin(ksi)+sqrt(eps1-sqr(cos(ksi))))/k;
{    k:=2*eps1*sin(ksi)/sqrt(eps1-1);
    k:=1-k;}
 end;

{ k:=ppol;
 if (ppol=2) then begin
    if (ll<10.00e-5) then begin
                         k:=-10.8*ksi+1;
       if (ksi>pi/180*3.2) then k:=-5.4*ksi+0.7;
       if (ksi>pi/30) then k:=0.15;
       if (ksi>pi/180*8) then k:=1.17*ksi+0.04;
       if (ksi>pi/18) then k:=0.2;
   end;
   if(ll>=1.00e-4) and (ll<3.00e-4) then begin
                       k:=-14.3*ksi+1;
       if (ksi>pi/90) then k:=-7.4*ksi+0.76;
       if (ksi>pi/180*4) then k:=-3.14*ksi+0.48;
       if (ksi>pi/180*6) then k:=2.14*ksi-0.075;
       if (ksi>pi/18) then k:=0.3;
   end;
   if(ll>=3.00e-4) and (ll<4.50e-4) then begin
                       k:=-15*ksi+1;
       if (ksi>pi/180*2.0) then k:=-6.5*ksi+0.7;
       if (ksi>pi/180*4.4) then k:=2.08*ksi+0.4;
       if (ksi>pi/18) then k:=0.37;
   end;
   if(ll>=4.50e-4) and (ll<6.00e-4) then begin
                       k:=-15*ksi+1;
       if (ksi>pi/180*2) then k:=-6.5*ksi+0.7;
       if (ksi>pi/180*4.0) then k:=1.64*ksi+0.13;
       if (ksi>pi/18) then k:=0.42;
   end;
   if(ll>=6.00e-4) and (ll<1.00e-3) then begin
                       k:=-21*ksi+1;
       if (ksi>pi/180*1.1) then k:=-10.55*ksi+0.8;
       if (ksi>pi/180*2.0) then k:=-8*ksi+0.71;
       if (ksi>pi/180*3.0) then k:=2.1*ksi+0.18;
       if (ksi>pi/18) then k:=0.53;
   end;
   if(ll>=1.00e-3) and (ll<1.50e-3) then begin
                       k:=-22.85*ksi+1;
       if (ksi>pi/180*1.0) then k:=-11.43*ksi+0.8;
       if (ksi>pi/180*2.0) then k:=-4.3*ksi+0.5;
       if (ksi>pi/180*3.0) then k:=2.36*ksi+0.2;
       if (ksi>pi/18) then k:=0.61;
   end;
   if(ll>=1.50e-3) and (ll<3.00e-3) then begin
                       k:=-28.5*ksi+1;
       if (ksi>pi/180*0.8) then k:=-13.57*ksi+0.79;
       if (ksi>pi/180*1.7) then k:=-3.7*ksi+0.5;
       if (ksi>pi/180*2.3) then k:=2.5*ksi+0.27;
       if (ksi>pi/18) then k:=0.71;
   end;
   if(ll>=3.00e-3) then begin
                       k:=-29.4*ksi+1;
       if (ksi>pi/180) then k:=-5.7*ksi+0.6;
       if (ksi>pi/90) then k:=2.43*ksi+0.316;
       if (ksi>pi/18) then k:=0.73;
   end;
 end;}
  c1:=k*exp(-8.0*sqr(q[26]*sin(ksi)));
  ko:=k;
 u:=re*cos(ksi)/(re+ha);
 yb:=arctan(u/sqrt(1.0-sqr(u)));
  fo:=-(pi/2-yb);
 u:=d/drg;   dr:=u/(1-u*u);
 if ha>h then h2:=h/ha else h2:=ha/h;
 d1:=1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(h2))/(sqr(1+h2)*(1+h2)));
    ffp:=DN(el1,e,sdn1);
    ffo:=DN(el1,fo,sdn1);
    if ffp<0.0001 then mm:=0 else  mm:=c1*d1*(ffo/ffp);
{         if ffo<0.0001 then mm:=0 else  mm:=c1*d1*(ffp/ffo);  }
    if (2.0*mm*cos(gam)-sqr(mm))>1 then
      v:=1.0e-3
    else
{      v:=sqrt(1.0-2.0*mm*cos(sss)+sqr(mm)); sss:=v;
      v:=sqrt(1.0-2.0*mm*cos(ccc)+sqr(mm)); ccc:=v;}
      v:=sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));
{    if (h<0.016 ) and (h>0.007) then
      v:=(sss+ccc)/2;
    if h<=0.007  then v:=sss;}
      if (ind=0) then goto w1;
  end;{fosl}
aaa: end;
end;
 procedure fosldn;
 label w1,w2,d0,aaa;
var
 ah,c1,d1,de,dg,dr,ffo,ffp,fo,fp,gam,h2,ha,v2,
 ksi,l,mm,r,re,rm1,rm2,rz,rum,sq,u,drg,l1,dcp,drum,ccc,ddd,ggg,sss,
 hap,hcp,ll,mv1,mv2,mv3,mv4,yb,zzz:real;
 flg:boolean;
 nl,kk: integer;
 k,ymdn,v1,eps1:real;
begin
  eps1:=80;
  flg:=true;
  nl:=40;
 re:=q[11];
 rz:=q[12];
 ha:=q[8];
 de:=q[15];
 sq:=sqrt(h)+sqrt(ha);
 drg:=4.12*(sqrt(ha*1000)+sqrt(h*1000));
 ah:=q[28];
 ll:=q[8]/q[13];
 l:=q[27];
 dcp:=d/l; hap:=ha/ah; hcp:=h/ah;
 if (abs(h-ha)>=0.95*d) then begin v:=1; goto aaa;end;
 dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
 rum:=sqrt(2.0*re)*(sqrt(ha+0.56*ah)+sqrt(h+0.56*ah))-1.5*l;

          if d<=rum then begin
          goto d0;end;
          if (d>rum) AND (ind=1) then begin
          drum:=d;
          D:=rum;ind:=0;goto D0;
          end;
      ksi:=dcp-sqrt(hcp);

         mv1:=40*lg(ggg*1000/ccc);
      mv2:={209}{218}209-mv1;mv3:=sss-ggg;
      v2:=d*mv2/mv3+mv1-ggg*mv2/mv3;
       (************  перевод в разы      ********)
    v2:= d*1000/(pwr(10,v2/40));

          ksi:=dcp-sqrt(hcp);
{             if ppol=1 then begin

      if (ksi>1.5) then v2:=280-40*sqrt(hap-0.1)-(7-ksi)*35.7;
      if (ksi<=1.5) and (ksi>1.0) then v2:=68-40*sqrt(hap-0.1)-(1-ksi)*32;
      if (ksi<=1.0) and (ksi>0.5) then v2:=68-40*sqrt(hap-0.1)-(1-ksi)*24;
      if (ksi<=0.5) then v2:=56-40*sqrt(hap-0.1)-(0.5-ksi)*20;
   end;
   if ppol=2 then begin

      if (ksi<=0.75)  then v2:=4-2*hap+(ksi-0.5)*8;
      if (ksi>0.75) and (ksi<=1.0)  then v2:=7-2.5*hap+(ksi-0.75)*11;
      if (ksi>1.0) and (ksi<=1.25)  then v2:=10-3*hap+(ksi-1)*12;
      if (ksi>1.25) and (ksi<=1.75)  then v2:=13.5-3.3*hap+(ksi-1.25)*14;
      if (ksi>1.75) and (ksi<=2.0)  then v2:=21-4.1*hap+(ksi-1.75)*16;
      if (ksi>2.0)   then v2:=25-4.25*hap+(ksi-2)*15.4;
   end;
         v2:=pwr(10,(-v2/40));
         v2:=sqrt(sqrt(sqr(dcp)/hcp))*v2;}
         v:=v2;{**** отсутствие коментария даст горбы *****}


goto aaa;
d0: rm1:=sqrt(ha)/sq*dg;
 rm2:=sqrt(h)/sq*dg;
 {*******************}
     gam:=4*pi*ha*h*(1-sqr(dg)/2/q[11]/h)/ll/dg;
{     sss:=gam;}
   u:=dg/drg;u:=(1-u*u)/u;
   u:=u*(ha+h)/drg;
 if (u>1/(5*q0[14])) then begin v:=1; goto aaa; end
 else  ksi:=arctan(u/sqrt(1.0-sqr(u)));
 if ppol=1 then begin
    k:=sin(ksi)+sqrt(eps1-sqr(cos(ksi)));
    k:=(-sin(ksi)+sqrt(eps1-sqr(cos(ksi))))/k;
 end;
 if ppol=2 then begin
    k:=eps1*sin(ksi)+sqrt(eps1-sqr(cos(ksi)));
    k:=(-eps1*sin(ksi)+sqrt(eps1-sqr(cos(ksi))))/k;
 end;
  c1:=k*exp(-8.0*sqr(q[26]*sin(ksi)));
  ko:=k;
 u:=re*cos(ksi)/(re+ha);
 yb:=arctan(u/sqrt(1.0-sqr(u)));
  fo:=-(pi/2-yb);
 u:=d/drg;   dr:=u/(1-u*u);
 if ha>h then h2:=h/ha else h2:=ha/h;
 d1:=1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(h2))/(sqr(1+h2)*(1+h2)));
    ffp:=DN(el1,e,sdn1);
    ffo:=DN(el1,fo,sdn1);
    if ffp<0.0001 then mm:=0 else  mm:=c1*d1*(ffo/ffp);
    if (2.0*mm*cos(gam)-sqr(mm))>1 then
      v:=1.0e-3
    else
      v:=sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));
  if (ind=0) then begin
  mv4:=v;d:=drum;end;
 aaa:
 sss:=drg; ggg:=rum;ccc:=mv4;
 end;
  procedure foid;
 label d0,aaa;
var
 ah,c1,d1,mv1,mv2,mv3,de,dg,dr,ffo,ffp,fo,fp,gam,h2,ha,ki,
 ksi,l,mm,r,re,rm1,rm2,rz,drum,rum,u,drg,l1,dcp,
 hap,hcp,ll,mv4,yb,zzz,e,h3,sq:real;
 k,ymdn,ymn,v1:real;
begin
 re:=q[11];
 rz:=q[12];
 ha:=q[8];
 sq:=sqrt(h)+sqrt(ha);{  drg:=4.12*(sqrt(ha*1000)+sqrt(h*1000));}
 drg:=sqrt(2*re)*(sqrt(ha)+sqrt(h));
 ah:=q[28];
 ll:=q[13];
 l:=q[27];
 dcp:=d/l; hap:=ha/ah; hcp:=h/ah;
 if (abs(h-ha)>=0.95*d) then begin v:=1; goto aaa; end;
 dg:=sqrt(sqr(re+h)-sqr((sqr(re+h)-sqr(d))/2/(re+ha)+(re+ha)/2));
   zzz:=sqr(re+h)-sqr(dg); zzz:=sqrt(zzz)-re-ha;
   if zzz/d>0.95 then e:=pi/2 else e:=arcsin(zzz/d);
 l1:=pwrr((pi*q[11]/q[13]),1,3)*(q[8]+h)*(1/d-d/sqr(drg));
 rum:=sqrt(2.0*re)*(sqrt(ha+0.56*ah)+sqrt(h+0.56*ah))-1.5*l;
 rm1:=sqrt(ha)/sq*dg;
 rm2:=sqrt(h)/sq*dg;
 u:=rum/drg; dr:=2*ha*h*sqr(1.0-u*u)/u/drg;
 gam:=q[29]*dr;
 ccc:=gam;
 u:=dg/drg;u:=(1-u*u)/u;
 u:=u*(ha+h)/drg;
 ksi:=arctan(u/sqrt(1.0-sqr(u)));

 {**************************************************************}
 if ppol=1 then begin
    k:=sin(ksi)+sqrt(eps-sqr(cos(ksi)));
    k:=(-sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
 end;
 if ppol=2 then begin
    k:=eps*sin(ksi)+sqrt(eps-sqr(cos(ksi)));
    k:=(-eps*sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
 end;
 {**************************************************************}
 if (u>ll/(5*q[14])) then begin v:=1; goto aaa; end;
  c1:=k*exp(-8.0*sqr(q[26]*sin(ksi)));
  u:=re*cos(ksi)/(re+ha);
  yb:=arctan(u/sqrt(1.0-sqr(u)));
  fo:=-(pi/2-yb);
 u:=rum/drg;   dr:=u/(1-u*u);
 if h>ha then h2:=ha/h else h2:=h/ha;
 d1:=1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(h2))/(sqr(1+h2)*(1+h2)));
    ffp:=DN(el1,e,sdn1);   ffp:=1;
    ffo:=DN(el1,fo,sdn1);  ffo:=1;
    if ffp<0.0001 then mm:=0 else  mm:=c1*d1*(ffo/ffp);
        if (2.0*mm*cos(gam)-sqr(mm))>1 then
      v:=1.0e-3
    else
      v:=sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));
       mv4:=v;sss:=drg; ggg:=rum;ccc:=mv4;
          if d<=rum then
          goto d0 else
  begin
      ksi:=dcp-sqrt(hcp);
         mv1:=40*lg(ggg*1000/ccc);
      mv2:={209}212-mv1;mv3:=sss-ggg;
      v2:=d*mv2/mv3+mv1-ggg*mv2/mv3;
       (************  перевод в разы      ********)
    v2:= d*1000/(pwr(10,v2/40));

         (*******    диффракция     ********)
         v:=v2;
  end;{**** отсутствие коментария даст горбы *****}
     goto aaa;
d0: rm1:=sqrt(ha)/sq*dg;
 rm2:=sqrt(h)/sq*dg;
 u:=d/drg; dr:=2*ha*h*sqr(1.0-u*u)/u/drg;
 gam:=q[29]*dr;
 ccc:=gam;
 u:=dg/drg;u:=(1-u*u)/u;
 u:=u*(ha+h)/drg;
 ksi:=arctan(u/sqrt(1.0-sqr(u)));

 {**************************************************************}
 if ppol=1 then begin
    k:=sin(ksi)+sqrt(eps-sqr(cos(ksi)));
    k:=(-sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
 end;
 if ppol=2 then begin
    k:=eps*sin(ksi)+sqrt(eps-sqr(cos(ksi)));
    k:=(-eps*sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
 end;
 {**************************************************************}
 if (u>ll/(5*q[14])) then begin v:=1; goto aaa; end;
  c1:=k*exp(-8.0*sqr(q[26]*sin(ksi)));
  u:=re*cos(ksi)/(re+ha);
  yb:=arctan(u/sqrt(1.0-sqr(u)));
  fo:=-(pi/2-yb);
 u:=d/drg;   dr:=u/(1-u*u);
 if h>ha then h2:=ha/h else h2:=h/ha;
 d1:=1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(h2))/(sqr(1+h2)*(1+h2)));
    ffp:=DN(el1,e,sdn1); ffp:=1;
    ffo:=DN(el1,fo,sdn1); ffo:=1;
    if ffp<0.0001 then mm:=0 else  mm:=c1*d1*(ffo/ffp);
        if (2.0*mm*cos(gam)-sqr(mm))>1 then
      v:=1.0e-3
    else
      v:=sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));
 aaa:
 end;

END.
