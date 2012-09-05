unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, TeeProcs, Chart, StdCtrls, ExtCtrls, Menus;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SaveDialog1: TSaveDialog;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
     max, Min : extended;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses Math_, Math, Unit_Vozm;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Button2.Top:=ClientHeight-6-Button2.Height;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  SetDefault;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  count : LongInt;
begin
  Init;
  Count:=0;
  Chart1.BottomAxis.Logarithmic:=False;
  Chart1.LeftAxis.Increment:=0.2;
  Chart1.BottomAxis.Increment:=0.1;
  Max:=0;
  Min:=0;
  Randomize;
  repeat
     //--------- Возмущение ----------
     if form2.RadioButton1.Checked then x[count]:=aa;
     if form2.RadioButton2.Checked then x[count]:=0.1{aa*}*sin(ww*2*pi * count*t0);
     if form2.RadioButton3.Checked then x[count]:=1 + 0.2  *   (random-0.5);

     //----------------------------

     if Form1.RadioButton1.Checked then y[count]:=    y[count-1]+a0*x[count]    +a1*x[count-n-1];

     if Form1.RadioButton2.Checked then y[count]:=  2*y[count-1]  - y[count-2] + a0*x[count]
                                               +a1*x[count-1]+a2*x[count-n-1]+a3*x[count-n-2];

     if max < Y[Count] then max:=y[Count];
     if min > Y[Count] then min:=y[Count];
     Chart1.Series[0].addXY(Count*t0,y[count]);
     if CheckBox1.Checked then Chart1.Series[1].addXY(Count*t0,(x[count]-1)*1.1 +1);
     inc(count);
  until Count>=round(Time/T0);
  if Max=0 then max:=0.1*abs(min);
  if Min=0 then min:=-0.1*max;
  Chart1.LeftAxis.Minimum:=Min*1.1;
  Chart1.LeftAxis.Maximum:=Max*1.1;
   memo1.SetFocus;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  count : LongInt;
  res   : Extended;
  fr    : extended;
  NN    : extended;
begin
  Init;
  Count:=0;
  res:=0;
  Chart1.BottomAxis.Logarithmic:=true;
  Chart1.LeftAxis.Increment:=20;
  Chart1.BottomAxis.Increment:=0;
  Max:=0;
  Min:=0;

  n:=10;
  a0:=1/(n+1);
  a1:=-1/(n+1);
  a2:=0;
  a3:=0;
  repeat
     fr:=freqArray[count]*pi/180{*T0};

     if RadioButton1.Checked then
        try res:=20*log10( sqrt(a0*a0+a1*a1+2*a0*a1*cos(fr*(n+1)))   /   (2*abs(sin(fr/2))) ); except end;

     if RadioButton2.Checked then begin
        NN:=  sqr( a0+a1*cos(fr)+a2*cos(fr*(n+1))+a2*cos(fr*(n+2)))
            + sqr(    a1*sin(fr)+a2*sin(fr*(n+1))+a2*sin(fr*(n+2)));
        try res:=20*log10( sqrt(NN) / (4*sqr(sin(fr/2))) ); except end;
     end;


     if max < res then max:=res;
     if min > res then min:=res;
     Chart1.Series[0].addXY(freqArray[count],res);
     inc(count);
  until Count>=CountFreq;
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  n:=20;
  a0:=1/(n+1);
  a1:=-1/(n+1);
  a2:=0;
  a3:=0;
  Count:=0;
  res:=0;
  repeat
     fr:=freqArray[count]*pi/180{*T0};

     if RadioButton1.Checked then
        try res:=20*log10( sqrt(a0*a0+a1*a1+2*a0*a1*cos(fr*(n+1)))   /   (2*abs(sin(fr/2))) ); except end;

     if RadioButton2.Checked then begin
        NN:=  sqr( a0+a1*cos(fr)+a2*cos(fr*(n+1))+a2*cos(fr*(n+2)))
            + sqr(    a1*sin(fr)+a2*sin(fr*(n+1))+a2*sin(fr*(n+2)));
        try res:=20*log10( sqrt(NN) / (4*sqr(sin(fr/2))) ); except end;
     end;


     if max < res then max:=res;
     if min > res then min:=res;
     Chart1.Series[1].addXY(freqArray[count],res);
     inc(count);
  until Count>=CountFreq;
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  n:=40;
  a0:=1/(n+1);
  a1:=-1/(n+1);
  a2:=0;
  a3:=0;
  Count:=0;
  res:=0;
  repeat
     fr:=freqArray[count]*pi/180{*T0};

     if RadioButton1.Checked then
        try res:=20*log10( sqrt(a0*a0+a1*a1+2*a0*a1*cos(fr*(n+1)))   /   (2*abs(sin(fr/2))) ); except end;

     if RadioButton2.Checked then begin
        NN:=  sqr( a0+a1*cos(fr)+a2*cos(fr*(n+1))+a2*cos(fr*(n+2)))
            + sqr(    a1*sin(fr)+a2*sin(fr*(n+1))+a2*sin(fr*(n+2)));
        try res:=20*log10( sqrt(NN) / (4*sqr(sin(fr/2))) ); except end;
     end;


     if max < res then max:=res;
     if min > res then min:=res;
     Chart1.Series[2].addXY(freqArray[count],res);
     inc(count);
  until Count>=CountFreq;
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ///++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  if Max=0 then max:=0.1*abs(min);
  if Min=0 then min:=-0.1*max;
  Chart1.LeftAxis.Minimum:=Min*1.1;
  Chart1.LeftAxis.Maximum:=Max*1.1;
   memo1.SetFocus;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.ShowModal;
  memo1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Screen.Cursor:=crHourGlass;
   SaveDialog1.Title:='Сохранения текущего графика у файл ...';
   SaveDialog1.Filter:='BitMap file (*.bmp)|*.bmp';

   if SaveDialog1.Execute then begin
       if ExtractFileExt(SaveDialog1.FileName)='' then
                  SaveDialog1.FileName:=SaveDialog1.FileName+'.bmp';
       Chart1.color:=clWhite;
       Chart1.SaveToBitmapFile(SaveDialog1.FileName);
       Chart1.color:=clBtnFace;
   end;
   Screen.Cursor:=crDefault;
   memo1.SetFocus;
end;

procedure TForm1.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = 27 then panel1.visible:=not panel1.visible;
   if key = 113 then Button2Click(nil);
   memo1.SetFocus;
end;

end.
