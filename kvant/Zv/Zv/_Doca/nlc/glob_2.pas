unit glob_2;
  { начальные значения переменных}
INTERFACE
Uses matfun;
type
    arr_a=array [1..68] of real;
const
     Hs:array[1..3] of real=(20*1e-3,15*1e-3,7.5*1e-3);
var
 q0:arr_a;
 tau,T_P,Dsw,PPer,PPri,GPer,GPri,Line_obn,Ddist:real;
 ha,lam,re,rz,N_Sh,PotT,PotR,ksi,ksi_raz,Ppri_min,Gpri_part,Gpri_sum: real;
 ppol,trans_reg:byte;
 PPer_raz, eps,se,sse,sse_K,sse_F,L_pot_J:real;
procedure initzonvidvar;  {установка начальных значений}
IMPLEMENTATION
uses umain, SysUtils;
procedure initzonvidvar;
var
   P1,P2,ll,ll_dB,GPer_raz,GPri_raz:real;
   h,aaaaaaaaa,PotR_raz,PotT_raz:real;
   i:byte;
begin
  trans_reg:=1;
  N_Sh:=9;
  L_pot_J:=6.5;
    GPri_sum:=32;(*** dB ***)
  GPri_part:=31.5;(*** dB ***)
  for i:=1 to 68 do q0[i]:=0;
  DDist:=20;
  ha:=StrToFloat(FmMain.edHa.Text) {9}; (*15, 20, 25*)        (* m *)
  rz:=6400.0;
  re:=8500.0; {re:=25000.0;}
{  lam:=0.1; }  {lam:=0.075;}  lam:=StrToFloat(FmMain.edLam.Text) {0.035};(* m *)
  ll:=sqr(lam/(4*pi));
  ll_dB:=10*Lg(ll);
   Tau:=4e-7;T_P:=4e-6;
  {GPer:=32;}  GPer:=10;
  GPri:=10; {GPri:=32;}
  GPri_raz:=exp(GPri*Ln(10)/10);
  GPer_raz:=exp(GPer*Ln(10)/10);
  PPer:=10;    PPer:=10;    (****   dB   ******)
  pper_raz:=exp(PPer*Ln(10)/10){pwr(10,pper/10)};
  PPri:=1E-13;
  Ppri_min:=-125;
  ksi:=3;
  PotT:=4;   (* dB *)
  PotR:=1;   (* dB *)
  PotR_raz:=exp(PotR*Ln(10)/10);
  PotT_raz:=exp(PotT*Ln(10)/10);
  ksi_raz:=exp(ksi*Ln(10)/10);
  Dsw:=sqrt(PPer_raz*Gper_raz*GPri_raz*ll/(PotT_raz*PotR_raz*ksi_raz*PPri));
  {x}///writeln('Dsw=',Dsw:12:3);
  P1:=10*Lg(PPer_raz)-{10*lg(PotT)}PotT+10*lg(GPer_raz);
  P2:=-10*lg(PPri)-{10*lg(PotR)}PotR+10*lg(GPri_raz)-ksi+ll_dB;
  h:=0.5*exp(ln(re*sqr(lam*1e-3)/sqr(pi))/3.0);
  aaaaaaaaa:=exp(ln(sqr(re)*lam*1e-3/pi)/3.0);
  q0[14]:=StrToFloat(FmMain.edH.Text)*1e-3; ///0.2*1e-3;  (* km *)
  q0[8]:=ha*1e-3;
  q0[11]:=re;
  q0[12]:=rz;
  q0[13]:=lam*1e-3;
  q0[15]:=3.0*pi/180;
  q0[16]:=0.0211;
  q0[26]:=q0[14]*pi/(lam*1e-3);
  q0[27]:=aaaaaaaaa;
  q0[28]:=h;
  q0[29]:=2.0*pi/(lam*1e-3);
  Line_obn:=P1+P2;
  {x}///writeln(Line_obn:12:6);
  ppol:=2;
  eps:=80;
  se:=0.0005;
  sse_F:=Gpri_sum+ll_dB-L_pot_J+204-N_Sh;
  {x}///writeln('sse_F = ',sse_F:12:6);
  sse_F:=exp(sse_F*Ln(10)/10);
  sse_K:=Gpri_part+ll_dB-L_pot_J+204-N_Sh;
  {x}///writeln('sse_K = ',sse_K:12:6);
  sse_K:=exp(sse_K*Ln(10)/10);
  {x}///readln;
  end;
END.


