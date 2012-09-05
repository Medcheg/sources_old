unit mpiFilters;

interface

type

TFiltr_100 = class
private
  c0, c1, c2, d1, d2   : Extended;
  y, x                 : array [-2..0] of extended;
public
   procedure Init();
   function Run(aValue : Extended):extended;
end;

implementation

{ TFiltr_100 }

procedure TFiltr_100.Init;
begin
  c0 :=  0.126385199528429;   // 100
  c1 :=  0.252770399056857;
  c2 :=  0.126385199528429;

  d1 := -0.944367393576168;
  d2 :=  0.449908191689882;

  FillChar(y, SizeOf(y), 0);
  FillChar(x, SizeOf(x), 0);
end;

function TFiltr_100.Run(aValue : Extended):extended;
begin
   x[-2] := x[-1];  x[-1] := x[ 0];
   y[-2] := y[-1];  y[-1] := y[ 0];

   x[0]  := aValue;
   y[0]  := -d1*y[-1] - d2*y[-2] + c0*x[0] + c1*x[-1] + c2*x[-2];

   result := y[0];
end;

end.
