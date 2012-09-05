unit Zveno;
//   1 TPower
//   2 TIntegral
//   3 TDiffer
//   4 TAperiod
//   5 TPeriod
//   6 TOgran
//   7 TLuft_AND_Ogran
//   8 TLuft
//   9 TAperiodForce

interface

uses Windows;

Type
   TElement = class
     pT0      : PExtended;
     Name    : Byte;
     Pos     : TPoint;    // --- Позиция на BitMap-e
     caption : String;
     Procedure Init(AnalogTime : PExtended);virtual;
     Function Run(Input :Extended):Extended;virtual;abstract;
   end;

   TPower = class (TElement) //--------------- Звено Усиления  ---------
      k      : Extended;
      Procedure Init(AnalogTime : PExtended);override;
      Function Run(Input :Extended):Extended;Override;
   end;

   TIntegral = class (TElement) //-------------- Интегралл --------------
//      Input  : Extended;
      Input_ : Extended;
      Output : Extended;
      k      : extended;
      k1     : extended;
      Procedure Init(AnalogTime : PExtended);override;
      Function Run(Input :Extended):Extended;Override;
   end;
   TDiffer = class (TElement) //-------------- Дифферинциатор ---------
      Input  : Extended;
      Input_ : Extended;
      Procedure Init(AnalogTime : PExtended);override;
//      function Run(Input, Input_ :Extended):Extended;
      Function Run(Input :Extended):Extended;Override;
   end;
   TAperiod = class (TElement) //----- Апереодическое звено ----------
//      Input  : Extended;
      Output : Extended;
      t1     : Extended;
      k      : Extended;
      k1     : Extended;
      k2     : Extended;
      Procedure Init(AnalogTime : PExtended);override;
      Function Run(Input :Extended):Extended;Override;
   end;
   TAperiodForce = class (TElement) //----- Апереодическое звено с форсировкой ---
      Input_ : Extended;
      Output : Extended;
      t1     : Extended;
      t2     : Extended;
      D1     : Extended;
      k      : Extended;
      k1     : Extended;
      k2     : Extended;
      Procedure Init(AnalogTime : PExtended);override;
      Function Run(Input :Extended):Extended;Override;
   end;
   TPeriod = class (TElement) //--------- Колебательное звено  ----------
//     Input   : Extended;
     OutPut  : array[0..2] of Extended;
     A       : Extended;
     B       : Extended;
     K       : Extended;
     ksi1    : Extended;
     T1      : Extended;
     K1      : Extended;
     Procedure Init(AnalogTime : PExtended);override;
     Function Run(Input :Extended):Extended;Override;
   end;
   TOgran= class (TElement) //----------- Ограничение  -------
//     Input   : Extended;
     B       : Extended;
     K       : Extended;
     Procedure Init(AnalogTime : PExtended);override;
     Function Run(Input :Extended):Extended;Override;
   end;
   TLuft_AND_Ogran = class (TElement) //----- Люфт  -----------
//      Input  : Extended;
      Input_      : Extended;
      A           : Extended;
      B           : Extended;
      B_k_plus_a  : Extended;
      B_k_Minus_a : Extended;
      K           : Extended;
      Procedure Init(AnalogTime : PExtended);override;
      Function Run(Input :Extended):Extended;Override;
   end;
   TLuft = class (TElement) //----- Люфт  -----------
//      Input  : Extended;
      Input_ : Extended;
      A      : Extended;
      K      : Extended;
      Procedure Init(AnalogTime : PExtended);override;
      Function Run(Input :Extended):Extended;Override;
   end;

Procedure WhiteNoise (var ix : longint; var noise : extended);
 
implementation


{ TPower }

procedure TPower.Init(AnalogTime: PExtended);
begin
  Name    :=  1;
  Caption :=  'Пропорциональное звено';
end;

function TPower.Run(Input :Extended): Extended;
begin
  result:=0;
end;

{ TInteg }

procedure TIntegral.Init(AnalogTime: PExtended);
begin
  inherited Init (AnalogTime);
  Input_ := 0;
  Output := 0;
  Name  :=  2;
  Caption :=  'Интеграл с начальным нулевым условием';
  K1:=K*pT0^/2;
end;

function TIntegral.Run(Input :Extended): Extended;
begin
   OutPut  := OutPut + K1*(Input + input_);
   InPut_  := Input;
   Result  := OutPut;
end;

{ TDiff }

procedure TDiffer.Init(AnalogTime: PExtended);
begin
  inherited Init (AnalogTime);
  Name  :=  3;
  Caption :=  'Дифференцматор';
  Pos.x := -100;
  Pos.y := -100;
end;

function TDiffer.Run(Input :Extended): Extended;
begin
  Result := (Input-Input_)/pT0^;
  Input_ := Input;
end;

{ TAperiod }

procedure TAperiod.Init(AnalogTime: PExtended);
begin
  inherited Init (AnalogTime);
  OutPut :=0;
  Name  :=  4;
  Caption :=  'Апериодическое звено';
  K1:=exp(-pT0^/T1);
  K2:=K*(1-exp(-pT0^/t1));
end;

function TAperiod.Run(Input :Extended): Extended;
begin
  OutPut := K1*OutPut + K2*Input;
  Result := OutPut;
end;

{ TPeriod }

procedure TPeriod.Init(AnalogTime: PExtended);
begin
  inherited Init (AnalogTime);
  Name      :=  5;
  Caption :=  'Колебательное звено';
  OutPut[0] := 0;
  OutPut[1] := 0;
  OutPut[2] := 0;

  A  := 2*exp(-  Ksi1*pT0^/T1) * Cos(pT0^/T1*sqrt(1-sqr(Ksi1)));
  B  :=   exp(-2*Ksi1*pT0^/T1);
  K  := K1 * (1-A+B);
end;

function TPeriod.Run(Input :Extended): Extended;
begin
   OutPut[2] := A * OutPut[1] - B * OutPut[0] + K *Input;
   OutPut[0] := OutPut[1];
   OutPut[1] := OutPut[2];
   result    := OutPut[2];
end;

{ TOgran }

procedure TOgran.Init(AnalogTime: PExtended);
begin
  Name  :=  6;
  Caption :=  'Ограничение';
end;

function TOgran.Run(Input :Extended): Extended;
begin
    Result:=0;
    if abs(input) <= b/k then Result := k*input;
    if     input  >  b/k then Result := B;
    if     input  < -b/k then Result :=-B;
end;

{ TLuft_AND_Ogran }

procedure TLuft_AND_Ogran.Init(AnalogTime: PExtended);
begin
  Name  :=  7;
  Caption :=  'Люфт и ограничение';
  Input_ := 0;
  B_k_plus_a  := B/k+a;
  B_k_Minus_a := B/k-a;
end;

function TLuft_AND_Ogran.Run(Input :Extended): Extended;
var prom : Extended;
begin
   Result:=0;
   prom:= Input - Input_;
   if Prom > 0 then begin
     if (input >=-B_k_Minus_a) and (input<=(B/k+a)) then Result := -k*a + K*Input;
     if input  >  B_k_plus_a                        then Result :=  B;
     if input  < -B_k_Minus_a                       then Result := -B;
   end;
   if Prom < 0 then begin
     if (input >=-B_k_plus_a) and (input<=B_k_Minus_a) then Result :=  k*a + K*Input;
     if input  >= B_k_Minus_a                          then Result :=  B;
     if input  <=-B_k_plus_a                           then Result := -B;
   end;
   Input_:=Input;
end;

{ TLuft }

procedure TLuft.Init(AnalogTime: PExtended);
begin
  Name   := 8;
  Caption :=  'Люфт';
  Input_ := 0;
end;

function TLuft.Run(Input: Extended): Extended;
var prom : Extended;
begin
   Result:=0;
   prom:= Input - Input_;

//   if Prom = 0 then if input_ > 0 then Result := -k*a + k*Input
//                                  else Result :=  k*a + k*Input;
   if Prom = 0 then Result := Input_;
   if Prom > 0 then result := -k*a + k*Input;
   if Prom < 0 then result :=  k*a + k*Input;

   Input_:=Input;
end;

{ TAperiodForce }

procedure TAperiodForce.Init(AnalogTime: PExtended);
begin
  inherited Init (AnalogTime);
  Name   := 9;
  Caption :=  'Апериодическое звено с форсировкой';
  try  D1:=Exp(-pT0^/T1); except D1:=0;  end;
  try  K1:=K*(1-d1+T2/T1*D1);   except K1:=0;  end;
  try  K2:=K*T2/T1*D1;          except K2:=0;  end;

  // MessageDlg('T2->к бесконечности, поэтому проверьте значение постоянной времени форсировки',mtError,[mbOk,mbHelp],0);
  Input_ := 0;
end;

function TAperiodForce.Run(Input: Extended): Extended;
begin
  OutPut := d1*OutPut + k1*Input - k2*Input_;
  Input_ := Input;
  Result := OutPut;
end;

{ TElement }

procedure TElement.Init (AnalogTime: PExtended);
begin
  pT0 := AnalogTime;
end;

Procedure WhiteNoise (var ix : longint; var noise : extended);
var
   iy   : LongInt;
   i    : byte;
   p    : Extended;

begin
   noise:=0.0;
   for i:=1 to 12 do
   begin
        {$R-}
        iy:= ix*65539;
        if iy<0 then iy:= iy + 2147483647 + 1;
        {$R+}
            ix:= iy;
            p:=  iy / 2147483647;
            noise := noise + p;
   end; { for i }
   noise := noise - 6.0;
END; {Procedure WhiteNoise}


end.




