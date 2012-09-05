unit DeclPasha;

interface

uses
  Sysutils, Classes, Zveno, Math, Unit_SpatialWave,
  Unit_ConverterCoordinate, Unit_Scheme, Dialogs;

const
  Caption1 = 'Adaptive DTS - Блок задания пространственной качки';
  Caption3 = 'Adaptive DTS - Привод KУ';
  Caption4 = 'Adaptive DTS - Привод УM';
  Caption7 = 'Adaptive DTS - Преобразователь координат 1';
  two_pi = 2*pi;
  pi_180 = pi/180;
  CountPixelInGraphic = 270000;
  //CountPixelInGraphic = 75;
  GrTakt   = 25;

type
  TEModelParameters = packed record
    Betta12               : Extended; // Азмиут на абонента № 2, рад
    Betta21               : Extended; // Азмиут на абонента № 1, рад
    Distance              : LongInt;  // Удаление абонента № 2, м
    DeltaBetta            : Extended; // Уровень нечувствительности антенны в режиме автосопровождения, рад
    Frequency             : LongInt;  // Частота следования импульсов
    Tdiscr                : Extended; // Такт дискретизации для Паши
    TdiscrToBlockKorrec   : Extended; // Такт дискретизации для Жени (блок керрекции)
    AmountPrivodCalc      : LongInt;  // Число импульсов для Паши
    //OffsetPercent         : Word;     // Процент от выделенного сигнала ошибки (для авт. захвата)
    ImpulseAmount         : LongInt;  // Число импульсов (для автомата захвата)
    ImpulsiveBlankAmount  : LongInt;  // Число пропусков импульсов для сброса
    ImpulseAmplitude      : LongInt;  // Амплитуда импульса, mB
    LevelDb               : Extended; // Порог в децибелах
    LevelVolt             : Extended; // Порого в mВ

    RandomMax             : LongInt;  // Temp
    K                     : Extended; // Коэффициент для УВСО
  end; //TEModelParameters
  PEModelParameters = ^TEModelParameters;

  // Базовый абстрактный клаас для Паши
  TPBakClass = class
  protected
    FpModelParams      : PEModelParameters;
    FpDiscr            : PExtended;
    FreqEvgeny         : PExtended;
    FTimeForImpuls     : Extended;
    FCurrentStabTime   : Extended;

  public
    constructor CreateNew (pModelParams : Pointer); virtual;
  end; // TPBakClass

  // ---- Класс пространственной качки ----------
  // Детерминированная
  TDeterm = record
    a,
    alfa,
    Omega,
    fi       : Extended;
   end; //TDeterm

  // Случайная
  TPSluch = record
    a,
    mju,
    lambda  : Extended;
  end; //TPSluch

  // Импульсная
  TImpuls = record
    T1,
    T2,
    A    : Extended;
  end; //TImpuls
  //----------------------------
  //----------------------------
  //----------------------------
  //----------------------------
  GrArr        = ^GraphicArray;
  GraphicArray = array [0..0] of Single;

  PGraphicArray = ^TGraphicArray;
  TGraphicArray = record
     PrGr       : GrArr;
     CurGr      : TList;
     Max, Min   : Single;
  end;
  //----------------------------
  //----------------------------
  //----------------------------
  //----------------------------

  //---------------------
  TPBlokProstranstvennojKachki = class (TPBakClass)
  private
    s            : Extended;
    b            : Extended;
    r            : Extended;
    bd           : Extended;
    a1           : Extended;
    a2           : Extended;
    alfa1        : Extended;
    alfa         : Extended;
    alfa0        : Extended;
    b1           : Extended;
    b2           : Extended;
    m            : Extended;

    xk_1         : Extended;
    xk_2         : Extended;
    ix           : LongInt;
    wk           : Extended;
    wk_1         : Extended;

  public
    SluchEnable   : Boolean;
    ImpulsEnable  : Boolean;
    DetermEnable  : Boolean;
    Sluch         : TPSluch;
    Determ        : array [0..2] of TDeterm;
    Impuls        : array [0..5] of TImpuls;
    GrArray       : PGraphicArray;

    Result        : Extended; // - Выход блока

    procedure Init;
    procedure Run(FCurrentStabTime : extended);
    constructor CreateNew(pModelParams  : Pointer); override;
    destructor  Destroy; override;
  end; //TBlokProstranstvennojKachki


  // ---- Блок корекции -----
  TBlockKorektirovki = class  (TPBakClass)
    Integral         : TIntegral;
    AperiodicForce1  : TAperiodForce;
    AperiodicForce2  : TAperiodForce;
    FpModelParams    : PEModelParameters;
    procedure Init;
    Function Next(Input : extended): extended;
    constructor CreateNew(pModelParams  : Pointer); override;
    destructor  Destroy; override;
  end;

  // ---- Класс, отвечающий за преобразователь координат 1 ---------
  TPPreobrazovatelCoordinat1 = class (TPBakClass)
  protected
    InputFromKR1                 : Extended; //------ Вход №1 ---
    InputFromBZPK                : Extended; //------ Вход №2 ---

  public
    GrArray1                     : PGraphicArray;
    GrArray2                     : PGraphicArray;
    C0_k, C1_k, C2_k, Omega_k    : extended;
    Eps0, Eps1, Eps2, Omega_Eps  : extended;
    Fi1, Fi_k1                   : extended;
    Fi2, Fi_k2                   : extended;
    q_k                          : extended; // ----- Выход ---
    Old                          : Extended;
    q_c                          : extended;
    Riskanie                     : extended; // ----- Рыскание корабля --------
    K_k                          : extended; // ----- Текущее значение КУРСА ---
    Eps_C                        : extended;
    Eps_k                        : extended; // ----- Выход ---
    constructor CreateNew (pModelParams : Pointer); override;
    destructor  Destroy; override;
    procedure Init;
    procedure Run (FCurrentStabTime,P1_nel, Ksi, QQ_k : extended);
  end; // TPreobrazovatelCoordinat1

  // ---- Класс отвечающий за преобразователь координат 2 ---------
  TPPreobrazovatelCoordinat2 = class (TPBakClass)
  protected

  public
    P_ca        : extended;  //--- Выход ---
    q_ca        : extended;
    eps_ca      : extended;
    Kappa       : extended;
    Old         : Extended;
    GrArray1    : PGraphicArray;
    GrArray2    : PGraphicArray;
    GrArray3    : PGraphicArray;

    procedure Init;
    procedure Run (ksi, QQ_k, q_c, K_k, Riskanie, q_ka, eps_ka : extended);
    constructor CreateNew (pModelParams: Pointer); override;
    destructor  Destroy; override;
  end;

  // ---- Собственно привод ---------------
  TPPrivod = class (TPBakClass)
  protected
    Descriptor              : Byte;
    Power                   : Array [1..10] of TPower;
    Ogran                   : array [1..5] of TOgran;
    Aperiod                 : TAperiod;
    Integ                   : array [1..2] of TIntegral;
    Luft                    : TLuft;

    Diff                    : array [1..2] of TDiffer;

    Diff_1                  : array[-1..0] of extended;
    Temp_A8                 : Extended;

  public
    Result                  : Extended;
    a                       : array [1..9]  of Extended;
    ElementList             : TList;
    GrArrayOut              : PGraphicArray;
    GrArrayOshibka          : PGraphicArray;

    Temp1                   : extended;
    Oshibka                 : Extended;

    procedure Init;
    procedure Run (Count : LongInt; input_1 : Extended);
    constructor CreateNew (pModelParams : Pointer); override;
    destructor  Destroy; override;
  end; //TPrivod

  //***************************************
  //*********   Класс - Платформа  ********
  //***************************************
  TPPlatform = class (TPBakClass)
  protected
    FpModelParams    : PEModelParameters;  // n = FpModelParams^.AmountPrivodCalc
    TochkaPropuska   : Integer;

    function GetAnalogTime : Extended;
  public
    FPeleng             : Extended;
    Kachka_Ksi          : TPBlokProstranstvennojKachki;
    Kachka_Teta         : TPBlokProstranstvennojKachki;
    PC1                 : TPPreobrazovatelCoordinat1;
    PC2                 : TPPreobrazovatelCoordinat2;
    PrivodKU            : TPPrivod;
    PrivodUM            : TPPrivod;
    BK                  : TBlockKorektirovki;
    OldDiff             : Extended;
    CurrentCircle       : Integer;
    CurrentGraphicPoint : integer;
    Angle_Qk            : array [-1..0] of Extended;

    k_k_GrArray         : PGraphicArray;
    Riskanie_GrArray    : PGraphicArray;
    Eps_C_GrArray       : PGraphicArray;
    //--------
    procedure   Init;
    Function  Next(T1 : extended; Peleng : extended; n : Byte): extended;
    Procedure SetNewPointToGraphicArray(n : byte);
    constructor CreateNew (pModelParams  : Pointer); override;
    destructor  Destroy ; Override;
    procedure BZPKDlgParams;
    procedure PC1DlgParams;
    procedure PrivodUMDlgParams;
    procedure PrivodKUDlgParams;
    procedure ParamSetDefault1;
    procedure ParamSetDefault2;
    Procedure SetParamToGraphicNameWindow;
    Procedure GetMemory_GraphicArray;
    Procedure FreeMemory_GraphicArray;
    Procedure ClearMemory_GraphicArray;

//    property CurrentTime : Extended read FCurrentTime write FCurrentTime;
//    property AnalogTime : Extended read GetAnalogTime;
  end; // TStabilizer

var
  MinTime             : integer;
  CurrentGraphic      : PGraphicArray;

    Oldt1               : Extended;


implementation

uses Unit_GraphNameForm;


{ TPBakClass }
constructor TPBakClass.CreateNew (pModelParams : Pointer);
begin
  inherited Create;
  FpModelParams := pModelParams;
  FpDiscr := @FpModelParams.TDiscr;
  FreqEvgeny := @FpModelParams.Frequency;
  FTimeForImpuls := 0;
end;

{ TBlokProstranstvennojKachki }

constructor TPBlokProstranstvennojKachki.CreateNew (pModelParams : Pointer);
begin
  inherited CreateNew (pModelParams);
end;

destructor TPBlokProstranstvennojKachki.Destroy;
begin
  inherited Destroy;
end;

procedure TPBlokProstranstvennojKachki.Init;
begin

   s:= sqrt(Sluch.A);  {с.к.о.}
   b:= Sluch.Lambda; {преобладающая частота}
   m:= Sluch.mju;  {коэффициент затухания}

   {Коэффициенты рекуррентного уравнения}
   r:= exp(-m*FpModelParams^.Tdiscr);
   bd:= b*FpModelParams^.Tdiscr;
   a1:= 2.0*r*cos(bd);
   a2:= -r*r;

   alfa0:= r*(r*r-1.0)*cos(bd) + m/b*(1.0+r*r)*r*sin(bd);
   alfa1:= 1.0 - r*r*r*r -4.0*r*r*m/b*sin(bd)*cos(bd);
   alfa:= Sqrt((alfa1+Sqrt(alfa1*alfa1-4.0*alfa0*alfa0))/2.0);

   b1:= s*alfa;
   b2:= s*alfa0/alfa;

   xk_1:=0.0; xk_2:=0.0;  {Начальные значения}

   ix:=9699685+Random(10);         {Нач. значения для датчика сл.чисел}
//   ix:=9699691;         {Нач. значения для датчика сл.чисел}
   WhiteNoise (ix,wk_1);
   WhiteNoise (ix,wk);
end;

procedure TPBlokProstranstvennojKachki.Run(FCurrentStabTime : extended);
var res1 : Extended;
    res2 : Extended;
    res3 : Extended;
    i    : Byte;
begin
  res1:=0;
  res2:=0;
  res3:=0;
  //  ---------  Детерменированная качка -------------
  if DetermEnable then  begin
      res1:=   Determ[0].A*exp(  - Determ[0].alfa  * FCurrentStabTime)
                            * sin(Determ[0].Omega  * FCurrentStabTime *two_pi +Determ[0].fi*pi_180)
             + Determ[1].A*exp(  - Determ[1].alfa  * FCurrentStabTime)
                            * sin(Determ[1].Omega  * FCurrentStabTime *two_pi +Determ[1].fi*pi_180)
             + Determ[2].A*exp(  - Determ[2].alfa  * FCurrentStabTime)
                            * sin(Determ[2].Omega  * FCurrentStabTime *two_pi +Determ[2].fi*pi_180);
  end;
  //  ---------  Случайная качка -------------
  if SluchEnable  then  begin
       res2:= a1*xk_1 + a2*xk_2 + b1*wk + b2*wk_1;
       {Переприсвоение}
       xk_2:=xk_1; xk_1:=res2; wk_1:=wk;
       WhiteNoise (ix,wk);
  end;
  //  ------------ Импульсное возмущение --------
  if ImpulsEnable then begin
     if FTimeForImpuls > Impuls[5].t2 then
       FTimeForImpuls:=0;
     for i:=0 to 5 do
        with Impuls[i] do begin
          if  FTimeForImpuls <  t1                            then begin res3:=0; break end;
          if (FTimeForImpuls >= t1) and (FTimeForImpuls < t2) then begin res3:=a; break end;
          if (FTimeForImpuls >  t2) and (i=5)                 then begin FTimeForImpuls:= FTimeForImpuls - t2 end;
        end;
  end;
  FTimeForImpuls := FTimeForImpuls + FpModelParams^.Tdiscr;
  Result:=res1+res2+res3;
end;

{ TPreobrazovatelCoordinat1 }

constructor TPPreobrazovatelCoordinat1.CreateNew (pModelParams : Pointer);
begin
  inherited CreateNew (pModelParams);

end;

destructor TPPreobrazovatelCoordinat1.Destroy;
begin
  inherited Destroy;
end;

procedure TPPreobrazovatelCoordinat1.Init;
begin
  InputFromKR1   := 0;
  InputFromBZPK  := 0;
end;


procedure TransferAngelKursa(var Q1, Q2 : extended);
begin
  {----  Проверки на совпадание 90 .. -- .. 270 }
  if  Round(Q2*10000)=DegToRad(90)*10000  then
           Q2:=DegToRad(89.9999);
  if  Round(Q2*10000)=DegToRad(270)*10000 then
           Q2:=DegToRad(269.9999);

  if  Round(Q1*10000)=DegToRad(90)*10000  then
           Q1:=DegToRad(89.9999);
  if  Round(Q1*10000)=DegToRad(270)*10000 then
           Q1:=DegToRad(269.9999);


  //-----------------------------------
  {//   if (q2<0) and (q1>DegToRad(270)) then
  //         q2 := q2 + 2*pi
   if (Q1 > DegToRad(270)) and (Q1<DegToRad(360)) then
         Q2:=Q2+2*pi
   else if (q2<0) and (q1>pi) then
            q2 := q2 + pi
  //            q2 := q2 + 2*pi
        else if (Q1 > DegToRad(90))  and (Q1<DegToRad(270)) then
                Q2:=Q2+pi
             else if (Q1 > DegToRad(270)) and (Q1<DegToRad(360)) then
                     Q2:=Q2+2*pi;
                  //else if  Q2 >= DegToRad(360) then
                          //Q2:=Q2-2*pi;}


   //   q2 := q2 + 2*pi*n;
        if (q1 >=   pi/4) and (q1 < 3*pi/4) and (q2 < 0) then
            q2:=q2+pi
   else if (q1 >= 3*pi/4) and (q1 < 5*pi/4)              then
            q2:=q2+pi
   else if (q1 >= 5*pi/4) and (q1 < 7*pi/4) then
            //----
            if q2 > 0 then q2 := q2 +   pi
                      else q2 := q2 + 2*pi
            //----
   else if (q1 >= 7*pi/4) and (q1 < 2*pi) then
           q2:=q2 + 2*pi;

//   if  Q2 > 2*pi then
//           Q2:=Q2-2*pi;

end;

//-----------------------------
//  ksi     выход с блока "Качка"  //1
//  QQ_k    выход с блока "Качка"  //2
//--------------------------------
procedure TPPreobrazovatelCoordinat1.Run (FCurrentStabTime,P1_nel, Ksi, QQ_k: extended);
var
  t      : extended;
  Angle  : extended;
begin
  t:= FCurrentStabTime;

  {K_k      :=   C0_k + C1_k*t
              + C2_k * sin(Omega_k   *t*two_pi);

  Riskanie :=   fi1*sin(fi_k1 *t*two_pi)
              + fi2*sin(fi_k2 *t*two_pi);


  q_c      := P1_nel-(K_k+Riskanie);}

  Eps_c    := Eps0 + Eps1*t + Eps2 * sin(Omega_Eps *t*two_pi);
  q_c      := P1_nel{-(K_k+Riskanie)};


  Angle  := (cos(eps_C)*((cos(q_C)*Sin(Ksi)*Sin(QQ_k) + sin(q_c)*cos(QQ_k)) - sin(eps_c)*Cos(Ksi)*sin(QQ_k)))
            /
            ( cos(q_c)*cos(eps_C)*cos(ksi) + sin(eps_c)*sin(ksi));

  q_k   := ArcTan(Angle);
  TransferAngelKursa(Q_c, Q_k);
  eps_k := ArcSin(sin(eps_c)*cos(ksi)*cos(QQ_k) + cos(eps_c)*(sin(q_c)*sin(QQ_k) - cos(q_c)*sin(ksi)*cos(QQ_k) ));

end;

{ TPreobrazovatelCoordinat2 }

constructor TPPreobrazovatelCoordinat2.CreateNew (pModelParams: Pointer);
begin
  inherited CreateNew (pModelParams );
end;

destructor TPPreobrazovatelCoordinat2.Destroy;
begin
  inherited Destroy;
end;

procedure TPPreobrazovatelCoordinat2.Init;
begin

end;

//-----------------------------
//  QQ_k    выход с блока "Качка"
//  ksi     выход с блока "Качка"
//  q_ka    выход с блока "ПРИВОД КУ"
//  eps_ka  выход с блока "ПРИВОД УМ"
//  Kapa    выход с блока "ПРИВОД УМ"
//--------------------------------
procedure TPPreobrazovatelCoordinat2.Run(ksi, QQ_k, q_c, K_k, Riskanie, q_ka,
  eps_ka: extended);
var
  angle   : extended;
  a1      : extended;
  a2      : extended;
begin
  a1 := (cos(eps_ka)*sin(q_ka)*cos(QQ_k)+sin(eps_ka)*sin(QQ_k));
  a2 := (cos(eps_ka)*( cos(q_ka)*cos(ksi)+sin(q_ka)*sin(ksi)*sin(QQ_k))-sin(eps_ka)*sin(ksi)*cos(QQ_k));

  if abs(a2) <= 0.01 then
    if a2 > 0 then
            a2:=0.01
               else
               a2:=-0.01;
  angle := a1/a2;

  q_ca   := ArcTan(Angle);

  TransferAngelKursa(Q_ka, Q_ca);

  eps_ca := ArcSin(cos(eps_ka)*(cos(q_ka)*sin(ksi) - sin(q_ka)*cos(ksi)*sin(QQ_k))+sin(eps_ka)*cos(ksi)*cos(QQ_k));
  Kappa  := 1/(cos(eps_ka))*(sin(q_ka)*sin(ksi)*cos(QQ_k) + cos(q_ka)*sin(QQ_k));

  //P_ca   := q_ca + K_k + Riskanie;
  P_ca   := q_ca{ + K_k + Riskanie};
end;

{ TPrivod }

constructor TPPrivod.CreateNew (pModelParams : Pointer);
var
  i : byte;
begin
  inherited CreateNew (pModelParams);
  ElementList  := Tlist.Create;

  for i:=1 to 10 do Power[i] := TPower.Create;
  for i:=1 to 5  do Ogran[i] := TOgran.Create;
  Aperiod := TAperiod.Create;
  for i:=1 to 2 do Integ[i]:=TIntegral.Create;
  Luft    := TLuft.Create;
  for i:=1 to 2 do Diff[i]:=TDiffer.Create;

  for i:=1 to 10 do ElementList.Add(Power[i]);
  for i:=1 to 5  do ElementList.Add(Ogran[i]);
  ElementList.add(Aperiod);
  for i:=1 to 2 do ElementList.Add(Integ[i]);
  ElementList.Add(Luft);
  for i:=1 to 2 do ElementList.Add(Diff[i]);
end;

destructor TPPrivod.Destroy;
var
  i : byte;
begin
  for i:=2 Downto 1 do Diff[i].Free;
  Luft.Free;
  for i:=2 Downto 1 do Integ[i].Free;
  Aperiod.Free;
  for i:=5 Downto 1  do Ogran[i].Free;
  for i:=10 Downto 1 do Power[i].Free;

  ElementList.Free;
  inherited Destroy;
end;

procedure TPPrivod.Init;
var i : byte;
begin
  FillChar(a, SizeOf(a),0);
  Diff_1[-1]     := 0;
  Diff_1[ 0]     := 0;
  Temp_A8        := 0;
  for i:=0 to ElementList.Count-1 do
         TElement(ElementList.Items[i]).Init (@FpModelParams^.Tdiscr);
end;

Function diff_1_Run(input, Input_, T0 : extended):extended;
begin
 result := (Input-Input_)/t0;
end;

procedure TPPrivod.Run(Count : LongInt; input_1 : Extended);
begin
   a[7]:=a[5]*power[8].k;
   a[8]:=a[6]*power[9].k;
   a[9]:=diff[2].run(a[8])*power[10].k;

   {---------------}
   a[1] :=(Diff_1[0] - Diff_1[-1]) * FpModelParams^.Frequency;

//   a[1] := diff[1].run(input_1*power[1].k);
   Temp1   := a[1];


   Oshibka := a[8]+Input_1;
   a[2]:=Ogran[1].run(a[8]+Input_1)*Power[2].k;

   a[3]:=(a[1]+a[2])*power[3].k;
   a[4]:=Ogran[3].Run(Ogran[2].Run((a[3]+a[9])*power[4].k)*power[5].k);
   a[5]:=Ogran[5].Run(Integ[1].Run(Ogran[4].Run(Aperiod.Run(a[4]+a[7]))*power[6].k));
   a[6]:=Luft.Run(integ[2].Run(a[5]))*Power[7].k;


   //-------  Проверка сели или не сели на Упор ----------
   if descriptor = 2 then begin
      if a[6] >= DegToRad( 17.5) then a[6] := DegToRad( 17.5);
      if a[6] <= DegToRad(-17.5) then a[6] := DegToRad(-17.5);
   end;
   //------- Наш Выход звена --------
   Result:=a[6];
end;

{ TPPlatform }

constructor TPPlatform.CreateNew(pModelParams: Pointer);
begin
  inherited Create;
  FpModelParams := pModelParams;

  Kachka_Ksi  := TPBlokProstranstvennojKachki.CreateNew(FpModelParams);
  Kachka_Teta := TPBlokProstranstvennojKachki.CreateNew (FpModelParams);
  PC1         := TPPreobrazovatelCoordinat1.CreateNew (FpModelParams);
  PC2         := TPPreobrazovatelCoordinat2.CreateNew (FpModelParams);
  PrivodKU    := TPPrivod.CreateNew (FpModelParams);
  PrivodUM    := TPPrivod.CreateNew (FpModelParams);
  Bk          := TBlockKorektirovki.CreateNew (FpModelParams);

  GetMemory_GraphicArray
end;

destructor TPPlatform.Destroy;
begin
  FreeMemory_GraphicArray;

  Bk.Free;
  PrivodUM.Free;
  PrivodKU.Free;
  PC2.Free;
  PC1.Free;
  Kachka_Teta.Free;
  Kachka_Ksi.Free;

  inherited Destroy;
end;

procedure TPPlatform.Init;
begin
  MinTime              :=0;
  FCurrentStabTime     :=0;
  TochkaPropuska       :=0;
  CurrentGraphicPoint  :=0;
  CurrentCircle        :=0;
  Angle_Qk[-1]         :=2;
  Angle_Qk[0]          :=0;

  Kachka_Ksi .FTimeForImpuls := 0;
  Kachka_Teta.FTimeForImpuls := 0;

  GraphNameForm.Init;

  PrivodUM.Init;
  PrivodKU.Init;
  PC2.Init;
  PC1.Init;
  Kachka_Ksi.Init;
  Kachka_Teta.Init;
  BK.Init;

  ClearMemory_GraphicArray;
end;

procedure TPPlatform.BZPKDlgParams;
var
  Dlg : TForm_SpatialWave;
begin
  Dlg:=TForm_SpatialWave.Create(nil);
  try
    Dlg.SetParametrs(Caption1, Kachka_Teta, Kachka_Ksi);
    Dlg.ShowModal;
  finally  Dlg.Free;  end;
end;

procedure TPPlatform.PC1DlgParams;
var
   Dlg : TForm_ConverterCoordinate;
begin
  Dlg:=TForm_ConverterCoordinate.Create(nil);
  try
    Dlg.SetParametrs(Caption7, PC1);
    Dlg.ShowModal;
  finally  Dlg.Free;  end;
end;

procedure TPPlatform.PrivodKUDlgParams;
var
  Dlg : TForm_Scheme;
begin
  Dlg:=TForm_Scheme.Create(nil);
  try
    Dlg.SetParametrs(Caption3, PrivodKU);
    Dlg.ShowModal;
  finally  Dlg.Free;  end;
end;

procedure TPPlatform.PrivodUMDlgParams;
var
  Dlg : TForm_Scheme;
begin
  Dlg:=TForm_Scheme.Create(nil);
  try
    Dlg.SetParametrs(Caption4, PrivodUM);
    Dlg.ShowModal;
  finally  Dlg.Free;  end;
end;


function TPPlatform.GetAnalogTime : Extended;
begin
  Result := FpModelParams^.Tdiscr;
end;

procedure TPPlatform.ParamSetDefault1;
begin
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  with Kachka_Ksi do begin
    //------------ Детерменированная качка ------------------
    DetermEnable := True;
//    DetermEnable := False;
    Determ[0].a     := 0.1;    Determ[1].a    := 0.1 ;   Determ[2].a     := 0.1;
    Determ[0].alfa  := 0.0001; Determ[1].alfa  := 0.0001;  Determ[2].alfa  := 0.0001;
    Determ[0].Omega := 0.14;   Determ[1].Omega := 0.24;    Determ[2].Omega := 0.34;
    Determ[0].fi    := 0;      Determ[1].fi    := 0;       Determ[2].fi    := 0;
    //------------ Случайная качка ------------------
    SluchEnable  := False;
    Sluch.a      := 0.35;
    Sluch.Lambda := 0.3 ;
    Sluch.mju    := 0.21 * Sluch.Lambda;
    //------------ Возмущение импульс ------------------
    ImpulsEnable := False;
    Impuls[0].a     := 0.4;  Impuls[1].a     := 0.3;  Impuls[2].a     := -0.3;
    Impuls[0].T1    := 1;    Impuls[1].T1    := 3;    Impuls[2].T1    := 7;
    Impuls[0].T2    := 2;    Impuls[1].T2    := 4.8;  Impuls[2].T2    := 7.5;

    Impuls[3].a     := -0.2; Impuls[4].a     := 0.4;  Impuls[5].a     := 0.1;
    Impuls[3].T1    := 8;    Impuls[4].T1    := 10;   Impuls[5].T1    := 12.8;
    Impuls[3].T2    := 9;    Impuls[4].T2    := 11;   Impuls[5].T2    := 14;
  end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  with Kachka_Teta do begin
    //------------ Детерменированная качка ------------------
    DetermEnable := true;
//    DetermEnable := False;
    Determ[0].a     := 0.1;    Determ[1].a    := 0.1 ;   Determ[2].a     := 0.1;
    Determ[0].alfa  := 0.0001; Determ[1].alfa  := 0.0001;  Determ[2].alfa  := 0.0001;
    Determ[0].Omega := 0.14;   Determ[1].Omega := 0.24;    Determ[2].Omega := 0.34;
    Determ[0].fi    := 10;     Determ[1].fi    := 20;      Determ[2].fi     := 30;
    //------------ Случайная качка ------------------
    SluchEnable  := False;
    Sluch.a      := 0.45;
    Sluch.Lambda := 0.4 ;
    Sluch.mju    := 0.21 * Sluch.Lambda;
    //------------ Возмущение импульс ------------------
    ImpulsEnable := False;
    Impuls[0].a     := -0.4; Impuls[1].a     := -0.3; Impuls[2].a     := 0.3;
    Impuls[0].T1    := 1.5;  Impuls[1].T1    := 3.5;  Impuls[2].T1    := 7.5;
    Impuls[0].T2    := 2.5;  Impuls[1].T2    := 5.3;  Impuls[2].T2    := 8.0;

    Impuls[3].a     := 0.2;  Impuls[4].a     := -0.4; Impuls[5].a     := -0.1;
    Impuls[3].T1    := 8.5;  Impuls[4].T1    := 10.5; Impuls[5].T1    := 13.3;
    Impuls[3].T2    := 9.5;  Impuls[4].T2    := 11.5; Impuls[5].T2    := 14.5;
  end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    with PrivodKU do begin
      Descriptor := 1;
      with power[1 ] do begin Pos.X :=  69;  Pos.Y := 3 ;   k := 6.4;      end;
      with power[2 ] do begin Pos.X := 165;  Pos.Y := 35;   k := 400;    end;
      with power[3 ] do begin Pos.X := 261;  Pos.Y := 35;   k := 1;      end;
      with power[4 ] do begin Pos.X := 357;  Pos.Y := 35;   k := 10      end;
      with power[5 ] do begin Pos.X := 452;  Pos.Y := 35;   k := 7;      end;
      with power[6 ] do begin Pos.X := 276;  Pos.Y := 115;  k := 0.0478; end;
      with power[7 ] do begin Pos.X := 517;  Pos.Y := 115;  k := 0.0028; end;
      with power[8 ] do begin Pos.X := 277;  Pos.Y := 147;  k := -0.078; end;
      with power[9 ] do begin Pos.X := 277;  Pos.Y := 179;  k := -1;     end;
      with power[10] do begin Pos.X := 181;  Pos.Y := 179;  k := 6;     end;

      With Ogran[1]  do begin Pos.X := 117;  Pos.Y := 35;   b := 0.02;  k := 1;  end;
      With Ogran[2]  do begin Pos.X := 405;  Pos.Y := 35;   b := 10;    k := 1;  end;
      With Ogran[3]  do begin Pos.X := 501;  Pos.Y := 35;   b := 70;    k := 1;  end;
      With Ogran[4]  do begin Pos.X := 229;  Pos.Y := 115;  b := 6;     k := 1;  end;
      With Ogran[5]  do begin Pos.X := 373;  Pos.Y := 115;  b := 800;   k := 1;  end;

      With Aperiod   do begin Pos.X := 181;  Pos.Y := 115;  t1 := 0.004; k := 0.38; end;

      With Integ[1]  do begin Pos.X := 325;  Pos.Y := 115;  k:=23817;  end;
      With Integ[2]  do begin Pos.X := 421;  Pos.Y := 115;  k:=1;      end;

      With Luft      do begin Pos.X := 469;  Pos.Y := 115;  a := 0.15; k := 1; end;
  end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  with PrivodUM do begin
      Descriptor := 2;
      with power[1 ] do begin Pos.X :=  69;  Pos.Y := 3 ;   k := 3;      end;
      with power[2 ] do begin Pos.X := 165;  Pos.Y := 35;   k := 200;    end;
      with power[3 ] do begin Pos.X := 261;  Pos.Y := 35;   k := 4;      end;
      with power[4 ] do begin Pos.X := 357;  Pos.Y := 35;   k := 10      end;
      with power[5 ] do begin Pos.X := 452;  Pos.Y := 35;   k := 7;      end;
      with power[6 ] do begin Pos.X := 276;  Pos.Y := 115;  k := 0.0478; end;
      with power[7 ] do begin Pos.X := 517;  Pos.Y := 115;  k := 0.0014; end;
      with power[8 ] do begin Pos.X := 277;  Pos.Y := 147;  k := -0.078; end;
      with power[9 ] do begin Pos.X := 277;  Pos.Y := 179;  k := -1;     end;
      with power[10] do begin Pos.X := 181;  Pos.Y := 179;  k := 12;     end;

      With Ogran[1]  do begin Pos.X := 117;  Pos.Y := 35;   b     := 0.02;  k     := 1;  end;
      With Ogran[2]  do begin Pos.X := 405;  Pos.Y := 35;   b     := 10;    k     := 1;  end;
      With Ogran[3]  do begin Pos.X := 501;  Pos.Y := 35;   b     := 70;    k     := 1;  end;
      With Ogran[4]  do begin Pos.X := 229;  Pos.Y := 115;  b     := 8;     k     := 1;  end;
      With Ogran[5]  do begin Pos.X := 373;  Pos.Y := 115;  b     := 800;   k     := 1;  end;

      With Aperiod   do begin Pos.X := 181;  Pos.Y := 115;  t1    := 0.004; k     := 0.38; end;

      With Integ[1]  do begin Pos.X := 325;  Pos.Y := 115;  k:=22471.97239232; end;
      With Integ[2]  do begin Pos.X := 421;  Pos.Y := 115;  k:=1;              end;

      With Luft      do begin Pos.X := 469;  Pos.Y := 115;  a := 0.1; k := 1; end;
  end;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  with PC1 do begin
     {C0_k     := -0.001;
     C1_k     := -0.1;
     C2_k     := 0.1;
     Omega_k  := 1;}

     C0_k     := 0;
     C1_k     := 0;
     C2_k     := 0;
     Omega_k  := 0;

     Eps0       := 0;
     Eps1       := 0;
     Eps2       := 0;
     Omega_Eps  := 0;

     fi1        := 0;
     fi2        := 0;
     fi_k1      := 0;
     fi_k2      := 0;
  end;
  //***********************************************************************
  //************ Параметры по умолчания для блока коретировки Жени ********
  //***********************************************************************
  With BK do begin
      With Integral        do begin Pos.X := -1;  Pos.Y := -1;  k := 1; end;
      With AperiodicForce1 do begin Pos.X := -1;  Pos.Y := -1;  k := 1; T1:=1; T2:=1; end;
      With AperiodicForce2 do begin Pos.X := -1;  Pos.Y := -1;  k := 1; T1:=1; T2:=1; end;
  end;
end;

procedure TPPlatform.ParamSetDefault2;
begin
  with Kachka_Ksi do begin
    //------------ Детерменированная качка ------------------
    DetermEnable := True;
//    DetermEnable := false;
    Determ[0].a     := -0.15;    Determ[1].a    := -0.1 ;   Determ[2].a     := -0.1;
//    Determ[0].a     := -0.1;    Determ[1].a     := 0  ;     Determ[2].a     := 0  ;
    Determ[0].alfa  := 0.0001; Determ[1].alfa  := 0.0001;  Determ[2].alfa  := 0.0001;
    Determ[0].Omega := 0.14;   Determ[1].Omega := 0.24;    Determ[2].Omega := 0.34;
    Determ[0].fi    := 90;     Determ[1].fi    := 90;      Determ[2].fi    := 90;
    //------------ Случайная качка ------------------
    SluchEnable  := False;
    Sluch.a      := 0.35;
    Sluch.Lambda := 0.3 ;
    Sluch.mju    := 0.21 * Sluch.Lambda;
    //------------ Возмущение импульс ------------------
    ImpulsEnable := False;
    Impuls[0].a     := 0.4;  Impuls[1].a     := 0.3;  Impuls[2].a     := -0.3;
    Impuls[0].T1    := 1;    Impuls[1].T1    := 3;    Impuls[2].T1    := 7;
    Impuls[0].T2    := 2;    Impuls[1].T2    := 4.8;  Impuls[2].T2    := 7.5;

    Impuls[3].a     := -0.2; Impuls[4].a     := 0.4;  Impuls[5].a     := 0.1;
    Impuls[3].T1    := 8;    Impuls[4].T1    := 10;   Impuls[5].T1    := 12.8;
    Impuls[3].T2    := 9;    Impuls[4].T2    := 11;   Impuls[5].T2    := 14;
  end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  with Kachka_Teta do begin
    //------------ Детерменированная качка ------------------
    DetermEnable := true;
//    DetermEnable := false;
    Determ[0].a     := -0.1;    Determ[1].a    := -0.1 ;   Determ[2].a     := -0.1;
//    Determ[0].a     := -0.1;    Determ[1].a     := 0  ;     Determ[2].a     := 0  ;
    Determ[0].alfa  := 0.0001; Determ[1].alfa  := 0.0001;  Determ[2].alfa  := 0.0001;
    Determ[0].Omega := 0.14;   Determ[1].Omega := 0.24;    Determ[2].Omega := 0.34;
    Determ[0].fi    := 90;     Determ[1].fi    := 90;      Determ[2].fi    := 90;
    //------------ Случайная качка ------------------
    SluchEnable  := False;
    Sluch.a      := 0.45;
    Sluch.Lambda := 0.4 ;
    Sluch.mju    := 0.21 * Sluch.Lambda;
    //------------ Возмущение импульс ------------------
    ImpulsEnable := False;
    Impuls[0].a     := -0.4; Impuls[1].a     := -0.3; Impuls[2].a     := 0.3;
    Impuls[0].T1    := 1.5;  Impuls[1].T1    := 3.5;  Impuls[2].T1    := 7.5;
    Impuls[0].T2    := 2.5;  Impuls[1].T2    := 5.3;  Impuls[2].T2    := 8.0;

    Impuls[3].a     := 0.2;  Impuls[4].a     := -0.4; Impuls[5].a     := -0.1;
    Impuls[3].T1    := 8.5;  Impuls[4].T1    := 10.5; Impuls[5].T1    := 13.3;
    Impuls[3].T2    := 9.5;  Impuls[4].T2    := 11.5; Impuls[5].T2    := 14.5;
  end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    with PrivodKU do begin
      Descriptor := 1;
      with power[1 ] do begin Pos.X :=  69;  Pos.Y := 3 ;   k := 6.4;      end;
      with power[2 ] do begin Pos.X := 165;  Pos.Y := 35;   k := 400;    end;
      with power[3 ] do begin Pos.X := 261;  Pos.Y := 35;   k := 1;      end;
      with power[4 ] do begin Pos.X := 357;  Pos.Y := 35;   k := 10      end;
      with power[5 ] do begin Pos.X := 452;  Pos.Y := 35;   k := 7;      end;
      with power[6 ] do begin Pos.X := 276;  Pos.Y := 115;  k := 0.0478; end;
      with power[7 ] do begin Pos.X := 517;  Pos.Y := 115;  k := 0.0028; end;
      with power[8 ] do begin Pos.X := 277;  Pos.Y := 147;  k := -0.078; end;
      with power[9 ] do begin Pos.X := 277;  Pos.Y := 179;  k := -1;     end;
      with power[10] do begin Pos.X := 181;  Pos.Y := 179;  k := 6;     end;

      With Ogran[1]  do begin Pos.X := 117;  Pos.Y := 35;   b := 0.02;  k := 1;  end;
      With Ogran[2]  do begin Pos.X := 405;  Pos.Y := 35;   b := 10;    k := 1;  end;
      With Ogran[3]  do begin Pos.X := 501;  Pos.Y := 35;   b := 70;    k := 1;  end;
      With Ogran[4]  do begin Pos.X := 229;  Pos.Y := 115;  b := 6;     k := 1;  end;
      With Ogran[5]  do begin Pos.X := 373;  Pos.Y := 115;  b := 800;   k := 1;  end;

      With Aperiod   do begin Pos.X := 181;  Pos.Y := 115;  t1 := 0.004; k := 0.38; end;

      With Integ[1]  do begin Pos.X := 325;  Pos.Y := 115;  k:=23817;  end;
      With Integ[2]  do begin Pos.X := 421;  Pos.Y := 115;  k:=1;      end;

      With Luft      do begin Pos.X := 469;  Pos.Y := 115;  a := 0.15; k := 1; end;
  end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  with PrivodUM do begin
      Descriptor := 2;
      with power[1 ] do begin Pos.X :=  69;  Pos.Y := 3 ;   k := 3;      end;
      with power[2 ] do begin Pos.X := 165;  Pos.Y := 35;   k := 200;    end;
      with power[3 ] do begin Pos.X := 261;  Pos.Y := 35;   k := 4;      end;
      with power[4 ] do begin Pos.X := 357;  Pos.Y := 35;   k := 10      end;
      with power[5 ] do begin Pos.X := 452;  Pos.Y := 35;   k := 7;      end;
      with power[6 ] do begin Pos.X := 276;  Pos.Y := 115;  k := 0.0478; end;
      with power[7 ] do begin Pos.X := 517;  Pos.Y := 115;  k := 0.0014; end;
      with power[8 ] do begin Pos.X := 277;  Pos.Y := 147;  k := -0.078; end;
      with power[9 ] do begin Pos.X := 277;  Pos.Y := 179;  k := -1;     end;
      with power[10] do begin Pos.X := 181;  Pos.Y := 179;  k := 12;     end;

      With Ogran[1]  do begin Pos.X := 117;  Pos.Y := 35;   b     := 0.02;  k     := 1;  end;
      With Ogran[2]  do begin Pos.X := 405;  Pos.Y := 35;   b     := 10;    k     := 1;  end;
      With Ogran[3]  do begin Pos.X := 501;  Pos.Y := 35;   b     := 70;    k     := 1;  end;
      With Ogran[4]  do begin Pos.X := 229;  Pos.Y := 115;  b     := 8;     k     := 1;  end;
      With Ogran[5]  do begin Pos.X := 373;  Pos.Y := 115;  b     := 800;   k     := 1;  end;

      With Aperiod   do begin Pos.X := 181;  Pos.Y := 115;  t1    := 0.004; k     := 0.38; end;

      With Integ[1]  do begin Pos.X := 325;  Pos.Y := 115;  k := 22471.97239232; end;
      With Integ[2]  do begin Pos.X := 421;  Pos.Y := 115;  k := 1;              end;

      With Luft      do begin Pos.X := 469;  Pos.Y := 115;  a := 0.1; k := 1; end;
  end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  with PC1 do begin
     {C0_k     := -0.01;
     C1_k     := -0.1;
     C2_k     := 0.1;
     Omega_k  := 1;}
     C0_k     := 0;
     C1_k     := 0;
     C2_k     := 0;
     Omega_k  := 0;

     Eps0       := 0;
     Eps1       := 0;
     Eps2       := 0;
     Omega_Eps  := 0;

     fi1        := 0;
     fi2        := 0;
     fi_k1      := 0;
     fi_k2      := 0;
  end;
  //***********************************************************************
  //************ Параметры по умолчания для блока коретировки Жени ********
  //***********************************************************************
  With BK do begin
      With Integral        do begin Pos.X := -1;  Pos.Y := -1;  k := 1; end;
      With AperiodicForce1 do begin Pos.X := -1;  Pos.Y := -1;  k := 1; T1:=1; T2:=1; end;
      With AperiodicForce2 do begin Pos.X := -1;  Pos.Y := -1;  k := 1; T1:=1; T2:=1; end;
  end;
end;

Procedure TPPlatform.SetParamToGraphicNameWindow;
Begin
   GraphNameForm.ListBox1.ItemIndex:=0;
   GraphNameForm.ListBox2.ItemIndex:=0;
   if FCurrentStabTime = 0 then begin
     GraphNameForm.Chart1.BottomAxis.Minimum:=0;
     GraphNameForm.Chart1.BottomAxis.Maximum:=10;
   end;
   GraphNameForm.Chart1.Series[0].Clear;
   GraphNameForm.Label1.Caption := 'T0 = ' + FloatToStrF(FpModelParams^.Tdiscr, ffFixed, 10,7) + ' с.';
   GraphNameForm.Chart1.LeftAxis.Maximum:=1000000000;
   GraphNameForm.Chart1.LeftAxis.Minimum:=0;
   GraphNameForm.Chart1.LeftAxis.Maximum:=0;
end;

procedure SetChartMaxMin(Time : extended);
var
  max , min : extended;
begin
  if GraphNameForm.CheckBox1.Checked then begin
     if Time > 10 then begin
        max := 5000000000000000000;  GraphNameForm.Chart1.BottomAxis.Maximum := max;
        min := 0;                    GraphNameForm.Chart1.BottomAxis.Minimum := min;
        max := Round(Time-0.5) + 1;  GraphNameForm.Chart1.BottomAxis.Maximum := max;
        min := max - 10;             GraphNameForm.Chart1.BottomAxis.Minimum := min;
     end;
  end;
end;

Procedure SetMaxMin(var CurrentGr : GrArr; data : extended; CurrentGraphicPoint : integer);
begin
  CurrentGr^[CurrentGraphicPoint]:= data;
end;

procedure TPPlatform.SetNewPointToGraphicArray(n : byte);
var temp : single;
begin
  if TochkaPropuska >= round(1/FpModelParams^.Tdiscr) div GrTakt then begin

     SetMaxMin(Kachka_Ksi. GrArray^.PrGr,      Kachka_Ksi .Result,   CurrentGraphicPoint);
     SetMaxMin(Kachka_Teta.GrArray^.PrGr,     Kachka_Teta.Result,   CurrentGraphicPoint);
     SetMaxMin(k_k_GrArray^.PrGr,             PC1.k_k,              CurrentGraphicPoint);
     SetMaxMin(Eps_C_GrArray^.PrGr,           PC1.Eps_C,            CurrentGraphicPoint);
     SetMaxMin(Riskanie_GrArray^.PrGr,        PC1.Riskanie,         CurrentGraphicPoint);
     SetMaxMin(PC1.GrArray1^.PrGr,            PC1.q_k,              CurrentGraphicPoint);
     SetMaxMin(PC1.GrArray2^.PrGr,            PC1.eps_k,            CurrentGraphicPoint);
     SetMaxMin(PrivodKU.GrArrayOut^.PrGr,     PrivodKU.Result,      CurrentGraphicPoint);
     SetMaxMin(PrivodKU.GrArrayOshibka^.PrGr, PrivodKU.Oshibka,     CurrentGraphicPoint);
     SetMaxMin(PrivodUM.GrArrayOut^.PrGr,     PrivodUM.Result,      CurrentGraphicPoint);
     SetMaxMin(PrivodUM.GrArrayOshibka^.PrGr, PrivodUM.Oshibka,     CurrentGraphicPoint);
     SetMaxMin(PC2.GrArray1^.PrGr,            PC2.P_ca,             CurrentGraphicPoint);
     SetMaxMin(PC2.GrArray2^.PrGr,            PC2.eps_ca,           CurrentGraphicPoint);
     SetMaxMin(PC2.GrArray3^.PrGr,            PC2.kappa,            CurrentGraphicPoint);

     Temp := CurrentGraphicPoint/GrTakt;

     if CurrentGraphicPoint=0 then SetParamToGraphicNameWindow;
     SetChartMaxMin(FCurrentStabTime);

     GraphNameForm.Chart1.Series[0].AddXY(Temp, CurrentGraphic^.PrGr^[CurrentGraphicPoint-1]);

     inc(CurrentGraphicPoint);
    TochkaPropuska := 0;
  end;
  inc(TochkaPropuska);
end;

function  TPPlatform.Next(T1 : extended; Peleng : extended; n : Byte): extended;
var
  count : Integer;
  Kurs  : Extended;
begin
 FPeleng  :=Peleng;

 {Count := 0;
  Repeat
      SetNewPointToGraphicArray;
      FCurrentStabTime := FCurrentStabTime + FpModelParams^.Tdiscr;
      inc(count);
  until Count>=n;
 result:=peleng;
 exit;}

 Count := 0;
  Repeat
      SetNewPointToGraphicArray(n);
      //---- Считаем качки -------
      Kachka_Ksi.run(FCurrentStabTime);
      Kachka_Teta.run(FCurrentStabTime);
      // ---- Считаем Преобразователь координат 1
      //  --- Kachka_Ksi .Result ------- Вход блока PC1
      //  --- Kachka_Teta.Result -------- Вход блока PC1
      PC1.Run(FCurrentStabTime, Peleng, Kachka_Ksi .Result, Kachka_Teta.Result);

       //      PC1.Q_k := 0.5*T1/1000;
      if count = 0 then begin
         PrivodKU.Diff_1[0] := PC1.Q_k   * PrivodKU.power[1].k;
         PrivodUM.Diff_1[0] := PC1.eps_k * PrivodUM.power[1].k;
      end;

      // --------- Считаем круги --------
          Angle_Qk[0] := Peleng; //q_c + Pc1.K_k + Pc1.Riskanie

          // >360
          if (Angle_Qk[0] > 0)      and (Angle_Qk[0] < 0.15)      and
             (Angle_Qk[-1] < 2*pi)  and (Angle_Qk[-1] > 2*pi-0.15)
          then
                  CurrentCircle := CurrentCircle + 1;

          Angle_Qk[-1] := Angle_Qk[0];
          //--------

          //if Oldt1  <> T1 then
          //        GraphNameForm.Label1.Caption := intToStr(CurrentCircle) + '  ' +floatToStr(PC1.Q_k*180/pi);

      // --------- End of "Считаем круги" --------

       //-------------------------------------------------
       //-------------------------------------------------
       //-------------------------------------------------
            PC1.K_k      :=   PC1.C0_k + PC1.C1_k*t1/1000
                            + PC1.C2_k * sin(PC1.Omega_k   *t1/1000*two_pi);

            PC1.Riskanie :=   PC1.fi1*sin(PC1.fi_k1 *t1/1000*two_pi)
                            + PC1.fi2*sin(PC1.fi_k2 *t1/1000*two_pi);

            //PC1.Eps_c    := PC1.Eps0 + PC1.Eps1*t1/1000 + PC1.Eps2 * sin(PC1.Omega_Eps *t1/1000*two_pi);

            Kurs         := PC1.K_k+PC1.Riskanie;
       //-------------------------------------------------
       //-------------------------------------------------
       //-------------------------------------------------

      PC1.Q_k := PC1.Q_k + 2*pi*CurrentCircle - Kurs;
         PrivodKU.Run(Count,  PC1.Q_k);
         PrivodUM.Run(Count,  PC1.eps_k);
      PrivodKU.Result := PrivodKU.Result - 2*pi*CurrentCircle + Kurs;

      PC2.Run(Kachka_Ksi.Result, Kachka_Teta.Result,
              PC1.q_c,           PC1.K_k,     PC1.Riskanie,
              PrivodKU.Result,   PrivodUM.Result);

      //---------
      FCurrentStabTime := FCurrentStabTime + FpModelParams^.Tdiscr;
      inc(count);
  until Count>=n;


  privodKU.Diff_1[-1] := privodKU.Diff_1[0];
  privodUM.Diff_1[-1] := privodUM.Diff_1[0];

  Result:=PC2.P_ca; // ---  ВЫХОД ПРИВОДОВ -------
  Oldt1    :=T1;
end;

procedure TPPlatform.GetMemory_GraphicArray;
begin
  GetMem(Kachka_Ksi  .GrArray    , SizeOf(TGraphicArray));
  GetMem(Kachka_Teta .GrArray    , SizeOf(TGraphicArray));

  GetMem(PC1.GrArray1            , SizeOf(TGraphicArray));
  GetMem(PC1.GrArray2            , SizeOf(TGraphicArray));

  GetMem(PC2.GrArray1            , SizeOf(TGraphicArray));
  GetMem(PC2.GrArray2            , SizeOf(TGraphicArray));
  GetMem(PC2.GrArray3            , SizeOf(TGraphicArray));

  GetMem(PrivodKU.GrArrayOut     , SizeOf(TGraphicArray));
  GetMem(PrivodKU.GrArrayOshibka , SizeOf(TGraphicArray));

  GetMem(PrivodUM.GrArrayOut     , SizeOf(TGraphicArray));
  GetMem(PrivodUM.GrArrayOshibka , SizeOf(TGraphicArray));

  GetMem(k_k_GrArray             , SizeOf(TGraphicArray));
  GetMem(Riskanie_GrArray        , SizeOf(TGraphicArray));
  GetMem(Eps_C_GrArray           , SizeOf(TGraphicArray));
//--------------------------
  GetMem(Kachka_Ksi  .GrArray^.PrGr    , SizeOf(Single)*(CountPixelInGraphic+1));
  GetMem(Kachka_Teta .GrArray^.PrGr    , SizeOf(Single)*(CountPixelInGraphic+1));

  GetMem(PC1.GrArray1^.PrGr            , SizeOf(Single)*(CountPixelInGraphic+1));
  GetMem(PC1.GrArray2^.PrGr            , SizeOf(Single)*(CountPixelInGraphic+1));

  GetMem(PC2.GrArray1^.PrGr            , SizeOf(Single)*(CountPixelInGraphic+1));
  GetMem(PC2.GrArray2^.PrGr            , SizeOf(Single)*(CountPixelInGraphic+1));
  GetMem(PC2.GrArray3^.PrGr            , SizeOf(Single)*(CountPixelInGraphic+1));

  GetMem(PrivodKU.GrArrayOut^.PrGr     , SizeOf(Single)*(CountPixelInGraphic+1));
  GetMem(PrivodKU.GrArrayOshibka^.PrGr , SizeOf(Single)*(CountPixelInGraphic+1));

  GetMem(PrivodUM.GrArrayOut^.PrGr     , SizeOf(Single)*(CountPixelInGraphic+1));
  GetMem(PrivodUM.GrArrayOshibka^.PrGr , SizeOf(Single)*(CountPixelInGraphic+1));

  GetMem(k_k_GrArray^.PrGr             , SizeOf(Single)*(CountPixelInGraphic+1));
  GetMem(Riskanie_GrArray^.PrGr        , SizeOf(Single)*(CountPixelInGraphic+1));
  GetMem(Eps_C_GrArray^.PrGr           , SizeOf(Single)*(CountPixelInGraphic+1));
end;

procedure TPPlatform.FreeMemory_GraphicArray;
begin
  FreeMem(Kachka_Ksi  .GrArray^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));
  FreeMem(Kachka_Teta .GrArray^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));

  FreeMem(PC1.GrArray1^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));
  FreeMem(PC1.GrArray2^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));

  FreeMem(PC2.GrArray1^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));
  FreeMem(PC2.GrArray2^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));
  FreeMem(PC2.GrArray3^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));

  FreeMem(PrivodKU.GrArrayOut^.PrGr    , SizeOf(Single)*(CountPixelInGraphic+1));
  FreeMem(PrivodKU.GrArrayOshibka^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));

  FreeMem(PrivodUM.GrArrayOut^.PrGr    , SizeOf(Single)*(CountPixelInGraphic+1));
  FreeMem(PrivodUM.GrArrayOshibka^.PrGr, SizeOf(Single)*(CountPixelInGraphic+1));

  FreeMem(k_k_GrArray^.PrGr      , SizeOf(Single)*(CountPixelInGraphic+1));
  FreeMem(Riskanie_GrArray^.PrGr , SizeOf(Single)*(CountPixelInGraphic+1));
  FreeMem(Eps_C_GrArray^.PrGr    , SizeOf(Single)*(CountPixelInGraphic+1));
end;

procedure TPPlatform.ClearMemory_GraphicArray;
begin
{  FillChar(Kachka_Ksi  .GrArray^.PrGr^    ,SizeOf(Single)*(CountPixelInGraphic+1),0);
  FillChar(Kachka_Teta .GrArray^.PrGr^    ,SizeOf(Single)*(CountPixelInGraphic+1),0);

  FillChar(PC1.GrArray1^.PrGr^            ,SizeOf(Single)*(CountPixelInGraphic+1),0);
  FillChar(PC1.GrArray2^.PrGr^            ,SizeOf(Single)*(CountPixelInGraphic+1),0);

  FillChar(PC2.GrArray1^.PrGr^            ,SizeOf(Single)*(CountPixelInGraphic+1),0);
  FillChar(PC2.GrArray2^.PrGr^            ,SizeOf(Single)*(CountPixelInGraphic+1),0);
  FillChar(PC2.GrArray3^.PrGr^            ,SizeOf(Single)*(CountPixelInGraphic+1),0);

  FillChar(PrivodKU.GrArrayOut^.PrGr^     ,SizeOf(Single)*(CountPixelInGraphic+1),0);
  FillChar(PrivodKU.GrArrayOshibka^.PrGr^ ,SizeOf(Single)*(CountPixelInGraphic+1),0);

  FillChar(PrivodUM.GrArrayOut^.PrGr^     ,SizeOf(Single)*(CountPixelInGraphic+1),0);
  FillChar(PrivodUM.GrArrayOshibka^.PrGr^ ,SizeOf(Single)*(CountPixelInGraphic+1),0);

  FillChar(k_k_GrArray^.PrGr^             ,SizeOf(Single)*(CountPixelInGraphic+1),0);
  FillChar(Riskanie_GrArray^.PrGr^        ,SizeOf(Single)*(CountPixelInGraphic+1),0);
  FillChar(Eps_C_GrArray^.PrGr^           ,SizeOf(Single)*(CountPixelInGraphic+1),0);
}
end;

{ TBlockKorektirovki }

constructor TBlockKorektirovki.CreateNew(pModelParams: Pointer);
begin
  inherited Create;
  Integral := TIntegral.Create;
  AperiodicForce1 := TAperiodForce.Create;
  AperiodicForce2 := TAperiodForce.Create;
  FpModelParams := pModelParams;
end;

destructor TBlockKorektirovki.Destroy;
begin
  Integral.Free;
  AperiodicForce1.Free;
  AperiodicForce2.Free;
  inherited Destroy;
end;

procedure TBlockKorektirovki.Init;
begin
  Integral.Init (@FpModelParams^.TdiscrToBlockKorrec);
  AperiodicForce1.Init (@FpModelParams^.TdiscrToBlockKorrec);
  AperiodicForce2.Init (@FpModelParams^.TdiscrToBlockKorrec);
end;

Function TBlockKorektirovki.Next(Input : extended):extended;
var
  Aper1 : Extended;
  Aper2 : Extended;
begin
  Aper1  := AperiodicForce1.Run( Input );
  Aper2  := AperiodicForce2.Run( Aper1 );
  result := Integral.Run( Aper2 );
end;

end.
