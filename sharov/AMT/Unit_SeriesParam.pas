unit Unit_SeriesParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin, MPIDeclaration, ImgList,
  Menus, Series;

type
  TfrmSeriesParam = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    PopupMenu1: TPopupMenu;
    fg1: TMenuItem;
    N1: TMenuItem;
    N4: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ImageList1: TImageList;
    panelLineStyle: TPanel;
    PaintBox1: TPaintBox;
    Label5: TLabel;
    edMin: TEdit;
    Label6: TLabel;
    edMax: TEdit;
    sbMin: TBitBtn;
    sbMax: TBitBtn;
    Label7: TLabel;
    edDate: TEdit;
    Label8: TLabel;
    edTime: TEdit;
    Button1: TButton;
    Bevel2: TBevel;
    Label9: TLabel;
    Button2: TButton;
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure abcColorComboBox1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure sbMinClick(Sender: TObject);
    procedure sbMaxClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure fg1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    MySeries      : TMySeries;
    ChartSeries   : TFastLineSeries;
    procedure Set_ParamProjectRecord();
  public
    procedure SetParam (aMySeries : TMySeries; aChartSeries : TFastLineSeries);

  end;

var
  frmSeriesParam: TfrmSeriesParam;

implementation

uses Unit_Main, Unit_SaveType, Unit_HeadingOfTheDiagram, Unit_PlanshetParam,
  Unit_PlanshetCreator;

{$R *.DFM}

{ TfrmSeriesParam }

procedure TfrmSeriesParam.SetParam(aMySeries: TMySeries; aChartSeries : TFastLineSeries);
begin
  MySeries                        := aMySeries;
  ChartSeries                     := aChartSeries;
  Edit1.Text                      := MySeries.Name;
  edDate.text                     := DateToStr(MySeries.StartDateTime);
  edTime.text                     := TimeToStr(MySeries.Timedata[0]);

  ///
  SpinEdit1.Value                 := MySeries.PenWidth;
  edMin.Text                      := floatToStrF(MySeries.Min,ffFixed,10,4);
  edMax.Text                      := floatToStrF(MySeries.Max,ffFixed,10,4);
end;

procedure TfrmSeriesParam.PaintBox1Click(Sender: TObject);
var
  CurPoint    : TPoint;
begin
      CurPoint.X := panelLineStyle.Left;
      CurPoint.Y := panelLineStyle.Top + panelLineStyle.Height+1;
      CurPoint   := ClientToScreen(CurPoint);
      PopUpMenu1.Popup(CurPoint.X, CurPoint.Y);
end;

procedure TfrmSeriesParam.PaintBox1Paint(Sender: TObject);
begin
  //edMin.Text             := FloatToStr(MySeries.min);
 // edMax.Text             := FloatToStr(MySeries.max);
  With PaintBox1.Canvas do begin
     Pen.Style := MySeries.PenStyle;
     Pen.Color := MySeries.PenColor;
     MoveTo (1,                   (PaintBox1.Height div 2 )-1);
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )-1);
     MoveTo (1,                   (PaintBox1.Height div 2 )  );
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )  );
     MoveTo (1,                   (PaintBox1.Height div 2 )+1);
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )+1);
  end;
end;

procedure TfrmSeriesParam.abcColorComboBox1Change(Sender: TObject);
begin
  PaintBox1.RePaint;
  ChartSeries.LinePen.Color := MySeries.PenColor;
  ChartSeries.SeriesColor   := MySeries.PenColor;
  Set_ParamProjectRecord();
  Form1.ChartArray[NumberPole,2].Repaint;
end;

procedure TfrmSeriesParam.SpinEdit1Change(Sender: TObject);
begin
  MySeries.PenWidth    := SpinEdit1.Value;
  ChartSeries.LinePen.Width := MySeries.PenWidth;
  if MySeries.PenWidth > 1 then begin
     MySeries.PenStyle := psSolid;
     PaintBox1.RePaint;
  end;
  Set_ParamProjectRecord();
  Form1.ChartArray[NumberPole,2].Repaint;
end;

procedure TfrmSeriesParam.Edit1Change(Sender: TObject);
begin
  MySeries.Name := Edit1.Text;
  Set_ParamProjectRecord();
  Form1.ChartArray[NumberPole,2].Repaint;
end;

procedure TfrmSeriesParam.sbMinClick(Sender: TObject);
var
 OldValueMin : Double;
begin
  OldValueMin := MySeries.Min;
  Try
    edMin.Text  := InputBox('Минимальное значение кривой','Введите новое значение :','');
    MySeries.Min := StrToFloat(edMin.Text);
  except
    beep;
    edMin.SelectAll;
    edMin.SetFocus;
    MySeries.Min := OldValueMin;
    MessageDlg('Не числовое значение', mtWarning, [mbOk], 0);
    BitBtn1.ModalResult := mrNone;
    Exit;
  end;
  BitBtn1.ModalResult := mrOk;
  Set_ParamProjectRecord();
  Form1.DrawSeriesOntoChart(ChartSeries,MySeries);
  edMin.Modified := False;
end;

procedure TfrmSeriesParam.sbMaxClick(Sender: TObject);
var
 OldValueMax : Double;
begin
  OldValueMax := MySeries.Max;
  Try
    edMax.Text  := InputBox('Максимальное значение кривой','Введите новое значение :','');
    MySeries.Max := StrToFloat(edMax.Text);
  except
    beep;
    edMax.SelectAll;
    edMax.SetFocus;
    MySeries.Max := OldValueMax;
    MessageDlg('Не числовое значение', mtWarning, [mbOk], 0);
    BitBtn1.ModalResult := mrNone;
    Exit;
  end;
  BitBtn1.ModalResult := mrOk;
  Set_ParamProjectRecord();
  Form1.DrawSeriesOntoChart(ChartSeries,MySeries);
  edMax.Modified := False;
end;

procedure TfrmSeriesParam.BitBtn1Click(Sender: TObject);
begin
 Set_ParamProjectRecord();
 close;
end;

procedure TfrmSeriesParam.fg1Click(Sender: TObject);
begin
  Case TComponent(Sender).tag of
    0 : MySeries.PenStyle := psSolid;
    1 : MySeries.PenStyle := psDash;
    2 : MySeries.PenStyle := psDot;
    3 : MySeries.PenStyle := psDashDot;
    4 : MySeries.PenStyle := psDashDotDot;
  end;
  if (MySeries.PenWidth <> 1) and (MySeries.PenStyle <> psSolid) then begin
     MySeries.PenWidth := 1;
     ChartSeries.LinePen.Width := MySeries.PenWidth;
  end;

  PaintBox1.RePaint;
  ChartSeries.LinePen.Style := MySeries.PenStyle;
  Set_ParamProjectRecord();
  Form1.DrawSeriesOntoChart(ChartSeries,MySeries);
  Form1.ChartArray[NumberPole,2].Repaint;
end;

procedure TfrmSeriesParam.Set_ParamProjectRecord;
var
 CurSeries   : Integer;
begin
 CurSeries := Form1.ChooseSeriesONChart[NumberPole];
 ProjectRecord.MainData[NumberPole-1].SeriesColor[CurSeries]    := MySeries.PenColor;
 ProjectRecord.MainData[NumberPole-1].SeriesStyle[CurSeries]    := MySeries.PenStyle;
 ProjectRecord.MainData[NumberPole-1].SeriesPenWidth[CurSeries] := MySeries.PenWidth;
 ProjectRecord.MainData[NumberPole-1].SeriesName[CurSeries]     := MySeries.Name;
 ProjectRecord.MainData[NumberPole-1].SeriesMax[CurSeries]      := MySeries.Max;
 ProjectRecord.MainData[NumberPole-1].SeriesMin[CurSeries]      := MySeries.Min;
end;

procedure TfrmSeriesParam.Button1Click(Sender: TObject);
var
 NewDate : TDateTime;

 TempFile  : TFile;
 TempSeries : TMySeries;

 FileCounter   : Integer;
 DataCounter   : TDataType;
 PoleCounter   : Integer;
 SeriesCounter : Integer;
 OldEditText   : String;

begin
  OldEditText := edDate.Text;
  try
    edDate.Text := InputBox('Новая дата начала измерений','Введите новое значение даты :','');
    NewDate     := StrToDate(edDate.Text);
  except
    beep;
    edDate.Text := OldEditText;
    MessageDlg('Введите правильную дату'#10#13#13'Например '+DateToStr(Now), mtWarning, [mbOk], 0);
    Exit;
  end;

  // ------------- Установка времени и исходной структуре файла ------
  for FileCounter := 0 to frmPlanshetCreator.ListBox1.items.Count -1 do begin
     TempFile := TFile(frmPlanshetCreator.ListBox1.items.Objects[FileCounter]);
     if TempFile.FileName = MySeries.FileName then
         for DataCounter := dtTempIn to dtPressure do begin
                   TempFile.Data[DataCounter].StartDate := NewDate;
         end;
  end; // --- for FileCounter := 0 to ListBox1.items.Count - 1 do begin
  //------------------------------------------------------------
  MySeries.StartDateTime := NewDate;
  // ------------- Установка времени всем сериям на поле  ------

  for PoleCounter :=1 to frmPlanshetParam.sePoleCount.Value do begin
      for SeriesCounter :=0 to Form1.SeriesList[PoleCounter].Count-1 do begin
          TempSeries := TMySeries(Form1.SeriesList[PoleCounter].Items[SeriesCounter]);
          if TempSeries.FileName = MySeries.FileName then begin
              TempSeries.StartDateTime := MySeries.StartDateTime;
              Form1.DrawSeriesOntoChart(Form1.MyFastLineSeries[PoleCounter,SeriesCounter],TempSeries);
          end;
      end;
  end;

  frmHeadingOfTheDiagram.Panel16.Caption := edDate.Text;
  Form1.ChartArray[NumberPole,2].Repaint;
end;

procedure TfrmSeriesParam.Button2Click(Sender: TObject);
var
 NewTime     : TDateTime;
 OffsetTime  : TDateTime;
 i           : Integer;
 OldEditText : String;
begin
  OldEditText := edTime.Text;
  try
    edTime.Text := InputBox('Новое время 1-ого замера','Введите новое время первого замера :','');
    NewTime     := StrToTime(edTime.Text);
  except
    beep;
    edTime.Text := OldEditText;
    MessageDlg('Введите правильное время'#10#13#13'Например '+TimeToStr(Now), mtWarning, [mbOk], 0);
    Exit;
  end;
  OffsetTime := NewTime - (MySeries.timeData[0] - trunc(MySeries.timeData[0]));
  for i:= 0 to MySeries.CountData -1 do
      MySeries.TimeData[i] := MySeries.TimeData[i] + OffsetTime;

  Form1.DrawSeriesOntoChart(ChartSeries,MySeries);

  Set_ParamProjectRecord();
end;

procedure TfrmSeriesParam.FormShow(Sender: TObject);
var
  k : integer;
begin
  for k := 1 to 3 do
    Form1.ChartArray[k,2].canvas.ReDrawBitmap;
end;

end.
