unit Modes;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TModeDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    CheckRGS: TCheckBox;
    CheckPSO: TCheckBox;
    CheckPPSO: TCheckBox;
    RestCheckBox: TCheckBox;
    MagRestRadio: TCheckBox;
    GRSRestRadio: TCheckBox;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure RestCheckBoxClick(Sender: TObject);
    procedure CheckPPSOClick(Sender: TObject);
    procedure CheckRGSClick(Sender: TObject);
    procedure CheckPSOClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModeDlg: TModeDlg;

implementation

{$R *.DFM}

procedure TModeDlg.OKBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TModeDlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TModeDlg.RestCheckBoxClick(Sender: TObject);
begin
  If RestCheckBox.Checked then begin
    MagRestRadio.Enabled:= True;
    GRSRestRadio.Enabled:= True;
  end else begin
    MagRestRadio.Enabled:= False;
    GRSRestRadio.Enabled:= False;
    MagRestRadio.Checked:= False;
    GRSRestRadio.Checked:= False;
  end;
end;

procedure TModeDlg.CheckPPSOClick(Sender: TObject);
begin
  if CheckPPSO.Checked then
    RestCheckBox.Enabled:= CheckPPSO.Checked
  else begin
    RestCheckBox.Enabled:= False;
    RestCheckBox.Checked:= False;
    RestCheckBoxClick(Self);
  end;
end;

procedure TModeDlg.CheckRGSClick(Sender: TObject);
begin
  if CheckRGS.Checked then
    CheckPSO.Enabled:=True
  else begin
    CheckPso.Enabled:=False;
    CheckPso.Checked:=False;
    CheckpPso.Enabled:=False;
  end;
end;

procedure TModeDlg.CheckPSOClick(Sender: TObject);
begin
  if CheckPSO.Checked then
    CheckPPSO.Enabled:=CheckPSO.Checked
  else begin
    CheckPPSO.Enabled:=False;
    CheckPPSO.Checked:=False;
    CheckPPSOClick(Self);
  end;
end;

end.
