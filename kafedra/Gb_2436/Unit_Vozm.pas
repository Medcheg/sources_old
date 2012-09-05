unit Unit_Vozm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm2 = class(TForm)
    RadioButton1: TRadioButton;
    Edit1: TEdit;
    RadioButton2: TRadioButton;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioButton3: TRadioButton;
    Label4: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    Edit5: TEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Math_;

{$R *.DFM}

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  try
     if RadioButton1.Checked then aa:=StrToInt(edit1.text);
     if RadioButton2.Checked then aa:=StrToInt(edit2.text);
     ww:=StrToFloat(edit2.text);
  except
    ShowMessage('Ошибка ввода данных');
    exit;
  end;
end;

end.
