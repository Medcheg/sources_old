unit dlgUVSO_Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,
  Declaration, DeclPasha, Math, ComCtrls;

type
  TfrmUVSO_Params = class(TForm)
    Label1: TLabel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    udOffsetPercent: TUpDown;
    Label2: TLabel;
    edtK: TEdit;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FPModelParameters  : PEModelParameters;
  public
    { Public declarations }
    procedure SetParameters (AModelParameters  : Pointer);
  end;

var
  frmUVSO_Params: TfrmUVSO_Params;

implementation

{$R *.DFM}

procedure TfrmUVSO_Params.SetParameters (AModelParameters  : Pointer);
begin
  FPModelParameters := AModelParameters;
  edtK.Text := FloatToStr (FPModelParameters^.K);
  //udOffsetPercent.Position := FPModelParameters^.OffsetPercent;
end;

procedure TfrmUVSO_Params.btnOkClick(Sender: TObject);
var
  intValue  : Integer;
  extValue  : Extended;
begin
  //FPModelParameters^.OffsetPercent := udOffsetPercent.Position;
  FPModelParameters^.K := StrToFloat (edtK.Text);
end;

end.
