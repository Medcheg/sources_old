unit Givus;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, Kzacom;

type
  TGIVUSDlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
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
    Label3: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label1: TLabel;
    TX: TEdit;
    TY: TEdit;
    TZ: TEdit;
    OmegaMX: TEdit;
    OmegaMY: TEdit;
    OmegaMZ: TEdit;
    TauX: TEdit;
    TauY: TEdit;
    TauZ: TEdit;
    CX: TEdit;
    CY: TEdit;
    CZ: TEdit;
    KX: TEdit;
    KY: TEdit;
    KZ: TEdit;
    DeltaOmega0X: TEdit;
    DeltaOmega0Y: TEdit;
    DeltaOmega0Z: TEdit;
    OmegaNX: TEdit;
    OmegaNY: TEdit;
    OmegaNZ: TEdit;
    DeltaFiU: TEdit;
    DeltaNyuU: TEdit;
    DeltaPsiU: TEdit;
    DeltaOmegaPX: TEdit;
    DeltaOmegaPY: TEdit;
    DeltaOmegaPZ: TEdit;
    BettaOmegaX: TEdit;
    BettaOmegaY: TEdit;
    BettaOmegaZ: TEdit;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Calculate(
    {INPUT PARAMETERS}
    {Proection of Absolute Angle Speed on SSK (grad/sek)}
    Omega,dOmega: CoordExtended;
    {Flags of malefunctions}
    Q: CoordBoolean;
    {OUTPUT PARAMETERS}
    {Output quwantity of Information impulses}
    var N: CoordInteger);
    function Save(F: LongInt): boolean;
    function Open(F: LongInt): boolean;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vT          : CoordExtended;
    vOmegaM     : CoordExtended;
    vTau        : CoordExtended;
    vC          : CoordExtended;
    vK          : CoordExtended;
    vDeltaOmega0: CoordExtended;
    vOmegaN     : CoordExtended;
    vDeltaOmegaP: CoordExtended;
    vBettaOmega : CoordExtended;
    vDeltaFiU   : Extended;
    vDeltaNyuU  : Extended;
    vDeltaPsiU  : Extended;
    {Declaration for Calculate}
   { OmegaG     : CoordTIntegr;}
    KOmega, Jg, OmegaS : CoordExtended;
    OmegaOm, dOmegaOm, OmegaG,OmegaGT,OmegaGTT,AngleFi: CoordTStek;
  end;

var
  GIVUSDlg: TGIVUSDlg;

implementation

Uses SysUtils, SParams;

{$R *.DFM}

function TGIVUSDlg.Save(F: LongInt): boolean;
begin
  FileWrite(F,vT,SizeOf(CoordExtended));
  FileWrite(F,vOmegaM,SizeOf(CoordExtended));
  FileWrite(F,vTau,SizeOf(CoordExtended));
  FileWrite(F,vC,SizeOf(CoordExtended));
  FileWrite(F,vK,SizeOf(CoordExtended));
  FileWrite(F,vDeltaOmega0,SizeOf(CoordExtended));
  FileWrite(F,vOmegaN,SizeOf(CoordExtended));
  FileWrite(F,vDeltaOmegaP,SizeOf(CoordExtended));
  FileWrite(F,vBettaOmega,SizeOf(CoordExtended));
  FileWrite(F,vDeltaFiU,SizeOf(Extended));
  FileWrite(F,vDeltaPsiU,SizeOf(Extended));
  FileWrite(F,vDeltaNyuU,SizeOf(Extended));
  Result:=True;
end;

function TGIVUSDlg.Open(F: LongInt): boolean;
begin
  FileRead(F,vT,SizeOf(CoordExtended));
  FileRead(F,vOmegaM,SizeOf(CoordExtended));
  FileRead(F,vTau,SizeOf(CoordExtended));
  FileRead(F,vC,SizeOf(CoordExtended));
  FileRead(F,vK,SizeOf(CoordExtended));
  FileRead(F,vDeltaOmega0,SizeOf(CoordExtended));
  FileRead(F,vOmegaN,SizeOf(CoordExtended));
  FileRead(F,vDeltaOmegaP,SizeOf(CoordExtended));
  FileRead(F,vBettaOmega,SizeOf(CoordExtended));
  FileRead(F,vDeltaFiU,SizeOf(Extended));
  FileRead(F,vDeltaPsiU,SizeOf(Extended));
  FileRead(F,vDeltaNyuU,SizeOf(Extended));
  Result:=True;
end;

procedure TGIVUSDlg.FormCreate(Sender: TObject);
var i: Coord;
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
  for i:=x to z do begin
    OmegaG[i]:=TStek.Create;
    OmegaGT[i]:=TStek.Create;
    OmegaGTT[i]:=TStek.Create;
    AngleFi[i]:=TStek.Create;
    OmegaOm[i]:=TStek.Create;
    dOmegaOm[i]:=TStek.Create;
  end;
  for i:=X to Z do begin
    vT[i]          :=0;
    vOmegaM[i]     :=0;
    vTau[i]        :=0;
    vC[i]          :=0;
    vK[i]          :=0;
    vDeltaOmega0[i]:=0;
    vOmegaN[i]     :=0;
    vDeltaOmegaP[i]:=0;
    vBettaOmega[i] :=0;
  end;
  vDeltaFiU :=0;
  vDeltaNyuU:=0;
  vDeltaPsiU:=0;
end;

procedure TGIVUSDlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TGIVUSDlg.OKBtnClick(Sender: TObject);
begin
  vDeltaFiU:=StrToFloat(DeltaFiU.Text);
  vDeltaPsiU:=StrToFloat(DeltaPsiU.Text);
  vDeltaNyuU:=StrToFloat(DeltaNyuU.Text);
  vDeltaOmega0[X]:=StrToFloat(DeltaOmega0X.Text);
  vDeltaOmega0[Y]:=StrToFloat(DeltaOmega0Y.Text);
  vDeltaOmega0[Z]:=StrToFloat(DeltaOmega0Z.Text);
  vDeltaOmegaP[X]:=StrToFloat(DeltaOmegaPX.Text);
  vDeltaOmegaP[Y]:=StrToFloat(DeltaOmegaPY.Text);
  vDeltaOmegaP[Z]:=StrToFloat(DeltaOmegaPZ.Text);
  vBettaOmega[X]:=StrToFloat(BettaOmegaX.Text);
  vBettaOmega[Y]:=StrToFloat(BettaOmegaY.Text);
  vBettaOmega[Z]:=StrToFloat(BettaOmegaZ.Text);
  vOmegaM[X]:=StrToFloat(OmegaMX.Text);
  vOmegaM[Y]:=StrToFloat(OmegaMY.Text);
  vOmegaM[Z]:=StrToFloat(OmegaMZ.Text);
  vOmegaN[X]:=StrToFloat(OmegaNX.Text);
  vOmegaN[Y]:=StrToFloat(OmegaNY.Text);
  vOmegaN[Z]:=StrToFloat(OmegaNZ.Text);
  vTau[X]:=StrToFloat(TauX.Text);
  vTau[Y]:=StrToFloat(TauY.Text);
  vTau[Z]:=StrToFloat(TauZ.Text);
  vT[X]:=StrToFloat(TX.Text);
  vT[Y]:=StrToFloat(TY.Text);
  vT[Z]:=StrToFloat(TZ.Text);
  vC[X]:=StrToFloat(CX.Text);
  vC[Y]:=StrToFloat(CY.Text);
  vC[Z]:=StrToFloat(CZ.Text);
  vK[X]:=StrToFloat(KX.Text);
  vK[Y]:=StrToFloat(KY.Text);
  vK[Z]:=StrToFloat(KZ.Text);
  Hide;
end;

procedure TGIVUSDlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TGIVUSDlg.FormShow(Sender: TObject);
begin
  DeltaFiU.Text:=FloatToStrF(vDeltaFiU,ffFixed,9,8);
  DeltaPsiU.Text:=FloatToStrF(vDeltaPsiU,ffFixed,9,8);
  DeltaNyuU.Text:=FloatToStrF(vDeltaNyuU,ffFixed,9,8);
  DeltaOmega0X.Text:=FloatToStrF(vDeltaOmega0[X],ffFixed,9,8);
  DeltaOmega0Y.Text:=FloatToStrF(vDeltaOmega0[Y],ffFixed,9,8);
  DeltaOmega0Z.Text:=FloatToStrF(vDeltaOmega0[Z],ffFixed,9,8);
  DeltaOmegaPX.Text:=FloatToStrF(vDeltaOmegaP[X],ffFixed,9,8);
  DeltaOmegaPY.Text:=FloatToStrF(vDeltaOmegaP[Y],ffFixed,9,8);
  DeltaOmegaPZ.Text:=FloatToStrF(vDeltaOmegaP[Z],ffFixed,9,8);
  BettaOmegaX.Text:=FloatToStrF(vBettaOmega[X],ffFixed,9,8);
  BettaOmegaY.Text:=FloatToStrF(vBettaOmega[Y],ffFixed,9,8);
  BettaOmegaZ.Text:=FloatToStrF(vBettaOmega[Z],ffFixed,9,8);
  OmegaMX.Text:=FloatToStrF(vOmegaM[X],ffFixed,9,8);
  OmegaMY.Text:=FloatToStrF(vOmegaM[Y],ffFixed,9,8);
  OmegaMZ.Text:=FloatToStrF(vOmegaM[Z],ffFixed,9,8);
  OmegaNX.Text:=FloatToStrF(vOmegaN[X],ffFixed,9,8);
  OmegaNY.Text:=FloatToStrF(vOmegaN[Y],ffFixed,9,8);
  OmegaNZ.Text:=FloatToStrF(vOmegaN[Z],ffFixed,9,8);
  TauX.Text:=FloatToStrF(vTau[X],ffFixed,9,8);
  TauY.Text:=FloatToStrF(vTau[Y],ffFixed,9,8);
  TauZ.Text:=FloatToStrF(vTau[Z],ffFixed,9,8);
  TX.Text:=FloatToStrF(vT[X],ffFixed,9,8);
  TY.Text:=FloatToStrF(vT[Y],ffFixed,9,8);
  TZ.Text:=FloatToStrF(vT[Z],ffFixed,9,8);
  CX.Text:=FloatToStrF(vC[X],ffFixed,9,8);
  CY.Text:=FloatToStrF(vC[Y],ffFixed,9,8);
  CZ.Text:=FloatToStrF(vC[Z],ffFixed,9,8);
  KX.Text:=FloatToStrF(vK[X],ffFixed,9,8);
  KY.Text:=FloatToStrF(vK[Y],ffFixed,9,8);
  KZ.Text:=FloatToStrF(vK[Z],ffFixed,9,8);
end;

(*procedure TGIVUSDlg.Calculate( Omega,dOmega: CoordExtended; Q: CoordBoolean;
                     N: CoordInteger);
var
    i: Coord;
    j: Integer;
    LocalT: Extended;
begin
  for i:=X to Z do begin
    KOmega[i]:=vOmegaM[i]/vBettaOmega[i];
    Jg[i]:=KOmega[i]*vT[i]*vT[i]{*Pi/180};
  end;
  OmegaOm[X].Set_(Omega[X]+Omega[Y]*vDeltaPsiU-Omega[Z]*vDeltaNyuU);
  OmegaOm[Y].Set_(-Omega[X]*vDeltaPsiU+Omega[Y]+Omega[Z]*vDeltaFiU);
  OmegaOm[Z].Set_(Omega[X]*vDeltaNyuU-Omega[Y]*vDeltaFiU+Omega[Z]);
  dOmegaOm[X].Set_(dOmega[X]+dOmega[Y]*vDeltaPsiU-dOmega[Z]*vDeltaNyuU);
  dOmegaOm[Y].Set_(-dOmega[X]*vDeltaPsiU+dOmega[Y]+dOmega[Z]*vDeltaFiU);
  dOmegaOm[Z].Set_(dOmega[X]*vDeltaNyuU-dOmega[Y]*vDeltaFiU+dOmega[Z]);
{----- Calculate in lower takt ----------}
   LocalT:=SystemParamsDlg.vmT0/5;
    for i:=X to Z do begin
      OmegaS[i]:= OmegaOm[i].Get_(0)+vDeltaOmega0[i]
      -OmegaOm[Coord((Ord(i)+2) mod 3)].Get_(0)*OmegaG[i]._Get(2,0)/KOmega[i]
      -dOmegaOm[Coord((Ord(i)+1) mod 3)].Get_(0)*Jg[i];

      if Abs(OmegaS[i])>vOmegaM[i] then OmegaS[i]:=Sign(OmegaS[i])*vOmegaM[i];

      OmegaG[i]._Set(-2*vK[i]*OmegaG[i]._Get(1,0)/vT[i]
                -OmegaG[i]._Get(2,0)/(vT[i]*vT[i])+OmegaS[i]
                -vDeltaOmegaP[i]*Sign(OmegaG[i]._Get(2,0)),
                [1,2],LocalT);

      if Abs(OmegaS[i]-(OmegaOm[Coord((Ord(i)+2) mod 3)].Get_(0)/KOmega[i]+1)
      *OmegaG[i]._Get(2,0)-dOmegaOm[Coord((Ord(i)+1) mod 3)].Get_(0)*Jg[i])
      <vDeltaOmegaP[i] then begin
        OmegaG[i]._Change(0,1);
        OmegaG[i]._Change(OmegaG[i]._Get(2,-1),2);
      end;
     Integral1();
      OmegaG[i]._Int(LocalT,[3]);
    end;
{----- End calculate in lower takt -----}
  For i:=X to Z do N[i]:=Trunc(OmegaG[i]._Get(3,0)/vC[i]);
end;
  *)
procedure TGIVUSDlg.Calculate( Omega,dOmega: CoordExtended; Q: CoordBoolean;
                    var N: CoordInteger);
var
    i,JJ: Coord;
    zu,j: Integer;
    LocalT: Extended;
begin
  for i:=X to Z do begin
    KOmega[i]:=vOmegaM[i]/vBettaOmega[i];
    Jg[i]:=KOmega[i]*vT[i]*vT[i]{*Pi/180};
  end;
  OmegaOm[X].Set_(Omega[X]+Omega[Y]*vDeltaPsiU-Omega[Z]*vDeltaNyuU);
  OmegaOm[Y].Set_(-Omega[X]*vDeltaPsiU+Omega[Y]+Omega[Z]*vDeltaFiU);
  OmegaOm[Z].Set_(Omega[X]*vDeltaNyuU-Omega[Y]*vDeltaFiU+Omega[Z]);
  dOmegaOm[X].Set_(dOmega[X]+dOmega[Y]*vDeltaPsiU-dOmega[Z]*vDeltaNyuU);
  dOmegaOm[Y].Set_(-dOmega[X]*vDeltaPsiU+dOmega[Y]+dOmega[Z]*vDeltaFiU);
  dOmegaOm[Z].Set_(dOmega[X]*vDeltaNyuU-dOmega[Y]*vDeltaFiU+dOmega[Z]);
{----- Calculate in lower takt ----------}
   LocalT:=SystemParamsDlg.vmT0/5;
   for i:=x to z do AngleFi[i].Clear;
   for  zu:=1 to 5 do begin
    for i:=X to Z do begin
      OmegaS[i]:= OmegaOm[i].Get_(0)+vDeltaOmega0[i]
      -OmegaOm[Coord((Ord(i)+2) mod 3)].Get_(0)*OmegaG[i].Get_(0)/KOmega[i]
      -dOmegaOm[Coord((Ord(i)+1) mod 3)].Get_(0)*Jg[i];

      if Abs(OmegaS[i])>vOmegaM[i] then OmegaS[i]:=Sign(OmegaS[i])*vOmegaM[i];

      OmegaGTT[i].Set_((-2*vK[i]*OmegaGT[i].Get_(0)*vT[i]
                -OmegaG[i].Get_(0)+OmegaS[i]-vDeltaOmegaP[i]
                *Sign(OmegaG[i].Get_(0)))/vT[i]/vT[i]);

      if Abs(OmegaS[i]-(OmegaOm[Coord((Ord(i)+2) mod 3)].Get_(0)/KOmega[i]+1)
      *OmegaG[i].Get_(0)-dOmegaOm[Coord((Ord(i)+1) mod 3)].Get_(0)*Jg[i])
      <vDeltaOmegaP[i] then
      begin
        OmegaGT[i].Set_(0);
        OmegaG[i].Set_(OmegaG[i].Get_(0));
      end else begin
        Integral1(LocalT,OmegaGTT[i],OmegaGT[i]);
        Integral1(LocalT,OmegaGT[i],OmegaG[i]);
      end;
        Integral1(LocalT,OmegaG[i],AngleFi[i]);
    end;
   end;
{----- End calculate in lower takt -----}
  For Jj:=X to Z do N[Jj]:=Trunc(AngleFi[Jj].Get_(0)/vC[Jj]);
end;
procedure TGIVUSDlg.FormDestroy(Sender: TObject);
var i: Coord;
begin
  for i:=x to z do begin
    OmegaG[i].Free;
    OmegaGT[i].Free;
    OmegaGTT[i].Free;
    AngleFi[i].Free;
    OmegaOm[i].Free;
    dOmegaOm[i].Free;
  end;
end;

end.
