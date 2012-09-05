unit fil_wfA;
interface
               Uses ob_wfa{*,textcrt,Tpcrt*};

        type
            t2s=array[1..2] of real;
             t6s=array[1..6] of real;
             t3i=array[1..3] of integer;
             t2i=array[1..2] of integer;
              t3_4s=array[1..3,1..4] of real;
              t3_3s=array[1..3,1..3] of real;
              t3_8s=array[1..3,1..8] of real;
              t3_21s=array[1..3,1..21] of real;
         procedure FIL1 ( var dte:real;   var nj,nko,qpo:integer;
                 var qm:t3_8s  ;   var nf:t3i; mpor:t3_4s);
         procedure FILOGP(var nko,nj:integer;var dte:real;
                  var nf,kfi,kp:t3i;var qm:t3_8s);
         procedure FILR(var i:integer;var dte:real;var ngi:t25i;
               var rk:t3s;var gp:t6s;var qm:t3_8s);
         procedure FILRT(var i:integer;var dte:real;var rk:t3s;
                 var gp:t6s;var qm:t3_8s;var ngi:t25i);
         procedure FILS2         (var nko:integer;var dte:real;var ni,kp,kfi:t3i;
                var po:t3_3s;var gp:t6s;var qm:t3_8s);
         procedure FILSM1(dt:real;kkf:integer;var nko:integer;var uk:t2s;
           var wp,pw,pp:t3_3s;var qp:t3_8s;var ni:t3i);
         procedure MKFIL(dt:real;kkf:integer;var nko:integer;var uk:t2s;
           var wp,pw,pp:t3_3s;var qp:t3_8s;var qp1:t3_21s;var ni:t3i);
         procedure FILZ3(kolkoor:integer;var PRM,NFZ,I:integer;var dte:real;var kp:t3i;
                        VAR RK:T3S;var SFE:t3_3s;var qm:t3_8s; NJZ: T2I);
         procedure F_POZIT(DTNA:real;kolkoor:integer;var PRM,NFZ,I:integer;
                   var dte,ttek:real;var kp:t3i;VAR RK:T3S;var SFE:t3_3s;var qm:t3_8s; NJZ: T2I);
     implementation
{@@@@@@@@@@@@@@@@@@@@@@@@@@@ ‘»À‹“– — Œ√–¿Õ»◊≈Õ»≈Ã œ¿Ãﬂ“» @@@@@@@@@@@@@@@}
{ ‘»À‹“–¿÷»ﬂ –¿«ƒ≈À‹Õ¿ﬂ, Œ›‘‘»÷»≈Õ“€ ‘»À‹“–¿  Œ––≈ “»–”ﬁ“—ﬂ œŒ Œ÷≈Õ ≈   }
{                       »Õ“≈Õ—»¬ÕŒ—“» Ã¿Õ≈¬–¿                           }
procedure FIL1 ;
           var ks1,rok,del,a,b:real;
           var pom:integer;
 begin;
 if nf[nko]=2 then begin;
              qm[nko,8]:=2*(2*nf[nko]+1)/(nf[nko]*(nf[nko]-1));
              qm[nko,8]:=qm[nko,6]*sqrt(1+qm[nko,8]); end;
 nf[nko]:=nf[nko]+1;
 del:=qm[nko,1]-qm[nko,4];  ks1:=qm[nko,1]-qm[nko,5];

  if abs(del)<=qpo*qm[nko,8]
    then begin ;
    pom:=0;
      if nf[nko]<nj then begin ;
                      a:=2*(2*nf[nko]-1)/(nf[nko]*(nf[nko]+1));
                      b:=6/(nf[nko]*(nf[nko]+1));      end
                    else begin  ;
                      a:=2*(2*nj-1)/(nj*(nj+1));
                      b:=6/(nj*(nj+1));                 end;
      end
    else begin;
    pom:=1;    nf[nko]:=2;
       rok:=abs((ks1-qm[nko,7])/qm[nko,6]);
       if rok<mpor[3,1] then begin ; a:=mpor[1,1];b:=mpor[2,1];end  else
       if rok<mpor[3,2] then begin ; a:=mpor[1,2];b:=mpor[2,2];end  else
       if rok<mpor[3,3] then begin ; a:=mpor[1,3];b:=mpor[2,3];end  else
       if rok<mpor[3,4] then begin ; a:=mpor[1,4];b:=mpor[2,4];end  else a:=1;b:=1;
    end;

    qm[nko,2]:=qm[nko,4]+a*del;  qm[nko,3]:=qm[nko,3]+(b/dte)*del;
    qm[nko,5]:=qm[nko,1];        qm[nko,7]:=ks1;
     if pom>0 then qm[nko,8]:=(2*sqr(a)+a*b+2*b)/(2*(4-2*a-b))
              else begin;
                 if nf[nko]<=nj then qm[nko,8]:=2*(2*nf[nko]+1)/(nf[nko]*(nf[nko]-1))
                                else qm[nko,8]:=2*(2*nj+1)/(nj*(nj -1));
              end;
         qm[nko,8]:=qm[nko,6]*sqrt(1+qm[nko,8]);
     end;
  { @@@@@@@@@@@@@@@@@@@@@@@@@@@@@  FILOGP   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
  {–¿«ƒ≈À‹Õ¿ﬂ ‘»À‹“–¿÷»ﬂ;¿ƒ¿œ“»¬Õ€… Œ¡Õ¿–”∆»“≈À‹ Ã¿Õ≈¬–¿ –¿¡Œ“¿≈“ œŒ      }
  {  ÀŒ√»◊≈— »Ã  –»“≈–»ﬂÃ "1 »« 1", "2 »« 2",  ŒÃ¡»Õ»–Œ¬¿ÕÕŒÃ”            }
          procedure FILOGP;
  label lb,lb0,lb1,lb2,kon;
  var kr,qpor:integer;
      a,b,rf,om,sig:real;
  begin
   sig:=qm[nko,6];kr:=kp[3];
   if kfi[nko]=0 then qpor:=kp[1]
                 else qpor:=kp[2];
   om:=sig*sqrt(2*(2*nf[nko]+1)/(nf[nko]*(nf[nko]-1))+1);
   rf:=abs(qm[nko,1]-qm[nko,4]);
   if kr>2 then goto lb1;
lb2:if rf>3*om then goto lb
               else begin
                         if kr=1 then goto lb1
                                 else goto lb0
                    end;
lb1:if rf<=om*qpor then
    begin
        kfi[nko]:=0;goto lb0;
    end;
    kfi[nko]:=kfi[nko]+1;
      if kfi[nko]<2 then goto lb0;
 lb:kfi[nko]:=1;a:=1.0;b:=1.0;nf[nko]:=2;
     qm[nko,3]:=(qm[nko,1]-qm[nko,5])/dte;
     qm[nko,2]:=qm[nko,1];
      goto kon;
 lb0:nf[nko]:=nf[nko]+1;
      if nf[nko]<nj then
       begin
        a:=2*(2*nf[nko]-1)/(nf[nko]*(nf[nko]+1));
        b:=6/(nf[nko]*(nf[nko]+1));
       end
                     else
                 begin
                      a:=2*(2*nj-1)/(nj*(nj+1));
                      b:=6/(nj*(nj-1));
                 end;
      qm[nko,2]:=qm[nko,4]+a*(qm[nko,1]-qm[nko,4]);
      qm[nko,3]:=qm[nko,3]+(b/dte)*(qm[nko,1]-qm[nko,4]);
   kon:qm[nko,5]:=qm[nko,1];
       end;{FILOGP}
 { @@@@@@@@@@@@@@@@@@@@@@@@@@  FILR  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
 { —Œ¬Ã≈—“Õ¿ﬂ ‘»À‹“–¿÷»ﬂ,Œ¡Õ¿–”∆»“≈À‹ Ã¿Õ≈¬–¿ ¬ —‘≈–»◊≈— Œ… —»—“≈Ã≈      }
 {           œ–» Œ¡Õ¿–”∆≈Õ»» Ã¿Õ≈¬–¿ Ã≈Õﬂ≈“—ﬂ √¿ÃÃ¿                      }
       procedure FILR;
 label l1;
 var pe,r:t3s;
     p11,p12,p22,a,b,fi:real;
     j,i1:              integer;
 BEGIN
 if i=3 then
  begin
   rk[1]:=1.0;rk[2]:=1.0/dte;rk[3]:=2.0/sqr(dte);
  end;
   p11:=rk[1];p12:=rk[2];p22:=rk[3];
   for i1:=1 to 3 do
     begin
      r[i1]:=abs(qm[i1,6]-qm[i1,7]);
      if r[i1]>gp[3+i1] then
        begin
         a:=gp[3];gp[1]:=a;ngi[i]:=ngi[i]+1;
         goto l1;
        end;
      end;
         a:=gp[2];gp[1]:=a;
 l1:if i>=3 then
     begin
      pe[1]:=p11+2*p12*dte+p22*sqr(dte);
      pe[2]:=p12+p22*dte;
      pe[3]:=p22;
      fi:=1.0/(a+pe[1]);b:=1.0/a;
      for i1:=1 to 2 do
       rk[i1]:=pe[i1]*fi;
       rk[3]:=b*(pe[3]-fi*sqr(pe[2]));
       for j:=1 to 3 do
        begin
         qm[j,2]:=qm[j,4]+rk[1]*(qm[j,1]-qm[j,4]);
         qm[j,3]:=qm[j,3]+rk[2]*(qm[j,1]-qm[j,4]);
        end; { ÷» À œŒ j }
      end { ÛÒÎÓ‚ËÂ Ò ÏÂÚÍÓÈ l1}
      END;{ filr}
  { @@@@@@@@@@@@@@@@@@@@@@@@@@  FILRT  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
 { —Œ¬Ã≈—“Õ¿ﬂ ‘»À‹“–¿÷»ﬂ,Œ¡Õ¿–”∆»“≈À‹ Ã¿Õ≈¬–¿ ¬ —‘≈–»◊≈— Œ… —»—“≈Ã≈      }
 {  œ–» Œ¡Õ¿–”∆≈Õ»» Ã¿Õ≈¬–¿ Ã≈Õﬂ≈“—ﬂ √¿ÃÃ¿ » —¡–¿—€¬¿≈“—ﬂ œ¿Ãﬂ“‹ ‘»À‹“–¿ }
      procedure FILRT;
  label lf1;
  var r,pe:t3s;
     k,j1: integer;
      a,b,fi,p11,p12,p22,kons:real;
 BEGIN
     a:=gp[2];
 if i=3 then
 begin
   rk[1]:=1.0;rk[2]:=1.0/dte;rk[3]:=2.0/sqr(dte);end;
   p11:=rk[1];p12:=rk[2];p22:=rk[3];
   kons:=(p11+2*p12*dte+p22*sqr(dte))/a+1;
   for j1:=1 to 3 do
    begin
     r[j1]:=abs(qm[j1,6]-qm[j1,7]);
   {  gp[j1+3]:=3.5*qm[j1,8]*sqrt(kons);}
     if r[j1]>gp[j1+3] then
       begin
        a:=gp[3];gp[1]:=a;ngi[i]:=ngi[i]+1;
        rk[1]:=1.0;rk[2]:=1.0/dte;rk[3]:=2.0/sqr(dte);
        p11:=rk[1];p12:=rk[2];p22:=rk[3];
        for k:=1 to  3 do
         begin
          qm[k,2]:=qm[k,1];qm[k,3]:=(qm[k,1]-qm[k,5])/dte;
         end;
         goto lf1;
        end; { œŒ œ–≈¬€ÿ. œŒ–Œ√¿ }
        end;
              a:=gp[2];gp[1]:=a;
    if i>=3 then
     begin
      pe[1]:=p11+2*p12*dte+p22*sqr(dte);
      pe[2]:=p12+p22*dte;
      pe[3]:=p22;
      fi:=1.0/(a+pe[1]);b:=1.0/a;
      for j1:=1 to 2 do
      rk[j1]:=pe[j1]*fi;
      rk[3]:=b*(pe[3]-fi*sqr(pe[2]));
     { IF I>8 THEN BEGIN
      RK[1]:=0.554; RK[2]:=0.173
      END;}{ !!!!!!!!!!!!! }
      for j1:=1 to 3 do
       begin
        qm[j1,2]:=qm[j1,4]+rk[1]*(qm[j1,1]-qm[j1,4]);
        qm[j1,3]:=qm[j1,3]+rk[2]*(qm[j1,1]-qm[j1,4]);
       end;
     end;
    lf1:for j1:=1 to 3 do
       qm[j1,5]:=qm[j1,1];
  END;{ filrt}
  {@@@@@@@@@@@@@@@@@@@@@@@@@@@  FILS2   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
  { –≈ ”––≈Õ“Õ€… À»Õ≈…Õ€… ‘»À‹“– — Œ¡Õ¿–”∆»“≈À≈Ã Ã¿Õ≈¬–¿ »
    –¿«ƒ≈À‹ÕŒ…  ‘»À‹“–¿÷»≈…  ŒŒ–ƒ»Õ¿“. Œ¡Õ¿–”∆»“≈À‹ Ã¿Õ≈¬–¿
    –¿¡Œ“¿≈“  ¿  ŒƒÕŒ- » ƒ¬”’—“”œ≈Õ◊¿“€… }
    procedure FILS2;
 label lb02,lb12,lb22;
  const capa=3;
 var n,qpor:integer;pe:t3s;
    qst,qt,qe,cgq,a,fz,rf,rq,qc,qtc,fi,b:real;
  BEGIN

  qt:=qm[nko,1]; qc:=qm[nko,2]; qtc:=qm[nko,3];
  qe:=qm[nko,4]; qst:=qm[nko,5]; cgq:=qm[nko,6];
  n:=ni[nko];n:=n+1;
  if n=3 then
   begin
     po[nko,1]:=1.0;po[nko,2]:=1.0/dte;po[nko,3]:=2.0/sqr(dte);
     gp[1]:=gp[3];
   end; a:=gp[3];
    pe[1]:=po[nko,1]+2.0*po[nko,2]*dte+po[nko,3]*sqr(dte);
    pe[2]:=po[nko,2]+po[nko,3]*dte;
    pe[3]:=po[nko,3];
    fz:=pe[1]/a+1.0;
    if kp[3]=1 then
     begin
          qpor:=capa; goto lb22;
     end;
     if kfi[nko]>0 then qpor:=kp[2]
                   else qpor:=kp[1];
lb22:rf:=qpor*cgq*sqrt(fz);
     rq:=abs(qe-qt);
     if rq<=rf then
       begin
        kfi[nko]:=0;goto lb02;
        end;
   kfi[nko]:=kfi[nko]+1;
     if kfi[nko]<kp[3] then
      begin
        if kp[3]=1 then
        goto lb02 else begin;
          if rq<3*rf then
          goto lb02
                      end;
      end;
   a:=gp[3];gp[1]:=gp[3];kfi[nko]:=1;
   po[nko,1]:=1;po[nko,2]:=1/dte;po[nko,3]:=2/sqr(dte);
   qc:=qt;qtc:=(qt-qst)/dte;
   goto lb12;
lb02:a:=gp[3];gp[1]:=gp[3];
    fi:=1.0/(a+pe[1]);b:=1.0/a;
    po[nko,1]:=pe[1]*fi;
    po[nko,2]:=pe[2]*fi;
    po[nko,3]:=b*(pe[3]-fi*sqr(pe[2]));
    qc:=qe+po[nko,1]*(qt-qe);
    qtc:=qtc+po[nko,2]*(qt-qe);
lb12:qst:=qt;
    qm[nko,1]:=qt;qm[nko,2]:=qc;qm[nko,3]:=qtc;
    qm[nko,4]:=qe;qm[nko,5]:=qst;
    ni[nko]:=n;
 END;{fils2}
 { @@@@@@@@@@@@@@@@@@@@@@@@@@@@@ FILSM1  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
 { ¿ƒ¿œ“»¬Õ€… –≈ ”––≈Õ“Õ€… À»Õ≈…Õ€… ‘»À‹“–;‘»À‹“–¿÷»ﬂ –¿«ƒ≈À‹Õ¿ﬂ Õ¿ Œ—ÕŒ- }
 { ¬≈ ¡¿…≈—Œ¬— Œ√Œ Œ÷≈Õ»¬¿Õ»ﬂ; ”œ–ŒŸ≈ÕÕ€… ¬¿–»¿Õ“                        }
  procedure FILSM1;
  const p0=0.0;p01=0.01;p02=0.02;p03=0.03;p97=0.97;p98=0.98;
    var m11,m12,m22,aj,bj,zet,usk,pe,sw,p11,p12,p22:t3s;
        zet1,zet2,zet3,k2,k3,sk,p1,p2,p3:real;
        ke,kte,mu11,mu12,mu22,p11n,p22n:real;
        iss:integer;
  begin
   if kkf=3 then
    begin
     usk[1]:=-0.5*uk[2];usk[2]:=0.0;usk[3]:=-uk[2];
    end
            else
    begin
     usk[1]:=-uk[2];usk[2]:=0.0;usk[3]:=0.0;
    end;
    ni[nko]:=ni[nko]+1;
    if ni[nko]=3 then
     begin
      p11[nko]:=sqr(qp[nko,4]);
      p12[nko]:=sqr(qp[nko,4])/dt;
      p22[nko]:=(2.0*sqr(qp[nko,4]))/(sqr(dt));
      qp[nko,5]:=pw[nko,1]*usk[1]+pw[nko,2]*usk[2]+pw[nko,3]*usk[3];
      pp[nko,1]:=p11[nko];pp[nko,2]:=p12[nko];pp[nko,3]:=p22[nko];
      end;
      p11[nko]:=pp[nko,1];p12[nko]:=pp[nko,2];p22[nko]:=pp[nko,3];
      for iss:=1 to 3 do
       begin
        m11[iss]:=p11[nko]+2.0*dt*p12[nko]+sqr(dt)*p22[nko]+
                 0.25*sqr(dt)*sqr(dt)*uk[1];
        m12[iss]:=p12[nko]+dt*p22[nko]+0.5*sqr(dt)*dt*uk[1];
        m22[iss]:=p22[nko]+sqr(dt)*uk[1];
        aj[iss]:=qp[nko,2]+qp[nko,3]*dt+0.5*usk[iss]*sqr(dt);
        bj[iss]:=qp[nko,3]+usk[iss]*dt;
        zet[iss]:=2.0*(sqr(qp[nko,4])+m11[iss]);
        pe[iss]:=exp(-(sqr(qp[nko,1]-aj[iss]))/zet[iss]);
       end;
       zet1:=pw[nko,1];zet2:=pw[nko,2];zet3:=pw[nko,3];
       sw[1]:=pe[1]*(wp[2,2]*zet1+wp[1,2]*zet2+wp[3,2]*zet3);
       sw[2]:=pe[2]*(wp[2,1]*zet1+wp[1,1]*zet2+wp[3,1]*zet3);
       sw[3]:=pe[3]*(wp[2,3]*zet1+wp[1,3]*zet2+wp[3,3]*zet3);
       sk:=sw[1]+sw[2]+sw[3];
          pw[nko,1]:=sw[1]/sk;
          pw[nko,2]:=sw[2]/sk;
          pw[nko,3]:=sw[3]/sk;
        if kkf=2 then
        begin
         if pw[nko,1]>=p98 then
          begin
           pw[nko,1]:=p98;pw[nko,2]:=p02;pw[nko,3]:=p0;
          end;
         if pw[nko,2]>=p98 then
          begin
           pw[nko,2]:=p98;pw[nko,1]:=p02;pw[nko,3]:=p0;
          end;
        end
                  else
          begin
         if pw[nko,2]>=p97 then
          begin
           pw[nko,2]:=p97;pw[nko,1]:=p02;pw[nko,3]:=p01;
          end ;
         if pw[nko,1]>=p97 then
          begin
           pw[nko,1]:=p97;pw[nko,2]:=p03;pw[nko,3]:=p0;
          end;
         if pw[nko,3]>=p97 then
          begin
           pw[nko,3]:=p97;pw[nko,2]:=p03;pw[nko,1]:=p0;
          end;
        end;
       qp[nko,5]:=0.0;ke:=0.0;kte:=0.0;mu11:=0.0;mu12:=0.0;mu22:=0.0;
       zet[1]:=pw[nko,1];zet[2]:=pw[nko,2];zet[3]:=pw[nko,3];
       for iss:=1 to 3 do
        begin
         qp[nko,5]:=qp[nko,5]+zet[iss]*usk[iss];
           ke:=ke+zet[iss]*aj[iss];
           kte:=kte+zet[iss]*bj[iss];
          mu11:=mu11+m11[iss]*zet[iss];
          mu12:=mu12+m12[iss]*zet[iss];
          mu22:=mu22+m22[iss]*zet[iss];
        end;
        k2:=mu11/(sqr(qp[nko,4])+mu11);
        k3:=mu12/(sqr(qp[nko,4])+mu11);
          p11[nko]:=k2*sqr(qp[nko,4]);
          p12[nko]:=k3*sqr(qp[nko,4]);
          p22[nko]:=mu22-k3*mu12;
         p11n:=k2;p22n:=p22[nko]*sqr(dt)/(sqr(qp[nko,4]));
        qp[nko,6]:=ke;
        qp[nko,3]:=kte;
        qp[nko,2]:=qp[nko,6]+k2*(qp[nko,1]-qp[nko,6]);
        qp[nko,3]:=qp[nko,3]+k3*(qp[nko,1]-qp[nko,6]);
      pp[nko,1]:=p11[nko];pp[nko,2]:=p12[nko];pp[nko,3]:=p22[nko];
     end; {FILSM1}
 { @@@@@@@@@@@@@@@@@@@@@@@@@@@@@ MKFIL  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
 { ¿ƒ¿œ“»¬Õ€… –≈ ”––≈Õ“Õ€… À»Õ≈…Õ€… ‘»À‹“–;‘»À‹“–¿÷»ﬂ –¿«ƒ≈À‹Õ¿ﬂ Õ¿ Œ—ÕŒ- }
 { ¬≈ ¡¿…≈—Œ¬— Œ√Œ Œ÷≈Õ»¬¿Õ»ﬂ; œŒÀÕ€… ¬¿–»¿Õ“                        }
         procedure MKFIL;
   const p0=0.0;p01=0.01;p02=0.02;p03=0.03;p97=0.97;p98=0.98;
    var  iss:integer;
         m11,m12,m22,del1,del2,k2,k3,zet,sk:real;
         x3,xt3,x4,xt4,psi11,psi12,psi22:t3_3s;
         pe,zl,usk,sw:t3s;
         p11,p12,p22:t3s;
  begin
   if kkf=3 then
    begin
      usk[1]:=-0.5*uk[2];usk[2]:=0.0;usk[3]:=-uk[2];
    end
            else
    begin
      usk[1]:=-uk[2];usk[2]:=0.0;usk[3]:=0.0;
    end;
    p11[nko]:=pp[nko,1];p12[nko]:=pp[nko,2];p22[nko]:=pp[nko,3];
    ni[nko]:=ni[nko]+1;
    if ni[nko]=3 then
     begin
      pp[nko,1]:=1.0;pp[nko,2]:=1.0/dt;pp[nko,3]:=2.0/dt/dt;
      p11[nko]:=pp[nko,1];p12[nko]:=pp[nko,2];p22[nko]:=pp[nko,3];
      for iss:=1 to 3 do
       begin
        x3[nko,iss]:=qp[nko,2];
        xt3[nko,iss]:=qp[nko,3];
        psi11[nko,iss]:=sqr(qp[nko,4]);
        psi12[nko,iss]:=sqr(qp[nko,4])/dt;
        psi22[nko,iss]:=2.0*sqr(qp[nko,4])/sqr(dt);
        qp1[nko,iss]:=x3[nko,iss];
        qp1[nko,iss+3]:=xt3[nko,iss];
        qp1[nko,iss+6]:=0.0;
        qp1[nko,iss+9]:=0.0;
        qp1[nko,iss+12]:=psi11[nko,iss];
        qp1[nko,iss+15]:=psi12[nko,iss];
        qp1[nko,iss+18]:=psi22[nko,iss];
       end;
     end;
       for iss:=1 to 3 do
        begin
         x3[nko,iss]:=qp1[nko,iss];
         xt3[nko,iss]:=qp1[nko,iss+3];
         x4[nko,iss]:=qp1[nko,iss+6];
         xt4[nko,iss]:=qp1[nko,iss+9];
         psi11[nko,iss]:=qp1[nko,iss+12];
         psi12[nko,iss]:=qp1[nko,iss+15];
         psi22[nko,iss]:=qp1[nko,iss+18];
         m11:=psi11[nko,iss]+2.0*dt*psi12[nko,iss]+sqr(dt)*psi22[nko,iss]+
              0.25*uk[1]*sqr(dt)*sqr(dt);
         m12:=psi12[nko,iss]+dt*psi22[nko,iss]+0.5*uk[1]*sqr(dt);
         m22:=psi22[nko,iss]+sqr(dt)*uk[1];
         x4[nko,iss]:=x3[nko,iss]+xt3[nko,iss]*dt+0.5*usk[iss]*sqr(dt);
         xt4[nko,iss]:=xt3[nko,iss]+usk[iss]*dt;
         k2:=m11/(m11+sqr(qp[nko,4]));
         k3:=m12/(m11+sqr(qp[nko,4]));
         psi11[nko,iss]:=k2*sqr(qp[nko,4]);
         psi12[nko,iss]:=k3*sqr(qp[nko,4]);
         psi22[nko,iss]:=m22-k3*m12;
         x3[nko,iss]:=x4[nko,iss]+k2*(qp[nko,1]-x4[nko,iss]);
         xt3[nko,iss]:=xt4[nko,iss]+k3*(qp[nko,1]-x4[nko,iss]);
         zet:=2.0*(sqr(qp[nko,4])+m11);
         pe[iss]:=exp(-(sqr(qp[nko,1]-x4[nko,iss]))/zet);
        end;
        zl[1]:=pw[nko,1];zl[2]:=pw[nko,2];zl[3]:=pw[nko,3];
        sw[1]:=pe[1]*(wp[2,2]*zl[1]+wp[1,2]*zl[2]+wp[3,2]*zl[3]);
        sw[2]:=pe[2]*(wp[2,1]*zl[1]+wp[1,1]*zl[2]+wp[3,1]*zl[3]);
        sw[3]:=pe[3]*(wp[2,3]*zl[1]+wp[1,3]*zl[2]+wp[3,3]*zl[3]);
        sk:=sw[1]+sw[2]+sw[3];
          pw[nko,1]:=sw[1]/sk;
          pw[nko,2]:=sw[2]/sk;
          pw[nko,3]:=sw[3]/sk;
        if kkf=2 then
        begin
         if pw[nko,1]>=p98 then
          begin
           pw[nko,1]:=p98;pw[nko,2]:=p02;pw[nko,3]:=p0;
          end;
         if pw[nko,2]>=p98 then
          begin
           pw[nko,2]:=p98;pw[nko,1]:=p02;pw[nko,3]:=p0;
          end;
        end
                  else
          begin
         if pw[nko,2]>=p97 then
          begin
           pw[nko,2]:=p97;pw[nko,1]:=p02;pw[nko,3]:=p01;
          end ;
         if pw[nko,1]>=p97 then
          begin
           pw[nko,1]:=p97;pw[nko,2]:=p03;pw[nko,3]:=p0;
          end;
         if pw[nko,3]>=p97 then
          begin
           pw[nko,3]:=p97;pw[nko,2]:=p03;pw[nko,1]:=p0;
          end;
        end;
        qp[nko,5]:=0.0;qp[nko,2]:=0.0;qp[nko,3]:=0.0;
        zl[1]:=pw[nko,1];zl[2]:=pw[nko,2];zl[3]:=pw[nko,3];
        p11[nko]:=0.0;p12[nko]:=0.0;p22[nko]:=0.0;
        for iss:=1 to 3 do
        begin
         qp[nko,2]:=qp[nko,2]+zl[iss]*x3[nko,iss];
         qp[nko,3]:=qp[nko,3]+zl[iss]*xt3[nko,iss];
        end;
        for iss:=1 to 3 do
         begin
          del1:=qp[nko,2]-x3[nko,iss];
          del2:=qp[nko,3]-xt3[nko,iss];
          p11[nko]:=p11[nko]+zl[iss]*(psi11[nko,iss]+sqr(del1));
          p12[nko]:=p12[nko]+zl[iss]*(psi12[nko,iss]+del1*del2);
          p22[nko]:=p22[nko]+zl[iss]*(psi22[nko,iss]+sqr(del2));
          qp[nko,5]:=qp[nko,5]+zl[iss]*usk[iss];
          psi11[nko,iss]:=psi11[nko,iss]+sqr(del1);
          psi12[nko,iss]:=psi12[nko,iss]+del1*del2;
          psi22[nko,iss]:=psi22[nko,iss]+sqr(del2);
          qp1[nko,iss]:=x3[nko,iss];
          qp1[nko,iss+3]:=xt3[nko,iss];
          qp1[nko,iss+6]:=x4[nko,iss];
          qp1[nko,iss+9]:=xt4[nko,iss];
          qp1[nko,iss+12]:=psi11[nko,iss];
          qp1[nko,iss+15]:=psi12[nko,iss];
          qp1[nko,iss+18]:=psi22[nko,iss];
         end;
      pp[nko,1]:=p11[nko];pp[nko,2]:=p12[nko];pp[nko,3]:=p22[nko];
   end;   { MKFIL }
  {@@@@@@@@@@@@@@@@@@@@@@@@@@@  FILZ3   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
  procedure FILZ3;
  { PPF=9; ŒƒÕŒ¬–≈Ã≈ÕÕ¿ﬂ ‘»À‹“–¿÷»ﬂ — ¿ƒ¿œ“»¬Õ€Ã Œ¡Õ¿–”∆»“≈À≈Ã Ã¿Õ≈¬–¿
    »  Œ––≈ “»–Œ¬ Œ…  Œ›‘‘»÷»≈Õ“Œ¬ ”—»À≈Õ»ﬂ —Õ»«” }
 label lZ1,lZ2,lZ3,LED;
 var K,KFI:integer;pe:t3s;
         KOEF1,KOEF2,
         a,fz,rfB,rfH,rq,fi,b:real;

  BEGIN

  if I=3 then
   begin
     RK[1]:=1.0;RK[2]:=1.0/dte;RK[3]:=2.0/sqr(dte);
     NFZ:=2;  PRM:=0;

   end;
   a:=1;  KFI:=0;
    pe[1]:=RK[1]+2.0*RK[2]*dte+RK[3]*sqr(dte);
    pe[2]:=RK[2]+RK[3]*dte;
    pe[3]:=RK[3];
    fz:=pe[1]/a+1.0;
         {Œ¡Õ¿–”∆»“≈À‹ Ï‡Ì∏‚‡}
    FOR K:=1 TO kolkoor DO        { Õ¿◊¿ÀŒ ÷» À¿ œŒ  ŒŒ–ƒ»Õ¿“¿Ã}
     begin
     rq:=abs(SFE[K,2]-SFE[K,1]); { œŒÀ”◊≈Õ»≈ Õ≈¬ﬂ« » ¬ —‘.—»—“ }
       rfB:=KP[1]*SFE[K,3]*sqrt(fz);    { ¬€—Œ »… œŒ–Œ√ }
     if rq>=rfB then  GOTO LZ1;
       rfH:=KP[2]*SFE[K,3]*sqrt(fz);     { Õ»« »… œŒ–Œ√ }
     if rq>=rfH then  KFI:=KFI+1;    { —◊≈“◊»  Œ¡Õ.Ã¿Õ≈¬–¿ }
     END;                            {  ŒÕ≈÷ ÷» À¿ œŒ  ŒŒ–ƒ»Õ¿“¿Ã }

         IF KFI > 1 THEN BEGIN  { Ã¿Õ≈¬– Œ¡Õ¿–”∆≈Õ }
  LZ1:  NFZ:= NJZ[2];   PRM:=1;
        RK[1]:=2*(2*NFZ-1)/(NFZ*(NFZ+1));
        RK[2]:=6/(NFZ*(NFZ+1)*DTE);
        RK[3]:=12/( SQR(DTE)*NFZ*( SQR(NFZ)-1));
        KOEF1:=RK[1];
        KOEF2:=RK[2];
        GOTO LZ2;        END

        ELSE BEGIN              { Ã¿Õ≈¬– Õ≈ Œ¡Õ¿–”∆≈Õ }

        NFZ:=NFZ+1;      PRM:=0;
       fi:=1.0/(a+pe[1]);b:=1.0/a;
       FOR K:=1 TO 2 DO
        RK[K]:=PE[K]*FI;
        RK[3]:=b*(pe[3]-fi*sqr(pe[2]));
        koef1:=rk[1]; koef2:=rk[2];
    IF NFZ > NJZ[1]  THEN BEGIN
         KOEF1:= 2*(2*nJZ[1]-1)/(nJZ[1]*(nJZ[1]+1));
         KOEF2:= 6/(nJZ[1]*(nJZ[1]+1)*DTE);
         goto LED;
                           END;
             END;


 LZ2: { koef1:=2*(2*i-1)/(i*(i+1)); koef2:=6/(i*(i+1)*dte);} {‚‡Ë‡ÌÚ ≈‰‡ÏÂÌÍÓ}
 LED:      rk[1]:=koef1;rk[2]:=koef2;
    FOR K:=1 TO kolkoor DO BEGIN
           qM[K,2]:=qM[K,4]+KOEF1*(qM[K,1]-qM[K,4]);
           IF NFZ=2 THEN QM[K,3]:=(QM[K,1] - QM[K,5])/DTE
              else
                qM[K,3]:=qM[K,3] +KOEF2*(qM[K,1]-qM[K,4]);
                QM[K,5]:= QM[K,1];
                            END;
 END;{filZ3}
   {@@@@@@@@@@@@@@@@@@@@@@@@@@@  F_POZIT   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
  procedure F_POZIT;
  { PPF=9; ŒƒÕŒ¬–≈Ã≈ÕÕ¿ﬂ ‘»À‹“–¿÷»ﬂ — ¿ƒ¿œ“»¬Õ€Ã Œ¡Õ¿–”∆»“≈À≈Ã Ã¿Õ≈¬–¿
    »  Œ––≈ “»–Œ¬ Œ…  Œ›‘‘»÷»≈Õ“Œ¬ ”—»À≈Õ»ﬂ —Õ»«”
    ËÁ FILZ3  ‰Îˇ ÔÓ‚ÂÍË "œŒ«»“»¬ Ã›" }
 label lZ1,lZ2,lZ3;
 const alfa=0.8;beta=0.8;
 var K,KFI:integer;pe:t3s;
         KOEF1,KOEF2,rab,
         a,fz,rfB,rfH,rq,fi,b:real;
  BEGIN
  if I=3 then
   begin
     RK[1]:=1.0;RK[2]:=1.0/dte;RK[3]:=2.0/sqr(dte);
     NFZ:=2;  PRM:=0;
   end;
   a:=1;  KFI:=0;
    pe[1]:=RK[1]+2.0*RK[2]*dte+RK[3]*sqr(dte);
    pe[2]:=RK[2]+RK[3]*dte;
    pe[3]:=RK[3];
    fz:=pe[1]/a+1.0;
    FOR K:=1 TO kolkoor DO        { Õ¿◊¿ÀŒ ÷» À¿ œŒ  ŒŒ–ƒ»Õ¿“¿Ã}
     begin
     rq:=abs(SFE[K,2]-SFE[K,1]); { œŒÀ”◊≈Õ»≈ Õ≈¬ﬂ« » ¬ —‘.—»—“ }
(*     kp[1]:=4;{ÚÓÎ¸ÍÓ ‰Îˇ ÔÓÍ‡Á‡}*)
       rfB:=KP[1]*SFE[K,3]*sqrt(fz);    { ¬€—Œ »… œŒ–Œ√ }
     if rq>=rfB then  GOTO LZ1;
(*       rfH:=KP[2]*SFE[K,3]*sqrt(fz);     { Õ»« »… œŒ–Œ√ }
     if rq>=rfH then  KFI:=KFI+1;*)    { —◊≈“◊»  Œ¡Õ.Ã¿Õ≈¬–¿ }
     END;                            {  ŒÕ≈÷ ÷» À¿ œŒ  ŒŒ–ƒ»Õ¿“¿Ã }

         IF KFI > 1 THEN BEGIN  { Ã¿Õ≈¬– Œ¡Õ¿–”∆≈Õ }
  LZ1:  NFZ:= NJZ[2];   PRM:=1;
        RK[1]:=2*(2*NFZ-1)/(NFZ*(NFZ+1));
        RK[2]:=6/(NFZ*(NFZ+1)*DTE);
        RK[3]:=12/( SQR(DTE)*NFZ*( SQR(NFZ)-1));
        KOEF1:=RK[1];
        KOEF2:=RK[2];
        GOTO LZ2;        END

        ELSE BEGIN              { Ã¿Õ≈¬– Õ≈ Œ¡Õ¿–”∆≈Õ }

        NFZ:=NFZ+1;      PRM:=0;
       fi:=1.0/(a+pe[1]);b:=1.0/a;
       FOR K:=1 TO 2 DO
        RK[K]:=PE[K]*FI;
        RK[3]:=b*(pe[3]-fi*sqr(pe[2]));
        rk[1]:=alfa; rk[2]:=beta/dte;
        koef1:=rk[1]; koef2:=rk[2];
    IF NFZ > NJZ[1]  THEN BEGIN
         KOEF1:= 2*(2*nJZ[1]-1)/(nJZ[1]*(nJZ[1]+1));
         KOEF2:= 6/(nJZ[1]*(nJZ[1]+1)*DTE);
         koef1:=alfa; koef2:=beta/dte;
                         END;
             END;


  LZ2:  rab:=(ttek-DTNA)/dte;
        rk[1]:=2*(2*rab+1)/((rab+1)*(rab+2));
        rk[2]:=6/((rab+1)*(rab+2)*dte);
        koef1:=2*(2*rab+1)/((rab+1)*(rab+2));
        koef2:=6/((rab+1)*(rab+2)*dte);
(*        if i=5 then
        rab:=5+2
        else} rab:=NFZ;
         KOEF1:= 2*(2*rab-1)/(rab*(rab+1));
         KOEF2:= 6/(rab*(rab+1)*DTE);
         koef1:=alfa; koef2:=beta/dte; *)
         rk[1]:=koef1; rk[2]:=koef2;
  FOR K:=1 TO kolkoor DO BEGIN
           qM[K,2]:=qM[K,4]+KOEF1*(qM[K,1]-qM[K,4]);
           IF NFZ=2 THEN QM[K,3]:=(QM[K,1] - QM[K,5])/DTE
              else
                qM[K,3]:=qM[K,3] +KOEF2*(qM[K,1]-qM[K,4]);
                QM[K,5]:= QM[K,1];
                            END;
 END;{f_pozit}
  end .
