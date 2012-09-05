unit dlgBK_Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DeclPasha;

type
  TfrmBKParams = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtKintegral: TEdit;
    edtK1: TEdit;
    edtT11: TEdit;
    edtT21: TEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtK2: TEdit;
    edtT12: TEdit;
    edtT22: TEdit;
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FBK  : TBlockKorektirovki;
    procedure GetParameters;
  public
    { Public declarations }
    procedure SetParameters (ShemeNo  : LongInt;
                             ApBK  : Pointer);
  end;

var
  frmBKParams: TfrmBKParams;

implementation

{$R *.DFM}

{ TfrmBKParams }

procedure TfrmBKParams.GetParameters;
begin
  FBK.Integral.k := StrToFloat (edtKintegral.Text);

  FBK.AperiodicForce1.k := StrToFloat (edtK1.Text);
  FBK.AperiodicForce1.T1 := StrToFloat (edtT11.Text);
  FBK.AperiodicForce1.T2 := StrToFloat (edtT21.Text);

  FBK.AperiodicForce2.k := StrToFloat (edtK2.Text);
  FBK.AperiodicForce2.T1 := StrToFloat (edtT12.Text);
  FBK.AperiodicForce2.T2 := StrToFloat (edtT22.Text);
end;

procedure TfrmBKParams.SetParameters(ShemeNo: Integer; ApBK: Pointer);
begin
  Caption := Concat ('Параметры блока коррекции ', IntToStr (ShemeNo));
  FBK := ApBK;
  edtKintegral.Text := FloatToStr (FBK.Integral.k);

  edtK1.Text := FloatToStr (FBK.AperiodicForce1.k);
  edtT11.Text := FloatToStr (FBK.AperiodicForce1.T1);
  edtT21.Text := FloatToStr (FBK.AperiodicForce1.T2);

  edtK2.Text := FloatToStr (FBK.AperiodicForce2.k);
  edtT12.Text := FloatToStr (FBK.AperiodicForce2.T1);
  edtT22.Text := FloatToStr (FBK.AperiodicForce2.T2);
end;

procedure TfrmBKParams.btnOkClick(Sender: TObject);
begin
  GetParameters;
end;

end.
