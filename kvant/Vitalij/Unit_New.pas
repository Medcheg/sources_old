unit Unit_New;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, TeeProcs, TeEngine, Chart, Series, StdCtrls;

type
  TGrarray = record
    Series1   : array [0..1000] of extended;
    Series2   : array [0..1000] of extended;
    Series3   : array [0..1000] of extended;
  end;


  TfmNew = class(TForm)
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
  private
    TimeinOneSecond     : TDateTime;
    CurrentOutPutTarget : Integer;
    TimeArray           : array [0..1000] of extended;
    ChartSeries         : array [1..8] of TGrArray;
    Count               : Integer;
  public
    procedure DrawPointOnSeries1(nc : Integer;NumberTarget : Integer; Time : Double; Peleng : Double);
    Procedure PreSet;
  end;

var
  fmNew: TfmNew;

implementation

{$R *.DFM}

procedure TfmNew.DrawPointOnSeries1(nc : Integer; NumberTarget: Integer; Time, Peleng: Double);
begin
//   time*TimeInOneSecond
  if nc = 1 then begin
     if TimeArray[Count] <> Time then inc(Count);
     TimeArray[Count] := Time;

     ChartSeries[NumberTarget+1].Series1[Count] := Peleng;

     if NumberTarget+1  = CurrentOutPutTarget then begin
        Chart1.Series[0].AddXY(time*TimeInOneSecond,Peleng);
     end;

     if  Chart1.series[0].MaxYValue < 0 then Chart1.LeftAxis.Maximum := Chart1.series[0].MaxYValue * 0.8;
     if  Chart1.series[0].MaxYValue > 0 then Chart1.LeftAxis.Maximum := Chart1.series[0].MaxYValue * 1.2;
     if  Chart1.series[0].MinYValue > 0 then Chart1.LeftAxis.Minimum := Chart1.series[0].MinYValue * 0.8;
     if  Chart1.series[0].MinYValue < 0 then Chart1.LeftAxis.Minimum := Chart1.series[0].MinYValue * 1.2;
  end;
end;

procedure TfmNew.FormCreate(Sender: TObject);
begin
  TimeinOneSecond :=EncodeTime (0,0,1,0);
  chart1.BottomAxis.Minimum :=0;
  chart2.BottomAxis.Minimum :=0;
  chart1.BottomAxis.Maximum :=30 * TimeinOneSecond;
  chart2.BottomAxis.Maximum :=30 * TimeinOneSecond;

  CurrentOutPutTarget := 1;

end;

procedure TfmNew.FormResize(Sender: TObject);
begin
  Chart1.Height := ClientHeight div 2;
end;

procedure TfmNew.PreSet;
begin
  Count := 0;
end;

procedure TfmNew.RadioButtonClick(Sender: TObject);
var
 i : byte;
 k : Integer;
 CurrentData : Extended;
begin
   for i:= 0 to 2 do begin
      Chart1.Series[i].Clear;
      Chart2.Series[i].Clear;
  end;

      For k:=1 to Count do begin
         CurrentData := ChartSeries[TRadioButton(Sender).Tag].Series1[k];
         if CurrentData = 0 then ChartSeries[TRadioButton(Sender).Tag].Series1[k] := ChartSeries[TRadioButton(Sender).Tag].Series1[k-1];
         CurrentData := ChartSeries[TRadioButton(Sender).Tag].Series1[k];

         Chart1.Series[0].addXY(TimeArray[k]*TimeInOneSecond, CurrentData);
      end;


     if  Chart1.series[0].MaxYValue < 0 then Chart1.LeftAxis.Maximum := Chart1.series[0].MaxYValue * 0.8;
     if  Chart1.series[0].MaxYValue > 0 then Chart1.LeftAxis.Maximum := Chart1.series[0].MaxYValue * 1.2;
     if  Chart1.series[0].MinYValue > 0 then Chart1.LeftAxis.Minimum := Chart1.series[0].MinYValue * 0.8;
     if  Chart1.series[0].MinYValue < 0 then Chart1.LeftAxis.Minimum := Chart1.series[0].MinYValue * 1.2;
     //Application.ProcessMessages;

   CurrentOutPutTarget := RadioButton1.Tag;
end;

end.
