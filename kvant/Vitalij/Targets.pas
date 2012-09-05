unit Targets;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Spin,Printers,MapUnit,MyLibrery, MpiDeclaration;

const
//  Copy=1;                                             {число копий каждой цели}
  ColorCount = 9;
  TargetColors: array [0..ColorCount - 1] of TColor = (
    clBlue,
    clFuchsia,
    clGreen,
    clLime,
    clMaroon,
    clOlive,
    clPurple,
    clRed,
    clTeal);
  DiapsName: array[1..5] of String[3] = ('I', 'G', 'E/F', 'D', 'D/C');

type
 Sig=record
            T,A,Tay,Pe,Pel:Float;        Nff:integer;
            Col:TColor;              Pr :Boolean;
              end;
   Float = Extended{Single};

  TTarget = class(TMoveObject)
    public

    typ: String[10];
    Number,
    Diap,PG,WR,rn,Depression,Color,Nf : Integer;
    F,BR,Fone,Tay,lamda,
//    tdubl,
                                                  {Расчитываемые параметры}
    S2,S_2,S__2: Float;                     {истинные пеленги с 1 и 2 носителей}

    TSignBeg1,
    SumPel,SumPel1,SumDis,SumDis1,SumV,SumK,SumProb_1,SumProb,SumProb_,SumProb2,
    SumProb123,  {сумматор числа одновр обнар на 1 2 и 3 носителях }
    SumProb12,   {сумматор числа одновр обнар на 1 и 2  носителях}
    tt_p,ttzip_p,Vzip_,Kzip_,Pezip_,Pezip_1,Przip_,Dizip_,Dizip_1,ttzip_,ttzip1_,Przip1_,
    V_,K_,Pe_,Pe_1,Pr_,Di_,
//    Di_x,
    Di_1,tt_:Float;   {ошибки и время}

 //   SumPel,SumDis,SumDis1,SumV,SumK,SumProb_1,SumProb,SumProb_,SumProb2,
    pdd0,p_dd0,p__dd0,
    pl, ppsh1, psh25,
    pl_, p_sh1, p_sh25,
    pl__,p__sh1,p__sh25 :array of Integer;
//    pTSignBeg1,p_TSignBeg1, {низкочастотная фаза перв обнар импульса}
    FPause,
    tdubl,
    VM1,VM2,VM3,
    SigLow1,SigLow2,SigLow3,
    TBegPause,
    X_, Y_,                 {измеренные координаты}
    X_out, Y_out,                 {координаты выдаваемые в оружие}
    D_,                     {Дальность от 2го носителя триангуляция 2 с 1 носителем}
    D_3,                    {Дальность от 2го носителя триангуляция 2 с 3 носителем}
    D_13,                   {Дальность от 2го носителя триангуляция 1 с 3 носителем}
    PPI,PPI_,PPI__,
    ModelV,ModelT,ModelD,ModelP,ModelK,{p_FU,p_FU1,}p_A,p_b,
    pa21, pa22, pa211, pa212, pa222,pb21,pb22,pb23, pttprov, S1,PP002,
    PPWIP2,PAAA,PBBB,PCCC,
    p_a21, p_a22, p_a211, p_a212, p_a222,p_b21,p_b22,p_b23, p_ttprov,
    S_1,P_P002,P_PWIP2,P_AAA,P_BBB,P_CCC,
    p__a21, p__a22, p__a211, p__a212, p__a222,p__b21,p__b22,p__b23, p__ttprov,
    S__1,P__P002,P__PWIP2,P__AAA,P__BBB,P__CCC:

    array of Float;
    Skip: array of Boolean;          {Счетчик пропусков цели}
    Man:  Boolean;          {признак маневра}
    constructor CreateTarget (ADiap, ARN: Integer);
    procedure Nilling;
    procedure ChangeT;
    procedure ChangeP(i:integer);
    procedure ChangeKurs; override;
    procedure ChangePel;override;
  end;

   TfmTargetEdit = class(TForm)
    TargetGrid: TDrawGrid;
    AddButton: TButton;
    DelButton: TButton;
    ColorBox: TComboBox;
    DiapBox: TComboBox;
    Group1Button: TButton;
    DefaultRN: TSpinEdit;
    Label1: TLabel;
    Group2Button: TButton;
    Group3Button: TButton;
    SeaModelCour: TButton;
    SeaModel1: TButton;
    SeaModelDis: TButton;
    SeaModel2: TButton;
    Refresh: TButton;
    Sharigin: TRadioButton;
    Vvedensky: TRadioButton;
    Label2: TLabel;
    EditPause: TSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure TargetGridDrawCell(Sender: TObject; Col, Row: Integer;
                                   Rect: TRect; State: TGridDrawState);
    procedure TargetGridGetEditText(Sender: TObject; ACol, ARow: Integer;
                                                    var Value: String);
    procedure TargetGridSelectCell(Sender: TObject; Col, Row: Integer;
                                                   var CanSelect: Boolean);
    procedure TargetGridSetEditText(Sender: TObject; ACol, ARow: Integer;
                                                  const Value: String);
    procedure AddButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure ColorBoxChange(Sender: TObject);
    procedure ColorBoxDrawItem(Control: TWinControl; Index: Integer;
                                      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rnBoxChange(Sender: TObject);
    procedure DiapBoxChange(Sender: TObject);
    procedure Group2ButtonClick(Sender: TObject);
    procedure Group1ButtonClick(Sender: TObject);
    procedure Group3ButtonClick(Sender: TObject);
    procedure SeaModelCourClick(Sender: TObject);
    procedure SeaModel1Click(Sender: TObject);
    procedure SeaModelDisClick(Sender: TObject);
    procedure SeaModel2Click(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditPauseChange(Sender: TObject);
    procedure DefaultRNChange(Sender: TObject);

  private
  public
    Dsm, {смещение отн центра}
    lm:integer;
  end;

var
  fmTargetEdit: TfmTargetEdit;
  TargetList, DetTarget  : TList;
  PauseRezhim            : Boolean;
implementation

uses Passiv, Math,  Select, Manager{, MapUnit};

{$R *.DFM}

const
   Num_   =  0;
   Typ_   =  1;
   Diap_  =  2;
   PG_    =  3;
   F_     =  4;
   WR_    =  5;
   BR_    =  6;
   Fone_  =  7;
   rn_    =  8;
   Peleng_=  9;
   Dist_  =  10;
  Kurs_   = 11;
 Speed_   = 12;
      H_  = 13;
   Color_ = 14;
var
  Columns: array [0..14] of String;

constructor TTarget.CreateTarget (ADiap, ARN: Integer);
var nc,Cop:integer;
begin
  inherited CreateMoveObject (-3,130,0.03,225,1,0);

     Cop:=fmPassivRadar.EdCopy.Value+1; {1 добавл, поскольку нумер динам масс нач с 0}
     Cop:=401;
     SetLength(FPause,Cop);
     SetLength(tdubl,Cop);
     SetLength(VM1,Cop); SetLength(VM2,Cop);   SetLength(VM3,Cop);
     SetLength(SigLow1 ,Cop); SetLength(SigLow2,Cop); SetLength(SigLow3,Cop);
     SetLength(X_ ,Cop);  SetLength(Y_ ,Cop);            {измеренные координаты}
     SetLength(X_out ,Cop);  SetLength(Y_out ,Cop); {координаты выдаваемые в оружие}
     SetLength(D_ ,Cop);                            {Дальность от 2го носителя}
     SetLength(D_3 ,Cop);
     SetLength(D_13 ,Cop);
     SetLength(PPI ,Cop); SetLength(PPI_ ,Cop);  SetLength(PPI__ ,Cop);
     SetLength(ModelV ,Cop); SetLength(ModelT ,Cop); SetLength(ModelD ,Cop); SetLength(ModelP ,Cop);
     SetLength(ModelK ,Cop); SetLength(p_A ,Cop); SetLength(p_b ,Cop);
     SetLength(pa21 ,Cop);  SetLength(pa22 ,Cop);  SetLength(pa211 ,Cop);  SetLength(pa212 ,Cop);  SetLength(pa222 ,Cop);
     SetLength(pb21 ,Cop); SetLength(pb22 ,Cop); SetLength(pb23 ,Cop);  SetLength(pttprov ,Cop);  SetLength(S1 ,Cop); SetLength(PP002 ,Cop);
     SetLength(PPWIP2 ,Cop); SetLength(PAAA ,Cop); SetLength(PBBB ,Cop); SetLength(PCCC ,Cop);
     SetLength(p_a21 ,Cop);  SetLength(p_a22 ,Cop);  SetLength(p_a211 ,Cop);  SetLength(p_a212 ,Cop);  SetLength(p_a222 ,Cop);
     SetLength(p_b21 ,Cop); SetLength(p_b22 ,Cop); SetLength(p_b23 ,Cop);  SetLength(p_ttprov ,Cop);
     SetLength(S_1 ,Cop); SetLength(P_P002 ,Cop); SetLength(P_PWIP2 ,Cop); SetLength(P_AAA ,Cop); SetLength(P_BBB ,Cop);
     SetLength(P_CCC ,Cop);

     SetLength(p__a21 ,Cop);  SetLength(p__a22 ,Cop);  SetLength(p__a211 ,Cop);  SetLength(p__a212 ,Cop);  SetLength(p__a222 ,Cop);
     SetLength(p__b21 ,Cop); SetLength(p__b22 ,Cop); SetLength(p__b23 ,Cop);  SetLength(p__ttprov ,Cop);
     SetLength(S__1 ,Cop); SetLength(P__P002 ,Cop); SetLength(P__PWIP2 ,Cop); SetLength(P__AAA ,Cop); SetLength(P__BBB ,Cop);
     SetLength(P__CCC ,Cop);

     SetLength(pdd0,Cop); SetLength(p_dd0,Cop);  SetLength(p__dd0,Cop);
     SetLength(pl,Cop);   SetLength(ppsh1,Cop);  SetLength(psh25,Cop);
     SetLength(pl_,Cop);  SetLength(p_sh1,Cop);  SetLength(p_sh25,Cop);
     SetLength(pl__,Cop);  SetLength(p__sh1,Cop);  SetLength(p__sh25,Cop);
//     SetLength(Ot0,Cop); SetLength(Ot0_,Cop);
  //   SetLength(Ot,300,Cop); SetLength(Ot_,300,Cop);
     SetLength(Skip,Cop);
     Diap := ADiap;
     case Diap of
      1:  Lamda :=  3.3;
      2:  Lamda :=  5.35;
      3:  Lamda := 10;
      4:  Lamda := 24;
      5:  Lamda := 28.5;
     end;
     case Diap of
  1,2: begin
         PG := 90; WR := 90; BR := 1; fone := -50;
       end;
    3: begin
         PG := 85+random(10); WR := 50+random(20); BR := 2.6; fone := -40;
       end;
    4: begin
         PG := 80; WR := 30; BR := 5; fone := -35;
       end;
    5: begin
         PG := 95; WR :=60; BR :=10; fone:=-35;
       end;
  end;
   Kurs:=180;
// Kurs:=0+fmTargetEdit.lm*45;
//  TSignBeg1:=random/(F*60000);
//  tay:=0.5+random(10);
  Nf:=1;
  rn := ARN;
  for nc:=1 to cop do
  begin
//    pl_[nc]:=-1;   pl[nc]:=-1;
    Skip[nc] := false;
  end;
  Number := TargetList.Count;
  Color  := TargetList.Count mod ColorCount;
//  Color := TargetList.Count mod 6;
                                            {фрагмент для селекции}
(*  if Color=0 then begin PG:=90;tay := 5.01;   F:=1/38.4; WR:=72; TSignBeg1:=0;end;
  if Color=1 then begin PG:=95;tay := 4; F:=1; WR:=90; TSignBeg1:=random/(F*60000); end;
  if Color=2 then begin PG:=-85; F:=1; fone:=0; tay:=1.01;TSignBeg1:=random/(F*60000); end;
 // if Color=2 then begin PG:=85; F:=1; fone:=0; tay:=1.01;TSignBeg1:=random/(F*60000); end;
  if Color=3 then begin PG:=85;tay := 3;   F:=2.7; WR:=180; TSignBeg1:=random/(F*60000);end;
  if Color=4 then begin PG:=85;tay := 2;   F:=5;   WR:=180; TSignBeg1:=random/(F*60000);end;
  if Color>4 then      *)
  begin
    tay:=random(10); F:=1; {Кгц} TSignBeg1:=random/(F*60000);

  end;

  for nc:=1 to cop do  Skip[nc] := false;
end;

procedure TTarget.ChangeT;
begin
//  F:=F;
end;
procedure TTarget.ChangeKurs;
begin
//   Kurs:=Kurs+0.5;

end;
procedure TTarget.ChangePel;
begin
   PTek:=PTek+WR*60*fmPassivRadar.delta_t;
   if PTek > 360 then PTek :=PTek-360;
end;
procedure TTarget.Nilling;
var
    nc: integer;
begin
    for nc:=1 to fmPassivRadar.EdCopy.Value do begin
 //       p_TSignBeg1[nc]:=0;   pTSignBeg1[nc]:=0;
        tdubl[nc]:=0;
        tt_:=0;   ttzip_:=0;
        tt_p:=0;  ttzip_p:=0;
        pe_:=0;pezip_:=0;dizip_:=0;dizip_1:=0;
        pr_:=0;przip_:=0;di_:=0;   di_1:=0;
        D_[nc]:=0; D_3[nc]:=0; D_13[nc]:=0;
        pl[nc]:=-1; pl_[nc]:=-1; pl__[nc]:=-1;   { перв отсч, после обр к проц=0}

        s1  [nc] := 0;
        s_1 [nc] := 0;
        s__1[nc] := 0;

    PP002[nc] :=0;PPWIP2[nc] :=0; PAAA[nc]:=0;PBBB[nc]:=0;PCCC[nc]:=0;
    P_P002[nc]:=0;P_PWIP2[nc]:=0; P_AAA[nc]:=0;P_BBB[nc]:=0;P_CCC[nc]:=0;

     ppsh1[nc]:=0;psh25[nc]:=0;pa21[nc]:=0;pa22[nc]:=0;pa212[nc]:=0;
     pa222[nc]:=0;pa211[nc]:=0;pb21[nc]:=0;pb22[nc]:=0;pb23[nc]:=0;

     p_sh1[nc]:=0;p_sh25[nc]:=0;p_a21[nc]:=0;p_a22[nc]:=0;p_a212[nc]:=0;
     p_a222[nc]:=0;p_a211[nc]:=0;p_b21[nc]:=0;p_b22[nc]:=0;p_b23[nc]:=0;

     p__sh1[nc]:=0;p__sh25[nc]:=0;p__a21[nc]:=0;p__a22[nc]:=0;p__a212[nc]:=0;
     p__a222[nc]:=0;p__a211[nc]:=0;p__b21[nc]:=0;p__b22[nc]:=0;p__b23[nc]:=0;

     p_ttprov[nc]:=0;pttprov[nc]:=0;p__ttprov[nc]:=0;
                     end;

end;


procedure TfmTargetEdit.AddButtonClick(Sender: TObject);

var
       nc:integer;
  Target: TTarget;
begin
  fmTargetEdit.lm:=fmTargetEdit.lm+1;
  if lm>1 then fmPassivRadar.Switch.Down:=True;
                               {цикл по числу копий цели}
  with TargetGrid do begin
  begin
    Target := TTarget.CreateTarget (Random(4)+1, DefaultRN.Value);
    Target.WR:=40+random(90);
    Target.Y0:=180+random(100)-Dsm;
    Target.X0:=-40+random(80);
    Target.PG:=70+random(20);
  end;
      Target.X:=Target.X0;
      Target.Y:=Target.Y0;
 //   Target.Y:=140+random(200);
  //    if Target.color=0 then
//    Target := TTarget.Create({1+ Round(random * 4)}3, DefaultRN.Value);
    TargetList.Add(Target);
    TargetList.Last;
    Col := Peleng_;
//    if Target.Color=0 then Target.Kurs:=335 else Target.Kurs:=135;
    if TargetList.Count >= RowCount then  begin
                  {блок введен для обнуления при добовления целей}
    Target.nilling;
    RowCount := RowCount + 1;             end;
    Row := RowCount - 1;
    TargetGrid.Options := TargetGrid.Options + [goEditing];
    Repaint;
    DelButton.Enabled := true;
  end;
end;

procedure TfmTargetEdit.Group1ButtonClick(Sender: TObject);
var
  GroupKurs, AX, AY: Float;

procedure SetTarget(AKurs, ADist: Float; Adiap, APG, AWR: Integer; ABR,
                                           AFone: Float; ATyp: String);
var
  Target: TTarget;
  S, C: Extended;
begin
  Target := TTarget.CreateTarget (ADiap, DefaultRN.Value);
  with Target do begin
    Typ := ATyp;
    PG := APG;
    WR := AWR;
    BR := ABR;
    Fone := AFone;
    Kurs := GroupKurs + 5;
    SinCos((GroupKurs + AKurs) * rad, S, C);
    X0 := AX + Adist*S; X := X0;
    Y0 := AY + Adist*C; Y := Y0;
  end;
  TargetList.Add(Target);
end;

const
  dDist = 15; {Расстояние между целями}
begin
  fmPassivRadar.Switch.Down:=True;
  AX := -10+30*random;
  AY := 180 + 40*random-Dsm;
  GroupKurs := 200{ + Random(90)};
  SetTarget(  0,   0,     2, 85, 60, 1.5,  -50, 'AN/SPS-10');
  SetTarget(  0,   1,     3, 90, 90, 2.5,  -40, 'AN/SPS-52');
  SetTarget(  0,   dDist, 5, 76, 42, 10.5, -35, 'AN/SPS-40');
  SetTarget(  0, 2*dDist, 1, 82, 96, 2,    -50, 'AN/SPS-55');
  SetTarget( 90,   dDist, 2, 85, 60, 1.5,  -50, 'AN/SPS-10');
  SetTarget(180,   dDist, 4, 80, 60, 5,    -35, 'AN/SPS-49');
  SetTarget(270,   dDist, 2, 85, 30, 2,    -50, 'AN/SPS-10');

  with TargetGrid do begin
  if TargetList.Count > RowCount - 1 then RowCount := TargetList.Count + 1;
    Row := RowCount - 1;
    Col := Peleng_;
  end;
  DelButton.Enabled := true;
end;
procedure TfmTargetEdit.Group2ButtonClick(Sender: TObject);
var
  GroupKurs, AX, AY: Float;

procedure SetTarget(AKurs, ADist,AH,ASpeed: Float; Adiap, APG, AWR:
                                Integer; ABR, AFone: Float; ATyp: String);
var
  Target: TTarget;
  S, C: Extended;
begin
  Target := TTarget.CreateTarget (ADiap, DefaultRN.Value);
  with Target do begin
    Typ := ATyp;
    PG := APG;
    WR := AWR;
    BR := ABR;
    Fone := AFone;
    Kurs := GroupKurs + 5;
    H:=AH;
    Speed:=ASpeed;
    SinCos((GroupKurs + AKurs) * rad, S, C);
    X0 := AX + Adist*S; X := X0;
    Y0 := AY + Adist*C; Y := Y0;
  end;
  TargetList.Add(Target);
end;

const
  dDist = 10; {Расстояние между целями}
begin
  AX := {-50+}100*random;
  AY := 600 + 40*random-Dsm;
  GroupKurs := 175 + Random(30);
  SetTarget(  270, 2*dDist, 10,10, 1, 85, 90, 2,  -40, 'AN/APS-116');
  SetTarget(  90,   3*dDist, 10,10, 1, 85, 90, 2,  -40, 'AN/APS-116');
  SetTarget(  0,   dDist,   10,10, 3, 90, 60, 3,  -35, 'AN/APY-1');
  SetTarget(  270, 3*dDist, 10,10, 1, 85, 90, 2,  -40, 'AN/APS-116');
  SetTarget( 90,   dDist,   10,10, 1, 85, 90, 2,  -40, 'AN/APS-116');
  SetTarget( 90,   2*dDist, 10,10, 1, 85, 90, 2,  -40, 'AN/APS-116');
  SetTarget(270,   dDist,   10,10, 1, 85, 90, 2,  -40, 'AN/APS-116');

  with TargetGrid do begin
  if TargetList.Count > RowCount - 1 then RowCount := TargetList.Count + 1;
    Row := RowCount - 1;
    Col := Peleng_;
  end;
  DelButton.Enabled := true;
end;
procedure TfmTargetEdit.SeaModelCourClick(Sender: TObject);
var
  GroupKurs, AX, AY: Float;

procedure SetTarget(AKurs, ADist,AH,ASpeed: Float; Adiap, APG, AWR:
                                 Integer; ABR, AFone: Float; ATyp: String);
var
  Target: TTarget;
  S, C: Extended;
begin
  Target := TTarget.CreateTarget (ADiap, DefaultRN.Value);
  with Target do begin
    Typ := ATyp;
    PG := APG;
    WR := AWR;
    BR := ABR;
    Fone := AFone;

//    Kurs := GroupKurs + 5;
    if Target.color=0 then Kurs:=0;
    if Target.color=1 then Kurs:=60;
    if Target.color=2 then Kurs:=120;
    if Target.color=3 then Kurs:=180;
    if Target.color=4 then Kurs:=240;
    if Target.color=5 then Kurs:=300;


    if Target.Color>5 then Kurs:=random(360);
//    if Target.color=6 then Kurs:=270;
  //  if Target.color=7 then Kurs:=315;
    F:=1;
    Tay:=7;
    H:=AH;
    Man:=True;   {признак маневра}
    Speed:=ASpeed;
    SinCos((GroupKurs + AKurs) * rad, S, C);
    X0 := AX + Adist*S; X := X0;
    Y0 := AY + Adist*C; Y := Y0;
  end;
  TargetList.Add(Target);
end;

const
  dDist = 0; {Расстояние между целями}
begin
  AX := 0;//{-50+}20*random;
  AY := 135-Dsm1;//100 + 40*random;
  GroupKurs := {175 + Random(10)}170;
  SetTarget(  0, 2*dDist, 0.02,1, 3, 90, 45, 3,  -40, '');
  SetTarget(  0,   3*dDist, 0.02,1, 3, 90, 45, 3, -40, '');
  SetTarget(  0,   dDist,   0.02,1, 3, 90, 45, 3,  -40, '');
  SetTarget(  0, 3*dDist, 0.02,1, 3, 90, 45, 3,  -40, '');
  SetTarget( 0,   dDist,   0.02,1, 3, 90, 45, 3,  -40, '');
  SetTarget( 0,   2*dDist, 0.02,1, 3, 90, 45, 3,  -40, '');
//  SetTarget(0,   dDist,   0.02,1, 3, 90, 360, 8,  -40, '');
  //SetTarget(0,   dDist,   0.02,1, 3, 90, 360, 8,  -40, '');

  with TargetGrid do begin
  if TargetList.Count > RowCount - 1 then RowCount := TargetList.Count + 1;
    Row := RowCount - 1;
    Col := Peleng_;
  end;
  DelButton.Enabled := true;

end;
procedure TfmTargetEdit.Group3ButtonClick(Sender: TObject);
var
  GroupKurs, AX, AY: Float;

procedure SetTarget(AKurs, ADist,AH,ASpeed: Float; Adiap, APG, AWR:
                                 Integer; ABR, AFone: Float; ATyp: String);
var
  Target: TTarget;
  S, C: Extended;
begin
  Target := TTarget.CreateTarget (ADiap, DefaultRN.Value);
  with Target do begin
    Typ := ATyp;
    PG := APG;
    WR := AWR;
    BR := ABR;
    Fone := AFone;
    Kurs := GroupKurs + 5;
    H:=AH;
    Speed:=ASpeed;
    SinCos((GroupKurs + AKurs) * rad, S, C);
    X0 := AX + Adist*S; X := X0;
    Y0 := AY + Adist*C; Y := Y0;
  end;
  TargetList.Add(Target);
end;

const
  dDist = 5; {Расстояние между целями}
begin
  AX := {-50+}20*random;
  AY := 100-Dsm + 40*random;
  GroupKurs := {175 + Random(10)}170;
  SetTarget(  270, 2*dDist, 0.02,15, 1, 65, 360, 8,  -40, '"Harpoon"');
  SetTarget(  90,   3*dDist, 0.02,15, 1, 65, 360, 8, -40, '"Hurpoon"');
  SetTarget(  0,   dDist,   0.02,15, 1, 65, 360, 8,  -40, '"Hurpoon"');
  SetTarget(  270, 3*dDist, 0.02,15, 1, 65, 360, 8,  -40, '"Hurpoon"');
  SetTarget( 90,   dDist,   0.02,15, 1, 65, 360, 8,  -40, '"Hurpoon"');
  SetTarget( 90,   2*dDist, 0.02,15, 1, 65, 360, 8,  -40, '"Hurpoon"');
  SetTarget(270,   dDist,   0.02,15, 1, 65, 360, 8,  -40, '"Hurpoon"');

  with TargetGrid do begin
  if TargetList.Count > RowCount - 1 then RowCount := TargetList.Count + 1;
    Row := RowCount - 1;
    Col := Peleng_;
  end;
  DelButton.Enabled := true;
end;

procedure TfmTargetEdit.DelButtonClick(Sender: TObject);
var
  T: Integer;
  Fake: Boolean;
begin
  T := DetTarget.IndexOf(TargetList.Items[TargetGrid.Row - 1]);
  if T <> -1 then begin
    DetTarget.Items[T] := nil;
    with DetTarget do
      while (Count > 0) and (Items[Count - 1] = nil) do Delete(Count - 1);
    fmPassivRadar.DetTargetGrid.Repaint;
  end;
  TTarget(TargetList.Items[TargetGrid.Row - 1]).Free;
  fmMap.Selected := -1;
  TargetList.Delete(TargetGrid.Row - 1);
  if TargetGrid.TopRow > 1 then TargetGrid.TopRow := TargetGrid.TopRow - 1;
  if TargetList.Count = 0
    then begin
      TargetGrid.Options := TargetGrid.Options - [goEditing];
      TargetGrid.Col := 1;
      DiapBox.Hide;
      //rnBox.Hide;
      ColorBox.Hide;
      DelButton.Enabled := false;
    end
    else if TargetList.Count > 0 then
                               TargetGrid.RowCount := TargetList.Count + 1;
  TargetGridSelectCell(Self, TargetGrid.Col, TargetGrid.Row, Fake);
  TargetGrid.Repaint;
end;

procedure TfmTargetEdit.TargetGridDrawCell(Sender: TObject; Col,
                         Row: Integer; Rect: TRect; State: TGridDrawState);
var
  T: String;
  CenterX: Integer;
  Centered: Boolean;
  Target    : TTarget;
begin
  T := '';
  CenterX := Rect.Left + (Rect.Right - Rect.Left) div 2;
  Centered := true;
  if Row = 0 then begin
    T := Columns[Col];
    if Col = Typ_ then Centered := False;
  end
    else if TargetList.Count > 0 then begin
        Target := TTarget(TargetList.Items[Row - 1]);
        with  Target do
        case Col of
             Num_: T := IntToStr(Row);
             Typ_: begin
                     T := Typ;
                     Centered := false;
                   end;
            Diap_: T := DiapsName[Diap];
              PG_: T:= IntToStr(PG);
                                            {Вывод частоты повторения}

//               F_: T := FloatToStrF(F,ffFixed,3,1);
                                            { Вывод уровня медленных флуктуаций}
                 F_: T := FloatToStrF(VM2[1],ffFixed,3,1);
              WR_: T := IntToStr(WR);
              BR_: T := FloatToStrF(BR,ffFixed, 4, 1);
            Fone_: T := FloatToStrF(Fone,ffFixed, 4, 0);
              rn_: begin
                      T := IntToStr(Depression);
                   //   if fmTargetEdit.Vvedensky.Checked then T := IntToStr(rn);
                     // if fmTargetEdit.Sharigin.Checked then  T := IntToStr(Depression);
                   end;
          Peleng_: T := FloatToStrF(FloatToGrad(grad*arctan2(X-
               fmPassivRadar.Carrier2.X, Y-fmPassivRadar.Carrier2.Y)), ffFixed, 4, 1);
            Dist_: T := FloatToStrF(Hypot(X-fmPassivRadar.Carrier2.X,
                                         Y-fmPassivRadar.Carrier2.Y), ffFixed, 4, 1);
            Kurs_: T := FloatToStrF(Kurs, ffGeneral, 4, 2);
           Speed_: T := FloatToStrF(Speed, ffFixed, 4, 1);
               H_: T := FloatToStrF(H, ffFixed, 4, 2);
        end;
    end;



    with TargetGrid.Canvas do begin
      if (TargetList.Count > 0) and (Row > 0) and (Col > 0) then begin
        if TTarget(TargetList.Items[Row - 1]).PG = 0 then begin
          Brush.Color := $00E0E0E0;
          FillRect(Rect);
        end;
        if Col = Color_ then begin
      Brush.Color := TargetColors[TTarget(TargetList.Items[Row - 1]).Color];
          FillRect(Rect);
        end;
    end;
    if T <> '' then
      if Centered then TextOut(CenterX - TextWidth(T) div 2,
            Rect.Top + Round((Rect.Bottom - Rect.Top + Font.Height)/2), T)
                else TextOut(Rect.Left + 2 ,
             Rect.Top + Round((Rect.Bottom - Rect.Top + Font.Height)/2),T);
    end;
end;

procedure TfmTargetEdit.TargetGridSelectCell(Sender: TObject; Col,
                                     Row: Integer; var CanSelect: Boolean);
var
  Rect: TRect;
begin
  if TargetList.Count = 0 then Exit;
  DiapBox.Hide;
  //rnBox.Hide;
  ColorBox.Hide;
  case Col of
  Diap_: begin
           TargetGrid.Options := TargetGrid.Options - [goEditing];
           Rect := TargetGrid.CellRect(Col, Row);
           DiapBox.ItemIndex := TTarget(TargetList.Items[Row - 1]).Diap - 1;
           DiapBox.Left := TargetGrid.Left + Rect.Left + 2;
           DiapBox.Top := TargetGrid.Top + Rect.Top + 2;
           DiapBox.Width := Rect.Right - Rect.Left + 1;
           DiapBox.Show;
           DiapBox.SetFocus;
         end;
    rn_: begin
           TargetGrid.Options := TargetGrid.Options - [goEditing];
           Rect := TargetGrid.CellRect(Col, Row);
           //rnBox.ItemIndex := TTarget(TargetList.Items[Row - 1]).rn - 1;
           //rnBox.Left := TargetGrid.Left + Rect.Left + 2;
           //rnBox.Top := TargetGrid.Top + Rect.Top + 2;
           //rnBox.Width := Rect.Right - Rect.Left + 1;
           //rnBox.Show;
           //rnBox.SetFocus;
         end;
 Color_: begin
           TargetGrid.Options := TargetGrid.Options - [goEditing];
           Rect := TargetGrid.CellRect(Col, Row);
           ColorBox.ItemIndex := TTarget(TargetList.Items[Row - 1]).Color;
           ColorBox.Left := TargetGrid.Left + Rect.Left + 2;
           ColorBox.Top := TargetGrid.Top + Rect.Top + 2;
           ColorBox.Width := Rect.Right - Rect.Left + 1;
           ColorBox.Show;
           ColorBox.SetFocus;
         end
  else
    TargetGrid.Options := TargetGrid.Options + [goEditing];
  end;
end;

procedure TfmTargetEdit.TargetGridSetEditText(Sender: TObject;
                                ACol, ARow: Integer; const Value: String);
var
  D, S, C: Extended;
begin
  if (aCol = 4) or (aCol = 8) then exit;
  try
    with TTarget(TargetList.Items[ARow - 1]) do
    case ACol of
    Typ_: Typ := Value;
    Diap_: begin
             if value <> '' then Diap := StrToInt(Value);
             case Diap of
               1: begin
                      PG := 90; WR := 90; BR := 1; fone := -50; lamda := 3.3;
                    end;
               2: begin
                      PG := 90; WR := 90; BR := 1; fone := -50; lamda := 5.35;
                    end;
                 3: begin
                      PG := 90; WR := 45; BR := 2; fone := -40; lamda:=10;
                    end;
                 4: begin
                      PG := 80; WR := 30; BR := 5; fone := -35; lamda := 24;
                    end;
                 5: begin
                      PG := 80; WR :=30;  BR :=15; fone := -35; lamda := 28.5;
                    end;
             end;
           end;
      PG_:   if Value <> '' then  begin
                                   PG := StrToInt(Value);
                                   fmPassivRadar.PGMamory[ARow - 1] := PG;
                                 end;
      F_:    if Value <> '' then  F  := StrToInt(Value);
      WR_:   if Value <> '' then  WR := StrToInt(Value);
      BR_:   if Value <> '' then  BR := StrToInt(Value);
      Fone_: if (Value <> '-')and(Value <> '') then  Fone := StrToFloat(Value);
      rn_:   if Value <> '' then  rn := StrToInt(Value);
  Peleng_:   if Value<> ''  then begin
             SinCos(rad*StrToFloat(Value), S, C);
              begin
               D := Hypot(X-fmPassivRadar.Carrier2.X, Y-fmPassivRadar.Carrier2.Y);
               X := fmPassivRadar.Carrier2.X + D*S;
               Y := fmPassivRadar.Carrier2.Y + D*C;
              end;
             X0 := X;
             Y0 := Y;
           end;
    Dist_: if Value <> '' then begin
              D := StrToFloat(Value);
              SinCos(arctan2(X-fmPassivRadar.Carrier2.X,
                                            Y-fmPassivRadar.Carrier2.Y), S, C);
              X := fmPassivRadar.Carrier2.X + D*S;
              Y := fmPassivRadar.Carrier2.Y + D*C;
              X0 := X;
              Y0 := Y;
           end;
   Kurs_:  if Value <> '' then Kurs := StrToFloat(Value);
   Speed_: if Value <> '' then Speed := StrToFloat(Value);
   H_:     if Value <> '' then H := StrToFloat(Value);
   Color_: if Value <> '' then Color := StrToInt(Value);
    end;
  except
  end;
  TargetGrid.Repaint;

end;

procedure TfmTargetEdit.DiapBoxChange(Sender: TObject);
begin
  TargetGridSetEditText(Sender, TargetGrid.Col, TargetGrid.Row,
                                         IntToStr(DiapBox.ItemIndex + 1));
end;

procedure TfmTargetEdit.rnBoxChange(Sender: TObject);
begin
  TargetGridSetEditText(Sender, TargetGrid.Col, TargetGrid.Row,
                                                   ''{rnBox.Text});
end;

procedure TfmTargetEdit.ColorBoxChange(Sender: TObject);
begin
  TargetGridSetEditText(Sender, TargetGrid.Col, TargetGrid.Row,
                                             IntToStr(ColorBox.ItemIndex));
  fmPassivRadar.DetTargetGrid.Repaint;
end;

procedure TfmTargetEdit.ColorBoxDrawItem(Control: TWinControl;
                                                           Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  with ColorBox.Canvas do begin
    Brush.Color := TargetColors[Index];
    FillRect(Rect);
  end;
end;

procedure TfmTargetEdit.TargetGridGetEditText(Sender: TObject;
                                   ACol, ARow: Integer; var Value: String);
begin
  with TTarget(TargetList.Items[ARow - 1]) do
  case ACol of
   Typ_: Value := Typ;
  Diap_: Value := IntToStr(Diap);
    PG_: Value := IntToStr(PG); 
     F_: Value := FloatToStrF(F,ffGeneral,3,1);
    WR_: Value := IntToStr(WR);
    BR_: Value := FloatToStrF(BR, ffGeneral, 4, 1);
    Fone_: Value := FloatToStrF(Fone, ffGeneral, 4, 0);
//    Fone_:Value := IntToStr(Fone);
    rn_: Value := IntToStr(rn);
Peleng_: Value := FloatToStrF(FloatToGrad(grad*arctan2(X-
     fmPassivRadar.Carrier2.X, Y-fmPassivRadar.Carrier2.Y)), ffGeneral, 4, 1);
//  Dist_: Value := FloatToStrF(Hypot(X-PassivRadar.Carrier2.X,Y-
  //                              PassivRadar.Carrier2.Y), ffGeneral, 4, 1);
  Kurs_: Value := FloatToStrF(Kurs, ffGeneral, 4, 5);
 Speed_: Value := FloatToStrF(Speed, ffGeneral, 4, 5);
  H_   : Value := FloatToStrF(H, ffGeneral, 4, 5);
  end;
end;
procedure TfmTargetEdit.SeaModel1Click(Sender: TObject);
var
  i:integer;
  Target: TTarget;
begin
  fmPassivRadar.Switch.Down:=True;
  for i:=1 to 5 do
  begin
    Target := TTarget.CreateTarget (3, 4);
  with Target do
  begin
    if i=1 then begin  diap:=1; end;
    if i=2 then begin  diap:=2; end;
    if i=3 then begin  diap:=3; end;
    if i=4 then begin  diap:=4; end;
    if i=5 then begin  diap:=5; end;
 //   Typ := ATyp;
 //  PG := 90;
 //   WR := 45;
   // BR := 2;
     case Diap of
      1: begin Lamda :=  3; PG:=92;  Y0:=//150;
                                                350-Dsm;
                                         WR:=123;BR:=1;RN:=3;Fone:=-50; end;
      2: begin Lamda :=  5; PG:=87;  Y0:=//150;
                                                350-Dsm;
                                         WR:=123;BR:=2;RN:=3;Fone:=-50 end;
      3: begin Lamda :=  10; PG:=90; Y0:=//150;
                                                350-Dsm;
                                         WR:=123;BR:=3;RN:=2;Fone:=-50; end;
      4: begin Lamda :=  25; PG:=80; Y0:=//150;
                                                350-Dsm;
                                         WR:=123;BR:=8;RN:=2;Fone:=-50; end;
      5: begin Lamda :=  35; PG:=75; Y0:=//150;
                                                350-Dsm;
                                         WR:=123;BR:=12;RN:=2;Fone:=-50; end;
    end;
   // Fone := -30;
    Kurs := 135;
    H:=0;//0.02;
    Speed:=1;//0.7;
    X0 :=-1;       X := X0;
 //   Y0 :=540;//420+i*20;
     Y := Y0;
  end;
   TargetList.Add(Target);
  end;

    with TargetGrid do begin
  if TargetList.Count > RowCount - 1 then RowCount := TargetList.Count + 1;
    Row := RowCount - 1;
    Col := Peleng_;
  end;
  DelButton.Enabled := true;
end;
procedure TfmTargetEdit.FormCreate(Sender: TObject);
var
  Target:TTarget;
  n: Integer;
begin
  TargetList  := TList.Create;
  DetTarget   := TList.Create;
  PauseRezhim := False;
  TargetGrid.Options := TargetGrid.Options - [goEditing];
  TargetGrid.DefaultRowHeight := DiapBox.Height; //!!!!
  for n := 1 to ColorCount do ColorBox.Items.Add('');
  DelButton.Enabled := TargetList.Count > 0;
//  for n:=1 to 4 do
//  AddButtonClick(Self);
  if fmManager.CU1.Down or fmManager.CU2.Down or fmManager.CU3.Down then
     SeaModelCourClick(Self);
//  SeaModel1Click(Self);
//    SeaModel2Click(Self);
  if fmManager.Probability.Down then
  SeaModelDisClick(Self);
  if Assigned(TargetList) and (TargetList.Count > 0) then
  for n := 0 to TargetList.Count - 1 do
  begin
      Target := TTarget(TargetList.Items[n]);
      with Target do
      begin
        X := X0; Y := Y0;          {ввод нач координат заданн в редак при tt=0}
        nilling;
      end;
  end;
//  fmTargetEdit.Show;
  Randomize;
end;
procedure TfmTargetEdit.SeaModelDisClick(Sender: TObject);
var
  GroupKurs, AX, AY: Float;

procedure SetTarget(AKurs, ADist,AH,ASpeed: Float; Adiap, APG, AWR:
                                 Integer; ABR, AFone: Float; ATyp: String);
var
  Target: TTarget;
  S, C: Extended;
  nc  :Integer;
  i   : Integer;
begin
  Target := TTarget.CreateTarget (ADiap, DefaultRN.Value);
  with Target do begin
//   TPause:=1;
   for nc:=1 to fmPassivRadar.EdCopy.Value do
  begin
//    TBegPause[nc] := TPause*Random(1);
  end;
    Typ := ATyp;
    PG := APG;
    WR := AWR;
    BR := ABR;
    Fone := AFone;


  // for i := 0 to TargetList.Count-1 do begin
  //    if Target.color=0 then AY:=90 + i*15 -Dsm1;//{220;}260;
  // end;
//    Kurs := GroupKurs + 5;
  //  if Diap=1 then
   begin
    if Target.color=0 then AY:=90-Dsm1;//{220;}260;
    if Target.color=1 then AY:=105-Dsm1;//{200;}280;
    if Target.color=2 then AY:=120-Dsm1;//{180;}300;
    if Target.color=3 then AY:=135-Dsm1;//{160;}320;
    if Target.color=4 then AY:=150-Dsm1;//{140;}340;
    if Target.color=5 then AY:=165-Dsm1;//{120;}360;
    if Target.color=6 then AY:=180-Dsm1;//{120;}360;

    if Target.color>6 then AY:=195-Dsm1+random(20);

   end;
    Kurs:=135;
//    if Target.color=6 then Kurs:=270;
  //  if Target.color=7 then Kurs:=315;
    F:=1;
    Tay:=7;
    H:=AH;
    Man:=True;   {признак маневра}
    Speed:=ASpeed;
    SinCos((GroupKurs + AKurs) * rad, S, C);
    X0 := AX + Adist*S; X := X0;
    Y0 := AY + Adist*C; Y := Y0;
  end;
  TargetList.Add(Target);
end;

const
  dDist = 0; {Расстояние между целями}
begin
  AX := -0.1;//{-50+}20*random;
//  AY := 170;//140;//100 + 40*random;
  GroupKurs := {175 + Random(10)}170;
  SetTarget(  0, 2*dDist, 0.02,1, 1, 66, 90, 2,  -50, '');
  SetTarget(  0,   3*dDist, 0.02,1, 1, 66, 90, 2, -50, '');
  SetTarget(  0,   dDist,   0.02,1, 1, 66, 90, 2,  -50, '');
  SetTarget(  0, 3*dDist, 0.02,1, 1, 66, 90, 2,  -50, '');
  SetTarget( 0,   dDist,   0.02,1, 1, 66, 90, 2,  -50, '');
  SetTarget( 0,   2*dDist, 0.02,1, 1, 66, 90, 2,  -50, '');
//  SetTarget(0,   dDist,   0.02,1, 1, 66, 360, 8,  -40, '');
  //SetTarget(0,   dDist,   0.02,1, 1, 66, 360, 8,  -40, '');

  with TargetGrid do begin
  if TargetList.Count > RowCount - 1 then RowCount := TargetList.Count + 1;
    Row := RowCount - 1;
    Col := Peleng_;
  end;
  DelButton.Enabled := true;
end;
procedure TfmTargetEdit.SeaModel2Click(Sender: TObject);
var
  i:integer;
  Target: TTarget;
begin
  for i:=1 to 2 do
  begin
    Target := TTarget.CreateTarget (3, 4);
  with Target do
  begin
    if i=1 then begin  diap:=1; end;
    if i=2 then begin  diap:=3; end;
//    if i=3 then begin  diap:=4; end;
  //  if i=4 then begin  diap:=4; end;
    //if i=5 then begin  diap:=5; end;
 //   Typ := ATyp;
 //  PG := 90;
 //   WR := 45;
   // BR := 2;
     case Diap of
      1: begin Lamda :=  3; PG:=90;  Y0:=150-Dsm;//350;
                                         WR:=120;BR:=1;RN:=2;Fone:=-50; end;
      3: begin Lamda :=  10; PG:=90;  Y0:=150-Dsm;//350;
                                         WR:=45;BR:=3;RN:=2;Fone:=-40 end;
      4: begin Lamda :=  25; PG:=100{90}; Y0:=150-Dsm;//350;
                                         WR:=30;BR:=6;RN:=2;Fone:=-50; end;
    //  4: begin Lamda :=  25; PG:=80; Y0:=150;//350;
      //                                   WR:=123;BR:=8;RN:=2;Fone:=-50; end;
    //  5: begin Lamda :=  35; PG:=75; Y0:=150;//350;
        //                                 WR:=123;BR:=12;RN:=2;Fone:=-50; end;
    end;
   // Fone := -30;
    Kurs :=290;// 135;
    H:=0.02;
    Speed:=1;//0.7;
    X0 :=11;        X := X0;
 //   Y0 :=540;//420+i*20;
     Y := Y0;
  end;
   TargetList.Add(Target);
  end;

    with TargetGrid do begin
  if TargetList.Count > RowCount - 1 then RowCount := TargetList.Count + 1;
    Row := RowCount - 1;
    Col := Peleng_;
  end;
  DelButton.Enabled := true;
end;
procedure TfmTargetEdit.FormDestroy(Sender: TObject);
var
  N: Integer;
begin
  DetTarget.Free;
  if TargetList.Count > 0 then
    for n := 0 to TargetList.Count - 1 do TTarget(TargetList.Items[n]).Free;
  TargetList.Free;
end;

procedure TfmTargetEdit.RefreshClick(Sender: TObject);
begin
 if fmManager.Probability.Down then
              fmManager.ProbabilityClick(Self);
 if fmManager.CU1.Down then
              fmManager.CU1Click(Self);
 if fmManager.CU2.Down then
              fmManager.CU2Click(Self);
 if fmManager.CU3.Down then
              fmManager.CU3Click(Self);

end;

procedure TTarget.ChangeP(i:integer);
begin
    

end;
procedure TfmTargetEdit.EditPauseChange(Sender: TObject);
var
 i : integer;
 Target : TTarget;
begin
  if (EditPause.Value = 0) and (PauseRezhim) then
     if TargetList.Count > 0 then begin
       for i:=0 to TargetList.Count - 1 do begin
         Target := TTarget(TargetList.Items[i]);
         Target.PG := fmPassivRadar.PGMamory[i];
       end;
       TargetGrid.Repaint;
     end;

  if EditPause.Value = 0 then begin
    PauseRezhim := False;
    fmTargetEdit.TargetGrid.Enabled := True;
  end else begin
    PauseRezhim := True;
    fmTargetEdit.TargetGrid.Enabled := False;
  end;

end;

procedure TfmTargetEdit.FormShow(Sender: TObject);
begin
  Left := 0;
  Top  := 402;
end;

 procedure TfmTargetEdit.DefaultRNChange(Sender: TObject);
var
Targ:integer;
Target:TTarget;
begin
   if Assigned(TargetList) and(TArgetList.Count > 0) then
         for Targ :=0 to TargetList.Count-1  do
         begin
          Target:=TTarget(TargetList.Items[Targ]);
          Target.rn:=StrToInt(DefaultRN.Text);
         end;
end;


begin
  Columns[Num_]    := 'Nt';
  Columns[Typ_]    := 'Type';
  Columns[Diap_]   := 'Freq';
  Columns[PG_]     := 'PG';
  Columns[F_]      := 'Low';
  Columns[WR_]     := 'WR';
  Columns[BR_]     := 'BR';
  Columns[Fone_]   := 'Level';
  Columns[rn_]     := 'Depr';
  Columns[Peleng_] := 'Direct';
  Columns[Dist_]   := 'Distan';
  Columns[Kurs_]   := 'Course';
  Columns[Speed_]  := 'Speed';
  Columns[Color_]  := 'Color';
  Columns[H_]      := 'Height';


end.
