unit modmove;

interface

uses Classes;

Type mas=array[1..2] of extended;
     ma1=array[1..400] of extended;
     sig=array[1..3,0..401] of extended;
     matrix = array[1..2,1..2] of extended;
     vector = array[1..2] of extended;
     Estimator = procedure;
     function c(x:extended):extended;
     function s(x:extended):extended;
     procedure noise(var n1:ma1);
     procedure nul_vect(var vec:vector);
     procedure mat_p_mat(m,n:byte ; a,b:matrix; var c:matrix );
     procedure vect_p_vect( m , n : byte ; a,b : vector ; var c : vector );
     procedure vect_scal(  a:vector; b: extended ; m : byte ; var c:vector );
     procedure matr_scal(m,n : byte ; a : matrix ; b : extended;  var c:matrix );
     procedure  multmat (ma, mb: matrix; m,n : byte; var multmal: matrix );
     procedure  mat_vect (ma :matrix; mb : vector ; m,n : byte;
                                                      var multmal: vector );
     Procedure trans(ain:matrix ; n:byte ;var aout:matrix);
     procedure st_matr (b:vector; f:matrix; n:byte; var bf:vector);
     procedure simmat(a:matrix;n:byte;var b:matrix);
     procedure  vect_vect ( ma,mb : vector ; n : byte; var multmal: extended );
     Procedure OFK;
     Procedure RN;
     Procedure SCAL;
     Procedure Ellipse;
     Procedure Garant;


Var
  x0,xk0,xk,k,bet,r,qq,pp,iz,z0,pp0,k0           : mas;
  n1,n2,n3                                        : ma1;
  omeX,omeY,ome0,rg,rm,inte1,dwx,dwy,dx,dy,tk1,
  t,tk,tn,h,ti,Wx,Wy,gen,dpsi,inte,dk,betta2,buf
  ,e2,cn,hi2,tau,ns,r0,delta,mu,vdk  : extended;
  ki,ni,Grm,Grt,kolt,l,kk                         : integer;
  ch                                              : char;
  xc,xr,xf                                        : sig;
  n                                               : byte;
  hm,aa,ht,h0,ah,at,ht1,h1,htb,p,p1,q,qr,buf1,b   : matrix;
  xtk0,xtk,xt0,xt,u,
  buf12,buf21,cc                                  : vector;
  uh,htu,sl                                       : vector;
  uhu,sigma2,gamma2,buhu,htuu,d,z1,z2,r1,
  gam_buf,u1k,u2k           : extended;



implementation

uses Sysutils;

function c(x:extended):extended;
      begin c:=cos(x);
end;
function s(x:extended):extended;
      begin s:=sin(x);
end;

procedure noise(var n1:ma1);
  var
   d,i: integer;
   h,s,x0,m1:extended;
const
    n:integer=5;
    m:integer=50;
 begin
  randomize;
     s:=0;
     m1:=0;
     if inte=0 then inte:=0 else begin
   for d:=1 to 400 do begin
      for i:=1 to n do
       begin
          s:=s+random(1000)/1000.0;
          h:=sqrt(12/n)*(s-n/2);
          x0:=h-(1/(20.0*n))*(3*h-h*h*h);
       end;
      S:=0;
		n1[d]:=x0;
		m1:=m1+n1[d];
  end;
  end;
       if inte1=0 then inte1:=0 else begin
   for d:=1 to 400 do begin
      for i:=1 to n do
       begin
          s:=s+random(1000)/1000.0;
          h:=sqrt(12/n)*(s-n/2);
          x0:=h-(1/(20.0*n))*(3*h-h*h*h);
       end;
      S:=0;
		n1[d]:=x0;
		m1:=m1+n1[d];
  end;
  end;
 end;
{--------------------------------------------------------------------------}
procedure nul_vect(var vec:vector);
var
 i : byte;
 begin
      for i:=1 to 2 do begin
          vec[i]:=0;
      end;
 end;
procedure nul_matrix(n : byte; var mat:matrix);
var
 i,j : byte;
 begin
      for i:=1 to n do begin
          for j:=1 to n do begin
             mat[i,j]:=0;
          end;
      end;
 end;
 {-------------------------------------------------------------------------}
procedure mat_p_mat(m,n:byte ; a,b:matrix; var c:matrix );

var
 i,j : integer;

begin

  for i:=1 to m do
    begin
      for j:=1 to n do
        begin
          c[i,j]:=a[i,j]+b[i,j];
        end;
    end;
end;
{-----------------------------------------------------------------------------}
procedure vect_p_vect( m , n : byte ; a,b : vector ; var c : vector );

var
 i : byte;

begin
  for i:=1 to m do c[i]:=a[i]+b[i];
end;
{---------------------------------------------------------------------------}
procedure vect_scal(  a:vector; b: extended ; m : byte ; var c:vector );

var
 i : byte;

begin
nul_vect(c);
  for i:=1 to m do
    begin
       c[i]:=a[i]*b;
    end;
end;{ End Vect_Scal }
{----------------------------------------------------------------------------}
procedure matr_scal(m,n : byte ; a : matrix ; b : extended;  var c:matrix );

var
 i,j : byte;
begin
  for i:=1 to m do
    begin
      for j:=1 to n do
        begin
          c[i,j]:=a[i,j]*b;
        end;
    end;
end;
{---------------------------------------------------------------------------}
procedure  multmat (ma, mb: matrix; m,n : byte; var multmal: matrix );

  var i,j,k : integer;
    begin
 nul_matrix(n,multmal);
      for i:=1 to n do
         begin
             for j:=1 to n do
                begin
                    for k:=1 to n do
                         multmal[i,j] := multmal[i,j]+ma[i,k]*mb[k,j];
                 end;
           end;
     end;
{--------------------------------------------------------------------------------}
procedure  mat_vect (ma :matrix; mb : vector ; m,n : byte; var multmal: vector );

  var i,j : integer;
    begin
 nul_vect(multmal);
      for i:=1 to n do
         begin
             for j:=1 to n do
                begin
                         multmal[i] := multmal[i]+ma[i,j]*mb[j];
                 end;
           end;
     end;
Procedure trans(ain:matrix ; n:byte;var aout:matrix);

 var
 i,j : integer;
 k:extended;
   begin
   nul_matrix(n,aout);
    for i:=1 to n do
    begin
     for j:=i+1 to n do
      begin
      k:=ain[i,j];
      aout[i,j]:=ain[j,i];
      aout[j,i]:=k;
      end;
      aout[i,i]:=ain[i,i];
    end;
   end;
procedure st_matr (b:vector; f:matrix; n:byte; var bf:vector);
 var i,j : integer;
begin
  nul_vect(bf);
  for i:=1 to n do
  begin
  for j:=1 to n do
    begin
     bf[i]:=bf[i]+b[j]*f[j,i];
    end;
  end;
end;
{----------------------------------------------------------------------------}
procedure simmat(a:matrix;n:byte;var b:matrix);

var
 n1,i1,i,j : integer;
 delta : extended;
begin
 n1:=n-1;
 for i:=1 to n1 do
  begin
   i1:=i+1;
   for j:=i1 to n do
    begin
     delta:=a[i,j]-a[j,i];
     b[i,j]:=a[i,j]-delta/2;
     b[j,i]:=b[i,j];
    end;
   b[i,i]:=a[i,i];
  end;
 b[n,n]:=a[n,n];
end;
{-----------------------------------------------------------------------------}
procedure  vect_vect ( ma,mb : vector ; n : byte; var multmal: extended );

  var i : byte;
    begin
 multmal:=0;
       for i:=1 to n do multmal := multmal+ma[i]*mb[i];
     end;
{-----------------------------------------------------------------------------}
Procedure OFK;
var
 ss : extended;
 i,j,kk:integer;
begin
    {------------------╬яЁхфхыхэшх ъю¤ЇЇшЎшхэЄют-----------------}
    st_matr(cc,p1,n,buf12);
    vect_vect(buf12,cc,n,buf);
    buf:=buf+r1;
    buf:=1/buf;
    mat_vect(p1,cc,n,n,buf21);
    k[1]:=buf21[1]*buf;
    k[2]:=buf21[2]*buf;
    {-----------------p(i/i)---------------------------------}
    buf1[1,1]:=k[1]*cc[1];
    buf1[1,2]:=k[1]*cc[2];
    buf1[2,1]:=k[2]*cc[1];
    buf1[2,2]:=k[2]*cc[2];
    for i:=1 to n do begin
     for j:=1 to n do begin
      ss:=0;
      for kk:=1 to n do ss:=ss+buf1[i,kk]*p1[kk,j];
      p[i,j]:=ss;
     end;
    end;
    for i:=1 to n do begin
     for j:=1 to n do begin
      buf1[i,j]:=p1[i,j]-p[i,j];
     end;
    end;
    simmat(buf1,n,p);
    {-------------------p(i+1/i)-----------------------------}
    multmat(aa,p,n,n,p1);
    for i:=1 to n do begin
     for j:=1 to n do begin
      ss:=0;
      for kk:=1 to n do ss:=ss+p1[i,kk]*aa[j,kk];
      buf1[i,j]:=ss;
     end;
    end;
    for i:=1 to n do begin
     for j:=1 to n do begin
      buf1[i,j]:=buf1[i,j]+q[i,j];
     end;
    end;
    simmat(buf1,n,p1);
     {x[1]:=x0[1]*c(ome0*ti)-x0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*Wx
     +(1-c(ome0*ti))*Wy);
     x[2]:=x0[1]*s(ome0*ti)+x0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*Wx
     +(-s(ome0*ti))*Wy);}
     xk[1]:=xk0[1]*c(ome0*ti)-xk0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))
     *(Wx+dx+dwx)+(1-c(ome0*ti))*(Wy+dy+dwy))+k[1]*(x0[1]+dpsi-xk0[1]);
     xk[2]:=xk0[1]*s(ome0*ti)+xk0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)
     *(Wx+dx+dwx)+(-s(ome0*ti))*(Wy+dy+dwy))+k[2]*(x0[1]+dpsi-xk0[1]);
     end; {Procedure OFK}

Procedure RN;
var
 ss : extended;
 i,j,kk : integer;
begin
    {-----------------╬яЁхфхыхэшх ъю¤ЇЇшЎшхэЄют------------------}
    st_matr(cc,p1,n,buf12);
    vect_vect(buf12,cc,n,buf);
    gam_buf:=buf;
    buf:=1/buf;
    mat_vect(p1,cc,n,n,buf21);
    k[1]:=buf21[1]*buf;
    k[2]:=buf21[2]*buf;
    { x[1]:=x0[1]*c(ome0*ti)-x0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*(Wx+dwx)+(1-c(ome0*ti))*(Wy+dwy));
     x[2]:=x0[1]*s(ome0*ti)+x0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*(Wx+dwx)+(-s(ome0*ti))*(Wy+dwy));}
     xk[1]:=xk0[1]*c(ome0*ti)-xk0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*(Wx+dwx+dx)+(1-c(ome0*ti))*
     (Wy+dwy+dy))+k[1]*(x0[1]+dpsi-xk0[1]);
     xk[2]:=xk0[1]*s(ome0*ti)+xk0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*(Wx+dwx+dx)+(-s(ome0*ti))*
     (Wy+dwy+dy))+k[2]*(x0[1]+dpsi-xk0[1]);
     dk:=x0[1]-xk0[1]+dpsi;
     gamma2:=1+dk*dk/gam_buf;

    {----------------- p(i/i)---------------------------------}
    buf1[1,1]:=k[1]*cc[1];
    buf1[1,2]:=k[1]*cc[2];
    buf1[2,1]:=k[2]*cc[1];
    buf1[2,2]:=k[2]*cc[2];
    for i:=1 to n do begin
     for j:=1 to n do begin
      ss:=0;
      for kk:=1 to n do ss:=ss+buf1[i,kk]*p1[kk,j];
      p[i,j]:=ss*(1-betta2);
     end;
    end;
    for i:=1 to n do begin
     for j:=1 to n do begin
      buf1[i,j]:=(p1[i,j]-p[i,j])*gamma2;
     end;
    end;
    simmat(buf1,n,p);
    {------------------- p(i+1/i)-----------------------------}
    multmat(aa,p,n,n,p1);
    for i:=1 to n do begin
     for j:=1 to n do begin
      ss:=0;
      for kk:=1 to n do ss:=ss+p1[i,kk]*aa[j,kk];
      buf1[i,j]:=ss;
     end;
    end;
    for i:=1 to n do begin
     for j:=1 to n do begin
      buf1[i,j]:=buf1[i,j]+qr[i,j];
     end;
    end;
    simmat(buf1,n,p1);
end; {Procedure RN}

Procedure Scal;
begin

 { x[1]:=x0[1]*c(ome0*ti)-x0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*Wx+(1-c(ome0*ti))*Wy);
  x[2]:=x0[1]*s(ome0*ti)+x0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*Wx+(-s(ome0*ti))*Wy);}

  z1:=z0[1];
  if (ki=1) then  z1:=x0[1]+n1[ki]*inte;
  if (ki div 2=ki/2) then  z2:=x0[1]+n1[ki]*inte;

  if (ki div 2 <> ki/2) and (ki<>1) then
   begin
    dwx:=(sqr(n2[ki-2]*inte1)+sqr(n2[ki-1]*inte1)+sqr(n2[ki]*inte1))/3;
    dwy:=(sqr(n3[ki-2]*inte1)+sqr(n3[ki-1]*inte1)+sqr(n3[ki]*inte1))/3;
    {dwx:=0;}
    dpsi:=(sqr(n1[ki-2]*inte)+sqr(n1[ki-1]*inte)+sqr(n1[ki]*inte))/3;
    qq[1]:=8*dpsi+2*ti*ti*dwx+ome0*ome0*sqr(ti*ti)*dwy;
    qq[2]:=4*ome0*ome0*ti*ti*dpsi+2*ti*ti*dwy+ome0*ome0*sqr(ti*ti)*dwx;
    r[1]:=dpsi;
    r[2]:=2/sqr(ome0*ti)*dpsi+1/sqr(ome0)*dwx;
    pp[1]:=sqr(1-ome0*ome0*ti*ti)*(1-k0[1])*pp0[1]+qq[1];
    pp[2]:=sqr(1-ome0*ome0*ti*ti)*(1-k0[2])*pp0[2]+qq[2];
    k[1]:=pp[1]/(pp[1]+r[1]);
    k[2]:=pp[2]/(pp[2]+r[2]);

    u1k:=2*ome0*ti*z1-2*ome0*ome0*ti*ti*z2;
    u2k:=2*ome0*ti*z1;

    iz[1]:=x0[1]+n1[ki]*inte;
    iz[2]:=x0[2]+(n1[ki-2]*inte)/(ome0*ti)-n2[ki-2]*inte1/ome0-n1[ki-1]*inte/(ome0*ti);

    xk[1]:=xk0[1]*(1-ome0*ome0*ti*ti)+u1k+k[1]*(iz[1]-(1-ome0*ome0*ti*ti)*xk0[1]-u1k);
    xk[2]:=xk0[2]*(1-ome0*ome0*ti*ti)+u2k+k[2]*(iz[2]-(1-ome0*ome0*ti*ti)*xk0[2]-u2k);
  end;
end; {Procedure Scal}

Procedure Ellipse;
var
 ss : real;
 i,j,kk: integer;

begin
{----------------------------вычисление p(i+1/i)-----------------------------}
    multmat(aa,p,n,n,p1);
    for i:=1 to n do begin
     for j:=1 to n do begin
      ss:=0;
      for kk:=1 to n do ss:=ss+p1[i,kk]*aa[j,kk];
      buf1[i,j]:=ss;
     end;
    end;
    simmat(buf1,n,p1);

{     x[1]:=x0[1]*c(ome0*ti)-x0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*(Wx+dwx)+(1-c(ome0*ti))*(Wy+dwy));
     x[2]:=x0[1]*s(ome0*ti)+x0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*(Wx+dwx)+(-s(ome0*ti))*(Wy+dwy));
}     xk[1]:=xk0[1]*c(ome0*ti)-xk0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*(Wx+dwx+dx)+(1-c(ome0*ti))*
     (Wy+dwy+dy));
     xk[2]:=xk0[1]*s(ome0*ti)+xk0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*(Wx+dwx+dx)+(-s(ome0*ti))*
     (Wy+dwy+dy));
     dk:=x0[1]-xk0[1]+dpsi;

{--------------------Промежуточная переменная е2(i+1/i)=c*p1*ct--------------}
    st_matr(cc,p1,n,buf12);
    vect_vect(buf12,cc,n,e2);

{-----------------------------Шаг алгоритма tau(i)---------------------------}
if abs(dk)>=cn then
 begin
  hi2:=cn*cn/e2;
  tau:=1/(1+ns*hi2);
 end
else tau:=0;
gamma2:=1+tau/ns;

{---------------------------вычисление коэффициента усиления-----------------}
    k[1]:=buf12[1]*tau/e2;
    k[2]:=buf12[2]*tau/e2;

{--------------------------вычисление p(i+1/i+1)---------------------------------}
    buf1[1,1]:=k[1]*cc[1];
    buf1[1,2]:=k[1]*cc[2];
    buf1[2,1]:=k[2]*cc[1];
    buf1[2,2]:=k[2]*cc[2];
    for i:=1 to n do begin
     for j:=1 to n do begin
      ss:=0;
      for kk:=1 to n do ss:=ss+buf1[i,kk]*p1[kk,j];
      p[i,j]:=ss;
     end;
    end;
    for i:=1 to n do begin
     for j:=1 to n do begin
      buf1[i,j]:=(p1[i,j]-p[i,j])*gamma2;
     end;
    end;
    simmat(buf1,n,p);
{------------------------Определение оценок вектора состояния----------------}
     xk[1]:=xk[1]+k[1]*dk;
     xk[2]:=xk[2]+k[2]*dk;

end; {Procedure Sost}

Procedure Garant;
var
 ss : real;
 i,j,kk: integer;
begin

    {----------------моделирование системы------------------------------}
{     x[1]:=x0[1]*c(ome0*ti)-x0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*(Wx+dwx)+(1-c(ome0*ti))*(Wy+dwy));
     x[2]:=x0[1]*s(ome0*ti)+x0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*(Wx+dwx)+(-s(ome0*ti))*(Wy+dwy));
}     dk:=x0[1]-xk0[1]+dpsi;
    {------------------вычисление коэффициента усиления-----------------}
     st_matr(cc,p1,n,buf12);
     vect_vect(buf12,cc,n,buf);
     e2:=buf;
     vdk:=abs(dk);
     if vdk>cn then
      mu:=(vdk-cn)*(vdk-cn)/e2
     else
      mu:=0;
     if mu>delta then
      gamma2:=1+(1+r0)*mu
     else
      gamma2:=1;
     hi2:=gamma2-r0*mu;
     mat_vect(p1,cc,n,n,buf21);
     k[1]:=r0*buf21[1]/e2;
     k[2]:=r0*buf21[2]/e2;
     {------------------------------------------------------------------}

     xk[1]:=xk0[1]*c(ome0*ti)-xk0[2]*s(ome0*ti)-1/ome0*((-s(ome0*ti))*(Wx+dwx+dx)+(1-c(ome0*ti))*
     (Wy+dwy+dy))+k[1]*(x0[1]+dpsi-xk0[1]);
     xk[2]:=xk0[1]*s(ome0*ti)+xk0[2]*c(ome0*ti)-1/ome0*((c(ome0*ti)-1)*(Wx+dwx+dx)+(-s(ome0*ti))*
     (Wy+dwy+dy))+k[2]*(x0[1]+dpsi-xk0[1]);

    {-----------------вычисление p(i/i)---------------------------------}
    buf1[1,1]:=k[1]*cc[1];
    buf1[1,2]:=k[1]*cc[2];
    buf1[2,1]:=k[2]*cc[1];
    buf1[2,2]:=k[2]*cc[2];
    for i:=1 to n do begin
     for j:=1 to n do begin
      ss:=0;
      for kk:=1 to n do ss:=ss+buf1[i,kk]*p1[kk,j];
      p[i,j]:=ss*(1-betta2);
     end;
    end;
    for i:=1 to n do begin
     for j:=1 to n do begin
      buf1[i,j]:=(p1[i,j]-p[i,j])*hi2;
     end;
    end;
    simmat(buf1,n,p);
    {-------------------вычисление p(i+1/i)-----------------------------}
    multmat(aa,p,n,n,p1);
    for i:=1 to n do begin
     for j:=1 to n do begin
      ss:=0;
      for kk:=1 to n do ss:=ss+p1[i,kk]*aa[j,kk];
      buf1[i,j]:=ss;
     end;
    end;
    for i:=1 to n do begin
     for j:=1 to n do begin
      buf1[i,j]:=buf1[i,j]+qr[i,j];
     end;
    end;
    simmat(buf1,n,p1);
end; {Procedure Sost}
end.
