unit mpiReportClass;

interface

uses Windows, Graphics, Classes, mpiDeclaration, mpiLasFile, mpiLibrary;

const
  ArrayGolovasticColor : array [0..4] of TColor = (0, 4144959, 8289918, 12434877, 16777215);
  mmOffsetY            = 25;

type
  TrcWhereIAm = (wiNone, wiDepth, wiLithography, wiDropCurves, wiMidleRadius, wiGis, wiGolovastic, wiFreqPole);

  PLithographyLayer = ^TLithographyLayer;

  TLithographyLayer = packed record
     BeginDepth      : TFloat;
     EndDepth        : TFloat;

     NameLayer       : String[255];
     LayerPenColor : LongInt;
     LayerBrushStyle : Byte;
  end;
  /////////////////////////////////////////
  TFreqLayer = packed record
     BeginDepth      : TFloat;
     EndDepth        : TFloat;

     AzimWindow      : Integer;
     BeginAlfa       : Integer;
     EndAlfa         : Integer;
  end;
  /////////////////////////////////////////

  TStatPole = class
  private
     fCanvas : TCanvas;


     pfscPosition : PInteger;

     pfMashtabCoef       : pFloat;

     CountPixelsInOneSant                         : TFloat;
  public
     PoleName           : TrcWhereIAm;

     pfBeginScreenDepth : pFloat;
     pfEndScreenDepth   : pFloat;

     BeginPosX, EndPosX, BeginPosY, Width, Height : Integer;

     procedure Draw(); virtual;
     constructor Create(aCanvas : TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat); virtual;
  end;

  // 111111111111111111111111111111111111111
  TDepthPole = class(TStatPole)
  public
     StepDepthLabel      : TFloat;                                               // ------   Шаг в метрах отметок глубины  ---------
     procedure Draw(); override;
     constructor Create(aCanvas : TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat); override;
  end;

  // 222222222222222222222222222222222222222
  TLithography = class(TStatPole)
  public
     CurEditIndexInListBox : Integer;

     LayerArray : array of TLithographyLayer;

     procedure SortLayerArray();
     procedure Draw(); override;
     constructor Create(aCanvas : TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat); override;
  end;

  // 333333333333333333333333333333333333333
  TDropCurves = class(TStatPole)
  public
     SeriesList : TList;
     procedure Draw(); override;
     constructor Create(aCanvas : TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat); override;
     destructor destroy(); override;
  end;

  // 444444444444444444444444444444444444444
  TMidleRadius = class(TStatPole)
  private
  public
     NominalDiametrEnabled : Boolean;
     NominalDiametr : TFloat;
     procedure Draw(); override;
     constructor Create(aCanvas : TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat); override;
  end;

  // 555555555555555555555555555555555555555
  TGIS = class(TStatPole)
  public
     GISLasFile : TLasFile;
     SeriesList : TList;

     procedure Draw(); override;
     constructor Create(aCanvas : TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat); override;
     destructor Destroy();Override;
  end;

  // 666666666666666666666666666666666666666
  TMinMaxGolovastic = packed record
    min, max : Integer;
  end;
  TGolovastic = class(TStatPole)
  private
     OnePartWidth : TFloat;
  public
     HolovasticRadius        : Integer;
     pfiGolovasticArrayIndex : PInteger;
     MinMaxArray             : array [0..4] of TMinMaxGolovastic;

     procedure Draw(); override;
     function GetPolePosFromAngle(Angle : TFloat): Integer;
     constructor Create(aCanvas : TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat); override;
  end;

  // 777777777777777777777777777777777777777
  TFreqPole = class(TStatPole)
  public
     CurEditIndexInFreqListBox : Integer;

     FreqLayerArray : array of TFreqLayer;

     procedure Draw(); override;
     constructor Create(aCanvas : TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat); override;
  end;

  //  --------------- MainClass ------------------------
  TReportClass = class
  private
     RedrawBitmap : TBitmap;
    // ---------------------------
     fCanvas : TCanvas;
    // ---------------------------
     fWidth  : Integer;
     fHeight : Integer;
     fBeginPosY : Integer;
    // ---------------------------
     fBeginScreenDepth : TFloat;
     fEndScreenDepth   : TFloat;
    // ---------------------------
     fsbPosition: Integer;
    // ---------------------------
     fCurrentPole            : TrcWhereIAm;
     fiDepthArrayIndex       : Integer;
     fiGolovasticArrayIndex  : Integer;
    // ---------------------------
     ClearBitmap   : TBitmap;


    DepthPole    : TDepthPole;
    Lithography  : TLithography;
    DropCurves   : TDropCurves;
    MidleRadius  : TMidleRadius;
    GIS          : TGIS;
    Golovastic   : TGolovastic;
    FreqAnalysis : TFreqPole;

    procedure Set_sbPosition(const Value: Integer);
    procedure Set_MousePos  (const aMousePos: TPoint);
  public
    ImageCanvas  : TCanvas;
    _ImageBitmap  : TBitmap;
    PoleList     : TList;
    MashtabCoef  : TFloat;                                             // -------- Маштабный коэффициент оси глубин --- нуно вынести в общии декларации ---------


    procedure   Draw(); virtual;
    procedure   ReDraw();
    constructor Create(aImageCanvas : TCanvas; {aImageBitmap : TBitmap; }aWidth, aHeight : Integer);
    destructor  Destroy();override;

    property    sbPosition : Integer read fsbPosition write Set_sbPosition;
    property    HeightWorkWindow : Integer read fHeight;
    property    MousePos : TPoint write Set_MousePos;

    property    CurrentPole           : TrcWhereIAm read fCurrentPole;
    property    iDeptharrayIndex      : Integer read fiDepthArrayIndex;
    property    iGolovasticArrayIndex : Integer read fiGolovasticArrayIndex;
  end;

  TReportClassParam = packed record
     // -------- 11 -----------
     DepthCoef : Extended;
     DepthStep : Extended;
     // -------- 22 -----------
     CountLitLayer : Integer;
     LitLayerArray : array of TLithographyLayer;
     // -------- 33 -----------
     CountDopCurves : Integer;
     DopCurverArray : TIntArray;
     // -------- 44 -----------
     NominalDiametrEnabled : Boolean;
     NominalDiametr        : Extended;
     // -------- 55 -----------
     NameLasFile           : String[255];
     NumberSeries          : Integer;
     SeriesColor           : Integer;
     SeriesStyle           : Integer;
     SeriesWidth           : Integer;
     // -------- 66 -----------
     DiametrGolovastic     : Integer;
     a1, a2, b1, b2, c1, c2 : Integer;
     d1, d2, e1, e2         : Integer;
     // -------- 77 -----------
     CountFreqLayer : Integer;
     FreqLayerArray : array of TFreqLayer;
  end;

var
    ReportClass : TReportClass;
    ReportClassParam : TReportClassParam;


implementation

uses sysUtils, Math, Unit_StatAnalysis, mpiSaveLoadDataFile;

{ TStatPole }

{===============================================================================
}
constructor TStatPole.Create(aCanvas: TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat);
begin
  fCanvas       := aCanvas;
  Height        := aHeight;
  pfscPosition  := apfscPosition;
  pfBeginScreenDepth := apfBeginScreenDepth;
  pfEndScreenDepth := apfEndScreenDepth;
  pfEndScreenDepth := apfEndScreenDepth;
  pfMashtabCoef    := apfMashtabCoef;

  CountPixelsInOneSant        := fCanvas.Font.PixelsPerInch/SmPerInch;
end;

{===============================================================================
}
procedure TStatPole.Draw();
begin
  if Height = -1 then begin
     Height := Height;
  end;
  // ------------
  With fCanvas do begin
     Pen.Width := 2;
     if BeginPosX <> 0 then begin MoveTo(BeginPosX, BeginPosY-4); LineTo(BeginPosX, BeginPosY+Height+5); end;
     if EndPosX   <> 0 then begin MoveTo(EndPosX  , BeginPosY-4); LineTo(EndPosX, BeginPosY+Height+5);   end;
     Pen.Width := 1;
  end;
end;

{ TReportClass }

{===============================================================================
}
constructor TReportClass.Create(aImageCanvas : TCanvas; {aImageBitmap : TBitmap; }aWidth, aHeight : Integer);
var
  WidthNulPole : Integer;
begin
  // ------------------------------------
   RedrawBitmap        := TBitmap.Create;
   ClearBitmap         := TBitmap.Create;

   ReDrawBitmap.PixelFormat := pf4bit;
   ClearBitmap .PixelFormat := pf4bit;

   RedrawBitmap.Width  := aWidth;
   RedrawBitmap.Height := aHeight;
   ClearBitmap.Width   := aWidth;
   ClearBitmap.Height  := aHeight;

   RedrawBitmap.Canvas.FillRect(Rect(0, 0, RedrawBitmap.Width, RedrawBitmap.Height));
   ClearBitmap .Canvas.FillRect(Rect(0, 0, ClearBitmap.Width, ClearBitmap.Height));

  // ------------------------------------
   //ImageBitmap := aImageBitmap;

   ImageCanvas := aImageCanvas;
   fCanvas     := RedrawBitmap.Canvas;

   fWidth      := aWidth;
   fBeginPosY  := Round(mmOffsetY/210 * aWidth);
   fHeight     := aHeight - fBeginPosY;
  // ------------------------------------
  MashtabCoef       := 0.8;
  sbPosition        := 0;
  // ------------------------------------
  PoleList := Tlist.Create;
  // ----------- Все криаты -------------
    DepthPole    := TDepthPole  .Create(fCanvas, fHeight, @fsbPosition, @fBeginScreenDepth, @fEndScreenDepth, @MashtabCoef); PoleList.Add(DepthPole   );
    Lithography  := TLithography.Create(fCanvas, fHeight, @fsbPosition, @fBeginScreenDepth, @fEndScreenDepth, @MashtabCoef); PoleList.Add(Lithography );
    DropCurves   := TDropCurves .Create(fCanvas, fHeight, @fsbPosition, @fBeginScreenDepth, @fEndScreenDepth, @MashtabCoef); PoleList.Add(DropCurves  );
    MidleRadius  := TMidleRadius.Create(fCanvas, fHeight, @fsbPosition, @fBeginScreenDepth, @fEndScreenDepth, @MashtabCoef); PoleList.Add(MidleRadius );
    GIS          := TGIS        .Create(fCanvas, fHeight, @fsbPosition, @fBeginScreenDepth, @fEndScreenDepth, @MashtabCoef); PoleList.Add(GIS     );
    Golovastic   := TGolovastic .Create(fCanvas, fHeight, @fsbPosition, @fBeginScreenDepth, @fEndScreenDepth, @MashtabCoef); PoleList.Add(Golovastic  );
    FreqAnalysis := TFreqPole   .Create(fCanvas, fHeight, @fsbPosition, @fBeginScreenDepth, @fEndScreenDepth, @MashtabCoef); PoleList.Add(FreqAnalysis);
  // ----------- Заполнение полей необходимыми данными -------------
    WidthNulPole := Round(3/210 * aWidth);

    DepthPole.StepDepthLabel := 1;
    DepthPole.Width          := Round(25/210 * aWidth);
    DepthPole.BeginPosX      := 0;
    DepthPole.EndPosX        := DepthPole.BeginPosX + DepthPole.Width;
    DepthPole.BeginPosY      := fBeginPosY;
    DepthPole.PoleName       := wiDepth;

    Lithography.Width     := Round(10/210 * aWidth);
    Lithography.BeginPosX := DepthPole.EndPosX;
    Lithography.EndPosX   := Lithography.BeginPosX + Lithography.Width;
    Lithography.BeginPosY := fBeginPosY;
    Lithography.PoleName  := wiLithography;

    DropCurves.Width     := Round(53/210 * aWidth);
    DropCurves.BeginPosX := Lithography.EndPosX + WidthNulPole;
    DropCurves.EndPosX   := DropCurves.BeginPosX + DropCurves.Width;
    DropCurves.BeginPosY := fBeginPosY;
    DropCurves.PoleName  := wiDropCurves;

    MidleRadius.Width     := Round(33/210 * aWidth);
    MidleRadius.BeginPosX := DropCurves.EndPosX + WidthNulPole;
    MidleRadius.EndPosX   := MidleRadius.BeginPosX + MidleRadius.Width;
    MidleRadius.BeginPosY := fBeginPosY;
    MidleRadius.PoleName  := wiMidleRadius;

    GIS.Width     := Round(10/210 * aWidth);
    GIS.BeginPosX := MidleRadius.EndPosX + WidthNulPole;
    GIS.EndPosX   := GIS.BeginPosX + GIS.Width;
    GIS.BeginPosY := fBeginPosY;
    GIS.PoleName  := wiGis;


    fiGolovasticArrayIndex             := -1;
    Golovastic.Width                   := Round(31/210 * aWidth);
    Golovastic.BeginPosX               := GIS.EndPosX + WidthNulPole;
    Golovastic.EndPosX                 := Golovastic.BeginPosX + Golovastic.Width;
    Golovastic.BeginPosY               := fBeginPosY;
    Golovastic.HolovasticRadius        := 4;
    Golovastic.PoleName                := wiGolovastic;
    Golovastic.pfiGolovasticArrayIndex := @fiGolovasticArrayIndex;


//    FreqAnalysis.Width     := Round(45/210 * aWidth);
    FreqAnalysis.BeginPosX := Golovastic.EndPosX + WidthNulPole;
//    FreqAnalysis.EndPosX   := 0;
    FreqAnalysis.EndPosX   := aWidth - 10;
    FreqAnalysis.BeginPosY := fBeginPosY;
    FreqAnalysis.Width     := FreqAnalysis.EndPosX - FreqAnalysis.BeginPosX;//Round(45/210 * aWidth);
    FreqAnalysis.PoleName  := wiFreqPole;
end;

{===============================================================================
}
destructor TReportClass.Destroy;
begin
    DepthPole   .Free;
    Lithography .Free;
    DropCurves  .Free;
    MidleRadius .Free;
    GIS         .Free;
    Golovastic  .Free;
    FreqAnalysis.Free;

    PoleList    .Free;
    ClearBitmap .Free;
    RedrawBitmap.Free;

    inherited Destroy;
end;

{===============================================================================
}
procedure TReportClass.Draw();
var
  i : integer;
begin
   fCanvas.Draw(0,0,ClearBitmap);

   with fCanvas do begin
      MoveTo(DepthPole.EndPosX, fBeginPosY); LineTo(fWidth, fBeginPosY);
   end;

   for i := 0 to PoleList.Count - 1 do begin
     fCanvas.Font.Size := 8;
     fCanvas.Font.Name := 'MS Sans Serif';
     fCanvas.Font.Style := [];
     TStatPole(PoleList.Items[i]).Draw();
   end;
  // ----------
  Redraw();
end;

{===============================================================================
}
procedure TReportClass.ReDraw();
begin
   ImageCanvas.Draw(0,0,RedrawBitmap);
end;

procedure TReportClass.Set_MousePos(const aMousePos: TPoint);
var
  i                 : integer;
  fHolovasticRadius : Integer;
  CurDepth1         : TFloat;
  CurDepth2         : TFloat;

  Posx, PosY        : Integer;
  OffsetDepthIndex  : Integer;
begin

  fCurrentPole           := wiNone;
  fiDepthArrayIndex      := -1;
  fiGolovasticArrayIndex := -1;
  // ----- Определяю текущее глубину -----------
   fiDepthArrayIndex := Round(MashtabCoef*(aMousePos.y + fsbPosition - TStatPole(PoleList.Items[0]).BeginPosY {- 1}));
   if (fiDepthArrayIndex < 0) or (fiDepthArrayIndex >= LasFile.XValue.Count - 1) then fiDepthArrayIndex := -1;
   if aMousePos.y < TStatPole(PoleList.Items[0]).BeginPosY then fiDepthArrayIndex := -1;

  // ----- Определяю текущее поле работы -----------
   for i := 0 to PoleList.Count - 1 do begin
      if (aMousePos.x > TStatPole(PoleList.Items[i] ).BeginPosX) and
         (aMousePos.x < TStatPole(PoleList.Items[i] ).EndPosX)   and
         (aMousePos.y > TStatPole(PoleList.Items[i] ).BeginPosY) and
         (aMousePos.y < TStatPole(PoleList.Items[i] ).BeginPosY + TStatPole(PoleList.Items[i]).Height) then begin

         fCurrentPole      := TStatPole(PoleList.Items[i]).PoleName;

         Break;
      end;
   end;

  // ----- Работа с полем головастиков -----------
  //(wiNone, wiDepth, wiLithography, wiDropCurves, wiMidleRadius, wiGis, wiGolovastic, wiFreqPole);
  //if (fCurrentPole = wiGolovastic) or (fCurrentPole = wiDropCurves) or (fCurrentPole = wiMidleRadius) then begin
   if (fiDepthArrayIndex <> -1) and (aMousePos.y > TStatPole(PoleList.Items[0]).BeginPosY) then begin
        Redraw();
        With ImageCanvas do begin
           Pen.Color := clRed;
           Pen.Style := psdot;
           Pen.Width := 1;

           for i := 0 to PoleList.Count - 1 do begin
               if (i <> 0) and (i <> 1) and (i <> 4) and (i <> 6) then begin

                  MoveTo(TStatPole(PoleList.Items[i] ).BeginPosX + 1, aMousePos.y);
                  LineTo(TStatPole(PoleList.Items[i] ).EndPosX   - 1, aMousePos.y);

               end;
           end;

           MoveTo(TStatPole(PoleList.Items[0] ).EndPosX - 5, aMousePos.y);
           LineTo(TStatPole(PoleList.Items[0] ).EndPosX + 5, aMousePos.y);

           Pen.Color := clBlack;
           Pen.Style := psSolid;
        end;
   end;
   // -------------
//   if aMousePos.y < TStatPole(PoleList.Items[0]).BeginPosY then Redraw();
   // ------------------ Определение текущего головастика ------------
   fHolovasticRadius := Round(fCanvas.Font.PixelsPerInch/SmPerInch*TGolovastic (ReportClass.PoleList.Items[5]).HolovasticRadius/10/2);


   OffsetDepthIndex := Round(MashtabCoef*fHolovasticRadius*0.5);
   CurDepth1        := 0;
   CurDepth2        := 0;
   if fiDepthArrayIndex <> -1 then begin
      if  fiDepthArrayIndex - OffsetDepthIndex >= 0 then CurDepth1 := LasFile.XValue.Data^[fiDepthArrayIndex - OffsetDepthIndex]
                                                    else CurDepth1 := LasFile.XValue.Data^[0];
      if fiDepthArrayIndex + OffsetDepthIndex <= LasFile.XValue.Count then CurDepth2 := LasFile.XValue.Data^[fiDepthArrayIndex + OffsetDepthIndex]
                                                                      else CurDepth2 := LasFile.XValue.Data^[LasFile.XValue.Count -1];
   end;
////////////////////////////////////////////////////////////////////
   if fiDepthArrayIndex <> -1 then begin
         for i := 0 to Length(MarkArray) - 1 do begin
            fiGolovasticArrayIndex := -1;
            if (MarkArray[i].fCurrentDepth >= CurDepth1) and ((MarkArray[i].fCurrentDepth <= CurDepth2)) then begin
               PosX := TGolovastic (ReportClass.PoleList.Items[5]).GetPolePosFromAngle(MarkArray[i].Alfa_1);
               PosY := Round(LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth){fiDepthArrayIndex} / MashtabCoef - sbPosition) + TGolovastic (ReportClass.PoleList.Items[5]).BeginPosY + 1;
               With ImageCanvas do begin
                   Pen.Color := clRed;
                   Pen.Width := 2;
                   ellipse(PosX - fHolovasticRadius - 1, PosY - fHolovasticRadius - 1, PosX + fHolovasticRadius + 1, PosY + fHolovasticRadius + 1);
                   Pen.Color := clBlack;
                   Pen.Width := 1;
               end;
               fiGolovasticArrayIndex := i;
               Break;
            end;
         end;
   end;
end;

procedure TReportClass.Set_sbPosition(const Value: Integer);
begin
  fsbPosition       := Value;
  if Planshet.xValues = nil then exit;

  fBeginScreenDepth := Planshet.xValues.Data^[Round(Value            *MashtabCoef)];
  fEndScreenDepth   := fBeginScreenDepth + LasFile.WellInf.Step*fHeight*MashtabCoef;
//  fEndScreenDepth   := Planshet.xValues.Data^[Round((Value + fHeight)*MashtabCoef)];
end;

{ TDepthPole }

{===============================================================================
}
constructor TDepthPole.Create(aCanvas: TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat);
begin
  inherited Create(aCanvas, aHeight, apfscPosition, apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef);
end;

{===============================================================================
}
procedure TDepthPole.Draw();
var
  StepInPixelVerticalLines : TFloat;

  OutStr         : String;
  OffsetDepthInPixels    : TFloat;
  OffsetDepth            : TFloat;
  OffsetDepthCounter      : Integer;
  BeginPos       : Integer;
  CurPos         : Integer;
  Counter        : Integer;

  fTextHeight     : Integer;
begin
  inherited Draw();

  fTextHeight := fCanvas.TextHeight('0');

  StepInPixelVerticalLines := StepDepthLabel/LasFile.WellInf.Step/pfMashtabCoef^; // ------   Шаг в пикселях отметок глубины -----------

  OffsetDepth         := abs(LasFile.WellInf.Start - pfBeginScreenDepth^);
  OffsetDepthInPixels := OffsetDepth/LasFile.WellInf.Step/pfMashtabCoef^;

  OffsetDepthCounter := Round(OffsetDepth/StepDepthLabel);
  if OffsetDepth/StepDepthLabel - OffsetDepthCounter > 0 then OffsetDepthCounter := OffsetDepthCounter + 1;


  BeginPos := Round(BeginPosY - (OffsetDepthInPixels - Round(Round(OffsetDepthInPixels / StepInPixelVerticalLines) * StepInPixelVerticalLines)));
  Counter  := 0; if BeginPos < BeginPosY then Counter := 1;
  CurPos   := Round(BeginPos + StepInPixelVerticalLines*Counter);
  with fCanvas do begin
     While CurPos <= BeginPosY + Height do begin

        // ---------- Отрисовка Лаблов -------------
          OutStr := FloatToStrF(LasFile.WellInf.Start+StepDepthLabel*OffsetDepthCounter, ffFixed, 15, 4);
          TextOut(EndPosX - 8 - TextWidth(OutStr), curPos - fTextHeight div 2 , OutStr);
        // ---------- Отрисовка Тиков --------------
          MoveTo(EndPosX - 5, curPos);
          LineTo(EndPosX    , curPos);

        Counter            := Counter + 1;
        OffsetDepthCounter := OffsetDepthCounter + 1;
        CurPos             := Round(BeginPos + StepInPixelVerticalLines*Counter);
     end;
     // ---------------- Вывод заголовка диаграммы ------
      Font.Size  := 9;
      Font.Name  := 'MS Sans Serif';
      Font.Style := [fsBold];
      TextOut(EndPosX - TextWidth('Глубина,м') - 8, Round(BeginPosY - 1.0*CountPixelsInOneSant), 'Глубина,м');
  end;
end;

{ TLithography }

{===============================================================================
}
constructor TLithography.Create(aCanvas: TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat);
begin
  inherited Create(aCanvas, aHeight, apfscPosition, apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef);

end;

{===============================================================================
}
procedure TLithography.Draw();
var
 ArrayIndex1, ArrayIndex2,  i : Integer;
 PosY1, PosY2 : Integer;
begin
  inherited Draw();

  with fCanvas do begin

      for i := 0 to Length(LayerArray) - 1 do begin
          if ((LayerArray[i].BeginDepth < pfBeginScreenDepth^) and (LayerArray[i].EndDepth   > pfEndScreenDepth^)) or
             ((LayerArray[i].BeginDepth > pfBeginScreenDepth^) and (LayerArray[i].BeginDepth < pfEndScreenDepth^)) or
             ((LayerArray[i].EndDepth   > pfBeginScreenDepth^) and (LayerArray[i].EndDepth   < pfEndScreenDepth^)) then begin
                  ArrayIndex1 := LasFile.GetDepthIndex(LayerArray[i].BeginDepth);
                  ArrayIndex2 := LasFile.GetDepthIndex(LayerArray[i].EndDepth  );

                  PosY1 := Round(ArrayIndex1 / pfMashtabCoef^ - pfscPosition^) + BeginPosY;
                  PosY2 := Round(ArrayIndex2 / pfMashtabCoef^ - pfscPosition^) + BeginPosY;

                  if PosY2 > BeginPosY then begin
                     if PosY1 < BeginPosY then PosY1 := BeginPosY;
                     Brush.Color := LayerArray[i].LayerPenColor;
                     Brush.Style := TBrushStyle(LayerArray[i].LayerBrushStyle);

                     Rectangle(BeginPosX, PosY1, EndPosX, PosY2);

                     Brush.Color := clWhite;
                     Brush.Style := bsSolid;
                  end;
          end;
      end;
  end;
end;

{===============================================================================
}
procedure TLithography.SortLayerArray();
var
  i : integer;
begin
  for i := 0 to Length(LayerArray) - 1 do begin

  end;
end;

{ TDropCurves }

{===============================================================================
}
constructor TDropCurves.Create(aCanvas: TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat);
begin
  inherited Create(aCanvas, aHeight, apfscPosition, apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef);
  SeriesList := TList.Create;
end;

{===============================================================================
}
destructor TDropCurves.destroy;
begin
  SeriesList.Free;
  inherited destroy;
end;

{===============================================================================
}
procedure TDropCurves.Draw();
var
  SubPoleWidth               : Integer;
  SubPoleBeginX, SubPoleEndX : Integer;
  OffsetPosSubPole           : Integer;
//  ZeroLine                   : Integer;

  ControllFlagWidthPole : Integer;
  i, k                  : Integer;

  SeriesScaleCoef       : TFloat;
  Series                : TSeries;

  OldArrayIndex, ArrayIndex : Integer;
  CountElementPointArray    : Integer;
  PointArray                : Array [0..1600] of TPoint;
  XValue                    : TFloat;
begin
  inherited Draw();

  ControllFlagWidthPole := 0;
  OffsetPosSubPole      := 0;
  if SeriesList.Count = 0 then SubPoleWidth := 0
                          else SubPoleWidth := (Width - 1) div SeriesList.Count;

  if SubPoleWidth*SeriesList.Count <> (Width - 1) then
           ControllFlagWidthPole := (Width - 1) - SubPoleWidth*SeriesList.Count;

  with fCanvas do begin
     for i := 0 to SeriesList.Count - 1 do begin
        if i = SeriesList.Count - 1 then SubPoleWidth := SubPoleWidth + ControllFlagWidthPole;
        Series := TSeries(SeriesList.Items[i]);
        SeriesScaleCoef := (SubPoleWidth - 2)/abs(Series.CorrectMaxValue - Series.CorrectMinValue);

        SubPoleBeginX := BeginPosX + OffsetPosSubPole + 1;
        SubPoleEndX   := SubPoleBeginX + SubPoleWidth - 1;

        // ---- Отрисовка промежутков полей --------
           if (i > 0) and (i < SeriesList.Count) then begin
               Pen.Color := clGray;
               MoveTo(BeginPosX + OffsetPosSubPole, BeginPosY);
               LineTo(BeginPosX + OffsetPosSubPole, BeginPosY + Height);
           end;
        // ---- Пошла отрисовка серий --------------
        OldArrayIndex          := Round((pfscPosition^ + 0) * pfMashtabCoef^);
        PointArray[0].x := SubPoleBeginX + Round((Series.data^[OldArrayIndex] - Series.CorrectMinValue)*SeriesScaleCoef);
        PointArray[0].y := BeginPosY;

        CountElementPointArray := 0;
        if Series.data^[OldArrayIndex] = LasFile.WellInf.Null then CountElementPointArray := -1;

        Pen.Style := Series.PenStyle;
        Pen.Width := Series.PenWidth;
        Pen.Color := Series.PenColor;
        for k := 1 to Height do begin
            ArrayIndex := Round((pfscPosition^ + k) * pfMashtabCoef^);
            if ArrayIndex >= Series.Count - 1 then break;
            if (OldArrayIndex <> ArrayIndex) and (Series.data^[ArrayIndex] <> LasFile.WellInf.Null) then begin
                CountElementPointArray := CountElementPointArray + 1;

                XValue := SubPoleBeginX + (Series.data^[ArrayIndex] - Series.CorrectMinValue)*SeriesScaleCoef;

                if XValue < SubPoleBeginX then XValue := SubPoleBeginX;
                if XValue > SubPoleEndX   then XValue := SubPoleEndX;

                PointArray[CountElementPointArray].x := Round(XValue);
                PointArray[CountElementPointArray].y := BeginPosY     + k;

                OldArrayIndex := ArrayIndex;
            end;
        end;
        Polyline(Slice(PointArray, CountElementPointArray));

        Pen.Color := clBlack;
        Pen.Style := psSolid;
        Pen.Width := 1;

        fCanvas.Font.Size  := 10;
        fCanvas.Font.Name  := 'Courier New';
        fCanvas.Font.Style := [fsBold];

        TextOut(SubPoleBeginX + (SubPoleEndX - SubPoleBeginX - TextWidth(Series.Name)) div 2, Round(BeginPosY - 0.2*CountPixelsInOneSant - TextHeight(Series.Name)), Series.Name);

        OffsetPosSubPole := OffsetPosSubPole + SubPoleWidth;
     end;

        fCanvas.Font.Size  := 12;
     // ------- Стрелочка --------
        Pen.Color := clBlack;
        MoveTo(Round(BeginPosX + 0.2*CountPixelsInOneSant), Round(BeginPosY - 0.8*CountPixelsInOneSant));
        LineTo(Round(EndPosX   - 0.2*CountPixelsInOneSant), Round(BeginPosY - 0.8*CountPixelsInOneSant));
        MoveTo(Round(EndPosX   - 0.7*CountPixelsInOneSant), Round(BeginPosY - 0.9*CountPixelsInOneSant));
        LineTo(Round(EndPosX   - 0.2*CountPixelsInOneSant), Round(BeginPosY - 0.8*CountPixelsInOneSant));
        LineTo(Round(EndPosX   - 0.7*CountPixelsInOneSant), Round(BeginPosY - 0.7*CountPixelsInOneSant));

        TextOut(Round(BeginPosX + 0.2*CountPixelsInOneSant)                   , Round(BeginPosY - 1.5*CountPixelsInOneSant), 'min');
        TextOut(Round(EndPosX   - 0.2*CountPixelsInOneSant - TextWidth('max')), Round(BeginPosY - 1.5*CountPixelsInOneSant), 'max');
        Font.Style := [];
     //---------sdfdsfdsf';lk';lk
  end;
end;

{ TMidleRadius }

{===============================================================================
}
constructor TMidleRadius.Create(aCanvas: TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat);
begin
  inherited Create(aCanvas, aHeight, apfscPosition, apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef);

end;

{===============================================================================
}
procedure TMidleRadius.Draw();
var
  Series : TSeries;

  i      : Integer;

  CenterXPole : Integer;
  MaxWidthRadius        : Integer;
  MashtabCoefRadius           : TFloat;

  ArrayIndex            : Integer;
  OldArrayIndex         : Integer;

  OffsetArray              : array [0..1800] of TPoint;
  PointArray1, PointArray2 : array of TPoint;
  CountElementPointArray   : Integer;

  MinRadius, MaxRadius     : TFloat;
  Text_Height              : Integer;
  OutPutStr                : String;
  OffstNominalDiametr      : Integer;
  PosY                     : TFloat;
begin
  inherited Draw();

  Series := LasFile.GetSeries('RADS');
  if Series = nil then exit;

  CenterXPole            := BeginPosX + Width div 2; // -- Центр поля -------
  MaxWidthRadius         := (Width - Round(Width*0.2)) div 2 ;
  MashtabCoefRadius      := MaxWidthRadius / Series.MaxValue;
  CountElementPointArray := 0;
  MinRadius              :=  100000000000;
  MaxRadius              := -100000000000;
  // ---------------------- Заполняю масив данными -----------------
     OldArrayIndex := Round((pfscPosition^ + 0) * pfMashtabCoef^);

     OffsetArray[CountElementPointArray].x := Width div 2;
     OffsetArray[CountElementPointArray].y :=  BeginPosY;
//     CountElementPointArray := CountElementPointArray + 1;

      for i := 0 to Height do begin
         ArrayIndex := Round((pfscPosition^ + i) * pfMashtabCoef^);
         if ArrayIndex >= Series.Count - 1 then break;
         if (OldArrayIndex <> ArrayIndex) and (Series.data^[ArrayIndex] <> LasFile.WellInf.Null) then begin
             CountElementPointArray := CountElementPointArray + 1;
             OffsetArray[CountElementPointArray].x := Round(Series.data^[ArrayIndex]*MashtabCoefRadius);
             OffsetArray[CountElementPointArray].y := BeginPosY + i;
             OldArrayIndex := ArrayIndex;

             if MinRadius > Series.data^[ArrayIndex] then MinRadius := Series.data^[ArrayIndex];
             if MaxRadius < Series.data^[ArrayIndex] then MaxRadius := Series.data^[ArrayIndex];
         end;
      end;
//      OffsetArray[1].x := Round(Series.data^[OldArrayIndex]*MashtabCoefRadius);
      OffsetArray[1].y := OffsetArray[1].y-1;
      OffsetArray[0].y := OffsetArray[1].y;

      CountElementPointArray := CountElementPointArray + 1;
      OffsetArray[CountElementPointArray].x := OffsetArray[CountElementPointArray-1].x;
      OffsetArray[CountElementPointArray].y := BeginPosY + Height + 5;

      CountElementPointArray := CountElementPointArray + 1;
      OffsetArray[CountElementPointArray].x := OffsetArray[0].x;
      OffsetArray[CountElementPointArray].y := OffsetArray[CountElementPointArray-1].y;

      SetLength(PointArray1, CountElementPointArray + 1);
      SetLength(PointArray2, CountElementPointArray + 1);
      for i := 0 to CountElementPointArray do begin
         PointArray1[i].x := CenterXPole - OffsetArray[i].x;
         PointArray1[i].y := OffsetArray[i].y;

         PointArray2[i].x := CenterXPole + OffsetArray[i].x;
         PointArray2[i].y := OffsetArray[i].y;
      end;
  // ------------ Отрисовка тем , чем заполнили масивы --------------
     with fCanvas do begin
       // ---- Отрисовка осевой линиий ------------
         Pen.Style := psDashDotDot;
         MoveTo(CenterXPole ,BeginPosY + 1); LineTo(CenterXPole, BeginPosY + Height - 1);
         Pen.Style := psSolid;
       // ---- Отрисовка Номинального радиуса ----------------
         if NominalDiametrEnabled then begin
           Pen.Color := clRed;
           OffstNominalDiametr := Round(NominalDiametr/2*MashtabCoefRadius);
           MoveTo(CenterXPole + OffstNominalDiametr ,BeginPosY + 1); LineTo(CenterXPole + OffstNominalDiametr, BeginPosY + Height - 1);
           MoveTo(CenterXPole - OffstNominalDiametr ,BeginPosY + 1); LineTo(CenterXPole - OffstNominalDiametr, BeginPosY + Height - 1);
           // -------------- Вывод планок , соответсвующие падениям головастиков ----
           Pen.Color := clBlack;
           for i := 0 to Length(MarkArray) - 1 do begin
              if (MarkArray[i].fCurrentDepth >= pfBeginScreenDepth^) and (MarkArray[i].fCurrentDepth <= pfEndScreenDepth^) then begin
                 ArrayIndex := LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth);
                 PosY  := ArrayIndex / pfMashtabCoef^ - pfscPosition^ + BeginPosY + 1;
                 MoveTo(CenterXPole                      , Round(PosY));
                 LineTo(CenterXPole + OffstNominalDiametr, Round(PosY + OffstNominalDiametr*tan(MarkArray[i].Alfa_1)));
              end;
           end;
         end;
       // ---- Отрисовка Среднего радиуса ------------
         Pen.Color   := clBlack;
         Pen.Style   := psSolid;
         Brush.Color := clSilver;
         Brush.Style := bsSolid;
           Polygon(PointArray1);
           Polygon(PointArray2);
         Brush.Color := clWhite;
       // ---------------- Вывод максимума и минимума радиуса  ------
         Text_Height := TextHeight('0');
         OutPutStr   := 'min=' + FloatToStrf(MinRadius, ffFixed, 10,2);
         TextOut(Round(BeginPosX + 0.1*CountPixelsInOneSant), Round(BeginPosY - Text_Height - 0.2*CountPixelsInOneSant), OutPutStr);
         OutPutStr   := 'max=' + FloatToStrf(MaxRadius, ffFixed, 10,2);
         TextOut(Round(EndPosX - 0.1*CountPixelsInOneSant - TextWidth(OutPutStr)), Round(BeginPosY - Text_Height - 0.2*CountPixelsInOneSant), OutPutStr);
       // ---------------- Вывод заголовка диаграммы ------
         fCanvas.Font.Size  := 12;
         fCanvas.Font.Name  := 'Courier New';
         fCanvas.Font.Style := [fsBold];
         TextOut(BeginPosX + (Width - TextWidth('Профиль скв.')) div 2, Round(BeginPosY - 1.5*CountPixelsInOneSant), 'Профиль скв.');

     end;
end;

{ TGIS }

{===============================================================================
}
constructor TGIS.Create(aCanvas: TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat);
begin
  inherited Create(aCanvas, aHeight, apfscPosition, apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef);
  GISLasFile := nil;
  SeriesList := TList.Create;
end;

{===============================================================================
}
destructor TGIS.Destroy;
begin
  if GISLasFile <> nil then GISLasFile.Free;
  SeriesList.Free;
  inherited Destroy;
end;

procedure TGIS.Draw();
var
  i, k                      : Integer;
  Series                    : TSeries;
  CountElementPointArray    : Integer;
  SeriesScaleCoef           : TFloat;
  XValue                    : TFloat;
  PointArray                : Array [0..1600] of TPoint;


  CurrentPoleDepth          : TFloat;
  DepthIndex                : Integer;
  OldDepthIndex             : Integer;
begin
  inherited Draw();

  with fCanvas do begin
     for i := 0 to SeriesList.Count - 1 do begin
        Series          := TSeries(SeriesList.Items[i]);
        SeriesScaleCoef := (Width - 2)/abs(Series.CorrectMaxValue - Series.CorrectMinValue);

        // ---- Пошла отрисовка серий --------------

        CurrentPoleDepth := pfBeginScreenDepth^;
        OldDepthIndex    := GISLasFile.GetDepthIndex(CurrentPoleDepth);
        if OldDepthIndex <> -1 then begin
              PointArray[0].x := BeginPosX + Round((Series.data^[OldDepthIndex] - Series.CorrectMinValue)*SeriesScaleCoef);
              PointArray[0].y := BeginPosY;

              CountElementPointArray := 0;
              if (Series.data^[OldDepthIndex] = GISLasFile.WellInf.Null) or  (OldDepthIndex = -1 )then CountElementPointArray := -1;

              Pen.Color := Series.PenColor;
              Pen.Width := Series.PenWidth;
              Pen.Style := Series.PenStyle;
              for k := 1 to Height do begin

                  CurrentPoleDepth := pfBeginScreenDepth^ + (pfEndScreenDepth^ - pfBeginScreenDepth^)/Height*k;
                  DepthIndex       := GISLasFile.GetDepthIndex(CurrentPoleDepth);
                  if DepthIndex <> -1 then begin
                     if (OldDepthIndex <> DepthIndex) and (Series.data^[DepthIndex] <> GisLasFile.WellInf.Null) then begin
                         CountElementPointArray := CountElementPointArray + 1;

                         XValue := BeginPosX + (Series.data^[DepthIndex] - Series.CorrectMinValue)*SeriesScaleCoef;

                         if XValue <= BeginPosX then XValue := BeginPosX + 1;
                         if XValue >= EndPosX   then XValue := EndPosX   - 1;

                         PointArray[CountElementPointArray].x := Round(XValue);
                         PointArray[CountElementPointArray].y := BeginPosY     + k;

                         OldDepthIndex := DepthIndex;
                     end;
                  end;
              end;
              Polyline(Slice(PointArray, CountElementPointArray));
        end;
     end;
       // ---------------- Вывод заголовка диаграммы ------
         fCanvas.Font.Size  := 12;
         fCanvas.Font.Name  := 'Courier New';
         fCanvas.Font.Style := [fsBold];
         TextOut(BeginPosX + (Width - TextWidth('ГИС')) div 2, Round(BeginPosY - 1.5*CountPixelsInOneSant), 'ГИС');

      Pen.Color := clBlack;
      Pen.Width := 1;
      Pen.Style := psSolid;
  end;
end;

{ TGolovastic }

{===============================================================================
}
constructor TGolovastic.Create(aCanvas: TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat);
begin
  inherited Create(aCanvas, aHeight, apfscPosition, apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef);

end;

{===============================================================================
}
procedure TGolovastic.Draw();
const
  pi_180 = pi/180;
var
  PosX               : Integer;
  PosY               : Integer;
  CurAngle           : Integer;
  Text_Height        : Integer;
  fHolovasticRadius  : Integer;

  i, k               : Integer;
  ArrayIndex         : Integer;
  x1, x2, y1, y2     : Integer;
  sumKorel           : TFloat;
begin
  inherited Draw();

  OnePartWidth       := Width / 9;
  with fCanvas do begin
     Brush.Style := bsSolid;
     Brush.Color := clWhite;
     // -------------
     Text_Height       := TextHeight('0');
     fHolovasticRadius := Round(Font.PixelsPerInch/SmPerInch*HolovasticRadius/10/2);
     // ---- Отрисовка Зон головастиков (разбивка поля на подполя по углам) -----------
     Pen.Color := clGray;
     CurAngle := 10;
     While CurAngle < 90 do begin
         PosX := GetPolePosFromAngle(CurAngle*Pi_180);
         MoveTo(PosX ,BeginPosY + 1); LineTo(PosX, BeginPosY + Height - 1);
         CurAngle := CurAngle + 10;
     end;
     Pen.Color := clBlack;
     // -------  zВывод подписей углов ----------------------
     PosX := GetPolePosFromAngle(0 *Pi_180); TextOut(PosX - TextWidth('0' ) div 2, BeginPosY - Text_Height - 3, '0' ); MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     PosX := GetPolePosFromAngle(10*Pi_180); TextOut(PosX - TextWidth('10') div 2, BeginPosY - Text_Height - 3, '10'); MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     PosX := GetPolePosFromAngle(20*Pi_180); TextOut(PosX - TextWidth('20') div 2, BeginPosY - Text_Height - 3, '20'); MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     PosX := GetPolePosFromAngle(50*Pi_180); TextOut(PosX - TextWidth('50') div 2, BeginPosY - Text_Height - 3, '50'); MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     PosX := GetPolePosFromAngle(90*Pi_180); TextOut(PosX - TextWidth('90') div 2, BeginPosY - Text_Height - 3, '90'); //MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     // --------- Вывод Головастиков ----------
     for i := 0 to Length(MarkArray) - 1 do begin
        if (MarkArray[i].fCurrentDepth >= pfBeginScreenDepth^) and (MarkArray[i].fCurrentDepth <= pfEndScreenDepth^) then begin
             ArrayIndex := LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth);

             PosX := GetPolePosFromAngle(MarkArray[i].Alfa_1);
             PosY := Round(ArrayIndex / pfMashtabCoef^ - pfscPosition^) + BeginPosY + 1;

             // --------- Подбираю тип заливки головастика -------
             sumKorel := (abs(MarkArray[i].kArray[0].Kor) + abs(MarkArray[i].kArray[1].Kor))/2;
             for k := 0 to 4 do begin
                 if (SumKorel >= MinMaxArray[k].min/100) and (SumKorel < MinMaxArray[k].max/100) then begin
                    Brush.Color := ArrayGolovasticColor[k];
                    Break;
                 end;
             end;
             // ----Вывожу кружок -------
             ellipse(PosX - fHolovasticRadius, PosY - fHolovasticRadius, PosX + fHolovasticRadius, PosY + fHolovasticRadius);
             // ----- Вывожу азимут скважены ---------

             x1 := Round(fHolovasticRadius*sin(MarkArray[i].Teta_1));   x2 := Round((fHolovasticRadius + 0.7*fHolovasticRadius)*sin(MarkArray[i].Teta_1));
             y1 := Round(fHolovasticRadius*cos(MarkArray[i].Teta_1));   y2 := Round((fHolovasticRadius + 0.7*fHolovasticRadius)*cos(MarkArray[i].Teta_1));
             Pen.Width := 2;
             MoveTo(PosX + X1, PosY - Y1); LineTo(PosX + X2, PosY - Y2);
             Pen.Width := 1;
        end;
     end;
       Brush.Color := clWhite;
     // ---------------- Вывод заголовка диаграммы ------
      fCanvas.Font.Size  := 12;
      fCanvas.Font.Name  := 'Courier New';
      fCanvas.Font.Style := [fsBold];
      TextOut(BeginPosX + (Width - TextWidth('Наклонограмма')) div 2, Round(BeginPosY - 1.5*CountPixelsInOneSant), 'Наклонограмма');
  end;
end;

{===============================================================================
}
function TGolovastic.GetPolePosFromAngle(Angle: TFloat): Integer;
const
  pi_2 = pi/2;
var
  Coef : TFloat;
begin
  Coef := 1 * (pi - angle)/pi_2*0.98;

  Result :=  BeginPosX + Round(angle*Coef*Width/pi_2)
end;

{ TFreqPole }

{===============================================================================
}
constructor TFreqPole.Create(aCanvas: TCanvas; aHeight : Integer; apfscPosition : PInteger; apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef : pFloat);
begin
  inherited Create(aCanvas, aHeight, apfscPosition, apfBeginScreenDepth, apfEndScreenDepth, apfMashtabCoef);
  CurEditIndexInFreqListBox := -1;
end;

{===============================================================================
}
procedure TFreqPole.Draw();
var
  i         : integer;
  Rect1     : TRect;
  Rect2     : TRect;
  ArrayIndex1, ArrayIndex2 : Integer;
  PosY1, PosY2 : Integer;
  HeightAllDiagram : Integer;
  HeightOneDiagram : Integer;
  LengthStrelka    : TFloat;
begin
  inherited Draw();

  with fCanvas do begin

    for i := 0 to Length(FreqLayerArray) - 1 do begin
       // ----- Нуно прописать проверочку на глубины -----------
       //if FreqLayerArray[i].BeginDepth
       if ((FreqLayerArray[i].BeginDepth < pfBeginScreenDepth^) and (FreqLayerArray[i].EndDepth   > pfEndScreenDepth^)) or
          ((FreqLayerArray[i].BeginDepth > pfBeginScreenDepth^) and (FreqLayerArray[i].BeginDepth < pfEndScreenDepth^)) or
          ((FreqLayerArray[i].EndDepth   > pfBeginScreenDepth^) and (FreqLayerArray[i].EndDepth   < pfEndScreenDepth^)) then begin
             ArrayIndex1 := LasFile.GetDepthIndex(FreqLayerArray[i].BeginDepth);
             ArrayIndex2 := LasFile.GetDepthIndex(FreqLayerArray[i].EndDepth  );


             HeightOneDiagram := Round((EndPosX - 10 - (BeginPosX + 5))*0.75);
             //HeightOneDiagram := Round(Font.PixelsPerInch/SmPerInch*2);
             HeightAllDiagram := HeightOneDiagram + HeightOneDiagram + Round(Font.PixelsPerInch/SmPerInch*0.5);

             PosY1 := Round(ArrayIndex1 / pfMashtabCoef^ - pfscPosition^) + BeginPosY;
             PosY2 := Round(ArrayIndex2 / pfMashtabCoef^ - pfscPosition^) + BeginPosY;
             // -----  Отрисовка стрелок --------
             LengthStrelka := Font.PixelsPerInch/SmPerInch*0.3;
             Pen.Color := clGreen;
             pen.Width := 2;

             MoveTo(BeginPosX, PosY1); LineTo(EndPosX, PosY1);  // --- Основная линия -----

             MoveTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, PosY1);
             LineTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, Round(PosY1 + LengthStrelka*2));

             MoveTo(Round(BeginPosX - LengthStrelka/3 + (EndPosX-BeginPosx)/2), Round(PosY1 + LengthStrelka));
             LineTo(Round(BeginPosX +                   (EndPosX-BeginPosx)/2), Round(PosY1                ));
             LineTo(Round(BeginPosX + LengthStrelka/3 + (EndPosX-BeginPosx)/2), Round(PosY1 + LengthStrelka));


             Pen.Color := clRed;
             MoveTo(BeginPosX, PosY2); LineTo(EndPosX, PosY2);

             MoveTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, PosY2);
             LineTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, Round(PosY2 - LengthStrelka*2));

             MoveTo(Round(BeginPosX - LengthStrelka/3 + (EndPosX-BeginPosx)/2), Round(PosY2 - LengthStrelka));
             LineTo(Round(BeginPosX +                   (EndPosX-BeginPosx)/2), Round(PosY2                ));
             LineTo(Round(BeginPosX + LengthStrelka/3 + (EndPosX-BeginPosx)/2), Round(PosY2 - LengthStrelka));

             Pen.Color := clBlack;
             Pen.Width := 1;
             // -------------
             PosY1 := PosY1 + ((PosY2 - PosY1) div 2) - HeightAllDiagram div 2;
             PosY2 := PosY1 + HeightOneDiagram;

             Rect1.Top    := PosY1;
             Rect1.Left   := BeginPosX + 5;
             Rect1.Bottom := PosY2;
             Rect1.Right  := EndPosX - 10;

             PosY2 := PosY1 + HeightAllDiagram;
             PosY1 := PosY2 - HeightOneDiagram;

             Rect2.Top    := PosY1;
             Rect2.Left   := BeginPosX + 5;
             Rect2.Bottom := PosY2;
             Rect2.Right  := EndPosX - 10;


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
               frmStatAnalysis.CalcAndDrawAlfaAndTetaGraphics(FreqLayerArray[i].BeginDepth,
                                                              FreqLayerArray[i].EndDepth,
                                                              FreqLayerArray[i].AzimWindow,
                                                              FreqLayerArray[i].BeginAlfa,
                                                              FreqLayerArray[i].EndAlfa,
                                                              0,
                                                              fCanvas,
                                                              fCanvas,
                                                              Rect1,
                                                              Rect2);
       end;
    end;
    FillRect(Rect(BeginPosX, 0,EndPosX, BeginPosY));
     // ---------------- Вывод заголовка диаграммы ------
      fCanvas.Font.Size  := 12;
      fCanvas.Font.Name  := 'Courier New';
      fCanvas.Font.Style := [fsBold];
      TextOut(BeginPosX + (Width - TextWidth('Частотограмма')) div 2, Round(BeginPosY - 1.5*CountPixelsInOneSant), 'Частотограмма');
  end;
end;

end.
