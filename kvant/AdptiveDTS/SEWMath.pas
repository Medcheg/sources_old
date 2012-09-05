unit SEWMath;

interface

uses
  Windows, Math;

function GetQurs (X1, Y1, X2, Y2  : Extended) : Extended ;
function GetDn (X1, Y1, H1, X2, Y2, H2  : Extended) : Extended ;
procedure GetLineCoefficients (X1, Y1, X2, Y2  : LongInt; k, b  : PExtended);
function Direct_dB (AVAlue  : Extended) : Extended;
function Reverse_dB (AVAlue  : Extended) : Extended;

implementation

{---------------------------------------------------------------------- GetQurs}
function GetQurs (X1, Y1, X2, Y2  : Extended) : Extended ;
var
  dX, dY  : Extended ;
  Qurs    : Extended ;
begin
  dX := X2 - X1 ;
  dY := Y2 - Y1 ;
  if dY = 0 then
    if dX > 0 then
      Qurs := Pi / 2
     else
      Qurs := Pi * 3 / 2
   else
    begin
      Qurs := ArcTan (dX / dY) ;

      if (dY > 0) and (dX >= 0) then
        Qurs := Qurs ;
      if (dY < 0) and (dX >= 0) then
        Qurs := Qurs + Pi ;
      if (dY < 0) and (dX < 0) then
        Qurs := Qurs + Pi ;
      if (dY > 0) and (dX < 0) then
        Qurs := Qurs + 2 * Pi ;
    end ;

  Result := Qurs ;  
end ;

{------------------------------------------------------------------------ GetDn}
function GetDn (X1, Y1, H1, X2, Y2, H2  : Extended) : Extended ;
var
  D1, D2, D3  : Extended ;
begin
  D1 := X2-X1 ;
  D2 := Y2-Y1 ;
  D3 := H2-H1 ;
  Result := Sqrt (Sqr (D1) + Sqr (D2) + Sqr (D3)) ;
end ;

{---------------------------------------------------------- GetLineCoefficients}
procedure GetLineCoefficients (X1, Y1, X2, Y2  : LongInt; k, b  : PExtended);
var
  DeltaX  : LongInt;
  DeltaY  : LongInt;
begin
  DeltaX := X2 - X1;
  DeltaY := Y2 - Y1;

  if DeltaX = 0 then
    k^ := DeltaY
   else
    k^ := DeltaY / DeltaX;
  k^ := Trunc (k^ * 10000) / 10000 ;
  b^ := Y2 - k^ * X2;
end;

{-------------------------------------------------------------------- Direct_dB}
function Direct_dB (AVAlue  : Extended) : Extended;
begin
  Result := 10 * Log10 (AValue)
end;

{------------------------------------------------------------------- Reverse_dB}
function Reverse_dB (AVAlue  : Extended) : Extended;
begin
  Result := Power (10, AValue * 0.1);
end;

end.
