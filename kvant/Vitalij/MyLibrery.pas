unit MyLibrery;

interface
uses
    Math;
type Float=Extended{Single};
procedure unr(var x,y:Float);
function G(var j:Extended;BRR,BLL:Extended):Extended;
function FloatToGrad(A: Extended): Extended;
function pel(X1,Y1,X2,Y2:Float):Float;
implementation
function pel(X1,Y1,X2,Y2:Float):Float;                    {может быть полезной}
                                       {пеленг из 1 на 2 от норда по час стрел}
 var x,y,a:Float;
begin

    X:=X2-X1; Y:=Y2-Y1;
     a:=arctan2(y,x);
     if y<0 then pel:=0.5*pi-a else
        if X>=0 then result:=0.5*pi-a else
                     result:=2.5*pi-a;
end;
function FloatToGrad(A: Extended): Extended;
begin
  if A < 0 then result := A + 360
  else if A >= 360 then result := A - 360
  else result := A;
end;
procedure unr(var x,y:Float);
var
  rrav1,
  r,a,b:Float;
begin
  repeat
    rrav1:=random;
  until rrav1 <> 0;
  r:=sqrt(-2*ln(rrav1));
  a:=random;
  b:=sin(6.28318530718*a);
  y:=r*b;b:=sqrt(1-b*b);
  if abs(a-0.5)<0.25 then b:=-b;
  x:=r*b;
end;
function G(var j:Extended;BRR,BLL:Extended):Extended;  {диаграмма включая
                                                                фонов лепестки}
  var A:Extended;
             begin
                  A:=j/BRR;
                  if abs(j)< BRR                      {ВR ширина глав лепестка}
                                                        {ДН в обл глав лепестка}
                  then  result:=-12*A*A else
                                                      {ДН в обл фонов лепестков}
                        result:=BLL{+n}+abs(sin(pi*A));
             end;

end.
