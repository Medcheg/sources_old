unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 Image1.Picture.LoadFromFile('February.bmp');
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Type
  TRange = set of 0..32;
var
  col : Integer;
  coef : Integer;
  TempY : Byte;
  Range : set of 0..32;
begin
  Col := Integer(Image1.Canvas.Pixels[x,y]);
  Label2.Caption := IntTOStr(Col);
  Coef := (Col - 120) div 5;

  tempY := 0;
  repeat
    Col  := Integer(Image1.Canvas.Pixels[x,y-TempY]);
    Coef := (Col - 120) div 5;
    Inc(TempY);
  until (Coef>=-14) and (coef <= 18) or (TempY>10);

  //if (Coef<-14) or (coef > 18) then
  //        Coef:=0;


  {repeat

    Col  := Integer(Image1.Canvas.Pixels[x,y-TempY]);
    Coef := (Col - 120) div 5;
    if abs(Coef) > 18 then begin
           inc(TempY); Dec(TempY);
    end;

    inc(TempY);
  until (tempY = 10) or (Coef+14 in Range);}


  Label4.Caption := IntToStr(Coef);
end;

end.
