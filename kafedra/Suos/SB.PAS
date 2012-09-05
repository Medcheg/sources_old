unit Sb;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls, Tabs,
  Buttons, ExtCtrls, KzaCom;

type
  TSunBatDlg = class(TForm)
    ButtonPanel: TPanel;
    TabSet: TTabSet;
    Notebook: TNotebook;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    TabCoord: TTabSet;
    CoordBook: TNotebook;
    Label32: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Eps11: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    G11x: TEdit;
    G12x: TEdit;
    G21x: TEdit;
    G22x: TEdit;
    G11y: TEdit;
    G12y: TEdit;
    G21y: TEdit;
    G22y: TEdit;
    G31y: TEdit;
    G11z: TEdit;
    G12z: TEdit;
    G21z: TEdit;
    G22z: TEdit;
    G31z: TEdit;
    G31x: TEdit;
    E22: TEdit;
    E12: TEdit;
    E31: TEdit;
    E11: TEdit;
    E21: TEdit;
    C11: TEdit;
    C12: TEdit;
    C21: TEdit;
    C22: TEdit;
    C31: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure TabCoordClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure Calculate(
    {Input parameters}
    var dOmega: CoordTStek);
    procedure Initsb;
    procedure FormDestroy(Sender: TObject);
    function Save(Handle: longint): Boolean;
    function Open(Handle: longint): Boolean;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    vG11: CoordExtended;
    vG12: CoordExtended;
    vG21: CoordExtended;
    vG22: CoordExtended;
    vG31: CoordExtended;
    vE22: Extended;
    vE12: Extended;
    vE31: Extended;
    vE11: Extended;
    vE21: Extended;
    vC11: Extended;
    vC12: Extended;
    vC21: Extended;
    vC22: Extended;
    vC31: Extended;
  public
    { Public declarations }
    vMp: Extended;
    vJp: Extended;
    q1t,q2t,p1t,p2t,r1t: CoordTStek;
    q1tt,q2tt,p1tt,p2tt,r1tt: CoordTStek;
    aq1,bq1,cq1,dq1,
    aq2,bq2,cq2,dq2,
    ap1,bp1,cp1,dp1,
    ap2,bp2,cp2,dp2,
    ar1,br1,cr1,dr1: extended;
  end;

var
  SunBatDlg: TSunBatDlg;

implementation

uses SysUtils, SParams;

{$R *.DFM}

function TSunBatDlg.Save(Handle: longint): Boolean;
begin
    FileWrite(Handle, vG11,SizeOf(CoordExtended));
    FileWrite(Handle, vG12,SizeOf(CoordExtended));
    FileWrite(Handle, vG21,SizeOf(CoordExtended));
    FileWrite(Handle, vG22,SizeOf(CoordExtended));
    FileWrite(Handle, vG31,SizeOf(CoordExtended));
    FileWrite(Handle, vE22,SizeOf(Extended));
    FileWrite(Handle, vE12,SizeOf(Extended));
    FileWrite(Handle, vE31,SizeOf(Extended));
    FileWrite(Handle, vE11,SizeOf(Extended));
    FileWrite(Handle, vE21,SizeOf(Extended));
    FileWrite(Handle, vC11,SizeOf(Extended));
    FileWrite(Handle, vC12,SizeOf(Extended));
    FileWrite(Handle, vC21,SizeOf(Extended));
    FileWrite(Handle, vC22,SizeOf(Extended));
    FileWrite(Handle, vC31,SizeOf(Extended));
Result:=True;
end;

function TSunBatDlg.Open(Handle: longint): Boolean;
begin
    FileRead(Handle, vG11,SizeOf(CoordExtended));
    FileRead(Handle, vG12,SizeOf(CoordExtended));
    FileRead(Handle, vG21,SizeOf(CoordExtended));
    FileRead(Handle, vG22,SizeOf(CoordExtended));
    FileRead(Handle, vG31,SizeOf(CoordExtended));
    FileRead(Handle, vE22,SizeOf(Extended));
    FileRead(Handle, vE12,SizeOf(Extended));
    FileRead(Handle, vE31,SizeOf(Extended));
    FileRead(Handle, vE11,SizeOf(Extended));
    FileRead(Handle, vE21,SizeOf(Extended));
    FileRead(Handle, vC11,SizeOf(Extended));
    FileRead(Handle, vC12,SizeOf(Extended));
    FileRead(Handle, vC21,SizeOf(Extended));
    FileRead(Handle, vC22,SizeOf(Extended));
    FileRead(Handle, vC31,SizeOf(Extended));
Result:=True;
end;

procedure TSunBatDlg.Initsb;
begin
  aq1:= -1/(1+vE11*SystemParamsDlg.vmT0/2
        +vC11*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4);
  bq1:= -2*(1-vC11*SystemParamsDlg.vmT0
        *SystemParamsDlg.vmT0/4)/aq1;
  cq1:= (1-vE11*SystemParamsDlg.vmT0/2
        +vC11*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4)
        /aq1;
  dq1:= (SystemParamsDlg.vmT0/2)/aq1;
  {-------}
  aq2:= -1/(1+vE12*SystemParamsDlg.vmT0/2
        +vC12*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4);
  bq2:= -2*(1-vC12*SystemParamsDlg.vmT0
        *SystemParamsDlg.vmT0/4)/aq2;
  cq2:= (1-vE12*SystemParamsDlg.vmT0/2
        +vC12*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4)
        /aq2;
  dq2:= (SystemParamsDlg.vmT0/2)/aq2;
  {----------}
  ap1:= -1/(1+vE21*SystemParamsDlg.vmT0/2
        +vC21*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4);
  bp1:= -2*(1-vC21*SystemParamsDlg.vmT0
        *SystemParamsDlg.vmT0/4)/ap1;
  cp1:= (1-vE21*SystemParamsDlg.vmT0/2
        +vC21*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4)
        /ap1;
  dp1:= (SystemParamsDlg.vmT0/2)/ap1;
  {-----------}
  ap2:= -1/(1+vE22*SystemParamsDlg.vmT0/2
        +vC22*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4);
  bp2:= -2*(1-vC22*SystemParamsDlg.vmT0
        *SystemParamsDlg.vmT0/4)/ap2;
  cp2:= (1-vE22*SystemParamsDlg.vmT0/2
        +vC22*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4)
        /ap2;
  dp2:= (SystemParamsDlg.vmT0/2)/ap2;
  {---------}
  ar1:= -1/(1+vE31*SystemParamsDlg.vmT0/2
        +vC31*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4);
  br1:= -2*(1-vC31*SystemParamsDlg.vmT0
        *SystemParamsDlg.vmT0/4)/ar1;
  cr1:= (1-vE31*SystemParamsDlg.vmT0/2
        +vC31*SystemParamsDlg.vmT0*SystemParamsDlg.vmT0/4)
        /ar1;
  dr1:= (SystemParamsDlg.vmT0/2)/ar1;
end;

procedure TSunBatDlg.FormCreate(Sender: TObject);
var i: Coord;
begin
  { make the number of Tabs = number of Pages,
    and have the same names }
  TabSet.Tabs := Notebook.Pages;
  TabCoord.Tabs := CoordBook.Pages;
  for i:=x to z do begin
    q1t[i]:=TStek.Create;
    q2t[i]:=TStek.Create;
    p1t[i]:=TStek.Create;
    p2t[i]:=TStek.Create;
    r1t[i]:=TStek.Create;
    q1tt[i]:=TStek.Create;
    q2tt[i]:=TStek.Create;
    p1tt[i]:=TStek.Create;
    p2tt[i]:=TStek.Create;
    r1tt[i]:=TStek.Create;
  end;
end;

procedure TSunBatDlg.TabSetClick(Sender: TObject);
begin
  { set visible Page to which Tab was clicked }
  Notebook.PageIndex := TabSet.TabIndex;
end;

procedure TSunBatDlg.TabCoordClick(Sender: TObject);
begin
  Coordbook.PageIndex := TabCoord.TabIndex;
end;

procedure TSunBatDlg.OKBtnClick(Sender: TObject);
begin
  vG11[x]:=StrToFloat(G11x.Text);
  vG11[y]:=StrToFloat(G11y.Text);
  vG11[z]:=StrToFloat(G11z.Text);
  vG12[x]:=StrToFloat(G12x.Text);
  vG12[y]:=StrToFloat(G12y.Text);
  vG12[z]:=StrToFloat(G12z.Text);
  vG21[x]:=StrToFloat(G21x.Text);
  vG21[y]:=StrToFloat(G21y.Text);
  vG21[z]:=StrToFloat(G21z.Text);
  vG22[x]:=StrToFloat(G22x.Text);
  vG22[y]:=StrToFloat(G22y.Text);
  vG22[z]:=StrToFloat(G22z.Text);
  vG31[x]:=StrToFloat(G31x.Text);
  vG31[y]:=StrToFloat(G31y.Text);
  vG31[z]:=StrToFloat(G31z.Text);
  vE11:=StrToFloat(E11.Text);
  vE12:=StrToFloat(E12.Text);
  vE21:=StrToFloat(E21.Text);
  vE22:=StrToFloat(E22.Text);
  vE31:=StrToFloat(E31.Text);
  vC11:=StrToFloat(C11.Text);
  vC12:=StrToFloat(C12.Text);
  vC21:=StrToFloat(C21.Text);
  vC22:=StrToFloat(C22.Text);
  vC31:=StrToFloat(C31.Text);

  Hide;
end;

procedure TSunBatDlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TSunBatDlg.Calculate(var dOmega: CoordTStek);
var I: Coord;
begin
  for i:=x to z do begin
    q1tt[i].Set_( vG11[i]*aq1*(dOmega[i].Get_(0)-2*dOmega[i].Get_(-1)
                  +dOmega[i].Get_(-2))
                  +bq1*q1tt[i].Get_(0)
                  +cq1*q1tt[i].Get_(-1));
    q1t[i].Set_( vG11[i]*dq1*(dOmega[i].Get_(0)-dOmega[i].Get_(-2))
                 +bq1*q1t[i].Get_(0)
                 +cq1*q1t[i].Get_(-1));

    q2tt[i].Set_( vG12[i]*aq2*(dOmega[i].Get_(0)-2*dOmega[i].Get_(-1)
                  +dOmega[i].Get_(-2))
                  +bq2*q2tt[i].Get_(0)
                  +cq2*q2tt[i].Get_(-1));
    q2t[i].Set_( vG12[i]*dq2*(dOmega[i].Get_(0)-dOmega[i].Get_(-2))
                 +bq2*q2t[i].Get_(0)
                 +cq2*q2t[i].Get_(-1));

    p1tt[i].Set_( vG21[i]*ap1*(dOmega[i].Get_(0)-2*dOmega[i].Get_(-1)
                  +dOmega[i].Get_(-2))
                  +bp1*p1tt[i].Get_(0)
                  +cp1*p1tt[i].Get_(-1));
    p1t[i].Set_( vG21[i]*dp1*(dOmega[i].Get_(0)-dOmega[i].Get_(-2))
                 +bp1*p1t[i].Get_(0)
                 +cp1*p1t[i].Get_(-1));

    p2tt[i].Set_( vG22[i]*ap2*(dOmega[i].Get_(0)-2*dOmega[i].Get_(-1)
                  +dOmega[i].Get_(-2))
                  +bp2*p2tt[i].Get_(0)
                  +cp2*p2tt[i].Get_(-1));
    p2t[i].Set_( vG22[i]*dp2*(dOmega[i].Get_(0)-dOmega[i].Get_(-2))
                 +bp2*p2t[i].Get_(0)
                 +cp2*p2t[i].Get_(-1));

    r1tt[i].Set_( vG31[i]*ar1*(dOmega[i].Get_(0)-2*dOmega[i].Get_(-1)
                  +dOmega[i].Get_(-2))
                  +br1*r1tt[i].Get_(0)
                  +cr1*r1tt[i].Get_(-1));
    r1t[i].Set_( vG31[i]*dr1*(dOmega[i].Get_(0)-dOmega[i].Get_(-2))
                 +br1*r1t[i].Get_(0)
                 +cr1*r1t[i].Get_(-1));
  end;
end;

procedure TSunBatDlg.FormDestroy(Sender: TObject);
var i: Coord;
begin
  for i:=x to z do begin
    q1t[i].Free;
    q2t[i].Free;
    p1t[i].Free;
    p2t[i].Free;
    r1t[i].Free;
    q1tt[i].Free;
    q2tt[i].Free;
    p1tt[i].Free;
    p2tt[i].Free;
    r1tt[i].Free;
  end;
end;

procedure TSunBatDlg.FormShow(Sender: TObject);
begin
  E11.Text:=FloatToStrF(vE11,ffFixed,9,8);
  E12.Text:=FloatToStrF(vE12,ffFixed,9,8);
  E21.Text:=FloatToStrF(vE21,ffFixed,9,8);
  E22.Text:=FloatToStrF(vE22,ffFixed,9,8);
  E31.Text:=FloatToStrF(vE31,ffFixed,9,8);
  C11.Text:=FloatToStrF(vC11,ffFixed,9,8);
  C12.Text:=FloatToStrF(vC12,ffFixed,9,8);
  C21.Text:=FloatToStrF(vC21,ffFixed,9,8);
  C22.Text:=FloatToStrF(vC22,ffFixed,9,8);
  C31.Text:=FloatToStrF(vC31,ffFixed,9,8);
  G11x.Text:=FloatToStrF(vG11[x],ffFixed,9,8);
  G11y.Text:=FloatToStrF(vG11[y],ffFixed,9,8);
  G11z.Text:=FloatToStrF(vG11[z],ffFixed,9,8);
  G12x.Text:=FloatToStrF(vG12[x],ffFixed,9,8);
  G12y.Text:=FloatToStrF(vG12[y],ffFixed,9,8);
  G12z.Text:=FloatToStrF(vG12[z],ffFixed,9,8);
  G21x.Text:=FloatToStrF(vG21[x],ffFixed,9,8);
  G21y.Text:=FloatToStrF(vG21[y],ffFixed,9,8);
  G21z.Text:=FloatToStrF(vG21[z],ffFixed,9,8);
  G22x.Text:=FloatToStrF(vG22[x],ffFixed,9,8);
  G22y.Text:=FloatToStrF(vG22[y],ffFixed,9,8);
  G22z.Text:=FloatToStrF(vG22[z],ffFixed,9,8);
  G31x.Text:=FloatToStrF(vG31[x],ffFixed,9,8);
  G31y.Text:=FloatToStrF(vG31[y],ffFixed,9,8);
  G31z.Text:=FloatToStrF(vG31[z],ffFixed,9,8);
end;

end.
