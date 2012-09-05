unit dlgAZ_Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,
  Declaration, DeclPasha, Math, ComCtrls;

type
  TfrmAZ_Params = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    udImpulseAmount: TUpDown;
    Edit2: TEdit;
    udImpulsiveBlankAmount: TUpDown;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FPModelParameters  : PEModelParameters;
  public
    { Public declarations }
    procedure SetParameters (AModelParameters  : Pointer);
  end;

var
  frmAZ_Params: TfrmAZ_Params;

implementation

{$R *.DFM}

procedure TfrmAZ_Params.SetParameters (AModelParameters  : Pointer);
begin
  FPModelParameters := AModelParameters;
  udImpulseAmount.Position := FPModelParameters^.ImpulseAmount;
  udImpulsiveBlankAmount.Position := FPModelParameters^.ImpulsiveBlankAmount;
end;

procedure TfrmAZ_Params.btnOkClick(Sender: TObject);
var
  intValue  : Integer;
  extValue  : Extended;
begin
  FPModelParameters^.ImpulseAmount := udImpulseAmount.Position;
  FPModelParameters^.ImpulsiveBlankAmount := udImpulsiveBlankAmount.Position;
end;

end.
