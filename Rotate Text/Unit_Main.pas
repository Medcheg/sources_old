unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    Rot  : Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  lf : TLogFont;
  tf : TFont;
begin
  with Canvas do begin
    Brush.Color:=clBtnFace;
    //Font.Name := 'Courier new';
    Font.Name := 'Arial';

    Font.Size := 8;
    tf := TFont.Create;
    try
      tf.Assign(Font);
      GetObject(tf.Handle, sizeof(lf), @lf);
      lf.lfEscapement := rot;
      lf.lfOrientation := Rot;
      tf.Handle := CreateFontIndirect(lf);
      Font.Assign(tf);
    finally
      tf.Free;
    end;
    TextOut(200, Height div 2, 'Rotated Text!');
  end;
  Rot := rot + 900;
end;

end.
