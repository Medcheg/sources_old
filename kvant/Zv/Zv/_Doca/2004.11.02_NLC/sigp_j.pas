unit sigp_J;
interface
uses
  glob_2,matfun;
type
  FDN=function(yml,ymc,sdn:real):real;

var
  zlg1,sdnp1,zlw1,sdnym1,pelp1,hp1,dist1,
  zlg2,sdnp2,zlw2,sdnym2,pelp2,hp2,dist2:real;

  procedure foid(d,h,el,sdn,ppol,eps:real;var v:real;DN:FDN);
  function DN_SIN(yml,ymc,sdn:real):real;
  function DN_SINN(yml,ymc,sdn:real):real;
  function DN_SINb(yml,ymc,sdn:real):real;
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
implementation

//===================================================================
function DN_SINB;
var
   sdngr,d_l,delta,x,y:real;
begin
   sdngr := sdn*180/pi;    (* перевод из радиан в градусы *)
   ymc := ymc*180/pi;
   yml := yml*180/pi;
   delta := (yml-ymc)/sdngr;
   if ABS(delta)<1e-8 then DN_SINb := 1
                      else begin
                         x := 2.7831*delta;
                         y := sin(x)/x;
                         DN_SINb := abs(y);
                      end;
end;
//===================================================================
function DN_SIN;
var
   sdngr,d_l,delta,x,y:real;
label
   k1;
begin
   sdngr := sdn*180/pi;
   d_l := 50.8/sdngr;
   delta := ABS(ymc-yml);
   if delta<1e-8 then begin
      DN_SIN := 1; goto k1;
   end;

   if delta<=sdn then begin
      x := pi*d_l*(sin(yml)-sin(ymc));
      y := sin(x)/x;
      DN_SIN := abs(y)
   end else dn_sin := 1e-6;
k1:
end;
//===================================================================
function DN_SINN;
var
   sdngr,d_l,delta,x,y:real;
label
   k1;
begin
   sdngr := sdn*180/pi;
   d_l := 50.8/sdngr;
   delta := ABS(ymc-yml);
   if delta<1e-8 then begin
      DN_SINN := 1;
      goto k1;
   end; begin
      x := pi*d_l*(ymc-yml);
      y := sin(x)/x;
      DN_SINN := abs(y);
   end;
k1:
end;
//===================================================================
procedure foid;
 label d0,aaa;
var
 ah,c1,d1,mv1,mv2,mv3,de,dg,dr,ffo,ffp,fo,fp,gam,h2,
 ksi,_EL_,mm,r,re,rz,drum,rum,u,drg,dcp,
 hap,hcp,LeLe,mv4,yb,zzz,e,h3,sq    : real;
 k,ymdn,ymn,v1,v2,sss,ddd,ccc,ggg   : real;

// EL_1,rm1,rm2 : real;
begin
     re   := q0[11];
     rz   := q0[12];
     ah   := q0[28];
     LeLe := q0[13];
     _EL_ := q0[27];
     hap  := q0[8]/ah;

     drg  := sqrt(2*re)*(sqrt(q0[8])+sqrt(abs(h)));
     sq   := sqrt(abs(h))+sqrt(q0[8]);
     dcp  := d/_EL_;
     hcp  := h/ah;

     if (abs(h-q0[8])>=0.95*d) then begin
         v := 1;
         goto aaa;
     end;

     if h>d then begin
         v := 1;
         goto aaa;
     end;

     dg  := sqrt(sqr(re+h) - sqr((sqr(re+h)-sqr(d))/2/(re+q0[8])+(re+q0[8])/2) );
     zzz := sqr(re+h)-sqr(dg);
     zzz := sqrt(zzz)-re-q0[8];
     if zzz/d>0.95 then e := pi/2
                   else e := arcsin(zzz/d);

     //EL_1 := pwrr((pi*q0[11]/q0[13]),1,3)*(q0[8]+h)*(1/d-d/sqr(drg));
     rum  := sqrt(2.0*re)*(sqrt(q0[8]+0.56*ah)+sqrt(abs(h+0.56*ah)))-1.5*_EL_;
     //rm1  := sqrt(q0[8])/sq*dg;
     //rm2  := sqrt(h)/sq*dg;
     u    := rum/drg;
     dr   := 2*q0[8]*h*sqr(1.0-u*u)/u/drg;
     gam  := q0[29]*dr;
     ccc  := gam;
     u    := dg/drg;
     u    := (1-u*u)/u;
     u    := u*(q0[8]+h)/drg;

     if u>=1 then begin
        v := 1;
        goto aaa;
     end;

     ksi := arctan(u/sqrt(1.0-sqr(u)));

     {**************************************************************}
     if ppol=1 then begin
        k := sin(ksi)+sqrt(eps-sqr(cos(ksi)));
        k := (-sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
     end;

     if ppol=2 then begin
        k := eps*sin(ksi)+sqrt(eps-sqr(cos(ksi)));
        k := (-eps*sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
     end;
     {**************************************************************}

     if (u>LeLe/(5*q0[14])) then begin
        v := 1;
        goto aaa;
     end;
     c1 := k*exp(-8.0*sqr(q0[26]*sin(ksi)));
     u  := re*cos(ksi)/(re+q0[8]);
     yb := arctan(u/sqrt(1.0-sqr(u)));
     fo := -(pi/2-yb);
     u  := rum/drg;
     dr := u/(1-u*u);

     if h>q0[8] then h2 := q0[8]/h
                else h2 := h/q0[8];

     d1  := 1.0/sqrt(abs(1.0+dr*4*h2*sqr(1+sqrt(abs(h2))))/(abs(sqr(abs(1+h2))*(1+h2))));
     ffp := DN(el,e,sdn);
     ffo := DN(el,fo,sdn);

     if ffp<0.0001 then mm := 0
                   else mm := c1*d1*(ffo/ffp);

     if (2.0*mm*cos(gam)-sqr(mm))>1 then v := 1.0e-3
                                    else v := sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));

     mv4 := v;
     sss := drg;
     ggg := rum;
     ccc := mv4;

     if d<=rum then goto d0
               else begin
                  ksi := dcp-sqrt(abs(hcp));
                  mv1 := 40*lg(ggg*1000/ccc);

                  if LeLe < 0.1e-3  then mv2 := 222-mv1;
                  if LeLe < 0.03e-3 then mv2 := 209-mv1;
                  if LeLe < 0.01e-3 then mv2 := 203-mv1;

                  mv3 := sss-ggg;
                  v2  := d*mv2/mv3+mv1-ggg*mv2/mv3;
           (************  перевод в разы      ********)
                  v2  :=  d*1000/(pwr(10,v2/40));
             (*******    диффракция     ********)
                  v := v2;
     end;{**** отсутствие коментария даст горбы *****}

     goto aaa;

d0:  //rm1 := sqrt(q0[8])/sq*dg;
     //rm2 := sqrt(h)/sq*dg;
     u   := d/drg;
     dr  := 2*q0[8]*h*sqr(1.0-u*u)/u/drg;
     gam := q0[29]*dr;
     ccc := gam;
     u   := dg/drg;
     u   := (1-u*u)/u;
     u   := u*(q0[8]+h)/drg;
     ksi := arctan(u/sqrt(1.0-sqr(u)));

     {**************************************************************}
     if ppol=1 then begin
        k := sin(ksi)+sqrt(eps-sqr(cos(ksi)));
        k := (-sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
     end;
     if ppol=2 then begin
        k := eps*sin(ksi)+sqrt(eps-sqr(cos(ksi)));
        k := (-eps*sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
     end;

     {**************************************************************}
     if (u>LeLe/(5*q0[14])) then begin
         v := 1;
         goto aaa;
     end;
     c1 := k*exp(-8.0*sqr(q0[26]*sin(ksi)));
     u  := re*cos(ksi)/(re+q0[8]);
     yb := arctan(u/sqrt(1.0-sqr(u)));
     fo := -(pi/2-yb);
     u  := d/drg;
     dr := u/(1-u*u);

     if h>q0[8] then h2 := q0[8]/h
                else h2 := h/q0[8];

     d1  := 1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(abs(h2)))/(sqr(1+h2)*(1+h2)));
     ffp := DN(el,e,sdn);
     ffo := DN(el,fo,sdn);
     if ffp<0.0001 then mm := 0
                   else  mm := c1*d1*(ffo/ffp);
     if (2.0*mm*cos(gam)-sqr(mm))>1 then v := 1.0e-3
                                    else v := sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));
aaa:
     end;
end.
