unit OFK;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, KzaCom, ModMove;

type
  TOFKDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OKBtn: TButton;
    CancelBtn: TButton;
    RadioGroup1: TRadioGroup;
    ChooseOFK: TRadioButton;
    ChooseFloating: TRadioButton;
    ChooseScalar: TRadioButton;

    UseOFK: TCheckBox;
    InitAnglePsi: TEdit;
    InitAngleFi: TEdit;
    InitAngleSpeedPsi: TEdit;
    InitAngleSpeedFi: TEdit;
    Tic: TEdit;
    BettaParam: TEdit;
    H11: TEdit;
    H12: TEdit;
    H21: TEdit;
    H22: TEdit;
    ChooseEliptic: TRadioButton;
    ChooseGarant: TRadioButton;
    Label5: TLabel;
    NoisePsi: TEdit;
    NoiseX: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    NoiseZ: TEdit;
    Bevel2: TBevel;
    procedure ChooseOFKClick(Sender: TObject);
    procedure ChooseFloatingClick(Sender: TObject);
    procedure ChooseScalarClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vInitAnglePsi,{X0[1]}
    vInitAngleFi,{X0[2]}
    vInitAngleSpeedPsi,{Wx}
    vInitAngleSpeedFi,{Wy}
    vTic,{Ti}
    vNoisePsi,
    vNoiseX,
    vNoiseZ,
    vBettaParam: Extended;{Betta2}
    vH: array [1..2,1..2] of Extended;{Hm}
    vEstAnglePsi,
    vEstAngleFi,
    vEstAngleSpeedPsi,
    vEstAngleSpeedFi: Extended;
    procedure Calculate(PMVAngle: Extended;
              NGIVUS: CoordInteger;
              var EstAngles: CoordExtended);
    procedure Init;
  end;

var
  OFKDlg: TOFKDlg;

implementation

{$R *.DFM}

uses Math;

procedure TOFKDlg.Init;
var i,j: integer;
begin
  {Инициализируем модуль ModMove}
    ModMove.X0[1]:=vInitAnglePsi;
    ModMove.X0[2]:=vInitAngleFi;
    ModMove.Wx:=vInitAngleSpeedPsi;
    ModMove.Wy:=vInitAngleSpeedFi;
    ModMove.Ti:=vTic;
    ModMove.Betta2:=vBettaParam;
    for i:=1 to 2 do
      for j:=1 to 2 do ModMove.Hm[i,j]:=vH[i,j];
end;

procedure TOFKDlg.Calculate(PMVAngle: Extended;
          NGIVUS: CoordInteger;
          var EstAngles: CoordExtended);
begin
  {Пересчет сигналов ГИВУСа}

  {Передача параметров движения}
    ModMove.X0[1]:=PMVAngle+vNoisePsi*RandG(0,1);
    ModMove.Wx:=vInitAngleSpeedPsi+vNoiseX*RandG(0,1);
    ModMove.Wy:=vInitAngleSpeedFi+vNoiseZ*RandG(0,1);
  {Обработка наблюдателей}
    if ChooseOFK.Checked then begin
      Modmove.OFK;
      modmove.xk0[1]:=modmove.Xk[1];
      modmove.xk0[2]:=modmove.Xk[2];
    end else if ChooseFloating.Checked then begin
      Modmove.RN;
      modmove.xk0[1]:=modmove.Xk[1];
      modmove.xk0[2]:=modmove.Xk[2];
    end else if ChooseScalar.Checked then begin
      Modmove.Scal;
      modmove.xk0[1]:=modmove.Xk[1];
      modmove.xk0[2]:=modmove.Xk[2];
    end else if ChooseEliptic.Checked then begin
      Modmove.Ellipse;
      modmove.xk0[1]:=modmove.Xk[1];
      modmove.xk0[2]:=modmove.Xk[2];
    end else if ChooseGarant.Checked then begin
      Modmove.Garant;
      modmove.xk0[1]:=modmove.Xk[1];
      modmove.xk0[2]:=modmove.Xk[2];
    end;

    EstAngles[x]:=modmove.Xk[1];
    EstAngles[z]:=modmove.Xk[2];
end;

procedure TOFKDlg.ChooseOFKClick(Sender: TObject);
begin
  Label7.Enabled:=False;
  Label8.Enabled:=False;
  BettaParam.Enabled:=False;
  H11.Enabled:=False;
  H21.Enabled:=False;
  H12.Enabled:=False;
  H22.Enabled:=False;
end;

procedure TOFKDlg.ChooseFloatingClick(Sender: TObject);
begin
  Label7.Enabled:=True;
  Label8.Enabled:=True;
  BettaParam.Enabled:=True;
  H11.Enabled:=True;
  H12.Enabled:=True;
  H21.Enabled:=True;
  H22.Enabled:=True;
end;

procedure TOFKDlg.ChooseScalarClick(Sender: TObject);
begin
  Label7.Enabled:=False;
  Label8.Enabled:=False;
  BettaParam.Enabled:=False;
  H11.Enabled:=False;
  H12.Enabled:=False;
  H21.Enabled:=False;
  H22.Enabled:=False;
end;

procedure TOFKDlg.OKBtnClick(Sender: TObject);
begin
  vInitAnglePsi:=StrToFloat(InitAnglePsi.Text);
  vInitAngleFi:=StrToFloat(InitAngleFi.Text);
  vInitAngleSpeedPsi:=StrToFloat(InitAngleSpeedPsi.Text);
  vInitAngleSpeedFi:=StrToFloat(InitAngleSpeedFi.Text);
  vTic:=StrToFloat(Tic.Text);
  vNoisePsi:=StrToFloat(NoisePsi.Text);
  vNoiseX:=StrToFloat(NoiseX.Text);
  vNoiseZ:=StrToFloat(NoiseZ.Text);
  vBettaParam:=StrToFloat(BettaParam.Text);
  vH[1,1]:=StrToFloat(H11.Text);
  vH[1,2]:=StrToFloat(H12.Text);
  vH[2,1]:=StrToFloat(H21.Text);
  vH[2,2]:=StrToFloat(H22.Text);
  close;
end;

procedure TOFKDlg.CancelBtnClick(Sender: TObject);
begin
  close;
end;

procedure TOFKDlg.FormShow(Sender: TObject);
begin
  InitAnglePsi.Text:=FloatToStrF(vInitAnglePsi,ffGeneral,8,10);
  InitAngleFi.Text:=FloatToStrF(vInitAngleFi,ffGeneral,8,10);
  InitAngleSpeedPsi.Text:=FloatToStrF(vInitAngleSpeedPsi,ffGeneral,8,10);
  InitAngleSpeedFi.Text:=FloatToStrF(vInitAngleSpeedFi,ffGeneral,8,10);
  Tic.Text:=FloatToStrF(vTic,ffGeneral,8,10);
  NoisePsi.Text:=FloatToStrF(vNoisePsi,ffGeneral,8,10);
  NoiseX.Text:=FloatToStrF(vNoiseX,ffGeneral,8,10);
  NoiseZ.Text:=FloatToStrF(vNoiseZ,ffGeneral,8,10);
  BettaParam.Text:=FloatToStrF(vBettaParam,ffGeneral,8,10);
  H11.Text:=FloatToStrF(vH[1,1],ffGeneral,8,10);
  H12.Text:=FloatToStrF(vH[1,2],ffGeneral,8,10);
  H21.Text:=FloatToStrF(vH[2,1],ffGeneral,8,10);
  H22.Text:=FloatToStrF(vH[2,2],ffGeneral,8,10);
end;

end.

