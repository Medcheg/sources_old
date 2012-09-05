unit RockinParameters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TRockingParams = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    edtTestParameters: TEdit;
    udTestParameters: TUpDown;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ValueAssignment (vTestParameters  : Integer);
    function GetTestParameters : Integer;
  end;

var
  RockingParams: TRockingParams;

implementation

{$R *.dfm}

procedure TRockingParams.ValueAssignment (vTestParameters  : Integer);
begin
  udTestParameters.Position := vTestParameters;
end;

function TRockingParams.GetTestParameters : Integer;
begin
  Result := udTestParameters.Position;
end;

end.
