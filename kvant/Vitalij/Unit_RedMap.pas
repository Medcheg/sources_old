unit Unit_RedMap;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TfrmRedMap = class(TForm)
    Image1: TImage;
    PaintBox1: TPaintBox;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    MainX : integer;
    MainY : integer;
    LabelCaption : String;
  public
    procedure SetParam(ACaption, FileName: String; x, y : Integer; sh, dl : String);
  end;

var
  frmRedMap: TfrmRedMap;

implementation

uses MPIDeclaration;

{$R *.DFM}

{ TForm1 }

procedure TfrmRedMap.SetParam(ACaption, FileName: String; x, y : Integer; sh, dl : String);
begin
  Caption := ACaption;
  MainX := X;
  MainY := Y;
  //--------------------------------
  Image1.Picture.Assign(SeasonBitmap);
  Width  := Image1.Picture.Width;
  Height := Image1.Picture.Height + Panel1.Height;
end;

procedure TfrmRedMap.PaintBox1Paint(Sender: TObject);
begin
  With PaintBox1.Canvas Do Begin
    Pen.Color := clWhite;
    Ellipse( MainX-6,
             MainY-6,
             MainX+6,
             MainY+6);
    Pen.Color := clYellow;
    Ellipse(LessX-4,LessY-4, LessX+4, LessY+4);
  end;
{  k1 := GetCoef1;
  k2 := GetCoef2;
  k3 := GetCoef3;
  str1 := 'Ослабление =  ' +  FloatToStrF(k1,ffFixed , 3,3) + '  дБ';
  str2 := 'Ksi    =  ' +  FloatToStrF(k2,ffFixed , 3,3);
  str3 := 'DeltaV =  ' +   IntToStr(k3);
  str4 := '________________';
  str5 := 'Сумма =  ' + FloatToStrF(k1 + k2*k3,ffFixed , 3,3);;

  if Canvas.TextWidth(Str1) > Canvas.TextWidth(Str2) then MaxWidth := Canvas.TextWidth(Str1)
                                                     else MaxWidth := Canvas.TextWidth(Str2);
  if MaxWidth               < Canvas.TextWidth(Str3) then MaxWidth := Canvas.TextWidth(Str3);

  Rect.Left   := LessX + 30;
  Rect.Right  := LessX + 30 + MaxWidth + 10;

  Rect.Top    := LessY - (10 +  Canvas.TextHeight(Str1)*4) div 2;
  Rect.Bottom := LessY -  10 +  Canvas.TextHeight(Str1)*4 + 5;

  With PaintBox1.Canvas Do Begin
    Pen.Color := clYellow;
    Ellipse(LessX-4,LessY-4, LessX+4, LessY+4);

    MoveTo(LessX+4, LessY-4);  LineTo(Rect.Left, Rect.Top);
    MoveTo(LessX+4, LessY+4);  LineTo(Rect.Left, Rect.Bottom);

    FillRect(Rect);
    TextOut(Rect.Left + 5, Rect.Top+5                                , str1);
    TextOut(Rect.Left + 5, Rect.Top+5 + Canvas.TextHeight(Str1)   + 2, str2);
    TextOut(Rect.Left + 5, Rect.Top+5 + Canvas.TextHeight(Str1)*2 + 4, str3);
    TextOut(Rect.Left + 5, Rect.Top+5 + Canvas.TextHeight(Str1)*3 + 4, str4);
    TextOut(Rect.Left + 5, Rect.Top+5 + Canvas.TextHeight(Str1)*4 + 4, str5);
  end;}
end;

procedure TfrmRedMap.PaintBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
 k1     : Extended;
 k2     : Extended;
 k3     : Integer;
 Depression : Extended;
 Dolgota    : String;

 PixelLengthMinuteX   : Single; // ---- Количество минут в одном пикселе ------

 CenterMinuteX           : Single;
 CenterMinuteY           : Single;
 Temp                    : Single;
 Temp1                   : Single;
 CoefY                   : Single;
begin
  LessX       := x;
  LessY       := y;
  LessDist    := 250;
  // ---- Вычисляем текущую широту долготу при движениии мыши ------------
  PixelLengthMinuteX   := (MaxDolgota - OffsetDolgota) / Image1.Width;
  CenterMinuteX := LessX * PixelLengthMinuteX;
  Dolgota :=  intToStr(trunc((OffsetDolgota+CenterMinuteX)/60)) + '.'+ IntToStr(Round(CenterMinuteX) mod 60)[1];

  //-----------
  CoefY := (LessY - 30) / Image1.Height;
  Temp1 := (MaxShirota - OffsetShirota);
  CenterMinuteY := CoefY * Temp1 + OffsetShirota - 90*60;

  Temp := CenterMinuteY;

  if CenterMinuteY < 0 then CenterMinuteY := abs(CenterMinuteY);

  ShirotaString := intToStr(trunc(CenterMinuteY/60)) + '.'+ IntToStr(Round(CenterMinuteY) mod 60)[1];

        if temp < 0 then ShirotaString :=  ShirotaString + 'N'
                    else ShirotaString :=  ShirotaString + 'S';

  LabelCaption :=    'Cannal average depression multiplier at distance 250 km  ( '
                   + 'D : '
                   + Dolgota
                   + '   Sh : '
                   + ShirotaString
                   + ' )';

  Label2.Caption :=  LabelCaption;
  Label2.Left :=  (Panel1.Width - Canvas.TextWidth(LabelCaption)) div 2;


  //---------- Вичисляем коэффициенты -----------------
  LessLambda  := 3;   k1 := GetCoef1; k2 := GetCoef2; k3  := GetCoef3;  Depression  := k1+k2*k3;
  if k3 > -9000 then Label3.Caption := 'I   = ' + IntToStr(Trunc(Depression))+'dB'
                     else Label3.Caption := 'I   = NAN';
  LessLambda  := 5;   k1 := GetCoef1; k2 := GetCoef2; k3  := GetCoef3;  Depression  := k1+k2*k3;
  if k3 > -9000 then Label4.Caption := 'G   = ' + IntToStr(Trunc(Depression))+'dB'
                     else Label4.Caption := 'G   = NAN';

  LessLambda  := 10;  k1 := GetCoef1; k2 := GetCoef2; k3  := GetCoef3;  Depression  := k1+k2*k3;
  if k3 > -9000 then Label5.Caption := 'E/F = ' + IntToStr(Trunc(Depression))+'dB'
                     else Label5.Caption := 'E/F = NAN';

  LessLambda  := 20;  k1 := GetCoef1; k2 := GetCoef2; k3  := GetCoef3;  Depression  := k1+k2*k3;
  if k3 > -9000 then Label6.Caption := 'D   = ' + IntToStr(Trunc(Depression))+'dB'
                     else Label6.Caption := 'D   = NAN';

  LessLambda  := 25;  k1 := GetCoef1; k2 := GetCoef2; k3  := GetCoef3;  Depression  := k1+k2*k3;
  if k3 > -9000 then Label7.Caption := 'D/C = ' + IntToStr(Trunc(Depression))+'dB'
                     else Label7.Caption := 'D/C = NAN';
  PaintBox1.RePaint;
end;

end.
