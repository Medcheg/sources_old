unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses mpiGuardantStealth;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
// if Check_Guardant_Stealth_1() then caption := 'yes yes yes yes yes'
//                               else caption := 'nea nea nea nea nea';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if Check_Guardant_Stealth_1() then Label1.caption := '�������� �1 : ���� ���������'
                               else Label1.caption := '�������� �1 : ���� �� ���������';
 if Check_Guardant_Stealth_2() then Label2.caption := '�������� �2 : ���� ���������'
                               else Label2.caption := '�������� �2 : ���� �� ���������';
end;

end.
