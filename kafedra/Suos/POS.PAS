unit Pos;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, Kzacom;

type
  TPOSDlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    AlfaTopPM: TEdit;
    AlfaBottomPM: TEdit;
    BettaTopPM: TEdit;
    BettaBottomPM: TEdit;
    DeltaAlfaD: TEdit;
    DeltaBettaD: TEdit;
    Alfa0: TEdit;
    Betta0: TEdit;
    DeltaAlfaSP: TEdit;
    DeltaBettaSP: TEdit;
    AlfaN: TEdit;
    BettaN: TEdit;
    DeltaFiSU: TEdit;
    DeltaAlfaSU: TEdit;
    DeltaBettaSU: TEdit;
    Tc: TEdit;
    TauS: TEdit;
    MaxNc1: TEdit;
    MaxNc2: TEdit;
    Label40: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    function Save(F: LongInt): boolean;
    function Open(F: LongInt): boolean;
    procedure Calculate(
    {INPUT PARAMETERS}
    {Proections of SunVector on LSC}
       S: CoordExtended;
    {Flag shadowed part of orbit}
       Pt,
    {Flags of mailfunctions chanels}
       Qca,Qcb: Boolean;
    {OUTPUT PARAMETERS}
    {Output amounts of impulses }
       var Nc1,Nc2: LongInt;
    {Flag of presenting Sun in Viewport}
       var Cns: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    vAlfaTopPM: Extended;
    vAlfaBottomPM: Extended;
    vBettaTopPM: Extended;
    vBettaBottomPM: Extended;
    vDeltaAlfaD: Extended;
    vDeltaBettaD: Extended;
    vAlfa0: Extended;
    vBetta0: Extended;
    vDeltaAlfaSP: Extended;
    vDeltaBettaSP: Extended;
    vAlfaN: Extended;
    vBettaN: Extended;
    vDeltaFiSU: Extended;
    vDeltaAlfaSU: Extended;
    vDeltaBettaSU: Extended;
    vTc: Extended;
    vTauS: Extended;
    vMaxNc1: longInt;
    vMaxNc2: longInt;
    _AlfaC: TStek;
    _BettaC: TStek;
    AlfaC,
    BettaC: Extended;
  end;

var
  POSDlg: TPOSDlg;

implementation

Uses SysUtils, SParams;

{$R *.DFM}

function TPOSDlg.Save(F: LongInt): boolean;
begin
    FileWrite(F, vAlfaTopPM, SizeOf(Extended));
    FileWrite(F, vAlfaBottomPM, SizeOf(Extended));
    FileWrite(F, vBettaTopPM, SizeOf(Extended));
    FileWrite(F, vBettaBottomPM, SizeOf(Extended));
    FileWrite(F, vDeltaAlfaD, SizeOf(Extended));
    FileWrite(F, vDeltaBettaD, SizeOf(Extended));
    FileWrite(F, vAlfa0, SizeOf(Extended));
    FileWrite(F, vBetta0, SizeOf(Extended));
    FileWrite(F, vDeltaAlfaSP, SizeOf(Extended));
    FileWrite(F, vDeltaBettaSP, SizeOf(Extended));
    FileWrite(F, vAlfaN, SizeOf(Extended));
    FileWrite(F, vBettaN, SizeOf(Extended));
    FileWrite(F, vDeltaFiSU, SizeOf(Extended));
    FileWrite(F, vDeltaAlfaSU, SizeOf(Extended));
    FileWrite(F, vDeltaBettaSU, SizeOf(Extended));
    FileWrite(F, vTc, SizeOf(Extended));
    FileWrite(F, vTauS, SizeOf(Extended));
    FileWrite(F, vMaxNc1, SizeOf(longInt));
    FileWrite(F, vMaxNc2, SizeOf(LongInt));
  Result:=True;
end;

function TPOSDlg.Open(F: LongInt): boolean;
begin
    FileRead(F, vAlfaTopPM, SizeOf(Extended));
    FileRead(F, vAlfaBottomPM, SizeOf(Extended));
    FileRead(F, vBettaTopPM, SizeOf(Extended));
    FileRead(F, vBettaBottomPM, SizeOf(Extended));
    FileRead(F, vDeltaAlfaD, SizeOf(Extended));
    FileRead(F, vDeltaBettaD, SizeOf(Extended));
    FileRead(F, vAlfa0, SizeOf(Extended));
    FileRead(F, vBetta0, SizeOf(Extended));
    FileRead(F, vDeltaAlfaSP, SizeOf(Extended));
    FileRead(F, vDeltaBettaSP, SizeOf(Extended));
    FileRead(F, vAlfaN, SizeOf(Extended));
    FileRead(F, vBettaN, SizeOf(Extended));
    FileRead(F, vDeltaFiSU, SizeOf(Extended));
    FileRead(F, vDeltaAlfaSU, SizeOf(Extended));
    FileRead(F, vDeltaBettaSU, SizeOf(Extended));
    FileRead(F, vTc, SizeOf(Extended));
    FileRead(F, vTauS, SizeOf(Extended));
    FileRead(F, vMaxNc1, SizeOf(longInt));
    FileRead(F, vMaxNc2, SizeOf(longInt));
  Result:=True;
end;

procedure TPOSDlg.FormCreate(Sender: TObject);
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
    vAlfaTopPM:=0;
    vAlfaBottomPM:=0;
    vBettaTopPM:=0;
    vBettaBottomPM:=0;
    vDeltaAlfaD:=0;
    vDeltaBettaD:=0;
    vAlfa0:=-270;
    vBetta0:=180;
    vDeltaAlfaSP:=0;
    vDeltaBettaSP:=0;
    vAlfaN:=0;
    vBettaN:=0;
    vDeltaFiSU:=0;
    vDeltaAlfaSU:=0;
    vDeltaBettaSU:=0;
    vTc:=0;
    vTauS:=0;
    vMaxNc1:=0;
    vMaxNc2:=0;
    _AlfaC:=TStek.Create;
    _BettaC:=TStek.Create;
end;

procedure TPOSDlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TPOSDlg.FormShow(Sender: TObject);
begin
  AlfaTopPM.Text:=FloatToStrF(vAlfaTopPM,ffFixed,9,8);
  AlfaBottomPM.Text:=FloatToStrF(vAlfaBottomPM,ffFixed,9,8);
  BettaTopPM.Text:=FloatToStrF(vBettaTopPM,ffFixed,9,8);
  BettaBottomPM.Text:=FloatToStrF(vBettaBottomPM,ffFixed,9,8);
  DeltaAlfaD.Text:=FloatToStrF(vDeltaAlfaD,ffFixed,9,8);
  DeltaBettaD.Text:=FloatToStrF(vDeltaBettaD,ffFixed,9,8);
  Alfa0.Text:=FloatToStrF(vAlfa0,ffFixed,9,8);
  Betta0.Text:=FloatToStrF(vBetta0,ffFixed,9,8);
  DeltaAlfaSP.Text:=FloatToStrF(vDeltaAlfaSP,ffFixed,9,8);
  DeltaBettaSP.Text:=FloatToStrF(vDeltaBettaSP,ffFixed,9,8);
  AlfaN.Text:=FloatToStrF(vAlfaN,ffFixed,9,8);
  BettaN.Text:=FloatToStrF(vBettaN,ffFixed,9,8);
  DeltaFiSU.Text:=FloatToStrF(vDeltaFiSU,ffFixed,9,8);
  DeltaAlfaSU.Text:=FloatToStrF(vDeltaAlfaSU,ffFixed,9,8);
  DeltaBettaSU.Text:=FloatToStrF(vDeltaBettaSU,ffFixed,9,8);
  Tc.Text:=FloatToStrF(vTc,ffFixed,9,8);
  TauS.Text:=FloatToStrF(vTauS,ffFixed,9,8);
  MaxNc1.Text:=IntToStr(vMaxNc1);
  MaxNc2.Text:=IntToStr(vMaxNc2);
end;

procedure TPOSDlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TPOSDlg.OKBtnClick(Sender: TObject);
begin
  vAlfaTopPM:=StrToFloat(AlfaTopPM.Text);
  vAlfaBottomPM:=StrToFloat(AlfaBottomPM.Text);
  vBettaTopPM:=StrToFloat(BettaTopPM.Text);
  vBettaBottomPM:=StrToFloat(BettaBottomPM.Text);
  vDeltaAlfaD:=StrToFloat(DeltaAlfaD.Text);
  vDeltaBettaD:=StrToFloat(DeltaBettaD.Text);
  vAlfa0:=StrToFloat(Alfa0.Text);
  vBetta0:=StrToFloat(Betta0.Text);
  vDeltaAlfaSP:=StrToFloat(DeltaAlfaSp.Text);
  vDeltaBettaSP:=StrToFloat(DeltaBettaSP.Text);
  vAlfaN:=StrToFloat(AlfaN.Text);
  vBettaN:=StrToFloat(BettaN.Text);
  vDeltaFiSU:=StrToFloat(DeltaFiSU.Text);
  vDeltaAlfaSU:=StrToFloat(DeltaAlfaSU.Text);
  vDeltaBettaSU:=StrToFloat(DeltaBettaSU.Text);
  vTc:=StrToFloat(Tc.Text);
  vTauS:=StrToFloat(TauS.Text);
  vMaxNc1:=StrToInt(MaxNc1.Text);
  vMaxNc2:=StrToInt(MaxNc2.Text);
  Hide;

end;

procedure TPOSDlg.Calculate(S: CoordExtended; Pt,Qca,Qcb: Boolean;
                     var Nc1,Nc2: longInt; var Cns: Boolean);

var Sxc,Syc,Szc,D: Extended;
begin
  if vTc=0 then D:=0 else
  D:=Exp(-SystemParamsDlg.vmT0/vTc);

  {Compute coordinates of SunVector}
  Sxc:=S[x]+S[y]*vDeltaAlfaSU-S[z]*vDeltaBettaSU;
  Syc:=-S[x]*vDeltaAlfaSU+S[y]+S[z]*vDeltaFiSU;
  Szc:=S[x]*vDeltaBettaSU-S[y]*vDeltaFiSU+S[z];

  AlfaC:=atan(Syc,Sxc);
  BettaC:=-ArcSin(Szc);

  Cns:= (vAlfaBottomPM < AlfaC) and (AlfaC < vAlfaTopPM) and
        (vBettaBottomPM < BettaC) and (BettaC < vBettaTopPM) and
         not Pt;

  If Cns then Begin
    BettaC:=2*ArcSin(Tan(BettaC/2));
    _AlfaC.Set_( D*_AlfaC.Get_(0)+(1-d)*AlfaC );
    _BettaC.Set_( D*_BettaC.Get_(0)+(1-d)*BettaC );
    If Qcb then Nc2:=Trunc( vBettaN/vDeltaBettaD )
           else Nc2:=Trunc( (_BettaC.Get_(0) + vBetta0 +
                   vDeltaBettaSP)/vDeltaBettaD );
    If Qca then Nc1:=Trunc( vAlfaN/vDeltaAlfaD )
           else Nc1:=Trunc( (_AlfaC.Get_(0) - vAlfa0 +
                   vDeltaAlfaSP)/vDeltaAlfaD ) - Trunc(Nc2/2);
  end Else begin
    _AlfaC.Clear;
    _BettaC.Clear;
    Nc1:=vMaxNc1;
    Nc2:=vMaxNc2;
  end

end;

procedure TPOSDlg.FormDestroy(Sender: TObject);
begin
    _AlfaC.Free;
    _BettaC.Free;
end;

end.
