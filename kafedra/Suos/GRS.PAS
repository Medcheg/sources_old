unit Grs;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, Kzacom;

type
  TGRSDlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
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
    Label1: TLabel;
    Label2: TLabel;
    PpX: TEdit;
    PpY: TEdit;
    PpZ: TEdit;
    NpX: TEdit;
    NpY: TEdit;
    NpZ: TEdit;
    QpX: TEdit;
    QpY: TEdit;
    QpZ: TEdit;
    LpX: TEdit;
    LpY: TEdit;
    LpZ: TEdit;
    PnpX: TEdit;
    PnpY: TEdit;
    PnpZ: TEdit;
    TX: TEdit;
    TY: TEdit;
    TZ: TEdit;
    TauX: TEdit;
    TauY: TEdit;
    TauZ: TEdit;
    DeltaFiU: TEdit;
    DeltaNyuU: TEdit;
    DeltaPsiU: TEdit;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure Calculate(
      {INPUT PARAMETERS}
      {Control Signals for GRS}
      Up: CoordExtended;
      {Flags Of Malefunctions In GRS}
      Q: CoordBoolean;
      {OUTPUT PARAMETERS}
      {Moments of DO GRS in SSK (kg*M)}
     var Mp,
      {Force Impulses of DO GRS (kg)}
      Rp: CoordExtended);
    function Save(F: LongInt): boolean;
    function Open(F: LongInt): boolean;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    vPp       : CoordExtended;
    vNp       : CoordInteger;
    vQp       : CoordExtended;
    vLp       : CoordExtended;
    vPnp      : CoordExtended;
    vT        : CoordExtended;
    vTau      : CoordExtended;
    vDeltaFiU : Extended;
    vDeltaNyuU: Extended;
    vDeltaPsiU: Extended;
  public
    { Public declarations }
    {Declaration for Calculate}
    _Up, Mdo: CoordTStek;
  end;

var
  GRSDlg: TGRSDlg;

implementation

uses SysUtils, SParams;

{$R *.DFM}

function TGRSDlg.Save(F: LongInt): boolean;
begin
  FileWrite(F,vT,SizeOf(CoordExtended));
  FileWrite(F,vTau,SizeOf(CoordExtended));
  FileWrite(F,vPp,SizeOf(CoordExtended));
  FileWrite(F,vQp,SizeOf(CoordExtended));
  FileWrite(F,vLp,SizeOf(CoordExtended));
  FileWrite(F,vPnp,SizeOf(CoordExtended));
  FileWrite(F,vNp,SizeOf(CoordInteger));
  FileWrite(F,vDeltaFiU,SizeOf(Extended));
  FileWrite(F,vDeltaPsiU,SizeOf(Extended));
  FileWrite(F,vDeltaNyuU,SizeOf(Extended));
  Result:=True;
end;

function TGRSDlg.Open(F: LongInt): boolean;
begin
  FileRead(F,vT,SizeOf(CoordExtended));
  FileRead(F,vTau,SizeOf(CoordExtended));
  FileRead(F,vPp,SizeOf(CoordExtended));
  FileRead(F,vQp,SizeOf(CoordExtended));
  FileRead(F,vLp,SizeOf(CoordExtended));
  FileRead(F,vPnp,SizeOf(CoordExtended));
  FileRead(F,vNp,SizeOf(CoordInteger));
  FileRead(F,vDeltaFiU,SizeOf(Extended));
  FileRead(F,vDeltaPsiU,SizeOf(Extended));
  FileRead(F,vDeltaNyuU,SizeOf(Extended));
  Result:=True;
end;

procedure TGRSDlg.FormCreate(Sender: TObject);
var i: Coord;
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
  for i:=x to z do begin
    _Up[i]:=TStek.Create;
    Mdo[i]:=TStek.Create;
  end;
  for i:=X to Z do begin
    vPp[i]       :=0;
    vNp[i]       :=0;
    vQp[i]       :=0;
    vLp[i]       :=0;
    vPnp[i]      :=0;
    vT[i]        :=0;
    vTau[i]      :=0;
  end;
  vDeltaFiU :=0;
  vDeltaNyuU:=0;
  vDeltaPsiU:=0;
end;

procedure TGRSDlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TGRSDlg.FormShow(Sender: TObject);
begin
  PpX.Text:=FloatToStrF(vPp[X],ffFixed,9,8);
  PpY.Text:=FloatToStrF(vPp[Y],ffFixed,9,8);
  PpZ.Text:=FloatToStrF(vPp[Z],ffFixed,9,8);
  QpX.Text:=FloatToStrF(vQp[X],ffFixed,9,8);
  QpY.Text:=FloatToStrF(vQp[Y],ffFixed,9,8);
  QpZ.Text:=FloatToStrF(vQp[Z],ffFixed,9,8);
  LpX.Text:=FloatToStrF(vLp[X],ffFixed,9,8);
  LpY.Text:=FloatToStrF(vLp[Y],ffFixed,9,8);
  LpZ.Text:=FloatToStrF(vLp[Z],ffFixed,9,8);
  PnpX.Text:=FloatToStrF(vPnp[X],ffFixed,9,8);
  PnpY.Text:=FloatToStrF(vPnp[Y],ffFixed,9,8);
  PnpZ.Text:=FloatToStrF(vPnp[Z],ffFixed,9,8);
  TX.Text:=FloatToStrF(vT[X],ffFixed,9,8);
  TY.Text:=FloatToStrF(vT[Y],ffFixed,9,8);
  TZ.Text:=FloatToStrF(vT[Z],ffFixed,9,8);
  TauX.Text:=FloatToStrF(vTau[X],ffFixed,9,8);
  TauY.Text:=FloatToStrF(vTau[Y],ffFixed,9,8);
  TauZ.Text:=FloatToStrF(vTau[Z],ffFixed,9,8);
  NpX.Text:=IntToStr(vNp[X]);
  NpY.Text:=IntToStr(vNp[Y]);
  NpZ.Text:=IntToStr(vNp[Z]);
  DeltaFiU.Text:=FloatToStrF(vDeltaFiU,ffFixed,9,8);
  DeltaPsiU.Text:=FloatToStrF(vDeltaPsiU,ffFixed,9,8);
  DeltaNyuU.Text:=FloatToStrF(vDeltaNyuU,ffFixed,9,8);

end;

procedure TGRSDlg.OKBtnClick(Sender: TObject);
begin
  vPp[X]:=StrToFloat(PpX.Text);
  vPp[Y]:=StrToFloat(PpY.Text);
  vPp[Z]:=StrToFloat(PpZ.Text);
  vQp[X]:=StrToFloat(QpX.Text);
  vQp[Y]:=StrToFloat(QpY.Text);
  vQp[Z]:=StrToFloat(QpZ.Text);
  vLp[X]:=StrToFloat(LpX.Text);
  vLp[Y]:=StrToFloat(LpY.Text);
  vLp[Z]:=StrToFloat(LpZ.Text);
  vPnp[X]:=StrToFloat(PnpX.Text);
  vPnp[Y]:=StrToFloat(PnpY.Text);
  vPnp[Z]:=StrToFloat(PnpZ.Text);
  vT[X]:=StrToFloat(TX.Text);
  vT[Y]:=StrToFloat(TY.Text);
  vT[Z]:=StrToFloat(TZ.Text);
  vTau[X]:=StrToFloat(TauX.Text);
  vTau[Y]:=StrToFloat(TauY.Text);
  vTau[Z]:=StrToFloat(TauZ.Text);
  vDeltaFiU:=StrToFloat(DeltaFiU.Text);
  vDeltaPsiU:=StrToFloat(DeltaPsiU.Text);
  vDeltaNyuU:=StrToFloat(DeltaNyuU.Text);
  vNp[X]:=StrToint(NpX.Text);
  vNp[Y]:=StrToint(NpY.Text);
  vNp[Z]:=StrToint(NpZ.Text);
  Hide;
end;

procedure TGRSDlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TGRSDlg.Calculate( Up: CoordExtended; Q: CoordBoolean;
                           var Mp,Rp: CoordExtended);
var
    Mpc, Mnp, MyuP, D: CoordExtended;
    L: CoordInteger;
    i: Coord;
begin
  for i:=X to Z do begin
    Mpc[i] :=vPp[i]*vNp[i]*vLp[i];
    Mnp[i] :=vPnp[i]*vNp[i]*vLp[i];
    MyuP[i]:=vQp[i]*vNp[i]*vLp[i];
    _Up[i].Set_(Up[i]);
    if Q[i] then Mdo[i].Set_(Mnp[i])
      else begin
        if vT[i]<1e-5 then D[i]:=0
        else D[i]:=Exp(-SystemParamsDlg.vmT0/vT[i]);
        L[i]:=Trunc(vTau[i]/SystemParamsDlg.vmT0);
        Mdo[i].Set_( D[i]*Mdo[i].Get_(0)
                     + Mpc[i]*(1-D[i])*_Up[i].Get_(-L[i]))
      end
  end;
  Mp[X]:=Mdo[X].Get_(0) - Mdo[Y].Get_(0)*vDeltaPsiU
                        + Mdo[Z].Get_(0)*vDeltaNyuU;
  Mp[Y]:=Mdo[X].Get_(0)*vDeltaPsiU + Mdo[Y].Get_(0)
                        - Mdo[Z].Get_(0)*vDeltaFiU;
  Mp[Z]:= -Mdo[X].Get_(0)*vDeltaNyuU
          + Mdo[Y].Get_(0)*vDeltaFiU + Mdo[Z].Get_(0);
  Rp[X]:=0;
  Rp[Y]:=0;
  Rp[Z]:=0;
end;
procedure TGRSDlg.FormDestroy(Sender: TObject);
var i: Coord;
begin
  for i:=x to z do begin
    _Up[i].Free;
    Mdo[i].Free;
  end;
end;

end.
