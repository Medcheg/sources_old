   Unit CKO;

interface
Uses traektor,ob_cko,fil_CKO,matfun,DAN_CKO;
   procedure gauss(am,sigma:real;var xnorm:real);
   procedure OSNOWA_CKO;

   {************** begin of interface  ***************}
(*   type t8s=array[1..8] of real;
   type t3_25s=array[1..3,1..25] of real;
   type t3_6s=array[1..3,1..6] of real;
   type t8_12_10s=array[1..8,1..12,1..10] of real;
   type t3_7s=array[1..3,1..7] of real;
   type t10s=array[1..10] of real;
   type t18s=array[1..18] of real;
   type t22s=array[1..22] of real;
   type t4i=array[1..4] of integer;
   type t3e=array[1..3] of extended;
   type t2_2s=array[1..2,1..2] of real;
   type t5st=array[1..5] of string;
   type t2_40r=array[1..2,1..40] of real;
{---------------------------------------------------}
  type t9_12_10i=array[1..9,1..12,1..10] of integer;
       t8_12_15s=array[1..8,1..12,1..15] of single;
       t8_12_25s=array[1..8,1..12,1..25] of single;
       t8i=array[1..8] of integer;
       t4b=array[1..4] of byte;*)
(* const
       PARAM_DV=1;{кроме координат вычисляются СКО параметров движения}
       ocV=1;{ - вычисляется СКО скорости}
       ocQ=1;{ - вычисляется СКО курса}
       ocH=0;{ - вычисляется СКО высоты}
       disk=0;{ 0-постоянный дискрет, 1-переменный}
       sig_izm=0;{0-постоянные ошибки измерения;
                 1-переменные, например, при качках}*)
 implementation
 const (*alfa=0.9; ogrv=0.05;ogrv_max=0.7;
       ogrx1=-0.6;ogrx2=-0.3;
       ogrH=0.07; {при Н меньшей или равной этой величины - признак НЛЦ}
       alnlc=0.3;*)
       pom=0; {1 - помехи есть 0 - помех нет}

         {  REG=1;} { СМЕНА ДИСКРЕТА С ГРУБОГО НА ТОЧНЫЙ ДЛЯ ГРАФИКА }
       REG=0; { БЕЗ СМЕНЫ ДИСКРЕТА}
(*       SHAG_SGL=1;{1 - вывод графиков от шага сглаживания, 0 - от времени}*)
    (*   td=1000;
       z00=0.010;{z0 для НЛЦ}
       VX=0;*)
    {  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  }
       BORT=0;{бортовых качек- нет}
(*           bort=1;{1 вариант бортовых качек с использованием sigug5 }*)
(*           bort=2;{2 вариант бортовых качек}
             bort=3; {3 вариант бортовых качек попеременно 7с и 5с}   *)
       kil=0; {килевой качки нет -0, ЕСТЬ - 1}
(*       ism_is=0;  {если проверяем по результатам испытания = 1
               если идем по алгоритму нашему = 0}
 dt_sek:array[1..39] of real=(2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
                              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
{массив, содержащий шаг по времени, который может быть переменным}*)

const ksi_gaus:array[1..3,1..40] of real=
{ КСИ из процедуры GAUSS для дальности}
((0.55474795,  1.03521508,  0.09021217, -1.71428967, -2.20066744,
 -0.65753909,  0.43479804,  0.92898768, -0.17255443,  1.79527694,
  0.54796367,  0.78483233, -0.15377826, -1.18117931,  1.32427490,
  0.00788678,  1.29461291, -0.31566153, -0.56532886,  1.08859441,
  0.28230940, -1.34919422,  1.10228609, -0.69073751, -0.56193202,
 -0.40532813,  0.74588023,  0.95731995,  1.73768625,  0.59396000,
  0.77729596, -0.95085337, -0.18619798,  1.74615077, -0.57801504,
  0,0,0,0,0),
{ КСИ из процедуры GAUSS для азимута}
( 1.45954549, -0.40783163,  0.55651337, -1.74872592, -0.27876304,
  0.20343702,  0.10430020,  0.13200562, -0.24903891, -1.43829546,
  0.87311524,  1.80276889, -0.71410242,  0.37048566, -0.47352010,
 -0.07573628, -0.27883602,  1.01428656,  0.66956267, -0.66105806,
 -0.20012730,  0.84944143, -1.30736498,  2.13218117,  0.15803555,
 -0.89506202, -1.00613290, -0.08619703, -1.22078562, -0.08011088,
 -0.27683671, -1.25690837,  0.10997997,  0.23453725, -2.16085886,
  0,0,0,0,0),
 {КСИ из процедуры GAUSS для Угла места}
( 0.79883791,  1.77951977, -1.11368011,  0.11099609, -0.31784340,
  1.12364498,  0.04788895,  0.38427208, -1.29436598, -1.03188997,
 -1.72241993,  0.31274344,  0.82700965,  1.16899066, -1.50912620,
  0.64416013,  1.18083479,  0.29334957, -0.21312076,  0.99776252,
 -1.71020930, -0.03610364,  0.13215614, -1.71286336,  0.32621172,
  1.11100749,  0.97264464,  0.57606830,  0.44663861,  0.49174311,
  1.06360381, -0.57762103, -0.08696020, -0.17126717,  1.05885498,
  0,0,0,0,0));


   var con:byte;
   nadp: t5st;
   obc:string;
   dt:real;
       i,ip,k1,ppf,kkf,pt,n,cirk,ki,KK1,KTG,OBT,VA,pr_otn:integer;
       j5,k0,j0,i0,i2,maxt,k2,i1,k,aaa,bbb,mig,j1,n1:integer;
       PRM,NFZ,NPR,INPR,kl,nko,lw,ppo,UG,UG1,US,k0d:integer;
       UM,UM1,DELTAQ1,DELTAQ2,POROG,rabocQ:real; {градусы, минуты, доли минуты}
       nj,qpo,X1Bar,Y1Bar,X2Bar,Y2Bar:integer;
       im,IFU,LREZ,Mkoe,smdisk:integer;
       KOL_PAR,Npar,dek_sf,wyw,NLC:INTEGER;
       Gpr,Gin:array[1..5] of real;
       z,y,x,pe,hcw,cgx,cgy,cgz,r,g,q,gn1,gn2,v0,Dg0:real;
       bbb1,ksi,eta,dsl,am,xxx,yyy:real;
       dte,procent,grad,dtna,Tnmin:real;
       sf3,dek3,qst,qi,sigb0,sige0:real;
       t,ttek,h,dg,ha,vtek:real;
       DeltaYM,rzrab:real;
       qk,qp,qd,yml,qmo:real;
       JK,ix,j:longint;
       kt:longint;
       Nmbg,Nmbp:word;
       KolKoor,per,perpf,jpes:integer;
       po2,plt,ti,cgr:extended;
       por,qsp,sigm,dmax:extended;
       ac{delko}:t10_25s;
       kdt,aq,maxvel,deltak:t5s;
       dk:t2_2s;
       mf:mfarr; md:mdarr; mv:mvarr; mq:mqarr; mte:mtearr;
       rwp:t10s;
       NJZ:t2i;
       nf,kfi,kp:t3i;
       ngi,njd:t25i;
       ppw,po,wp,sfe:t3_3s;
       ma1,ma2,rk,dek,
       extr,tekn,sigma,asf,
       dp,sf,cg,cgd,fg,fp:t3s;
       gp:t6s;
       mpor:t3_4s;
       uk:t2s;
       qp1:t3_21s;
       sfs:t3e;
       sq,dq,qm:t3_8s;
       sigg,cgsf,disp{,rdspr}:t5_25s;
     { BAY_SF, CKO_ed:t2_40r;}
       CKO_ed:t10_25s;
       fout,excel:text;
       {tt,}{в модуле DAN_CKO}
       ttdi:t25s;


{---------------------------------------------------------}

 procedure gauss(am,sigma:real;var xnorm:real);
  var i1:integer;
      sum,xn:real;
  const a=0.774597;
    begin
        sum:=0.0;
        for i1:=1 to 5 do
          begin;
           xn:=random;
           xn:=2*xn*a-a;
           sum:=sum+xn;
          end;
        xnorm:=am+sigma*(sum+0.01*(sqr(sum)*sum-3*sum));
    end;
procedure OSNOWA_CKO;

label met,met1,met2,l10,lp1,lpb,mc0,bm3,mmm,MET3,
        l1,l0,l2,l3_1,l3_2,l8,l6,l3,l4,l13,l11,l12,
        l5,li,l9,l14,l22,KKK,KKK5,l7,LNLC,ism0;


{******************************** procedure VIFIL ***************************}
   procedure vifil(var ppf:integer);{выбор фильтра из каталога}
   label l10,l14;
     begin
      if l[7]=1 then begin
       for k:=1 to  3 do begin
       for cirk:=1 to 8 do begin
        qm[k,cirk]:=dq[k,cirk]
      end  end;
   if (ppf=1) or (ppf=4) or (ppf=5) or (ppf=9) then begin
     for cirk:=1 to 3 do begin
     qm[cirk,6]:=cgd[cirk]  end  end  end
                 else begin
     for k:=1 to  3 do begin
     for cirk:=1 to 8 do begin
     qm[k,cirk]:=sq[k,cirk]
     end  end;
     if (ppf=1) or (ppf=4) or (ppf=5) or (ppf=9) then begin
     if KolKoor=2 then cg[3]:=0.0;
     for cirk:=1 to 3 do begin
     qm[cirk,6]:=cg[cirk]  end  end  end;
     if ppf=1 then begin
     for nko:=1 to 3 do begin
      FILS2(nko,dte,nf,kp,kfi,po,gp,qm)
     end; goto l10 end;
   if (ppf=2) or (ppf=3) then begin
   for k:=1 to 3 do begin
   qm[k,6]:=sq[k,4];qm[k,7]:=sq[k,1];
   for ki:=1 to 5 do begin
   if l[7]=1 then
   qm[k,ki]:=dq[k,ki] else qm[k,ki]:=sq[k,ki]
   end   end;
   if i>=7 then
   aaa:=aaa;
   if ppf=2 then FILR(i,dte,ngi,rk,gp,qm)
   else FILRT(i,dte,rk,gp,qm,ngi);
   goto l10  end;
   if ppf=4 then begin
   for nko:=1 to 3 do begin
   FILOGP(nko,nj,dte,nf,kfi,kp,qm)
   end; goto l10  end;
   if ppf=5 then begin
   for nko:=1 to 3 do begin
   FIL1(dte,nj,nko,qpo,qm,nf,mpor);
   end;  goto l10  end;
   if (ppf=6) or (ppf=7) then begin
   for k:=1 to 3 do begin
   qm[k,4]:=sigg[k,i];qm[k,6]:=dq[k,4];
   for ki:=1 to 3 do begin
   qm[k,ki]:=dq[k,ki]
   end  end;
   for nko:=1 to 3 do begin
   if ppf=6 then
   MKFIL(dte,kkf,nko,uk,wp,ppw,po,qm,qp1,nf);
   if ppf=7 then
   FILSM1(dte,kkf,nko,uk,wp,ppw,po,qm,nf);
   end;
   goto l10  end;
   { $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ }
    if ppf=9 then begin
       for k:=1 to kolkoor do begin
           sfe[k,1]:=sq[k,1];
           sfe[k,2]:=sq[k,4];
           sfe[k,3]:=cg[k];
                        end;

     FILZ3(kolkoor,PRM,NFZ,I,DTE,KP,RK,SFE,QM,NJZ);

                  END;
{ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%}
l10:if (ppf=1) or (ppf=2) or (ppf=3) or (ppf=4)
    or (ppf=5) or (ppf=9) then begin
   for k:=1 to 3 do begin
   for ki:=1 to 5 do begin
   if l[7]=1 then dq[k,ki]:=qm[k,ki] else sq[k,ki]:=qm[k,ki]  end  end;
   goto l14  end;
   if (ppf=6) or (ppf=7) then begin
   for k:=1 to 3 do begin
   for ki:=1 to 3 do begin
   dq[k,ki]:=qm[k,ki]  end;dq[k,4]:=qm[k,6];dq[k,6]:=qm[k,4];
   dq[k,5]:=qm[k,5]  end;
   goto l14  end;
l14:end; { end of vifil }
(* $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ *)
procedure shapka;{вывод в dat файл исходных данных, по которым рассчитывается
                   данный вариант}
BEGIN
   if j=1 then begin
  IF KIL=1 THEN
      writeln(fout,'КИЛЕВАЯ КАЧКА');
  if bort<>0 then BEGIN
      writeln(fout,'БОРТОВАЯ КАЧКА');
IF BORT=1 THEN writeln(fout,'угловые ошибки по закону 1, 1.3, 0.7, 1.3 и т.д.');
IF BORT=2 THEN writeln(fout,'угловые ошибки равны заданным');
IF BORT=3 THEN writeln(fout,'дискрет 7с, 5с, 7с, 5с, и т.д.')
       END;

   writeln(fout,'количество реализаций  ',jk:3);
   writeln(fout,'количество точек траектории ', kt:3);
if pom=1 then writeln(fout,'помехи есть')
else writeln(fout,'помех нет');

   if (l[7]=1) and (lw=0) then
   writeln(fout,'сферическая,декартовая,декартовая');
   if l[7]=0 then
   writeln(fout,'сферическая,сферическая,сферическая');
   if (l[7]=1) and (lw=1) then
   writeln(fout,'сферическая,декартовая,сферическая');
   if LREZ=0 then writeln(fout,' относительные величины ') else
   writeln (fout,'абсолютные величины');
   if PARAM_DV=1 then begin
   if ocV=1 then writeln (fout,'вычисление оценки скорости');
   if ocQ=1 then writeln (fout,'вычисление оценки курса');
   if ocH=1 then writeln (fout,'вычисление оценки высоты');
                      end;
   if disk=0 then writeln (fout,'ДИСКРЕТ ПОСТОЯННЫЙ ',dtna:4:1) ELSE
                  writeln (fout,'ДИСКРЕТ ПЕРЕМЕННЫЙ');
      case pt of
   1: writeln(fout,'горка');
   2: writeln(fout,'пологий спуск');
   3: writeln(fout,'пикирование с уч. входа и выхода');
   4: if kolkoor=3 then writeln(fout,'прямолинейное движение на постоянной высоте')
     else writeln(fout,'прямолинейное движение надводной цели');
      end;
       if pt=1 then begin
        writeln(fout,'нач. горизонт. дальность= ',dg:8:5);
       writeln(fout,'                 скорость= ',md[1,4]:5:3);

       writeln(fout,'      начальная    высота= ',md[1,5]:5:3);
       writeln(fout,'      максимальн.  высота= ',md[1,10]:5:3);
       writeln(fout,'дальность конца маневра  = ',md[1,7]:8:5);
       writeln(fout,'                     курс= ',md[1,8]:8:6);
       gramiso(md[1,8],ug,um);
                    writeln(fout,'курс в град.= ',ug:3,' град ',um:2,' мин');
       writeln(fout,'       курсовой параметр = ',md[1,11]:5:3);
       writeln(fout,'          угол разворота = ',md[1,12]:8:6);
                                     end;
    if pt=2 then begin
    writeln(fout,'            скорость, км/сек=',md[1,4]:5:3);
    writeln(fout,'        Начальная высота, км=',md[1,5]:5:3);
    writeln(fout,'   Нач. гориз-я дальн-ть, км=',md[1,6]:7:4);
    writeln(fout,'   Дальн-ть конца маневра,км=',md[1,7]:7:4);
    writeln(fout,'                   Курс, рад=',md[1,8]:9:6);
    writeln(fout,'   Траверзное расстояние,км.=',md[1,11]:7:5);
                  end;
   if pt=3 then begin
       writeln(fout,'нач. горизонт. дальность= ',dg:8:5);
       writeln(fout,'                 скорость= ',md[1,4]:5:3);

       writeln(fout,'      начальная    высота= ',md[1,5]:5:3);
       writeln(fout,'      минимальн.  высота = ',md[1,10]:5:3);
       writeln(fout,'дальность конца маневра  = ',md[1,7]:8:5);
       writeln(fout,'                     курс= ',md[1,8]:8:6);
       gramiso(md[1,8],ug,um);
                    writeln(fout,'курс в град.= ',ug:3,' град ',um:2,' мин');
       writeln(fout,'       курсовой параметр = ',md[1,11]:5:3);
       writeln(fout,'          угол разворота = ',md[1,12]:8:6);
       gramiso(md[1,12],ug,um);
               writeln(fout,'угол разв.в град.= ',ug:3,' град ',um:2,' мин');
                                     end;

      if pt=4 then begin
       writeln(fout,'          горизонт.дальн.= ',md[1,6]:5:3);
       writeln(fout,'                 скорость= ',md[1,4]:7:4);
       writeln(fout,'                   высота= ',H:5:3);
       writeln(fout,'                   пеленг= ',sf[2]:7:5);
       writeln(fout,'                     курс= ',md[1,8]:8:6);
       writeln(fout,'                ускорение= ',md[1,21]:8:6);
      writeln(fout,'                начало уск= ',md[1,22]:8:6);
       writeln(fout,'                конец уск= ',md[1,23]:8:6);
       end;
     case pt of
   5: begin writeln(fout,'радиальное движение со снижением');
    writeln(fout,'                      высота, км=',h:5:3);
    writeln(fout,'                     пеленг, рад=',sf[2]:9:6);
    writeln(fout,'                скорость, км/сек=',md[1,4]:5:3);
    writeln(fout,'       нач. гориз. дальн-ть, км.=',md[1,6]:5:2);
    writeln(fout,'                       курс, рад=',md[1,8]:9:6);
    writeln(fout,'              ускорение, км/секэ=',md[1,21]:5:3);
    writeln(fout,'      Нач.маневра по скор-ти,сек=',md[1,22]:5:2);
    writeln(fout,'       Продолжит-ть маневра, сек=',md[1,23]:5:2);
   end;
   6: begin  writeln(fout,'пикирование');
    writeln(fout,' Высота, км...............= ',h:5:3);
    writeln(fout,' Пеленг, рад..............= ',sf[2]:8:6);
    writeln(fout,' Скорость, км/сек.........= ',md[1,4]:5:3);
    writeln(fout,' Нач. гориз. дальн-ть, км.= ',md[1,6]:5:2);
    writeln(fout,' Курс, рад................= ',md[1,8]:9:6);
    writeln(fout,' Угол пикирования, рад....= ',md[1,9]:9:6);
    writeln(fout,' Ускорение, км/cэ.........= ',md[1,21]:4:2);
    writeln(fout,' Нач.маневра по скор-и,сек= ',md[1,22]:4:1);
    writeln(fout,' Продолжит-ть маневра, сек= ',md[1,23]:4:1);
   end;
   7: writeln(fout,'змейка');
   8: begin if kolkoor=3 then
            writeln(fout,'1 разворот на постоянной высоте')
       else writeln(fout,'разворот надводной цели');
            writeln(fout,'          горизонт.дальн.= ',md[1,6]:5:3);
            writeln(fout,'                 скорость= ',md[1,4]:5:3);
            writeln(fout,'                   пеленг= ',sf[2]:7:5);
            writeln(fout,'                   высота= ',H:5:3);
            writeln(fout,'                     курс= ',md[1,8]:8:6);
            writeln(fout,'                   радиус= ',md[1,15]:8:6);
            writeln(fout,'           угол разворота= ',md[1,12]:8:6);
            writeln(fout,'       время до разворота= ',md[1,18]:8:6);
            writeln(fout,'               перегрузка= ',gn1:7:5 )
       end;
   9:  writeln(fout,'2 разворота на постоянной высоте');
   10: writeln(fout,'петля в горизонтальной плоскости');
   11: writeln(fout,'набор высоты по винтовой');
   12: writeln(fout,'пространственная змейка');
     end;
        if pt=11 then begin

         writeln(fout,'нач. горизонт. дальность= ',dg:8:5);
       writeln(fout,'                 скорость= ',md[1,4]:5:3);
       writeln(fout,'                   пеленг= ',sf[2]:7:5);
       gramiso(SF[2],ug,um);
       writeln(fout,'           пеленг в град.= ',ug:3,' град ',um:2,' мин');

       writeln(fout,'                   высота= ',H:5:3);
       writeln(fout,'                     курс= ',md[1,8]:8:6);
       gramiso(md[1,8],ug,um);
       writeln(fout,'             курс в град.= ',ug:3,' град ',um:2,' мин');
       writeln(fout,'                   радиус= ',md[1,15]:8:6);
       writeln(fout,'          угол разворота = ',md[1,12]:8:6);
       writeln(fout,'               перегрузка= ',gn1:7:5 );
       writeln(fout,' угол наклона к горизонту=',md[1,17]:8:6);
       writeln(fout,' время до начала маневра =',md[1,18]:8:6);

                 end;
   case ppf of
   1: writeln(fout,'фильтр FILS2');
   2: writeln(fout,'фильтр FILR');
   3: writeln(fout,'фильтр FILRT');
   4: writeln(fout,'фильтр FILOGR');
   5: writeln(fout,'фильтр FIL1');
   6: writeln(fout,'фильтр MKFIL');
   7: writeln(fout,'фильтр FILSM1');
   9: writeln(fout,'фильтр FILZ3')
   end;
   if ppf=9 then begin
      writeln(fout,'память на прямой=',iwx[4,9,1]:2,
                  ' память на маневре=',iwx[4,9,2]:2);
          writeln(fout,'верхний порог=',iwx[4,9,3]:2,
                      '  нижний порог=',iwx[4,9,4]:2);
          if pt=8 then
          writeln(fout,'ОДНОПОРОГОВЫЙ, порог=',iwx[4,9,3]:2);
                   end;
   end;
        END;         {конец SHAPKA}
{ &&&&&&&&& расчёт параметров движения и их отклонений от точных &&&&& }
procedure V_Q_H(Kol_Par:integer;var RabocQ:real);
VAR RABOCV,RABTV,RABTQ,RABOCH,RABTH:REAL;
    label lv1,LQ1,LH1,LQ2,LH2,LkonV;

    begin  {V_Q_H} {1}

    if L[7]=1 then begin {сф-дек}  {2}
 { ******************* СФЕРИЧЕСКАЯ - ДЕКАРТОВАЯ *********************}
         IF (OCV=1)  THEN BEGIN     {3}
                 {оценка ТОЛЬКО скорости}

         if KolKoor=3 then begin     {4}
         RABOCV:=SQRT(dq[1,3]*dq[1,3]+dq[2,3]*dq[2,3]+dq[3,3]*dq[3,3]);
                            end;       {4}

         if KolKoor=2 then RABOCV:=SQRT(dq[1,3]*dq[1,3]+dq[2,3]*dq[2,3]);
               RABTV:=v0;

 IF (KOL_PAR=1) then BEGIN {5}
if KolKoor=3 then begin AQ[4]:=RABOCV; KDT[4]:=RABTV;end;
if KolKoor=2 then begin AQ[3]:=RABOCV; KDT[3]:=RABTV;end;
 goto lv1; END;{оценка ТОЛЬКО скорости}   {5}
IF (KOL_PAR=2) then BEGIN  {6}
if KolKoor=3 then begin AQ[4]:=RABOCV; KDT[4]:=RABTV;end;
if KolKoor=2 then begin AQ[3]:=RABOCV; KDT[3]:=RABTV;end;
    if OCQ=1 then GOTO LQ1;
    if oCH=1 then GOTO LH1;
     END;{6}
         end;       {3}
 { -----------------------------------------------------------------}
 LQ1:     IF OCQ=1  THEN BEGIN {7}
           {оценка ТОЛЬКО курса}
           if i<3 then  {2 точка }
         RABOCQ:=arctang(dq[2,3],dq[1,3])
            else begin           {8}
         qst:=RABOCQ;
         qi:=arctang(dq[2,3],dq[1,3]);   {Q}
         RABOCQ:=(1-alfa)*qst+alfa*qi;
              end;                 {8}
    RABTQ:=md[1,8];
IF KOL_PAR=1 then BEGIN {9}
if KolKoor=3 then begin AQ[4]:= RABOCQ; kdt[4]:=RABTQ; end;
if KolKoor=2 then begin AQ[3]:= RABOCQ; kdt[3]:=RABTQ;end;
goto lv1;END; {9}
IF KOL_PAR=2 then BEGIN {10}
if KolKoor=3 then begin AQ[5]:=RABOCQ; KDT[5]:=RABTQ;end;
if KolKoor=2 then begin AQ[4]:= RABOCQ; kdt[4]:=RABTQ;end;
     GOTO LV1 END;       {10}
                       end; {7}   {оценка курса}
 { -----------------------------------------------------------------}
LH1:  IF OCH=1 THEN BEGIN  {11}
   {оценка высоты}
RABOCH:=dq[3,2]+0.5*(dq[1,2]*dq[1,2]+dq[2,2]*dq[2,2]+dq[3,2]*dq[3,2])/6400+ha;
RABTH:=h;
IF KOL_PAR=1 then BEGIN       {12}
if KolKoor=3 then begin AQ[4]:= RABOCH; kdt[4]:=RABTH;end;
if KolKoor=2 then begin AQ[3]:= RABOCH; kdt[3]:=RABTH;end;
goto lv1;END;                  {12}
IF KOL_PAR=2 then BEGIN         {13}
if KolKoor=3 then begin AQ[5]:=RABOCH; KDT[5]:=RABTH;end;
if KolKoor=2 then begin AQ[4]:= RABOCH; kdt[4]:=RABTH;end;
            GOTO LV1;
        END                       {13}
                          end; {11}  {оценка высоты}
                end;{2} { сф-дек L[7]=1 }
 { ************КОНЕЦ СФЕРИЧЕСКАЯ - ДЕКАРТОВАЯ *********************}

       if L[7]=0 then begin {cc1}
  { ************НАЧАЛО СФЕРИЧЕСКАЯ - СФЕРИЧЕСКАЯ ********************}
                dk[1,1]:=sq[1,3]*sin(sq[2,1]);
                dk[1,2]:=sq[1,1]*cos(sq[2,1])*sq[2,3];
                dk[2,2]:=sq[1,1]*sin(sq[2,1])*sq[2,3];
                dk[2,1]:=sq[1,3]*cos(sq[2,1]);
                xxx:=dk[1,1]+dk[1,2];
                yyy:=dk[2,1]-dk[2,2];
       if ocV=1 then {оценка скорости}
       begin       {cc2}
      RABOCV:=SQRT(sq[1,3]*sq[1,3]+sq[1,1]*sq[1,1]*sq[2,3]*sq[2,3]);
      RABTV:=v0;
 IF  KOL_PAR=1 THEN BEGIN {cc3}
if KolKoor=3 then begin AQ[4]:=RABOCV; KDT[4]:=RABTV;end;
if KolKoor=2 then begin  AQ[3]:=RABOCV; KDT[3]:=RABTV;end;
               goto lv1; END; {cc3}{оценка ТОЛЬКО скорости}
 IF  KOL_PAR=2 THEN BEGIN    {cc4}
if KolKoor=3 then begin AQ[4]:=RABOCV; KDT[4]:=RABTV;end;
if KolKoor=2 then begin AQ[3]:=RABOCV; KDT[3]:=RABTV;end;
    if OCQ=1 then   GOTO LQ2;
    if oCH=1 then GOTO LH2;
     END;{cc4}
         end; {cc2}

LQ2:   if ocQ=1 then begin  {cc5} {оценка курса}
       RABOCQ:=arctang(xxx,yyy);
       RABTQ:=md[1,8];
IF  KOL_PAR=1 THEN BEGIN       {cc6}
if KolKoor=3 then begin AQ[4]:=RABOCQ; KDT[4]:=RABTQ;end;
if KolKoor=2 then begin AQ[3]:=RABOCQ; KDT[3]:=RABTQ;end;
               goto lv1; END;    {cc6}
IF KOL_PAR=2 then BEGIN           {cc7}
if KolKoor=3 then begin AQ[5]:=RABOCQ; KDT[5]:=RABTQ;end;
if KolKoor=2 then begin AQ[4]:=RABOCQ; KDT[4]:=RABTQ;end;
     GOTO LV1 END;                {cc7}
                       end; {cc5}   {оценка курса}

LH2:        if ocH=1 then begin {cc8} {оценка высоты}
       RABOCH:=sq[1,2]*sin(sq[3,2])+0.5*sq[1,2]*sq[1,2]/6400+ha;
       RABTH:=h;
IF  KOL_PAR=1 THEN BEGIN   {cc9}
if KolKoor=3 then begin AQ[4]:= RABOCH; kdt[4]:=RABTH;end;
if KolKoor=2 then begin AQ[3]:= RABOCH; kdt[3]:=RABTH;end;
goto lv1; END;             {cc9}
IF KOL_PAR=2 then BEGIN     {cc10}
if KolKoor=3 then begin AQ[5]:=RABOCH; KDT[5]:=RABTH;end;
if KolKoor=2 then begin AQ[4]:= RABOCH; kdt[4]:=RABTH;end;
            GOTO LV1;  END {cc10}
        end;   {оценка высоты}  {cc8}
                        end; {cc1} { сф-сф-сф L[7]=0}
 { ************КОНЕЦ СФЕРИЧЕСКАЯ - СФЕРИЧЕСКАЯ ********************}
lv1:    IF KOL_PAR=1 THEN begin
if KolKoor=3 then begin aaa:=4; DeltaQ1:=aq[4]-kdt[4];end;
if KolKoor=2 then begin aaa:=3; DeltaQ1:=aq[3]-kdt[3];end;
                          end;
  IF KOL_PAR=2 THEN begin
if KolKoor=3 then begin aaa:=4;DeltaQ1:=aq[4]-kdt[4];
                        bbb:=5;DeltaQ2:=aq[5]-kdt[5];
                    end;
if KolKoor=2 then begin aaa:=3;DeltaQ1:=aq[3]-kdt[3];
                        bbb:=4;DeltaQ2:=aq[4]-kdt[4];
                    end;
                    end;
      if (j=1) and (i<=kt)  then begin {*}
      if KOL_PAR=1 then BEGIN { расчет одного параметра}
      {дополнительно рассчитывается один из параметров}
      if (ocV=1) AND (KOL_PAR=1) then
writeln (fout,'i=',i:2,' Vточн = ',v0:5:3,' ОцV = ',aq[aaa]:7:5,' DELTA V = ',DeltaQ1:7:5);
     if (ocQ=1) AND (KOL_PAR=1) then
writeln (fout,'i=',i:2,' Vx=',dq[1,3]:7:5,' Vy=',dq[2,3]:7:5,' Q= ',qi:9:7,' ОцQ = ',aq[aaa]:7:5,' Deltaq=',Deltaq1:9:7);
     if (ocH=1) AND (KOL_PAR=1) then
writeln (fout,'i=',i:2,' hточн=',h:7:5,' Oцh= ',aq[aaa]:9:7,' DeltaH=',Deltaq1:9:7);
      goto Lkonv;  END;

      if KOL_PAR=2  then BEGIN
      {дополнительно рассчитываются два параметра}
if (ocv=1) and (ocQ=1)   then begin
writeln (fout,'i=',i:2,' Vточн = ',v0:5:3,' ОцV = ',aq[aaa]:7:5,' DELTA V = ',DeltaQ1:7:5);
writeln (fout,'i=',i:2,' Vx=',dq[1,3]:7:5,' Vy=',dq[2,3]:7:5,' Q= ',qi:9:7,' ОцQ = ',aq[bbb]:7:5,' DeltaQ=',Deltaq2:9:7);
                            end;
if (ocv=1) and (ocH=1)  then begin
writeln (fout,'i=',i:2,' Vточн = ',v0:5:3,' ОцV = ',aq[aaa]:7:5,' DELTA V = ',DeltaQ1:7:5);
writeln (fout,'i=',i:2,' hточн=',h:7:5,' Oцh= ',aq[bbb]:9:7,' DeltaH=',Deltaq2:9:7);
                             end;
if (ocQ=1) and (ocH=1) then begin
writeln (fout,'i=',i:2,' Vx=',dq[1,3]:7:5,' Vy=',dq[2,3]:7:5,' Q= ',qi:9:7,' ОцQ = ',aq[aaa]:7:5,' Deltaq=',Deltaq1:9:7);
writeln (fout,'i=',i:2,' hточн=',h:7:5,' Oцh= ',aq[bbb]:9:7,' DeltaH=',Deltaq2:9:7);
                             end;
                          END;
                                end;      {*}
Lkonv:   end; {V_Q_H}

{ &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&}
procedure ABS_WYW(kolkoor,Npar,kol_par:integer);{ВЫВОД АБСОЛЮТНЫХ ВЕЛИЧИН В DAT ФАЙЛ}
label ABS1,ABS2,ABS3;
      BEGIN
  if (k0d=0) then begin {1}
  if j0=2 then goto ABS1;
  if (Lw=1) or (Lw=33) then begin {2}{вывод в сферической системе координат}
  GRAMISO(DISP[2+k0d,J5],UG,UM);     {градусы, минуты, доли минуты}
writeln(excel,'   ',j5:3,', ',tt[j5]:5:1,', ',disp[1+k0d,j5]*td:9:6,', ',tt[j5]:5:1,', ',disp[2+k0d,j5]*td:9:6,',');
writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,'         ',disp[2+k0d,j5]*td:9:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.');
                 {вывод R, beta}
goto ABS1;       end; {2}
   if LW=0 then begin {3}
 writeln(fout,' ',j5:3,' ',disp[1+k0d,j5]*td:9:6,'              ',disp[2+k0d,j5]*td:9:6);
 writeln(excel,' ',j5:3,', ',tt[j5]:5:1,', ',disp[1+k0d,j5]*td:9:6,', ',tt[j5]:5:1,', ',disp[2+k0d,j5]*td:9:6,',');
                   {вывод X,Y}
goto ABS1;       end;  {3}
                 end{1}

   ELSE
   begin {4}
   if kolkoor=2 then GOTO ABS3;
   if kolkoor=3 then begin  {5} {3-я координата (eps или Z) + 1-й параметр}
   if (Npar=0) and (j0<5) then begin { $$$$$$$ }
   if (Lw=1) or (Lw=33) then begin {6}
   GRAMISO(DISP[1+k0d,J5],UG,UM);
     if j0=4 then goto ABS1;
if (ocV=1) or (ocH=1) then begin {7}
writeln(excel,'   ',j5:3,', ',tt[j5]:5:1,', ',disp[1+k0d,j5]*td:9:6,', ',tt[j5]:5:1,', ',disp[2+k0d,j5]*td:9:6,',');
writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.','     ',disp[2+k0d,j5]*td:9:6);
GOTO ABS2; end;{7}
if ((ocQ=1) and ((ocV=0) or (ocH=0))) then begin {8}
   GRAMISO(DISP[2+k0d,J5],UG1,UM1); {пересчёт в градусы Q}
writeln(excel,'   ',j5:3,', ',tt[j5]:5:1,', ',disp[1+k0d,j5]*td:9:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.',
        ', ',tt[j5]:5:1,', ',disp[2+k0d,j5]*td:10:6,'   ', UG1:3,' ГРАД. ',UM1:5:2,' МИН.');
writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.',
             ' ',disp[2+k0d,j5]*td:10:6,'   ', UG1:3,' ГРАД. ',UM1:5:2,' МИН.');
GOTO ABS2; end; {8}
                end;  {6} {LW=1}

    if LW=0 then begin  {9}
     if j0=4 then goto ABS1;
if (ocV=1) or (ocH=1) then begin {10}
writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,'         ',disp[2+k0d,j5]*td:9:6);
writeln(excel,'   ',j5:3,', ',tt[j5]:5:1,', ',disp[1+k0d,j5]*td:9:6,', ',tt[j5]:5:1,', ',disp[2+k0d,j5]*td:9:6,',');
                  {вывод Z, V/H}
GOTO ABS2;                  end; {10}
if ((ocQ=1) and ((ocV=0) or (ocH=0))) then begin {11}
    GRAMISO(DISP[2+k0d,J5],UG,UM);
writeln(excel,'   ',j5:3,', ',tt[j5]:5:1,', ',disp[1+k0d,j5]*td:9:6,
        ', ',tt[j5]:5:1,', ',disp[2+k0d,j5]*td:9:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.');
writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,' ',disp[2+k0d,j5]*td:9:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.');
               end;   {11}
               end; {9}
               end; { $$$$$$$ }
ABS2:
   if NPAR=1 then begin {12}
   if ocH=1  then begin {13} {Н в качестве 5 величины}
   writeln(excel,'   ',j5:3,', ',tt[j5]:5:1,', ',disp[5,j5]*td:9:6,',');
   writeln(fout,'   ',j5:3,' ',disp[5,j5]*td:9:6);
goto ABS1; end;           {13}
if ocQ=1 then begin {Q в качестве 5 величины}     {14}
   GRAMISO(DISP[5,J5],UG,UM);     {градусы, минуты, доли минуты}
writeln(fout,'   ',j5:3,'  ',disp[5,j5]*td:10:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.');
writeln(excel,' ',j5:3,', ',tt[j5]:5:1,', ',disp[5,j5]*td:10:6);
GOTO ABS1;     end;              {14}
GOTO ABS1;          end; {12}
GOTO ABS1;              end; {5}
 ABS3:
   if (k0d=2) and (j0=3) then begin { #######}
   if ocQ=1 then begin  {15}
   GRAMISO(DISP[4,J5],UG,UM);
writeln(excel,'   ',j5:3,', ',tt[j5]:5:1,', ',disp[1+k0d,j5]*td:9:6,
        ', ',tt[j5]:5:1,', ',disp[4,j5]*td:9:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.');
writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,'             ',disp[4,j5]*td:10:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.');
GOTO ABS1; end; {15}
    if ocH=1 then begin {16}
writeln(excel,'   ',j5:3,', ',tt[j5]:5:1,', ',disp[1+k0d,j5]*td:9:6,
        ', ',tt[j5]:5:1,', ',disp[4,j5]*td:9:6);
writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,' ',disp[4,j5]*td:9:6);
                  end; {16}
                  end; { #######}
                  end; {4}
ABS1:      END;{ABS_WYW}
{-----------------------------------------------------------------------}
procedure CKO_DEK_SF(asf:t3s;ppf:integer);{ :: пересчет  СКО x,y,z в СКО d,b,e :::: }
{для фильтра MKFIL}
BEGIN
  { ::::::::::::::::::::::: пересчет  СКО x,y,z в СКО d,b,e :::::::::::::: }
 if (ppf=6) or (ppf=7) then BEGIN  { ******* для байесовского оценивания}
    lw:=1;
for i0:=1 to kolkoor do begin
for j0:=2 to kt do begin
CKO_ED[i0,j0]:=CKO_ED[i0,j0]*cg[i0]/asf[i0];
                   end end; END; { ******* }

  for j:=1 to kolkoor do begin
  for n1:=1 to kt-1 do begin
  BAY_SF[j,n1]:=CKO_ed[j,n1+1];
  if (j=1) and (n1=1) then writeln(fout,' CKO D BAYES');
  if (j=2) and (n1=1) then writeln(fout,' CKO B BAYES');
  if (j=3) and (n1=1) then writeln(fout,' CKO E BAYES');
   writeln(fout,'NTOCH= ',n1:2,'  ',BAY_SF[j,n1]:9:6);
                        end;
   BAY_SF[j,kt]:=CKO_ed[j,kt]*0.95;
   writeln(fout,'NTOCH= ',kt:2,'  ',BAY_SF[j,kt]:9:6);
                     end;

  if (disk=0) and (SHAG_SGL=0) then begin          {1}
             wyw:=0;

                      tt[1]:=dtna+dt;

                    for j1:=2 to kt do
                    tt[j1]:=tt[j1-1]+dt;
                   end;             {1}
   IF (DISK=1) or ((disk=0) and (SHAG_SGL=1)) THEN begin      {2}
                    wyw:=1;
                    for k:=1 to kt-1 do
                    tt[k]:=k+1;
                   end;                   {2}
     Nmbp:=kt-1;

     for k:=1 to kolkoor do
     begin
         i:=k;
     Nmbg:=1;
 MKoe:=1;  {для относ. величин LREZ=0 и для абс, т.к. они в метрах}{8-8}
 if LREZ=0 then grad:=1;  {для относ. величин LREZ=0}
 if LREZ=1 then grad:=td;
        for n1:=2 to kt do begin {9}
                BAY_SF[i,n1-1]:=BAY_SF[i,n1]*Mkoe*grad;
                 end;              {9}

    // bas_k_P(kolkoor,lrez,lw,i,wyw,VA,Nmbg,Nmbp,tt,disp);
{конец вставки}
     end;

END; { конец:::: пересчёта  СКО x,y,z в СКО d,b,e :::: }
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
procedure otnosit_w(var pr_otn:integer);
{ПРОЦЕДУРА ЗАНЕСЕНИЯ В DAT ФАЙЛ ОТНОСИТЕЛЬНЫХ ЗНАЧЕНИЙ КООРДИНАТ}
label ot1;
BEGIN        {&&&&&&&&&&&&&&&}
    if kolkoor =3 then begin {17}
    if (k0d=0) then begin     {18}
    if j0=2 then goto ot1;
    if j0=1 then
 writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]:9:6,'        ', disp[2+k0d,j5]:9:6);
                     end;      {18}
    if k0d=2 then begin         {19}
    if j0=4 then goto ot1;
    if j0=3 then
    writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]:9:6,'        ', disp[2+k0d,j5]*td:9:6);
                  end;           {19}
   if k0d=5 then begin {19a}
  if ocH=1 then  writeln(fout,'   ',j5:3,' ',disp[k0d,j5]*td:9:6);
  if ocQ=1 then begin  GRAMISO(DISP[5,J5],UG,UM);{19b}
writeln(fout,'   ',j5:3,' ',disp[5,j5]*td:10:6,'   ', UG:3,' ГРАД. ',UM:5:2,' МИН.');
                  end;  {19b}
                  end;{19a}
    goto ot1;     end; {17}


    if kolkoor=2 then begin {20}
    if (k0d=0) then begin     {21}
    if j0=2 then goto ot1;
    if j0=1 then
 writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]:9:6,'        ', disp[2+k0d,j5]:9:6);
                     end;      {21}
   if k0d=2 then begin  {22}
    if kol_par=1 then
    writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6);
    if kol_par=2 then begin {23}
    if ocQ=1 then begin     {24}
    GRAMISO(DISP[k0d+2,J5],UG,UM);
writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,'             ', disp[2+k0d,j5]*td:10:6,'   ',
 UG:3,' ГРАД. ',UM:5:2,' МИН.');
                    end;      {24}
if ocH=1 then writeln(fout,'   ',j5:3,' ',disp[1+k0d,j5]*td:9:6,'             ', disp[2+k0d,j5]*td:10:6);
                       end;    {23}
                  end;  {22}
    goto ot1         end;{20}
ot1: pr_otn:=1;
    END;   {otnosit}
{=======================================================================}
procedure grafik1R;
{построение графика отклонений для единичной реализации}
BEGIN
nmbg:=2;
  if (disk=0) and (SHAG_SGL=0) then begin          {1}
             wyw:=0;
                      tt[1]:=dtna+dt;
                    for j1:=2 to kt-1 do
                    tt[j1]:=tt[j1-1]+dt;
                   end; {1}
   IF (DISK=1) or ((disk=0) and (SHAG_SGL=1)) THEN begin      {4}
                    wyw:=1;
    if VX=0 then begin
                    for k:=1 to kt-1 do
                    tt[k]:=k+1;
                   end;
   if VX<>0 then begin
   for k:=1 to kt-1 do
       tt[k]:=k;
                 end;

                   end;                    {4}
     Nmbp:=kt-1;

 aaa:=kolkoor; bbb:=1;
     for k:=bbb to aaa do
     begin                                   {5}
      i:=k;
     if VX=0 then cirk:=2;
     if VX<>0 then cirk:=1;
     for n1:=cirk to kt do  BEGIN     {10}
if (lw=1) or (lw=33) then begin
             DELKO[i,n1]:=DELKO[i,n1]/cg[i];
             DELKO[i+4,n1]:=DELKO[i+4,n1]/cg[i];
              end;
if lw=0 then begin
DELKO[i,n1]:=DELKO[i,n1]/sigg[i,n1];
DELKO[i+4,n1]:=DELKO[i+4,n1]/sigg[i,n1];
             end;

                  END;      {10}
for k2:=2 to kt do begin
disp[1,k2]:=DELKO[i,k2];
disp[2,k2]:=DELKO[i+4,k2];
                     end;
for n1:=2 to kt do begin

if i=1 then begin
if n1=2 then writeln(fout, 'ОТН. ОШ. ИЗМ.1 коор','        ОТН. ОШ. ФИЛЬТ.1 коор');
writeln(fout,'N точ.= ',n1:2,'  ',DELKO[1,n1]:9:5,'        ',DELKO[5,n1]:9:5);
             end;
if i=2 then begin
if n1=2 then writeln(fout, 'ОТН. ОШ. ИЗМ.2 коор','        ОТН. ОШ. ФИЛЬТ.2 коор');
writeln(fout,'N точ.= ',n1:2,'  ',DELKO[2,n1]:9:5,'        ',DELKO[6,n1]:9:5);
            end;
if kolkoor=3 then begin
if i=3 then  begin
if n1=2 then writeln(fout, 'ОТН. ОШ. ИЗМ.3 коор','        ОТН. ОШ. ФИЛЬТ.3 коор');
writeln(fout,'N точ.= ',n1:2,'  ',DELKO[3,n1]:9:5,'        ',DELKO[7,n1]:9:5);
              end;end;
            end;
                end;                           {5}

{конец построения графика отклонений для единичной реализации}
     END;
procedure grafik_Nre;
{построение графика отклонений для n реализаций}
BEGIN
  if (disk=0) and (SHAG_SGL=0) then begin          {1}
             wyw:=0;
                      tt[1]:=dtna+dt;
writeln(fout,'nt=   1',' ',tt[1]:6:4);
                    for j1:=2 to kt-1 do begin
                    tt[j1]:=tt[j1-1]+dt;
writeln(fout,'nt= ',j1:3,' ',tt[j1]:6:4);    end;
                   end;             {1}
   IF (DISK=1) or ((disk=0) and (SHAG_SGL=1)) THEN begin      {2}
                    wyw:=1;
    if VX=0 then begin
                    for k:=1 to kt-1 do
                    tt[k]:=k+1;
                   end;
   if VX<>0 then begin
   for k:=1 to kt-1 do
       tt[k]:=k;
                 end;
                   end;                   {2}
     Nmbp:=kt-1;
     if NLC=0 then begin aaa:=im; bbb:=1; end;
     if NLC=1 then begin bbb:=3; aaa:=3; end; {т.к. угол места рассчитывается
     отдельно, а остальные координаты и параметры при двухкоординатной РЛС}
     for k:=bbb to aaa do
     begin
         i:=k;
     Nmbg:=1;
 if lrez=1 then begin    {5}
         Mkoe:=1000;    grad:=1
                end      {5}
   else begin MKoe:=1; grad:=1 end;  {для относительных величин LREZ=0}{8-8}

IF (KOLKOOR=3) and (Kol_PAR=1) THEN BEGIN {1}
if i=4 then begin
if ocV=1 then begin VA:=0;MKOE:=1000;grad:=1; end;
if ocQ=1 then begin Va:=1;MKOE:=1;grad:=180/pi; end;{3-3}
if OCH=1 then begin VA:=2;MKOE:=1000;grad:=1; end;
             end;
                    end;    {1}
 IF (KOLKOOR=2) and (Kol_PAR=1) THEN BEGIN
if i=3 then begin
if ocV=1 then begin VA:=0;MKOE:=1000;grad:=1; end;
if ocQ=1 then begin Va:=1;MKOE:=1;grad:=180/pi; end;{3-3}
if OCH=1 then begin VA:=2;MKOE:=1000;grad:=1; end;
             end;
                                END;
 IF (KOLKOOR=3) and (Kol_PAR=2) THEN BEGIN {1}
if i=4 then begin VA:=0;MKOE:=1000; grad:=1; end;
if i=5 then begin                        {2}
 if ocQ=1 then begin Va:=1; MKOE:=1;grad:=180/pi; end;{3-3}
 if OCH=1 then begin VA:=2;MKOE:=1000;grad:=1; end;
            end;           {2}
                    end;    {1}
 IF (KOLKOOR=2) and (Kol_PAR=2) THEN BEGIN {4}
if i=3 then begin VA:=0;MKOE:=1000;grad:=1; end;
if i=4 then begin                           {5}
 if ocQ=1 then begin Va:=1;MKOE:=1;grad:=180/pi; end;{6-6}
 if OCH=1 then begin VA:=2;MKOE:=1000;grad:=1; end;
            end;              {5}
                     end;      {4}

        for n1:=2 to kt do begin {9}
                 rdspr[i,n1-1]:=rdspr[i,n1]*Mkoe*grad;
                 end;              {9}

     end;


     END;
{=======================================================================}

   BEGIN {начало основной процедуры}
      KolKoor:=iwx[7,7,7];
{начало вставки}
{ ################# bst ########################### }
{Param_dv:=1;
ocV:=1;
ocQ:=1;
disk:=0;
SHAG_SGL:=1;}
{ ################# bst ########################### }
{конец вставки}


{********************************* начало ***********************************}
     pt:=l[1];{признак выбранной траектории}
     ppf:=l[4];{признак выбранного фильтра}
     maxt:=iwx[1,1,2];{максимальное количество траекторий}
     {per:=l[8];perpf:=iwx[8,per,1];}
     n:=1;{одна цель !!!!!!!}
     dsl:=1;po2:=1.0;
     am:=wx[2,1,5];
     dsl:=wx[2,1,4];
     po2:=wx[2,1,6];

     {TODO : input1}
     (*    if (ppf=6) or (ppf=7) then
      dek_sf:=1-LREZ;*)

    LREZ:=iwx[7,1,2];
    if ((ppf=6) or (ppf=7)) then begin
    if LREZ=1 then dek_sf:=1;
    if LREZ=0 then dek_sf:=0;
                                 end;

    if l[6]=1 then begin
   jk:=iwx[6,1,1];
   kt:=iwx[6,1,2]
   end;
if (PARAM_DV=0) then begin
if Kolkoor=3 then im:=3;
if Kolkoor=2 then im:=2;
                     end;
if PARAM_DV=1 then BEGIN
if Kolkoor=3 then begin
if (ocV=1) and (ocQ=0) and (ocH=0) then begin im:=4;KOL_PAR:=1;end;
if (ocQ=1) and (ocV=0) and (ocH=0) then begin im:=4;KOL_PAR:=1;end;
if (ocH=1) and (ocV=0) and (ocQ=0) then begin im:=4;KOL_PAR:=1;end;
if (ocV=1) and (ocQ=1) and (ocH=0) then begin im:=5;KOL_PAR:=2;end;
if (ocV=1) and (ocH=1) and (ocQ=0) then begin im:=5;KOL_PAR:=2;end;
                   end;
if Kolkoor=2 then begin
if (ocV=1) and (ocQ=0) and (ocH=0) then begin im:=3;KOL_PAR:=1;end;
if (ocQ=1) and (ocV=0) and (ocH=0) then begin im:=3;KOL_PAR:=1;end;
if (ocH=1) and (ocV=0) and (ocQ=0) then begin im:=3;KOL_PAR:=1;end;
if (ocV=1) and (ocQ=1) and (ocH=0) then begin im:=4;KOL_PAR:=2;end;
if (ocV=1) and (ocH=1) and (ocQ=0) then begin im:=4;KOL_PAR:=2;end;
                   end;
                   END;
(*     LREZ:=iwx[7,1,2];*)
   for aaa:=1 to 3 do begin
   for bbb:=1 to 8 do begin
     sq[aaa,bbb]:=0.0;dq[aaa,bbb]:=0.0
   end    end;
   for aaa:=1 to (im*2) do begin
   for bbb:=1 to kt do begin
     ac[aaa,bbb]:=0.0;
     delko[aaa,bbb]:=0;
      njd[bbb]:=0;
   end    end;
   for aaa:=1 to im do begin
   kdt[aaa]:=0;aq[aaa]:=0;
   end;
   for aaa:=1 to 10 do
      mf[1,aaa]:=0;
   for aaa:=1 to 25 do
      md[1,aaa]:=0.0;

     DTNA:=wx[3,1,1];
     DT:=wx[3,1,1];
   for aaa:=1 to im do begin
   for bbb:=1 to kt do begin
   sigg[aaa,bbb]:=0.0;
   cgsf[aaa,bbb]:=0.0
   end    end;
   if (ppf=1) or (ppf=2) or (ppf=3) then begin
   for i1:=1 to 3 do begin
   fg[i1]:=wx[4,ppf,i1];gp[i1]:=fg[i1]   end;
   if (ppf=2) or (ppf=3) then begin
   for k:=1 to 3 do begin
   fp[k]:=wx[4,ppf,k+3];gp[k+3]:=fp[k]  end   end;
   if ppf=1 then begin
   for k:=1 to 3 do begin
   kp[k]:=iwx[4,ppf,k]  end  end;
   goto met  end;
   if ppf=4 then begin
   nj:=iwx[4,ppf,1];
   for k:=1 to 3 do begin
   kp[k]:=iwx[4,ppf,k+1]
   end;
   goto met
   end;
   if ppf=5 then begin
   nj:=iwx[4,ppf,1];qpo:=iwx[4,ppf,2];
   ki:=1;k2:=1;
   for k:=1 to 12 do begin
   r:=wx[4,ppf,k];mpor[ki,k2]:=r;
   k2:=k2+1;
   if k2<5 then goto met1;
   k2:=1;ki:=ki+1;
met1:end;
   goto met   end;
   if (ppf=6) or (ppf=7) then begin
   kkf:=iwx[4,ppf,1];uk[1]:=wx[4,ppf,13];uk[2]:=wx[4,ppf,14];
   if kkf=3 then begin
   for k:=1 to 9 do begin
   rwp[k]:=wx[4,ppf,k];
   if k<4 then begin
   for cirk:=1 to 3 do begin ppw[cirk,k]:=wx[4,ppf,k+9]  end  end
   end   end     else begin
   for k:=1 to 9 do begin
   rwp[k]:=pw[4,ppf,k];
   if k<4 then begin
   for cirk:=1 to 3 do begin ppw[cirk,k]:=pw[4,ppf,k+9]   end  end
   end  end;
   ki:=1;k2:=1;
   for k:=1 to 9 do begin
   wp[ki,k2]:=rwp[k];
   k2:=k2+1;
   if k2<4 then goto met2;
   k2:=1;ki:=ki+1;
met2:end;
   goto met  end;
          if ppf=9  then begin      {1}  {фильтр FILZ3 }
          FOR K:=1 TO 2 DO BEGIN
            KP[K]:=IWX[4,PPF,K+2];
            NJZ[K]:=IWX[4,PPF,K];
                           END;
    goto met  end;


met:
   if l[7]=1 then begin
   if iwx[7,1,1]=0 then lw:=0 else
   lw:=1  end;
   kl:=1;
   if l[7]=0 then lw:=33;
 if (l[7]=1) and (lw=0) then begin
    assign(fout,'add.dat');
    assign(excel,'aEdd.pas');
                             end;
   if l[7]=0 then    begin
    assign(fout,'ass.dat');
    assign(excel,'aEss.pas');
                     end;
   if (l[7]=1) and (lw=1) then begin
   assign(fout,'ads.dat');
   assign(excel,'aEds.pas');
                               end;
   rewrite(fout);
   rewrite(excel);
   g:=0.0098; nlc:=0;
{ ########################################################## }
   for j:=1 to jk do begin {НАЧАЛО ЦИКЛА ПО РЕАЛИЗАЦИЯМ}
   if disk=1 then begin
   ttdi[1]:=dt_sek[1]; ttdi[2]:=dt_sek[2]; smdisk:=0;
                  end;
   smdisk:=0;
   k1:=0;
   for i1:=1 to maxt do begin
   if pt=i1 then begin
   for i2:=1 to 10 do begin
   mf[1,i2]:=iwx[1,pt,i2]
   end;
   for i2:=1 to 25 do begin
   md[1,i2]:=wx[1,pt,i2]  end
   end  end;
   for i1:=4 to maxt do begin
   if pt=i1 then begin
   h:=pw[1,i1,1];sf[2]:=pw[1,i1,2]   end   end;
   if pt<4 then h:=md[1,5];dg:=md[1,6];q:=md[1,8];v0:=md[1,4];
   ip:=0;
   for aaa:=1 to 3 do begin
   kfi[aaa]:=0
   end;
   t:=0.0;if pt>6 then begin
   gn1:=sqrt((v0*v0/md[1,15]/g)*(v0*v0/md[1,15]/g)+1.0);
   if (pt=7) or (pt=9) then
   gn2:=sqrt((v0*v0/md[1,16]/g)*(v0*v0/md[1,16]/g)+1.0);
   end;
   ttek:=0.0;
   if (h<ogrH) and (kolkoor=3) then NLC:=1; {ветка расчёта для НЛЦ}
SHAPKA;
   sf3:=0.0; dek3:=0.0;


 cg[1]:=WX[2,1,20];{СИГМА ДАЛЬНОСТИ РЕЖИМ ТОЧНОГО СОПРОВОЖДЕНИЯ ПРИ ВРАЩ. ФАР}
 sigb0:=WX[2,1,21];{sigma beta0}
 sige0:=WX[2,1,22];{sigma epsilon0}

   {****************************************************************************}
   for i:=1 to kt do begin {НАЧАЛО ЦИКЛА ПО ТРАЕКТОРИИ}
      {высокая точность}
   IF disk=1 THEN BEGIN    { переменный  дискрет }     {2}
  if i<>kt then begin
    dt:=dt_sek[i];   dte:=dt*(k1+1);
      ttek:=ttek+dt;
      ttdi[i]:=ttek;
                    end
else begin
ttek:=ttek+dt;
dte:=dte;
ttdi[i]:=ttek;
     end;
                  END;                    {2}
         {постоянный дискрет - период обзора в меню}
 IF DISK=0 THEN begin
// DT:=DTNA;
 dte:=dtNA*(k1+1);ttek:=ttek+dtNA;ttdi[i]:=ttek;
                end;
if ism_is=1 then goto ism0;

if sig_izm=0 then {ДЛЯ Постоянных СИГМ ИЗМЕРЕНИЯ}
   BEGIN
   CG[1]:=WX[2,1,20];
   CG[2]:=sigb0;
   CG[3]:=sige0; END;
if sig_izm=1 then
   BEGIN
 CG[1]:=WX[2,1,20];
 CG[2]:=sigb0*SIGUG[2,I];{ДЛЯ ПЕРЕМЕННЫХ СИГМ ИЗМЕРЕНИЯ, НАПРИМЕР, ПРИ КАЧКАХ}
 CG[3]:=sige0*SIGUG[3,I];
   end;

{****************************************************************************}
TRASSA1(n,t,ttek,sf[1],sf[2],sf[3],dek[1],dek[2],dek[3],vtek,dg,h,ha,mf,md,mv,mq,mte);
{****************************************************************************}
   sf3:=sf[3]; dek3:=dek[3];
   if KolKoor=2 then begin sf[3]:=0.0; dek[3]:=0.0; end;
   if (j=1) and (i<=kt) then  begin
   writeln(fout,' ');
   writeln(fout,'X1 = ',dek[1]:8:3);
   writeln(fout,'Y1 = ',dek[2]:8:3);
   if KolKoor=3 then
   writeln(fout,'Z1 = ',dek[3]:8:3);
   writeln(fout,'R  = ',sf[1]:8:3);
   writeln(fout,'B1 = ',sf[2]:9:5);
   if KolKoor=3 then
    begin
      writeln(fout,'E1 = ',sf[3]:8:5);
   {Градусы, минуты, доли минуты. UM real в объявлении}
      GRAMISO(SF[3],UG,UM);
    end;
   if (i=1) and (pt=8) then  writeln(fout,'время на 1-ом развороте = ', md[1,21]:6:3);
ism0: if ism_is=1 then  writeln(fout,' ');

   writeln(fout,'I  = ' ,i);
   writeln(fout,'TT = ',ttek:5:2)   end;
   for aaa:=1 to 3 do sfs[aaa]:=sf[aaa];

mmm: {******************** начало VOI **********************}

   if i<3 then goto mc0;
   eta:=random;
   if eta>po2 then begin  ppo:=0; goto bm3;end;
mc0:ppo:=1;k1:=0;

      for aaa:=1 to kolkoor do begin
    GAUSS(am,dsl,ksi);
//    ksi:=ksi_gaus[aaa,i];
    sq[aaa,1]:=sf[aaa]+ksi*cg[aaa];
        ma1[aaa]:=sq[aaa,1];
      if (j=1) and ((lw=1) or (lw=33)) then
    delko[aaa,i]:=sq[aaa,1]-sf[aaa];
     end;
    {получение дельты измеренных и точных декартовых координат для MKFIL}
  if (j=1) and (lw=0) then begin
  PR(ma1,ma2,cg,cgd);
  for aaa:=1 to kolkoor do
  delko[aaa,i]:=ma2[aaa]-dek[aaa];
  if j=1 then writeln(fout,'Xизм= ',ma2[1]:9:6,' Yизм= ',ma2[2]:9:6,' Zизм= ',ma2[3]:9:6);
                            end;
{  @@@@@@@@@@@@@@@@@@@@@@@   ВСТАВКА ИЗМЕРЕНИЙ ПО ИСПЫTАНИЯМ @@@@@@@@@@@@@@}
if ism_is=1 then begin
   sq[1,1]:=Dizm[i];
   sq[2,1]:=Bizm[i]*radian;
   sq[3,1]:=Eizm[i]*radian;
                     end;
{  @@@@@@@@@@@@@@@@@@@@@@@   ВСТАВКА ИЗМЕРЕНИЙ ПО ИСПЫTАНИЯМ @@@@@@@@@@@@@@}

   bbb1:=cg[2]*1000*3.6;
     if (j=1) and (i<=kt) then
   if KolKoor=3 then  writeln(fout,'ИЗМ. КООРДИНАТЫ  ',sq[1,1]:7:4,'  ',sq[2,1]:8:4,'  ',sq[3,1]:8:4)
                else  writeln(fout,'ИЗМ. КООРДИНАТЫ  ',sq[1,1]:8:4,'  ',sq[2,1]:8:4);

   if (j=1) and (i=1) THEN begin
   if KolKoor=3 then writeln(fout,'СИГМЫ  ',cg[1]:6:3,'  ',cg[2]:9:5,'  ',cg[3]:9:5)
                else writeln(fout,'СИГМЫ  ',cg[1]:6:3,'  ',cg[2]:9:5{bbb1:9:5});
               end;
   if (j=1) and (i<=kt) then begin
   for k:=1 to kolkoor do begin cgsf[k,i]:=cg[k]   end  end;
   if kolkoor=3 then begin
   cgsf[4,i]:=1;cgsf[5,i]:=1;
                      end;
   if kolkoor=2 then begin
   cgsf[3,i]:=1;cgsf[4,i]:=1;
                      end;
  { if lw=0 then begin} if j=1 then begin
   PR(sf,dp,cg,cgd);
   for k:=1 to kolkoor do begin
    sigg[k,i]:=cgd[k];
      end
   {end}  end;
   if kolkoor=3 then begin
     sigg[4,i]:=1;
     sigg[5,i]:=1;
                     end;
   if kolkoor=2 then begin
     sigg[3,i]:=1;
     sigg[4,i]:=1;
                     end;

bm3:if ip<1 then goto l1;

   if l[7]<>1 then goto l0;
   for k:=1 to 3 do begin dq[k,4]:=ex(dq[k,2],dq[k,3],dte);
  if (ppf=6) or (ppf=7) then dq[k,4]:=dq[k,4]+dq[k,5]*dte*dte  end;
  if (ppf=2) or (ppf=3) or (ppf=9) then begin
        for cirk:=1 to 3 do begin
   ma1[cirk]:=dq[cirk,4];
   if KolKoor=2 then ma1[3]:=0.0;
                            end;
   OBP(ma1,ma2);
   for cirk:=1 to 3 do begin
   sq[cirk,4]:=ma2[cirk]
   end;
   if (j=1) and (i<=kt) then begin
   writeln(fout,'экстраполир.сф.',sq[1,4]:7:4,sq[2,4]:8:4,sq[3,4]:8:4);
   writeln(fout,'экстраполир.дек.',dq[1,4]:8:4,dq[2,4]:8:4,dq[3,4]:8:4)
   end
   end;{условие для filr,filrt}
   if (Lw=1) or (Lw=33) then begin
   for cirk:=1 to 3 do begin
   ma1[cirk]:=dq[cirk,4];
   if KolKoor=2 then ma1[3]:=0.0;
   end;
   OBP(ma1,ma2);
   for cirk:=1 to 3 do begin
   sq[cirk,4]:=ma2[cirk]
   end
   end;
   goto l1;
l0:for k:=1 to 3 do begin   sq[k,4]:=ex(sq[k,2],sq[k,3],dte)  end;
l1:if ppo=1 then goto l2;
   if i=1 then goto l8;
l2:if i>1 then goto l3;
   { ************* первая отметка *****************}
      if l[7]=1 then begin
   for cirk:=1 to 3 do begin
   ma1[cirk]:=sq[cirk,1];
   if KolKoor=2 then ma1[3]:=0.0;
    if (j=1) and ((lw=1) or (lw=33)) then
   delko[cirk+4,I]:=ma1[cirk]-sf[cirk];
   end;
   PR(ma1,ma2,cg,cgd);
   for cirk:=1 to 3 do begin
   dq[cirk,5]:=ma2[cirk];
    if (j=1) and (lw=0) then
   delko[cirk+4,I]:=ma2[cirk]-dek[cirk];
{   if (ppf=6) or (ppf=7) then delko[cirk+4,I]:=ma2[cirk]-DEK[cirk];}
   end;
   IF NLC=1 then BEGIN
    if ma2[3]>=z00 then
    dq[3,5]:=sq[1,1]*sin(sq[3,1])
    else
    dq[3,5]:=z00;
                 END
   end else begin
   for k:=1 to 3 do begin
   sq[k,5]:=sq[k,1]   end   end;
   goto l8;
l3:if ip>=1 then goto l4;
 { **************** ВТОРАЯ ОТМЕТКА ***************}
   for cirk:=1 to 3 do begin
   nf[cirk]:=2
   end;
   ip:=1;
   if l[7]=1 then begin    {1}
   for cirk:=1 to 3 do begin  {2}
   ma1[cirk]:=sq[cirk,1];
   if KolKoor=2 then ma1[3]:=0.0;
   end;                        {2}
   PR(ma1,ma2,cg,cgd);
   for cirk:=1 to 3 do begin   {3}
   dq[cirk,2]:=ma2[cirk];
      end;                          {3}
   IF NLC=1 then BEGIN
    if dq[3,2]>=z00 then
    dq[3,2]:=sq[1,1]*sin(sq[3,1])
    else
    dq[3,2]:=z00;
                 END;
   for k:=1 to 3 do begin         {4}
   dq[k,3]:=tc(dq[k,2],dq[k,5],dte);dq[k,5]:=dq[k,2];
   if VX<>0 then begin
  dq[1,3]:=VX;
  dq[2,3]:=VX; end;
     end; {4}
   { &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& }
 {ЗАКОММЕНТИРОВАНЫ КОМАНДЫ ДЛЯ РАСЧЕТА ПРИ ИСПОЛЬЗОВАНИИ РАДИАЛЬНОЙ СКОРОСТИ}
(*   if abs(dq[1,3])<abs(ogrx2) then dq[1,3]:=ogrx2;
   if abs(dq[2,3])<abs(ogrx2) then dq[2,3]:=ogrx2;
   if abs(dq[1,3])>abs(ogrx1) then dq[1,3]:=ogrx1;
   if abs(dq[2,3])>abs(ogrx1) then dq[2,3]:=ogrx1;*)
   if dq[3,3]>ogrv  then dq[3,3]:=ogrv;
   { &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& }
   if (Lw=1) or (Lw=33) then goto l5;
   for k:=1 to 3 do begin {5}
   aq[k]:=dq[k,2];kdt[k]:=dek[k];
     if j=1 then
   delko[k+4,I]:=aq[k]-kdt[k];
   deltak[k]:=aq[k]-kdt[k]
                      end;   {5}
   if j=1 then begin
if KolKoor=3 then writeln(fout,'дельты оценок (м) x,y,z ',deltak[1]*1000:9:6,'  ',deltak[2]*1000:9:6,'  ',deltak[3]*1000:9:6);
if KolKoor=2 then writeln(fout,'дельты оценок (м) x,y ',deltak[1]*1000:9:6,'  ',deltak[2]*1000:9:6);
               end;
 V_Q_H(KOL_PAR,rabocQ);
   goto l12
   end;    {1}
   for k:=1 to 3 do begin  sq[k,3]:=tc(sq[k,1],sq[k,5],dte)  end; {l7=0}
l5:  for k:=1 to 3 do begin  sq[k,2]:=sq[k,1];sq[k,5]:=sq[k,1];
        aq[k]:=sq[k,2]; kdt[k]:=sf[k];
        if j=1   then delko[k+4,I]:=aq[k]-kdt[k];
        deltak[k]:=aq[k]-kdt[k]  end;
   if j=1 then begin
if KolKoor=3 then writeln(fout,'дельты R(м),b,e ',deltak[1]*1000:9:6,'  ',deltak[2]:9:6,'  ',deltak[3]:9:6);
if KolKoor=2 then writeln(fout,'дельты R(м),b ',deltak[1]*1000:9:6,'  ',deltak[2]:9:6);
               end;
  V_Q_H(KOL_PAR,rabocQ);
   goto l12;
    {**************** третья и последующие отметки *************}
l4:  if l[7]=1 then begin
   for cirk:=1 to 3 do begin
   ma1[cirk]:=sq[cirk,1];
   if KolKoor=2 then ma1[3]:=0.0;
   end;
   PR(ma1,ma2,cg,cgd);
   for cirk:=1 to 3 do begin
   dq[cirk,1]:=ma2[cirk]
   end
   end;
   if NLC=1 then
   rzrab:=dq[3,2];
   VIFIL(ppf);
   if NLC=1 then
    dq[3,2]:=rzrab;
if (j=1) and (i<=kt) and (ppf=9) then
writeln(fout,'коэффициенты фильтра FILZ3',' K1 = ',rk[1]:9:6,' K2 = ',rk[2]:9:6,
             ' K3 = ',rk[3]:9:6);
   if l[7]<>1 then goto l13;
   if lw=0 then goto l11;
   if NLC=1 then
   dq[3,2]:=(1-alnlc)*dq[3,1]+alnlc*dq[3,2];
   for cirk:=1 to 3 do begin
   ma1[cirk]:=dq[cirk,2];
   if KolKoor=2 then ma1[3]:=0.0;
   end;
   OBP(ma1,ma2);
   for cirk:=1 to 3 do begin
   sq[cirk,2]:=ma2[cirk]
   end;
l13:for k:=1 to 3 do begin   aq[k]:=sq[k,2];kdt[k]:=sf[k];
                             deltak[k]:=aq[k]-kdt[k];
    if j=1 then
   delko[k+4,I]:=aq[k]-kdt[k];
      end;
   if (j=1) and (i<=kt) then begin
   if KolKoor=3 then writeln(fout,'оценки x,y,z ',dq[1,2]:9:6,'  ',dq[2,2]:9:6,'  ',dq[3,2]:9:6)
                else writeln(fout,'оценки x,y ',dq[1,2]:9:6,'  ',dq[2,2]:9:6);
if KolKoor=3 then writeln(fout,'дельты (м) x,y,z ',deltak[1]*1000:9:6,'  ',deltak[2]*1000:9:6,'  ',deltak[3]*1000:9:6);
if KolKoor=2 then writeln(fout,'дельты (м) x,y ',deltak[1]*1000:9:6,'  ',deltak[2]*1000:9:6);
if KolKoor=3 then  writeln(fout,'оценки r,b,e,dte ',sq[1,2]:8:3,'  ',sq[2,2]:8:5,'  ',sq[3,2]:8:5,'  ',dte:4:1)
    else  writeln(fout,'оценки r,b,dte ',sq[1,2]:8:3,'  ',sq[2,2]:8:5,'  ',dte:4:1);
if KolKoor=3 then writeln(fout,'дельты R(м),b,e ',deltak[1]*1000:9:6,'  ',deltak[2]:9:6,'  ',deltak[3]:9:6);
if KolKoor=2 then writeln(fout,'дельты R(м),b ',deltak[1]*1000:9:6,'  ',deltak[2]:9:6);
    end;

V_Q_H(KOL_PAR,rabocQ);
   goto l12;
l11:
   if NLC=1 then
   dq[3,2]:=(1-alnlc)*dq[3,1]+alnlc*dq[3,2];
   for k:=1 to 3 do begin   aq[k]:=dq[k,2];kdt[k]:=dek[k];
                             deltak[k]:=aq[k]-kdt[k];
    if j=1   then
   delko[k+4,I]:=aq[k]-kdt[k];
                    end;
   if (j=1) and (i<=kt) then begin
   if KolKoor=3 then writeln(fout,'оценки x,y,z ',dq[1,2]:9:6,'  ',dq[2,2]:9:6,'  ',dq[3,2]:9:6)
                else writeln(fout,'оценки x,y ',dq[1,2]:9:6,'  ',dq[2,2]:9:6);
if KolKoor=3 then writeln(fout,'дельты (м) x,y,z ',deltak[1]*1000:9:6,'  ',deltak[2]*1000:9:6,'  ',deltak[3]*1000:9:6);
if KolKoor=2 then writeln(fout,'дельты (м) x,y ',deltak[1]*1000:9:6,'  ',deltak[2]*1000:9:6);
                              end;

V_Q_H(KOL_PAR,rabocQ);

l12:{ZHV;}
     if   (lw=1) or (lw=33) then begin
     FOR K:=2 TO 3 DO BEGIN
   IF (AQ[K]>=3*PI*0.5) AND (KDT[K]<=0.5*PI) THEN
   AQ[K]:=AQ[K]-2*PI;
                    END;         end;
   if (j<=2) and (i=2) then
   aaa:=aaa;
   NAKSUM(i,aq,kdt,ac,im,njd);
l8:
li:

   end; {КЦ ПО ТРАЕКТОРИИ }

if j=1 then begin   {1}
for aaa:=1 to Kolkoor do begin {2}
if (Lw=1) or (Lw=33) then begin     {3}
if aaa=1 then
writeln(fout, 'отклонения по дальности');
if aaa=2 then
writeln(fout, 'отклонения по пеленгу');
if (aaa=3) and (NLC=0) then
writeln(fout, 'отклонения по углу места');
end;                    {3}
if lw=0 then begin       {4}
if aaa=1 then
writeln(fout, 'отклонения по X');
if aaa=2 then
writeln(fout, 'отклонения по Y');
if (aaa=3) and (NLC=0) then
writeln(fout, 'отклонения по Z');
end;                       {4}
for n1:=1 to kt do
writeln(fout,'N точ.= ',n1:2,'  ош. изм.(м) = ',DELKO[aaa,n1]*1000:9:5,'  ош. фильтр.(м) = ',DELKO[aaa+4,n1]*1000:9:5);
          end;{2}
           end; {1}

   end;{КЦ ПО РЕАЛИЗАЦИЯМ}
grafik1R;

LNLC:   for i0:=1 to im do begin        {1}
   CON:=2;
   for j0:=con to kt do begin                   {2}
   qk:=ac[i0,j0];qp:=ac[i0+im,j0];
   DISPER(jk,qk,qp,qd,qmo,j0,Njd);
   disp[i0,j0]:=qd;
   if (ppf=6) or (ppf=7) then begin
   asf[1]:=disp[1,con];
   asf[2]:=disp[2,con];
   asf[3]:=disp[3,con];
                               end;
         if LREZ=0 then begin                         {3}
      if (KOLKOOR=2) and (i0=3) then goto l22;
      if lw=0 then disp[I0,J0]:=qd/sigg[i0,2]
      else    disp[i0,j0]:=qd/cgsf[i0,2];
      l22:   Gpr[i0]:=0.75;Gin[i0]:=1.0;Dg0:=0.2   end;    {3}
         if LREZ=1 then begin {4}
 Gpr[i0]:=0.75*disp[i0,2];Gin[i0]:=disp[i0,2];Dg0:=0.2  end {4}
      end;{к.ц. по j0}   {2}

    if i0=1 then begin       {5}
    if LREZ=1 then begin    {6}
    if (lw=1) or (lw=33) then nadp[1]:='     стат. оц. D (М)      '
    else                      nadp[1]:='     стат. оц. X (М)      '; end; {6}
   if LREZ=0 then begin  {7}
   if ((lw=1) or (lw=33)) then nadp[1]:='  стат. оц. D      '
    else                       nadp[1]:='   стат. оц.  X      '; end;  {7}
        k0:=1;
        goto l9  end;         {5}

   if i0=2 then begin          {8}
   if LREZ=1 then begin        {9}
    if (lw=1) or (lw=33) then nadp[2]:=' стат. оц. ПЕЛЕНГА (mrad), (ш) '
    else                      nadp[2]:='   стат. оц.  Y (М) '; end; {9}
    if LREZ=0 then begin {10}
 if ((lw=1) or (lw=33)) then nadp[2]:='      стат. оц. ПЕЛЕНГА '
    else                     nadp[2]:='    стат. оц.  Y  '; end;{10}
   k0:=2;
   goto l9  end;            {8}

    if (i0=3) and (kolkoor=3) then begin    {11}
  if LREZ=1 then begin {12}
if (lw=1) or (lw=33) then nadp[3]:=' стат. оц. УГЛА МЕСТА (mrad), (ш)      '
else                      nadp[3]:='   стат. оц.  Z (М)   ';end; {12}
   if LREZ=0 then begin    {13}
if ((lw=1) or (lw=33)) then nadp[3]:=' стат. оц. УГЛА МЕСТА     '
else                        nadp[3]:='    стат. оц.  Z      ';end;{13}
   k0:=3;
   goto l9  end;            {11}

   if kolkoor=3 then begin {################################}
   if KOL_PAR=1 then BEGIN  {1 parameter}
    if (i0=4) and (ocV=1) then begin              {14}
       nadp[i0]:='   стат. оц.  СКОРОСТИ (М/С) ';
       k0:=4; goto l9 end;                        {14}
    if (i0=4) and (ocH=1) then begin
       nadp[i0]:='   стат. оц.  ВЫСОТЫ (М) ';
       k0:=4; goto l9 end;
    if (i0=4) and (ocH=1) then begin
       nadp[i0]:='   стат. оц. КУРСА (mrad), (ш) ';
       k0:=4; goto l9 end;
                      END;  {1 parameter}
   if KOL_PAR=2 then BEGIN  {2 parameter}
    if (i0=4) and (ocV=1) then begin              {14a}
       nadp[i0]:='   стат. оц.  СКОРОСТИ (М/С) ';
       k0:=4; goto l9 end;                        {14a}
     if (i0=5) then begin    {15}
       if ocQ=1 then nadp[i0]:='   стат. оц.  КУРСА (mrad), (ш) ';
       if ocH=1 then nadp[i0]:='   стат. оц.  ВЫСОТЫ (М) ';
       k0:=5;  goto l9  end;               {15}
                      END;   {2 parameter}
                     end; {################################}
   if kolkoor=2 then begin { &&&&&&&&&&&&&}
   if KOL_PAR=1 then BEGIN  {1 parameter}
    if (i0=3) and (ocV=1) then begin              {16}
    nadp[i0]:='   стат. оц. СКОРОСТИ (М/С) ';
       k0:=3; goto l9 end;             {16}
    if (i0=3) and (ocH=1) then begin
       nadp[i0]:='   стат. оц. ВЫСОТЫ (М) ';
       k0:=3; goto l9 end;
    if (i0=3) and (ocQ=1) then begin
       nadp[i0]:='   стат. оц. КУРСА (mrad), (ш) ';
       k0:=3; goto l9 end;
                      END;  {1 parameter}
   if KOL_PAR=2 then BEGIN  {2 parameter}
    if (i0=3) and (ocV=1) then begin              {14a}
       nadp[i0]:='   стат. оц. СКОРОСТИ (М/С) ';
       k0:=3; goto l9 end;                        {14a}
     if (i0=4) then begin    {17}
       if ocQ=1 then nadp[i0]:='    стат. оц.  КУРСА (mrad), (ш) ';
       if ocH=1 then nadp[i0]:='    стат. оц.  ВЫСОТЫ (М) ';
       k0:=4;  goto l9  end;               {17}
                     END {2 parameter}
                     end; { &&&&&&&&&&&&&}
   l9:  end;    {кц по i0  5}
{для двух или трёх координат и V как параметра движения}
      con:=2;
     for j0:=1 to im do begin
     k0d:=k0d;
     if (j0<3) then k0d:=0;
     if (j0=3) or (j0=4) then k0d:=2;
     if (j0=5) then k0d:=5;
     for j5:=con to kt do begin         {15}
     if ((k0d=0) and (j0=1)) or ((k0d=2) and (j0=3)) then begin
     if j5=con then begin    {15a}
     obc:=nadp[1+k0d]+nadp[2+k0d];
     writeln(excel,obc);
     writeln(fout,obc);
          end;  end; {15a}
     if (j0=5) and (j5=con) then
     begin   {15b}
     obc:=nadp[5];
writeln(excel,obc);
     writeln(fout,obc);
     end;      {15b}

  if LREZ=0 then begin {ПОЛУЧЕНИЕ ОТНОСИТЕЛЬНЫХ ВЕЛИЧИН СКО}
    pr_otn:=0;
    otnosit_w(pr_otn);
    if pr_otn=1 then goto KKK;
                  end;
    if LREZ=1 then begin    {17}
     if (k0d=0) or (k0d=2) then  Npar:=0;
     if k0d=5 then
      Npar:=1;
    ABS_WYW(kolkoor,Npar,kol_par);
     end;                   {17}
KKK:   end; {15}
  end; {***}

   if (disk=1) or ((disk=0) and (SHAG_SGL=1)) then begin {a}
  writeln(fout,'массив времен, соответствующих номеру точки на графике');
  for k:=2 to kt do
  writeln(fout,'   ',k,'  ',ttdi[k]:9:6);
                  end;    {a}

  disp[1,1]:=disp[1,2];disp[2,1]:=disp[2,2];disp[3,1]:=disp[3,2];disp[4,1]:=disp[4,2];
    if ocV=1 then begin      {b}
   disp[4,2]:=(disp[4,2]+disp[4,3])/2;
                  end;       {b}

   for j:=1 to im do begin
   for n1:=1 to kt do begin
   rdspr[j,n1]:=disp[j,n1];
   CKO_ED[j,n1]:=disp[j,n1];
      if VX<>0 then begin
      if n1<kt then
      rdspr[4,n1]:=disp[4,n1+1];
      if n1=kt then rdspr[4,n1]:=disp[4,n1];
                    end;
   end; end;

{******************* формирование данных для построения графика ********}
grafik_Nre;
 { ЕСЛИ ПРЕДУСМОТРЕН ВЫВОД ДЛЯ ФИЛЬТРА MKFIL НЕ ТОЛЬКО В ДЕКАРТОВОЙ,
   НО И В СФЕРИЧЕСКОЙ СИСТЕМЕ КООРДИНАТ ТО ОБРАЩЕНИЕ К ПРОЦЕДУРЕ CKO_DEK_SF}
   if dek_sf=1 then
   CKO_DEK_SF(asf,ppf);
    close(fout);
    close(excel);
    END; {procedure OSNOWA_CKO}
    end.  {конец модуля СКО}
