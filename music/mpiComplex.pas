unit mpiComplex;

interface

type

  TFloat        = Extended;
  TComplex      = record
     re, im : TFloat;
  end;

  TComplexArray  = array of TComplex;
  TComplexMatrix = array of array of TComplex;
  TFloatArray    = array of TFloat;

   function Complex        (re, im : TFloat) : TComplex;

   function ComplexABS     (Complex : TComplex) : TFloat;   // Модуль комплексного числа
   function ComplexSopr    (Complex : TComplex): TComplex;  // Сопряженное комплексное число
   function ComplexInvers  (Complex : TComplex): TComplex;  // Complex := -Complex

   function ComplexMulFloat(Complex : TComplex; Float : TFloat): TComplex;
   function ComplexDivFloat(Complex : TComplex; Float : TFloat): TComplex;

   function ComplexSum(a, b : TComplex) : TComplex;
   function ComplexSub(a, b : TComplex) : TComplex;
   function ComplexMul(a, b : TComplex) : TComplex;
   function ComplexDiv(a, b : TComplex) : TComplex;

implementation

{****************************************************************************************************************************************
}
function Complex(re, im : TFloat) : TComplex;
begin
  Result.re := re;
  Result.im := im;
end;

{****************************************************************************************************************************************
}
function ComplexABS(Complex : TComplex) : TFloat;
begin
  Result := sqrt(sqr(Complex.Re) + sqr(Complex.Im));
end;

{****************************************************************************************************************************************
Комплексное сопряжение}
function ComplexSopr(Complex : TComplex): TComplex;
begin
  Result.re :=  Complex.re;
  Result.im := -Complex.im;
end;

{****************************************************************************************************************************************
}
function ComplexInvers  (Complex : TComplex): TComplex;
begin
  Result.re := -Result.re;
  Result.im := -Result.im;
end;

{****************************************************************************************************************************************
}
function ComplexMulFloat(Complex : TComplex; Float : TFloat): TComplex;
begin
  Result.Re := Complex.re*float;
  Result.im := Complex.im*float;
end;

function ComplexDivFloat(Complex : TComplex; Float : TFloat): TComplex;
begin
  Result.Re := Complex.re/float;
  Result.im := Complex.im/float;
end;
{****************************************************************************************************************************************
Сумма комплексных чисел}
function ComplexSum(a, b : TComplex) : TComplex;
begin
  Result.re := a.re + b.re;
  Result.im := a.im + b.im;
end;

{****************************************************************************************************************************************
Разность комплексных чисел}
function ComplexSub(a, b : TComplex) : TComplex;
begin
  Result.re := a.re - b.re;
  Result.im := a.im - b.im;
end;

{****************************************************************************************************************************************
Умножение комплексных чисел}
function ComplexMul(a, b : TComplex) : TComplex;
begin
  Result.re := a.re*b.re - a.im*b.im;
  Result.im := a.re*b.im + a.im*b.re;
end;

{****************************************************************************************************************************************
}
function ComplexDiv(a, b : TComplex) : TComplex;
var
  q : TFloat;
  p, b_sopr : TComplex;

begin
  q         := (b.re*b.re + b.im*b.im);

  b_sopr    := ComplexSopr(b);
  p         := ComplexMul(a, b_sopr);

  Result.re := p.re / q;
  Result.im := p.im / q;

{  Result.re := (a.re*b.re + a.im*b.im) / q;
  Result.im := (a.im*b.re - a.re*b.im) / q;}
end;

end.
