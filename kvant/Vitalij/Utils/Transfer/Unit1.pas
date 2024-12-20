unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, math;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    procedure Edit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    f : textFile;
    Data : array [0..4] of integer;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

Function SumDegrees (s1, s2 : extended) : Extended;
var
 IntS, intS1, IntS2 : Integer;
 ModS, Mods1, Mods2 : Integer;

begin
  intS1 := Trunc (s1);
  intS2 := Trunc (s2);
  IntS  := IntS1 + IntS2;

  ModS1 := Round((s1-IntS1)*100);
  ModS2 := Round((s2-IntS2)*100);
  ModS  := ModS1 + ModS2;
  if ModS > 60 then begin
     ModS := Mods - 60;
     IntS := IntS + 1;
  end;
  Result := IntS + ModS/100;

end;

Function MinusDegrees (s1, s2 : extended) : Extended;
var
 IntS, intS1, IntS2 : Integer;
 ModS, Mods1, Mods2 : Integer;
begin
  intS1 := Trunc (s1);
  intS2 := Trunc (s2);
  IntS  := IntS1 - IntS2;

  ModS1 := Round((s1-IntS1)*100);
  ModS2 := Round((s2-IntS2)*100);
  ModS  := ModS1 - ModS2;
  if ModS < 0 then begin
     ModS := 60 - abs(Mods);
     IntS := IntS - 1;
  end;
  Result := IntS + ModS/100;
end;

procedure TForm1.Edit1Change(Sender: TObject);
var
  d1   : Integer;
  d2   : Integer;
  d3   : Integer;
  d4   : Integer;
  d5   : Integer;
  dd2  : Extended;
  dd3  : Extended;
  dd4  : Extended;
  dd5  : Extended;
begin
  Try
    d1  := StrToInt (Edit1.Text);

    dd2 := StrToFloat (Edit2.Text);
    dd3 := StrToFloat (Edit3.Text);
    dd4 := StrToFloat (Edit4.Text);
    dd5 := StrToFloat (Edit5.Text);

    If CheckBox1.Checked then dd2 := SumDegrees  (90 , dd2)
                            else dd2 := MinusDegrees(90 , dd2);
    If CheckBox2.Checked then dd3 := SumDegrees  (90 , dd3)
                            else dd3 := MinusDegrees(90 , dd3);
    If CheckBox3.Checked then dd4 := MinusDegrees(360, dd4);
    If CheckBox4.Checked then dd5 := MinusDegrees(360, dd5);

    d2  := Trunc(dd2);
    d2  := d2*60 + Round((dd2 - d2) * 100);

    d3  := Trunc(dd3);
    d3  := d3*60 + Round((dd3 - d3) * 100);

    d4  := Trunc(dd4);
    d4  := d4*60 + Round((dd4 - d4) * 100);

    d5  := Trunc(dd5);
    d5  := d5*60 + Round((dd5 - d5) * 100);

    Label1.Caption := intToStr(d1) + ' : ' + intToStr(d2) + ' : ' + intToStr(d3) + ' : '
                                           + intToStr(d4) + ' : ' + intToStr(d5);

    data[0]:=d1;
    data[1]:=d2;
    data[2]:=d3;
    data[3]:=d4;
    data[4]:=d5;

  except

  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    Edit1Change(Nil);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 i : byte;
begin
  assignFile(f, 'Karta.dat');
  Append(f);

  For i:=0 to 4 do begin
    WriteLn(f, FloatToStr(Data[i]));
  end;
  WriteLn(f, '');

  CloseFile(f);
end;

end.
