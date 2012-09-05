unit Unit_ACH_FCH;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, MPITypes,
  StdCtrls, Spin;

type
  TPosImage = record
    x, y, w, h : Integer;
  end;

  TfrmACH_FCH = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Bevel1: TBevel;
    Label7: TLabel;
    lAchValue: TLabel;
    Label8: TLabel;
    lFchValue: TLabel;
    lFreqValue: TLabel;
    Label11: TLabel;
    Bevel2: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Bevel3: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ToolButton2Click(Sender: TObject);
  private
    a1, b1, a2, b2        : array [0..8] of extended;

    FreqArray             : array of Extended;
    AchArray              : array of Extended;
    FchArray              : array of Extended;
    AchPointArray         : array of TPoint;
    FchPointArray         : array of TPoint;

    Bitmap                : TBitmap;
    CountPixelInOneDecada : Integer;
    ZeroPos               : Integer;

    Max, Min   : Integer;
    ImagePos   : TPosImage;
    BitmapPos  : TPosImage;

    CountDecad : Integer;
    BeginDecad : Integer;
    EndDecad   : Integer;
    CoefY      : Extended;

    //+++++++++++++++++++++
    function Get_Ach_FchValue(aLambda: Extended): TTwoValues;

    function Get_PosInFreqAray(Value : Extended): Integer;
    procedure ClearCaptionText();
    procedure ClearArray();
    procedure Prepare_FreqArray();
    procedure Prepare_W_Coef();
    procedure Prepare_Bitmap();
    procedure Correct_FchValue();
    procedure Draw_Labels();
    procedure Draw_Lines(arg: extended; OutStr1, OutStr2 : String; MullConst : byte; myLabel : TLabel);
  public
    EndFreq    : Extended;
    BeginFreq  : Extended;
    AchEnabled : boolean;
    FchEnabled : boolean;
    procedure Draw();
  end;

var
  frmACH_FCH: TfrmACH_FCH;

implementation

uses Math, MPIDeclaration, MPILibrary, Unit_AchFchParam;

{$R *.DFM}

procedure TfrmACH_FCH.FormCreate(Sender: TObject);
begin
  Bitmap         := TBitmap.Create;
  Bitmap.Width   := Bevel1.Width;
  Bitmap.Height  := Bevel1.Height;

  ToolBar1.Width := ControlBar1.Width;

  ImagePos.x     := Bevel2.Left - Bevel1.Left;
  ImagePos.y     := Bevel2.Top  - Bevel1.Top;
  ImagePos.w     := Bevel2.Width;
  ImagePos.h     := Bevel2.Height;

  BitmapPos.x    := Bevel1.Left;
  BitmapPos.y    := Bevel1.Top;
  BitmapPos.w    := Bevel1.Width;
  BitmapPos.h    := Bevel1.Height;

  BeginFreq      := 0.01;
  EndFreq        := 100;

  Max            := 40;
  Min            := -180;

  AchEnabled     := true;
  FchEnabled     := true;
end;
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
procedure TfrmACH_FCH.FormShow(Sender: TObject);
begin
  Draw();
end;
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
function TfrmACH_FCH.Get_Ach_FchValue(aLambda: Extended): TTwoValues;
var
 L          : Extended;

 Re1 , Im1, Re2, Im2 : Extended;
 Re11, Im11          : Extended;

 Re3 , Im3, Re4, Im4 : Extended;

 Ww                  : TTwoValues;
 Dw                  : TTwoValues;

begin
  // ----- W(w) = (re1 + im1) / (re2 + im2) ---------  Объект
  // ----- D(w) = (re3 + im3) / (re4 + im4) ---------  Цифровая коррекция

  L := aLambda;
  //--------------------------------------------------------------------------------
  //Re1   := 1;
  //Im1   := -L*MainT0/2;
  Re1   := 1;
  Im1   := 0;

  Re11  := a1[0]   - a1[2]*L*L   + a1[4]*L*L*L*L   - a1[6]*L*L*L*L*L*L + a1[8]*L*L*L*L*L*L*L*L;
  Im11  := a1[1]*L - a1[3]*L*L*L + a1[5]*L*L*L*L*L - a1[7]*L*L*L*L*L*L*L;

  Re1   := Re1*Re11 - Im1*Im11;
  Im1   := Re1*Im11 + Im1*Re11;
  //Re1   := Re11;
  //Im1   := Im11;

  Re2   := b1[0]   - b1[2]*L*L   + b1[4]*L*L*L*L   - b1[6]*L*L*L*L*L*L + b1[8]*L*L*L*L*L*L*L*L;
  Im2   := b1[1]*L - b1[3]*L*L*L + b1[5]*L*L*L*L*L - b1[7]*L*L*L*L*L*L*L;
  //--------------------------------------------------------------------------------
  Re3   := a2[0]   - a2[2]*L*L   + a2[4]*L*L*L*L   - a2[6]*L*L*L*L*L*L + a2[8]*L*L*L*L*L*L*L*L;
  Im3   := a2[1]*L - a2[3]*L*L*L + a2[5]*L*L*L*L*L - a2[7]*L*L*L*L*L*L*L;
  Re4   := b2[0]   - b2[2]*L*L   + b2[4]*L*L*L*L   - b2[6]*L*L*L*L*L*L + b2[8]*L*L*L*L*L*L*L*L;
  Im4   := b2[1]*L - b2[3]*L*L*L + b2[5]*L*L*L*L*L - b2[7]*L*L*L*L*L*L*L;

  //--------------------------------------------------------------------------------

  // ----  --------
  Ww.val1 := oc.k*sqrt( (Re1*Re1 + Im1*Im1)/(Re2*Re2 + Im2*Im2));
  Dw.val1 := Coef_Korec.k*sqrt( (Re3*Re3 + Im3*Im3)/(Re4*Re4 + Im4*Im4));
  // ----  Фаза --------
  if (re1 <> 0) and (re2 <>0) then Ww.val2 := arctan(im1/re1) - arctan(im2/re2)
                              else Ww.val2 := 0;
  if (re3 <> 0) and (re4 <>0) then Dw.val2 := arctan(im3/re3) - arctan(Im4/Re4)
                              else Dw.val2 := 0;
  // ------------- Выход -----------
  if (Ww.val1 <> 0) and (Dw.val1 <>0 ) then result.val1 := 20*log10(Ww.val1 * Dw.val1* 1/exp(Coef_Korec.Mju*ln(L)));
  if Ww.val1 = 0                       then result.val1 := 20*log10(Dw.val1* 1/exp(Coef_Korec.Mju*ln(L)));
  if Dw.val1 = 0                       then result.val1 := 20*log10(Ww.val1);

  result.val2 := Ww.val2 + Dw.val2 - pi/2*Coef_Korec.Mju;
end;
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
procedure TfrmACH_FCH.ToolButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmACH_FCH.ClearCaptionText;
begin
  lAchValue.Caption  := '----------------';
  lFchValue.Caption  := '----------------';
  lFreqValue.Caption := '----------------';
end;
procedure TfrmACH_FCH.ToolButton1Click(Sender: TObject);
begin
  frmAchFchParam.ShowModal;
end;

procedure TfrmACH_FCH.Prepare_W_Coef;
var
  k : integer;
begin
  for k:=0 to 8                           do a1[k] := 0;
  for k:=0 to 8                           do b1[k] := 0;
  for k:=0 to 8                           do a2[k] := 0;
  for k:=0 to 8                           do b2[k] := 0;

{  for k:=0 to Length(WCoef.a) - 1         do a1[k] := WCoef.a[k];
  for k:=0 to Length(WCoef.b) - 1         do b1[k] := WCoef.b[k];
  for k:=0 to Length(wCoef_Korec.a) - 1   do a2[k] := wCoef_Korec.a[k];
  for k:=0 to Length(wCoef_Korec.b) - 1   do b2[k] := wCoef_Korec.b[k];}

{  a2[0] :=  3 /(12*0.0025);
  a2[1] := 10 /(12*0.0025);
  a2[2] := -18/(12*0.0025);
  a2[3] := 6  /(12*0.0025);
  a2[4] := -1 /(12*0.0025);
  b2[0] := 1;}

  Coef_Korec.Mju := 0;
  oc.k  := 0;

  {Kvant}
  a2[0] :=  0;
  a2[1] :=  0.9999999998;
  a2[2] :=  0.2500000000e-2;
  a2[3] :=  0.520833334e-6;
  a2[4] := -0.2604166666e-8;

  { Bez Filtrom }
{  a2[0] := 0;
  a2[1] := 0.999999999;
  a2[2] := 0.5000000000e-2;
  a2[3] := 0.9895833333e-5;
  a2[4] := 0.1041666667e-7;}

  { s Filtrom }
{  a2[0] := 0;
  a2[1] := 1.000000000;
  a2[2] := 0.5000000000e-2;
  a2[3] := 0.9374999999e-6;
  a2[4] := 0.1116071429e-8;}

  { s Filtrom 6 porjadka}
  a2[0] := 0;
  a2[1] := 0.9999999998;
  a2[2] := 0.7500000000e-2;
  a2[3] := 0.3124999999e-5;
  a2[4] := 0.1004464286e-7;
  a2[5] := 0.1046316964e-11;
  a2[6] := 0.8719308029e-15;

{  b2[0] := 1;
  b2[1] := 0.5000000000e-2;
  b2[2] := 0.9375000000e-5;
  b2[3] := 0.7812500000e-8;
  b2[4] := 0.2441406250e-11;}

  b2[0] := 1;
  b2[1] := 0.7500000000e-2;
  b2[2] := 0.2343750000e-4;
  b2[3] := 0.3906250000e-7;
  b2[4] := 0.3662109375e-10;
  b2[5] := 0.1831054687e-13;
  b2[6] := 0.3814697265e-17;

  a1[0] := 1;
  b1[0] := 1;
end;

procedure TfrmACH_FCH.Prepare_FreqArray;
var
  k,n                    : Integer;
begin
  BeginDecad := Round(ln(BeginFreq)/ln(10));
  EndDecad   := Round(ln(EndFreq  )/ln(10));
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

procedure TfrmACH_FCH.Prepare_Bitmap();
var
  k,i : integer;
  x : Integer;

  CountHorizontalLines      : Integer;
  StepBetweenHorizontalLine : Extended;
  UpLines                   : Integer;
  DownLines                 : Integer;

  OutStr                    : String;
begin
  //Bitmap.Canvas.Brush.Color := Rgb(212, 208, 200);
  Bitmap.Canvas.Brush.Color := clWhite;
  //-------------
  Bitmap.Canvas.Pen.Color   := clGray;
  Bitmap.Canvas.Rectangle(0,0,Bitmap.Width, Bitmap.Height);
  //-------------
  Bitmap.Canvas.Pen.Color := clBlack;
  Bitmap.Canvas.Pen.Width := 2;
  Bitmap.Canvas.Rectangle(ImagePos.x,ImagePos.y,ImagePos.x + ImagePos.w, ImagePos.y + ImagePos.h);
  //--------  Отрисовка логарифмической сетки -----------------------------------------
  Bitmap.Canvas.Pen.Width := 1;
  for k:= 0 to CountDecad - 1 do begin
    for i := 2 to 9 do begin
      x := trunc(ImagePos.x + k*CountPixelInOneDecada + log10(i)*CountPixelInOneDecada);
      Bitmap.Canvas.Pen.Color := clGray;
      Bitmap.Canvas.MoveTo(x, ImagePos.y + 1);
      Bitmap.Canvas.LineTo(x, ImagePos.y + ImagePos.h - 2)
    end;
      x := ImagePos.x + k*CountPixelInOneDecada;
      Bitmap.Canvas.Pen.Color := clBlack;
      Bitmap.Canvas.MoveTo(x, ImagePos.y + 1);
      Bitmap.Canvas.LineTo(x, ImagePos.y + ImagePos.h + 3);
      //-------------
  end;
  // -----  Вывод Вертикальных подписей текста ---------
  for k:= 0 to CountDecad  do begin
      x := ImagePos.x + k*CountPixelInOneDecada;
      OutStr := FloatToStrF(exp((k+BeginDecad)*ln(10)),ffGeneral, 5, 5);
      Bitmap.Canvas.TextOut(x - Bitmap.Canvas.TextWidth(OutStr) div 2, ImagePos.y + ImagePos.h + 8, OutStr)
  end;
  //--------  Отрисовка Горизонтальной сетки --------------------
  UpLines                    := abs(Max div 20);
  DownLines                  := abs(Min div 20);
  CountHorizontalLines       := UpLines + DownLines;
  StepBetweenHorizontalLine  := ImagePos.h / CountHorizontalLines;
  ZeroPos                    := Trunc(ImagePos.y + UpLines*StepBetweenHorizontalLine);

  Bitmap.Canvas.Pen.Color    := clBlack;
  Bitmap.Canvas.Pen.Width    := 2;
  if UpLines = 0 then begin
        Bitmap.Canvas.Pen.Color := clGray;
        Bitmap.Canvas.Pen.Width := 1;
  end;

  for k := 0 to UpLines - 1 do begin
    if k <> 0 then begin
        Bitmap.Canvas.Pen.Color := clGray;
        Bitmap.Canvas.Pen.Width := 1;
    end;
    Bitmap.Canvas.MoveTo(ImagePos.x + 1             , trunc(ZeroPos -  k*StepBetweenHorizontalLine));
    Bitmap.Canvas.LineTo(ImagePos.x + ImagePos.w - 2, trunc(ZeroPos -  k*StepBetweenHorizontalLine));
  end;
  for k := 1 to DownLines - 1 do begin
    Bitmap.Canvas.MoveTo(ImagePos.x + 1             , trunc(ZeroPos +  k*StepBetweenHorizontalLine));
    Bitmap.Canvas.LineTo(ImagePos.x + ImagePos.w - 2, trunc(ZeroPos +  k*StepBetweenHorizontalLine));
  end;
  // -----  Вывод Горизонтальных подписей текста ---------
  for k := 0 to UpLines   do begin
      OutStr := IntToStr(k*20);
      Bitmap.Canvas.TextOut(ImagePos.x - Bitmap.Canvas.TextWidth(OutStr) - 10, trunc(ZeroPos -  k*StepBetweenHorizontalLine - Bitmap.Canvas.TextHeight(OutStr) / 2), OutStr)
  end;
  for k := 1 to DownLines do begin
      OutStr := IntToStr(-k*20);
      Bitmap.Canvas.TextOut(ImagePos.x - Bitmap.Canvas.TextWidth(OutStr) - 10, trunc(ZeroPos +  k*StepBetweenHorizontalLine - Bitmap.Canvas.TextHeight(OutStr) / 2), OutStr)
  end;
end;

procedure TfrmACH_FCH.FormDestroy(Sender: TObject);
begin
  Bitmap.Free;
end;

procedure TfrmACH_FCH.FormPaint(Sender: TObject);
begin
  Canvas.Draw(BitmapPos.x, BitmapPos.y,Bitmap);
end;

procedure TfrmACH_FCH.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
 posArray   : Integer;
 y1, y2, y3 : Integer;
begin
  if (x >= BitmapPos.x+ImagePos.x) and (y >= BitmapPos.y+ImagePos.y) and (x <= BitmapPos.x+ImagePos.x + ImagePos.w - 1) and (y <= BitmapPos.y+ImagePos.y + ImagePos.h) then begin
     Canvas.Draw(BitmapPos.x, BitmapPos.y,Bitmap);
     
     posArray := x - BitmapPos.x - ImagePos.x ;
     y1       := trunc(BitmapPos.y+ZeroPos - AchArray[posArray]/coefY);
     y2       := trunc(BitmapPos.y+ZeroPos - FchArray[posArray]/coefY);

     if not AchEnabled then y1 := -999;
     if not FchEnabled then y2 := -999;

     y3       := y1;
     if y1 > y2 then begin y1 := y2; y2 := y3 end;
     // ---- Бегущая линия ------
     canvas.Pen.Color := clBlack;
     canvas.MoveTo(x, BitmapPos.y+ImagePos.y + 1);

     if y1 <> -999 then begin canvas.LineTo(x, y1 - 4); canvas.MoveTo(x, y1 + 4); end;
     if y2 <> -999 then begin canvas.LineTo(x, y2 - 4); canvas.MoveTo(x, y2 + 4); end;

     canvas.LineTo(x, BitmapPos.y+ImagePos.y + ImagePos.h - 2);
     // -----------------------------------------------------------
     DrawCircle(Canvas,x, y1);
     DrawCircle(Canvas,x, y2);

     lFreqValue.Caption := FloatToStrF (FreqArray[posArray], ffFixed, 13,5) + '  Гц';
     if AchEnabled then lAchValue.Caption  := FloatToStrF (AchArray [posArray], ffFixed, 13,5) + '  дБ';
     if FchEnabled then lFchValue.Caption  := FloatToStrF (FchArray [posArray], ffFixed, 13,5) + '  гр';
  end else begin
     if lFreqValue.Caption <> '----------------' then Canvas.Draw(BitmapPos.x, BitmapPos.y,Bitmap);
     ClearCaptionText();
  end;
end;

procedure TfrmACH_FCH.Draw;
var
  k          : integer;
  TwoValues  : TTwoValues;
begin
  ClearArray();
  ClearCaptionText ();
  Prepare_FreqArray();
  Prepare_W_Coef   ();
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
    if AchEnabled then if Max < AchArray[k] then Max := Trunc(AchArray[k]);
    if FchEnabled then if Max < FchArray[k] then Max := Trunc(FchArray[k]);
    if AchEnabled then if Min > AchArray[k] then Min := Trunc(AchArray[k]);
    if FchEnabled then if Min > FchArray[k] then Min := Trunc(FchArray[k]);
  end;
  //-------------------------------------
  min := (trunc(Min/20) - 2) * 20;
  max := (trunc(Max/20) + 2) * 20;
  //-------------------------------------
  Prepare_Bitmap();
  //-------------------------------------
  coefY := (max - min)/ImagePos.h;
  //-------------------------------------
  for k := 0 to Length(FreqArray)-1 do begin
    AchPointArray[k].y := Trunc(ZeroPos - AchArray[k]/coefY);
    FchPointArray[k].y := Trunc(ZeroPos - FchArray[k]/coefY);
    AchPointArray[k].x := ImagePos.x + k;
    FchPointArray[k].x := ImagePos.x + k;
  end;
  Bitmap.Canvas.pen.Width := 2;
  if AchEnabled then begin
      //Bitmap.Canvas.pen.Color := clRed;
      Bitmap.Canvas.pen.Color := clBlack;
      Bitmap.Canvas.Polyline(AchPointArray);
  end;
  if FchEnabled then begin
      //Bitmap.Canvas.pen.Color := clYellow;
      Bitmap.Canvas.pen.Color := clBlack;
      Bitmap.Canvas.Polyline(FchPointArray);
  end;
  // -------------
  Draw_Labels();
end;

procedure TfrmACH_FCH.Correct_FchValue();
var
  k          : Integer;
  OffsetFaza : Extended;
  OldDiff    : Extended;
  Diff       : Extended;
begin
  OffsetFaza := 0;
  Diff       := 0;
  for k := 1 to Length(FreqArray)-1 do begin
    OldDiff := Diff;
    Diff    := FchArray[k] + OffsetFaza - FchArray[k-1];
    //------------------
    if (OldDiff > 0) and (Diff < 0) and (abs(Diff - oldDiff) > 140) then begin
        OffsetFaza := OffsetFaza + 180;
        Diff := Diff + 180;
    end;
    //------------------
    if (OldDiff < 0) and (Diff > 0) and (abs(Diff - oldDiff) > 140) then begin
        OffsetFaza := OffsetFaza - 180;
        Diff := Diff - 180;
    end;
    //------------------
    if (OldDiff < 0) and (Diff < 0) and (abs(Diff - oldDiff) > 140) then begin
      OffsetFaza := OffsetFaza + 180;
      Diff := Diff + 180;
    end;
    //------------------
   if (OldDiff > 0) and (Diff > 0) and (abs(Diff - oldDiff) > 140) then begin
        OffsetFaza := OffsetFaza - 180;
        Diff := Diff - 180;
    end;

    FchArray[k] := FchArray[k] + OffsetFaza;

    //if FchArray[k] >= 268 then
    //   Caption := '1';
  end;
end;

procedure TfrmACH_FCH.Draw_Labels();
var
  x         : integer;
  d         : extended;
  TwoValues : TTwoValues;
  Pos       : Integer;
begin
  Label1.Caption  := '1 = T1e = --------';
  Label10.Caption := '3 = T3e = --------';
  Label3.Caption  := '5 = T5e = --------';
  Label4.Caption  := '7 = T7e = --------';
  Label14.Caption := '9 = T9e = --------';

  Label9.Caption  := '2  = T2e = --------';
  Label2.Caption  := '4  = T4e = --------';
  Label12.Caption := '6  = T6e = --------';
  Label13.Caption := '8  = T8e = --------';
  Label5.Caption  := '10 = T10e = --------';
  Label6.Caption  := '12 = T12e = --------';

  Label15.Caption := '1k = T1e = --------';
  Label22.Caption := '3k = T3e = --------';
  Label17.Caption := '5k = T5e = --------';
  Label18.Caption := '7k = T7e = --------';
  Label25.Caption := '9k = T9e = --------';

  Label21.Caption := '2k  = T2e = --------';
  Label16.Caption := '4k  = T4e = --------';
  Label23.Caption := '6k  = T6e = --------';
  Label24.Caption := '8k  = T8e = --------';
  Label19.Caption := '10k = T10e = --------';
  with Bitmap.canvas do begin
     //////////////////////////   2/t0     ///////////////////////////////
     if frmAchFchParam.CheckBox2.Checked then begin
         Pen.Color := clGreen;
         Pen.Width := 2;
         Pos := Get_PosInFreqAray(2/MainT0);
         if Pos <> -1 then begin
            x := ImagePos.x + Pos;
            MoveTo(x, ImagePos.y - 5);  LineTo(x, ImagePos.y + ImagePos.h);
            TextOut(x-TextWidth('2/t0') div 2, ImagePos.y - 5 - TextHeight('2/t0'),'2/t0');
         end
     end;
     //////////////////////////////////////////////////////////////////
     if frmAchFchParam.CheckBox6.Checked then begin
         Pen.Color := clRed;   Pen.Width := 1;
         if oc.t1  <> 0 then begin TwoValues := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(MainT0, oc.t1, oc.ksi1); Draw_Lines(1/TwoValues.val1, '1 = T1e = ','1', 1, label1); end;
         if oc.t3  <> 0 then begin TwoValues := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(MainT0, oc.t3, oc.ksi3); Draw_Lines(1/TwoValues.val1, '3 = T3e = ','3', 1, label10); end;
         if oc.t5  <> 0 then begin d := exp(-MainT0/oc.t5);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '5 = T5e = ','5' , 1, label3); end;
         if oc.t7  <> 0 then begin d := exp(-MainT0/oc.t7);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '7 = T7e = ','7' , 1, label4); end;
         if oc.t9  <> 0 then begin d := exp(-MainT0/oc.t9);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '9 = T9e = ','9' , 1, label14); end;
     end;
     //////////////////////////////////////////////////////////////////
     if frmAchFchParam.CheckBox1.Checked then begin
         Pen.Color := clBlue;   Pen.Width := 1;
         if oc.t2  <> 0 then begin TwoValues := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(MainT0, oc.t2, oc.ksi2); Draw_Lines(1/TwoValues.val1, '2 = T2e = ','2', 1, label9); end;
         if oc.t4  <> 0 then begin TwoValues := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(MainT0, oc.t4, oc.ksi4); Draw_Lines(1/TwoValues.val1, '4 = T4e = ','4', 1, label2); end;
         if oc.t6  <> 0 then begin d := exp(-MainT0/oc.t6);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '6 = T6e = ','6' , 1, label12); end;
         if oc.t8  <> 0 then begin d := exp(-MainT0/oc.t8);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '8 = T8e = ','8' , 1, label13); end;
         if oc.t10 <> 0 then begin d := exp(-MainT0/oc.t10); Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '10 = T10e = ','10', 1, label5); end;
         if oc.t12 <> 0 then begin d := exp(-MainT0/oc.t12); Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '12 = T12e = ','12', 1, label6); end;
     end;
     //////////////////////////////////////////////////////////////////
     //////////////////////////////////////////////////////////////////
     //////////////////////////////////////////////////////////////////
     if frmAchFchParam.CheckBox3.Checked then begin
         Pen.Color := clYellow;   Pen.Width := 1;
         if Coef_Korec.t1  <> 0 then begin TwoValues := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(MainT0, Coef_Korec.t1, Coef_Korec.ksi1); Draw_Lines(1/TwoValues.val1, '1k = T1e = ','1k', 2, label15); end;
         if Coef_Korec.t3  <> 0 then begin TwoValues := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(MainT0, Coef_Korec.t3, Coef_Korec.ksi3); Draw_Lines(1/TwoValues.val1, '3k = T3e = ','3k', 2, label22); end;
         if Coef_Korec.t5  <> 0 then begin d := exp(-MainT0/Coef_Korec.t5);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '5k= T5e = ','5k' , 2, label17); end;
         if Coef_Korec.t7  <> 0 then begin d := exp(-MainT0/Coef_Korec.t7);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '7k= T7e = ','7k' , 2, label18); end;
         if Coef_Korec.t9  <> 0 then begin d := exp(-MainT0/Coef_Korec.t9);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '9k= T9e = ','9k' , 2, label25); end;
     end;
     //////////////////////////////////////////////////////////////////
     if frmAchFchParam.CheckBox7.Checked then begin
         Pen.Color := clAqua;   Pen.Width := 1;
         if Coef_Korec.t2  <> 0 then begin TwoValues := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(MainT0, Coef_Korec.t2, Coef_Korec.ksi2); Draw_Lines(1/TwoValues.val1, '2k = T2e  = ','2k', 2, label21); end;
         if Coef_Korec.t4  <> 0 then begin TwoValues := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(MainT0, Coef_Korec.t4, Coef_Korec.ksi4); Draw_Lines(1/TwoValues.val1, '4k = T4e  = ','4k', 2, label16); end;
         if Coef_Korec.t6  <> 0 then begin d := exp(-MainT0/Coef_Korec.t6);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '6k = T6e  = ','6k' , 2, label23); end;
         if Coef_Korec.t8  <> 0 then begin d := exp(-MainT0/Coef_Korec.t8);  Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '8k = T8e  = ','8k' , 2, label24); end;
         if Coef_Korec.t10 <> 0 then begin d := exp(-MainT0/Coef_Korec.t10); Draw_Lines(1/(MainT0/2*(1+d)/(1-d)), '10k = T10e = ','10k', 2, label19); end;
     end;
  end;
end;

function TfrmACH_FCH.Get_PosInFreqAray(Value: Extended): Integer;
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

procedure TfrmACH_FCH.ClearArray;
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

procedure TfrmACH_FCH.Draw_Lines(arg: extended; OutStr1, OutStr2 : String;
  MullConst: byte; myLabel : TLabel);
var
  x, pos : Integer;
begin
  with Bitmap.canvas do begin
     Pos := Get_PosInFreqAray(arg);
     if Pos <> -1 then begin
         x := ImagePos.x + Pos;
         MoveTo(x, ImagePos.y - 5);  LineTo(x, ImagePos.y + ImagePos.h);
         TextOut(x-TextWidth(OutStr2) div 2, ImagePos.y - 5 - TextHeight(OutStr2)*MullConst, OutStr2);
         myLabel.Caption  := OutStr1 + ' ' + floatToStrF(1/arg, ffFixed, 10,9);
     end;
  end;
end;

procedure TfrmACH_FCH.ToolButton2Click(Sender: TObject);
begin
  Bitmap.SaveToFile('1.Bmp');
end;

end.
