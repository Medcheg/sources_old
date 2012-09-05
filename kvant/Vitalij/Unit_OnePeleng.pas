unit Unit_OnePeleng;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, Spin;

type
  TMyPoint = record
    i : Integer;
    y : Double;
  end;

  TfmOnePeleng = class(TForm)
    Chart1: TChart;
    BarSeries1: TBarSeries;
    Chart2: TChart;
    LineSeries2: TFastLineSeries;
    Chart4: TChart;
    LineSeries4: TFastLineSeries;
    Chart3: TChart;
    BarSeries3: TBarSeries;
    Panel1: TPanel;
    Panel2: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Chart1AfterDraw(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Chart2AfterDraw(Sender: TObject);
    procedure Chart3AfterDraw(Sender: TObject);
    procedure Chart4AfterDraw(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
    procedure Chart1Zoom(Sender: TObject);
    procedure Chart1Scroll(Sender: TObject);
  private
    SigFast_SigLow, SHPEL0, DB, Offset : Double;
    MM                                 : Integer;

    BarWidth                               : Integer;

    procedure Set_BarWidth();
  public

    SeriesArray1 : Array [0..2000] of TMyPoint;
    SeriesArray2 : Array [0..2000] of TMyPoint;
    SeriesArray3 : Array [0..2000] of TMyPoint;
    SeriesArray4 : Array [0..2000] of TMyPoint;

    NumberTarget : Integer;
    CountDataSeries1 : Integer;
    procedure PrepareChart(NumberT, nc : Integer;aMM : integer; aSHPEL0, aSigFast,aSigLow,aDB : Double);
    procedure DrawSeries  (NumberT, nc : Integer);

    procedure AddPointChart1(NumberT : Integer; i : integer; y: Double);
    procedure AddPointChart2(NumberT : Integer; i : integer; y: Double);
    procedure AddPointChart3(NumberT : Integer; i : integer; y: Double);
    procedure AddPointChart4(NumberT : Integer; i : integer; y: Double);
    procedure SetParam(NumberT : Integer);
  end;

var
  fmOnePeleng: TfmOnePeleng;

implementation

{$R *.DFM}

uses Targets;

{ TfmOnePeleng }

procedure TfmOnePeleng.FormCreate(Sender: TObject);
var
 i : integer;
begin
  Width := 552;
  Height:= 661;
  BarSeries1.CustomBarWidth := 3;
  BarSeries3.CustomBarWidth := 3;
  SetParam(0);
end;

procedure TfmOnePeleng.SetParam(NumberT: Integer);
begin
  Chart1.Series[0].Clear;
  Chart2.Series[0].Clear;
  Chart3.Series[0].Clear;
  Chart4.Series[0].Clear;

  FillChar(SeriesArray1, sizeof(TMyPoint)*2001,0);
  FillChar(SeriesArray2, sizeof(TMyPoint)*2001,0);
  FillChar(SeriesArray3, sizeof(TMyPoint)*2001,0);
  FillChar(SeriesArray4, sizeof(TMyPoint)*2001,0);
  CountDataSeries1 := -1;
  NumberTarget     := NumberT;
  if NumberT = 0 then RadioButton1.Checked := True;
end;

procedure TfmOnePeleng.AddPointChart1(NumberT : Integer; i : integer; y: Double);
begin
  if NumberTarget <> -1 then
    if (NumberT = NumberTarget)then begin
       Chart1.Series[0].Addxy(i*DB + SigFast_SigLow + SHPEL0, y);
       Chart1.Repaint;
    end;
end;

procedure TfmOnePeleng.AddPointChart2(NumberT, i: integer; y: Double);
begin
  if NumberTarget <> -1 then
    if (NumberT = NumberTarget)then begin
       Chart2.Series[0].Addxy(i*DB + SigFast_SigLow + SHPEL0,y);
       Chart2.Repaint;
    end;
end;

procedure TfmOnePeleng.AddPointChart3(NumberT, i: integer; y: Double);
begin
  if NumberTarget <> -1 then
    if (NumberT = NumberTarget)then begin
       Chart3.Series[0].Addxy(i*DB + SigFast_SigLow + SHPEL0,y);
       Chart3.Repaint;
    end;
end;

procedure TfmOnePeleng.AddPointChart4(NumberT, i: integer; y: Double);
begin
  if NumberTarget <> -1 then
    if (NumberT = NumberTarget)then begin
       Chart4.Series[0].Addxy(i*DB + SigFast_SigLow + SHPEL0,y);
       Chart4.Repaint;
    end;
end;

procedure TfmOnePeleng.Set_BarWidth();
var
  BottomAxisWidth     : Integer;
  BottomAxisMaxTime   : Double;
  TempValue           : Extended;
begin
  if Chart1.ChartRect.Right = 0 then Exit;
  BottomAxisWidth   := Chart1.ChartRect.Right    - Chart1.ChartRect.Left;
  BottomAxisMaxTime := Chart1.BottomAxis.Maximum - Chart1.BottomAxis.Minimum;
  if BottomAxisMaxTime = 0 then exit;

  TempValue                 := BottomAxisWidth*DB/BottomAxisMaxTime;
  BarWidth                  := trunc(TempValue) + 2;

  BarSeries1.CustomBarWidth := BarWidth;
  BarSeries3.CustomBarWidth := BarWidth;
end;

procedure TfmOnePeleng.FormPaint(Sender: TObject);
begin
  Set_BarWidth()
end;

procedure TfmOnePeleng.Chart1AfterDraw(Sender: TObject);
var
 x1, x2, x3, x4  : Integer;
 st1, st2        : String;
begin
     if MM = 0 then exit;
     x1   := Chart1.BottomAxis.CalcXPosValue(-MM*DB+SHPEL0);
     x2   := Chart1.BottomAxis.CalcXPosValue( MM*DB+SHPEL0);
     x3   := Chart1.BottomAxis.CalcXPosValue(-MM*DB+SHPEL0+SigFast_SigLow);
     x4   := Chart1.BottomAxis.CalcXPosValue( MM*DB+SHPEL0+SigFast_SigLow);

     st1  := FLoatToStrF(Chart1.BottomAxis.CalcPosPoint(x1),ffFixed,2,2);
     st2  := FLoatToStrF(Chart1.BottomAxis.CalcPosPoint(x2),ffFixed,2,2);
     //st1  :=    FLoatToStrF(-MM*DB + SHPEL0,ffFixed,2,2);
     //st2  := FLoatToStrF( MM*DB + SHPEL0,ffFixed,2,2);

     if (x1=x2) then exit;
     if (x3=x4) then exit;

     Chart1.Canvas.Pen.Color := clBlack;
     Chart1.Canvas.Pen.Width := 3; Chart1.Canvas.Pen.Style := psSolid;

     Chart1.Canvas.MoveTo(x1, Chart1.ChartRect.Bottom);
     Chart1.Canvas.LineTo(x1, Chart1.ChartRect.Top);
     Chart1.Canvas.MoveTo(x2, Chart1.ChartRect.Bottom);
     Chart1.Canvas.LineTo(x2, Chart1.ChartRect.Top);

     // ------------  Пунктирные линии ---------------
     Chart1.Canvas.Pen.Width := 1;// Chart1.Canvas.Pen.Style := psDot;

     if x3 >= Chart1.BottomAxis.IStartPos then begin
       Chart1.Canvas.MoveTo(x3, Chart1.ChartRect.Bottom);
       Chart1.Canvas.LineTo(x3, Chart1.ChartRect.Top);
     end;

     if x4 <= Chart1.BottomAxis.IEndPos then begin
       Chart1.Canvas.MoveTo(x4, Chart1.ChartRect.Bottom);
       Chart1.Canvas.LineTo(x4, Chart1.ChartRect.Top);
     end;
     //---------------------------------------------------

     //Chart1.Canvas.TextOut(x1 - Chart1.Canvas.TextWidth(st1) div 2, Chart1.ChartRect.Bottom + 15, st1);
     //Chart1.Canvas.TextOut(x2 - Chart1.Canvas.TextWidth(st2) div 2, Chart1.ChartRect.Bottom + 15, st2);
end;

procedure TfmOnePeleng.Chart2AfterDraw(Sender: TObject);
var
 x3, x4  : Integer;
begin
     x3   := Chart2.BottomAxis.CalcXPosValue(-MM*DB+SHPEL0+SigFast_SigLow);
     x4   := Chart2.BottomAxis.CalcXPosValue( MM*DB+SHPEL0+SigFast_SigLow);
     if (x3=x4) then exit;

     Chart2.Canvas.Pen.Width := 1;// //Chart2.Canvas.Pen.Style := psDot;

     if x3 >= Chart1.BottomAxis.IStartPos then begin
       Chart2.Canvas.MoveTo(x3, Chart2.ChartRect.Bottom);
       Chart2.Canvas.LineTo(x3, Chart2.ChartRect.Top);
     end;

     if x4 <= Chart1.BottomAxis.IEndPos then begin
       Chart2.Canvas.MoveTo(x4, Chart2.ChartRect.Bottom);
       Chart2.Canvas.LineTo(x4, Chart2.ChartRect.Top);
     end;
end;

procedure TfmOnePeleng.Chart3AfterDraw(Sender: TObject);
var
 x3, x4  : Integer;
begin
     x3   := Chart3.BottomAxis.CalcXPosValue(-MM*DB+SHPEL0+SigFast_SigLow);
     x4   := Chart3.BottomAxis.CalcXPosValue( MM*DB+SHPEL0+SigFast_SigLow);
     if (x3=x4) then exit;

     Chart3.Canvas.Pen.Width := 1;// //Chart3.Canvas.Pen.Style := psDot;

     if x3 >= Chart1.BottomAxis.IStartPos then begin
       Chart3.Canvas.MoveTo(x3, Chart3.ChartRect.Bottom);
       Chart3.Canvas.LineTo(x3, Chart3.ChartRect.Top);
     end;

     if x4 <= Chart1.BottomAxis.IEndPos then begin
       Chart3.Canvas.MoveTo(x4, Chart3.ChartRect.Bottom);
       Chart3.Canvas.LineTo(x4, Chart3.ChartRect.Top);
     end;
end;

procedure TfmOnePeleng.Chart4AfterDraw(Sender: TObject);
var
 x3, x4  : Integer;
begin
     x3   := Chart4.BottomAxis.CalcXPosValue(-MM*DB+SHPEL0+SigFast_SigLow);
     x4   := Chart4.BottomAxis.CalcXPosValue( MM*DB+SHPEL0+SigFast_SigLow);
     if (x3=x4) then exit;

     Chart4.Canvas.Pen.Width := 1;// //Chart4.Canvas.Pen.Style := psDot;

     if x3 >= Chart1.BottomAxis.IStartPos then begin
       Chart4.Canvas.MoveTo(x3, Chart4.ChartRect.Bottom);
       Chart4.Canvas.LineTo(x3, Chart4.ChartRect.Top);
     end;

     if x4 <= Chart1.BottomAxis.IEndPos then begin
       Chart4.Canvas.MoveTo(x4, Chart4.ChartRect.Bottom);
       Chart4.Canvas.LineTo(x4, Chart4.ChartRect.Top);
     end;
end;

procedure TfmOnePeleng.PrepareChart(NumberT, nc : Integer;aMM : integer; aSHPEL0, aSigFast,aSigLow,aDB : Double);
var
 i : integer;
begin
  if nc <> 1 then exit;
  if (NumberT = NumberTarget) then begin

     Chart1.Series[0].SeriesColor := TargetColors[NumberT];
     Chart3.Series[0].SeriesColor := TargetColors[NumberT];

     Chart1.UndoZoom;
     Chart2.UndoZoom;
     Chart3.UndoZoom;
     Chart4.UndoZoom;

     if CountDataSeries1 = -1 then exit;
     MM             := aMM;
     DB             := aDB;
     SHPEL0         := aSHPEL0;
     SigFast_SigLow := aSigFast + aSigLow;

     Label3.Caption := ' =   ' + FloatToStrF(aSigFast, ffFixed, 3, 2);
     Label6.Caption := ' =   ' + FloatToStrF(aSigLow , ffFixed, 3, 2);

     Chart1.BottomAxis.SetMinMax(-MM*DB*2+SHPEL0{+SigFast_SigLow*1.3} ,MM*DB*2+SHPEL0{+SigFast_SigLow*1.3});
     Chart2.BottomAxis.SetMinMax(-MM*DB*2+SHPEL0{+SigFast_SigLow*1.3} ,MM*DB*2+SHPEL0{+SigFast_SigLow*1.3});
     Chart3.BottomAxis.SetMinMax(-MM*DB*2+SHPEL0{+SigFast_SigLow*1.3} ,MM*DB*2+SHPEL0{+SigFast_SigLow*1.3});
     Chart4.BottomAxis.SetMinMax(-MM*DB*2+SHPEL0{+SigFast_SigLow*1.3} ,MM*DB*2+SHPEL0{+SigFast_SigLow*1.3});

     Set_BarWidth();
  end;
end;

procedure TfmOnePeleng.DrawSeries(NumberT, nc: Integer);
var
  i : integer;
begin
  if nc <> 1 then exit;
  if NumberTarget <> -1 then
    if (NumberT = NumberTarget)then begin
       Chart1.Series[0].Clear;
       Chart2.Series[0].Clear;
       Chart3.Series[0].Clear;
       Chart4.Series[0].Clear;

       if CountDataSeries1 = -1 then exit;

       for i:=-0 to CountDataSeries1-1 do begin
           Chart1.Series[0].Addxy(SeriesArray1[i].i*DB + SigFast_SigLow + SHPEL0,SeriesArray1[i].y);
       end;
       for i:=-mm to mm do begin
           Chart2.Series[0].Addxy(i*DB + SigFast_SigLow + SHPEL0,SeriesArray2[i+mm].y);
           Chart3.Series[0].Addxy(i*DB + SigFast_SigLow + SHPEL0,SeriesArray3[i+mm].y);
           Chart4.Series[0].Addxy(i*DB + SigFast_SigLow + SHPEL0,SeriesArray4[i+mm].y);
       end;

       FillChar(SeriesArray1, sizeof(TMyPoint)*2001,0);
       FillChar(SeriesArray2, sizeof(TMyPoint)*2001,0);
       FillChar(SeriesArray3, sizeof(TMyPoint)*2001,0);
       FillChar(SeriesArray4, sizeof(TMyPoint)*2001,0);
       CountDataSeries1 := -1;
    end;

end;

procedure TfmOnePeleng.RadioButtonClick(Sender: TObject);
begin
  SetParam(TRadioButton(Sender).Tag - 1);
end;

procedure TfmOnePeleng.Chart1Zoom(Sender: TObject);
begin
  Chart1Scroll(Sender);
  Set_BarWidth();
end;

procedure TfmOnePeleng.Chart1Scroll(Sender: TObject);
var
  max, min : Double;
begin
  max := TChart(Sender).BottomAxis.Maximum;
  min := TChart(Sender).BottomAxis.Minimum;

  Chart1.BottomAxis.SetMinMax(Min, Max);
  Chart2.BottomAxis.SetMinMax(Min, Max);
  Chart3.BottomAxis.SetMinMax(Min, Max);
  Chart4.BottomAxis.SetMinMax(Min, Max);
end;

end.
