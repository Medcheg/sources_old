unit MPIDeclaration;

interface

uses MPITypes, stdctrls, Dialogs;

const
  //p = 1000*1000;
  //= 1000*1000;
  p = 1;


type
  TZTrans = class
  private

    procedure  Calc_aCoef();
    procedure  Calc_zCoef();
    procedure  Calc_wCoef();
    procedure  Calc_wCoef_Korec();
    procedure  Calc_zCoef_Korec();

    function   Calc_wCoef_ch_zn(a: TArray; Chislit : Boolean): TArray; // --- Отдельный счет числителя, знаменателя ---

    function  Get_Coef_a1: TComplex;
    function  Get_Coef_a2: TComplex;
    function  Get_Coef_a4: TComplex;
    function  Get_Coef_a6: TComplex;
    function  Get_Coef_a8: TComplex;
    function  Get_Coef_a10: TComplex;
    function  Get_Coef_a12: TComplex;
  public
    //---- Функции для выводов графиков ------
    function  Get_Coef_T_2_4e_and_Zetta_2_4e(t0, t2, ksi2 : Extended): TTwoValues;
    //-----------------------

    procedure Calc();
    constructor create;
    destructor destroy; override;
  end;

var
  ZTransform  : TZTrans;
  CountExcept : Integer;

  //---------------
  proverka    : Extended;
  ZOrder      : Integer;
  //---------------

implementation

function MyExp(Value : Extended): Extended;
{var
  order : Integer;
  i,k   : Integer;

  chis  : Extended;
  znam  : Extended;
  Sum   : Extended;}
begin
{  order := 5;

  znam := 1;
  chis := 1;
  sum  := 1;
  for i:=1 to order do begin
    znam := 1;
    for k:=1 to i do znam := znam * k;

    chis := chis * (value);
    sum := sum + chis/znam;
  end;

  result := sum;}
  result := exp(Value);
end;

{ TZTrans }

procedure TZTrans.Calc();
begin
    CountExcept := 0;
    fillChar(zCoef.a, SizeOf(zCoef.a),0);
    Calc_aCoef();
    Calc_zCoef();
    Calc_wCoef();
    //Calc_Roots();
    Calc_wCoef_Korec();
    Calc_zCoef_Korec();
end;

procedure TZTrans.Calc_aCoef;
begin
    Coef.a1  := Get_Coef_A1();
    Coef.a2  := Get_Coef_A2();  Coef.a3.Re  :=  Coef.a2.Re;  Coef.a3.Im  := -Coef.a2.Im;
    Coef.a4  := Get_Coef_A4();  Coef.a5.Re  :=  Coef.a4.Re;  Coef.a5.Im  := -Coef.a4.Im;
    Coef.a6  := Get_Coef_A6();
    Coef.a8  := Get_Coef_A8();
    Coef.a10 := Get_Coef_A10();
    Coef.a12 := Get_Coef_A12();

    // --------- Определяю порядок системы --------
    ZOrder := 0;
    if (Coef.a2.re  <> 0) or (Coef.a2.im  <> 0) then ZOrder := ZOrder+1;
    if (Coef.a3.re  <> 0) or (Coef.a3.im  <> 0) then ZOrder := ZOrder+1;
    if (Coef.a4.re  <> 0) or (Coef.a4.im  <> 0) then ZOrder := ZOrder+1;
    if (Coef.a5.re  <> 0) or (Coef.a5.im  <> 0) then ZOrder := ZOrder+1;
    if (Coef.a6.re  <> 0) or (Coef.a6.im  <> 0) then ZOrder := ZOrder+1;
    if (Coef.a8.re  <> 0) or (Coef.a8.im  <> 0) then ZOrder := ZOrder+1;
    if (Coef.a10.re <> 0) or (Coef.a10.im <> 0) then ZOrder := ZOrder+1;
    if (Coef.a12.re <> 0) or (Coef.a12.im <> 0) then ZOrder := ZOrder+1;
end;

constructor TZTrans.create;
begin
//----------
end;

destructor TZTrans.destroy;
begin
//----------
  inherited destroy;
end;

function TZTrans.Get_Coef_a1: TComplex;
begin
  Result.Re := OC.k;
  Result.Im := 0;
end;

function TZTrans.Get_Coef_a2: TComplex;
var
  b1, b2, b3, b4, b5, b6, b7, b8, b9, b10               : Extended;
  m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12 : Extended;

  c1, c2 : Extended;
  d1, d2 : Extended;
  n1, n2 : Extended;

  p1, p2, p3, p4, p5, p6 : Extended;

  f1, f2 : extended;
begin

  if OC.t2 = 0 then begin
    Coef.L2 := 0;
    Coef.L3 := 0;
    Result.Re :=  Coef.L2;
    Result.Im :=  Coef.L3;

    inc(CountExcept);
    exit;
  end;

  m0  := 2*sqrt(1- OC.ksi2*OC.ksi2)/OC.t2;
  m1  := - OC.ksi2;
  m2  := sqrt(1- OC.ksi2*OC.ksi2);
  m3  := ((OC.t2*OC.t2-OC.t4*OC.t4) - 2*OC.ksi2*OC.t4*(OC.ksi4*OC.t2 - OC.ksi2*OC.t4));
  m4  := 2*sqrt(1- OC.ksi2*OC.ksi2)*OC.t4*(OC.ksi4*OC.t2 - OC.ksi2*OC.t4);
  m5  := (OC.t2 - OC.ksi2*OC.t6);
  m6  := OC.t6*sqrt(1- OC.ksi2*OC.ksi2);
  m7  := OC.t2 - OC.ksi2*OC.t8;
  m8  := OC.t8*sqrt(1- OC.ksi2*OC.ksi2);
  m9  := OC.t2 - OC.ksi2*OC.t10;
  m10 := OC.t10 * sqrt(1- OC.ksi2*OC.ksi2);
  m11 := OC.t2 - OC.ksi2*OC.t12;
  m12 := OC.t12 * sqrt(1- OC.ksi2*OC.ksi2);

  b1  := (OC.t2*OC.t2-OC.t1*OC.t1) - 2*OC.ksi2*OC.t1*(OC.ksi1*OC.t2 - OC.ksi2*OC.t1);
  b2  := 2*sqrt(1- OC.ksi2*OC.ksi2)*OC.t1*(OC.ksi1*OC.t2 - OC.ksi2*OC.t1);
  b3  := (OC.t2*OC.t2-OC.t3*OC.t3) - 2*OC.ksi2*OC.t3*(OC.ksi3*OC.t2 - OC.ksi2*OC.t3);
  b4  := 2*sqrt(1- OC.ksi2*OC.ksi2)*OC.t3*(OC.ksi3*OC.t2 - OC.ksi2*OC.t3);
  b5  := (OC.t2 - OC.ksi2*OC.t5);
  b6  := OC.t5*sqrt(1- OC.ksi2*OC.ksi2);
  b7  := OC.t2 - OC.ksi2*OC.t7;
  b8  := OC.t7*sqrt(1- OC.ksi2*OC.ksi2);
  b9  := OC.t2 - OC.ksi2*OC.t9;
  b10 := OC.t9 * sqrt(1- OC.ksi2*OC.ksi2);

  c1 := b1*b3 - b2*b4;
  c2 := b1*b4 + b2*b3;

  d1 := b9 *(b5*b7 - b6*b8) - b10*(b6*b7 + b5*b8);
  d2 := b10*(b5*b7 - b6*b8) + b9 *(b6*b7 + b5*b8);

  n1 := c1*d1 - c2*d2;
  n2 := c2*d1 + c1*d2;

  p1 := m1 *m3  - m2 *m4;
  p2 := m2 *m3  + m1 *m4;
  p3 := m5 *m7  - m6 *m8;
  p4 := m6 *m7  + m5 *m8;
  p5 := m9 *m11 - m10*m12;
  p6 := m10*m11 + m9 *m12;

  f1 := p5*(p1*p3-p2*p4) - p6*(p2*p3+p1*p4);
  f2 := p5*(p2*p3+p1*p4) + p6*(p1*p3-p2*p4);

  if OC.t2*OC.t2*m0*(f1*f1+f2*f2) = 0 then begin
    Coef.L2 := 0;
    Coef.L3 := 0;
    inc(CountExcept);
  end else begin
    Coef.L2 :=  OC.k/(OC.t2*OC.t2*m0*(f1*f1+f2*f2))*(n2*f1-n1*f2);
    Coef.L3 := -OC.k/(OC.t2*OC.t2*m0*(f1*f1+f2*f2))*(n1*f1+n2*f2);
  end;

  Result.Re :=  Coef.L2;
  Result.Im :=  Coef.L3;
end;

function TZTrans.Get_Coef_a4: TComplex;
var
  e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12 : Extended;
  g1, g2, g3, g4, g5, g6                                : Extended;
  r1, r2, r3, r4, r5, r6, r7, r8, r9, r10              : Extended;

  h1, h2 : Extended;
  v1, v2 : Extended;
  s2, s1 : Extended;
  f3, f4 : Extended;
begin
  if oc.t4 = 0 then begin
    Coef.L4 := 0;
    Coef.L5 := 0;
    Result.Re :=  Coef.L4;
    Result.Im :=  Coef.L5;

    inc(CountExcept);
    exit;
  end;

  e0  := 2*sqrt(1-oc.ksi4*oc.ksi4)/oc.t4;
  e1  := -oc.ksi4;
  e2  := sqrt(1-oc.ksi4*oc.ksi4);
  e3  := (oc.t4*oc.t4 - oc.t2*oc.t2) - 2*oc.ksi4*oc.t2*(oc.ksi2*oc.t4-oc.ksi4*oc.t2);
  e4  := 2*sqrt(1-oc.ksi4*oc.ksi4)*oc.t2*(oc.ksi2*oc.t4-oc.ksi4*oc.t2);
  e5  := oc.t4 - oc.ksi4*oc.t6;
  e6  := oc.t6*sqrt(1-oc.ksi4*oc.ksi4);
  e7  := oc.t4 - oc.ksi4*oc.t8;
  e8  := oc.t8*sqrt(1-oc.ksi4*oc.ksi4);
  e9  := oc.t4 - oc.ksi4*oc.t10;
  e10 := oc.t10*sqrt(1-oc.ksi4*oc.ksi4);
  e11 := oc.t4 - oc.ksi4*oc.t12;
  e12 := oc.t12*sqrt(1-oc.ksi4*oc.ksi4);

  g1  := e1 *e3  - e2 *e4 ;
  g2  := e2 *e3  + e1 *e4 ;
  g3  := e5 *e7  - e6 *e8 ;
  g4  := e6 *e7  + e5 *e8 ;
  g5  := e9 *e11 - e10*e12;
  g6  := e10*e11 + e9 *e12;

  f3 := g5*(g1*g3-g2*g4) - g6*(g2*g3 + g1*g4);
  f4 := g5*(g2*g3+g1*g4) + g6*(g1*g3 - g2*g4);

  r1  := (oc.t4*oc.t4 - oc.t1*oc.t1) - 2*oc.ksi4*oc.t1*(oc.ksi1*oc.t4-oc.ksi4*oc.t1);
  r2  := 2*sqrt(1-oc.ksi4*oc.ksi4)*oc.t1*(oc.ksi1*oc.t4-oc.ksi4*oc.t1);
  r3  := (oc.t4*oc.t4 - oc.t3*oc.t3) - 2*oc.ksi4*oc.t3*(oc.ksi3*oc.t4-oc.ksi4*oc.t3);
  r4  := 2*sqrt(1-oc.ksi4*oc.ksi4)*oc.t3*(oc.ksi3*oc.t4-oc.ksi4*oc.t3);
  r5  := oc.t4 - oc.ksi4*oc.t5;
  r6  := oc.t5*sqrt(1-oc.ksi4*oc.ksi4);
  r7  := oc.t4 - oc.ksi4*oc.t7;
  r8  := oc.t7*sqrt(1-oc.ksi4*oc.ksi4);
  r9  := oc.t4 - oc.ksi4*oc.t9;
  r10 := oc.t9*sqrt(1-oc.ksi4*oc.ksi4);

  v1 := (r1*r3 - r2*r4);
  v2 := (r1*r4 + r2*r3);

  h1 := r9 *(r5*r7 - r6*r8) - r10*(r6*r7 + r5*r8);
  h2 := r10*(r5*r7 - r6*r8) + r9 *(r6*r7 + r5*r8);

  s1 := v1*h1 - v2*h2;
  s2 := v2*h1 + v1*h2;

  if OC.t4*OC.t4*e0*(f3*f3+f4*f4) = 0 then begin
    Coef.L4 := 0;
    Coef.L5 := 0;
    inc(CountExcept);
  end else begin
    Coef.L4 :=  OC.k/(OC.t4*OC.t4*e0*(f3*f3+f4*f4))*(s2*f3-s1*f4);
    Coef.L5 := -OC.k/(OC.t4*OC.t4*e0*(f3*f3+f4*f4))*(s1*f3+s2*f4);
  end;

  Result.Re :=  Coef.L4;
  Result.Im :=  Coef.L5;
end;

function TZTrans.Get_Coef_a6: TComplex;
begin
  if (OC.t6-OC.t8  = 0) or
     (OC.t6-OC.t10 = 0) or
     (OC.t6-OC.t12 = 0) or
     (OC.t2*OC.t2-2*OC.ksi2*OC.t2*OC.t6 +OC.t6*OC.t6 = 0) or
     (OC.t4*OC.t4-2*OC.ksi4*OC.t4*OC.t6 +OC.t6*OC.t6 = 0) then begin Result.Re := 0; inc(CountExcept); end
                                                          else Result.Re := -OC.k*(OC.t1*OC.t1-2*OC.ksi1*OC.t1*OC.t6 +OC.t6*OC.t6  )*(OC.t3*OC.t3-2*OC.ksi3*OC.t3*OC.t6 +OC.t6*OC.t6  )*(OC.t6 -OC.t5)*(OC.t6 -OC.t7)*(OC.t6 -OC.t9)/(OC.t2*OC.t2-2*OC.ksi2*OC.t2*OC.t6 +OC.t6*OC.t6  )/(OC.t4*OC.t4-2*OC.ksi4*OC.t4*OC.t6 +OC.t6*OC.t6  )/(OC.t6-OC.t8)/(OC.t6-OC.t10)/(OC.t6-OC.t12);
  Result.Im := 0;
end;

function TZTrans.Get_Coef_a8: TComplex;
begin
  if (OC.t8-OC.t6  = 0) or
     (OC.t8-OC.t10 = 0) or
     (OC.t8-OC.t12 = 0) or
     (OC.t2*OC.t2-2*OC.ksi2*OC.t2*OC.t8 +OC.t8*OC.t8 = 0) or
     (OC.t4*OC.t4-2*OC.ksi4*OC.t4*OC.t8 +OC.t8*OC.t8 = 0) then begin Result.Re := 0; inc(CountExcept); end
                                                          else Result.Re := -OC.k*(OC.t1*OC.t1-2*OC.ksi1*OC.t1*OC.t8 +OC.t8*OC.t8  )*(OC.t3*OC.t3-2*OC.ksi3*OC.t3*OC.t8 +OC.t8*OC.t8  )*(OC.t8 -OC.t5)*(OC.t8 -OC.t7)*(OC.t8 -OC.t9)/(OC.t2*OC.t2-2*OC.ksi2*OC.t2*OC.t8 +OC.t8*OC.t8  )/(OC.t4*OC.t4-2*OC.ksi4*OC.t4*OC.t8 +OC.t8*OC.t8  )/(OC.t8 -OC.t6)/(OC.t8 -OC.t10)/(OC.t8-OC.t12);
  Result.Im := 0;
end;

function TZTrans.Get_Coef_a10: TComplex;
begin
  if (OC.t10-OC.t6  = 0) or
     (OC.t10-OC.t8  = 0) or
     (OC.t10-OC.t12 = 0) or
     (OC.t2*OC.t2-2*OC.ksi2*OC.t2*OC.t10+OC.t10*OC.t10 = 0) or
     (OC.t4*OC.t4-2*OC.ksi4*OC.t4*OC.t10+OC.t10*OC.t10 = 0) then begin Result.Re := 0; inc(CountExcept); end
                                                            else Result.Re := -OC.k*(OC.t1*OC.t1-2*OC.ksi1*OC.t1*OC.t10+OC.t10*OC.t10)*(OC.t3*OC.t3-2*OC.ksi3*OC.t3*OC.t10+OC.t10*OC.t10)*(OC.t10-OC.t5)*(OC.t10-OC.t7)*(OC.t10-OC.t9)/(OC.t2*OC.t2-2*OC.ksi2*OC.t2*OC.t10+OC.t10*OC.t10)/(OC.t4*OC.t4-2*OC.ksi4*OC.t4*OC.t10+OC.t10*OC.t10)/(OC.t10-OC.t6)/(OC.t10-OC.t8 )/(OC.t10-OC.t12);
  Result.Im := 0;
end;

function TZTrans.Get_Coef_a12: TComplex;
begin
  if (OC.t12-OC.t6  = 0) or
     (OC.t12-OC.t8  = 0) or
     (OC.t12-OC.t10 = 0) or
     (OC.t2*OC.t2-2*OC.ksi2*OC.t2*OC.t12+OC.t12*OC.t12 = 0) or
     (OC.t4*OC.t4-2*OC.ksi4*OC.t4*OC.t12+OC.t12*OC.t12 = 0) then begin Result.Re := 0; inc(CountExcept); end
                                                            else Result.Re := -OC.k*(OC.t1*OC.t1-2*OC.ksi1*OC.t1*OC.t12+OC.t12*OC.t12)*(OC.t3*OC.t3-2*OC.ksi3*OC.t3*OC.t12+OC.t12*OC.t12)*(OC.t12-OC.t5)*(OC.t12-OC.t7)*(OC.t12-OC.t9)/(OC.t2*OC.t2-2*OC.ksi2*OC.t2*OC.t12+OC.t12*OC.t12)/(OC.t4*OC.t4-2*OC.ksi4*OC.t4*OC.t12+OC.t12*OC.t12)/(OC.t12-OC.t6)/(OC.t12-OC.t8 )/(OC.t12-OC.t10);
  Result.Im := 0;
end;

function TZTrans.Get_Coef_T_2_4e_and_Zetta_2_4e(t0, t2,
  ksi2: Extended): TTwoValues;
var
 a, b     : Extended;
 e_x_p    : Extended;
 argument : Extended;
 gamma    : Extended;
begin
  if t2 = 0 then begin
     result.val1 := 0;
     result.val2 := 0;
     exit;
  end;
  gamma       := t0/t2;

  e_x_p       := MyExp(-ksi2*gamma);
  argument    := gamma*sqrt(1-ksi2*ksi2);

  a           := 1 + 2*e_x_p*cos(argument) + e_x_p*e_x_p;
  b           := 1 - 2*e_x_p*cos(argument) + e_x_p*e_x_p;

  result.val1 := t0/2 * sqrt(a/b);
  result.val2 := (1 - e_x_p*e_x_p) / sqrt(a*b);
end;

procedure TZTrans.Calc_zCoef;
var
  d6, d8, d10, d12 : Extended;
  h2, h3, h4, h5   : Extended;
  l2, l3, l4, l5   : Extended;

  _exp, arg        : Extended;
  n, i             : Integer;
  ZOrder1          : Integer; // --- Порядок числителя
  ZOrder2          : Integer; // --- Порядок знаменателя ----
  a                : array [0..8] of Extended;
  b                : array [0..8] of Extended;
  a1   : Extended;
  a6   : Extended;
  a8   : Extended;
  a10  : Extended;
  a12  : Extended;
begin
  if coef.a6 .re = 0 then d6 := 0 else d6  := MyExp(-MainT0/oc.t6);
  if coef.a8 .re = 0 then d8 := 0 else d8  := MyExp(-MainT0/oc.t8);
  if coef.a10.re = 0 then d10:= 0 else d10 := MyExp(-MainT0/oc.t10);
  if coef.a12.re = 0 then d12:= 0 else d12 := MyExp(-MainT0/oc.t12);
  //---------------------
  h2   := 2*coef.L2;
  h4   := 2*coef.L4;
  //---------------------
  if coef.a2.re = 0 then begin
      h3   := 0;
      l2   := 0;
      l3   := 0;
  end else begin
      _exp := MyExp(-oc.ksi2*MainT0/oc.t2);
      arg  := MainT0/oc.t2*sqrt(1-oc.ksi2*oc.ksi2);

      h3   := 2*_exp*(coef.L2*cos(arg) + coef.L3*sin(arg));
      l2   := 2*_exp*cos(arg);
      l3   := _exp*_exp;
  end;
  //---------------------
  if coef.a4.re = 0 then begin
      h5   := 0;
      l4   := 0;
      l5   := 0;
  end else begin
      _exp := MyExp(-oc.ksi4*MainT0/oc.t4);
      arg  := MainT0/oc.t4*sqrt(1-oc.ksi4*oc.ksi4);

      h5   := 2*_exp*(coef.L4*cos(arg) + coef.L5*sin(arg));
      l4   := 2*_exp*cos(arg);
      l5   := _exp*_exp;
  end;

  a1   := coef.A1.re;
  a12  := coef.A12.re;
  a6   := coef.A6.re;
  a8   := coef.A8.re;
  a10  := coef.A10.re;

  a[0] := A1*l3*l5*d6*d8*d10*d12*p
          +h3*l5*d6*d8*d10*d12*p
          +h5*l3*d6*d8*d10*d12*p
          +A6*l3*l5*d8*d10*d12*p
          +A8*l3*l5*d6*d10*d12*p
          +A10*l3*l5*d6*d8*d12*p
          +A12*l3*l5*d6*d8*d10*p;
  a[1] := (-A1*l3*l4*d6*d8*d10*d12-A1*l3*l5*d6*d8*d12-A1*l3*l5*d6*d10*d12-A1*l2*l5*d6*d8*d10*d12-A1*l3*l5*d6*d8*d10-A1*l3*l5*d8*d10*d12)*p
          +(-h3*l5*d8*d10*d12-h3*l5*d6*d8*d12-h3*l5*d6*d8*d10*d12-h3*l4*d6*d8*d10*d12-h3*l5*d6*d8*d10-h2*l5*d6*d8*d10*d12-h3*l5*d6*d10*d12)*p
          +(-h5*l3*d6*d10*d12-h5*l3*d6*d8*d10*d12-h4*l3*d6*d8*d10*d12-h5*l2*d6*d8*d10*d12-h5*l3*d8*d10*d12-h5*l3*d6*d8*d12-h5*l3*d6*d8*d10)*p
          +(-A6*l2*l5*d8*d10*d12-A6*l3*l5*d10*d12-A6*l3*l5*d8*d10-A6*l3*l4*d8*d10*d12-A6*l3*l5*d8*d10*d12-A6*l3*l5*d8*d12)*p
          +(-A8*l3*l5*d6*d10-A8*l3*l4*d6*d10*d12-A8*l3*l5*d6*d10*d12-A8*l3*l5*d10*d12-A8*l2*l5*d6*d10*d12-A8*l3*l5*d6*d12)*p
          +(-A10*l2*l5*d6*d8*d12-A10*l3*l5*d6*d12-A10*l3*l5*d6*d8*d12-A10*l3*l4*d6*d8*d12-A10*l3*l5*d8*d12-A10*l3*l5*d6*d8)*p
          +(-A12*l3*l5*d6*d8-A12*l2*l5*d6*d8*d10-A12*l3*l5*d8*d10-A12*l3*l5*d6*d8*d10-A12*l3*l5*d6*d10-A12*l3*l4*d6*d8*d10)*p;
  a[2] := (A1*l3*l4*d6*d10*d12+A1*l3*l4*d8*d10*d12+A1*l3*l5*d8*d12+A1*l3*d6*d8*d10*d12+A1*l3*l4*d6*d8*d12+A1*l2*l5*d6*d8*d10+A1*l2*l4*d6*d8*d10*d12+A1*l2*l5*d6*d8*d12+A1*l3*l5*d6*d10+A1*l3*l5*d10*d12+A1*l2*l5*d8*d10*d12+A1*l3*l4*d6*d8*d10+A1*l5*d6*d8*d10*d12+A1*l3*l5*d8*d10+A1*l3*l5*d6*d12+A1*l2*l5*d6*d10*d12+A1*l3*l5*d6*d8)*p
          +(h3*l5*d6*d10*d12+h3*l5*d6*d8+h3*l4*d6*d8*d12+h3*l4*d6*d8*d10*d12+h3*l5*d6*d8*d10+h3*l4*d6*d8*d10+h2*l5*d6*d10*d12+h2*l5*d6*d8*d10*d12+h3*l5*d8*d10*d12+h2*l4*d6*d8*d10*d12+h3*l5*d6*d12+h3*l5*d8*d12+h3*d6*d8*d10*d12+h2*l5*d6*d8*d12+h3*l5*d6*d8*d12+h2*l5*d8*d10*d12+h3*l5*d6*d10+h3*l4*d8*d10*d12+h2*l5*d6*d8*d10+h3*l4*d6*d10*d12+h3*l5*d8*d10+h3*l5*d10*d12)*p
          +(h4*l3*d6*d8*d10*d12+h5*l2*d8*d10*d12+h5*l3*d8*d12+h5*l3*d6*d10+h5*l3*d6*d12+h5*l2*d6*d8*d10*d12+h5*l3*d8*d10+h4*l3*d6*d10*d12+h5*l3*d6*d8+h5*l3*d6*d8*d10+h5*l3*d10*d12+h4*l3*d6*d8*d12+h5*l3*d6*d8*d12+h4*l3*d6*d8*d10+h5*l2*d6*d10*d12+h4*l2*d6*d8*d10*d12+h4*l3*d8*d10*d12+h5*d6*d8*d10*d12+h5*l2*d6*d8*d10+h5*l3*d8*d10*d12+h5*l3*d6*d10*d12+h5*l2*d6*d8*d12)*p
          +(A6*l3*d8*d10*d12+A6*l2*l5*d10*d12+A6*l3*l5*d8*d10+A6*l3*l4*d10*d12+A6*l3*l4*d8*d10+A6*l5*d8*d10*d12+A6*l3*l5*d10+A6*l3*l5*d8+A6*l3*l5*d10*d12+A6*l3*l5*d12+A6*l2*l5*d8*d10*d12+A6*l2*l5*d8*d10+A6*l2*l4*d8*d10*d12+A6*l3*l4*d8*d10*d12+A6*l3*l5*d8*d12+A6*l3*l4*d8*d12+A6*l2*l5*d8*d12)*p
          +(A8*l3*l4*d6*d12+A8*l3*d6*d10*d12+A8*l2*l5*d6*d10+A8*l3*l5*d12+A8*l2*l5*d10*d12+A8*l3*l4*d6*d10+A8*l5*d6*d10*d12+A8*l3*l5*d10+A8*l3*l5*d6+A8*l3*l5*d6*d10+A8*l3*l4*d6*d10*d12+A8*l3*l5*d6*d12+A8*l2*l4*d6*d10*d12+A8*l2*l5*d6*d12+A8*l3*l4*d10*d12+A8*l2*l5*d6*d10*d12+A8*l3*l5*d10*d12)*p
          +(A10*l3*l4*d8*d12+A10*l3*d6*d8*d12+A10*l2*l4*d6*d8*d12+A10*l3*l5*d6*d12+A10*l2*l5*d8*d12+A10*l3*l4*d6*d12+A10*l5*d6*d8*d12+A10*l3*l5*d6+A10*l3*l4*d6*d8+A10*l3*l5*d12+A10*l2*l5*d6*d12+A10*l3*l5*d6*d8+A10*l3*l4*d6*d8*d12+A10*l3*l5*d8+A10*l3*l5*d8*d12+A10*l2*l5*d6*d8+A10*l2*l5*d6*d8*d12)*p
          +(A12*l3*l4*d6*d8*d10+A12*l2*l5*d6*d8*d10+A12*l3*l5*d8*d10+A12*l3*l5*d6*d10+A12*l3*l5*d6*d8+A12*l3*d6*d8*d10+A12*l3*l4*d8*d10+A12*l5*d6*d8*d10+A12*l2*l5*d8*d10+A12*l2*l5*d6*d8+A12*l3*l4*d6*d8+A12*l2*l4*d6*d8*d10+A12*l2*l5*d6*d10+A12*l3*l5*d8+A12*l3*l5*d6+A12*l3*l4*d6*d10+A12*l3*l5*d10)*p;
  a[3] := (-A1*l3*l5*d8-A1*l3*l5*d6-A1*l3*l5*d10-A1*l3*l5*d12-A1*l2*l5*d8*d10-A1*l2*l5*d6*d12-A1*l5*d6*d8*d10-A1*l3*d6*d8*d10-A1*l3*l4*d8*d10-A1*l2*l4*d6*d10*d12-A1*l3*l4*d6*d12-A1*l5*d6*d8*d12-A1*l2*l5*d6*d8-A1*l3*l4*d6*d8-A1*l2*l4*d6*d8*d10-A1*l2*l5*d6*d10-A1*l3*l4*d6*d10-A1*l4*d6*d8*d10*d12-A1*l2*d6*d8*d10*d12-A1*l2*l4*d8*d10*d12-A1*l2*l5*d8*d12-A1*l3*d6*d8*d12-A1*l3*l4*d8*d12-A1*l5*d8*d10*d12-A1*l5*d6*d10*d12-A1*l2*l5*d10*d12-A1*l3*d6*d10*d12-A1*l3*l4*d10*d12-A1*l3*d8*d10*d12-A1*l2*l4*d6*d8*d12)*p
          +(-h3*l5*d10-h3*l5*d6-h3*l5*d12-h3*l5*d8-h3*l5*d6*d8-h2*l5*d6*d12-h3*l4*d6*d8-h2*l5*d6*d8-h2*l5*d6*d10-h3*l4*d6*d10-h3*l5*d6*d10-h2*l5*d8*d10-h3*d6*d8*d10-h3*l4*d8*d10-h3*l5*d8*d10-h3*l4*d6*d12-h3*l5*d6*d12-h2*l5*d8*d12-h3*d6*d8*d12-h3*l4*d8*d12-h3*l5*d8*d12-h3*l4*d10*d12-h2*l5*d10*d12-h3*l5*d10*d12-h3*d6*d10*d12-h3*d8*d10*d12-h2*l5*d6*d10*d12-h3*l4*d6*d8*d10-h2*l4*d6*d8*d10-h2*l5*d6*d8*d10-h2*l4*d6*d10*d12-h3*l4*d6*d8*d12-h2*l4*d6*d8*d10*d12-h2*l4*d6*d8*d12-h2*l5*d6*d8*d12-h3*l4*d6*d10*d12-h2*d6*d8*d10*d12-h2*l4*d8*d10*d12-h2*l5*d8*d10*d12-h3*d6*d8*d10*d12-h3*l4*d8*d10*d12)*p
          +(-h5*l3*d10-h5*l3*d8-h5*l3*d12-h5*l3*d6-h5*l3*d6*d8-h5*l2*d8*d10-h5*l2*d6*d8-h4*l3*d6*d8-h4*l3*d6*d10-h5*l2*d6*d10-h5*l3*d6*d10-h4*l3*d8*d10-h5*d6*d8*d10-h5*l3*d8*d10-h4*l3*d6*d12-h5*l2*d6*d12-h5*l3*d6*d12-h4*l3*d8*d12-h5*d6*d8*d12-h5*l2*d8*d12-h5*l3*d8*d12-h5*l2*d8*d10*d12-h5*l2*d6*d8*d12-h4*l3*d6*d8*d10-h4*l2*d6*d8*d10-h5*l2*d6*d8*d10-h4*l3*d6*d8*d12-h5*l2*d10*d12-h5*l3*d10*d12-h4*l3*d10*d12-h5*d8*d10*d12-h5*d6*d10*d12-h4*l2*d6*d8*d12-h4*l2*d6*d8*d10*d12-h4*l2*d6*d10*d12-h4*l3*d6*d10*d12-h5*l2*d6*d10*d12-h4*d6*d8*d10*d12-h4*l2*d8*d10*d12-h4*l3*d8*d10*d12-h5*d6*d8*d10*d12)*p
          +(-A6*l3*l5-A6*l3*l5*d8-A6*l3*d8*d10-A6*l2*l5*d8-A6*l3*l4*d8-A6*l5*d8*d10-A6*l2*l5*d10-A6*l3*l4*d10-A6*l3*l5*d10-A6*l2*l5*d8*d10-A6*l2*l4*d8*d10-A6*l3*l4*d10*d12-A6*l3*l4*d8*d10-A6*l4*d8*d10*d12-A6*l2*l5*d10*d12-A6*l2*l4*d10*d12-A6*l2*d8*d10*d12-A6*l2*l4*d8*d10*d12-A6*l5*d10*d12-A6*l5*d8*d12-A6*l3*d10*d12-A6*l2*l5*d12-A6*l3*l4*d12-A6*l3*d8*d12-A6*l3*l5*d12-A6*l2*l4*d8*d12-A6*l2*l5*d8*d12-A6*l3*l4*d8*d12-A6*l5*d8*d10*d12-A6*l3*d8*d10*d12)*p
          +(-A8*l3*l5-A8*l3*d6*d12-A8*l3*l5*d12-A8*l2*l5*d6-A8*l3*l4*d6-A8*l3*l5*d6-A8*l5*d6*d10-A8*l2*l5*d10-A8*l3*d6*d10-A8*l3*l4*d10-A8*l3*l5*d10-A8*l5*d10*d12-A8*l3*d10*d12-A8*l2*l5*d12-A8*l3*l4*d12-A8*l5*d6*d12-A8*l2*l5*d6*d10-A8*l2*l5*d10*d12-A8*l4*d6*d10*d12-A8*l2*l5*d6*d12-A8*l3*l4*d6*d10-A8*l2*l4*d6*d10-A8*l3*l4*d10*d12-A8*l2*l4*d10*d12-A8*l2*l4*d6*d12-A8*l3*l4*d6*d12-A8*l2*d6*d10*d12-A8*l3*d6*d10*d12-A8*l5*d6*d10*d12-A8*l2*l4*d6*d10*d12)*p
          +(-A10*l3*l5-A10*l2*l5*d8*d12-A10*l2*l5*d8-A10*l3*d6*d12-A10*l2*l5*d6-A10*l3*l4*d6-A10*l5*d6*d8-A10*l3*d6*d8-A10*l3*l4*d8-A10*l3*l5*d8-A10*l3*l5*d6-A10*l5*d8*d12-A10*l2*l5*d12-A10*l3*l4*d12-A10*l3*d8*d12-A10*l3*l5*d12-A10*l5*d6*d12-A10*l3*d6*d8*d12-A10*l3*l4*d6*d8-A10*l2*l4*d6*d8-A10*l2*l5*d6*d8-A10*l2*l4*d6*d8*d12-A10*l4*d6*d8*d12-A10*l5*d6*d8*d12-A10*l2*d6*d8*d12-A10*l2*l4*d8*d12-A10*l3*l4*d8*d12-A10*l2*l4*d6*d12-A10*l2*l5*d6*d12-A10*l3*l4*d6*d12)*p
          +(-A12*l3*l5-A12*l2*l5*d6-A12*l3*l4*d6-A12*l5*d6*d8-A12*l2*l5*d8-A12*l3*d6*d8-A12*l3*l4*d8-A12*l3*l5*d8-A12*l3*l5*d6-A12*l5*d8*d10-A12*l5*d6*d10-A12*l2*l5*d10-A12*l3*d6*d10-A12*l3*l4*d10-A12*l3*d8*d10-A12*l3*l5*d10-A12*l2*l4*d6*d10-A12*l2*l4*d6*d8-A12*l5*d6*d8*d10-A12*l2*l5*d6*d8-A12*l3*l4*d6*d8-A12*l2*l4*d6*d8*d10-A12*l2*l5*d6*d10-A12*l3*l4*d6*d10-A12*l4*d6*d8*d10-A12*l2*d6*d8*d10-A12*l2*l4*d8*d10-A12*l2*l5*d8*d10-A12*l3*d6*d8*d10-A12*l3*l4*d8*d10)*p;
  a[4] := (A1*l3*l5+A1*l3*l4*d8+A1*l2*l5*d6+A1*l3*l4*d6+A1*l5*d6*d8+A1*l2*l5*d8+A1*l3*d6*d8+A1*l5*d8*d10+A1*l5*d6*d10+A1*l2*l5*d10+A1*l3*d6*d10+A1*l3*l4*d10+A1*l3*d8*d10+A1*l2*l5*d12+A1*l5*d6*d12+A1*l3*d6*d12+A1*l5*d10*d12+A1*l5*d8*d12+A1*l3*d8*d12+A1*l3*l4*d12+A1*l3*d10*d12+A1*l4*d8*d10*d12+A1*l4*d6*d8*d10+A1*l2*d6*d8*d10+A1*l2*l4*d8*d10+A1*l2*l4*d6*d12+A1*l4*d6*d8*d12+A1*l2*l4*d6*d10+A1*l2*l4*d6*d8+A1*l2*d6*d8*d12+A1*l2*l4*d8*d12+A1*l4*d6*d10*d12+A1*l2*d6*d10*d12+A1*l2*d8*d10*d12+A1*l2*l4*d10*d12+A1*d6*d8*d10*d12)*p
          +(h3*l4*d12+h2*l5*d12+h3*l4*d10+h3*l4*d6+h3*d6*d12+h3*d10*d12+h3*d6*d8+h2*l5*d6+h3*l4*d8+h3*l5*d10+h2*l5*d10+h3*d8*d10+h3*l5*d6+h3*l5*d12+h2*l5*d8+h3*l5*d8+h3*d6*d10+h3*d8*d12+h3*l5+h2*l4*d8*d10+h2*l5*d6*d12+h2*l4*d6*d12+h3*l4*d6*d8+h2*l4*d6*d8+h2*l5*d6*d8+h2*l4*d6*d10+h2*l5*d6*d10+h3*l4*d6*d10+h2*d6*d8*d10+h2*l5*d8*d10+h3*d6*d8*d10+h3*l4*d8*d10+h3*l4*d6*d12+h2*d6*d8*d12+h2*l4*d8*d12+h2*l5*d8*d12+h3*d6*d8*d12+h3*l4*d8*d12+h3*l4*d10*d12+h2*l5*d10*d12+h2*d6*d10*d12+h3*d6*d10*d12+h2*l4*d10*d12+h2*d8*d10*d12+h3*d8*d10*d12+h2*l4*d6*d8*d10+h2*l4*d6*d10*d12+h2*l4*d6*d8*d12+h2*d6*d8*d10*d12+h2*l4*d8*d10*d12)*p
          +(h4*l3*d8+h4*l3*d10+h5*l2*d8+h5*d10*d12+h5*d6*d12+h5*d8*d10+h5*d6*d8+h5*l2*d12+h5*l3*d10+h4*l3*d6+h5*l2*d6+h4*l3*d12+h5*l3*d8+h5*l2*d10+h5*d8*d12+h5*l3*d12+h5*l3*d6+h5*d6*d10+h5*l3+h5*l2*d8*d10+h5*l2*d6*d8+h4*l2*d6*d8+h4*l3*d6*d8+h4*l2*d6*d10+h4*l3*d6*d10+h5*l2*d6*d10+h4*d6*d8*d10+h4*l2*d8*d10+h4*l3*d8*d10+h5*d6*d8*d10+h4*l2*d6*d12+h4*l3*d6*d12+h5*l2*d6*d12+h4*d6*d8*d12+h4*l2*d8*d12+h4*l3*d8*d12+h5*d6*d8*d12+h5*l2*d8*d12+h4*l2*d6*d8*d10+h4*l2*d10*d12+h5*l2*d10*d12+h4*d8*d10*d12+h4*d6*d10*d12+h4*l3*d10*d12+h5*d8*d10*d12+h5*d6*d10*d12+h4*l2*d6*d8*d12+h4*l2*d6*d10*d12+h4*d6*d8*d10*d12+h4*l2*d8*d10*d12)*p
          +(A6*l3*d8+A6*l5*d10+A6*l3*l4+A6*l5*d8+A6*l3*d12+A6*l3*d10+A6*l3*l5+A6*l2*l5+A6*l5*d12+A6*l3*d8*d10+A6*l2*l4*d8+A6*l2*l5*d8+A6*l3*l4*d8+A6*l4*d8*d10+A6*l5*d8*d10+A6*l2*l5*d10+A6*l3*l4*d10+A6*l2*d8*d10+A6*l2*l4*d10+A6*l2*l4*d8*d10+A6*l4*d8*d12+A6*l4*d8*d10*d12+A6*l2*l4*d10*d12+A6*l2*d8*d10*d12+A6*l4*d10*d12+A6*d8*d10*d12+A6*l5*d10*d12+A6*l5*d8*d12+A6*l3*d10*d12+A6*l2*l5*d12+A6*l3*l4*d12+A6*l2*d8*d12+A6*l3*d8*d12+A6*l2*d10*d12+A6*l2*l4*d12+A6*l2*l4*d8*d12)*p
          +(A8*l3*d10+A8*l3*l4+A8*l2*l5+A8*l5*d12+A8*l3*d12+A8*l5*d6+A8*l3*d6+A8*l5*d10+A8*l3*l5+A8*l3*d6*d12+A8*l4*d10*d12+A8*l4*d6*d12+A8*l2*l4*d6+A8*l2*l5*d6+A8*l3*l4*d6+A8*l4*d6*d10+A8*l2*d6*d10+A8*l5*d6*d10+A8*l2*l5*d10+A8*l3*d6*d10+A8*l3*l4*d10+A8*l2*l4*d10+A8*l5*d10*d12+A8*l3*d10*d12+A8*l2*l5*d12+A8*l3*l4*d12+A8*l2*d10*d12+A8*l2*l4*d12+A8*l2*d6*d12+A8*l5*d6*d12+A8*d6*d10*d12+A8*l4*d6*d10*d12+A8*l2*l4*d6*d10+A8*l2*l4*d10*d12+A8*l2*l4*d6*d12+A8*l2*d6*d10*d12)*p
          +(A10*l3*l4+A10*l3*d12+A10*l3*d8+A10*l5*d8+A10*l3*l5+A10*l5*d6+A10*l3*d6+A10*l2*l5+A10*l5*d12+A10*l4*d8*d12+A10*l2*l4*d8+A10*l2*l5*d8+A10*l3*d6*d12+A10*l4*d6*d8+A10*l2*l4*d6+A10*l2*l5*d6+A10*l3*l4*d6+A10*l5*d6*d8+A10*l2*d6*d8+A10*l3*d6*d8+A10*l3*l4*d8+A10*l5*d8*d12+A10*l2*l5*d12+A10*l3*l4*d12+A10*l2*d8*d12+A10*l3*d8*d12+A10*l2*l4*d12+A10*l4*d6*d12+A10*l2*d6*d12+A10*l5*d6*d12+A10*d6*d8*d12+A10*l2*l4*d6*d8+A10*l4*d6*d8*d12+A10*l2*d6*d8*d12+A10*l2*l4*d8*d12+A10*l2*l4*d6*d12)*p
          +(A12*l2*l5+A12*l3*d10+A12*l3*l4+A12*l3*d8+A12*l5*d8+A12*l3*l5+A12*l5*d10+A12*l3*d6+A12*l5*d6+A12*l4*d6*d8+A12*l2*l5*d6+A12*l2*d6*d10+A12*l3*l4*d6+A12*l2*l4*d10+A12*l5*d6*d8+A12*l2*l4*d6+A12*l2*d6*d8+A12*l2*l4*d8+A12*l2*l5*d8+A12*l3*d6*d8+A12*l3*l4*d8+A12*l4*d8*d10+A12*l4*d6*d10+A12*l5*d8*d10+A12*l5*d6*d10+A12*l2*l5*d10+A12*l3*d6*d10+A12*l3*l4*d10+A12*l2*d8*d10+A12*l3*d8*d10+A12*d6*d8*d10+A12*l2*l4*d6*d10+A12*l2*l4*d6*d8+A12*l4*d6*d8*d10+A12*l2*d6*d8*d10+A12*l2*l4*d8*d10)*p;
  a[5] := (-A1*l5*d6-A1*l3*l4-A1*l5*d8-A1*l3*d10-A1*l3*d8-A1*l3*d12-A1*l5*d12-A1*l5*d10-A1*l2*l5-A1*l3*d6-A1*l4*d10*d12-A1*l4*d6*d12-A1*l2*l4*d6-A1*l4*d6*d8-A1*l2*d6*d8-A1*l2*l4*d8-A1*l4*d8*d10-A1*l4*d6*d10-A1*l2*d6*d10-A1*l2*d8*d10-A1*l2*l4*d10-A1*d6*d8*d10-A1*d8*d10*d12-A1*d6*d10*d12-A1*l2*d6*d12-A1*l2*l4*d12-A1*l2*d10*d12-A1*l2*d8*d12-A1*d6*d8*d12-A1*l4*d8*d12)*p
          +(-h3*l4*d12-h2*l4*d12-h2*l5*d12-h3*l4*d10-h2*l4*d8-h3*l4*d6-h3*d6*d12-h2*d8*d10-h2*l4*d10-h2*d6*d12-h3*d10*d12-h3*d6*d8-h2*l5*d6-h3*l4*d8-h2*d10*d12-h2*d8*d12-h2*l5*d10-h3*d8*d10-h2*l5*d8-h2*l4*d6-h3*d6*d10-h2*d6*d10-h3*d8*d12-h2*d6*d8-h3*l5-h2*l4*d8*d10-h2*l4*d6*d12-h2*l4*d6*d8-h2*l4*d6*d10-h2*d6*d8*d10-h2*d6*d8*d12-h2*l4*d8*d12-h2*d6*d10*d12-h2*l4*d10*d12-h2*d8*d10*d12-h3*d12-h3*d10-h3*d6-h2*l5-h3*d8-h3*l4)*p
          +(-h4*l2*d8-h4*l3*d8-h4*d10*d12-h4*l3*d10-h4*l2*d12-h5*l2*d8-h4*d8*d10-h5*d10*d12-h5*d6*d12-h5*d8*d10-h4*d6*d8-h5*d6*d8-h4*l2*d10-h5*l2*d12-h4*l3*d6-h5*l2*d6-h4*d6*d10-h4*l3*d12-h4*d8*d12-h5*l2*d10-h5*d8*d12-h4*l2*d6-h5*d6*d10-h4*d6*d12-h5*l2-h5*l3-h5*d12-h4*l2*d6*d8-h4*l2*d6*d10-h4*d6*d8*d10-h4*l2*d8*d10-h4*l2*d6*d12-h4*d6*d8*d12-h4*l2*d8*d12-h5*d10-h5*d8-h4*l3-h5*d6-h4*l2*d10*d12-h4*d8*d10*d12-h4*d6*d10*d12)*p
          +(-A6*l2*l4-A6*l3*d8-A6*l4*d12-A6*l2*d8-A6*d8*d12-A6*l5*d10-A6*l3*l4-A6*l5*d8-A6*d10*d12-A6*l3*d12-A6*l3*d10-A6*l5-A6*l2*d10-A6*l4*d8-A6*l2*l5-A6*d8*d10-A6*l2*d12-A6*l5*d12-A6*l4*d10-A6*l2*l4*d8-A6*l4*d8*d10-A6*l2*d8*d10-A6*l2*l4*d10-A6*l3-A6*l4*d8*d12-A6*l4*d10*d12-A6*d8*d10*d12-A6*l2*d8*d12-A6*l2*d10*d12-A6*l2*l4*d12)*p
          +(-A8*l3*d10-A8*d6*d12-A8*l3*l4-A8*l2*d10-A8*l2*d12-A8*l2*l5-A8*d6*d10-A8*l5*d12-A8*l3*d12-A8*l2*d6-A8*l4*d6-A8*l5*d6-A8*l2*l4-A8*l4*d12-A8*d10*d12-A8*l3*d6-A8*l5*d10-A8*l4*d10-A8*l3-A8*l5-A8*l4*d10*d12-A8*l4*d6*d12-A8*l2*l4*d6-A8*l4*d6*d10-A8*l2*d6*d10-A8*l2*l4*d10-A8*l2*d10*d12-A8*l2*l4*d12-A8*l2*d6*d12-A8*d6*d10*d12)*p
          +(-A10*d6*d12-A10*l4*d8-A10*d6*d8-A10*l3*l4-A10*l2*d8-A10*l2*l4-A10*l2*d6-A10*l3*d12-A10*l3*d8-A10*l2*d12-A10*l4*d6-A10*l5*d8-A10*l4*d12-A10*d8*d12-A10*l5*d6-A10*l3*d6-A10*l2*l5-A10*l5*d12-A10*l3-A10*l5-A10*l4*d8*d12-A10*l2*l4*d8-A10*l4*d6*d8-A10*l2*l4*d6-A10*l2*d6*d8-A10*l2*d8*d12-A10*l2*l4*d12-A10*l4*d6*d12-A10*l2*d6*d12-A10*d6*d8*d12)*p
          +(-A12*l2*l5-A12*l3*d10-A12*l4*d8-A12*d6*d8-A12*l3*l4-A12*l2*d8-A12*l2*d10-A12*l2*l4-A12*l2*d6-A12*l3*d8-A12*d6*d10-A12*l4*d6-A12*l5*d8-A12*l4*d10-A12*l5*d10-A12*l3*d6-A12*d8*d10-A12*l5*d6-A12*l4*d6*d8-A12*l2*d6*d10-A12*l2*l4*d10-A12*l2*l4*d6-A12*l2*d6*d8-A12*l2*l4*d8-A12*l4*d8*d10-A12*l4*d6*d10-A12*l2*d8*d10-A12*d6*d8*d10-A12*l3-A12*l5)*p;
  a[6] := (A1*l2*d8+A1*l4*d10+A1*l2*d6+A1*d6*d12+A1*d8*d12+A1*l4*d12+A1*l4*d6+A1*d6*d8+A1*d10*d12+A1*d8*d10+A1*d6*d10+A1*l4*d8+A1*l2*d12+A1*l5+A1*l2*l4+A1*l3+A1*l2*d10)*p
          +(h3*d10+h2*l4*d10+h2*d6*d12+h2*d10+h2*l4*d8+h2*d12+h2*l4+h2*d8*d10+h3*d12+h2*l4*d6+h2*d6+h2*l4*d12+h2*d8*d12+h2*d6*d8+h2*d6*d10+h3*d6+h2*d8+h3*l4+h2*d10*d12+h3+h2*l5+h3*d8)*p
          +(h4*d6*d10+h5*d6+h4*l2*d10+h4*d6*d12+h4*d10*d12+h4*d10+h5*d10+h4*l2+h4*l3+h4*d6+h4*l2*d12+h4*d8*d10+h5*l2+h5+h4*d8+h5*d8+h4*l2*d6+h4*l2*d8+h5*d12+h4*d8*d12+h4*d6*d8+h4*d12)*p
          +(A6*d8*d12+A6*l4*d8+A6*l2*l4+A6*l4*d12+A6*l2*d10+A6*d10*d12+A6*d8+A6*l2*d12+A6*l3+A6*l2*d8+A6*d8*d10+A6*d10+A6*l4*d10+A6*l5+A6*d12+A6*l2+A6*l4)*p
          +(A8*l4*d6+A8*d10*d12+A8*d6+A8*l2*d10+A8*l2*d6+A8*d6*d10+A8*l2*d12+A8*l4+A8*l4*d12+A8*l2*l4+A8*d10+A8*d12+A8*l4*d10+A8*l2+A8*l5+A8*l3+A8*d6*d12)*p
          +(A10*d6*d8+A10*l4*d6+A10*l2+A10*l4+A10*l4*d12+A10*d8+A10*l2*d6+A10*l4*d8+A10*l3+A10*l2*d8+A10*d12+A10*l2*d12+A10*l2*l4+A10*d6+A10*d8*d12+A10*l5+A10*d6*d12)*p
          +(A12*l2*l4+A12*d6*d8+A12*l2*d6+A12*l2*d10+A12*l4*d6+A12*l2*d8+A12*d8*d10+A12*l4+A12*l5+A12*d8+A12*d6*d10+A12*l3+A12*d10+A12*l4*d10+A12*d6+A12*l2+A12*l4*d8)*p;
  a[7] := (-A1*d8-A1*l4-A1*d6-A1*d12-A1*d10-A1*l2)*p
          +(-h2*d8-h3-h2-h2*d6-h2*d12-h2*d10-h2*l4)*p
          +(-h4*d8-h4*d6-h4*l2-h4-h4*d12-h5-h4*d10)*p
          +(-A6*d12-A6*d10-A6*l4-A6-A6*d8-A6*l2)*p
          +(-A8*d10-A8-A8*l4-A8*d6-A8*d12-A8*l2)*p
          +(-A10*d8-A10-A10*d6-A10*l4-A10*d12-A10*l2)*p
          +(-A12*d8-A12*l2-A12*l4-A12-A12*d10-A12*d6)*p;
  a[8] := (A1+h2+h4+A6+A8+A10+A12)*p;
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  b[0] := l3*l5*d6*d8*d10*d12;
  b[1] := (-l3*l5*d8*d10*d12-l3*l5*d6*d10*d12-l3*l5*d6*d8*d10-l2*l5*d6*d8*d10*d12-l3*l4*d6*d8*d10*d12-l3*l5*d6*d8*d12);
  b[2] := (l2*l5*d6*d10*d12+l3*d6*d8*d10*d12+l5*d6*d8*d10*d12+l2*l4*d6*d8*d10*d12+l3*l4*d6*d10*d12+l3*l4*d8*d10*d12+l2*l5*d8*d10*d12+l2*l5*d6*d8*d10+l3*l4*d6*d8*d10+l2*l5*d6*d8*d12+l3*l4*d6*d8*d12+l3*l5*d8*d10+l3*l5*d8*d12+l3*l5*d6*d8+l3*l5*d10*d12+l3*l5*d6*d12+l3*l5*d6*d10);
  b[3] := (-l3*l5*d6-l3*l5*d12-l3*l5*d8-l3*l5*d10-l5*d8*d10*d12-l3*d6*d8*d12-l2*l5*d6*d8-l3*l4*d6*d8-l2*l5*d6*d10-l3*l4*d6*d10-l5*d6*d8*d10-l2*l5*d8*d10-l3*d6*d8*d10-l3*l4*d8*d10-l2*l5*d6*d12-l3*l4*d6*d12-l2*l4*d6*d10*d12-l2*l4*d6*d8*d10-l3*l4*d10*d12-l3*d6*d10*d12-l5*d6*d10*d12-l3*d8*d10*d12-l5*d6*d8*d12-l2*l5*d8*d12-l3*l4*d8*d12-l2*l5*d10*d12-l2*d6*d8*d10*d12-l2*l4*d8*d10*d12-l2*l4*d6*d8*d12-l4*d6*d8*d10*d12);
  b[4] := (l3*d6*d8+l3*d8*d12+l2*l5*d6+l3*d8*d10+l3*l4*d12+l3*l4*d6+l2*l5*d12+l3*d6*d12+l5*d8*d12+l5*d6*d10+l5*d6*d12+l3*l4*d8+l5*d6*d8+l3*d10*d12+l5*d10*d12+l2*l5*d8+l3*l4*d10+l5*d8*d10+l2*l5*d10+l3*d6*d10+d6*d8*d10*d12+l2*d6*d10*d12+l2*l4*d6*d8+l2*l4*d6*d10+l4*d6*d8*d10+l2*d6*d8*d10+l2*l4*d8*d10+l2*l4*d6*d12+l4*d6*d8*d12+l3*l5+l4*d8*d10*d12+l2*l4*d10*d12+l4*d6*d10*d12+l2*d6*d8*d12+l2*l4*d8*d12+l2*d8*d10*d12);
  b[5] := (-d6*d10*d12-l2*d6*d12-l4*d6*d10-l2*l4*d8-l4*d10*d12-l2*d6*d10-l4*d6*d8-l4*d8*d12-l2*d8*d10-l4*d8*d10-l2*d6*d8-d6*d8*d12-l2*d10*d12-l2*l4*d12-d6*d8*d10-l5*d8-l2*l4*d10-d8*d10*d12-l4*d6*d12-l2*d8*d12-l2*l4*d6-l3*d8-l3*d10-l2*l5-l5*d6-l5*d12-l3*d12-l3*d6-l5*d10-l3*l4);
  b[6] := (l2*l4+d6*d8+d8*d12+l2*d6+d6*d10+l4*d10+l2*d10+d8*d10+l4*d12+l4*d8+l4*d6+l5+l3+l2*d8+d6*d12+l2*d12+d10*d12);
  b[7] := (-d8-d6-l4-d12-l2-d10);
  b[8] := 1;

  /// --- Проверка на глючность сопроцесора ---------
//  for i:=0 to 8 do if abs(a[i]) < 1e-18 then a[i] := 0;
//  for i:=0 to 8 do if abs(b[i]) < 1e-18 then b[i] := 0;
  ///////////////////////////////////////////////////////////////////////
  n := 0;
  if ZOrder <> 8 then
    for i:= 8 - ZOrder to 8 do begin
     a[n] := a[i]; a[i] := 0;
     b[n] := b[i]; b[i] := 0;
     inc(n);
    end;

  /// ---------- Rusult -------

  SetLength(Zcoef.a,zOrder+1);   SetLength(Wcoef.a,zOrder+1);
  SetLength(Zcoef.b,zOrder+1);   SetLength(Wcoef.b,zOrder+1);

  for i:= 0 to Length(Zcoef.a)-1 do ZCoef.a[i] := a[i];
  for i:= 0 to Length(Zcoef.b)-1 do ZCoef.b[i] := b[i];
end;

procedure TZTrans.Calc_wCoef;
var
  i           : integer;
  CoefA0      : Extended;
  CoefB0      : Extended;
begin
  wCoef.a := Calc_wCoef_ch_zn(zCoef.a, true);  for i:= 0 to Length(Zcoef.a)-1 do ZCoef.a[i] := ZCoef.a[i]/p;
  wCoef.b := Calc_wCoef_ch_zn(zCoef.b, false);

  CoefA0 := wCoef.a[0];
  CoefB0 := wCoef.b[0];

  if wCoef.a[0] <> 0 then for i:=0 to Length(wCoef.a)-1 do wCoef.a[i] := wCoef.a[i]/CoefA0;
  if wCoef.b[0] <> 0 then for i:=0 to Length(wCoef.b)-1 do wCoef.b[i] := wCoef.b[i]/CoefB0;

  if CoefB0 = 0 then proverka := 999999999
                else proverka := CoefA0 / CoefB0 /p;
end;

function TZTrans.Calc_wCoef_ch_zn(a: TArray; Chislit : Boolean): TArray;
var
  t0  : Extended;
  t0_2, t0_3, t0_4, t0_5, t0_6, t0_7, t0_8 : extended;
  zz : Integer;
begin
  SetLength(Result, Length(a));
  t0   := MainT0;
  t0_2 := t0*t0;
  t0_3 := t0*t0*t0;
  t0_4 := t0*t0*t0*t0;
  t0_5 := t0*t0*t0*t0*t0;
  t0_6 := t0*t0*t0*t0*t0*t0;
  t0_7 := t0*t0*t0*t0*t0*t0*t0;
  t0_8 := t0*t0*t0*t0*t0*t0*t0*t0;

  //  ---  Определяю алгоритм по которому считаю W --------
  if Chislit then zz := 2
             else zz := 1;
  //if a[Length(a)-1] <> 0 then zz  := 2
  //                       else zz  := 2;

  if (Length(a) - zz) = 0 then begin
    Result[0] := zCoef.a[0];
  end;
  if (Length(a) - zz) = 1 then begin
     Result[0] := a[0]+a[1];
     Result[1] := t0  *(-1/2*a[0]+1/2*a[1])
  end;
  if (Length(a) - zz) = 2 then begin
     Result[0] := a[0]+a[2]+a[1];
     Result[1] := t0  *(a[2]-a[0]);
     Result[2] := t0_2*(-1/4*a[1]+1/4*a[0]+1/4*a[2]);
  end;
  if (Length(a) - zz) = 3 then begin
     Result[0] := a[0]+a[1]+a[2]+a[3];
     Result[1] := t0  *(-3/2*a[0]-1/2*a[1]+1/2*a[2]+3/2*a[3]);
     Result[2] := t0_2*(3/4*a[0]-1/4*a[1]-1/4*a[2]+3/4*a[3]);
     Result[3] := t0_3*(-1/8*a[0]+1/8*a[1]-1/8*a[2]+1/8*a[3]);
  end;
  if (Length(a) - zz) = 4 then begin
     Result[0] := a[0]+a[1]+a[4]+a[3]+a[2];
     Result[1] := t0  *(-a[1]+2*a[4]-2*a[0]+a[3]);
     Result[2] := t0_2*(3/2*a[0]-1/2*a[2]+3/2*a[4]);
     Result[3] := t0_3*(1/4*a[1]+1/2*a[4]-1/2*a[0]-1/4*a[3]);
     Result[4] := t0_4*(1/16*a[2]-1/16*a[1]+1/16*a[0]-1/16*a[3]+1/16*a[4]);
  end;
  if (Length(a) - zz) = 5 then begin
     Result[0] := a[1]+a[2]+a[3]+a[0]+a[5]+a[4];
     Result[1] := t0  *(1/2*a[3]+3/2*a[4]-5/2*a[0]+5/2*a[5]-1/2*a[2]-3/2*a[1]);
     Result[2] := t0_2*(-1/2*a[2]-1/2*a[3]+5/2*a[0]+1/2*a[1]+1/2*a[4]+5/2*a[5]);
     Result[3] := t0_3*(1/4*a[2]-1/4*a[4]+1/4*a[1]-5/4*a[0]-1/4*a[3]+5/4*a[5]);
     Result[4] := t0_4*(-3/16*a[1]+1/16*a[2]+5/16*a[0]+5/16*a[5]+1/16*a[3]-3/16*a[4]);
     Result[5] := t0_5*(-1/32*a[0]-1/32*a[2]+1/32*a[3]-1/32*a[4]+1/32*a[1]+1/32*a[5]);
  end;
  if (Length(a) - zz) = 6 then begin
     Result[0] := a[5]+a[6]+a[1]+a[2]+a[3]+a[0]+a[4];
     Result[1] := t0  *(2*a[5]+3*a[6]-3*a[0]-2*a[1]-a[2]+a[4]);
     Result[2] := t0_2*(-3/4*a[3]+5/4*a[1]-1/4*a[2]-1/4*a[4]+15/4*a[6]+15/4*a[0]+5/4*a[5]);
     Result[3] := t0_3*(5/2*a[6]+1/2*a[2]-5/2*a[0]-1/2*a[4]);
     Result[4] := t0_4*(3/16*a[3]-1/16*a[4]-5/16*a[5]-1/16*a[2]-5/16*a[1]+15/16*a[0]+15/16*a[6]);
     Result[5] := t0_5*(-1/8*a[5]+1/8*a[1]+3/16*a[6]-1/16*a[2]-3/16*a[0]+1/16*a[4]);
     Result[6] := t0_6*(-1/64*a[5]+1/64*a[4]+1/64*a[6]+1/64*a[0]+1/64*a[2]-1/64*a[3]-1/64*a[1]);
  end;
  if (Length(a) - zz) = 7 then begin
     Result[0] := a[3]+a[0]+a[1]+a[2]+a[7]+a[4]+a[5]+a[6];
     Result[1] := t0  *(1/2*a[4]+3/2*a[5]+5/2*a[6]-1/2*a[3]-5/2*a[1]-3/2*a[2]-7/2*a[0]+7/2*a[7]);
     Result[2] := t0_2*(9/4*a[6]+9/4*a[1]+21/4*a[7]+1/4*a[5]+21/4*a[0]-3/4*a[4]-3/4*a[3]+1/4*a[2]);
     Result[3] := t0_3*(-35/8*a[0]-5/8*a[1]+3/8*a[3]+5/8*a[2]+35/8*a[7]+5/8*a[6]-3/8*a[4]-5/8*a[5]);
     Result[4] := t0_4*(35/16*a[7]+35/16*a[0]+3/16*a[4]+3/16*a[3]-5/16*a[2]-5/16*a[5]-5/16*a[6]-5/16*a[1]);
     Result[5] := t0_5*(-1/32*a[2]+1/32*a[5]-9/32*a[6]-3/32*a[3]+9/32*a[1]-21/32*a[0]+21/32*a[7]+3/32*a[4]);
     Result[6] := t0_6*(-1/64*a[3]-1/64*a[4]-5/64*a[6]+3/64*a[5]-5/64*a[1]+7/64*a[0]+7/64*a[7]+3/64*a[2]);
     Result[7] := t0_7*(1/128*a[7]-1/128*a[6]+1/128*a[3]-1/128*a[0]+1/128*a[1]-1/128*a[4]-1/128*a[2]+1/128*a[5]);
  end;
  if (Length(a) - zz) = 8 then begin
     Result[0] := a[5]+a[6]+a[7]+a[8]+a[0]+a[1]+a[2]+a[3]+a[4];
     Result[1] := t0  *(-a[3]-2*a[2]-3*a[1]+a[5]+3*a[7]+2*a[6]+4*a[8]-4*a[0]);
     Result[2] := t0_2*(7/2*a[1]+7*a[8]+a[2]-1/2*a[5]+a[6]+7/2*a[7]-a[4]+7*a[0]-1/2*a[3]);
     Result[3] := t0_3*(3/4*a[3]+1/2*a[2]-7/4*a[1]-7*a[0]+7*a[8]+7/4*a[7]-1/2*a[6]-3/4*a[5]);
     Result[4] := t0_4*(35/8*a[0]-5/8*a[6]+3/8*a[4]+35/8*a[8]-5/8*a[2]);
     Result[5] := t0_5*(7/16*a[1]+1/8*a[2]-3/16*a[3]+7/4*a[8]-7/4*a[0]-7/16*a[7]-1/8*a[6]+3/16*a[5]);
     Result[6] := t0_6*(1/32*a[5]-7/32*a[7]-7/32*a[1]+1/16*a[6]+7/16*a[8]+1/32*a[3]+7/16*a[0]+1/16*a[2]-1/16*a[4]);
     Result[7] := t0_7*(-1/64*a[5]-1/16*a[0]-1/32*a[2]+1/16*a[8]+1/32*a[6]-3/64*a[7]+3/64*a[1]+1/64*a[3]);
     Result[8] := t0_8*(1/256*a[6]+1/256*a[4]+1/256*a[8]+1/256*a[2]-1/256*a[7]-1/256*a[3]-1/256*a[1]-1/256*a[5]+1/256*a[0]);
  end;

  /// --- Проверка на глючность сопроцесора ---------
  //for i:=0 to Length(a)-1 do if abs(Result[i]) < 1e-18 then Result[i] := 0;
  /// --- End Of Проверка на глючность сопроцесора ---------
end;

procedure TZTrans.Calc_wCoef_Korec;
var
  a                : array [0..7] of Extended;
  b                : array [0..7] of Extended;
  i                : Integer;
  ksi1, ksi2       : Extended;
  ksi3, ksi4       : Extended;
  t1, t2, t3, t4   : Extended;
  t5, t6, t7, t8   : Extended;
  t9, t10          : Extended;
  //OrderNumerator   : Extended;
  //OrderDenominator : Extended;
begin
  ksi1 := Coef_Korec.ksi1;
  ksi2 := Coef_Korec.ksi2;
  ksi3 := Coef_Korec.ksi3;
  ksi4 := Coef_Korec.ksi4;
  t1   := Coef_Korec.t1;
  t2   := Coef_Korec.t2;
  t3   := Coef_Korec.t3;
  t4   := Coef_Korec.t4;
  t5   := Coef_Korec.t5;
  t6   := Coef_Korec.t6;
  t7   := Coef_Korec.t7;
  t8   := Coef_Korec.t8;
  t9   := Coef_Korec.t9;
  t10  := Coef_Korec.t10;

  {a[0] := 1;
  a[1] := (2*ksi1*t1+t7+t9+2*ksi3*t3+t5);
  a[2] := (t1*t1+t3*t3+t5*t9+t5*t7+2*ksi3*t3*t5+2*ksi1*t1*t9+2*ksi1*t1*t7+2*ksi1*t1*t5+t7*t9+2*ksi3*t3*t9+4*ksi1*t1*ksi3*t3+2*ksi3*t3*t7);
  a[3] := (t1*t1*t5+t3*t3*t9+2*t1*t1*ksi3*t3+t5*t7*t9+2*ksi1*t1*t7*t9+t1*t1*t7+t3*t3*t5+t3*t3*t7+4*ksi1*t1*ksi3*t3*t5+t1*t1*t9+2*ksi1*t1*t3*t3+4*ksi1*t1*ksi3*t3*t9+2*ksi1*t1*t5*t7+2*ksi3*t3*t5*t7+2*ksi3*t3*t5*t9+4*ksi1*t1*ksi3*t3*t7+2*ksi3*t3*t7*t9+2*ksi1*t1*t5*t9);
  a[4] := (t1*t1*t5*t7+t3*t3*t5*t9+t1*t1*t3*t3+2*ksi3*t3*t5*t7*t9+2*t1*t1*ksi3*t3*t9+2*t1*t1*ksi3*t3*t5+2*ksi1*t1*t3*t3*t5+t1*t1*t5*t9+2*ksi1*t1*t5*t7*t9+2*t1*t1*ksi3*t3*t7+4*ksi1*t1*ksi3*t3*t7*t9+t1*t1*t7*t9+t3*t3*t7*t9+4*ksi1*t1*ksi3*t3*t5*t9+4*ksi1*t1*ksi3*t3*t5*t7+t3*t3*t5*t7+2*ksi1*t1*t3*t3*t9+2*ksi1*t1*t3*t3*t7);
  a[5] := (2*t1*t1*ksi3*t3*t7*t9+2*ksi1*t1*t3*t3*t7*t9+2*t1*t1*ksi3*t3*t5*t7+2*ksi1*t1*t3*t3*t5*t7+t1*t1*t3*t3*t7+t1*t1*t3*t3*t5+2*t1*t1*ksi3*t3*t5*t9+2*ksi1*t1*t3*t3*t5*t9+t3*t3*t5*t7*t9+t1*t1*t3*t3*t9+t1*t1*t5*t7*t9+4*ksi1*t1*ksi3*t3*t5*t7*t9);
  a[6] := (t1*t1*t3*t3*t7*t9+2*ksi1*t1*t3*t3*t5*t7*t9+t1*t1*t3*t3*t5*t9+2*t1*t1*ksi3*t3*t5*t7*t9+t1*t1*t3*t3*t5*t7);
  a[7] := t1*t1*t3*t3*t5*t7*t9;}

  a[0] := 1;
  a[1] := (t5+2*ksi1*t1+t9+2*ksi3*t3+t7);
  a[2] := (t5*t7+t1*t1+4*ksi1*t1*ksi3*t3+t7*t9+t5*t9+t3*t3+2*ksi1*t1*t7+2*ksi3*t3*t5+2*ksi3*t3*t7+2*ksi1*t1*t5+2*ksi3*t3*t9+2*ksi1*t1*t9);
  a[3] := (2*t1*t1*ksi3*t3+t3*t3*t5+t1*t1*t5+t3*t3*t9+2*ksi1*t1*t5*t9+t1*t1*t9+t3*t3*t7+2*ksi3*t3*t5*t9+2*ksi1*t1*t3*t3+4*ksi1*t1*ksi3*t3*t5+4*ksi1*t1*ksi3*t3*t7+t1*t1*t7+2*ksi3*t3*t5*t7+t5*t7*t9+2*ksi3*t3*t7*t9+2*ksi1*t1*t7*t9+4*ksi1*t1*ksi3*t3*t9+2*ksi1*t1*t5*t7);
  a[4] := (t3*t3*t7*t9+4*ksi1*t1*ksi3*t3*t7*t9+t1*t1*t3*t3+t3*t3*t5*t7+t1*t1*t5*t7+t1*t1*t7*t9+t3*t3*t5*t9+2*ksi1*t1*t3*t3*t5+t1*t1*t5*t9+2*t1*t1*ksi3*t3*t7+4*ksi1*t1*ksi3*t3*t5*t7+2*ksi1*t1*t3*t3*t7+2*ksi1*t1*t5*t7*t9+4*ksi1*t1*ksi3*t3*t5*t9+2*t1*t1*ksi3*t3*t9+2*ksi1*t1*t3*t3*t9+2*t1*t1*ksi3*t3*t5+2*ksi3*t3*t5*t7*t9);
  a[5] := (2*ksi1*t1*t3*t3*t5*t9+2*ksi1*t1*t3*t3*t7*t9+2*t1*t1*ksi3*t3*t5*t7+t1*t1*t3*t3*t7+2*ksi1*t1*t3*t3*t5*t7+t3*t3*t5*t7*t9+4*ksi1*t1*ksi3*t3*t5*t7*t9+t1*t1*t5*t7*t9+2*t1*t1*ksi3*t3*t5*t9+2*t1*t1*ksi3*t3*t7*t9+t1*t1*t3*t3*t5+t1*t1*t3*t3*t9);
  a[6] := (t1*t1*t3*t3*t5*t7+2*t1*t1*ksi3*t3*t5*t7*t9+t1*t1*t3*t3*t5*t9+t1*t1*t3*t3*t7*t9+2*ksi1*t1*t3*t3*t5*t7*t9);
  a[7] := t1*t1*t3*t3*t5*t7*t9;

 { b[0] := 1;
  b[1] := (2*ksi4*t4+t10+2*ksi2*t2+t6+t8);
  b[2] := (t2*t2+4*ksi2*t2*ksi4*t4+2*ksi4*t4*t8+t6*t8+t4*t4+2*ksi4*t4*t10+2*ksi4*t4*t6+t6*t10+2*ksi2*t2*t6+t8*t10+2*ksi2*t2*t8+2*ksi2*t2*t10);
  b[3] := (2*ksi2*t2*t6*t10+t2*t2*t8+t4*t4*t8+2*ksi2*t2*t4*t4+4*ksi2*t2*ksi4*t4*t6+t4*t4*t6+2*t2*t2*ksi4*t4+t2*t2*t10+t6*t8*t10+2*ksi2*t2*t8*t10+t2*t2*t6+2*ksi4*t4*t8*t10+2*ksi2*t2*t6*t8+2*ksi4*t4*t6*t8+2*ksi4*t4*t6*t10+4*ksi2*t2*ksi4*t4*t8+4*ksi2*t2*ksi4*t4*t10+t4*t4*t10);
  b[4] := (t2*t2*t4*t4+t4*t4*t8*t10+2*ksi2*t2*t4*t4*t6+t4*t4*t6*t10+2*t2*t2*ksi4*t4*t6+t4*t4*t6*t8+4*ksi2*t2*ksi4*t4*t8*t10+2*ksi2*t2*t4*t4*t8+2*ksi2*t2*t6*t8*t10+t2*t2*t8*t10+t2*t2*t6*t10+2*ksi2*t2*t4*t4*t10+t2*t2*t6*t8+4*ksi2*t2*ksi4*t4*t6*t10+2*t2*t2*ksi4*t4*t10+4*ksi2*t2*ksi4*t4*t6*t8+2*t2*t2*ksi4*t4*t8+2*ksi4*t4*t6*t8*t10);
  b[5] := (t2*t2*t6*t8*t10+2*ksi2*t2*t4*t4*t8*t10+t2*t2*t4*t4*t10+t2*t2*t4*t4*t8+t2*t2*t4*t4*t6+2*t2*t2*ksi4*t4*t6*t8+2*t2*t2*ksi4*t4*t8*t10+2*ksi2*t2*t4*t4*t6*t10+2*t2*t2*ksi4*t4*t6*t10+t4*t4*t6*t8*t10+4*ksi2*t2*ksi4*t4*t6*t8*t10+2*ksi2*t2*t4*t4*t6*t8);
  b[6] := (t2*t2*t4*t4*t6*t10+2*ksi2*t2*t4*t4*t6*t8*t10+t2*t2*t4*t4*t8*t10+2*t2*t2*ksi4*t4*t6*t8*t10+t2*t2*t4*t4*t6*t8);
  b[7] := t2*t2*t4*t4*t6*t8*t10;}

  b[0] := 1;
  b[1] := (t8+t10+2*ksi4*t4+2*ksi2*t2+t6);
  b[2] := (t4*t4+4*ksi2*t2*ksi4*t4+2*ksi4*t4*t10+t2*t2+2*ksi2*t2*t6+t8*t10+2*ksi4*t4*t8+t6*t8+2*ksi2*t2*t10+2*ksi4*t4*t6+t6*t10+2*ksi2*t2*t8);
  b[3] := (t4*t4*t6+t2*t2*t8+t2*t2*t10+t4*t4*t10+t2*t2*t6+4*ksi2*t2*ksi4*t4*t6+2*t2*t2*ksi4*t4+t4*t4*t8+2*ksi2*t2*t6*t10+2*ksi4*t4*t8*t10+2*ksi4*t4*t6*t10+t6*t8*t10+2*ksi2*t2*t4*t4+2*ksi2*t2*t6*t8+4*ksi2*t2*ksi4*t4*t8+4*ksi2*t2*ksi4*t4*t10+2*ksi2*t2*t8*t10+2*ksi4*t4*t6*t8);
  b[4] := (2*t2*t2*ksi4*t4*t10+t4*t4*t6*t10+4*ksi2*t2*ksi4*t4*t6*t8+t2*t2*t4*t4+t4*t4*t8*t10+t4*t4*t6*t8+2*t2*t2*ksi4*t4*t6+t2*t2*t6*t10+2*ksi2*t2*t4*t4*t8+2*ksi4*t4*t6*t8*t10+2*t2*t2*ksi4*t4*t8+4*ksi2*t2*ksi4*t4*t8*t10+t2*t2*t6*t8+2*ksi2*t2*t6*t8*t10+2*ksi2*t2*t4*t4*t10+t2*t2*t8*t10+2*ksi2*t2*t4*t4*t6+4*ksi2*t2*ksi4*t4*t6*t10);
  b[5] := (t2*t2*t4*t4*t10+t2*t2*t4*t4*t8+2*t2*t2*ksi4*t4*t6*t8+2*ksi2*t2*t4*t4*t6*t10+2*ksi2*t2*t4*t4*t6*t8+2*t2*t2*ksi4*t4*t8*t10+2*t2*t2*ksi4*t4*t6*t10+4*ksi2*t2*ksi4*t4*t6*t8*t10+2*ksi2*t2*t4*t4*t8*t10+t2*t2*t4*t4*t6+t2*t2*t6*t8*t10+t4*t4*t6*t8*t10);
  b[6] := (t2*t2*t4*t4*t6*t8+2*ksi2*t2*t4*t4*t6*t8*t10+t2*t2*t4*t4*t6*t10+2*t2*t2*ksi4*t4*t6*t8*t10+t2*t2*t4*t4*t8*t10);
  b[7] := t2*t2*t4*t4*t6*t8*t10;


  SetLength(wCoef_Korec.a, 8);  SetLength(wCoef_Korec.b, 8);
  //tLength(zCoef_Korec.a, 8);  SetLength(zCoef_Korec.b, 8);

  for i:=0 to Length(wCoef_Korec.a)-1 do wCoef_Korec.a[i] := a[i];
  for i:=0 to Length(wCoef_Korec.b)-1 do wCoef_Korec.b[i] := b[i];
end;

procedure TZTrans.Calc_zCoef_Korec;
//-----------------
function calc_zzz(t1, ksi1 : extended):TTriValues1;
var
 k1, k2 : Extended;
begin
  k1 := sqr(t1*2/MainT0);
  k2 := 2*ksi1*t1*2/MainT0;

  if t1 <> 0 then begin
     Result.val1 := 1 + k1 + k2;
     Result.val2 := 2*(1-k1)      / Result.val1;
     Result.val3 := (1 + k1 - k2) / Result.val1;
  end else begin
     Result.val1 := 0;
     Result.val2 := 0;
     Result.val3 := 0;
  end;
end;
//-----------------
function calc_zz(t1 : extended):TTwoValues;
var
 k1 : Extended;
begin
  k1 := t1*2/MainT0;

  if t1 <> 0 then begin
    Result.val1 := 1 + k1;
    Result.val2 := (1 - k1) / Result.val1;
  end else begin
    Result.val1 := 0;
    Result.val2 := 0;
  end;
end;
//-----------------
var
  TwoValues : TTwoValues;
  TriValues : TTriValues1;
begin
  TriValues := calc_zzz(Coef_Korec.t1, Coef_Korec.ksi1);
  zCoef_Korec.a10 := TriValues.val1;
  zCoef_Korec.a11 := TriValues.val2;
  zCoef_Korec.a12 := TriValues.val3;
  //------------------------------------------
  TriValues := calc_zzz(Coef_Korec.t3, Coef_Korec.ksi3);
  zCoef_Korec.a20 := TriValues.val1;
  zCoef_Korec.a21 := TriValues.val2;
  zCoef_Korec.a22 := TriValues.val3;
  //------------------------------------------
  TwoValues := calc_zz(Coef_Korec.t5);
  zCoef_Korec.a30 := TwoValues.val1;
  zCoef_Korec.a31 := TwoValues.val2;
  //------------------------------------------
  TwoValues := calc_zz(Coef_Korec.t7);
  zCoef_Korec.a40 := TwoValues.val1;
  zCoef_Korec.a41 := TwoValues.val2;
  //------------------------------------------
  TwoValues := calc_zz(Coef_Korec.t9);
  zCoef_Korec.a50 := TwoValues.val1;
  zCoef_Korec.a51 := TwoValues.val2;
  //------------------------------------------
  //------------------------------------------
  //------------------------------------------
  //------------------------------------------
  TriValues := calc_zzz(Coef_Korec.t2, Coef_Korec.ksi2);
  zCoef_Korec.b10 := TriValues.val1;
  zCoef_Korec.b11 := TriValues.val2;
  zCoef_Korec.b12 := TriValues.val3;
  //------------------------------------------
  TriValues := calc_zzz(Coef_Korec.t4, Coef_Korec.ksi4);
  zCoef_Korec.b20 := TriValues.val1;
  zCoef_Korec.b21 := TriValues.val2;
  zCoef_Korec.b22 := TriValues.val3;
  //------------------------------------------
  TwoValues := calc_zz(Coef_Korec.t6);
  zCoef_Korec.b30 := TwoValues.val1;
  zCoef_Korec.b31 := TwoValues.val2;
  //------------------------------------------
  TwoValues := calc_zz(Coef_Korec.t8);
  zCoef_Korec.b40 := TwoValues.val1;
  zCoef_Korec.b41 := TwoValues.val2;
  //------------------------------------------
  TwoValues := calc_zz(Coef_Korec.t10);
  zCoef_Korec.b50 := TwoValues.val1;
  zCoef_Korec.b51 := TwoValues.val2;
end;

end.
