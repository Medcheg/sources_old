unit Unit_PrintPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers, WinSpool;

const FontSize  = 12;

type
  TPos = record
    x1, x2, y1, y2, y3 : integer;
  end;

  TfrmPrintPreview = class(TForm)
    ScrollBar1: TScrollBar;
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    HeadBitmap             : TBitmap;
    MaxVisiblePlanshetTime : Double;
    pa                     : array [1..3] of TPos;
    CountShot              : LongInt;
    MaxHeadingWidth        : Integer;
    FontBitmap             : TBitmap;
    StretchBitmap          : TBitmap;
    PaintBitmap            : TBitmap;
    MashtabCoef            : Double;
    DocHeight              : Integer;
    ExceptError            : Boolean;


    procedure DrawHeadingOfDiagramm(myCanvas : TCanvas; offset : integer;FontS : Integer;var MaxHeadingWidth  : Integer);
    function  Get_WidthDocument(MyCanvas : TCanvas):Integer;
    procedure SetPrinterPageSizes(APageWidth, APageLength: Integer);
    procedure RotateTextBitmapToPrinter(MyCanvas : TCanvas;outString : String;x, y, FontS : Integer; fontC : TColor);
    procedure Get_ArrayPosPolesInPlanshet(HeadingOffset, H, poleWidth : Integer);


  public
    procedure PrintingDocument(myCanvas : TCanvas);
    procedure PrintDocument();

  end;

var
  frmPrintPreview: TfrmPrintPreview;

implementation

uses Unit_HeadingOfTheDiagram, Unit_PlanshetParam, Unit_Main, MPIDeclaration, Unit_SaveType;

{$R *.DFM}

//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.FormCreate(Sender: TObject);
begin
  StretchBitmap                 := TBitmap.Create;
  FontBitmap                    := TBitmap.Create;
  PaintBitmap                   := TBitmap.Create;
  StretchBitmap.PixelFormat     := pf4Bit;
  PaintBitmap  .PixelFormat     := pf4Bit;
  FontBitmap.Width              := 300;
  FontBitmap.Height             := 300;
  ExceptError                   := False;

  FontBitmap.Canvas.brush.Color := clWhite;
  FontBitmap.Canvas.Font.Size   := FontSize;
  FontBitmap.Canvas.TextOut(0,0,'FontSize');
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.FormDestroy(Sender: TObject);
begin
  FontBitmap   .Free;
  StretchBitmap.Free;
  PaintBitmap  .Free;
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.FormPaint(Sender: TObject);
begin
  if MaxVisiblePlanshetTime < 0 then close;
  if ExceptError                then close;

  Cursor := crHourGlass;
  //-----------------------------------
  if not ExceptError then Canvas.Draw(-ScrollBar1.Position, 0, PaintBitmap);
  //-----------------------------------
  Cursor := crDefault;
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.FormResize(Sender: TObject);
begin
//  FormShow(nil);
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.FormShow(Sender: TObject);
begin
    Width  := 2000;
    Height := 2000;
    CountShot           := 0;
    MaxVisiblePlanshetTime :=  form1.MaxPlanshetTime - form1.MinPlanshetTime;
    if MaxVisiblePlanshetTime < 0 then begin
      beep;
      MessageDlg ('Загрузите данные на планшет', mtInformation, [mbOk], 0);
      exit;
    end;

    if not ExceptError then begin
        frmHeadingOfTheDiagram.AutoSize   := True;
        frmHeadingOfTheDiagram.AutoScroll := False;
        frmHeadingOfTheDiagram.Width      := 689;
        HeadBitmap                        := frmHeadingOfTheDiagram.GetFormImage;
        HeadBitmap.PixelFormat            := pf1Bit;
        DocHeight                         := (ClientHeight - ScrollBar1.Height);
        MashtabCoef                       := DocHeight/HeadBitmap.Height;
        //--------------------------------------------------------------
        StretchBitmap.Width  := trunc(HeadBitmap.Width*MashtabCoef*0.97);
        StretchBitmap.Height := trunc(DocHeight*0.97);

        StretchBitmap.Canvas.Brush.Color := clWhite;
        StretchBitmap.Canvas.FillRect(rect(0,0,StretchBitmap.Width, StretchBitmap.Height));
        StretchBitmap.Canvas.StretchDraw(rect(Trunc(HeadBitmap.Width*MashtabCoef*0.03),
                                              Trunc(DocHeight*0.03),
                                              Trunc(HeadBitmap.Width*MashtabCoef*0.97),
                                              Trunc(DocHeight*0.97)), HeadBitmap);
        //--------------------------------------------------------------
        if Sender <> nil then begin
            PaintBitmap.Width := Get_WidthDocument(PaintBitmap.Canvas);
            //PaintBitmap.Width := 2000;
        end;
    end;

    PaintBitmap.Height := ClientHeight;

    PaintBitmap.Canvas.brush.Color := clWhite;
    PaintBitmap.Canvas.brush.Style := bsSolid;
    PaintBitmap.Canvas.FillRect(rect(0,0,PaintBitmap.Width, PaintBitmap.Height));

    try
      if not ExceptError then PrintingDocument(PaintBitmap.Canvas);
    except
       on EOutofResources do begin
           MessageDlg('Предварительный просмотр не возможен, чтоб его произвести увеличьте параметр "Масштаб времени [мин/см]"', mtError, [mbOk],0);
           ExceptError := true;
      end;
    end;

    ScrollBar1Change(Self);
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.ScrollBar1Change(Sender: TObject);
begin
  Cursor := crHourGlass;
  //-----------------------------------
  if not ExceptError then Canvas.Draw(-ScrollBar1.Position, 0, PaintBitmap);
  //-----------------------------------
  Cursor := crDefault;
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.RotateTextBitmapToPrinter(MyCanvas: TCanvas;
   outString: String; x, y, FontS: Integer; fontC : TColor);
var
 i, k : integer;
 TextW, TextH : Integer;
 Coef         : Double;
begin
  Coef := MyCanvas.Font.PixelsPerInch / Form1.Font.PixelsPerInch;

  if DocHeight < 1000 then FontBitmap.Canvas.Font.Size  := FontSize
                      else FontBitmap.Canvas.Font.Size  := Trunc(FontSize*Coef) + 1;
  FontBitmap.Canvas.Font.Style := MyCanvas.Font.Style;
  FontBitmap.Canvas.Font.Color := fontC;
  FontBitmap.Canvas.Pen.Color  := MyCanvas.Pen.Color;

  TextW := FontBitmap.Canvas.TextWidth (OutString);
  TextH := FontBitmap.Canvas.TextHeight(OutString);

  FontBitmap.Width  := TextW+4;
  FontBitmap.Height := TextH+4;

  // -----  Очистка Фонт Битмапа ---------
  if fontC = clWhite then begin
    FontBitmap.Canvas.brush.Color := clBlack;
    FontBitmap.Canvas.brush.Style := bsSolid;
    FontBitmap.Canvas.FillRect(Rect(0,0,FontBitmap.Width, FontBitmap.Height));
  end else begin
    FontBitmap.Canvas.brush.Color := clWhite;
    FontBitmap.Canvas.brush.Style := bsSolid;
    FontBitmap.Canvas.FillRect(Rect(0,0,FontBitmap.Width, FontBitmap.Height));
  end;
  // -----  Вывод текста на Фонт Битмапа ---------
  FontBitmap.Canvas.TextOut(0,4,OutString);
  Application.ProcessMessages;

    for i:=0 to FontBitmap.Width - 1 do
    for k:=0 to FontBitmap.Height - 1 do
        MyCanvas.pixels[x+k, y-i] := FontBitmap.Canvas.pixels[i,k];


{  FontBitmap.Canvas.brush.Color := clWhite;
  FontBitmap.Canvas.brush.Style := bsSolid;
  FontBitmap.Canvas.FillRect(Rect(0,0,FontBitmap.Width, FontBitmap.Height));
  FontBitmap.Canvas.FillRect(Rect(0,0,FontBitmap.Width, FontBitmap.Height));}
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.DrawHeadingOfDiagramm(myCanvas : TCanvas; offset : integer;FontS : Integer;var MaxHeadingWidth  : Integer);
var
 i,k              : integer;
 HeadingWidth     : integer;
 MyTextHeight     : Integer;
 MySeries         : TMySeries;
 TempPosX         : Integer;
 TempPosY         : Integer;
 outText          : String;

begin
   MyCanvas.Font.Size  := FontS;
   MyCanvas.Font.Style := [];
   MyTextHeight := MyCanvas.TextHeight('0');
   MaxHeadingWidth := -1000000;
   With myCanvas do begin
     for k:=1 to frmPlanshetParam.sePoleCount.value do begin
              myCanvas.Pen.Width := 2;
              myCanvas.Pen.Color := clBlack;

              HeadingWidth := (Form1.SeriesList[k].Count)*MyTextHeight*2 + MyTextHeight;

              if MaxHeadingWidth < HeadingWidth then MaxHeadingWidth := HeadingWidth;

              MoveTo(offset               , pa[k].y1);
              LineTo(offset + HeadingWidth, pa[k].y1);

              MoveTo(offset               , pa[k].y2);
              LineTo(offset + HeadingWidth, pa[k].y2);

              for i:= 0 to Form1.SeriesList[k].Count - 1 do begin
                  MySeries := TMySeries(Form1.SeriesList[k].Items[i]);

                  Pen.Color := MySeries.PenColor;
                  Pen.Width := MySeries.PenWidth;
                  Pen.Style := MySeries.PenStyle;

                  MoveTo(offset + (i+1)*MyTextHeight*2, pa[k].y1);
                  LineTo(offset + (i+1)*MyTextHeight*2, pa[k].y2);

                  // --- Вывожу надписи ----
                  TempPosX := offset + (i+1)*MyTextHeight*2 - MyTextHeight - MyTextHeight div 5;
                  TempPosY :=  pa[k].y1 + (pa[k].y2 - pa[k].y1 + TextWidth(MySeries.Name)) div 2;
                  //RotateLabel(MyCanvas,MySeries.Name,TempPosX-2, TempPosY,90);
                  MyCanvas.Font.Size  := FontS;
                  RotateTextBitmapToPrinter(MyCanvas,MySeries.Name,TempPosX-2, TempPosY,FontS,clBlack);

                  OutText := floatToStrF(MySeries.min, ffFixed, 9,3);
                  //RotateLabel(MyCanvas, OutText, TempPosX-2, pa[k].y2 - 5, 90);
                  MyCanvas.Font.Size  := FontS;
                  RotateTextBitmapToPrinter(MyCanvas, OutText, TempPosX-2, pa[k].y2 - 5, FontS,clBlack);

                  OutText := floatToStrF(MySeries.max, ffFixed, 9,3);
                  //RotateLabel(MyCanvas, OutText, TempPosX-2, pa[k].y1 + 5 + MyCanvas.TextWidth(OutText), 90);
                  MyCanvas.Font.Size  := FontS;
                  RotateTextBitmapToPrinter(MyCanvas, OutText, TempPosX-2, pa[k].y1 + 5 + MyCanvas.TextWidth(OutText), FontS,clBlack);
              end;
            end; // --- for k:=1 to frmPlanshetParam.sePoleCount.value do begin
   end; // --- With PaintBox1.Canvas do begin ---

   MaxHeadingWidth := MaxHeadingWidth + MyTextHeight*2;
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.Get_ArrayPosPolesInPlanshet(HeadingOffset, H, poleWidth : Integer);
var
 a,b,c   : Double;
 i       : Integer;
 nullPos : Double;
begin
  a := 0.063918918919*H;
  b := H - 2*a;
  c := b / frmPlanshetParam.sePoleCount.value;

  for i:=1 to frmPlanshetParam.sePoleCount.value do begin
      pa[i].x1 := HeadingOffset;
      pa[i].x2 := HeadingOffset + PoleWidth;

      nullPos   :=  a + (i-1)*c;
      pa[i].y1 :=  trunc(nullPos  + c * 0.05555555555555555555555);
      pa[i].y2 :=  trunc(pa[i].y1 + c * 0.85555555555555555555555);
      pa[i].y3 :=  trunc(a + i*c);
  end;
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.PrintingDocument(myCanvas: TCanvas);
var
  i,k,n       : Integer;
  PolesCount  : byte;
  RealHeightDocument                : Double;

  TimeBeetwenMainVerticalLine       : Double;
  CountSmBeetwenMainVerticalLine    : Double;
  CountInchBeetwenMainVerticalLine  : Double;
  CountPixelBeetwenMainVerticalLine : Double;
  CountVerticalMainLine             : Double;

  CountPixelBeetwenMainHorizontalLine : Double;
  CountHorizontalMainLine             : Double;

  // --- Temp Value ---
  FirstPointX, SecondPointX           : Double;
  FirstPointY, SecondPointY           : Double;
  StepMinorGrid                       : Double;
  UpPositionTextX, DownPositionTextX  : Double;
  UpPositionTextY, DownPositionTextY  : Double;
  TimeInOnePixel                      : Double;
  TopTime                             : String;
  BottomTime                          : String;
  MySeries                            : TMySeries;
  MyLegend                            : TLegend;
  MyCaption                           : TMyCaption;
  NormalizeCoef                       : Double;
  OffsetY                             : Double;

  PoleWidth                           : Integer;
  MinDrawPlanshetTime                 : TDateTime;

  PixelsOneSantimetr                  : Integer;
  PointSeriesPosition                 : Integer;
  OldPointSeriesPosition              : Integer;

  // -----------------------------------------------------
  MyLine                              : Array  of TPoint;
  CurPointCoord                       : TPoint;
  CountPoint                          : Integer;
  // -----------------------------------------------------
  fStartpos                           : TPoint;
  fEndpos                             : TPoint;
  TextPos                             : TPoint;
  BoxRect                             : TRect;
  OffsetValue                         : Integer;
  TempValue                           : TPoint;
  TempPos                             : TPoint;
  HeightText                          : Integer;
  WidthText                           : Integer;
  CenterBox                           : TPoint;
  x1, x2                              : Integer;
  y1, y2                              : Integer;


begin
  MashtabCoef        := DocHeight/HeadBitmap.Height;
  PolesCount         := frmPlanshetParam.sePoleCount.value;
  PixelsOneSantimetr := Trunc(myCanvas.Font.PixelsPerInch/SmPerInch);
  PoleWidth          := 0;
  MaxHeadingWidth    := 0;

  With myCanvas do begin
    // ---- Отрисовал заголовок диаграммы ---------------
      MyCanvas.Draw(0,0,StretchBitmap);
    // --- Вичисляю Горизонтальной оси ------
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      Get_ArrayPosPolesInPlanshet(StretchBitmap.Width + (3)*PixelsOneSantimetr + MaxHeadingWidth , DocHeight, poleWidth);
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      TimeBeetwenMainVerticalLine       := ChartParam.MaxVisibleTimeOnChart / (100/ChartParam.BottomAxis_GridStep);
      CountSmBeetwenMainVerticalLine    := TimeBeetwenMainVerticalLine        / ChartParam.CountMinInOneSantimetr / TimeInOneSecond /60;
      CountInchBeetwenMainVerticalLine  := CountSmBeetwenMainVerticalLine     / SmPerInch;
      CountPixelBeetwenMainVerticalLine := CountInchBeetwenMainVerticalLine   * myCanvas.Font.PixelsPerInch;
      CountVerticalMainLine             := MaxVisiblePlanshetTime             / TimeBeetwenMainVerticalLine;
      poleWidth                         := Trunc(CountPixelBeetwenMainVerticalLine * CountVerticalMainLine);
      TimeInOnePixel                    := MaxVisiblePlanshetTime / (poleWidth);
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //  -------------------    Zagolovok Diagrammy      -------------------------
      DrawHeadingOfDiagramm(myCanvas,  StretchBitmap.Width + 1*PixelsOneSantimetr                                , FontSize, MaxHeadingWidth);
      DrawHeadingOfDiagramm(myCanvas,  StretchBitmap.Width + 2*PixelsOneSantimetr + MaxHeadingWidth + poleWidth  , FontSize, MaxHeadingWidth);
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      Get_ArrayPosPolesInPlanshet(StretchBitmap.Width + 1*PixelsOneSantimetr + MaxHeadingWidth , DocHeight, poleWidth);
      UpPositionTextY    := DocHeight*0.05;
      DownPositionTextY  := DocHeight*0.95;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      pen.Color := clBlack;

      x1 := pa[1].x2 + 1*PixelsOneSantimetr + MaxHeadingWidth;
      y1 := pa[PolesCount].y1;
      y2 := pa[PolesCount].y2;
      x2 := pa[1].x2 + 1*PixelsOneSantimetr + MaxHeadingWidth + 3 * PixelsOneSantimetr + PixelsOneSantimetr div 10;
      Rectangle(x1, pa[1].y1, x2, pa[PolesCount].y2);

      MyCanvas.font.Size  := FontSize;
      MyCanvas.font.Style := [fsBold, fsItalic];
      MyCanvas.font.Color := clBlack;
      RotateTextBitmapToPrinter(MyCanvas,'Режимы работы скважины',x1 + PixelsOneSantimetr div 10, y2 - PixelsOneSantimetr div 2,FontSize,clBlack);

      MyCanvas.font.Size  := FontSize;
      MyCanvas.font.Style := [];
      MyCanvas.font.Color := clBlack;

      x1 := x1 + 2 * PixelsOneSantimetr div 10 + MyCanvas.TextHeight('0');
      y2 := y2 -     PixelsOneSantimetr;
      brush.Color := clBlack;
      brush.Style := bsVertical;
      Rectangle(rect(x1  , y2 - PixelsOneSantimetr    , x1 + PixelsOneSantimetr   , y2   ));
      RotateTextBitmapToPrinter(MyCanvas,'Свабирование, востан. уровня', x1 + (PixelsOneSantimetr - MyCanvas.TextHeight('0')) div 2, y2 - PixelsOneSantimetr - PixelsOneSantimetr div 2,FontSize,clBlack);

      brush.Style := bsBDiagonal;
      x1 := x1 + 2 * PixelsOneSantimetr div 10 + PixelsOneSantimetr;
      Rectangle(rect(x1  , y2 - PixelsOneSantimetr     , x1 + PixelsOneSantimetr   , y2   ));
      RotateTextBitmapToPrinter(MyCanvas,'Свабирование', x1 + (PixelsOneSantimetr - MyCanvas.TextHeight('0')) div 2, y2 - PixelsOneSantimetr - PixelsOneSantimetr div 2,FontSize,clBlack);
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      brush.Color := clBlack;
      brush.Style := bsSolid;
      x1 := x2 + PixelsOneSantimetr div 10;
      Rectangle(rect(x1 , 0, x1 + PixelsOneSantimetr   , DocHeight));

      MyCanvas.font.Size  := FontSize-2;
      MyCanvas.font.Style := [];
      MyCanvas.font.Color := clWhite;

      x1 := x1 + (PixelsOneSantimetr - MyCanvas.TextHeight('0')) div 2;
      y1 := DocHeight - (DocHeight - MyCanvas.TextWidth('КОНЕЦ ДИАГРАММЫ')) div 2;
      RotateTextBitmapToPrinter(MyCanvas,'КОНЕЦ ДИАГРАММЫ', x1, y1,MyCanvas.font.Size, clWhite);
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      MyCanvas.font.Size  := FontSize;
      MyCanvas.font.Style := [];
      MyCanvas.font.Color := clBlack;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      if (CountShot = 0) then begin
        //ScrollBar1.Max         := trunc(pa[1].x2 + 2*PixelsOneSantimetr + MaxHeadingWidth  +  + 0 +  2*PixelsOneSantimetr - 1024);
        ScrollBar1.Max         := trunc(x2+ 0 +  2*PixelsOneSantimetr - 1024);
        PaintBitmap.Width      := ScrollBar1.Max + 1024;
        ScrollBar1.LargeChange := Trunc(ScrollBar1.Max/30);
        inc(CountShot);
      end;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ---- Отрисовал ПРЯМОУГОЛЬНИКИ ПОЛЕЙ  ---------------
    for i:=1 to PolesCount do begin
      Pen.Color   := clBlack;
      Pen.Style   := psSolid;
      Pen.Width   := 1;
      brush.Color := clwhite;
      brush.Style := bsSolid;

      Rectangle(pa[i].x1, pa[i].y1, pa[i].x2, pa[i].y2);

      MoveTo(pa[i].x1, pa[i].y3);
      LineTo(pa[i].x2, pa[i].y3);
    end;

    for i:=1 to PolesCount do
        for k := 0 to {trunc(CountVerticalMainLine)}Round(CountVerticalMainLine)-1 do begin
           // --- Отрисовка Основных Вертикальных линий -----
           Pen.Color   := ChartParam.MainLine_PenColor;
           Pen.Style   := ChartParam.MainLine_PenStyle;
           Pen.Width   := 1;

           FirstPointX := pa[i].x1 + k*CountPixelBeetwenMainVerticalLine;

           MoveTo(trunc(FirstPointX), pa[i].y1);
           LineTo(trunc(FirstPointX), pa[i].y2);
           if i = 1 then begin
              MoveTo(trunc(FirstPointX), trunc(pa[i].y1 - DocHeight*0.008));
              LineTo(trunc(FirstPointX), pa[i].y1);
           end;
           if i = PolesCount then begin
              MoveTo(trunc(FirstPointX), pa[i].y3);
              LineTo(trunc(FirstPointX), trunc(pa[i].y3 + DocHeight*0.008));
           end;
           //++++++++++++++++++++++++++++++++++++++++++++++++
           // --- Подписи времени Верха - Низа --------------
           if i = 1 then begin
                 SecondPointX := k*CountPixelBeetwenMainVerticalLine;
                 MyCanvas.Font.Size := FontSize; //Trunc(FontSize*MashtabCoef) - 1;
                 MyCanvas.Font.Style := [];
                 MyCanvas.Pen.Color := clBlack;

                 if (k=0) or (trunc(Form1.MinPlanshetTime + TimeInOnePixel*SecondPointX) <>
                    trunc(Form1.MinPlanshetTime + TimeInOnePixel*(SecondPointX-CountPixelBeetwenMainVerticalLine))) then begin
                       TopTime := DateToStr(Form1.MinPlanshetTime + TimeInOnePixel*SecondPointX);
                       UpPositionTextX  := FirstPointX - myCanvas.TextWidth(TopTime) div 2;
                       MyCanvas.TextOut(Trunc(UpPositionTextX  ), Trunc(UpPositionTextY - DocHeight*0.025), TopTime);
                 end;

                 TopTime          := TimeToStr(Form1.MinPlanshetTime + TimeInOnePixel*SecondPointX);
                 UpPositionTextX  := FirstPointX - myCanvas.TextWidth(TopTime) div 2;
                 MyCanvas.TextOut(Trunc(UpPositionTextX  ), Trunc(UpPositionTextY  ), TopTime);

                 BottomTime   := TimeToStr(TimeInOnePixel*SecondPointX);
                 DownPositionTextX  := FirstPointX - myCanvas.TextWidth(BottomTime) div 2;
                 MyCanvas.TextOut(Trunc(DownPositionTextX), Trunc(DownPositionTextY), BottomTime);
           end;
           // --- Отрисовка Вспомогательных Вертикальных линий если нуно-----
           //++++++++++++++++++++++++++++++++++++++++++++++++
           MyCanvas.Pen.Color := clBlack;
           if ChartParam.BottomAxis_MinorGridStep <> 0 then begin
             StepMinorGrid := CountPixelBeetwenMainVerticalLine / (ChartParam.BottomAxis_MinorGridStep+1);
             n := 1;
             While n*StepMinorGrid < CountPixelBeetwenMainVerticalLine do begin
               Pen.Color   := ChartParam.NotMainLine_PenColor;
               Pen.Style   := ChartParam.NotMainLine_PenStyle;

               SecondPointX    := FirstPointX + n*StepMinorGrid;

               MoveTo(Round(SecondPointX), pa[i].y1+1);
               LineTo(Round(SecondPointX), pa[i].y2-1);
               inc(n);
             end;
           end;
        end;
    // --- Отрисовка Основных горизонтальных линий -----
    MyCanvas.Pen.Color := clBlack;
    for i:=1 to PolesCount do begin
        CountPixelBeetwenMainHorizontalLine := (pa[i].y2 - pa[i].y1) / Trunc(100/ChartParam.LeftAxis_GridStep);
        CountHorizontalMainLine             := 100/(ChartParam.LeftAxis_GridStep);
        for k := 0 to trunc(CountHorizontalMainLine)-1 do begin
           Pen.Color   := ChartParam.MainLine_PenColor;
           Pen.Style   := ChartParam.MainLine_PenStyle;

           FirstPointY  := pa[i].y1 + k*CountPixelBeetwenMainHorizontalLine;
           FirstPointX  := pa[i].x1;
           SecondPointX := pa[i].x1 + PoleWidth;

           MoveTo(Round(FirstPointX ), trunc(FirstPointY));
           LineTo(Round(SecondPointX), trunc(FirstPointY));
           // --- Отрисовка Вспомогательных Вертикальных линий если нуно-----
           if ChartParam.leftAxis_MinorGridStep <> 0 then begin
             StepMinorGrid := CountPixelBeetwenMainHorizontalLine / (ChartParam.LeftAxis_MinorGridStep+1);
             n := 1;
             While n*StepMinorGrid < CountPixelBeetwenMainHorizontalLine do begin
               Pen.Color    := ChartParam.NotMainLine_PenColor;
               Pen.Style    := ChartParam.NotMainLine_PenStyle;

               SecondPointY := FirstPointY  + n*StepMinorGrid;

               MoveTo(trunc(FirstPointX )+1, trunc(SecondPointY));
               LineTo(trunc(SecondPointX)-1, trunc(SecondPointY));
               inc(n);
             end;
           end;
        end;
    end; // --- for i:=1 to PolesCount do
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////// --- Отрисовка серий ----/////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    MyCanvas.Pen.Color := clBlack;
    MinDrawPlanshetTime :=  StrToTime(TimeToStr(Form1.MinPlanshetTime - Trunc(Form1.MinPlanshetTime)));
    for k:=1 to PolesCount do begin
        for i:= 0 to Form1.SeriesList[k].Count - 1 do begin
           MySeries      := TMySeries(Form1.SeriesList[k].Items[i]);
           NormalizeCoef := (pa[k].y2  - pa[k].y1) / (MySeries.Max - MySeries.Min);
           OffsetY       :=  - MySeries.Min * NormalizeCoef;

           MyCanvas.pen.Color := MySeries.PenColor;
           MyCanvas.pen.Width := MySeries.PenWidth;
           MyCanvas.Pen.Style := MySeries.PenStyle;

           // ------------- Определяем количество точек для массива данных ------
           OldPointSeriesPosition := trunc(pa[k].x1 + 1 + (MySeries.TimeData[0] + MySeries.StartDateTime - Form1.MinPlanshetTime)/TimeInOnePixel);
           CountPoint             := 0;
           for n := 0 to MySeries.CountData - 1 do begin
               PointSeriesPosition := trunc(pa[k].x1 + 1 + (MySeries.TimeData[n] + MySeries.StartDateTime - Form1.MinPlanshetTime)/TimeInOnePixel);
               if OldPointSeriesPosition <> PointSeriesPosition then begin
                 OldPointSeriesPosition := PointSeriesPosition;
                 inc(CountPoint);
               end;
           end;
           SetLength(MyLine, CountPoint);
           // ------------- Отрисовую серии  ------
           OldPointSeriesPosition := trunc(pa[k].x1 + 1 + (MySeries.TimeData[0] + MySeries.StartDateTime - Form1.MinPlanshetTime)/TimeInOnePixel);
           CountPoint             := 0;
           for n := 0 to MySeries.CountData - 1 do begin
               PointSeriesPosition := trunc(pa[k].x1 + 1 + (MySeries.TimeData[n] + MySeries.StartDateTime - Form1.MinPlanshetTime)/TimeInOnePixel);
               if OldPointSeriesPosition <> PointSeriesPosition then begin
                  CurPointCoord.x    := trunc(pa[k].x1 + 1 + (MySeries.TimeData[n] + MySeries.StartDateTime - Form1.MinPlanshetTime)/TimeInOnePixel);
                  CurPointCoord.y    := pa[k].y2 - trunc(MySeries.Data[n]*NormalizeCoef + OffsetY);
                  MyLine[CountPoint] := CurPointCoord;
                  OldPointSeriesPosition := PointSeriesPosition;
                  inc(CountPoint);
               end;
           end;

           MyCanvas.Polyline(MyLine);
        end;
     end;
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////// --- Отрисовка Легенд  ----///////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    MyCanvas.Pen.Color := clBlack;
    for k:=1 to PolesCount do begin
        for i:= 0 to Form1.LegendList[k].Count - 1 do begin
           MyLegend    := TLegend(Form1.LegendList[k].Items[i]);
           pen.Color   := clBlack;
           pen.Style   := psSolid;
           pen.Mode    := pmCopy;
           Pen.Width   := 1;
           Brush.Color := clBlack;
           Brush.Style := MyLegend.BrushStyle;

           Rectangle (pa[k].x1 + Trunc((MyLegend.StartTimePos - Form1.MinPlanshetTime)/TimeInOnePixel),
                      pa[k].y2+1,
                      pa[k].x1 + Trunc((MyLegend.EndTimePos - Form1.MinPlanshetTime)/TimeInOnePixel),
                      pa[k].y3-1);
        end;
    end;
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////// --- Отрисовка Надписи ----///////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    MyCanvas.Pen.Color := clBlack;
    for k:=1 to PolesCount do begin
        for i:= 0 to Form1.CaptionList[k].Count - 1 do begin
           MyCaption := TMyCaption(Form1.CaptionList[k].Items[i]);

           MyCanvas.Pen.Color   := clBlack;
           MyCanvas.Pen.Style   := psSolid;
           MyCanvas.pen.mode    := pmCopy;
           MyCanvas.pen.Width   := 1;
           MyCanvas.brush.Color := clWhite;
           MyCanvas.brush.Style := bsSolid;
           MyCanvas.Font.Size   := MyCaption.Font.Size; //Trunc(FontSize*MashtabCoef) - 1;
           MyCanvas.Font.Style  := MyCaption.Font.Style;

           fStartpos.x := pa[k].x1 + Trunc((MyCaption. StartTimePos - Form1.MinPlanshetTime)/TimeInOnePixel);
           fEndpos.x   := pa[k].x1 + Trunc((MyCaption. EndTimePos   - Form1.MinPlanshetTime)/TimeInOnePixel);
           fStartpos.y := pa[k].y2 - Trunc (MyCaption.YStartValue*(pa[k].y2-pa[k].y1                       ));
           fEndpos.y   := pa[k].y2 - Trunc (MyCaption.YEndValue  *(pa[k].y2-pa[k].y1                       ));
           // --- Вычисляю координаты центра прямоугольника ----
           CenterBox.X := abs(fStartPos.X - fEndPos.X) div 2;
           CenterBox.Y := abs(fStartPos.Y - fEndPos.Y) div 2;
           // --- Вычисляю Высоту, Ширину выводимого текста в прямоугольник ----
           WidthText  := MyCanvas.TextWidth (MyCaption.Caption);
           HeightText := MyCanvas.TextHeight(MyCaption.Caption);

           MyCanvas.Pen.Color := clBlack;
           if MyCaption.Orientation = oHorizontal then begin
                  OffsetValue := 0;
                  if abs(fStartPos.X - fEndPos.X) + 5 < WidthText + WidthText div 2 then OffsetValue := - HeightText - CenterBox.y;
                  if fStartPos.Y < fEndPos.Y then TempValue.Y := fStartPos.Y else TempValue.Y := fEndPos.Y;
                  if fStartPos.X < fEndPos.X then TempValue.X := fStartPos.X else TempValue.X := fEndPos.X;
                  // --- Вычисляю координаты левого-вернего угла прямоугольника ---
                  BoxRect.left   := TempValue.x + CenterBox.X - WidthText div 2 - WidthText div 18;
                  BoxRect.Top    := TempValue.y + OffsetValue + CenterBox.y - HeightText div 2 - HeightText div 18;
                  // --- Вычисляю координаты правого-нижнего угла прямоугольника ---
                  BoxRect.Right  := TempValue.x + CenterBox.X + WidthText div 2 + WidthText div 18;
                  BoxRect.Bottom := TempValue.y + OffsetValue + CenterBox.y + HeightText div 2 + HeightText div 18;
                  // --- Вычисляю  координаты начала текста ---
                  TextPos.X := BoxRect.Left + WidthText div 18;
                  TextPos.Y := BoxRect.Top  + HeightText div 18;
                  ///////////////////////////////////////////////////////
                  FillRect(Rect(TextPos.X-4, TextPos.Y-4, TextPos.X + WidthText+ 4, TextPos.Y+HeightText+4));
                  MyCanvas.TextOut(TextPos.x, TextPos.Y, MyCaption.Caption);
           end else begin
                  OffsetValue := 0;
                  if abs(fStartPos.y - fEndPos.y) + 5 < WidthText + WidthText div 3 then OffsetValue := - HeightText - CenterBox.x;

                  if fStartPos.x < fEndPos.x then TempValue.x := fStartPos.x else TempValue.x := fEndPos.x;
                  if fStartPos.Y < fEndPos.Y then TempValue.y := fStartPos.y else TempValue.y := fEndPos.y;
                  // --- Вычисляю координаты левого-вернего угла прямоугольника ---
                  BoxRect.Left   := TempValue.x + OffsetValue + CenterBox.X - HeightText div 2 - HeightText div 18;
                  BoxRect.Top     := TempValue.y + CenterBox.Y - WidthText div 2 - WidthText div 18;
                  // --- Вычисляю координаты правого-нижнего угла прямоугольника ---
                  BoxRect.Right  := TempValue.x + OffsetValue + CenterBox.X + HeightText div 2 + HeightText div 18;
                  BoxRect.Bottom  := TempValue.y + CenterBox.Y + WidthText div 2 + WidthText div 18;
                  // --- Вычисляю  координаты начала текста ---
                  TextPos.X := BoxRect.Left    + HeightText div 18;
                  TextPos.Y := BoxRect.Bottom  - WidthText div 18;

                  RotateTextBitmapToPrinter(MyCanvas,MyCaption.Caption,TextPos.x, TextPos.y,FontSize,clBlack);
           end;

          MyCanvas.Pen.Color := clBlack;
          if MyCaption.LineVisible then begin
               // --- отрисовую кружочки Начала-Конца Надписи ---
               Ellipse(fStartpos.x - 3, fStartpos.y-3, fStartpos.x  + 3, fStartpos.y + 3);
               Ellipse(fEndpos.  x - 3, fEndpos  .y-3, fEndpos.x    + 3, fEndpos  .y + 3);

               if MyCaption.Orientation = oHorizontal then begin
                   TempPos.Y := BoxRect.Top + (BoxRect.Bottom - BoxRect.Top) div 2;
                   if abs(fStartPos.X - fEndPos.X) < abs(BoxRect.Right - BoxRect.Left) + 8 then begin
                                // --- Отрисовую первую Стрелку ---
                         MyCanvas.MoveTo(BoxRect.Left  , TempPos.Y);
                         MyCanvas.LineTo(BoxRect.Left-5, TempPos.Y);
                         MyCanvas.LineTo(BoxRect.Left-5, fStartpos.Y);
                         MyCanvas.LineTo(fStartpos.x   , fStartpos.Y);
                                // --- Отрисовую вторуюм Стрелку ---
                         MyCanvas.MoveTo(BoxRect.Right  , TempPos.Y);
                         MyCanvas.LineTo(BoxRect.Right+5, TempPos.Y);
                         MyCanvas.LineTo(BoxRect.Right+5, fEndPos.Y);
                         MyCanvas.LineTo(fEndPos.x      , fEndPos.Y);
                   end else begin
                                // --- Отрисовую первую Стрелку ---
                         MyCanvas.MoveTo(BoxRect.Left, TempPos.Y);
                         MyCanvas.LineTo(fStartpos.x,  TempPos.Y);
                         MyCanvas.LineTo(fStartpos.x,  fStartpos.Y);
                                // --- Отрисовую вторуюм Стрелку ---
                         MyCanvas.MoveTo(BoxRect.Right, TempPos.Y);
                         MyCanvas.LineTo(fEndPos.x,  TempPos.Y);
                         MyCanvas.LineTo(fEndPos.x,  fEndPos.Y);
                   end;
               end else begin
                   TempPos.X := BoxRect.Left + (BoxRect.Right - BoxRect.Left) div 2;
                   if abs(fStartPos.Y - fEndPos.Y) < abs(BoxRect.Top - BoxRect.Bottom) + 8 then begin
                         // --- Отрисовую первую Стрелку ---
                         MyCanvas.MoveTo(TempPos.X,    BoxRect.Top);
                         MyCanvas.LineTo(TempPos.X,    BoxRect.Top - 5);
                         MyCanvas.LineTo(fStartpos.x, BoxRect.Top - 5);
                         MyCanvas.LineTo(fStartpos.x, fStartpos.Y);
                         // --- Отрисовую вторуюм Стрелку ---
                         MyCanvas.MoveTo(TempPos.X,  BoxRect.Bottom);
                         MyCanvas.LineTo(TempPos.X,  BoxRect.Bottom+5);
                         MyCanvas.LineTo(fEndPos.x, BoxRect.Bottom+5);
                         MyCanvas.LineTo(fEndPos.x, fEndpos.Y);
                     end else begin
                         // --- Отрисовую первую Стрелку ---
                         MyCanvas.MoveTo(TempPos.X, BoxRect.Top);
                         MyCanvas.LineTo(TempPos.X, fStartpos.y);
                         MyCanvas.LineTo(fStartpos.x,  fStartpos.Y);
                         // --- Отрисовую вторуюм Стрелку ---
                         MyCanvas.MoveTo(TempPos.X, BoxRect.Bottom);
                         MyCanvas.LineTo(TempPos.X, fEndPos.y);
                         MyCanvas.LineTo(fEndPos.x,  fEndpos.Y);
                    end;
               end;
           end;
        end;
    end;
  end; // --- With myCanvas do begin
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
function TfrmPrintPreview.Get_WidthDocument(MyCanvas : TCanvas): Integer;
var
  TimeBeetwenMainVerticalLine       : Double;
  CountSmBeetwenMainVerticalLine    : Double;
  CountInchBeetwenMainVerticalLine  : Double;
  CountPixelBeetwenMainVerticalLine : Double;
  CountVerticalMainLine             : Double;
  PoleWidth                         : Integer;
  PixelsOneSantimetr                : Integer;
  MaxHeadingWidth                   : Integer;
  HeadingWidth                      : Integer;
  MyTextHeight                      : Integer;
  k                                 : integer;
//  a1, a2, a3, a4, a5                : Double;

begin
    /////////////////////////////////////////////////////
     MaxHeadingWidth := -1000000;
     MyTextHeight := MyCanvas.TextHeight('0');
     for k:=1 to frmPlanshetParam.sePoleCount.value do begin
              HeadingWidth := (Form1.SeriesList[k].Count)*MyTextHeight*2 + MyTextHeight;
              if MaxHeadingWidth < HeadingWidth then MaxHeadingWidth := HeadingWidth;
     end;
    /////////////////////////////////////////////////////
    PixelsOneSantimetr := Trunc(MyCanvas.Font.PixelsPerInch/SmPerInch);
    /////////////////////////////////////////////////////
    TimeBeetwenMainVerticalLine       := ChartParam.MaxVisibleTimeOnChart / (100/ChartParam.BottomAxis_GridStep);
    CountSmBeetwenMainVerticalLine    := (TimeBeetwenMainVerticalLine / TimeInOneSecond)/ (ChartParam.CountMinInOneSantimetr * 60);
    CountInchBeetwenMainVerticalLine  := CountSmBeetwenMainVerticalLine     / SmPerInch;
    CountPixelBeetwenMainVerticalLine := CountInchBeetwenMainVerticalLine   * MyCanvas.Font.PixelsPerInch;
    CountVerticalMainLine             := MaxVisiblePlanshetTime             / TimeBeetwenMainVerticalLine;
    poleWidth                         := Trunc(CountPixelBeetwenMainVerticalLine * CountVerticalMainLine);
//    result                            := trunc(StretchBitmap.Width +       8*PixelsOneSantimetr + 2*MaxHeadingWidth + poleWidth + PixelsOneSantimetr div 10);

    result                            := trunc(  StretchBitmap.Width
                                               + PixelsOneSantimetr
                                               + MaxHeadingWidth
                                               + PixelsOneSantimetr
                                               + PoleWidth
                                               + PixelsOneSantimetr
                                               + MaxHeadingWidth
                                               + PixelsOneSantimetr
                                               + 3 * PixelsOneSantimetr + PixelsOneSantimetr div 10
                                               //---------------
                                               + 4*PixelsOneSantimetr);

      //DrawHeadingOfDiagramm(myCanvas,  StretchBitmap.Width + 2*PixelsOneSantimetr + MaxHeadingWidth + poleWidth  , FontSize, MaxHeadingWidth);

//    a2 := (ChartParam.CountMinInOneSantimetr * 60)  * SmPerInch / MyCanvas.Font.PixelsPerInch; // kol vrem v 1 pix
//    a3 := (MaxVisiblePlanshetTime / TimeInOneSecond) / a2;

//    caption := FloatToStr(a2);
//    caption := FloatToStr(a3);
//    caption := FloatToStr(a3);
//    caption := FloatToStr(PoleWidth);
end;
//******************************************************************************************************************************************
//******************************************************************************************************************************************
//******************************************************************************************************************************************
procedure TfrmPrintPreview.SetPrinterPageSizes(APageWidth,
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
        NewDevMode.dmOrientation := DMORIENT_LANDSCAPE; // DMORIENT_PORTRAIT
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

procedure TfrmPrintPreview.PrintDocument;
Var
  DocumentWidth : Integer;
  MashtCoef     : Double;
begin
    Form1.Cursor  := crHourGlass;

    CountShot           := 0;
    ScrollBar1.Position := 0;
    MaxVisiblePlanshetTime :=  form1.MaxPlanshetTime - form1.MinPlanshetTime;
    if MaxVisiblePlanshetTime < 0 then begin
      beep;
      MessageDlg ('Загрузите данные на планшет', mtInformation, [mbOk], 0);
      exit;
    end;

    frmHeadingOfTheDiagram.AutoSize   := True;
    frmHeadingOfTheDiagram.AutoScroll := False;
    frmHeadingOfTheDiagram.Width      := 689;
    HeadBitmap                        := frmHeadingOfTheDiagram.GetFormImage;
    HeadBitmap.PixelFormat            := pf4Bit;
    Printer.Orientation               := poPortrait;
    DocHeight                         := Printer.PageWidth;
    MashtabCoef                       := DocHeight/HeadBitmap.Height;
    StretchBitmap.Width               := trunc(HeadBitmap.Width*MashtabCoef*0.97);
    StretchBitmap.Height              := trunc(DocHeight*0.97);
    StretchBitmap.Canvas.Brush.Color  := clWhite;

    StretchBitmap.Canvas.FillRect(rect(0,0,StretchBitmap.Width, StretchBitmap.Height));
    StretchBitmap.Canvas.StretchDraw(rect(Trunc(HeadBitmap.Width*MashtabCoef*0.03),
                                          Trunc(DocHeight*0.03),
                                          Trunc(HeadBitmap.Width*MashtabCoef*0.97),
                                          Trunc(DocHeight*0.97)), HeadBitmap);

    DocumentWidth := Get_WidthDocument(Printer.Canvas);
    MashtCoef     := 10/(Printer.Canvas.Font.PixelsPerInch/SmPerInch/10);
    SetPrinterPageSizes(Printer.PageWidth, Trunc(DocumentWidth*MashtCoef) + 100);
    //SetPrinterPageSizes(Printer.PageWidth, Trunc(DocumentWidth*1.39));

    Printer.BeginDoc;
      PrintingDocument(Printer.Canvas);
    Printer.EndDoc;
    Form1.Cursor := crDefault;
end;

end.
