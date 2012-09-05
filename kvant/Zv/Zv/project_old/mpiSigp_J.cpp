//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "mpiSigp_J.h"
#include "mpiMatFun.h"
//===========================================================================
#pragma package(smart_init)
//===========================================================================
//===========================================================================
//===========================================================================
void foid(TFloat d, TFloat h, TFloat el, TFloat sdn, TFloat ppol, TFloat eps, TFloat &v, TFDN DN)
{
     TFloat drg, ah, aaaaaaaaaa, ll, dcp, hcp, dg, zzz, rum, u, dr, gam, ccc, yb, fo, e, k, c1, d1, h2, ffp, ffo, mm, mv4, sss, ggg, mv1, mv2, mv3, v2;
//     TFloat sq, l1, hap, rm1, rm2;

     //sq  = sqrt(h)+sqrt((Ha + DeltaHa)); // {  drg = 4.12*(sqrt((Ha + DeltaHa)*1000)+sqrt(h*1000));}
     drg = sqrt(2*ZvData.Re) * (sqrt((ZvData.Ha + DeltaHa))+sqrt(h));
     ah  = q0[28];
     //ll  = Lambda;
     aaaaaaaaaa   = q0[27];
     dcp = d / aaaaaaaaaa;
     //hap = (ZvData.Ha + DeltaHa) / ah;
     hcp = h / ah;

     if (fabs(h - (ZvData.Ha + DeltaHa)) >= 0.95*d) { v = 1; return;}
     if (h             >       d) { v = 1; return;}

     dg  = sqrt(sqr(ZvData.Re+h)-sqr((sqr(ZvData.Re+h)-sqr(d)) /2.0 / (ZvData.Re + (ZvData.Ha + DeltaHa))+(ZvData.Re + (ZvData.Ha + DeltaHa)) / 2.0));
     zzz = sqr(ZvData.Re+h)-sqr(dg); zzz = sqrt(zzz) - ZvData.Re - (ZvData.Ha + DeltaHa);

     if (zzz / d > 0.95) e = pi / 2.0; else e = _ArcSin_(zzz / d);

     //l1     = pwrr((pi*ZvData.Re/Lambda),1,3)*((ZvData.Ha + DeltaHa) + h)*(1/d-d/sqr(drg));
     rum    =  sqrt(2.0*ZvData.Re)*(sqrt((ZvData.Ha + DeltaHa) + 0.56*ah)+sqrt(h+0.56*ah))-1.5 * aaaaaaaaaa;
     //rm1    = sqrt((ZvData.Ha + DeltaHa))/sq*dg;
     //rm2    = sqrt(h)/sq*dg;
     u      = rum/drg;
     dr     = 2*(ZvData.Ha + DeltaHa)*h*sqr(1.0-u*u) / u / drg;
     gam    = q0[29] * dr;
     ccc    = gam;
     u      = dg / drg;
     u      = (1 - u*u)/u;
     u      = u * ((ZvData.Ha + DeltaHa) + h) / drg;
     if (u >= 1){ v = 1; return;}
     ksi = ArcTan2(u, sqrt(fabs(1.0-sqr(u))));

   // ----------------------------------------------------------------
     if (ppol == 1) {
        k =   sin(ksi) + sqrt(eps - sqr(cos(ksi)));
        k = (-sin(ksi) + sqrt(eps - sqr(cos(ksi)))) / k;
     }
     if (ppol == 2) {
        k =   eps*sin(ksi) + sqrt(eps - sqr(cos(ksi)));
        k = (-eps*sin(ksi) + sqrt(eps - sqr(cos(ksi)))) / k;
     }

   // ----------------------------------------------------------------

     if (u > ZvData.Lambda / (5 * WorkSeaSurfaceShum) ) { v = 1; return;}
     c1 = k*exp(-8.0*sqr(q0[26]*sin(ksi)));
     u  = ZvData.Re*cos(ksi)/(ZvData.Re + (ZvData.Ha + DeltaHa));
     yb = ArcTan2(u, sqrt(1.0-sqr(u)));
     fo = -(pi/2.0-yb);
     u  = rum/drg;
     dr = u/(1-u*u);

     if (h > (ZvData.Ha + DeltaHa)) h2 = (ZvData.Ha + DeltaHa) / h; else h2 = h / (ZvData.Ha + DeltaHa);
     d1 = 1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(h2))/(sqr(1+h2)*(1+h2)));
     ffp = DN(el,e,sdn);
     ffo = DN(el,fo,sdn);

     if (ffp < 0.0001) mm = 0; mm = c1*d1*(ffo/ffp);
     if ((2.0*mm*cos(gam)-sqr(mm)) > 1) v = 1.0e-3; else v = sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));

     mv4 = v;
     sss = drg;
     ggg = rum;
     ccc = mv4;

     if (d > rum) {
          ksi = dcp-sqrt(hcp);
          mv1 = 40*log10(ggg*1000/ccc);

          mv2 = 208-mv1;
          mv3 = sss-ggg;
          v2 = d*mv2/mv3+mv1-ggg*mv2/mv3;

           //(************  перевод в разы      ********)
           v2 = d*1000/(Power(10,v2/40));

           // (*******    диффракция     ********)
           v = v2;
           return;
     }
     //rm1 = sqrt((ZvData.Ha + DeltaHa)) / sq * dg;
     //rm2 = sqrt(h)     / sq * dg;
     u   = d/drg;
     dr  = 2*(ZvData.Ha + DeltaHa)*h*sqr(1.0-u*u)/u/drg;
     gam = q0[29] * dr;
     ccc = gam;
     u   = dg/drg;
     u   = (1-u*u)/u;
     u   = u*((ZvData.Ha + DeltaHa)+h)/drg;
     ksi = ArcTan2(u, sqrt(1.0-sqr(u)));

   // ----------------------------------------------------------------
     if (ppol == 1) {
        k = sin(ksi)+sqrt(eps-sqr(cos(ksi)));
        k = (-sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
     }
     if (ppol == 2) {
        k = eps*sin(ksi)+sqrt(eps-sqr(cos(ksi)));
        k = (-eps*sin(ksi)+sqrt(eps-sqr(cos(ksi))))/k;
     }
   // ----------------------------------------------------------------
     if (u > ZvData.Lambda / (5 * WorkSeaSurfaceShum)) { v = 1; return; }

     c1 = k*exp(-8.0*sqr(q0[26]*sin(ksi)));
     u  = ZvData.Re*cos(ksi)/(ZvData.Re+(ZvData.Ha + DeltaHa));
     yb = ArcTan2(u, sqrt(1.0-sqr(u)));
     fo = -(pi/2.0 - yb);
     u  = d/drg;
     dr = u/(1-u*u);

     h2 = (h > (ZvData.Ha + DeltaHa))? (ZvData.Ha + DeltaHa)/h:h/(ZvData.Ha + DeltaHa);

     d1  = 1.0/sqrt(1.0+dr*4*h2*sqr(1+sqrt(h2))/(sqr(1+h2)*(1+h2)));
     ffp = DN(el,e,sdn);
     ffo = DN(el,fo,sdn);
     mm  = (ffp < 0.0001)? 0:c1*d1*(ffo/ffp);
     v   = ((2.0*mm*cos(gam)-sqr(mm)) > 1)? 1.0e-3 : sqrt(1.0-2.0*mm*cos(gam)+sqr(mm));
}
//===========================================================================
//===========================================================================
//===========================================================================
TFloat DN_SINb(TFloat yml, TFloat ymc, TFloat sdn)
{
     TFloat sdngr, d_l, delta, x, y;

       sdngr = sdn * _180_del_pi;   // (* перевод из радиан в градусы *)
       ymc   = ymc * _180_del_pi;
       yml   = yml * _180_del_pi;
       delta = (yml-ymc) / sdngr;
       if (fabs(delta)<1e-8) return 1;
          else {
             x = 2.7831 * delta;
             y = sin(x) / x;
             return fabs(y);
          }
}
//===========================================================================
//===========================================================================
//===========================================================================
TFloat PPO(TFloat az, TData sn, TData pp)
{
      TFloat a, b, y;
   // ------------
      if (az < sn[1 ]) y = pp[1];
      if (az > sn[50]) y = pp[50];
   // ------------
      for (int i = 1; i < 50 + 1; i ++)
          if (fabs(az-sn[i]) < 1E-6) y = pp[i];

   // ------------
      for (int i = 1; i < 50+1; i ++)
            if (az > sn[i] && az <= sn[i+1])
                if (pp[i+1] == pp[i]) y = pp[i];
                    else {
                        a = (pp[i+1]-pp[i])/(sn[i+1]-sn[i]);
                        b = pp[i]-sn[i]*a;
                        y = az*a+b;
                    }
   // ------------
      return y;
}
//===========================================================================
//===========================================================================
//===========================================================================
/*
unit sigp_J;
INTERFACE
uses
   glob_2,matfun;
type
   FDN    = function(yml,ymc,sdn:real):real;
   Massiv = array[1..50] of Extended;
var
    zlg1,sdnp1,zlw1,sdnym1,pelp1,hp1,dist1,
    zlg2,sdnp2,zlw2,sdnym2,pelp2,hp2,dist2:real;
function DN_SIN (yml,ymc,sdn:real):real;
function DN_SINN(yml,ymc,sdn:real):real;
procedure SSig_F(zlg,sdnp,pelc,zlw,sdnym,ymc,dist:real;trans_reg:byte;var S_N:real);
procedure SSig_K(zlg,sdnp,pelc,zlw,sdnym,ymc,dist:real;trans_reg:byte;var S_N:real);
procedure Spom_F(zlg,sdnp,pelc,zlw,sdnym,ymc,hp,dist:real;trans_reg:byte;var S_N:real);
procedure Spom_K(zlg,sdnp,pelc,zlw,sdnym,ymc,hp,dist:real;trans_reg:byte;var S_N:real);
procedure Spom_XIP(zlg,sdnp,pelc,zlw,sdnym,ymc,hp,dist:real;trans_reg:byte;var S_N:real);
function DNaz_TAB_1(yml,az,sdn:real):real;
function DNaz_SUM(yml,az,sdn:real):real;
function DNaz_TAB_2(yml,az,sdn:real):real;
function DNym_TAB(yml,ymc,sdn:real):real;
function DNym_TAB0(yml,ymc,sdn:real):real;
function DNaz_Part_1(yml,az,sdn:real):real;
function DNaz_Part_2(yml,az,sdn:real):real;
IMPLEMENTATION


function DNaz_TAB_1;
     const
        data_DN:array[1..72] of real=
(0.93,0.9,0.82,0.77,0.71,0.65,0.61,0.56,0.53,0.51,0.51,0.53,0.575,
 0.61,0.68,0.75,0.82,0.86,0.88,0.86,0.82,0.75,0.68,0.58,0.56,0.54,
 0.54,0.55,0.575,0.605,0.67,0.78,0.97,0.95,0.9,0.9,0.94,0.94,0.91,
 0.75,0.63,0.66,0.7,0.71,0.7,0.7,0.72,0.8,0.97,0.97,0.94,0.95,0.98,
 0.995,1.0,0.995,0.98,0.88,0.78,0.72,0.65,0.59,0.56,0.54,0.56,0.58,
 0.62,0.68,0.74,0.8,0.87,0.92);
     type
       dt_yg=array[1..72] of real;
     var
        arraz:dt_yg;
        a,b,y:real;
        i:byte;
      begin
        for i = 1 to 72 do
        begin
        arraz[i] = 5*(i-1)*pi/180.0;
            if fabs(az-arraz[i])<1e-6 then y = Data_dn[i];
        }
        for i = 1 to 71 do
          begin
            if (az>arraz[i]) and (az<arraz[i+1]) then
              begin
                a = (Data_dn[i+1]-Data_dn[i])/(arraz[i+1]-arraz[i]);
                b = Data_dn[i]-arraz[i]*a;
                y = az*a+b;
              }
          }
            DNaz_tab_1 = y
      }
function DNaz_TAB_2;
     const
        data_DN:array[1..72] of real=
(0.95,0.95,0.95,0.88,0.8,0.71,0.67,0.6,0.54,0.54,0.55,0.57,0.6,0.64,
 0.695,0.79,0.88,0.92,0.94,0.89,0.81,0.71,0.605,0.51,0.465,0.42,0.42,
 0.44,0.46,0.49,0.54,0.59,0.68,0.75,0.83,0.888,0.905,0.9,0.87,0.81,
 0.77,0.71,0.68,0.67,0.67,0.67,0.68,0.74,0.79,0.83,0.885,0.92,0.98,
 0.995,0.985,0.965,0.88,0.765,0.67,0.61,0.58,0.53,0.51,0.51,0.52,0.55,
 0.605,0.7,0.78,0.83,0.88,0.92);
     type
       dt_yg=array[1..72] of real;
     var
        arraz:dt_yg;
        a,b,y:real;
        i:byte;
      begin
        for i = 1 to 72 do
        begin
        arraz[i] = 5*(i-1)*pi/180.0;
            if fabs(az-arraz[i])<1e-6 then y = Data_dn[i];
        }
        for i = 1 to 71 do
          begin
            if (az>arraz[i]) and (az<arraz[i+1]) then
              begin
                a = (Data_dn[i+1]-Data_dn[i])/(arraz[i+1]-arraz[i]);
                b = Data_dn[i]-arraz[i]*a;
                y = az*a+b;
              }
          }
            DNaz_tab_2 = y
      }
function DNym_TAB;
     const
        data_DN:array[1..55] of real=  (*** dB  ******)
(-22,-21,-20,-19,-18,-17,-16,-15,-14,-13,-12,-11,-10,
 -9,-8,-7,-6,-5,-4,-3,-2.5,-2,-1.5,-1,-0.5,
 -0.3,-0.05,0,-0.05,-0.3,-0.5,-1,-1.5,-2,-2.5,-3,-4,-5,-6,
 -7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18,-19,-20,-21,-22);
       data_ym:array[1..55] of real=   (*** degree ***)
(-2.75,-2.7,-2.65,-2.6,-2.55,-2.5,-2.45,-2.4,-2.35,-2.25,-2.15,-2.05,-2,
 -1.9,-1.8,-1.7,-1.6,-1.5,-1.3,-1.1,-1,-0.8,-0.7,-0.5,-0.25,
 0,0.25,0.35,0.6,0.8,0.95,1.15,1.25,1.35,1.5,1.6,1.8,1.95,2.1,
 2.2,2.3,2.4,2.55,2.6,2.7,2.75,2.8,2.85,2.95,3.05,3.0,3.1,3.15,3.2,3.25);
     type
       dt_yg=array[1..55] of real;
     var
        arrym:dt_yg;
        a,b,y:real;
        i:byte;
      begin
        for i = 1 to 55 do
        begin
        arrym[i] = data_ym[i]*pi/180.0;
        if fabs(ymc-arrym[i])<1e-3 then y = Data_dn[i];
        }
        if (ymc<=arrym[1]) AND (ymc>arrym[1]-sdn) then y = -25;
        if (ymc>=arrym[55]) AND (ymc<arrym[55]+sdn)  then y = -25;
        if ymc<=arrym[1]-sdn then y = -40;
        if ymc>=arrym[55]+sdn then y = -40;
        for i = 1 to 54 do
          begin
            if (ymc>arrym[i]) and (ymc<=arrym[i+1]) then
              begin
                a = (Data_dn[i+1]-Data_dn[i])/(arrym[i+1]-arrym[i]);
                b = Data_dn[i]-arrym[i]*a;
                y = ymc*a+b;
              }
          }
            DNym_tab = pwr(10,y/10.0);
      }
function DNym_TAB0;
     const
        data_DN:array[1..55] of real=  (*** dB  ******)
(-22,-21,-20,-19,-18,-17,-16,-15,-14,-13,-12,-11,-10,
 -9,-8,-7,-6,-5,-4,-3,-2.5,-2,-1.5,-1,-0.5,
 -0.3,-0.05,0,-0.05,-0.3,-0.5,-1,-1.5,-2,-2.5,-3,-4,-5,-6,
 -7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18,-19,-20,-21,-22);
       data_ym:array[1..55] of real=   (*** degree ***)
(-2.75,-2.7,-2.65,-2.6,-2.55,-2.5,-2.45,-2.4,-2.35,-2.25,-2.15,-2.05,-2,
 -1.9,-1.8,-1.7,-1.6,-1.5,-1.3,-1.1,-1,-0.8,-0.7,-0.5,-0.25,
 0,0.25,0.35,0.6,0.8,0.95,1.15,1.25,1.35,1.5,1.6,1.8,1.95,2.1,
 2.2,2.3,2.4,2.55,2.6,2.7,2.75,2.8,2.85,2.95,3.05,3.0,3.1,3.15,3.2,3.25);
     type
       dt_yg=array[1..55] of real;
     var
        arrym:dt_yg;
        a,b,y:real;
        i:byte;
      begin
        for i = 1 to 55 do
        begin
        arrym[i] = data_ym[i]*pi/180.0;
        if fabs(ymc-arrym[i])<1e-3 then y = Data_dn[i];
        }
        if (ymc<=arrym[1]) AND (ymc>arrym[1]-sdn) then
       y = -20+10*exp(-sdn*(ymc+(arrym[1]-sdn/2.0))/2.0)/ln(10);
        if (ymc>=arrym[55]) AND (ymc<arrym[55]+sdn)  then
          y = -20+10*exp(-sdn*(ymc-(arrym[55]-sdn/2.0))/2.0)/ln(10);
        if ymc<=arrym[1]-sdn then y = -40;
        if ymc>=arrym[55]+sdn then y = -40;
        for i = 1 to 54 do
          begin
            if (ymc>arrym[i]) and (ymc<=arrym[i+1]) then
              begin
                a = (Data_dn[i+1]-Data_dn[i])/(arrym[i+1]-arrym[i]);
                b = Data_dn[i]-arrym[i]*a;
                y = ymc*a+b;
              }
          }
            DNym_tab0 = pwr(10,y/10.0);
                  }
function DNaz_SUM;
     const
        data_DN:array[1..63] of real=  (*** dB  ******)
(-26,-25,-24,-23,-22,-21,-20,-19,-18,-17,-16,-15,-14,
 -13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2.5,
 -2,-1.5,-1,-0.5,-0.25,-0.1,0,-0.1,-0.25,-0.5,-1.0,-1.5,-2,-2.5,-3,
 -4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18,-19,-20,-21,
 -22,-23,-24,-25,-26);
       data_az:array[1..63] of real=   (*** degree ***)
(-3.4,-3.25,-3.2,-3.15,-3.05,-3.0,-2.95,-2.9,-2.85,-2.75,-2.7,-2.65,-2.6,
 - 2.5,-2.4,-2.3,-2.2,-2.1,-1.95,-1.85,-1.75,-1.65,-1.55,-1.25,-1.15,
 -1,-0.85,-0.75,-0.6,-0.35,-0.25,0,0.25,0.35,0.6,0.75,0.85,1,1.15,1.25,
 1.55,1.65,1.75,1.85,1.95,2.1,2.2,2.3,2.4,2.5,2.6,2.65,2.7,2.75,2.85,
 2.9,2.95,3.0,3.05,3.15,3.2,3.25,3.4);
     type
       dt_yg=array[1..63] of real;
     var
        arraz:dt_yg;
        a,b,y:real;
        i:byte;
      begin
        for i = 1 to 63 do
        begin
        arraz[i] = data_az[i]*pi/180.0+yml;
            if fabs(az-arraz[i])<1e-6 then y = Data_dn[i];
        }
        if (az<arraz[1]) AND (az>=arraz[1]-sdn) then y = -23;
        if (az>arraz[63]) AND (az<=arraz[63]+sdn)  then y = -23;
        if az<=arraz[1]-sdn then y = -40;
        if az>=arraz[63]+sdn then y = -40;
        for i = 1 to 62 do
          begin
            if (az>arraz[i]) and (az<arraz[i+1]) then
              begin
                a = (Data_dn[i+1]-Data_dn[i])/(arraz[i+1]-arraz[i]);
                b = Data_dn[i]-arraz[i]*a;
                y = az*a+b;
              }
          }
            DNaz_SUM = pwr(10,y/10.0);
      }
function DNaz_PART_1;
     const
        data_DN1:array[1..82] of real=  (*** dB  ******)
(-26,-25,-24,-23,-22.5,-22.3,-22.2,-22.3,-22.5,-22.6,-22.5,-22,-21,
 -20,-19,-18,-17,-16,-15,-14,-13,-12,-11,-10,-9,
 -8,-7,-6,-5,-4,-3,-2.5,-2,-1.5,-1,-0.75,-0.6,
 -0.55,-0.5,-0.55,-0.6,-0.75,-1,-1.5,-2,-2.5,-3,-3.5,-4,-5,-6,-7,
 -8,-9,-10,-11,-12,-13,-14,-15,-16,-16.4,-16.6,-16.75,-16.6,-16.2,-16,
 -15.8,-15.7,-15.6,-15.8,-16,-17,-18,-19,-20,-21,-22,-23,-24,-25,-26);
       data_az1:array[1..82] of real=   (*** degree ***)
(-4.6,-4.5,-4.4,-4.2,-4.1,-4.0,-3.9,-3.85,-3.75,-3.65,-3.5,-3.45,-3.4,
 -3.3,-3.25,-3.2,-3.125,-3.05,-3,-2.95,-2.9,-2.85,-2.75,-2.7,-2.65,
 -2.55,-2.45,-2.35,-2.2,-2.1,-1.95,-1.85,-1.75,-1.65,-1.5,-1.35,-1.25,
 -1.1,-1,-0.9,-0.75,-0.65,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.35,
 0.45,0.5,0.6,0.67,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.25,1.4,1.5,
 1.6,1.75,1.8,2,2.1,2.25,2.35,2.4,2.5,2.55,2.65,2.7,2.75,2.8,2.85);
     type
       dt_yg=array[1..82] of real;
     var
        arraz:dt_yg;
        a,b,y:real;
        i:byte;
      begin
        for i = 1 to 82 do
        begin
        arraz[i] = data_az1[i]*pi/180.0+yml;
            if fabs(az-arraz[i])<1e-6 then y = Data_dn1[i];
        }
        if (az<arraz[1]) AND (az>=arraz[1]-sdn) then y = -18;
        if (az>arraz[82]) AND (az<=arraz[82]+sdn)  then y = -18;
        if az<=arraz[1]-sdn then y = -40;
        if az>=arraz[82]+sdn then y = -40;
        for i = 1 to 81 do
          begin
            if (az>=arraz[i]) and (az<arraz[i+1]) then
              begin
                a = (Data_dn1[i+1]-Data_dn1[i])/(arraz[i+1]-arraz[i]);
                b = Data_dn1[i]-arraz[i]*a;
                y = az*a+b;
              }
          }
            DNaz_PART_1 = pwr(10,y/10.0);
      }
function DNaz_PART_2;
     const
        data_DN:array[1..87] of real=  (*** dB  ******)
(-26,-25,-24,-23,-22,-21,-20,-19,-18.75,-18.2,-18,-17.8,
 -17.9,-18,-18.2,-18.75,-19,-19.1,-19,-18.5,-18,-17,-16,
 -15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,
 -4,-3.5,-3,-2.5,-2,-1.5,-1.2,-1,-0.8,-0.6,-0.5,-0.6,-0.8,-1,-1.2,
 -1.5,-2,-2.5,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,
 -14,-15,-16,-17,-18,-19,-20,-20.5,-20.9,-21,-20.9,-20.8,-20.7,-20.3,
 -20,-19.8,-20,-20.3,-21,-22,-23,-24,-25,-26);
       data_az:array[1..87] of real=   (*** degree ***)
(-3,-2.9,-2.85,-2.8,-2.75,-2.65,-2.55,-2.4,-2.35,-2.25,-2.2,-2.1,
 -1.9,-1.8,-1.75,-1.7,-1.65,-1.55,-1.45,-1.4,-1.35,-1.25,-1.2,
 -1.125,-1.05,-0.95,-0.9,-0.8,-0.75,-0.65,-0.55,-0.45,-0.35,-0.2,
 -0.1,0,0.1,0.155,0.25,0.4,0.5,0.6,0.7,0.85,1,1.15,1.25,1.35,1.4,
 1.5,1.6,1.68,1.75,1.87,2,2.15,2.25,2.35,2.43,2.5,2.6,2.65,2.7,
 2.75,2.8,2.85,2.9,2.95,3,3.05,3.1,3.15,3.2,3.25,3.3,3.4,3.5,
 3.6,3.75,3.9,4,4.15,4.3,4.35,4.4,4.45,4.5);
     type
       dt_yg=array[1..87] of real;
     var
        arraz:dt_yg;
        a,b,y:real;
        i:byte;
      begin
        for i = 1 to 87 do
        begin
        arraz[i] = data_az[i]*pi/180.0+yml;
            if fabs(az-arraz[i])<1e-6 then y = Data_dn[i];
        }
        if (az<arraz[1]) AND (az>=arraz[1]-sdn) then y = -18;
        if (az>arraz[87]) AND (az<=arraz[87]+sdn)  then y = -18;
        if az<=arraz[1]-sdn then y = -40;
        if az>=arraz[87]+sdn then y = -40;
        for i = 1 to 86 do
          begin
            if (az>=arraz[i]) and (az<arraz[i+1]) then
              begin
                a = (Data_dn[i+1]-Data_dn[i])/(arraz[i+1]-arraz[i]);
                b = Data_dn[i]-arraz[i]*a;
                y = az*a+b;
              }
          }
            DNaz_PART_2 = pwr(10,y/10.0);
      }
     function DN_SIN;
       var
           sdngr,d_l,delta,x,y:real;
       label
            k1;
       begin
           sdngr = sdn*180/pi;
           d_l = 50.8/sdngr;
           delta = fabs(ymc-yml);
           if delta<1e-8 then
             begin
                 DN_SIN = 1;goto k1;
             }
               if delta<=sdn then
                begin
                 x = pi*d_l*(sin(yml)-sin(ymc));
                 y = sin(x)/x;
                 DN_SIN = fabs(y)
                 end
                 else
                  dn_sin = 1e-6;
    k1:        }
     function DN_SINN;
       var
           sdngr,d_l,delta,x,y:real;
       label
            k1;
       begin
           sdngr = sdn*180/pi;
           d_l = 50.8/sdngr;
           delta = fabs(ymc-yml);
           if delta<1e-8 then
             begin
                 DN_SINN = 1;goto k1;
             }
                 begin
                 x = pi*d_l*(ymc-yml);
                 y = sin(x)/x;
                 DN_SINN = fabs(y);
               }
    k1:        }
procedure SSig_F;
  var  dne,dnw,y_br1,dne_pri,dnw_pri,y_br2,v:real;
  begin
       Dne = DNaz_tab_1(zlg,pelc,sdnp);        dne = 1;
       Dnw = DNym_tab(0.4*pi/180.0,0.4*pi/180.0,sdnym); dnw = 1;
       foid(dist,HS[1],0.4*pi/180.0,sdnym,ppol,eps,v,DNym_TAB);
       Dne_pri = DNaz_SUM(zlg,pelc,2.7*pi/180.0);Dne_pri = 1;
       Dnw_pri = DNym_tab(zlw,ymc,2.7*pi/180.0);Dnw_pri = 1;
       y_br1 = dne*dnw*dne_pri*dnw_pri*Pper_raz;
      y_br2 = 10*Lg(y_br1);
       dne = 20*Lg(v)+20*lg(lam*1e-3/(dist*4*pi))-8.5;
       S_N = dne+y_br2+Gper+Gpri_SUM-Ppri_min;
   }
procedure SSig_K;
  var  dne,dnw,y_br1,dne_pri,dnw_pri,y_br2,v:real;
   begin
       DNE_pri = DNaz_Part_1(zlg,pelc,2.5*pi/180.-);DNE_pri = 1;
       Dnw_pri = DNym_tab(zlw,ymc,2.7*pi/180.-); Dnw_pri = 1;
       Dne = DNaz_tab_1(zlg,pelc,sdnp); dne = 1;
       Dnw = DNym_tab(zlw,ymc,sdnym); dnw = 1;
       foid(dist,HS[1],zlw,sdnym,ppol,eps,v,DNym_TAB);
       y_br1 = dne*dnw*dne_pri*dnw_pri*Pper_raz;
       y_br2 = 10*Lg(y_br1);
       dne = 20*Lg(v)+20*lg(lam*1e-3/(dist*4*pi))-8.5;
       S_N = dne+y_br2+Gper+Gpri_part-Ppri_min;
   }
procedure SPom_F;
  var  dne,dnw,y_br,dne_pri,dnw_pri,pom,v:real;
   begin
       DNE_pri = DNaz_Sum(zlg,pelc,2.7*pi/180.0);
       Dnw_pri = DNym_tab(0.4*pi/180.0,ymc,sdnym);
if hp>2 then v = 1 else
       foid(dist,Hp,zlw,sdnym,ppol,eps,v,DNym_TAB);
    v = 1;
       y_br = dne_pri*dnw_pri;
       pom = se*sqr(v/(dist*1000.0))*y_br;
       pom = pom*sse_F;
       S_N = 10*lg(1+pom);
  }
procedure SPom_K;
  var  dne,dnw,y_br,dne_pri,dnw_pri,pom,v:real;
  begin
       Dne_pri = DNaz_part_1(zlg,pelc,2.5*pi/180.0);
       Dnw_pri = DNym_tab(0.4*pi/180.0,ymc,sdnym);
if hp>2 then v = 1 else
      foid(dist,hp,zlw,sdnym,ppol,eps,v,DNym_TAB);
       y_br = {dne*dnw*}dne_pri*dnw_pri;
       pom = se*sqr(v/(dist*1000))*y_br;
       pom = pom*sse_K;
       S_N = 10*lg(1+pom);
  }
procedure SPom_XIP;
  var  ppt,dne,L_pot,dnw,y_br,dne_pri,dnw_pri,pom,v:real;
  begin
       ppt = 1000; // pt
       dne = 50;
       L_pot = 5.5;L_pot = pwr(10,L_pot/10);
       Dne_pri = DNaz_part_1(zlg,pelc,2.2*pi/180);
       Dnw_pri = DNym_tab(0.4*pi/180.0,ymc,sdnym);
   {    foid(dist,hp,zlw,sdnym,ppol,eps,v,DNym_TAB); }
       v = 1;
       y_br = dne_pri*dnw_pri*ppt*dne/L_pot;write(y_br:18:15);
       pom = sqr(v*lam*1e-3/(dist*4*pi))*y_br; writeln('pom  ',pom:18:15);
       S_N = tau/T_p*(Ppri+pom)+Ppri*(1-tau/T_p);
       s_N = 10*lg(S_N)+Gper;  writeln(' s/n ', S_N:12:6);
  }
END.*/
