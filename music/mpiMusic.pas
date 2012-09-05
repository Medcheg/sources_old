unit mpiMusic;

interface

uses mpiComplex;

type
  TFreqType = (mMusic, mEv);

  function CalcFreq(FreqType : TFreqType; InputArray : TComplexArray; T0 : TFLoat; NPSD,IP, NSig : Integer):TFloatArray;

implementation

uses Dialogs;

{********************************************************}
{ Разложение комплексной матрицы A по сингулярным числам }
{********************************************************}
procedure CSVD(A: TComplexMatrix; M, N, IP, NU, NV: Integer;
               S: TFloatArray; U, V: TComplexMatrix);
const
  Eta = 1.2e-7;
  Tol = 2.4e-32;
var
  Q, R: TComplex;
  B, C, T: Array[0..100] of TFloat;
  NP, N1, k, K1, i, j, kk, LL, L, L1: Integer;
  z, W, Eps, CS, SN, F, H, XX, YY, G: TFloat;
label
  10, 220, 290;
begin
  NP := N + IP;
  N1 := N + 1;
  { редукция (понижение порядка) Хаусхолдера }
  C[0] := 0;
  k := 0;
10:
  K1 := k + 1;
  { исключение элементов A[i,k], i = k + 1, ..., M }
  z := 0;
  for i := k to M - 1 do
    z := z + Sqr(A[i,k].Re) + Sqr(A[i,k].Im);
  B[k] := 0;
  if z > Tol then begin
    z := Sqrt(z);
    B[k] := z;
    W := ComplexABS(A[k,k]);
    Q := Complex(1, 0);
    if W <> 0 then Q := ComplexMulFloat(A[k,k], 1/W);
    A[k,k] := ComplexMulFloat(Q, z+W);
    if k <> NP then begin
      for j := K1 to NP - 1 do begin
        Q := Complex(0, 0);
        for i := k to M - 1 do Q := ComplexSum(Q, ComplexMul(ComplexSopr(A[i,k]), A[i,j]));
        Q := ComplexMulFloat(Q, 1/(z*(z+W)));
        for i := k to M - 1 do A[i,j] := ComplexSub(A[i,j], ComplexMul(Q, A[i,k]));
      end;
      { преобразование фазы }
      Q := ComplexMulFloat(ComplexSopr(A[k,k]), -1/ComplexABS(A[k,k]));
      for j := K1 to NP - 1 do A[k,j] := ComplexMul(Q, A[k,j]);
    end;
  end;
  { исключение элементов A[k,j], j = k + 2, ..., N }
  if k <> N - 1 then begin
    z := 0;
    for j := K1 to N - 1 do z := z + Sqr(A[k,j].Re) + Sqr(A[k,j].Im);
    C[K1] := 0;
    if z > Tol then begin
      z := Sqrt(z);
      C[K1] := z;
      W := ComplexABS(A[k,K1]);
      Q := Complex(1, 0);
      if W <> 0 then Q := ComplexMulFloat(A[k,K1], 1/W);
      A[k,K1] := ComplexMulFloat(Q, z+W);
      for i := K1 to M - 1 do begin
        Q := Complex(0, 0);
        for j := k1 to N - 1 do Q := ComplexSum(Q, ComplexMul(ComplexSopr(A[k,j]), A[i,j]));
        Q := ComplexMulFloat(Q, 1/(z * (z + W)));
        for j := k1 to N - 1 do A[i,j] := ComplexSub(A[i,j], ComplexMul(Q, A[k,j]));
      end;
      { преобразование фазы }
      Q := ComplexMulFloat(ComplexSopr(A[k,k1]), -1/ComplexABS(A[k,k1]));
      for i := k1 to M - 1 do A[i,k1] := ComplexMul(A[i,k1], Q);
    end;
    k := k1;
    goto 10;
  end;
  { допуск для пренебрежимо малых элементов }
  Eps := 0;
  for k := 0 to N - 1 do begin
    S[k] := B[k];
    T[k] := C[k];
    if Eps < S[k] + T[k] then Eps := S[k] + T[k];
  end;
  Eps := Eps * Eta;
  { инициализация вычислений U и V }
  if NU <> 0 then begin
    for j := 0 to NU - 1 do begin
      for i := 0 to M - 1 do
        U[i,j] := Complex(0, 0);
      U[j,j] := Complex(1, 0);
    end;
  end;
  if NV <> 0 then begin
    for j := 0 to NV - 1 do begin
      for i := 0 to N - 1 do
        V[i,j] := Complex(0, 0);
      V[j,j] := Complex(1, 0);
    end;
  end;
  { QR-диагонализация }
  L := 0;
  for kk := 0 to N - 1 do begin
    k := N1 - kk - 1;
220:
    { проверка на расщепление }
    for LL := 0 to k - 1 do begin
      L := k - LL ;
      if Abs(T[L - 1]) <= Eps then goto 290;
      if Abs(S[L - 2]) <= Eps then Break;
    end;
    { сокращение B[L] }
    CS := 0;
    SN := 1;
    L1 := L - 2;
    for i := L - 1 to k - 1 do begin
      F := SN * T[i];
      T[i] := CS * T[i];
      if Abs(F) <= Eps then goto 290;
      H := S[i];
      W := Sqrt(Sqr(F) + Sqr(H));
      S[i] := W;
      CS := H / W;
      SN := -F / W;
      if NU <> 0 then begin
        for j := 0 to N - 1 do begin
          XX := U[j,L1].Re;
          YY := U[j,i].Re;
          U[j,L1] := Complex(XX * CS + YY * SN, 0);
          U[j,i] := Complex(YY * CS - XX * SN, 0);
        end;
      end;
      if NP = N then Continue;
      for j := N1 to NP - 1 do begin
        Q := A[L1,j];
        R := A[i,j];
        A[L1,j] := ComplexSum(ComplexMulFloat(Q, CS), ComplexMulFloat(R, SN));
        A[i,j] := ComplexSub(ComplexMulFloat(R, CS), ComplexMulFloat(Q, SN));
      end;
    end;
    { проверка сходимости }
290:
    W := S[k-1];
    if L <> k then begin
      { сдвиг начала координат }
      XX := S[L-1];
      YY := S[k-2];
      G := T[k - 2];
      H := T[k - 1];
      F := ((YY-W)*(YY+W) + (G-H)*(G+H)) / (2*H*YY);
      G := Sqrt(Sqr(F)+1);
      if F < 0 then G := -G;
      F := ((XX-W)*(XX+W) + (YY/(F+G)-H)*H) / XX;
      { QR - шаг }
      CS := 1;
      SN := 1;
      L1 := L+1;
      for i := L1-1 to k-1 do begin
        G := T[i];
        YY := S[i];
        H := SN * G;
        G := CS * G;
        W := Sqrt(Sqr(H) + Sqr(F));
        T[i-1] := W;
        CS := F/W;
        SN := H/W;
        F := XX*CS + G*SN;
        G := G*CS - XX*SN;
        H := YY*SN;
        YY := YY*CS;
        if NV <> 0 then begin
          for j := 0 to N-1 do begin
            XX := V[j,i-1].Re;
            W := V[j,i].Re;
            V[j,i-1] := Complex(XX*CS + W*SN, 0);
            V[j,i] := Complex(W*CS - XX*SN, 0);
          end;
        end;
        W := Sqrt(Sqr(H) + Sqr(F));
        S[i-1] := W;
        CS := F/W;
        SN := H/W;
        F := CS*G + SN*YY;
        XX :=CS*YY - SN*G;
        if NU <> 0 then begin
          for j := 0 to N-1 do begin
            YY := U[j,i-1].Re;
            W := U[j,i].Re;
            U[j,i-1] := Complex(YY*CS + W*SN, 0);
            U[j,i] := Complex(W*CS - YY*SN, 0);
          end;
        end;
        if N = NP then Continue;
        for j := N1 to NP do begin
          Q := A[i-1,j];
          R := A[i,j];
          A[i-1,j] := ComplexSum(ComplexMulFloat(Q, CS), ComplexMulFloat(R, SN));
          A[i,j] := ComplexSub(ComplexMulFloat(R, CS), ComplexMulFloat(Q, SN));
        end;
      end;
      T[L-1] := 0;
      T[k-1] := F;
      S[k-1] := XX;
      goto 220;
    end;
    { сходимость }
    if W >= 0 then Continue;
    S[k] := -W;
    if NV = 0 then Continue;
    for j := 0 to N-1 do V[j,k] := ComplexMulFloat(V[j,k], -1);
  end;
  { упорядочение сингулярных чисел }
  for k := 0 to N-1 do begin
    G := -1;
    j := k;
    for i := k to N-1 do begin
      if S[i] <= G then Continue;
      G := S[i];
      j := i;
    end;
    if j = k then Continue;
    S[j] := S[k];
    S[k] := G;
    if NV <> 0 then begin
      for i := 0 to N-1 do begin
        Q := V[i,j];
        V[i,j] := V[i,k];
        V[i,k] := Q;
      end;
    end;
    if NU <> 0 then begin
      for i := 0 to N-1 do begin
        Q := U[i,j];
        U[i,j] := U[i,k];
        U[i,k] := Q;
      end;
    end;
    if N = NP then Continue;
    for i := N1-1 to NP-1 do begin
      Q := A[j,i];
      A[j,i] := A[k,i];
      A[k,i] := Q;
    end;
  end;
  { обратное преобразование }
  if NU <> 0 then begin
    for kk := 0 to N-1 do begin
      k := N1 - kk - 2;
      if B[k] = 0 then Continue;
      Q := ComplexMulFloat(A[k,k], -1/ComplexABS(A[k,k]));
      for j := 0 to NU - 1 do
        U[k,j] := ComplexMul(Q, U[k,j]);
      for j := 0 to NU - 1 do begin
        Q := Complex(0, 0);
        for i := k to M - 1 do
          Q := ComplexSum(Q, ComplexMul(ComplexSopr(A[i,k]), U[i,j]));
        Q := ComplexMulFloat(Q, 1/(ComplexABS(A[k,k]) * B[k]));
        for i := k to M - 1 do
          U[i,j] := ComplexSub(U[i,j], ComplexMul(Q, A[i,k]));
      end;
    end;
  end;
  if NV = 0 then Exit;
  if N < 2 then Exit;
  for kk := 2 - 1 to N - 1 do begin
    k := N1 - kk - 2;
    K1 := k + 1;
    if C[k1] = 0 then Continue;
    Q := ComplexMulFloat(ComplexSopr(A[k,k1]), -1/ComplexABS(A[k,k1]));
    for j := 0 to NV - 1 do
      V[k1,j] := ComplexMul(Q, V[k1,j]);
    for j := 0 to NV - 1 do begin
      Q := Complex(0, 0);
      for i := k1 to N - 1 do
        Q := ComplexSum(Q, ComplexMul(A[k,i], V[i,j]));
      Q := ComplexMulFloat(Q, 1/(ComplexABS(A[k,k1]) * C[k1]));
      for i := k1 to N - 1do
        V[i,j] := ComplexSub(V[i,j], ComplexMul(Q, ComplexSopr(A[k,i])));
    end;
  end;
{}  for i := 0 to N - 1 do
{}    for j := 0 to N - 1 do
{}      V[i,j] := ComplexMulFloat(V[i,j], -1);
{}  for i := 0 to M - 1 do
{}    for j := 0 to M - 1 do
{}      U[i,j] := ComplexMulFloat(U[i,j], -1);
end;

{**************************************************}
{ Составляет таблицу комплексных экспонент для FFT }
{**************************************************}
procedure PreFFT(N: Integer; Mode: Byte;
                 var NExp: Integer; W: TComplexMatrix);
var
  C1, C2: TComplex;
  NT, k: Integer;
  S: TFloat;
begin
  NExp := 1;
  repeat
    NT := 2 shl (NExp - 1); { 2^NExp }
    if NT >= N then Break;
    Inc(NExp);
  until False;
  if NT <> N then begin
    NExp := -1; { Ошибка! N не есть степень числа 2 }
    Exit;
  end;
  S := 8 * ArcTan(1) / NT;
  C1 := Complex(Cos(S), -Sin(S));
  if Mode <> 0 then C1 := ComplexSopr(C1);
  C2 := Complex(1, 0);
  for k := 0 to NT - 1 do begin
    W[k,0] := C2;
    C2 := ComplexMul(C2, C1);
  end;
end;

{**********************************************************}
{ Вычисляет дискретно-временной ряд Фурье                  }
{ по массиву отсчетов комплексных данных                   }
{ с помощью алгоритма БПФ с децимацией в частотной области }
{**********************************************************}
procedure FFT(N: Integer; Mode: Byte; T0: TFloat; NExp: Integer;
              W: TComplexMatrix; X: TComplexMatrix);
var
  MM, LL, NN, JJ, KK, k, i, j, NV2, NM1: Integer;
  C1, C2: TComplex;
  S: TFloat;
begin
  MM := 1;
  LL := N;
  for k := 1 to NExp do begin
    NN := LL div 2;
    JJ := MM + 1;
    i := 1; { я использую для цикла с шагом LL }
    while i <= N do begin
      KK := i + NN;
      C1 := ComplexSum(X[i-1,0], X[KK-1,0]);
      X[KK-1,0] := ComplexSub(X[i-1,0], X[KK-1,0]);
      X[i-1,0] := C1;
      Inc(i, LL);
    end;
    if NN = 1 then Continue;
    for j := 2 to NN do begin
      C2 := W[JJ-1,0];
      i := j; { я использую для цикла с шагом LL }
      while i <= N do begin
        KK := i + NN;
        C1 := ComplexSum(X[i-1,0], X[KK-1,0]);
        X[KK-1,0] := ComplexMul(ComplexSub(X[i-1,0], X[KK-1,0]), C2);
        X[i-1,0] := C1;
        Inc(i, LL);
      end;
      Inc(JJ, MM);
    end;
    LL := NN;
    MM := MM * 2;
  end;
  NV2 := N div 2;
  NM1 := N - 1;
  j := 1;
  for i := 1 to NM1 do begin
    if i < j then begin
      C1 := X[j-1,0];
      X[j-1,0] := X[i-1,0];
      X[i-1,0] := C1;
    end;
    k := NV2;
    while k < j do begin
      j := j - k;
      k := k div 2;
    end;
    Inc(j, k);
  end;
  if Mode = 0 then S := T0 else S := 1/(T0 * N);
  for i := 0 to N-1 do
    X[i,0] := ComplexMulFloat(X[i,0], S);
end;

{*****************************************************************}
{ Вычисление оценок частоты в подпространстве шума либо с помощью }
{ метода MUSIC (Method=0), либо с помощью метода EV (Method=1).   }
{ Оба метода основаны на использовании РСЧ модифицированной       }
{ ковариационной матрицы данных.                                  }
{*****************************************************************}
function CalcFreq(FreqType : TFreqType; InputArray : TComplexArray; T0 : TFloat; NPSD,IP, NSig : Integer):TFloatArray;
const
{}  MaxV = 15;
var
  FB, U, V : TComplexMatrix;
  W, Z     : TComplexMatrix;
  S        : TFloatArray;

  NExp,N, NP, i, k, NP2: Integer;
  MaxU                   : Integer;
    Temp              : TFloat;

begin
  N    := Length(InputArray);
  MaxU := (N - IP)*2;
  // ------------
  SetLength(Result, npsd);
  SetLength(FB, MaxU, MaxV);
  SetLength(U , MaxU, MaxU);
  SetLength(V , MaxV, MaxV);
  SetLength(W , NPSD, 1);
  SetLength(Z , NPSD, 1);
  SetLength(S , MaxV);
  // ----------------------------
  if not ((NSig < IP) and (NSig >= 0)) then begin
    MessageDlg('Ошибка !!!', mtError, [mbOk],0);
    Exit;
  end;
  NP := N - IP;
  for i := 0 to NP - 1 do begin
    for k := 0 to IP - 1 do begin
      FB[i,k]    := InputArray[i - k + IP - 1];
      FB[i+NP,k] := ComplexSopr(InputArray[i+k+1]);
    end;
  end;
  NP2 := 2*NP;
  CSVD(FB, NP2, IP, 0, IP, IP, S, U, V);
  { в этой точке для выбора сингулярных чисел "сигнала" или значения }
  { входного параметра NSIG используется ИКА или экспертная оценка   }

  PreFFT(NPSD, 0, NExp, W);
  for k := 0 to NPSD - 1 do Result[k] := 0;
  for i := NSig+1 - 1 to IP -1 do begin
    for k := 0 to IP-1 do Z[k,0] := V[k,i];
    for k := IP+1-1 to NPSD-1 do Z[k,0] := Complex(0, 0);
    FFT(NPSD, 0, t0, NExp, W, Z);
    for k := 0 to NPSD-1 do begin
      Temp := Sqr(Z[k,0].Re) + Sqr(Z[k,0].Im);
      if FreqType = mMusic then Result[k] := Result[k] + Temp;
      if FreqType = mEv    then Result[k] := Result[k] + Temp / S[i];
    end;
  end;
  for k := 0 to NPSD-1 do Result[k] := 1 / Result[k];

///////////////
end;

end.
