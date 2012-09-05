//////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////   Важная инфа    ////////////////////////////////////////////////
////   1. Canvu нуно передавать в класс TPlanshet при максимальном ее размере                             ////
////   2. в классе TPlanshet в методе Create нужно соблюдать очередность передачи параметров              ////
////   3. Чтоб на Image Plansheta чтото было сначала на форму нуно ложить имедж а потом все остальное !!! ////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
unit mpiDeclaration;

interface

uses Windows, Classes, Graphics, extCtrls, StdCtrls, {} SysUtils{}, mpiLibrary;

const
  ProjectCaption = 'Plastomer 1.0';
  frmMainCaption = 'Plastomer 1.0 - ';

  SmPerInch       = 2.5413793103448275862068965517241;
  HeadingFontSize = 12;
  RamkaPenWidth   = 2;

type
  TFloatPoint  = record x, y : TFloat end;
  TWhereIAm    = (wiaPole, wiaHead, wiaNone);
  TInputParam  = (ipHand, ipAvto);

   TSeriesParam = packed record
      index     : Integer;

      PenColor  : Integer;
      PenStyle  : Integer;
      PenWidth  : Integer;

      fMin      : Extended;
      fMax      : Extended;
   end;
   //////////////////////////////////////////
   TPlanshetParam = packed record
      Pole_Visible    : array [0..2] of Boolean;
      CountSeriesPole : array [0..2] of Integer;
      SeriesListPole  : array [0..2] of array of TSeriesParam;
      // -----------
      MashtabCoef      : Integer;
      ScrollBarPos     : Integer;
      // -----------
      OtmetkiVisible       : Boolean;
      ListOtmetkiVisible   : Boolean;
      // -----------
      WindowsValuePosition : TPoint;
      WindowsOtmetkiValue  : TPoint;
   end;
   //////////////////////////////////////////
   TKoreljation = packed record
     Kor       : TFloat;
     Offset    : Integer;
     iSeries1  : integer; // ------ Ведомая ----------
     iSeries2  : integer; // ------ Ведущая ----------
   end;
   //////////////////////////////////////////
   PMarks = ^TMarks;
   TMarks = packed record
      fCurrentDepth  : TFloat;

      Alfa_1         : TFloat;
      Teta_1         : TFloat;

      Alfa_2         : TFloat;
      Teta_2         : TFloat;
      kArray         : array [0..1] of TKoreljation;
   end;
   //////////////////////////////////////////

   TMinMax = Record
     Value1     , Value2      : TFloat;
     IndexValue1, IndexValue2 : Integer;
   end;
   //////////////////////////////////////////
   TLabelType = record
     lName  : TLabel;
     lValue : TLabel;
   end;
   //////////////////////////////////////////
   TSeries = class
   private
     procedure Set_Value(index: Integer; const Value: TFloat);
   public
      Name       : String;   // ----- Имя Серии *---------------
      FileName   : String;
      Dimension  : String;   // ----- Размерность Кривой -------------
     // ---------------
      Data       : PFloatPointerArray;
      NullValue  : TFloat;
      Step       : TFloat;
      Count      : Integer;  // -----  Количество данных ---------
      BeginDepth : TFloat;
      EndDepth   : TFloat;
      Parent     : Pointer;
     // ---------------
      MinValue   : TFloat;    // -----  Минимальное значение ---------
      MaxValue   : TFloat;    // ----- Максимальное значение ----------------

      CorrectMinValue : TFloat;  // ---- Откоретированные значения максимумов и минимумов кривой -------
      CorrectMaxValue : TFloat;  // ---- предназначенных для вывода на график ----------

      coefY           : TFloat; // ---- Масштабный коеффициент для кривой отображенной на екране --------

      PenColor   : TColor;
      PenStyle   : TPenStyle;
      PenWidth   : Integer;

      Selected   : Boolean;
      KoreljationOffset : Integer;

      CountPointInGraphic : Integer; // ---- Количество реально выведеных на поле точек Series
      GraphPoints   : array [0..1500] of TPoint;  // ---- Массив предназначеный для содержание точек для выводп на PolyLine

      constructor create;
      destructor  destroy; override;

      property AddValue[index : Integer] : TFloat write Set_Value;
   end;
   //////////////////////////////////////////
   TPole = class
   private
     Canvas           : TCanvas;
     fPoleWidth        : Integer;
     fPoleHeight       : Integer;

//     fpPolesCount      : pByte;
     fpOffsetX         : pInteger;
//     fpMinPlanshetTime : pDouble;
//     fpMaxPlanshetTime : pDouble;

//     procedure Set_Canvas(aCanvas : TCanvas);
       procedure Draw_Series();
       procedure Draw_HeadingOfDiagram();
   public
       SeriesList       : TList;
       PoleRect         : TRect;
       HeadRect         : TRect;

       xValues          : TSeries;
       MashtabCoef      : pInteger;

       Visible          : Boolean;
       procedure Draw();
       constructor create();
       destructor destroy; override;
       property PoleWidth : Integer read fPoleWidth;
   end;
   //////////////////////////////////////////
    TPlanshet = class
    private
      fCanvas           : TCanvas;
      fScrollBarOffset  : Integer;
      //------------------
      fWhereIAm         : TWhereIAm;
      fCurrentPole      : Integer;
      fNumberSeries     : Integer;
      fCurrentSeries    : TSeries;
      fSelectedSeries   : TSeries;
      fSelectedMark     : PMarks;
      fDepthArrayIndex  : Integer; // --- Индекс в масиве глубины ------
      //------------------
      fiStartScreenDepth : Integer; // --- Начальный Индекс в масиве глубины планшета ------
      fiStopScreenDepth  : Integer; // --- Конечный Индекс в масиве глубины планшета ------
      ffStartScreenDepth : TFloat;   // --- Начальная глубина планшета ------
      ffStopScreenDepth  : TFloat;   // --- Конечная глубина планшета ------
      //------------------
      fAssignedBitmap   : Boolean;

      oldScreenWidth      : Integer;
      oldScreenHeight     : Integer;
      OldPolesCount        : Integer;

      ClearBitmap   : TBitmap;
      fImageBitmap  : TBitmap;

      fScreenWidth        : PInteger;
      fScreenHeight       : PInteger;
      fMashtabCoef        : integer;

      fDepthInOneSantimetr: Integer;

      function  Get_HeadWidth() : Integer;
      procedure Set_Canvas(aCanvas : TCanvas);

      procedure Draw_Net_And_Labels;
      procedure Draw_Marks();
      procedure CheckResizeImage(CheckRes : Boolean);
      procedure Set_MashtabCoef(const Value: integer);
      procedure Set_DepthInOneSantimetr(const Value: Integer);
      procedure Set_AssignedBitmap(const Value: boolean);
    public
       PoleArray  : array [0..2] of TPole;

       ScrollBarMax    : PInteger;
       PolesCount      : Byte;
       DepthInOnePixel : TFloat;
       StartDepth      : TFloat;
//       FoneColor       : TColor;

       PoleMouseDownPresent  : Boolean;
       MarkEnabled           : Boolean;
       InputMarks            : Boolean;

       xValues               : TSeries;


       StepVerticalLines    : Integer; // ---- шаг в пикселя вертикальных линий поля ----
       CountHorizontalLines : Integer;   // ---- количество м горизонтальных линий поля -----
       ReDrawBitmap         : TBitmap;

       //function  Get_DepthIndex(aDetph : TFloat) : Integer;

       procedure draw(CheckRes : Boolean);
       procedure ReDraw();
       procedure CalcPositionPole();
       procedure Set_MouseCoordinate(x, y:Integer);
       procedure DeSelectSeries();

       constructor Create(aImageBitmap : TBitmap; aImageCanvas : TCanvas; aScreenWidth, aScreenHeight : PInteger);
       destructor  destroy; override;

       property Canvas : TCanvas read fCanvas write Set_Canvas;
       property ScrollBarOffset : Integer read fScrollBarOffset write fScrollBarOffset;

       property MashtabCoef     : integer read fMashtabCoef write Set_MashtabCoef;
       property DepthInOneSantimetr : Integer read fDepthInOneSantimetr   write Set_DepthInOneSantimetr;

       property WhereIAm       : TWhereIAm read fWhereIAm;
       property CurrentPole    : Integer   read fCurrentPole;
       property NumberSeries   : Integer   read fNumberSeries;
       property CurrentSeries  : TSeries   read fCurrentSeries;
       property SelectedSeries : TSeries   read fSelectedSeries write fSelectedSeries;
       property SelectedMark   : PMarks    read fSelectedMark write fSelectedMark;
       property DepthArrayIndex: Integer   read fDepthArrayIndex;

       property iStartScreenDepth : Integer read fiStartScreenDepth;
       property iStopScreenDepth  : Integer read fiStopScreenDepth;

       property AssignedBitmap : boolean read fAssignedBitmap write Set_AssignedBitmap;
    end;
   //////////////////////////////////////////

var
   Planshet         : TPlanshet;
   LasFileModified  : Boolean = false;
  // ------ Лаблы для вывода инвфы по кривым -------
   LabelArray     : array [0..2] of array of TLabelType;
   LabelDepth     : TLabel;
  // ------ Лаблы для вывода инвфы по кривым -------
   MarkArray      : array of TMarks;
  // ------ Загрузочные параметры планшета  -------
   PlanshetParam  : TPlanshetParam;
  // -----------------------------------------------
   PlanshetFoneColor  : TColor = 11716808;
  // -----------------------------------------------
   KoreljationWindow  : TFloat = 0.3;
  // -----------------------------------------------
   AngleBetweenBMK    : TFloat = pi/3;
  // -----------------------------------------------
   CheckApsidalAngle  : TFloat = 3*pi/180;
   OffsetVizirAngle   : TFloat = 0;
  // -----------------------------------------------
   InitialDir         : String;
  // -----------------------------------------------
   L_Big    : TFloat = 0.4;
   L_Small  : TFloat = 0.065;
   r0       : TFloat = 0.055;

implementation

uses mpiLasFile, mpiSaveLoadDataFile;

{===============================================================================
}
procedure OutRotateText(Canvas : TCanvas; x, y : Integer; Angle : Integer; OutText : String);
var
  lf : TLogFont;
  tf : TFont;
  rot  : Integer;
begin
  rot := Angle*10;
  with Canvas do begin
    tf := TFont.Create;
    try
      tf.Assign(Font);
      GetObject(tf.Handle, sizeof(lf), @lf);
      lf.lfEscapement := rot;
      lf.lfOrientation := Rot;
      tf.Handle := CreateFontIndirect(lf);
      Font.Assign(tf);
    finally
      tf.Free;
    end;
    TextOut(x, y, OutText);
  end;
end;

{ TPlanshet }

{===============================================================================
}
procedure TPlanshet.CalcPositionPole;
var
  a, b, c   : Double;
  i         : Byte;
  ZeroPos   : Integer;
  HeadWidth : Integer;
begin
  if OldPolesCount = 0 then exit;

  a := (0.033        {+ 0.06})*fScreenHeight^; // --- 3.3% --- отступы с верху и снизу ---- -- 6%   --- отступы на вывод времени ---
  b := fScreenHeight^ - 2*a - 0.03 *fScreenHeight^; // --- 6%   --- Отступ на легенду ----

  c         := b / OldPolesCount;
  ZeroPos   := Round(a);
  HeadWidth := Get_HeadWidth();

  i := 0;
  while i < 3 do begin
        if PoleArray[i].Visible then begin
            PoleArray[i].HeadRect.Left   := 1;
            PoleArray[i].HeadRect.Right  := HeadWidth;
            PoleArray[i].HeadRect.Top    := ZeroPos;
            PoleArray[i].HeadRect.Bottom := Round(PoleArray[i].HeadRect.Top + c);

            PoleArray[i].PoleRect.Left   := PoleArray[i].HeadRect.Right;
            PoleArray[i].PoleRect.Right  := fScreenWidth^-1;
            PoleArray[i].PoleRect.Top    := PoleArray[i].HeadRect.Top;
            PoleArray[i].PoleRect.Bottom := PoleArray[i].HeadRect.Bottom - 0;

            ZeroPos              := PoleArray[i].PoleRect.Bottom;

            PoleArray[i].fPoleWidth      := PoleArray[i].PoleRect.Right  - PoleArray[i].PoleRect.Left  - 2*RamkaPenWidth;
            PoleArray[i].fPoleHeight     := PoleArray[i].PoleRect.Bottom - PoleArray[i].PoleRect.Top   - 2*RamkaPenWidth;

    //      for j:=0 to Pole.SeriesList.count-1 do TSeries(Pole.SeriesList.Items[j]).Set_CoefY();

        end;
        i := i + 1;
  end;
end;

{===============================================================================
}
procedure TPlanshet.CheckResizeImage(CheckRes : Boolean);
var
  i, k : byte;
  Series : TSeries;
begin
  if (CheckRes) or (OldPolesCount <> PolesCount) or (oldScreenWidth <> fScreenWidth^) or (oldScreenHeight <> fScreenHeight^) then begin
      oldScreenWidth  := fScreenWidth^;
      oldScreenHeight := fScreenHeight^;
      OldPolesCount   := PolesCount;

      ClearBitmap.Width  := fScreenWidth^;
      ClearBitmap.Height := fScreenHeight^;

      if PolesCount = 0 then ClearBitmap.Canvas.Brush.Color := clgray
                        else ClearBitmap.Canvas.Brush.Color := PlanshetFoneColor;

      //  fCanvas.Brush.Color := nilBitmap.Canvas.Brush.Color;
      ClearBitmap.Canvas.FillRect(Rect(0, 0, ClearBitmap.Width, ClearBitmap.Height));
      //ClearBitmap.Canvas.Rectangle(Rect(0, 0, ClearBitmap.Width, ClearBitmap.Height));

      CalcPositionPole();
      // ---- Устанавливаю масштабные коеффициенты для Серий *------
      for i := 0 to 2 do
        if (PoleArray[i].SeriesList.Count <> 0) and PoleArray[i].Visible then
            for k := 0 to PoleArray[i].SeriesList.Count - 1 do begin
              Series       := TSeries(PoleArray[i].SeriesList.Items[k]);
              Series.coefY := (PoleArray[i].PoleRect.Bottom - PoleArray[i].PoleRect.Top) / ( Series.CorrectMaxValue - Series.CorrectMinValue );
            end;
  end;
end;

{===============================================================================
}
constructor TPlanshet.Create(aImageBitmap : TBitmap; aImageCanvas : TCanvas; aScreenWidth, aScreenHeight : PInteger);
var
 i : byte;
begin
    inherited create;
    OldScreenWidth   := -1;
    OldScreenHeight  := -1;
    OldPolesCount    := -1;
    PolesCount       := 3;
//    FoneColor        := RGB(200 ,200, 178);

    StepVerticalLines    := 100;
    CountHorizontalLines := 10;
    DepthInOnePixel      := 0.01;
    StartDepth           := 0;

    PoleMouseDownPresent     := False;
    MarkEnabled              := True;

    fScreenWidth  := aScreenWidth;
    fScreenHeight := aScreenHeight;

    fMashtabCoef  := 1;

    ClearBitmap  := TBitmap.Create;
    ReDrawBitmap := TBitmap.Create;

//    ClearBitmap .PixelFormat := pf4bit;
//    ReDrawBitmap.PixelFormat := pf4bit;

    //------------
    for i := 0 to 2 do begin
       PoleArray[i]             := TPole.Create;
       PoleArray[i].fpOffsetX   := @fScrollBarOffset;
       PoleArray[i].MashtabCoef := @fMashtabCoef;
    end;
    //------------

    fImageBitmap := aImageBitmap;
    Canvas       := aImageCanvas;

    // -------------
    SetDefaultParamForPlanshet();
end;

{===============================================================================
}
procedure TPlanshet.DeSelectSeries();
var
  i : integer;
begin
  fSelectedSeries := nil;

  for i := 0 to LasFile.SeriesList.Count - 1 do
      TSeries(LasFile.SeriesList.Items[i]).Selected := False;
end;

{===============================================================================
}
destructor TPlanshet.destroy;
var
  i : byte;
begin

  for i := 0 to 2 do PoleArray[i].Free;

  ClearBitmap.free;
  ReDrawBitmap.Free;
  inherited destroy;
end;

{===============================================================================
}
procedure TPlanshet.draw(CheckRes : Boolean);
var
  i : Integer;
begin
  CheckResizeImage(CheckRes);
  fCanvas.Brush.Color := PlanshetFoneColor;
  fCanvas.Draw(0,0,ClearBitmap);

  if PolesCount = 0 then exit;

  try Draw_Net_And_Labels(); except end;
  // --------------------------
  for i := 0 to 2 do
      if PoleArray[i].Visible then PoleArray[i].Draw;
  // --------------------------
  Draw_Marks();
end;

{===============================================================================
}
procedure TPlanshet.Draw_Marks();
var
 ai1, ai2 : Integer;
 i        : Integer;
 posX     : Integer;
 DepthIndex : Integer;
// LeftOffset : Integer;
 HeadWidth : Integer;
 PoleWidth : Integer;
begin
  if xValues = nil then exit;

  HeadWidth := Get_HeadWidth();
  PoleWidth := PoleArray[0].PoleRect.Right  - HeadWidth;
  with Canvas do begin
      // ----- Растановка начальной - конечной глубины в файле ----------
      if MashtabCoef >= 1 then begin
         ai1 := Round((0             + 0 + fScrollBarOffset) * MashtabCoef);
         ai2 := Round((PoleWidth - 2 + 0 + fScrollBarOffset) * MashtabCoef);
      end else begin
         ai1 := Round((0             + 0 + fScrollBarOffset) / (-MashtabCoef));
         ai2 := Round((PoleWidth - 2 + 0 + fScrollBarOffset) / (-MashtabCoef));
      end;
      // -------------
      if (ai1 < 0)                 then ai1 := 0;
      if (ai2 < 0)                 then ai2 := 0;
      if (ai1 > xValues.Count - 1) then ai1 := xValues.Count - 1;
      if (ai2 > xValues.Count - 1) then ai2 := xValues.Count - 1;

      fiStartScreenDepth := ai1;
      fiStopScreenDepth  := ai2;
      ffStartScreenDepth := xValues.Data^[ai1];
      ffStopScreenDepth  := xValues.Data^[ai2];

      // --------- Отрисовка Отметок -------------
      if MarkEnabled then begin
            for i := 0 to Length(MarkArray) - 1 do begin
                if ((MarkArray[i].fCurrentDepth >= ffStartScreenDepth) and
                   (MarkArray[i].fCurrentDepth <= ffStopScreenDepth)) or
                   ((MarkArray[i].fCurrentDepth <= ffStartScreenDepth) and
                   (MarkArray[i].fCurrentDepth >= ffStopScreenDepth)) then begin
                    Pen.Width := 1;
                    Pen.Color := clRed;

                    DepthIndex := LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth);

                    posX      := Round(DepthIndex/MashtabCoef - fScrollBarOffset);
                    if MashtabCoef < 1 then posX := - DepthIndex * MashtabCoef - fScrollBarOffset;


{                    if HeadWidth = 12321 then LeftOffset := 1;

                    if PoleArray[0].Visible then LeftOffset := HeadWidth
                                            else if PoleArray[1].Visible then LeftOffset := PoleArray[1].PoleRect.Left
                                                                         else LeftOffset := PoleArray[2].PoleRect.Left;

}                    posX := posX + HeadWidth + RamkaPenWidth;

                    if (i = Length(MarkArray) - 1) and InputMarks then begin
                       MoveTo(posX , PoleArray[0].PoleRect.Top - 5);
                       LineTo(posX , PoleArray[2].PoleRect.Bottom + 5);
                    end else begin
                       if (fSelectedMark <> nil) then begin
                         if (fSelectedMark^.fCurrentDepth =  MarkArray[i].fCurrentDepth) then begin
                             Pen.Width := 3;
                             Pen.Color := clBlue;
                             MoveTo(posX , PoleArray[0].PoleRect.Top - 5);
                             LineTo(posX , PoleArray[0].PoleRect.Top + 8);
                             MoveTo(posX , PoleArray[2].PoleRect.Bottom - 8);
                             LineTo(posX , PoleArray[2].PoleRect.Bottom + 5);
                         end;
                       end else begin
                         Pen.Width := 1;
                         Pen.Color := clRed;
                         MoveTo(posX , PoleArray[0].PoleRect.Top - 5);
                         LineTo(posX , PoleArray[0].PoleRect.Top + 8);
                         MoveTo(posX , PoleArray[2].PoleRect.Bottom - 8);
                         LineTo(posX , PoleArray[2].PoleRect.Bottom + 5);
                       end;
                    end;
                end;
            end;
      end;
  end;
end;

{===============================================================================
}
procedure TPlanshet.Draw_Net_And_Labels();
var
   curPos    : Integer;
   StepHLines : TFloat;
   RcurPos     : TFloat;
   OutputStr   : String;
   i           : Integer;
   Flag        : boolean;
   ArrayPos    : Integer;
   OffsetYTextPos : Integer;
   HeadWidth      : Integer;
begin
  with Canvas do begin
    Font.Size := HeadingFontSize;
    Pen.Width := 1;
    Pen.Color := clGray;
    Pen.Style := psSolid;
    Flag      := True;
    HeadWidth := Get_HeadWidth();

    for i := 0 to 2 do begin
       if PoleArray[i].Visible then begin
           // ---- Отрисовка Вертикальных линий  ----------
           CurPos := -ScrollBarOffset + PoleArray[i].PoleRect.Left + RamkaPenWidth + Round(ScrollBarOffset/StepVerticalLines)*StepVerticalLines;

           while curPos < PoleArray[i].PoleRect.Right do begin
              if CurPos >= RamkaPenWidth + PoleArray[i].PoleRect.Left  then begin
                 MoveTo(curPos, PoleArray[i].PoleRect.Top    + 1);
                 LineTo(curPos, PoleArray[i].PoleRect.Bottom - 1);
              end;
              // ---- Отрисовка Лаблов ----------
              if Flag then begin
                   // ??????????????????????????????

                  ArrayPos := curPos - HeadWidth + fScrollBarOffset - RamkaPenWidth;
                  if fMashtabCoef >= 1 then ArrayPos := ArrayPos*fMashtabCoef
                                       else ArrayPos := Round(ArrayPos/(-fMashtabCoef));

                  if (PoleArray[0].xValues <> nil) then begin
                     if (ArrayPos > 0) and (ArrayPos < PoleArray[0].xValues.Count) then OutputStr   := FloatToStrF(PoleArray[0].xValues.data^[ArrayPos], ffFixed, 10, 2)
                                                                                   else OutputStr := '--------';
                  end else OutputStr := '--------';

                  //OutputStr   := FloatToStrF(OutputDepth, ffFixed, 10, 2);
                  OffsetYTextPos := PoleArray[2].PoleRect.Bottom;
                  if (not PoleArray[1].Visible) and (not PoleArray[2].Visible) then OffsetYTextPos := PoleArray[0].PoleRect.Bottom
                                                                               else if not PoleArray[2].Visible then OffsetYTextPos := PoleArray[1].PoleRect.Bottom;

                  TextOut(curPos - TextWidth(OutputStr) div 2, OffsetYTextPos + 10, OutputStr);

                  FillRect(Rect(0,PoleArray[2].HeadRect.Bottom + 2, 25, PoleArray[2].HeadRect.Bottom + 60));
              end;
              curPos := curPos + StepVerticalLines;
           end;

           // ---- Отрисовка Горизонтальных линий  ----------
           StepHLines := (PoleArray[i].PoleRect.Bottom - PoleArray[i].PoleRect.Top - 1) / CountHorizontalLines;
           RcurPos     := PoleArray[i].PoleRect.Top;
           while RcurPos < PoleArray[i].PoleRect.Bottom do begin
              MoveTo(PoleArray[i].PoleRect.Left  + 1,  Round(RcurPos));
              LineTo(PoleArray[i].PoleRect.Right - 1,  Round(RcurPos));

              RcurPos := RcurPos + StepHLines;
           end;
           Flag := False;
       end;
    end;
  end;
end;

{===============================================================================
}
{function TPlanshet.Get_DepthIndex(aDetph: TFloat): Integer;
begin
 Result    := Round(abs(aDetph - XValues.MinValue)/ XValues.Step);
// Result    := Round(abs(aDetph - XValues.Data^[0])/ XValues.Step);
// if (Result < 0) or (Result > CountData-1) then result := -1;
end;
}
{===============================================================================
}
function TPlanshet.Get_HeadWidth: Integer;
var
 i          : integer;
 Value      : Integer;
 aHeadWidth : Integer;
begin
  fCanvas.Font.Size  := HeadingFontSize;
  fCanvas.Font.Style := [];
  fCanvas.Font.Name  := 'Tahoma';
  aHeadWidth         := 0;
//        MainRightPos  := HeadRect.Left + (i+1)*2*_TextHeight;
  for i := 0 to 2{PolesCount-1} do begin
    Value := PoleArray[i].SeriesList.count*2*fCanvas.TextHeight('0') ;
    if (aHeadWidth < Value) and (PoleArray[i].Visible) then aHeadWidth := Value;
  end;
  result := aHeadWidth + fCanvas.TextHeight('0');
end;

{===============================================================================
}
procedure TPlanshet.ReDraw;
begin
  fCanvas.Draw(0,0,ReDrawBitmap);
end;

{===============================================================================
}
procedure TPlanshet.Set_AssignedBitmap(const Value: boolean);
begin
  if fAssignedBitmap <> Value then
    if Value then ReDrawBitmap.Assign(fImageBitmap);

  fAssignedBitmap := Value;
end;

{===============================================================================
}
procedure TPlanshet.Set_Canvas(aCanvas: TCanvas);
begin
 fCanvas := aCanvas;
 PoleArray[0].Canvas := aCanvas;
 PoleArray[1].Canvas := aCanvas;
 PoleArray[2].Canvas := aCanvas;
end;

{===============================================================================
}
procedure TPlanshet.Set_DepthInOneSantimetr(const Value: Integer);
begin
  if PolesCount = 0 then exit;
  fDepthInOneSantimetr := Value;

//  DepthInOnePixel          :=   (fCanvas.Font.PixelsPerInch * SmPerInch*(Value*fMashtabCoef)*60)
//                             / (PoleArray[0].PoleRect.Right - PoleArray[0].PoleRect.Left - 2*RamkaPenWidth)
//                             * OneSecondValue;

  //-------------------
//  TempValue := (fMaxPlanshetTime - fMinPlanshetTime)/TimeInOnePixel - 7;
//  if abs(TempValue) < 2147483647 then fMaxScrollBarValue := Round(TempValue);
//  if fMaxPlanshetTime = -1      then fMaxScrollBarValue := 1;
  //-------------------
//  Set_PlanshetParam();
//
end;

{===============================================================================
}
procedure TPlanshet.Set_MashtabCoef(const Value: integer);
begin
  fMashtabCoef := Value;
  DepthInOneSantimetr := fDepthInOneSantimetr;
end;

{===============================================================================
}
procedure TPlanshet.Set_MouseCoordinate(x, y: Integer);
var i,           k : Integer;
    x1, x2, y1, y2 : Integer;
    _TextHeight    : Integer;
    ArPoint        : array [0..4] of Tpoint;
    Series         : TSeries;
    Flag           : Boolean;
    HeadWidth      : Integer;
    TempValue      : Integer;
begin
  fCurrentPole     := -1;
  fDepthArrayIndex := -1;
  fNumberSeries    := -1;
  fCurrentSeries   := nil;
  fSelectedMark    := nil;
  HeadWidth        := Get_HeadWidth();
  // -------------------------------
  Flag := False;
  // -------------------------------
  for i := 0 to 2 do begin
    if PoleArray[i].Visible then begin
       if (x > PoleArray[i].PoleRect.Left) and (x < PoleArray[i].PoleRect.Right) and (y > PoleArray[i].PoleRect.Top) and (y < PoleArray[i].PoleRect.Bottom) then begin
           fWhereIAm    := wiaPole;
           fCurrentPole := i;
           Break;
       end else
       if (x > PoleArray[i].HeadRect.Left) and (x < PoleArray[i].HeadRect.Right) and (y > PoleArray[i].HeadRect.Top) and (y < PoleArray[i].HeadRect.Bottom) then begin
           fWhereIAm    := wiaHead;
           fCurrentPole := i;
           Break;
       end else fWhereIAm := wiaNone;
    end;
  end;
  // ----------------------------
  if fWhereIAm = wiaHead then begin // ---Тут нуно определить серию и ее номер
      fCanvas.Font.Size   := HeadingFontSize;
      fCanvas.Font.Name   := 'Tahoma';
      _TextHeight := fCanvas.TextHeight('0');

      for i := 0 to PoleArray[fCurrentPole].SeriesList.Count - 1 do begin
         if PoleArray[fCurrentPole].SeriesList.Count <> 0 then begin
             x1 := PoleArray[fCurrentPole].HeadRect.Left + (i+0)*2*_TextHeight;
             x2 := PoleArray[fCurrentPole].HeadRect.Left + (i+1)*2*_TextHeight;
             y1 := PoleArray[fCurrentPole].HeadRect.Top;
             y2 := PoleArray[fCurrentPole].HeadRect.Bottom;
             if (x > x1) and (x < x2) and (y > y1) and (y < y2) then begin
                  fNumberSeries  := i;
                  fCurrentSeries := TSeries(PoleArray[fCurrentPole].SeriesList.Items[i]);

                  fCanvas.Pen.Style := psSolid;
                  fCanvas.Pen.Color := clBlack;
                  fCanvas.Pen.Width := 1;

                  fCanvas.MoveTo(x1+3, y1+3);
                  fCanvas.LineTo(x2-2, y1+3);
                  fCanvas.LineTo(x2-2, y2-4);
                  fCanvas.LineTo(x1+3, y2-4);
                  fCanvas.LineTo(x1+3, y1+3);

                  fCanvas.MoveTo(x1+2, y1+2);
                  fCanvas.LineTo(x2-3, y1+2);
                  fCanvas.LineTo(x2-3, y2-3);
                  fCanvas.LineTo(x1+2, y2-3);
                  fCanvas.LineTo(x1+2, y1+2);

                  Break;
             end;
         end;
      end;
  end;
  // ----------------------------
  if fWhereIAm = wiaPole then begin // ---Тут нуно определить текущий индекс глубины -------
      fCanvas.Pen.Style := psSolid;
      fCanvas.Pen.Color := clBlack;
      fCanvas.Pen.Width := 1;

      fCanvas.MoveTo(x, PoleArray[0].PoleRect.Top + 3   );
      fCanvas.LineTo(x, PoleArray[2].PoleRect.Bottom - 3);


      fDepthArrayIndex  := x - HeadWidth - RamkaPenWidth + fScrollBarOffset;

      if fMashtabCoef >= 1 then fDepthArrayIndex := fDepthArrayIndex*fMashtabCoef
                           else fDepthArrayIndex := Round(fDepthArrayIndex/(-fMashtabCoef));


      for k := 0 to 2 do begin
        for i := 0 to Length(LabelArray[k]) - 1 do begin
            if Length(LabelArray[k]) = 0 then break;
            Series := TSeries(PoleArray[k].SeriesList[i]);

            if (fDepthArrayIndex > 0) and (fDepthArrayIndex < Series.Count) then begin
                if not Flag then labelDepth.Caption := FloatToStrF(PoleArray[0].xValues.data^[fDepthArrayIndex], ffFixed, 10, 4);

                if Series.Data^[fDepthArrayIndex] <> Series.NullValue then LabelArray[k][i].lValue.Caption := FloatToStrF(Series.Data^[fDepthArrayIndex], ffFixed, 10, 4)
                                                                else LabelArray[k][i].lValue.Caption := '------------------';

                Flag := true;
            end else begin
                LabelArray[k][i].lValue.Caption := '------------------';
                fDepthArrayIndex := -1;
            end;

        end;
      end;
     // -------- Определяю отметку ---------
     if xValues = nil then exit;
      if (fDepthArrayIndex <> -1) and (fDepthArrayIndex > 1) and (fDepthArrayIndex < xValues.Count - 2) and (Length(MarkArray) <> 0) then begin
         for i := 0 to Length(MarkArray) - 1 do begin
             if (MarkArray[i].fCurrentDepth  >= xValues.Data^[fDepthArrayIndex-1]) and (MarkArray[i].fCurrentDepth  <= xValues.Data^[fDepthArrayIndex+1]) then begin
                 fSelectedMark := @MarkArray[i];
                 Draw_Marks();
                 break;
             end;
         end;
      end;
  end;
  // ----------------------------
  if (fWhereIAm = wiaNone) or (fWhereIAm = wiaHead) then begin
      labelDepth.Caption := '------------------';
      for k := 0 to 2 do
        for i := 0 to Length(LabelArray[k]) - 1 do
           if Length(LabelArray[k]) <> 0 then LabelArray[k][i].lValue.Caption := '------------------';
  end;
end;

{ TPole }

{===============================================================================
}
constructor TPole.create();
begin
  inherited Create;
  Visible := True;
  SeriesList := TList.Create;
end;

{===============================================================================
}
destructor TPole.destroy;
begin

  SeriesList.Free;
  inherited Destroy;
end;

{===============================================================================
}
procedure TPole.Draw;
//var
//  i : Integer;
begin
     with Canvas do begin
            Pen.Color := clBlack;
            Pen.Width := RamkaPenWidth;
            // --- Рисую зоны Заголовков -----
            //Rectangle(HeadRect);
            MoveTo(HeadRect.Left,  HeadRect.Top);
            LineTo(HeadRect.Right, HeadRect.Top);
            LineTo(HeadRect.Right, HeadRect.Bottom);
            LineTo(HeadRect.Left,  HeadRect.Bottom);
            LineTo(HeadRect.Left,  HeadRect.Top);
            // --- Рисую зоны полей -----
            MoveTo(PoleRect.Left,  PoleRect.Top);
            LineTo(PoleRect.Right, PoleRect.Top);
            LineTo(PoleRect.Right, PoleRect.Bottom);
            LineTo(PoleRect.Left,  PoleRect.Bottom);
            // --------------------------

            if SeriesList.Count <> 0 then begin
              Draw_HeadingOfDiagram();
              Draw_Series();
            end;
     end; // --- with fCanvas do begin
end;

{===============================================================================
}
procedure TPole.Draw_HeadingOfDiagram;
var
 _TextHeight  : Integer;
 Series       : TSeries;
 i            : Integer;
 MainRightPos : Integer;
 TempPosition : Integer;
 _TextWidth   : Integer;
 OutStr       : String;
begin
  with canvas do begin
    Font.Size   := HeadingFontSize;
    Font.Name   := 'Tahoma';
    _TextHeight := TextHeight('0');
    for i := 0 to SeriesList.Count - 1 do begin
        Series     := TSeries(SeriesList.Items[i]);

        MainRightPos  := HeadRect.Left + (i+1)*2*_TextHeight;

        if Series.Selected then begin
          //Brush.Style := bsVertical;
          Pen.Width  := 2;
          Pen.Color  := clBlack;

          Brush.Color := clSilver;
          Rectangle(MainRightPos + 4 - 2*_TextHeight, HeadRect.Top + 4,MainRightPos-2, HeadRect.Bottom-2);
          //Brush.Color := PlanshetFoneColor;
        end;

        //Font.Color := Series.PenColor;
        Pen.Color  := Series.PenColor;
        Pen.Style  := Series.PenStyle;
        Pen.Width  := Series.PenWidth;

        MoveTo(MainRightPos , HeadRect.Top    + RamkaPenWidth);
        LineTo(MainRightPos , HeadRect.Bottom - RamkaPenWidth*2);

        TempPosition  := MainRightPos - _TextHeight - 4 - 2;
        //-------------------------
        Font.Size  := HeadingFontSize;
        Font.Style := [fsBold];
        OutStr     := Series.Name;
        _TextWidth := TextWidth(OutStr);
        OutRotateText(Canvas, TempPosition, HeadRect.Top + (HeadRect.Bottom - HeadRect.Top + _TextWidth) div 2,90, OutStr);
        //-------------------------
        Font.Size  := HeadingFontSize-2;
        Font.Style := [];
        //-------------------------
        OutStr      := FloatToStrF(Series.CorrectMaxValue, ffFixed, 7, 2);
        _TextWidth := TextWidth(OutStr);
        OutRotateText(Canvas, TempPosition+4, HeadRect.Top + 5 + _TextWidth + RamkaPenWidth,90, OutStr);
        //-------------------------
        OutStr      := FloatToStrF(Series.CorrectMinValue, ffFixed, 7, 2);
        OutRotateText(Canvas, TempPosition+4, HeadRect.Bottom - 5 - RamkaPenWidth,90, OutStr);
        //-------------------------
        Brush.Color := PlanshetFoneColor;
    end;
    OutRotateText(Canvas, -100, -100,0, OutStr);
  end;
end;

{===============================================================================
}
function Get_MinMax(aValue : PFloatPointerArray; index1, index2 : Integer) : TMinMax;
var
  i : integer;
begin
     Result.Value1      :=  aValue^[index1];
     Result.Value2      :=  aValue^[index2];
     Result.IndexValue1 :=  index1;
     Result.IndexValue2 :=  index2;

     for i := index1+1 to index2-1 do begin
        if Result.Value1 > aValue^[i] then begin Result.Value1 := aValue^[i]; Result.IndexValue1 := i; end;
        if Result.Value2 < aValue^[i] then begin Result.Value2 := aValue^[i]; Result.IndexValue2 := i; end;
     end;
end;

{===============================================================================
}
procedure TPole.Draw_Series;
var
 k, i            : integer;

 Series          : TSeries;

 OffsetYValue     : TFloat;

 ArrayIndex1      : Integer;
 OldArrayIndex    : Integer;
// ArrayIndex2      : Integer;

// MinMax           : TMinMax;
// OldMinMax        : TMinMax;
// CoefMinMax       : Integer;

 yValue           : Integer;
// KorOffset        : Integer;

begin
  with Canvas do begin
      for k := 0 to SeriesList.Count - 1 do begin
             Series := TSeries(SeriesList.Items[k]);

             Pen.Color   := Series.PenColor;
             Pen.Style   := Series.PenStyle;
             Pen.Width   := Series.PenWidth;

//             KorOffset := 0;
//             if Series.Selected then KorOffset := Series.KoreljationOffset;


             // ---- Промежуточные переменные -----
                OffsetYValue          := PoleRect.Top + RamkaPenWidth + Series.CorrectMaxValue * Series.CoefY;
                Series.CountPointInGraphic     := 0;
             // -----------------------------------
               OldArrayIndex := -1;
//             CoefMinMax := -1;
//             FillChar(OldMinMax, sizeOf(OldMinMax), 0);

             for i := 0 to fPoleWidth-2 do begin
                // ---- Текущий елемент Масива -------

                  if MashtabCoef^ >= 1 then ArrayIndex1 :=  Round((i + 0 + fpOffsetX^ ) * MashtabCoef^) + Series.KoreljationOffset
                                       else ArrayIndex1 := -Round((i + 0 + fpOffsetX^ ) / MashtabCoef^) + Series.KoreljationOffset;

{                  if MashtabCoef^ <> 1 then begin
                           if MashtabCoef^ >= 1 then ArrayIndex2 := Round((i + 1 + fpOffsetX^) * MashtabCoef^)
                                                else ArrayIndex2 := Round((i + 1 + fpOffsetX^) / (-MashtabCoef^));
                           //--------------
                           if ArrayIndex1 <> ArrayIndex2 then
                                 if (ArrayIndex1 < Series.Count) and (ArrayIndex1 >= 0) and (ArrayIndex2 < Series.Count) and (ArrayIndex2 >= 0) then begin
                                       MinMax :=  Get_MinMax(Series.Data, ArrayIndex1, ArrayIndex2); // if i = 0 then OldMinMax := MinMax;

                                       if CoefMinMax < 0 then begin
                                         if Series.Data^[ArrayIndex1] > Series.Data^[MinMax.IndexValue1]    then ArrayIndex1 :=    MinMax.IndexValue1;
                                         if Series.Data^[ArrayIndex1] > Series.Data^[oldMinMax.IndexValue1] then ArrayIndex1 := oldMinMax.IndexValue1;
                                       end else begin
                                         if Series.Data^[ArrayIndex1] < Series.Data^[MinMax.IndexValue2]    then ArrayIndex1 :=    MinMax.IndexValue2;
                                         if Series.Data^[ArrayIndex1] < Series.Data^[oldMinMax.IndexValue2] then ArrayIndex1 := oldMinMax.IndexValue2;
                                       end;
                                      CoefMinMax := -CoefMinMax;
                                      OldMinMax  := MinMax;
                                 end;
                           //------------
                  end;}

                  if (OldArrayIndex <> ArrayIndex1) and (ArrayIndex1 >= 0) and (ArrayIndex1 < Series.Count) and  (Series.Data^[ArrayIndex1] <> Series.NullValue) then begin
                        yValue := round(OffsetYValue - Series.Data^[ArrayIndex1]*Series.CoefY);

                        if yValue > PoleRect.Bottom then yValue := PoleRect.Bottom;
                        if yValue < PoleRect.Top    then yValue := PoleRect.Top;

                        Series.GraphPoints[Series.CountPointInGraphic].x := PoleRect.Left + i + RamkaPenWidth;
                        Series.GraphPoints[Series.CountPointInGraphic].y := yValue;

                        Series.CountPointInGraphic                       := Series.CountPointInGraphic + 1;
                  end;
                  OldArrayIndex := ArrayIndex1;
             end;

             Polyline(slice(Series.GraphPoints, Series.CountPointInGraphic));

      end; // --- End Of for k := 0 ---
  end; // --- End Of Canvas
end;

{ TSeries }

{===============================================================================
}
constructor TSeries.create;
begin
  inherited Create;

  Name      := 'No Name';
  Count     := -1;
  MinValue  :=  1000000000;
  MaxValue  := -1000000000;

  KoreljationOffset := 0;
  Selected          := False;

  PenColor  := clBlack;
  PenStyle  := psSolid;
  PenWidth  := 1;

end;

{===============================================================================
}
destructor TSeries.destroy;
begin
  if Count <> -1 then
     FreeMem(Data, SizeOf(TFloat)*Count);

  inherited Destroy;
end;

{===============================================================================
}
procedure TSeries.Set_Value(index: Integer; const Value: TFloat);
begin
  Data^[index] := value;

  if Value <> NullValue then begin
      if MinValue > Value then MinValue := Value;
      if MaxValue < Value then MaxValue := Value;
  end;
end;

end.
