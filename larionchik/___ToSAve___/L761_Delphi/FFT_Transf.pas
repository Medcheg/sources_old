unit FFT_Transf;

interface

type
  PSingleArray = ^TSingleArray;
  TSingleArray = array [0..0] of Single;

  procedure FFT(Re, im : pSingleArray; n : Integer); //  n - Stepne` ->>>>  2^n

implementation

uses Windows;

procedure fft(Re, im : pSingleArray; n : Integer); //  n - Stepne` ->>>>  2^n
Label Mot1,Mot2,Mot3;
var M,Count,E,L,F,I,J,O,J1,I1   : DWord;
    Z,C,S,P,Q,R,T,W,V,U,K   : Single;
begin
  Count := Round(exp(n * ln(2)));
  M     := n;
  //------------------- FFT -----------------------
  for L:=1 to M do begin
        e :=  Round(Exp((M+1-L)*ln(2)));
        f :=  Round(e/2);
        u :=  1;
        v :=  0;
        z :=  PI/F;
        c :=  Cos(Z);
        s := -Sin(Z);
        for J:=1 to f do begin
              i := J;
              while i <= Count do begin
                    o     :=i+f-1;

                    p     :=Re^[i-1]+Re^[o];
                    q     :=Im^[i-1]+Im^[o];
                    r     :=Re^[i-1]-Re^[o];
                    t     :=Im^[i-1]-Im^[o];

                    Re^[o]   := r*u - t*v;
                    Im^[o]   := t*u + r*v;
                    Re^[i-1] := P;
                    Im^[i-1] := Q;

                    i := i + e;
              end;
              w := u*c-v*s;
              v := v*c+u*s;
              u := w;
        end;
  end;
  // ----- Двоичная перестановка ---------
  j:=1;
  for i := 1 to Count - 1{EndShowFreq} do begin
    if i > j then goto mot1;
    j1 := j-1;
    i1 := i-1;
    p  := Re^[j1];
    q  := Im^[j1];
    Re^[J1] := Re^[I1];
    Im^[J1] := Im^[I1];
    Re^[I1] := P;
    Im^[I1] := Q;
mot1:
    k := Count/2;
mot2:
    if k >= j then goto mot3;
    j := j - Round(k);
    k := k/2;
    goto mot2;
mot3:
    j := j + Round(k);
  end;
end;

end.