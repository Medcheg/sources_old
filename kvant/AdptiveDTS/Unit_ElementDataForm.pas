unit Unit_ElementDataForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm_ElementData = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowEdit(Edit_:TEdit);
  public
  end;

var
  Form_ElementData: TForm_ElementData;

implementation

uses Unit_Scheme, Zveno;

{$R *.DFM}

Procedure TForm_ElementData.ShowEdit(Edit_:TEdit);
begin
     Edit_.SetFocus;
     Edit_.SelectAll;
     MessageDlg('Не правильно введено значение',mtError,[mbOk],0);
end;

procedure TForm_ElementData.Button1Click(Sender: TObject);
begin
  ModalResult:=mrNone;
  try  StrToFloat(Edit1.Text) except ShowEdit(Edit1); exit end;
  try  StrToFloat(Edit2.Text) except ShowEdit(Edit2); exit end;
  ModalResult:=mrOk;
end;


end.
