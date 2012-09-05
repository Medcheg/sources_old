unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, Buttons, MPIDeclaration,
  ComCtrls, ToolWin, ImgList, Menus;

type
  TForm1 = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton12: TToolButton;
    FilePopupMenu: TPopupMenu;
    NewPlanshetN: TMenuItem;
    nSaveShablonFile: TMenuItem;
    N3: TMenuItem;
    nPrintPreview: TMenuItem;
    nPrint: TMenuItem;
    N6: TMenuItem;
    nExit: TMenuItem;
    StatusBar1: TStatusBar;
    ToolButton22: TToolButton;
    nOpenShablonFile: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    ToolButton23: TToolButton;
    TrackBar1: TTrackBar;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    Panel4: TPanel;
    PanelChart: TPanel;
    PanelPole3: TPanel;
    Chart5: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Series5: TFastLineSeries;
    Series6: TFastLineSeries;
    Series7: TFastLineSeries;
    Series8: TFastLineSeries;
    Series9: TFastLineSeries;
    Series10: TFastLineSeries;
    Panel3: TPanel;
    Chart6: TChart;
    PanelPole2: TPanel;
    Chart3: TChart;
    FastLineSeries1: TFastLineSeries;
    FastLineSeries2: TFastLineSeries;
    FastLineSeries3: TFastLineSeries;
    FastLineSeries4: TFastLineSeries;
    FastLineSeries5: TFastLineSeries;
    FastLineSeries6: TFastLineSeries;
    FastLineSeries7: TFastLineSeries;
    FastLineSeries8: TFastLineSeries;
    FastLineSeries9: TFastLineSeries;
    FastLineSeries10: TFastLineSeries;
    Panel2: TPanel;
    Chart4: TChart;
    PanelPole1: TPanel;
    Chart1: TChart;
    FastLineSeries11: TFastLineSeries;
    FastLineSeries12: TFastLineSeries;
    FastLineSeries13: TFastLineSeries;
    FastLineSeries14: TFastLineSeries;
    FastLineSeries15: TFastLineSeries;
    FastLineSeries16: TFastLineSeries;
    FastLineSeries17: TFastLineSeries;
    FastLineSeries18: TFastLineSeries;
    FastLineSeries19: TFastLineSeries;
    FastLineSeries20: TFastLineSeries;
    Panel1: TPanel;
    Chart2: TChart;
    N2: TMenuItem;
    nSaveDataFile: TMenuItem;
    nOpenDataFile: TMenuItem;
    scPanel: TPanel;
    ScrollBar1: TScrollBar;
    PrintDialog1: TPrintDialog;
    ImageList1: TImageList;
    ToolButton13: TToolButton;
    procedure Chart1AfterDraw(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButtonClick(Sender: TObject);
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure Chart1Click(Sender: TObject);
    procedure nExitClick(Sender: TObject);
    procedure Chart2AfterDraw(Sender: TObject);
    procedure Chart2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Chart2Click(Sender: TObject);
    procedure ToolButton3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure NewPlanshetNClick(Sender: TObject);
    procedure nOpenShablonFileClick(Sender: TObject);
    procedure nSaveShablonFileClick(Sender: TObject);
    procedure nPrintPreviewClick(Sender: TObject);
    procedure nPrintClick(Sender: TObject);
    procedure Chart2DblClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nSaveDataFileClick(Sender: TObject);
    procedure nOpenDataFileClick(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure Chart2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

    MyTextHeight : Integer;
    oldChooseSeriesONChart : array [1..3] of Integer;

    MouseDownFirstTime     : Boolean;  // --- Первое нажатие мыши ---
    MouseDownSecondTime    : Boolean;  // --- Второе нажатие Крысы ---

    //---------------------------------
    MinTopTime             : Double;
    MinBottomTime          : Double;
    //---------------------------------

    FirstPointInArray      : LongInt;
    SecondPointInArray     : LongInt;

    fMinPlanshetTime       : Double;  // --- Минимальное  время на всем планшете ---
    fMaxPlanshetTime       : Double;  // --- Максимальное время на всем планшете ---
    TimeInOnePixel         : Double;  // --- Время Соответствующее толщине одного пикселя ---

    OldMousePosX           : Integer;  // --- Старое положение мыши на Чарте ---

    procedure Set_ScrollBarMaxAndMin();
    procedure Set_MinPlanshetTime(aValue : Double);
    procedure Set_MaxPlanshetTime(aValue : Double);
    procedure Set_ChartMaxMin(aMax, aMinT, aMinB: Double);
    procedure Set_Chart2Width();
    procedure Get_TwoCoordinatMouseDown(Shift: TShiftState; X, Y: Integer);

    function  SelfMouseMove(Shift: TShiftState; X, Y: Integer) : LongInt;
    procedure SelfChartClickAproximation();
    procedure SelfChartClickDeleteLine();
    procedure SelfChartClickSavePartialTable();
    procedure SelfChartClickPartialPrint();

    procedure HidePanelsComponents();

    procedure Set_Legend_Caption_Dialog_ListBox();
  public
    CaptionList       : array [1..3] of TList;
    LegendList        : array [1..3] of TList;
    SeriesList        : array [1..3] of TList;
    FileList          : TList;

    ChooseSeriesONChart    : array [1..3] of Integer;
    ChooseSeries           : array [1..3] of Integer;
    ChartArray             : array [1..3,1..2] of TChart;
    MyFastLineSeries       : array [1..3,0..9] of TFastLineSeries;

    NumberButtonDown  : Byte;
    procedure ClearTextOnStatusBar();
    procedure DrawSeriesOntoChart(FastLineSeries: TFastLineSeries;{ChartSeries : TChartSeries;} MySeries : TMySeries);
    property MinPlanshetTime : Double read fMinPlanshetTime write Set_MinPlanshetTime;
    property MaxPlanshetTime : Double read fMaxPlanshetTime write Set_MaxPlanshetTime;
  end;

var
  Form1: TForm1;

implementation

uses Unit_CaptionParam, Unit_LegentParam, Unit_PlanshetCreator,
  Unit_SeriesParam, Unit_TransformationParam, Unit_FiltrationParam,
  Unit_HeadingOfTheDiagram, Unit_PlanshetParam, Unit_ChoosDestop,
  Unit_SaveDialog, Unit_SaveSeriesToTable, Unit_PrintPartialSeries,
  Unit_PrintPreview, Unit_SaveType;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  i, k : integer;
begin
  DecimalSeparator := '.';
  ShortDateFormat  := 'dd.mm.yyyy';

  Caption          := Form1Caption + ' - []';

  for k := 1 to 3 do begin
    ChooseSeries[k]           := -1;
    ChooseSeriesONChart[k]    := -1;
  end;
  NumberPole                :=  -1;
  NumberButtonDown          :=  1;
  fMinPlanshetTime          :=  10000000;
  fMaxPlanshetTime          := -10000000;

  Chart1.BevelOuter := bvNone;

  for i:= 1 to 3 do begin
      CaptionList[i] := TList.Create;
      LegendList [i] := TList.Create;
      SeriesList [i] := TList.Create;
  end;
  FileList    := TList.Create;

  ChartArray[1,1] := Chart1;
  ChartArray[1,2] := Chart2;
  ChartArray[2,1] := Chart3;
  ChartArray[2,2] := Chart4;
  ChartArray[3,1] := Chart5;
  ChartArray[3,2] := Chart6;

 MyFastLineSeries[1,0] := FastLineSeries11;
 MyFastLineSeries[1,1] := FastLineSeries12;
 MyFastLineSeries[1,2] := FastLineSeries13;
 MyFastLineSeries[1,3] := FastLineSeries14;
 MyFastLineSeries[1,4] := FastLineSeries15;
 MyFastLineSeries[1,5] := FastLineSeries16;
 MyFastLineSeries[1,6] := FastLineSeries17;
 MyFastLineSeries[1,7] := FastLineSeries18;
 MyFastLineSeries[1,8] := FastLineSeries19;
 MyFastLineSeries[1,9] := FastLineSeries20;
 MyFastLineSeries[2,0] := FastLineSeries1;
 MyFastLineSeries[2,1] := FastLineSeries2;
 MyFastLineSeries[2,2] := FastLineSeries3;
 MyFastLineSeries[2,3] := FastLineSeries4;
 MyFastLineSeries[2,4] := FastLineSeries5;
 MyFastLineSeries[2,5] := FastLineSeries6;
 MyFastLineSeries[2,6] := FastLineSeries7;
 MyFastLineSeries[2,7] := FastLineSeries8;
 MyFastLineSeries[2,8] := FastLineSeries9;
 MyFastLineSeries[2,9] := FastLineSeries10;
 MyFastLineSeries[3,0] := Series1;
 MyFastLineSeries[3,1] := Series2;
 MyFastLineSeries[3,2] := Series3;
 MyFastLineSeries[3,3] := Series4;
 MyFastLineSeries[3,4] := Series5;
 MyFastLineSeries[3,5] := Series6;
 MyFastLineSeries[3,6] := Series7;
 MyFastLineSeries[3,7] := Series8;
 MyFastLineSeries[3,8] := Series9;
 MyFastLineSeries[3,9] := Series10;


  StatusBar1.Font.Size  := 10;
  StatusBar1.Font.Style := [fsBold];
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  frmChoosDestop.Visible := False;

  frmPlanshetParam.Set_FormParams();
  frmPlanshetParam.Set_ChartParam();
  frmPlanshetParam.sePoleCountChange(nil);
  // --- Центрирую BackGroundPanel
  //Image1.Left := (ClientWidth - Image1.Width) div 2;
  //Image1.Top  := ControlBar1.Height + (ClientHeight - ControlBar1.Height - Image1.Height) div 2;
  ToolBar1.Width := ControlBar1.Width;
  //BackGroundPanel.Left := (ClientWidth - BackGroundPanel.Width) div 2;
  //BackGroundPanel.Top  := ControlBar1.Height + (ClientHeight - ControlBar1.Height - BackGroundPanel.Height) div 2;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmChoosDestop.Close;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  i,k : Integer;
begin
  for k := 1 to 3 do begin
      for i := 0 to CaptionList[k].Count - 1 do begin TMyCaption(CaptionList[k].Items[0]).Free; CaptionList[k].Delete(0); end;
      for i := 0 to LegendList [k].Count - 1 do begin TLegend   (LegendList [k].Items[0]).Free; LegendList [k].Delete(0); end;
      for i := 0 to SeriesList [k].Count - 1 do begin TMySeries (SeriesList [k].Items[0]).Free; SeriesList [k].Delete(0); end;
  end;
  for i := 0 to FileList   .Count - 1 do begin TFile     (FileList   .Items[0]).Free; FileList   .Delete(0); end;
  //----------------------------------
  if Sender <> nil then  begin
    for k := 1 to 3 do begin
      CaptionList[k].Free;
      LegendList [k].Free;
      SeriesList [k].Free;
    end;
      FileList   .Free;
  end;
  //----------------------------------
  if sender = nil then begin
      frmPlanshetCreator.ListBox1.Clear;
      frmPlanshetCreator.ListBox2.Clear;
      frmPlanshetCreator.ListBox3.Clear;
      frmPlanshetCreator.ListBox4.Clear;
      frmPlanshetCreator.ListBox5.Clear;
      frmLegentParam    .ListBox1.Clear;
      frmCaptionParam   .ListBox1.Clear;
      for i:=1 to 3 do begin
        ChartArray[i,2].Repaint;
        ChartArray[i,1].Repaint;
        ChooseSeriesONChart[i] := -1;
        for k:=0 to 9 do
           MyFastLineSeries[i,k].Clear;
      end;
  end;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  if frmPlanshetParam.sePoleCount.Value = 0 then begin
    beep;
    MessageDlg('На пустом планшете нечего создавать , установите параметр "Количество полей" не нулевым',mtError, [mbOk],0);
    exit;
  end;
  frmPlanshetCreator.ShowModal;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
//  ToolButton1.Down := not ToolButton1.Down;
end;

procedure TForm1.ToolButtonClick(Sender: TObject);
begin
 MouseDownFirstTime  := false;
 MouseDownSecondTime := false;

  if (frmPlanshetParam.sePoleCount.Value = 0) then begin
    beep;
    MessageDlg('На пустом планшете нечего менять, установите параметр "Количество полей" не нулевым',mtError, [mbOk],0);
    exit;
  end;

 if (NumberPole             = -1) {or
    (ChooseSeriesONChart[1] = -1) and
    (ChooseSeriesONChart[2] = -1) and
    (ChooseSeriesONChart[3] = -1) }then begin
     beep;
     MessageDlg('Выберете поле на котором будет произведено действие ', mtInformation, [mbOk], 0);
     ToolButton3 .Down:=true;
     exit;
 end;

 ChartArray[NumberPole,1].Canvas.ReDrawBitmap;
 if NumberButtonDown <> TToolButton(Sender).Tag then
      case NumberButtonDown of
        1 : ;
        2 : frmCaptionParam.Close;
        3 : frmLegentParam.Close;
        4 : ;                             // --- Удаление срывов
        5 : frmFiltrationParam.Close;     // --- Сглаживание (фильтрация)
        6 : ;                             // --- Вырезание интервалов
        7 : frmTransformationParam.Close; // --- Трансформация (мультипликативная, аддитивная)
        8 : ;
        9 : ;
      end;

  NumberButtonDown    := TToolButton(Sender).Tag;

  case NumberButtonDown of
    1 : begin ToolButton3 .Down:=true; end;
    2 : begin ToolButton4 .Down:=true; ClearTextOnStatusBar(); frmCaptionParam.Show; end;
    3 : begin ToolButton5 .Down:=true; ClearTextOnStatusBar(); frmLegentParam.Show;     end;
    4 : begin ToolButton6 .Down:=true; end;
    5 : begin ToolButton7 .Down:=true; ClearTextOnStatusBar(); frmFiltrationParam.Show end;
    6 : begin ToolButton8 .Down:=true; end;
    7 : begin ToolButton9 .Down:=true; ClearTextOnStatusBar(); frmTransformationParam.Show; end;
    8 : begin ToolButton11.Down:=true; end;
    9 : begin ToolButton10.Down:=true; end;
  end;
end;

procedure TForm1.Get_TwoCoordinatMouseDown(Shift: TShiftState; X, Y: Integer);
var
  tempPos : LongInt;
begin
   if (not MouseDownFirstTime) and (not MouseDownSecondTime) then begin
            tempPos := SelfMouseMove(Shift, X, Y);
            if TempPos <> -1 then FirstPointInArray := TempPos;
   end;

   if (MouseDownFirstTime) and (not MouseDownSecondTime) then begin
            tempPos := SelfMouseMove(Shift, X, Y);
            if TempPos <> -1 then SecondPointInArray := TempPos;
            if SecondPointInArray < FirstPointInArray then SecondPointInArray := FirstPointInArray;
   end;
end;

procedure TForm1.Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  k       : Integer;
begin
  if FileList.Count = 0 then Exit; // --- Если не загрузил не одного файла то выходим ---

  // --- Очистка и отрисовка Второго чарта ----
  for k := 1 to 3 do begin
    ChartArray[k,2].canvas.ReDrawBitmap;
    ChooseSeriesONChart[k] := -1;
  end;
  // --- End of Очистка и отрисовка Второго чарта ----

  case NumberButtonDown of
    1 : SelfMouseMove(Shift, X, Y);
    2 : frmCaptionParam.ChartMouseMove(Shift, X, Y);
    3 : frmLegentParam.ChartMouseMove(Shift, X, Y);
    4 : Get_TwoCoordinatMouseDown(Shift, X, Y);
    5 : ;
    6 : Get_TwoCoordinatMouseDown(Shift, X, Y);
    7 : ;
    8 : Get_TwoCoordinatMouseDown(Shift, X, Y);
    9 : Get_TwoCoordinatMouseDown(Shift, X, Y);
  end;
end;

procedure TForm1.Chart1Click(Sender: TObject);
begin
  case NumberButtonDown of
    1 : ;
    2 : frmCaptionParam.ChartClick();
    3 : frmLegentParam.ChartClick();
    4 : SelfChartClickAproximation();
    5 : ;
    6 : SelfChartClickDeleteLine();
    7 : ;
    8 : SelfChartClickSavePartialTable();
    9 : SelfChartClickPartialPrint();
  end;
end;

procedure TForm1.Chart1AfterDraw(Sender: TObject);
var
 MyCaption    : TMyCaption;
 Legend       : TLegend;
 i,k          : integer;
begin
  if FileList.Count = 0 then Exit; // --- Если не загрузил не одного файла то выходим ---

  // --- Отрисовую все подписи на всем планшете ---
  for k:= 1 to 3 do begin
      for i:=0 to CaptionList[K].Count-1 do begin
          MyCaption := TMyCaption(CaptionList[K].Items[i]);

          MyCaption.StartPos := point(ChartArray[K,1].Series[0].CalcXPosValue(MyCaption.StartTimePos),
                                      ChartArray[K,1].Series[0].CalcYPosValue(MyCaption.YStartValue));
                                      //(ChartSeries.YValues[Result] )/MySeries.NormalizeCoef
          MyCaption.EndPos   := point(ChartArray[K,1].Series[0].CalcXPosValue(MyCaption.EndTimePos),
                                      ChartArray[K,1].Series[0].CalcYPosValue(MyCaption.YEndValue));

          {MyCaption.StartPos := point(ChartArray[K,1].Series[0].CalcXPosValue(MyCaption.StartTimePos),
                                      MyCaption.StartPos.y);
          MyCaption.EndPos   := point(ChartArray[K,1].Series[0].CalcXPosValue(MyCaption.EndTimePos),
                                      MyCaption.EndPos.y);}
          if (MyCaption.EndPos.y <> -1) and (MyCaption.YEndValue <> -1) then MyCaption.Draw;
      end;
      // --- Отрисовую все легенды на всем планшете ---
      for i:=0 to LegendList[K].Count-1 do begin
          Legend := TLegend(LegendList[K].Items[i]);

          Legend.StartPos := point(Form1.ChartArray[K,1].Series[0].CalcXPosValue(Legend.StartTimePos),
                                   Form1.ChartArray[K,1].ChartRect.Bottom);
          Legend.EndPos   := point(Form1.ChartArray[K,1].Series[0].CalcXPosValue(Legend.EndTimePos),
                                   Form1.ChartArray[K,1].BottomAxis.PosAxis);

          if Legend.EndTimePos <> 0 then
                     Legend.Draw;
     end;
  end;
end;

procedure TForm1.nExitClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.Chart2AfterDraw(Sender: TObject);
var
 i, k         : Integer;
 MySeries     : TMySeries;
 TempPosX     : Integer;
 TempPosY     : Integer;
 OutText      : String;

begin
  if FileList.Count = 0 then Exit; // --- Если не загрузил не одного файла то выходим ---

  // --- Отрисовую второй заголовок ----
  for k:= 1 to 3 do begin
      if SeriesList[k].Count <> 0 then // --- Если есть серии на Чарте ---
          With ChartArray[k,2].Canvas do begin
            Font.Size  := 11;
            Font.Style := [fsBold];
            Pen.Color := clBlack;
            Pen.Width := 2;

            MoveTo(0                    , ChartArray[k,1].ChartRect.top);
            LineTo(ChartArray[k,2].Width, ChartArray[k,1].ChartRect.top);

            MoveTo(0                    , ChartArray[k,1].ChartRect.Bottom);
            LineTo(ChartArray[k,2].Width, ChartArray[k,1].ChartRect.Bottom);

            for i:= 0 to SeriesList[k].Count - 1 do begin
                MySeries := TMySeries(SeriesList[k].Items[i]);

                Pen.Color := MySeries.PenColor;
                Pen.Width := MySeries.PenWidth;
                Pen.Style := MySeries.PenStyle;

                MoveTo((i+1)*MyTextHeight*2, ChartArray[k,1].ChartRect.top);
                LineTo((i+1)*MyTextHeight*2, ChartArray[k,1].ChartRect.Bottom);

                // --- Выдиляем выделенную серию прямоугольниками ----
                if ChooseSeries[k] = i then begin
                   Brush.Color := MySeries.PenColor;
                   FillRect(Rect( (i  )*MyTextHeight*2 + 2, ChartArray[k,1].ChartRect.top-10,
                                  (i+1)*MyTextHeight*2 - 2, ChartArray[k,1].ChartRect.top));

                   FillRect(Rect( (i  )*MyTextHeight*2 + 2, ChartArray[k,1].ChartRect.Bottom,
                                  (i+1)*MyTextHeight*2 - 2, ChartArray[k,1].ChartRect.Bottom + 10));
                end;
                // --- End of Выдиляем выделенную серию прямоугольниками ----

                // --- Вывожу надписи ----
                TempPosX := (i+1)*MyTextHeight*2 - MyTextHeight;
                TempPosY :=  ChartArray[k,1].ChartRect.Top + (ChartArray[k,1].ChartRect.Bottom - ChartArray[k,1].ChartRect.Top + TextWidth(MySeries.Name)) div 2;
                RotateLabel(TempPosX-2, TempPosY, MySeries.Name, 90);

                OutText := floatToStrF(MySeries.min, ffFixed, 9,3);
                RotateLabel(TempPosX-2, ChartArray[k,1].ChartRect.Bottom - 5 ,OutText ,90);

                OutText := floatToStrF(MySeries.max, ffFixed, 9,3);
                RotateLabel(TempPosX-2, ChartArray[k,1].ChartRect.Top + 5 + TextWidth(OutText), OutText,90);
            end;
          end; // --- With PaintBox1.Canvas do begin ---
  end;
  Set_ScrollBarMaxAndMin();
end;

procedure TForm1.Chart2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  i, k         : integer;
  NumPole      : Integer;
begin
  if FileList.Count = 0 then Exit; // --- Если не загрузил не одного файла то выходим ---

  NumPole := -1;
  if TComponent(Sender).Name = 'Chart2' then  NumPole := 1;
  if TComponent(Sender).Name = 'Chart4' then  NumPole := 2;
  if TComponent(Sender).Name = 'Chart6' then  NumPole := 3;
  if NumPole = -1 then exit;

  if SeriesList[NumPole].Count <> 0 then // --- Если есть серии на Чарте ---
    if (y > ChartArray[NumPole,1].ChartRect.top) and (y < ChartArray[NumPole,1].ChartRect.Bottom) then begin
       for i:= 0 to SeriesList[NumPole].Count - 1 do begin
           if (x > i*MyTextHeight*2) and (x < (i+1)*MyTextHeight*2) then begin
             if ChooseSeriesONChart[NumPole] <> OldChooseSeriesONChart[NumPole] then begin
                 with ChartArray[NumPole,2].Canvas do begin
                     ReDrawBitmap;
                     Pen.Color := MyFastLineSeries[NumPole,i].LinePen.Color;
                     Pen.Style := psSolid;
                     MoveTo(i    *MyTextHeight*2+1, ChartArray[NumPole,1].ChartRect.top+1);
                     LineTo((i+1)*MyTextHeight*2-1, ChartArray[NumPole,1].ChartRect.top+1);
                     LineTo((i+1)*MyTextHeight*2-1, ChartArray[NumPole,1].ChartRect.Bottom-1);
                     LineTo(i    *MyTextHeight*2+1, ChartArray[NumPole,1].ChartRect.Bottom-1);
                     LineTo(i    *MyTextHeight*2+1, ChartArray[NumPole,1].ChartRect.top+2);

                     LineTo((i+1)*MyTextHeight*2-2, ChartArray[NumPole,1].ChartRect.top+2);
                     LineTo((i+1)*MyTextHeight*2-2, ChartArray[NumPole,1].ChartRect.Bottom-2);
                     LineTo(i    *MyTextHeight*2+2, ChartArray[NumPole,1].ChartRect.Bottom-2);
                     LineTo(i    *MyTextHeight*2+2, ChartArray[NumPole,1].ChartRect.top+2);

                     OldChooseSeriesONChart[NumPole] := ChooseSeriesONChart[NumPole];
                 end;
             end;
             ChooseSeriesONChart[NumPole] := i;
             break;
           end;// else for k := 1 to 3 do ChooseSeriesONChart[k] := -1;
       end; // --- for i:= 0 to SeriesList[NumPole].Count - 1 do begin
    end else for k := 1 to 3 do ChooseSeriesONChart[k] := -1; // --- if (y > ChartArray[NumPole,1].ChartRect.top) and (y < ChartArray[NumPole,1].ChartRect.Bottom) then begin

    if ChooseSeriesONChart[NumPole] = -1 then begin
        // --- Очистка и отрисовка Второго чарта ----
        for i := 1 to 3 do ChartArray[i,2].canvas.ReDrawBitmap;
        // --- End of Очистка и отрисовка Второго чарта ----
    end;
end;

procedure TForm1.Chart2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
    i : integer;
begin
        // --- Очистка и отрисовка Второго чарта ----
        for i := 1 to 3 do ChartArray[i,2].canvas.ReDrawBitmap;
        // --- End of Очистка и отрисовка Второго чарта ----
end;

procedure TForm1.Chart2DblClick(Sender: TObject);
begin
  if TComponent(Sender).Name = 'Chart2' then  NumberPole := 1;
  if TComponent(Sender).Name = 'Chart4' then  NumberPole := 2;
  if TComponent(Sender).Name = 'Chart6' then  NumberPole := 3;

  Set_Legend_Caption_Dialog_ListBox();


  if ChooseSeriesONChart[NumberPole] <> -1 then begin
     frmSeriesParam.SetParam( TMySeries(SeriesList[NumberPole].Items[ChooseSeriesONChart[NumberPole]]),
                              MyFastLineSeries[NumberPole,ChooseSeriesONChart[NumberPole]]);
     frmSeriesParam.ShowModal;
  end;
  ToolButton3MouseMove(self, [], -100,-100);
end;

procedure TForm1.Set_Legend_Caption_Dialog_ListBox();
begin
  if frmLegentParam .LegendDraw  then frmLegentParam .DeleteLegend() ;
  if frmCAptionParam.CaptionDraw then frmCaptionParam.DeleteCaption();
  frmCaptionParam.SetParamListBox;
  frmLegentParam .SetParamListBox;
end;

procedure TForm1.Chart2Click(Sender: TObject);
var
  k : integer;
begin
   if (ChooseSeriesONChart[1]=-1) and
      (ChooseSeriesONChart[2]=-1) and
      (ChooseSeriesONChart[3]=-1) then exit;

   if TComponent(Sender).Name = 'Chart2' then  NumberPole := 1;
   if TComponent(Sender).Name = 'Chart4' then  NumberPole := 2;
   if TComponent(Sender).Name = 'Chart6' then  NumberPole := 3;


   ClearTextOnStatusBar();
   MouseDownFirstTime  := false;
   MouseDownSecondTime := false;

   if ChooseSeriesONChart[NumberPole] = -1 then exit;

   for k := 1 to 3 do ChooseSeries[k] := -1;

   Set_Legend_Caption_Dialog_ListBox();

   ChooseSeries[NumberPole]    := ChooseSeriesONChart[NumberPole];
   StatusBar1.Panels[0].Text   := '  Поле : ' + IntToStr(NumberPole);
   StatusBar1.Panels[1].Text   := '  Кривая : ' + IntToStr(ChooseSeries[NumberPole]+1);

   //ChartArray[NumberPole,2].Repaint;

   for k := 1 to 3 do begin
     ChartArray[k,1].Repaint;
     ChartArray[k,2].Repaint;
   end;
   {ChartArray[1,2].RePaint;
   ChartArray[2,2].RePaint;
   ChartArray[3,2].RePaint;}
end;

procedure TForm1.DrawSeriesOntoChart(FastLineSeries: TFastLineSeries;//ChartSeries: TChartSeries;
  MySeries: TMySeries);
var
  i : Integer;
begin
  FastLineSeries.Clear;
  // --- Устанавливаю максимальный разброс времени для масштабирования на чарте ---
  if TrackBar1.Position = 0 then begin
    ChartParam.OldScaledMaxVisibleTime := ChartParam.MaxVisibleTimeOnChart;
    ChartParam.   ScaledMaxVisibleTime  := ChartParam.MaxVisibleTimeOnChart;
  end;

  Set_ChartMaxMin(MinPlanshetTime + ChartParam.ScaledMaxVisibleTime  , MinPlanshetTime,0);
  MySeries.NormalizeCoef := 1 / (MySeries.Max - MySeries.Min);
  MySeries.OffsetY       := - MySeries.Min * MySeries.NormalizeCoef;


  for i := 0 to MySeries.CountData - 1 do
    FastLineSeries.Addxy(MySeries.StartDateTime + MySeries.TimeData[i], MySeries.Data[i]*MySeries.NormalizeCoef  + MySeries.OffsetY) ;

  FastLineSeries.LinePen.Color := MySeries.PenColor;
  FastLineSeries.LinePen.Style := MySeries.PenStyle;
  FastLineSeries.LinePen.Width := MySeries.PenWidth;

  Set_Chart2Width();
  for i := 1 to 3 do Form1.ChartArray[i,2].Repaint;
  Application.ProcessMessages;
end;

procedure TForm1.ToolButton3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var k : integer;
begin
  // --- Очистка и отрисовка Второго чарта ----
  for k := 1 to 3 do begin
    ChartArray[k,2].canvas.ReDrawBitmap;
    ChooseSeriesONChart[k] := -1;
  end;
  // --- End of Очистка и отрисовка Второго чарта ----
end;

function TForm1.SelfMouseMove(Shift: TShiftState; X, Y: Integer) : LongInt;
var
  MySeries       : TMySeries;
  ChartSeries    : TFastLineSeries;
  YPos           : Integer;
  XPos           : Integer;
  i              : Integer;
  ArrayIndex     : LongInt;

  CurTime        : Double;
  XValue, YValue : Double;

  BeginTime,EndTime  : Double;
  StepX              : Integer;
  CurrentChart       : TChart;

begin
  Result := -1;
  CurrentChart := ChartArray[NumberPole,1];
  if (ChooseSeries[NumberPole] = -1) or (SeriesList[NumberPole].Count = 0) then exit;


     if OldMousePosX <> x then
         with  CurrentChart.Canvas do begin
            if (X>CurrentChart.ChartRect.Left) and (X < CurrentChart.ChartRect.Right) and (Y > CurrentChart.ChartRect.Top) and (Y < CurrentChart.ChartRect.Bottom) then begin
                MySeries    := TMySeries(SeriesList[NumberPole].Items[ChooseSeries[NumberPole]]);
                ChartSeries := TFastLineSeries(CurrentChart.SeriesList.Items[ChooseSeries[NumberPole]]);
                // ----- Нахожу позицию в масиве ----
                    CurTime    := CurrentChart.TopAxis.CalcPospoint(x);
                    ArrayIndex := MySeries.LocateTimeData(CurTime);
                    if ArrayIndex = -1 then exit;
                // ----- End Of Нахожу позицию в масиве ----}
                RedrawBitmap;
                Result := ArrayIndex;

                // --- Выводим точку на Серию -----

                Pen.Width := 1;
                Pen.Color := clBlack;
                Pen.Style := psSolid;

                YPos := CurrentChart.Series[ChooseSeries[NumberPole]].CalcYPosValue(ChartSeries.YValues[Result]);
                MoveTo(CurrentChart.ChartRect.Left,YPos);
                LineTo(x - 10               ,YPos);
                MoveTo(x + 10               ,YPos);
                LineTo(CurrentChart.ChartRect.Right,YPos);

                MoveTo(x,CurrentChart.ChartRect.Top);
                LineTo(x, YPos - 10 );
                MoveTo(x, YPos + 10 );
                LineTo(x, CurrentChart.ChartRect.Bottom);
                Pen.Width := 3;
                Ellipse(x-4,yPos-4, x+4,yPos+4);

                Pen.Width := 1;
                // --- Если на жата кнопка апроксимации ---
                if (NumberButtonDown = 4) or (NumberButtonDown = 6) or (NumberButtonDown = 8) or (NumberButtonDown = 9) then begin
                  if MouseDownFirstTime then begin
                      Pen.Width := 6;
                      Pen.Color := ChartSeries.LinePen.Color;

                      // --- Определяю шаг между точками масива------
                      BeginTime := ChartSeries.XValue[FirstPointInArray];
                      EndTime   := ChartSeries.XValue[ArrayIndex];
                      if BeginTime - EndTime = 0  then Exit;
                      StepX     :=  Trunc( (Result-FirstPointInArray)
                                           /( CurrentChart.Series[ChooseSeries[NumberPole]].CalcXPosValue(EndTime)
                                             -CurrentChart.Series[ChooseSeries[NumberPole]].CalcXPosValue(BeginTime)
                                            ));


                      // --- Передвигаюсь в первую точку ---
                      XValue := ChartSeries.XValue[FirstPointInArray];
                      YValue := ChartSeries.YValue[FirstPointInArray];
                      xPos   := CurrentChart.Series[ChooseSeries[NumberPole]].CalcXPosValue(XValue);
                      YPos   := CurrentChart.Series[ChooseSeries[NumberPole]].CalcYPosValue(YValue);

                      MoveTo(xPos, yPos);

                      // --- Отрисовую все точки  ---
                      i:=FirstPointInArray;
                      if StepX = 0 Then StepX:=1;
                      While i <= Result do begin
                         XValue := ChartSeries.XValue[i];
                         YValue := ChartSeries.YValue[i];
                         xPos   := CurrentChart.Series[ChooseSeries[NumberPole]].CalcXPosValue(XValue);
                         YPos   := CurrentChart.Series[ChooseSeries[NumberPole]].CalcYPosValue(YValue);
                         LineTo(xPos, yPos);
                         i:=i+StepX;
                      end;
                  end;
                end;

                Pen.Width    := 1;
                OldMousePosX := x;
                // --- Выводим Текст в статус бар -----
                StatusBar1.Panels[0].Text := '  Поле : ' + IntToStr(NumberPole);
                StatusBar1.Panels[1].Text := '  Кривая : ' + IntToStr(ChooseSeries[NumberPole]+1);
                StatusBar1.Panels[2].Text := '  Реальное время : ' + DateTimeToStr(MySeries.StartDateTime + CurTime);
                StatusBar1.Panels[3].Text := '  Абсолютное время : ' + TimeToStr(CurrentChart.BottomAxis.CalcPospoint(x));
                StatusBar1.Panels[4].Text := '  Значение кривой : '  + floatToStrF((ChartSeries.YValues[Result] - MySeries.OffsetY)/MySeries.NormalizeCoef, ffFixed,10,4);
            end;
         end;

end;

procedure TForm1.SelfChartClickAproximation;
var
  MySeries     : TMySeries;
  CoefK, CoefB : Double;
  i            : Integer;
begin
    if not MouseDownFirstTime then begin
        MouseDownFirstTime := true;
    end else begin
        MouseDownSecondTime := true;
        ToolButton3.Down    := True;

        NumberButtonDown := 1;
        //MouseDownFirstTime := False;
        //MouseDownSecondTime := False;

        if SecondPointInArray = FirstPointInArray then Exit;
        CoefK :=    (   ChartArray[NumberPole,1].series[ChooseSeries[NumberPole]].YValue[SecondPointInArray]
                     -  ChartArray[NumberPole,1].series[ChooseSeries[NumberPole]].YValue[FirstPointInArray])
                   /(SecondPointInArray - FirstPointInArray);
        CoefB := ChartArray[NumberPole,1].series[ChooseSeries[NumberPole]].YValue[FirstPointInArray];

        MySeries := TMySeries(SeriesList[NumberPole].Items[ChooseSeries[NumberPole]]);

        for i:=0 to SecondPointInArray - FirstPointInArray  do
            MySeries.Data[i+FirstPointInArray] := (CoefB + CoefK*i- MySeries.OffsetY)/MySeries.NormalizeCoef;


        //ChartArray[NumberPole,1].series[ChooseSeries[NumberPole]]
        DrawSeriesOntoChart(MyFastLineSeries[NumberPole,Form1.ChooseSeries[NumberPole]],MySeries);
    end;
end;

procedure TForm1.SelfChartClickDeleteLine;
var
   MySeries       : TMySeries;
   i              : Integer;
begin
    if not MouseDownFirstTime then begin
        MouseDownFirstTime := true;
    end else begin
        MouseDownSecondTime := true;
        ToolButton3.Down    := True;

        MySeries := TMySeries(SeriesList[NumberPole].Items[ChooseSeries[NumberPole]]);

        if FirstPointInArray  < 7                      then FirstPointInArray := 0; // ---Проверка попал ли я в начало координат ---
        if SecondPointInArray > MySeries.CountData - 17 then SecondPointInArray := MySeries.CountData; // ---Проверка попал ли я в начало координат ---

        for i:=FirstPointInArray to MySeries.CountData - (SecondPointInArray - FirstPointInArray)  do begin
           MySeries.Data[i]     := MySeries.Data    [i+SecondPointInArray - FirstPointInArray];
           //MySeries.TimeData[i] := MySeries.TimeData[i+SecondPointInArray - FirstPointInArray];
        end;
        MySeries.CountData := MySeries.CountData - (SecondPointInArray - FirstPointInArray);


        //ChartArray[NumberPole,1].series[ChooseSeries[NumberPole]]
        DrawSeriesOntoChart(MyFastLineSeries[NumberPole,Form1.ChooseSeries[NumberPole]],MySeries);
        NumberButtonDown := 1;
    end;
end;

procedure TForm1.SelfChartClickSavePartialTable;
var
   MySeries       : TMySeries;
begin
    if not MouseDownFirstTime then begin
        MouseDownFirstTime := true;
    end else begin
        MouseDownSecondTime := true;
        ToolButton3.Down    := True;

        MySeries := TMySeries(SeriesList[NumberPole].Items[ChooseSeries[NumberPole]]);

        frmSaveSeriesToTable.Set_Param(MySeries, FirstPointInArray, SecondPointInArray);
        frmSaveSeriesToTable.ShowModal;
        NumberButtonDown := 1;
    end;
end;

procedure TForm1.SelfChartClickPartialPrint;
var
   MySeries       : TMySeries;
begin
    if not MouseDownFirstTime then begin
        MouseDownFirstTime := true;
    end else begin
        MouseDownSecondTime := true;
        ToolButton3.Down    := True;

        MySeries := TMySeries(SeriesList[NumberPole].Items[ChooseSeries[NumberPole]]);
        frmPrintPartialSeries.Set_Param(MySeries, FirstPointInArray, SecondPointInArray);
        frmPrintPartialSeries.ShowModal;
        NumberButtonDown := 1;
    end;
end;

procedure TForm1.Set_ScrollBarMaxAndMin();
var
//  VisibleTimeOnChart : Double;
  BottomAxisWidth    : Integer;
  ScrollBar1Max      : Int64;
begin
  if  (ChartParam.ScaledMaxVisibleTime = 0) then exit;
//  if  (NumberPole = -1) or (ChartParam.ScaledMaxVisibleTime = 0) then exit;
//  BottomAxisWidth    := ChartArray[NumberPole,1].ChartRect.Right - ChartArray[NumberPole,1].ChartRect.Left;
  BottomAxisWidth    := ChartArray[1,1].ChartRect.Right - ChartArray[1,1].ChartRect.Left;
  if BottomAxisWidth = 0 then exit;

  {if ChartArray[NumberPole,1].TopAxis.Maximum - ChartArray[NumberPole,1].TopAxis.Minimum > MaxPlanshetTime - MinPlanshetTime then begin
    ChartArray[NumberPole,1].TopAxis.Maximum := MaxPlanshetTime;
    ChartArray[NumberPole,1].TopAxis.Minimum := MinPlanshetTime;
  //  MaxVisibleTime         := ChartArray[NumberPole,1].TopAxis.Maximum - ChartArray[NumberPole,1].TopAxis.Minimum;
  end;}
//  VisibleTimeOnChart := ChartArray[NumberPole,1].TopAxis.Maximum - ChartArray[NumberPole,1].TopAxis.Minimum;
//  VisibleTimeOnChart := ChartArray[1,1].TopAxis.Maximum - ChartArray[1,1].TopAxis.Minimum;


   TimeInOnePixel     :=  ChartParam.ScaledMaxVisibleTime/ BottomAxisWidth;

  ScrollBar1.Min      := -10;

  ScrollBar1Max := (trunc((MaxPlanshetTime - MinPlanshetTime) / TimeInOnePixel) - BottomAxisWidth - ScrollBar1.Min)*2;

  if ScrollBar1Max < 800            then ScrollBar1Max := 800;
  if ScrollBar1Max >= High(Integer) then ScrollBar1Max := High(Integer);

  ScrollBar1.Max      := ScrollBar1Max;

  // --- Установка позиции ScrollBar ----
  //if ScrollBar1.Position <> Round(ChartArray[1,1].BottomAxis.Minimum / TimeInOnePixel)
  //  then
  //     ScrollBar1.Position := Round(ChartArray[1,1].BottomAxis.Minimum / TimeInOnePixel)
  //  else
       ScrollBar1.Position := Round(ChartArray[1,1].BottomAxis.Minimum / TimeInOnePixel);
       ScrollBar1Change(nil);
end;

procedure TForm1.Set_MaxPlanshetTime(aValue: Double);
begin
  if fMaxPlanshetTime < aValue then fMaxPlanshetTime := aValue;
end;

procedure TForm1.Set_MinPlanshetTime(aValue: Double);
begin
  if fMinPlanshetTime > aValue then fMinPlanshetTime := aValue;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  max       : Double;
begin
 if not PanelChart.Visible then begin
   ScrollBar1.Position := -10;
   exit;
 end;

  minTopTime    := MinPlanshetTime + ScrollBar1.Position * TimeInOnePixel;
  minBottomTime :=                   ScrollBar1.Position * TimeInOnePixel;

  max       := MinTopTime + ChartParam.ScaledMaxVisibleTime - ScrollBar1.Min * TimeInOnePixel * 2;

  Set_ChartMaxMin(max, minTopTime, minBottomTime);
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     // ----- Показать заголовок планшет --------
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TForm1.Set_ChartMaxMin(aMax, aMinT, aMinB: Double);
begin
  Form1.ChartArray[1,1].BottomAxis.SetMinMax(aMinB, aMinB + aMax-aMinT);
  Form1.ChartArray[1,1].TopAxis   .SetMinMax(aMinT, aMax);

  if frmPlanshetParam.sePoleCount.Value >= 2 then begin
    Form1.ChartArray[2,1].BottomAxis.SetMinMax(aMinB, aMinB + aMax-aMinT);
    Form1.ChartArray[2,1].TopAxis   .SetMinMax(aMinT, aMax);
    {Form1.ChartArray[2,1].TopAxis   .Maximum := Form1.ChartArray[1,1].TopAxis   .Maximum;
    Form1.ChartArray[2,1].BottomAxis.Maximum := Form1.ChartArray[1,1].BottomAxis.Maximum;
    Form1.ChartArray[2,1].TopAxis   .Minimum := Form1.ChartArray[1,1].TopAxis   .Minimum;
    Form1.ChartArray[2,1].BottomAxis.Minimum := Form1.ChartArray[1,1].BottomAxis.Minimum;}
  end;
  if frmPlanshetParam.sePoleCount.Value = 3 then begin
    Form1.ChartArray[3,1].BottomAxis.SetMinMax(aMinB, aMinB + aMax-aMinT);
    Form1.ChartArray[3,1].TopAxis   .SetMinMax(aMinT, aMax);
    {Form1.ChartArray[3,1].TopAxis   .Maximum := Form1.ChartArray[1,1].TopAxis   .Maximum;
    Form1.ChartArray[3,1].BottomAxis.Maximum := Form1.ChartArray[1,1].BottomAxis.Maximum;
    Form1.ChartArray[3,1].TopAxis   .Minimum := Form1.ChartArray[1,1].TopAxis   .Minimum;
    Form1.ChartArray[3,1].BottomAxis.Minimum := Form1.ChartArray[1,1].BottomAxis.Minimum;}
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
 if not PanelChart.Visible then begin
   TrackBar1.Position := 0;
   exit;
 end;

  if TrackBar1.Position = 0 then begin
    ChartParam.OldScaledMaxVisibleTime  := ChartParam.MaxVisibleTimeOnChart;
    ChartParam.   ScaledMaxVisibleTime  := ChartParam.MaxVisibleTimeOnChart;
  end;
///// ?????????
  //ChartParam.ScaledMaxVisibleTime       := (MaxPlanshetTime - MinPlanshetTime) - TrackBar1.Position*(MaxPlanshetTime - MinPlanshetTime)/TrackBar1.Max;
  ChartParam.ScaledMaxVisibleTime       := ChartParam.MaxVisibleTimeOnChart - TrackBar1.Position*ChartParam.MaxVisibleTimeOnChart/TrackBar1.Max;
///// ?????????
  if ChartParam.OldScaledMaxVisibleTime  = ChartParam.ScaledMaxVisibleTime then exit;
     ChartParam.OldScaledMaxVisibleTime := ChartParam.ScaledMaxVisibleTime;

  Set_ScrollBarMaxAndMin();

  // --- Установка шага ---
//  increment := (ChartArray[NumberPole,1].BottomAxis.Maximum - ChartArray[NumberPole,1].BottomAxis.Minimum)/10;

//  for k := 1 to 3 do begin
//      ChartArray[k,1].BottomAxis.Increment := increment;
//      ChartArray[k,1].TopAxis   .Increment := increment;
//  end;
end;

procedure TForm1.ClearTextOnStatusBar;
begin
    StatusBar1.Panels[0].Text := '  Поле : ' + IntToStr(NumberPole);
    StatusBar1.Panels[1].Text := '  Кривая : ';
    StatusBar1.Panels[2].Text := '  Реальное время : ';
    StatusBar1.Panels[3].Text := '  Абсолютное время : ';
    StatusBar1.Panels[4].Text := '  Значение кривой : ';
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     // ----- Показать заголовок планшет --------
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TForm1.ToolButton22Click(Sender: TObject);
begin
  frmHeadingOfTheDiagram.ShowModal;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     // ----- Спрятать усе --------
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TForm1.HidePanelsComponents;
begin
//  ToolBar2.Visible   := False;
//  TrackBar1.Visible  := False;
  PanelChart.Visible := False;
  frmPlanshetParam.sePoleCount.Value  := 0;
  /////
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     // ----- Новый планшет --------
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TForm1.NewPlanshetNClick(Sender: TObject);
begin
  // -----  Проверка на работу с предыдущим проктом -----------------
    if frmPlanshetParam.sePoleCount.Value <> 0 then begin
       beep;
       if MessageDlg('Завершить текущий сеанс работы с проектом ?', mtWarning, [mbOk, mbCancel],0) = mrCancel then exit;
    end;
  // ----------------------
   if NumberButtonDown <> 1 then ToolButtonClick(ToolButton3);
  // ----------------------
  ToolButton3.Down := True;
  HidePanelsComponents();
  FormDestroy(nil);
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TForm1.nOpenDataFileClick(Sender: TObject);
var
  FileName : String;
  TempFileName : String;
  i        : integer;
  PosPoint : integer;
begin
  // -----  Проверка на работу с предыдущим проктом -----------------
    if frmPlanshetParam.sePoleCount.Value <> 0 then begin
       beep;
       if MessageDlg('Завершить текущий сеанс работы с проектом ?', mtWarning, [mbOk, mbCancel],0) = mrCancel
          then exit
          else FormDestroy(nil);
    end;
  // ----------------------
   if NumberButtonDown <> 1 then ToolButtonClick(ToolButton3);
  // ----------------------
  OpenDialog1.Filter :='Файлы проектов (*.prj)|*.prj';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Проекты\';

  if OpenDialog1.Execute then begin
     FileName := '';
     TempFileName := ExtractFileName(OpenDialog1.FileName);
     if ExtractFileExt(TempFileName) = '' then FileName := ExtractFileName(TempFileName)
     else begin
        PosPoint     := -1;
        for i := Length(TempFileName) downto 1 do
          if TempFileName[i] = '.' then begin
            PosPoint := i-1;
            break;
          end;
        for i:= 1 to PosPoint do FileName := FileName + TempFileName[i];
     end;
     caption := Form1Caption + ' - ['+ExtractFileName(OpenDialog1.FileName)+']';
     frmSaveDialog.LoadShablonPlanshet(ExtractFilePath(OpenDialog1.FileName), FileName, True);
     SetCurrentDir(ExtractFilePath(OpenDialog1.FileName));
     frmPlanshetParam  .Set_FormParams();
     frmPlanshetParam  .Set_ChartParam();
     frmPlanshetParam  .sePoleCountChange(nil);
     frmPlanshetCreator.SetupDataProject();
     frmPlanshetParam  .SpinEdit1Change(Self);
  end;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TForm1.nSaveDataFileClick(Sender: TObject);
begin
  frmSaveDialog.ShowModal;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TForm1.nOpenShablonFileClick(Sender: TObject);
var
  FileName : String;
  TempFileName : String;
  i        : integer;
  PosPoint : integer;
begin
  // -----  Проверка на работу с предыдущим проктом -----------------
    if frmPlanshetParam.sePoleCount.Value <> 0 then begin
       beep;
       if MessageDlg('Завершить текущий сеанс работы с проектом ?', mtWarning, [mbOk, mbCancel],0) = mrCancel then exit
                                                                                                              else FormDestroy(nil);
    end;
  // ----------------------
  OpenDialog1.Filter     := 'Файлы шаблона (*.shab)|*.shab';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Шаблоны проектов\';

  if OpenDialog1.Execute then begin
     FileName := '';
     TempFileName := ExtractFileName(OpenDialog1.FileName);
     if ExtractFileExt(TempFileName) = '' then FileName := ExtractFileName(TempFileName)
     else begin
        PosPoint     := -1;
        for i := Length(TempFileName) downto 1 do
          if TempFileName[i] = '.' then begin
            PosPoint := i-1;
            break;
          end;
        for i:= 1 to PosPoint do FileName := FileName + TempFileName[i];
     end;

     frmSaveDialog.LoadShablonPlanshet(ExtractFilePath(OpenDialog1.FileName), FileName, False);
     frmPlanshetParam.Set_FormParams();
     frmPlanshetParam.Set_ChartParam();
     frmPlanshetParam.sePoleCountChange(nil);
  end;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TForm1.nSaveShablonFileClick(Sender: TObject);
var
  FileName : String;
  TempFileName : String;
  i        : integer;
  PosPoint : integer;
begin
  // --- Параметры Саве Диалога ----
  SaveDialog1.Filter     := 'Файлы шаблона (*.shab)|*.shab';
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Шаблоны проектов\';
  if SaveDialog1.Execute then begin
     FileName := '';
     TempFileName := ExtractFileName(SaveDialog1.FileName);
     if ExtractFileExt(TempFileName) = '' then FileName := ExtractFileName(TempFileName)
     else begin
        PosPoint     := -1;
        for i := Length(TempFileName) downto 1 do
          if TempFileName[i] = '.' then begin
            PosPoint := i-1;
            break;
          end;
        for i:= 1 to PosPoint do FileName := FileName + TempFileName[i];
     end;
     if frmSaveDialog.SaveShablonPlanshet(ExtractFilePath(SaveDialog1.FileName), FileName, False) then nSaveShablonFileClick(self);
  end;
end;

procedure TForm1.nPrintPreviewClick(Sender: TObject);
begin
  frmPrintPreview.ShowModal;
end;

procedure TForm1.nPrintClick(Sender: TObject);
begin
  if PrintDialog1.Execute then begin
     frmPrintPreview.PrintDocument;
  end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  frmPlanshetParam.ShowModal;
end;

procedure TForm1.Set_Chart2Width;
var
 k : integer;
 MaxWidth      : Integer;
 MaxWidth1     : Integer;
 MaxWidth2     : Integer;
 MaxWidth3     : Integer;
begin
  for k:= 1 to 3 do begin
     ChartArray[k,2].Canvas.Font.Size  := 11;
     ChartArray[k,2].Canvas.Font.Style := [fsBold];
  end;
  MyTextHeight := ChartArray[1,2].Canvas.TextHeight('0');
  // --- Виставляю ширину заголовка ----------------------
  MaxWidth1 := MyTextHeight * (SeriesList[1].Count*2 + 1);
  MaxWidth2 := MyTextHeight * (SeriesList[2].Count*2 + 1);
  MaxWidth3 := MyTextHeight * (SeriesList[3].Count*2 + 1);
  if MaxWidth1 > MaxWidth2 then MaxWidth := MaxWidth1
                           else MaxWidth := MaxWidth2;
  if MaxWidth < MaxWidth3  then MaxWidth := MaxWidth3;
  Panel1.Width := MaxWidth;
  Panel2.Width := MaxWidth;
  Panel3.Width := MaxWidth;
  // --- End Of Виставляю ширину заголовка ---------------
end;

procedure TForm1.ToolButton12Click(Sender: TObject);
begin
//  frmHeadingOfTheDiagram.Height         := 662;
//  frmHeadingOfTheDiagram.Show;
//  frmHeadingOfTheDiagram.Visible        := False;
// frmHeadingOfTheDiagram.ScrollBar1.Position := 0;
// frmHeadingOfTheDiagram.ScrollBar1.Position := frmHeadingOfTheDiagram.ScrollBar1.Max;
// frmHeadingOfTheDiagram.GetFormImage.SaveToFile('2.bmp');
end;

end.
