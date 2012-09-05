unit dlgBFZ_Params;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,
  Declaration, DeclPasha, Math, ComCtrls;

type
  TfrmBFZ_Params = class(TForm)
    edtImpulseAmplitude: TEdit;
    edtLevelDb: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    udFrequency: TUpDown;
    Label3: TLabel;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FPModelParameters  : PEModelParameters;
  public
    { Public declarations }
    procedure SetParameters (AModelParameters  : Pointer);
  end;

var
  frmBFZ_Params: TfrmBFZ_Params;

implementation

uses dlgOutBFZ1, dlgOutBFZ2;

{$R *.DFM}

procedure TfrmBFZ_Params.SetParameters (AModelParameters  : Pointer);
begin
  FPModelParameters := AModelParameters;
  udFrequency.Position := FPModelParameters^.Frequency;
  edtImpulseAmplitude.Text := IntToStr (FPModelParameters^.ImpulseAmplitude div 1000);
  edtLevelDb.Text := FloatToStr (FPModelParameters^.LevelDb);
end;

procedure TfrmBFZ_Params.btnOkClick(Sender: TObject);
var
  intValue  : Integer;
  extValue  : Extended;
begin
  try
    intValue := StrToInt (edtImpulseAmplitude.Text);
  except
    MessageDlg (Concat ('Неверное значение максимальной амлитуды импульса: ',
                        edtImpulseAmplitude.Text, #13,
                        'Будет оставлено преженее значение'), mtError,
                        [mbOk], 0);
    intValue := FPModelParameters^.ImpulseAmplitude;
  end;

  try
    extValue := StrToFloat (edtLevelDb.Text);
  except
    MessageDlg (Concat ('Неверное значение порога: ',
                        edtImpulseAmplitude.Text, #13,
                        'Будет оставлено преженее значение'), mtError,
                        [mbOk], 0);
    extValue := FPModelParameters^.LevelDb;
  end;

  FPModelParameters^.Frequency := udFrequency.Position;
  FPModelParameters^.ImpulseAmplitude := intValue * 1000;
  FPModelParameters^.LevelDb := extValue;
  FPModelParameters^.LevelVolt := intValue * 1000 / Power (10, extValue);

  frmOutBFZ1.Chart.LeftAxis.Maximum := intValue;
  frmOutBFZ2.Chart.LeftAxis.Maximum := intValue;
end;

end.
