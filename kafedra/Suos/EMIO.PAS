unit Emio;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, KzaCom;

type
  TEMIODlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Bevel6: TBevel;
    Bevel5: TBevel;
    Bevel4: TBevel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label21: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Label37: TLabel;
    TX: TEdit;
    TY: TEdit;
    TZ: TEdit;
    HmX: TEdit;
    HmY: TEdit;
    HmZ: TEdit;
    TauX: TEdit;
    TauY: TEdit;
    TauZ: TEdit;
    H0X: TEdit;
    H0Y: TEdit;
    H0Z: TEdit;
    KX: TEdit;
    KY: TEdit;
    KZ: TEdit;
    McoX: TEdit;
    McoY: TEdit;
    McoZ: TEdit;
    McmX: TEdit;
    McmY: TEdit;
    McmZ: TEdit;
    DeltaFiU: TEdit;
    DeltaNyuU: TEdit;
    DeltaPsiU: TEdit;
    MmX: TEdit;
    MmY: TEdit;
    MmZ: TEdit;
    TkX: TEdit;
    TkY: TEdit;
    TkZ: TEdit;
    DeltaHdX: TEdit;
    DeltaHdY: TEdit;
    DeltaHdZ: TEdit;
    DeltaHkX: TEdit;
    DeltaHkY: TEdit;
    DeltaHkZ: TEdit;
    MhX: TEdit;
    MhY: TEdit;
    MhZ: TEdit;
    HhX: TEdit;
    HhY: TEdit;
    HhZ: TEdit;
    DeltaUX: TEdit;
    DeltaUY: TEdit;
    DeltaUZ: TEdit;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function Save(Handle: LongInt): boolean;
    function Open(Handle: LongInt): boolean;
    procedure Calculate(
    {Input Parameters}
    Uu: CoordExtended;
    Qe,Qh: CoordBoolean;
    {Output Parameters}
    var Me, H: CoordExtended;
    var Nh: CoordInteger);
    procedure FormDestroy(Sender: TObject);
  public
    vT        : CoordExtended;
    vHm       : CoordExtended;
    vTau      : CoordExtended;
    vH0       : CoordExtended;
    vK        : CoordExtended;
    vMco      : CoordExtended;
    vMcm      : CoordExtended;
    vMm       : CoordExtended;
    vTk       : CoordExtended;
    vDeltaHd  : CoordExtended;
    vDeltaHk  : CoordExtended;
    vMh       : CoordExtended;
    vHh       : CoordExtended;
    vDeltaU   : CoordExtended;
    vDeltaFiU : Extended;
    vDeltaNyuU: Extended;
    vDeltaPsiU: Extended;
    MyuC: CoordExtended;
    Uem: CoordExtended;
    Mde: CoordTStek;
    Hk: CoordTStek;
    Mh: CoordTStek;
  public
    { Public declarations }
  end;

var
  EMIODlg: TEMIODlg;

implementation

uses SysUtils,SParams;
{$R *.DFM}

function TEMIODlg.Save(Handle: LongInt): boolean;
begin
    FileWrite(Handle, vT        ,SizeOf(CoordExtended));
    FileWrite(Handle, vHm       ,SizeOf(CoordExtended));
    FileWrite(Handle, vTau      ,SizeOf(CoordExtended));
    FileWrite(Handle, vH0       ,SizeOf(CoordExtended));
    FileWrite(Handle, vK        ,SizeOf(CoordExtended));
    FileWrite(Handle, vMco      ,SizeOf(CoordExtended));
    FileWrite(Handle, vMcm      ,SizeOf(CoordExtended));
    FileWrite(Handle, vMm       ,SizeOf(CoordExtended));
    FileWrite(Handle, vTk       ,SizeOf(CoordExtended));
    FileWrite(Handle, vDeltaHd  ,SizeOf(CoordExtended));
    FileWrite(Handle, vDeltaHk  ,SizeOf(CoordExtended));
    FileWrite(Handle, vMh       ,SizeOf(CoordExtended));
    FileWrite(Handle, vHh       ,SizeOf(CoordExtended));
    FileWrite(Handle, vDeltaU   ,SizeOf(CoordExtended));
    FileWrite(Handle, vDeltaFiU ,SizeOf(Extended));
    FileWrite(Handle, vDeltaNyuU,SizeOf(Extended));
    FileWrite(Handle, vDeltaPsiU,SizeOf(Extended));
    Result:=True;
end;

function TEMIODlg.Open(Handle: LongInt): boolean;
var i: Coord;
begin
    FileRead(Handle, vT        ,SizeOf(CoordExtended));
    FileRead(Handle, vHm       ,SizeOf(CoordExtended));
    FileRead(Handle, vTau      ,SizeOf(CoordExtended));
    FileRead(Handle, vH0       ,SizeOf(CoordExtended));
    FileRead(Handle, vK        ,SizeOf(CoordExtended));
    FileRead(Handle, vMco      ,SizeOf(CoordExtended));
    FileRead(Handle, vMcm      ,SizeOf(CoordExtended));
    FileRead(Handle, vMm       ,SizeOf(CoordExtended));
    FileRead(Handle, vTk       ,SizeOf(CoordExtended));
    FileRead(Handle, vDeltaHd  ,SizeOf(CoordExtended));
    FileRead(Handle, vDeltaHk  ,SizeOf(CoordExtended));
    FileRead(Handle, vMh       ,SizeOf(CoordExtended));
    FileRead(Handle, vHh       ,SizeOf(CoordExtended));
    FileRead(Handle, vDeltaU   ,SizeOf(CoordExtended));
    FileRead(Handle, vDeltaFiU ,SizeOf(Extended));
    FileRead(Handle, vDeltaNyuU,SizeOf(Extended));
    FileRead(Handle, vDeltaPsiU,SizeOf(Extended));
  For i:=x to z do begin
    MyuC[i]:=(vMcm[i]-vMco[i])/vHm[i];
    Uem[i]:=vMm[i]/vK[i];
  end;
    Result:=True;
end;

procedure TEMIODlg.FormCreate(Sender: TObject);
var i: Coord;
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
  For i:=X to Z do begin
    vT[i]        :=0;
    vHm[i]       :=0;
    vTau[i]      :=0;
    vH0[i]       :=0;
    vK[i]        :=0;
    vMco[i]      :=0;
    vMcm[i]      :=0;
    vMm[i]       :=0;
    vTk[i]       :=0;
    vDeltaHd[i]  :=0;
    vDeltaHk[i]  :=0;
    vMh[i]       :=0;
    vHh[i]       :=0;
    vDeltaU[i]   :=0;
  end;
  vDeltaFiU :=0;
  vDeltaNyuU:=0;
  vDeltaPsiU:=0;
  for i:=x to z do begin
      Mde[i]:=TStek.Create;
      Hk[i]:=TStek.Create;
      Mh[i]:=TStek.Create;
  end;
end;

procedure TEMIODlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TEMIODlg.OKBtnClick(Sender: TObject);
var i: Coord;
begin
  vDeltaFiU:=StrToFloat(DeltaFiU.Text);
  vDeltaPsiU:=StrToFloat(DeltaPsiU.Text);
  vDeltaNyuU:=StrToFloat(DeltaNyuU.Text);
  vDeltaU[X]:=StrToFloat(DeltaUX.Text);
  vDeltaU[Y]:=StrToFloat(DeltaUY.Text);
  vDeltaU[Z]:=StrToFloat(DeltaUZ.Text);
  vDeltaHd[X]:=StrToFloat(DeltaHdX.Text);
  vDeltaHd[Y]:=StrToFloat(DeltaHdY.Text);
  vDeltaHd[Z]:=StrToFloat(DeltaHdZ.Text);
  vDeltaHk[X]:=StrToFloat(DeltaHkX.Text);
  vDeltaHk[Y]:=StrToFloat(DeltaHkY.Text);
  vDeltaHk[Z]:=StrToFloat(DeltaHkZ.Text);
  vTau[X]:=StrToFloat(TauX.Text);
  vTau[Y]:=StrToFloat(TauY.Text);
  vTau[Z]:=StrToFloat(TauZ.Text);
  vT[X]:=StrToFloat(TX.Text);
  vT[Y]:=StrToFloat(TY.Text);
  vT[Z]:=StrToFloat(TZ.Text);
  vTk[X]:=StrToFloat(TkX.Text);
  vTk[Y]:=StrToFloat(TkY.Text);
  vTk[Z]:=StrToFloat(TkZ.Text);
  vK[X]:=StrToFloat(KX.Text);
  vK[Y]:=StrToFloat(KY.Text);
  vK[Z]:=StrToFloat(KZ.Text);
  vHm[X]:=StrToFloat(HmX.Text);
  vHm[Y]:=StrToFloat(HmY.Text);
  vHm[Z]:=StrToFloat(HmZ.Text);
  vH0[X]:=StrToFloat(H0X.Text);
  vH0[Y]:=StrToFloat(H0Y.Text);
  vH0[Z]:=StrToFloat(H0Z.Text);
  vHh[X]:=StrToFloat(HhX.Text);
  vHh[Y]:=StrToFloat(HhY.Text);
  vHh[Z]:=StrToFloat(HhZ.Text);
  vMh[X]:=StrToFloat(MhX.Text);
  vMh[Y]:=StrToFloat(MhY.Text);
  vMh[Z]:=StrToFloat(MhZ.Text);
  vMm[X]:=StrToFloat(MmX.Text);
  vMm[Y]:=StrToFloat(MmY.Text);
  vMm[Z]:=StrToFloat(MmZ.Text);
  vMcm[X]:=StrToFloat(McmX.Text);
  vMcm[Y]:=StrToFloat(McmY.Text);
  vMcm[Z]:=StrToFloat(McmZ.Text);
  vMco[X]:=StrToFloat(McoX.Text);
  vMco[Y]:=StrToFloat(McoY.Text);
  vMco[Z]:=StrToFloat(McoZ.Text);
  For i:=x to z do begin
    MyuC[i]:=(vMcm[i]-vMco[i])/vHm[i];
    Uem[i]:=vMm[i]/vK[i];
  end;
  Hide;
end;

procedure TEMIODlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TEMIODlg.Calculate( Uu: CoordExtended;
                              Qe,Qh: CoordBoolean;
                              var Me, H: CoordExtended;
                              var Nh: CoordInteger);
var i: Coord;
    Ue: CoordExtended;
    D, LocalT: Extended;
    j: Integer;
begin
  LocalT:=SystemParamsDlg.vmT0/10;
  for i:=x to z do begin
    if vT[i]<1e-5 then D:=0
    else D:=exp(-SystemParamsDlg.vmT0/vT[i]);

    Ue[i]:=Trunc(Uu[i]/vDeltaU[i])*vDeltaU[i];
    if abs(Ue[i])>Uem[i] then Ue[i]:=Uem[i]*Sign(Ue[i]);
    Mde[i].Set_(D*Mde[i].Get_(0)+vK[i]*(1-D)*Ue[i]);
    {Calculate in lower takt}
    for j:=1 to 10 do begin
      Integral1(LocalT,Mh[i],Hk[i]);
      if abs(Hk[i].Get_(0))<=vHm[i] then
        Mh[i].Set_( Mde[i].Get_(0)-vMco[i]*sign(Hk[i].Get_(0))
                    -MyuC[i]*Hk[i].Get_(0))
      else Mh[i].Set_(0);
    end;
    {End lower takt}
    if Qh[i] then Nh[i]:=Trunc(vHh[i]/vDeltaHd[i])
    else Nh[i]:=Trunc((Hk[i].Get_(0)+vDeltaHk[i])/vDeltaHd[i]);
  end;
  Me[x]:=-(Mh[x].Get_(0)-Mh[y].Get_(0)*vDeltaPsiU+Mh[z].Get_(0)*vDeltaNyuU);
  Me[y]:=-(Mh[x].Get_(0)*vDeltaPsiU+Mh[y].Get_(0)-Mh[z].Get_(0)*vDeltaFiU);
  Me[z]:=-(-Mh[x].Get_(0)*vDeltaNyuU+Mh[y].Get_(0)*vDeltaFiU+Mh[z].Get_(0));

  H[x]:=Hk[x].Get_(0)-Hk[y].Get_(0)*vDeltaPsiU+Hk[z].Get_(0)*vDeltaNyuU;
  H[y]:=Hk[x].Get_(0)*vDeltaPsiU+Hk[y].Get_(0)-Hk[z].Get_(0)*vDeltaFiU;
  H[z]:=-Hk[x].Get_(0)*vDeltaNyuU+Hk[y].Get_(0)*vDeltaFiU+Hk[z].Get_(0);
end;

procedure TEMIODlg.FormShow(Sender: TObject);
begin
  DeltaFiU.Text:=FloatToStrF(vDeltaFiU,ffFixed,9,8);
  DeltaPsiU.Text:=FloatToStrF(vDeltaPsiU,ffFixed,9,8);
  DeltaNyuU.Text:=FloatToStrF(vDeltaNyuU,ffFixed,9,8);
  DeltaUX.Text:=FloatToStrF(vDeltaU[X],ffFixed,9,8);
  DeltaUY.Text:=FloatToStrF(vDeltaU[Y],ffFixed,9,8);
  DeltaUZ.Text:=FloatToStrF(vDeltaU[Z],ffFixed,9,8);
  DeltaHdX.Text:=FloatToStrF(vDeltaHd[X],ffFixed,9,8);
  DeltaHdY.Text:=FloatToStrF(vDeltaHd[Y],ffFixed,9,8);
  DeltaHdZ.Text:=FloatToStrF(vDeltaHd[Z],ffFixed,9,8);
  DeltaHkX.Text:=FloatToStrF(vDeltaHk[X],ffFixed,9,8);
  DeltaHkY.Text:=FloatToStrF(vDeltaHk[Y],ffFixed,9,8);
  DeltaHkZ.Text:=FloatToStrF(vDeltaHk[Z],ffFixed,9,8);
  TauX.Text:=FloatToStrF(vTau[X],ffFixed,9,8);
  TauY.Text:=FloatToStrF(vTau[Y],ffFixed,9,8);
  TauZ.Text:=FloatToStrF(vTau[Z],ffFixed,9,8);
  TX.Text:=FloatToStrF(vT[X],ffFixed,9,8);
  TY.Text:=FloatToStrF(vT[Y],ffFixed,9,8);
  TZ.Text:=FloatToStrF(vT[Z],ffFixed,9,8);
  TkX.Text:=FloatToStrF(vTk[X],ffFixed,9,8);
  TkY.Text:=FloatToStrF(vTk[Y],ffFixed,9,8);
  TkZ.Text:=FloatToStrF(vTk[Z],ffFixed,9,8);
  KX.Text:=FloatToStrF(vK[X],ffFixed,9,8);
  KY.Text:=FloatToStrF(vK[Y],ffFixed,9,8);
  KZ.Text:=FloatToStrF(vK[Z],ffFixed,9,8);
  HmX.Text:=FloatToStrF(vHm[X],ffFixed,9,8);
  HmY.Text:=FloatToStrF(vHm[Y],ffFixed,9,8);
  HmZ.Text:=FloatToStrF(vHm[Z],ffFixed,9,8);
  H0X.Text:=FloatToStrF(vH0[X],ffFixed,9,8);
  H0Y.Text:=FloatToStrF(vH0[Y],ffFixed,9,8);
  H0Z.Text:=FloatToStrF(vH0[Z],ffFixed,9,8);
  HhX.Text:=FloatToStrF(vHh[X],ffFixed,9,8);
  HhY.Text:=FloatToStrF(vHh[Y],ffFixed,9,8);
  HhZ.Text:=FloatToStrF(vHh[Z],ffFixed,9,8);
  MhX.Text:=FloatToStrF(vMh[X],ffFixed,9,8);
  MhY.Text:=FloatToStrF(vMh[Y],ffFixed,9,8);
  MhZ.Text:=FloatToStrF(vMh[Z],ffFixed,9,8);
  MmX.Text:=FloatToStrF(vMm[X],ffFixed,9,8);
  MmY.Text:=FloatToStrF(vMm[Y],ffFixed,9,8);
  MmZ.Text:=FloatToStrF(vMm[Z],ffFixed,9,8);
  McmX.Text:=FloatToStrF(vMcm[X],ffFixed,9,8);
  McmY.Text:=FloatToStrF(vMcm[Y],ffFixed,9,8);
  McmZ.Text:=FloatToStrF(vMcm[Z],ffFixed,9,8);
  McoX.Text:=FloatToStrF(vMco[X],ffFixed,9,8);
  McoY.Text:=FloatToStrF(vMco[Y],ffFixed,9,8);
  McoZ.Text:=FloatToStrF(vMco[Z],ffFixed,9,8);
end;

procedure TEMIODlg.FormDestroy(Sender: TObject);
var i: Coord;
begin
  for i:=x to z do begin
      Mde[i].Free;
      Hk[i].Free;
      Mh[i].Free;
  end;
end;

end.
