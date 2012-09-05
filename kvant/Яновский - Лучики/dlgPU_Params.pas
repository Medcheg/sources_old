unit dlgPU_Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,
  Declaration, DeclPasha, Math;

type
  TfrmPU_Params = class(TForm)
    edtImpulseAmplitude: TEdit;
    edtLevelV: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FPModelParameters  : PEModelParameters;
  public
    { Public declarations }
    procedure SetParameters (AModelParameters  : Pointer);
  end;

var
  frmPU_Params: TfrmPU_Params;

implementation

{$R *.DFM}

procedure TfrmPU_Params.SetParameters (AModelParameters  : Pointer);
begin
  FPModelParameters := AModelParameters;
  edtImpulseAmplitude.Text := FloatToStr (FPModelParameters^.ImpulseAmplitude / 1000);
  edtLevelV.Text := FloatToStr (FPModelParameters^.LevelVolt  / 1000);
end;

procedure TfrmPU_Params.btnOkClick(Sender: TObject);
var
  intValue  : Integer;
  extValue  : Extended;
begin
  try
    extValue := StrToFloat (edtImpulseAmplitude.Text);
  except
    MessageDlg (Concat ('Неверное значение максимальной амлитуды импульса: ',
                        edtImpulseAmplitude.Text, #13,
                        'Будет оставлено преженее значение'), mtError,
                        [mbOk], 0);
    extValue := FPModelParameters^.ImpulseAmplitude;
  end;
  FPModelParameters^.ImpulseAmplitude := Round (extValue * 1000);

  try
    extValue := StrToFloat (edtLevelV.Text);
  except
    MessageDlg (Concat ('Неверное значение порога: ',
                        edtImpulseAmplitude.Text, #13,
                        'Будет оставлено преженее значение'), mtError,
                        [mbOk], 0);
    extValue := FPModelParameters^.LevelDb;
  end;
  FPModelParameters^.LevelVolt := StrToFloat (edtLevelV.Text) * 1000;
  FPModelParameters^.LevelDb := FPModelParameters^.ImpulseAmplitude / FPModelParameters^.LevelVolt;
end;

end.
