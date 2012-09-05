unit glob_2;
  { начальные значения переменных}

interface
Uses matfun;
type
    arr_a=array [1..68] of real;
var
  q0                 : arr_a;
  ha,lam,re,rz, eps  : real;
  ppol               : byte;

  procedure initzonvidvar;  {установка начальных значений}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
implementation

uses umain, SysUtils;

procedure initzonvidvar;
var
   h,EL,LeLe : real;
   i         : byte;
begin
  for i := 1 to 68 do q0[i] := 0;

  ha     := StrToFloat(FmMain.edHa.Text) {9}; (*15, 20, 25*)        (* m *)
  rz     := 6400.0;
  re     := 8500.0;
  lam    := StrToFloat(FmMain.edLam.Text) {0.035};      (* m *)
  LeLe   := sqr(lam/(4*pi));
  h      := 0.5*exp(ln(re*sqr(lam*1e-3)/sqr(pi))/3.0);
  EL     := exp(ln(sqr(re)*lam*1e-3/pi)/3.0);
  q0[14] := StrToFloat(FmMain.edH.Text)*1e-3; ///0.2*1e-3;  (* km *)
  q0[8]  := ha*1e-3;
  q0[11] := re;
  q0[12] := rz;
  q0[13] := lam*1e-3;
  q0[15] := 3.0*pi/180;
  q0[16] := 0.0211;
  q0[26] := q0[14]*pi/(lam*1e-3);
  q0[27] := EL;
  q0[28] := h;
  q0[29] := 2.0*pi/(lam*1e-3);
  ppol   := 2;
  eps    := 80;
end;

end.


