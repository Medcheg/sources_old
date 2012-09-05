Unit traektor;
Interface
uses DAN_CKO;
(*  const rz=6370;
   Type
    mfarr=array[1..1,1..10] of integer;
    mdarr=array[1..1,1..25] of real;
    mvarr=array[1..1,1..7] of real ;
    mqarr=array[1..1,1..27] of real ;
    mtearr=array[1..18,1..1] of real;
    darr=array[1..1] of real;
    parr=array[1..1] of integer;*)
 Procedure linea(k,v,h,ha:real;var Dg,tn,Ttek,D,P,E,X,Y,Z:real);
 Procedure linea_a(k,v,h,ha:real;var Dg,tn,Ttek,D,P,E,X,Y,Z,vtek:real;
                   a,tba,dta:real);
 Procedure Pikrad(Tb,v,k,Ha:real;b,rad:integer;
                   var t,Dg,yh,d,p,e,h,x,y,z:real;var p1:integer);
 Procedure krug(thm,h0,ra,x0,y0,f,vb,w,ha:real;pr:integer;
                                 var tb,x,y,h,k,d,p,e,t:real);
 Procedure krug1(x,y,p,k,v,al,ra,h:real;pr:integer;
                var x0,y0,vb,w,f,h0:real;var prb,mzh:integer);
 Procedure Zmeika1(var ha,v,al1,al2,r1,r2,al,t1,t2,t3,t11,t22,dt:real;
                   var pr1,pr2:integer;
                   var h,k,tb,tn,t,d,p,e,x,y,z,x0,y0,dg,vb,w,f,h0,thm:real;
                   var prb,p1,mzh:integer);
 Procedure USL1(v,dn,hn,h,zn,al:real;n,ntr:integer;
                       var dp,fi1:real;var q:mqarr;var te:mtearr);
 Procedure tras4(n:integer;v:real; var t,x,y:real;
                              q:mqarr;var te:mtearr);
 Procedure Tras3(npl,n,n2:integer;tn,dt:real;
                var t,d,p,e,x1,y,z1,v:real;var te:mtearr;var q:mqarr);
 Procedure Trassa1(var n:integer;var t,tb,d,p,e,
                                             x,y,z,vtek,dg,h,ha:real;
                    var mf:mfarr;var md:mdarr;var mv:mvarr;var mq:mqarr;
                    var mte:mtearr);
 Implementation
  Procedure linea(k,v,h,ha:real;var Dg,tn,Ttek,D,P,E,X,Y,Z:real);
 {----------------------------------------------------}
 {    Расчет текущих координат линейной траектории    }
 {             на постоянной высоте                   }
 {   Ttek - текущее время;      Tn - начальное;       }
 {       (при первом обращении Tn:=0;)                }
 {   V - скорость;    H - высота;     К - курс;       }
 {   Dg - гориз. дальность; Ha - высота антены;       }
 {   Выходные параметры:                              }
 {   D,P,E - дальность,пеленг,угол места;             }
 {   X,Y,Z - прямоугольные координаты;                }
 {----------------------------------------------------}
  Var dt,r:real;
  Begin
    if tn=0 then
      begin
          x:=dg*cos(p);y:=dg*sin(p);
      end;
    dt:=Ttek-Tn;
    X:=X+V*dt*Cos(K);   Y:=Y+V*dt*sin(k);
    P:=ArcTan(Abs(Y/X));
   if (x>0) and (y<0) then p:=2*pi-p;
   if (x<0) and (y>0) then p:=pi-p;
   if (x<0) and (y<0) then p:=pi+p;
    dg:=sqrt(sqr(x)+sqr(y));
    z:=sqrt(sqr(rz+h)-sqr(dg))-rz-Ha;
    d:=sqrt(sqr(dg)+sqr(z));r:=z/d;
    e:=ArcTan(r/sqrt(1-sqr(r)));
    Tn:=Ttek;
  End;
 Procedure Linea_a(k,v,h,ha:real;var Dg,tn,Ttek,D,P,E,X,Y,Z,vtek:real;
                   a,tba,dta:real);
      label a1,a2;
      Var dt,r:real;
      rab,
      rr1,rr2,rr3,rr4,rr5:extended;
   BEGIN
         r:=0;
         if ttek>tba then
         if ttek<tba+dta then r:=a;
         if tn=0 then
                  begin
              x:=dg*cos(p); y:=dg*sin(p);
                  end;
         dt:=Ttek-Tn;
         X:=X+(Vtek*dt+r*sqr(dt)/2)*cos(k);
         Y:=Y+(Vtek*dt+r*sqr(dt)/2)*sin(k);
         V:=Vtek+r*dt;
         vtek:=v;
    a2:
         P:=Arctan(abs(Y/X));
         if (x>0) and (y<0) then p:=2*pi-p;
         if (x<0) and (y>0) then p:=pi-p;
         if (x<0) and (y<0) then p:=pi+p;
         dg:=sqrt(sqr(x)+sqr(y));
         rr1:=rz+h;
         rr2:=sqr(rr1);
         rr3:=sqr(dg);
         rr4:=rr2-rr3;
         rr1:=sqrt(rr4);
         rr5:=rr1-rz;
         z:=rr5-ha;
{         z:=sqrt(sqr(rz+h)-sqr(dg))-rz-ha;}
         d:=sqrt(sqr(dg)+sqr(Z)); rab:=z/d;
         e:=arctan(z/dg);
{         e:=arctan(rab/sqrt(1-sqr(rab)));}
         tn:=ttek;
   END;
 Procedure Pikrad(Tb,v,k,Ha:real;b,rad:integer;
                   var t,Dg,yh,d,p,e,h,x,y,z:real;var p1:integer);
   Label m1;
   Var r,dt:real;
  Begin
      if p1=1 then
        begin
          z:=sqrt(sqr(rz+h)-sqr(Dg))-rz-Ha;
          d:=sqrt(sqr(Dg)+sqr(z));r:=z/d;
          e:=arctan(r/sqrt(1-sqr(r)));
          x:=Dg*cos(p);y:=Dg*sin(p);
          p1:=2;
        end; { для P1 }
      if rad=1 then
       begin
          yh:=e;k:=p+pi; rad:=2;
       end;
     dt:=tb-t;x:=x+(v*dt)*cos(k)*cos(yh);
     y:=Y+(v*dt)*sin(k)*cos(yh);
     z:=z-(v*dt)*b*sin(yh);
     if rad=2 then goto m1;
     if x=0 then
        begin
           if y>=0 then
              p:=pi/2 else p:=2*pi-pi/2;
           goto m1;
        end;
    p:=arctan(abs(y/x));
    if (x>0) and (y<0) then p:=2*pi-p;
    if (x<0) and (y>0) then p:=pi-p;
    if (x<0) and (y<0) then p:=pi+p;
   m1:
    Dg:=sqrt(x*x+y*y);
    d:=sqrt(dg*dg+z*z);
    r:=z/d;
    e:=ArcTan(r/Sqrt(1-Sqr(r)));
    h:=sqrt(sqr(rz+Ha)+sqr(d)+2*(rz+ha)*d*Sin(e))-rz;
    T:=Tb;
  end;

 Procedure krug(thm,h0,ra,x0,y0,f,vb,w,ha:real;pr:integer;
                                 var tb,x,y,h,k,d,p,e,t:real);
  var xb,yb,r,z,dg:real;
 Begin
   r:=w*(tb-thm)*pr+f;
   k:=r+pi/2*pr;
   xb:=ra*cos(r);yb:=ra*sin(r);x:=x0+xb;y:=y0+yb;
   p:=arctan(abs(y/x));
    if (x>0) and (y<0) then p:=2*pi-p;
    if (x<0) and (y>0) then p:=pi-p;
    if (x<0) and (y<0) then p:=pi+p;
   dg:=sqrt(x*x+y*y);
   h:=h0+vb*(tb-thm);
   z:=sqrt(sqr(rz+h)-sqr(dg))-rz-ha;
   d:=sqrt(sqr(dg)+sqr(z));
   r:=z/d;e:=arctan(r/sqrt(1-r*r));
   t:=tb
 end;

 Procedure krug1(x,y,p,k,v,al,ra,h:real;pr:integer;
                var x0,y0,vb,w,f,h0:real;var prb,mzh:integer);
 Var dx,dy,r:real;
 Begin
   dx:=ra*sin(k);dy:=ra*cos(k);
   x0:=x-dx*pr;y0:=y+dy*pr;f:=k-pi/2*pr;
   vb:=sqrt(v*v-sqr(v*cos(al)));
   vb:=mzh*vb;
   w:=v/ra;h0:=h;prb:=1;
 end;

Procedure Zmeika1(var ha,v,al1,al2,r1,r2,al,t1,t2,t3,t11,t22,dt:real;
                   var pr1,pr2:integer;
                   var h,k,tb,tn,t,d,p,e,x,y,z,x0,y0,dg,vb,w,f,h0,thm:real;
                   var prb,p1,mzh:integer);
  Label l,l2,l3,l4,l9,l0,l10;
    Var r,tb1,vl1:real;
  Begin
            if p1=0 then begin
         vl1:=v*cos(al);
         x:=dg*cos(p);
         y:=dg*sin(p);
         z:=sqrt(sqr(rz+h)-dg*dg)-rz-ha;
         d:=sqrt(dg*dg+z*z);
         r:=z/d;
         e:=ArcTan(r/sqrt(1-r*r));
         t11:=r1*al1/vl1;t22:=r2*al2/vl1;
         p1:=1
        end;tb1:=tb;tb:=t;
   l:  tb:=tb+dt;
   l10: if (tb-tn)<t1 then goto l9;
     if p1<>1 then goto l2;
     p1:=2;
     Krug1(x,y,p,k,v,al,r1,h,pr1,x0,y0,vb,w,f,h0,prb,mzh);
     thm:=tb;
   l2:  if (tb-tn)>=(tn+t1+t11) then goto l4;
       krug(thm,h0,r1,x0,y0,f,vb,w,ha,pr1,tb,x,y,h,k,d,p,e,t);
       dg:=sqrt(x*x+y*y);
       z:=sqrt(sqr(rz+h)-dg*dg)-rz-ha;
       goto l0;
   l4:  if ((tb-tn)<(tn+t1+t11+t2)) or (r2<0.01) then goto l9;
        if p1<>2 then goto l3;
        p1:=3;
         Krug1(x,y,p,k,v,al,r2,h,pr2,x0,y0,vb,w,f,h0,prb,mzh);
        thm:=tb; goto l0;
   l3:  if(tb-tn)>=(tn+t1+t11+t2+t22) then goto l9;
        krug(thm,h0,r2,x0,y0,f,vb,w,ha,pr2,tb,x,y,h,k,d,p,e,t);
       dg:=sqrt(x*x+y*y);
       z:=sqrt(sqr(rz+h)-dg*dg)-rz-ha;
        goto l0;
   l9:  linea(k,V,H,ha,Dg,T,Tb,D,P,E,X,Y,Z);
   l0:  if (tb1<1e10) then
          begin
            if ((tb1-tb)>(dt/100)) then goto l
             else
               begin
                  tb:=tb1;tb1:=1e20;goto l10
               end
          end
   end;
 Procedure USL1;
       Label u1,u2,u3,u4,u5,u6;
       Var ro,r1,h3,y5,fi2,r2,ya,r3,t,x4,td1,t2,
                              t4,t5,t1,dm:real;
                                     sro:integer;
 Begin
       ro:=v*v/0.08;r1:=ro;h3:=abs(h-hn)*0.5;
        if ntr=1 then goto u1;
        if ntr=2 then goto u2;
        if ntr=3 then goto u3;
     u1: sro:=1;
       if h3<=1.0E-5 then sro:=-1;
         y5:=h*0.5;fi2:=Arctan(y5/dp);r2:=y5/(1-cos(fi2));
       if r2>ro then goto u4;
         r2:=ro;ya:=y5/ro;r3:=sqrt(2*ya-ya*ya);
         fi2:=Arctan(r3/sqrt(1+r3*r3));
       if fi2>1.0E-6 then dp:=y5/(sin(fi2)/cos(fi2)); goto u4;
    u2: r2:=ro;sro:=-1;fi2:=0;y5:=h;goto u4;
    u3: fi2:=fi1;fi1:=0;r2:=0;y5:=h;t1:=0;
       if fi2<=1.0E-6 then t1:=2*dn/v;
        fi2:=Arctan(y5/dn);
       goto u6;
   u4: if h3<=1.0E-5 then goto u5;
          r1:=h3/(1-cos(fi1));
       if r1>ro then goto u5;
         r3:=sqrt(0.5*h3/ro);
         fi1:=2*ArcTan(r3/sqrt(1+r3*r3));r1:=ro;
   u5:  x4:=dp+r2*sin(fi2);dm:=x4+2*r1*sin(fi1);
        t1:=(dn-dm)/v;
       if t1<0  then t1:=0;
   u6:  td1:=r1*fi1/v;t2:=t1+td1;t4:=t2+td1;t5:=t4+r2*fi2/v;
        q[n,1]:=dn;q[n,2]:=dm;q[n,3]:=dp;q[n,4]:=hn;q[n,5]:=h;
        q[n,6]:=fi1;q[n,7]:=sro;q[n,8]:=zn;q[n,9]:=cos(al);
        q[n,10]:=sin(al);q[n,13]:=t1;q[n,14]:=t2;q[n,15]:=t4;
        q[n,16]:=t5;q[n,17]:=y5;q[n,18]:=x4;q[n,19]:=cos(fi2);
        q[n,20]:=sin(fi2);q[n,21]:=r1;q[n,22]:=r2;q[n,23]:=v/r1;
      if r2>1.0e-5 then q[n,24]:=v/r2; te[4,n]:=v
END;
Procedure tras4;
   label u11,u12,u14,u15,u16,u17;
   Var sro:integer;
       t1,t2,t4,t5,ro,xc,yc,fi,dx:real;
  Begin
        sro:=round(q[n,7]);t1:=q[n,13];t2:=q[n,14];
        t4:=q[n,15];t5:=q[n,16];
       if t>=t1 then goto u11;
        x:=q[n,1]-v*t;y:=q[n,4]; goto u17;
      u11:  if t>=t2 then goto u12;
         ro:=q[n,21];xc:=q[n,2];yc:=q[n,4]+sro*ro;
         fi:=sro*(pi*(0.5+sro)-q[n,23]*(t-t1));
         goto u16;
      u12: if t>=t4 then goto u14;
         ro:=q[n,21];xc:=q[n,18];yc:=q[n,5]-sro*ro;
         fi:=-sro*(pi*(0.5-sro)+q[n,6]-q[n,23]*(t-t2));
         goto u16;
     u14:  if t>=t5 then goto u15;
           ro:=q[n,22];xc:=q[n,18];yc:=q[n,5]-ro;
           fi:=pi*0.5+q[n,24]*(t-t4);
           goto u16;
    u15:  dx:=v*(t-t5);x:=q[n,3]-dx*q[n,19];
          y:=q[n,17]-dx*q[n,20];
          goto u17;
    u16:  x:=xc+ro*cos(fi);y:=yc+ro*sin(fi);
    u17:  te[16,n]:=x;te[17,n]:=y;
  End;
Procedure Tras3;
   label l1,l2,l3,l4,l5,l6,l7,l8,l18,l21,l22,l41;
   Var  ti,ca,sa,z,x,c,x2,tp:real;
 Begin
    ti:=0;
    v:=te[4,n];
    ca:=q[n,9];sa:=q[n,10];
    if t>tn then goto l4;
    tras4(n,v,t,x,y,q,te);
    z:=q[n,8];
      if npl=1 then goto l6;
      if npl=2 then goto l7;
      if npl=3 then goto l8;
   l7: z:=y;y:=q[n,8];goto l6;
   l8: tras4(n2,v,t,x2,z,q,te);
   l6: x1:=-x*ca+z*sa;z1:=-x*sa-z*ca;
       d:=sqrt(x1*x1+y*y+z1*z1);c:=y/d;
       e:=arctan(c/sqrt(1+c*c));
       p:=arctan(abs(z1/x1));
      if (x1>0) and (z1<0) then p:=2*pi-p;
      if (x1<0) and (z1>0) then p:=pi-p;
       if (x1<0) and (z1<0) then p:=pi+p;
      goto l18;
   l4: ti:=t;t:=te[18,n];
   l41: t:=t+dt;
         if ti<1e10 then
          begin
           if (ti-t)>dt/100 then goto l21
             else
               begin
                 t:=ti;ti:=1e20;goto l21
               end
          end;
      d:=te[1,n];p:=te[2,n];e:=te[3,n];
      x1:=te[7,n];y:=te[8,n];z1:=te[9,n];
      goto l22;
   l21: tras4(n,v,t,x,y,q,te);
       if npl=1 then goto l1;
       if npl=2 then goto l2;
       if npl=3 then goto l3;
   l1: z:=q[n,8];goto l5;
   l2: z:=y;y:=q[n,8];goto l5;
   l3: tras4(n2,v,t,x2,y,q,te);
       z:=te[2,n2];x:=(x+x2)*0.5;
   l5: x1:=-x*ca+z*sa;
       z1:=-x*sa-z*ca;
       d:=sqrt(x1*x1+y*y+z1*z1);
       c:=y/d;e:=arctan(c/sqrt(1+c*c));
       p:=arctan(abs(z1/x1));
        if (x1>0) and (z1<0) then p:=2*pi-p;
        if (x1<0) and (z1>0) then p:=pi-p;
        if (x1<0) and (z1<0) then p:=pi+p;
   l18: te[1,n]:=d;te[2,n]:=p;te[3,n]:=e;te[7,n]:=x1;te[8,n]:=y;
        te[9,n]:=z1;te[18,n]:=t;
         if ti=0 then goto l22;
      goto l41;
  l22:
end;
Procedure Trassa1;
    Label met;
    Var dt:real;
    Begin
        if h<0 then goto met;
        if md[n,3]>tb then goto met;
       if (mf[n,1]=1) or (mf[n,1]=2) then
           begin
             if mf[n,3]=0 then
                begin
                  usl1(md[n,4],md[n,6],md[n,5],md[n,10],md[n,11],md[n,8],
                         n,mf[n,1],md[n,7],md[n,12],mq,mte);
                  tras3(mf[n,5],n,mf[n,6],md[n,3],md[n,2],md[n,3],
                  d,p,e,x,h,y,md[n,4],mte,mq);
                  z:=h;
                  mf[n,3]:=1
                end;
                  dt:=tb-md[n,3];
                  tras3(mf[n,5],n,mf[n,6],md[n,3],md[n,2],dt,
                        d,p,e,x,h,y,md[n,4],mte,mq);
                 z:=h;
                 t:=tb;goto met
           end;
       if mf[n,1]=3 then
           begin
           if t=md[n,3] then vtek:=md[n,4];
             (*  Linea(md[n,8],md[n,4],h,ha,md[n,6],t,tb,d,p,e,x,y,z);*)
             linea_a(md[n,8],md[n,4],h,ha,md[n,6],t,tb,d,p,e,x,y,z,vtek,md[n,21],
                     md[n,22],md[n,23]);
               goto met;
           end;
       if (mf[n,1]=4) or (mf[n,1]=5) then
           begin
              pikrad(tb,md[n,4],md[n,8],ha,mf[n,10],mf[n,9],
                     t,md[n,6],md[n,9],d,p,e,h,x,y,z,mf[n,2]);
              goto met;
           end
        else


    zmeika1(ha,md[n,4],md[n,12],md[n,14],md[n,15],md[n,16],md[n,17],
            md[n,18],md[n,19],md[n,20],md[n,21],md[n,22],md[n,2],
            mf[n,7],mf[n,8],h,md[n,8],tb,md[n,3],t,d,p,e,x,y,z,mv[n,1],mv[n,2],
            md[n,6],mv[n,3],mv[n,4],mv[n,5],mv[n,6],mv[n,7],
            mf[n,4],mf[n,3],mf[n,10]);
    met:
End;
End.
