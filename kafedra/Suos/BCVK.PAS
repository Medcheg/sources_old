unit Bcvk;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, KzaCom, Dialogs, BFZ;

type
  TBCVKDlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label10: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label16: TLabel;
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
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label43: TLabel;
    Label45: TLabel;
    Label47: TLabel;
    Label49: TLabel;
    Label51: TLabel;
{RGS Parameters}
    TabCoord: TTabSet;
    CoordBook: TNotebook;
    OmegaPx: TEdit;
    TauX: TEdit;
    OmegaHx: TEdit;
    OmegaPy: TEdit;
    TauY: TEdit;
    OmegaHy: TEdit;
    OmegaPz: TEdit;
    TauZ: TEdit;
    OmegaHz: TEdit;
    {PSO Parameters}
    TabSet1: TTabSet;
    Notebook1: TNotebook;
    KOmegaZ: TEdit;
    Kz: TEdit;
    UOmegaMZ: TEdit;
    UThetaMZ: TEdit;
    SigmaOnZ: TEdit;
    SigmaOffZ: TEdit;
    ThetaH: TEdit;
    OmegaPrgZ: TEdit;
    KOmegaY: TEdit;
    Ky: TEdit;
    UOmegaMY: TEdit;
    UFiMY: TEdit;
    SigmaOnY: TEdit;
    SigmaOffY: TEdit;
    FiH: TEdit;
    OmegaPrgY: TEdit;
    KOmegaX: TEdit;
    UOmegaMX: TEdit;
    SigmaOnX: TEdit;
    SigmaOffX: TEdit;
    OmegaPrgX: TEdit;
    Panel5: TPanel;
    TimeEdit: TEdit;
    Label7: TLabel;
    GroupBox3: TGroupBox;
    Bevel7: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Label8: TLabel;
    Label55: TLabel;
    Label58: TLabel;
    Panel6: TPanel;
    TabSet2: TTabSet;
    Notebook2: TNotebook;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label69: TLabel;
    pKOmegaX: TEdit;
    pUOmegaMX: TEdit;
    QnrsX: TEdit;
    QfrsX: TEdit;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    pKOmegaY: TEdit;
    pKY: TEdit;
    pUOmegaMY: TEdit;
    pUAngleMY: TEdit;
    QnrsY: TEdit;
    QfrsY: TEdit;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    pKOmegaZ: TEdit;
    pKZ: TEdit;
    pUOmegaMZ: TEdit;
    pUAngleMZ: TEdit;
    QnrsZ: TEdit;
    QfrsZ: TEdit;
    Panel8: TPanel;
    Label61: TLabel;
    Label67: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label68: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label82: TLabel;
    GroupBox4: TGroupBox;
    Bevel8: TBevel;
    Bevel14: TBevel;
    Label83: TLabel;
    Panel7: TPanel;
    TabSet3: TTabSet;
    Notebook3: TNotebook;
    GRSonX: TEdit;
    GRSoffX: TEdit;
    GRSonY: TEdit;
    GRSoffY: TEdit;
    Label114: TLabel;
    Label115: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    GRSonZ: TEdit;
    GRSoffZ: TEdit;
    Panel9: TPanel;
    Label84: TLabel;
    Label85: TLabel;
    Label92: TLabel;
    Label99: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label93: TLabel;
    Label98: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label9: TLabel;
    GroupBox5: TGroupBox;
    Bevel9: TBevel;
    Bevel13: TBevel;
    Label108: TLabel;
    Panel10: TPanel;
    TabSet4: TTabSet;
    Notebook4: TNotebook;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    HMOnX: TEdit;
    HMOffX: TEdit;
    Label113: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label120: TLabel;
    HMOnY: TEdit;
    HMOffY: TEdit;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    HMOnZ: TEdit;
    HMOffZ: TEdit;
    Panel11: TPanel;
    Label125: TLabel;
    Label126: TLabel;
    Bevel15: TBevel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    BOnX: TEdit;
    BOffX: TEdit;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    BOnY: TEdit;
    BOffY: TEdit;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    BOnZ: TEdit;
    BOffZ: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure TabSet1Click(Sender: TObject);
    procedure TabSet2Click(Sender: TObject);
    procedure TabSet3Click(Sender: TObject);
    procedure TabSet4Click(Sender: TObject);
    procedure TabCoordClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure TauZChange(Sender: TObject);
    procedure TauYChange(Sender: TObject);
    procedure TauXChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function Save(F: LongInt): boolean;
    function Open(F: LongInt): boolean;
    procedure RGS(
    {Input parameters}
    N_GIVUS:CoordInteger;{Impulses from GIVUS}
    {Output parameters}
    var Up: CoordExtended;{Control signals}
    var L_rgs: Boolean);{Flag of RGS finish}
    procedure PSO(
    {Input parameters}
    N_GIVUS:CoordInteger;{Impulses from GIVUS}
    N1_POS:LongInt;{Impulses from POS}
    N2_POS:LongInt;{Impulses from POS}
    flgPRESENT_SUN: Boolean;{Flag of Sun presents from POS}
    {Output parameters}
    var Up: CoordExtended;{Control signals}
    var L_pso: Boolean);
    procedure RelaxGRS(
    {Input parameters}
    N_EMIO:CoordInteger;{Impulses from EMIO}
    {Output parameters}
    var Up: CoordExtended);{Control signals}
    procedure RelaxM(
    {Input parameters}
    N_EMIO,N_BFZ:CoordInteger;{Impulses from EMIO}
    {Output parameters}
    var Up: CoordExtended);{Control signals}
    procedure PPSO( N_GIVUS:CoordInteger;
               N1_POS:longInt;
               N2_POS:longInt;
               flgPRESENT_SUN, L_pso: Boolean;
           var Up: CoordExtended);
    procedure FormDestroy(Sender: TObject);{Flag of POS finish}
  private
    { Private declarations }
  public
    AngleIS : CoordExtended;
{RGS Parameters}
    vOmegaP : CoordExtended;
    vTau    : CoordExtended;
    vOmegaH : CoordExtended;
    CurTau  : Extended;
{PSO Parameters}
    vKOmega   : CoordExtended;
    vUOmegaM  : CoordExtended;
    vSigmaOn  : CoordExtended;
    vSigmaOff : CoordExtended;
    vOmegaPrg : CoordExtended;
    vK        : CoordExtended;
    vUAngleM  : CoordExtended;
    vAngleH   : CoordExtended;
    UpPSO     : CoordTStek;
    vTime : Extended;
    TT: Extended;
    {PPSO parameters}
    Pred_L_pso, Pred_flgPRESENT_SUN: Boolean;
    Sr: CoordTStek;
    vQfrs,vQnrs: CoordExtended;
    vpKOmega   : CoordExtended;
    vpUOmegaM  : CoordExtended;
    vpK        : CoordExtended;
    vpUAngleM  : CoordExtended;
    {Relax on GRS}
    vGRSon: CoordExtended;
    vGRSoff: CoordExtended;
    UpO     : CoordTStek;
    {Relax on MPZ}
    vHMOn: CoordExtended;
    vHMOff: CoordExtended;
    vBOn: CoordExtended;
    vBOff: CoordExtended;
    UpM     : CoordTStek;
  end;

var
  BCVKDlg: TBCVKDlg;

implementation

uses SysUtils, SParams, Givus, POS, EMIO;

{$R *.DFM}

function TBCVKDlg.Save(F: LongInt): boolean;
begin
  FileWrite(F,vOmegaP,SizeOf(CoordExtended));
  FileWrite(F,vOmegaH,SizeOf(CoordExtended));
  FileWrite(F,vTau,SizeOf(CoordExtended));
  FileWrite(F,vKOmega,SizeOf(CoordExtended));
  FileWrite(F,vUOmegaM,SizeOf(CoordExtended));
  FileWrite(F,vSigmaOn,SizeOf(CoordExtended));
  FileWrite(F,vSigmaOff,SizeOf(CoordExtended));
  FileWrite(F,vOmegaPrg,SizeOf(CoordExtended));
  FileWrite(F,vK,SizeOf(CoordExtended));
  FileWrite(F,vUAngleM,SizeOf(CoordExtended));
  FileWrite(F,vAngleH,SizeOf(CoordExtended));
  FileWrite(F,vTime,SizeOf(Extended));

  FileWrite(F,vpKOmega,SizeOf(CoordExtended));
  FileWrite(F,vpUOmegaM,SizeOf(CoordExtended));
  FileWrite(F,vpK,SizeOf(CoordExtended));
  FileWrite(F,vpUAngleM,SizeOf(CoordExtended));
  FileWrite(F,vQnrs,SizeOf(CoordExtended));
  FileWrite(F,vQfrs,SizeOf(CoordExtended));

  FileWrite(F,vGRSOn,SizeOf(CoordExtended));
  FileWrite(F,vGRSOff,SizeOf(CoordExtended));

  FileWrite(F,vHMOn,SizeOf(CoordExtended));
  FileWrite(F,vHMOff,SizeOf(CoordExtended));
  FileWrite(F,vBOn,SizeOf(CoordExtended));
  FileWrite(F,vBOff,SizeOf(CoordExtended));

  Result:=True;
end;

function TBCVKDlg.Open(F: LongInt): boolean;
begin
  FileRead(F,vOmegaP,SizeOf(CoordExtended));
  FileRead(F,vOmegaH,SizeOf(CoordExtended));
  FileRead(F,vTau,SizeOf(CoordExtended));
  FileRead(F,vKOmega,SizeOf(CoordExtended));
  FileRead(F,vUOmegaM,SizeOf(CoordExtended));
  FileRead(F,vSigmaOn,SizeOf(CoordExtended));
  FileRead(F,vSigmaOff,SizeOf(CoordExtended));
  FileRead(F,vOmegaPrg,SizeOf(CoordExtended));
  FileRead(F,vK,SizeOf(CoordExtended));
  FileRead(F,vUAngleM,SizeOf(CoordExtended));
  FileRead(F,vAngleH,SizeOf(CoordExtended));
  FileRead(F,vTime,SizeOf(Extended));
  FileRead(F,vpKOmega,SizeOf(CoordExtended));
  FileRead(F,vpUOmegaM,SizeOf(CoordExtended));
  FileRead(F,vpK,SizeOf(CoordExtended));
  FileRead(F,vpUAngleM,SizeOf(CoordExtended));
  FileRead(F,vQnrs,SizeOf(CoordExtended));
  FileRead(F,vQfrs,SizeOf(CoordExtended));
  FileRead(F,vGRSOn,SizeOf(CoordExtended));
  FileRead(F,vGRSOff,SizeOf(CoordExtended));
  FileRead(F,vHMOn,SizeOf(CoordExtended));
  FileRead(F,vHMOff,SizeOf(CoordExtended));
  FileRead(F,vBOn,SizeOf(CoordExtended));
  FileRead(F,vBOff,SizeOf(CoordExtended));
  Result:=True;
end;

procedure TBCVKDlg.FormCreate(Sender: TObject);
var i: Coord;
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
  TabCoord.Tabs := CoordBook.Pages;
  TabSet1.Tabs := Notebook1.Pages;
  TabSet2.Tabs := Notebook2.Pages;
  TabSet3.Tabs := Notebook3.Pages;
  TabSet4.Tabs := Notebook4.Pages;
  for i:=x to z do begin
    UpO[i]:=TStek.Create;
    UpM[i]:=TStek.Create;
    UpPSO[i]:=TStek.Create;
    Sr[i]:=TStek.Create;
  end;
end;

procedure TBCVKDlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TBCVKDlg.TabSet1Click(Sender: TObject);
begin
  Notebook1.PageIndex := TabSet1.TabIndex;
end;

procedure TBCVKDlg.TabSet2Click(Sender: TObject);
begin
  Notebook2.PageIndex := TabSet2.TabIndex;
end;

procedure TBCVKDlg.TabSet3Click(Sender: TObject);
begin
  Notebook3.PageIndex := TabSet3.TabIndex;
end;

procedure TBCVKDlg.TabSet4Click(Sender: TObject);
begin
  Notebook4.PageIndex := TabSet4.TabIndex;
end;

procedure TBCVKDlg.TabCoordClick(Sender: TObject);
begin
  Coordbook.PageIndex := TabCoord.TabIndex;
end;

procedure TBCVKDlg.OKBtnClick(Sender: TObject);
const AA='Время проверки выполнения режима РГС меньше такта дискретизации!';
begin
  vTau[x]:=StrToFloat(TauX.Text);
  vTau[y]:=StrToFloat(Tauy.Text);
  vTau[z]:=StrToFloat(Tauz.Text);
  if vTau[x]<SYstemParamsDlg.vmT0
  then MessageDlg(AA,mtError,mbOKCancel,0)
  else begin
    vOmegaP[x]:=StrToFloat(OmegaPX.Text);
    vOmegaP[y]:=StrToFloat(OmegaPY.Text);
    vOmegaP[z]:=StrToFloat(OmegaPZ.Text);
    vOmegaH[x]:=StrToFloat(OmegaHX.Text);
    vOmegaH[y]:=StrToFloat(OmegaHY.Text);
    vOmegaH[z]:=StrToFloat(OmegaHZ.Text);
    vKOmega[x]:=StrToFloat(KOmegaX.Text);
    vKOmega[y]:=StrToFloat(KOmegaY.Text);
    vKOmega[z]:=StrToFloat(KOmegaZ.Text);
    vUOmegaM[x]:=StrToFloat(UOmegaMX.Text);
    vUOmegaM[y]:=StrToFloat(UOmegaMY.Text);
    vUOmegaM[z]:=StrToFloat(UOmegaMZ.Text);
    vOmegaPrg[x]:=StrToFloat(OmegaPrgX.Text);
    vOmegaPrg[y]:=StrToFloat(OmegaPrgY.Text);
    vOmegaPrg[z]:=StrToFloat(OmegaPrgZ.Text);
    vSigmaOn[x]:=StrToFloat(SigmaOnX.Text);
    vSigmaOn[y]:=StrToFloat(SigmaOnY.Text);
    vSigmaOn[z]:=StrToFloat(SigmaOnZ.Text);
    vSigmaOff[x]:=StrToFloat(SigmaOffX.Text);
    vSigmaOff[y]:=StrToFloat(SigmaOffY.Text);
    vSigmaOff[z]:=StrToFloat(SigmaOffZ.Text);
    vK[x]:=0;
    vK[y]:=StrToFloat(Ky.Text);
    vK[z]:=StrToFloat(Kz.Text);
    vUAngleM[x]:=0;
    vUAngleM[y]:=StrToFloat(UFiMY.Text);
    vUAngleM[z]:=StrToFloat(UThetaMZ.Text);
    vAngleH[x]:=0;
    vAngleH[y]:=StrToFloat(FiH.Text);
    vAngleH[z]:=StrToFloat(ThetaH.Text);
    vTime:=StrToFloat(TimeEdit.Text);
    vpKOmega[x]:=StrToFloat(pKOmegaX.Text);
    vpKOmega[y]:=StrToFloat(pKOmegaY.Text);
    vpKOmega[z]:=StrToFloat(pKOmegaZ.Text);
    vpUOmegaM[x]:=StrToFloat(pUOmegaMX.Text);
    vpUOmegaM[y]:=StrToFloat(pUOmegaMY.Text);
    vpUOmegaM[z]:=StrToFloat(pUOmegaMZ.Text);
    vpK[x]:=0;
    vpK[y]:=StrToFloat(pKy.Text);
    vpK[z]:=StrToFloat(pKz.Text);
    vpUAngleM[x]:=0;
    vpUAngleM[y]:=StrToFloat(pUAngleMY.Text);
    vpUAngleM[z]:=StrToFloat(pUAngleMZ.Text);
    vQnrs[x]:=StrToFloat(QnrsX.Text);
    vQnrs[y]:=StrToFloat(QnrsY.Text);
    vQnrs[z]:=StrToFloat(QnrsZ.Text);
    vQfrs[x]:=StrToFloat(QfrsX.Text);
    vQfrs[y]:=StrToFloat(QfrsY.Text);
    vQfrs[z]:=StrToFloat(QfrsZ.Text);
    vGRSOn[x]:=StrToFloat(GRSOnX.Text);
    vGRSOn[y]:=StrToFloat(GRSOnY.Text);
    vGRSOn[z]:=StrToFloat(GRSOnZ.Text);
    vGRSOff[x]:=StrToFloat(GRSOffX.Text);
    vGRSOff[y]:=StrToFloat(GRSOffY.Text);
    vGRSOff[z]:=StrToFloat(GRSOffZ.Text);
    vHMOn[x]:=StrToFloat(HMOnX.Text);
    vHMOn[y]:=StrToFloat(HMOnY.Text);
    vHMOn[z]:=StrToFloat(HMOnZ.Text);
    vHMOff[x]:=StrToFloat(HMOffX.Text);
    vHMOff[y]:=StrToFloat(HMOffY.Text);
    vHMOff[z]:=StrToFloat(HMOffZ.Text);
    vBOn[x]:=StrToFloat(BOnX.Text);
    vBOn[y]:=StrToFloat(BOnY.Text);
    vBOn[z]:=StrToFloat(BOnZ.Text);
    vBOff[x]:=StrToFloat(BOffX.Text);
    vBOff[y]:=StrToFloat(BOffY.Text);
    vBOff[z]:=StrToFloat(BOffZ.Text);
    Hide;
  end;
end;

procedure TBCVKDlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TBCVKDlg.TauZChange(Sender: TObject);
begin
  TauX.Text:=TauZ.Text;
  TauY.Text:=TauZ.Text;
end;

procedure TBCVKDlg.TauYChange(Sender: TObject);
begin
  TauX.Text:=TauY.Text;
  TauZ.Text:=TauY.Text;
end;

procedure TBCVKDlg.TauXChange(Sender: TObject);
begin
  TauY.Text:=TauX.Text;
  TauZ.Text:=TauX.Text;
end;

procedure TBCVKDlg.FormShow(Sender: TObject);
begin
  OmegaPx.Text:=FloatToStrF(vOmegaP[x],ffFixed,9,8);
  OmegaPy.Text:=FloatToStrF(vOmegaP[y],ffFixed,9,8);
  OmegaPz.Text:=FloatToStrF(vOmegaP[z],ffFixed,9,8);
  OmegaHx.Text:=FloatToStrF(vOmegaH[x],ffFixed,9,8);
  OmegaHy.Text:=FloatToStrF(vOmegaH[y],ffFixed,9,8);
  OmegaHz.Text:=FloatToStrF(vOmegaH[z],ffFixed,9,8);
  Taux.Text:=FloatToStrF(vTau[x],ffFixed,9,8);
  Tauy.Text:=FloatToStrF(vTau[y],ffFixed,9,8);
  Tauz.Text:=FloatToStrF(vTau[z],ffFixed,9,8);
  KOmegaX.Text:=FloatToStrF(vKOmega[x],ffFixed,9,8);
  KOmegaY.Text:=FloatToStrF(vKOmega[y],ffFixed,9,8);
  KOmegaZ.Text:=FloatToStrF(vKOmega[z],ffFixed,9,8);
  UOmegaMX.Text:=FloatToStrF(vUOmegaM[x],ffFixed,9,8);
  UOmegaMY.Text:=FloatToStrF(vUOmegaM[y],ffFixed,9,8);
  UOmegaMZ.Text:=FloatToStrF(vUOmegaM[z],ffFixed,9,8);
  OmegaPrgX.Text:=FloatToStrF(vOmegaPrg[x],ffFixed,9,8);
  OmegaPrgY.Text:=FloatToStrF(vOmegaPrg[y],ffFixed,9,8);
  OmegaPrgZ.Text:=FloatToStrF(vOmegaPrg[z],ffFixed,9,8);
  SigmaOnX.Text:=FloatToStrF(vSigmaOn[x],ffFixed,9,8);
  SigmaOnY.Text:=FloatToStrF(vSigmaOn[y],ffFixed,9,8);
  SigmaOnZ.Text:=FloatToStrF(vSigmaOn[z],ffFixed,9,8);
  SigmaOffX.Text:=FloatToStrF(vSigmaOff[x],ffFixed,9,8);
  SigmaOffY.Text:=FloatToStrF(vSigmaOff[y],ffFixed,9,8);
  SigmaOffZ.Text:=FloatToStrF(vSigmaOff[z],ffFixed,9,8);
  Ky.Text:=FloatToStrF(vK[y],ffFixed,9,8);
  Kz.Text:=FloatToStrF(vK[z],ffFixed,9,8);
  UFiMY.Text:=FloatToStrF(vUAngleM[y],ffFixed,9,8);
  UThetaMZ.Text:=FloatToStrF(vUAngleM[z],ffFixed,9,8);
  FiH.Text:=FloatToStrF(vAngleH[y],ffFixed,9,8);
  ThetaH.Text:=FloatToStrF(vAngleH[z],ffFixed,9,8);
  TimeEdit.Text:=FloatToStr(vTime);
  pKOmegaX.Text:=FloatToStrF(vpKOmega[x],ffFixed,9,8);
  pKOmegaY.Text:=FloatToStrF(vpKOmega[y],ffFixed,9,8);
  pKOmegaZ.Text:=FloatToStrF(vpKOmega[z],ffFixed,9,8);
  pUOmegaMX.Text:=FloatToStrF(vpUOmegaM[x],ffFixed,9,8);
  pUOmegaMY.Text:=FloatToStrF(vpUOmegaM[y],ffFixed,9,8);
  pUOmegaMZ.Text:=FloatToStrF(vpUOmegaM[z],ffFixed,9,8);
  pKy.Text:=FloatToStrF(vpK[y],ffFixed,9,8);
  pKz.Text:=FloatToStrF(vpK[z],ffFixed,9,8);
  pUAngleMY.Text:=FloatToStrF(vpUAngleM[y],ffFixed,9,8);
  pUAngleMZ.Text:=FloatToStrF(vpUAngleM[z],ffFixed,9,8);
  QnrsX.Text:=FloatToStrF(vQnrs[x],ffFixed,9,8);
  QnrsY.Text:=FloatToStrF(vQnrs[y],ffFixed,9,8);
  QnrsZ.Text:=FloatToStrF(vQnrs[z],ffFixed,9,8);
  QfrsX.Text:=FloatToStrF(vQfrs[x],ffFixed,9,8);
  QfrsY.Text:=FloatToStrF(vQfrs[y],ffFixed,9,8);
  QfrsZ.Text:=FloatToStrF(vQfrs[z],ffFixed,9,8);
  GRSOnX.Text:=FloatToStrF(vGRSOn[x],ffFixed,9,8);
  GRSOnY.Text:=FloatToStrF(vGRSOn[y],ffFixed,9,8);
  GRSOnZ.Text:=FloatToStrF(vGRSOn[z],ffFixed,9,8);
  GRSOffX.Text:=FloatToStrF(vGRSOff[x],ffFixed,9,8);
  GRSOffY.Text:=FloatToStrF(vGRSOff[y],ffFixed,9,8);
  GRSOffZ.Text:=FloatToStrF(vGRSOff[z],ffFixed,9,8);

  HMOnX.Text:=FloatToStrF(vHMOn[x],ffFixed,9,8);
  HMOnY.Text:=FloatToStrF(vHMOn[y],ffFixed,9,8);
  HMOnZ.Text:=FloatToStrF(vHMOn[z],ffFixed,9,8);
  HMOffX.Text:=FloatToStrF(vHMOff[x],ffFixed,9,8);
  HMOffY.Text:=FloatToStrF(vHMOff[y],ffFixed,9,8);
  HMOffZ.Text:=FloatToStrF(vHMOff[z],ffFixed,9,8);
  BOnX.Text:=FloatToStrF(vBOn[x],ffFixed,9,8);
  BOnY.Text:=FloatToStrF(vBOn[y],ffFixed,9,8);
  BOnZ.Text:=FloatToStrF(vBOn[z],ffFixed,9,8);
  BOffX.Text:=FloatToStrF(vBOff[x],ffFixed,9,8);
  BOffY.Text:=FloatToStrF(vBOff[y],ffFixed,9,8);
  BOffZ.Text:=FloatToStrF(vBOff[z],ffFixed,9,8);
end;

procedure TBCVKDlg.RelaxM( N_EMIO,N_BFZ:CoordInteger;
              var Up: CoordExtended);
var i: Coord;
    UProm: CoordExtended;
    Qz,Qr: CoordExtended;
begin
  for i:=x to z do begin
    UProm[i]:=N_EMIO[i]*EMIODlg.vDeltaHd[i];
    if abs(UProm[i])>=vHMOn[i] then
       UpM[i].Set_(-Sign(UProm[i]));
    if abs(UProm[i])<=vHMOff[i] then
       UpM[i].Set_(0);
    UProm[i]:=N_BFZ[i]*BFZDlg.vDeltaUd[i];
    if abs(UProm[i])>vBon[i] then
       Qr[i]:=Sign(UProm[i])
       else Qr[i]:=0;
    if abs(UProm[i])<=vBOff[i] then
       Qz[i]:=1
       else Qz[i]:=0;
  end;
  Up[x]:= -UpM[y].Get_(0)*Qz[y]*Qr[z]+UpM[z].Get_(0)*Qz[z]*Qr[y];
  Up[y]:= UpM[x].Get_(0)*Qz[x]*Qr[z]-UpM[z].Get_(0)*Qz[z]*Qr[x];
  Up[z]:= -UpM[x].Get_(0)*Qz[x]*Qr[y]+UpM[y].Get_(0)*Qz[y]*Qr[x];
end;

procedure TBCVKDlg.RelaxGRS(N_EMIO:CoordInteger;
                            var Up: CoordExtended);
var i: Coord;
    UProm: CoordExtended;
begin
  for i:=x to z do begin
    UProm[i]:=N_EMIO[i]*EMIODlg.vDeltaHd[i];
    if abs(UProm[i])>=vGRSon[i] then
       UpO[i].Set_(-Sign(UProm[i]));
    if abs(UProm[i])<=vGRSOff[i] then
       UpO[i].Set_(0);
    Up[i]:=Trunc(UpO[i].Get_(0));
  end;
end;

procedure TBCVKDlg.RGS(N_GIVUS: CoordInteger;
          var Up: CoordExtended; var L_rgs: Boolean);
var i: Coord;
    OmegaU: CoordExtended;
begin
  L_rgs:=False;
  for i:=x to z do begin
    OmegaU[i]:=N_GIVUS[i]*GIVUSDlg.vC[i]/SystemParamsDlg.vmT0
    -vOmegaP[i];
    if abs(OmegaU[i])>=vOmegaH[i]
    then Up[i]:=-Sign(OmegaU[i])
    else Up[i]:=0;
  end;
  if (Up[x]=0) and (Up[y]=0) and (Up[z]=0)
  then begin
    if CurTau=0 then CurTau:=SystemParamsDlg.vmT0
    else if CurTau>vTau[x] then L_rgs:=True
         else CurTau:=CurTau+SystemParamsDlg.vmT0;
  end
  else begin
    CurTau:=0;
  end;
end;

procedure TBCVKDlg.PSO( N_GIVUS:CoordInteger;
               N1_POS:longInt;
               N2_POS:longInt;
               flgPRESENT_SUN: Boolean;
           var Up: CoordExtended;
           var L_pso: Boolean);
var i: Coord;
    OmegaU,UOm,UAngle,UProm: CoordExtended;
begin
  AngleIS[x]:=0;
  AngleIS[z]:=-( (N1_POS+N2_POS/2)*POSDlg.vDeltaAlfaD
               +POSDlg.vAlfa0);
  AngleIS[y]:= -(arctan(2*sin((N2_POS*POSDlg.vDeltaBettaD-
               POSDlg.vBetta0)/2)));
  L_pso:=(abs(AngleIS[y])<=vAngleH[y])and
         (abs(AngleIS[z])<=vAngleH[z])and flgPRESENT_SUN;
  if L_Pso then begin
     if tt<vTime then begin
       L_Pso:=False;
       tt:=tt+SystemParamsDlg.vmT0;
     end; end
  else tt:=0;
  pred_L_pso:=False;
  Pred_flgPRESENT_SUN:=flgPRESENT_SUN;
  for i:=x to z do begin
    if flgPRESENT_SUN then
      OmegaU[i]:=N_GIVUS[i]*GIVUSDlg.vC[i]/SystemParamsDlg.vmT0
    else OmegaU[i]:=N_GIVUS[i]*GIVUSDlg.vC[i]/SystemParamsDlg.vmT0
         -vOmegaPrg[i];
    UOm[i]:=vKOmega[i]*OmegaU[i];
    if abs(UOm[i])>=vUOmegaM[i]
      then Uom[i]:=vUOmegaM[i]*Sign(UOm[i]);
  end;
{    if flgPRESENT_SUN then
    UAngle[x]:=vK[y]*AngleIS[y]*sin(AngleIS[z])
    else UAngle[x]:=0;
    if flgPRESENT_SUN then
    UAngle[y]:=vK[y]*AngleIS[y]*cos(AngleIS[z])
    else UAngle[y]:=0;}
  for i:=x to z do begin
    if flgPRESENT_SUN then
    UAngle[i]:=vK[i]*AngleIS[i]
    else UAngle[i]:=0;
    if abs(UAngle[i])>=vUAngleM[i]
      then UAngle[i]:=vUAngleM[i]*Sign(UAngle[i]);
    UProm[i]:=Uom[i]+UAngle[i];
    if abs(UProm[i])>=vSigmaOn[i] then
       UpPSO[i].Set_(-Sign(UProm[i]));
    if abs(UProm[i])<=vSigmaOff[i] then
       UpPSO[i].Set_(0);
    Up[i]:=Trunc(UpPSO[i].Get_(0));
  end;
end;

procedure TBCVKDlg.PPSO( N_GIVUS:CoordInteger;
               N1_POS:longInt;
               N2_POS:longInt;
               flgPRESENT_SUN,L_pso: Boolean;
           var Up: CoordExtended);
var i: Coord;
    OmegaU,UOm,UAngle,Sn,Krs: CoordExtended;
begin
  AngleIS[x]:=0;
  AngleIS[z]:=-( (N1_POS+N2_POS/2)*POSDlg.vDeltaAlfaD
               +POSDlg.vAlfa0);
  AngleIS[y]:= -(arctan(2*sin((N2_POS*POSDlg.vDeltaBettaD-
               POSDlg.vBetta0)/2)));
  for i:=x to z do begin
    OmegaU[i]:=N_GIVUS[i]*GIVUSDlg.vC[i];
    UOm[i]:=vpKOmega[i]*OmegaU[i]/SystemParamsDlg.vmT0;
    if abs(UOm[i])>=vpUOmegaM[i]
      then Uom[i]:=vpUOmegaM[i]*Sign(UOm[i]);
    if ((not pred_flgPRESENT_SUN)and(flgPRESENT_SUN))
       or((not Pred_L_pso)and(L_pso)) then
       Krs[i]:=vQfrs[i]
    else if not flgPRESENT_SUN then
       Krs[i]:=0
    else Krs[i]:=vQnrs[i];
  end;
  Pred_L_pso:=L_pso;
  Pred_flgPRESENT_SUN:=flgPRESENT_SUN;

  Sn[x]:=cos(AngleIS[y])*cos(AngleIS[z]);
  Sn[y]:=-sin(AngleIS[z]);
  Sn[z]:=cos(AngleIS[z])*sin(AngleIS[y]);

  Sr[x].Set_( Sr[x].Get_(0)+Sr[y].Get_(0)*OmegaU[z]-
              Sr[z].Get_(0)*OmegaU[y]-Krs[x]*
              (Sr[x].Get_(0)-Sn[x]));
  Sr[y].Set_( Sr[y].Get_(0)-Sr[x].Get_(-1)*OmegaU[z]+
              Sr[z].Get_(0)*OmegaU[x]-Krs[y]*
              (Sr[y].Get_(0)-Sn[y]));
  Sr[z].Set_( Sr[z].Get_(0)+Sr[x].Get_(-1)*OmegaU[y]-
              Sr[y].Get_(-1)*OmegaU[x]-Krs[z]*
              (Sr[z].Get_(0)-Sn[z]));

  AngleIS[x]:=0;
  AngleIS[y]:=atan(Sr[z].Get_(0),Sr[x].Get_(0));
  AngleIS[z]:=-arcSin(Sr[y].Get_(0));

  for i:=x to z do begin
    UAngle[i]:=vpK[i]*AngleIS[i];
    if abs(UAngle[i])>=vpUAngleM[i]
      then UAngle[i]:=vpUAngleM[i]*Sign(UAngle[i]);
    Up[i]:=Uom[i]+UAngle[i];
  end;
end;

procedure TBCVKDlg.FormDestroy(Sender: TObject);
var i: Coord;
begin
  for i:=x to z do begin
    UpO[i].Free;
    UpM[i].Free;
    UpPSO[i].Free;
    Sr[i].Free;
  end;
end;

end.
