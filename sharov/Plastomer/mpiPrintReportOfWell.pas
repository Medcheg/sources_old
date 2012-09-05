unit mpiPrintReportOfWell;

interface

uses Windows,Graphics, mpiDeclaration, mpiLibrary, Math;

type
  TPrintParam = record
     PageWidth         : Integer;
     PageHeight       : Integer;

     RealPageWidth         : Integer;
     RealPageHeight       : Integer;

     BeginX, BeginY        : Integer;

     DepthPole_BeginX       : Integer; // 1
     DepthPole_Width       : Integer; // 1

     LitPole_BeginX         : Integer; // 2
     LitPole_Width         : Integer; // 2

     DopCurvesPole_BeginX   : Integer; // 3
     DopCurvesPole_Width   : Integer; // 3

     MidleRadiusPole_BeginX : Integer; // 4
     MidleRadiusPole_Width : Integer; // 4

     GisPole_BeginX         : Integer; // 5
     GisPole_Width         : Integer; // 5

     GolovasticPole_BeginX  : Integer; // 6
     GolovasticPole_Width  : Integer; // 6

     FreqPole_BeginX        : Integer; // 7
     FreqPole_Width        : Integer; // 7
  end;

    procedure PrintPageReportOfWell(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);

var
  PrintParam : TPrintParam;

implementation

Uses Classes, mpiGuardantStealth, mpiReportClass, mpiLasFile, sysUtils, Unit_StatAnalysis;

{===============================================================================
}
procedure PrintPole_1_(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);
var
  DepthPole : TDepthPole;

  CurDepth      : TFloat;
  CurDepthIndex : Integer;

  BeginPosX, EndPosX : Integer;
  CurPosY            : Integer;
  OutStr             : String;
  CountPixelsInOneSant       : TFloat;
begin
  DepthPole := TDepthPole(ReportClass.PoleList.Items[0]);

  CountPixelsInOneSant := fCanvas.Font.PixelsPerInch/SmPerInch;

  BeginPosX := PrintParam.DepthPole_BeginX;
  EndPosX   := BeginPosX + PrintParam.DepthPole_Width;


  CurDepth := LasFile.WellInf.Start;
  with fCanvas do begin
     Font.Size := 8;
     Font.Name := 'MS Sans Serif';
     Font.Style := [];
     while CurDepth <= LasFile.WellInf.Stop do begin
       CurDepthIndex := LasFile.GetDepthIndex(CurDepth);

       if (CurDepthIndex >= BeginPageDepthIndex) and (CurDepthIndex <= EndPageDepthIndex) then begin
             CurPosY := PrintParam.BeginY + Round((CurDepthIndex - BeginPageDepthIndex) / MashtabCoef);


           // ---------- Отрисовка Лаблов -------------
             OutStr := FloatToStrF(CurDepth, ffFixed, 15, 1);
             TextOut(EndPosX - Trunc(0.3*CountPixelsInOneSant) - TextWidth(OutStr), CurPosY - TextHeight(OutStr) div 2 , OutStr);
           // ---------- Отрисовка Тиков --------------
             MoveTo(EndPosX - 25, CurPosY);
             LineTo(EndPosX -  0, CurPosY);
       end;
       CurDepth := CurDepth + DepthPole.StepDepthLabel;
     end;
     // ---------------- Вывод заголовка диаграммы ------
      Font.Size  := 8;
      Font.Name  := 'MS Sans Serif';
      Font.Style := [fsBold];
      TextOut(EndPosX - Trunc(0.09*CountPixelsInOneSant) - TextWidth('Глубина,м'), Round(PrintParam.BeginY - 1.0*CountPixelsInOneSant), 'Глубина,м');
  end;
end;

{===============================================================================
}
procedure PrintPole_2_(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);
var
  LitPole                    : TLithography;
  BeginIndexLit, EndIndexLit : Integer;
  i                          : integer;
  PosY1, PosY2               : Integer;
  BeginPosX, EndPosX         : Integer;
  Bitmap                     : TBitmap;
begin
  LitPole   := TLithography(ReportClass.PoleList.Items[1]);
  BeginPosX := PrintParam.LitPole_BeginX;
  EndPosX   := BeginPosX + PrintParam.LitPole_Width;
  Bitmap    := TBitmap.Create();
  with fCanvas do begin
      for i := 0 to Length(LitPole.LayerArray) - 1 do begin
          BeginIndexLit := LasFile.GetDepthIndex(LitPole.LayerArray[i].BeginDepth);
          EndIndexLit   := LasFile.GetDepthIndex(LitPole.LayerArray[i].EndDepth);

          if ((BeginIndexLit < BeginPageDepthIndex) and (EndIndexLit > EndPageDepthIndex)) or
             ((BeginIndexLit > BeginPageDepthIndex) and (BeginIndexLit < EndPageDepthIndex)) or
             ((EndIndexLit   > BeginPageDepthIndex) and (EndIndexLit   < EndPageDepthIndex)) then begin

                  if BeginIndexLit < BeginPageDepthIndex then BeginIndexLit := BeginPageDepthIndex;
                  if EndIndexLit   > EndPageDepthIndex   then EndIndexLit   := EndPageDepthIndex;

                  PosY1 := PrintParam.BeginY + Round((BeginIndexLit - BeginPageDepthIndex) / MashtabCoef);
                  PosY2 := PrintParam.BeginY + Round((EndIndexLit   - BeginPageDepthIndex) / MashtabCoef);

                  fCanvas.pen.Color   := clBlack;
                  fCanvas.pen.Style   := psSolid;
                  fCanvas.pen.Mode    := pmCopy;
                  fCanvas.Pen.Width   := 1;

                  fCanvas.Brush.Color := LitPole.LayerArray[i].LayerPenColor;
                  fCanvas.Brush.Style := TBrushStyle(LitPole.LayerArray[i].LayerBrushStyle);

                  fCanvas.Rectangle(BeginPosX, PosY1, EndPosX, PosY2);

                  fCanvas.Brush.Color := clWhite;
                  fCanvas.Brush.Style := bsSolid;
          end;
      end;
  end;
  Bitmap.free;
end;

{===============================================================================
}
procedure PrintPole_3_(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);
var
  DropCurves  : TDropCurves;
  i, k        : integer;
  SubPoleWidth : Integer;
  BeginPosX, EndPosX         : Integer;
  BeginPosY, EndPosY         : Integer;
  Series                     : Tseries;
  SeriesScaleCoef            : TFloat;

  OffsetPosSubPole           : Integer;
  SubPoleBeginX, SubPoleEndX : Integer;

  PointArray                 : array of TPoint;

  xValue                     : TFloat;

  CountPixelsInOneSant       : TFloat;
begin
  DropCurves  := TDropCurves (ReportClass.PoleList.Items[2]);


  SetLength(PointArray, EndPageDepthIndex - BeginPageDepthIndex + 1);

  CountPixelsInOneSant := fCanvas.Font.PixelsPerInch/SmPerInch;

  BeginPosX := PrintParam.DopCurvesPole_BeginX;
  EndPosX   := BeginPosX + PrintParam.DopCurvesPole_Width;
  BeginPosY := PrintParam.BeginY;
  EndPosY   := PrintParam.BeginY + Trunc((EndPageDepthIndex - BeginPageDepthIndex)/MashtabCoef);

  OffsetPosSubPole := 0;
  if DropCurves.SeriesList.Count = 0 then SubPoleWidth := 0
                                     else SubPoleWidth := ((EndPosX - BeginPosX) - 1) div DropCurves.SeriesList.Count;

  with fCanvas do begin
    for i := 0 to DropCurves.SeriesList.Count - 1 do begin
        Series := TSeries(DropCurves.SeriesList.Items[i]);
        SeriesScaleCoef := (SubPoleWidth - 2)/abs(Series.CorrectMaxValue - Series.CorrectMinValue);

        SubPoleBeginX := BeginPosX + OffsetPosSubPole + 1;
        SubPoleEndX   := SubPoleBeginX + SubPoleWidth - 1;
        // ---- Отрисовка промежутков полей --------
           if (i > 0) and (i < DropCurves.SeriesList.Count) then begin
               Pen.Color := clGray;
               MoveTo(BeginPosX + OffsetPosSubPole, BeginPosY);
               LineTo(BeginPosX + OffsetPosSubPole, EndPosY);
           end;
        // ---- Пошла отрисовка серий --------------
        Pen.Style := Series.PenStyle;
        Pen.Width := Series.PenWidth;
        Pen.Color := Series.PenColor;
        for k := BeginPageDepthIndex to EndPageDepthIndex do begin

                XValue := SubPoleBeginX + (Series.data^[k] - Series.CorrectMinValue)*SeriesScaleCoef;

                if XValue < SubPoleBeginX then XValue := SubPoleBeginX;
                if XValue > SubPoleEndX   then XValue := SubPoleEndX;

                PointArray[k - BeginPageDepthIndex].x := Trunc(XValue);
                PointArray[k - BeginPageDepthIndex].y := BeginPosY     + Round((k - BeginPageDepthIndex) / MashtabCoef);
        end;
        Polyline(PointArray);

        fCanvas.Font.Size := 7;
        fCanvas.Font.Name := 'MS Sans Serif';
        fCanvas.Font.Style := [fsBold];

        TextOut(SubPoleBeginX + (SubPoleEndX - SubPoleBeginX - TextWidth(Series.Name)) div 2, Trunc(BeginPosY - 0.2*CountPixelsInOneSant - TextHeight(Series.Name)), Series.Name);

        OffsetPosSubPole := OffsetPosSubPole + SubPoleWidth;
     end;

        fCanvas.Font.Size  := 10;
        fCanvas.Font.Name  := 'Courier New';
     // ------- Стрелочка --------
        Pen.Color := clBlack;
        MoveTo(Trunc(BeginPosX + 0.2*CountPixelsInOneSant), Trunc(BeginPosY - 0.8*CountPixelsInOneSant));
        LineTo(Trunc(EndPosX   - 0.2*CountPixelsInOneSant), Trunc(BeginPosY - 0.8*CountPixelsInOneSant));
        MoveTo(Trunc(EndPosX   - 0.7*CountPixelsInOneSant), Trunc(BeginPosY - 0.9*CountPixelsInOneSant));
        LineTo(Trunc(EndPosX   - 0.2*CountPixelsInOneSant), Trunc(BeginPosY - 0.8*CountPixelsInOneSant));
        LineTo(Trunc(EndPosX   - 0.7*CountPixelsInOneSant), Trunc(BeginPosY - 0.7*CountPixelsInOneSant));

        TextOut(Trunc(BeginPosX + 0.2*CountPixelsInOneSant)                   , Trunc(BeginPosY - 1.45*CountPixelsInOneSant), 'min');
        TextOut(Trunc(EndPosX   - 0.2*CountPixelsInOneSant - TextWidth('max')), Trunc(BeginPosY - 1.45*CountPixelsInOneSant), 'max');
        Font.Style := [];
  end;
end;

{===============================================================================
}
procedure PrintPole_4_(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);
var
  MidleRadius : TMidleRadius;
  Series      : TSeries;
  BeginPosX, EndPosX         : Integer;
  BeginPosY, EndPosY         : Integer;

  CenterXPole                : Integer;
  MaxWidthRadius             : Integer;
  MashtabCoefRadius          : TFloat;

  OffsetArray                : array of TPoint;
  CountElementOffsetArray    : Integer;
  PointArray1                : array of TPoint;
  PointArray2                : array of TPoint;
  i                          : Integer;

  MinRadius, MaxRadius       : TFloat;
    OffstNominalDiametr      : Integer;
    Text_Height              : Integer;
    OutPutStr                : String;
  CountPixelsInOneSant       : TFloat;
  ArrayIndex                 : Integer;
  PosY                       : TFloat;


begin
  MidleRadius := TMidleRadius(ReportClass.PoleList.Items[3]);

  BeginPosX := PrintParam.MidleRadiusPole_BeginX;
  EndPosX   := BeginPosX + PrintParam.MidleRadiusPole_Width;
  BeginPosY := PrintParam.BeginY;
  EndPosY   := PrintParam.BeginY + Trunc((EndPageDepthIndex - BeginPageDepthIndex)/MashtabCoef);

  CountPixelsInOneSant := fCanvas.Font.PixelsPerInch/SmPerInch;

  Series := LasFile.GetSeries('RADS');
  CenterXPole            := BeginPosX + (EndPosX - BeginPosX) div 2; // -- Центр поля -------

  MaxWidthRadius         := ((EndPosX - BeginPosX) - Trunc((EndPosX - BeginPosX)*0.2)) div 2 ;
  MashtabCoefRadius      := MaxWidthRadius / Series.MaxValue;

  SetLength(OffsetArray, EndPageDepthIndex - BeginPageDepthIndex + 1);

  MinRadius              :=  100000000000;
  MaxRadius              := -100000000000;
  for i := BeginPageDepthIndex to EndPageDepthIndex do begin
      if Series.data^[i] = LasFile.WellInf.Null then OffsetArray[i - BeginPageDepthIndex].x := Trunc(LasFile.WellInf.Null*1000)
      else OffsetArray[i - BeginPageDepthIndex].x := Trunc(Series.data^[i]*MashtabCoefRadius);
      OffsetArray[i - BeginPageDepthIndex].y := BeginPosY + Round((i - BeginPageDepthIndex) / MashtabCoef);

      if MinRadius > Series.data^[i] then MinRadius := Series.data^[i];
      if MaxRadius < Series.data^[i] then MaxRadius := Series.data^[i];
  end;

  SetLength(PointArray1, EndPageDepthIndex - BeginPageDepthIndex + 1 + 2);
  SetLength(PointArray2, EndPageDepthIndex - BeginPageDepthIndex + 1 + 2);

  CountElementOffsetArray := 0;
  for i := 0 to Length(OffsetArray) - 1 do begin
     if OffsetArray[i].x <> Trunc(LasFile.WellInf.Null*1000) then begin
        PointArray1[CountElementOffsetArray].x := CenterXPole - OffsetArray[i].x;
        PointArray1[CountElementOffsetArray].y := OffsetArray[i].y;

        PointArray2[CountElementOffsetArray].x := CenterXPole + OffsetArray[i].x;
        PointArray2[CountElementOffsetArray].y := OffsetArray[i].y;

        CountElementOffsetArray := CountElementOffsetArray + 1;
     end;
  end;
  SetLength(PointArray1, CountElementOffsetArray + 2);
  SetLength(PointArray2, CountElementOffsetArray + 2);

  PointArray1[CountElementOffsetArray].x := BeginPosX;
  PointArray1[CountElementOffsetArray].y := PointArray1[CountElementOffsetArray - 1].y;
  PointArray2[CountElementOffsetArray].x := EndPosX;
  PointArray2[CountElementOffsetArray].y := PointArray2[CountElementOffsetArray - 1].y;

  PointArray1[CountElementOffsetArray+1].x := BeginPosX;
  PointArray1[CountElementOffsetArray+1].y := PointArray1[0].y;
  PointArray2[CountElementOffsetArray+1].x := EndPosX;
  PointArray2[CountElementOffsetArray+1].y := PointArray2[0].y;

  // ------------ Отрисовка тем , чем заполнили масивы --------------
  with fCanvas do begin
       // ---- Отрисовка осевой линиий ------------
         Pen.Style := psDashDotDot;
         MoveTo(CenterXPole ,BeginPosY + 1); LineTo(CenterXPole, EndPosY - 1);
         Pen.Style := psSolid;
       // ---- Отрисовка Номинального радиуса ----------------
         if MidleRadius.NominalDiametrEnabled then begin
           Pen.Color := clRed;
           OffstNominalDiametr := Trunc(MidleRadius.NominalDiametr/2*MashtabCoefRadius);
           MoveTo(CenterXPole + OffstNominalDiametr ,BeginPosY + 1); LineTo(CenterXPole + OffstNominalDiametr, EndPosY - 1);
           MoveTo(CenterXPole - OffstNominalDiametr ,BeginPosY + 1); LineTo(CenterXPole - OffstNominalDiametr, EndPosY - 1);
           // -------------- Вывод планок , соответсвующие падениям головастиков ----
           Pen.Color := clBlack;
           for i := 0 to Length(MarkArray) - 1 do begin
              ArrayIndex := LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth);
              if (ArrayIndex >= BeginPageDepthIndex) and (ArrayIndex <= EndPageDepthIndex) then begin

                 PosY  := BeginPosY + Round((ArrayIndex - BeginPageDepthIndex) / MashtabCoef);

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
         Font.Size := 8;
         Font.Name := 'MS Sans Serif';
         Font.Style := [];

         Text_Height := TextHeight('0');

         OutPutStr   := 'min=' + FloatToStrf(MinRadius, ffFixed, 10,2);
         TextOut(Round(BeginPosX + 0.1*CountPixelsInOneSant), Round(BeginPosY - 2*Text_Height - 0.25 * CountPixelsInOneSant), OutPutStr);
         OutPutStr   := 'max=' + FloatToStrf(MaxRadius, ffFixed, 10,2);
         TextOut(Round(BeginPosX + 0.1*CountPixelsInOneSant), Round(BeginPosY -   Text_Height - 0.2  * CountPixelsInOneSant), OutPutStr);
       // ---------------- Вывод заголовка диаграммы ------
         fCanvas.Font.Size  := 10;
         fCanvas.Font.Name  := 'Courier New';
         fCanvas.Font.Style := [fsBold];
         TextOut(BeginPosX + ((EndPosX - BeginPosX) - TextWidth('Профиль скв.')) div 2, Round(BeginPosY - 1.5*CountPixelsInOneSant), 'Профиль скв.');
  end;

end;

{===============================================================================
}
procedure PrintPole_5_(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);
var
  GIS         : TGIS;

  BeginPosX, EndPosX         : Integer;
  BeginPosY                  : Integer;

  i, k                       : Integer;
  Series                     : TSeries;
  SeriesScaleCoef            : TFloat;

  ArrayIndex                 : Integer;
  CountElementPointArray     : Integer;
  CurrentPoleDepth           : TFloat;
  DepthIndex                 : Integer;
  PointArray                 : array of TPoint;
  XValue                     : TFloat;
  CountPixelsInOneSant       : TFloat;
begin

  GIS         := TGIS        (ReportClass.PoleList.Items[4]);

  BeginPosX := PrintParam.GisPole_BeginX;
  EndPosX   := BeginPosX + PrintParam.GisPole_Width;
  BeginPosY := PrintParam.BeginY;

  CountPixelsInOneSant := fCanvas.Font.PixelsPerInch/SmPerInch;

  with fCanvas do begin
     for i := 0 to GIS.SeriesList.Count - 1 do begin
        Series          := TSeries(GIS.SeriesList.Items[i]);
        SeriesScaleCoef := ((EndPosX - BeginPosX) - 2)/abs(Series.CorrectMaxValue - Series.CorrectMinValue);

        // ---- Пошла отрисовка серий --------------
        SetLength(PointArray, EndPageDepthIndex - BeginPageDepthIndex + 1);

        ArrayIndex             := GIS.GISLasFile.GetDepthIndex(LasFile.XValue.Data^[BeginPageDepthIndex]);
        if ArrayIndex <> -1 then begin
              PointArray[0].x        := BeginPosX + Trunc((Series.data^[ArrayIndex] - Series.CorrectMinValue)*SeriesScaleCoef);
              PointArray[0].y        := BeginPosY;
              CountElementPointArray := 0;

              if (Series.data^[ArrayIndex] = GIS.GISLasFile.WellInf.Null) or
                 (arrayIndex = -1)                                        or
                 (GIS.GISLasFile.XValue.Data^[ArrayIndex] < GIS.pfBeginScreenDepth^)     or
                 (GIS.GISLasFile.XValue.Data^[ArrayIndex] > GIS.pfEndScreenDepth^)       then CountElementPointArray := -1;

              Pen.Color := Series.PenColor;
              Pen.Width := Series.PenWidth;
              Pen.Style := Series.PenStyle;

              for k := BeginPageDepthIndex to EndPageDepthIndex do begin

                  CurrentPoleDepth := LasFile.XValue.Data^[k];
                  DepthIndex       := GIS.GISLasFile.GetDepthIndex(CurrentPoleDepth);
                  if DepthIndex <> -1 then begin
                     if (Series.data^[DepthIndex] <> GIS.GISLasFile.WellInf.Null) and
                        (GIS.GISLasFile.XValue.Data^[ArrayIndex] >= GIS.pfBeginScreenDepth^)      and
                        (GIS.GISLasFile.XValue.Data^[ArrayIndex] <= GIS.pfEndScreenDepth^)      then begin
                         CountElementPointArray := CountElementPointArray + 1;

                         XValue := BeginPosX + (Series.data^[DepthIndex] - Series.CorrectMinValue)*SeriesScaleCoef;

                         if XValue <= BeginPosX then XValue := BeginPosX + 1;
                         if XValue >= EndPosX   then XValue := EndPosX   - 1;

                         PointArray[CountElementPointArray].x := Trunc(XValue);
                         PointArray[CountElementPointArray].y := BeginPosY + Round((k - BeginPageDepthIndex) / MashtabCoef);
                     end;
                  end;
              end;
              if CountElementPointArray > 0 then begin
                SetLength(PointArray, CountElementPointArray);
                Polyline(PointArray);
              end;
        end;
     end;
       // ---------------- Вывод заголовка диаграммы ------
         fCanvas.Font.Size  := 12;
         fCanvas.Font.Name  := 'Courier New';
         fCanvas.Font.Style := [fsBold];
         TextOut(BeginPosX + ((EndPosX - BeginPosX) - TextWidth('ГИС')) div 2, Round(BeginPosY - 1.5*CountPixelsInOneSant), 'ГИС');

      Pen.Color := clBlack;
      Pen.Width := 1;
      Pen.Style := psSolid;
  end;
end;

{===============================================================================
}
function GetPolePosFromAngle(Angle : TFloat): Integer;
const
  pi_2 = pi/2;
var
  Coef : TFloat;
  BeginPosX, EndPosX         : Integer;
begin
  Coef := 1 * (pi - angle)/pi_2*0.98;

  BeginPosX := PrintParam.GolovasticPole_BeginX;
  EndPosX   := BeginPosX + PrintParam.GolovasticPole_Width;

  Result :=  BeginPosX + trunc(angle*Coef*((EndPosX - BeginPosX))/pi_2)
end;

{===============================================================================
}
procedure PrintPole_6_(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);
const
  pi_180 = pi/180;
var
  Golovastic   : TGolovastic;
  BeginPosX, EndPosX         : Integer;
  BeginPosY, EndPosY         : Integer;
  Text_Height                : Integer;
  fHolovasticRadius          : Integer;
  CurAngle                   : TFloat;
  PosX, PosY                 : Integer;
  CountPixelsInOneSant       : TFloat;

  i, k                       : Integer;
  ArrayIndex                 : Integer;
  sumKorel                   : TFloat;
  x1, x2, y1, y2             : Integer;
begin
  Golovastic  := TGolovastic (ReportClass.PoleList.Items[5]);

  BeginPosX := PrintParam.GolovasticPole_BeginX;
  EndPosX   := BeginPosX + PrintParam.GolovasticPole_Width;
  BeginPosY := PrintParam.BeginY;
  EndPosY   := PrintParam.BeginY + Trunc((EndPageDepthIndex - BeginPageDepthIndex)/MashtabCoef);

  CountPixelsInOneSant := fCanvas.Font.PixelsPerInch/SmPerInch;

  with fCanvas do begin
     Brush.Style := bsSolid;
     Brush.Color := clWhite;
     // -------------
     Text_Height       := TextHeight('0');
     fHolovasticRadius := Round(Font.PixelsPerInch/SmPerInch*Golovastic.HolovasticRadius/10/2);
     // ---- Отрисовка Зон головастиков (разбивка поля на подполя по углам) -----------
     Pen.Color := clGray;
     CurAngle := 10;
     While CurAngle < 90 do begin
         PosX := GetPolePosFromAngle(CurAngle*Pi_180);
         MoveTo(PosX ,BeginPosY + 1); LineTo(PosX, EndPosY - 1);
         CurAngle := CurAngle + 10;
     end;
     Pen.Color := clBlack;
     // -------  zВывод подписей углов ----------------------
     PosX := GetPolePosFromAngle(0 *Pi_180); TextOut(PosX - TextWidth('0' ) div 2, BeginPosY - Text_Height - Round(0.2  * CountPixelsInOneSant), '0' ); MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     PosX := GetPolePosFromAngle(10*Pi_180); TextOut(PosX - TextWidth('10') div 2, BeginPosY - Text_Height - Round(0.2  * CountPixelsInOneSant), '10'); MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     PosX := GetPolePosFromAngle(20*Pi_180); TextOut(PosX - TextWidth('20') div 2, BeginPosY - Text_Height - Round(0.2  * CountPixelsInOneSant), '20'); MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     PosX := GetPolePosFromAngle(50*Pi_180); TextOut(PosX - TextWidth('50') div 2, BeginPosY - Text_Height - Round(0.2  * CountPixelsInOneSant), '50'); MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     PosX := GetPolePosFromAngle(90*Pi_180); TextOut(PosX - TextWidth('90') div 2, BeginPosY - Text_Height - Round(0.2  * CountPixelsInOneSant), '90'); //MoveTo(PosX, BeginPosY); LineTo(PosX, BeginPosY - 3);
     // --------- Вывод Головастиков ----------
     for i := 0 to Length(MarkArray) - 1 do begin

        if (LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth) >= BeginPageDepthIndex) and (LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth) <= EndPageDepthIndex) then begin

             ArrayIndex := LasFile.GetDepthIndex(MarkArray[i].fCurrentDepth);

             PosX := GetPolePosFromAngle(MarkArray[i].Alfa_1);
             PosY := BeginPosY + Round((ArrayIndex - BeginPageDepthIndex) / MashtabCoef);

             // --------- Подбираю тип заливки головастика -------
             sumKorel := (abs(MarkArray[i].kArray[0].Kor) + abs(MarkArray[i].kArray[1].Kor))/2;
             for k := 0 to 4 do begin
                 if (SumKorel >= Golovastic.MinMaxArray[k].min/100) and (SumKorel < Golovastic.MinMaxArray[k].max/100) then begin
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
      fCanvas.Font.Size  := 10;
      fCanvas.Font.Name  := 'Courier New';
      fCanvas.Font.Style := [fsBold];
      TextOut(BeginPosX + ((EndPosX - BeginPosX) - TextWidth('Наклонограмма')) div 2, Round(BeginPosY - 1.5*CountPixelsInOneSant), 'Наклонограмма');
  end;
end;

{===============================================================================
}
procedure PrintPole_7_(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);
var
  FreqPole                   : TFreqPole;

  BeginPosX, EndPosX         : Integer;
  BeginPosY                  : Integer;

  CountPixelsInOneSant       : TFloat;

  ArrayIndex1                : Integer;
  ArrayIndex2                : Integer;
  ArrayIndex3                : Integer;
  PosY1, PosY2               : Integer;
  ControlPos                 : Integer;
  Rect1, Rect2               : TRect;

  i                          : Integer;

  HeightAllDiagram           : Integer;
  HeightOneDiagram           : Integer;

  LengthStrelka              : TFloat;
begin
  FreqPole    := TFreqPole   (ReportClass.PoleList.Items[6]);

  BeginPosX := PrintParam.FreqPole_BeginX;
  EndPosX   := BeginPosX + PrintParam.FreqPole_Width;
  BeginPosY := PrintParam.BeginY;

  CountPixelsInOneSant := fCanvas.Font.PixelsPerInch/SmPerInch;

  with fCanvas do begin
    for i := 0 to Length(FreqPole.FreqLayerArray) - 1 do begin
       ArrayIndex1 := LasFile.GetDepthIndex(FreqPole.FreqLayerArray[i].BeginDepth);
       ArrayIndex3 := LasFile.GetDepthIndex(FreqPole.FreqLayerArray[i].EndDepth  );
       ArrayIndex2 := ArrayIndex1 + (ArrayIndex3 - ArrayIndex1) div 2;

       HeightOneDiagram := Round((EndPosX - 10 - (BeginPosX + 5))*0.75);
       //HeightOneDiagram := Round(Font.PixelsPerInch/SmPerInch*2);
       HeightAllDiagram := HeightOneDiagram + HeightOneDiagram + Round(Font.PixelsPerInch/SmPerInch*0.5);

       PosY1      := PrintParam.BeginY + Round((ArrayIndex1 - BeginPageDepthIndex) / MashtabCoef);
       PosY2      := PrintParam.BeginY + Round((ArrayIndex3 - BeginPageDepthIndex) / MashtabCoef);
       ControlPos := PosY2;

       // -----  Отрисовка стрелок --------
       LengthStrelka := Font.PixelsPerInch/SmPerInch*0.3;
       pen.Width := 2;

       if (ArrayIndex1 >= BeginPageDepthIndex) and (ArrayIndex1 < EndPageDepthIndex) then begin
           Pen.Color := clGreen;
           MoveTo(BeginPosX, PosY1); LineTo(EndPosX, PosY1);  // --- Основная линия -----

           MoveTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, PosY1);
           LineTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, Round(PosY1 + LengthStrelka*2));

           MoveTo(Round(BeginPosX - LengthStrelka/3 + (EndPosX-BeginPosx)/2), Round(PosY1 + LengthStrelka));
           LineTo(Round(BeginPosX +                   (EndPosX-BeginPosx)/2), Round(PosY1                ));
           LineTo(Round(BeginPosX + LengthStrelka/3 + (EndPosX-BeginPosx)/2), Round(PosY1 + LengthStrelka));
       end;
       if (ArrayIndex3 >= BeginPageDepthIndex) and (ArrayIndex3 < EndPageDepthIndex) then begin
           Pen.Color := clRed;
           MoveTo(BeginPosX, PosY2); LineTo(EndPosX, PosY2);

           MoveTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, PosY2);
           LineTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, Round(PosY2 - LengthStrelka*2));

           MoveTo(Round(BeginPosX - LengthStrelka/3 + (EndPosX-BeginPosx)/2), Round(PosY2 - LengthStrelka));
           LineTo(Round(BeginPosX +                   (EndPosX-BeginPosx)/2), Round(PosY2                ));
           LineTo(Round(BeginPosX + LengthStrelka/3 + (EndPosX-BeginPosx)/2), Round(PosY2 - LengthStrelka));
       end;

       Pen.Color := clBlack;
       Pen.Width := 1;
       if (ArrayIndex2 >= BeginPageDepthIndex) and (ArrayIndex2 < EndPageDepthIndex) then begin
           PosY1 := PosY1 + ((PosY2 - PosY1) div 2) - HeightAllDiagram div 2;
           PosY2 := PosY1 + HeightOneDiagram;

           if ControlPos - PosY2 < 0 then begin
             PosY1 := PosY1 - abs(ControlPos - PosY2);
             PosY2 := PosY2 - abs(ControlPos - PosY2);
           end;

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
           frmStatAnalysis.CalcAndDrawAlfaAndTetaGraphics(FreqPole.FreqLayerArray[i].BeginDepth,
                                                          FreqPole.FreqLayerArray[i].EndDepth,
                                                          FreqPole.FreqLayerArray[i].AzimWindow,
                                                          FreqPole.FreqLayerArray[i].BeginAlfa,
                                                          FreqPole.FreqLayerArray[i].EndAlfa,
                                                          0,
                                                          fCanvas,
                                                          fCanvas,
                                                          Rect1,
                                                          Rect2);
       end;
       // -------------
    end;
     // ---------------- Вывод заголовка диаграммы ------
      fCanvas.Font.Size  := 10;
      fCanvas.Font.Name  := 'Courier New';
      fCanvas.Font.Style := [fsBold];
      fCanvas.TextOut(BeginPosX + (PrintParam.FreqPole_Width - TextWidth('Частотограмма')) div 2, Round(BeginPosY - 1.5*CountPixelsInOneSant), 'Частотограмма');
  end;
{  with fCanvas do begin
    for i := 0 to Length(FreqLayerArray) - 1 do begin
       // ----- Нуно прописать проверочку на глубины -----------
       //if FreqLayerArray[i].BeginDepth
       if ((FreqLayerArray[i].BeginDepth < pfBeginScreenDepth^) and (FreqLayerArray[i].EndDepth   > pfEndScreenDepth^)) or
          ((FreqLayerArray[i].BeginDepth > pfBeginScreenDepth^) and (FreqLayerArray[i].BeginDepth < pfEndScreenDepth^)) or
          ((FreqLayerArray[i].EndDepth   > pfBeginScreenDepth^) and (FreqLayerArray[i].EndDepth   < pfEndScreenDepth^)) then begin
             ArrayIndex1 := LasFile.GetDepthIndex(FreqLayerArray[i].BeginDepth);
             ArrayIndex2 := LasFile.GetDepthIndex(FreqLayerArray[i].EndDepth  );

             HeightOneDiagram := Round(Font.PixelsPerInch/SmPerInch*2);
             HeightAllDiagram := HeightOneDiagram + HeightOneDiagram + Round(Font.PixelsPerInch/SmPerInch*0.5);

             PosY1 := Round(ArrayIndex1 / pfMashtabCoef^ - pfscPosition^) + BeginPosY;
             PosY2 := Round(ArrayIndex2 / pfMashtabCoef^ - pfscPosition^) + BeginPosY;
             // -------------
             LengthStrelka := Font.PixelsPerInch/SmPerInch*0.3;
             Pen.Color := clGreen;
             pen.Width := 2;

             MoveTo(BeginPosX, PosY1); LineTo(EndPosX, PosY1);  // --- Основная линия -----

             MoveTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, PosY1);
             LineTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, Round(PosY1 + LengthStrelka*2));

             MoveTo(Round(BeginPosX - LengthStrelka/2 + (EndPosX-BeginPosx)/2), Round(PosY1 + LengthStrelka));
             LineTo(Round(BeginPosX +                   (EndPosX-BeginPosx)/2), Round(PosY1                ));
             LineTo(Round(BeginPosX + LengthStrelka/2 + (EndPosX-BeginPosx)/2), Round(PosY1 + LengthStrelka));


             Pen.Color := clRed;
             MoveTo(BeginPosX, PosY2); LineTo(EndPosX, PosY2);

             MoveTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, PosY2);
             LineTo(Round(BeginPosX + (EndPosX-BeginPosx)/2) + 1, Round(PosY2 - LengthStrelka*2));

             MoveTo(Round(BeginPosX - LengthStrelka/2 + (EndPosX-BeginPosx)/2), Round(PosY2 - LengthStrelka));
             LineTo(Round(BeginPosX +                   (EndPosX-BeginPosx)/2), Round(PosY2                ));
             LineTo(Round(BeginPosX + LengthStrelka/2 + (EndPosX-BeginPosx)/2), Round(PosY2 - LengthStrelka));

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
  end;}
end;

procedure PrintPageReportOfWell(fCanvas : TCanvas; MashtabCoef : TFloat; BeginPageDepthIndex, EndPageDepthIndex : Integer);
var
  y1, y2  : Integer;
begin
  // -- Делаю Очистку Канвы ---------
  fCanvas.FillRect(Rect(0,0,PrintParam.PageWidth, PrintParam.PageHeight));
  // -- Отрисовка Полей -----------

     y1 := PrintParam.BeginY;
     y2 := PrintParam.BeginY + Trunc((EndPageDepthIndex - BeginPageDepthIndex)/MashtabCoef);
    // ---Нижняя - верняя границы -------
    fCanvas.MoveTo(PrintParam.DepthPole_BeginX + PrintParam.DepthPole_Width, y1);
    fCanvas.LineTo(PrintParam.PageWidth                                    , y1);
    fCanvas.MoveTo(PrintParam.DepthPole_BeginX + PrintParam.DepthPole_Width, y2);
    fCanvas.LineTo(PrintParam.PageWidth                                    , y2);
    // -------- 11 --------
    fCanvas.MoveTo(PrintParam.DepthPole_BeginX + PrintParam.DepthPole_Width, y1);
    fCanvas.LineTo(PrintParam.DepthPole_BeginX + PrintParam.DepthPole_Width, y2);
    // -------- 21 --------
    fCanvas.MoveTo(PrintParam.LitPole_BeginX, y1);
    fCanvas.LineTo(PrintParam.LitPole_BeginX, y2);
    fCanvas.MoveTo(PrintParam.LitPole_BeginX + PrintParam.LitPole_Width, y1);
    fCanvas.LineTo(PrintParam.LitPole_BeginX + PrintParam.LitPole_Width, y2);
    // -------- 31 --------
    fCanvas.MoveTo(PrintParam.DopCurvesPole_BeginX, y1);
    fCanvas.LineTo(PrintParam.DopCurvesPole_BeginX, y2);
    fCanvas.MoveTo(PrintParam.DopCurvesPole_BeginX + PrintParam.DopCurvesPole_Width, y1);
    fCanvas.LineTo(PrintParam.DopCurvesPole_BeginX + PrintParam.DopCurvesPole_Width, y2);
    // -------- 41 --------
    fCanvas.MoveTo(PrintParam.MidleRadiusPole_BeginX, y1);
    fCanvas.LineTo(PrintParam.MidleRadiusPole_BeginX, y2);
    fCanvas.MoveTo(PrintParam.MidleRadiusPole_BeginX + PrintParam.MidleRadiusPole_Width, y1);
    fCanvas.LineTo(PrintParam.MidleRadiusPole_BeginX + PrintParam.MidleRadiusPole_Width, y2);
    // -------- 51 --------
    fCanvas.MoveTo(PrintParam.GisPole_BeginX, y1);
    fCanvas.LineTo(PrintParam.GisPole_BeginX, y2);
    fCanvas.MoveTo(PrintParam.GisPole_BeginX + PrintParam.GisPole_Width, y1);
    fCanvas.LineTo(PrintParam.GisPole_BeginX + PrintParam.GisPole_Width, y2);
    // -------- 61 --------
    fCanvas.MoveTo(PrintParam.GolovasticPole_BeginX, y1);
    fCanvas.LineTo(PrintParam.GolovasticPole_BeginX, y2);
    fCanvas.MoveTo(PrintParam.GolovasticPole_BeginX + PrintParam.GolovasticPole_Width, y1);
    fCanvas.LineTo(PrintParam.GolovasticPole_BeginX + PrintParam.GolovasticPole_Width, y2);
    // -------- 71 --------
    fCanvas.MoveTo(PrintParam.FreqPole_BeginX, y1);
    fCanvas.LineTo(PrintParam.FreqPole_BeginX, y2);
    // ---------------------------------------------------------------------------------------------
    if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPole_1_(fCanvas, MashtabCoef, BeginPageDepthIndex, EndPageDepthIndex);
    if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPole_2_(fCanvas, MashtabCoef, BeginPageDepthIndex, EndPageDepthIndex);
    if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPole_3_(fCanvas, MashtabCoef, BeginPageDepthIndex, EndPageDepthIndex);
    if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPole_4_(fCanvas, MashtabCoef, BeginPageDepthIndex, EndPageDepthIndex);
    if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPole_5_(fCanvas, MashtabCoef, BeginPageDepthIndex, EndPageDepthIndex);
    if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPole_6_(fCanvas, MashtabCoef, BeginPageDepthIndex, EndPageDepthIndex);
    if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPole_7_(fCanvas, MashtabCoef, BeginPageDepthIndex, EndPageDepthIndex);
end;

end.
