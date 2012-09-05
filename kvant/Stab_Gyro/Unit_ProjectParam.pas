unit Unit_ProjectParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmProjectParam = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    eCalcTime: TEdit;
    Label2: TLabel;
    eT0: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProjectParam: TfrmProjectParam;

implementation

uses Unit_Main;

{$R *.DFM}

procedure ShowWrongEdit(Edit : TEdit);
begin
  Beep;
  Edit.SetFocus;
  Edit.SelectAll;
  MessageDlg('Введено не числове значення !!!', mtError, [mbOk],0);
end;

procedure TfrmProjectParam.FormShow(Sender: TObject);
begin
  eCalcTime.Text := FloatToStr(frmMain.CalcTime);
  eT0.Text := FloatToStr(frmMain.T0);
end;

procedure TfrmProjectParam.BitBtn1Click(Sender: TObject);
begin
  try frmMain.CalcTime := StrToFloat(eCalcTime.text) except ShowWrongEdit(eCalcTime); exit end;
  try frmMain.T0       := StrToFloat(eT0.text)       except ShowWrongEdit(eT0);       exit end;

  frmMain.Set_Arrays();
  close;
end;


end.
