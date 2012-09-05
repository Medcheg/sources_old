unit Bfz;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, Kzacom;

type
  TBFZDlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label5: TLabel;
    Label6: TLabel;
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
    TX: TEdit;
    TY: TEdit;
    TZ: TEdit;
    UmX: TEdit;
    UmY: TEdit;
    UmZ: TEdit;
    TauX: TEdit;
    TauY: TEdit;
    TauZ: TEdit;
    DeltaUdX: TEdit;
    DeltaUdY: TEdit;
    DeltaUdZ: TEdit;
    KX: TEdit;
    KY: TEdit;
    KZ: TEdit;
    DeltaU0X: TEdit;
    DeltaU0Y: TEdit;
    DeltaU0Z: TEdit;
    UnX: TEdit;
    UnY: TEdit;
    UnZ: TEdit;
    DeltaFiU: TEdit;
    DeltaNyuU: TEdit;
    DeltaPsiU: TEdit;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    function Save(Handle: LongInt): boolean;
    function Open(Handle: LongInt): boolean;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure Calculate(
    {INPUT PARAMETERS}
      {Proection of induction MPZ vector to SSK}
      B: CoordExtended;
      {Flags of malefunctions in BFZ}
      Qf: CoordBoolean;
    {OUTPUT PARAMETERS}
      {Output amount of impulses BFZ}
      var Nf: CoordInteger);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vT        : CoordExtended;
    vUm       : CoordExtended;
    vTau      : CoordExtended;
    vDeltaUd  : CoordExtended;
    vK        : CoordExtended;
    vDeltaU0  : CoordExtended;
    vUn       : CoordExtended;
    vDeltaFiU : Extended;
    vDeltaNyuU: Extended;
    vDeltaPsiU: Extended;
    Uf: CoordTStek;
  end;

var
  BFZDlg: TBFZDlg;

implementation
uses SysUtils, SParams;

{$R *.DFM}

function TBFZDlg.Save(Handle: LongInt): boolean;
begin
    FileWrite(Handle, vT        ,SizeOf(CoordExtended));
    FileWrite(Handle, vUm       ,SizeOf(CoordExtended));
    FileWrite(Handle, vTau      ,SizeOf(CoordExtended));
    FileWrite(Handle, vDeltaUd  ,SizeOf(CoordExtended));
    FileWrite(Handle, vK        ,SizeOf(CoordExtended));
    FileWrite(Handle, vDeltaU0  ,SizeOf(CoordExtended));
    FileWrite(Handle, vUn       ,SizeOf(CoordExtended));
    FileWrite(Handle, vDeltaFiU ,SizeOf(Extended));
    FileWrite(Handle, vDeltaNyuU,SizeOf(Extended));
    FileWrite(Handle, vDeltaPsiU,SizeOf(Extended));
    Result:=True;
end;

function TBFZDlg.Open(Handle: LongInt): boolean;
begin
    FileRead(Handle, vT        ,SizeOf(CoordExtended));
    FileRead(Handle, vUm       ,SizeOf(CoordExtended));
    FileRead(Handle, vTau      ,SizeOf(CoordExtended));
    FileRead(Handle, vDeltaUd  ,SizeOf(CoordExtended));
    FileRead(Handle, vK        ,SizeOf(CoordExtended));
    FileRead(Handle, vDeltaU0  ,SizeOf(CoordExtended));
    FileRead(Handle, vUn       ,SizeOf(CoordExtended));
    FileRead(Handle, vDeltaFiU ,SizeOf(Extended));
    FileRead(Handle, vDeltaNyuU,SizeOf(Extended));
    FileRead(Handle, vDeltaPsiU,SizeOf(Extended));
    Result:=True;
end;

procedure TBFZDlg.FormCreate(Sender: TObject);
var i: Coord;
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
  for i:=X to Z do begin
    vT[i]        :=0;
    vUm[i]       :=0;
    vTau[i]      :=0;
    vDeltaUd[i]  :=0;
    vK[i]        :=0;
    vDeltaU0[i]  :=0;
    vUn[i]       :=0;
    Uf[i]:=TStek.Create;
  end;
  vDeltaFiU :=0;
  vDeltaNyuU:=0;
  vDeltaPsiU:=0;
end;

procedure TBFZDlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TBFZDlg.FormShow(Sender: TObject);
begin
  TX.Text:=FloatToStrF(vT[X],ffFixed,9,8);
  TY.Text:=FloatToStrF(vT[Y],ffFixed,9,8);
  TZ.Text:=FloatToStrF(vT[Z],ffFixed,9,8);
  UmX.Text:=FloatToStrF(vUm[X],ffFixed,9,8);
  UmY.Text:=FloatToStrF(vUm[Y],ffFixed,9,8);
  UmZ.Text:=FloatToStrF(vUm[Z],ffFixed,9,8);
  TauX.Text:=FloatToStrF(vTau[X],ffFixed,9,8);
  TauY.Text:=FloatToStrF(vTau[Y],ffFixed,9,8);
  TauZ.Text:=FloatToStrF(vTau[Z],ffFixed,9,8);
  DeltaUdX.Text:=FloatToStrF(vDeltaUd[X],ffFixed,9,8);
  DeltaUdY.Text:=FloatToStrF(vDeltaUd[Y],ffFixed,9,8);
  DeltaUdZ.Text:=FloatToStrF(vDeltaUd[Z],ffFixed,9,8);
  DeltaU0X.Text:=FloatToStrF(vDeltaU0[X],ffFixed,9,8);
  DeltaU0Y.Text:=FloatToStrF(vDeltaU0[Y],ffFixed,9,8);
  DeltaU0Z.Text:=FloatToStrF(vDeltaU0[Z],ffFixed,9,8);
  KX.Text:=FloatToStrF(vK[X],ffFixed,9,8);
  KY.Text:=FloatToStrF(vK[Y],ffFixed,9,8);
  KZ.Text:=FloatToStrF(vK[Z],ffFixed,9,8);
  UnX.Text:=FloatToStrF(vUn[X],ffFixed,9,8);
  UnY.Text:=FloatToStrF(vUn[Y],ffFixed,9,8);
  UnZ.Text:=FloatToStrF(vUn[Z],ffFixed,9,8);
  DeltaFiU.Text:=FloatToStrF(vDeltaFiU,ffFixed,9,8);
  DeltaNyuU.Text:=FloatToStrF(vDeltaNyuU,ffFixed,9,8);
  DeltaPsiU.Text:=FloatToStrF(vDeltaPsiU,ffFixed,9,8);
end;

procedure TBFZDlg.OKBtnClick(Sender: TObject);
begin
  vT[X]:=StrToFloat(TX.Text);
  vT[Y]:=StrToFloat(TY.Text);
  vT[Z]:=StrToFloat(TZ.Text);
  vUm[X]:=StrToFloat(UmX.Text);
  vUm[Y]:=StrToFloat(UmY.Text);
  vUm[Z]:=StrToFloat(UmZ.Text);
  vTau[X]:=StrToFloat(TauX.Text);
  vTau[Y]:=StrToFloat(TauY.Text);
  vTau[Z]:=StrToFloat(TauZ.Text);
  vDeltaUd[X]:=StrToFloat(DeltaUdX.Text);
  vDeltaUd[Y]:=StrToFloat(DeltaUdY.Text);
  vDeltaUd[Z]:=StrToFloat(DeltaUdZ.Text);
  vDeltaU0[X]:=StrToFloat(DeltaU0X.Text);
  vDeltaU0[Y]:=StrToFloat(DeltaU0Y.Text);
  vDeltaU0[Z]:=StrToFloat(DeltaU0Z.Text);
  vK[X]:=StrToFloat(KX.Text);
  vK[Y]:=StrToFloat(KY.Text);
  vK[Z]:=StrToFloat(KZ.Text);
  vUn[X]:=StrToFloat(UnX.Text);
  vUn[Y]:=StrToFloat(UnY.Text);
  vUn[Z]:=StrToFloat(UnZ.Text);
  vDeltaFiU:=StrToFloat(DeltaFiU.Text);
  vDeltaNyuU:=StrToFloat(DeltaNyuU.Text);
  vDeltaPsiU:=StrToFloat(DeltaPsiU.Text);
  Hide;
end;

procedure TBFZDlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TBFZDlg.Calculate( B: CoordExtended; Qf: CoordBoolean;
                             var Nf: CoordInteger);
var Bf: CoordExtended;
    i : Coord;
    D : Extended;
begin
  Bf[X]:= B[X] + B[Y] * vDeltaPsiU - B[Z] * vDeltaNyuU;
  Bf[Y]:= -B[X] * vDeltaPsiU + B[Y] + B[Z] * vDeltaFiU;
  Bf[Z]:= B[X] * vDeltaNyuU - B[Y] * vDeltaFiU + B[Z];

  For i:=X to Z do begin
    if vT[i]<1e-5 then d:=0 else
    D:= exp(-SystemParamsDlg.vmT0/vT[i]);
    Bf[i]:= Bf[i] + vDeltaU0[i]/vK[i];
    if Qf[i] then begin
      Nf[i]:= Trunc( vUn[i]/vDeltaUd[i]);
      Uf[i].Set_(vUn[i])
    end
    else begin
      Uf[i].Set_( D*Uf[i].Get_(0) + vK[i]*(1-D)*Bf[i]);
      if Abs( Uf[i].Get_(0) )>vUm[i] then
         Uf[i].Change_( vUm[i]*Sign( Uf[i].Get_(0) ) );
      Nf[i]:= Trunc( Uf[i].Get_(0)/vDeltaUd[i]);
    end
  end
end;

procedure TBFZDlg.FormDestroy(Sender: TObject);
var i: Coord;
begin
  for i:=x to z do Uf[i].Free;
end;

end.

