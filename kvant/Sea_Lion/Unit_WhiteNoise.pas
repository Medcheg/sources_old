unit Unit_WhiteNoise;

interface

type
  TNoiseType = record
    s            : Extended;
    b            : Extended;
    r            : Extended;
    bd           : Extended;
    a1           : Extended;
    a2           : Extended;
    alfa1        : Extended;
    alfa         : Extended;
    alfa0        : Extended;
    b1           : Extended;
    b2           : Extended;
    m            : Extended;

    xk_1         : Extended;
    xk_2         : Extended;
    ix           : LongInt;
    wk           : Extended;
    wk_1         : Extended;

    Max, Min     : Extended;
  end;

Procedure WhiteNoise (var ix : longint; var noise : extended);
procedure Init_WhiteNoise(var NoiseType : TNoiseType;a, lambda, mju,t0 : extended);
Function  GetCurrentNoisePoint(var NoiseType : TNoiseType):single;

implementation

procedure Init_WhiteNoise(var NoiseType : TNoiseType;a, lambda, mju,t0 : extended);
begin
  with NoiseType do begin
     s:= sqrt(A);  //с.к.о.
     m:= mju;  //коэффициент затухания/
     b:= Lambda; //преобладающая частота

     //Коэффициенты рекуррентного уравнения
     r:= exp(-m*T0);
     bd:= b*T0;
     a1:= 2.0*r*cos(bd);
     a2:= -r*r;

     alfa0:= r*(r*r-1.0)*cos(bd) + m/b*(1.0+r*r)*r*sin(bd);
     alfa1:= 1.0 - r*r*r*r -4.0*r*r*m/b*sin(bd)*cos(bd);
     alfa:= Sqrt((alfa1+Sqrt(alfa1*alfa1-4.0*alfa0*alfa0))/2.0);

     b1:= s*alfa;
     b2:= s*alfa0/alfa;

     xk_1:=0.0; xk_2:=0.0;  //Начальные значения

     ix:=9699685+Random(10);         //Нач. значения для датчика сл.чисел
  //   ix:=9699691;         //Нач. значения для датчика сл.чисел
     WhiteNoise (ix,wk_1);
     WhiteNoise (ix,wk);
     Max := -10000000000000;
     Min :=  10000000000000;
  end;
end;

Function  GetCurrentNoisePoint(var NoiseType : TNoiseType):single;
begin
  with NoiseType do begin
      Result := a1*xk_1 + a2*xk_2 + b1*wk + b2*wk_1;

      xk_2:=xk_1; xk_1:=Result; wk_1:=wk;
      WhiteNoise (ix,wk);
      if Max < Result then Max := Result;
      if Min > Result then Min := Result;
  end;
end;

Procedure WhiteNoise (var ix : longint; var noise : extended);
var
   iy   : LongInt;
   i    : byte;
   p    : Extended;

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
            noise := noise + p;
   end; //for i
   noise := noise - 6.0;
END; //Procedure WhiteNoise

end.
