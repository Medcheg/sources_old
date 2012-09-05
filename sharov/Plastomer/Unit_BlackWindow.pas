unit Unit_BlackWindow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmBlackWindow = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBlackWindow: TfrmBlackWindow;

implementation

uses mpiDeclaration, Unit_Main, mpiLibrary;

{$R *.DFM}

procedure TfrmBlackWindow.BitBtn1Click(Sender: TObject);
var
 prev : TFloat;
begin
  try Prev := StrToFloat(Edit1.Text); except ShowWrongEdit(edit1); exit; end;
  AngleBetweenBMK := Prev*pi/180;

  Close;
end;

procedure TfrmBlackWindow.FormShow(Sender: TObject);
begin
   Caption := frmMainCaption + 'Дополнительные параметры';
  // ------
   Edit1.Text := FloatToStr(AngleBetweenBMK*180/pi);
end;

procedure TfrmBlackWindow.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

procedure TfrmBlackWindow.CheckBox1Click(Sender: TObject);
begin
  KeyReg(frmMain.Handle, ktSnapShot);
end;

end.
