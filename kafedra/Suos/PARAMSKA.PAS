unit Paramska;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, KzaCom, Dialogs;

const
     MyuE    = 3.98602e14;{Grav parameter of Earth}
     RE      = 6.377e6; {Average radius of Earth}
     NyuE    = 8.06e19; {Magnetick moment of Earth dipol}
     AlfaM   = 20*Pi/180; {Angle betwen EXm and GreenWhich meridian}
     GammaM  = 11.5*Pi/180;{Angle of dipol}
     iiS     = 23.5*Pi/180; {Angle betwen Ecliptic and Ekvator}
     OmegaS  = 1.14e-5*Pi/180;{Angle speed of Sun in Ecliptic}
     OmegaEE = 4.17e-3*Pi/180;{Average angle speed of Earth spin}
     Bm      = NyuE/(RE*RE*RE);
type
  TParamsKADlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    GroupBox4: TGroupBox;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Bevel16: TBevel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Label23: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Bevel15: TBevel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Bevel1: TBevel;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Bevel23: TBevel;
    Bevel24: TBevel;
    Bevel25: TBevel;
    Label24: TLabel;
    Label30: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label43: TLabel;
    Label48: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label22: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    GroupBox5: TGroupBox;
    Bevel6: TBevel;
    Bevel11: TBevel;
    Bevel26: TBevel;
    Bevel27: TBevel;
    Bevel28: TBevel;
    Bevel29: TBevel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Bevel30: TBevel;
    Bevel31: TBevel;
    Bevel32: TBevel;
    Bevel33: TBevel;
    Bevel34: TBevel;
    Bevel35: TBevel;
    Label60: TLabel;
    Label61: TLabel;
    GroupBox6: TGroupBox;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Bevel36: TBevel;
    Bevel37: TBevel;
    Bevel38: TBevel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Jxx: TEdit;
    Jxy: TEdit;
    Jxz: TEdit;
    Jyx: TEdit;
    Jyy: TEdit;
    Jyz: TEdit;
    Jzx: TEdit;
    Jzy: TEdit;
    Jzz: TEdit;
    Mx: TEdit;
    My: TEdit;
    Mz: TEdit;
    A1x: TEdit;
    A1y: TEdit;
    A1z: TEdit;
    F1x: TEdit;
    F1y: TEdit;
    F1z: TEdit;
    SH1x: TEdit;
    SH1y: TEdit;
    SH1z: TEdit;
    A2x: TEdit;
    A2y: TEdit;
    A2z: TEdit;
    F2z: TEdit;
    F2y: TEdit;
    F2x: TEdit;
    SH2x: TEdit;
    SH2y: TEdit;
    SH2z: TEdit;
    InitAngX: TEdit;
    InitAngY: TEdit;
    InitAngZ: TEdit;
    InitSpeedX: TEdit;
    InitSpeedY: TEdit;
    InitSpeedZ: TEdit;
    Jp: TEdit;
    Mp: TEdit;
    LambdaS0: TEdit;
    LambdaG0: TEdit;
    Lambda0: TEdit;
    i0: TEdit;
    U0: TEdit;
    H0: TEdit;
    IMxx: TEdit;
    IMxy: TEdit;
    IMxz: TEdit;
    IMyx: TEdit;
    IMyy: TEdit;
    IMyz: TEdit;
    IMzx: TEdit;
    IMzy: TEdit;
    IMzz: TEdit;
    MMx: TEdit;
    MMy: TEdit;
    MMz: TEdit;
    GRSBegin: TEdit;
    GRSLength: TEdit;
    GRSMomX: TEdit;
    GRSMomY: TEdit;
    GRSMomZ: TEdit;
    UBMomX: TEdit;
    UBMomY: TEdit;
    UBMomZ: TEdit;
    REDMomX: TEdit;
    REDMomY: TEdit;
    REDMomZ: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CalculateMom(
    {Input parameters}
    Omega, Mu, H: CoordExtended;
    {Output parameters}
    var M: CoordExtended);
    procedure Calculate(
    Lrgs: Boolean;
    {Output parameters}
    Mu, H: CoordExtended;
    var AngleFi,Omega,dOmega: CoordTStek);
    procedure CalculateSun( AngleFi: CoordTStek;
     var S: CoordExtended);
    procedure CalculateS( T: Extended;var Sx0: Extended;
     var Pt: Boolean);
    procedure CalculateVoz;
    procedure CalculateB( var AngleFi: CoordTStek;
              T: Extended;var B: CoordExtended);
    function Save(Handle: LongInt): boolean;
    function Open(Handle: LongInt): boolean;
    function Tenzor:boolean;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vJ : MatrixExtended;
    vJv: MatrixExtended;
    vM: CoordExtended;
    vA1: CoordExtended;
    vA2: CoordExtended;
    vF1: CoordExtended;
    vF2: CoordExtended;
    vSH1: CoordExtended;
    vSH2: CoordExtended;
    vInitAng  : CoordExtended;
    vInitSpeed: CoordExtended;
    vLambdaS0: Extended;
    vLambdaG0: Extended;
    vLambda0: Extended;
    vi0: Extended;
    vU0: Extended;
    vH0: Extended;
    Omega0: Extended;
    RoE: Extended;
    OmegaE: CoordTStek;
    VozMom: CoordExtended;

    vIM: MatrixExtended;
    vMM: CoordExtended;
    vGRSBegin: Extended;
    vGRSLength: Extended;
    vGRSMom: CoordExtended;
    vUBMom: CoordExtended;
    vREDMom: CoordExtended;
  end;

var
  ParamsKADlg: TParamsKADlg;

implementation

uses SysUtils, SB, SParams, Main;

{$R *.DFM}

function TParamsKADlg.Save(Handle: LongInt): boolean;
begin
  FileWrite(Handle,vJ,SizeOf(MatrixExtended));
  FileWrite(Handle,vInitAng,SizeOf(CoordExtended));
  FileWrite(Handle,vInitSpeed,SizeOf(CoordExtended));
  FileWrite(Handle,vLambdaS0,SizeOf(Extended));
  FileWrite(Handle,vLambdaG0,SizeOf(Extended));
  FileWrite(Handle,vLambda0,SizeOf(Extended));
  FileWrite(Handle,vi0,SizeOf(Extended));
  FileWrite(Handle,vU0,SizeOf(Extended));
  FileWrite(Handle,vH0,SizeOf(Extended));
  FileWrite(Handle, vM,SizeOf(CoordExtended));
  FileWrite(Handle, vA1,SizeOf(CoordExtended));
  FileWrite(Handle, vA2,SizeOf(CoordExtended));
  FileWrite(Handle, vF1,SizeOf(CoordExtended));
  FileWrite(Handle, vF2,SizeOf(CoordExtended));
  FileWrite(Handle, vSH1,SizeOf(CoordExtended));
  FileWrite(Handle, vSH2,SizeOf(CoordExtended));
  FileWrite(Handle, vIM,SizeOf(MatrixExtended));
  FileWrite(Handle, vMM,SizeOf(CoordExtended));
  FileWrite(Handle, vGRSMom,SizeOf(CoordExtended));
  FileWrite(Handle, vUBMom,SizeOf(CoordExtended));
  FileWrite(Handle, vREDMom,SizeOf(CoordExtended));
  FileWrite(Handle, vGRSBegin,SizeOf(Extended));
  FileWrite(Handle, vGRSLength,SizeOf(Extended));
  Result:=True;
end;

function TParamsKADlg.Open(Handle: LongInt): boolean;
begin
  FileRead(Handle,vJ,SizeOf(MatrixExtended));
  FileRead(Handle,vInitAng,SizeOf(CoordExtended));
  FileRead(Handle,vInitSpeed,SizeOf(CoordExtended));
  FileRead(Handle,vLambdaS0,SizeOf(Extended));
  FileRead(Handle,vLambdaG0,SizeOf(Extended));
  FileRead(Handle,vLambda0,SizeOf(Extended));
  FileRead(Handle,vi0,SizeOf(Extended));
  FileRead(Handle,vU0,SizeOf(Extended));
  FileRead(Handle,vH0,SizeOf(Extended));
  FileRead(Handle, vM,SizeOf(CoordExtended));
  FileRead(Handle, vA1,SizeOf(CoordExtended));
  FileRead(Handle, vA2,SizeOf(CoordExtended));
  FileRead(Handle, vF1,SizeOf(CoordExtended));
  FileRead(Handle, vF2,SizeOf(CoordExtended));
  FileRead(Handle, vSH1,SizeOf(CoordExtended));
  FileRead(Handle, vSH2,SizeOf(CoordExtended));
  FileRead(Handle, vIM,SizeOf(MatrixExtended));
  FileRead(Handle, vMM,SizeOf(CoordExtended));
  FileRead(Handle, vGRSMom,SizeOf(CoordExtended));
  FileRead(Handle, vUBMom,SizeOf(CoordExtended));
  FileRead(Handle, vREDMom,SizeOf(CoordExtended));
  FileRead(Handle, vGRSBegin,SizeOf(Extended));
  FileRead(Handle, vGRSLength,SizeOf(Extended));
  Omega0  := Sqrt(MyuE/((RE+vH0)*(RE+vH0)*(RE+vH0)));
  RoE     := cos(ArcSin(RE/(vH0+RE)));
  Tenzor;
  Result:=True;
end;

procedure TParamsKADlg.FormCreate(Sender: TObject);
var i: Coord;
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
  for i:=x to z do
  OmegaE[i]:=TStek.Create;
end;

procedure TParamsKADlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TParamsKADlg.OKBtnClick(Sender: TObject);
const Mes='Детерминант тензора инерции равен 0!';
var i,j: Coord;
begin
  SunBatDlg.vJp:=StrToFloat(Jp.Text);
  SunBatDlg.vMp:=StrToFloat(Mp.Text);
  vLambdaS0:=StrToFloat(LambdaS0.Text);
  vi0:=StrToFloat(i0.Text);
  vLambdaG0:=StrToFloat(LambdaG0.Text);
  vLambda0:=StrToFloat(Lambda0.Text);
  vU0:=StrToFloat(U0.Text);
  vH0:=StrToFloat(H0.Text);
  vInitAng[x]:=StrToFloat(InitAngX.Text);
  vInitAng[y]:=StrToFloat(InitAngY.Text);
  vInitAng[z]:=StrToFloat(InitAngZ.Text);
  vInitSpeed[x]:=StrToFloat(InitSpeedX.Text);
  vInitSpeed[y]:=StrToFloat(InitSpeedY.Text);
  vInitSpeed[z]:=StrToFloat(InitSpeedZ.Text);
  vM[x]:=StrToFloat(Mx.Text);
  vM[y]:=StrToFloat(My.Text);
  vM[z]:=StrToFloat(Mz.Text);
  vA1[x]:=StrToFloat(A1x.Text);
  vA1[y]:=StrToFloat(A1y.Text);
  vA1[z]:=StrToFloat(A1z.Text);
  vA2[x]:=StrToFloat(A2x.Text);
  vA2[y]:=StrToFloat(A2y.Text);
  vA2[z]:=StrToFloat(A2z.Text);
  vF1[x]:=StrToFloat(F1x.Text);
  vF1[y]:=StrToFloat(F1y.Text);
  vF1[z]:=StrToFloat(F1z.Text);
  vF2[x]:=StrToFloat(F2x.Text);
  vF2[y]:=StrToFloat(F2y.Text);
  vF2[z]:=StrToFloat(F2z.Text);
  vSH1[x]:=StrToFloat(SH1x.Text);
  vSH1[y]:=StrToFloat(SH1y.Text);
  vSH1[z]:=StrToFloat(SH1z.Text);
  vSH2[x]:=StrToFloat(SH2x.Text);
  vSH2[y]:=StrToFloat(SH2y.Text);
  vSH2[z]:=StrToFloat(SH2z.Text);
  vMM[x]:=StrToFloat(MMx.Text);
  vMM[y]:=StrToFloat(MMy.Text);
  vMM[z]:=StrToFloat(MMz.Text);
  vGRSMom[x]:=StrToFloat(GRSMomX.Text);
  vGRSMom[y]:=StrToFloat(GRSMomy.Text);
  vGRSMom[z]:=StrToFloat(GRSMomz.Text);
  vUBMom[x]:=StrToFloat(UBMomX.Text);
  vUBMom[y]:=StrToFloat(UBMomy.Text);
  vUBMom[z]:=StrToFloat(UBMomz.Text);
  vREDMom[x]:=StrToFloat(REDMomX.Text);
  vREDMom[y]:=StrToFloat(REDMomy.Text);
  vREDMom[z]:=StrToFloat(REDMomz.Text);
  vGRSBegin:=StrToFloat(GRSBegin.Text);
  vGRSLength:=StrToFloat(GRSLength.Text);

  vIM[X,X]:=StrToFloat(IMxx.Text);
  vIM[X,Y]:=StrToFloat(IMxy.Text);
  vIM[X,Z]:=StrToFloat(IMxz.Text);
  vIM[Y,X]:=StrToFloat(IMyx.Text);
  vIM[Y,Y]:=StrToFloat(IMyy.Text);
  vIM[Y,Z]:=StrToFloat(IMyz.Text);
  vIM[Z,X]:=StrToFloat(IMzx.Text);
  vIM[Z,Y]:=StrToFloat(IMzy.Text);
  vIM[Z,Z]:=StrToFloat(IMzz.Text);
  {---------------------------}
  Omega0  := Sqrt(MyuE/((RE+vH0)*(RE+vH0)*(RE+vH0)));
  RoE     :=cos( ArcSin(RE/(vH0+RE)));
  vJ[X,X]:=StrToFloat(Jxx.Text);
  vJ[X,Y]:=StrToFloat(Jxy.Text);
  vJ[X,Z]:=StrToFloat(Jxz.Text);
  vJ[Y,X]:=StrToFloat(Jyx.Text);
  vJ[Y,Y]:=StrToFloat(Jyy.Text);
  vJ[Y,Z]:=StrToFloat(Jyz.Text);
  vJ[Z,X]:=StrToFloat(Jzx.Text);
  vJ[Z,Y]:=StrToFloat(Jzy.Text);
  vJ[Z,Z]:=StrToFloat(Jzz.Text);
  {--------------}
  if Tenzor then  Hide
    else MessageDlg(Mes,mtError,mbOKCancel,0);
end;

function TParamsKADlg.Tenzor: boolean;
var   det: Extended;
begin
   Result:=false;
  det:= vJ[X,X]*vJ[Y,Y]*vJ[Z,Z] - vJ[X,X]*vJ[Y,Z]*vJ[Y,Z] - vJ[Y,Y]*vJ[X,Z]*vJ[X,Z]
       - vJ[Z,Z]*vJ[X,Y]*vJ[X,Y] - 2*vJ[X,Y]*vJ[X,Z]*vJ[Y,Z];
  if det<>0 then begin
  vJv[X,X]:= (vJ[y,y]*vJ[z,z] - vJ[y,z]*vJ[y,z])/det;
  vJv[X,Y]:= (vJ[z,z]*vJ[x,y] + vJ[y,z]*vJ[x,z])/det;
  vJv[X,Z]:= (vJ[x,y]*vJ[y,z] + vJ[y,y]*vJ[x,z])/det;
  vJv[Y,X]:= (vJ[x,y]*vJ[z,z] + vJ[x,z]*vJ[y,z])/det;
  vJv[Y,Y]:= (vJ[x,x]*vJ[z,z] - vJ[x,z]*vJ[x,z])/det;
  vJv[Y,Z]:= (vJ[x,x]*vJ[y,z] + vJ[x,y]*vJ[x,z])/det;
  vJv[Z,X]:= (vJ[x,y]*vJ[y,z] + vJ[y,y]*vJ[x,z])/det;
  vJv[Z,Y]:= (vJ[x,x]*vJ[y,z] + vJ[x,z]*vJ[x,y])/det;
  vJv[Z,Z]:= (vJ[x,x]*vJ[y,y] - vJ[x,y]*vJ[x,y])/det;
  Result:=true;
  end;
end;

procedure TParamsKADlg.CalculateMom(Omega, Mu, H: CoordExtended; var M: CoordExtended);
var i: Coord;
    Mb: CoordExtended;
begin
  Mb[x]:= -(Omega[y]*H[z]-Omega[z]*H[y])
          -vJ[y,z]*(sqr(Omega[z])-sqr(Omega[y]))
          -(vJ[z,z]-vJ[y,y])*Omega[y]*Omega[z]
          -vJ[x,y]*Omega[x]*Omega[z]
          +vJ[x,z]*Omega[y]*Omega[x]
          +Omega[z]*(SunBatDlg.vMp*(SunbatDlg.q1t[y].Get_(0)
          +SunbatDlg.q2t[y].Get_(0)+SunbatDlg.p1t[y].Get_(0)
          +SunbatDlg.p2t[y].Get_(0))+SunbatDlg.vJp
          *SunbatDlg.r1t[y].Get_(0))
          -Omega[y]*(SunBatDlg.vMp*(SunbatDlg.q1t[z].Get_(0)
          +SunbatDlg.q2t[z].Get_(0)+SunbatDlg.p1t[z].Get_(0)
          +SunbatDlg.p2t[z].Get_(0))+SunbatDlg.vJp
          *SunbatDlg.r1t[z].Get_(0))
          -SunBatDlg.vMp*(SunbatDlg.q1tt[x].Get_(0)
          +SunbatDlg.q2tt[x].Get_(0)+SunbatDlg.p1tt[x].Get_(0)
          +SunbatDlg.p2tt[x].Get_(0))-SunbatDlg.vJp
          *SunbatDlg.r1tt[x].Get_(0);
  Mb[y]:= -(Omega[z]*H[x]-Omega[x]*H[z])
          -vJ[x,z]*(sqr(Omega[x])-sqr(Omega[z]))
          -(vJ[x,x]-vJ[z,z])*Omega[x]*Omega[z]
          -vJ[y,z]*Omega[x]*Omega[y]
          +vJ[x,y]*Omega[y]*Omega[z]
          +Omega[x]*(SunBatDlg.vMp*(SunbatDlg.q1t[z].Get_(0)
          +SunbatDlg.q2t[z].Get_(0)+SunbatDlg.p1t[z].Get_(0)
          +SunbatDlg.p2t[z].Get_(0))+SunbatDlg.vJp
          *SunbatDlg.r1t[z].Get_(0))
          -Omega[z]*(SunBatDlg.vMp*(SunbatDlg.q1t[x].Get_(0)
          +SunbatDlg.q2t[x].Get_(0)+SunbatDlg.p1t[x].Get_(0)
          +SunbatDlg.p2t[x].Get_(0))+SunbatDlg.vJp
          *SunbatDlg.r1t[x].Get_(0))
          -SunBatDlg.vMp*(SunbatDlg.q1tt[y].Get_(0)
          +SunbatDlg.q2tt[y].Get_(0)+SunbatDlg.p1tt[y].Get_(0)
          +SunbatDlg.p2tt[y].Get_(0))-SunbatDlg.vJp
          *SunbatDlg.r1tt[y].Get_(0);
  Mb[z]:= -(Omega[x]*H[y]-Omega[y]*H[x])
          -vJ[x,y]*(sqr(Omega[y])-sqr(Omega[x]))
          -(vJ[y,y]-vJ[x,x])*Omega[y]*Omega[x]
          -vJ[x,z]*Omega[y]*Omega[z]
          +vJ[y,z]*Omega[x]*Omega[z]
          +Omega[y]*(SunBatDlg.vMp*(SunbatDlg.q1t[x].Get_(0)
          +SunbatDlg.q2t[x].Get_(0)+SunbatDlg.p1t[x].Get_(0)
          +SunbatDlg.p2t[x].Get_(0))+SunbatDlg.vJp
          *SunbatDlg.r1t[x].Get_(0))
          -Omega[x]*(SunBatDlg.vMp*(SunbatDlg.q1t[y].Get_(0)
          +SunbatDlg.q2t[y].Get_(0)+SunbatDlg.p1t[y].Get_(0)
          +SunbatDlg.p2t[y].Get_(0))+SunbatDlg.vJp
          *SunbatDlg.r1t[y].Get_(0))
          -SunBatDlg.vMp*(SunbatDlg.q1tt[z].Get_(0)
          +SunbatDlg.q2tt[z].Get_(0)+SunbatDlg.p1tt[z].Get_(0)
          +SunbatDlg.p2tt[z].Get_(0))-SunbatDlg.vJp
          *SunbatDlg.r1tt[z].Get_(0);
  CalculateVoz;
  for i:=x to z do begin

    M[i]:= Mb[i]+Mu[i]+VozMom[i];
  end;
end;

procedure TParamsKADlg.CalculateVoz;
var i: Coord;
    m,prom: CoordExtended;
begin
  prom:=M_V(vIM,MainForm.MPZ);
  for i:=x to z do prom[i]:=prom[i]+vMM[i];
  m[x]:=prom[y]*MainForm.MPZ[z]-prom[z]*MainForm.MPZ[y];
  m[y]:=prom[z]*MainForm.MPZ[x]-prom[x]*MainForm.MPZ[z];
  m[z]:=prom[x]*MainForm.MPZ[y]-prom[y]*MainForm.MPZ[x];

  For i:=x to z do begin
    VozMom[i]:=vM[i]
           +vA1[i]*sin(vF1[i]*MainForm.CurT+vSH1[i])
           +vA2[i]*sin(vF2[i]*MainForm.CurT+vSH2[i])
           +vUBMom[i]+vREDMom[i]+m[i];
    if (MainForm.CurT>=vGRSBegin)and(MainForm.CurT<(vGRSLength+vGrsBegin)) then
      VozMom[i]:=VozMom[i]+vGRSMom[i];
  end;
end;

procedure TParamsKADlg.CalculateSun( AngleFi: CoordTStek; var S: CoordExtended);
begin
  S[x]:=cos(AngleFi[y].Get_(0))*cos(AngleFi[z].Get_(0));
  S[y]:=-sin(AngleFi[z].Get_(0));
  S[z]:=sin(AngleFi[y].Get_(0))*cos(AngleFi[z].Get_(0));
end;

procedure TParamsKADlg.CalculateS( t: Extended; var Sx0: Extended;
     var Pt: Boolean);
var LambdaS,Sxn,Syn,Szn,U,C11,C21,C31: Extended;
begin
  LambdaS:=vLambdaS0+OmegaS*t;

  Sxn:=cos(LambdaS);
  Syn:=sin(LambdaS)*Cos(iiS);
  Szn:=Sin(LambdaS)*sin(iiS);

  U:=vU0+Omega0*t;

  C11:=cos(U)*cos(vLambda0)-sin(U)*sin(vLambda0)*cos(vi0);
  C21:=cos(U)*sin(vLambda0)-sin(U)*cos(vLambda0)*cos(vi0);
  C31:=sin(vLambda0)*sin(vi0);

  Sx0:=C11*Sxn+C21*Syn+C31*Szn;

  Pt:=(-Sx0>RoE);
end;

procedure TParamsKADlg.CalculateB( var AngleFi: CoordTStek;
                                   T: Extended;var B: CoordExtended);
var LambdaS,LambdaM,U: Extended;
    DT,AT,C,CT,BB,EE: MatrixExtended;
    vec: CoordExtended;
begin
  LambdaS:=vLambdaS0+OmegaS*t;

  DT[x,x]:=cos(LambdaS);
  DT[x,y]:=Sin(LambdaS)*Cos(iiS);
  DT[x,z]:=Sin(LambdaS)*Sin(iiS);
  DT[y,x]:=-Sin(LambdaS);
  DT[y,y]:=Cos(LambdaS)*Cos(iiS);
  DT[y,z]:=Cos(LambdaS)*Sin(iiS);
  DT[z,x]:=0;
  DT[z,y]:=-Sin(iiS);
  DT[z,z]:=cos(iiS);

  AT[x,x]:= cos(AngleFi[y].Get_(0))*cos(AngleFi[z].Get_(0));
  AT[x,y]:= Sin(AngleFi[y].Get_(0))*Sin(AngleFi[x].Get_(0))+
            cos(AngleFi[y].Get_(0))*cos(AngleFi[x].Get_(0))*
            Sin(AngleFi[z].Get_(0));
  AT[x,z]:= -sin(AngleFi[y].Get_(0))*cos(AngleFi[x].Get_(0))
            +cos(AngleFi[y].Get_(0))*sin(AngleFi[x].Get_(0))*
            sin(AngleFi[z].Get_(0));
  AT[y,x]:= -sin(AngleFi[z].Get_(0));
  AT[y,y]:= cos(AngleFi[y].Get_(0))*cos(AngleFi[z].Get_(0));
  AT[y,z]:= sin(AngleFi[y].Get_(0))*cos(AngleFi[z].Get_(0));
  AT[z,x]:= sin(AngleFi[y].Get_(0))*cos(AngleFi[z].Get_(0));
  AT[z,y]:= -cos(AngleFi[y].Get_(0))*sin(AngleFi[x].Get_(0))
            +sin(AngleFi[y].Get_(0))*cos(AngleFi[x].Get_(0))*
            sin(AngleFi[z].Get_(0));
  AT[z,z]:= cos(AngleFi[y].Get_(0))*cos(AngleFi[x].Get_(0))
            +sin(AngleFi[y].Get_(0))*sin(AngleFi[x].Get_(0))*
            sin(AngleFi[z].Get_(0));

  LambdaM:=vLambdaG0+AlfaM+OmegaEE*T;

  BB[x,x]:=cos(LambdaM);
  BB[x,y]:=-Sin(LambdaM)*Cos(GammaM);
  BB[x,z]:=Sin(LambdaM)*Sin(GammaM);
  BB[y,x]:=Sin(LambdaM);
  BB[y,y]:=Cos(LambdaM)*Cos(GammaM);
  BB[y,z]:=-Cos(LambdaM)*Sin(GammaM);
  BB[z,x]:=0;
  BB[z,y]:=Sin(GammaM);
  BB[z,z]:=cos(GammaM);

  U:=vU0+Omega0*t;

  C[x,x]:= cos(U)*cos(vLambda0)-
           sin(U)*sin(vLambda0)*cos(vi0);
  C[x,y]:= -sin(U)*cos(vLambda0)-
           cos(U)*sin(vLambda0)*cos(vi0);
  C[x,z]:= sin(vLambda0)*sin(vi0);
  C[y,x]:= cos(U)*sin(vLambda0)+
           sin(U)*cos(vLambda0)*cos(vi0);
  C[y,y]:= -sin(U)*sin(vLambda0)+
           cos(U)*cos(vLambda0)*cos(vi0);
  C[y,z]:= -cos(vLambda0)*sin(vi0);
  C[z,x]:= sin(U)*sin(vi0);
  C[z,y]:= cos(U)*sin(vi0);
  C[z,z]:= cos(vi0);

  CT[x,x]:= C[x,x];
  CT[x,y]:= C[y,x];
  CT[x,z]:= C[z,x];
  CT[y,x]:= C[x,y];
  CT[y,y]:= C[y,y];
  CT[y,z]:= C[z,y];
  CT[z,x]:= C[x,z];
  CT[z,y]:= C[y,z];
  CT[z,z]:= C[z,z];

  EE[x,x]:= -Bm;
  EE[x,y]:= 0;
  EE[x,z]:= 0;
  EE[y,x]:= 0;
  EE[y,y]:= -Bm;
  EE[y,z]:= 0;
  EE[z,x]:= 0;
  EE[z,y]:= 0;
  EE[z,z]:= 2*Bm;

  Vec[x]:=0;
  Vec[y]:=0;
  Vec[z]:=1;

  B:=M_V(M_M(M_M(M_M(M_M(M_M(AT,DT),C),EE),CT),BB),Vec);
end;

procedure TParamsKADlg.Calculate( Lrgs: Boolean; Mu, H: CoordExtended;
             var AngleFI,Omega,dOmega: CoordTStek);
var i: Coord;
    M, Om: CoordExtended;
begin
  SunBatDlg.Calculate(Omega);
  for i:=x to z do
  om[i]:=Omega[i].Get_(0);
  CalculateMom(Om,Mu,H,M);
  for i:=x to z do begin
    dOmega[i].Set_(vJv[i,x]*M[x]+vJv[i,y]*M[y]+vJv[i,z]*M[z]);
    Integral1(SystemParamsDlg.vmT0,dOmega[i],Omega[i]);
  end;
    {After this you must calculate OmegaE (2.1.14) integriruem
      and get AngleFi}
  if Lrgs then begin
    OmegaE[x].Set_( (Omega[x].Get_(0)*cos(AngleFi[y].Get_(0))+
                    Omega[z].Get_(0)*sin(AngleFi[y].Get_(0)))/
                    cos(AngleFi[z].Get_(0)));
    OmegaE[y].Set_( Omega[y].Get_(0)- OmegaE[x].Get_(0)*
                    sin(AngleFi[z].Get_(0)));
    OmegaE[z].Set_( Omega[z].Get_(0)*cos(AngleFi[y].Get_(0))-
                    Omega[x].Get_(0)*sin(AngleFi[y].Get_(0)));
    for i:=x to z do begin
      Integral1(SystemParamsDlg.vmT0,OmegaE[i],AngleFi[i]);
      if abs(AngleFi[i].Get_(0))>=Pi then
         AngleFi[i].Change_(-Sign(AngleFi[i].Get_(0))*(Abs(AngleFi[i].Get_(0))-Pi));
    end;
  end;
 end;

procedure TParamsKADlg.FormShow(Sender: TObject);
begin
  Jxx.Text:=FloatToStrF(vJ[x,x],ffFixed,9,8);
  Jxy.Text:=FloatToStrF(vJ[x,y],ffFixed,9,8);
  Jxz.Text:=FloatToStrF(vJ[x,z],ffFixed,9,8);
  Jyx.Text:=FloatToStrF(vJ[y,x],ffFixed,9,8);
  Jyy.Text:=FloatToStrF(vJ[y,y],ffFixed,9,8);
  Jyz.Text:=FloatToStrF(vJ[y,z],ffFixed,9,8);
  Jzx.Text:=FloatToStrF(vJ[z,x],ffFixed,9,8);
  Jzy.Text:=FloatToStrF(vJ[z,y],ffFixed,9,8);
  Jzz.Text:=FloatToStrF(vJ[z,z],ffFixed,9,8);
  IMxx.Text:=FloatToStrF(vIM[x,x],ffFixed,9,8);
  IMxy.Text:=FloatToStrF(vIM[x,y],ffFixed,9,8);
  IMxz.Text:=FloatToStrF(vIM[x,z],ffFixed,9,8);
  IMyx.Text:=FloatToStrF(vIM[y,x],ffFixed,9,8);
  IMyy.Text:=FloatToStrF(vIM[y,y],ffFixed,9,8);
  IMyz.Text:=FloatToStrF(vIM[y,z],ffFixed,9,8);
  IMzx.Text:=FloatToStrF(vIM[z,x],ffFixed,9,8);
  IMzy.Text:=FloatToStrF(vIM[z,y],ffFixed,9,8);
  IMzz.Text:=FloatToStrF(vIM[z,z],ffFixed,9,8);
  InitAngX.Text:=FloatToStrF(vInitAng[x],ffFixed,9,8);
  InitAngY.Text:=FloatToStrF(vInitAng[y],ffFixed,9,8);
  InitAngZ.Text:=FloatToStrF(vInitAng[z],ffFixed,9,8);
  InitSpeedX.Text:=FloatToStrF(vInitSpeed[x],ffFixed,9,8);
  InitSpeedY.Text:=FloatToStrF(vInitSpeed[y],ffFixed,9,8);
  InitSpeedZ.Text:=FloatToStrF(vInitSpeed[z],ffFixed,9,8);
  LambdaS0.Text:=FloatToStr(vLambdaS0);
  LambdaG0.Text:=FloatToStr(vLambdaG0);
  Lambda0.Text:=FloatToStr(vLambda0);
  i0.Text:=FloatToStr(vi0);
  H0.Text:=FloatToStr(vH0);
  U0.Text:=FloatToStr(vU0);
  Mx.Text:=FloatToStr(vM[x]);
  My.Text:=FloatToStr(vM[y]);
  Mz.Text:=FloatToStr(vM[z]);
  A1x.Text:=FloatToStr(vA1[x]);
  A1y.Text:=FloatToStr(vA1[y]);
  A1z.Text:=FloatToStr(vA1[z]);
  A2x.Text:=FloatToStr(vA2[x]);
  A2y.Text:=FloatToStr(vA2[y]);
  A2z.Text:=FloatToStr(vA2[z]);
  F1x.Text:=FloatToStr(vF1[x]);
  F1y.Text:=FloatToStr(vF1[y]);
  F1z.Text:=FloatToStr(vF1[z]);
  F2x.Text:=FloatToStr(vF2[x]);
  F2y.Text:=FloatToStr(vF2[y]);
  F2z.Text:=FloatToStr(vF2[z]);
  SH1x.Text:=FloatToStr(vSH1[x]);
  SH1y.Text:=FloatToStr(vSH1[y]);
  SH1z.Text:=FloatToStr(vSH1[z]);
  SH2x.Text:=FloatToStr(vSH2[x]);
  SH2y.Text:=FloatToStr(vSH2[y]);
  SH2z.Text:=FloatToStr(vSH2[z]);
  MMx.Text:=FloatToStr(vMM[x]);
  MMy.Text:=FloatToStr(vMM[y]);
  MMz.Text:=FloatToStr(vMM[z]);
  GRSMomx.Text:=FloatToStr(vGRSMom[x]);
  GRSMomy.Text:=FloatToStr(vGRSMom[y]);
  GRSMomz.Text:=FloatToStr(vGRSMom[z]);
  UBMomx.Text:=FloatToStr(vUBMom[x]);
  UBMomy.Text:=FloatToStr(vUBMom[y]);
  UBMomz.Text:=FloatToStr(vUBMom[z]);
  REDMomx.Text:=FloatToStr(vREDMom[x]);
  REDMomy.Text:=FloatToStr(vREDMom[y]);
  REDMomz.Text:=FloatToStr(vREDMom[z]);
  GRSBegin.Text:=FloatToStr(vGRSBegin);
  GRSLength.Text:=FloatToStr(vGRSLength);
end;

procedure TParamsKADlg.FormDestroy(Sender: TObject);
var i: Coord;
begin
  for i:=x to z do
    OmegaE[i].Free;
end;

procedure TParamsKADlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

end.
