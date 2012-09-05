Unit MPI_Types;

interface

type
  TComplex = record
    Re : Extended;
    Im : Extended;
  end;

  PCompexArray = array of TComplex;
  PIntArray    = array of Integer;
  PExtArray    = array of Extended;

  PArray = ^TArray;
  TArray = array [0..1000000] of Extended;

  PZCoefCsZn = ^TZCoefCsZn;
  TZCoefCsZn = record
     CoefCh : PExtArray;
     CoefZn : PExtArray;
  end;

  TPosImage = record
    x, y, w, h : Integer;
  end;

  TTwoValues = record
    val1 : Extended;
    val2 : Extended;
  end;

  TTriValues = record
    val1 : Extended;
    val2 : Extended;
    val3 : Integer;
  end;

  TTriValues1 = record
    val1 : Extended;
    val2 : Extended;
    val3 : Extended;
  end;

  TWRoots = record
     w : array of TComplex;
  end;

  TCoef = record
    A1  : TComplex;
    A2  : TComplex;
    A3  : TComplex;
    A4  : TComplex;
    A5  : TComplex;
    A6  : TComplex;
    A8  : TComplex;
    A10 : TComplex;
    A12 : TComplex;

    //---------------
    L2        : Extended;
    L3        : Extended;
    L4        : Extended;
    L5        : Extended;
    //---------------
    T_2e      : Extended;
    T_4e      : Extended;
    T_6e      : Extended;
    T_8e      : Extended;
    T_10e     : Extended;
    T_12e     : Extended;

    A_6e      : Extended;
    A_8e      : Extended;
    A_10e     : Extended;
    A_12e     : Extended;

    Tau_1e   : Extended;
    Tau_3e   : Extended;

    L6       : Extended;
    L8       : Extended;

    Zetta_2e : Extended;
    Zetta_4e : Extended;
  end;

  TwCoef = record
      //a0, a1, a2, a3, a4, a5, a6, a7, a8     : Extended;
      //a  : array [0..8] of Extended;
      a  : TArray;
      b  : TArray;
  end;

  TzCoef = record
      //a0, a1, a2, a3, a4, a5, a6, a7, a8     : Extended;
      a  : TArray;
      b  : TArray;
  end;

  TObjectCoef = packed record
      k      : Extended;
      s      : Extended;
      Mju    : Extended;
      //--------------
      t1     : Extended;
      t2     : Extended;
      t4     : Extended;
      t3     : Extended;
      t5     : Extended;
      t6     : Extended;
      t7     : Extended;
      t8     : Extended;
      t9     : Extended;
      t10    : Extended;
      t12    : Extended;
      //--------------
      ksi1   : Extended;
      ksi2   : Extended;
      ksi3   : Extended;
      ksi4   : Extended;
  end;

  TCorecCoef = packed record
      k      : Extended;
      s      : Extended;
      Mju    : Extended;
      //--------------
      t1     : Extended;
      t2     : Extended;
      t4     : Extended;
      t3     : Extended;
      t5     : Extended;
      t6     : Extended;
      t7     : Extended;
      t8     : Extended;
      t9     : Extended;
      t10    : Extended;
      t12    : Extended;
      //--------------
      ksi1   : Extended;
      ksi2   : Extended;
      ksi3   : Extended;
      ksi4   : Extended;
  end;

  TZCorecCoef = packed record
      a10      : Extended;
      a11      : Extended;
      a12      : Extended;
      //---------------------
      a20      : Extended;
      a21      : Extended;
      a22      : Extended;
      //---------------------
      a30      : Extended;
      a31      : Extended;
      //---------------------
      a40      : Extended;
      a41      : Extended;
      //---------------------
      a50      : Extended;
      a51      : Extended;
      //---------------------
      //---------------------
      b10      : Extended;
      b11      : Extended;
      b12      : Extended;
      //---------------------
      b20      : Extended;
      b21      : Extended;
      b22      : Extended;
      //---------------------
      b30      : Extended;
      b31      : Extended;
      //---------------------
      b40      : Extended;
      b41      : Extended;
      //---------------------
      b50      : Extended;
      b51      : Extended;
  end;

var
  OC         : TObjectCoef;
  Coef       : TCoef;
  zCoef      : TzCoef;
  wCoef      : TwCoef;
  MainT0     : Extended;
  Coef_Korec       : TCorecCoef;
  zCoef_Korec      : TZCorecCoef;
  wCoef_Korec      : TwCoef;

implementation

begin
 MainT0     := 0.001;
 with OC do begin
      k      := 1;
      s      := 1;
      //--------------
      //----  Такт дестритизации ----------

      t1     := 0;    // 11111111111111111111111111111111111
      ksi1   := 0;  if t1 = 0 then ksi1 := 0;

      t2     := 0;   // 22222222222222222222222222222222222
      ksi2   := 0.1;  if t2 = 0 then ksi2 := 0;

      t3     := 0;   // 33333333333333333333333333333333333
      ksi3   := 0;  if t3 = 0 then ksi3 := 0;

      t4     := 0;   // 44444444444444444444444444444444444
      ksi4   := 0.1;  if t4 = 0 then ksi4 := 0;


      t5     := 0;
      t7     := 0;
      t9     := 0;

      t6     := 0.1;
      t8     := 0;
      t10    := 0;
      t12    := 0;
 end;
 with Coef_Korec do begin
      k      := 1;
      mju    := 1;
      //--------------

      t1     := 0;   // 11111111111111111111111111111111111
      ksi1   := 0.1;  if t1 = 0 then ksi1 := 0;

      t2     := 0;   // 22222222222222222222222222222222222
      ksi2   := 0.1;  if t2 = 0 then ksi2 := 0;

      t3     := 0;   // 33333333333333333333333333333333333
      ksi3   := 0.1;  if t3 = 0 then ksi3 := 0;

      t4     := 0;   // 44444444444444444444444444444444444
      ksi4   := 0.1;  if t4 = 0 then ksi4 := 0;

      t5     := 0;
      t7     := 0;
      t9     := 0;

      t6     := 0;
      t8     := 0;
      t10    := 0;
      t12    := 0;
 end;
end.
