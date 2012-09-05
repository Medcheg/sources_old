unit IDatProc;


             INTERFACE
USES IMATH,IUSINT,DOS;

procedure MaxLiklDemoStatPel(NSourc,L,Nstat:integer; qqq1:xxx1; Tn,Enm:Xn;
                       Ann: matrix; var Vec : vector);
procedure PrMatDemoStatPel(NSourc,L,Nstat:integer; qqq1:xxx1; Tn,Enm:Xn;
                   Ann: matrix; var Vec : vector; var EAsm: Double);
procedure MUSICstatPel(st,NSourc,L,Nstat:integer; qqq1:xxx1; Tn,Enm:Xn;
                      Msv,Fnn: matrix;
              Vsz: vector; var Vec: vector; var EAsm: Double; TypA:byte);
procedure PELENGdemoPel(st,L,NStat:integer; Fnn,Msv: matrix; Vsz: vector;
                       qqq1:xxx1; Tn,Enm:Xn; var EAsm: Double);
procedure CaponDemoStatPel(NSourc,L,Nstat:integer; qqq1:xxx1; Tn,Enm:Xn;
          Ann: matrix; var Vec : vector; var EAsm: Double; TypA:byte);
procedure PISARENKOdemoPel(L:integer; Fnn,Msv: matrix; Vsz: vector;
                       qqq1:xxx1; Tn,Enm:Xn; qn,qv,qt:Double);
procedure GRAM_SHMdemoPel(N,St,L:integer; Fnn,Msv: matrix;
                       qqq1:xxx1; Tn,Enm:Xn; var EAsm: Double);
procedure Est_PowerF1(Fnn:matrix; N,M,TypDan:integer; Tn,Fm: Xn;
          var Pm:Xn);

procedure Spct_Fur( Lot:integer; TypV,Nkd: word; NameFD:string; tn0:Double);
procedure Spct_Fur_KS(Npd: integer; MasVyxSigP: MasSigPtr;
                      NameFD:string; Tnab: Double);


procedure CountTheorRMSE(Sf,dlr:Double; NSourc:byte; var RmseTh:Double);
procedure CountCRB(Pm,Qm, dl:Double; Kv: integer; var VarTh:Double);

procedure DeltaTime(var Hour1,Min1,Sec1,Sec1001: integer;
                    Hour2,Min2,Sec2,Sec1002: Word);



                 IMPLEMENTATION


uses Crt,Graph,Printer;

procedure minimum3(Aaa1,qqq1:Xxx1; St,kd:integer;
                   var qm1:vector; var ymin,amax:Double);  forward;
procedure ANALIZ_FUN(aaa1,qqq1:Xxx1; St,L:integer;
                   var qm1:vector; var MinFun,MaxFun,EAsm:Double);
                   forward;
procedure VyvSI_PrMatr(Nep,St:integer; EstP: double; Vsz : vector;Enm:Xn);
          forward;
procedure VyvSI_NPF1_1(Nep,St:integer; Vsz : vector;Enm:Xn); forward;
procedure VyvSI_SpcFur(var Pmc : vector; var St, Kv:integer;
                       var Nkd: word; var NameFD : string;
                       var tn0,Tnab,qn1,qv1,Psum,Psum1 :Double );
                       forward;


procedure MaxLiklDemoStatPel(NSourc,L,Nstat:integer; qqq1:xxx1; Tn,Enm:Xn;
                       Ann: matrix; var Vec : vector);
{ Реализация алгоритма ПМ при стат. испытаниях и демонстрациях }
var
  Hnm,Gnm   : ^matrix;
  Vsz1,Vsz2 : vector;
     i,j,i1 : integer;
  a,  fi, ymax : Double;
         cz : complex;
       aaa1 : Xxx1;
BEGIN
  New(Hnm);  New(Gnm);
  ymax:=0;
  for i:=1 to L do for j:=i to L do begin
      VDN2(qqq1[i],Tn,N,Vsz1);
      VDN2(qqq1[j],Tn,N,Vsz2);
      for i1:=1 to N do begin
          Hnm^[i1,1]:=Vsz1[i1];
          Hnm^[i1,2]:=Vsz2[i1];
      end;
      if i=j then i1:=1
      else i1:=2;
      gramp (Hnm^,N,i1, Gnm^, Vsz1);
      upm_csm(Gnm^,Gnm^,N,i1,N,Hnm^);
      fi:=SpurAB(Hnm^,Ann,N)/N;
      if Fi>ymax then begin
         Vec[1].re:=qqq1[i];
         Vec[2].re:=qqq1[j];
         Vec[1].im:=Fi; Vec[2].im:=Fi;
         ymax:=Fi;
      end;
  end;
  Dispose(Hnm);  Dispose(Gnm);
  If Nstat<10 then begin
     ClrScr;

     TextColor(White );
     writeln('   Алгоритм максимального правдоподобия: ');
     TextColor(Yellow );
     writeln('Угловые координаты (пеленги) источников и их оценки МП:');
     NormVideo;
     for j:=1 to 2 do begin
       TextColor(Yellow );
       write('  Пеленг[',j,']=');
       TextColor(White );
       write(Qm[j]:5:3);
       TextColor(Yellow );
       write('    Оценка[',j,']=');
       TextColor(White );
       writeln(Vec[j].re:5:3);
     end;
     TextColor(Yellow );
     write('Сектор обзора: ');
     TextColor(White );
     writeln(qqq1[1]:4:2,'    ',qqq1[L]:4:2);
     TextColor(Yellow );
     write('Максимум целевой функции ');
     TextColor(White );
     write(ymax:12,'  ');
     Readln;
  end;

END;


procedure PrMatDemoStatPel(NSourc,L,Nstat:integer; qqq1:xxx1; Tn,Enm:Xn;
                   Ann: matrix; var Vec : vector; var EAsm: Double);
{ Реализация алгоритма ПМ при стат. испытаниях и демонстрациях }
var
        Vsz : vector;
          i : integer;
a,b,ymax,ymin,EstP : Double;
         cz : complex;
       aaa1 : Xxx1;
BEGIN
  ymax:=0;
  for i:=1 to L do begin
      VDN2(qqq1[i],Tn,N,Vsz);
      UMV(Ann,Vsz,N,Vec);
      SUV(Vsz,Vec,N,cz);
      a:=Normcv(cz)/N;
      a:=Ln10R*ln(a);
      aaa1[i]:=a;
{      If a>ymax then ymax:=a;}
  end;
  for i:=1 to L do aaa1[i]:=-aaa1[i];
  ANALIZ_FUN(aaa1,qqq1,NSourc,L,Vec,ymax,a,EAsm);
{  minimum3(aaa1,qqq1,NSourc,l,Vec,a);  }

  If Nstat<=7 then begin
    ymin:=-a;
    ymax:=-ymax;
    EstP:=-a; { Оценка мощности шума, дБ}
    b:=AstX(10,0.1*a); { Оценка мощности шума P02, разы}
    for i:=1 to NSourc do begin
      a:=-Vec[i].im;
      Vec[i].im:=(AstX(10,0.1*a)-b)/N;
      Vec[i].im:=Ln10R*Ln(abs(Vec[i].im));
    end;
    for i:=1 to L do begin
        aaa1[i]:=-aaa1[i];
{       aaa1[i]:=Ln10R*Ln(abs(aaa1[i]));}
    end;
    Vtext:='Алгоритм прямой матрицы  (отклик на выходе неадаптир. решетки)';
    PodpOX:=' q,град';  PodpOY1:='P(q),';  PodpOY2:='дБ';

    RisGraf1(aaa1,qqq1,ymin,ymax, L,5,4,
             Vtext,PodpOX,PodpOY1,PodpOY2);
    VyvSI_PrMatr(N,NSourc,EstP,Vec,Enm);
    Readln;
    RestoreCrtMode;
  end;

END;

procedure MUSICstatPel(st,NSourc,L,Nstat:integer; qqq1:xxx1; Tn,Enm:Xn;
                      Msv,Fnn: matrix;
              Vsz: vector; var Vec: vector; var EAsm: Double; TypA:byte);
{ Реализация алгоритма MUSIC при стат. испытаниях }
var
      i,j,k : integer;
        a,b : Double;
  ymin,ymax : Double;
  pmin,pmax : Double;
Vtext,Vtext1 : string;
      cz,ca : complex;
     aaa1,bbb1 : Xxx1;
      EstPm : Xn;
BEGIN
  ymin:=0;
  for i:=1 to L do begin
      b:=0.0;
      VDN2(qqq1[i],Tn,N,Vec);
      for j:=1 to st do begin
        ca.re:=0.0;  ca.im:=0.0;
        for k:=1 to N do begin   { скалярное произведение }
           umcsp(Msv[k,j],Vec[k],cz);
           scv(ca,cz,ca);
        end;
        b:=b + Norm2cv(ca)/N;
      end;
{      a:=abs(1-b)+1.e-12;}
      a:=1-b;  if a<=0 then a:=1.e-12;
      a:=Ln10R*ln(a);
      aaa1[i]:=a;
  {    if a<ymin then ymin:=a;}
  end;
  Case TypA of
  1:  begin
        ANALIZ_FUN(aaa1,qqq1,St,L,Vec,ymin,a,EAsm);
        pmin:=0; pmax:=0;
        for i:=2 to L do begin
           bbb1[i-1]:=aaa1[i]-aaa1[i-1];
           if bbb1[i-1]<pmin then pmin:=bbb1[i-1];
           if bbb1[i-1]>pmax then pmax:=bbb1[i-1];
        end;
        if abs(pmax)>=abs(pmin) then a:=abs(pmax)/abs(pmin)
        else a:=abs(pmin)/abs(pmax);
        Vec[1].im:=a;
{        Vec[1].im:=abs(pmin)/abs(pmax);}
      end;
  2:  minimum3(aaa1,qqq1,St,l,Vec,ymin,a);
  end;
  IF Nstat<=7 then begin
    GetTime(Hour,Min,Sec,Sec100);
{    Est_PowerF1(Fnn, N,St,2,Tn,Fm, EstPm);
    for j:=1 to St do Vec[j].im:=Ln10R*Ln(EstPm[j]); { оценки мощностей }
    str(st,Vtext1);
    ymax:=0;
    Vtext:='Нулевая частотная характеристика (НЧХ) (st=' + Vtext1 + ')';
    PodpOX:=' q,град';  PodpOY1:='НЧХ(q),';  PodpOY2:='дБ';

    RisGraf1(aaa1,qqq1, ymin,ymax, L,5,4,
             Vtext,PodpOX,PodpOY1,PodpOY2);
    VyvSI_NPF1_1(N,St,Vec,Enm);
    Readln;

{    pmin:=0;  pmax:=0;
    for i:=2 to L do begin
      bbb1[i-1]:=aaa1[i]-aaa1[i-1];
      if bbb1[i-1]<pmin then pmin:=bbb1[i-1];
      if bbb1[i-1]>pmax then pmax:=bbb1[i-1];
    end;
    a:=abs(pmin)/abs(pmax);
{    if abs(ymax)>=abs(ymin) then a:=abs(ymax)/abs(ymin)
    else a:=abs(ymin)/abs(ymax);
    Vec[1].im:=a;}
    Vtext:='Производная НЧХ (st=' + Vtext1 + ')';
    RisGraf1(bbb1,qqq1, -2.5,2.5, L-1,5,4,
             Vtext,PodpOX,PodpOY1,PodpOY2);
    VyvSI_NPF1_1(N,St,Vec,Enm);
    Readln;


    RestoreCrtMode;
  end;

END;

procedure PELENGdemoPel(st,L,Nstat:integer; Fnn,Msv: matrix; Vsz: vector;
                       qqq1:xxx1; Tn,Enm:Xn; var EAsm: Double);
{ Реализация алгоритма ПЕЛЕНГ-У при демонстрациях }
var
      i,j,k : integer;
        a,b : Double;
  ymin,ymax : Double;
      cz,ca : complex;
        Vec : vector;
  aaa1,bbb1 : Xxx1;
    Fm, EstPm  : Xn;
Vtext,Vtext1 : string;
BEGIN
  ymin:=0;
  for i:=1 to L do begin
      b:=0.0;
      VDN2(qqq1[i],Tn,N,Vec);
      for j:=1 to st do begin
        ca.re:=0.0;  ca.im:=0.0;
        for k:=1 to N do begin   { скалярное произведение }
           umcsp(Msv[k,j],Vec[k],cz);
           scv(ca,cz,ca);
        end;
        b:=b + Norm2cv(ca)/N;
      end;
{      a:=abs(1-b)+1.e-12;}
      a:=1-b;  if a<=0 then a:=1.e-12;
      a:=Ln10R*ln(a);
      aaa1[i]:=a;
      If aaa1[i]<ymin then ymin:=aaa1[i];
  end;

  ANALIZ_FUN(aaa1,qqq1,st,L,Vec,ymin,ymax,EAsm);

  for j:=1 to St do Fm[j]:=Vec[j].re;  {оценки пеленгов}
  Est_PowerF1(Fnn, N,St,2,Tn,Fm, EstPm);
{  Est_PowerF(Vsz,Msv, N,St,2,Tn,Fm, Pm);}
  for j:=1 to St do Vec[j].im:=Ln10R*Ln(EstPm[j]); { оценки мощностей }

{  If Nstat<10 then begin}
     ClrScr;

     TextColor(White );
     writeln('   Алгоритм M-MUSIC: ');
     TextColor(Yellow );
     writeln('Угловые координаты (пеленги) источников и их оценки:');
     NormVideo;
     for j:=1 to St do begin
       TextColor(Yellow );
       write('  Пеленг[',j,']=');
       TextColor(White );
       write(Qm[j]:5:3);
       TextColor(Yellow );
       write('    Оценка пеленга[',j,']=');
       TextColor(White );
       write(Vec[j].re:5:3);
       TextColor(Yellow );
       write('    мощности[',j,']=');
       TextColor(White );
       writeln(Vec[j].im:5:3);
     end;
     TextColor(Yellow );
     write('Сектор обзора: ');
     TextColor(White );
     writeln(qqq1[1]:4:2,'    ',qqq1[L]:4:2);
     Readln;
{  end;}
    str(st,Vtext1);
    Vtext:='Алгоритм ПЕЛЕНГ-У (st=' + Vtext1 + ')';
       RisGraf1(aaa1,qqq1, ymin,ymax, L,5,4,
                Vtext,PodpOX,PodpOY1,PodpOY2);
       VyvSI_NPF1_1(N,St,Vec,Enm);
       Readln;



    RestoreCrtMode;

END;

procedure Est_PowerF1(Fnn:matrix; N,M,TypDan:integer; Tn,Fm: Xn;
          var Pm:Xn);
{ Подпрограмма вычисления оценок мощностей принимаемых сигналов, }
{ основанная на преобразовании сигнальной КМ  Pmm=(Vnm-) * Fnn * (Vnm-)+}
{ Vsz, Msv - матрицы сигнальных с.чисел и с. векторов }
{ Fm - вектор частот (пеленгов) сигналов; Tn - вектор конфигурации МЛЗ (АР)}
{ Pm - вектор оценок мощностей сигналов }
{ TypDan - тип данных: 1 - отсчеты с выходов МЛЗ; 2 - с выходов АР }
{ !!! Используется выборочная корреляционная матрица  }
var
Vn,am,ym : vector;
Vnm, Gmm, Gmm_    : ^matrix;
a,b,a1,a2   : Double;
i,j  : byte;
begin
New(Vnm); New(Gmm); New(Gmm_);
{   sintezM1p(Vsz,Msv,N,M,Fnn^); { Синтез КМ по спектру собственных векторов }
   for j:=1 to M do begin
        Case TypDan of
         1: VDNFmN(Fm[j],Tn,Vn);
         2: VDN2(Fm[j], Tn, N, Vn);
        end;
        ZvectorM(Vn,N,j,Vnm^);
   end;  { Форирование оценки частотной матрицы }
   ucsm_pm(Vnm^,Vnm^, N,M,M, Gmm^);  {Матрица Грама Vmn+*Vnm}
   movz(Gmm^,M,Gmm_^);
   upm_csm(Gmm_^,Vnm^,M,M,N,Vnm^); { Псевдообратная матрица }
   upm(Vnm^,Fnn,M,N,N,Fnn);
   upm_csm(Fnn,Vnm^,N,N,M,Gmm^); { матрица мощностей }
   for i:=1 to M do Pm[i]:=Gmm^[i,i].re;

Dispose(Vnm); Dispose(Gmm); Dispose(Gmm_);

end;

procedure VyvSI_NPF1_1(Nep,St:integer; Vsz : vector;Enm:Xn);

{ Вывод служебной информации }
var
  Vtext      :string;
  i,j        : shortint;
      a      : Double;
      Ys,Xgr : integer;
BEGIN
  Xgr:=X1-3*sx;
  OuttextXY(Xgr+20*sx,Y2+2*sy,'Исходные данные модели');
  str(Nep,Vtext);
  OuttextXY(Xgr,Y2+3*sy,'Число пр.каналов N='+ Vtext);
  str(M,Vtext);
  OuttextXY(Xgr+38*sx,Y2+3*sy,'Число сигналов M='+ Vtext);
  OuttextXY(Xgr+3*sx,Y2+4*sy,'Параметры сигналов:');
  OuttextXY(Xgr+38*sx,Y2+4*sy,'Матрица апертурной корреляции');
  OuttextXY(Xgr+46*sx,Y2+5*sy,' сигналов:');
  OuttextXY(Xgr,Y2+5*sy,'Пеленг   Pm/S,дБ   E/N,дБ   тип  ');
  for i:=1 to M do begin
      str(Qm[i]:4:2,Vtext);
      OuttextXY(Xgr,Y2+(5+i)*sy,Vtext);
      a:=10*Ln(Pm[i])/Ln(10);
{      a:=Pm[i];}
      str(a:6:2,Vtext);
      OuttextXY(Xgr+7*sx,Y2+(5+i)*sy,Vtext);
      str(Enm[i]:6:2,Vtext);
      OuttextXY(Xgr+15*sx,Y2+(5+i)*sy,Vtext);
      CASE TypSig[i] OF
        1,2 : OuttextXY(Xgr+25*sx,Y2+(5+i)*sy,'ЛЧМ');
          3 : OuttextXY(Xgr+25*sx,Y2+(5+i)*sy,'шум');
          4 : OuttextXY(Xgr+25*sx,Y2+(5+i)*sy,'sin');
      END;
      for j:=1 to M do begin
          str(Bmm[i,j]:4:2,Vtext);
          OuttextXY(Xgr+(30+7*j)*sx,Y2+(5+i)*sy,Vtext);
      end;
  end;
  ys:=Y2+(6+M)*Sy;
{  If St>0 then  OuttextXY(Xgr+8*sx,ys,'НЧХ,дБ');}
  If St>0 then  OuttextXY(Xgr,ys,'Оценки пеленгов и значения НЧХ,дБ');
  for i:=1 to St do begin
      ys:=Ys+sy;
      str(Vsz[i].re:4:2,Vtext);
      OuttextXY(Xgr,Ys,Vtext);
      str(Vsz[i].im:6:2,Vtext);
      OuttextXY(Xgr+7*sx,Ys,Vtext);
  end;
END;

procedure CaponDemoStatPel(NSourc,L,Nstat:integer; qqq1:xxx1; Tn,Enm:Xn;
          Ann: matrix; var Vec : vector; var EAsm: Double; TypA:byte);
{ Реализация алгоритма ПМ при стат. испытаниях и демонстрациях }
var
    Bnn,Inn : ^matrix;
        Vsz : vector;
          i : integer;
a,ymax,ymin,EstP : Double;
         cz : complex;
       aaa1 : ^Xxx1;
BEGIN
  New(Bnn); New(aaa1);
  MOVZ(Ann,N,Bnn^);
  If Nstat<10 then begin
     New(Inn);
     ukm(Bnn^,Ann,N, INN^);
     epsEM(INN^,N, a);
     writeln('Точность обращения КМ  eps= ',a:9);
     write('Введите Enter');
     Readln;
     Dispose(Inn);
  end;
  ymin:=0;
  for i:=1 to L do begin
      VDN2(qqq1[i],Tn,N,Vsz);
      UMV(Bnn^,Vsz,N,Vec);
      SUV(Vsz,Vec,N,cz);
      a:=Normcv(cz)/N;
      aaa1^[i]:=Ln10R*ln(a+1e-12);
      If aaa1^[i]<ymin then ymin:=aaa1^[i];
  end;
  Dispose(Bnn);
  Case TypA of
  1:  ANALIZ_FUN(aaa1^,qqq1,NSourc,L,Vec,EstP,a,EAsm);
  2:  minimum3(aaa1^,qqq1,NSourc,L,Vec,ymin,a);
  end;

{  minimum3(aaa1,qqq1,NSourc,l,Vec,a);}


  If Nstat<10 then begin
    EstP:=-a;
    ymax:=a;
{    ymin:=Vec[1].im;}
    for i:=1 to NSourc do begin
{      Vec[i].im:=AstX(10,Vec[i].im);}
      Vec[i].im:=-Vec[i].im-Ln10r*Ln(N);
    end;

    Vtext:='Алгоритм обратной матрицы  ';
    PodpOX:=' q,град';  PodpOY1:='P(q),';  PodpOY2:='дБ';

    RisGraf1(aaa1^,qqq1,ymin,ymax, L,5,4,
             Vtext,PodpOX,PodpOY1,PodpOY2);
    VyvSI_PrMatr(N,NSourc,EstP,Vec,Enm);
    Readln;
    RestoreCrtMode;
  end;
  Dispose(aaa1);

END;

procedure PISARENKOdemoPel(L:integer; Fnn,Msv: matrix; Vsz: vector;
                       qqq1:xxx1; Tn,Enm:Xn; qn,qv,qt:Double);
{ Реализация алгоритма MUSIC при демонстрациях }
var
     i,j,St : integer;
          a : Double;
  ymin,ymax : Double;
      cz,ca : complex;
        Vec : vector;
       aaa1 : Xxx1;
    Fm, Pm  : Xn;
Vtext,Vtext1 : string;
BEGIN
  ymin:=0;
  for i:=1 to L do begin
      VDN2(qqq1[i],Tn,N,Vec);
      ca.re:=0.0;  ca.im:=0.0;
      for j:=1 to N do begin   { скалярное произведение }
           umcsp(Msv[j,N],Vec[j],cz);
           scv(ca,cz,ca);
      end;
      a:=Norm2cv(ca)/N;
      a:=abs(a+1.e-12);
      aaa1[i]:=Ln10R*ln(a);
      If aaa1[i]<ymin then ymin:=aaa1[i];
  end;
  St:=N-1;
  minimum3(aaa1,qqq1,St,L,Vec,ymin,ymax);

  for j:=1 to St do Fm[j]:=Vec[j].re;
  Est_PowerF1(Fnn, N,St,2,Tn,Fm, Pm);
{  Est_PowerF(Vsz,Msv, N,St,2,Tn,Fm, Pm);}
  for j:=1 to St do Vec[j].im:=Ln10R*Ln(Pm[j]);

    Vtext:='Алгоритм PISARENKO ';
{    Vtext:='Нулевая частотная характеристика (НЧХ) (st=' + Vtext1 + ')';}
    PodpOX:=' q,град';  PodpOY1:='НЧХ(q),';  PodpOY2:='дБ';

    RisGraf1(aaa1,qqq1, ymin,ymax, L,5,4,
             Vtext,PodpOX,PodpOY1,PodpOY2);
    VyvSI_NPF1_1(N,St,Vec,Enm);
{    GetTime(Hour,Min,Sec,Sec100);}
    Readln;
    RestoreCrtMode;

END;

procedure GRAM_SHMdemoPel(N,St,L:integer; Fnn,Msv: matrix;
                       qqq1:xxx1; Tn,Enm:Xn; var EAsm: Double);
{ Реализация алгоритма Грама-Шмидта при демонстрациях }
var
{        Msv : ^matrix;}
      i,j,k : integer;
        a,b : Double;
  ymin,ymax : Double;
      cz,ca : complex;
        Vec : vector;
       aaa1 : Xxx1;
    Fm, Pm  : Xn;
Vtext,Vtext1 : string;
BEGIN
{New(Msv);
GRAMP(Fnn,N,St0,Msv^,Vec);}
{for st:=1 to St0 do begin}
  ymin:=0;
  for i:=1 to L do begin
      b:=0.0;
      VDN2(qqq1[i],Tn,N,Vec);
      for j:=1 to st do begin
        ca.re:=0.0;  ca.im:=0.0;
        for k:=1 to N do begin   { скалярное произведение }
           umcsp(Msv[k,j],Vec[k],cz);
           scv(ca,cz,ca);
        end;
        b:=b + Norm2cv(ca)/N;
      end;
{      a:=abs(1-b)+1.e-12;}
      a:=1-b;  if a<=0 then a:=1.e-24;
      a:=Ln10R*ln(a);
      aaa1[i]:=a;
    {  If aaa1[i]<ymin then ymin:=aaa1[i];}
  end;
{  minimum3(aaa1,qqq1,st,l,Vec,ymax);}
  ANALIZ_FUN(aaa1,qqq1,st,L,Vec,ymin,ymax,EAsm);

  for j:=1 to St do Fm[j]:=Vec[j].re;
  Est_PowerF1(Fnn, N,St,2,Tn,Fm, Pm);
  for j:=1 to St do Vec[j].im:=Ln10R*Ln(Pm[j]);

    str(st,Vtext1);
    Vtext:='нулевая частотная характеристика (НЧХ) (st=' + Vtext1 + ')';
    Vtext:='Модифицированная '+Vtext;
    PodpOX:=' q,град';  PodpOY1:='НЧХ(q),';  PodpOY2:='дБ';

    RisGraf1(aaa1,qqq1, ymin,ymax, L,5,4,
             Vtext,PodpOX,PodpOY1,PodpOY2);
    VyvSI_NPF1_1(N,St,Vec,Enm);
    Readln;
    RestoreCRTMode;

{end;}
{Dispose(Msv);}

END;


procedure minimum3(Aaa1,qqq1:Xxx1; St,kd:integer;
                   var qm1:vector; var ymin, amax:Double);
{********   Процедура находит St минимумов  *************}
label mtk1;
type
  Tamin = array[1..201] of double;
  Timin = array[1..201] of integer;
var
i,j,i1,inn,j1,ip:integer;
amin : ^Tamin;
imin : ^Timin;
ap,aq   :Double;
begin
  New(amin);
  New(imin);
  Kmin:=0;  amax:=aaa1[1];
  for i:=2 to (kd-1) do begin
      if (aaa1[i] < aaa1[i-1]) and  (aaa1[i] <= aaa1[i+1]) then begin
         Kmin:=Kmin+1;
         if Kmin>201 then goto mtk1;
         amin^[Kmin]:=aaa1[i];  imin^[Kmin]:=i;
      end;
      if aaa1[i]>amax then amax:=aaa1[i];
  end;
  { Kmin - число всех минимумов }
  j:=Kmin;
{ ****** Упорядочивание (St<=j) минимумов **************}
mtk1:
if Kmin=0 then begin
   Kmin:=1;  imin^[1]:=1;  amin^[1]:=0;
end;
if Kmin>St then inn:=St  else  inn:=Kmin-1;
qm1[St+1].im:=Kmin;
   { qm1[St+1].im - число найденных минимумов }

  { Сортировка по возрастанию минимумов }
  for i1:=1 to inn do begin
    for j1:= (i1+1) to Kmin do
    if amin^[i1]>=amin^[j1] then  begin
      ap:=amin^[i1];  ip:=imin^[i1];
      amin^[i1]:=amin^[j1]; imin^[i1]:=imin^[j1];
      amin^[j1]:=ap; imin^[j1]:=ip;
    end;
  end;
  ymin:=amin^[1];

  { Сортировка по возрастанию пеленга }
  if Kmin>=St then inn:=St  else  inn:=Kmin;
  for i:=1 to inn do begin
      qm1[i].re:=qqq1[ imin^[i] ];
      qm1[i].im:=amin^[i];
  end;
  for i1:=1 to (inn-1) do begin
    for j1:= (i1+1) to inn do
    if qm1[i1].re >= qm1[j1].re then  begin
      ap:=qm1[i1].re;  aq:=qm1[i1].im;
      qm1[i1]:=qm1[j1];
      qm1[j1].re:=ap; qm1[j1].im:=aq;
    end;
  end;
{
  if Kmin < St then begin
     for i:=Kmin+1 to St do qm1[i]:=qm1[Kmin];
  end;
 }
{ for i:=1 to St do begin
     if i<=j then begin
        qm1[i].re:=qqq1[ imin^[i] ];
        qm1[i].im:=amin^[i];
     end
     else begin
        qm1[i].re:=qm1[j].re;
        qm1[i].im:=qm1[j].im;
     end;
  end;}
  Dispose(amin);
  Dispose(imin);
end;

procedure ANALIZ_FUN(aaa1,qqq1:Xxx1; St,L:integer;
                   var qm1:vector; var MinFun,MaxFun,EAsm:Double);
{********   Процедура находит абсциссы и ординаты
            St точек минимумов и перегибов функции AAA1 }
label mtk1,mtk2;
type
  Tamin = array[1..201] of double;
  Timin = array[0..201] of integer;
var
{i,i1,inn,j,Kmin,Kmax,Kper,Kglm:integer;}
i,i1,inn,j,Kmax,Kper :integer;
Amin,Amax,Aper,Aglm  : ^Tamin;
Imin,Imax,Iper,Iglm  : ^Timin;
     ap,zn0,zn,zn1   :Double;
begin
  New(amin);  New(amax);  New(aper);  New(aglm);
  New(imin);  New(imax);  New(iper);  New(iglm);
  Kmin:=0; Kmax:=0;  Kper:=0;  Kglm:=0; iglm^[Kglm]:=1;
  MaxFun:=aaa1[1];  MinFun:=aaa1[1];
  for i:=2 to (L-2) do begin
      zn0:=aaa1[i]-aaa1[i-1];
      zn:=aaa1[i+1]-aaa1[i];
      zn1:=aaa1[i+2]-aaa1[i+1];
      if aaa1[i]<MinFun then MinFun:=aaa1[i];
      if aaa1[i]>MaxFun then MaxFun:=aaa1[i];
      if zn0>=0 then begin
         { Поиск максимумов }
         if zn<0 then begin
             { Между (i) и (i+1) - максимум функции }
             Kmax:=Kmax+1;
             if Kmax>201 then goto mtk1;
             if abs(zn0)<abs(zn) then begin
                amax^[Kmax]:=aaa1[i-1];  imax^[Kmax]:=i-1
             end
             else begin
                amax^[Kmax]:=aaa1[i];  imax^[Kmax]:=i
             end;
             goto mtk2;
         end;
         { Поиск перегибов }
{         if (aaa1[i] <= aaa1[i-1]) and  (aaa1[i] <= aaa1[i+1]) then begin}
         if (zn < zn0) and  (zn <= zn1) and ((i-iglm^[Kglm])>5) then begin
             { (i) - точка перегиба }
                kglm:=Kglm+1;
                kper:=Kper+1;
                if Kper>201 then goto mtk1;
                if Kglm>201 then goto mtk1;
                aper^[kper]:=aaa1[i];  iper^[kper]:=i;
                aglm^[kglm]:=aaa1[i];  iglm^[kglm]:=i;
         end;
      end;
mtk1:
      if zn0<0 then begin
         { Поиск минимумов }
         if zn>=0 then begin
             { Между (i) и (i+1) - минимум функции }
             Kmin:=Kmin+1;
             kglm:=Kglm+1;
             if Kmin>201 then goto mtk2;
             if Kglm>201 then goto mtk2;
             if abs(zn0)<abs(zn) then begin
                amin^[Kmin]:=aaa1[i-1];  imin^[Kmin]:=i-1;
                aglm^[kglm]:=aaa1[i-1];  iglm^[kglm]:=i-1;
             end
             else begin
                amin^[Kmin]:=aaa1[i];  imin^[Kmin]:=i;
                aglm^[kglm]:=aaa1[i];  iglm^[kglm]:=i;
             end;
             goto mtk2;
         end;
         { Поиск перегибов }
{         if (aaa1[i] >= aaa1[i-1]) and  (aaa1[i] >= aaa1[i+1]) then begin}
         if (zn >= zn0) and  (zn > zn1) and ((i-iglm^[Kglm])>5) then begin
             { (i) - точка перегиба }
                kglm:=Kglm+1;
                kper:=Kper+1;
                if Kper>201 then goto mtk2;
                if Kglm>201 then goto mtk2;
                aper^[kper]:=aaa1[i];  iper^[kper]:=i;
                aglm^[kglm]:=aaa1[i];  iglm^[kglm]:=i;
         end;
      end;
mtk2:
  end;

{ Kmin - число всех минимумов }
{ Kmax - число всех максимумов }
{ Kper - число всех перегибов }
{ Kglm - число всех минимумов и перегибов }
{ ****** Нахождение St<=(Kmin+Kper) глобальных минимумов и перегибов ****}

Kasm:=Kglm;

if Kglm=0 then begin
   Kglm:=1;  iglm^[1]:=1;  aglm^[1]:=0;
end;
if Kglm>St then inn:=St  else  inn:=Kglm-1;
qm1[St+1].im:=Kglm;
   { qm1[m+1].im - число найденных минимумов и перегибов }
   { Поиск St главных минимумов и точек перегиба }
  for i1:=1 to inn do begin
    for j:= (i1+1) to Kglm do
    if aglm^[i1]>=aglm^[j] then  begin
      ap:=aglm^[i1];  i:=iglm^[i1];
      aglm^[i1]:=aglm^[j]; iglm^[i1]:=iglm^[j];
      aglm^[j]:=ap; iglm^[j]:=i;
    end;
  end;
  for i:=1 to St do begin
     if i<=Kglm then begin
        qm1[i].re:=qqq1[ iglm^[i] ];
        qm1[i].im:=aglm^[i];
     end
     else begin
        qm1[i].re:=qm1[Kglm].re;
        qm1[i].im:=qm1[Kglm].im;
     end;
  end;

  { Поиск асимметрии функции }
  if (Kglm=1) and (St>1) then  begin
     ap:=0.5*qm1[1].im;  {Координата и значение главного минимума }
     zn:=qm1[1].re;
     i:=iglm^[1];
     while (aaa1[i] < ap) and (i>1) do i:=i-1;
     zn0:=qqq1[i];
     i:=iglm^[1];
     while (aaa1[i] < ap) and (i<=(L-1)) do i:=i+1;
     zn1:=qqq1[i];
     EAsm:=(zn1-zn)/(zn-zn0);
     if ( EAsm > RAsm) or ( (1/EAsm) > RAsm) then begin
        Kasm:=2;
        qm1[2].re:=zn1+zn0-zn;
        qm1[2].im:=qm1[1].im;
     end;
  end;
  { Перестановка St оценок в порядке возрастания }
  for i:=1 to (St-1) do for j:=(i+1) to St do begin
     if qm1[j].re < qm1[i].re then begin
        zn0:=qm1[i].re;  zn1:=qm1[i].im;
        qm1[i].re:=qm1[j].re;  qm1[i].im:=qm1[j].im;
        qm1[j].re:=zn0;        qm1[j].im:=zn1;
     end;
  end;

  Dispose(amin);    Dispose(amax);  Dispose(aper);  Dispose(aglm);
  Dispose(imin);    Dispose(imax);  Dispose(iper);  Dispose(iglm);
end;

procedure VyvSI_PrMatr(Nep,St:integer; EstP: double; Vsz : vector;Enm:Xn);

{ Вывод служебной информации }
var
  Vtext      :string;
  i,j        : shortint;
      a      : Double;
      Ys,Xgr : integer;
BEGIN
  Xgr:=X1-3*sx;
  OuttextXY(Xgr+20*sx,Y2+2*sy,'Исходные данные модели');
  str(Nep,Vtext);
  OuttextXY(Xgr,Y2+3*sy,'Число пр.каналов N='+ Vtext);
  str(M,Vtext);
  OuttextXY(Xgr+20*sx,Y2+3*sy,'Число сигналов M='+ Vtext);
  if PriznADT=1 then a:=(P02*AstX(2,N_ADT-1)/Umax)
  else a:=P02;
  a:=2*Ln10R*Ln(a);
  str(a:3:1,Vtext);
  OuttextXY(Xgr+40*sx,Y2+3*sy,'Мощн. некорр.шума P02  '+ Vtext+' дБ');
  OuttextXY(Xgr+3*sx,Y2+4*sy,'Параметры сигналов:');
  OuttextXY(Xgr+38*sx,Y2+4*sy,'Матрица апертурной корреляции');
  OuttextXY(Xgr+46*sx,Y2+5*sy,' сигналов:');
  OuttextXY(Xgr,Y2+5*sy,'Пеленг   Pm/S,дБ   E/N,дБ   тип  ');
  for i:=1 to M do begin
      str(Qm[i]:4:2,Vtext);
      OuttextXY(Xgr,Y2+(5+i)*sy,Vtext);
{      a:=10*Ln(Pm[i])/Ln(10);}
      a:=Ln10R*Ln(Pm[i]/P02);
      str(a:6:2,Vtext);
      OuttextXY(Xgr+7*sx,Y2+(5+i)*sy,Vtext);
      str(Enm[i]:6:2,Vtext);
      OuttextXY(Xgr+15*sx,Y2+(5+i)*sy,Vtext);
      CASE TypSig[i] OF
        1,2 : OuttextXY(Xgr+25*sx,Y2+(5+i)*sy,'ЛЧМ');
          3 : OuttextXY(Xgr+25*sx,Y2+(5+i)*sy,'шум');
          4 : OuttextXY(Xgr+25*sx,Y2+(5+i)*sy,'sin');
      END;
      for j:=1 to M do begin
          str(Bmm[i,j]:4:2,Vtext);
          OuttextXY(Xgr+(30+7*j)*sx,Y2+(5+i)*sy,Vtext);
      end;
  end;
  ys:=Y2+(6+M)*Sy;
{  If St>0 then  OuttextXY(Xgr+8*sx,ys,'НЧХ,дБ');}
  str(EstP:4:2,Vtext);
  OuttextXY(Xgr,ys,'Оценка мощности некорр. шума P02,дБ '+Vtext);
  ys:=Ys+sy;
  If St>0 then  OuttextXY(Xgr,ys,'Оценки пеленгов, Pm/S,дБ  и  E/N,дБ  ');
  for i:=1 to St do begin
      ys:=Ys+sy;
      str(Vsz[i].re:4:2,Vtext);
      OuttextXY(Xgr,Ys,Vtext);
      a:=Vsz[i].im - EstP;
      str(a:6:2,Vtext);
      OuttextXY(Xgr+7*sx,Ys,Vtext);
      a:=a + ln10R*ln(Kv*N);
{      If Vsz[i].im>0 then
        a:=ln10R*ln(Vsz[i].im*Kv*N)
      else a:=0;}
      str(a:6:2,Vtext);
      OuttextXY(Xgr+15*sx,Ys,Vtext);
  end;
END;

procedure Spct_Fur_KS(Npd: integer; MasVyxSigP: MasSigPtr;
                      NameFD:string; Tnab: Double);
 { Вычисление спектра Фурье канальных сигналов }

label NACH;
var
                 i  : integer;
                Ip  : word;
             Vtext  : string;

BEGIN
   Writeln('Оценивание частотных параметров сигналов ');
   for i:=1 to 2 do New( Mas_Dan[i]);
NACH:
   Write('Введите номер подрешетки '); Readln(Ip);
   for i:=1 to Kv do begin
       Mas_Dan[1]^[i]:= round( MasVyxSigP[Ip]^[i].re * 1000);
       Mas_Dan[2]^[i]:= round( MasVyxSigP[Ip]^[i].im * 1000);
{       mas^[i]:= round( MasVyxSigP[Ip]^[i].re * 1000);
       masi^[i]:=round( MasVyxSigP[Ip]^[i].im * 1000); }
   end;
   Spct_Fur(Kv, 2, Ip, NameFD,0.0);

   Vtext:='';
   Write('Повторить ? (Enter - Да)');
   Readln(Vtext);
   If Vtext='' THEN   GOTO NACH;
   for i:=1 to 2 do Dispose( Mas_Dan[i]);

END;

procedure Spct_Fur( Lot:integer; TypV,Nkd: word; NameFD:string; tn0:Double);
 { Вычисление спектра Фурье последовательности данных.}

var
      q,qt,f0,f1,f  : Double;
       qn1,qv1,aLt  : Double;
           In1,Iv1  : integer;
    lny, ymin,ymax  : Double;
   Tnab,Psum,Psum1  : Double;
     Vtext, TypWin  : string;
          i,j,k,Lt  : integer;
        Kv, St, Kp  : integer;
       aaa1,  fff1  : Xxx1;
              Rect  : masr1;
           nox,noy  : shortint;
     Cs,Cz,Cp,Csum  : complex;
               Pmc  : vector;
BEGIN
Tnab:=Lot/Fd_r;
Vtext:='';
{Write('Длительность анализируемой выбоки ', Tnab:5:2, ' cek ? ');}
Write('Число отсчетов данных ', Lot, ' ? ');
Readln(Vtext);
If Vtext='' THEN   Lt:=Lot
ELSE  begin
{   Write('Введите длительность анализируемой выбоки '); Readln(Tnab);}
   Write('Введите число отсчетов данных '); Readln(Lt);
   If Lt>Lot then Lt:=Lot;
{   Lt:=round (Tnab*Fd_r);
   Writeln('Число отсчетов  данных', Lt:5);}
END;

Vtext:='';
{qn:=1.7;  qv:=2.7;}
{qn:=0;  qv:=5;}
Write('Полоса анализа ',OBSmin:3:1, '...', OBSmax:3:1, ' Гц ? ');
Readln(Vtext);
If Vtext<>'' THEN  begin
   Write('Введите нижнюю границу полосы анализа  (Гц)');
   Readln(OBSmin);
   Write('Введите верхнюю границу полосы анализа (Гц) ');
   Readln(OBSmax);
END;

Vtext:='';
qn1:=2.1;  qv1:=2.3;
{Write('Выделяемая полоса ',qn1:3:1, '...', qv1:3:1, ' Гц ? ');
Readln(Vtext);
If Vtext<>'' THEN  begin
   Write('Введите нижнюю границу полосы анализа  (в герцах)');
   Readln(qn1);
   Write('Введите верхнюю границу полосы анализа (в герцах)');
   Readln(qv1);
END;}

Kv:=330;
Vtext:='';
Write('Число точек обзора по частоте Kобз = ', Kv:4,' ? ');
Readln(Vtext);
If Vtext<>'' THEN  begin
   Write('Введите число точек обзора по частоте ( кратное 110 )');
   Readln(Kv);
   If Kv>400 then Kv:=400;
END;

{TypWin:='Хэмминга '; i:=1;}
TypWin:='прямоугольное '; i:=1;
Vtext:='';
Writeln('   Типы окон:');
Writeln('1- прямоуг.; 2-Хэмминга; 3 - Ханна; 4 - треугольное; 5 - гауссовское');
Write('Используемое окно -',TypWin,' ? ');
Readln(Vtext);
If Vtext<>'' THEN  begin
   Write('Введите тип окна ');
   Readln(i);
   Case i of
     2: TypWin:='Хэмминга';
     3: TypWin:='Ханна';
     4: TypWin:='треугольное';
     5: TypWin:='гауссовское';
     else TypWin:='прямоугольное'
   end;
END;
f:=pi2/Lt;
New(Rect);
Case i of
    2:   for k:=1 to Lt do Rect^[k]:=0.54 + 0.46*cos(f*k-pi);
    3:   for k:=1 to Lt do Rect^[k]:=0.5 + 0.5*cos(f*k-pi);
    4:   for k:=1 to Lt do Rect^[k]:=1-2*abs(k/Lt - 0.5);
    5:   for k:=1 to Lt do Rect^[k]:=exp(-0.5*sqr(5* (k/Lt - 0.5) ) );
    else for k:=1 to Lt do Rect^[k]:=1.0
end;

TextBackGround(Red);
TextColor(Yellow + Blink);
Write('Ждите! Вычисляется ДПФ ');
q:=OBSmin;
qt:=(OBSmax-OBSmin)/ Kv; { Шаг по частоте, Гц }
In1:=round( (qn1-OBSmin)/ qt); Iv1:=round( (qv1-OBSmin)/ qt);
ymin:=0;  ymax:=0;
f0:=pi2/Fd_r;
Psum:=0.0;   Psum1:=0.0;
aLt:=Lt;
Kp:=0;
for k:=1 to (Kv+1) do begin
    fff1[k]:=q; { Текущая частота, в Гц }
    Csum.re:=0.0; Csum.im:=0.0;
    f1:=f0*q;
    FOR j:=1 to Lt DO begin
        Cs.re:=Mas_Dan[1]^[j] * Rect^[j];
        Cs.im:=Mas_Dan[2]^[j] * Rect^[j];
        f:=f1*j;
        Cz.re:=cos(f);  Cz.im:=-sin(f);
        Ucv(Cs,Cz,Cp);
        Scv(Csum,Cp,Csum);
    END;
    DcvS(Csum,aLt,Csum);
    aaa1[k]:= absc(Csum) + 1e-6;
    if aaa1[k] > ymax then ymax:=aaa1[k];
    Psum:=Psum+aaa1[k];
    if (k >= In1) and (k < Iv1) then begin
       Psum1:=Psum1+aaa1[k];
       Kp:=Kp + 1;
    end;
    q:=q + qt;
end;
Dispose(Rect);
    Psum:=Psum1/Psum;
    Psum:=Psum*Psum;
    If Kp>0 then  Psum1:=2*ln(Psum1/Kp)*ln10R
    else Psum:=-60;
    St:=7;  { Число отыскиваемых максимумов в спектре }
    for i:=1 to (Kv+1) do aaa1[i]:=-aaa1[i];
    minimum3(aaa1,fff1,st,Kv+1,Pmc,ymin,q);
    for i:=1 to (Kv+1) do aaa1[i]:=-aaa1[i];
    for i:=1 to St do Pmc[i].im:=-Pmc[i].im;

    Vtext:='Спектр Фурье комплексных данных. Окно '+ TypWin;
    nox:=5;  noy:=5;
    PodpOX:='  f,Гц';  PodpOY1:='C(f)';  PodpOY2:='';

    RisGraf1(aaa1,fff1, ymin,ymax, Kv+1 ,nox,noy,
             Vtext,PodpOX,PodpOY1,PodpOY2);
    VyvSI_SpcFur(Pmc, St, Lt, Nkd, NameFD, tn0,Tnab,qn1,qv1,Psum,Psum1 );
    Readln;

    Vtext:='Спектральная плотность мощности данных. Окно '+ TypWin;
    lny:=TypV*ln(ymax)*ln10R;
    ymax:=0.0;{  ymin:=-60.0;} ymin:=-50.0;
    for i:=1 to (Kv+1) do begin
        aaa1[i]:=TypV*ln(abs(aaa1[i] + 1e-6))*ln10R - lny;
        if aaa1[i] < ymin then aaa1[i]:=ymin;
    end;

    for i:=1 to St do Pmc[i].im:=TypV*ln(Pmc[i].im)*ln10R - lny;
    PodpOY1:='G(f),дБ';
    RisGraf1(aaa1,fff1, ymin,ymax, Kv ,nox,noy,
             Vtext,PodpOX,PodpOY1,PodpOY2);
{    Readln;}

    VyvSI_SpcFur(Pmc, St, Lt, Nkd, NameFD, tn0, Tnab,qn1,qv1,Psum,Psum1);
    Readln;


    Vtext:='Спектральная плотность мощности данных. Окно '+ TypWin;
{    ymax:=Lny;  ymin:=ymin + lny;}
    ymax:=70;  ymin:=20;
    for i:=1 to Kv do begin
        aaa1[i]:=aaa1[i] + lny;
    end;
    for i:=1 to St do Pmc[i].im:=Pmc[i].im+lny;
    RisGraf1(aaa1,fff1, ymin,ymax, Kv ,nox,noy,
             Vtext,PodpOX,PodpOY1,PodpOY2);
    Readln;
{    VyvSI_SpcFur(Pmc, St, Lt, Nkd, NameFD, tn0,Tnab,qn1,qv1,Psum,Psum1  );
    Readln;}

    RestoreCRTMode;
    NormVideo;

end;



procedure CountTheorRMSE(Sf,dlr:Double; NSourc:byte; var RmseTh:Double);
{ Расчет теоретическо RMSE при наличии АФВ }
var
  i : shortint;
  a1,a2,a3,a4 : Double;
BEGIN
  a1:=0;
  for i:=1 to n do a1:=a1 + DnNPF[i];
  a1:=a1/N;
  a2:=0;
  for i:=1 to n do a2:=a2 + sqr(DnNPF[i]);
  a2:=a2/N;
  a3:=sqrt(a2-sqr(a1));
  RmseTh:=0.0;
  for i:=1 to NSourc do begin
     a4:=1.0/(pi2*sqrt(N)*a3*CosD(Qm[i]));
     RmseTh:=RmseTh + sqr(Sf*a4);
  end;
  RmseTh:=sqrt(RmseTh/NSourc);
END;


procedure CountCRB(Pm,Qm, dl:Double; Kv: integer; var VarTh:Double);
{ Расчет границ Крамера-Рао (дисперсий эффективной оценки) }
var
  i : shortint;
  a1,a2,a3,a4 : Double;
BEGIN
  a1:=0;
  for i:=1 to n do a1:=a1 + sqr(DnNPF[i]);
{  a2:=sqr(pi2*cosd(Qm)/dl);}
  a2:=sqr(pi2*cosd(Qm));
  A3:=4*Kv*Pm*(Pm+0.5)*a2*a1;
  VarTh:=sqrt(1/a3);

END;
procedure VyvSI_SpcFur(var Pmc : vector; var St, Kv:integer;
                       var Nkd: word; var NameFD : string;
                       var tn0,Tnab,qn1,qv1,Psum,Psum1 :Double );
  { Вывод служебной информации, после ДПФ }
var
  Vtext,Vt1,Vt2  : string;
      i,j        : shortint;
          a      : Double;

BEGIN
  SetColor(Blue);

  str(tn0:4:2,Vtext);
  OuttextXY(X1+38*sx,Y1+5*sy,'Т нач.набл. '+ Vtext+' сек');
  str(Tnab:4:2,Vtext);
  OuttextXY(X1+38*sx,Y1+6*sy,'Инт. набл.  '+ Vtext+' сек');

  OuttextXY(X1,Y2+3*sy,'Имя файла данных '+ NameFD + '.cpl');
  str(Nkd,Vtext);
  OuttextXY(X1+25*sx,Y2+3*sy,'Номер канала дальности '+ Vtext);

  str(Tnab:4:2,Vtext);
  OuttextXY(X1,Y2+4*sy,'Время наблюдения '+ Vtext + ' сек.');
  str(Fd_r,Vtext);
  OuttextXY(X1+25*sx,Y2+4*sy,'Частота дискретизации '+ Vtext+ ' Гц');

  a:=1/Tnab;
  str(a:5:3,Vtext);
  OuttextXY(X1,Y2+5*sy,'Разреш. по Релею  ' + Vtext + ' Гц');

  str(Psum1:4:1,Vtext);
  str(qn1:5:3,Vt1);   str(qv1:5:3,Vt2);
  OuttextXY(X1,Y2+6*sy,'Мощн. в полосе ' +Vt1+ '..' +Vt2+ ':   абс. '
            + Vtext + ' дБ;');
  str(Psum*100:4:1,Vt1);
  OuttextXY(X1+42*sx,Y2+6*sy,'отн. ' +Vt1+ ' %');

  str(St,Vtext);
  OuttextXY(X1,Y2+7*sy,'Оценки '+ Vtext + ' максимумов в спектре: ');
  for i:=1 to St do begin
      str(Pmc[i].re:3:3,Vtext);
      OuttextXY(X1+sx,Y2+(7+i)*sy,Vtext+' Гц');
      a:=Pmc[i].im;
      str(a:4:2,Vtext);
      OuttextXY(X1+10*sx,Y2+(7+i)*sy,Vtext);

  end;
{  Readln;
  RestoreCRTMode;   }
END;


procedure DeltaTime(var Hour1,Min1,Sec1,Sec1001: integer;
                    Hour2,Min2,Sec2,Sec1002: Word);
{ Процедура вычисления временного интервала  }
BEGIN
     Sec1001:=Sec1002-Sec1001;
     if Sec1001<0 then begin
        Sec1001:=100+Sec1001; Sec2:=Sec2-1;
     end;
     Sec1:=Sec2-Sec1;
     if Sec1<0 then begin
        Sec1:=60+Sec1; Min2:=Min2-1;
     end;
     Min1:=Min2-Min1;
     if Min1<0 then begin
        Min1:=60+Min1; Hour2:=Hour2-1;
     end;
     Hour1:=Hour2-Hour1;
     writeln('Время вычисления ',
              Hour1:2,'ч.',Min1:2,'мин.',Sec1,',',Sec1001,'сек.');
END;

end.
