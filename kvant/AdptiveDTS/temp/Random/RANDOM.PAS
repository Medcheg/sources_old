{$S-,I-,V-,B-,Q-}

{ Программа моделирования случайного процесса }
{ типа нерегулярной качки }

VAR
   ix, i, k, Nk : longint;
   s, m, b : real;
   r, bd, a1, a2, b1, b2, alfa, alfa0, alfa1 : real;
   xk, xk_1, xk_2 : real;
   wk, wk_1 : real;
   t, dt: real;
   f: text;

{********************************************************************}
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
END; {Procedure WhiteNoise}

BEGIN
   Assign(f, 'data.prn');
   Rewrite(f);

   s:= 10.0; {с.к.о.}
   b:= 6.28; {преобладающая частота}
   m:= 0.1;  {коэффициент затухания}
   dt:= 0.05; {шаг дискретизации}
   Nk:= 1000; {количество точек}

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
for k:=1 to Nk do
begin
   t:= t + dt;
   xk:= a1*xk_1 + a2*xk_2 + b1*wk + b2*wk_1;
   Writeln(t,'  ',xk);
   Writeln(f,t,'  ',xk);

   {Переприсвоение}
   xk_2:=xk_1; xk_1:=xk; wk_1:=wk;
   WhiteNoise (ix,wk);
end;

   Close(f);

END.
