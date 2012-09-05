unit MPI_Declaration;

interface

uses MPI_Types;

 function GetCoefZForm(t0, w_sr : Extended; aN_Filtr : integer): TZCoefCsZn;

implementation

Uses Math;


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetCoefBinomNewton(aN_Filtr : Integer) : PIntArray;
var
  aBinomNewton  : PIntArray;
  OldLevelArray : PIntArray;
  CurLevelArray : PIntArray;
  i,k           : Integer;
begin
  SetLength(aBinomNewton , aN_Filtr + 1);
  SetLength(OldLevelArray, aN_Filtr + 1);
  SetLength(CurLevelArray, aN_Filtr + 1);

  oldLevelArray[0] := 1;
  oldLevelArray[1] := 2;
  oldLevelArray[2] := 1;

  if aN_Filtr = 1 then begin aBinomNewton[0] := 1; aBinomNewton[1] := 0;                       result := aBinomNewton; exit; end;
  if aN_Filtr = 2 then begin aBinomNewton[0] := 1; aBinomNewton[1] := 2; aBinomNewton[2] := 1; result := aBinomNewton; exit; end;


  for i := 2 to aN_Filtr-1 do begin
       CurLevelArray[0]   := 1;
       for k := 0 to i-1 do CurLevelArray[k + 1] := OldLevelArray[k] + OldLevelArray[k+1];
       CurLevelArray[i+1] := 1;
       for k := 0 to i+1 do begin
          OldLevelArray[k] := CurLevelArray[k];
          aBinomNewton [k] := CurLevelArray[k];
       end;
  end;
  result := aBinomNewton;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetCoefChis(aBinomNewton  : PIntArray) : PExtArray;
var
  aCh      : PExtArray;
  Count    : Integer;
  i        : Integer;
begin
  Count := Length(aBinomNewton);
  SetLength(aCh, Count);

  for i := 0 to Count - 1 do
     aCh[i] := aBinomNewton[i];

  Result := aCh;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetCoefZnam(aBinomNewton  : PIntArray; aW_Sr : Extended) : PExtArray;
var
  Zn1, Zn2, aZn : PExtArray;
  Count : Integer;
  Znak  : integer;
  i     : Integer;
  k     : Extended;
begin
  Count := Length(aBinomNewton);

  SetLength(aZn, Count);
  SetLength(Zn1, Count);
  SetLength(Zn2, Count);

  if (((Count - 1) div 2) div 2)*2 = (Count - 1) div 2 then Znak :=  1
                                                       else Znak := -1;
  k    := abs(1/tan(aW_sr/2));

  for i := 0 to Count - 1 do       Zn1[i] := aBinomNewton[i];
  for i := 0 to Count - 1 do begin Zn2[i] := aBinomNewton[i]*znak*k; Znak := -Znak; end;
  for i := 0 to Count - 1 do       aZn[i] := Zn1[i] + Zn2[i];

  Result := aZn;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function Calc_Roots_Polinom(Coefs : PExtArray) : PCompexArray;
var
  b, aCoefs       : PExtArray;
  p    , q        : Extended;
  Old_p, Old_q    : Extended;
  k, CountCoefs   : Integer;
  D               : Extended;
  aRoots          : PCompexArray;

///////////////
 eps        : extended;
 CountRoots : Integer;
begin
  eps        := 1e-18;
  CountRoots := 0;
  CountCoefs := Length(Coefs)-1;
  SetLength(aRoots, CountCoefs + 1);
  SetLength(aCoefs, Length(Coefs));

  for k:= 0 to Length(Coefs) - 1 do aCoefs[k] := Coefs[k];

 //---------------------------------------------------
  while CountCoefs >= 1 do begin
     p := 0;
     q := 0;
     SetLength(b, CountCoefs+1);
     // ---- Search for Root ------
     for k := 0 to Length(b)-1 do b[k] := 0;
     repeat
       if CountCoefs = 1 then b[0] := 1
                else for k:=0 to CountCoefs-2 do
                         b[CountCoefs-k-2] := aCoefs[CountCoefs-k] - p*b[CountCoefs-k-1] - q*b[CountCoefs-k];

            Old_q := q;  q := aCoefs[0]/b[0];
            Old_p := p;  p := (aCoefs[1] - q*b[1])/b[0];
     until ((abs(p-Old_p) < eps) and (abs(q-Old_q) < eps));
     // ---- End of Search for Root ------
     if CountCoefs <> 1 then begin
         D := sqr(p)-4*q;
         if D < 0 then begin
            aRoots[CountRoots].re := -p/2;
            aRoots[CountRoots].im :=  sqrt(abs(d))/2; inc(CountRoots);

            aRoots[CountRoots].re := -p/2;
            aRoots[CountRoots].im := -sqrt(abs(d))/2; inc(CountRoots);
         end else begin
            aRoots[CountRoots].re := -p/2 - sqrt(d)/2; aRoots[CountRoots].im := 0; inc(CountRoots);
            aRoots[CountRoots].re := -p/2 + sqrt(d)/2; aRoots[CountRoots].im := 0; inc(CountRoots);
         end;
     end else begin
         if aCoefs[1] <> 0 then begin
             aRoots[CountRoots].re := -aCoefs[0]/aCoefs[1];
             aRoots[CountRoots].im := 0;
             inc(CountRoots);
         end;
     end;
     for k:=0 to CountCoefs do aCoefs[k] := 0;
     for k:=0 to CountCoefs do aCoefs[k] := b[k];
     CountCoefs := CountCoefs - 2;
  end;
  result := aRoots;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetCorectValuesRoots(aRoots : PCompexArray): PCompexArray;
var
  CountNormalRoots : Integer;
  NormalArraysRoots : PCompexArray;
  i                : integer;
  TempValue        : Extended;
begin
  CountNormalRoots := 0;
  for i := 0 to Length(aRoots) - 1 do begin
    TempValue := Sqrt(sqr(aRoots[i].Re) + sqr(aRoots[i].Im));
    if TempValue < 1 then begin
       inc(CountNormalRoots);
       SetLength(NormalArraysRoots, CountNormalRoots);
       NormalArraysRoots[CountNormalRoots - 1] := aRoots[i];
    end;

  end;
  Result := NormalArraysRoots;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetNewZCoefFromRoots(aRoots : PCompexArray): PExtArray;
var
  aZCoef : PExtArray;
begin
  SetLength(aZCoef, 4);

  Result := aZCoef;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetCoefZForm(t0, W_sr : Extended; aN_Filtr : integer): TZCoefCsZn;
var
  N_Filtr      : Integer;
  BinomNewton  : PIntArray;
  Ch, Zn       : PExtArray;
  RootsCh      : PCompexArray;
  RootsZn      : PCompexArray;
begin
  N_Filtr     := aN_Filtr * 2;

  SetLength(Ch , N_Filtr + 1);
  SetLength(Zn , N_Filtr + 1);

  ////////////////////////////////////////////////
  BinomNewton := GetCoefBinomNewton(N_Filtr);
  ////////////////////////////////////////////////
  Ch          := GetCoefChis       (BinomNewton);
  Zn          := GetCoefZnam       (BinomNewton, W_sr);
  ////////////////////////////////////////////////
  SetLength(RootsCh, 1); RootsCh[0].re := -1; RootsCh[0].im := 0;  //RootsCh     := Calc_Roots_Polinom(Ch);
  RootsZn     := Calc_Roots_Polinom(Zn);
  ////////////////////////////////////////////////
  RootsCh := GetCorectValuesRoots(RootsCh);  // ????????????????????????
  RootsZn := GetCorectValuesRoots(RootsZn);  // ????????????????????????
  ////////////////////////////////////////////////
  //Ch      := GetNewZCoefFromRoots(RootsCh);
  //Zn      := GetNewZCoefFromRoots(RootsZn);
  // --- End of Osvabazhdaem Masivy dannyh ----
  Result.CoefCh := Ch;
  Result.CoefZn := Zn;
end;

end.
