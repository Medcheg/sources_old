unit IMATH;
                              interface

const
    Fd = 50;      { Частота дискретизации, Гц }
    Fdd:integer = 10;      { Частота дискретизации, Гц }
   dtc = 1/Fd;   { Период дискретизации, с   }
  Ln10 = 2.302585092994095684;
 Ln10R = 10/Ln10;
   pi2 = 2*pi;
   p02:real = 1.0;        { дисперсия комплексного внутреннего шума         }
   sgN = 0.707107;{ СКО внутр. шума квадратурного канала       }
{  LMas = 16100;}    { Длина рабочего массива masint }
  LMas = 8050;    { Длина рабочего массива masint }
SizeTsk = 24;     { Размерность задачи (векторов и матриц) }
SizeMax = 54;    { Максимальная размерность }
 NumSourc = 4;    { Число оцениваемых источников }
 NumModParamInf = 5; { Число параметров модели для каждого источника }
 NumEstParamInf = 4; { Общее число оцениваемых параметров каждого источника }
 NumBasEstParam = 3; { Число основных (информативных) оцениваемых параметров каждого источника }
 NumTests = 500; { Число статистических испытаний  }

                   P_f   = 12 ;     {  Макс. порядок фильтра }
                  P_2f   = 2*P_f ;

type
  complex   =   record
                 re,im : Double end;
  cplx_int  =   record
                 re,im : integer end;
  cplx_Li  =   record
                 re,im : longint end;
  expform   =   record
                 a,f   : Double
                end;
   vector   =   array [   1..SizeTsk  ] of complex;
Longvector  =   array [   1..SizeMax  ] of complex;
   matrix   =   array [1..SizeTsk,1..SizeTsk] of complex;
  matrix3   =   array [1..18,1..18,1..11] of complex;
   masint   =   array [1..Lmas] of integer;
   maslong  =   array [1..2048] of longint;
{mascplint   =   array [1..4096] of cplx_int;}
mascplint   =   array [1..8095] of cplx_int;
   masPtr   =   ^maslong;
mascpldan   =   array [1..2] of masPtr;
{ Для Искры }
{ Массивы цифровых отсчетов }
  mascplint_I =   array [1..128] of cplx_int;
 MasOutPr_int =  ^mascplint_I;
 MasOutAr_dig =   array [1..54] of MasOutPr_int;
{ Массивы аналоговых сигналов }
     mascpl_I =   array [1..128] of complex;
 MasOutPr_cpl =  ^mascpl_I;
 MasOutAr_anl =   array [1..54] of MasOutPr_cpl;

{*****     Массивы для проведения статистических испытаний *****}
 MatrEstim    = array[1..NumSourc,1..NumEstParamInf] of double;
 MatrBasEstim    = array[1..NumSourc,1..NumBasEstParam] of double;
 MatrBasEstimPtr = ^MatrBasEstim;
 MasStatTests = array[1..NumTests] of MatrBasEstimPtr;
 { Массив содержит значения основных параметров, которые оцениваются
   исследуемым алгоритмом в процессе его функционирования.
   Используется для проведения вычислений }

 ModelParamInf = record     { Информация о параметрах модели }
                  name,value   : string
                end;
 SignalParamInf = record     { Информация о параметрах сигналов }
                  SType,SPKType  : byte;
                  Angl,Freq,Dlit,Ampl,Powr,Band,Tzad,Fpvt : single;
                  {Угол,частота,длительн.,ампл,мощн,полоса,
                   время запаздывания фрона, частота повторения }
                end;
 MatrModelParamInf = array[1..NumSourc,1..NumModParamInf] of ModelParamInf;
     { Матрица содержит информацию о наименовании и значениях параметров,
       описывающих модель каждого источника. Используется для вывода инф-ции }
 MatrEstimParamInf = array[1..NumSourc,1..NumEstParamInf] of ModelParamInf;
     { Матрица содержит информацию о наименовании и значениях параметров,
       оцениваемых для каждого источника в процессе стат. испытаний.
       Используется для вывода инф-ции }
 TOutInf = array[1..3] of string;
{*******************************************************************}
       Xn   =   array [1..SizeTsk] of Double;
   XnWord   =   array [1..SizeTsk] of Word;
     Xxx1   =   array [1..402] of Double;
    KoorT   =   RECORD
                  x,y : integer
                END;
      NFX   =   array [1..402] of KoorT;
     masr   =   array [1..1000] of Double;
MasDouble   =   array [1..10000] of Single;
    masr1   =   ^MasDouble;
      VxP   =   array [1..512] of complex;
     VxP1   =   array [1..256] of complex;
    MSPtr   =   ^VxP;
MasSigPtr   =   Array [1..SizeTsk] of MSPtr;
   VDNFst   =   array [1..9,1..110] of complex; { массив ВДНЧ размером 8х110 }
     XnAR   =   array [1..64] of Double;

                 ArrKF   = array [1..P_2f,1..5] of real;
                 Cmas1   = array[0..4] of complex  ;
                 Cmas2   = array[1..4] of complex  ;
                 mascp   =   array [1..4000] of integer;

var
                 SigPar  : array [1..SizeTsk] of SignalParamInf;
                  {Параметры моделируемых сигналов}

                 TypSig  : array [1..10] of Byte; { Тип сигнала  }
                 Bmm     : array[1..10,1..10] of Double;
  mas,masi,masD,masDi    : ^masint;
{              Mas_AKF    : ^mascplint;}
              Mas_Dan    :  mascpldan;
                FnnKf    : ^matrix3;
             Zap_Spec    : ^VxP1;
    MasSigP,MasVyxSigP   : MasSigPtr;
        Lit,Lcrl         : XnWord;
                  DnAR   : XnAR;   { Геометрия приемной АР }
                 DnNPF   : Xn;     { Геометрия датчиков НПФ }
       Qm,Pm,Fm,Dm,Tn    : Xn;       { Pm - массив ОСШ по мощности }
   DeltaQ, RAsm, Sa,Sf   : Double;
      tayn,Fmax,aBeam    : Double;
         FdF0,dl,Umax    : Double; { Отношение Fдискр/Fmax;  Параметр  Fmax*T0,}
                                 { где Т0 - задержка между  отводами МЛЗ }
        OBSmin,OBSmax    : Double; {Параметры сектора обзора}

          N,M,Kv,Fd_r    : integer;
   GraphDriver,GraphMode : integer;
       X1,X2,Y1,Y2,sx,sy : integer;
              ErrorCode  : integer;
       Kmin,Kglm,Kasm    : integer;
        Pmin,Pper,Pasm   : Word;     { Вероятность пропуска источника }
             MaxX, MaxY  : word;     { максимальное разрешение экрана }
             MaxColor    : word;     { Максимально доступный цвет }
   Year,Month,Day,DWeek  : Word;
   Hour,Min,Sec,Sec100   : Word;
 AimProg,AimStAn,TypeCM  : byte;
          NameAlg,NumDL  : byte;
              Kdec,Kf    : byte;  { к-т децимации и реальная частота дискр-ции }
      PriznADT ,N_ADT    : byte;
       {          NFX1    : NFX;}
Prnt,Vtext, SpFrKM,NameDir : string;
                 GeomAR   : string;
  PodpOX,PodpOY1,PodpOY2  : string; { Подписи осей OX,OY для VyvGraf }
 PodpGr1,PodpGr2,PodpGr3  : string; { Подписи графиков 1-3 для VyvGraf }
            {     MasSig   : array [1..2] of VxP;}  { Массив принимаемых сигналов,М<4 }



     { Процедуры комплексной арифметики }
  procedure SIRcv(var z:complex);
  procedure cv0(var z:complex);
  procedure minus_cv(a:complex; var z:complex);
  procedure cvc(a:complex;var b:complex);
  procedure scv(a,b: complex; var c:complex);
  procedure rcv(a,b: complex; var c:complex);
  procedure ucv(a,b:complex; var c:complex);
  procedure scv_int(a,b:cplx_int; var c:cplx_int);
  procedure rcv_int(a,b:cplx_int; var c:cplx_int);
  procedure ucv_int(a,b:cplx_int; var c:cplx_int);
  procedure ucvcsv(a,b:complex; var c:complex);
  procedure dcv(a,b:complex; var c:complex);
  procedure ucvs(z:complex;a:Double;var p:complex);
  procedure DcvS(z:complex;a:Double;var p:complex);
  procedure ucvis(z:complex;i:integer;var p:complex);
  procedure WcvS(a:complex; s:integer; var c:complex);
  function sign(c: Double):integer;
  function indic(c: Double):integer;
  function indicb(c: Double):integer;
  procedure pce(a: complex; var b: expform);
  procedure opce(b:expform;z:complex);
  procedure Wrvps(a,s:Double;var b:Double);
  procedure WrvOS(a:Double;n:integer; var b:Double);
  procedure WcvPS(z:complex;s:Double; var a:complex);
  function absc(a: complex):Double;
  function faza_cv(c: complex):Double;
  function abs2c(a: complex):Double;
  function absc_int(a: cplx_int):Double;
  function abs2c_int(a: cplx_int):Double;
  {  function expj(x: Double):complex;}


     { Тригонометрические и другие стандартные функции }

  function sinc(x: Double):Double;
  function AstX(a,x: Double):Double;
  function sinD(const x: Double): Double;
  function cosD(const x: Double): Double;
  function Tg(const x: Double): Double;
  function CTg(const x: Double): Double;
  function ArcSin(const x: Double): Double;
  function Log10(const x: Double): Double;
  function Norm2CV(cz: complex):Double;
  function NormCV(cz: complex):Double;
  procedure umcsp(cz,cs: complex; var cr:complex);

       { 2.Процедуры комплексной векторной алгебры }
  procedure SIRV(N:integer; var pN1: vector);                           {2.2}
  procedure  Vc(zN1:vector;N:integer;var pN1:vector);                   {2.3}
  procedure sV(an1,bn1:vector;n:integer;var cn1:vector);                {2.4}
  procedure rV(an1,bn1:vector;n:integer;var cn1:vector);                {2.5}
  procedure ucvV(z:complex;Vn1:vector;n:integer;var Wn1:vector);        {2.6}
  procedure ucvVLong(z:complex;Vn1:Longvector;n:integer;var Wn1:Longvector);
  procedure suv(an1,bn1:vector;n:integer;var p:complex);                {2.7}
  function normav( vn1 : vector; n : integer): Double;                    {2.8}
  procedure eV(an1:vector;n:integer;var eN1:vector);                    {2.9}
  procedure SKoorV(an1:vector;n:integer;var cs:complex);
  procedure NRvector(n:integer;var vn1:vector);

       { 3. Процедуры комплексной матричной алгебры  }
  procedure  SIRM(N,M:integer;var pNM:matrix);                          {3.2}
  procedure  Mc(aNM:matrix;N,M:integer;var BNM:matrix);                 {3.3}
  procedure  Mt(aNM:matrix;N,M:integer;var BMN:matrix);                 {3.4}
  procedure  Mhc(aNM:matrix;N,M:integer;var BMN:matrix);                {3.5}
  procedure BRI(n:integer;var A:matrix);                                {3.6}
  procedure  sM(aNM,bNM:matrix;N,M:integer;var cNM:matrix);              {3.9}
  procedure  rM(aNM,bNM:matrix;N,M:integer;var cNM:matrix);              {3.10}
  procedure uMcv(z:complex;aNM:matrix;N,M:integer;var bNM:matrix);       {3.11}
  procedure umv(cnn: matrix; vn1: vector; n :integer; var an1: vector);   {3.12}
  procedure upmv(cnm:matrix;vm1:vector; n,m:integer; var an1:vector);     {3.13}
  procedure ukm(M1,M2: matrix; n : integer;var M3:matrix);                {3.14}
  procedure upm(M1,M2: matrix; n,l,m : integer;var M3:matrix);            {3.15}
  procedure upm_csm(M1,M2: matrix; L,M,N : integer;var M3:matrix);
  procedure ucsm_pm(M1,M2: matrix; N,M,L : integer;var M3:matrix);
  procedure WmS( M : matrix; n,s : integer;var Ms:matrix );               {3.16}
  procedure  diada(a:matrix;n,m:integer;var dia:matrix);                  {3.17}
  procedure  diada2(a,c:matrix;n,m:integer;var dia:matrix);               {3.18}
  function  SpurAB(Ann,Bnn:matrix;n:integer):Double;
  procedure  Spur(ann:matrix;n:integer;var spur:complex);                 {3.19}
  procedure  spm(ann,bnn:matrix;n:integer;var p:complex);                 {3.20}
  function normaM( aNM : matrix; N,M : integer): Double;                    {3.21}
  procedure Wvector(anm:matrix;n,m,k:integer;var vn1k :vector);           {3.22}
  procedure ZvectorM(hn1:vector;n,l:integer;var Msv:matrix);             {3.23}
  procedure PrCplRe(Cnn:matrix; n,l:integer;var Ann,Bnn:matrix);

       { 4.Специальные функции (точные методы) }
  procedure summa(a:vector; n:integer; var s:complex);                    {4.1}
  procedure summap(a:vector; n:integer; r:Double;var s:integer);                    {4.1}
  procedure Vsumma(ank:matrix; n,k:integer; var sn1:vector);              {4.2}
  procedure analizVe(xn1:vector;enm:matrix;n,m:integer;var ym1:vector);  {4.4}
  procedure sintezM1(a:vector;H:matrix;n:integer; var B:matrix);
  procedure sintezM1p(am1:vector;Hnm:matrix;n,m:integer; var Bnn:matrix);
  procedure epsEM(ann:matrix;n:integer;var eps:Double);                 {4.9}
  procedure epsMU(hnn:matrix;n:integer;var eps:Double);                 {4.9}
  procedure epsgrp(enm:matrix;n,m:integer;var eps:Double);          {4.9'}
  procedure epsSRh(ann,Msvnn:matrix;Vszn1:vector;n:integer;var eps:Double); {4.10}
  procedure epsAqh(ann:matrix;hn1:vector;n:integer;q:complex;var eps:Double);
  procedure gram (Knn : matrix; n : integer; var enn: matrix);           {4.13}
  procedure gramp (Knm:matrix;n,m:integer;var enm:matrix;var dm1:vector);{4.14}
  procedure movz (Knm : matrix; n : integer; var Oknm: matrix);
{  procedure VDNF(dn1:vector;n:integer;q:Double;var vn1:vector); }          {4.18}
  procedure VDN2(q:Double; Tn:Xn; Np:integer; var vn1:vector);
  procedure VDN_AF_Long(q:Double; VecAFV_AR: Longvector;
                      Np:integer; var vn:Longvector);
  procedure VDNFmN(q:Double; Tn:Xn; var vn1:vector);
{  procedure VDN(dn1:vector;n:integer;q:Double;var vn1:vector);           {4.18}

  procedure VDNfiaf(dn1,fn1,an1:vector;n:integer;q,sf,sa,f:Double;var vn1:vector);
  procedure Mp(dn1,qm1:vector;n,m:integer;var vnm:matrix);             {4.19}
  procedure Mpfiaf(dn1,fn1,an1,qm1,fm1:vector;n,m:integer;sf,sa:Double;var vnm:matrix);             {4.19}
  procedure NPXP(pnn:matrix;Vn1:vector;n:integer;var npxdb:Double);      {4.21}
  procedure oNPXgr(dn1:vector;znm:matrix;n,m:integer;q:Double;var fdb:Double);
  procedure znaksum(d:vector;n:integer;var m:Double);                    {4.26}
  procedure factori(n:integer;var p:Double);                             {4.27}
  procedure pinm(zn1:vector;n,i,m:integer;var qnim:complex);           {4.28}
  procedure polinom(cv:complex; a: vector; n:integer;var z:complex);   {4.30}
  procedure polinomp(cv:complex; a: vector; n,m:integer;var z:complex);{4.31}
  procedure HF(Knm :matrix;n :integer; var d:vector);                  {4.32}
  procedure omHF(Knm :matrix;n :integer; var om:matrix);                  {4.32}
  procedure epsoksF(a:matrix;n,s:integer;var eps:Double);
{  procedure HFM(Knn:matrix;n:integer;z:complex;var d:vector;var bnn:matrix);}
  function GAUSS(mo,sigma: Double):Double;                                {1.10}


              { 5. Специальные функции (итерационные методы) }
  procedure savzH(Knn:matrix;n,st:integer;eps:Double;var Msv:matrix;var Vsz:vector);
  procedure savzStat(Knn:matrix;n,st:integer;eps:Double;
                     var Msv:matrix;var Vsz:vector);
  procedure savzVAG(ann:matrix;n,st:integer;eps:Double;pr :complex;var Msv,Msvs:matrix;var Vsz:vector);
  procedure  anPELvag(hnm:matrix;n,m,st1:integer;D1,eps1:Double;pr :complex;var qm1,am1:vector);
 { procedure ris(xt,xmin,xmax,ymin,ymax,d,w0:Double;ind,nn:integer;yt:Double); }

                            implementation

uses Crt;

        {*****  1.Процедуры комплексной арифметики    *********}
procedure SIRcv(var z:complex);
 { Обнуление комплексного числа }           {1.2}
begin
   z.re:=0;  z.im:=0;
end;
procedure cv0(var z:complex);
 { Обнуление комплексного числа }           {1.2}
begin
   z.re:=0.0;  z.im:=0.0;
end;
procedure minus_cv(a:complex; var z:complex);
 { Вычисление комплексного числа с противоп. знаком }
begin
   z.re:=-a.re;  z.im:=-a.im;
end;
procedure cvc(a:complex;var b:complex);
 { Комплексное сопряжение  }                        {1.3}
begin
   b.re:=a.re; b.im:=-a.im;
end;
procedure scv(a,b: complex; var c:complex);
 { Сумма комплексных чисел  }                        {1.4}
begin
  c.re:=a.re+b.re; c.im:=a.im+b.im;
end;
procedure rcv(a,b: complex; var c:complex);
  { Разность комплексных чисел  }                             {1.5}
begin
  c.re:=a.re-b.re; c.im:=a.im-b.im;
end;
procedure ucv(a,b:complex; var c:complex);
   { Умножение комплексных чисел  }                             {1.6}
begin
  c.re:=a.re*b.re-a.im*b.im; c.im:=a.re*b.im+a.im*b.re;
end;

procedure scv_int(a,b:cplx_int; var c:cplx_int);
 { Сумма комплексных чисел  }                        {1.4}
begin
  c.re:=a.re+b.re; c.im:=a.im+b.im;
end;
procedure rcv_int(a,b: cplx_int; var c:cplx_int);
  { Разность комплексных чисел  }                             {1.5}
begin
  c.re:=a.re-b.re; c.im:=a.im-b.im;
end;

procedure ucv_int(a,b:cplx_int; var c:cplx_int);
   { Умножение комплексных чисел  }                             {1.6}
begin
  c.re:=round( a.re*b.re-a.im*b.im );
  c.im:=round( a.re*b.im+a.im*b.re );
end;

procedure ucvcsv(a,b:complex; var c:complex);
   { Умножение комплексного числа на комплексно сопряженное число }                             {1.6}
begin
  c.re:=a.re*b.re+a.im*b.im; c.im:=-a.re*b.im+a.im*b.re;
end;

procedure ucsvcv(a,b:complex; var c:complex);
   { Умножение комплексно сопряженного числа на комплексное число }                             {1.6}
begin
  c.re:=a.re*b.re+a.im*b.im;
  c.im:=a.re*b.im-a.im*b.re;
end;

procedure dcv(a,b:complex; var c:complex);
   { Деление комплексных чисел  }                              {1.16}
var
b1,p  : complex;
q     : Double;
begin
   q:=sqr(b.re)+sqr(b.im);
   cvc(b,b1);ucv(a,b1,p); c.re:=p.re/q; c.im:=p.im/q;
end;
procedure ucvs(z:complex;a:Double;var p:complex);
  { Умножение комплексного числа на веществ. скаляр }                    {1.8}
begin
   p.re:=a*z.re; p.im:=a*z.im;
end;
procedure DcvS(z:complex;a:Double;var p:complex);
  { Деление комплексного числа на веществ. скаляр }                    {1.8}
begin
   p.re:=z.re/a; p.im:=z.im/a;
end;
procedure ucvis(z:complex;i:integer;var p:complex);
  { Умножение комплексного числа на целый скаляр }                    {1.8}
begin
   p.re:=i*z.re; p.im:=i*z.im;
end;
procedure WcvS(a:complex; s:integer; var c:complex);
 { Возведение комплексного числа в целую степень  }                 {1.9}
var
  p:complex;
  k:integer;
begin
   if s=0 then c.re:=1;c.im:=0;
   p.re:=1; p.im:=0;
   for k:=1 to s do begin ucv(p,a,p); end;  c:=p;
end;
function sign(c: Double):integer;                                {1.10}
var k: integer;
begin
  if c<0.0 then k:=-1 else k:=1;
  sign:=k;
end;
function indic(c: Double):integer;                               {1.11}
var k: integer;
begin
  if c=-1 then k:=1 else k:=0;
  indic:=k;
end;
function indicb(c: Double):integer;                               {1.11}
var k: integer;
begin
  if c>0.0 then k:=1 else k:=0;
  indicb:=k;
end;
function absc(a: complex):Double;                               {1.11}
begin
   absc:=sqrt(a.re*a.re + a.im*a.im);
end;

function faza_cv(c: complex):Double;                               {1.11}
var
a         : Double;
begin
   If c.re=0 then a:=pi/2
             else a:=Abs( Arctan(c.im/c.re) );
   case ( Byte(c.re>0) + Byte(c.im>=0) ) of
     2: faza_cv:=a;
     1: if c.re>0 then faza_cv:=2*pi - a
                  else faza_cv:=pi   - a;
     0: faza_cv:=Pi + a;
   end;
end;

function abs2c(a: complex):Double;                               {1.11}
begin
   abs2c:=a.re*a.re + a.im*a.im;
end;

function absc_int(a: cplx_int):Double;                               {1.11}
begin
   absc_int:=sqrt(a.re*a.re + a.im*a.im);
end;

function abs2c_int(a: cplx_int):Double;                               {1.11}
begin
   abs2c_int:=a.re*a.re + a.im*a.im;
end;

{function expj(x: Double):complex;
begin
   expj.re:=cos(x);   expj.im:=sin(x);
end; }

function sinc(x: Double):Double;                                {1.10}
begin
  if x=0 then sinc:=1
  else sinc:=sin(x)/x;
end;


procedure pce(a: complex; var b: expform);
 { Перевод комплексного числа из алгебраической в показательную форму } {1.12}
begin
  b.a:=sqrt(sqr(a.re)+sqr(a.im));
  if abs(a.re)<=0.1e-12 then b.f:=pi/2*sign(a.im)
  else b.f:=arctan(a.im/a.re)+pi*sign(a.im)*(1.0-sign(a.re))/2.0;
end;
procedure opce(b:expform;z:complex);                                  {1.13}
begin
   z.re:=b.a*cos(b.f);  z.im:=b.a*sin(b.f);
end;
function Norm2CV(cz: complex):Double;
{ Вычисление квадрата нормы комплексного числа }
begin
   Norm2CV:=sqr(cz.re) + sqr(cz.im);
end;

function NormCV(cz: complex):Double;
{ Вычисление нормы комплексного числа }
begin
   NormCV:=sqrt(sqr(cz.re) + sqr(cz.im));
end;

procedure umcsp(cz,cs: complex; var cr:complex);
{ Умножение комплексного числа на комплексно-сопряженное }
begin
   cr.re:=cz.re*cs.re + cz.im*cs.im;
   cr.im:=cz.im*cs.re - cz.re*cs.im;
end;


procedure Wrvps(a,s:Double;var b:Double);                            {1.14}
var
c         : Double;
begin
   c:=s*ln(abs(a)); b:=exp(c);
end;
procedure WrvOS(a:Double;n:integer; var b:Double);                     {1.15}
var
s,c,s1         : Double;
begin
   s:=1/n;s1:=sign(a);
   if a=0 then b:=0 else begin
   c:=s*ln(abs(a)); b:=s1*exp(c);end;
end;
procedure WcvPS(z:complex;s:Double; var a:complex);                     {1.16}
var
b,q       : expform;
c         : Double;
begin
   if s=0 then a.re:=1;a.im:=0;
   pce(z,b); q.f:=s*(b.f);
   if b.a=0.0 then begin
   a.re:=0.0; a.im:=0.0;end else begin
   c:=s*ln(b.a); q.a:=exp(c);
   a.re:=q.a*cos(q.f); a.im:=q.a*sin(q.f);end;
end;
function AstX(a,x: Double):Double;
{ Возведение а в положительную степень х }
begin
   AstX:=Exp(x*Ln(abs(a)));
end;

function sinD(const x: Double): Double;
{ Вычисляет Sin(x) , x - в градусах}
begin
  SinD:= Sin(x*pi/180);
end;

function cosD(const x: Double): Double;
{ Вычисляет cos(x) , x - в градусах}
begin
  cosD:= cos(x*pi/180);
end;
function Tg(const x: Double): Double;
begin
  Tg:= Sin(x)/Cos(x);
end;
{-----------------------------------------------------------}
function CTg(const x: Double): Double;
begin
  CTg:= Cos(x)/Sin(x);
end;
{-----------------------------------------------------------}
function ArcSin(const x: Double): Double;
begin
     If Abs(x)=1 then ArcSin:=0
     else ArcSin:=ArcTan(x/Sqrt(1-Sqr(x)))
end;
{-----------------------------------------------------------}
function Log10(const x: Double): Double;
begin
  Log10:= 0.4342944819033*Ln(x);
end;
{-----------------------------------------------------------}


         {****  2.Процедуры комплексной векторной алгебры  ****}
procedure SIRV(N:integer; var pN1: vector);                           {2.2}
{формирование нуль-вектора}
var
i:integer;
begin
   for i:=1 to N do begin pN1[i].re:=0.0; pN1[i].im:=0.0;
   end;
end;
procedure  Vc(zN1:vector;N:integer;var pN1:vector);
 { Комплексное сопряжение вектора }                 {2.3}
var
i:integer;
begin
   for i:=1 to N do       cvc(zN1[i],pN1[i]);
end;
procedure sV(an1,bn1:vector;n:integer;var cn1:vector);
{ Сумма векторов }               {2.4}
var
i:integer;
begin
   for i:=1 to n do    scv(an1[i],bn1[i],cn1[i]);
end;
procedure rV(an1,bn1:vector;n:integer;var cn1:vector);
{Разность векторов }               {2.5}
var
i:integer;
begin
   for i:=1 to n do    rcv(an1[i],bn1[i],cn1[i]);
end;
procedure ucvV(z:complex;Vn1:vector;n:integer;var Wn1:vector);
 { Умножение вектора на комплексное число }       {2.6}
var
i:integer;
begin
   for i:=1 to n do    ucv(z,Vn1[i],Wn1[i])
end;
procedure ucvVLong(z:complex;Vn1:Longvector;n:integer;var Wn1:Longvector);
 { Умножение вектора на комплексное число }       {2.6}
var
i:integer;
begin
   for i:=1 to n do    ucv(z,Vn1[i],Wn1[i])
end;
procedure suv(an1,bn1:vector;n:integer;var p:complex);
{ Скалярное умножение векторов }              {2.7}
var
  i   : integer;
  c   : complex;
  Wn1 : vector;
begin
  for i:=1 to n do  cvc(bn1[i],Wn1[i]);
  p.re:=0.0; p.im:=0.0;
  for i:=1 to n do begin
      ucv(an1[i],Wn1[i],c); scv(p,c,p);
  end;
end;
function normav( vn1 : vector; n : integer): Double;
{ Норма вектора }                   {2.8}
var
  i: integer;
  g: Double;
begin
  g:=0.0; for i:=1 to n do g:=g+sqr(vn1[i].re)+sqr(vn1[i].im);
  normav:=sqrt(g);
end;
procedure eV(an1:vector;n:integer;var eN1:vector);
{ Процедура нормировки вектора }                  {2.9}
var
i:integer;
q:Double;
begin
   q:=normav(an1,n)+1E-10;
   for i:=1 to n do begin
   eN1[i].re:=an1[i].re/q; eN1[i].im:=an1[i].im/q;
   end;
end;

procedure SKoorV(an1:vector;n:integer;var cs:complex);
{ Вычисление суммы координат вектора }                  {2.9}
var
i:integer;
begin
   cs.re:=0;  cs.im:=0;
   for i:=1 to n do begin
       cs.re:=cs.re + an1[i].re;   cs.im:=cs.im + an1[i].im;
   end;
end;

procedure NRvector(n:integer;var vn1:vector);
{ Формирование вектора, координаты которого -
  независимые гауссовы случайные величины с нулевым средним и
  единичной СКО  }
var
s  :Double;
i,j:integer;
begin
{   randomize;}
   for i:=1 to n do begin
     s:=0;
     for j:=1 to 12 do begin
     s:=s+random;
     end;
   vn1[i].re:=(s-6);vn1[i].im:=0.0;
   end;
end;

       {***  3.Процедуры комплексной матричной алгебры  ********}
procedure  SIRM(N,M:integer;var pNM:matrix);                          {3.2}
var
i,j : integer;
begin
   for i:=1 to N do begin  for j:=1 to M do begin
   pNM[i,j].re:=0.0; pNM[i,j].im:=0.0;
   end;end;
end;
procedure  Mc(aNM:matrix;N,M:integer;var BNM:matrix);                 {3.3}
var
i,j:integer;
begin
   for i:=1 to N do begin for j:=1 to M do begin
   cvc(aNM[i,j],BNM[i,j]);
   end;end;
end;
procedure  Mt(aNM:matrix;N,M:integer;var BMN:matrix);
 {Транспонирование прямоугольной матрицы  }                {3.4}
var
i,j:integer;
begin
   for i:=1 to M do begin for j:=1 to N do begin
   BMN[i,j].re:=aNM[j,i].re;
   BMN[i,j].im:=aNM[j,i].im;
   end;end;
end;
procedure  Mhc(aNM:matrix;N,M:integer;var BMN:matrix);
 {Комплексное сопряжение прямоугольной матрицы  }                {3.5}
var
i,j:integer;
PMN:^matrix;
begin
   New(Pmn);
   for i:=1 to M do begin for j:=1 to N do begin
   PMN^[i,j]:=aNM[j,i]; cvc(PMN^[i,j],BMN[i,j]);
   end;end;
   Dispose(Pmn);
end;
procedure BRI(n:integer;var A:matrix);                                {3.6}
var
i,j       :integer;
begin
   for i:=1 to n do begin for j:=1 to n do begin
   if i=j  then begin  A[i,j].re:=1;A[i,j].im:=0.0;end
   else  A[i,j].re:=0.0;A[i,j].im:=0.0;end;end;
end;
procedure  sM(aNM,bNM:matrix;N,M:integer;var cNM:matrix);
{ Сумма матриц  }              {3.9}
var
i,j:integer;
begin
   for i:=1 to N do begin for j:=1 to M do begin
   scv(aNM[i,j],bNM[i,j],cNM[i,j]);
   end;end;
end;
procedure  rM(aNM,bNM:matrix;N,M:integer;var cNM:matrix);
 { Разность матриц }             {3.10}
var
i,j:integer;
begin
   for i:=1 to N do  for j:=1 to M do
   rcv(aNM[i,j],bNM[i,j],cNM[i,j]);
end;
procedure uMcv(z:complex;aNM:matrix;N,M:integer;var bNM:matrix);
{ Умножение матрицы на комплексное число }     {3.11}
var
i,j:integer;
begin
   for i:=1 to N do  for j:=1 to M do
   ucv(z,aNM[i,j],bNM[i,j]);
end;
procedure umv(cnn: matrix; vn1: vector; n :integer; var an1: vector);
{ Умножение квадратной компл. матрицы на компл. вектор }  {3.12}
var
  i,j : integer;
  d,s : complex;
begin
  for i:=1 to n do begin
    s.re:=0.0; s.im:=0.0;
    for j:=1 to n do begin
      ucv(cnn[i,j],vn1[j],d); scv(s,d,s);
    end; an1[i]:=s;
  end;
end;
procedure upmv(cnm:matrix;vm1:vector; n,m:integer; var an1:vector);
{ Умножение прямоугольной компл. матрицы на компл. вектор }     {3.13}
var
  i,j : integer;
  d,s : complex;
begin
  for i:=1 to n do begin
    s.re:=0.0; s.im:=0.0;
    for j:=1 to m do begin
      ucv(cnm[i,j],vm1[j],d); scv(s,d,s);
    end; an1[i]:=s;
  end;
end;
procedure ukm(M1,M2: matrix; n : integer;var M3:matrix);
{Умножение квадратных матриц}              {3.14}
var
  i,j,k: integer;
  c    : complex;
begin
  for i:=1 to n do for j:=1 to n do begin
    M3[i,j].re:=0.0; M3[i,j].im:=0.0;
    for k:=1 to n do begin
      ucv(M1[i,k],M2[k,j],c);scv(c,M3[i,j],M3[i,j]);
    end;
  end;
end;
procedure upm(M1,M2: matrix; n,l,m : integer;var M3:matrix);
{ Умножение прямоугольных матриц }          {3.15}
var
  i,j,k: integer;
  c    : complex;
begin
  for i:=1 to n do for j:=1 to m do begin
    M3[i,j].re:=0.0; M3[i,j].im:=0.0;
    for k:=1 to l do begin
      ucv(M1[i,k],M2[k,j],c);scv(c,M3[i,j],M3[i,j]);
    end;
  end;
end;

procedure upm_csm(M1,M2: matrix; L,M,N : integer;var M3:matrix);
{ Умножение прямоугольной матрицы на компл. сопр. матрицу }
{ M - число столбцов м-цы М1  и   столбцов несопряженной м-цы М2}
{ L - число строк м-цы М1; N - число строк несопряженной м-цы М2}
var
  i,j,k: integer;
  c    : complex;
begin
  for i:=1 to L do for j:=1 to N do begin
    M3[i,j].re:=0.0; M3[i,j].im:=0.0;
    for k:=1 to M do begin
      umcsp(M1[i,k],M2[j,k],c);scv(c,M3[i,j],M3[i,j]);
    end;
  end;
end;

procedure ucsm_pm(M1,M2: matrix; N,M,L : integer;var M3:matrix);
{ Умножение компл. сопр. матрицы на прямоугольную матрицу }
{ N - число строк несопряженной м-цы М1  и строк м-цы М2}
{ М - число столбцов м-цы М1; L - число столбцов м-цы М2}
var
  i,j,k: integer;
  c    : complex;
begin
  for i:=1 to M do for j:=1 to L do begin
    M3[i,j].re:=0.0; M3[i,j].im:=0.0;
    for k:=1 to N do begin
      ucsvcv(M1[k,i],M2[k,j],c);scv(c,M3[i,j],M3[i,j]);
    end;
  end;
end;

procedure WmS( M : matrix; n,s : integer;var Ms:matrix );
{ Возведение квадр. матрицы в степень }             {3.16}
var
i,j,k: integer;
  Mp: ^matrix;
begin
  New(Mp);
  if s=0 then Ms:=Mp^;
  BRI(n,Mp^);
  for k:=1 to s do begin ukm(Mp^,M,n,Mp^);end; Ms:=Mp^;
  Dispose(Mp);
end;
procedure  diada(a:matrix;n,m:integer;var dia:matrix);
{ Формирование диады: dia = Anm * Anm+ }                 {3.17}
var
b     :  ^matrix;
begin
New(B);
    Mhc(a,n,m,b^); upm(a,b^,n,m,n,dia);
Dispose(B);
end;
procedure  diada2(a,c:matrix;n,m:integer;var dia:matrix);
{ Формирование диады: dia = Anm * Cnm+ }                {3.18}
var
b    :  ^matrix;
begin
New(B);
   Mhc(c,n,m,b^); upm(a,b^,n,m,n,dia);
Dispose(B);
end;
procedure  Spur(ann:matrix;n:integer;var spur:complex);
{ Вычисление следа матрицы }              {3.19}
var
i : integer;
p : complex;
begin
   p.re:=0.0; p.im:=0.0;
   for i:=1 to n do begin scv(p,ann[i,i],p);end;spur:=p;
end;
procedure  spm(ann,bnn:matrix;n:integer;var p:complex);
{ Вычисление следа диады2: p = Spur(Ann Bnn+ ) }              {3.20}
var
c,d   :  ^matrix;
begin
New(D);  New(C);
   Mhc(bnn,n,n,c^); ukm(ann,c^,n,d^); Spur(d^,n,p);
Dispose(D);  Dispose(C);
end;
function normaM( aNM : matrix; N,M : integer): Double;
 { Норма матрицы }                  {3.21}
var
  i,j: integer;
  g,a,b: Double;
begin
  g:=0.0; for i:=1 to N do begin for j:=1 to M do begin
  a:=aNM[i,j].re;  b:=aNM[i,j].im;
  g:=g+sqr(a)+sqr(b);  end;end;
  normaM:=sqrt(g);
end;
procedure Wvector(anm:matrix;n,m,k:integer;var vn1k :vector);
{ Выделение к-го столбца матрицы Anm в виде вектора  Vn1k }        {3.22}
var
i:integer;
begin
   for i:= 1 to n do   vn1k[i]:=anm[i,k];
end;
procedure ZvectorM(hn1:vector;n,l:integer;var Msv:matrix);
{ Замена k-го столбца матрицы Vsv на вектор Hn1 }            {3.23}
var
i:integer;
begin
   for i:=1 to n do begin Msv[i,l]:=hn1[i];end;
end;

procedure PrCplRe(Cnn:matrix; n,l:integer;var Ann,Bnn:matrix);
{ Преобразование комплексной матрицы в две действительные }            {3.23}
var
i,j : integer;
begin
   for i:=1 to n do for j:=1 to l do begin
     Ann[i,j].re:=Cnn[i,j].re;
     Bnn[i,j].re:=Cnn[i,j].im;
     Ann[i,j].im:=0.0;
     Bnn[i,j].im:=0.0;
   end;
end;

           {*****   4. Специальные функции  ***********}
procedure summa(a:vector; n:integer; var s:complex);                    {4.1}
var
i      :integer;
p      :vector;
begin
   for i:=1 to n do begin p[i].re:=1;p[i].im:=0.0;end;
   suv(a,p,n,s);
end;
procedure summap(a:vector; n:integer; r:Double;var s:integer);                    {4.1}
var
i      :integer;
b      :vector;
begin
   s:=0;
   for i:=1 to n do begin
   b[i].re:=a[i].re-r;s:=s+indicb(b[i].re);
   end;
end;
procedure Vsumma(ank:matrix; n,k:integer; var sn1:vector);              {4.2}
var
i,j      :integer;
pk1      :vector;
begin
   for i:=1 to n do begin for j:=1 to k do begin
   pk1[j]:=ank[i,j];summa(pk1,k,sn1[i]);end;end;
end;
{procedure sintezV(dk1:vector;ank:matrix; n,k:integer; var sn1:vector);
var
i,j      :integer;
p        :complex;
pk1      :vector;
begin
   for i:=1 to n do begin for j:=1 to k do begin
   ucv(dk1[j],ank[i,j],pk1[j]);
   summa(pk1,k,sn1[i]);end;end;
end;}
procedure analizVe(xn1:vector;enm:matrix;n,m:integer;var ym1:vector);  {4.4}
var
W  : vector;
i,j:integer;
begin
   for j:=1 to m do begin
      for i:=1 to n do  W[i]:=enm[i,j];
      suv(xn1,W,n,ym1[j]);
   end;
end;
procedure sintezM1(a:vector;H:matrix;n:integer; var B:matrix);
var
i,j,k   :integer;
p,q,g   :complex;
d       :vector;
begin
   for i:=1 to n do begin for j:=1 to n do begin
     for k:=1 to n do begin
     cvc(H[j,k],p);ucv(H[i,k],p,q);ucv(a[k],q,g);d[k]:=g;
     end;
   summa(d,n,p);B[i,j]:=p;
   end;end;
end;
procedure sintezM1p(am1:vector;Hnm:matrix;n,m:integer; var Bnn:matrix);
var
i,j,k   :integer;
p,q,g   :complex;
dm1     :vector;
begin
   for i:=1 to n do begin for j:=1 to n do begin
     for k:=1 to m do begin
        cvc(Hnm[j,k],p);
        ucv(Hnm[i,k],p,q);
        ucv(am1[k],q,g);
        dm1[k]:=g;
     end;
     summa(dm1,m,p);Bnn[i,j]:=p;
   end;end;
end;

function SpurAB(Ann,Bnn:matrix;n:integer):Double;
var
i,j   :integer;
a,b,c   :complex;
begin
   SIRcv(a);
   for i:=1 to n do begin
     SIRcv(b);
     for j:=1 to n do begin
        ucv(Ann[i,j],Bnn[j,i],c);
        SCV(c,b,b);
     end;
     SCV(a,b,a);
   end;
   SpurAB:=NormCV(a);
end;

procedure epsEM(ann:matrix;n:integer;var eps:Double);                 {4.9}
var
bnn,cnn    :  ^matrix;
q1,q2      :  Double;
begin
New(bnn); New(cnn);
   BRI(n,bnn^);
   rM(ann,bnn^,n,n,cnn^);
   q1:=normaM(cnn^,n,n);
   q2:=normaM(bnn^,n,n);
   if q2<1.0e-13 then eps:=q1 else
   eps:=q1/q2;
Dispose(bnn); Dispose(cnn);
end;
procedure epsMU(hnn:matrix;n:integer;var eps:Double);                 {4.9}
var
ann,bnn,cnn:  ^matrix;
q1,q2      :Double;
begin
New(Ann); New(bnn); New(cnn);
   diada(hnn,n,n,ann^);BRI(n,bnn^);rM(ann^,bnn^,n,n,cnn^);
   q1:=normaM(cnn^,n,n);q2:=normaM(bnn^,n,n);
      if q2<1.0e-13 then eps:=q1 else
   eps:=q1/q2;
Dispose(Ann); Dispose(bnn); Dispose(cnn);
end;
procedure epsgrp(enm:matrix;n,m:integer;var eps:Double);          {4.9'}
var
bmm,cmm    :^matrix;
q1,q2      :Double;
begin
   New(bmm); New(cmm);
   Mhc(enm,n,m,Cmm^); upm(Cmm^,enm,m,n,m,bmm^);
   BRI(m,cmm^);rM(bmm^,cmm^,m,m,bmm^);
   q1:=normaM(bmm^,m,m);q2:=normaM(cmm^,m,m);
      if q2<1.0e-13 then eps:=q1 else
   eps:=q1/q2;
   Dispose(bmm); Dispose(cmm);
end;
procedure epsSRh(ann,Msvnn:matrix;Vszn1:vector;n:integer;var eps:Double); {4.10}
var
bnn,cnn    :^matrix;
q1,q2      :Double;
begin
   New(bnn); New(cnn);
   sintezM1(Vszn1,Msvnn,n,bnn^);
   rM(ann,bnn^,n,n,cnn^);
   q1:=normaM(cnn^,n,n);q2:=normaM(ann,n,n);
      if q2<1.0e-13 then eps:=q1 else
   eps:=q1/q2;
   Dispose(bnn); Dispose(cnn);
end;
procedure epsAqh(ann:matrix;hn1:vector;n:integer;q:complex;var eps:Double);
var
bn1,cn1,xn1:vector;
q1,q2      :Double;
begin
   ucvV(q,hn1,n,bn1);umv(ann,hn1,n,cn1);
   rV(cn1,bn1,n,xn1);q1:=normaV(xn1,n);q2:=normaV(cn1,n);
   if q2=0.0 then eps:=q1;
   eps:=q1/q2;
end;
procedure gram (Knn : matrix; n : integer; var enn: matrix);           {4.13}
var
  Pv,Vp,Vk,S    :   vector;
  cv            :   complex;
  i,k,m         :   integer;
begin
  for i:=1 to n do begin Pv[i]:=Knn[i,1];end;
  ev(Pv,n,Vp);
  for i:=1 to n do begin enn[i,1]:=Vp[i]; end;
  for k:=2 to n do begin
    for i:=1 to n do begin Pv[i]:=Knn[i,k];
    S[i].re:=0;S[i].im:=0;end;
    for m:=1 to k-1 do begin
      for i:=1 to n do begin Vp[i]:=enn[i,m]; end;
      suv(Pv,Vp,n,cv); ucvV(cv,Vp,n,Vk);
      sV(S,Vk,n,S);
    end;
  rV(Pv,S,n,Vk);
  ev(Vk,n,Vp);
  for i:=1 to n do begin enn[i,k]:=Vp[i]; end;
  end;
end;
procedure gramp (Knm:matrix;n,m:integer;var enm:matrix;var dm1:vector);{4.14}
var
  Pv,Vp,Vk,S    :   vector;
  cv            :   complex;
  i,k           :   integer;
begin
  for i:=1 to n do begin Pv[i]:=Knm[i,1];end;
  ev(Pv,n,Vp);dm1[1].re:=normav(Pv,n); dm1[1].im:=0.0;
  for i:=1 to n do begin enm[i,1]:=Vp[i]; end;
  for k:=2 to m do begin
    for i:=1 to n do begin Pv[i]:=Knm[i,k];
    S[i].re:=0;S[i].im:=0;end;
    for m:=1 to k-1 do begin
      for i:=1 to n do begin Vp[i]:=enm[i,m]; end;
      suv(Pv,Vp,n,cv); ucvV(cv,Vp,n,Vk);
      sV(S,Vk,n,S);
    end;
  rV(Pv,S,n,Vk); dm1[k].re:=normav(Vk,n); dm1[k].im:=0.0;
  ev(Vk,n,Vp);
  for i:=1 to n do begin enm[i,k]:=Vp[i]; end;
  end;
end;

procedure movz (Knm : matrix; n : integer; var Oknm: matrix);
label Mend;
var
  Mv,Mvs,OIM       :   ^matrix;
  Pv,Vp,Vk,Sv,H0   :   vector;
  cv               :   complex;
  i,j,l,k,m        :   integer;
  mad,c1,c2        :   Double;
begin
New(Mv); New(Mvs); New(OIM);
  IF N=1 THEN begin
     Oknm[1,1].re:=1/Knm[1,1].re; Oknm[1,1].im:=0.0;
     goto Mend;
  end;
  for i:=1 to n do begin
  H0[i].re:=i*i+1;H0[i].im:=i;end;
  for l:=1 to n do begin
    for k:=1 to (n-1) do for i:=1 to n do
    if k<l then Mvs^[i,k]:=Knm[i,k]  else  Mvs^[i,k]:=Knm[i,k+1];
    for i:=1 to n do begin Pv[i].re:=Mvs^[i,1].re;Pv[i].im:=Mvs^[i,1].im;end;
    ev(Pv,n,Vp);
    for i:=1 to n do Mv^[i,1]:=Vp[i];
    for k:=2 to n-1 do begin
      for i:=1 to n do  Pv[i]:=Mvs^[i,k];
      for i:=1 to n do begin Sv[i].re:=0.0; Sv[i].im:=0.0; end;
      for m:=1 to k-1 do begin
        for i:=1 to n do Vp[i]:=Mv^[i,m];
        suv(Pv,Vp,n,cv);
        ucvV(cv,Vp,n,Vk);
        for i:=1 to n do scv(Sv[i],Vk[i],Sv[i]);
      end;
      for i:=1 to n do rcv(Pv[i],Sv[i],Vk[i]);
      ev(Vk,n,Vp);
      for i:=1 to n do Mv^[i,k]:=Vp[i];
    end;
    cv.re:=0.0;cv.im:=0.0; for i:=1 to n do Sv[i]:=cv;
    for m:=1 to n-1 do begin
      for i:=1 to n do Vp[i]:=Mv^[i,m];
      suv(H0,Vp,n,cv); ucvV(cv,Vp,n,Pv);
      for i:=1 to n do scv(Sv[i],Pv[i],Sv[i]);
    end;
    for i:=1 to n do rcv(H0[i],Sv[i],Pv[i]);
    ev(Pv,n,Vp);
    for i:=1 to n do Pv[i]:=Knm[i,l];
    suv(Vp,Pv,n,cv);
    cv.im:=-cv.im;
    ucvV(cv,Vp,n,Vk);
    mad:=sqr(cv.re)+sqr(cv.im);
    for i:=1 to n do begin
      Oknm[i,l].re:=Vk[i].re/mad; Oknm[i,l].im:=Vk[i].im/mad;
    end;
  end;
  for i:=1 to n do for j:=1 to n do Mv^[i,j]:=Oknm[j,i];
  for i:=1 to n do for j:=1 to n do begin Oknm[i,j].im:=-Mv^[i,j].im;
  Oknm[i,j].re:=Mv^[i,j].re;end;
Mend:
Dispose(Mv); Dispose(Mvs); Dispose(OIM);
end;

procedure VDN2(q:Double; Tn:Xn; Np:integer; var vn1:vector);
 { Подпрограмма формирования ненормированной идеальной ВДН  }
var
x,q1 : Double;
k      : integer;
begin
   q1:=pi2*sin(q*pi/180);
   for k:=1 to Np do begin
       x:=q1*Tn[k];
       vn1[k].re:=cos(x); vn1[k].im:=sin(x);
   end; { ev(wn1,n,vn1);}

end;

procedure VDN_AF_Long(q:Double; VecAFV_AR: Longvector;
                      Np:integer; var vn:Longvector);
 { Подпрограмма формирования ненормированной НПХ  }
 { при наличии случайных АФ возмущений            }
var
    x,q1 : Double;
       k : integer;
begin
   q1:=pi2*sin(q*pi/180);
   for k:=1 to Np do begin
       x:=q1*DnAR[k];
       vn[k].re:=cos(x); vn[k].im:=sin(x);
       UCV(Vn[k],VecAFV_AR[k],Vn[k]);
 {  writeln('x=',x:6:2,'  cos(x)=',vn1[k].re:6:3);}
   end;
end;

procedure VDNFmN(q:Double; Tn:Xn; var vn1:vector);
 { Подпрограмма формирования ненормированной идеальной НЧХ  }
 { для произвольной МЛЗ                                     }
var
x,q1 : Double;
k      : integer;
begin
   q1:=q*pi2*dl;
   for k:=1 to n do begin
       x:=q1*Tn[k];
       vn1[k].re:=cos(x); vn1[k].im:=sin(x);
   end;
end;

procedure VDN(dn1:vector;n:integer;q:Double;var vn1:vector);           {4.18}
var
x,u,q1 : Double;
k      : integer;
wn1    : vector;
begin
   q1:=q*pi*(1/180); u:=sin(q1);
   for k:=1 to n do begin
   x:=2*pi*u*dn1[k].re;
   wn1[k].re:=cos(x); wn1[k].im:=sin(x);
   end;  ev(wn1,n,vn1);
end;
procedure VDNfiaf(dn1,fn1,an1:vector;n:integer;q,sf,sa,f:Double;var vn1:vector);
var
x,u,q1,v,s : Double;
k          : integer;
begin
   q1:=q*pi/180; u:=sin(q1);  v:=sf*pi/180;
   for k:=1 to n do begin
   x:=2*pi*u*f*dn1[k].re+v*fn1[k].re;
   s:=exp(ln(10)*sa*an1[k].re/20);
   vn1[k].re:=s*cos(x); vn1[k].im:=s*sin(x);
   end;
end;
procedure Mp(dn1,qm1:vector;n,m:integer;var vnm:matrix);             {4.19}
var
a      :vector;
i,j    :integer;
q      :Double;
begin
   for i:=1 to n do begin for j:=1 to m do begin
   q:=qm1[j].re; VDN(dn1,n,q,a);vnm[i,j]:=a[i];end;end;
end;
procedure Mpfiaf(dn1,fn1,an1,qm1,fm1:vector;n,m:integer;sf,sa:Double;var vnm:matrix);             {4.19}
var
a      :vector;
i,j    :integer;
q,c,d      :Double;
begin
   for i:=1 to n do begin for j:=1 to m do begin
   q:=qm1[j].re; d:=fm1[j].re;VDNfiaf(dn1,fn1,an1,n,q,sf,sa,d,a);
   vnm[i,j]:=a[i];end;end;
end;
procedure NPXP(pnn:matrix;Vn1:vector;n:integer;var npxdb:Double);      {4.21}
var
q,qv,c1,c2 : Double;
p          : complex;
a          : vector;
begin
   umv(pnn,vn1,n,a); q:=normav(a,n); qv:=normav(Vn1,n);
   c1:=sqr(q/qv);c2:=abs(1-c1)+0.00000000000000000001;
   npxdb:=10*ln(c2)/ln(10.0);
end;
procedure oNPXgr(dn1:vector;znm:matrix;n,m:integer;q:Double;var fdb:Double);
var                                                                  {4.24}
Vn1,am1,ym1 : vector;
enm         : ^matrix;
a,b,a1,a2   : Double;
begin
New(Enm);

   VDN(dn1,n,q,Vn1);GRAMp(znm,n,m,enm^,am1);
   analizVe(Vn1,enm^,n,m,ym1);a:=normav(ym1,m);
   a1:=normav(Vn1,n);a2:=a/a1;
   b:=abs(1-sqr(a2));fdb:=10*ln(b+0.0000000001)/ln(10.0);
Dispose(Enm);
end;
procedure znaksum(d:vector;n:integer;var m:Double);                    {4.26}
var
k1,k2,k,j  : integer;
p,q        : Double;
z          : complex;
a          : vector;
begin
   for j:=1 to (n-1) do begin
   q:=d[j].re*d[j+1].re;k1:=sign(q);p:=k1;k2:=indic(p);
   a[j].re:=k2; a[j].im:=0.0;
   end; k:=(n-1);summa(a,k,z);  m:=z.re;
end;
procedure factori(n:integer;var p:Double);                             {4.27}
var
i:integer;
begin
   if n=0 then p:=1;
   p:=1;
   for i:=1 to n do p:=p*i;
end;
procedure pinm(zn1:vector;n,i,m:integer;var qnim:complex);           {4.28}
var
k      :integer;
p      :complex;
begin
   p:=zn1[m];
   for k:=1 to (i-1) do begin ucv(p,zn1[m+k],p);
   end;qnim:=p;
end;
procedure polinom(cv:complex; a: vector; n:integer;var z:complex);   {4.30}
var
   i,k     :integer;
   p,p1,s  :complex;
   b,c     :vector;
begin
   for i:=1 to (n-1) do begin k:=(n-i); WcvS(cv,k,p);b[i]:=p;end;
   b[n].re:=1;b[n].im:=0.0;
   for i:=1 to n do begin c[i].re:=b[i].re;c[i].im:=-b[i].im;end;
   suv(a,c,n,p);WcvS(cv,n,p1); scv(p,p1,s); z:=s;
end;
procedure polinomp(cv:complex; a: vector; n,m:integer;var z:complex);{4.31}
var
   i,k,n1,ni,n1i                    : integer;
   p,p1,s,p2,s1                     : complex;
   bim,b0m,bn1m,d1,d2,d3,d4         : Double;
   b,c,an1                          : vector;
begin
   n1:=n-m;factori(n,d1);factori(n1,d2);b0m:=d1/d2;
   for i:=1 to (n1-1) do begin k:=(n1-i); WcvS(cv,k,p);
   ni:=n-i;n1i:=n1-i;factori(ni,d3);factori(n1i,d4);bim:=d3/d4;
   ucvs(p,bim,b[i]);end;
   factori(m,bn1m);
   b[n1].re:=bn1m;b[n1].im:=0.0;
   for i:=1 to n1 do begin c[i].re:=b[i].re;c[i].im:=-b[i].im;
   an1[i]:=a[i];end;
   suv(an1,c,n1,s1);WcvS(cv,n1,p1);
   ucvs(p1,b0m,p2); scv(s1,p2,s); z:=s;
end;
procedure HF(Knm :matrix;n :integer; var d:vector);                  {4.32}
var
i,j,k ,m           :integer;
a                  :Double;
p                  :complex;
Mp,Mpr,Mde,Oknm    :^matrix;
W,Vpr              :vector;
begin
   New(Mp); New(Mpr); New(Mde); New(Oknm);

   BRI(n,Mde^);Mp^:=Mde^;m:=n;
   for k:=1 to n do begin
   ukm(Knm,MP^,n,Mpr^);Spur(Mpr^,n,p);a:=-1/k;ucvs(p,a,W[k]);
   uMcv(W[k],Mde^,n,m,Oknm^);sM(Mpr^,Oknm^,n,m,Mp^);
   end;
   for i:=1 to n do begin d[i]:=W[i];end;

   Dispose(Mp); Dispose(Mpr); Dispose(Mde);  Dispose(Oknm);
end;
procedure omHF(Knm :matrix;n :integer; var om:matrix);                  {4.32}
var
i,j,k              :integer;
a                  :Double;
p,c                :complex;
Mp,Mpr,Mde,Oknm,b  :^matrix;
W,Vpr,d            :vector;
begin

New(Mp); New(Mpr); New(Mde); New(Oknm);

   BRI(n,Mde^);  Mp^:=Mde^;
   for k:=1 to (n-1) do begin
     ukm(Knm,Mp^,n,Mpr^);  Spur(Mpr^,n,p);
     a:=-1/k;   ucvs(p,a,W[k]);
     uMcv(W[k],Mde^,n,n,Oknm^);   sM(Mpr^,Oknm^,n,n,Mp^);
   end;
   Dispose(Oknm);

   New(b);
   b^:=Mp^;
   ukm(Knm,b^,n,Mpr^);  Spur(Mpr^,n,p);  a:=1/n;  ucvs(p,a,c);
   p.re:=1;   p.im:=0.0;
   dcv(p,c,c);uMcv(c,b^,n,n,om);

   Dispose(Mp); Dispose(Mpr); Dispose(Mde);
   Dispose(b);
end;
procedure epsoksF(a:matrix;n,s:integer;var eps:Double);
var
b,c   :^matrix;
q1,q2   :Double;
begin
  New(b);  New(c);
  wms(a,n,s,a);omHF(a,n,b^);ukm(a,b^,n,a);
  BRI(n,c^);rM(a,c^,n,n,b^);
   q1:=normaM(b^,n,n);q2:=normaM(c^,n,n);
      if q2<1.0e-13 then eps:=q1 else
   eps:=q1/q2;
  Dispose(b);  Dispose(c);
end;
(*
procedure HFM(Knn:matrix;n:integer;z:complex;var d:vector;var bnn:matrix);
var
i,j,k ,m,nk ,n1                   :integer;
a                                 :Double;
p,znk                             :complex;
Mp,Mpr,Mde,Oknm,bnnk,pnn,bn1,An   :matrix;
W,Vpr                             :vector;
begin
   BRI(n,Mde);Mp:=Mde;m:=n;SIRM(n,m,pnn);  n1:=n-1;
   for k:=1 to n1 do begin
   nk:=n1-k;
   ukm(Knn,MP,n,Mpr);Spur(Mpr,n,p);a:=-1/k;ucvs(p,a,W[k]);
   uMcv(W[k],Mde,n,m,Oknm);sM(Mpr,Oknm,n,m,Mp);
   WcvS(z,nk,znk);uMcv(znk,Mp,n,m,bnnk);
   sM(pnn,bnnk,n,m,pnn);
   end;bn1:=mp; An:=pnn;
   ukm(Knn,bn1,n,Mpr);Spur(Mpr,n,p);a:=-1/n;ucvs(p,a,W[n]);
   wcvS(z,n1,p);uMcv(p,Mde,n,m,Mp);sM(An,Mp,n,m,bnn);
   for i:=1 to n do begin d[i]:=W[i];end;
end;

*)
function Gauss(mo,sigma: Double):Double;
{ Вычисление случайной величины, распределенной по     }
{ нормальному закону.                                  }
{ mo - среднее,  sigma - СКО                           }
VAR
  a,b,r,sq  : Double;
BEGIN
  repeat
    a:=2*Random - 1;
    b:=2*Random - 1;
    r:=sqr(a) + sqr(b)
  until (r<1);
  sq:=Sqrt(-2*Ln(r)/r);
  Gauss:=mo + sigma*a*sq
END;



    {************ 5.Special function (iteration methods)*********}
procedure savzH(Knn:matrix;n,st:integer;eps:Double;var Msv:matrix;var Vsz:vector);
label 1;                                                              {5.1}
var
  Pm,Knms,Pms,Knm,Msvs,ann                    :   ^matrix;
  Pv,Pvs,H0,H1,V0,V1,Vk,Vks,Vszp,Vszps,Vpr,d  :   vector;
  i,j,l,n1                                    :   integer;
  pr,norm,del,del1,a,s1                       :   Double;
  lam0,lam1,lams0,lams1,p,vc,pc,pol,sp,sir    :   complex;
begin
  New(Pm); New(Knms); New(Pms);
  New(Knm); New(Msvs); New(ann);

  s1:=1/st; WmS(Knn,n,st,Knn);
  BRI(n,Pms^); SPUR(Knn,n,sp); sir.re:=0.0;sir.im:=0.0;
 { write('Reg. par. => ');readln(pr);
  writeln(f,'Reg.par.=>',pr:2:3); } pr:=1.0;
  lams1.re:=pr;lams1.im:=0.0;uMcv(lams1,Pms^,n,n,Knms^);
  sM(Knn,Knms^,n,n,Knm^);
  {s1:=1/st; WmS(Knm,n,st,Knm);}
{  HF(Knm,n,d);}
  n1:=n-1;  { n1:=4; }
  for i:=1 to n do begin
  V0[i].re:=i*sin(i*i+1);V0[i].im:=0.0;
  end;
  for l:=1 to n1 do begin
    for i:=1 to n do for j:=1 to n do begin
      Pm^[i,j]:=Knm^[i,j];
    end;
{    for i:=1 to n do begin H0[i].re:=i*i; H0[i].im:=0.0; end;}
    Wvector(Pm^,n,n,1,H0);
    lam0.re:=0.0; lam0.im:=0.0; j:=0;
    repeat
      j:=j+1;
    {  if keypressed then goto 1; }
      if j>200 then goto 1;
      umv(Pm^,H0,n,Pv);
      norm:=normav(Pv,n);
      if norm<1.e-9 then begin lam1:=sir; ev(H0,n,H1); end;
      for i:=1 to n do begin H1[i].re:=Pv[i].re/norm; H1[i].im:=Pv[i].im/norm; end;
      umv(Pm^,H1,n,Vk); suv(Vk,H1,n,lam1);
    {  polinom(lam1,d,n,pol);}
     epsAqh(Pm^,H1,n,lam1,a);del:=a;
{     del:=abs(lam1.re-lam0.re);}
     {del:=sqrt(sqr(lam1.re-lam0.re)+sqr(lam1.im-lam0.im));}
    { if del1>eps1 then del:=del1 else
     del:=sqrt(sqr(pol.re)+sqr(pol.im));}
     { del:=del+sqr(lams1.re-lams0.re)+sqr(lams1.im-lams0.im);}
      for i:=1 to n do begin H0[i]:=H1[i]; end;
      lam0:=lam1;
    until(del<eps);
    1: writeln('Ki=> ',j:7); {writeln(f,'Ki=> ',j:7);}
    Vsz[l].re:=lam1.re-pr; Vsz[l].im:=lam1.im;Vszp[l]:=lam1;
    {WcvPS(lam1,s1,lam1);
    Vsz[l].re:=lam1.re-pr; Vsz[l].im:=lam1.im;}
    for i:=1 to n do begin Msv[i,l]:=H1[i];
      Pv[i].re:=Msv[i,l].re;Pv[i].im:=-Msv[i,l].im;
    end;
    for i:=1 to n do for j:=1 to n do begin
      ucv(Pv[j],H1[i],lam0);ucv(lam0,Vszp[l],lam1);
      rcv(Pm^[i,j],lam1,Knm^[i,j]);
    end;
  end;
  for l:=1 to n1 do begin V1[l]:=Vsz[l];end;
  summa(V1,n1,vc);rcv(sp,vc,Vsz[n]);
  for i:=1 to n do begin for j:=1 to n1 do begin
  Msvs^[i,j]:=Msv[i,j];end;end;
  for i:=1 to n do begin Msvs^[i,n]:=V0[i];end;
  for i:=1 to n1 do begin Vk[i].re:=1;Vk[i].im:=0.0;end;
  Vk[n].re:=0.0;Vk[n].im:=0.0;
  sintezM1(Vk,Msvs^,n,Pm^);rM(Pms^,PM^,n,n,ann^);
  umv(ann^,V0,n,V1);eV(V1,n,H0);
  for i:=1 to n do begin Msv[i,n]:=H0[i];end;
  for i:=1 to n do begin WcvPS(Vsz[i],s1,Vsz[i]);end;

  Dispose(Pm); Dispose(Knms); Dispose(Pms);
  Dispose(Knm); Dispose(Msvs); Dispose(ann);
end;

procedure savzStat(Knn:matrix;n,st:integer;eps:Double;
                   var Msv:matrix;var Vsz:vector);
{ Процедура вычисления st собственных чисел и векторов матрицы  }
{ Используется при проведении статистических испытаний          }
{ Число итераций не более 200                                   }
label 1;                                                              {5.1}
var
  Ann,Bnn              :   ^matrix;
  Pv,H0,H1,V0,Vszp     :   vector;
  i,j,l,n1             :   integer;
  pr,norm,del          :   Double;
  lam0,lam1,sp         :   complex;
begin
  New(Ann);
  New(Bnn);

  SPUR(Knn,n,sp);
  pr:=1.0;
  for i:=1 to n do for j:=1 to n do
  begin
       Bnn^[i,j].re:=Knn[i,j].re;
       Bnn^[i,j].im:=Knn[i,j].im;
       If i=j Then Bnn^[i,j].re:=Bnn^[i,j].re+1;
  end;
  n1:=st;  { n1:=4; }
  for i:=1 to n do begin
      V0[i].re:=i*sin(i*i+1);
      V0[i].im:=0.0;
  end;
  for l:=1 to n1 do begin
    for i:=1 to n do for j:=1 to n do begin
      Ann^[i,j]:=Bnn^[i,j];
    end;
    Wvector(Ann^,n,n,1,H0);
    lam0.re:=0.0; lam0.im:=0.0;
    j:=0;
    repeat
       j:=j+1;
    {  if keypressed then goto 1; }
       if j>200 then begin
          Lcrl[l]:=Lcrl[l]+1;
          goto 1;
       end;
       umv(Ann^,H0,n,Pv);
       norm:=normav(Pv,n);
       if norm<1.e-9 then begin
          ev(H0,n,H1);
       end;
       for i:=1 to n do begin
           H1[i].re:=Pv[i].re/norm;
           H1[i].im:=Pv[i].im/norm;
       end;
       umv(Ann^,H1,n,Pv);
       suv(Pv,H1,n,lam1);
       epsAqh(Ann^,H1,n,lam1,del);
       for i:=1 to n do H0[i]:=H1[i];
       lam0:=lam1;
    until(del<eps);
    1:
    Lit[l]:=j;
{    writeln('Ki=> ',j:7);}
    Vsz[l].re:=lam1.re-pr; Vsz[l].im:=lam1.im;
    Vszp[l]:=lam1;
    for i:=1 to n do begin Msv[i,l]:=H1[i];
      Pv[i].re:=Msv[i,l].re;Pv[i].im:=-Msv[i,l].im;
    end;
    for i:=1 to n do for j:=1 to n do begin
      ucv(Pv[j],H1[i],lam0);
      ucv(lam0,Vszp[l],lam1);
      rcv(Ann^[i,j],lam1,Bnn^[i,j]);
    end;
  end;
  for l:=1 to n1 do begin Pv[l]:=Vsz[l];end;
  summa(Pv,n1,Lam0);rcv(sp,lam0,Vsz[n]);
  for i:=1 to n do begin for j:=1 to n1 do begin
  Bnn^[i,j]:=Msv[i,j];end;end;
  for i:=1 to n do Bnn^[i,n]:=V0[i];
  for i:=1 to n1 do begin
      Pv[i].re:=1;
      Pv[i].im:=0.0;
  end;
  Pv[n].re:=0.0;  Pv[n].im:=0.0;
  sintezM1(Pv,Bnn^,n,Ann^);
{  rM(Anns^,Ann^,n,n,Bnn^);}
  for i:=1 to n do for j:=1 to n do
  begin
       Bnn^[i,j].re:=-Ann^[i,j].re;
       Bnn^[i,j].im:=-Ann^[i,j].im;
       If i=j Then Bnn^[i,j].re:=Bnn^[i,j].re+1;
  end;
  umv(Bnn^,V0,n,Pv);
  eV(Pv,n,H0);
  for i:=1 to n do begin Msv[i,n]:=H0[i];end;

  Dispose(Ann);
  Dispose(Bnn);
end;

procedure savzVAG(ann:matrix;n,st:integer;eps:Double;pr :complex;var Msv,Msvs:matrix;var Vsz:vector);
label 1,7;                                                              {5.2}
var
  Pm,Pms,Knm,Knms,bnn,cnn                         :   ^matrix;
  Pv,Pvs,H0,H1,V0,V1,Vk,Vks,Vszp,Vszps,Vszs :   vector;
  i,j,l                                           :   integer;
  norm,del,a,as,q,qs,s1                        :   Double;
  lam0,lam1,lams0,lams1,p,vc,pc,pol,z0,z1,z2,sir  :   complex;
begin
  New(Pm); New(Knms); New(Pms);
  New(Knm); New(Bnn); New(Cnn);

  sir.re:=0.0;sir.im:=0.0;
  z1.re:=0.5;z1.im:=0.0;z2.re:=0.0;z2.im:=-0.5;{Mhc(ann,n,n,bnn);}
  movz(ann,n,bnn^);sM(ann,bnn^,n,n,Knm^);rM(ann,bnn^,n,n,cnn^);
  uMcv(z1,Knm^,n,n,Knm^);uMcv(z2,cnn^,n,n,cnn^);
  for i:=1 to n do begin Knm^[i,i].re:=Knm^[i,i].re+pr.re;
  Knm^[i,i].im:=Knm^[i,i].im+pr.im;
  end;
  WmS(Knm^,n,st,Knm^);{ WmS(cnn,n,st,cnn);}
    for i:=1 to n do for j:=1 to n do begin
      Knms^[i,j].re:=Knm^[j,i].re; Knms^[i,j].im:=-Knm^[j,i].im;
    end;
{  HF(Knm,n,d);}
  for l:=1 to n do begin
    for i:=1 to n do for j:=1 to n do begin
      Pm^[i,j]:=Knm^[i,j]; Pms^[i,j]:=Knms^[i,j];
    end;
  writeln('matrix Pm ');
 { writeln(f,'matrix Pm '); }
  for i:=1 to n do begin for j:=1 to n do begin
     write('   ',Pm^[i,j].re,'   ',Pm^[i,j].im);
  {   write(f,'   ',Pm[i,j].re,'   ',Pm[i,j].im); } end;
      writeln;  { writeln(f);  }
   end;
   writeln('matrix Pms ');
 {  writeln(f,'matrix Pms '); }
  for i:=1 to n do begin for j:=1 to n do begin
     write('   ',Pms^[i,j].re,'   ',Pms^[i,j].im);
   {  write(f,'   ',Pms[i,j].re,'   ',Pms[i,j].im);}  end;
     writeln;  {writeln(f); }
   end;
{    for i:=1 to n do begin H0[i].re:=i*i; H0[i].im:=0.0; V0[i]:=H0[i]; end;}
    Wvector(Pms^,n,n,1,V0);Wvector(Pm^,n,n,1,H0);
 {   writeln('vector V0.re    V0.im ');
    writeln(f,'vector V0.re    V0.im ');
    for i:=1 to n do begin
        writeln('   ',V0[i].re,'  ',V0[i].im);
        writeln(f,'   ',V0[i].re,'  ',V0[i].im);
    end;
    writeln('vector H0.re    H0.im ');
    writeln(f,'vector H0.re    H0.im ');
    for i:=1 to n do begin
        writeln('   ',H0[i].re,'  ',H0[i].im);
        writeln(f,'   ',H0[i].re,'  ',H0[i].im);
    end;}
    lam0.re:=0.0; lams0.re:=0.0;lam0.im:=0.0; lams0.im:=0.0;   j:=0;
    repeat
      j:=j+1;
   {   if keypressed then goto 1; }
      umv(Pm^,H0,n,Pv);
      norm:=normav(Pv,n);
      if norm<1.e-9 then begin lam1:=sir;ev(H0,n,H1);goto 7; end;
      for i:=1 to n do begin H1[i].re:=Pv[i].re/norm; H1[i].im:=Pv[i].im/norm; end;
      umv(Pm^,H1,n,Vk);
      {q:=normav(Vk,n);
      if q=0.0 then  begin Vsz[l].re:=-pr;Vsz[l].im:=0.0;
      ZvectorM(H1,n,l,Msv);end;}
      suv(Vk,H1,n,lam1);
      umv(Pms^,V0,n,Pvs); norm:=normav(Pvs,n);
      if norm<1.e-9 then begin lams1:=sir;ev(V0,n,V1);goto 7; end;
      for i:=1 to n do begin V1[i].re:=Pvs[i].re/norm; V1[i].im:=Pvs[i].im/norm; end;
      umv(Pms^,V1,n,Vks);
      {qs:=normav(Vks,n);
      if qs=0.0 then begin Vszs[l].re:=-pr;Vszs[l].im:=0.0;
      ZvectorM(V1,n,l,Msvs);end;}
      suv(Vks,V1,n,lams1);
    {  polinom(lam1,d,n,pol);
      del:=sqrt(sqr(pol.re)+sqr(pol.im));}
{      epsAqh(Pm,H1,n,lam1,del);}
      {epsAqh(Pms,V1,n,lams1,as);
      del:=sqrt(sqr(a)+sqr(as)); }
      del:=sqrt(sqr(lam1.re-lam0.re)+sqr(lam1.im-lam0.im));
     { del:=del+sqr(lams1.re-lams0.re)+sqr(lams1.im-lams0.im);}
      for i:=1 to n do begin H0[i]:=H1[i]; V0[i]:=V1[i]; end;
7:    lam0:=lam1; lams0:=lams1;
    until(del<eps);
    1: writeln('Ki=> ',j:7); {writeln(f,'Ki=> ',j:7);}
    Vszp[l]:=lam1;Vszps[l]:=lams1;
    writeln('lam1 ',lam1.re:3:3,'    ',lam1.im:3:3);
 {   writeln(f,'lam1 ',lam1.re:3:3,'    ',lam1.im:3:3);   }
    writeln('lams1 ',lams1.re:3:3,'    ',lams1.im:3:3);
{    writeln(f,'lams1 ',lams1.re:3:3,'    ',lams1.im:3:3);  }
{    Vsz[l].re:=lam1.re-pr; Vsz[l].im:=lam1.im;
    Vszs[l].re:=lams1.re-pr;Vszs[l].im:=lams1.im;}
    Vsz[l]:=lam1;Vszs[l]:=lams1;
    for i:=1 to n do Msv[i,l]:=H1[i];
    suv(V1,H1,n,vc);pc.im:=-vc.im; norm:=sqr(vc.re)+sqr(vc.im);
    pc.re:=vc.re;
    for i:=1 to n do begin
      ucv(V1[i],pc,p);
      Msvs[i,l].re:=p.re/norm; Msvs[i,l].im:=p.im/norm;  {*****}
      V1[i]:=Msvs[i,l];
      Pv[i].re:=Msv[i,l].re;Pv[i].im:=-Msv[i,l].im;
      Pvs[i].re:=Msvs[i,l].re; Pvs[i].im:=-Msvs[i,l].im;
    end;
    for i:=1 to n do for j:=1 to n do begin
      ucv(Pvs[j],H1[i],lam0);ucv(lam0,Vszp[l],lam1);
      ucv(Pv[j],V1[i],lams0);ucv(lams0,Vszps[l],lams1);
      rcv(Pm^[i,j],lam1,Knm^[i,j]);
      rcv(Pms^[i,j],lams1,Knms^[i,j]);
    end;
  end;
  for j:=1 to n do begin
  a:=Vsz[j].re;Vsz[j].im:=0.0;
  WrvOS(a,st,q);Vsz[j].re:=q-pr.re;end;
  for i:=1 to n do begin
  Wvector(Msv,n,n,i,H1);umv(cnn^,H1,n,V1);suv(V1,H1,n,Vszs[i]);
  Vsz[i].im:=Vszs[i].re;Vsz[i].re:=Vsz[i].re;end;
{  for i:=1 to n do begin WcvPS(Vsz[i],s1,Vsz[i]);end;}

  Dispose(Pm); Dispose(Knms); Dispose(Pms);
  Dispose(Knm); Dispose(Bnn); Dispose(Cnn);
end;
procedure  anPELvag(hnm:matrix;n,m,st1:integer;D1,eps1:Double;pr :complex;var qm1,am1:vector);
var                                                                             {5.3''}
amm,bmm,cmm,oamm,pmm : ^matrix;
q,qt                 : Double;
i,j,k                : integer;
zm1,Vsz,Vszs         : vector;
ce                   : expform;
Msv,Msvs             : ^matrix;
begin
   New(amm);  New(bmm); New(cmm); New(oamm); New(pmm);
   New(Msv);  New(Msvs);

   writeln('Матрица собственных векторов N*M');
 {  writeln(f,'Матрица собственных векторов N*M');  }
     for i:=1 to n do begin for j:=1 to m do begin
       write('  ',hnm[i,j].re:2:3,'   ',hnm[i,j].im:2:3);
     {  write(f,'  ',hnm[i,j].re:2:3,'   ',hnm[i,j].im:2:3); }
       end;
       writeln;  {writeln(f);   }
   end;
   for i:=1 to m do begin for j:=1 to m do begin
   amm^[i,j]:=hnm[i,j];bmm^[i,j]:=hnm[i+1,j];end;end;
   writeln('Матрица обратная M*M');
{   writeln(f,'Матрица обратная M*M');  }
   movz(amm^,m,oamm^);
   for i:=1 to m do begin
     for j:=1 to m do begin
       write('  ',oamm^[i,j].re:2:2,'   ',oamm^[i,j].im:2:2);
     {  write(f,'  ',oamm[i,j].re:2:2,'   ',oamm[i,j].im:2:2); }
       end;
       writeln;  {writeln(f);  }
   end;
   ukm(oamm^,bmm^,m,pmm^);
   writeln('произведение матриц');
 {  writeln(f,'произведение матриц');    }
   for i:=1 to m do begin for j:=1 to m do begin
       write('  ',pmm^[i,j].re:2:3,'   ',pmm^[i,j].im:2:3);
  {     write(f,'  ',pmm[i,j].re:2:3,'   ',pmm[i,j].im:2:3);    }
       end;
       writeln;  {writeln(f);  }
   end;
   savzVAG(pmm^,m,st1,eps1,pr,Msv^,Msvs^,Vsz);
   for i:=1 to m do begin
     writeln('  ',Vsz[i].re:2:1,'   ',Vsz[i].im:2:1);
  {   writeln(f,'  ',Vsz[i].re:2:1,'   ',Vsz[i].im:2:1);    }
   end;
   for k:=1 to m do begin
    pce(Vsz[k],ce);
    qt:=ce.f/2/pi/D1;
    q:=180.0/pi*arctan(qt/sqrt(1-sqr(qt)));
    qm1[k].re:=q; qm1[k].im:=0.0;
    am1[k].re:=ce.a;am1[k].im:=0.0;
   end;
   Dispose(amm);  Dispose(bmm); Dispose(cmm); Dispose(oamm); Dispose(pmm);
   Dispose(Msv);  Dispose(Msvs);
end;

end.
