unit Unit_PrintReportOfWell1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, mpiDeclaration, WinSpool, mpiLibrary;

type
  TPrintType = (Printing, NotPrinting);

  TfrmPrintReportOfWell = class(TForm)
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    bbPrintReportOfWell: TBitBtn;
    bbCancelReportOfWell: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    procedure bbPrintReportOfWellClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    PixelsInOneSm : TFloat;
    PageCount     : Integer;
    MashtabCoef   : TFloat;

    procedure OutTopCap(i, PageCount : integer; outPages : Boolean);
    procedure SetPrinterPageSizes(APageWidth,APageLength: Integer);
    function  PrintHeadPaper(PrintType : TPrintType) : Integer;
    function  OutBottomCap(CurYPos : Integer; ArrayIndexPerPage, DrawedArrayIndex : Integer; MashtabCoef : TFloat): integer;
    procedure FillType_PrintParam(Offset : Integer);
  public
    { Public declarations }
  end;

var
  frmPrintReportOfWell: TfrmPrintReportOfWell;

implementation

uses Printers, mpiReportClass, mpiLasFile,
  mpiPrintReportOfWell, Unit_StatAnalysis, mpiGuardantStealth;

{$R *.DFM}

{===============================================================================
}
function TfrmPrintReportOfWell.PrintHeadPaper(PrintType : TPrintType): Integer;
var
   TopBottomOffsetSm :TFloat;
   str1              : String;
   str2              : String;
   str3              : String;
   str4              : String;
   str5              : String;
   str6              : String;
   str_              : String;
   Mashtab           : Integer;

   Rect1, Rect2      : TRect;
   v1, v2            : TFloat;

   coef              : TFloat;

begin

   TopBottomOffsetSm := 1;
   Mashtab           := Trunc(100 * PixelsInOneSm/((1/LasFile.WellInf.Step)/MashtabCoef));
   if RadioGroup1.ItemIndex = 0 then coef := ((Printer.PageHeight/Printer.Canvas.font.PixelsPerInch)*SmPerInch)/29.5
                                else coef := 1;

   str1              := 'ОПЫТНО-КОНТРУКТОРСКОЕ БЮРО';
   str2              := 'ГЕОФИЗИЧЕСКОГО ПРИБОРОСТРОЕНИЯ';
   str3              := 'Наклонограмма' + ' 1 : ' + IntToStr(Mashtab);

   str4              := 'Статистики';
   str5              := 'Углы падения пластов   ( max = ';
   str6              := 'Азимуты падения пластов   ( max = ';

   str_              := 'Интерпретатор____________________________//';

   with Printer.Canvas do begin
        // -------- Верх титула --------
         Font.Size  := 16;
         Font.Name  := 'MS Sans Serif';
         Font.Style := [];
         if PrintType = Printing then TextOut((Printer.PageWidth - TextWidth(Str1)) div 2, Round(coef * TopBottomOffsetSm      *PixelsInOneSm)                   , str1);
         if PrintType = Printing then TextOut((Printer.PageWidth - TextWidth(Str2)) div 2, Round(coef * (TopBottomOffsetSm+0.3)*PixelsInOneSm + TextHeight(Str1)), str2);
        // -------- Центр --------------
         Font.Size  := 24;
         Font.Name  := 'MS Sans Serif';
         Font.Style := [fsBold];
         if PrintType = Printing then TextOut((Printer.PageWidth - TextWidth(Str3)) div 2, Round(coef * 9*PixelsInOneSm), str3);
        // ----------------------------
         Font.Size  := 12;
         Font.Name  := 'MS Sans Serif';
         Font.Style := [];

         Result := Round(coef * 15.5*PixelsInOneSm);                    if PrintType = Printing then TextOut(Trunc(3*PixelsInOneSm), Result, 'Площадь: ____________________' { + LasFile.WellInf.Field});
         Result := Result + TextHeight('O') + Round(0.2*PixelsInOneSm); if PrintType = Printing then TextOut(Trunc(3*PixelsInOneSm), Result, 'Скважина: ___________________'{ + LasFile.WellInf.Well});
         Result := Result + TextHeight('O') + Round(0.2*PixelsInOneSm); if PrintType = Printing then TextOut(Trunc(3*PixelsInOneSm), Result, 'Ном.диаметр, мм: ' + FloatToStrF(ReportClassParam.NominalDiametr, ffFixed, 20, 1));
         Result := Result + TextHeight('O') + Round(0.2*PixelsInOneSm); if PrintType = Printing then TextOut(Trunc(3*PixelsInOneSm), Result, 'Интервал, м: '     + FloatToStrF(LasFile.WellInf.Start, ffFixed, 20, 3) +' - '+FloatToStrF(LasFile.WellInf.Stop, ffFixed, 20, 3));
         Result := Result + TextHeight('O') + Round(0.2*PixelsInOneSm); if PrintType = Printing then TextOut(Trunc(3*PixelsInOneSm), Result, 'Дата каротажа: '   + LasFile.WellInf.Date);
         Result := Result + TextHeight('O') + Round(0.2*PixelsInOneSm); if PrintType = Printing then TextOut(Trunc(3*PixelsInOneSm), Result, 'Дата выдачи: ________________');
        // ----------------------------
        v1 := 14;
        v2 := 20;

        Rect1 := Rect(Printer.PageWidth - Trunc(8.5*PixelsInOneSm), Trunc(coef * v1*PixelsInOneSm), Printer.PageWidth - Trunc(1.5*PixelsInOneSm), Trunc(coef * (v1+4.5)*PixelsInOneSm));
        Rect2 := Rect(Printer.PageWidth - Trunc(8.5*PixelsInOneSm), Trunc(coef * v2*PixelsInOneSm), Printer.PageWidth - Trunc(1.5*PixelsInOneSm), Trunc(coef * (v2+4.5)*PixelsInOneSm));

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
       if PrintType = Printing then
           frmStatAnalysis.CalcAndDrawAlfaAndTetaGraphics(LasFile.WellInf.Start,
                                                          LasFile.WellInf.Stop,
                                                          14,
                                                          0,
                                                          -1,
                                                          0,
                                                          Printer.Canvas,
                                                          Printer.Canvas,
                                                          Rect1,
                                                          Rect2);

        if frmStatAnalysis.MaxAlfaAngle <> -999 then str5 := str5 + FloatToStrf(frmStatAnalysis.MaxAlfaAngle, ffFixed, 20, 1)
                                                else str5 := str5 + '----';
        if frmStatAnalysis.MaxTetaAngle <> -999 then str6 := str6 + FloatToStrf(frmStatAnalysis.MaxTetaAngle, ffFixed, 20, 1)
                                                else str6 := str6 + '----';

        Font.Size  := 13;
        Font.Name  := 'MS Sans Serif';
        Font.Style := [fsItalic];
        if PrintType = Printing then TextOut(Rect1.Left +  (Rect1.Right - Rect1.Left - TextWidth(str4)) div 2,  Rect1.Top - 2*TextHeight('O') - 2*Round(0.2*PixelsInOneSm) - Round(0.5*PixelsInOneSm), str4);

        Font.Size  := 10;
        Font.Name  := 'MS Sans Serif';
        Font.Style := [fsItalic];
        if PrintType = Printing then TextOut(Rect1.Left +  (Rect1.Right - Rect1.Left - TextWidth(str5)) div 2,  Rect1.Top -   TextHeight('O') -   Round(0.2*PixelsInOneSm), str5 + ' )');
        if PrintType = Printing then TextOut(Rect2.Left +  (Rect2.Right - Rect2.Left - TextWidth(str6)) div 2,  Rect2.Top -   TextHeight('O') -   Round(0.2*PixelsInOneSm), str6 + ' )');

        // -----------------------
        // -----------------------
         Font.Size  := 12;
         Font.Name  := 'MS Sans Serif';
         Font.Style := [];
         if PrintType = Printing then TextOut((Printer.PageWidth - TextWidth(str_)) div 2, Round(coef * 26.5*PixelsInOneSm), str_);
        // -------------------------
        Result := Round(coef * 27 *PixelsInOneSm) + TextHeight('O');
   end;
end;

{===============================================================================
}
procedure TfrmPrintReportOfWell.FillType_PrintParam(Offset : Integer);
var
 WidthNulPole : Integer;
begin
   if RadioGroup1.ItemIndex = 0 then offset := 0; // ---- Постраничная печать то смнщнние нулевое !!!

   WidthNulPole := Trunc(Printer.Canvas.Font.PixelsPerInch/SmPerInch*0.2);
   With PrintParam do begin
     PageWidth  :=  Printer.PageWidth;
     PageHeight :=  Printer.PageHeight;

     RealPageWidth  :=  Printer.PageWidth -  Trunc(Printer.Canvas.Font.PixelsPerInch/SmPerInch*(1.3+1));
     RealPageHeight :=  Printer.PageHeight - Trunc(Printer.Canvas.Font.PixelsPerInch/SmPerInch*(mmOffsetY + 15 + 10)/10) + Offset;

     BeginX := Trunc(Printer.Canvas.Font.PixelsPerInch/SmPerInch*1.3);
     BeginY := Trunc(Printer.Canvas.Font.PixelsPerInch/SmPerInch*(mmOffsetY+15)/10) + Offset;
     /////////////////////////
       DepthPole_BeginX      := BeginX;
       DepthPole_Width       := Round(15/210 * RealPageWidth);

       LitPole_BeginX        := DepthPole_BeginX + DepthPole_Width;
       LitPole_Width         := Round(9/210 * RealPageWidth);

       DopCurvesPole_BeginX  := LitPole_BeginX + LitPole_Width + WidthNulPole;
       DopCurvesPole_Width   := Round(57/210 * RealPageWidth);

       MidleRadiusPole_BeginX := DopCurvesPole_BeginX + DopCurvesPole_Width + WidthNulPole;
       MidleRadiusPole_Width  := Round(30/210 * RealPageWidth);

       GisPole_BeginX         := MidleRadiusPole_BeginX + MidleRadiusPole_Width + WidthNulPole;
       GisPole_Width          := Round(11/210 * RealPageWidth);

       GolovasticPole_BeginX := GisPole_BeginX + GisPole_Width + WidthNulPole;
       GolovasticPole_Width  := Round(40/210 * RealPageWidth);

       PrintParam.FreqPole_BeginX       := GolovasticPole_BeginX + GolovasticPole_Width + WidthNulPole;
       PrintParam.FreqPole_Width        := Trunc(PageWidth - FreqPole_BeginX - 0.5 * PixelsInOneSm) + 1;
   end;
end;

{===============================================================================
}
procedure TfrmPrintReportOfWell.OutTopCap(i, PageCount : integer; outPages : Boolean);
var
  Offset : Integer;
begin
   Offset := PrintParam.BeginY - Trunc(Printer.Canvas.Font.PixelsPerInch/SmPerInch*(mmOffsetY+15)/10);
   if Offset < 0 then offset := 0;

   Printer.Canvas.Font.Size  := 12;
   Printer.Canvas.Font.Name  := 'MS Sans Serif';
   Printer.Canvas.Font.Style := [];

   Printer.Canvas.MoveTo(PrintParam.BeginX, Offset + Trunc(0.4*PixelsInOneSm)); Printer.Canvas.LineTo(Printer.PageWidth - Trunc(0.55*PixelsInOneSm), Offset + Trunc(0.4*PixelsInOneSm));

   Printer.Canvas.TextOut(PrintParam.BeginX,  Offset + Trunc(0.55*PixelsInOneSm), '"ОКБ ГП"  программа  "Plastomer"');


   if outPages then Printer.Canvas.TextOut(Printer.PageWidth - Trunc(0.55*PixelsInOneSm) - Printer.Canvas.TextWidth('Стр.'+IntToStr(i+1)+'/'+intToStr(PageCount)),
                                           Offset + Trunc(0.5*PixelsInOneSm) + (Trunc(0.7*PixelsInOneSm) + 2*Printer.Canvas.TextHeight('0') - Trunc(0.5*PixelsInOneSm) - Printer.Canvas.TextHeight('0')) div 2, 'Стр.'+IntToStr(i+1)+'/'+intToStr(PageCount));

   Printer.Canvas.TextOut(PrintParam.BeginX, Offset + Trunc(0.6*PixelsInOneSm) + Printer.Canvas.TextHeight('0'), LasFile.FileName);

   Printer.Canvas.MoveTo(PrintParam.BeginX, Offset + Trunc(0.7*PixelsInOneSm) + 2*Printer.Canvas.TextHeight('0'));
   Printer.Canvas.LineTo(Printer.PageWidth - Trunc(0.55*PixelsInOneSm), Offset + Trunc(0.7*PixelsInOneSm) + 2*Printer.Canvas.TextHeight('0'));
end;

{===============================================================================
}
function TfrmPrintReportOfWell.OutBottomCap(CurYPos : Integer; ArrayIndexPerPage, DrawedArrayIndex : Integer; MashtabCoef : TFloat): integer;
var
  Lithography      : TLithography;
  Golovastic       : TGolovastic;
  OffsetX          : Integer;
  i                : Integer;
  x1, x2, y1, y2   : Integer;
  l                : Integer;
  TempStr          : String;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);
  Golovastic  := TGolovastic (ReportClass.PoleList.Items[5]);

  if CurYPos = -1 then CurYPos := PrintParam.BeginY + trunc(DrawedArrayIndex /MashtabCoef) + 1;
  Result  := -(PrintParam.BeginY + 0 + 1);

  OffsetX := PrintParam.DepthPole_BeginX + PrintParam.DepthPole_Width;
  if RadioGroup1.ItemIndex = 0 then
     if ArrayIndexPerPage <> -1 then
        if Printer.PageHeight - CurYPos < 2.0*PixelsInOneSm then begin
           Printer.NewPage;
           OutTopCap(PageCount, PageCount+1, true);
           CurYPos := PrintParam.BeginY - Trunc(1.5*PixelsInOneSm);
        end;
  // -------------------------------------------------
  // -------------------------------------------------
  // -------------------------------------------------
     if Length(Lithography.LayerArray) <> 0 then begin
        CurYPos := CurYPos + Trunc(0.5*PixelsInOneSm) + 1;

        Printer.Canvas.Font.Size  := 12;
        Printer.Canvas.Font.Name  := 'MS Sans Serif';
        Printer.Canvas.Font.Style := [fsBold];
        if ArrayIndexPerPage <> -1 then Printer.Canvas.TextOut(OffsetX, CurYPos, 'Литография'); CurYPos := CurYPos + Printer.Canvas.TextHeight('0') + Trunc(0.3*PixelsInOneSm) + 1;

        Printer.Canvas.Font.Size  := 11;
        Printer.Canvas.Font.Name  := 'MS Sans Serif';
        Printer.Canvas.Font.Style := [];
        for i := 0 to Length(Lithography.LayerArray) - 1 do begin
            Printer.Canvas.pen.Color   := clBlack;
            Printer.Canvas.pen.Style   := psSolid;
            Printer.Canvas.pen.Mode    := pmCopy;
            Printer.Canvas.Pen.Width   := 1;

            Printer.Canvas.Brush.Color := Lithography.LayerArray[i].LayerPenColor;
            Printer.Canvas.Brush.Style := TBrushStyle(Lithography.LayerArray[i].LayerBrushStyle);

            x1 := OffsetX + Trunc(0.5*PixelsInOneSm);
            y1 := CurYPos;
            x2 := OffsetX + Trunc((0.5+1.0)*PixelsInOneSm);
            y2 := CurYPos + Trunc(0.65*PixelsInOneSm);

            if ArrayIndexPerPage <> -1 then Printer.Canvas.Rectangle(x1, y1, x2, y2);

            Printer.Canvas.Brush.Color := clWhite;
            if ArrayIndexPerPage <> -1 then Printer.Canvas.TextOut(x2 + Trunc(0.4*PixelsInOneSm), y1 + (y2 - y1 - Printer.Canvas.TextHeight(Lithography.LayerArray[i].NameLayer)) div 2, '-  '+Lithography.LayerArray[i].NameLayer);

            CurYPos := y2 + Trunc(0.3*PixelsInOneSm);
            if RadioGroup1.ItemIndex = 0 then
               if Printer.PageHeight - CurYPos < 1.6*PixelsInOneSm then begin
                   if i = Length(Lithography.LayerArray) - 1 then break;
                   Printer.NewPage;
                   OutTopCap(PageCount, PageCount+1, true);
                   CurYPos := PrintParam.BeginY - Trunc(1.5*PixelsInOneSm);
               end;
        end;
     end;
  // -------------------------------------------------
  // -------------------------------------------------
  // -------------------------------------------------

  if RadioGroup1.ItemIndex = 0 then
     if ArrayIndexPerPage <> -1 then
        if Printer.PageHeight - CurYPos < 2.0*PixelsInOneSm then begin
           Printer.NewPage;
           OutTopCap(PageCount, PageCount+1, true);
           CurYPos := PrintParam.BeginY - Trunc(1.5*PixelsInOneSm);
        end;
  l := Trunc(0.65*PixelsInOneSm);
  if Length(MarkArray) <> 0 then begin
     CurYPos := CurYPos + Trunc(0.5*PixelsInOneSm) + 1;

     Printer.Canvas.Font.Size  := 12;
     Printer.Canvas.Font.Name  := 'MS Sans Serif';
     Printer.Canvas.Font.Style := [fsBold];
     if ArrayIndexPerPage <> -1 then Printer.Canvas.TextOut(OffsetX, CurYPos, 'Наклонограмма'); CurYPos := CurYPos + Printer.Canvas.TextHeight('0') + Trunc(0.3*PixelsInOneSm) + 1;

     Printer.Canvas.Font.Size  := 11;
     Printer.Canvas.Font.Name  := 'MS Sans Serif';
     Printer.Canvas.Font.Style := [];

     for i := 0 to Length(Golovastic.MinMaxArray) - 1 do begin
        Printer.Canvas.Brush.Color := ArrayGolovasticColor[i];
        Printer.Canvas.Brush.Style := bsSolid;

         l  := trunc(Golovastic.HolovasticRadius / 2/10*PixelsInOneSm);

         x1 := OffsetX + Trunc(0.5*PixelsInOneSm) + l;
         y1 := CurYPos + l;

         TempStr := '';
         if i = Length(Golovastic.MinMaxArray) - 1 then TempStr := '  ';

         if ArrayIndexPerPage <> -1 then Printer.Canvas.Ellipse(x1-l, y1-l, x1+l, y1+l);
         Printer.Canvas.Brush.Color := clWhite;
         if ArrayIndexPerPage <> -1 then Printer.Canvas.TextOut(x1 + l + Trunc(0.4*PixelsInOneSm), y1 - Printer.Canvas.TextHeight('0') div 2, '-  Достоверность пласта = ' + IntToStr(Golovastic.MinMaxArray[i].min) + TempStr + ' ..... ' + IntToStr(Golovastic.MinMaxArray[i].max)+'%');

         CurYPos := y1 + l + Trunc(0.3*PixelsInOneSm);
         if RadioGroup1.ItemIndex = 0 then
             if Printer.PageHeight - CurYPos < 1.6*PixelsInOneSm then begin
                 if i = Length(Golovastic.MinMaxArray) - 1 then break;
                 Printer.NewPage;
                 OutTopCap(PageCount, PageCount+1, true);
                 CurYPos := PrintParam.BeginY - Trunc(1.5*PixelsInOneSm);
             end;
     end;
  end;
  Result := Result + CurYPos + l;
//  Caption :=  IntToStr(CurYPos + Printer.PageHeight);
end;

{===============================================================================
Для работы процедуры нуно WinSpool}
procedure TfrmPrintReportOfWell.SetPrinterPageSizes(APageWidth,
  APageLength: Integer);
var
  AdeviceMode : THandle;
  hPrinter    : THandle;

  StubDevMode : TDeviceMode;
  NewDevMode  : ^TDeviceMode;
  ADevice, ADriver, APort : array[0..255] of Char;
begin
  Printer.GetPrinter( ADevice, ADriver, APort, AdeviceMode);
  if not OpenPrinter( ADevice, hPrinter, nil ) then
    raise EPrinter.Create( SysErrorMessage( GetLastError ));

  try
      AdeviceMode := GlobalAlloc( GHND,  DocumentProperties(0, hPrinter,ADevice, StubDevMode, StubDevMode, 0));
      NewDevMode  := GlobalLock (AdeviceMode);

      DocumentProperties( 0, hPrinter, ADevice, NewDevMode^,NewDevMode^,DM_OUT_BUFFER);
      try
        NewDevMode.dmFields      := DM_ORIENTATION or DM_PAPERSIZE or DM_PAPERLENGTH or DM_PAPERWIDTH;
        NewDevMode.dmOrientation := DMORIENT_PORTRAIT; //DMORIENT_LANDSCAPE; //
        NewDevMode.dmPaperSize   := DMPAPER_USER;
        NewDevMode.dmPaperLength := APageLength;
        NewDevMode.dmPaperWidth  := APageWidth;

        DocumentProperties( self.handle, hPrinter, ADevice, NewDevMode^, NewDevMode^, DM_IN_BUFFER {or DM_IN_prompt} or DM_OUT_BUFFER);
      finally
        GlobalUnlock(AdeviceMode);
      end;
      Printer.SetPrinter( ADevice, ADriver, APort, AdeviceMode);
  finally
    ClosePrinter( hPrinter );
  end;
end;

procedure TfrmPrintReportOfWell.bbPrintReportOfWellClick(Sender: TObject);
var
  BeginPageDepthIndex : Integer;
  EndPageDepthIndex   : Integer;
  ArrayIndexPerPage   : Integer;
  RealPageCount       : Integer;

  i                   : Integer;

  LegentHeight        : Integer;
  HeadHeight          : Integer;

  PageHeightInPixel   : Integer;

begin
  if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then begin
        Printer.Canvas.TextHeight('O'); // ---- Нуно для правильной инициализации (Printer.Canvas.Font.PixelsPerInch)
        if PrintDialog1.Execute then begin
                  Printer.Title     := 'Plastomer v1.0 - Печать наклонограммы';
                  PixelsInOneSm     := Printer.Canvas.Font.PixelsPerInch/SmPerInch;  // --- Количество пикселей в одном сантиметре принтера ---
                  MashtabCoef       := ReportClass.ImageCanvas.Font.PixelsPerInch/Printer.Canvas.Font.PixelsPerInch*ReportClass.MashtabCoef;
                  EndPageDepthIndex := 0;      // ---- Конечная глубина на листе бумаги -----------
                  HeadHeight        := PrintHeadPaper(NotPrinting);
                  LegentHeight      := OutBottomCap(-1, -1, 0, 1);                   // --- Определений Высоты Легенду в пикселях -------
                  // ---------------------
                  if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then  FillType_PrintParam(HeadHeight);   // --- Растановка Позиций полей ------
                 // ---------------------

                  /////////////////////////////////////////////////////
                  ///////     РУЛОННАЯ ПЕЧАТЬ /////////////////////////
                  /////////////////////////////////////////////////////
                  if RadioGroup1.ItemIndex <> 0 then begin
                        PageHeightInPixel := PrintParam.BeginY +
                                             Trunc(LasFile.XValue.Count/MashtabCoef) +
                                             LegentHeight; // + Trunc(2*PixelsInOneSm);

                        if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then  SetPrinterPageSizes(Printer.PageWidth, PageHeightInPixel);
                        // ---------

                        Printer.BeginDoc;
                              if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPageReportOfWell(Printer.Canvas, MashtabCoef, 0, LasFile.XValue.Count);
                              if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintHeadPaper       (Printing);
                              if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then OutTopCap            (0, 0, false);
                              if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then OutBottomCap         (PrintParam.BeginY + Trunc(LasFile.XValue.Count/MashtabCoef), 0, 0, MashtabCoef);
                        Printer.EndDoc;
                  end else begin
                        Printer.BeginDoc;
                              if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintHeadPaper(Printing);                                              // --- Печать титульного листа отчета                  ---
                              if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then Printer.NewPage;
                              /////////////////////////////////////////////////////
                              //////     Постраничная печать //////////////////////
                              /////////////////////////////////////////////////////
                              PageCount           := Trunc((LasFile.XValue.Count/MashtabCoef)/PrintParam.RealPageHeight) + 1;
                              RealPageCount       := Trunc((LasFile.XValue.Count/MashtabCoef + LegentHeight{8.6*PixelsInOneSm})/PrintParam.RealPageHeight) + 1;
                              ArrayIndexPerPage   := Trunc(PrintParam.RealPageHeight * MashtabCoef);
                              BeginPageDepthIndex := 0;
                              // ---------------------
                              for i := 0 to PageCount - 1 do begin
                                    EndPageDepthIndex   := BeginPageDepthIndex + ArrayIndexPerPage;
                                    if EndPageDepthIndex   > LasFile.XValue.Count then EndPageDepthIndex := LasFile.XValue.Count;
                                    // ----------------------------------
                                       if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then PrintPageReportOfWell(Printer.Canvas, MashtabCoef, BeginPageDepthIndex, EndPageDepthIndex);
                                       if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then OutTopCap(i, RealPageCount, true);
                                    // ----------------------------------
                                    BeginPageDepthIndex := BeginPageDepthIndex + ArrayIndexPerPage;
                                    if i <> PageCount - 1 then Printer.NewPage;
                              end;
                              if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then OutBottomCap(-1, ArrayIndexPerPage,(EndPageDepthIndex - (BeginPageDepthIndex - ArrayIndexPerPage)), MashtabCoef);
                        Printer.EndDoc;
                  end;
        end;
   end;
   Close;
end;

procedure TfrmPrintReportOfWell.RadioGroup1Click(Sender: TObject);
begin
 if RadioGroup1.ItemIndex = 0 then CheckBox1.Enabled := true
                              else CheckBox1.Enabled := false;
end;

end.
