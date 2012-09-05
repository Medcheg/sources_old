unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TForm1 = class(TForm)
    Chart1: TChart;
    Series1: TFastLineSeries;
    BitBtn1: TBitBtn;
    Series2: TFastLineSeries;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

Procedure WhiteNoise (var ix : longint; var noise : real);
var
   iy : longint;
   i, k : byte;
   p : real;

begin
   noise:=0.0;
   for i:=1 to 12 do
   begin
        {$R-}
        iy:= ix*65539;
        if iy<0 then iy:= iy + 2147483647 + 1;
        {$R+}
            ix:= iy;
            p:=  iy / 2147483647;
            noise:= noise + p;
   end; { for i }
   noise:= noise - 6.0;
//   noise := Noise/2;
END; {Procedure WhiteNoise}

procedure TForm1.BitBtn1Click(Sender: TObject);
{ Программа моделирования случайного процесса }
{ типа нерегулярной качки }
var
   ix, i, k, Nk : longint;
   s, m, b : real;
   r, bd, a1, a2, b1, b2, alfa, alfa0, alfa1 : real;
   xk, xk_1, xk_2 : real;
   wk, wk_1 : real;
   t, dt: real;
   Time : extended;

begin
   Randomize;
   s:= 0.01674; {с.к.о.}
   s:= sqrt(0.01674); {с.к.о.}
   b:= 0.7*2*pi;  {преобладающая частота}
   m:= 0.1;       {коэффициент затухания}

   dt:= 0.001;     {шаг дискретизации}
   Time:= 10;

   {Коэффициенты рекуррентного уравнения}
   r:= exp(-m*dt);
   bd:= b*dt;
   a1:= 2.0*r*cos(bd);
   a2:= -r*r;

   alfa0:= r*(r*r-1.0)*cos(bd) + m/b*(1.0+r*r)*r*sin(bd);
   alfa1:= 1.0 - r*r*r*r -4.0*r*r*m/b*sin(bd)*cos(bd);
   alfa:= Sqrt((alfa1+Sqrt(alfa1*alfa1-4.0*alfa0*alfa0))/2.0);

   b1:= s*alfa;
   b2:= s*alfa0/alfa;

   xk_1:=0.0; xk_2:=0.0;  {Начальные значения}
   t:=0;

        ix:=9699691;         {Нач. значения для датчика сл.чисел}
        WhiteNoise (ix,wk_1);
        WhiteNoise (ix,wk);


   {Моделирование}
   Chart1.Series[0].Clear;
//   Chart1.Series[1].Clear;
   Application.ProcessMessages;
    for k:=1 to Round(Time/dt) do begin
       t:= t + dt;
       xk:= a1*xk_1 + a2*xk_2 + b1*wk + b2*wk_1;
       Chart1.Series[0].Addxy(t, xk);
//       Chart1.Series[1].Addxy(t, wk);

       {Переприсвоение}
       xk_2:=xk_1; xk_1:=xk; wk_1:=wk;
       WhiteNoise (ix,wk);
    end;

end;
end.
