program DIRFIND;
     {***************************************************
                Модель пеленгатора, состоящего из
                антенной решетки и спецпроцессора ЦОС
                   (версия 3.0)
      Алгоритмы пеленгации:
          неадаптивный с весовым суммированием;
          MUSIC; Кейпона и пр.
                 (5 августа 1999 г.)
      ***************************************************}

{*** Для К  *****
uses Graph,Printer,crt,Dos,IMATH,IUSINT,KDATFORM,IDATPROC;}
{*** Рабочий вариант                                       }
uses Graph,Printer,crt,Dos,IMATH,IUSINT,IDATFORM,IDATPROC;
label      Mt21,Mt22,Mt22a,Mt23,Mt24,Mt24a, Mt25, Mt31, Mt32, Mt33, Mt34,
           Mt35, Mt36,
           MTPis,MTG_Sh,MTKNAC,MTKNAC_F,MTKEND,MET_SAVZ;
var
  i,j,k,l,mr,om,ii,st,st1  : integer;
  I1max, I2max, nrz,k1,k2  : integer;
  Nstat, Nisp,Imin,Amin    : integer;
      Shema,Lpoint         : integer;
      TypeRandA,TypeRandF  : integer;
  a,b,c,s,q,qt,qn,qv,d     : double;
  xmin,xmax,ymin,ymax,ENdb : double;
 r,sum,eps,Dlr,Tnab,EAsm   : double;
  eNmaxI1, eNminI, eNminA  : double;
  Pr,Prmin,Prmax,dPr       : double;
     MaxDNP,BeamW,RmseTh    : Double;
    NameFD,Vt              : string;
  Vtext, Vtext1, Kvadr     : string;
  F_dpf,ENm                : ^Xn; { Массив частот }
       RandV, VecAFV_AR    : ^LongVector; { Векторы мплитудных и фазовых возмущений }
       qqq1                : ^Xxx1;
        Msv,Ann,Bnn,Fnn    : ^matrix;
  Vsz,Vszs,Pmc             : vector;
(*********************************************)
              M_OutAr_dig      : MasOutAr_dig;
 M_OutAr_anl,M_OutAr_anl_ad    : MasOutAr_anl;
                    Memory     : LongInt;

 { Переменные для обработки статистических данных }
                M_StatTests    : MasStatTests;
          NSourc, NBasParam    : Byte;  { Число оцениваемых параметров для каждого источника }
              PovtorP, Lpnt    : Byte;

                   M_ModPar    : MatrModelParamInf;
                   M_EstPar    : MatrEstimParamInf;
                     OutTxt    : TOutInf;
                {   QQQst   : VDNFst; }  { массив ВДНЧ размером 8х100 }
(*********************************************)
            Nep,Npd,Nar    : integer;
                   DNp     : complex;
                 nox,noy   : shortint;

             BGIFileName: String;
             FPtr       : Pointer;
             Size       : Word;
  begin
  GrInit;
  RestoreCRTMode;

  Memory:=MemAvail;
  New(Enm);
  New(F_dpf);
  New(qqq1);
  New(Msv); { New(Bnn); } New(Fnn);
  Memory:=MemAvail;

{  TextAttr:=White + 16*Black;
  ClrScr;
  TextAttr:=Yellow + 16*Red;
  Window(10,8,70,20);
  writeln(' ':60);
  writeln('        Пространственно-временная обработка сигналов        ');
  writeln('        в РЛС с цифровыми антенными  решетками              ');
  writeln(' ':60);
  writeln('        Автор: И.Р. Уразгильдиев                            ');
  writeln(' ':60);
  readln;
  TextBackGround(Black);
  ClrScr;
  NormVideo;
  Window(1,1,80,25);

  BGIFileName:='C:\BP\BGI\scri.chr';
  LoadFont(BGIFileName, FPtr,Size);}

  SetGraphMode(GraphMode);
{  SetBkColor(White);
  SetViewPort(10*sx,8*sy,20*sx,30*sy,ClipOn);
  ClearViewPort;  }
  SetBkColor(Red);
  SetColor(Yellow);
{  SetTextStyle(DefaultFont,HorizDir,2);}
  SetTextStyle(0,HorizDir,2);
  i:=GraphResult;
  Vtext:='Пространственно-временная';
  OuttextXY(12*sx,14*sy,Vtext);
  Vtext:='обработка сигналов  в РЛС';
  OuttextXY(12*sx,18*sy,Vtext);
  Vtext:='с цифровыми антенными решетками';
  OuttextXY(7*sx,22*sy,Vtext);
{  SetTextStyle(DefaultFont,HorizDir,1);
  SetTextStyle(TriplexFont,HorizDir,2);
  OuttextXY(1*sx,2*sy,Vtext);}
  Readln;
  RestoreCrtMode;

  PovtorP:=0;
  AimProg:=1;  AimStAn:=0; TypeCM:=0;
  Nep:=1; Npd:=8; Dlr:=1.0; M:=2;  Sa:=0.; Sf:=0.0;  Kv:=60;
  PriznADT:=1; N_ADT:=12;  Fd_r:=360;  aBeam:=0.15;
  Qm[1]:=2;
  ENm^[1]:=30;
  Fm[1]:=100;   Fm[2]:=103; Fm[3]:=2;   Fm[4]:=4;
  TypSig[1]:=3;  TypSig[2]:=3;
  DeltaQ:=0.5;  RAsm:=1.2;
  TypeRandA:=1;  TypeRandF:=1;  NameAlg:=3;   Lpoint:=200;   Lpnt:=50;
  Nstat:=100;  eps:=1e-5;

  New(RandV);
  RandomVec(SizeMax,TypeRandA,TypeRandF,RandV^);
{  MasAF(Sa,Sf, Nar,TypeRandA,TypeRandF, VecAFV_AR^);}



MTKNAC:
  for i:=1 to SizeTsk do Lcrl[i]:=0;  { Число зацикливаний итерац. процедуры }
  Pmin:=0;  Pper:=0;  Pasm:=0;   P02:=1;
  VvIsDan1(Nep,Npd,Nar,Lpoint,TypeRandA,TypeRandF,Dlr,ENdb,BeamW,Enm^,qqq1^,
           NameFD,Tnab,MaxDNP,M_ModPar,OutTxt,RandV^);

  If AimProg =0 then Nstat:=1;


  a:=AstX(10,0.1*Endb);
  a:=sqrt(a/(Nar*Kv)+1);   Umax:=2*a;
  If Umax<3*Sgn then Umax:=3*SgN;
{  Kvadr:='Пр. Гильберта';}
  Kvadr:='Квадратура';
{  writeln('Введите геометрию МЛЗ1 ');
  VvodApert(Tn1);
  writeln('Введите геометрию МЛЗ2 ');
  VvodApert(Tn2); }

  Case PriznADT of
  0: begin
       Vtext:='';
       write('Цифровое формирование квадратур не производится ?  (Да)'); readln(Vtext);
       if Vtext <> '' then PriznADT:=1;
     end;
  1: begin
       Vtext:='';
       write('Цифровое формирование квадратур производится ?  (Да)'); readln(Vtext);
       if Vtext <> '' then PriznADT:=0;
     end;
  end;

  if PriznADT=1 then begin

     writeln('Вводятся параметры цифровых сигналов на выходах ФД: ');
  { Формирование массива N выходных цифровых сигналов с учетом АФВ }
Mt25:
   Vtext:='';
   write('Число разрядов (включая знаковый) ',N_ADT,'  -> ');
   readln(Vtext);
   if Vtext<>'' then begin
      Val(Vtext,N_ADT,i);
      if (i<>0) or (N_ADT<=0) then begin
         writeln('Ошибка при вводе! Повторите');
         goto Mt25;
      end;
   end;
     Vtext:='';
     write('Режим работы формирователя - линейный (Pmax=',a:4:2,' Umax=',Umax:4:2,')  ?  (Да)');
     readln(Vtext);
     if Vtext <> '' then begin
        write('Введите Umax ');  readln(Umax);
     end;
     OutTxt[2]:=OutTxt[2]+'АЦП:лин.реж.; ';
     str(a:4:2,Vtext);
     OutTxt[2]:=OutTxt[2]+'Pmax='+ Vtext + '; ';
     str(Umax:4:2,Vtext);
     OutTxt[2]:=OutTxt[2]+'Umax='+ Vtext + '; ';

   {  P02:=(P02*AstX(2,N_ADT-1)/Umax);}
  end;
  for j:=1 to Npd do Tn[j]:=DnAR[1 + (j-1)*Nep];

  if TypeCM=0 then
  begin
    { Формирование массива М входных сигналов MasSig }
    { для случая формирования выборочной КМ }
     for i:=1 to M do New(MasSigP[i]);
     FormMasSig(M_ModPar);

     for j:=1 to Nar do New(M_OutAr_anl[j])
  end;
{
  D:=0;
  for i:=1 to Nar do D:=D+sqr(DnAR[i]);
  for j:=1 to M do begin
      If M_ModPar[j,3].sign='Noise' then
         a:=dlr/sqrt(Pm[j]*Kv*D* sqr(pi2 * cosD(Qm[j])))
      else
         a:=sqrt(1/(0.5*Pm[j]*Kv*D* sqr(pi2 * cosD(Qm[j]))));
      str(a:6:5,Vtext);
      M_ModPar[j,5].sign:=Vtext;
  end; }

  New(VecAFV_AR);
  If AimStAn=0 then begin
    { Вычисление ВИП при анализе влияния внутренних шумов }
    { Формирование массива АФВ приемных каналов АР }
     If PovtorP=0 then
        MasAFRandV(Sa,Sf, Nar,TypeRandA,TypeRandF,RandV^,VecAFV_AR^)
     else
     begin
        Vtext:='';
        write('Вычислять новые реализации случайных АФВ  ?  (Нет)');
        readln(Vtext);
        if Vtext <> '' then
        begin
           RandomVec(SizeMax,TypeRandA,TypeRandF,RandV^);
           MasAFRandV(Sa,Sf, Nar,TypeRandA,TypeRandF,RandV^,VecAFV_AR^)
        end
        else MasAFRandV(Sa,Sf, Nar,TypeRandA,TypeRandF,RandV^,VecAFV_AR^);
     end;

     if TypeCM=0 then
     begin
        { Формирование массива N выходных аналоговых сигналов с учетом АФВ }
        { Случай формирования выборочной КМ }
        ForMasOutAr_anl(Nar,VecAFV_AR^,M_OutAr_anl);
        for i:=1 to M do  Dispose(MasSigP[i]);
     end;

  end
  else begin
        { Вычисление ВИП при статистическом анализе влияния АФВ }
        { Массив MasSigP  закрывается после проведения стат. испытаний}
  end;

  if TypeCM=0 then
  begin
    { Случай формирования выборочной КМ }
     for i:=1 to Npd do  New(MasVyxSigP[i])
  end
  else begin
    { Случай формирования среднестатистической КМ }
      SrStatKM(N, VecAFV_AR^, Fnn^);

  end;


  If Nstat<>1 then begin
Mt34:
     Vtext:='';
     write('Число статистических испытаний Nstat=',Nstat,'  -> ');
     readln(Vtext);
     If Vtext='e' then halt;
     if Vtext<>'' then begin
         Val(Vtext,Nstat,i);
         if (i<>0) or (Nstat<=0) or (Nstat>NumTests) then begin
             writeln('Ошибка при вводе! Повторите');
             goto Mt34;
         end;
     end;

  end;
  str(Nstat,Vtext);
  OutTxt[2]:=OutTxt[2]+'Nstat='+ Vtext + '; ';
  NSourc:=M;
  if Nstat>1 then begin
  { Начало цикла статистических испытаний }
Mt23:
     Vtext:='';
     write('Исследуется алгоритм ');
     case NameAlg of
     1: write('МП ?');
     2: write('Прямой матрицы ?');
     3: write('MUSIC');
     4: write('M-MUSIC ?');
     5: write('Кейпона');
     6: write('M-Keйпона ?');
     end;
     readln(Vtext);
     if Vtext <> '' then begin
        writeln('Выберите название исследуемого алгоритма ');
        write('1-МП;2-Bartlett;3-MUSIC;4-M-MUSIC;5-Capon;6-M-Capon');
        ReadLn(NameAlg);
        If NameAlg>6 then goto Mt23;
     end;
     IF NameAlg=1 then begin
        qn:=qqq1^[1]; qv:=qqq1^[Lpoint];
        qt:=(qv-qn)/(Lpnt-1);
        for i:=1 to Lpnt do qqq1^[i]:=qn+(i-1)*qt;
     end;

     If NSourc>NumSourc then NSourc:=NumSourc;
     NBasParam:=NumBasEstParam;
     Vtext:='';
Mt35:
     Vtext:='';
     write('Число оцениваемых источников сигналов ',NSourc,'  -> ');
     readln(Vtext);
     If Vtext='e' then halt;
     if Vtext<>'' then begin
         Val(Vtext,NSourc,i);
         if (i<>0) or (NSourc<=0) or (NSourc>NumSourc) then begin
             writeln('Ошибка при вводе! Повторите');
             goto Mt35;
         end;
     end;

     if (NameAlg=3) or (NameAlg=4) then
     begin
       St:=M;
Mt36:
       Vtext:='';
       write('Размерность подпространства St=',St,'  -> ');
       readln(Vtext);
       If Vtext='e' then halt;
       if Vtext<>'' then begin
           Val(Vtext,St,i);
           if (i<>0) or (St<=0) or (St>N) then begin
               writeln('Ошибка при вводе! Повторите');
               goto Mt36;
           end;
       end;
    end;
{     Vtext:='';
     write('Число оцениваемых параметров для каждого источника сигналов ',NParam,' ?  (Да)');
     readln(Vtext);
     if Vtext <> '' then begin
        write('Введите число оцениваемых источников (не более ', NumParam,') ');
        ReadLn(NParam);
        If NParam>NumParam then NParam:=NumParam;
     end;}

     TextBackGround(Red);
     TextColor(Yellow + Blink);
     Write('Ждите! Идут статистические испытания!');
     NormVideo;

    if TypeCM=0 then
    begin
    { Случай формирования выборочной КМ }
      for j:=1 to Nar do New(M_OutAr_anl_ad[j]);
    end;
     for j:=1 to Nstat do New(M_StatTests[j]);

     ii:=1;
     for Nisp:=1 to Nstat do begin

        If Nstat >= 50 then begin
          If Nisp>=round(0.1*ii*Nstat) then begin
            ClrScr;
            Writeln('Выполнено ',(100.0*Nisp/Nstat):3:1,' %  ',Nisp);
            ii:=ii+1;
          end;
        end;

        If AimStAn=0 then begin
           { Вычисление ВИП при анализе влияния внутренних шумов }
           for i:=1 to Nar do for k:=1 to Kv do
               M_OutAr_anl_ad[i]^[k]:=M_OutAr_anl[i]^[k];
           {!!! Массив M_OutAr_anl запоминается и не изменяется }
           { Все расчеты проводятся с массивом M_OutAr_anl_ad !!}

           { Наложение аддитивного шума приемных каналов. }
           AddNoise(Nar,M_OutAr_anl_ad);
        end
        else begin
           { Вычисление ВИП при анализе влияния АФВ }
           RandomVec(Nar,TypeRandA,TypeRandF,RandV^);  {Текущие значения АФВ}
           MasAFRandV(Sa,Sf, Nar,TypeRandA,TypeRandF,RandV^,VecAFV_AR^); { Текущ. вектор АФВ }
           if TypeCM=0 then
           begin
             { Случай формирования выборочной КМ }
             ForMasOutAr_anl(Nar,VecAFV_AR^,M_OutAr_anl_ad); {Текущий аналоговый выход АР }
           end
           else begin
              { Случай формирования среднестатистической КМ }
              SrStatKM(N, VecAFV_AR^, Fnn^);
              goto Mt32;
           end;

        end;

        { Аналого-цифровое преобразование выходных сигналов }
        if PriznADT=1 then begin
           for j:=1 to Nar do  New(M_OutAr_dig[j]);
           ForMasOutAr_dig(Nar,N_ADT,Umax,M_OutAr_anl_ad,M_OutAr_dig);

           { Формирование массива Npd цифровых сигналов
            с  выходов программно-реализованных подрешеток }

           ForMasOutDigPdr(Nep,Npd, MaxDNP,M_OutAr_dig,MasVyxSigP);
           for j:=1 to Nar do  Dispose(M_OutAr_dig[j]);
        end
        else begin
           ForMasOutAnlPdr(Nep,Npd, MaxDNP,M_OutAr_Anl_ad,MasVyxSigP);
        end;
        { Формирование корреляционной матрицы для нахождения оценок }

        Memory:=MemAvail;
        FormKMKS(MasVyxSigP,Fnn^);

Mt32:
        {****  Далее вставляется исследуемый алгоритм ****}
        Case NameAlg of
        1: begin
             MaxLiklDemoStatPel(NSourc,Lpnt,Nstat, qqq1^, Tn,Enm^, Fnn^, Pmc);
             if ( (Pmc[2].re-Pmc[1].re) <= (qqq1^[3]-qqq1^[1]) )
                or (Pmc[1].re=qqq1^[1]) or (Pmc[2].re=qqq1^[Lpnt])
             then Pmin:=Pmin+1;
           end;
        2: begin
              PrMatDemoStatPel(NSourc,Lpoint,Nstat, qqq1^, Tn,Enm^, Fnn^,
              Pmc, EAsm);
              If Kmin<NSourc then Pmin:=Pmin+1;
              If Kglm<NSourc then Pper:=Pper+1;
              If Kasm<NSourc then Pasm:=Pasm+1;
           end;
        3: begin
               If St>=N Then St:=N-1;
               savzStat(Fnn^,N,St,eps,Msv^,Vsz);
               MUSICstatPel(st,NSourc,Lpoint,Nstat, qqq1^,Tn,Enm^, Msv^,Fnn^, Vsz, Pmc,
               EAsm,2);
               If Kmin<NSourc then Pmin:=Pmin+1;
           end;
        4: begin
               If St>=N Then St:=N-1;
               savzStat(Fnn^,N,St,eps,Msv^,Vsz);
               MUSICstatPel(st,NSourc,Lpoint,Nstat, qqq1^,Tn,Enm^, Msv^, Fnn^,Vsz, Pmc,
               EAsm,1);
               If Kmin<NSourc then Pmin:=Pmin+1;
               If Kglm<NSourc then Pper:=Pper+1;
               If Kasm<NSourc then Pasm:=Pasm+1;
           end;
      5,6: begin
               If NameAlg=5 then
               CaponDemoStatPel(NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Fnn^,Pmc,EAsm,2)
               else
               CaponDemoStatPel(NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Fnn^,Pmc,EAsm,1);
               If St>=N Then St:=N-1;
               If Kmin<NSourc then
               Pmin:=Pmin+1;
               If Kglm<NSourc then Pper:=Pper+1;
               If Kasm<NSourc then Pasm:=Pasm+1;
           end;
        end;
        {****  конец исследуемого алгоритма           ****}
        {****  Заполняется массив статистических испытаний  ****}
        for i:=1 to NSourc do begin
            M_StatTests[NIsp]^[i,1]:=Pmc[i].re;
            M_StatTests[NIsp]^[i,2]:=Pmc[i].im;
            M_StatTests[NIsp]^[i,3]:=Lit[i];
        end;
        Memory:=MemAvail;
     end;

     for i:=1 to NSourc do begin
         M_EstPar[i,1].name:='DirOfArr';
        Case NameAlg of
         1,2: M_EstPar[i,2].name:='Power';
         3,4: M_EstPar[i,2].name:='НПХ,dB + Lit(SAVZ)';
         5,6: M_EstPar[i,2].name:='НПХ,dB';
        end;
     end;
     { Подпр. вычисления моментов оценок }
     Case NameAlg of
     1: OutTxt[3]:='Алгоритм МП   ';
     2: begin
          OutTxt[3]:='Алгоритм Прямой матрицы   ';
          str(RAsm:3:2,Vtext);
          OutTxt[3]:=OutTxt[3]+'RAsm='+ Vtext + ';) ';
        end;
     3,4: begin
          if NameAlg=3 then
             OutTxt[3]:='Алгоритм MUSIC   '
          else
             OutTxt[3]:='Алгоритм Analiz-Per-Asm(EigVectors)   ';
          str(eps:8,Vtext);
          OutTxt[3]:=OutTxt[3]+'(eps='+ Vtext + ';  ';
          str(St:2,Vtext);
          OutTxt[3]:=OutTxt[3]+'St='+ Vtext + ';  ';
          str(RAsm:3:2,Vtext);
          OutTxt[3]:=OutTxt[3]+'RAsm='+ Vtext + ';) ';
         end;
     5,6: begin
          if NameAlg=5 then
             OutTxt[3]:='Алгоритм Кейпона   '
          else
             OutTxt[3]:='Алгоритм Analiz-Per-Asm(InvMatr)   ';
          str(RAsm:3:2,Vtext);
          OutTxt[3]:=OutTxt[3]+'(RAsm='+ Vtext + ';) ';
         end;
     end;

     { Расчет теоретического СКО при наличии АФВ }
     If (TypeCM=1) or (AimStAn=1) then
         CountTheorRMSE(Sf,dlr, NSourc, RmseTh);
{     else CountCRB(Pm[1],Qm[1], dlr, Kv, RmseTh);}

     CountStatMom(Nstat,NSourc,NumModParamInf,NBasParam,Qm,M_StatTests,
                  BeamW,RmseTh,M_ModPar,M_EstPar,OutTxt);

     if TypeCM=0 then
     begin
       { Случай формирования выборочной КМ }
       for j:=1 to Nar do Dispose(M_OutAr_anl_ad[j]);
     end;

     for j:=1 to Nstat do Dispose(M_StatTests[j]);
  { Конец цикла статистических испытаний }
     goto Mtkend;
  end;

  If AimStAn<>0 then  for i:=1 to M do  Dispose(MasSigP[i]);

 { Наложение аддитивного шума приемных каналов. }
  if TypeCM=0 then
  begin
    AddNoise(Nar,M_OutAr_anl);


     IF PriznADT=1 then begin
        for j:=1 to Nar do  New(M_OutAr_dig[j]);
        ForMasOutAr_dig(Nar,N_ADT,Umax,M_OutAr_anl,M_OutAr_dig);
       { Формирование массива Npd цифровых сигналов
         с  выходов программно-реализованных подрешеток }
        ForMasOutDigPdr(Nep,Npd, MaxDNP,M_OutAr_dig,MasVyxSigP);
        for j:=1 to Nar do  Dispose(M_OutAr_dig[j]);
     end
     else begin
       ForMasOutAnlPdr(Nep,Npd, MaxDNP,M_OutAr_Anl,MasVyxSigP);
     end;

     TextColor(Yellow);
     writeln('Файл данных сформирован ');
     Normvideo;

     FormKMKS(MasVyxSigP,Fnn^);
     goto Mt31;

  end;

  TextColor(Yellow);
  writeln('Файл данных сформирован ');
  Normvideo;

Mt31:
  writeln('Определите цель дальнейшей обработки:');
  write('1-оценка времени вычисления; 2-демонстрация алгоритмов ');
  Readln(Shema);
  if Shema=1 then begin
     St:=M;
     Vtext:='';
Mt33:
   write('Размерность подпространства St=',St,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,St,i);
       if (i<>0) or ((St<=0) and (St>=N)) then begin
          writeln('Ошибка при вводе! Повторите');
          goto Mt33;
       end;
   end;

     GetTime(Hour,Min,Sec,Sec100);
     writeln('Время начала работы программы ',
              Hour:2,'ч.',Min:2,'мин.',Sec,',',Sec100,'сек.');
     goto Met_savz;
  end;


  for j:=1 to N do  Vsz[j]:=Fnn^[j,j];
  SKoorV(Vsz,N,Pmc[1]);
  a:=absc(Pmc[1])/(Nar*Nep);   b:=0.5*a;

{  writeln('Оценка суммарной мощности действит. сигналов  Pm ',b:5:3,' Вт');
  writeln('Оценка суммарной мощности аналит. сигналов  2*Pm ',a:5:3,' Вт');
  readln; }

{  TextBackGround(Blue);}
  TextColor(Yellow );
  write('Вычислять спектры Фурье канальных сигналов ? (Нет) ');
  NormVideo;
  Vtext:='';
  readln(Vtext);
  if Vtext <> '' then begin
     OBSmin:=0;  OBSmax:=Fd_r;
     Spct_Fur_KS(Npd,MasVyxSigP,NameFD,Tnab);
  end;
{ Вычисление спектров Фурье канальных сигналов}

MTKNAC_F:
{  TextBackGround(Blue);}
   TextColor(Yellow);
   writeln('Оценивание пеленгов сигналов');
   goto Mt21;
   TextColor(White);
   writeln('Введите способ обработки');
   NormVideo;
   write('(1-временной; 2-частотный; 3-выход)  ');
   readln(i);
   if i<>1 then i:=1;
   CASE i OF
      1 :  goto MT21;
      2 : begin
            NEW(FnnKf);
            FormKMKS_Fur(MasVyxSigP,F_dpf^);
            writeln('Сетка частот для ПЧ-обработки');
            for j:=1 to (Kf+1) do write(F_dpf^[j]:2:2,'  ');
            writeln;
            write('Введите номер частоты i=');
            readln(i);
            writeln('Вычисляется пространственный спектр на частоте ',F_dpf^[i]:2:2);
            for k:=1 to N do  for j:=1 to N do
                Fnn^[k,j]:=FnnKf^[k,j,i];
            DISPOSE(FnnKf);
          end;
      3 : goto MTKEND;
   END;
Mt21:

{  ModZG_RLS(qn,qv,qt,Lpoint,Nep,Npd,qqq1^,Enm^,Fnn^);}

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('Вычислять отклик на выходе АР ? (Да) ');
  NormVideo;
  Vtext:='';
  readln(Vtext);
  if Vtext = '' then
     PrMatDemoStatPel(NSourc,Lpoint,Nstat, qqq1^, Tn,Enm^, Fnn^, Pmc,EAsm);

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('Вычислять оценки Кейпона ? (Да) ');
  NormVideo;
  Vtext:='';
  readln(Vtext);
  if Vtext = '' then
         CaponDemoStatPel(NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Fnn^,Pmc,EAsm,2);

  If M=2 then begin
{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('Вычислять оценки МП ? (Нет)');
  NormVideo;
   Vtext:='';
    readln(Vtext);
     if Vtext <> '' then begin
        qn:=qqq1^[1]; qv:=qqq1^[Lpoint];
        qt:=(qv-qn)/(Lpnt-1);
        for i:=1 to Lpnt do qqq1^[i]:=qn+(i-1)*qt;
        MaxLiklDemoStatPel(NSourc,Lpnt,Nstat, qqq1^, Tn,Enm^, Fnn^, Pmc);
        qn:=qqq1^[1]; qv:=qqq1^[Lpnt];
        qt:=(qv-qn)/(Lpoint-1);
        for i:=1 to Lpoint do qqq1^[i]:=qn+(i-1)*qt;
     end;
  end;

{ Формирование КМ канальных сигналов для нелинейного пространств. фильтра }
MET_SAVZ:

  if Shema=1 then begin
{     St:=8;               }
     If St>=N Then St:=N-1;
     i:=Hour; j:=Min; k:=Sec; l:=Sec100;
     savzStat(Fnn^,N,St,eps,Msv^,Vsz);
     MUSICstatPel(st,NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Msv^,Fnn^,
              Vsz, Pmc, EAsm, 1);
{     MUSICdemoPel(st,Lpoint,Msv^, Vsz, qqq1^, Tn,Enm^);}
     writeln('Время окончания работы программы ',
              Hour:2,'ч.',Min:2,'мин.',Sec,',',Sec100,'сек.');
     DeltaTime(i,j,k,l, Hour,Min,Sec,Sec100);
     goto Mtkend;
  end;

(*
  SKoorV(Vsz,N,Pmc[1]);
  c:=a*Nar*Nep;  { Spur выборочной сигнальной КМ }
  b:=(absc(Pmc[1])-c) / (Nar*Nep);
  writeln('Оценка дисперсии компл. шума ',b:5:3);
  b:=a/b;
{  writeln('Оценка ОСШ по мощности ',b:5:3); }
  b:=Ln(b*Nar*Kv + 1e-6) * Ln10R;
  writeln('Cуммарное ОСШ ',ENdb:5:3, ' дБ');
  writeln('Оценка суммарного ОСШ ',b:5:3, ' дБ');
  *)

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('Вычислять оценки по алгоритму MUSIC ? (Да) ');
  readln(Vtext);
  NormVideo;
  if Vtext = '' then
  begin;
     savzStat(Fnn^,N,N,eps,Msv^,Vsz);
     Vtext:='Собственные числа КМ';
     VyvSZn(Vsz,N,a,Vtext);
     write('Введите Enter');
     readln;
     ClrScr;
Mt22:
   St:=M;
   Vtext:='';
Mt22a:
   write('Размерность сигнального подпространства [1...',N-1,'] St=',St,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,St,i);
       if (i<>0) or ((St<=0) and (St>=N)) then begin
          writeln('Ошибка при вводе! Повторите');
          goto Mt22a;
       end;
   end;

     MUSICstatPel(st,NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Msv^,Fnn^,
              Vsz, Pmc, EAsm, 2);
{     MUSICdemoPel(st,Lpoint,Msv^, Vsz, qqq1^, Tn,Enm^);}
     Vtext:='';
     write('Повторить ? (Да) ');
     readln(Vtext);
     if Vtext = '' then  goto Mt22;
  end;

    (*********************************************************)
     {********            Алгоритм M-MUSIC          ********}

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('Вычислять оценки по алгоритму M-MUSIC ? (Да) ');
  readln(Vtext);
  NormVideo;
  if Vtext = '' then
  begin;
     Vtext:= '';
     write('Вычислять собственные векторы ? (Нет) ');
     readln(Vtext);
     if Vtext <> '' then begin
       savzStat(Fnn^,N,N,eps,Msv^,Vsz);
       Vtext:='Собственные числа КМs + KMn';
       VyvSZn(Vsz,N,a,Vtext);
       readln;
       ClrScr;
     end;
Mt24:
   St:=M;
   Vtext:='';
Mt24a:
   write('Размерность сигнального подпространства [1...',N-1,'] St=',St,' -> ');
   readln(Vtext);
   If Vtext='e' then halt;
   if Vtext <> '' then  begin
       Val(Vtext,St,i);
       if (i<>0) or ((St<=0) and (St>=N)) then begin
          writeln('Ошибка при вводе! Повторите');
          goto Mt24a;
       end;
   end;

{     MUSICstatPel(st,NSourc,Lpoint,Nstat,qqq1^,Tn,Enm^,Msv^,Fnn^,
              Vsz, Pmc, EAsm, 1);}
     PELENGdemoPel(st,Lpoint,Nstat,Fnn^,Msv^, Vsz, qqq1^, Tn,Enm^,EAsm);
     Vtext:='';
     write('Повторить ? (Да) ');
     readln(Vtext);
     if Vtext = '' then  goto Mt24;
  end;

     (*********************************************************)
     {********            Алгоритм PISARENKO           ********}

{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('Вычислять оценки по алгоритму Писаренко ? (Да) ');
  NormVideo;
  readln(Vtext);
  if Vtext = '' then begin

MTPis:
    PISARENKOdemoPel(Lpoint,Fnn^,Msv^, Vsz, qqq1^, Tn,Enm^, qn,qv,qt);

     Vtext:='';
     write('Повторить ? (Нет) ');
     readln(Vtext);
     if Vtext <> '' then  goto MtPIS;

  end;

  goto MTKEND;
     (*********************************************************)
     {********            Алгоритм Gr-Shm              ********}
{  TextBackGround(Blue);}
  TextColor(Yellow);
  write('Вычислять оценки по алгоритму ортогонализации КМ ? (Да) ');
  readln(Vtext);
  NormVideo;
  if Vtext = '' then
  begin;
    GRAMP(Fnn^,N,N,Msv^,Vszs);
MTG_Sh:
     write('Введите размерность сигнального подпространства St=');
     readln(St);
     If St>=N then St:=N-1;
     GRAM_SHMdemoPel(N,St,Lpoint,Fnn^,Msv^,  qqq1^, Tn, Enm^,EAsm);
     Vtext:='';
     write('Повторить ? (Да) ');
     readln(Vtext);
     if Vtext = '' then  goto MtG_Sh;
  end;

MTKEND:
  PovtorP:=PovtorP+1;
  write('Повторить программу ? (1 - Начало, 3 - Выход) ');
  readln(Vtext);
  if Vtext='2' then goto MTKNAC_F;
  if TypeCM=0 then
  begin
     for j:=1 to Nar do  Dispose(M_OutAr_anl[j]);
     for i:=1 to Npd do  Dispose(MasVyxSigP[i]);
  end;
  if Vtext='1' then goto MTKNAC;

  Dispose(Enm);
  Dispose(F_dpf);
  Dispose(qqq1);
  Dispose(Msv);{ Dispose(Ann); Dispose(Bnn); } Dispose(Fnn);
  Dispose(VecAFV_AR);
  Dispose(RandV);

  CloseGraph;
end.
