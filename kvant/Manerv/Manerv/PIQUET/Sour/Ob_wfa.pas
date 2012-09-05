unit ob_wfa;
interface
    Uses matfun,{*textcrt,}TRAEKTOR{*,un1_wfa*};
const tochnost=0; {îáû÷íàÿ òî÷íîñòü} {cht=20;}{ ðåæèì òî÷íîãî ñîïðîâîæäåíèÿ
                                             ïðè âðàùåíèè ÔÀÐ}
        type
            t3s=array[1..3] of real;
             t4s=array[1..4] of real;
             t5s=array[1..5] of real;

{             t8_25s=array[1..8,1..40] of real;}
             t10_25s=array[1..10,1..40] of real;
{             t3_25s=array[1..3,1..40] of real;  }
             t5_25s=array[1..5,1..40] of real;
             t3_5s=array[1..3,1..5] of real;
             t25i=array[1..40] of integer;
             t25s=array[1..40] of real;
     function ex(var ok,ov,ot:real):real;
     function real_Ur(a1,a2:real):real;
     function tc(var cgtc,st,te:real):real;
     procedure NAKSUM(var m1:integer;var aq,kna:t5s;var ac:t10_25s;
     var im:integer;var njd:t25i);
     procedure DISPER(var jk:longint;var qk,qp:real;var qd,qmo:real;
     var m1:integer;var njd:t25i);
     procedure pr(var sm,dm,cg,cgd:t3s);
     function ARCTANG(y,x:real):real;
     procedure OBP(var dm,sm:t3s);
     procedure GRAMIS(VAR XR:real;VAR UG,UM,US:INTEGER);
     procedure GRAMISO(VAR XR:real;VAR UG:INTEGER;VAR UM:real);
     procedure dispm(var jk:longint;var qk,qp:real;var qd,qmo:real;
          var m1:integer;var njd:t25i);
     procedure diskret(ex,tekn,sigma:t3s;dtna,tn_1:real; var Tnmin:real;
                      var npr:integer);
{------------------------------------------------------------------------}
     implementation
 {------------------------------------------------------------------------}
     function  ex;
        {**************************** function EX *********************************}
     var oe:real;
      begin
       oe:=ok+ov*ot;
       ex:=oe
      end;
   {**************************** function real_UR ****************************}
   function real_UR;
     var x,a,b:real;
      begin
   {############# à1 - ëåâàÿ ãðàíèöà, à2 - ïðàâàÿ ãðàíèöà #############}
       x:=Random;
       b:=a1;a:=a2-b;
       real_UR:=a*x+b
      end;
   {************************** function TC *************************************}
   function tc;
    var rez:real;
      begin
       rez:=(cgtc-st)/te;
       tc:=rez
      end;
    {******************************** procedure NAKSUM **************************}
   procedure naksum;
    var ins:integer;razn,razn_kv:real;
      begin
      njd[m1]:=njd[m1]+1;
       for ins:=1 to im do
        begin
        razn:=aq[ins]-kna[ins];
        razn_kv:=razn*razn;
         ac[ins+im,m1]:=ac[ins+im,m1]+razn;
         ac[ins,m1]:=ac[ins,m1]+razn_kv;
       end
   end; { end of naksum }
   {******************************** procedure DISPER **************************}
   procedure disper;
    var qqk,qqp,qqpk,r52:real;
    jd:integer;
      begin
      jd:=njd[m1];
       qqk:=qk/jd;
       qqp:=qp/jd;
       qqpk:=sqr(qqp);
       r52:=abs(qqk-qqpk);
       qmo:=qqp;
       qd:=sqrt(r52)
      end; { end of disper }
   {******************************** procedure PR ******************************}
   procedure pr;
     var sc:array[1..2,1..2] of real;
         gc:array[1..3] of real;
         d,pe,b,cgr,cgp,cgb,x,y,z,cgx,cgy,cgz:real;
      begin
        d:=sm[1];pe:=sm[2];b:=sm[3];cgr:=cg[1];cgp:=cg[2];cgb:=cg[3];
        x:=d*cos(b)*cos(pe);y:=d*cos(b)*sin(pe);z:=d*sin(b);
        sc[1,1]:=sin(b)*sin(b);sc[2,1]:=cos(b)*cos(b);
        sc[1,2]:=sin(pe)*sin(pe);sc[2,2]:=cos(pe)*cos(pe);
        gc[1]:=cgr*cgr*sc[2,1];
        gc[2]:=d*d*sc[2,1]*cgp*cgp;
        gc[3]:=d*d*sc[1,1]*cgb*cgb;
        cgx:=sqrt(gc[1]*sc[2,2]+gc[2]*sc[1,2]+gc[3]*sc[2,2]);
        cgy:=sqrt(gc[1]*sc[1,2]+gc[2]*sc[2,2]+gc[3]*sc[1,2]);
        cgz:=sqrt(cgr*cgr*sc[1,1]+d*d*sc[2,1]*cgb*cgb);
        cgd[1]:=cgx;cgd[2]:=cgy;cgd[3]:=cgz;
        dm[1]:=x;dm[2]:=y;dm[3]:=z
     end; { end of pr }
  {***************************** function ARCTANG ***********************}
  {             ðàñ÷åò êðóãîâîãî àðêòàíãåíñà îò 0 äî 2Ï                 }
   function ARCTANG;
      var r,r1:real;
      begin
      if x=0 then  begin
      if y>=0 then arctang:=pi/2
              else arctang:=-pi/2;
                   end
              else begin
              r1:=abs(y/x);
              r:=arctan(r1);
              end;
      if(x>0) and (y>=0) then    arctang:=r;
      if(x>0) and (y<0 ) then    arctang:=2*pi-r;
      if(x<0) and (y>=0) then    arctang:=pi-r;
      if(x<0) and (y<0 ) then    arctang:=pi+r;
      end;

   {********************************* procedure OBP ****************************}
   {             ïðåáðàçîâàíèå èç äåêàðòîâîé â ñôåðè÷åñêóþ                }
   procedure obp;
     var d,pe,b,x,y,z:real;
      begin
       x:=dm[1];y:=dm[2];z:=dm[3];
       d:=sqrt(x*x+y*y+z*z);pe:=arctang(y,x);
       b:=arctang(z,sqrt(x*x+y*y));
       sm[1]:=d;sm[2]:=pe;sm[3]:=b
      end; { end of obp }

{--------------------    GRAMIS   ------------------------------------------}
 { ÏÅÐÅÂÎÄ ÓÃËÀ ÈÇ ÐÀÄÈÀÍÍÎÉ ÌÅÐÛ Â ÃÐÀÄÓÑÍÓÞ }
     procedure GRAMIS;
     LABEL 42,43;
     CONST IGX=-1;
     VAR KG,IG:INTEGER;
     VAR RM,R1:real;
     IR:ARRAY[1..3] OF INTEGER;
   BEGIN
        FOR IG:=1 TO 3 DO
        IR[IG]:=0;
      R1:=ABS(XR)*57.296083;
      IR[3]:=TRUNC(R1);
      RM:=(R1-IR[3])*60;
       IR[2]:=TRUNC(RM);
      IR[1]:=TRUNC((RM-IR[2])*60+0.5);
          FOR KG:=1 TO 2 DO BEGIN
         IF IR[KG]=60 THEN GOTO 42
                            ELSE GOTO 43;
 42:
       IR[KG]:=0;
        IR[KG+1]:=IR[KG+1]+1;
                             END;
  43:  UG:=IR[3];
       IF XR<0 THEN UG:=ABS(IR[2])*IGX;
       UM:=IR[2];
       IF (UG=0) AND (XR<0) THEN UM:=ABS(IR[3])*IGX;
       US:=IR[1];
 END;
 {--------------------    GRAMISO   ------------------------------------------}
 { ÏÅÐÅÂÎÄ ÓÃËÀ ÈÇ ÐÀÄÈÀÍÍÎÉ ÌÅÐÛ Â ÃÐÀÄÓÑÍÓÞ,ÌÈÍÓÒÛ È ÄÎËÈ ÌÈÍÓÒ }
     procedure GRAMISO;
     LABEL 420,430;
     CONST IGX=-1;
     VAR KG,IG:INTEGER;
     VAR RM,R1:real;
     IR:ARRAY[1..3] OF INTEGER;
   BEGIN
        FOR IG:=1 TO 3 DO
        IR[IG]:=0;
      R1:=ABS(XR)*57.296083;
      IR[3]:=TRUNC(R1);
      RM:=(R1-IR[3])*60;
       IR[2]:=TRUNC(RM);
      IR[1]:=TRUNC((RM-IR[2])*60+0.5);
          FOR KG:=1 TO 2 DO BEGIN
         IF IR[KG]=60 THEN GOTO 420
                            ELSE GOTO 430;
 420:
       IR[KG]:=0;
        IR[KG+1]:=IR[KG+1]+1;
                             END;
  430:  UG:=IR[3];
       IF XR<0 THEN UG:=ABS(IR[2])*IGX;
       UM:={IR[2]}RM;
       IF (UG=0) AND (XR<0) THEN UM:=ABS(R1)*IGX;
      { US:=IR[1];}
 END;
    procedure dispm;
    var qqk,qqp,qqpk,r52:real;
    jd:integer;
      begin
      jd:=njd[m1];
       qqk:=qk/jd;
       qqp:=qp/jd;
       qqpk:=sqr(qqp);
       r52:=abs(qqk);
       qmo:=qqp;
       qd:=sqrt(r52)
      end; { end of disper }

 procedure diskret( ex,tekn,sigma:t3s;dtna,tn_1:real; var Tnmin:real;
                  var npr:integer);
       var delta,tn,gamma: t3s;
           iko,cr: integer;
  begin
   cr:=0;
   for iko:=1 to 3 do
    begin
      delta[iko]:=abs(ex[iko]-tekn[iko]);
      gamma[iko]:=sqrt(delta[iko]/sigma[iko]);
      tn[iko]:=tn_1/gamma[iko];
      if gamma[iko]>2 then
      cr:=cr+1;
    end;
  if cr>=2 then
    begin
    npr:=npr+1;
    if tn[1]<=tn[2] then Tnmin:=tn[1] else
       Tnmin:=tn[2];
    if tn[3]<=Tnmin then Tnmin:=tn[3];
    end
     else
      tnmin:={tn_1;}dtna;
     end; {êîíåö ïðîöåäóðû äèñêðåò}

end.

