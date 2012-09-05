unit Unit_StatAnalysis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, mpiDeclaration, ExtCtrls, TeEngine, Series,
  TeeProcs, Chart, mpiLibrary;

type
  TfrmStatAnalysis = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    seAzimWindow: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    Edit2: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    seNumberAzim: TSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    seBeginAlfa: TSpinEdit;
    seEndAlfa: TSpinEdit;
    Image2: TImage;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Edit1Chang(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure seBeginAlfaChange(Sender: TObject);
    procedure seEndAlfaChange(Sender: TObject);
    procedure seNumberAzimChange(Sender: TObject);
    procedure seAzimWindowChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    BeginDepth, EndDepth : TFloat;
    AzimWidow, BeginAlfa : Integer;
    EndAlfa, NumberAzim  : Integer;

    AtomName : Integer;

    function  CalcAlfaAngles(aBeginDepth, aEndDepth : TFloat; aBeginAlfa, aEndAlfa, aNumberAzim : Integer):TIntArray;
    function  CalcTetaAngles(aBeginDepth, aEndDepth : TFloat; aBeginAlfa, aEndAlfa, aAzimWidow, aNumberAzim : Integer):TIntArray;
    procedure DrawAlfaGraphic(aCanvas : TCanvas; aRect : TRect; Gistogram : TIntArray; aBeginAlfa, aEndAlfa : Integer);
    procedure DrawTetaGraphic(aCanvas : TCanvas; aRect : TRect; Gistogram : TIntArray; aAzimWindow : Integer);
  public
    MaxAlfaAngle : TFloat;
    MaxTetaAngle : TFloat;
    procedure CalcAndDrawAlfaAndTetaGraphics(aBeginDepth, aEndDepth : TFloat; aAzimWidow, aBeginAlfa, aEndAlfa, aNumberAzim:Integer; aCanvas1, aCanvas2: TCanvas; aRect1, aRect2 : TRect);
  end;

var
  frmStatAnalysis: TfrmStatAnalysis;

implementation

uses Unit_Main, mpiLasFile, Unit_BlackWindow;

{$R *.DFM}

{===============================================================================
}
procedure TfrmStatAnalysis.FormShow(Sender: TObject);
begin
  Caption := frmMainCaption + frmMain.aStatAnalysis.Caption;

  if not frmBlackWindow.CheckBox1.Checked then begin
         AtomName := GlobalFindAtom('Alt+PrintScreen');
         UnregisterHotKey(frmMain.Handle, AtomName);
  end;

  Self.Height := 146;

  if Edit1.text = '0' then Edit1.Text := FloatToStrF(LasFile.WellInf.Start, ffFixed, 16, 4);
  if Edit2.text = '0' then Edit2.Text := FloatToStrF(LasFile.WellInf.Stop , ffFixed, 16, 4);

  seBeginAlfaChange(self);
  seEndAlfaChange  (self);
end;

{===============================================================================
}
procedure TfrmStatAnalysis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not frmBlackWindow.CheckBox1.Checked then RegisterHotKey(frmMain.Handle, AtomName, MOD_ALT, VK_SNAPSHOT);
end;

{===============================================================================
}
procedure TfrmStatAnalysis.Edit1Chang(Sender: TObject);
begin
   Caption     := frmMainCaption + frmMain.aStatAnalysis.Caption;
   Self.Height := 146;
end;

{===============================================================================
}
procedure TfrmStatAnalysis.BitBtn1Click(Sender: TObject);
begin
  Self.Height := 367;
  // -----------
  try BeginDepth := StrToFloat(Edit1.Text) except ShowWrongEdit(Edit1); exit end;
  try EndDepth   := StrToFloat(Edit2.Text) except ShowWrongEdit(Edit2); exit end;
  AzimWidow  := seAzimWindow.Value;
  BeginAlfa  := seBeginAlfa.Value;
  EndAlfa    := seEndAlfa.Value;
  NumberAzim := seNumberAzim.Value;
  // -----------

  Image1.Canvas.FillRect(Image1.ClientRect);
  Image2.Canvas.FillRect(Image2.ClientRect);

  CalcAndDrawAlfaAndTetaGraphics(BeginDepth, EndDepth, AzimWidow, BeginAlfa, EndAlfa, NumberAzim, Image1.Canvas, Image2.Canvas, Image1.ClientRect, Image2.ClientRect);
end;

// aBeginDepth ---- Начальная глубина для статистики ---------------
// aEndDepth   ---- Конечая глубина для статистики -----------------
// aAzimWidow  ---- Вычисление статистики окном азимута ------------
// aBeginAlfa  ---- Начальный угол наклона для расчета статистики --
// aEndAlfa    ---- Конечный угол наклона для окна статистики ------
// aNumberAzim ---- Номер максимума азимута ------------------------
// aCanvas1    ---- Куда рисуем ------------------------------------
// aCanvas1    ---- Куда рисуем ------------------------------------
// Rect1       ---- Граници отрисовки первого поля -----------------
// Rect2       ---- Граници отрисовки второго поля -----------------
{===============================================================================
}
procedure TfrmStatAnalysis.CalcAndDrawAlfaAndTetaGraphics(aBeginDepth,
  aEndDepth: TFloat; aAzimWidow, aBeginAlfa, aEndAlfa, aNumberAzim: Integer;
  aCanvas1, aCanvas2: TCanvas; aRect1, aRect2: TRect);
var
  Gistogram : TIntArray;
begin
  if aEndAlfa = -1                               then aNumberAzim := 1;
  if (aEndAlfa = -1) and (Length(MarkArray) = 0) then aEndAlfa    := 90;

  Gistogram := CalcAlfaAngles(aBeginDepth, aEndDepth, aBeginAlfa, aEndAlfa, aNumberAzim);
  DrawAlfaGraphic(aCanvas1, aRect1, Gistogram, aBeginAlfa, aEndAlfa);

  Gistogram := CalcTetaAngles(aBeginDepth, aEndDepth, aBeginAlfa, aEndAlfa, aAzimWidow, aNumberAzim);
  DrawTetaGraphic(aCanvas2, aRect2, Gistogram, aAzimWidow);
end;

{===============================================================================
}
function TfrmStatAnalysis.CalcAlfaAngles(aBeginDepth,
  aEndDepth: TFloat; aBeginAlfa, aEndAlfa, aNumberAzim : Integer): TIntArray;
var
  i, k            : integer;
  SumArray        : TFloatArray;
  TempResultArray : TIntArray;

  max        : Integer;
  Temp       : TFloat;
  CountMarks : Integer;
begin
  SetLength(result, 1);

  // ---- Автоматическое определения конечного алфа --------
  if aEndAlfa = -1 then begin
     for i := 0 to Length(MarkArray) - 1 do begin
        if aEndAlfa < MarkArray[i].Alfa_1*180/pi then aEndAlfa := Round(MarkArray[i].Alfa_1*180/pi) + 2;
     end;
  end;
  // -----------------------------------------

  SetLength(Result         , aEndAlfa - aBeginAlfa); for i := 0 to Length(Result) - 1 do Result[i]          := 0;
  SetLength(TempResultArray, aEndAlfa - aBeginAlfa); for i := 0 to Length(Result) - 1 do TempResultArray[i] := 0;
  SetLength(SumArray       , aEndAlfa - aBeginAlfa); for i := 0 to Length(Result) - 1 do SumArray[i]        := 0;

  for k := aBeginAlfa to aEndAlfa - 1 do begin
     for i := 0 to Length(MarkArray) - 1 do begin
        if (MarkArray[i].fCurrentDepth >= aBeginDepth) and (MarkArray[i].fCurrentDepth <= aEndDepth) then begin
            if (MarkArray[i].Alfa_1*180/pi >= k) and (MarkArray[i].Alfa_1*180/pi < k + 1) then begin
                  Result         [k - aBeginAlfa] := Result[k - aBeginAlfa]          + 1;
                  TempResultArray[k - aBeginAlfa] := TempResultArray[k - aBeginAlfa] + 1;
                  SumArray       [k - aBeginAlfa] := SumArray[k - aBeginAlfa] + MarkArray[i].Alfa_1*180/pi;
            end;
        end;
     end;
  end;
  // ----- Считаю среднее по каждому участку -------------
  for k := aBeginAlfa to aEndAlfa - 1 do begin
      if Result  [k - aBeginAlfa] <> 0 then
         SumArray[k - aBeginAlfa] := SumArray[k - aBeginAlfa]/Result  [k - aBeginAlfa];
  end;
  // ---- Упорядычу масив SumArray по убыванию для нахождения максимума который мне нуно ----------------
  for i := 0 to length(TempResultArray) - 2 do begin
     max := TempResultArray[i];
     for k := i+1 to length(TempResultArray) - 1 do begin
        if max < TempResultArray[k] then begin
            max                := TempResultArray[k];
            TempResultArray[k] := TempResultArray[i];
            TempResultArray[i] := Max;

            Temp               := SumArray[k];
            SumArray[k]        := SumArray[i];
            SumArray[i]        := Temp;
        end;
     end;
  end;
  // -------- Вывод инфы --------
   CountMarks := 0; for i := 0 to Length(Result) - 1 do CountMarks := CountMarks + Result[i];
    // -------
      if (aNumberAzim >  Length(TempResultArray)) or  (CountMarks  =  0) or (TempResultArray[aNumberAzim - 1] = 0) then begin
         GroupBox1.Caption := 'Всего 0 значений. На выбраном максимуме: 0(100%)';
         GroupBox2.Caption := 'Угол: ---- ';
         MaxAlfaAngle      := -999;
      end;
      if (aNumberAzim <= Length(TempResultArray)) and (CountMarks  <> 0) then begin
         GroupBox1.Caption := 'Всего ' + intTOStr(CountMarks)+' значений. На выбраном максимуме: '+intToStr(TempResultArray[aNumberAzim - 1])+'('+FloatToStrF(TempResultArray[aNumberAzim - 1]/CountMarks*100, ffFixed, 20, 2)+'%)';
         GroupBox2.Caption := 'Угол: ' + FloatToStrF(SumArray[aNumberAzim - 1], ffFixed, 20, 1);
         MaxAlfaAngle      := SumArray[aNumberAzim - 1];
      end;
    // -------

  Caption           := frmMainCaption + frmMain.aStatAnalysis.Caption+': '+intToStr(aBeginAlfa) + ' - ' + intToStr(aEndAlfa);
end;

{===============================================================================
}
function TfrmStatAnalysis.CalcTetaAngles(aBeginDepth,
  aEndDepth: TFloat; aBeginAlfa, aEndAlfa, aAzimWidow, aNumberAzim : Integer): TIntArray;
var
  i, k            : integer;
  SumArray        : TFloatArray;
  TempResultArray : TIntArray;

  max             : Integer;
  Temp            : TFloat;
  CountSector     : Integer;

  CurAngle        : Integer;
  AngleCounter    : Integer;
begin
  if aAzimWidow = 0 then exit;
  CountSector := Round(360 / aAzimWidow);
  if 360 / aAzimWidow - CountSector <> 0 then CountSector := CountSector + 1;
  SetLength(Result         , CountSector + 1); for i := 0 to Length(Result) - 1 do Result[i] := 0;
  SetLength(TempResultArray, CountSector + 1); for i := 0 to Length(Result) - 1 do TempResultArray[i] := 0;
  SetLength(SumArray       , CountSector + 1); for i := 0 to Length(Result) - 1 do SumArray[i] := 0;

  // ---- Автоматическое определения конечного алфа --------
  if aEndAlfa = -1 then begin
     for i := 0 to Length(MarkArray) - 1 do begin
        if aEndAlfa < MarkArray[i].Alfa_1*180/pi then aEndAlfa := Round(MarkArray[i].Alfa_1*180/pi) + 2;
     end;
  end;

  CurAngle     := 0;
  AngleCounter := 0;
  while CurAngle < 360 do begin
     for i := 0 to Length(MarkArray) - 1 do begin
        if (MarkArray[i].fCurrentDepth >= aBeginDepth) and (MarkArray[i].fCurrentDepth <= aEndDepth) then begin
            if (MarkArray[i].Teta_1*180/pi >= CurAngle            ) and
               (MarkArray[i].Teta_1*180/pi < CurAngle + aAzimWidow) and
               (MarkArray[i].Alfa_1*180/pi >= aBeginAlfa          ) and
               (MarkArray[i].Alfa_1*180/pi <  aEndAlfa            ) then begin

                  Result         [AngleCounter] := Result         [AngleCounter] + 1;
                  TempResultArray[AngleCounter] := TempResultArray[AngleCounter] + 1;
                  SumArray       [AngleCounter] := SumArray       [AngleCounter] + MarkArray[i].Teta_1*180/pi;
            end;
        end;
     end;
     CurAngle     := CurAngle + aAzimWidow;
     AngleCounter := AngleCounter + 1;
  end;
  // ----- Считаю среднее по каждому участку -------------
  for k := 0 to Length(Result) - 1 do begin
      if Result  [k] <> 0 then
         SumArray[k] := SumArray[k]/Result  [k];
  end;

  // ---- Упорядычу масив SumArray по убыванию для нахождения максимума который мне нуно ----------------
  for i := 0 to length(TempResultArray) - 2 do begin
     max := TempResultArray[i];
     for k := i+1 to length(TempResultArray) - 1 do begin
        if max < TempResultArray[k] then begin
            max                := TempResultArray[k];
            TempResultArray[k] := TempResultArray[i];
            TempResultArray[i] := Max;

            Temp               := SumArray[k];
            SumArray[k]        := SumArray[i];
            SumArray[i]        := Temp;
        end;
     end;
  end;

  // -------- Вывод инфы --------
      if (aNumberAzim >  Length(TempResultArray)) or (SumArray[aNumberAzim - 1] = 0) then begin
          GroupBox3.Caption := 'Азимут: ---- ';
          MaxTetaAngle      := -999;
      end;
      if (aNumberAzim <= Length(TempResultArray)) and (Length(SumArray) <> 0) and (SumArray[aNumberAzim - 1] <> 0) then begin
          GroupBox3.Caption := 'Азимут: ' + FloatToStrF(SumArray[aNumberAzim - 1], ffFixed, 20, 1);
          MaxTetaAngle      := SumArray[aNumberAzim - 1];
      end;
end;

{===============================================================================
}
procedure TfrmStatAnalysis.DrawAlfaGraphic(aCanvas : TCanvas; aRect : TRect;
  Gistogram : TIntArray; aBeginAlfa, aEndAlfa : Integer);
var
  i : integer;

  BeginPosAxis   : TPoint;
  WidthXAxis     : Integer;
  WidthYAxis     : Integer;

  StepTicks  : TFloat;

  Temp       : TFloat;

  MaxGistogram : Integer;
  CoefYAxis    : TFloat;
begin
  // ---- Автоматическое определения конечного алфа --------
   if aEndAlfa = -1 then begin
      for i := 0 to Length(MarkArray) - 1 do begin
         if aEndAlfa < MarkArray[i].Alfa_1*180/pi then aEndAlfa := Round(MarkArray[i].Alfa_1*180/pi) + 2;
      end;
   end;
  // -----------------------------------------
  BeginPosAxis := point(aRect.Left + 10, aRect.Bottom - 15);

  WidthXAxis    := aRect.Right  - aRect.Left - 40;
  WidthYAxis    := (aRect.Bottom - aRect.Top) - 40;

  StepTicks     := WidthXAxis / Length(Gistogram);

  with aCanvas do begin
     Pen.Style := psSolid;
     Pen.Color := clBlack;
     Brush.Color := clWhite;
     Brush.Style := bsSolid;


     aCanvas.Font.Size := 8;

     // ------ Очитка зоны отрисовки --------
//     FillRect(aRect);
     // ------- Оси ---------
     MoveTo(BeginPosAxis.x-5, BeginPosAxis.y); LineTo(BeginPosAxis.x + WidthXAxis + 20, BeginPosAxis.y);
     MoveTo(BeginPosAxis.x, BeginPosAxis.y+5); LineTo(BeginPosAxis.x, BeginPosAxis.y - WidthYAxis - 20);
     // ------- Стрелочки ------------
     MoveTo(BeginPosAxis.x + WidthXAxis + 20 - 10, BeginPosAxis.y - 2); LineTo(BeginPosAxis.x + WidthXAxis + 20     , BeginPosAxis.y    ); LineTo(BeginPosAxis.x + WidthXAxis + 20 - 10, BeginPosAxis.y + 2);
     MoveTo(BeginPosAxis.x - 2, BeginPosAxis.y - WidthYAxis - 20 + 10); LineTo(BeginPosAxis.x    , BeginPosAxis.y - WidthYAxis - 20); LineTo(BeginPosAxis.x + 2, BeginPosAxis.y - WidthYAxis - 20 + 10);
     // ------- Разбивка горизонтальной оси на участки ---------------
     Temp := StepTicks;
     While Temp <= WidthXAxis do begin
            MoveTo(Round(BeginPosAxis.x + Temp), BeginPosAxis.y-2);
            LineTo(Round(BeginPosAxis.x + Temp), BeginPosAxis.y+3);
            Temp := Temp + StepTicks;
     end;
     // ------- Вывод отметок на оси Х ----------------
     TextOut(BeginPosAxis.x - 10, BeginPosAxis.y + 2, intToStr(aBeginAlfa));
     TextOut(BeginPosAxis.x + WidthXAxis - TextWidth(intToStr(aEndAlfa)) div 2, BeginPosAxis.y + 2, intToStr(aEndAlfa));
     // ------- Вывод Гистограммы --------------
        // ---  Максимум гистограммы -------
        MaxGistogram := 0; for i := 0 to Length(Gistogram) - 1 do if MaxGistogram < Gistogram[i] then MaxGistogram := Gistogram[i];
        if MaxGistogram = 0 then exit;
        CoefYAxis    := WidthYAxis/MaxGistogram;
        Brush.Color := clGray;
        // --- Сама гистограмма ---------------
        for i := 0 to Length(Gistogram) - 1 do begin
           if i = Length(Gistogram) - 1 then
                 Rectangle(Round(BeginPosAxis.x + i*StepTicks),
                           BeginPosAxis.y + 1,
                           Round(BeginPosAxis.x + (i+1)*StepTicks),
                           Round(BeginPosAxis.y - Gistogram[i]*CoefYAxis))
           else
                 Rectangle(Round(BeginPosAxis.x + i*StepTicks),
                           BeginPosAxis.y + 1,
                           Round(BeginPosAxis.x + (i+1)*StepTicks + 1),
                           Round(BeginPosAxis.y - Gistogram[i]*CoefYAxis));
        end;
        Brush.Color := clWhite;
  end;
end;

{===============================================================================
}
procedure TfrmStatAnalysis.DrawTetaGraphic(aCanvas : TCanvas; aRect : TRect;
  Gistogram : TIntArray; aAzimWindow : Integer);
var
  i, Counter   : Integer;

  BeginPosAxis : TPoint;
  WidthXAxis   : Integer;
  WidthYAxis   : Integer;

  MaxGistogram : Integer;
  CoefAxis    : TFloat;

  CurAngle    : TFloat;

  StepAngleInSector      : TFloat;
  BeginSector, EndSector : TFloat;
begin
  BeginPosAxis := point(aRect.Left + (aRect.Right-aRect.Left) div 2, aRect.Top + (aRect.Bottom - aRect.Top) div 2);

  WidthXAxis    := ((aRect.Right  - aRect.Left) div 2) - 25;
  WidthYAxis    := ((aRect.Bottom - aRect.Top ) div 2) - 25;

  // ----- to Delete ----
//  for i := 0 to Length(Gistogram) - 1 do Gistogram[i] := 150 - Random(150);
  // ----- End of to Delete ----

  with aCanvas do begin
     Pen.Style := psSolid;
     Pen.Color := clBlack;
     Brush.Color := clWhite;
     Brush.Style := bsSolid;

     aCanvas.Font.Size := 8;

     // ------ Очитка зоны отрисовки --------
//     FillRect(aRect);
     // ------- Оси ---------
     MoveTo(BeginPosAxis.x - WidthXAxis - 15, BeginPosAxis.y); LineTo(BeginPosAxis.x + WidthXAxis + 15, BeginPosAxis.y);
     MoveTo(BeginPosAxis.x, BeginPosAxis.y - WidthYAxis - 15); LineTo(BeginPosAxis.x, BeginPosAxis.Y + WidthYAxis + 15);
     // ------- Вывод отметок на оси Х ----------------
     TextOut(BeginPosAxis.x + 2                                    , BeginPosAxis.y - WidthYAxis - 15 - 5                    , '0');
     TextOut(BeginPosAxis.x + WidthXAxis + 15 + 5 - TextWidth('90'), BeginPosAxis.y + 2                                      , '90');
     TextOut(BeginPosAxis.x + 2                                    , BeginPosAxis.y + WidthYAxis + 15 + 5 - TextHeight('180'), '180');
     TextOut(BeginPosAxis.x - WidthXAxis - 15 - 5                  , BeginPosAxis.y + 2                                      , '270');
     // ------- Вывод Гистограммы --------------
        // ---  Максимум гистограммы -------
        MaxGistogram := 0; for i := 0 to Length(Gistogram) - 1 do if MaxGistogram < Gistogram[i] then MaxGistogram := Gistogram[i];
        if MaxGistogram = 0 then exit;
        CoefAxis    := WidthYAxis/MaxGistogram;
        Brush.Color := clGray;
        // ----- Отрисовка самойй гистограммы ------------------
        BeginSector       := 0;
        Counter           := 0;
        StepAngleInSector := aAzimWindow/Round(aAzimWindow / 0.5);
        while BeginSector < 360 do begin
            EndSector         := BeginSector + aAzimWindow;

            CurAngle  := BeginSector;
            while CurAngle < EndSector do begin
                  MoveTo(Round(BeginPosAxis.x + sin(curAngle*pi/180                    )*Gistogram[Counter]*CoefAxis),
                         Round(BeginPosAxis.y - cos(curAngle*pi/180                    )*Gistogram[Counter]*CoefAxis));
                  LineTo(Round(BeginPosAxis.x + sin((curAngle+StepAngleInSector)*pi/180)*Gistogram[Counter]*CoefAxis),
                         Round(BeginPosAxis.y - cos((curAngle+StepAngleInSector)*pi/180)*Gistogram[Counter]*CoefAxis));

                  CurAngle := CurAngle + StepAngleInSector;

                  if CurAngle >= 360 then Break;
            end;
            MoveTo(BeginPosAxis.x, BeginPosAxis.y);
            LineTo(Round(BeginPosAxis.x + sin((BeginSector)*pi/180)*Gistogram[Counter]*CoefAxis), Round(BeginPosAxis.y - cos((BeginSector)*pi/180)*Gistogram[Counter]*CoefAxis));

            MoveTo(BeginPosAxis.x, BeginPosAxis.y);
            if EndSector < 360 then LineTo(Round(BeginPosAxis.x + sin((EndSector  )*pi/180)*Gistogram[Counter]*CoefAxis), Round(BeginPosAxis.y - cos((EndSector  )*pi/180)*Gistogram[Counter]*CoefAxis));

            Counter     := Counter   + 1;
            BeginSector := BeginSector + aAzimWindow;
        end;
        Brush.Color := clWhite;
  end;
end;

{===============================================================================
}
procedure TfrmStatAnalysis.seBeginAlfaChange(Sender: TObject);
begin
//  Edit1Chang(Sender);
  //-----------------------
  seEndAlfa.MinValue := seBeginAlfa.Value + 1;
  if seBeginAlfa.Value >= seEndAlfa.Value - 1 then seBeginAlfa.Value := seEndAlfa.Value - 1;

  if seEndAlfa.Value - seBeginAlfa.Value < seNumberAzim.Value then begin
       seNumberAzim.Value    := seEndAlfa.Value - seBeginAlfa.Value;
       seNumberAzim.MaxValue := seEndAlfa.Value - seBeginAlfa.Value;
  end;

  BitBtn1Click(Sender);
end;

{===============================================================================
}
procedure TfrmStatAnalysis.seEndAlfaChange(Sender: TObject);
begin
//  Edit1Chang(Sender);
  //-----------------------
  seBeginAlfa.MaxValue := seEndAlfa.Value - 1;
  if seEndAlfa.Value <= seBeginAlfa.Value + 1 then seEndAlfa.Value := seBeginAlfa.Value + 1;

  if seEndAlfa.Value - seBeginAlfa.Value < seNumberAzim.Value then begin
       seNumberAzim.Value    := seEndAlfa.Value - seBeginAlfa.Value;
       seNumberAzim.MaxValue := seEndAlfa.Value - seBeginAlfa.Value;
  end;

  BitBtn1Click(Sender);
end;

{===============================================================================
}
procedure TfrmStatAnalysis.seNumberAzimChange(Sender: TObject);
begin
//  Edit1Chang(Sender);
  //-----------------------
  seNumberAzim.MaxValue := seEndAlfa.Value - seBeginAlfa.Value;
  if seNumberAzim.Value < 1 then seNumberAzim.Value := 1;
//  if seNumberAzim.MaxValue = 1 then seNumberAzim.Value := 1;

  BitBtn1Click(Sender);
end;

{===============================================================================
}
procedure TfrmStatAnalysis.seAzimWindowChange(Sender: TObject);
begin
  BitBtn1Click(Sender);
end;

{===============================================================================
}
procedure TfrmStatAnalysis.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

procedure TfrmStatAnalysis.Label5Click(Sender: TObject);
begin
  Edit1.Text := FloatToStrF(LasFile.WellInf.Start, ffFixed, 16, 4);
  Edit2.Text := FloatToStrF(LasFile.WellInf.Stop , ffFixed, 16, 4);
end;

end.
