unit Unit_OgranForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TOgranForm = class(TForm)
    Label3: TLabel;
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
    Temp1 : pointer;
    Procedure SetParam(Temp : pointer);
  end;

var
  OgranForm: TOgranForm;

implementation

uses Unit_Scheme, Zveno;

{$R *.DFM}

procedure TOgranForm.SetParam(Temp: pointer);
begin
  Temp1 :=Temp;
  Edit1.Text:=FloatToStr(Round(TOgran(temp).B*10000000)/10000000);
  Edit2.Text:=FloatToStr(Round(TOgran(temp).K*10000000)/10000000);
end;

Procedure TOgranForm.ShowEdit(Edit_:TEdit);
begin
     Edit_.SetFocus;
     Edit_.SelectAll;
end;

procedure TOgranForm.Button1Click(Sender: TObject);
begin
  try  TOgran(temp1).B  :=StrToFloat(Edit1.Text) except ShowEdit(Edit1); exit end;
  try  TOgran(temp1).K  :=StrToFloat(Edit2.Text) except ShowEdit(Edit2); exit end;
  close;
end;


end.
