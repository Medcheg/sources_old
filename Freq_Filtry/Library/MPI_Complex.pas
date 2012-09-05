unit MPI_Complex;

interface

type
  TComplex = record
     re, im : Extended;
  end;

  function Add_C(a, b : TComplex) : TComplex;
  function Sub_C(a, b : TComplex) : TComplex;
  function Mul_C(a, b : TComplex) : TComplex;
  function Div_C(a, b : TComplex) : TComplex;

implementation

function Add_C(a, b : TComplex) : TComplex;
begin
  Result.re := a.re + b.re;
  Result.im := a.im + b.im;
end;

function Sub_C(a, b : TComplex) : TComplex;
begin
  Result.re := a.re - b.re;
  Result.im := a.im - b.im;
end;

function Mul_C(a, b : TComplex) : TComplex;
begin
  Result.re := a.re*b.re - a.im*b.im;
  Result.im := a.re*b.im + a.im*b.re;
end;

function Div_C(a, b : TComplex) : TComplex;
begin
  Result.re := (a.re*b.re + a.im*b.im) / (b.re*b.re + b.im*b.im);
  Result.im := (a.im*b.re - a.re*b.im) / (b.re*b.re + b.im*b.im);
end;


end.