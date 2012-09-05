unit MPI_Ach_Fch_Draw;

interface

uses  Windows, ExtCtrls, Graphics;

type
  TTriStringValues = record
    Res1 : String;
    Res2 : String;
    Res3 : String;
  end;


  TAchFchParam = record
    BackGroundColor       : TColor;
    AchColor              : TColor;
    FchColor              : TColor;
    AchPenStyle           : TPenStyle;
    FchPenStyle           : TPenStyle;
    EndFreq               : Extended;
    BeginFreq             : Extended;

    AchEnabled            : boolean;
    FchEnabled            : boolean;
    t0Enabled             : boolean;

    AchPenWidth           : Integer;
    FchPenWidth           : Integer;
  end;

  procedure Ach_Fch_Create(aImage : TImage; aBitmap : TBitmap; pT0 : pExtended; afpZCoefCsZn  : Pointer);//; apZCoefChZn : TZCoefChZn
  procedure Ach_Fch_Resize();
  procedure Ach_Fch_Draw();
  function AchFcf_MouseMove(X, Y: Integer): TTriStringValues;

var
  AchFchParam : TAchFchParam;



implementation

uses Math, SysUtils, MPI_Library, MPI_Types;

var
   AchFchBitmap : TBitmap;
   AchFchImage  : TImage;
   fpT0         : PExtended;
   fpZCoefCsZn  : ^TZCoefCsZn;

   ImagePos     : TPosImage;

   CountPixelInOneDecada : Integer;
   ZeroPos               : Integer;

   FreqArray             : array of Extended;

   AchArray              : array of Extended;
   FchArray              : array of Extended;

   AchPointArray         : array of TPoint;
   FchPointArray         : array of TPoint;

    Max, Min   : Integer;
    CountDecad : Integer;
    BeginDecad : Integer;
    EndDecad   : Integer;
    CoefY      : Extended;

procedure Ach_Fch_Create(aImage : TImage; aBitmap : TBitmap; pT0 : pExtended; afpZCoefCsZn  : Pointer);
begin
   AchFchBitmap := aBitmap;
   AchFchImage  := aImage;
   fpT0         := pT0;
   fpZCoefCsZn  := afpZCoefCsZn;
end;

procedure ClearArray();
var k : integer;
begin
  if FreqArray <> nil then
     for k := 0 to Length(FreqArray) - 1 do begin
        FreqArray[k]  := 0;
        AchArray[k]   := 0;
        FchArray[k]   := 0;
        AchPointArray[k].x := 0;
        AchPointArray[k].y := 0;
        FchPointArray[k].x := 0;
        FchPointArray[k].y := 0;
     end;
     ZeroPos := -1000;
end;

procedure Prepare_FreqArray();
var
  k,n                    : Integer;
begin
  BeginDecad := Round(ln(AchFchParam.BeginFreq)/ln(10));
  EndDecad   := Round(ln(AchFchParam.EndFreq  )/ln(10));
  CountDecad := EndDecad - BeginDecad;

  // ------  Количество пикселей в одной декаде --------
  CountPixelInOneDecada := Trunc(ImagePos.w / CountDecad);
  // ------  Устанавливаю длинны масивов  ------------
  SetLength(FreqArray     ,CountPixelInOneDecada * CountDecad);
  SetLength(AchArray      ,CountPixelInOneDecada * CountDecad);
  SetLength(FchArray      ,CountPixelInOneDecada * CountDecad);
  SetLength(AchPointArray ,CountPixelInOneDecada * CountDecad);
  SetLength(FchPointArray ,CountPixelInOneDecada * CountDecad);
  // ------  Заполняю глобальный массив частот ------------
  for n:=0 to CountDecad - 1 do
    for k:=0 to CountPixelInOneDecada - 1 do
       FreqArray[n*CountPixelInOneDecada + k] := exp(k/CountPixelInOneDecada*ln(10)) * exp((n+BeginDecad)*ln(10));
  // ------  Правильная ширина поляотображения графика ------------
  ImagePos.w := CountPixelInOneDecada*CountDecad;
end;

function Get_Ach_FchValue(Omega: Extended): TTwoValues;
var
 Re1, Im1   : Extended;
 Re2, Im2   : Extended;
 i          : Integer;
begin
//Omega := 2 / fpT0^ * arcTan(Omega*fpt0^/2);
  // --- Elsi net Znachenij ---
  if Length(fpZCoefCsZn^.CoefCh) = 0 then begin result.val1 := 0; result.val2 := 0; exit; end;
  // --- End of Elsi net Znachenij ---

  Re1 := 0; Im1 := 0;
  for i := 0 to Length(fpZCoefCsZn^.CoefCh)-1 do begin
    Re1 := Re1 + fpZCoefCsZn^.CoefCh[i]*cos(i*Omega*fpT0^*2*pi);
    Im1 := Im1 - fpZCoefCsZn^.CoefCh[i]*sin(i*Omega*fpT0^*2*pi);
  end;
  Re2 := 0; Im2 := 0;
  for i := 0 to Length(fpZCoefCsZn^.CoefZn)-1 do begin
    Re2 := Re2 + fpZCoefCsZn^.CoefZn[i]*cos(i*Omega*fpT0^*2*pi);
    Im2 := Im2 - fpZCoefCsZn^.CoefZn[i]*sin(i*Omega*fpT0^*2*pi);
  end;
  result.val1 := 20*log10(sqrt(Re1*Re1 + Im1*Im1)/sqrt(Re2*Re2 + Im2*Im2));
  result.val2 := arctan(im1/re1) - arctan(im2/re2);
end;

procedure Correct_FchValue;
var
  k          : Integer;
  OffsetFaza : Extended;
  OldDiff    : Extended;
  Diff       : Extended;
begin
  OffsetFaza := 0;
  Diff       := 0;
  for k := 1 to Length(FreqArray)-1 do begin
    if k = 298 then begin
       FchArray[k] := FchArray[k];
       FchArray[k] := FchArray[k];
    end;
    OldDiff := Diff;
    Diff    := FchArray[k] + OffsetFaza - FchArray[k-1];
    //--------------------------------------------------------------------------
    if (OldDiff > 0) and (Diff < 0) and (abs(Diff - oldDiff) > 330) then begin OffsetFaza := OffsetFaza + 360; Diff := Diff + 360; end;
    if (OldDiff > 0) and (Diff < 0) and (abs(Diff - oldDiff) > 150) then begin OffsetFaza := OffsetFaza + 180; Diff := Diff + 180; end;
    if (OldDiff > 0) and (Diff < 0) and (abs(Diff - oldDiff) > 060) then begin OffsetFaza := OffsetFaza + 090; Diff := Diff + 090; end;

    if (OldDiff < 0) and (Diff > 0) and (abs(Diff - oldDiff) > 330) then begin OffsetFaza := OffsetFaza - 360; Diff := Diff - 360; end;
    if (OldDiff < 0) and (Diff > 0) and (abs(Diff - oldDiff) > 150) then begin OffsetFaza := OffsetFaza - 180; Diff := Diff - 180; end;
    if (OldDiff < 0) and (Diff > 0) and (abs(Diff - oldDiff) > 060) then begin OffsetFaza := OffsetFaza - 090; Diff := Diff - 090; end;

    if (OldDiff < 0) and (Diff < 0) and (abs(Diff - oldDiff) > 330) then begin OffsetFaza := OffsetFaza + 360; Diff := Diff + 360; end;
    if (OldDiff < 0) and (Diff < 0) and (abs(Diff - oldDiff) > 150) then begin OffsetFaza := OffsetFaza + 180; Diff := Diff + 180; end;
    if (OldDiff < 0) and (Diff < 0) and (abs(Diff - oldDiff) > 060) then begin OffsetFaza := OffsetFaza + 090; Diff := Diff + 090; end;

    if (OldDiff > 0) and (Diff > 0) and (abs(Diff - oldDiff) > 330) then begin OffsetFaza := OffsetFaza - 360; Diff := Diff - 360; end;
    if (OldDiff > 0) and (Diff > 0) and (abs(Diff - oldDiff) > 150) then begin OffsetFaza := OffsetFaza - 180; Diff := Diff - 180; end;
    if (OldDiff > 0) and (Diff > 0) and (abs(Diff - oldDiff) > 060) then begin OffsetFaza := OffsetFaza - 090; Diff := Diff - 090; end;
    //--------------------------------------------------------------------------
    FchArray[k] := FchArray[k] + OffsetFaza;

    //if FchArray[k] >= 268 then
    //   Caption := '1';
  end;
end;

procedure Prepare_Bitmap();
var
  k,i : integer;
  x : Integer;

  CountHorizontalLines      : Integer;
  StepBetweenHorizontalLine : Extended;
  UpLines                   : Integer;
  DownLines                 : Integer;

  OutStr                    : String;
begin
  AchFchBitmap.Canvas.Brush.Color := AchFchParam.BackGroundColor;
  //-------------
  AchFchBitmap.Canvas.Pen.Color   := clGray;
  AchFchBitmap.Canvas.Pen.Width   := 1;
  AchFchBitmap.Canvas.Pen.Style   := psSolid;
  AchFchBitmap.Canvas.Rectangle(0,0,AchFchBitmap.Width, AchFchBitmap.Height);
  //-------------
  AchFchBitmap.Canvas.Pen.Color := clBlack;
  AchFchBitmap.Canvas.Pen.Width := 2;
  AchFchBitmap.Canvas.Rectangle(ImagePos.x,ImagePos.y,ImagePos.x + ImagePos.w, ImagePos.y + ImagePos.h);
  //--------  Отрисовка логарифмической сетки -----------------------------------------
  AchFchBitmap.Canvas.Pen.Width := 1;
  for k:= 0 to CountDecad - 1 do begin
    for i := 2 to 9 do begin
      x := trunc(ImagePos.x + k*CountPixelInOneDecada + log10(i)*CountPixelInOneDecada);
      AchFchBitmap.Canvas.Pen.Color := clGray;
      AchFchBitmap.Canvas.MoveTo(x, ImagePos.y + 1);
      AchFchBitmap.Canvas.LineTo(x, ImagePos.y + ImagePos.h - 2)
    end;
      x := ImagePos.x + k*CountPixelInOneDecada;
      AchFchBitmap.Canvas.Pen.Color := clBlack;
      AchFchBitmap.Canvas.MoveTo(x, ImagePos.y + 1);
      AchFchBitmap.Canvas.LineTo(x, ImagePos.y + ImagePos.h + 3);
      //-------------
  end;
  // -----  Вывод Вертикальных подписей текста ---------
  for k:= 0 to CountDecad  do begin
      x := ImagePos.x + k*CountPixelInOneDecada;
      OutStr := FloatToStrF(exp((k+BeginDecad)*ln(10)),ffGeneral, 5, 5);
      AchFchBitmap.Canvas.TextOut(x - AchFchBitmap.Canvas.TextWidth(OutStr) div 2, ImagePos.y + ImagePos.h + 8, OutStr)
  end;
  //--------  Отрисовка Горизонтальной сетки --------------------
  UpLines                    := abs(Max div 20);
  DownLines                  := abs(Min div 20);
  CountHorizontalLines       := UpLines + DownLines;
  StepBetweenHorizontalLine  := ImagePos.h / CountHorizontalLines;
  ZeroPos                    := Trunc(ImagePos.y + UpLines*StepBetweenHorizontalLine);

  AchFchBitmap.Canvas.Pen.Color    := clBlack;
  AchFchBitmap.Canvas.Pen.Width    := 2;
  if UpLines = 0 then begin
        AchFchBitmap.Canvas.Pen.Color := clGray;
        AchFchBitmap.Canvas.Pen.Width := 1;
  end;

  for k := 0 to UpLines - 1 do begin
    if k <> 0 then begin
        AchFchBitmap.Canvas.Pen.Color := clGray;
        AchFchBitmap.Canvas.Pen.Width := 1;
    end;
    AchFchBitmap.Canvas.MoveTo(ImagePos.x + 1             , trunc(ZeroPos -  k*StepBetweenHorizontalLine));
    AchFchBitmap.Canvas.LineTo(ImagePos.x + ImagePos.w - 2, trunc(ZeroPos -  k*StepBetweenHorizontalLine));
  end;
  for k := 1 to DownLines - 1 do begin
    AchFchBitmap.Canvas.MoveTo(ImagePos.x + 1             , trunc(ZeroPos +  k*StepBetweenHorizontalLine));
    AchFchBitmap.Canvas.LineTo(ImagePos.x + ImagePos.w - 2, trunc(ZeroPos +  k*StepBetweenHorizontalLine));
  end;
  // -----  Вывод Горизонтальных подписей текста ---------
  for k := 0 to UpLines   do begin
      OutStr := IntToStr(k*20);
      AchFchBitmap.Canvas.TextOut(ImagePos.x - AchFchBitmap.Canvas.TextWidth(OutStr) - 10, trunc(ZeroPos -  k*StepBetweenHorizontalLine - AchFchBitmap.Canvas.TextHeight(OutStr) / 2), OutStr)
  end;
  for k := 1 to DownLines do begin
      OutStr := IntToStr(-k*20);
      AchFchBitmap.Canvas.TextOut(ImagePos.x - AchFchBitmap.Canvas.TextWidth(OutStr) - 10, trunc(ZeroPos +  k*StepBetweenHorizontalLine - AchFchBitmap.Canvas.TextHeight(OutStr) / 2), OutStr)
  end;

  AchFchBitmap.Canvas.TextOut(6, 6, 'дБ');
  AchFchBitmap.Canvas.TextOut(ImagePos.x + ImagePos.w + 6, ImagePos.y + ImagePos.h - 9, 'Гц');
end;

function Get_PosInFreqAray(Value: Extended): Integer;
var
  k : integer;
begin
  Result := -1;
  for k:=1 to Length(FreqArray)-1 do
     if (Value>FreqArray[k-1]) and (Value<FreqArray[k]) then begin
        Result := k;
        break;
     end;
end;

procedure Draw_Labels();
var
  x         : integer;
  Pos       : Integer;
begin
  with AchFchBitmap.Canvas do begin
     //////////////////////////   2/t0     ///////////////////////////////
     if AchFchParam.T0Enabled then begin
         Pen.Color := clGreen;
         Pen.Width := 2;
         Pos := Get_PosInFreqAray(2/fpT0^);
         if Pos <> -1 then begin
            x := ImagePos.x + Pos;
            MoveTo(x, ImagePos.y - 5);  LineTo(x, ImagePos.y + ImagePos.h);
            TextOut(x-TextWidth('2/t0') div 2, ImagePos.y - 5 - TextHeight('2/t0'),'2/t0');
         end
     end;
  end;
end;

procedure Ach_Fch_Draw();
var
  k          : integer;
  TwoValues  : TTwoValues;
  Flag       : Boolean;
begin
  ClearArray();
  //ClearCaptionText ();
  Prepare_FreqArray();
  Flag := True;
  //-------  Расчет АЧХ  ___ ФЧХ значение ------------------------------
  for k := 0 to Length(FreqArray)-1 do begin
    TwoValues := Get_Ach_FchValue(FreqArray[k]);
    AchArray[k] := TwoValues.val1;
    FchArray[k] := TwoValues.val2*180/pi;
  end;
  //---------  Корректировка перекидти фазы ----------------------------
  Correct_FchValue();
  //-------------------------------------
  Max           := -1000000000;
  Min           :=  1000000000;
  for k := 0 to Length(FreqArray)-1 do begin
    if AchFchParam.AchEnabled then if Max < AchArray[k] then Max := Trunc(AchArray[k]);
    if AchFchParam.FchEnabled then if Max < FchArray[k] then Max := Trunc(FchArray[k]);
    if AchFchParam.AchEnabled then if Min > AchArray[k] then Min := Trunc(AchArray[k]);
    if AchFchParam.FchEnabled then if Min > FchArray[k] then Min := Trunc(FchArray[k]);
  end;
  if not AchFchParam.FchEnabled and not AchFchParam.AchEnabled then begin Min := 0; Max := 0;  end;
  if (Min = 0) and  (Max = 0) then Flag := False;
  //-------------------------------------
  min := (trunc(Min/20) - 2) * 20;
  max := (trunc(Max/20) + 2) * 20;
  //-------------------------------------
  Prepare_Bitmap();
  //-------------------------------------
  coefY := (max - min)/ImagePos.h;
  //-------------------------------------
  if Flag then begin
        for k := 0 to Length(FreqArray)-1 do begin
          AchPointArray[k].y := Trunc(ZeroPos - AchArray[k]/coefY);
          FchPointArray[k].y := Trunc(ZeroPos - FchArray[k]/coefY);
          AchPointArray[k].x := ImagePos.x + k;
          FchPointArray[k].x := ImagePos.x + k;
        end;
        if AchFchParam.AchEnabled then begin
            AchFchBitmap.Canvas.pen.Color   := AchFchParam.AchColor;
            AchFchBitmap.Canvas.pen.Style   := AchFchParam.AchPenStyle;
            AchFchBitmap.Canvas.pen.Width   := AchFchParam.AchPenWidth;
            AchFchBitmap.Canvas.Brush.Color := AchFchParam.BackGroundColor;
            AchFchBitmap.Canvas.Polyline(AchPointArray);
        end;
        if AchFchParam.FchEnabled then begin
            AchFchBitmap.Canvas.pen.Color := AchFchParam.FchColor;
            AchFchBitmap.Canvas.pen.Style := AchFchParam.FchPenStyle;
            AchFchBitmap.Canvas.pen.Width := AchFchParam.FchPenWidth;
            AchFchBitmap.Canvas.Brush.Color := AchFchParam.BackGroundColor;
            AchFchBitmap.Canvas.Polyline(FchPointArray);
        end;
  end;
  // -------------
  Draw_Labels();
  AchFchImage.Canvas.Draw(0, 0,AchFchBitmap);
end;

procedure Ach_Fch_Resize();
begin
  AchFchBitmap.Width   := AchFchImage.Width;
  AchFchBitmap.Height  := AchFchImage.Height;

  ImagePos.x     := 40;
  ImagePos.y     := 32;
  ImagePos.w     := AchFchImage.Width  - 60;
  ImagePos.h     := AchFchImage.Height - 64;

end;

function AchFcf_MouseMove(X, Y: Integer): TTriStringValues;
var
 posArray   : Integer;
 y1, y2, y3 : Integer;
begin
  if (x >= ImagePos.x) and (y >= ImagePos.y) and (x <= ImagePos.x + ImagePos.w - 1) and (y <= ImagePos.y + ImagePos.h) and (coefY <> 0) then begin
     AchFchImage.Canvas.Draw(0, 0,AchFchBitmap);

     posArray := x - ImagePos.x ;
     y1       := trunc(ZeroPos - AchArray[posArray]/coefY);
     y2       := trunc(ZeroPos - FchArray[posArray]/coefY);

     if not AchFchParam.AchEnabled then y1 := -999;
     if not AchFchParam.FchEnabled then y2 := -999;

     y3       := y1;
     if y1 > y2 then begin y1 := y2; y2 := y3 end;
     // ---- Бегущая линия ------
     AchFchImage.canvas.Pen.Color := clBlack;
     AchFchImage.canvas.MoveTo(x, ImagePos.y + 1);

     if y1 <> -999 then begin AchFchImage.canvas.LineTo(x, y1 - 4); AchFchImage.canvas.MoveTo(x, y1 + 4); end;
     if y2 <> -999 then begin AchFchImage.canvas.LineTo(x, y2 - 4); AchFchImage.canvas.MoveTo(x, y2 + 4); end;

     AchFchImage.canvas.LineTo(x, ImagePos.y + ImagePos.h - 2);
     // -----------------------------------------------------------
     DrawCircle(AchFchImage.Canvas,x, y1);
     DrawCircle(AchFchImage.Canvas,x, y2);

     Result.Res1 := FloatToStrF (FreqArray[posArray], ffFixed, 13,5) + '  Гц';
     if AchFchParam.AchEnabled then Result.Res2  := FloatToStrF (AchArray [posArray], ffFixed, 13,5) + '  дБ';
     if AchFchParam.FchEnabled then Result.Res3  := FloatToStrF (FchArray [posArray], ffFixed, 13,5) + '  гр';
  end else begin
     Result.Res1 := '----------------';
     Result.Res2 := '----------------';
     Result.Res3 := '----------------';
     AchFchImage.Canvas.Draw(0, 0,AchFchBitmap);
  end;
end;

end.

