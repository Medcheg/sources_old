unit Mio;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, Kzacom;

type
  TMIODlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label5: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label21: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PmkX: TEdit;
    PmkY: TEdit;
    PmkZ: TEdit;
    PnmX: TEdit;
    PnmY: TEdit;
    PnmZ: TEdit;
    PokX: TEdit;
    PokY: TEdit;
    PokZ: TEdit;
    TX: TEdit;
    TY: TEdit;
    TZ: TEdit;
    DeltaFiU: TEdit;
    DeltaNyuU: TEdit;
    DeltaPsiU: TEdit;
    function Save(Handle: LongInt): boolean;
    function Open(Handle: LongInt): boolean;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Calculate(
    {INPUT PARAMETERS}
    {Proections of Vector MPZ to SSK KA}
    B,
    {Control Signals frpm BCVK to MIO}
    Um: CoordExtended;
    {Flags of malefunction of MIO}
    Qm: CoordBoolean;
    {OUTPUT PARAMETERS}
    {MIO moments on SSK KA}
    var Mm: CoordExtended);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vPmk      : CoordExtended;
    vPnm      : CoordExtended;
    vPok      : CoordExtended;
    vT        : CoordExtended;
    vDeltaFiU : Extended;
    vDeltaNyuU: Extended;
    vDeltaPsiU: Extended;
    _Pk: CoordTStek;
  end;

var
  MIODlg: TMIODlg;

implementation

uses SysUtils,sparams;

{$R *.DFM}

function TMIODlg.Save(Handle: LongInt): boolean;
begin
    FileWrite(Handle, vPmk      ,SizeOf(CoordExtended));
    FileWrite(Handle, vPnm      ,SizeOf(CoordExtended));
    FileWrite(Handle, vPok      ,SizeOf(CoordExtended));
    FileWrite(Handle, vT        ,SizeOf(CoordExtended));
    FileWrite(Handle, vDeltaFiU ,SizeOf(Extended));
    FileWrite(Handle, vDeltaNyuU,SizeOf(Extended));
    FileWrite(Handle, vDeltaPsiU,SizeOf(Extended));
    Result:=True;
end;

function TMIODlg.Open(Handle: LongInt): boolean;
begin
    FileRead(Handle, vPmk      ,SizeOf(CoordExtended));
    FileRead(Handle, vPnm      ,SizeOf(CoordExtended));
    FileRead(Handle, vPok      ,SizeOf(CoordExtended));
    FileRead(Handle, vT        ,SizeOf(CoordExtended));
    FileRead(Handle, vDeltaFiU ,SizeOf(Extended));
    FileRead(Handle, vDeltaNyuU,SizeOf(Extended));
    FileRead(Handle, vDeltaPsiU,SizeOf(Extended));
    Result:=True;
end;

procedure TMIODlg.FormCreate(Sender: TObject);
var i: Coord;
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
  for i:=X to Z do begin
    vPmk[i]      :=0;
    vPnm[i]      :=0;
    vPok[i]      :=0;
    vT[i]        :=0;
    _Pk[i]:=TStek.Create;
  end;
  vDeltaFiU :=0;
  vDeltaNyuU:=0;
  vDeltaPsiU:=0;
end;

procedure TMIODlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TMIODlg.OKBtnClick(Sender: TObject);
begin
  vPmk[X]:=StrToFloat(PmkX.Text);
  vPmk[Y]:=StrToFloat(PmkY.Text);
  vPmk[Z]:=StrToFloat(PmkZ.Text);
  vPnm[X]:=StrToFloat(PnmX.Text);
  vPnm[Y]:=StrToFloat(PnmY.Text);
  vPnm[Z]:=StrToFloat(PnmZ.Text);
  vPok[X]:=StrToFloat(PokX.Text);
  vPok[Y]:=StrToFloat(PokY.Text);
  vPok[Z]:=StrToFloat(PokZ.Text);
  vT[X]:=StrToFloat(TX.Text);
  vT[Y]:=StrToFloat(TY.Text);
  vT[Z]:=StrToFloat(TZ.Text);
  vDeltaFiU:=StrToFloat(DeltaFiU.Text);
  vDeltaPsiU:=StrToFloat(DeltaPsiU.Text);
  vDeltaNyuU:=StrToFloat(DeltaNyuU.Text);
  Hide;
end;

procedure TMIODlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TMIODlg.FormShow(Sender: TObject);
begin
  DeltaFiU.Text:=FloatToStrF(vDeltaFiU,ffFixed,9,8);
  DeltaPsiU.Text:=FloatToStrF(vDeltaPsiU,ffFixed,9,8);
  DeltaNyuU.Text:=FloatToStrF(vDeltaNyuU,ffFixed,9,8);
  PmkX.Text:=FloatToStrF(vPmk[X],ffFixed,9,8);
  PmkY.Text:=FloatToStrF(vPmk[Y],ffFixed,9,8);
  PmkZ.Text:=FloatToStrF(vPmk[Z],ffFixed,9,8);
  PnmX.Text:=FloatToStrF(vPnm[X],ffFixed,9,8);
  PnmY.Text:=FloatToStrF(vPnm[Y],ffFixed,9,8);
  PnmZ.Text:=FloatToStrF(vPnm[Z],ffFixed,9,8);
  PokX.Text:=FloatToStrF(vPok[X],ffFixed,9,8);
  PokY.Text:=FloatToStrF(vPok[Y],ffFixed,9,8);
  PokZ.Text:=FloatToStrF(vPok[Z],ffFixed,9,8);
  TX.Text:=FloatToStrF(vT[X],ffFixed,9,8);
  TY.Text:=FloatToStrF(vT[Y],ffFixed,9,8);
  TZ.Text:=FloatToStrF(vT[Z],ffFixed,9,8);
end;

procedure TMIODlg.Calculate( B,Um:CoordExtended; Qm: CoordBoolean;
                     var Mm: CoordExtended);
var Umk, Pk, D, Pm: CoordExtended;
    i: Coord;
begin
  for i:=X to Z do Begin
    if vT[i]<1e-5 then d[i]:=0 else
    D[i]:=Exp(-SystemParamsDlg.vmT0/vT[i]);
    if Um[i]<>0 then Umk[i]:=sign(Um[i]) else Umk[i]:=0;
    if Qm[i] then _Pk[i].Set_(vPnm[i])
       else _Pk[i].Set_( D[i]*_Pk[i].Get_(0) + vPmk[i]*(1-D[i])*Umk[i]);
    Pk[i]:=_Pk[i].Get_(0) + vPok[i]
  end;
  Pm[X]:= Pk[X] - Pk[Y]*vDeltaPsiU + Pk[Z]*vDeltaNyuU;
  Pm[Y]:= Pk[X]*vDeltaPsiU + Pk[Y]
   - Pk[Z]*vDeltaFiU;
  Pm[Z]:= -Pk[X]*vDeltaNyuU + Pk[Y]*vDeltaFiU + Pk[Z];

  Mm[X]:=-(Pm[Y]*B[Z] - Pm[Z]*B[Y]);
  Mm[Y]:=-(Pm[Z]*B[X]- Pm[X]*B[Z]);
  Mm[Z]:=-(Pm[X]*B[Y] - Pm[Y]*B[X]);

end;

procedure TMIODlg.FormDestroy(Sender: TObject);
var i: Coord;
begin
  for i:=x to z do _Pk[i].Free;
end;

end.
