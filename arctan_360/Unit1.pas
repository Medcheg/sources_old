unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    //function arctg(a, b: real): real;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
function arctg(a, b: real): real;
{���������� ����������� � ��������� 0...360 ��������}
begin
if (a>0)  and (b>0) then arctg:= arctan(a/b);
if (a>0)  and (b=0) then arctg:= pi/2;
if (a>=0) and (b<0) then arctg:= arctan(a/b) + pi;
if (a<0)  and (b<0) then arctg:= pi + arctan(-a/-b);
if (a<0)  and (b=0) then arctg:= 3*pi/2;
if (a<0)  and (b>0) then arctg:= arctan(a/b) + 2*pi;
if (a=0)  and (b>0) then arctg:= 0;
end;

//������ �������� ����, ������� �� ���� ����� � �������,
//������� �� ����������� ���������  arct�n � �� ������� arctg
procedure TForm1.Button1Click(Sender: TObject);
label start;
var u,s,c,a,a1 : real;
    ss: string;
    i: integer;
begin
i:=1;
u:=0;
start:
str(u*(180/pi):6:1,ss); StringGrid1.Cells[0,i]:=ss;
s:=sin(u);str(s:6:1,ss); StringGrid1.Cells[1,i]:=ss;
c:=cos(u);str(c:6:1,ss); StringGrid1.Cells[2,i]:=ss;
a:=arctan(s/c); str(a*(180/pi):6:1,ss); StringGrid1.Cells[3,i]:=ss;
a:=arctg(s,c); str(a*(180/pi):6:1,ss); StringGrid1.Cells[4,i]:=ss;
if u<2*pi then
          begin
          u:=u+2*pi/24;
          i:=i+1;
          goto start;
          end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
StringGrid1.Cells[0,0]:='��������';
StringGrid1.Cells[1,0]:='�����';
StringGrid1.Cells[2,0]:='�������';
StringGrid1.Cells[3,0]:='arctan';
StringGrid1.Cells[4,0]:='�������';
end;

end.
