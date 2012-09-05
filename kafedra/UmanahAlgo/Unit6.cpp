//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit6.h"
#include "Math.h"
#include "Math.hpp"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm6 *Form6;
//---------------------------------------------------------------------------
__fastcall TForm6::TForm6(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm6::Button1Click(TObject *Sender)
{
	double om    = 2750.0*2.0*M_PI;
	double r     = 1.5;
	double theta = 1.0*M_PI*0.25;
	double Tend  = 1.0;
	double r_  = 1;
	double om_ = 2600.0*2.0*M_PI;
	double T0  = 1.0 / 50000.0;
	int    i   = 0;

	const int Nbuf = 10;
    double dBuf[Nbuf] = {0.0};
    double Tbuf[Nbuf] = {0.0};
    double F[Nbuf] = {0.0};
    double dF[Nbuf][2] = {0.0};

    double *x     = (double*) malloc ((int)(Tend / T0)+1* sizeof(double));
    double *Theta = (double*) malloc ((int)(Tend / T0)+1* sizeof(double));
    double *dx2   = (double*) malloc ((int)(Tend / T0)+1* sizeof(double));
    double *r_oc  = (double*) malloc ((int)(Tend / T0)+1* sizeof(double));
    double *om_oc = (double*) malloc ((int)(Tend / T0)+1* sizeof(double));
    double *tt    = (double*) malloc ((int)(Tend / T0)+1* sizeof(double));

    for ( int z = 0; z < Nbuf; z++)
    {
		dBuf[z]    = 0.0;
		Tbuf[z]    = 0.0;
		F   [z]    = 0.0;
		dF  [z][0] = 0.0;
		dF  [z][1] = 0.0;
    }
    for ( int z = 0; z < Nbuf; z++)
    {
        x    [z] = 0.0;
        Theta[z] = 0.0;
        dx2  [z] = 0.0;
        r_oc [z] = 0.0;
        om_oc[z] = 0.0;
        tt   [z] = 0.0;
    }

    double XX  [2] = {0.0, 0.0};

	double om_TH = M_PI;

    for ( int k =0; k < Nbuf; k++ ) Tbuf[k] = k*T0;
    XX[0] = r_;
    XX[1] = om_;

	int    i_diff = 1;
	int    n_tact = 1;
	int    k = 1;

    for ( double t = 0; t < Tend; t = t + T0, i++ )
    {
		 x   [i] = r*cos(om*t)*cos(theta) + 0.005*RandG(0,1);        
         dBuf[0] = x[i];
         Tbuf[0] = t;

        // -------------------------
        //F = r_*cos(om_*Tbuf)*cos(theta);
        //dF = [cos(om_*Tbuf)*cos(theta);-r_*Tbuf.*sin(om_*Tbuf)*cos(theta)]';
        for (int z = 0; z < Nbuf; z++)
        {
            F [z]    =  r_ * cos(om_*Tbuf[z])*cos(theta);
            dF[z][0] =  cos(om_*Tbuf[z])*cos(theta);
            dF[z][1] = -r_ *Tbuf[z]*sin(om_*Tbuf[z])*cos(theta);
        }
        // -------------------------

/*

            while (F-dBuf)*(F-dBuf)'>.001 && i_diff>=Nbuf
            // ---- %     while N_tact <6 & i_diff>=Nbuf
            F = r_*cos(om_*Tbuf)*cos(theta);
            dF = [cos(om_*Tbuf)*cos(theta);-r_*Tbuf.*sin(om_*Tbuf)*cos(theta)]';
                                                          f ns xnj jlby
            XX = XX - inv(dF'*dF)*dF'*(F-dBuf)';
            r_ = XX(1);
            om_ = XX(2);

            for ( int i = 0; i < 1200; i++)

            (//F-dBuf)*(F-dBuf)'
            if (F-dBuf)*(F-dBuf)'<=0.001
                  // ---- %         if N_tact >=6
                  i_diff = 0;
                  N_tact(k) = n_tact;
                  k = k+1;
            end
            n_tact = n_tact + 1;
        end
*/
        n_tact   = 1;
		theta    = theta + om_TH*T0;
		Theta[i] = theta;
        dx2  [i] = -r_*sin(om_*t)*cos(theta) -om_TH*r_*cos(om_*t)*sin(theta);
		r_oc [i] = r_;
		om_oc[i] = om_;

        //%       dx_et = -r*sin(om*t)*cos(theta)
        //%       -r_*sin(om_*t)*cos(theta);
        //%       end
        //%     dx2(i) = r_*cos(om_*t)*cos(theta);

        for ( int z = Nbuf - 1; z > 0 ; z-- )
        {
           dBuf[z] = dBuf[z-1];
           Tbuf[z] = Tbuf[z-1];
        }
        dBuf[0] = 0.0;
        Tbuf[0] = 0.0;

        tt[i] = t;
        i = i + 1;
        i_diff = i_diff + 1;
    }

    free(x);
    free(Theta);
    free(dx2);
    free(r_oc);
    free(om_oc);
    free(tt);

//
/*
clc
clear all


om = 2750*2*pi;
r = 1.5;
theta = 1*pi/4;
Tend = 1.0;

Nbuf = 10;
dBuf = zeros(1,Nbuf);

r_ = 1;
om_ = 2600*2*pi;
T0 = 1/50000;
i = 1;
om_TH = pi;

Tbuf = 0:Nbuf-1;
Tbuf = Tbuf*T0;
XX = [r_;om_];

i_diff = 1;
n_tact = 1;
k = 1;
for t = 0:T0:Tend
    x(i) = r*cos(om*t)*cos(theta) + 0.005*randn(1,1);
    dBuf(1) = x(i);
    Tbuf(1) = t;
    F = r_*cos(om_*Tbuf)*cos(theta);
    dF = [cos(om_*Tbuf)*cos(theta);-r_*Tbuf.*sin(om_*Tbuf)*cos(theta)]';
    
    
    while (F-dBuf)*(F-dBuf)'>.001 && i_diff>=Nbuf 
%     while N_tact <6 & i_diff>=Nbuf 
        

        F = r_*cos(om_*Tbuf)*cos(theta);
        dF = [cos(om_*Tbuf)*cos(theta);-r_*Tbuf.*sin(om_*Tbuf)*cos(theta)]';
        
        XX = XX - inv(dF'*dF)*dF'*(F-dBuf)';
        r_ = XX(1);
        om_ = XX(2);

        (F-dBuf)*(F-dBuf)'
        if (F-dBuf)*(F-dBuf)'<=0.001
%         if N_tact >=6
        i_diff = 0;
        N_tact(k) = n_tact;

        k = k+1;
        end   
        
        n_tact = n_tact + 1;
        

    end
    
   n_tact = 1; 
    
   
       theta = theta + om_TH*T0;
         Theta(i) = theta;

        dx2(i) = -r_*sin(om_*t)*cos(theta) -om_TH*r_*cos(om_*t)*sin(theta);
        
        r_oc(i) = r_;
        om_oc(i) = om_;

%         dx_et = -r*sin(om*t)*cos(theta)
%         -r_*sin(om_*t)*cos(theta);
%         end
        

%     dx2(i) = r_*cos(om_*t)*cos(theta);
    
    
    
    dBuf(end) = [];
    dBuf = [0 dBuf];
    Tbuf(end) = [];
    Tbuf = [0 Tbuf];

    tt(i) = t;
    i = i + 1;
    i_diff = i_diff + 1;
    
end

% N = 5;
% for i = 1:length(x)-N
%     dx1(i) = x(i+N);
% end


dx_et = -r*sin(om*tt).*cos(Theta)- om_TH*r*cos(om*tt).*sin(Theta);


dx2(1:Nbuf) = [];
dx_et(1:Nbuf) = [];
tt(1:Nbuf) = [];
Theta(1:Nbuf) = [];

r_oc(1:Nbuf) = [];
om_oc(1:Nbuf) = [];



figure
plot(tt,dx_et,tt,dx2);grid

figure
plot(tt,dx_et-dx2);grid

figure
plot(Theta*180/pi,dx_et-dx2);grid


figure
plot(tt,r_oc,tt,r*ones(1,length(r_oc)));grid

figure
plot(tt,om_oc/(2*pi),tt,om*ones(1,length(r_oc))/(2*pi));grid


% max(dx_et-dx1)
max(dx_et-dx2)
% figure
% plot(tt,x);grid

buf = x(1:19);
Nb = 1:length(buf);

NN = 1:length(N_tact)
figure
plot(NN,N_tact);grid
*/
}
//---------------------------------------------------------------------------

