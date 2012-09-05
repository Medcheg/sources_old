unit Passiv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, quickrpt, qrprntr, Qrctrls, Buttons,
  Printers, Menus, Grids,  Registry, Targets, Spin, ComCtrls, math,
  MyLibrery,MapUnit, ExtDlgs, MPIDeclaration, Unit_Cript;

const
  TimeTurnConst = 10;
  Dmax = 800;
  Dmin = 0;
  Step = 50;                                            {Шаг шкалы дальности км}
  grad = 180/pi;
  rad  = pi/180;
type
      para= record
      X,Y:float;
      n:integer;
      end;
    Float=Extended{Single};   {При Float=Singel точность вычисл при сравн по }
                              {  периоду следования недостаточна !}
    Sig=record
            T,A,Tay,Pe,Pel:Float;        Nff:integer;
            Col:TColor;              Pr :Boolean;
              end;
    PoDia=^Diapason;
           Diapason=record
           N:Integer;
           end;
    PoPack = ^Pack;
           Pack=record
             T,A,Tay,Pe,Pel,ConstDiap:Float;   N,Nf:integer;
             Col:TColor;             Pr :Boolean;     {приз припис имп к пакету}
               end;
    PoPach = ^Pach;
           Pach=record
             T,tay,Beg,Pe,Pel:Float;  N,Nf:integer;
             Col:TColor;              Pr :Boolean;
               end;
    PoTarget = ^TargetProb;
           TargetProb=record
            {T,}tay,Beg,Pe{,Pel}:Float;
                                         {здесь массивы динам сделать не удается}
             Pel: array [1..300] of Float;
             ppsh1: array [1..2] of Float;   {2-число копий}
                                              {для нелинейного сглажив пеленгов}
             ModelT,ModelP,ModelD,ModelK,ModelV,Xp,Yp,T: array[1..2] of Float;
              N,Nf:integer;
             Col:TColor;
               end;
    TfmPassivRadar = class(TForm)
    //TfmPassivRadar = class(TCarrier)
    Enter: TButton;
    PBButton: TButton;
    PauseButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Sector1: TSpeedButton;
    Sector3: TSpeedButton;
    Sector2: TSpeedButton;
    Panorama1: TSpeedButton;
    Panorama2: TSpeedButton;
    Diap1: TSpeedButton;
    Diap2: TSpeedButton;
    Diap3: TSpeedButton;
    Diap4: TSpeedButton;
    Diap5: TSpeedButton;
    Speed1: TSpeedButton;
    Speed2: TSpeedButton;
    Speed3: TSpeedButton;
    Speed4: TSpeedButton;
    Speed5: TSpeedButton;
    Speed6: TSpeedButton;
    Timer: TTimer;
    MainMenu1: TMainMenu;
    Bevel1: TBevel;
    ScaleEdit: TSpinEdit;
    DetTargetGrid: TStringGrid;
    Screen: TScrollBox;
    ScreenImage: TImage;
    Switch: TSpeedButton;
    HorScale: TPaintBox;
    HorScrollBar: TScrollBar;
    VerScrollBar: TScrollBar;
    VerScale: TPaintBox;
    ScreenImage1: TImage;
    ShowReal: TCheckBox;
    Label4: TLabel;
    Tuern: TSpeedButton;
    Adupt: TSpeedButton;
    OutDate: TButton;
    DateOut: TCheckBox;
    Panorama3: TSpeedButton;
    EdCopy: TSpinEdit;
    Label5: TLabel;
    Speed7: TSpeedButton;
    Sector4: TSpeedButton;
    Select: TButton;
    ImputMassiv: TButton;
    Matrix: TButton;
    procedure EnterClick(Sender: TObject);
    procedure PBButtonClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
    procedure StatMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DetTargetGridDrawCell(Sender: TObject; Col, Row: Integer;
                                           Rect: TRect; State: TGridDrawState);
    procedure ScaleEditChange(Sender: TObject);
    procedure DiapClick(Sender: TObject);
    procedure SpeedClick(Sender: TObject);
    procedure PanoramaClick(Sender: TObject);
    procedure SectorClick(Sender: TObject);
    procedure TargetMenuClick(Sender: TObject);
    procedure HorScalePaint(Sender: TObject);
    procedure HorScrollBarChange(Sender: TObject);
    procedure VerScrollBarChange(Sender: TObject);
    procedure VerScalePaint(Sender: TObject);
    procedure ShowRealClick(Sender: TObject);
    procedure HorScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
                                                       var ScrollPos: Integer);
    procedure DetTargetGridSelectCell(Sender: TObject; Col, Row: Integer;
                                                       var CanSelect: Boolean);
    procedure DetTargetGridSetEditText(Sender: TObject; ACol, ARow: Integer;
                                                          const Value: String);
    procedure DetTargetGridKeyPress(Sender: TObject; var Key: Char);
    procedure DetTargetGridGetEditText(Sender: TObject; ACol, ARow: Integer;
                                                            var Value: String);
    procedure MapMenuClick(Sender: TObject);
    procedure SwitchClick(Sender: TObject);
    procedure NillButtonClickClick(Sender: TObject);
 {   procedure Target2Click(Sender: TObject);
    procedure Imit2Click(Sender: TObject);
    procedure Map2Click(Sender: TObject);
    procedure Statistics2Click(Sender: TObject);
    procedure Imit1Click(Sender: TObject);
    procedure Target1Click(Sender: TObject);
    procedure Map1Click(Sender: TObject);
    procedure Statistics1Click(Sender: TObject); }
    procedure TuernClick(Sender: TObject);
    procedure fggf1Click(Sender: TObject);
    procedure SortBubbl(var N:integer;var ImputMassiv: array of Sig);
    procedure SortBubblA(var N:integer;var ImputMassiv: array of Sig);
    procedure FormImputSignal(Target:TTarget;
                               var ImputMassiv: array of Sig;var nsig:integer);
    procedure PuckSig(var ImputMassiv:array of Sig; var nsig :integer);
    procedure SelectArray(ListFinishPacet :
                          TList;var ImputMassiv: array of Sig;var nsig:integer);
    procedure SelectList(ListCurrentPacet,ListFinishPacet,ListDN :TList);
    procedure SelectContrast(ListFinishPacet:TList;var ImputMassiv: array of Sig;
                                       var nsig:integer);
    procedure MatrixTayA(var ImputMassiv: array of Sig;var nsig:integer);
    procedure MatrixTA(var ImputMassiv: array of Sig;var nsig:integer);
    procedure IdentifPaket(var Pach_:PoPach; ListCurrentPach,
                               ListFinishPach,ListFinishPacet:TList);
    procedure IdentifPach(var TargetProb:PoTarget; ListCurrentTargetProb,
                                                        ListFinishPach:TList);
    //procedure ChangePel; override;

    procedure ChangeDia;
    procedure ChangeSpeedScan;
    procedure SgPeleng1Click(Sender: TObject);
    procedure ImputMassiv1Click(Sender: TObject);
    procedure Matrix1Click(Sender: TObject);
    procedure OutDateClick(Sender: TObject);

    procedure EdCopyChange(Sender: TObject);

    procedure AduptClick(Sender: TObject);
    procedure DetTargetGridDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Parameters1Click(Sender: TObject);
    procedure ScreenImageDblClick(Sender: TObject);
    procedure SelectClick(Sender: TObject);
    procedure ImputMassivClick(Sender: TObject);
    procedure MatrixClick(Sender: TObject);

  private
    Revers: Boolean;
    InDiagr: Boolean;
    ReTayA:array[0..20,0..20] of para;
    pImputMassiv : array of array of Sig;
    ListDia,
    pListDN,p_ListDN,p__ListDN,
    pListCurrentPacet,pListFinishPacet,pListCurrentPach,
    pListCurrentTargetProb,
    pListFinishPach: TList;
//    Pezip,Dizip,

    PtekZip,BAZ,{WP,}BAZ3,BAZ13,GPRLS,BP, Po,Po_,Po__,TRevers:Float;
//    HeapError:Pointer;

    Xc,                                          {Центр картинки в пикселах}
    NumberRevers,                                       {текущее число реверсов}
    NumberDiaTarget,                     {число работ диапаз для адап сопровожд}
    HalfDN,st1,nc,nsig: Integer;        {пол-ширины рамки ДН в  пикселах}
    TimeToRepaint, TimeToScroll: TDateTime;
    Scrolling: Boolean;  {true если в данный момент скроллинг изображения по x}
    kX, kY: Float;               {1градус в пикселах по x/1 км в пикселах по y}
//    Temp1:array[0..99,1..2] of Integer;
    NumberDia: array[1..5] of Boolean;
    DiapButtons: array [1..5] of TSpeedButton;
    SpeedButtons: array[1..6] of TSpeedButton;
    procedure SetDiap(ADiap: Integer);
    procedure DetectDiaTarget;
    procedure DrawRealTarget(Peleng, D: Real; Color: TColor);
    procedure DrawScanTarget(Peleng, D: Real; Color: TColor);
    procedure DrawDN(Peleng: Float);
    procedure NonLineApr(Target: TTarget;var Targ,nc,sh25:integer);
    procedure NonLineAprTargetProb(var TargetProb:PoTarget;var nc:Integer;
                                                  ListCurrentTargetProb: TList);
    procedure Extrapol(Target: TTarget;var Targ,nc:integer);
//    procedure DetectKursSpeed(Target: TTarget;var Targ,nc:integer);
    procedure Peleng(Target: TTarget;IndCarrier : integer;Carrier:TCarrier;nc:integer; var ListDN :TList;
                   var { nc,}dd0,l, sh25, sh1:  integer;
    var {TSignBeg1,}VM,SigLow,a21,a22,a211,a212,a222,b21,b22,b23,{ttprov,}PI,
    SHPEL,SHPEL0, D,H,P002,PWIP2,AAA,BBB,CCC,Po: Float);
    procedure Cannal(Target: TTarget; Carrier :TCarrier;var
    DTRMED,sigmaDTRL,sigmaDTRF,DTRT1 :Float);
  public
    ArS:Integer;
    NamberEnter                : Integer; // --- Количество нажатий на Enter ---
    Carrier1,Carrier2,Carrier3 : TCarrier;
    BPK                        : Float;
    Ot0,Ot0_                   : array of array of OtRecord;
    Ot,Ot_                     : TOt_;

    TableArrayProb             : array [0..20,0..500] of Single;  // -- 1.
    TableArrayDevPel           : array [0..20,0..500] of Single;
    TableArrayDevDist          : array [0..20,0..500] of Single;

    NumberDiaSwitch            : array[1..5] of Boolean;
    PGMamory                   : array[0..100] of integer; // --- Массив Мощности Паузного режима ----
    CurrentTablePos            : Integer;
    COD                        :array[0..511] of Float;
    Dia                        : integer;  //---- Номер диапазона ----
    PB,                                             {текущ пеленг биссектриссы}
    WP,
    TimeTurn,
  //  ttTuern,
    SEK,PelMin,PelMax,        {ширина сектора и его границы при текущ биссектр}
    Panoram, tt,ttsek,ttsek_,{ttzip,} delta_p, delta_t,delta_t_st,
    delta_t_stt :Float;

    X0,Y0,H0,Ptek0: Float;                             {начальные координаты}
    X,Y,H,Ptek: Float;                                   {текущие координаты}
    Kurs,Speed,Kurs0,Speed0 :Extended;  {текущий и начальный курс и скорость}
    Xout,Yout:Float;   {коорд нос в момент стрельбы небх для оценк упрежд координ}
    procedure Move (dt:Extended);
    procedure ChangePel; virtual;
    procedure ChangeKurs; virtual;
  end;

var
  fmPassivRadar: TfmPassivRadar;

implementation

uses Statistic, Select, SgPeleng, ImputMassiv, SignTabel,
  StatisticProb, Switch, Manager, StatisticUpr, Parameters, About,
  Unit_OnePeleng;
{$R *.DFM}

type                              {тип задан здесь поскольку иначе не работает}
                                                      {метод ListDN.Sort(Comp)}
          PSig = ^Sig;
const
//  GPRLSs: array [1..5] of Float = (42, 36, 28.5, 21, 20);
//  BPs:    array [1..5] of Float = (0.75, 1.5, 2.9, 7.3, {15}7.3);
//  BPKs:   array [1..5] of Float = (1.65, 3.3, 5.8, 12.4, {25}12.4);
//  Pos:    array [1..5] of Float = (-106, -107, -109, -110, -114);

  GPRLSs: array [1..5] of Float = (38, 32, 28.5, 21, 20);   {Минерал МЭ-2}
  BPs:    array [1..5] of Float = (0.8, 3, 3, 7.3, 8.5);
  BPKs:   array [1..5] of Float = (1.65, 6, 5.8, 12.4, 14);
  Pos:    array [1..5] of Float = (-113, -113, -113, -113, -113);
  PosN:    array [1..5] of Float = (-117, -117, -117, -117, -117);
procedure TfmPassivRadar.SortBubbl(var N:integer;var ImputMassiv: array  of Sig);
var i,j,k :integer;
    Y   :Sig;
begin
  for i:=1 to N do
    begin
      for j:=N downto i do
      if ImputMassiv[j-1].T>ImputMassiv[j].T then
      begin
         Y:=ImputMassiv[j-1];
         ImputMassiv[j-1]:=ImputMassiv[j];
         ImputMassiv[j]:=Y;
      end;
    end;
end;
procedure TfmPassivRadar.SortBubblA(var N:integer;var ImputMassiv: array  of Sig);
var i,j,k :integer;
    Y   :Sig;
begin
  for i:=1 to N do
    begin
      for j:=N downto i do
      if ImputMassiv[j-1].A>ImputMassiv[j].A then
      begin
         Y:=ImputMassiv[j-1];
         ImputMassiv[j-1]:=ImputMassiv[j];
         ImputMassiv[j]:=Y;
      end;
    end;
end;
procedure TfmPassivRadar.PuckSig( var ImputMassiv:array of Sig;var nsig:integer);
var
  k,n,i:integer;
begin
  for k:=0 to nsig do if ImputMassiv[k].A > 0 then break;
  for i:=k to nsig do ImputMassiv[i-k]:=ImputMassiv[i];
  nsig:=nsig-k;
end;
procedure TfmPassivRadar.FormImputSignal(Target:TTarget;var ImputMassiv:
                                           array of Sig;var nsig:integer);
label MM1;
var
  ttsmol,PTekPRLSsmol,PTekRLSsmol,Dtrf,TF,TFsek,PelTar,
  PelPRLS,C33,C5,E,
  G2,G1,
  x,y,fol,nos,
  DTRMED,sigmaDTRL,sigmaDTRF,DTRT1 :Float;
  j1,j2:Extended;
  k,tot,mig,i,nSmol :integer;
begin
 // for k:=0 to NS do  ImputMassiv[k].Pr:=False;
  Cannal(Target,Carrier2,DTRMED,sigmaDTRL,sigmaDTRF,DTRT1);
  C33:= 0.4343*ln(Target.lamda*0.01);
  C5:=Target.PG+GPRLS+20*C33-22;
  ttsmol:=tt+Target.TSignBeg1;             {начал знач тек врем внутри delta_t}
                                      {текущ полож макс ДН ПРЛС внутри delta_t}
  PTekPRLSsmol:=fmPassivRadar.PTek ;
                                        {текущ полож макс ДН РЛС внутри delta_t}
  PTekRLSsmol :=Target.PTek;
//  k:=0;                                      {счетчик числа отсчетов DTRfast}
  TF:=1/(60000*Target.F);                                 {период повтор в мин}
  TFsek:=TF*60;                                                {пер повт в сек}
  PelTar :=grad*arctan2(Target.X-fmPassivRadar.X,Target.Y-fmPassivRadar.Y);                                                {пеленг цели с ПРЛС}
//  grad*Pel(fmPassivRadar.X,fmPassivRadar.Y,Target.X,Target.Y);
  PelPRLS:=                                                 {пеленг ПРЛС с цели}
  grad*Pel(Target.X,Target.Y,fmPassivRadar.X,fmPassivRadar.Y);{провер правильность!}
   tot:=0;
   mig:=0;
   nSmol:=0;
  while ttsmol < tt+delta_t do
  begin
    nSmol:=nSmol+1;
    if nSmol>1 then
    ttsmol:=ttsmol+TF;                             {тек врем внутр инт delta_t}
//    if ttsmol >= tt+delta_t then goto  MM1;
    if delta_p>0 then
    PTekPRLSsmol:=PTekPRLSsmol+fmPassivRadar.WP*TFsek else
    PTekPRLSsmol:=PTekPRLSsmol-fmPassivRadar.WP*TFsek;
    PTekRLSsmol :=PTekRLSsmol +Target.WR*TFsek;
    if PTekRLSsmol > 360 then PTekRLSsmol:=PTekRLSsmol-360;
    Target.ChangeT;                                   {текущий прирост периода}
                                   {выбираем ближайш отсчет ампл быст флуктуац}
//              while DTRfast[k].T<ttsmol do k:=k+1 else
//                     DTRf :=DTRfast[k].A;
    DTRf:=0;
                        {DTRfast генерир процедурой Cannal c пост дискр 0.01сек}
    if (PTekPRLSsmol < 0) and ( PelTar > 270 )then PelTar:=360-PelTar;
    j1:=PTekPRLSsmol-PelTar;
    j2:=PTekRLSsmol-PelPRLS;
    G1:= G(j1,fmPassivRadar.BP,-30);
    G2:= G(j2,Target.BR,Target.fone);
    E:=G1+G2+DTRMED+{VM+}DTRf+C5;
    if E > fmPassivRadar.Po      then
                                                              {условие обнаруж}
    begin                                        {наолняем входн массив сигнал}
                          { фиксир малое время внутри инт delta_t}
      if Target.Color<>0 then
      begin
        nsig:=nsig+1;
        ImputMassiv[nsig].Pel:=PTekPRLSsmol;
        ImputMassiv[nsig].T:=ttsmol*60;
        ImputMassiv[nsig].A:=E-fmPassivRadar.Po;
        ImputMassiv[nsig].Nff:=Target.Nf;
        ImputMassiv[nsig].Tay:=Target.Tay;
      end;
  if Target.Color=0 then                                          {Фрегат}
    begin
            for k:=0 to 47 do
            begin
              nsig:=nsig+1;
              if k = 0 then ImputMassiv[nsig].T:=ttsmol*60;
              if k > 0 then ImputMassiv[nsig].T:=ImputMassiv[nsig-1].T+0.0008;
              if ImputMassiv[nsig].T >= ttsek_ then goto MM1;
              ImputMassiv[nsig].Col:=TargetColors[Target.Color];
            end;
  ImputMassiv[0].A:=E-fmPassivRadar.Po;     ImputMassiv[0].Tay:=9;   ImputMassiv[0].Nff:=1;
  ImputMassiv[1].A:=E-fmPassivRadar.Po-500; ImputMassiv[1].Tay:=9;   ImputMassiv[1].Nff:=1;
  ImputMassiv[2].A:=E-fmPassivRadar.Po-500; ImputMassiv[2].Tay:=9;   ImputMassiv[2].Nff:=1;
  ImputMassiv[3].A:=E-fmPassivRadar.Po-5;   ImputMassiv[3].Tay:=1.2; ImputMassiv[3].Nff:=1;
  ImputMassiv[4].A:=E-fmPassivRadar.Po-5;   ImputMassiv[4].Tay:=1.2; ImputMassiv[4].Nff:=1;
  ImputMassiv[5].A:=E-fmPassivRadar.Po-5;   ImputMassiv[5].Tay:=1.2; ImputMassiv[5].Nff:=1;
  ImputMassiv[6].A:=E-fmPassivRadar.Po-500; ImputMassiv[6].Tay:=9;   ImputMassiv[6].Nff:=1;
  ImputMassiv[7].A:=E-fmPassivRadar.Po-500; ImputMassiv[7].Tay:=1.2; ImputMassiv[7].Nff:=1;
  ImputMassiv[8].A:=E-fmPassivRadar.Po-30;  ImputMassiv[8].Tay:=5;   ImputMassiv[8].Nff:=2;
  ImputMassiv[9].A:=E-fmPassivRadar.Po-500; ImputMassiv[9].Tay:=9;   ImputMassiv[9].Nff:=1;
  ImputMassiv[10].A:=E-fmPassivRadar.Po-500;ImputMassiv[10].Tay:=9;  ImputMassiv[10].Nff:=1;
  ImputMassiv[11].A:=E-fmPassivRadar.Po-10; ImputMassiv[11].Tay:=5;  ImputMassiv[11].Nff:=1;
  ImputMassiv[12].A:=E-fmPassivRadar.Po;    ImputMassiv[12].Tay:=1.2;ImputMassiv[12].Nff:=1;
  ImputMassiv[13].A:=E-fmPassivRadar.Po;    ImputMassiv[13].Tay:=1.2;ImputMassiv[13].Nff:=1;
  ImputMassiv[14].A:=E-fmPassivRadar.Po;    ImputMassiv[14].Tay:=1.2;ImputMassiv[14].Nff:=1;
  ImputMassiv[15].A:=E-fmPassivRadar.Po-5;  ImputMassiv[15].Tay:=9;  ImputMassiv[15].Nff:=1;
  ImputMassiv[16].A:=E-fmPassivRadar.Po-500;ImputMassiv[16].Tay:=9;  ImputMassiv[16].Nff:=1;
  ImputMassiv[17].A:=E-fmPassivRadar.Po-500;ImputMassiv[17].Tay:=9;  ImputMassiv[17].Nff:=1;
  ImputMassiv[18].A:=E-fmPassivRadar.Po-500;ImputMassiv[18].Tay:=9;  ImputMassiv[18].Nff:=1;
  ImputMassiv[19].A:=E-fmPassivRadar.Po-500;ImputMassiv[19].Tay:=1.2;ImputMassiv[19].Nff:=1;
  ImputMassiv[20].A:=E-fmPassivRadar.Po-500;ImputMassiv[20].Tay:=1.2;ImputMassiv[20].Nff:=1;
  ImputMassiv[21].A:=E-fmPassivRadar.Po-500;ImputMassiv[21].Tay:=1.2;ImputMassiv[21].Nff:=1;
  ImputMassiv[22].A:=E-fmPassivRadar.Po-500;ImputMassiv[22].Tay:=9;  ImputMassiv[22].Nff:=1;
  ImputMassiv[23].A:=E-fmPassivRadar.Po-25; ImputMassiv[23].Tay:=5;  ImputMassiv[23].Nff:=2;
  ImputMassiv[24].A:=E-fmPassivRadar.Po;    ImputMassiv[24].Tay:=9;  ImputMassiv[24].Nff:=1;
  ImputMassiv[25].A:=E-fmPassivRadar.Po-500;ImputMassiv[25].Tay:=9;  ImputMassiv[25].Nff:=1;
  ImputMassiv[26].A:=E-fmPassivRadar.Po-500;ImputMassiv[26].Tay:=9;  ImputMassiv[26].Nff:=1;
  ImputMassiv[27].A:=E-fmPassivRadar.Po-5;  ImputMassiv[27].Tay:=1.2;ImputMassiv[27].Nff:=1;
  ImputMassiv[28].A:=E-fmPassivRadar.Po-5;  ImputMassiv[28].Tay:=1.2;ImputMassiv[28].Nff:=1;
  ImputMassiv[29].A:=E-fmPassivRadar.Po-5;  ImputMassiv[29].Tay:=1.2;ImputMassiv[29].Nff:=1;
  ImputMassiv[30].A:=E-fmPassivRadar.Po-500;ImputMassiv[30].Tay:=1.2;ImputMassiv[30].Nff:=1;
  ImputMassiv[31].A:=E-fmPassivRadar.Po-500;ImputMassiv[31].Tay:=5;  ImputMassiv[31].Nff:=1;
  ImputMassiv[32].A:=E-fmPassivRadar.Po-500;ImputMassiv[32].Tay:=9;  ImputMassiv[32].Nff:=1;
  ImputMassiv[33].A:=E-fmPassivRadar.Po-500;ImputMassiv[33].Tay:=9;  ImputMassiv[33].Nff:=1;
  ImputMassiv[34].A:=E-fmPassivRadar.Po-500;ImputMassiv[34].Tay:=9;  ImputMassiv[34].Nff:=1;
  ImputMassiv[35].A:=E-fmPassivRadar.Po-10; ImputMassiv[35].Tay:=5;  ImputMassiv[35].Nff:=1;
  ImputMassiv[36].A:=E-fmPassivRadar.Po;    ImputMassiv[36].Tay:=1.2;ImputMassiv[36].Nff:=1;
  ImputMassiv[37].A:=E-fmPassivRadar.Po;    ImputMassiv[37].Tay:=1.2;ImputMassiv[37].Nff:=1;
  ImputMassiv[38].A:=E-fmPassivRadar.Po;    ImputMassiv[38].Tay:=1.2;ImputMassiv[38].Nff:=1;
  ImputMassiv[39].A:=E-fmPassivRadar.Po-5;  ImputMassiv[39].Tay:=9;  ImputMassiv[39].Nff:=1;
  ImputMassiv[40].A:=E-fmPassivRadar.Po-500;ImputMassiv[40].Tay:=5;  ImputMassiv[40].Nff:=2;
  ImputMassiv[41].A:=E-fmPassivRadar.Po-500;ImputMassiv[41].Tay:=9;  ImputMassiv[41].Nff:=1;
  ImputMassiv[42].A:=E-fmPassivRadar.Po-500;ImputMassiv[42].Tay:=9;  ImputMassiv[42].Nff:=1;
  ImputMassiv[43].A:=E-fmPassivRadar.Po-500;ImputMassiv[43].Tay:=5;  ImputMassiv[43].Nff:=1;
  ImputMassiv[44].A:=E-fmPassivRadar.Po-500;ImputMassiv[44].Tay:=1.2;ImputMassiv[44].Nff:=1;
  ImputMassiv[45].A:=E-fmPassivRadar.Po-500;ImputMassiv[45].Tay:=1.2;ImputMassiv[45].Nff:=1;
  ImputMassiv[46].A:=E-fmPassivRadar.Po-500;ImputMassiv[46].Tay:=1.2;ImputMassiv[46].Nff:=1;
  ImputMassiv[47].A:=E-fmPassivRadar.Po-25; ImputMassiv[47].Tay:=5;  ImputMassiv[47].Nff:=1;
  end;
          if Target.Color=4 then                                      {Позитив}
          begin
                      tot:=tot+1;
                      if tot >3  then begin tot:=1; mig:=mig+1;end;
                      if mig >3  then mig:=0;
                      if mig=0   then ImputMassiv[nsig].Nff:=1;
                      if mig=1 then
                      begin
                      ImputMassiv[nsig].Nff:=2;  ImputMassiv[nsig].A:=E-fmPassivRadar.Po-5;
                      end;
                      if mig=2 then
                      begin
                       ImputMassiv[nsig].Nff:=3; ImputMassiv[nsig].A:=E-fmPassivRadar.Po-10;
                      end;
                      if mig=3 then
                      begin
                       ImputMassiv[nsig].Nff:=4; ImputMassiv[nsig].A:=E-fmPassivRadar.Po-15;
                      end;
          end;
          if Target.Color=2 then
          begin
            ImputMassiv[nsig].T:=ImputMassiv[nsig].T+random*TF*60;
            ImputMassiv[nsig].Nff:=Random(4)+1;
                                      unr(x,y); fol:=3*y;
            ImputMassiv[nsig].A:=ImputMassiv[nsig].A+ fol;
                                      nos:=0.4*x;
            ImputMassiv[nsig].Tay:=ImputMassiv[nsig].Tay+nos;
            if ImputMassiv[nsig].Tay < 0 then ImputMassiv[nsig].Tay:=0;
          end;
       ImputMassiv[nsig].Col:=TargetColors[Target.Color];
       ImputMassiv[nsig].Pr:=false;
    end;
  end;
  MM1:
                          {сигнальный фрагмент сдвига времени между группами}
{    if Target.Color=4 then
      for i:=2 to nsig do
      if abs(ImputMassiv[i].Nff-ImputMassiv[i-1].Nff)>0 then
        for k:=i to nsig do
        ImputMassiv[k].T:=ImputMassiv[k].T+0.0005;       }

//  Target.TSignBeg1:=ttsmol-(tt+delta_t);         {новая нискочаст начальн фаза }

end;
procedure TfmPassivRadar.ChangePel;
var ll,kk:integer;
begin
  PTEK := PTEK+delta_p;                                            {тек пеленг}
  if ((PTEK >= PelMax) and (delta_p > 0)) or ((PTEK <= PelMin)
                                                             and (delta_p < 0))
  then
  begin
    Revers :=True;
    NumberRevers:=NumberRevers+1;
    if NumberRevers=12 then
                             NumberRevers:=1;
   delta_p := -delta_p;
   TRevers:=ttsek;                                         {фикс время реверса}
//    for kk:=0 to 20 do  for ll:=0 to 20 do  ReTayA[ll,kk].N:= ReTayA[ll,kk].N-10;
   with fmSigMatrix,fmSignTabel,canvas do
   begin
     Brush.color:= clWhite;
     for ll:=0 to 19 do
       for kk:=0 to 19 do
       begin
                                                          {устаревание матрицы Тау-А}
                         ReTayA[ll,kk].N:= ReTayA[ll,kk].N-10;
                           if ReTayA[ll,kk].N<=0  then  begin
                                                          Brush.color:= clWhite;
                                                          ReTayA[ll,kk].N:=0;
                                                        end;
                                 {  обновляем картинку с уменьшеными ReTayA[].N}
                           if ReTayA[ll,kk].N>20 then  Brush.color:= clBlack else
                           if ReTayA[ll,kk].N>10 then  Brush.color:= clGray else
                           if ReTayA[ll,kk].N>0  then  Brush.color:= clSilver;
                           if (kk < fmSigMatrix.fmSignTabel.Selection.Left) or
                              (kk > fmSigMatrix.fmSignTabel.Selection.Right)and
                              (ll > fmSigMatrix.fmSignTabel.Selection.Top)  or
                              (ll < fmSigMatrix.fmSignTabel.Selection.Bottom) then
                           FillRect(fmSignTabel.CellRect(ll,fmSignTabel.RowCount-kk-1));
       end;
                                                {перерисов область бланкирования}
              Brush.Color:=clMenu;
              for kk:=fmSigMatrix.fmSignTabel.Selection.Left to
                                      fmSigMatrix.fmSignTabel.Selection.Right do
              for ll:=fmSigMatrix.fmSignTabel.Selection.Top to
                                     fmSigMatrix.fmSignTabel.Selection.Bottom do
              FillRect(fmSignTabel.CellRect(kk,ll));
              Brush.Color:=clWhite;
  end;
                                                     {матрица пеленг-амплитуда}
   with fmSigMatrix,fmSignTabelTA,canvas do
  begin
    Brush.color:= clWhite;
     for ll:=0 to 19 do
       for kk:=0 to 19 do
                      FillRect(fmSignTabelTA.CellRect(ll{+1},kk{+1}));
  end;
  end  else
  Revers:=False;
                                                   {реверс}
end;

procedure TfmPassivRadar.SetDiap(ADiap: Integer);
begin
  if ADiap < 1{5} then ADiap := 5;
  Dia := ADiap;
  GPRLS := GPRLSs[Dia];
  BP := BPs[Dia];
  BPK := BPKs[Dia];
(*  if Panorama2.Down or Panorama3.Down then
  begin
  Po := Pos[Dia]; Po_:=Po; Po__:=Po;
  if fmManager.CU1.Down then
     begin
     if not(fmPassivRadar.Tuern.Down) then Po_:=1000000;
     if     fmPassivRadar.Tuern.Down  then Po:=1000000;
     end;
  end
   else
  begin
   Po := PosN[Dia];Po_:=Po; Po__:=Po;
    if fmManager.CU1.Down then
     begin
     if not(fmPassivRadar.Tuern.Down) then Po_:=1000000;
     if     fmPassivRadar.Tuern.Down  then Po:=1000000;
     end;
  end;    *)
 { if Tuern.Down then Po_:=100 else    Po_ := Pos[Dia]  ;    }
  HalfDN := Round(kX * BPK / 2);
end;

procedure TfmPassivRadar.DiapClick(Sender: TObject);
var
  ADiap: Integer;
begin
  ADiap := 1;
  if Diap1.Down then ADiap := 1 else
  if Diap2.Down then ADiap := 2 else
  if Diap3.Down then ADiap := 3 else
  if Diap4.Down then ADiap := 4 else
  if Diap5.Down then ADiap := 5;

  if Dia <> ADiap then
  begin
    DrawDN(PTEK);
    SetDiap(ADiap);
    DrawDN(PTEK);
  end;
  ScreenImage1.Repaint;
end;

procedure TfmPassivRadar.SectorClick(Sender: TObject);
begin
  DrawDN(PTEK);
  if Sector1.Down then Sek := 22.5 else
  if Sector2.Down then Sek := 45 else
  if Sector3.Down then Sek := 90 else
  if Sector4.Down then Sek := 11.25;

  PelMax:=PB+SEK/2;
  PelMin:=PB-SEK/2;
  DrawDN(PTEK);
  if (Carrier1 <> nil) and (DetTarget <> nil) then
       fmMap.PaintBox1.RePaint;
end;

procedure TfmPassivRadar.SpeedClick(Sender: TObject);
begin
  if Speed1.Down then WP := StrToFloat(Speed1.Caption) else
  if Speed2.Down then WP := StrToFloat(Speed2.Caption) else
  if Speed3.Down then WP := StrToFloat(Speed3.Caption) else
  if Speed4.Down then WP := StrToFloat(Speed4.Caption) else
  if Speed5.Down then WP := StrToFloat(Speed5.Caption) else
  if Speed6.Down then WP := StrToFloat(Speed6.Caption) else
  if Speed7.Down then WP := StrToFloat(Speed7.Caption) ;
//  if Speed5.Down and not Adupt.Down then  ScaleEdit.Value:=5 else
//  if Speed6.Down and not Adupt.Down then  ScaleEdit.Value:=5 else
//  if Speed7.Down and not Adupt.Down then  ScaleEdit.Value:=2 else
//  if not Adupt.Down then ScaleEdit.Value:=20;

  ScaleEditChange(Self);
end;

procedure TfmPassivRadar.ScaleEditChange(Sender: TObject);
var
  OldDelta_t : Extended;
begin
  OldDelta_t := Delta_t;
  try
    delta_t := abs(ScaleEdit.Value * Timer.Interval);
    delta_t := delta_t / 60 / 1000;
  except
     Delta_t         := OldDelta_t;
  end;

  if delta_p > 0 then delta_p :=  delta_t * WP * 60
                 else delta_p := -delta_t * WP * 60;
end;

procedure TfmPassivRadar.SwitchClick(Sender: TObject);
begin
  if not Switch.Down then begin
    SpeedClick(Self);
    DiapClick(Self);
    fmSWitch.Hide;
  end
        else fmSwitch.Show;
end;

procedure TfmPassivRadar.PanoramaClick(Sender: TObject);
begin
  if Panorama1.Down or Panorama3.Down then panoram := 1 else
  if Panorama2.Down then
  begin
    panoram := 0.17;
    if Diap4.Down or Diap5.Down then panoram := 0.5;
  end;

  if Panorama2.Down or Panorama3.Down then
  begin
    Po := Pos[Dia]; Po_:=Po; Po__:=Po;
  end
   else
  begin
    Po := PosN[Dia];Po_:=Po; Po__:=Po;
  end;
  if Tuern.Down then
  begin
                                    {после разворота}
   if Panorama3.Down or Panorama2.Down then Po_   := Pos[Dia]{-109;}
   else Po_   := PosN[Dia];
   Po__:=1000;    Po    := 1000;
                                     {выкл приема на время разворота}
   if tt<TimeTurn+1 then
   begin
    Po_:= 1000;
    Carrier2.Speed:=0;
   end;                              {восстановление пораметров после разворота}
   if (tt>TimeTurn+1) and (tt-delta_t<TimeTurn+1) then begin
     fmMap.P2SpeedEdit.Text := FloatTostr(Carrier1.Speed);
     fmMap.Set2ButtonClick(Self);                                                     {паузный режим работы}
   end;
//   if ((tt>1)and(tt<3.2))or((tt>4)and(tt<6.2))or((tt>7)and(tt<9.2)) then Po_ :=105;
  end                                                           {до разворота}
  else
  begin
     if fmManager.Probability.Down then
     begin
       Po__:=1000;  Po     :=1000;
     end;
     if fmManager.CU1.Down then
     begin
       Po_    := 1000; Po__:=1000;
     end;
      if fmManager.CU2.Down then
     begin
       Po__:=1000;
     end;
  end;
//   if delta_p<0 then begin Po_:=1000; Po:=1000; end;
                         {прекращение приема после выдачи в оружие}
  if DateOut.Checked=True then
  begin
   Po_:=1000; Po:=1000; Po__:=1000;
  end;
end;

procedure TfmPassivRadar.PBButtonClick(Sender: TObject);
var
  P: Integer;
begin
  if Sender <> DetTargetGrid then begin
    DrawDN(PTEK);
    PB := PTek;
  end;
  with HorScrollBar do begin
    P := Round(Max * (0.5 + PB / 260));
    if P < 0 then P := 0;
    if P > Max then P := Max;
    PB := 260*(P/Max - 0.5);
    Scrolling := P <> Position;
  end;
  DrawDN(PTEK);
  DetTargetGrid.Repaint;
  SectorClick(Self);
end;

procedure TfmPassivRadar.PauseButtonClick(Sender: TObject);
begin
  Timer.Enabled:= not (Timer.Enabled);
end;

procedure TfmPassivRadar.EnterClick(Sender: TObject);

var
  st: string;
  n,X,nc,k11,k12,ll,kk,Targ,Tar:integer;
  x1,y1:Float;
  Target: TTarget;

begin
  //---------------------
//////   Cript;
    if Assigned(fmStatistic) then
    begin
      if fmManager.Probability.Down or fmManager.Cu1.Down then    fmStatistic.ttMax:=40 else
                                                                  fmStatistic.ttMax:=20;
      with fmStatistic.PeImage do    fmStatistic.kXpe:=Width/(fmStatistic.ttmax-ttmin);
      with fmStatistic.DiImage do    fmStatistic.kXDi:=Width/(fmStatistic.ttmax-ttmin);
    end;
    if Assigned(fmSgPeleng) then fmSgPeleng.hide;
  PauseButton.Enabled := True;
  ScaleEdit.Value:=20;
  Ot:=nil; Ot_:=nil; Ot0:=nil; Ot0_:=nil;
// SetLength(Ot0,10{TargetList.Count},fmPassivRadar.EdCopy.Value);
// SetLength(Ot,10{TargetList.Count},40{Target.psh25[nc]},fmPassivRadar.EdCopy.Value);
  delta_p:=-abs(delta_p); {определяет начальное движен диаграммы влевопри повт наж}
  NumberRevers:=1;
  NumberDiaTarget :=5;                             {число работающих диапазонов}
  CurrentTablePos := -1;                           {Начальная текущая позиция в таблице EXEL` }
  Tuern.Down:=False;
  ArS:=50000;
  if Assigned(fmSelect) then
     if fmSelect.SelectOn.Checked = True then
     EdCopy.Value := 1;
  if EdCopy.Value = 1 then
    SetLength(pImputMassiv,fmPassivRadar.EdCopy.Value+1,50001)
                         else
    SetLength(pImputMassiv,fmPassivRadar.EdCopy.Value+1,1);
//  for kk:=0 to 20 do  for ll:=0 to 20 do  ReTayA[ll,kk].N:=0;
                            {обнуляяем ИРО Тау-А}
  if Assigned(fmSigMatrix) then
  with fmSigMatrix,fmSignTabel,canvas do
  begin
    Brush.Color:=clWhite;
    for kk:=0 to ColCount do
      for ll:=0 to RowCount do begin
      ReTayA[ll,kk].N:=0;
      FillRect(fmSigMatrix.fmSignTabel.CellRect(kk,ll));
      fmSigMatrix.fmSignTabel.Repaint;
      end;

  end;
  if Assigned(fmSwitch) then
  if  Switch.Down then
    begin
      SetDiap(5);DiapButtons[5].Down := true;
      if fmSwitch.MGP.Checked then  Speed4.Down:=True;
      if fmSwitch.FastScan.Checked    then  Speed5.Down:=True;
      if fmSwitch.MGPTimeDiap.Checked then  Speed4.Down:=True;
    end;
  if EdCopy.Value=1 then                              {если вкл селекция}
  for k11 :=1 to fmPassivRadar.EdCopy.Value do
  for k12 :=0 to ArS do
  with pImputMassiv[k11,k12] do
  begin
            T  :=0;    A:=0;  Tay:=0;  Pe:=0;
            Nff:=0;
            Pr :=False;
  end;

         with fmPassivRadar,Canvas do
         for k12:=0 to 12  do
           for k11:=0 to 15 do
         TextOut(k11*50,340+k12*15,'                             ');

  if Assigned(TargetList) and (TargetList.Count > 0) then
  for Tar := 0 to TargetList.Count - 1 do
  begin
      Target := TTarget(TargetList.Items[Tar]);
      with Target do
      begin
        X := X0; Y := Y0;          {ввод нач координат заданн в редак при tt=0}
        nilling;
      end;
                      {для искл дребезга при повторн нажат Enter}
      Target.ttzip_p:=Target.tt_p; Target.przip_:=Target.pr_;
      Target.pezip_:=Target.pe_; Target.dizip_:=Target.di_;Target.dizip_1:=Target.di_1;
  end;
  if EdCopy.Value=1 then                              {если вкл селекция}
  if NamberEnter > 0 then
  for nc:=1 to fmPassivRadar.EdCopy.Value do
  begin
        pListDN.Clear;                pListDN.Free;
        p_ListDN.Clear;               p_ListDN.Free;
        p__ListDN.Clear;              p__ListDN.Free;
        pListFinishPacet.Clear;       pListFinishPacet.Free;
        pListCurrentPach.Clear;       pListCurrentPach.Free;
        pListFinishPach.Clear;        pListFinishPach.Free;
        pListCurrentTargetProb.Clear; pListCurrentTargetProb.Free
  end;
        pListDN:=TList.Create;
        p_ListDN:=TList.Create;
        p__ListDN:=TList.Create;
        pListFinishPacet:=TList.Create;
        pListCurrentPach:=TList.Create;
        pListFinishPach :=TList.Create;
        pListCurrentTargetProb :=TList.Create;
//        pListDN:=TList.Create;   SetLength(pListDN,fmTargetEdit.EdCopy.Value+1);
  //      p_ListDN:=TList.Create;       SetLength(p_ListDN,fmTargetEdit.EdCopy.Value+1);
    //    pListFinishPacet:=TList.Create;  SetLength(pListFinishPacet,fmTargetEdit.EdfmPassivRadar.EdCopy.Value.Value+1);
      //  pListCurrentPach:=TList.Create;   SetLength(pListCurrentPach,fmTargetEdit.EdCopy.Value+1);
       // pListFinishPach :=TList.Create;    SetLength(pListFinishPach,fmTargetEdit.EdCopy.Value+1);
        //pListCurrentTargetProb :=TList.Create;   SetLength(pListCurrentTargetProb,fmTargetEdit.EdCopy.Value+1);

{   if Carrier2 <> nil then
     begin
       Carrier2.Free;
       Carrier2 := nil;
     end;

   if Carrier1 <> nil then
     begin
       Carrier1.Free;
       Carrier1 := nil;
     end;

   if Carrier3 <> nil then
     begin
       Carrier3.Free;
       Carrier3 := nil;
     end;}


   {if Carrier1 <> nil then Carrier1.free;
   if Carrier2 <> nil then Carrier2.free;
   if Carrier3 <> nil then Carrier3.free;}

   Carrier1 := nil;
   Carrier2 := nil;
   Carrier3 := nil;

   Carrier1:=TCarrier.CreateMoveObject (-30,0,0.025,0,1,0);    {0.925=30 узлов}
   Carrier2:=TCarrier.CreateMoveObject (0,0,0.025,0,1,0);
   Carrier3:=TCarrier.CreateMoveObject (30,0,0.025,0,1,0);

  //****************************************************************
  //*******************  Standard Carrier Position *****************
  //****************************************************************
  if fmManager.Probability.Down and StandardCarrierPosition then
  begin
    if Assigned(fmStatisticProb) then fmStatisticProb.Show;
     Carrier2.X0:=0;     Carrier2.Y0:=-Dsm1;
    Carrier2.X:=0;     Carrier2.Y:=-Dsm1;    Carrier2.H:=0.025;  Carrier2.Kurs:=0;
    Carrier2.Speed:=0; Carrier2.Ptek:=0;

    Carrier1.Free; Carrier1 := Carrier2;
    Carrier3.Free; Carrier3 := Carrier2;

  end;
  if  fmManager.CU1.Down and StandardCarrierPosition then
  begin
    if Assigned(fmMap) then
    //fmMap.GroupBox2.Visible:=False;
    if Assigned(fmStatisticProb) then fmStatisticProb.Hide;
    Carrier1.X0:=0;     Carrier1.Y0:=-Dsm1;
    Carrier1.X:=0;     Carrier1.Y:=-Dsm1;    Carrier1.H:=0.025;  Carrier1.Kurs:=90;
    Carrier1.Speed:=0.925; Carrier1.Ptek:=0;
    Carrier2.X0:=0;     Carrier2.Y0:=-Dsm1;
    Carrier2.X:=0;     Carrier2.Y:=-Dsm1;    Carrier2.H:=0.025;  Carrier2.Kurs:=90;
    Carrier2.Speed:=0.925; Carrier2.Ptek:=0;

  //  Carrier2:=Carrier1;
    Carrier3.Free;
    Carrier3 := Carrier2;
  end;

  if fmManager.CU2.Down  and StandardCarrierPosition then begin
     if Assigned(fmStatisticProb) then fmStatisticProb.Hide;
     Carrier1.X0:=0;     Carrier1.Y0:=-Dsm1;
     Carrier1.X:=-15;     Carrier1.Y:=-Dsm1;    Carrier1.H:=0.025;  Carrier1.Kurs:=0;
     Carrier1.Speed:=0.925; Carrier1.Ptek:=0;
     Carrier2.X0:=0;     Carrier2.Y0:=-Dsm1;
     Carrier2.X:=15;     Carrier2.Y:=-Dsm1;    Carrier2.H:=0.025;  Carrier2.Kurs:=0;
     Carrier2.Speed:=0.925; Carrier2.Ptek:=0;

     Carrier3.Free;
     Carrier3 := Carrier2;
  end;

  if fmManager.CU3.Down  and StandardCarrierPosition then begin
      if Assigned(fmStatisticProb) then fmStatisticProb.Hide;
      Carrier1.X0:=0;     Carrier1.Y0:=-Dsm1;
      Carrier1.X:=-30;     Carrier1.Y:=-Dsm1;    Carrier1.H:=0.025;  Carrier1.Kurs:=0;
      Carrier1.Speed:=0.925; Carrier1.Ptek:=0;
      Carrier2.X0:=0;     Carrier2.Y0:=-Dsm1;
      Carrier2.X:=0;     Carrier2.Y:=-Dsm1;    Carrier2.H:=0.025;  Carrier2.Kurs:=0;
      Carrier2.Speed:=0.925; Carrier2.Ptek:=0;
      Carrier3.X0:=0;     Carrier3.Y0:=-Dsm1;
      Carrier3.X:=30;     Carrier3.Y:=-Dsm1;    Carrier3.H:=0.025;  Carrier3.Kurs:=0;
      Carrier3.Speed:=0.925; Carrier3.Ptek:=0;
  end;
  //****************************************************************
  //*******************  Not Standard Carrier Position *****************
  //****************************************************************
  if fmManager.Probability.Down  and not StandardCarrierPosition then
  begin
    if Assigned(fmStatisticProb) then fmStatisticProb.Show;
    Carrier2.X0    := StrToFloat(fmMap.p1XEdit.text);
    Carrier2.X     := Carrier2.X0;
    Carrier2.Y0    := StrToFloat(fmMap.p1YEdit.text);
    Carrier2.Y     := Carrier2.Y0;
    Carrier2.H     := 0.025;
    Carrier2.Kurs  := StrToFloat(fmMap.p1KursEdit.text);
    Carrier2.Speed := StrToFloat(fmMap.p1SpeedEdit.text);
    Carrier2.Ptek  :=0;

    Carrier1.Free; Carrier1 := Carrier2;
    Carrier3.Free; Carrier3 := Carrier2;
  end;
  if  (fmManager.CU1.Down or fmManager.CU2.Down) and not StandardCarrierPosition then
  begin
    if Assigned(fmMap) then
    //fmMap.GroupBox2.Visible:=False;
    if Assigned(fmStatisticProb) then fmStatisticProb.Hide;
    Carrier1.X0    := StrToFloat(fmMap.p1XEdit.text);
    Carrier1.X     := Carrier1.X0;
    Carrier1.Y0    := StrToFloat(fmMap.p1YEdit.text);
    Carrier1.Y     := Carrier1.Y0;
    Carrier1.H     := 0.025;
    Carrier1.Kurs  := StrToFloat(fmMap.p1KursEdit.text);
    Carrier1.Speed := StrToFloat(fmMap.p1SpeedEdit.text);
    Carrier1.Ptek  := 0;

    Carrier2.X0    := StrToFloat(fmMap.p2XEdit.text);
    Carrier2.X     := Carrier2.X0;
    Carrier2.Y0    := StrToFloat(fmMap.p2YEdit.text);
    Carrier2.Y     := Carrier2.Y0;
    Carrier2.H     := 0.025;
    Carrier2.Kurs  := StrToFloat(fmMap.p2KursEdit.text);
    Carrier2.Speed := StrToFloat(fmMap.p2SpeedEdit.text);
    Carrier2.Ptek  :=0;
  //  Carrier2:=Carrier1;
    Carrier3.Free;
    Carrier3 := Carrier2;
  end;

  if fmManager.CU3.Down  and not StandardCarrierPosition then begin
      if Assigned(fmStatisticProb) then fmStatisticProb.Hide;
      Carrier1.X0    := StrToFloat(fmMap.p1XEdit.text);
      Carrier1.X     := Carrier1.X0;
      Carrier1.Y0    := StrToFloat(fmMap.p1YEdit.text);
      Carrier1.Y     := Carrier1.Y0;
      Carrier1.H     := 0.025;
      Carrier1.Kurs  := StrToFloat(fmMap.p1KursEdit.text);
      Carrier1.Speed := StrToFloat(fmMap.p1SpeedEdit.text);
      Carrier1.Ptek  := 0;

      Carrier2.X0    := StrToFloat(fmMap.p2XEdit.text);
      Carrier2.X     := Carrier2.X0;
      Carrier2.Y0    := StrToFloat(fmMap.p2YEdit.text);
      Carrier2.Y     := Carrier2.Y0;
      Carrier2.H     := 0.025;
      Carrier2.Kurs  := StrToFloat(fmMap.p2KursEdit.text);
      Carrier2.Speed := StrToFloat(fmMap.p2SpeedEdit.text);
      Carrier2.Ptek  :=0;

      Carrier3.X0    := StrToFloat(fmMap.p3XEdit.text);
      Carrier3.X     := Carrier3.X0;
      Carrier3.Y0    := StrToFloat(fmMap.p3YEdit.text);
      Carrier3.Y     := Carrier3.Y0;
      Carrier3.H     := 0.025;
      Carrier3.Kurs  := StrToFloat(fmMap.p3KursEdit.text);
      Carrier3.Speed := StrToFloat(fmMap.p3SpeedEdit.text);
      Carrier3.Ptek  :=0;
  end;

    //-----  Вводим в начальные данные для Edito-v Map_Unit ----
   fmMap.P1KursEdit.Text  := floatToStr(Carrier1.Kurs);
   fmMap.P1SpeedEdit.Text := floatToStr(Carrier1.Speed);
   fmMap.P1XEdit.Text     := floatToStr(Carrier1.X);
   fmMap.P1YEdit.Text     := floatToStr(Carrier1.Y);

   fmMap.P2KursEdit.Text  := floatToStr(Carrier2.Kurs);
   fmMap.P2SpeedEdit.Text := floatToStr(Carrier2.Speed);
   fmMap.P2XEdit.Text     := floatToStr(Carrier2.X);
   fmMap.P2YEdit.Text     := floatToStr(Carrier2.Y);

   fmMap.P3KursEdit.Text  := floatToStr(Carrier3.Kurs);
   fmMap.P3SpeedEdit.Text := floatToStr(Carrier3.Speed);
   fmMap.P3XEdit.Text     := floatToStr(Carrier3.X);
   fmMap.P3YEdit.Text     := floatToStr(Carrier3.Y);
 
   //-----  End Of 'Вводим в начальные данные для Edito-v Map_Unit' ----
 // ttzip:=0;
  TimeTurn:=0;
  tt := 0;  ttsek:=0;                                          {начальное время}
  st1:=0;
  delta_t_st:=0.2; delta_t_stt:=0.2; {начальный момент выдачи данных статистики}
  Ptek:=0;   {установка нулевого положения при повтрных нажатиях клав Enter}
  PtekZip:=0;
  Sector1.Down:=True;
  PBButtonClick(self);
  Adupt.Down:=false;
  Timer.Enabled := true;                                      {запуск  таймера}
  NamberEnter := NamberEnter+1;     {счетч числа запусков устан при созд формы}
  Tuern.Down :=false;                               {отжатие клавиши разворота}
  DateOut.Checked:=false;                      {Снятие признака выдачи в оружие}
  with ScreenImage do
  with Canvas do
  begin
      Brush.Color := clWhite;
      FillRect(ClientRect);                           {рисов 1 ДНА для стирания}
      Pen.Color := clBlack;
      ScreenImage1.Canvas.Brush.Color := clWhite;
      ScreenImage1.Canvas.FillRect(ClientRect);
      ScreenImage1.Canvas.Pen.Color := clBlack;
      MoveTo(0, Round(Height / 2));              {рисов гор линии по центру экр}
      LineTo(Width, Round(Height / 2));
      ScreenImage1.Canvas.MoveTo(0, Round(Height / 2));
      ScreenImage1.Canvas.LineTo(Width, Round(Height / 2));
      for n := 1 to 73 do
      begin                                      {рисов делений шкалы по центру}
        X := Round(n* Width / 72);
        MoveTo(X, Round(Height / 2) - 4);
        LineTo(X, Round(Height / 2) + 4);
        ScreenImage1.Canvas.MoveTo(X, Round(Height / 2) - 4);
        ScreenImage1.Canvas.LineTo(X, Round(Height / 2) + 4);
      end;
    for n := 0 to 8 do
    begin                                       {рисов значений шкалы по центру}
        X := Round(n * Width / 8);
        MoveTo(X, Round(Height / 2) - 10);
        LineTo(X, Round(Height / 2) + 10);
        ScreenImage1.Canvas.MoveTo(X, Round(Height / 2) - 10);
        ScreenImage1.Canvas.LineTo(X, Round(Height / 2) + 10);
        if n < 4 then St := IntToStr(45*n + 180)
                 else St := IntToStr(45*n - 180);
        if X + 2 + TextWidth(St) > Width then X := Width - TextWidth(St) - 2;
        TextOut(X + 2, Round(Height / 2) + 4, St);
        TextOut(X + 2, Round(Height / 2) + Font.Height - 4, St);
        ScreenImage1.Canvas.TextOut(X + 2, Round(Height / 2) + 4, St);
        ScreenImage1.Canvas.TextOut(X + 2,Round(Height / 2) + Font.Height -4,St);
    end;
  end;
  if NamberEnter>1 then
  begin
    fmOnePeleng.SetParam(0);
    fmSgPeleng .PreSet();
    With fmStatistic.ProbImage  do  With Canvas do
    begin
      Brush.Color := clWhite;      FillRect(ClientRect);
    end;
    With fmStatisticProb.ProbImage  do  With Canvas do
    begin
      Brush.Color := clWhite;      FillRect(ClientRect);
    end;
    With fmStatistic.PeImage  do  With Canvas do
    begin
      Brush.Color := clWhite;      FillRect(ClientRect);
    end;
    With fmStatisticUpr.PeImage  do  With Canvas do
    begin
      Brush.Color := clWhite;      FillRect(ClientRect);
    end;
    With fmStatistic.DiImage  do  With Canvas do
    begin
      Brush.Color := clWhite;      FillRect(ClientRect);
    end;
    With fmStatisticUpr.DiImage  do  With Canvas do
    begin
      Brush.Color := clWhite;      FillRect(ClientRect);
    end;
    With fmStatistic.Di1Image  do  With Canvas do
    begin
      Brush.Color := clWhite;      FillRect(ClientRect);
    end;
  end;
  DrawDN(PTEK);
  if Assigned(DetTarget)then
  begin
    DetTarget.Clear;
    DetTargetGrid.Repaint;
  end;
end;

procedure TfmPassivRadar.DrawRealTarget(Peleng, D: Real; Color: TColor);
var
  X, Y: Integer;
begin
  with ScreenImage do
    with Canvas do
    begin
      X := round(Xc + kX * Peleng);
      Y := Height - round(kY * (D-Dmin));
      Pen.Color := Color;
      Brush.Color := Color;
      Ellipse(X - 1, Y - 1, X + 1, Y + 1);
    end;
end;

procedure TfmPassivRadar.DrawScanTarget(Peleng, D: Real; Color: TColor);
var
  X, Y: Integer;
begin
  with ScreenImage do
  with Canvas do
    begin
      X := Round(Xc + kX * Peleng);
      Y := Height - Round(kY * (D-Dmin));
      Brush.Color := Color;
      Pen.Color := clBlack;
      Ellipse(X - 3, Y - 3, X + 3, Y + 3);
    end;

    with ScreenImage1.Canvas do
    begin
      Brush.Color := Color;
      Pen.Color := clBlack;
      Ellipse(X - 3, Y - 3, X + 3, Y + 3);
    end;
end;

procedure TfmPassivRadar.DrawDN(Peleng: Float);
var
  X: Integer;
  ActiveImage: TImage;
begin
{  if Sector1.Down then Sek := StrToFloat(Sector1.Caption) else
  if Sector2.Down then Sek := StrToFloat(Sector2.Caption) else
  if Sector3.Down then Sek := StrToFloat(Sector3.Caption);}


  if ScreenImage.Visible then ActiveImage := ScreenImage
                         else ActiveImage := ScreenImage1;
  with ActiveImage do
    with Canvas do
    begin
      Pen.Mode := pmXor;
      Pen.Color := clSilver xor clWhite;
      X := Round(Xc + (PB + Sek/2)* kX);
      MoveTo(X , 2); LineTo(X, Height - 2);
      X := Round(Xc + (PB - Sek/2)* kX);
      MoveTo(X , 2); LineTo(X, Height - 2);

      Pen.Color := clRed xor clWhite;
      X := Round(Xc + Peleng * kX);
      MoveTo(X - HalfDN, 2); LineTo(X - HalfDN, Height - 2);
      MoveTo(X + HalfDN, 2); LineTo(X + HalfDN, Height - 2);
      Pen.Mode := pmCopy;
    end;
end;
  function Comp(Item1,Item2:Pointer):Integer;
  begin
   if PSig(Item1)^.T<PSig(Item2)^.T then
     Result:=-1 else
   if PSig(Item1)^.T>PSig(Item2)^.T then
     Result:=1  else
     Result:=0;
  end;

procedure TfmPassivRadar.Cannal(Target: TTarget; Carrier :TCarrier;
      var DTRMED,sigmaDTRL,sigmaDTRF,DTRT1:Float);
  var
      x,y,ae,C8,C3,{C33,}C4,C6,D,De,DDM,MN310 :Float;
  begin
     case Target.Diap of
      1:  DTRT1 := 0.25;      2:  DTRT1 :=  0.3;      3:  DTRT1 :=  0.5;
      4:  DTRT1 :=    1;      5:  DTRT1 :=    2;
     end;
//    C33:=0.4343*ln(Target.lamda*0.01);
    C3:=0.4343*ln(Target.lamda);
    C4:=100*(1+C3);
    ae:=6700/(1-0.046658*exp(0.005577*(277.5+25*Target.rn)));{экв рад Земли}
    C8:=sqrt(2*ae/1000);
    D:=Hypot(Target.X-Carrier.X, Target.Y-Carrier.Y);
    De:=D-{4.12}C8*(sqrt(Target.H*1000)+sqrt(Carrier.H*1000));
                                               {дальность за радиогоризонтом}
        if DE<200             then sigmaDTRL:=7.5;            { Гусятинский}
        if(De>=200)and(De<300)then sigmaDTRL:=6;
        if(De>=300)and(De<400)then sigmaDTRL:=5;
        if(De>=400)and(De<500)then sigmaDTRL:=4.5;
        if De>=500            then sigmaDTRL:=3.7;
                                                                {КАНАЛ ДТР}
    sigmaDTRF:=6;                                             {ско быстрых}
                                                        {полн множит ослаб}
                           {Введенский,но для дальности за радиогоризонтом}
    if De<=C4 then MN310:=10*C3-0.05*De-74 {ближняя зона  N=310}
             else MN310:= -64-0.15*De-C3*(4.3*C3-0.043*De-15.7);

                                                     {дальняя зона  N=310)}
//    if D<>0 then
    C6:=8.686*ln(D*1000);                              {свободн простр    }
                                                         {попр на метео   }
    if De<=350 then DDM := (-32.5+Target.rn*25)*(0.93-0.00163*De)
               else DDM := (-32.5+Target.rn*25)*(0.5-0.0004*De);
    if De>0 then
    begin
        if fmTargetEdit.Vvedensky.Checked then
        begin
            DTRMED    := MN310+DDM-C6;                                        {при ДТР}
            //Target.rn := Trunc(DTRMED);
        end;
        if fmTargetEdit.Sharigin.Checked then
        begin
            CoordinateRedBitmapX    := GetXSeasonMap(CenterXMinute);
            CoordinateRedBitmapY    := GetYSeasonMap(RealCenterYMinute);
            DTRMED := GetDepressionCoefficient(CoordinateRedBitmapX,
                                  CoordinateRedBitmapY, De, Target.lamda) - C6;
        end;
//            Target.Depression := Trunc(DTRMED)-11;
        //DTRMED := WaveDepression.CalcWaveDepression (D , )-C6         {при ДТР}
    end   else DTRMED:=-C6;                 {в условиях прямой видимости}
            Target.Depression := Trunc(DTRMED)-11;
  end;

procedure TfmPassivRadar.NonLineApr(Target: TTarget;var Targ,nc,sh25:integer);
label MM32;
var
  NP,ind,indD,indP0,indVt,indKt,indab,indab0,indKtend:integer;
  D0,deltaD,P0,deltaP,Vt0,deltaVt,Kt0,deltaKt,FU,FU1,bob,bob1,kil,XTt,YTt,
  XTsh25,YTsh25,deltaVV,BPKhalphSq,SiKt0,CoKt0,X,Y,a,St,beta,alfa,fi,B,gamma :
                                                                        Float;
begin
  if sh25=1 then
  begin
    Target.ModelT[nc]:=tt;
  end;
  begin
    BPKhalphSq:=BPK*BPK*rad*rad/4;
    FU1:=10000000000;
    deltaP:=rad*0.2;   NP:=trunc(rad*BPK/deltaP);
           {с запасом 10 на срыв сопровожд т к от обзора к обзору пеленг может}
          { существенно измениться}
    if sh25 < 59 then
//      if tt< 3 then
    begin
   //   D0:=80; deltaD:=10;
        D0:=135; deltaD:=2;
      ind:=30;
    end else
    begin
      D0:= Target.ModelD[nc]*0.5;
      deltaD:=D0/30;        ind:=60;
    end;
    for indD:=1 to ind do
    begin
        D0:= D0+deltaD;
        P0:=( fmPassivRadar.Ot_[Targ,sh25-1,nc-1].Pel-rad*(BPK/2));
      for indP0:=1 to NP do
      begin
        P0:=P0+deltaP;
        Vt0:=0.8;              deltaVt:=0.02;
                                               {Х-коорд цели на последн момент}
        XTsh25:=fmPassivRadar.Ot_[Targ,sh25-1,nc-1].Xp+D0*Sin(P0);
                                                  {У-коорд цели на посл момент}
        YTsh25:=fmPassivRadar.Ot_[Targ,sh25-1,nc-1].Yp+D0*Cos(P0);
        for indVt:=1 to 20 do
        begin
          Vt0:=Vt0+deltaVt;
          if sh25 < 59 then
//            if tt <3 then
          begin
          Kt0:=0;          deltaKt:=5*rad;                            {1 градус}
          indKtend:=72;
          end else
          begin
          Kt0:= Target.ModelK[nc]-12*rad;
          deltaKt:=rad;
          indKtend:=24;
          end;
          for indKt:=1 to  indKtend do
          begin
            Kt0:=Kt0+deltaKt;
            FU:=0; bob:=0;                       {скользящее окно по 8 отсчетам}
//                if sh25 <= 8 then indab0:=1 else indab0:=sh25-7;
            for indab:={indab0}1 to sh25 do
            begin
                                                    {интрв врем до предид отсч}
              deltaVV:=Vt0*(tt-fmPassivRadar.Ot_[Targ,indab-1,nc-1].t);
                                                   {Х-коорд цели предид отсчета}
              XTt:=XTsh25-Sin(Kt0)*deltaVV;
                                                    {У-корд цели предид отсчета}
              YTt:=YTsh25-Cos(Kt0)*deltaVV;
                                               {модельный пеленг предид отсчета}
              X:=XTt-fmPassivRadar.Ot_[Targ,indab-1,nc-1].Xp;   Y:=YTt-fmPassivRadar.Ot_[Targ,indab-1,nc-1].Yp;
              kil:=arctan2(y,x);
              if y<0 then kil:=1.5707963-kil else          {0.5*pi}
                if X>=0 then kil:=1.5707963-kil else
                kil:=7.8539815-kil;        {2.5*pi}
                                            {отклонение измер пел от модельного}
              bob:= fmPassivRadar.Ot_[Targ,indab-1,nc-1].Pel-kil;
              bob1:=bob*bob;
                                        {выход из цикла при откл более пол ШДНА}
              if bob1 > BPKhalphSq then goto MM32;
              FU:=FU+bob1;
            end;
            if (FU < FU1) and (sh25>1) then
            begin
              FU1:=FU;
              Target.ModelD[nc]:=D0;
              Target.ModelP[nc]:=P0;
              Target.ModelV[nc]:=Vt0;
              Target.ModelK[nc]:=Kt0;
            end;
MM32:     end;
        end;
      end;
    end;
  end;
end;                                          {сглаж отселлектированных пачек}
                                                {правильность надо проверить}
procedure TfmPassivRadar.NonLineAprTargetProb(var TargetProb:PoTarget;
                                   var nc:integer;ListCurrentTargetProb: TList);
label MM32;
var
  NP,ind,indD,indP0,indVt,indKt,indab,indab0,indKtend,
  ii:integer;
  D0,deltaD,P0,deltaP,Vt0,deltaVt,Kt0,deltaKt,FU,FU1,bob,bob1,kil,XTt,YTt,XTsh25,
  YTsh25,deltaVV,BPKhalphSq,SiKt0,CoKt0,X,Y,a,St,beta,alfa,fi,B,gamma :Float;
begin
   if ListCurrentTargetProb.Count>0 then             {ес спис незав целей наполн}
      for ii:=0 to ListCurrentTargetProb.Count-1 do    {то орг цикл по незав цел}
      if ii<=ListCurrentTargetProb.Count-1 then
 begin
      TargetProb:=ListCurrentTargetProb.Items[ii];
  if TargetProb^.N=1 then
  begin
    TargetProb^.ModelT[nc]:=tt;
  end;
  begin
    BPKhalphSq:=BPK*BPK*rad*rad/4;
    FU1:=10000000000;
    deltaP:=rad*0.2;   NP:=trunc(rad*BPK/deltaP);
    if TargetProb^.N < 9 then
    begin
      D0:=80; deltaD:=10;   ind:=30;
    end else
    begin
      D0:= TargetProb^.ModelD[nc]*0.5;
      deltaD:=D0/30;        ind:=60;
    end;
    for indD:=1 to ind do
    begin
        D0:= D0+deltaD;
        P0:=(TargetProb^.Pel[TargetProb^.N]-rad*(BPK/2));
      for indP0:=1 to NP do
      begin
        P0:=P0+deltaP;
        Vt0:=8.8;              deltaVt:=0.2;
                                               {Х-коорд цели на последн момент}
        XTsh25:=TargetProb^.Xp[TargetProb^.N]+D0*Sin(P0);
                                                  {У-коорд цели на посл момент}
        YTsh25:=TargetProb^.Yp[TargetProb^.N]+D0*Cos(P0);
        for indVt:=1 to 10 do
        begin
          Vt0:=Vt0+deltaVt;
          if TargetProb^.N < 9 then
          begin
          Kt0:=0;          deltaKt:=5*rad;                            {1 градус}
          indKtend:=72;
          end else
          begin
            Kt0:= TargetProb^.ModelK[nc]-12*rad;
            deltaKt:=rad;
            indKtend:=24;
          end;
          for indKt:=1 to  indKtend do
          begin
            Kt0:=Kt0+deltaKt;
            FU:=0; bob:=0;                       {скользящее окно по 8 отсчетам}
 //               if TargetProb^.N <= 8 then indab0:=1 else indab0:=TargetProb^.N-7;
            for indab:={indab0}1 to TargetProb^.N do
            begin
                                                    {интрв врем до предид отсч}
              deltaVV:=Vt0*(tt-TargetProb^.T[indab]);
                                                   {Х-коорд цели предид отсчета}
              XTt:=XTsh25-Sin(Kt0)*deltaVV;
                                                    {У-корд цели предид отсчета}
              YTt:=YTsh25-Cos(Kt0)*deltaVV;
                                               {модельный пеленг предид отсчета}
              X:=XTt-TargetProb^.Xp[indab];   Y:=YTt-TargetProb^.Yp[indab];
              kil:=arctan2(y,x);
              if y<0 then kil:=1.5707963-kil else          {0.5*pi}
                if X>=0 then kil:=1.5707963-kil else
                kil:=7.8539815-kil;        {2.5*pi}
                                            {отклонение измер пел от модельного}
              bob:= TargetProb^.Pel[indab]-kil;
              bob1:=bob*bob;
                                        {выход из цикла при откл более пол ШДНА}
              if bob1 > BPKhalphSq then goto MM32;
              FU:=FU+bob1;
            end;
            if (FU < FU1) and (TargetProb^.N>1) then
            begin
              FU1:=FU;
              TargetProb^.ModelD[nc]:=D0;
              TargetProb^.ModelP[nc]:=P0;
              TargetProb^.ModelV[nc]:=Vt0;
              TargetProb^.ModelK[nc]:=Kt0;
            end;
MM32:     end;
        end;
      end;
    end;
  end;
 end;
end;
procedure TfmPassivRadar.Peleng(Target: TTarget;IndCarrier : integer;Carrier:TCarrier; nc:integer;
                  var ListDN :TList;
                  var { nc,}dd0,l, sh25, sh1:  integer;
                  var {TSignBeg1,}VM,SigLow,a21,a22,a211,a212,a222,b21,b22,b23,
                  {ttprov,}PI, SHPEL, SHPEL0, D,H,
                  P002,PWIP2,AAA,BBB,CCC,Po: Float);

label M1,MM25,MM35;
  type
  vector=array[1..3,1..3] of real;
var
  ListPr:TList;
  APach:PoPach;
  ASig4,ASig:PSig;
  SigFast,
  TSegmBeg,TSegmEnd,DE,ae, sigmaDTRL,x,y,DTRT1, TR,C33,C1,C5,
  C7,C6,C8,DB,delta,tt1,bob,{PI,}wite, zz, DDM, MN310,sigmaDTRF, DTRMED,
  sigmaBL, r1, r2, sh7,c55, c56,ttfix,TF,fol,nos,FPov
                                                                :Float;
  M, MM, MM1,NDN, LL1, MM2,MM3,i,dd1,d1, k, iiii,SigIndex,
  DNdtind,DNind,shdel,id,ii,i0i,k111,k112,ListInd
                                                              :integer;
  DNRLS,DNRLS1,DTRfast:array [0..25000] of real;
  DNPRLS:array[-10000..10000] of real;
  A,B,C,DD:vector;
  cross:boolean;
  CountShot : Integer;
  function det(A:vector): real;
    begin
      det:=A[1,1]*A[2,2]*A[3,3]-A[1,1]*A[2,3]*A[3,2]+A[1,2]*A[2,3]*A[3,1]-
      A[1,2]*A[2,1]*A[3,3]+A[1,3]*A[2,1]*A[3,2]-A[1,3]*A[2,2]*A[3,1];
    end;
begin                                                      {блок обнуления}
  for i:=1 to 2000 do begin DTRfast[i]:=0;DNRLS[i]:=0;end;
  for i:=-1000 to 1000 do DNPRLS[i]:=0;
  PI:=0;                                     {обнулен счет и сумм один пел}
  with Target do
    begin
    l:=l+1;                      {текущий счетчик обращ к процедуре peleng}
    sh1:=0;
    TR:=(360/WR)/60;                                {период обзора ДНА РЛС}
    M := trunc(360/BR);                             {число дискрет за обзр}
    MM:=trunc((BPK/2)/(WP*BR/WR));            {половина чис отсчет ДН ПРЛС}
    MM1:=MM*2+1;

    LL1:=MM1 div M;         {число оборов РЛС за время прохож напр на цель}
    C1:=(-12*sqr(WP)*BR*BR)/(BP*BP*WR*WR);          {константа для ДН ПРЛС}
    C33:=0.4343*ln(lamda*0.01);
    C5:=PG+GPRLS+20*C33-22;                                      {PG+S-4pi}
    DB:=WP*BR/WR;                              {велич углов дискр для ПРЛС}
    delta:=BR/WR;                       {величина временного дискрета, sek}
    NDN:=trunc(MM1*delta/(delta_t*60))+1;  {число интерв тамера на длит ДН}
    Cannal(Target,Carrier,DTRMED,sigmaDTRL,sigmaDTRF,DTRT1);

    MM2 := trunc (DTRT1/(0.63*delta)); {число отсчетов в окне суммирования}
    MM3 := MM1+MM2;
    for i:=1 to MM3 do
    begin                           {быстрые флуктуации}
      unr(r1,r2);      DTRfast[i] := r1;
    end;
                                                            {запас}
    for i:=1 to MM1 do
    begin           {формиров корр отсчет в скольз окне}
      sh7:=0;
      for k := i to (i+MM2) do
      sh7:=sh7+DTRfast[k];
      DTRfast[i] := sigmaDTRF*sh7/sqrt(MM2);
    end;
                                                    {ДН ПРЛС Дб относ мах }
    for i:=-MM to MM do DNPRLS[i]:=C1*i*i;
                                                        {ДН РЛС за 1 обзор}
    sigmaBL:=7;                                                 {ско фона }
    for i:=1 to M do
    begin    {идентичн для всех обзоров фон одинак для1и2}
      unr(r1, r2);
      DNRLS1[i]:= Target.fone+sigmaBL*r1;
    end;
    end;                                      {With Target}
  if LL1>0 then
    for i:=0 to LL1 do                             {фонов лепестки за обз }
      for iiii :=1 to M do DNRLS1[(i+1)*m+iiii]:=DNRLS1[iiii];

  if (l=0)and not(Tuern.Down) then
  begin
              unr(x,y);VM:=sigmaDTRL*y;
              SigLow:=0.33*x;
              d1:=random(m);   dd0:=d1;
  end ;
                                    { dd0- отсчет первого мах на 1 обзоре}
  tt1:=M*frac(tt/TR);
  dd1:=round(tt1);
                                          {новое коррелированное положение
                                  главного лепестка на последующих обзорах}
  if dd1<=dd0 then d1:=dd0-dd1 else d1:=dd0+(M-dd1);
  for i:=1 to MM1 do DNRLS[i]:=DNRLS1[i];    {фонов леп ДН РЛС за неск обз}
                                  //первый оборот антенны источника
  if LL1=0 then   if d1<=MM1 then
  begin
    DNRLS[d1]:=0;    //главный лепесток
    if d1>1 then
    begin           // первій  боковой
      DNRLS[d1-1]:=-25;   DNRLS[d1+1]:=-25;
    end;

    if d1>2 then
    begin        // второй боковой
      DNRLS[d1-2]:=-28;   DNRLS[d1+2]:=-28;
    end;
  end;
                           //  второй и послед обороты антенны источника
  if LL1>0 then for i:=0 to LL1 do
  begin
    DNRLS[d1+i*m]:=0;
    DNRLS[d1+i*m+1]:=-25; DNRLS[d1+i*m-1]:=-25;
    DNRLS[d1+i*m+2]:=-28; DNRLS[d1+i*m-2]:=-28;

  end;
  i0i:=0;
  cross:=false;                              {признак пересечения диаграмм}
  if fmSelect.SelectOn.Checked=true then
  TF:=1/(1000*Target.F);                   {перевод част повт в пер следов}

  unr(x,y); SigFast:=0.25*x;

  CountShot := 0;

  for i:=-MM to MM do begin                                  {пеленгование}
    C7:=C5+DTRfast[i+MM+1]+DTRMED+VM+DNRLS[i+MM+1]+DNPRLS[i];

    //////////////////////////////////////////////////////////////////////////////////////////
    if (IndCarrier = 2) and (Target.Number = fmOnePeleng.NumberTarget) and (nc = 1) then begin
        if C7>Po then begin
          fmOnePeleng.SeriesArray1[CountShot].y     := C7-Po;
          fmOnePeleng.SeriesArray1[CountShot].i     := i;
          inc(CountShot);
          fmOnePeleng.CountDataSeries1 := CountShot;
        end;
        fmOnePeleng.SeriesArray2[i+MM].y :=   DTRfast[i+MM+1];   fmOnePeleng.SeriesArray2[i+MM].i := i;
        fmOnePeleng.SeriesArray3[i+MM].y :=     DNRLS[i+MM+1];   fmOnePeleng.SeriesArray3[i+MM].i := i;
        fmOnePeleng.SeriesArray4[i+MM].y :=    DNPRLS[i     ];   fmOnePeleng.SeriesArray4[i+MM].i := i;
    end;
    //////////////////////////////////////////////////////////////////////////////////////////

    if C7>Po then begin
      bob:=random;
      if bob<=panoram then begin
        sh1:=sh1+1;
       {счетч числа обнар отсч за обзор}
        with fmSelect do
          if fmSelect.SelectOn.Checked=true then begin {блок вкл/откл форм масс для сел}
              with fmPassivRadar,Canvas do
                 for k112:=0 to 2 do for k111:=0 to 15 do
                    TextOut(k111*50,340+k112*15,'                             ');
                    TSegmBeg:=ttsek+(i+MM)*delta;       {фиксир начало очеред сегмента}
                    TSegmEnd:=TSegmBeg+delta;              {фикс конец очеред сегмента}
                    //if (sh25=0) and (sh1=1) then  begin
                                            {фиксир время обнар 1го пакета}
                                               {фиксир нискочастотную фазу}
                                                  {первого обнаруж сигнала}
                    // TSignBeg1:=TSegmBeg+TF*random;
                                              {начальнре коррелир значение}
                                              {времени 1го имп очеред сегм}
                    // end;
              if sh1=1 then begin
                   New(ASig4);
                   if ListDN.Count>0 then ASig4:=ListDN.Last;{фиксир послед сигнал пред}
                   if TSegmBeg < ASig4^.T then cross:=true;
              end;
                                                 {               диаграммы}
              // TSegmBeg:=TSegmBeg+
              //          (TF-TF*Frac((TSegmBeg-TSignBeg1)/TF));
              while TSegmBeg<TSegmEnd do begin
                  New(ASig);
                  //            TestGetMem(ASig,64);
                  if Target.Color=2 then begin                      {шумовой сигнал для второй цели}         {со случ амплитудой}
                      unr(x,y);  fol:=6*y;  ASig^.A  :=C7-Po+fol;
                                                      { случ длительностью}
                      nos:=0.4*x;ASig^.Tay:=Target.Tay+nos;
                                                          {и период следов}
                     //  ASig^.Pe:=TF;
                      TSegmBeg:=TSegmBeg+random*TF;
                      ASig^.T :=TSegmBeg;
                  end  else begin {регулярный сигнал}
                      ASig^.A  :=C7-Po;         ASig^.Pe:=TF;
                      ASig^.Tay:=Target.Tay;
                      TSegmBeg:=TSegmBeg+TF;    ASig^.T:=TSegmBeg;
                  end; // --- if Target.Color=2 then begin
                  ASig^.Nff:=Target.Nf;
                  ASig^.Col   :=TargetColors[Target.Color];
                  ASig^.Pr    :=false;       {признак припис (true) либо
                                              неприпис (false) к пакету}
                  if  ASig^.A >0 then ListDN.Add(ASig);{чтобы искл A<0 для шума}
                                                    {если ДН перекрываются}
              end; // --- while TSegmBeg<TSegmEnd do begin
          end; // --- if fmSelect.SelectOn.Checked=true then begin --- {конец блока форм масс для селекции}
{?}        PI:=PI+i*DB;
      end; // --- if bob<=panoram then begin
    end; // --- if C7>Po then begin
  end; // --- for i:=-MM to MM do begin

    ////////////////////////////////////////////
    if (IndCarrier = 2) then begin
      fmOnePeleng.PrepareChart(Target.Number, nc, MM, SHPEL0, SigFast,SigLow, DB);
      fmOnePeleng.DrawSeries  (Target.Number, nc);
    end;
    ////////////////////////////////////////////

     if fmSelect.SelectOn.Checked=true then
     if cross then ListDN.Sort(Comp);

     if st1>0 then st1:=st1+1;
                                                   {конец вывода импульсов}
    if sh1>0 then
    begin
////////////      unr(x,y); SigFast:=0.25*x;
      PI:=PI/sh1+SHPEL0+SigFast+SigLow;
      sh25:=sh25+1;{счетч числа обнаруж}
      wite:=1;                 { вес}
//      if sh1<3               then wite:=0.2;
  //    if (sh1>=3)and (sh1<6) then wite:=0.5;
    //  if (sh1>=6)            then wite:=1;
      c55:=wite*PI;   a21:=a21+c55;                       {сумматор пеленга}
      c56:=tt;        a212:=a212+wite*c56;                {сумматор времени}
                    a222:=a222+wite*c56*c56;      {сумматор квадр времени}
                    a22:=a22+c55*c56;              {сумматор пеленг*время}
                    a211:=a211+wite;                       {сумматор веса}
      zz:=a211*a222-a212*a212;
                                             {при апроксимации параболой }
                    b21:=b21+(c56*c56)*c56;        {суматор кубов времени}
                    b22:=b22+(c56*c56)*(c56*c56); {сумматор 4степ времени}
                    b23:=b23+(c55*c56)*c56;               {сумматор П*Т*Т}

       DD[1,1]:=a222;   DD[1,2]:=a212;    DD[1,3]:=sh25;
       DD[2,1]:=b21;    DD[2,2]:=a222;    DD[2,3]:=a212;
       DD[3,1]:=b22;    DD[3,2]:=b21;     DD[3,3]:=a222;

       A[1,1]:=a21;    A[1,2]:=a212;    A[1,3]:=sh25;
       A[2,1]:=a22;    A[2,2]:=a222;    A[2,3]:=a212;
       A[3,1]:=b23;    A[3,2]:=b21;     a[3,3]:=a222;

       B[1,1]:=a222;   B[1,2]:=a21;    B[1,3]:=sh25;
       B[2,1]:=b21;    B[2,2]:=a22;    B[2,3]:=a212;
       B[3,1]:=b22;    B[3,2]:=b23;    B[3,3]:=a222;

       C[1,1]:=a222;   C[1,2]:=a212;    C[1,3]:=a21;
       C[2,1]:=b21;    C[2,2]:=a222;    C[2,3]:=a22;
       C[3,1]:=b22;    C[3,2]:=b21;     C[3,3]:=b23;
       if sh25 >= 2 then
       if zz <> 0 then
       begin                        {линейная аппроксимация}
         P002:=(a21*a222-a22*a212)/zz;              {уточненный пеленг дляl=0}
         PWIP2:=(a22*a211-a212*a21)/zz;                  {уточненный ВИП     }
                                             {параболическая аппроксимация}
         zz:=det(DD);
         if zz<>0 then
         begin                      {коэффициенты аппроксимации}
           AAA:=det(A)/zz; BBB:=det(B)/zz;
           CCC:=det(C)/zz;
         end;
       end;
  end;

  if sh25=0                  then goto M1;
//  if(sh25< 4) and (sh1>0) then SHPEL:=PI;      { первые 3 несглаж пеленга }
//  if(sh25< 4) and (sh1=0)     then goto M1;
//  if sh25>=4              then SHPEL:= P002+tt*PWIP2;   {сглаженный пеленг}


  if(sh25< fmSgPeleng.OnePeleng.Value) and (sh1>0) then SHPEL:=PI;      { первые 3 несглаж пеленга }
  if(sh25< fmSgPeleng.OnePeleng.Value) and (sh1=0) then goto M1;
  if sh25>=fmSgPeleng.OnePeleng.Value  then SHPEL:= P002+tt*PWIP2;   {сглаженный пеленг}

M1:
// end;
end;
procedure TfmPassivRadar.MatrixTayA(var ImputMassiv:array of Sig;var nsig:integer);
 label MM75,MM111,MM112;
// type para= record
  //    X,Y:float;
    //  n:integer;
      //end;
 type qwadro=record
      X1,X2,X3,X4,X5,X6,X7,
      Y1,Y2,Y3,Y4,Y5,Y6,Y7:integer;
      end;
 var
     myRect:TGridRect;
//     Re:array[0..20,0..20] of para;
     Pack,Pack_: PoPack;
//     ZipMa: array[0..40] of Sig;
     Sh: array [0..20,0..20,0..30] of Sig;         {матрица на 30 имп в ячейке}
     i,ii,ind2,ii0,k,l,f,contr:integer;
     TF,deltaTF,deltaTay,deltaA,Tay0,A0,A1,A2,
     dt,dt1,dt2,dt3,dt4,dt5,t1,t2,t3,t4,t5,t6:float;
     ListDN :TList;

begin
//     contr :=fmSelect.ContrastEdit.value;
     deltaTay:=0.5;  Tay0:=0; //  Tay0:=-deltaTay;
     deltaA:=2.5;    A0:=0;   //  A0:=-deltaA;
//  ReTayA[l,k].N
     for k:=0 to 20 do  for l:=0 to 20 do
       begin
         ReTayA[l,k].X:=Tay0+deltaTay*l;
         ReTayA[l,k].Y:=A0  +deltaA*k;
       end;

{+}         for ii:=0 to nsig do
{+}                      if (ImputMassiv[ii].Tay <= ReTayA[fmSigMatrix.
                                        fmSignTabel.Selection.Right+1,0].X) and
{+}                         (ImputMassiv[ii].Tay >= ReTayA[fmSigMatrix.
                                        fmSignTabel.Selection.Left,0].X)    and
                            (ImputMassiv[ii].A >=   ReTayA[0,fmSigMatrix.
                                        fmSignTabel.Selection.Bottom-20].Y) and
{+}                         (ImputMassiv[ii].A <=   ReTayA[0,20-fmSigMatrix.
                                        fmSignTabel.Selection.Top].Y)
                             then
                             ImputMassiv[ii].A:=0;
  if nsig>-1 then
  for ii:=0 to nsig do
     begin
       if (ImputMassiv[ii].T < fmPassivRadar.ttsek_) and
          (ImputMassiv[ii].T  >=fmPassivRadar.ttsek) then
       begin

                                           {рассортиров по ячейкам}
       for l:=0 to 19 do
         if (ImputMassiv[ii].Tay > ReTayA[l,0].X) and
                                      (ImputMassiv[ii].Tay <= ReTayA[l+1,0].X) then
            for k:=0 to 19 do
              if (ImputMassiv[ii].A > ReTayA[l,k].Y) and
                                         (ImputMassiv[ii].A <= ReTayA[l,k+1].Y)then
                  begin
                         ReTayA[l,k].N:=ReTayA[l,k].N+1;
                         if ReTayA[l,k].N>30 then  ReTayA[l,k].N:=30;
                    //     sh[l,k,Re[l,k].N].Nff:=ImputMassiv[ii].Nff;
                         sh[l,k,ReTayA[l,k].N].Tay:=ImputMassiv[1].Tay;
                         sh[l,k,ReTayA[l,k].N].A:=ImputMassiv[ii].A;
       {создаем массив списков сигналов сцелью повторн сорт по врем приход}
                         sh[l,k,ReTayA[l,k].N].T:=ImputMassiv[ii].T;
//                         sh[l,k,Re[l,k].N].Nff:=sh[l,k,Re[l,k].N].Nff+1;
                  //       sh[l,k,Re[l,k].N].Col:=ImputMassiv[ii].Col;
                   //      sh[l,k,Re[l,k].N].Pr:=false;
                     //    sh[l,k,Re[l,k].N].Pe :=ImputMassiv[ii].Pe;
                                                   {выводим матрицу на экран ЗТ}
 //                                                Brush.color:=clWhite;
                    //     goto MM111;
                  end;
                 for l:=0 to 19 do
                    for k:=0 to 19 do
               with fmSigMatrix,fmSignTabel,canvas do
                         begin
                           if ReTayA[l,k].N>20 then  Brush.color:= clBlack else
                           if ReTayA[l,k].N>10 then  Brush.color:= clGray else
                           if ReTayA[l,k].N>0  then  Brush.color:= clSilver;
                           if ReTayA[l,k].N>0 then
                           FillRect(fmSignTabel.CellRect(l,fmSignTabel.RowCount-k-1));
                         end;
     MM111:
       end ;                    {если импульс вне интервала}
 end;
end;
procedure TfmPassivRadar.MatrixTA(var ImputMassiv:array of Sig;var nsig:integer);
 label MM75,MM111,MM112;
 type para= record
      X,Y:float;
      n:integer;
      end;
 type qwadro=record
      X1,X2,X3,X4,X5,X6,X7,
      Y1,Y2,Y3,Y4,Y5,Y6,Y7:integer;
      end;
 var
     Re:array[0..20,0..20] of para;
     Pack,Pack_: PoPack;
//     ZipMa: array[0..100] of Sig;
     Sh: array [0..20,0..20,0..30] of Sig;         {матрица на 30 имп в ячейке}
     i,ii,ind2,ii0,k,l,f,contr:integer;
     TF,deltaTF,deltaT,deltaA,T0,A0,A1,A2,senter,deltaP,
     dt,dt1,dt2,dt3,dt4,dt5,t1,t2,t3,t4,t5,t6:float;
     AA,BB :boolean;
     ListDN :TList;

begin
     BB := False;
     deltaT:=1.5;//Sek/(20*WP){0.5};
     senter:=StrToInt( fmSigMatrix.EditSenterP.Text);//0;
     deltaP:=deltaT*10;
//     fmSigMatrix.Label10.Caption:=fmSigMatrix.EditSenterP.Text;
     if senter < 180 then BB:=True;
     if senter >=180 then BB:=False;
     if BB=True then
        if senter < deltaP/2 then AA:=True else AA:=False;
     if BB=False then
        if (360-Senter) < deltaP/2 then AA:=True else AA:=False;
     T0:=senter-deltaP;//TRevers; //  Tay0:=-deltaTay;
     deltaA:=2.5;    A0:=0;   //  A0:=-deltaA;
     for k:=0 to 20 do  for l:=0 to 20 do  Re[l,k].N:=0;
     for l:=0 to 20 do  for k:=0 to 20 do
       begin
         Re[l,k].X:=T0+deltaT*l;
         Re[l,k].Y:=A0  +deltaA*k;
       end;

  if nsig>-1 then
  for ii:=0 to nsig do
     begin
       if (ImputMassiv[ii].T < fmPassivRadar.ttsek_) and
          (ImputMassiv[ii].T  >=fmPassivRadar.ttsek) then
       begin
         if ImputMassiv[ii].Pel > 180 then ImputMassiv[ii].Pel:=360-ImputMassiv[ii].Pel;
                                           {рассортиров по ячейкам}
       for l:=0 to 19 do
         if (ImputMassiv[ii].Pel{T} > Re[l,0].X) and
                                      (ImputMassiv[ii].Pel{T} <= Re[l+1,0].X) then
            for k:=0 to 19 do
              if (ImputMassiv[ii].A > Re[l,k].Y) and
                                         (ImputMassiv[ii].A <= Re[l,k+1].Y)then
                  begin
                         Re[l,k].N:=Re[l,k].N+1;
                         if Re[l,k].N>30 then  Re[l,k].N:=30;

                         sh[l,k,Re[l,k].N].A:=ImputMassiv[ii].A;
       {создаем массив списков сигналов сцелью повторн сорт по врем приход}
                         sh[l,k,Re[l,k].N].T:=ImputMassiv[ii].T;

                                                   {выводим матрицу на экран ЗТ}
                         with fmSigMatrix,fmSignTabelTA,canvas do
                         begin
                           if Re[l,k].N>20 then begin  Brush.color:= clBlack;EditorMode:=True;end else
                           if Re[l,k].N>10 then   Brush.color:= clGray  else
                           if Re[l,k].N>0  then   Brush.color:= clSilver;
                           if Re[l,k].N>0  then
                           FillRect(fmSignTabelTA.CellRect(l,fmSignTabelTA.RowCount-k-1));
                         end;
     //                                            Brush.color:=clWhite;
                         goto MM111;
                  end;

     MM111:
       end ;                    {если импульс вне интервала}
 end;
end;
procedure TfmPassivRadar.SelectArray(ListFinishPacet:TList;
                                var ImputMassiv:array of Sig; var nsig:integer);
label MM75,MM85,MM95;
var
// ASig3:PSig;
  Pack,Pack_ :PoPack;
  ii,ind2,ii0,NPak,deltaNf :integer;
  deltaA,deltaTay,{ConstDiap,}const1,const2:Float;
  PrizT,PrizA,PrizTay,PrizNf:Boolean;
  ListCurrentPacet :TList;
  procedure IniPack_;                      {процедура зввязыв текущ пакета}
     begin
     New(Pack_);
     Pack_^.Nf:=ImputMassiv[ii].Nff;    Pack_^.Tay:=ImputMassiv[ii].Tay;
     Pack_^.A :=ImputMassiv[ii].A;      Pack_^.T  :=ImputMassiv[ii].T;
     Pack_^.N :=1;             Pack_^.Col:=ImputMassiv[ii].Col;
     Pack_^.Pr:=False;
     Pack_^.ConstDiap:=0.002;
                                       {добавл  пакет в спис незав пакетов}
                      ListCurrentPacet.Add(Pack_);
     end;
  procedure IniPack;                      {процедура зввязыв заверш пакета}
  var
  delta_pSmol:Float;
     begin
        if Pack_^.N>=NPak then
        if Pack_^.Pr=false then
              begin
                      New(Pack);
                             {учтем изменение пеленга внутри временного интерв}
                      if delta_p > 0 then delta_pSmol:=(Pack_^.T-ttsek)*WP else
                                            delta_pSmol:=-(Pack_^.T-ttsek)*WP ;
                      Pack^.Pel:=fmPassivRadar.Ptek + delta_pSmol;
                      Pack^.Nf:=Pack_^.Nf;     Pack^.Tay:=Pack_^.Tay;
                      Pack^.A :=Pack_^.A;
                      Pack^.T  :=Pack_^.T-Pack_^.Pe;
                                    {убираем 1 период иначе Pack^.T выходит}
                                                          {за границу ttsek_}
                      Pack^.N :=Pack_^.N;      Pack^.Col:=Pack_^.Col;
                      Pack^.Pr:=false;
                      Pack^.Pe:=Pack_^.Pe;
                                       {добавл  пакет в спис незав пакетов}
                      ListFinishPacet.Add(Pack);
                 Pack_^.Pr:=true;
              end;
                      Pack_:=nil;
                      if Pack_=nil then
                      begin
                        ListCurrentPacet.Delete(ind2);
                        ind2:=ind2-1;
                        FreeMem(Pack_,SizeOf(Pack_));
                      end;
     end;
begin
  const1:=(1-0.01*fmSelect.DeltaTEdit.Value);   {стробы по период повтор}
  const2:=(1+0.01*fmSelect.DeltaTEdit.Value);
  deltaTay:=0.1*fmSelect.DeltaTayEdit.Value;
  deltaA:=0.1*fmSelect.DeltaAEdit.Value;
  deltaNf:=fmSelect.deltaNfEdit.Value;
                                                       {строб срав по ампл}
  NPak:=fmSelect.NEdit.Value;                        {число имп в пакете}
                                                       {число имп в пакете}
  if nsig > -1 then

  begin
    ListCurrentPacet:=TList.Create;
    for ii:=0 to nsig do
    if ImputMassiv[ii].A >0 then   {исключая обработку имп ниже порога,напр шума}
    begin
                                                      {цикл по сигналам ДН}
      if ListCurrentPacet.Count=0 then {если спис незавер пак}
                              { пуст то приш имп завяз незаверш нов пакет }
      begin
        IniPack_;
        goto MM95;
      end;
      if ListCurrentPacet.Count > 0 then          {если список незаверш }
                                                         {пакетов наполнен}
      for ind2:=0 to ListCurrentPacet.Count-1 do
      if (ind2<= ListCurrentPacet.Count-1) then
        begin
                                            {цикл по незавершенным пакетам}
                                        {выбираем очередной незаверш пакет}
          Pack_:=ListCurrentPacet.Items[ind2];
          if Pack_^.N=1 then
                                      {провер попал ли 2 имп в 1 шир строб}
          begin
 //           ConstDiap:=0.002;
            if (abs(Pack_^.T-ImputMassiv[ii].T) >= 0.00009) and
            (abs(Pack_^.T-ImputMassiv[ii].T) < 0.002) then
              begin
                PrizT:=true ;
              end
                                                         else PrizT:=false;
          end;
          if Pack_^.N>1 then
                                   {пров попад 3 и послед имп в узкий строб}
          begin
            if Pack_^.T<>ImputMassiv[ii].T then
            if (abs(Pack_^.T-ImputMassiv[ii].T) > const1*Pack_^.Pe) and
            (abs(Pack_^.T-ImputMassiv[ii].T) < const2*Pack_^.Pe) then
            PrizT:=true else
            PrizT:=false;
          end;
                     {сравн очеред сигнал по парам посл со всеми пакетами}
          if   (abs(Pack_^.Nf-ImputMassiv[ii].Nff) <= deltaNf) then PrizNf:=true
          else PrizNf:=false;
           if   (abs(Pack_^.A-ImputMassiv[ii].A) < deltaA) then PrizA:=true
          else PrizA:=false;
          if   (abs(Pack_^.Tay-ImputMassiv[ii].Tay)< deltaTay)then PrizTay
                                                    :=true else PrizTay:=false;
          if fmSelect.SelectTay.Enabled = false then PrizTay:=true;
          if fmSelect.SelectA.Enabled = false then PrizA:=true;
          if PrizA and PrizTay and PrizT and PrizNf then        { если сравн произошло}
          begin
            if Pack_^.N =1 then Pack_^.ConstDiap:=0.002 else Pack_^.ConstDiap:=2*Pack_^.Pe;
            if ((ImputMassiv[ii].T-Pack_^.T)< Pack_^.ConstDiap) then
                                       {проверка критер заверш пак по врем}
            begin                                  {если пакет не завершен}
              Pack_^.A:=ImputMassiv[ii].A;         {запис нов парам пакета}
              Pack_^.Nf:=ImputMassiv[ii].Nff;
     //         Pack_^.Col:=ImputMassiv[ii].Col;
              Pack_^.N:=Pack_^.N+1;
     //         if Pack_^.N=2 then
               Pack_^.Pe:=ImputMassiv[ii].T-Pack_^.T;
      //                                 else
        //      begin
          //    Pack_^.Pe:=Pack_^.Pe*(Pack_^.N-2)+(ImputMassiv[ii].T-Pack_^.T);
            //  Pack_^.Pe:=Pack_^.Pe/(Pack_^.N-1);
              //end;
            //  if Pack_^.N < NPak then IniPack_;
                  {если пакет еще не завязто каждый новый имп завяз нов пакет}
                 {этот фрагмент нуждается в уточнении посколькуразмножает паке}
              ImputMassiv[ii].Pr:=true;  {присв приз сигн припис к пакету}
              Pack_^.T:=ImputMassiv[ii].T;       {новое врем конца пакета}
            end ;
            if ((ImputMassiv[ii].T-Pack_^.T)>= Pack_^.ConstDiap)then
                                                      {если пакет завершен}
            begin
              IniPack;
              if ImputMassiv[ii].Pr=false then
              IniPack_;                     {завязыв пакет по нов импул   }
            end ;
          end                    {окнчан блока обраб сиг срав по всем пар}

          else              {если имп не припис к очередн пакету при срав }
          begin                     {начало блок обр имп не сравн по ампл}
            if Pack_^.N =1 then Pack_^.ConstDiap:=0.002 else Pack_^.ConstDiap:=2*Pack_^.Pe;
            if((ImputMassiv[ii].T-Pack_^.T)>Pack_^.ConstDiap) then
                                               {проверка завер пак по врем}
            IniPack;
            if  ListCurrentPacet.indexOf(Pack_)= ListCurrentPacet.Count-1
                                                          then
                                     {а список незаверш пакетов исчерпался}
                                           {то импульс завязыв новый пакет}
            if ImputMassiv[ii].Pr=false then    {если он не прип ни к одному}
                                                               {из пакетов}
            begin
                                 IniPack_;  {добавл нов пакет с пар тек имп}
            end;                         {конец блока обр имп не срав по ампл}
        end;                           {конец цикла по незавершенным пакетам}
        end;
        for ind2:=0 to ListCurrentPacet.Count-1 do     {удаляем заверш пакеты}
                                                  {из списка незавершенных}
        if ind2<=ListCurrentPacet.Count-1 then
        begin
          Pack_:=ListCurrentPacet.Items[ind2];
          if((ImputMassiv[ii].T-Pack_^.T)>Pack_^.ConstDiap) {если интерв после посл}
                                                     {обнаруж достат велик}
          or (ii= nsig) then                       {либо обработани посл имп}
          begin
            IniPack;                               {завяз заверш пакет}
            ListCurrentPacet.Remove(Pack_);         {то удал завер пак}
          end;
        end;
        if ii=nsig  then
        begin
          for ind2:=0 to ListCurrentPacet.Count-1 do
          if ind2<= ListCurrentPacet.Count-1 then
          begin
            Pack_:=ListCurrentPacet.Items[ind2];
            FreeMem(Pack_,SizeOf(Pack_));
          end;
          ListCurrentPacet.Clear;
          ListCurrentPacet.Free;
        end;
MM95: end;                                     {конец цикла по сигналам ДН}
                                                     {вывод законч пакетов}
 end;
    if nsig > 0 then
    if ListFinishPacet.Count > 0 then
    for ii0:=0 to 10 do
    with fmPassivRadar,canvas do
    begin
         TextOut(ii0*70+20,385,'                                ');
         TextOut(ii0*70+20,400,'                                ');
         TextOut(ii0*70+20,415,'                                ');
    end;
     if fmSelect.SelectSort.Checked=False then
                                            {вывод в случае откл сел сортировки}
                                       { иначе вывод внутр проце SelectContrast}
     if ListFinishPacet.Count > 0 then
     for ii0:=0 to (ListFinishPacet.Count-1) do
     begin
       if ii0 > 10 then goto MM75;
       Pack:=ListFinishPacet.Items[ii0];
       with fmPassivRadar,Canvas do
       begin
         Font.Color:=Pack^.Col;
         TextOut(ii0*70+20,385,FloatToStrF(Pack^.T,ffFixed,7,7));
         TextOut(ii0*70+20,400,FloatToStrF(Pack^.Pe,ffFixed,7,7));
         TextOut(ii0*70+20,415,FloatToStrF(Pack^.N,ffFixed,7,7));
       end;
     end;  MM75:
                                                    { конец вывода пакетов}
end;                                                               {select}
procedure TfmPassivRadar.SelectList(
                           ListCurrentPacet,ListFinishPacet,ListDN :TList);
label MM75,MM85,MM95;
var
  ASig3:PSig;
  Pack,Pack_ :PoPack;
  ii,ind2,ii0,NPak :integer;
  deltaA,deltaTay,ConstDiap,const1,const2:Float;
  Priz,PrizA,PrizTay:Boolean;
  procedure IniPack_;                      {процедура зввязыв текущ пакета}
     begin
                      New(Pack_);
                      Pack_^.Nf:=ASig3^.Nff;    Pack_^.Tay:=ASig3^.Tay;
                      Pack_^.A :=ASig3^.A;      Pack_^.T  :=ASig3^.T;
                      Pack_^.N :=1;             Pack_^.Col:=ASig3^.Col;
                      Pack_^.Pr:=false;
                                       {добавл  пакет в спис незав пакетов}
                      ListCurrentPacet.Add(Pack_);
     end;
  procedure IniPack;                      {процедура зввязыв заверш пакета}
     begin
        if Pack_^.N>=NPak then
        if Pack_^.Pr=false then
              begin
                      New(Pack);
                      Pack^.Pel:=fmPassivRadar.Ptek;
                      Pack^.Nf:=Pack_^.Nf;     Pack^.Tay:=Pack_^.Tay;
                      Pack^.A :=Pack_^.A;      Pack^.T  :=Pack_^.T;
                      Pack^.N :=Pack_^.N;      Pack^.Col:=Pack_^.Col;
                      Pack^.Pr:=false;
                      Pack^.Pe:=Pack_^.Pe;
                                       {добавл  пакет в спис незав пакетов}
                      ListFinishPacet.Add(Pack);
                 Pack_^.Pr:=true;
              end;
                      Pack_:=nil;
                      if Pack_=nil then begin
                      ListCurrentPacet.Remove(Pack_);
                      FreeMem(Pack_,SizeOf(Pack_));
                                        end;
     end;
  begin
  const1:=(1-0.01*fmSelect.DeltaTEdit.Value);   {стробы по период повтор}
  const2:=(1+0.01*fmSelect.DeltaTEdit.Value);
  deltaTay:=0.1*fmSelect.DeltaTayEdit.Value;
  deltaA:=0.1*fmSelect.DeltaAEdit.Value;
//  deltaNf:=fmSelect.deltaNfEdit.Value;
                                      {строб срав по ампл}
  NPak:=fmSelect.NEdit.Value;                        {число имп в пакете}
                                                       {число имп в пакете}
    for ii:=0 to ListDN.Count-1 do
      begin
                                                      {цикл по сигналам ДН}
       ASig3:=ListDN.Items[ii];                 {выбираем очередной сигнал}
       if (ASig3^.T <fmPassivRadar.ttsek_) and (ASig3^.T>=fmPassivRadar.ttsek)
                                then
                                     {если сигнал не превысил врем интерв }
                                          { переходим на алгоритм селекции}
   begin
                   if ListCurrentPacet.Count=0 then {если спис незавер пак}
                              { пуст то приш имп завяз незаверш нов пакет }
                   begin
                    IniPack_;
                    goto MM95;
                   end;
          if ListCurrentPacet.Count > 0 then          {если список незаверш }
                                                         {пакетов наполнен}
             for ind2:=0 to ListCurrentPacet.Count-1 do
              if (ind2<= ListCurrentPacet.Count-1)then
               begin
                                            {цикл по незавершенным пакетам}
                                        {выбираем очередной незаверш пакет}
                 Pack_:=ListCurrentPacet.Items[ind2];
                 if Pack_^.N=1 then          begin
                        ConstDiap:=0.002;
                     if (abs(Pack_^.T-ASig3^.T) >= 0.00009) and
                        (abs(Pack_^.T-ASig3^.T) < 0.002) then Priz:=true
                                                         else Priz:=false;
                                              end;
                 if Pack_^.N>1 then          begin
                        ConstDiap:=2*Pack_^.Pe;
                   if Pack_^.T<>ASig3^.T then
                     if (abs(Pack_^.T-ASig3^.T) > const1*Pack_^.Pe) and
                        (abs(Pack_^.T-ASig3^.T) < const2*Pack_^.Pe) then
                                              Priz:=true else Priz:=false;
                                             end;
                 if   (abs(Pack_^.A-ASig3^.A) < deltaA) then PrizA:=true
                                                       else PrizA:=false;
                 if   (abs(Pack_^.Tay-ASig3^.Tay)< deltaTay)then PrizTay
                                              :=true else PrizTay:=false;
                 if fmSelect.SelectTay.Enabled = false then
                                                          PrizTay:=true;
                 if fmSelect.SelectA.Enabled = false then PrizA:=true;

                 if
                     PrizA
                     {если импульс припис к пакету в результ сравн аплитуд}
                 and PrizTay                                     {длительн}
                 and Priz                                    {и пер следов}
                 then                                                  {то}
                   begin
                   if ((ASig3^.T-Pack_^.T)< ConstDiap)
                                then   {проверка критер заверш пак по врем}
                      begin                        {если пакет не завершен}
                        Pack_^.A:=ASig3^.A;       {запис нов обр амплитуды}
                        Pack_^.N:=Pack_^.N+1;           {счет имп в пакете}
                                                             {измер период}
                        Pack_^.Pe:=ASig3^.T-Pack_^.T;
//            if Pack_.N < NPak then IniPack_;
                                                  {если пакет еще не завяз}
                                      {то каждый новый имп завяз нов пакет}
                            {этот фрагмент нуждается в уточнении поскольку}
                                                        {размножает пакеты}
                        ASig3^.Pr:=true;  {присв приз сигн припис к пакету}
                        Pack_^.T:=ASig3^.T;       {новое врем конца пакета}
                      end ;
                 if ((ASig3^.T-Pack_^.T)>= ConstDiap)
//                          or             {или обрабатываем последн импульс}
  //                       ( ii = ListDN.Count-1 )
                                            then
                                                      {если пакет завершен}
                 begin
                    IniPack;
                    if ASig3^.Pr=false then
                    IniPack_;  {завязыв пакет по нов импул   }
                 end ;
                   end           {окнчан блока провер принадл имп к пакету}
                                                {при сравнени по амплитуде}
                 else  {если имп не припис к очередн пакету при срав по ам}
                  begin              {начало блок обр имп не сравн по ампл}
                   if((Asig3^.T-Pack_^.T)>ConstDiap) then
                                               {проверка завер пак по врем}
                   IniPack;
                   if  ListCurrentPacet.indexOf(Pack_)=
                      ListCurrentPacet.indexOf(ListCurrentPacet.Last) then
                                     {а список незаверш пакетов исчерпался}
                                           {то импульс завязыв новый пакет}
                   if ASig3^.Pr=false then    {если он не прип ни к одному}
                                                               {из пакетов}
                                 IniPack_;  {добавл нов пакет с пар тек имп}
                  end;                {конец блока обр имп не срав по ампл}
               end;                  {конец цикла по незавершенным пакетам}
     for ind2:=0 to ListCurrentPacet.Count-1 do     {удаляем заверш пакеты}
                                                  {из списка незавершенных}
       if ind2<=ListCurrentPacet.Count-1 then
       begin
           Pack_:=ListCurrentPacet.Items[ind2];
           if((ASig3^.T-Pack_^.T)>ConstDiap)       {если интерв после посл}
                                                     {обнаруж достат велик}
               or(ii= ListDN.Count-1)            {либо обработани посл имп}
                then
                 begin
                 IniPack;
                 ListCurrentPacet.Remove(Pack_);    {то удал завер пак}
                 end;
       end;
   end else begin
              if ListCurrentPacet.Count>0 then
                for ind2:=0 to ListCurrentPacet.Count-1 do
                begin
                Pack_:=ListCurrentPacet.Items[ind2];
                IniPack;
                end;
                  for ind2:=0 to ListCurrentPacet.Count-1 do
                      begin
                         Pack_:=ListCurrentPacet.Items[ind2];
                         FreeMem(Pack_,SizeOf(Pack_));
                      end;
            ListCurrentPacet.Clear;
            goto MM95;
            end;
      if ii=ListDN.Count-1  then begin
             for ind2:=0 to ListDN.Count-1 do
                begin
                ASig3:=ListDN.Items[ind2];  ASig3:=nil;
                if ASig3=nil then Dispose(ASig3);
                end;
                ListDN.Clear;
                  for ind2:=0 to ListCurrentPacet.Count-1 do
                      begin
                         Pack_:=ListCurrentPacet.Items[ind2];
                         FreeMem(Pack_,SizeOf(Pack_));
                      end;
                      ListCurrentPacet.Clear;
                                 end;
MM95: end;                                     {конец цикла по сигналам ДН}
                                                     {вывод законч пакетов}
     if ListFinishPacet.Count > 0 then
       for ii0:=0 to (ListFinishPacet.Count-1) do     begin
            if ii0 > 10 then goto MM75;
                  Pack:=ListFinishPacet.Items[ii0];
                     with fmPassivRadar,Canvas do  begin
        Font.Color:=Pack^.Col;
        TextOut(ii0*70+20,400,'            ');
        TextOut(ii0*70+20,415,'            ');
        TextOut(ii0*70+20,400,FloatToStrF(Pack^.T,ffFixed,7,7));
        TextOut(ii0*70+20,415,FloatToStrF(Pack^.N,ffFixed,7,7));
                                            end;
                                                         end;  MM75:
                                                    { конец вывода пакетов}
end;                                                               {select}
                                    {1 вариант-импульсы укладываются в списки}
(*procedure TPassivRadar.SelectContrast(ImputMassiv:array of sig;
                                      ListFinishPacet:TList;var nsig:integer);
 label MM75,MM111,MM112,MM122;
 type para= record
      X,Y:float;
      end;
      PPack= record
             T:TList;
             A,Tay,Pe,Pel:Float;
             N,Nf:integer;
             Col:TColor;
             Pr :Boolean; {приз припис имп к пакету}
               end;
 var ASig3 :PSig;
     Re: Array[0..20,0..20] of para;
     Pack,Pack_: PoPack;
     Sh: array[0..19,0..19] of PPack;
     i,ii,ind2,ii0,k,l,contr:integer;
     TF,deltaTF,deltaTay,deltaA,Tay0,A0,A1,A2,
     dt,dt1,dt2,dt3,dt4,dt5,t1,t2,t3,t4,t5,t6:float;
     ListDN :TList;

begin
     if nsig > -1 then
     begin
     ListDN:=TList.Create;
     for i:=0 to nsig do
     begin
       New(ASig3);
         ASig3^.A:=ImputMassiv[i].A;     ASig3^.T:=ImputMassiv[i].T;
         ASig3^.Tay:=ImputMassiv[i].Tay; ASig3^.Pe:=ImputMassiv[i].Pe;
         ASig3^.Nff:=ImputMassiv[i].Nff; ASig3^.Col:=ImputMassiv[i].Col;
         ASig3^.Pr:=ImputMassiv[i].Pr;
       ListDN.Add(ASig3);
     end;
     end;
     contr :=fmSelect.ContrastEdit.value;
     deltaTay:=0.5;  Tay0:=0;
     deltaA:=2.5;    A0:=0;
     for k:=0 to 19 do  for l:=0 to 19 do  Sh[l,k].N:=0;
     for k:=0 to 20 do  for l:=0 to 20 do
       begin
         Re[l,k].X:=Tay0+deltaTay*l;
         Re[l,k].Y:=A0  +deltaA*k;
       end;
  if nsig >0 then
    if ListDN.Count>0 then
     for i:=0 to ListDN.Count-1 do
     begin
       ASig3:=ListDN.Items[i];
       if (ASig3^.T<ttsek_) and (ASig3^.T>=ttsek) then
       begin                                     {рассортиров по ячейкам}
       for l:=0 to 19 do
         if (ASig3^.Tay > Re[l,0].X) and (ASig3^.Tay <= Re[l+1,0].X) then
            for k:=0 to 19 do
              if (ASig3^.A > Re[l,k].Y) and (ASig3^.A <= Re[l,k+1].Y)then
                  begin
                         sh[l,k].Nf:=Asig3^.Nff;   sh[l,k].Tay:=ASig3^.Tay;
                         sh[l,k].A:=ASig3^.A;
       {создаем массив списков сигналов сцелью повторн сорт по врем приход}
                         if sh[l,k].N=0 then sh[l,k].T:=TList.Create;
                         sh[l,k].T.Add(ASig3);
                         sh[l,k].N:=sh[l,k].N+1;   sh[l,k].Col:=ASig3^.Col;
                         sh[l,k].Pr:=false;        sh[l,k].Pe :=ASig3^.Pe;
                         goto MM111;
                  end;
     MM111:
       end;// else goto MM122;                    {если импульс вне интервала}
//      if i=ListDN.Count-1  then begin  {очищаем список сигн при обраб посл}
                                                                { сигнала}
  //                for ind2:=0 to ListDN.Count-1 do
    //                  begin
      //                   ASig3:=ListDN.Items[ind2];
        //                 FreeMem(ASig3,SizeOf(ASig3));
          //            end;
            //                      ListDN.Clear;
              //                    ListDN.Free;
                //                end;
MM122: end;
  if nsig >-1 then
    if ListDN.Count>0 then
     for k:=0 to 19 do
       for l:=0 to 19 do
         begin
                                              {проверяем на контрастность}
        if fmSelect.SelectContrastIn.Checked = false then goto MM112;
        if (abs(sh[l,k].N-sh[l+1,k].N) >= Contr) and
           (abs(sh[l,k].N-sh[l,k+1].N) >= Contr)
          then                              {проверяем число имп в ячейке}
 MM112:    if sh[l,k].N>3 then
           if sh[l,k].T.Count > 5 then
            begin
                  sh[l,k].T.Sort(comp);     {сорт второй раз внутри ячейки
                                                        по времени прихода}
     SelectList(pListCurrentPacet[nc],ListFinishPacet,sh[l,k].T);
                begin

                end;
            end;
         end;
                                                     {вывод законч пакетов}
     if ListFinishPacet.Count > 0 then
     for ii0:=0 to (ListFinishPacet.Count-1) do     begin
            if ii0 > 10 then goto MM75;
                  Pack:=ListFinishPacet.Items[ii0];
                     with PassivRadar,Canvas do  begin
        Font.Color:=Pack^.Col;
        TextOut(ii0*70+20,400,'            ');
        TextOut(ii0*70+20,415,'            ');
        TextOut(ii0*70+20,400,FloatToStrF(Pack^.T,ffFixed,7,7));
        TextOut(ii0*70+20,415,FloatToStrF(Pack^.N,ffFixed,7,7));
                                            end;
                                                         end;  MM75:
                                                    { конец вывода пакетов}
end;                      *)
                              {2 вариант- имп размещ по ячейкам без сортир}
                              {объемы памяти матрицы велики }
procedure TfmPassivRadar.SelectContrast(ListFinishPacet:TList;
                                 var ImputMassiv:array of Sig;var nsig:integer);
 label MM75,MM111,MM112;
 type para= record
      X,Y:float;
      n:integer;
      end;
 type qwadro=record
      X1,X2,X3,X4,X5,X6,X7,
      Y1,Y2,Y3,Y4,Y5,Y6,Y7:integer;
      end;
 var
     Re:array[0..20,0..20] of para;
     Pack,Pack_: PoPack;
     ZipMa: array[0..40] of Sig;
     Sh: array [0..20,0..20,0..40] of Sig;         {матрица на 40 имп в ячейке}
     i,ii,ind2,ii0,k,l,f,contr:integer;
     TF,deltaTF,deltaTay,deltaA,Tay0,A0,A1,A2,
     dt,dt1,dt2,dt3,dt4,dt5,t1,t2,t3,t4,t5,t6:float;
     ListDN :TList;

begin
     contr :=fmSelect.ContrastEdit.value;
     deltaTay:=0.5;  Tay0:=0; //  Tay0:=-deltaTay;
     deltaA:=2.5;    A0:=0;   //  A0:=-deltaA;
     for k:=0 to 20 do  for l:=0 to 20 do  Re[l,k].N:=0;
     for k:=0 to 20 do  for l:=0 to 20 do
       begin
         Re[l,k].X:=Tay0+deltaTay*l;
         Re[l,k].Y:=A0  +deltaA*k;
       end;
{  if nsig >-1 then
  with fmSigMatrix,fmSignTabel,canvas do
  begin
    Brush.color:= clWhite;
     for l:=0 to 19 do
       for k:=0 to 19 do
                      FillRect(fmSignTabel.CellRect(l+1,k+1));
  end;                                                        }
  if nsig>-1 then
  for ii:=0 to nsig do
     begin
       if (ImputMassiv[ii].T < fmPassivRadar.ttsek_) and
          (ImputMassiv[ii].T  >=fmPassivRadar.ttsek) then
       begin
                                           {рассортиров по ячейкам}
       for l:=0 to 19 do
         if (ImputMassiv[ii].Tay > Re[l,0].X) and
                                      (ImputMassiv[ii].Tay <= Re[l+1,0].X) then
            for k:=0 to 19 do
              if (ImputMassiv[ii].A > Re[l,k].Y) and
                                         (ImputMassiv[ii].A <= Re[l,k+1].Y)then
                  begin
                         Re[l,k].N:=Re[l,k].N+1;
                         if Re[l,k].N>40 then  Re[l,k].N:=40;
                         sh[l,k,Re[l,k].N].Nff:=ImputMassiv[ii].Nff;
                         sh[l,k,Re[l,k].N].Tay:=ImputMassiv[1].Tay;
                         sh[l,k,Re[l,k].N].A:=ImputMassiv[ii].A;
       {создаем массив списков сигналов сцелью повторн сорт по врем приход}
                         sh[l,k,Re[l,k].N].T:=ImputMassiv[ii].T;
//                         sh[l,k,Re[l,k].N].Nff:=sh[l,k,Re[l,k].N].Nff+1;
                         sh[l,k,Re[l,k].N].Col:=ImputMassiv[ii].Col;
                         sh[l,k,Re[l,k].N].Pr:=false;
                         sh[l,k,Re[l,k].N].Pe :=ImputMassiv[ii].Pe;
                                                   {выводим матрицу на экран ЗТ}
           (*              with fmSigMatrix,fmSignTabel,canvas do
                         begin
                           if Re[l,k].N>20 then  Brush.color:= clRed else
                           if Re[l,k].N>10 then  Brush.color:= clMaroon else
                           if Re[l,k].N>0  then  Brush.color:= clGreen;
                           if Re[l,k].N>0 then
                           FillRect(fmSignTabel.CellRect(l{+1},k{+1}));
                         end;
                                                 Brush.color:=clWhite;     *)
                         goto MM111;
                  end;

     MM111:
       end ;                    {если импульс вне интервала}
 end;
  if Re[l,k].N >-1 then
     for k:=0 to 19 do
       for l:=0 to 19 do
         begin
         for f:=0 to Re[l,k].N do ZipMa[f]:=sh[l,k,f];
                                              {проверяем на контрастность}
        if fmSelect.SelectContrastIn.Checked = false then goto MM112;
//        if (abs(Re[l,k].N-Re[l+1,k].N) >= Contr) and
  //         (abs(Re[l,k].N-Re[l,k+1].N) >= Contr)
    //      then                              {проверяем число имп в ячейке}
 MM112:    if Re[l,k].N>3 then
            begin

              SortBubbl(Re[l,k].N,ZipMa);
              SelectArray(ListFinishPacet,ZipMa,Re[l,k].N);
     //           begin
       //         end;
            end;
         end;
                                                     {вывод законч пакетов}
     if ListFinishPacet.Count > 0 then
     for ii0:=0 to (ListFinishPacet.Count-1) do     begin
            if ii0 > 10 then goto MM75;
                  Pack:=ListFinishPacet.Items[ii0];
                     with fmPassivRadar,Canvas do  begin
        Font.Color:=Pack^.Col;
        TextOut(ii0*70+20,400,'            ');
        TextOut(ii0*70+20,415,'            ');
        TextOut(ii0*70+20,400,FloatToStrF(Pack^.T,ffFixed,7,7));
        TextOut(ii0*70+20,415,FloatToStrF(Pack^.Tay{N},ffFixed,7,7));
                                            end;
                                                         end;  MM75:
                                                    { конец вывода пакетов}
end;

                              {3 вариант-импразмещ по ячейкам по результ сортир}
                              {потери времени слишкрм велики}
(*procedure TPassivRadar.SelectContrast(ListFinishPacet:TList;
                                 var ImputMassiv:array of Sig;var nsig:integer);
var
  deltaA,Al,deltaTay,Tayl:Float;
  indAmin,i,k,l,indTayMin,IndTayMax:integer;
procedure sortA(Nmin,Nmax:integer;var ImputMassiv:array of sig);
var i,j:integer;
y:sig;
begin
  for i:=Nmin+1 to Nmax do
  begin
    for j:=Nmax downto i do
    if ImputMassiv[j-1].A>ImputMassiv[j].A then
    begin
     Y:=ImputMassiv[j-1];
     ImputMassiv[j-1]:=ImputMassiv[j];
     ImputMassiv[j]:=Y;
   end;
  end;
end;
procedure sortTay(Nmin,Nmax:integer;var ImputMassiv:array of sig);
var i,j:integer;
y:sig;
begin
  for i:=Nmin+1 to Nmax do
  begin
    for j:=Nmax downto i do
    if ImputMassiv[j-1].Tay>ImputMassiv[j].Tay then
    begin
     Y:=ImputMassiv[j-1];
     ImputMassiv[j-1]:=ImputMassiv[j];
     ImputMassiv[j]:=Y;
   end;
  end;
end;
procedure sortT(Nmin,Nmax:integer;var ImputMassiv:array of sig);
var i,j:integer;
y:sig;
begin
  for i:=Nmin+1 to Nmax do
  begin
    for j:=Nmax downto i do
    if ImputMassiv[j-1].T>ImputMassiv[j].T then
    begin
     Y:=ImputMassiv[j-1];
     ImputMassiv[j-1]:=ImputMassiv[j];
     ImputMassiv[j]:=Y;
   end;
  end;
end;
begin
  sortA(0,nsig,ImputMassiv);                  {сортир весь массив по амплитуде}
  deltaA:=2.5;
  deltaTay:=0.5;
  Al:=ImputMassiv[0].A+deltaA;                     {выставл первую границу по А}
  indAmin:=0;
  for i:=0 to nsig do
  if (ImputMassiv[i].A>Al) or (i=nSig) then {если очеред ампл превысила границу}
  begin
    Al:=Al+deltaA;                                     {выставляем новую грницу}
    SortTay(indAmin,i-1,ImputMassiv);     {сортир имп выбранного отрезка по Тау}
    Tayl:=ImputMassiv[indAmin].Tay+deltaTay;        {выставляем верхнюю границу}
    indTaymin:=indAmin;                           {фиксир новыйначальн инд по А}
    IndAmin:=i;
    for k:=indTayMin to i-1 do            {перебираем инд отсорт по Тау отрезка}
    if (ImputMassiv[k].Tay >Tayl) or ( k=i-1) then {если имп перешел через гран}
    begin
      Tayl:=Tayl+deltaTay;                        {выставл новую границу по Tay}
      SortT(indTaymin,k-1,ImputMassiv);      {сортир имп интерв по врем прихода}
      IndTayMax:=k-1;                                {фиксируем верхний импульс}
      SelectArray(ListFinishPacet,ImputMassiv,IndTayMax,indTaymin);
      indTaymin:=k;                                {устана новый начальн индекс}
    end;
  end;
end;    *)
procedure TfmPassivRadar.IdentifPaket(var Pach_:PoPach; ListCurrentPach,
 ListFinishPach, ListFinishPacet:TList);
label MM105,MM115,MM125;
var
Pach:PoPach;
Pack:PoPack;
ii,ind2,ii0:integer; DeltaTay,DeltaNf,ConstDi2:Float;
begin
   ConstDi2:=1.2*fmPassivRadar.BPK/fmPassivRadar.WP;{ум на 1.2 чтоб не дроб пачку }
                                                      {задаем врем шир ДНА}
   deltaTay:=0.5;                             {задаем строб ср по длит имп}
   deltaNf:=fmSelect.deltaNfEdit.Value;
                                              {задаем строб ср по нес част}
   if ListCurrentPach.Count>0 then             {ес спис незав пачек наполн}
      for ii:=0 to ListCurrentPach.Count-1 do    {то орг цикл по незав пач}
      if ii<=ListCurrentPach.Count-1 then
      begin
      Pach_:=ListCurrentPach.Items[ii];
      if(ttsek_-Pach_^.Beg)>constDi2 then     {и пров их по крит завер пач}
                                                               {по времени}
        begin                                       {если критер выполн то}
           New(Pach);
               Pach^.Pel:=Pach_^.Pel/Pach_^.N;       {средн пеленг пачки}
               Pach^.N:=Pach_^.N;      Pach^.Col:=Pach_^.Col;
               Pach^.T:=Pach_^.T;      Pach^.Beg:=Pach_^.Beg;
               Pach^.Tay:=Pach_^.tay;  Pach^.Nf:=Pach_^.Nf;
               Pach^.Pe:=Pach_^.Pe;    Pach^.Pr:=False;
{проверить!}      //       Pack^.Pr:=true;
           ListFinishPach.Add(Pach);          { переводим их в спис заверш}
           ListCurrentPach.Delete(ii);
        end;
      end;
        if ListFinishPacet.Count>0 then          {есл вх спис пакет наполн}
        for ii:=0 to ListFinishPacet.Count-1 do {то орг цикл по всем пакет}
        begin
           Pack:=ListFinishPacet.Items[ii];              {выбир очер пакет}
           if(Pack^.T<ttsek_) then       {и обр его на интер ttsek..ttsek_}
           begin
              if ListCurrentPach.Count=0 then  {если спис незав пачек пуст}
                                   {то перв пакет завяз пер цельс параметр}
              begin
                   New(Pach_);
                   Pach_^.Pel:=Pack^.Pel;
                   Pach_^.N:=1;                 Pach_^.Col:=Pack^.Col;
                   Pach_^.T:=Pack^.T;           Pach_^.Beg:=Pack^.T;
                   Pach_^.tay:=Pack^.Tay;       Pach_^.Nf:=Pack^.Nf;
                   Pach_^.Pe:=Pack^.Pe;
{проверить!}                Pack^.Pr:=true;
                   ListCurrentPach.Add(Pach_);
                                                goto MM105;
              end;
           if ListCurrentPach.Count>0 then     {есл спис незав пачек полон}
           for ind2:=0 to ListCurrentPach.Count-1 do   {то орг цикл по нез}
                                                                  { пачкам}
           if(ind2<=ListCurrentPach.Count-1) then     {т к числ эл мож изм}
               begin
                   Pach_:=ListCurrentPach.Items[ind2];      {выбир очер зл}
                   if(abs(Pach_^.tay-Pack^.Tay)<deltaTay) and
                     (abs(Pach_^.Nf-Pack^.Nf)  <=deltaNf)    {если пак припис}

                                               { к пачке при срав по парам}
                   then                  {то пров вып крит зав пач по врем}

                       if (Pack^.T-Pach_^.Beg)<ConstDi2 then
                       begin
                                              {накапливаем пеленги пакетов}
                         Pach_^.Pel:=Pach_^.Pel+Pack^.Pel;;
                         Pach_^.N:=Pach_^.N+1;     {доб 1 в сч числа пакет}
                         Pack^.Pr:=True;{призн того что пак припис к пачке}
                         ListCurrentPach.Delete(ind2);{удал из сп стар пач}
                         ListCurrentPach.Insert(ind2,Pach_); {ввод в спис }
                                                             {   нов пачку}
                       end
                       else
                       begin

                      New(Pach_);
                        Pach_^.Pel:=Pack^.Pel;
                        Pach_^.N:=1;                 Pach_^.Col:=Pack^.Col;
                        Pach_^.T:=Pack^.T;           Pach_^.Beg:=Pack^.T;
                        Pach_^.tay:=Pack^.Tay;       Pach_^.Nf:=Pack^.Nf;
                          ListFinishPach.Add(Pach_);
                          ListCurrentPach.Delete(ind2);
                       end
                   else          {если критер сравн по парам не выполнился}
                       if ind2=ListCurrentPach.Count-1 then { список исчер}
                       if Pack^.Pr=False then{и паке не припис ни к одн па}
                       begin
                        New(Pach_);             {то  завязываем ноую пачку}
                          Pach_^.Pel:=Pack^.Pel;
                          Pach_^.N:=1;               Pach_^.Col:=Pack^.Col;
                          Pach_^.T:=Pack^.T;         Pach_^.Beg:=Pack^.T;
                          Pach_^.tay:=Pack^.Tay;     Pach_^.Nf:=Pack^.Nf;
                          ListCurrentPach.Add(Pach_); {и добав ее в список}
                       end;
                    end;
                 end;
        MM105: end;
                                                            {вывод законч }
       if ListFinishPach.Count > 0 then
       for ii0:=0 to (ListFinishPach.Count-1) do     begin
                  Pach:=ListFinishPach.Items[ii0];
                     with fmPassivRadar,Canvas do  begin
        TextOut(ii0*70+20,445,'                      ');
        TextOut(ii0*70+20,460,'                      ');
        TextOut(ii0*70+20,475,'                      ');
        Font.Color:=Pach^.Col;
        TextOut(5,445,'Pe'); TextOut(5,460,'N');TextOut(5,475,'T');
        TextOut(ii0*70+20,445,FloatToStrF(Pach^.Pel,ffFixed,7,7));
        TextOut(ii0*70+20,460,FloatToStrF(Pach^.N,ffFixed,7,7));
        TextOut(ii0*70+20,475,FloatToStrF(Pach^.tay,ffFixed,7,7));
                                            end;
                                                         end;   MM115:
                                                              { конец вывода }
                                   {если удалить пакеты так то хорошо без помех}
                                                          {но плохо в помехах}
    for ii:=0 to ListFinishPacet.Count-1 do
      if ii<= ListFinishPacet.Count-1 then begin       {удаляем  начал пак }
      Pack:=ListFinishPacet.Items[ii];
      if Pack^.Pr=true then
      if ListFinishPacet.Count>0 then
      ListFinishPacet.Delete(ii) else
       goto MM125;
                                           end; MM125:
                                 {если удалять пакеты так то хорошо в усл помех}
                              {но теряются цели без помех при больших временах}
//        ListFinishPacet.Clear;
  //     for ii:=0 to ListFinishPacet.Count-1 do
    //  FreeMem(ListFinishPacet[ii],SizeOf(ListFinishPacet[ii]));
end;                                                              {ident}
procedure TfmPassivRadar.IdentifPach(var TargetProb:PoTarget; ListCurrentTargetProb,
ListFinishPach:TList);
label MM105,MM115,MM125,MM1125;
var
Pach:PoPach;
ii,ind2,ii0:integer; DeltaTay,DeltaNf:Float;
procedure IniTargetProb;
begin
   New(TargetProb);
   TargetProb^.Pel[1]:=Pach^.Pel;
   TargetProb^.N:=1;                 TargetProb^.Col:=Pach^.Col;
   TargetProb^.T[1]:=Pach^.T;           TargetProb^.Beg:=Pach^.T;
   TargetProb^.tay:=Pach^.Tay;       TargetProb^.Nf:=Pach^.Nf;
   TargetProb^.Pe:=Pach^.Pe;
  Pach^.Pr:=True;
   ListCurrentTargetProb.Add(TargetProb);
end;
begin
   deltaTay:=0.5;                             {задаем строб ср по длит имп}
   deltaNf:=fmSelect.deltaNfEdit.Value;
 //  deltaNf:=1;                                {задаем строб ср по нес част}
   if ListCurrentTargetProb.Count>0 then             {ес спис незав целей наполн}
      for ii:=0 to ListCurrentTargetProb.Count-1 do    {то орг цикл по незав цел}
      if ii<=ListCurrentTargetProb.Count-1 then
      TargetProb:=ListCurrentTargetProb.Items[ii];
        if ListFinishPach.Count>0 then          {есл вх спис пачек наполн}
        for ii:=0 to ListFinishPach.Count-1 do {то орг цикл по всем пачкам}
        begin
           Pach:=ListFinishPach.Items[ii];              {выбир очер пачку}
           begin
              if ListCurrentTargetProb.Count=0 then  {если спис незав целей пуст}
                                   {то перв пачка завяз пер цельс параметр}
              begin
              IniTargetProb;
                                                goto MM105;
              end;
           if ListCurrentTargetProb.Count>0 then     {есл спис незав целей полон}
           for ind2:=0 to ListCurrentTargetProb.Count-1 do   {то орг цикл по нез}
                                                                  { целям}
           if(ind2<=ListCurrentTargetProb.Count-1) then     {т к числ эл мож изм}
               begin
                   TargetProb:=ListCurrentTargetProb.Items[ind2]; {выбир очер зл}
                   if(abs(TargetProb^.tay-Pach^.Tay)<deltaTay) and
                     (abs(TargetProb^.Nf-Pach^.Nf)  <=deltaNf)  {если пач припис}
                                               { к цели при срав по парам}
                   then
                       begin
                                                        {припис цели нов пеленг}
                     //    TargetProb^.Pel:=Pach^.Pel;
                         TargetProb^.N:=TargetProb^.N+1; {доб 1 в сч числа пачек}
                         TargetProb^.Pel[TargetProb^.N]:=Pach^.Pel;
                         Pach^.Pr:=True;{призн того что пач припис к цкли}
                         ListCurrentTargetProb.Delete(ind2);{удал из сп стар цел}
                         ListCurrentTargetProb.Insert(ind2,TargetProb);
                                                        {ввод в спис   нов цель}
                       end
                       else
                       if (ind2=ListCurrentTargetProb.Count-1)and(Pach^.Pr=False)
                       then
                       begin
                       IniTargetProb;
                       end
                    end;
                 end;
        MM105: end;
                                                            {вывод законч }
       if ListCurrentTargetProb.Count > 0 then
       for ii0:=0 to (ListCurrentTargetProb.Count-1) do     begin
                  TargetProb:=ListCurrentTargetProb.Items[ii0];
                     with fmPassivRadar,Canvas do  begin
        Font.Color:=TargetProb^.Col;
        TextOut(5,490,'Pe'); TextOut(5,505,'N');TextOut(5,520,'T');
        TextOut(ii0*70+20,490,
                        FloatToStrF(TargetProb^.Pel[TargetProb.N],ffFixed,7,7));
        TextOut(ii0*70+20,505,IntToStr(TargetProb^.N));
        TextOut(ii0*70+20,520,FloatToStrF(TargetProb^.tay,ffFixed,7,7));
                                            end;
                                                         end;   MM115:
                                                           { конец вывода }
         ListFinishPach.Clear;
        for ii:=0 to ListFinishPach.Count-1 do
        FreeMem(ListFinishPach[ii],SizeOf(ListFinishPach[ii]));
(*    if ListFinishPach.Count>0 then
    for ii:=0 to ListFinishPach.Count-1 do
    if ii<= ListFinishPach.Count-1 then begin      {удаляем  начал пач }
      Pach:=ListFinishPach.Items[ii];
      if Pach^.Pr =true then
      if ListFinishPach.Count>0 then
      ListFinishPach.Delete(ii) else
       goto MM125;                                           end; MM125:    *)
end;                                                              {ident}

procedure TfmPassivRadar.TimerTimer(Sender: TObject);
label MM66;
var
  pPack_:array of PoPack;
  pPach_:array of PoPach;
  pTargetProb:array of PoTarget;
  AASig:Sig;
  ListPr:TList;
  Vx, Vy,P1toP2: Extended;
  tsi,tsizip,
  PathR,
  kil,St,beta,alfa,fi,B,gamma,
  dP,                                             {угол между PTek и целью}
  dPmin,C1,C2,C3,  D1,D2,D3,  P1,P2,P3,  XTtt,YTtt,ttt,  ViewPel,D,  R1,R2 : Float;
  ii01,nc,rr,Targ, TargIndex,T,ind,ind1,k12,k11,i,ht,DNind1,DNdtind,DNdtind1,
  ii: Integer;
  Target: TTarget;
  TargetInDN,AA,BB,CC,InDiagr1: Boolean;
  ImageVi:TImage;

  CurrentBAZ : Double;

  TempAAAA   : Integer;
begin
{  if nsig > -1 then
  for k11 :=1 to Copy do
  for k12 :=0 to NS do
  with pImputMassiv[k11,k12] do
    begin
            nsig:=-1;
            T  :=0;    A:=0;  Tay:=0;  Pe:=0;
            Nff:=0;
            Pr :=false;
    end;   }

  if Switch.Down then begin
      // --- Проверка "Наличие включенного диапазона" -----
    if not fmSwitch.SwitchDia1.Checked and
       not fmSwitch.SwitchDia2.Checked and
       not fmSwitch.SwitchDia3.Checked and
       not fmSwitch.SwitchDia4.Checked and
       not fmSwitch.SwitchDia5.Checked then begin
       Timer.Enabled := false;
       MessageDlg('Fix diapasons list'#10#13'Click Pause', mtInformation, [mbOk],0);
       exit;
    end;
       //формируем матрицу назначенных диапазонов
    if fmSwitch.SwitchDia1.Checked then  NumberDiaSwitch[1]:=True
                                   else  NumberDiaSwitch[1]:=False;
    if fmSwitch.SwitchDia2.Checked then  NumberDiaSwitch[2]:=True
                                   else  NumberDiaSwitch[2]:=False;
    if fmSwitch.SwitchDia3.Checked then  NumberDiaSwitch[3]:=True
                                   else  NumberDiaSwitch[3]:=False;
    if fmSwitch.SwitchDia4.Checked then  NumberDiaSwitch[4]:=True
                                   else  NumberDiaSwitch[4]:=False;
    if fmSwitch.SwitchDia5.Checked then  NumberDiaSwitch[5]:=True
                                   else  NumberDiaSwitch[5]:=False;

  end;


                       {если вкл адапт то определ число работ диапазонов}
  if Adupt.Down then DetectDiaTarget;
  if fmSelect.SelectOn.Checked=True then
  begin
    fmPassivRadar.EdCopy.Value:=1;
    fmPassivradar.EdCopy.EditorEnabled:=False;
  end
  else
  begin
                                   {если сел откл то устан число копий}
//  if fmPassivRadar.EdCopy.Value=1 then fmPassivRadar.EdCopy.Value:=50 ;
  end;
  if fmSelect.SelectOn.Checked=True then
  begin
  SetLength( pTargetProb,fmPassivRadar.EdCopy.Value+1);
  SetLength( pPach_,fmPassivRadar.EdCopy.Value+1);
  SetLength( pPack_,fmPassivRadar.EdCopy.Value+1);
  end;
  if (Assigned(fmSelect)) then if (fmSelect.SelectOn.Checked=True) then
    fmPassivradar.ScaleEdit.Value:=2;

  fmSigMatrix.Label10.Caption:=fmSigMatrix.EditSenterP.Text;
     R1:=StrToInt(fmSigMatrix.EditSenterP.Text)-StrToInt(fmSigMatrix.EditDeltaP.Text)*0.1*10;
  fmSigMatrix.Label11.Caption:=FloatToStr(R1);
     R2:=StrToInt(fmSigMatrix.EditSenterP.Text)+StrToInt(fmSigMatrix.EditDeltaP.Text)*0.1*10;
  fmSigMatrix.Label12.Caption:=FloatToStr(R2);
  if (fmSelect.SelectOn.Checked = False) and (tt=0) then
  begin
  fmMap.Show; fmTargetEdit.Show;// fmStatisticProb.Show;
  end;
//  if fmSelect.SelectOn.Checked = False then ScaleEdit.value:=20 else
  //                                          ScaleEdit.Value:=2;
(*  if (tt > 10) and (CU1.Down) then Tuern.Down:=True;
  if (tt > 7{20}) and  (DateOut.Checked=False) then
  begin
  OutDate.OnClick(Self);
//  DateOut.Checked:=True;
  end;
  if DateOut.Checked=True then                {если данные выданы в оружие}
  begin
     PathR:=10*(tt-7{20});                 {путь ракеты летящ со скор 10км/мин}
     if Assigned(TargetList) and(TArgetList.Count > 0) then
         for Targ :=0 to TargetList.Count-1  do
         begin
            Target:=TTarget(TargetList.Items[Targ]);
            D := Hypot(Target.X-Carrier2.X, Target.Y-Carrier2.Y);
                       {если расст о ракет до цели < 25 и курс еще не менялся}
           if (D-PathR <25) and (Target.Man=True) then
           begin
                                                           {то меняем курс цели}
           if Target.Color=0 then Target.Kurs:=Target.Kurs+30;
            if Target.Color=1 then Target.Kurs:=Target.Kurs+60;
             if Target.Color=2 then Target.Kurs:=Target.Kurs+90;
              if Target.Color=3 then Target.Kurs:=Target.Kurs+120;
               if Target.Color=4 then Target.Kurs:=30;//Target.Kurs+150;
                if Target.Color=5 then Target.Kurs:=60;//Target.Kurs+180;
           Target.Man:=False;
           end;
         end;
  end;            *)
  ii01:=-1;
  if Tuern.Down then
  if (TimeToScroll > 0) and (TimeToScroll <= Time) then
  begin
    TimeToScroll := 0;
    Scrolling := true;
  end;
  if Scrolling then with HorScrollBar do
  begin
    ViewPel := 260*(Position / Max - 0.5);
    if ViewPel > PB then ViewPel := ViewPel - 2;
    if ViewPel < PB then ViewPel := ViewPel + 2;
    if abs(ViewPel - PB) < 2 then
    begin
      ViewPel := PB;
      Scrolling := false;
    end;
    if Position <> Max * (0.5 + ViewPel / 260) then Position :=
                               Round(Max * (0.5 + ViewPel / 260));
  end;
 // ttzip:=tt;
  tt := tt + delta_t;                                              {тек время}
  if (fmManager.CU1.Down) and (tt>TimeTurnConst) and (TimeTurn=0) then

  begin
   Tuern.Down:=True;
   TimeTurn:=tt;

  end;
                                                          {автоостановка}
  if fmManager.CU1.Down and (tt > 30) and (tt < 30+delta_t) then
  Timer.Enabled:=False;
  if not fmManager.CU1.Down and (tt > 10) and (tt < 10+delta_t) then
  Timer.Enabled:=False;

 // if (tt>10) and (tt< 10+delta_t) then ttTuern:=tt;
  ttsek := tt*60;
  ttsek_:=ttsek+60*delta_t;
                                   {фиксация моментов выдачи данных статистик}
  if (tt>=delta_t_st) and (tt-delta_t<delta_t_st)then
  begin
    CC:=true;
    delta_t_st:=delta_t_st+ delta_t_stt;
    inc(CurrentTablePos); // --- Увеличиваю позицию в таблице Exel
  end
            else   CC:=false;
  PanoramaClick(Self);

  P1toP2:=grad*ArcTan2(Carrier2.X-Carrier1.X,Carrier2.Y-Carrier1.Y);
  BAZ   := Hypot(Carrier2.X-Carrier1.X, Carrier2.Y-Carrier1.Y);
  BAZ3  := Hypot(Carrier2.X-Carrier3.X, Carrier2.Y-Carrier3.Y);
  BAZ13 := Hypot(Carrier3.X-Carrier1.X, Carrier3.Y-Carrier1.Y);
  DrawDN(PTEK);
  if Adupt.Down then  ind:=DetTarget.Count        {просмотр только обнар целей}
                   else  ind:=TargetList.Count;           {просмотр всех целей}
         if Assigned(TargetList) and(TArgetList.Count > 0) then
         for Targ :=0 to TargetList.Count-1  do
         begin
           //  for nc:=1 to fmPassivRadar.EdCopy.Value do
            Target:=TTarget(TargetList.Items[Targ]);
            Target.SumProb123:=0; Target.SumProb12:=0;
            Target.SumProb:=0;Target.SumProb_1:=0;Target.SumProb2:=0;Target.SumProb_:=0;
            Target.SumDis:=0; Target.SumDis1:=0;
            Target.SumPel:=0;Target.SumPel1:=0; Target.SumV:=0;Target.SumK:=0;
            Target.Di_:=0; Target.Di_1:=0; Target.Pe_:=0; Target.Pr_:=0;Target.K_:=0;Target.V_:=0;
         end;
  for nc:=1 to fmPassivRadar.EdCopy.Value do
  begin                                          {цикл по числу копий цели}
//    nsig:=-1;
                     {обнуление приводит к слишком большим затратам времени}
  if nsig <>-1{0} then
  if fmSelect.SelectOn.Checked = true then
  for k11 :=1 to fmPassivRadar.EdCopy.Value do
  for k12 :=0 to ArS do
  with pImputMassiv[k11{nc},k12] do
    begin
            T  :=0;    A:=0;  Tay:=0;  Pe:=0;
            Nff:=0;
            Pr :=false;
    end;
     nsig:=-1;
{O}  if ind > 0 then
     begin
       InDiagr:=False;
           //************************************
           for targ := 0 to TargetList.Count -1 do
           begin
               Target := TTarget(TargetList.Items[Targ]);
               if nc=1 then
               begin                                         //рисуем только 1 копию
                 Target.Move(delta_t);
                 Target.S2 := grad*arctan2(Target.X-Carrier1.X, Target.Y-Carrier1.Y);
                                                      //текущие ист пеленги с 1ПРЛС
                                                      //текущие ист пеленги со 2ПРЛС
                 Target.S_2 := grad*arctan2(Target.X-Carrier2.X, Target.Y-Carrier2.Y);
                 Target.S__2 := grad*arctan2(Target.X-Carrier3.X, Target.Y-Carrier3.Y);
                 D := Hypot(Target.X-Carrier2.X, Target.Y-Carrier2.Y);
                                                           //тек ист дальн от 2 ПРЛС
                 DrawRealTarget(Target.S_2, D, TargetColors[Target.Color]);
                 // --- Вывод Реального пеленга ( Паша )----
                 if fmManager.CU1.Down then begin
                     if not Tuern.Down then fmSgPeleng.DrawRealPeleng(Target.Number, tt, Target.S2, Target.S_2,true)
                                       else fmSgPeleng.DrawRealPeleng(Target.Number, tt, Target.S2, Target.S_2,False);
                 end else begin
                     fmSgPeleng.DrawRealPeleng(Target.Number, tt, Target.S_2, Target.S_2,true)
                 end;
                // --- End of Вывод Реального пеленга ----
               end;
           end;
           //************************************
           //************************************
           //************************************

{I}    for Targ :=0 to ind-1 do
       begin                                    {цикл по целям}{II}

(*       if nc=1 then
       if Target.TPause<>0 then
       begin
             if tt=delta_t then
             begin
               Target.FPause[nc]:=0.01*random(628);
               PGMamory[Targ]:=Target.PG;
             end;
             tsi:=sin(2*pi*tt/Target.TPause+Target.FPause[nc]);
             if tsi<0 then Target.PG:=0 else Target.PG:=PGMamory[Targ];
       end;           *)

         if nc=1 then fmStatisticProb.OutInformationOnPanel(Target);

         if Adupt.Down then
         Target := TTarget(DetTarget.Items[Targ]) else
         Target := TTarget(TargetList.Items[Targ]);
{III}      with Target do
           begin
                                                {паузный режим}
     //      if fmTargetEdit.Pause.Checked then
       //    begin
           if tt=delta_t then
             begin                        {случайная начальная фаза}
               Target.FPause[nc]:=0.01*random(628);
               if Target.PG<>0 then       {запоминаем потенциал}
               PGMamory[Targ]:=Target.PG;
             end;
           if fmTargetEdit.EditPause.Value <>0 then
           begin

             tsi:=sin(10*2*pi*tt/(2*fmTargetEdit.EditPause.Value)+Target.FPause[nc]);
             if tsi<0 then
                        Target.PG:=0
                      else
                        Target.PG:=PGMamory[Targ];
           end;
   //          if fmTargetEdit.EditPause.Value=0 then Target.PG:=PGMamory[Targ] ;
         //  end;
          Target.ChangeP(nc);
//        ppsh1[nc]:=0; p_sh1[nc]:=0;        {обнуление счетчиков числа пакетов}

           {if nc=1 then
           begin                                         //рисуем только 1 копию
             Target.Move(delta_t);
             Target.S2 := grad*arctan2(Target.X-Carrier1.X, Target.Y-Carrier1.Y);
                                                  //текущие ист пеленги с 1ПРЛС
                                                  //текущие ист пеленги со 2ПРЛС
             Target.S_2 := grad*arctan2(Target.X-Carrier2.X, Target.Y-Carrier2.Y);
             Target.S__2 := grad*arctan2(Target.X-Carrier3.X, Target.Y-Carrier3.Y);
             D := Hypot(Target.X-Carrier2.X, Target.Y-Carrier2.Y);
                                                       //тек ист дальн от 2 ПРЛС
             DrawRealTarget(Target.S_2, D, TargetColors[Target.Color]);
           end;}
                                                 {условие попадания в диаграмму}
           InDiagr1:= (Dia = Diap) and (Target.S_2<fmPassivRadar.PTEK+fmPassivRadar.BPK/2)
                           and (Target.S_2>fmPassivRadar.PTEK-fmPassivRadar.BPK/2);
                  {если хотябы одна из цел попад в диагр, выраб признак InDiagr,
                    котор используется при адапт обзоре пространства ему присв
                                     False перед тем как войти в цикл по цклям}
           if InDiagr1 then InDiagr:=True;
           if                                               {селекция включена}
{IV}        (fmselect.SelectOn.Checked  and
                                       {выполняется условие попадан в диаграмму}
         //  (Dia = Diap) and (Target.S_2<fmPassivRadar.PTEK+fmPassivRadar.BPK/2)
           //                and (Target.S_2>fmPassivRadar.PTEK-fmPassivRadar.BPK/2)
                InDiagr1)
           or                                           {селекция отключена}
           (( fmSelect.SelectOn.Checked = False) and
                            {выполняется условие перех макс диаг напр на цель }
                                                    (Dia = Diap) and
               (((fmPassivRadar.PTEK > Target.S_2) and (fmPassivRadar.PTEKZip <= Target.S_2)) or
{IV}            ((fmPassivRadar.PTEK < Target.S_2) and ((fmPassivRadar.PTEKZip) >= Target.S_2))))
                                                                            then
           begin
                                {проверка на двоение целей за счет наплывания диаграмы на движ цель}
              if ((tt-Target.tdubl[nc]) <= 2*delta_t) and( fmSelect.SelectOn.Checked = False)
                                                               and (tt>2*delta_t) then goto MM66;
             Target.tdubl[nc]:=tt;
             if Switch.Down then SetDiap(Diap);
      //       if Adupt.Down then WP:=0.25;
                                                 {условие уменьшен скор обзора}
                                                                       {1носит}
                                                           {селекция отключена}
             if( fmSelect.SelectOn.Checked = False) then
             peleng(Target,1,Carrier1,nc,pListDN,pdd0[nc],
               pl[nc],psh25[nc], ppsh1[nc],{pTSignBeg1[nc],}VM1[nc],SigLow1[nc],
                                                              pa21[nc],pa22[nc],
                       pa211[nc],pa212[nc],pa222[nc],pb21[nc],pb22[nc],pb23[nc],
                                         {pttprov[nc],}PPI[nc], S1[nc], S2, D,H,
                            PP002[nc],PPWIP2[nc],PAAA[nc],PBBB[nc],PCCC[nc],Po);
             if nc=fmPassivRadar.EdCopy.Value then D :=
                          Hypot(Target.X-fmPassivRadar.X, Target.Y-fmPassivRadar.Y);
             if fmSelect.SelectOn.Checked = true then
             FormImputSignal(Target,pImputMassiv[nc],nsig);
            {2носит,осущест синхр обзор с 1нос}

                                 {если ЦУ1 то уровень медл флукт на обр галсе старый}
            if Tuern.Down then
            begin
              VM2[nc]:=VM1[nc];
              SigLow2[nc]:=SigLow1[nc];
            end;
                                                   {селекция отключена}
             if  ( fmSelect.SelectOn.Checked = False) then
             peleng(Target,2,Carrier2,nc,p_ListDN,p_dd0[nc],
             pl_[nc],p_sh25[nc], p_sh1[nc],{p_TSignBeg1[nc],}VM2[nc],SigLow2[nc],
                                                                       p_a21[nc],
                           p_a22[nc], p_a211[nc],p_a212[nc],p_a222[nc],p_b21[nc],
                   p_b22[nc],p_b23[nc],{p_ttprov[nc],}PPI_[nc], S_1[nc],S_2, D,H,
                       P_P002[nc],P_PWIP2[nc],P_AAA[nc],P_BBB[nc],P_CCC[nc],Po_);

                {3носит,осущест синхр обзор с 1нос}
                                                   {селекция отключена}
             if  ( fmSelect.SelectOn.Checked = False) then
                 peleng(Target, 3,Carrier3,nc,      p__ListDN,    p__dd0[nc],
                        pl__[nc],    p__sh25[nc],  p__sh1[nc],{p__TSignBeg1[nc],}
                        VM3[nc],     SigLow3[nc],  p__a21[nc],
                        p__a22[nc],  p__a211[nc],  p__a212[nc],
                        p__a222[nc], p__b21[nc],   p__b22[nc],{p__ttprov[nc],}
                        p__b23[nc],  PPI__[nc],    S__1[nc],
                        S__2,        D,            H,
                        P__P002[nc], P__PWIP2[nc], P__AAA[nc],
                        P__BBB[nc],  P__CCC[nc],   Po__);

                                       {при TargetList.Count ошибка при добавлении целей в редакторе}
                   if  Ot_ = nil then begin
                       //SetLength(Ot0_,200{TargetList.Count},1{fmPassivRadar.EdCopy.Value});
                       //SetLength(Ot_,200{TargetList.Count},200,1{fmPassivRadar.EdCopy.Value});
                       SetLength(Ot0_,200{TargetList.Count},1{fmPassivRadar.EdCopy.Value});
                       SetLength(Ot_ ,20{TargetList.Count},600,1{fmPassivRadar.EdCopy.Value});
                       fmSgPeleng.PreSet();
                   end;
           if (nc=1) and (Target.Number < 20) then  {введено для экономии памяти}
           begin
                   if fmManager.CU1.Down then
                   begin
                     if Target.ppsh1[nc]>0 then
                     begin
                          if  rad*Target.PPI[nc] < 0 then fmPassivRadar.Ot_[Target.Number,Target.psh25[nc]-1,nc-1].Pel:= rad*Target.PPI[nc] + 2*pi
                                                     else fmPassivRadar.Ot_[Target.Number,Target.psh25[nc]-1,nc-1].Pel:= rad*Target.PPI[nc];
                          fmPassivRadar.Ot_[0           ,0                  ,nc-1].Color  := Target.Color;
                          fmPassivRadar.Ot_[Target.Number,0                 ,nc-1].sh25    := Target.psh25[nc];
                          fmPassivRadar.Ot_[Target.Number,Target.psh25[nc]-1,nc-1].t       := tt;
                          fmPassivRadar.Ot_[Target.Number,Target.psh25[nc]-1,nc-1].Xp      := Carrier1.X;
                          fmPassivRadar.Ot_[Target.Number,Target.psh25[nc]-1,nc-1].Yp      := Carrier1.Y;
                      if nc=1 then
                         fmSgPeleng.DrawSgPeleng_And_AproximatePeleng(Target,
                                                                      Target.Number, //---Target.Color,
                                                                      fmPassivRadar.Ot_[Target.Number,Target.psh25[1]-1,0].t,
                                                                      True);
                     end;
                     if Target.p_sh1[nc]>0 then
                     begin
                         if  rad*Target.PPI_[nc] < 0 then fmPassivRadar.Ot_ [Target.Number,Target.p_sh25[nc]+ Target.psh25[nc]-1,nc-1].Pel:=rad*Target.PPI_[nc] + 2*pi
                                                      else fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]+ Target.psh25[nc]-1,nc-1].Pel:=rad*Target.PPI_[nc];
                          fmPassivRadar.Ot_[0   ,0                  ,nc-1].Color                := Target.Color;                  {Паша проверь правильность}
                          fmPassivRadar.Ot_[Target.Number,0                 ,nc-1].sh25                  := Target.p_sh25[nc]+Target.psh25[nc];//-1;
                          fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]+Target.psh25[nc]-1,nc-1].t   := tt;
                          fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]+Target.psh25[nc]-1,nc-1].Xp  := Carrier2.X;
                          fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]+Target.psh25[nc]-1,nc-1].Yp  := Carrier2.Y;
                          if nc=1 then
                              fmSgPeleng.DrawSgPeleng_And_AproximatePeleng(Target,
                                                                           Target.Number, // --- Target.Color,
                                                                           fmPassivRadar.Ot_[Target.Number,Target.p_sh25[1]+Target.psh25[1]-1,0].t,
                                                                           False);
                     end;
                   end;
                   if not fmManager.CU1.Down then
                   if Target.p_sh1[nc]>0 then
                   begin
                          if  rad*Target.PPI_[nc] < 0 then fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]-1,nc-1].Pel:= rad*Target.PPI_[nc] + 2*pi
                                                     else  fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]-1,nc-1].Pel:= rad*Target.PPI_[nc];
                          fmPassivRadar.Ot_[0   ,0                  ,nc-1].Color  := Target.Color;              { Паша проверь правильность}
                          fmPassivRadar.Ot_[Target.Number,0                  ,nc-1].sh25   := Target.p_sh25[nc];//-1;
                          fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]-1,nc-1].t     := tt;
                          fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]-1,nc-1].Xp    := Carrier1.X;
                          fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]-1,nc-1].Yp    := Carrier1.Y;
                          Target.P_AAA[1]:=Target.P_AAA[1];
                          Target.P_BBB[1]:=Target.P_BBB[1];
                          Target.P_CCC[1]:=Target.P_CCC[1];
                          if nc=1 then
                              fmSgPeleng.DrawSgPeleng_And_AproximatePeleng(Target,
                                                                           Target.Number, // ---
                                                                           fmPassivRadar.Ot_[Target.Number,Target.p_sh25[nc]-1,0].t,
                                                                           True);
                   end;
            end;
//               if (tt > 20) then
  //             begin
    //             if (Targ=0) and (nc=1) then
      //           begin
        //         for ii:=0 to 10 do
          //         fmSgPeleng.Date.Items.Add(FloatToStrF(Ot[0,ii,0].Pel,ffFixed,4,4));
            //       Timer.Enabled:=False;
              //   end;
               //end;

           //  if Target.p_sh1[1]>0 then
           //  DetTargetGrid.Repaint;
         {этот фрагмент рабочий но требует отработки для работы на прямом галсе}
 (*                          {если ВИП > 2 то вкл алгор нелинейной аппрокимации}
             if abs(P_PWIP2[1])>2 then
                                  SgPelengForm.NonLineApprox.Checked:=True else
                           {если ВИП <=2 то вкл алгоритм линейной аппроксимации}
             SgPelengForm.LineApprox.Checked:=True;  *)
               if (Target.p_sh25[nc]>1) and (Target.p_sh1[nc]>0) and fmSgPeleng.NonLineApprox.Checked  then begin
                                               //NonLineApr(Target,Target.Number,nc,Target.p_sh25[nc]);  //Target.psh25[nc]
                                               TempAAAA:= Target.p_sh25[nc] + Target.psh25[nc];
                                               fmSgPeleng.uuuuuuuuuuu(Target,Target.Number,nc, TempAAAA);
                                               end;
                               //       fmSgPeleng.uuuuuuuuuuu(Target, Targ,nc,Target.p_sh25[nc]);
                                                       {если есть обнаружение}
                                      {фиксируем время последнего обнаружения}
             //if nsig >0 then
             if ppsh1[nc]>0 then pttprov[nc]:=tt;
             if p_sh1[nc]>0 then p_ttprov[nc]:=tt;
                                     {дальность измер при прохожднапр на цель}
             {в расчет берется последний измеренный на каждом носителе пеленг}

             if Tuern.Down or fmManager.CU2.Down or fmManager.CU3.Down then
             if (p_sh25[nc] > 0) then
               begin
                 if fmSgPeleng.OldDistans.Checked and fmManager.CU1.Down then
                                    {дальн от 2го по базе 1-2}
                  D_[nc] := BAZ*sin(ArcTan2(Carrier2.X-Carrier1.X,Carrier2.Y-
                  Carrier1.Y)-rad*S1[nc]) /sin(rad*(S1[nc] - S_1[nc]));
                  if fmManager.CU2.Down     or fmManager.CU3.Down then
                     if (p_sh25[nc]>0) and (psh25[nc]>0) then
                                    {дальн от 2го по базе 1-2}






                  D_[nc] := BAZ*sin(ArcTan2(Carrier2.X-Carrier1.X,Carrier2.Y-
                  Carrier1.Y)-rad*S1[nc]) /sin(rad*(S1[nc] - S_1[nc]));
                 if {fmSgPeleng.OldDistans.Checked and} fmManager.CU3.Down then
                 if (psh25[nc]>0) and (p_sh25[nc]>0) and (p__sh25[nc]>0) then
                 begin
                                    {дальн от 2го по базе  2-3}
                   D_3[nc] := BAZ3*sin(ArcTan2(Carrier2.X-Carrier3.X,Carrier2.Y-
                   Carrier3.Y)-rad*S__1[nc]) /sin(rad*(Target.S__1[nc] - Target.S_1[nc]));
                                     {дальн от 1го по базе 1-3}
                   D_13[nc] := BAZ13*sin(ArcTan2(Carrier1.X-Carrier3.X,Carrier1.Y-
                   Carrier3.Y)-rad*S__1[nc]) /sin(rad*(S__1[nc] - S1[nc]));
                                     {пересч дальн от 2го по базе 1-3}
                   D_13[nc] := Hypot(Carrier1.X+D_13[nc]*Sin(rad*S1[nc])-Carrier2.X,
                              Carrier1.Y+D_13[nc]*Cos(rad*S1[nc])-Carrier2.Y);
               //      D_[nc]:=D_13[nc];
                   D_[nc]:=(D_[nc]*BAZ*BAZ+D_3[nc]*BAZ3*BAZ3+D_13[nc]*BAZ13*BAZ13)/
                             (BAZ*BAZ+BAZ3*BAZ3+BAZ13*BAZ13);
                 end;
                 if fmSgPeleng.NewDistans.Checked and fmManager.CU1.Down
                    and  (Target.P_PWIP2[nc]<>0) and (Target.PPWIP2[nc]<>0) then
                   D_[nc] := BAZ*Cos(rad*Target.PPWIP2[nc]*(tt-TimeTurn))*
                        Cos(rad*Target.P_PWIP2[nc]*(tt-TimeTurn))/sin(rad*
                        (abs(Target.PPWIP2[nc])*(tt-TimeTurn)+
                                   abs(Target.P_PWIP2[nc])*(tt-TimeTurn)));
                 SinCos(rad*Target.S_1[nc], Vx, Vy);
                  {далее режектор введен для того чтобы убрать выбросы дальности}
                  {которые возникают при малой энергетикее (закон Коши - х/у) ?}
                  if fmSgPeleng.CheckRejDis.Checked then
                  if (D_[nc]<fmSgPeleng.DMinEdit.Value) or (D_[nc]>fmSgPeleng.DMaxEdit.Value) then
                        D_[nc]:=fmSgPeleng.DMinEdit.Value+(fmSgPeleng.DMaxEdit.Value-fmSgPeleng.DMinEdit.Value)/2;
                                         {далее необходимо отработать}
                  begin
     //             S_1[nc]:=S_1[nc]-BP/2;
       //           S1[nc]:=S1[nc]+BP/2;
         //            D1:=Hypot(Target.X-Carrier2.Xout, Target.Y-Carrier2.Yout);
           //          D_[nc]:=D1;
              //    D_[nc] := BAZ*sin(ArcTan2(Carrier2.X-Carrier1.X,Carrier2.Y-
                //  Carrier1.Y)-rad*S1[nc]) /sin(rad*(S1[nc] - S_1[nc]));
                 //SinCos(rad*Target.S_1[nc], Vx, Vy);
                  end;

                 Target.X_[nc] :=Carrier2.X + Vx*D_[nc];Target.Y_[nc] :=Carrier2.Y + Vy*D_[nc];
                                                       {рисуем только 1 копию}
                 if nc=1 then
                 begin
                 if (p_sh25[nc] > 1)and (p_sh1[1] > 0) then
                 begin
                   if fmSgPeleng.NonLineApprox.Checked = True then
                   begin
                     if Target.ModelP[1] > 3*pi/2 then
                   DrawScanTarget(-grad*(2*pi-Target.ModelP[1]),Target.ModelD[1],
                                               TargetColors[target.Color])else
                     DrawScanTarget(grad*Target.ModelP[1], Target.ModelD[1] ,
                                                TargetColors[Target.Color])
                   end
                                                            else
                   begin
                   if fmManager.CU1.Down and (psh25[nc]>1) then
                           DrawScanTarget(S_1[1], D_[1] , TargetColors[Target.Color]);
                   if fmManager.CU2.Down and (psh25[nc]>1) and (p_sh25[nc]>1) then
                           DrawScanTarget(S_1[1], D_[1] , TargetColors[Target.Color]);

                    if fmManager.CU3.Down and (psh25[nc]>1) and (p_sh25[nc]>1) and (p__sh25[nc]>1) then
                           DrawScanTarget(S_1[1], D_[1] , TargetColors[Target.Color]);
                   end;
                   end;
                 end;
               end;


               if DetTarget.IndexOf(Target) = -1 then
               begin
                TargIndex := DetTarget.IndexOf(nil);
                if  TargIndex > -1 then DetTarget.Items[TargIndex] := Target
                                                 else
                                                  DetTarget.Add(Target);

 //                  if Target.ppsh1[nc]=1 then
   //                begin
     //                  SetLength(Ot0,TargetList.Count,fmPassivRadar.EdCopy.Value);
       //                SetLength(Ot,TargetList.Count,100{Target.psh25[nc]},fmPassivRadar.EdCopy.Value);
         //              fmPassivRadar.Ot[Targ,Target.psh25[nc]-1,nc-1].Pel:=rad*Target.PPI[nc-1];
           //            if  fmPassivRadar.Ot[Targ,Target.psh25[nc]-1,nc-1].Pel < 0 then
             //            fmPassivRadar.Ot[Targ,Target.psh25[nc]-1,nc-1].Pel:=
               //                               fmPassivRadar.Ot[1{Targ},Target.psh25[nc]-1,nc-1].Pel+pi*2;
                 //      fmPassivRadar.Ot[Targ,Target.psh25[nc]-1,nc-1].t  :=tt;
                   //    fmPassivRadar.Ot[Targ,Target.psh25[nc]-1,nc-1].Xp  :=Carrier2.X;
                     //  fmPassivRadar.Ot[Targ,Target.psh25[nc]-1,nc-1].Yp  :=Carrier2.Y;
//                       Target.ppsh1[nc]:=0;
  //                 end;
    //           if (tt > 20) then
      //         begin
        //         if (Targ=0) and (nc=1) then
          //       begin
            //     for ii:=0 to 5 do
              //     fmSgPeleng.Date.Items.Add(FloatToStrF(Ot[0,ii,0].Pel,ffFixed,4,4));
                //   Timer.Enabled:=False;// not (Timer.Enabled);
//                 end;
  //             end;

               if (p_sh25[nc]>1) and (p_sh1[nc]>0) and fmSgPeleng.NonLineApprox.Checked  then
                                               NonLineApr(Target,Target.Number,nc,p_sh25[nc]);

                DetTargetGrid.Repaint;
                Beep;
               end;
           MM66:
{IV}       end;                                               {конец измерения}
           if (Targ=ind-1)  then                         {если цели исчерпались}
            if fmSelect.SelectOn.Checked = true then
           begin
             SortBubbl(nsig,pImputMassiv[nc]);           {сортируем сигналы}
             SortBubblA(nsig,pImputMassiv[nc]);
             if nsig > -1 then
             begin
             PuckSig(pImputMassiv[nc],nsig);
             SortBubbl(nsig,pImputMassiv[nc]);
             end;
             if nsig > -1 then                           {выводим их на дисплей}
             begin
               for DNdtind:=0 to {(ListDN.Count-1)}{nsig}1000 do
               begin
                 ind1:=trunc(DNdtind/40);
                 AASig:=pImputMassiv[nc,DNdtind];//ListDN.Items[DNdtind];
                 if DNdtind <440 then
                 begin
                   ht:=0; ImageVi:=fmImputMassiv.Image1;
                 end;
                 if DNdtind >440 then
                 begin
                   ht:=440; ImageVi:=fmImputMassiv.Image2;
                 end;
                 with {fmImputMassiv.}ImageVi,Canvas do
                 begin
                   Font.Color:=AASig.Col;
                   for i:=1 to 11 do
                   begin
                     if (DNdtind>(40*i-41)) and (DNdtind<40*i) then
                     begin
                       Font.Color:=clBlack;
                       TextOut(20+(i-1)*70+ind1*20,10,'t,сек     T,мкс ');
                       Font.Color:=AASig.Col;
                           TextOut(20+(i-1)*70+ind1*20,
                          30+(DNdtind-40*(i-1))*15,'                        ');
                       TextOut(50+20+(i-1)*70+ind1*20,
                          30+(DNdtind-40*(i-1))*15,'                        ');
                       if DNdtind <= nsig then
                       begin
                          if AASig.T >= ttsek then
                          begin
                          TextOut(20+(i-1)*70+ind1*20,30+(DNdtind-40*(i-1))*15,
                                              FloatToStrF(AASig.T,ffFixed,7,4));
                         TextOut(50+20+(i-1)*70+ind1*20,30+(DNdtind-40*(i-1))*15,
                                            FloatToStrF({ttsek}AASig.{A}Tay,ffFixed,7,4));
          //                                  IntToStr(AASig.Nff));
                          end;
                       end;
                     end;
                   end;
                 end;
               end;   //MM35:
             end;
             for DNdtind:=0 to nsig do
             begin                                     {и выводим его надисплей}
               if (DNdtind < 11) and (nc=1) then   {иначе выводится с дребезгом}
               with fmPassivRadar,Canvas do
               begin
                 Font.Color:=pImputMassiv[1,DNdtind].Col;
                 TextOut(5,340,'t'); TextOut(5,355,'A');TextOut(5,370,'T');
                 TextOut((DNdtind)*70+20,340+st1*30,'                       ');
                 TextOut((DNdtind)*70+20,355+st1*30,'                       ');
                 TextOut((DNdtind)*70+20,370+st1*30,'                       ');
                 TextOut((DNdtind)*70+20,340+st1*30,
                            FloatToStrF(pImputMassiv[1,DNdtind].T,ffFixed,7,7));
                 TextOut((DNdtind)*70+20,355+st1*30,
                            FloatToStrF(pImputMassiv[1,DNdtind].A,ffFixed,7,7));
                 TextOut((DNdtind)*70+20,370+st1*30,
                          FloatToStrF(pImputMassiv[1,DNdtind].Tay,ffFixed,7,7));
               end;
             end;
              if nsig >-1 then
              if fmSelect.SelectOn.Checked=true then
              begin
               MatrixTayA(pImputMassiv[nc],nsig);
               MatrixTA(pImputMassiv[nc],nsig);
              end;
             with  fmSelect do
             if nsig > -1 then
             if  fmSelect.SelectOn.Checked=true then
              begin                                        {вр нач сел }
                              { для прав измер необх снять вывод на экр в прц SelectArray}
               fmSelect.EditBegSel.Text:=TimeToStr(Time);
             for rr:=1 to 1 do         {цикл увел врем для измер вр выпол селек}
               if  SelectSort.Checked = true  then
               SelectContrast(pListFinishPacet,pImputMassiv[nc],nsig)
                                                               else
               SelectArray(pListFinishPacet,pImputMassiv[nc],nsig);
             end;                                         { вр окон сел}
             fmSelect.EditEndSel.Text:=TimeToStr(Time);
{+}     //        if pListFinishPacet[nc].Count>0 then
               IdentifPaket(pPach_[nc],
                pListCurrentPach,pListFinishPach,pListFinishPacet);
             if pListFinishPach.Count>0 then
               IdentifPach(pTargetProb[nc],pListCurrentTargetProb,
                                                          pListFinishPach);
             if fmSgPeleng.NonLineApprox.Checked = True then
               NonLineAprTargetProb(pTargetProb[nc],
                                                nc,pListCurrentTargetProb);

           end;
           if nsig > -1 then
           Skip[nc] := (tt - p_ttprov[nc]) > 7000;
           if CC=true then
           begin
                            Extrapol(Target,Targ,nc);
//                            if Tuern.Down then DetectKursSpeed(Target,Targ,nc);
           end;
{III} end;                                                               {with}

{I}end;                                                         {Цикл по целям}
{II}end;                                             {Цикл по числу копий цели}
// SortBubbl(nsig{-1},pImputMassiv[nc,nsig]);{сортировка в случае необходимости}
{0}end;
                                                      {Режим адаптивного поиска}
  TargetInDN := false;
  dPmin := abs(delta_p);

{  if Sector1.Down then Sek := 22.5 else
  if Sector2.Down then Sek := 45 else
  if Sector3.Down then Sek := 90;  }

    PtekZip:=Ptek;
    if fmManager.Probability.Down then
    Carrier1.Move(delta_t);
    if fmManager.CU1.Down or fmManager.CU2.Down or fmManager.CU3.Down then
    begin
    Carrier1.Move(delta_t);
    Carrier2.Move(delta_t);
    end;
    if fmManager.CU3.Down then
    Carrier3.Move(delta_t);
    fmPassivRadar.Move(delta_t);
    ChangeDia;
    ChangeSpeedScan;
 //   if ((PTEK >= PelMax) and (delta_p > 0)) or ((PTEK <= PelMin) and
     //                                                       (delta_p < 0))
   // then

    {if (not Tuern.Down) and (Target.psh25[1] > 0) then
        fmSgPeleng.DrawPointOnSeries1(Targ,
                                      tt, Target.PPI[1],
                                      Target.psh25[1]-1, Target.S2,
                                      Target.S1[1], Target.PPWIP2[1], True);

    if Tuern.Down and (Target.psh25[1] > 0) then
        fmSgPeleng.DrawPointOnSeries1(Targ,
                                      fmPassivRadar.Ot_[Targ,Target.p_sh25[1]+Target.psh25[1]-1,0].t, Target.PPI_[1],
                                      Target.p_sh25[1]+Target.psh25[1]-1, Target.S_2,
                                      Target.S_1[1],Target.P_PWIP2[1], False);}
    DrawDN(PTEK);
    if TimeToRepaint + 1/86400 < Time then
    begin
      TimeToRepaint := Time;
      DetTargetGrid.Repaint;
      fmTargetEdit.TargetGrid.Repaint;

      with fmMap do
      begin
         if not P1XEdit.Modified     then P1XEdit.Text := FloatToStrF(Carrier2.X,ffFixed, 4, 1);
         if not P1YEdit.Modified     then P1YEdit.Text := FloatToStrF(Carrier2.Y,ffFixed, 4, 1);
         if not P1KursEdit.Modified  then P1KursEdit.Text := FloatToStrF(Carrier2.Kurs,ffFixed, 4, 1);
         if not P1SpeedEdit.Modified then P1SpeedEdit.Text := FloatToStrF(Carrier2.Speed,ffFixed, 4, 1);

         if not P2XEdit.Modified     then P2XEdit.Text := FloatToStrF(Carrier2.X,ffFixed, 4, 1);
         if not P2YEdit.Modified     then P2YEdit.Text := FloatToStrF(Carrier2.Y,ffFixed, 4, 1);
         if not P2KursEdit.Modified  then P2KursEdit.Text := FloatToStrF(Carrier2.Kurs,ffFixed, 4, 1);
         if not P2SpeedEdit.Modified then P2SpeedEdit.Text := FloatToStrF(Carrier2.Speed,ffFixed, 4, 1);

         if not P3XEdit.Modified     then P3XEdit.Text := FloatToStrF(Carrier3.X,ffFixed, 4, 1);
         if not P3YEdit.Modified     then P3YEdit.Text := FloatToStrF(Carrier3.Y,ffFixed, 4, 1);
         if not P3KursEdit.Modified  then P3KursEdit.Text := FloatToStrF(Carrier3.Kurs,ffFixed, 4, 1);
         if not P3SpeedEdit.Modified then P3SpeedEdit.Text := FloatToStrF(Carrier3.Speed,ffFixed, 4, 1);
         if fmManager.CU3.down or fmManager.CU2.down then begin
            if not P1XEdit.Modified     then P1XEdit.Text := FloatToStrF(Carrier1.X,ffFixed, 4, 1);
            if not P1YEdit.Modified     then P1YEdit.Text := FloatToStrF(Carrier1.Y,ffFixed, 4, 1);
            if not P1KursEdit.Modified  then P1KursEdit.Text := FloatToStrF(Carrier1.Kurs,ffFixed, 4, 1);
            if not P1SpeedEdit.Modified then P1SpeedEdit.Text := FloatToStrF(Carrier1.Speed,ffFixed, 4, 1);
         end;


         if fmManager.CU2.Down then CurrentBAZ := Baz;
         if fmManager.CU3.Down then CurrentBAZ := Baz13;

         //function pel(X1,Y1,X2,Y2:Float):Float;

         if not edBase1.Modified   then edBase1.Text   := FloatToStrF(CurrentBAZ, ffFixed, 4, 1);
         fmMap.Get_GroupPeleng(DetTarget);
         //if not edPeleng1.Modified then edPeleng1.Text := FloatToStrF(fmMap.Get_GroupPeleng(DetTarget), ffFixed, -4, 1);

         ScreenImage1.Repaint;
         fmMap.PaintBox1.Repaint;
      end;
    end;

end;

procedure TfmPassivRadar.FormCreate(Sender: TObject);
var
  X1,Y1:Float;
begin
//  Cript;
  NamberEnter:=0;
  DiapButtons[1] := Diap1;
  DiapButtons[2] := Diap2;
  DiapButtons[3] := Diap3;
  DiapButtons[4] := Diap4;
  DiapButtons[5] := Diap5;
  SpeedButtons[1] := Speed1;
  SpeedButtons[2] := Speed2;
  SpeedButtons[3] := Speed3;
  SpeedButtons[4] := Speed4;
  SpeedButtons[5] := Speed5;
  SpeedButtons[6] := Speed6;
  with DetTargetGrid do
  begin
    ColWidths[3] := 40;
    ColWidths[4] := 40;
    Cells[0, 0] := 'Tar';                    Cells[1, 0] := '  E';
    Cells[2, 0] := '  N';                    Cells[{3}6, 0] := '  P';
    Cells[{5}7, 0] := '  D';                 Cells[4, 0] := 'dP/dt';
    Cells[{6}5, 0] := '  t';                Cells[{7}3, 0] := 'Band';
//   Cells[8, 0] := 'K';                    Cells[9, 0] := 'V';
    Cells[0, RowCount - 1] := '   Т=';     Cells[4, RowCount - 1] := '   K=';
    Cells[6, RowCount - 1] := '   S=';     Cells[8, RowCount - 1] := 'Bis=';
    Col := 9;
    Row := RowCount - 1;
  end;

  with ScreenImage do begin
    Left := 0;
    Top := 0;
    Width  := Round(3.6 * Screen.ClientWidth);
    Height := Round(2 * Screen.ClientHeight);
    Xc := Round(Width / 2);
    kX := Width / 360;
    kY := Height / (Dmax-Dmin);
  end;

  with ScreenImage1 do begin
    Left := 0;
    Top := 0;
    Width  := ScreenImage.Width;
    Height := ScreenImage.Height;
  end;

  with HorScrollBar do begin
    Left := Screen.Left + 1;
    Width := Screen.Width - 1;
    Max := ScreenImage.Width - Screen.ClientWidth;
    Position := Round(Max / 2);
    LargeChange := Round(Max / ((360 - 100)/10));
    SmallChange := Round(Max / (360 - 100));
  end;

  with HorScale do begin
    Left := Left + Screen.ClientOrigin.X - ClientOrigin.X;
    Width := Screen.ClientWidth;
  end;

  with VerScrollBar do begin
    Top := Screen.Top + 1;
    Height := Screen.Height - 1;
    Max := ScreenImage.Height - Screen.ClientHeight;
    Position := Round(Max /1.3);
    LargeChange := Round(2*Step*Max / (Dmax - Dmin));
    SmallChange := Round(Max / (Dmax - Dmin));
  end;
  with VerScale do
    with Canvas do
    begin
      Top := Top + Screen.ClientOrigin.Y - ClientOrigin.Y - TextHeight('0') div 2 - 1;
      Height := Screen.ClientHeight + TextHeight('0');
    end;
  DiapClick(self);
  SectorClick(self);
  SpeedClick(self);
  PanoramaClick(self);
  EnterClick(self);
  Timer.Enabled:= false;
  ShowRealClick(self);
//  Show;
end;
procedure TfmPassivRadar.DetTargetGridDrawCell(Sender: TObject; Col, Row:
                                 Integer; Rect: TRect; State: TGridDrawState);
var
  T: String;
  Target  : TTarget;
  CenterX : Integer;
  Centered: Boolean;
begin
  T := '';
  CenterX := Rect.Left + (Rect.Right - Rect.Left) div 2;
  Centered := false;
  with DetTargetGrid.Canvas do begin
    if Row > 0 then
      if Row = 9 then begin
        case Col of
          1: T := FloatToStrF(tt, ffFixed, 3, 1);
          5: T := FloatToStrF(Carrier2.Kurs, ffGeneral, 3, 0);
          7: T := FloatToStrF(Carrier2.Speed, ffGeneral, 2, 0);
          9: T := IntToStr(Trunc(FloatToGrad(PB) + 0.5));
                                                     end;
                        end
      else if DetTarget.Count >= Row then
                                       begin
        Target := TTarget(DetTarget.Items[Row - 1]);
        if Target <> nil then with Target do
          if (not Skip[1] or (Col in [0, 6])) then
{?//след стр может надо искл}
      if (Target.p_sh1[1]>0) or (Target.p_sh25[1]>0) or (Target.ppsh1[1]>0) or (Target.psh25[1] >0) then

    with DetTargetGrid.Canvas do
        case Col of
            0: begin
                 T := IntToStr(Row);
                 Brush.Color := TargetColors[Color];
                 FillRect(Rect);
                 Font.Color := clWhite;
                 Font.Style := [fsBold];
               end;
{}
            1: if Tuern.Down  or fmManager.CU2.Down or fmManager.CU3.Down or
                  fmManager.Probability.Down then T :=IntToStr(Target.p_sh1[1])
                                             else T := IntToStr(Target.ppsh1[1]);
            2: if Tuern.Down  or fmManager.CU2.Down or fmManager.Probability.Down then
               T :=IntToStr(Target.p_sh25[1])else T:=IntToStr(Target.psh25[1]);
            6: if Tuern.Down  or fmManager.CU2.Down or fmManager.Probability.Down then
    begin
    if fmSgPeleng.NonLineApprox.Checked = True
    then T :=FloatToStrF(grad*Target.ModelP[1], ffFixed, 4, 1)  else
         T:=FloatToStrF(FloatToGrad(S_1[1]),ffFixed,4,1);
    end
    else T:=FloatToStrF(FloatToGrad(S1[1]),ffFixed,4,1);
   7: if Tuern.Down or fmManager.CU2.Down or fmManager.CU3.Down{Probability.Down} then
          if fmSgPeleng.NonLineApprox.Checked = True then
          T := FloatToStrF(Target.ModelD[1], ffFixed, 4, 0) else
                 begin
                   if fmManager.CU1.Down and (Target.psh25[1]>1) then
                            T:=FloatToStrF(D_[1],ffFixed,4,0);
                   if fmManager.CU2.Down and (Target.psh25[1]>1) and (Target.p_sh25[1]>1) then
                             T:=FloatToStrF(D_[1],ffFixed,4,0);
                    if fmManager.CU3.Down and (Target.psh25[1]>1) and (Target.p_sh25[1]>1) and (Target.p__sh25[1]>1) then
                             T:=FloatToStrF(D_[1],ffFixed,4,0);
                 end;

//          T:=FloatToStrF(D_[1],ffFixed,4,0);


   4: if Tuern.Down  or fmManager.CU2.Down or fmManager.Probability.Down then
                             T := FloatToStrF(P_PWIP2[1], ffFixed, 4, 1) else
         T:=FloatToStrF(PPWIP2[1],ffFixed,4,1);
   5: if Tuern.Down  or fmManager.CU2.Down or fmManager.Probability.Down then
                           T := FloatToStrF((tt - p_ttprov[1]), ffFixed, 3, 1)
     else T := FloatToStrF((tt - pttprov[1]), ffFixed, 3, 1);
   3: begin
                 T := fmTargetEdit.DiapBox.Items[Diap - 1];
                 Centered := true;

               end;
 // 8: if Tuern.Down  or fmManager.CU2.Down or fmManager.Probability.Down then
   //                    T := FloatToStrF(grad*Target.ModelK[1], ffFixed, 4, 0);
//  9: if Tuern.Down  or fmManager.CU2.Down or fmManager.Probability.Down then
  //                         T := FloatToStrF(Target.ModelV[1], ffFixed, 2, 1);


          end;

      end;
      if T <> '' then
        if Centered
        then TextOut(CenterX - TextWidth(T) div 2, Rect.Top + 2, T)
        else TextOut(Rect.Left + 2, Rect.Top + 2, T);
  end;
end;

procedure TfmPassivRadar.TargetMenuClick(Sender: TObject);
begin
  fmTargetEdit.Show;
end;

procedure TfmPassivRadar.StatMenuClick(Sender: TObject);
begin
//  fmStatistic.show;
end;

procedure TfmPassivRadar.HorScalePaint(Sender: TObject);
var
  P: Float;
  TextH, n, X: integer;
  S: String;
begin
  with Screen do
    with HorScale.Canvas do begin
      Pen.Color := clBlack;

      for n := 0 to 20 do begin
        X := Round(n * (ClientWidth) / 20);
        MoveTo(X, 0);
        LineTo(X, 5);
      end;
      TextH := TextHeight('0');
      X := Round(ClientWidth / 2);
      MoveTo(X, 15); LineTo(X, 0);
      with HorScrollBar do
      P := 260*(Position/Max - 0.5);
      S := IntToStr(Round(FloatToGrad(P)));
    TextOut(Round((ClientWidth - TextWidth(S))/2), HorScale.Height - TextH, S);
      X := Round(ClientWidth / 2 - ClientWidth * 5.625 / 50);
      MoveTo(X, HorScale.Height - TextH); LineTo(X, 0);
      X := Round(ClientWidth / 2 + ClientWidth * 5.625 / 50);
      MoveTo(X, HorScale.Height - TextH); LineTo(X, 0);

      for n := 1 to 2 do begin
        X := Round(ClientWidth / 2 - n * ClientWidth * 11.25 / 50);
        MoveTo(X, HorScale.Height); LineTo(X, 0);
        S := FloatToStrF(FloatToGrad(P-22.5*n), ffFixed, 4, 1);
        TextOut(Round(X - TextWidth(S)/2), HorScale.Height - TextH , S);
        X := Round(ClientWidth / 2 + n * ClientWidth * 11.25 / 50);
        MoveTo(X, HorScale.Height); LineTo(X, 0);
        S := FloatToStrF(FloatToGrad(P+22.5*n), ffFixed, 4, 1);
        TextOut(Round(X - TextWidth(S)/2), HorScale.Height - TextH, S);
      end;
    end;
end;

procedure TfmPassivRadar.VerScalePaint(Sender: TObject);
var
  d1, d2: Float;
  n, Y: integer;
  S: String;
begin
  with ScreenImage do begin
    d1 := (Height - (Screen.ClientHeight - Top)) / kY;
    d2 := (Height + Top) / kY;
  end;

  with VerScale do
    with Canvas do begin
      for n := Trunc(d1 / Step) to Trunc(d2 / Step) + 1 do begin
     Y := Round(Screen.ClientHeight - (n * Step - d1) * kY) + Screen.Top - Top;
        MoveTo(0, Y); LineTo(Width, Y);
        S := IntToStr(Dmin + Round(n * Step));
        TextOut(Width - TextWidth(S) , Y - Round(TextHeight(S) / 2), S);
      end;
  end;
end;

procedure TfmPassivRadar.HorScrollBarChange(Sender: TObject);
begin
  ScreenImage.Left  := -HorScrollBar.Position;
  ScreenImage1.Left := -HorScrollBar.Position;
  HorScale.Repaint;
end;

procedure TfmPassivRadar.VerScrollBarChange(Sender: TObject);
begin
  ScreenImage.Top := -VerScrollBar.Position;
  ScreenImage1.Top := -VerScrollBar.Position;
  VerScale.Repaint;
end;

procedure TfmPassivRadar.ShowRealClick(Sender: TObject);
begin
  DrawDN(PTEK);
  if ShowReal.Checked then begin
    ScreenImage1.Hide;
    ScreenImage.Show;
  end
  else begin
    ScreenImage.Hide;
    ScreenImage1.Show;
  end;
  DrawDN(PTEK);
end;

procedure TfmPassivRadar.HorScrollBarScroll(Sender: TObject;
                              ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  if ScrollCode = scEndScroll then TimeToScroll := Time + 5/86400
                              else Scrolling := false;
end;

procedure TfmPassivRadar.DetTargetGridSelectCell(Sender: TObject; Col,
                                         Row: Integer; var CanSelect: Boolean);
begin
  CanSelect := (DetTargetGrid.Row <> DetTargetGrid.RowCount - 1);
  if Row <> DetTargetGrid.RowCount - 1 then Exit;
  CanSelect := Col in [5, 7, 9];
end;

procedure TfmPassivRadar.DetTargetGridGetEditText(Sender: TObject; ACol,
                                             ARow: Integer; var Value: String);
begin
  case ACol of
    5: Value := FloatToStrF(Carrier2.Kurs, ffGeneral, 3, 0);
    7: Value := FloatToStrF(Carrier2.Speed, ffGeneral, 3, 0);
    9: Value := FloatToStrF(FloatToGrad(PB), ffFixed, 4, 1);
  end;
end;

procedure TfmPassivRadar.DetTargetGridSetEditText(Sender: TObject; ACol,
                                          ARow: Integer; const Value: String);
var
  PB_: Float;
begin
  if not DetTargetGrid.EditorMode then begin
    case ACol of
     5: try
          Carrier2.Kurs := StrToFloat(Value);
          fmMap.P2KursEdit.Text := Value;
        except
        end;
     7: try
          Carrier2.Speed := StrToFloat(Value);
          fmMap.P2SpeedEdit.Text := Value;
        except
        end;
     9: begin
          try
            PB_ := StrToFloat(Value);
            if PB_ > 180 then PB_ := PB_ - 360;
            DrawDN(Ptek);
            PB := PB_;
            PBButtonClick(DetTargetGrid);
          except
          end;
        end;
    end;
  end;
end;

procedure TfmPassivRadar.DetTargetGridKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, DecimalSeparator]) then Key := #0;
end;

procedure TfmPassivRadar.MapMenuClick(Sender: TObject);
begin
  with fmMap do begin
    P1KursEdit.Text := FloatToStrF(Carrier1.Kurs, ffFixed, 4, 1);
    P1SpeedEdit.Text := FloatToStrF(Carrier1.Speed, ffFixed, 4, 1);
    P2KursEdit.Text := FloatToStrF(Carrier2.Kurs, ffFixed, 4, 1);
    P2SpeedEdit.Text := FloatToStrF(Carrier2.Speed, ffFixed, 4, 1);
    Show;
  end;

end;

procedure TfmPassivRadar.NillButtonClickClick(Sender: TObject);
  var {nc,}Tar:integer;
begin
  if Assigned(TargetList) and (TargetList.Count > 0) then
    for Tar := 0 to TargetList.Count - 1 do begin
      Target := TTarget(TargetList.Items[Tar]);
      with Target do begin
       { X := Xo; Y := Yo; }       {ввод нач координат заданн в редак при tt=0}
      nilling;
                      end;
                                       end;

end;



procedure TfmPassivRadar.TuernClick(Sender: TObject);
var {nc,ADiap,}Tar:integer;
begin
   if TimeTurn = 0 then TimeTurn:=tt;

  if Assigned(TargetList) and (TargetList.Count > 0) then
    for Tar := 0 to TargetList.Count - 1 do begin
      Target := TTarget(TargetList.Items[Tar]);
      with Target do begin
       { X := Xo; Y := Yo; }       {ввод нач координат заданн в редак при tt=0}

                      end;
                                       end;

end;
procedure TfmPassivRadar.fggf1Click(Sender: TObject);
begin
fmSelect.Show;
end;

procedure TfmPassivRadar.SgPeleng1Click(Sender: TObject);
begin
fmSgPeleng.Show;
end;


procedure TfmPassivRadar.ImputMassiv1Click(Sender: TObject);
begin
  fmImputMassiv.Show;
end;

procedure TfmPassivRadar.Matrix1Click(Sender: TObject);
begin
  fmSigMatrix.Show;
end;

procedure TfmPassivRadar.OutDateClick(Sender: TObject);
var
 i,n:integer;
begin
   Carrier2.Xout:=Carrier2.X;
   Carrier2.Yout:=Carrier2.Y;
    fmPassivRadar.Po_:=1000; fmPassivRadar.Po:=1000; fmPassivRadar.Po__:=1000;
   with Target do
     for i :=0 to TargetList.Count-1 do
       begin
        Target := TTarget(TargetList.Items[i]);
        for n:=1 to fmPassivRadar.EdCopy.Value do
                        {координаты выдав в оружие}
           begin
             Target.X_out[n]:=Target.X_[n];
             Target.Y_out[n]:=Target.Y_[n];
           end;
       end;
   DateOut.Checked:=True;
end;



procedure TfmPassivRadar.EdCopyChange(Sender: TObject);
var Cop,Targ,nc:Integer;
begin
  //  ----  Прооверка на збой --------
    Timer.Enabled       := False;
    PauseButton.Enabled := False;
  //  ----  Прооверка на збой --------
 (* if EdCopy.Value = 1 then   {необх при вкл реж сел в процессе раб без нажат Enter}
    SetLength(pImputMassiv,fmPassivRadar.EdCopy.Value+1,50001);
  if Assigned(TargetList) and(TArgetList.Count > 0) then
         for Targ :=0 to TargetList.Count-1  do
  begin
     Target:=TTarget(TargetList.Items[Targ]);
    Cop:=fmPassivRadar.EdCopy.Value+1;     {1 добавл, поскольку нумер динам масс нач с 0}
     SetLength(Target.VM1,Cop); SetLength(Target.VM2,Cop);
     SetLength(Target.SigLow1 ,Cop); SetLength(Target.SigLow2,Cop);
     SetLength(Target.X_ ,Cop);  SetLength(Target.Y_ ,Cop);
     SetLength(Target.X_out ,Cop);  SetLength(Target.Y_out ,Cop);
     SetLength(Target.D_ ,Cop);
     SetLength(Target.PPI ,Cop); SetLength(Target.PPI_ ,Cop);
     SetLength(Target.ModelV ,Cop); SetLength(Target.ModelT ,Cop); SetLength(Target.ModelD ,Cop);
     SetLength(Target.ModelP ,Cop);
     SetLength(Target.ModelK ,Cop); SetLength(Target.p_A ,Cop); SetLength(Target.p_b ,Cop);
     SetLength(Target.pa21 ,Cop);  SetLength(Target.pa22 ,Cop);  SetLength(Target.pa211 ,Cop);
     SetLength(Target.pa212 ,Cop);  SetLength(Target.pa222 ,Cop);
     SetLength(Target.pb21 ,Cop); SetLength(Target.pb22 ,Cop); SetLength(Target.pb23 ,Cop);
     SetLength(Target.pttprov ,Cop);  SetLength(Target.S1 ,Cop); SetLength(Target.PP002 ,Cop);
     SetLength(Target.PPWIP2 ,Cop); SetLength(Target.PAAA ,Cop); SetLength(Target.PBBB ,Cop);
     SetLength(Target.PCCC ,Cop);
     SetLength(Target.p_a21 ,Cop);  SetLength(Target.p_a22 ,Cop);  SetLength(Target.p_a211 ,Cop);
     SetLength(Target.p_a212 ,Cop);  SetLength(Target.p_a222 ,Cop);
     SetLength(Target.p_b21 ,Cop); SetLength(Target.p_b22 ,Cop); SetLength(Target.p_b23 ,Cop);
     SetLength(Target.p_ttprov ,Cop);
     SetLength(Target.S_1 ,Cop); SetLength(Target.P_P002 ,Cop); SetLength(Target.P_PWIP2 ,Cop);
     SetLength(Target.P_AAA ,Cop); SetLength(Target.P_BBB ,Cop);
     SetLength(Target.P_CCC ,Cop);
     SetLength(Target.pdd0,Cop); SetLength(Target.p_dd0,Cop);
     SetLength(Target.pl,Cop);  SetLength(Target.ppsh1,Cop);  SetLength(Target.psh25,Cop);
     SetLength(Target.pl_,Cop);  SetLength(Target.p_sh1,Cop);  SetLength(Target.p_sh25,Cop);
     SetLength(fmPassivRadar.Ot0,Cop); SetLength(fmPassivRadar.Ot0_,Cop);
     SetLength(fmPassivRadar.Ot,300,Cop); SetLength(fmPassivRadar.Ot_,300,Cop);
     SetLength(Target.Skip,Cop);

   end;*)
end;




procedure TfmPassivRadar.ChangeDia;
var sh:integer;
begin
         if Switch.Down and Revers then
    begin                                      { автоматич переключ диапазонов}
          DiapClick(nil);                      {без адаптации}
        if not(Adupt.Down) then
        begin
//          SetDiap(Dia - 1);
  //        DiapButtons[Dia].Down := true;

   if NumberDiaSwitch[dia]=True then
            begin
              Dia:=Dia-1;
              if Dia < 1 then Dia:=5;
            end;
            if NumberDiaSwitch[dia]=False then
              while NumberDiaSwitch[dia]=False do
            begin
              Dia:=Dia-1;
              if Dia < 1 then Dia:=5;
            end;
            SetDiap(Dia);
            DiapButtons[Dia].Down := true;

        end
                else
        begin                                  {с адаптацией}
            if NumberDia[dia]=True then
            begin
              Dia:=Dia-1;
              if Dia < 1 then Dia:=5;
            end;
            if NumberDia[dia]=False then
              while NumberDia[dia]=False do
            begin
              Dia:=Dia-1;
              if Dia < 1 then Dia:=5;
            end;
            SetDiap(Dia);
            DiapButtons[Dia].Down := true;
        end;
                                               {с адаптацией 1 вар}
//          if NumberRevers=1 then begin SpeedButtons[1].Down:=true; SetDiap(1);DiapButtons[1].Down := true; end;
  //        if (NumberRevers > 1) and (NumberRevers<=3) then
    //              begin SpeedButtons[2].Down:=true; SetDiap(2);DiapButtons[2].Down := true; end;
      //    if (NumberRevers > 3) and (NumberRevers<=7) then
        //          begin SpeedButtons[3].Down:=true; SetDiap(3);DiapButtons[3].Down := true;  end;
          //if (NumberRevers > 7) and (NumberRevers<=15) then
            //      begin SpeedButtons[4].Down:=true; SetDiap(4);DiapButtons[4].Down := true;  end;

                                               {с адап 2 вар}
          if fmSwitch.MGPTimeDiap.Checked=True  then
        begin
          if NumberRevers=1 then begin  SetDiap(5);
                                               DiapButtons[5].Down := true; end;
          if NumberRevers=2 then begin  SetDiap(4);
                                               DiapButtons[4].Down := true; end;
          if NumberRevers=3 then begin  SetDiap(3);
                                               DiapButtons[3].Down := true; end;
          if NumberRevers=4 then begin  SetDiap(2);
                                               DiapButtons[2].Down := true; end;
          if NumberRevers=5 then begin  SetDiap(1);
                                               DiapButtons[1].Down := true; end;
          if NumberRevers=6 then begin  SetDiap(5);
                                               DiapButtons[5].Down := true; end;
          if NumberRevers=7 then begin  SetDiap(4);
                                               DiapButtons[4].Down := true; end;
          if NumberRevers=8 then begin  SetDiap(3);
                                               DiapButtons[3].Down := true; end;
          if NumberRevers=9 then begin  SetDiap(2);
                                               DiapButtons[2].Down := true; end;
          if NumberRevers=10  then begin  SetDiap(5);
                                               DiapButtons[5].Down := true; end;
          if NumberRevers=11  then begin  SetDiap(4);
                                               DiapButtons[4].Down := true; end;
 //         if NumberRevers=12  then begin  SetDiap(1);
   //                                            DiapButtons[1].Down := true; end;
   //       if NumberRevers=13 then begin  SetDiap(5);
     //                                          DiapButtons[5].Down := true; end;
       //   if NumberRevers=14 then begin  SetDiap(4);
         //                                      DiapButtons[4].Down := true; end;
   //       if NumberRevers=15 then begin  SetDiap(3);
     //                                          DiapButtons[3].Down := true; end;
       //   if (NumberRevers=16) or (NumberRevers=18)or(NumberRevers=20)or(NumberRevers=22)
         //                                                                then
   //       begin
     //       SetDiap(5);DiapButtons[5].Down := true;
       //   end;
   //       if (NumberRevers=17) or (NumberRevers=19)or(NumberRevers=21)or(NumberRevers=23)
           //                                                              then
     //     begin
       //     SetDiap(4);DiapButtons[4].Down := true;
         // end;
        end;
    end;
end;

procedure TfmPassivRadar.ChangeSpeedScan;
begin
  if not Adupt.Down then                              {если адаптация не вкл}
  begin
    if Switch.Down then                              {если перекл диап включено}
    begin
      if fmSwitch.FastScan.Checked=True then SpeedButtons[5].Down:=true;
      if (fmSwitch.MGP.Checked=True) or (fmSwitch.MGPTimeDiap.Checked=True) then
      begin
          if Dia=1 then SpeedButtons[1].Down:=true;
          if Dia=2 then SpeedButtons[2].Down:=true;
          if Dia=3 then SpeedButtons[2].Down:=true;
          if Dia=4 then SpeedButtons[2].Down:=true;
          if Dia=5 then SpeedButtons[4].Down:=true;
      end;
    end;
  end else                                          {если адаптация включена}
  begin
    if InDiagr then
    begin
          if Dia=1 then SpeedButtons[1].Down:=true;
          if Dia=2 then SpeedButtons[2].Down:=true;
          if Dia=3 then SpeedButtons[2].Down:=true;
          if Dia=4 then SpeedButtons[2].Down:=true;
          if Dia=5 then SpeedButtons[4].Down:=true;
    end else
          SpeedButtons[5].Down:=True;
  end;
  SpeedClick(self);
end;

procedure TfmPassivRadar.DetectDiaTarget;
var Target1,Target2:TTarget;
i,sh :integer;
Diapason:PoDia;
begin
      for i:=1 to 5 do NumberDia[i]:=False;
      for i:=0 to DetTarget.Count-1 do
      begin
      Target1 := TTarget(DetTarget.Items[i]);
      NumberDia[Target1.Diap]:=True;
      end;


    if fmSwitch.SwitchDia1.Checked=false then   NumberDia[1]:=False;
    if fmSwitch.SwitchDia2.Checked=false then   NumberDia[2]:=False;
    if fmSwitch.SwitchDia3.Checked=false then   NumberDia[3]:=False;
    if fmSwitch.SwitchDia4.Checked=false then   NumberDia[4]:=False;
    if fmSwitch.SwitchDia5.Checked=false then   NumberDia[5]:=False;

     sh:=0;
      for i:=1 to 5 do
        if NumberDia[i]=True then sh:=sh+1;
        NumberDiaTarget:=sh;
(*    if  ListDia.Count=0 then
    if DetTarget.Count>0 then
    begin
      Target1 := TTarget(DetTarget.Items[0]);
      New(Diapason);
      Diapason^.N:=Target1.Diap;
      if ListDia.Count=0 then
                   ListDia.Add(Diapason);
    end;
    if DetTarget.Count>1 then
      for i:=1 to DetTarget.Count-1 do
      begin
        for k:=1 to i-1 do
        begin
        Target1 := TTarget(DetTarget.Items[i]);
        Target2 := TTarget(DetTarget.Items[k]);
          if Target1.Diap=Target2.Diap then break;
          if k=i-1 then
            begin
              New(Diapason);
              Diapason^.N:=Target1.Diap;
              ListDia.Add(Diapason);
            end;
        end;
      end;           *)

end;

procedure TfmPassivRadar.AduptClick(Sender: TObject);
begin
    if Adupt.Down then ListDia:=TList.Create;
    if not(Adupt.Down) then
    begin
    ListDia.Clear; ListDia.Free;
    end;
    ScaleEdit.Value:=2;
end;

procedure TfmPassivRadar.Extrapol(Target: TTarget;var Targ,nc:integer);
var AA{,BB}:boolean;
Vx,Vy:Extended;
P1,P2,P3,ttt,XTtt,YTtt,kil,C1,C2,C3,D,D1,D2,D3,P1toP2,BAZ:Float;
begin
             if (Target.psh25[nc]>0) and (Target.p_sh25[nc]>0) and  (Target.p__sh25[nc]>0) then
                                         Target.SumProb123:=Target.SumProb123+1;
             if (Target.psh25[nc]>0) and (Target.p_sh25[nc]>0)  then
                                         Target.SumProb12:=Target.SumProb12+1;
                                                                    {2 носитель}
             if Target.p_sh25[nc]>0 then
                                Target.SumProb:=Target.SumProb+1;
             D := Hypot(Target.X-{PassivRadar}Carrier2.X, Target.Y-Carrier2.Y);
                                                                      {1 носитель}
             if (Target.p_sh25[nc]>0){ and ((tt-pttprov[nc])<200)}{ttgar} then
                                        AA:=true   else AA:=false;
                                                                  {2 носитель}
             if (Target.p_sh25[nc]>0){ and ((tt-p_ttprov[nc])<200)}{ttgar} then
             begin
      //         BB:=true;

                Target.SumProb_1:=Target.SumProb_1+1;
                                               {если аппроксим пеленга линейна}
               if fmSgPeleng.LineApprox.Checked = True then
               begin
                                               {первые   не сглаженныч пеленга}
                 if Target.p_sh25[nc]<fmSgPeleng.OnePeleng.Value then Target.SumPel:=
                   Target.SumPel+(Target.S_1[nc]-Target.S_2)*(Target.S_1[nc]-Target.S_2);
                                                    {экстраполированные пеленги}
                 if not(DateOut.Checked) then
                 if Target.p_sh25[nc]>=fmSgPeleng.OnePeleng.Value then Target.SumPel:=Target.SumPel +
                ((Target.P_P002[nc]+tt*Target.P_PWIP2[nc])-Target.S_2)*((Target.P_P002[nc]+tt*Target.P_PWIP2[nc])-Target.S_2);
                 if DateOut.Checked then   {если данные выдан в оруж}
                      begin
       //                fmPassivRadar.Po_:=100;

               if fmManager.CU1.Down or fmManager.CU2.Down then
                              BAZ   := Hypot(Carrier2.X-Carrier1.X, Carrier2.Y-Carrier1.Y);
              Target.D_[nc] := BAZ*sin(ArcTan2(Carrier2.X-Carrier1.X,Carrier2.Y-
                 Carrier1.Y)-rad*( Target.PP002[nc]+tt*Target.PPWIP2[nc]))
                  /sin(rad*((Target.PP002[nc]+tt*Target.PPWIP2[nc]) -(Target.P_P002[nc]+tt*Target.P_PWIP2[nc]) ));
                 SinCos(rad*(Target.P_P002[nc]+tt*Target.P_PWIP2[nc]){Target.S_1[nc]}, Vx, Vy);
                 Target.X_[nc] :=Carrier2.X + Vx*Target.D_[nc];Target.Y_[nc] :=Carrier2.Y + Vy*Target.D_[nc];
{}
                                             { истинная пеленг  от точки стрельбы до упр точки }
                       P1:= { P1toP2:=}grad*ArcTan2(Target.X-Carrier2.Xout,Target.Y-Carrier2.Yout);
                                             { измер пеленг  от точки стрельбы до цели на момент стрельбы }
                       P2:= { P1toP2:=}grad*ArcTan2(Target.X_out[nc]-Carrier2.Xout,Target.Y_out[nc]-Carrier2.Yout);

                                          { измеренный пеленг от точки стрельбы до упр точки}
                       P3:= { P1toP2:=}grad*ArcTan2(Target.X_[nc]-Carrier2.Xout,Target.Y_[nc]-Carrier2.Yout);
                       Target.SumPel:=Target.SumPel + (P2-P1)*(P2-P1);
                       Target.SumPel1:=Target.SumPel1 + (P3-P1)*(P3-P1);
                      end;
                if Target.p_sh25[nc]>=fmSgPeleng.OnePeleng.Value then Target.SumV:=Target.SumV +
                ((Target.P_AAA[nc]*tt*tt+Target.P_BBB[nc]*tt+Target.P_CCC[nc])-Target.S_2)*
                                ((Target.P_AAA[nc]*tt*tt+Target.P_BBB[nc]*tt+Target.P_CCC[nc])-Target.S_2);
               end;
                                                {если аппрок пеленга нелинейна}
               if fmSgPeleng.NonLineApprox.Checked = True then
               begin
                 if (Target.p_sh25[nc]>1) and (Target.p_sh1[nc]>0) then
                 begin
                   ttt:= (tt-fmPassivRadar.Ot_[Targ,Target.p_sh25[nc]-1,nc-1].t);
                   XTtt:=fmPassivRadar.Ot_[Targ,Target.p_sh25[nc]-1,nc-1].Xp+Target.ModelD[nc]*
                   Sin(Target.ModelP[nc])+Target.ModelV[nc]*
                                                     Cos(Target.ModelK[nc])*ttt;
                   YTtt:=fmPassivRadar.Ot_[Targ,Target.p_sh25[nc]-1,nc-1].Yp+Target.ModelD[nc]*
                   Cos(Target.ModelP[nc])+Target.ModelV[nc]*
                                                     Sin(Target.ModelK[nc])*ttt;
                   kil:={PPI_[nc];}grad*pel(fmPassivRadar.Ot_[Targ,Target.p_sh25[nc]-1,nc-1].Xp+
            Carrier2.Speed*Sin(Carrier2.Kurs)*ttt,fmPassivRadar.Ot_[Targ,Target.p_sh25[nc]-1,nc-1].Yp+
                               Carrier2.Speed*Cos(Carrier2.Kurs)*ttt,XTtt,YTtt);
                                             {обеспечив непрер перехода через 0}
                   if abs(kil-Target.S_2)>180 then
                   if kil < Target.S_2 then kil:=kil+360 else
                                                      Target.S_2:=Target.S_2+360;
                   Target.SumPel:=Target.SumPel+(kil-Target.S_2)*(kil-Target.S_2);
                 end;
                 if Target.p_sh25[nc]>=1 then Target.SumV:=Target.SumV +
             ( Target.Speed-Target.ModelV[nc])*(Target.Speed-Target.ModelV[nc]);
               end;
                                                             {фиктивные пеленги}
               { if psh25[nc]>=4 then SumPel:=SumPel +
               ((PP002[nc]+tt*PPWIP2[nc])-S2)*((PP002[nc]+tt*PPWIP2[nc])-S2); }
               { ((PAAA[nc]*tt*tt+PBBB[nc]*tt+PCCC[nc])-S2)*
               ((PAAA[nc]*tt*tt+PBBB[nc]*tt+PCCC[nc])-S2);}
           end;//  else
  //                                   BB:=false;
   //       if (AA=true)and (BB=true) then
          begin
           { if (psh25[nc]>=4) and (p_sh25[nc]>=4) then begin}
                    Target.SumProb2:=Target.SumProb2+1;
                                                  {если аппрокс пеленга линейна}

            if  fmSgPeleng.LineApprox.Checked = True then
                                             {если данные не выданы в оружие}
          begin
          if not(DateOut.Checked) then
            begin
             { C1:=sin(rad*(S1[nc]- S_1[nc]));
             if C1<>0 then D_[nc] := BAZ*sin(rad*(P1toP2-S1[nc])) /C1 ;   }
//             C2:=PP002[nc]+tt*PPWIP2[nc];
  //           C3:=P_P002[nc]+tt*P_PWIP2[nc];
    //         C1:=sin(rad*(C2-C3));
      //       if C1<>0  then C1 := BAZ*sin(rad*(P1toP2-C2))/C1;

             C1:= Hypot(Target.X_[nc]-Carrier2.X, Target.Y_[nc]-Carrier2.Y);
             D := Hypot(Target.X-Carrier2.X, Target.Y-Carrier2.Y);

             // ----
           //  C1 := sqrt( sqr(Target.X_[nc]- Carrier2.X) + sqr(Target.Y_[nc] - Carrier2.Y));
            // D  := sqrt( sqr(Target.X     - Carrier2.X) + sqr(Target.Y      - Carrier2.Y));

             if     (Target.psh25[nc]>0)
                and (Target.p_sh25[nc]>0)
                and (Target.p__sh25[nc]>0)
                and fmManager.CU3.Down then Target.SumDis:=Target.SumDis+(D-C1)*(D-C1);

            if     (Target.psh25[nc]>0)
               and (Target.p_sh25[nc]>0)
               and (fmManager.CU2.Down or fmManager.CU1.Down) then Target.SumDis:=Target.SumDis+(D-C1)*(D-C1);
            end;

            if DateOut.Checked then             // если данные выданы в оружие
            begin
{}
 //                Target.D_[nc] := BAZ*sin(ArcTan2(Carrier2.X-Carrier1.X,Carrier2.Y-
   //              Carrier1.Y)-rad*Target.S1[nc]) /sin(rad*(Target.S1[nc] - Target.S_1[nc]));
                 SinCos(rad*Target.S_1[nc], Vx, Vy);
                 Target.X_[nc] :=Carrier2.X + Vx*Target.D_[nc];Target.Y_[nc] :=Carrier2.Y + Vy*Target.D_[nc];
{}                                { истинная  далность от точки стрельбы до упр точки }
            D1:=Hypot(Target.X-Carrier2.Xout, Target.Y-Carrier2.Yout);
                                 { истинная пеленг  от точки стрельбы до упр точки }
//            P1:= { P1toP2:=}grad*ArcTan2(Target.X-Carrier2.Xout,Target.Y-Carrier2.Yout);

                                { измер далность от точки стрельбы до цели на момент стрельбы}
            D2:=Hypot(Target.X_out[nc]-Carrier2.Xout, Target.Y_out[nc]-Carrier2.Yout);
                                  { измер пеленг  от точки стрельбы до цели на момент стрельбы }
  //          P2:= { P1toP2:=}grad*ArcTan2(Target.X_out[nc]-Carrier2.Xout,Target.Y_out[nc]-Carrier2.Yout);
                                { измеренная дальность от точки стрельбы до упр точки}
            D3:=Hypot(Target.X_[nc]-Carrier2.Xout, Target.Y_[nc]-Carrier2.Yout);
                                 { измеренный пеленг от точки стрельбы до упр точки}
    //        P3:= { P1toP2:=}grad*ArcTan2(Target.X_[nc]-Carrier2.Xout,Target.Y_[nc]-Carrier2.Yout);

            Target.SumDis:=Target.SumDis+(D2-D1)*(D2-D1);
            Target.SumDis1:= Target.SumDis1+(D3-D1)*(D3-D1);
//            Target.SumPel:=Target.SumPel+(P2-P1)*(P2-P1);
//            Target.SumPel1:= Target.SumPel1+(P3-P1)*(P3-P1);
            end;
         end;                                       {еесли аппрокс пеленга нелинейна}
            if  fmSgPeleng.NonLineApprox.Checked = True then
            if  Target.p_sh25[nc]>0 then
            begin
          Target.SumDis:=Target.SumDis+(D-Target.ModelD[nc])*(D-Target.ModelD[nc]);
             Target.SumK:=Target.SumK+(Target.Kurs-grad*Target.ModelK[nc])*
                                            (Target.Kurs-grad*Target.modelK[nc]);
            end;

                                     {           параболическая аппроксимация }
           C2:=Target.PAAA[nc]*tt*tt+Target.PBBB[nc]*tt+Target.PCCC[nc];
           C3:=Target.P_AAA[nc]*tt*tt+Target.P_BBB[nc]*tt+Target.P_CCC[nc];
           C1:=sin(rad*(C2-C3));
           P1toP2:=grad*ArcTan2(Carrier2.X-Carrier1.X,Carrier2.Y-Carrier1.Y);
           BAZ := Hypot(Carrier2.X-Carrier1.X, Carrier2.Y-Carrier1.Y);


           if C1<>0 then C1 := BAZ*sin(rad*(P1toP2-C2))/C1;
           Target.SumK:=Target.SumK+(D-C1)*(D-C1);

//              if Target.p_sh25[nc]>4 then Target.SumPel:=
  //            Target.SumPel+(C2-Target.S2)*(C2-Target.S2);
          end;
          if nc=fmPassivRadar.EdCopy.Value then
          begin                      {расчет ошибок в заданные моменты времени}
            if Target.Speed<>0 then
            if Target.SumProb_1>0 then Target.V_:=
                              Sqrt(Target.SumV/Target.SumProb_1)*100/Target.Speed;
            Target.pr_:=
                              Target.SumProb/fmPassivRadar.EdCopy.Value;
            if not(DateOut.Checked) then
            if Target.SumProb_1>0 then
             Target.Pe_:=Sqrt(Target.SumPel/{fmPassivRadar.EdCopy.Value}Target.SumProb_1);




            if  (fmManager.CU1.Down) or
                (fmManager.CU2.Down) or
                (fmManager.CU3.Down) then
                    if Target.SumProb2 >0 then
                     Target.Di_
                               := Sqrt(Target.SumDis/fmPassivRadar.EdCopy.Value{Target.SumProb2})*100/D;   {в процентах}


           if  fmManager.CU2.Down then
            if Target.SumProb12 >0 then
                    Target.Di_
                               := Sqrt(Target.SumDis/Target.SumProb12)*100/D;

            if  fmManager.CU3.Down then
            if Target.SumProb123 >0 then
                    Target.Di_
                               := Sqrt(Target.SumDis/Target.SumProb123)*100/D;


            if DateOut.Checked then      {если данные  выданы в оружие}
              if Target.SumProb2 >0 then
              begin
                Target.Di_ := Sqrt(Target.SumDis/fmPassivRadar.EdCopy.Value{Target.SumProb2})*100/D1;
                Target.Di_1:= Sqrt(Target.SumDis1/fmPassivRadar.EdCopy.Value{Target.SumProb2})*100/D1;
                Target.Pe_ := Sqrt(Target.SumPel/fmPassivRadar.EdCopy.Value{Target.SumProb2});
                Target.Pe_1:= Sqrt(Target.SumPel1/fmPassivRadar.EdCopy.Value{Target.SumProb2});
              end;


//            if (Target.SumProb2 >0)and (Target.SumK>0) then Target.Di_1:=
  //                                 Sqrt(Target.SumK/fmPassivRadar.EdCopy.Value)*100/D;//Target.SumProb2);{в процентах}


            if Tuern.Down  or fmManager.CU2.Down or fmManager.CU3.Down or fmManager.Probability.Down then
            begin
              Target.tt_p:=tt;
              with fmStatisticUpr do
              begin
                if not(DateOut.Checked) then
                begin
                  if (Target.di_>0) and (Target.dizip_>0) then
                  if (Target.di_<DiMax) and (Target.di_>DiMin) then
                  DrawDi(Target.tt_p,Target.ttzip_p, Target.di_ ,Target.dizip_, TargetColors[Target.Number]);
                  if (Target.pe_>0) and (Target.pezip_>0) then
                  DrawPe(Target.tt_p,Target.ttzip_p, Target.pe_ ,Target.pezip_, TargetColors[Target.Number]);
                end else
                begin
                  if (Target.di_1>0) and (Target.dizip_1>0) then    {для искл начальн выброса}
                  if (Target.di_1<DiMax) and (Target.di_1>DiMin) then
                     DrawDi(Target.tt_p,Target.ttzip_p,{Target.di_-}Target.di_1,
                     {Target.dizip_-}Target.dizip_1, TargetColors[Target.Number]);
                  if (Target.pe_1>0) and (Target.pezip_1>0) then    {для искл начальн выброса}
                  if (Target.pe_1<PeMax) and (Target.pe_1>PeMin) then
                     DrawPe(Target.tt_p,Target.ttzip_p,{Target.pe_-}Target.pe_1,{Target.pezip_-}Target.pezip_1, TargetColors[Target.Number]);
                end
              end;
              with fmStatistic do
              begin                                         {рисуем сглаж пеленг}
                if  fmManager.Probability.Down then
                with fmStatisticProb do
                begin                                         {рисуем сглаж пеленг}
                  if (Target.pr_>0)and (Target.przip_>0)
                  then
                  if (Target.pr_<=PMax) and (Target.pr_>PMin) then begin
                      DrawProb(Target,Carrier2,Target.tt_p,Target.ttzip_p, Target.pr_ ,Target.przip_, TargetColors[Target.Number]);
                      // -- Vstavka Pashy ---
                      if Target.Number < 20 then begin
                          TableArrayProb[0               , CurrentTablePos] := Target.tt_p;
                          TableArrayProb[Target.Number + 1, CurrentTablePos] := Target.pr_;
                      end;
                  end;
                end;
                if (Target.di_>0) and (Target.dizip_>0) then
               if (Target.di_<DiMax) and (Target.di_>DiMin) then begin
                    DrawDi(Target.tt_p,Target.ttzip_p, Target.di_ ,Target.dizip_, TargetColors[Target.Number]);
                     // -- Vstavka Pashy ---
                      if Target.Number < 20 then begin
                         TableArrayDevDist[0               , CurrentTablePos] := Target.tt_p;
                         TableArrayDevDist[Target.Number + 1, CurrentTablePos] := Target.di_;
                      end;
                end;
                if (Target.pe_>0) and (Target.pezip_>0) then begin
                     DrawPe(Target.tt_p,Target.ttzip_p, Target.pe_ ,Target.pezip_, TargetColors[Target.Number]);
                     // -- Vstavka Pashy ---
                      if Target.Number < 20 then begin
                        TableArrayDevPel[0               , CurrentTablePos] := Target.tt_p;
                        TableArrayDevPel[Target.Number + 1, CurrentTablePos] := Target.pe_;
                     end;
                end;
                Target.ttzip_p:=Target.tt_p;
                Target.przip_:=Target.pr_;
                Target.Kzip_:= Target.K_;Target.Vzip_:=Target.V_;
                Target.pezip_:=Target.pe_;Target.pezip_1:=Target.pe_1;
                Target.dizip_:=Target.di_;
                Target.dizip_1:=Target.di_1;
              end;
            end;
          end;
end;

procedure TfmPassivRadar.ChangeKurs;
begin
 if Tuern.Down and fmManager.CU1.Down then  Carrier2.Kurs:=Carrier1.Kurs+180;
end;

procedure TfmPassivRadar.Move(dt: Extended);
var Vx,Vy:Extended;
begin
    ChangePel;
    ChangeKurs;
    //SinCos(Kurs*rad,Vx,Vy);
    SinCos(Kurs*pi_Del_180,Vx,Vy);
    X:=X + dT*Vx*Speed;
    Y:=Y + dt*Vy*Speed;
end;

procedure TfmPassivRadar.DetTargetGridDblClick(Sender: TObject);
begin
   OutDate.Visible:=True;
   DateOut.Visible:=True;
   fmStatisticUpr.Show;
end;

procedure TfmPassivRadar.FormShow(Sender: TObject);
begin
  Left := 360;
  Top  := 377;
end;

procedure TfmPassivRadar.Parameters1Click(Sender: TObject);
begin
  fmParameters.Show;
end;

//procedure TfmPassivRadar.DetectKursSpeed(Target: TTarget; var Targ,
  //                                      nc: integer);
//var P_,P,D_Back,Carrier2XBack,Carrier2YBack,Carrier1XBack,Carrier1YBack,BAZ,
  //  TimeBack,
  //  TargetXBack,TargetYBack:Float;
//begin
(*    TimeBack:=tt-2*(tt-TimeTurn)-1;
                                      {расчитыв прошлые пеленги}
    P_:=Target.P_P002[nc]+TimeBack*Target.P_PWIP2[nc];
    P :=Target.PP002[nc]+TimeBack*Target.PPWIP2[nc];
                                 {расчитываем прошлые положения носителей}
    Carrier1XBack:=Carrier1.X-Sin(rad*Carrier1.Kurs)*Carrier1.Speed*TimeBack;
    Carrier2XBack:=Carrier2.X-Sin(rad*Carrier2.Kurs)*Carrier2.Speed*TimeBack;
    Carrier1YBack:=Carrier1.Y-Cos(rad*Carrier1.Kurs)*Carrier1.Speed*TimeBack;
    Carrier2YBack:=Carrier2.Y-Cos(rad*Carrier2.Kurs)*Carrier2.Speed*TimeBack;
                                 {расчитываем прошлая дальность со 2го носителя}
                                  BAZ   := Hypot(Carrier2XBack-Carrier1XBack, Carrier2YBack-Carrier1YBack);
    D_Back:=
                 BAZ*sin(ArcTan2(Carrier2.X-Carrier1.X,Carrier2.Y-
                 Carrier1.Y)-rad*( Target.PP002[nc]+tt*Target.PPWIP2[nc]-TimeBack*Target.PPWIP2[nc]))
                  /sin(rad*((Target.PP002[nc]+tt*Target.PPWIP2[nc]-TimeBack*Target.PPWIP2[nc]) -(Target.P_P002[nc]+
                                                               tt*Target.P_PWIP2[nc]-TimeBack*Target.PPWIP2[nc]) ));
             //    SinCos(rad*(Target.P_P002[nc]+tt*Target.P_PWIP2[nc]){Target.S_1[nc]}, Vx, Vy);

         //        Target.X_[nc] :=Carrier2.X + Vx*Target.D_[nc];Target.Y_[nc] :=Carrier2.Y +
           //                                                                     Vy*Target.D_[nc];

                                         {расчитываем прошлые координаты целей}
    TargetXBack:=Carrier1XBack+D_Back*Cos(rad*P);
    TargetYBack:=Carrier1YBack+D_Back*Sin(rad*P);
                                         {расчитываем модельные курс и скорость}
   Target.ModelV[nc]:=Hypot(TargetXBack-Target.X_[nc],TargetYBack-Target.Y_[nc])/(tt-TimeBack);
   Target.ModelK[nc]:=Pel(TargetXBack,TargetYBack,Target.X_[nc],Target.Y_[nc]);                         *)
//end;



procedure TfmPassivRadar.ScreenImageDblClick(Sender: TObject);
begin
 if (fmPassivRadar.tt>15) and (fmPassivRadar.tt<15.5) then fmAbout.Show;
end;

procedure TfmPassivRadar.SelectClick(Sender: TObject);
begin
fmSelect.Show;
end;

procedure TfmPassivRadar.ImputMassivClick(Sender: TObject);
begin
fmImputMassiv.Show;
end;

procedure TfmPassivRadar.MatrixClick(Sender: TObject);
begin
fmSigMatrix.Show;
end;

end.

