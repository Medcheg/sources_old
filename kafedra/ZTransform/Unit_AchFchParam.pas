unit Unit_AchFchParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmAchFchParam = class(TForm)
    Label1: TLabel;
    edBeginFreq: TEdit;
    Label2: TLabel;
    edEndFreq: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAchFchParam: TfrmAchFchParam;

implementation

uses Unit_ACH_FCH, MPILibrary;

{$R *.DFM}

procedure TfrmAchFchParam.BitBtn1Click(Sender: TObject);
var
  Finish : Boolean;
begin
  Finish := True;

  try frmACH_FCH.BeginFreq := StrToFloat(edBeginFreq.text) except ShowWrongEdit(edBeginFreq); Finish := False; end;
  try frmACH_FCH.EndFreq   := StrToFloat(edendFreq  .text) except ShowWrongEdit(edEndFreq  ); Finish := False; end;

  frmACH_FCH.AchEnabled := CheckBox4.Checked;
  frmACH_FCH.FchEnabled := CheckBox5.Checked;

  if Finish then begin
     frmACH_FCH.draw();
     close
  end;
end;

end.
