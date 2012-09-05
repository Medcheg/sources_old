unit Unit_SaveType;

interface

uses Graphics, MPiDeclaration;
type
  { ------ TChartParam ------}
  TChartParam = packed record
     MainLine_PenStyle        : TPenStyle;
     MainLine_PenColor        : TColor;
     NotMainLine_PenStyle     : TPenStyle;
     NotMainLine_PenColor     : TColor;

     LeftAxis_GridStep        : byte;
     LeftAxis_MinorGridStep   : byte;
     BottomAxis_GridStep      : byte;
     BottomAxis_MinorGridStep : byte;

     PolesCount               : Byte;
     MaxVisibleTimeOnChart    : Double;
     OldScaledMaxVisibleTime  : Double;
        ScaledMaxVisibleTime  : Double;


     CountMinInOneSantimetr   : Integer;
     MaxSmInChart             : Double;
     //Files                    : array [0..2, 0..30] of string[255];
  end;
  //----------------------------------------------
  TSeriesRecordType  = packed record
    CountItems     : Integer;
    DataType       : Array [0..10] of TDataType;   // --- dtTempIn, dtTempOut, dtPressure ---
    SeriesName     : array [0..10] of String[255]; // --- Имя серии -------------------------
    FileName       : array [0..10] of string[255]; // --- Имя файла с которого данные -------

    SeriesColor    : array [0..10] of TColor;      // --- Цвет графика ----------------------
    SeriesStyle    : array [0..10] of TPenStyle;   // --- Стиль линии -----------------------
    SeriesMax      : array [0..10] of Double;      // --- Максимум серии --------------------
    SeriesMin      : array [0..10] of Double;      // --- Миниму серии ----------------------
    SeriesPenWidth : array [0..10] of Integer;     // --- Толщина линии серии ----------------------
  end;
  //--------------------------------------------------------------------
  TProjectRecord = Packed record
     MainData : array [0..2] of TSeriesRecordType;  // --- Три поля ----
  end;
  //---------------------------------------------------------------------
  TLegendParam = packed record
    StartTimePos             : Double;
    EndTimePos               : Double;
    BrushStyle               : TBrushStyle;
    Caption                  : String[255];
  end;
  //---------------------------------------------------------------------
  TMyCaptionParam = packed record
    Orientation              : TOrientation;  // ---  Ориентация теста ---
    Caption                  : String[255];        // --- Выводимый текст ---

    StartTimePos             : Double;
    EndTimePos               : Double;
    YStartValue              : Double;
    YEndValue                : Double;

    myFont  : packed record
      Size  :  integer;
      Style :  TFontStyles;
      Color :  TColor;
      Name  :  String [255];
    end;
    LineVisible              : Boolean;
  end;
  //---------------------------------------------------------------------
  procedure PrepareHeadingDiagramPanelArray();
  procedure Load_DataPanelArrayToHeadingDiagram();
  procedure Load_CaptionArray();
  procedure Load_LegendArray();
  procedure Save_LegendArray();
  procedure Save_CaptionArray();

var

  ChartParam            : TChartParam;
  ProjectRecord         : TProjectRecord;
  FileListArray         : packed array [0..20] of String[255];
  PanelArray            : packed array [1..78] of String[255];
  LegendArray           : array [1..3,0..30] of TLegendParam;
  CaptionArray          : array [1..3,0..30] of TMyCaptionParam;

implementation

uses Unit_HeadingOfTheDiagram, Unit_Main, Unit_CaptionParam, Unit_LegentParam, Unit_PlanshetParam;

procedure PrepareHeadingDiagramPanelArray();
begin
  with frmHeadingOfTheDiagram do begin
     PanelArray[1 ] := Panel6 .Caption;
     PanelArray[2 ] := Panel12.Caption;
     PanelArray[3 ] := Panel8 .Caption;
     PanelArray[4 ] := Panel7 .Caption;
     PanelArray[5 ] := Panel13.Caption;
     PanelArray[6 ] := Panel14.Caption;
     PanelArray[7 ] := Panel15.Caption;
     PanelArray[8 ] := Panel16.Caption;
     PanelArray[9 ] := Panel17.Caption;
     PanelArray[10] := Panel18.Caption;

     PanelArray[11] := Panel21.Caption;
     PanelArray[12] := Panel25.Caption;
     PanelArray[13] := Panel29.Caption;
     PanelArray[14] := Panel33.Caption;
     PanelArray[15] := Panel37.Caption;
     PanelArray[16] := Panel41.Caption;
     PanelArray[17] := Panel45.Caption;
     PanelArray[18] := Panel48.Caption;
     PanelArray[19] := Panel49.Caption;

     PanelArray[20] := Panel23.Caption;
     PanelArray[21] := Panel27.Caption;
     PanelArray[22] := Panel30.Caption;
     PanelArray[23] := Panel31.Caption;
     PanelArray[24] := Panel43.Caption;
     PanelArray[25] := Panel42.Caption;
     PanelArray[26] := Panel47.Caption;
     PanelArray[27] := Panel46.Caption;

     PanelArray[28] := Panel51.Caption;
     PanelArray[29] := Panel50.Caption;
     PanelArray[30] := Panel57.Caption;
     PanelArray[31] := Panel53.Caption;
     PanelArray[32] := Panel55.Caption;
     PanelArray[33] := Panel54.Caption;
     PanelArray[34] := Panel58.Caption;
     PanelArray[35] := Panel3 .Caption;
     PanelArray[36] := Panel60.Caption;
     PanelArray[37] := Panel61.Caption;
     PanelArray[38] := Panel62.Caption;
     PanelArray[39] := Panel63.Caption;
     PanelArray[40] := Panel64.Caption;
     PanelArray[41] := Panel65.Caption;
     PanelArray[42] := Panel66.Caption;
     PanelArray[43] := Panel67.Caption;
     PanelArray[44] := Panel68.Caption;
     PanelArray[45] := Panel69.Caption;
     PanelArray[46] := Panel70.Caption;
     PanelArray[47] := Panel71.Caption;
     PanelArray[48] := Panel72.Caption;
     PanelArray[49] := Panel73.Caption;
     PanelArray[50] := Panel74.Caption;
     PanelArray[51] := Panel75.Caption;
     PanelArray[52] := Panel76.Caption;
     PanelArray[53] := Panel77.Caption;
     PanelArray[54] := Panel79.Caption;
     PanelArray[55] := Panel80.Caption;
     PanelArray[56] := Panel81.Caption;
     PanelArray[57] := Panel83.Caption;
     PanelArray[58] := Panel84.Caption;
     PanelArray[59] := Panel85.Caption;
     PanelArray[60] := Panel87.Caption;
     PanelArray[61] := Panel88.Caption;
     PanelArray[62] := Panel89.Caption;
     PanelArray[63] := Panel90.Caption;
     PanelArray[64] := Panel91.Caption;
     PanelArray[65] := Panel92.Caption;
     PanelArray[66] := Panel93.Caption;
     PanelArray[67] := Panel94.Caption;
     PanelArray[68] := Panel95.Caption;
     PanelArray[69] := Panel96.Caption;
     PanelArray[70] := Panel97.Caption;
     PanelArray[71] := Panel98.Caption;
     PanelArray[72] := Panel99.Caption;
     PanelArray[73] := Panel100.Caption;
     PanelArray[74] := Panel101.Caption;

  end;
end;

procedure Load_DataPanelArrayToHeadingDiagram();
begin
  with frmHeadingOfTheDiagram do begin

     Panel6 .Caption := PanelArray[1 ];
     Panel12.Caption := PanelArray[2 ];
     Panel8 .Caption := PanelArray[3 ];
     Panel7 .Caption := PanelArray[4 ];
     Panel13.Caption := PanelArray[5 ];
     Panel14.Caption := PanelArray[6 ];
     Panel15.Caption := PanelArray[7 ];
     Panel16.Caption := PanelArray[8 ];
     Panel17.Caption := PanelArray[9 ];
     Panel18.Caption := PanelArray[10];

     Panel21.Caption := PanelArray[11];
     Panel25.Caption := PanelArray[12];
     Panel29.Caption := PanelArray[13];
     Panel33.Caption := PanelArray[14];
     Panel37.Caption := PanelArray[15];
     Panel41.Caption := PanelArray[16];
     Panel45.Caption := PanelArray[17];
     Panel48.Caption := PanelArray[18];
     Panel49.Caption := PanelArray[19];

     Panel23.Caption := PanelArray[20];
     Panel27.Caption := PanelArray[21];
     Panel30.Caption := PanelArray[22];
     Panel31.Caption := PanelArray[23];
     Panel43.Caption := PanelArray[24];
     Panel42.Caption := PanelArray[25];
     Panel47.Caption := PanelArray[26];
     Panel46.Caption := PanelArray[27];

     Panel51.Caption := PanelArray[28];
     Panel50.Caption := PanelArray[29];
     Panel57.Caption := PanelArray[30];
     Panel53.Caption := PanelArray[31];
     Panel55.Caption := PanelArray[32];
     Panel54.Caption := PanelArray[33];
     Panel58.Caption := PanelArray[34];
     Panel3 .Caption := PanelArray[35];
     Panel60.Caption := PanelArray[36];
     Panel61.Caption := PanelArray[37];
     Panel62.Caption := PanelArray[38];
     Panel63.Caption := PanelArray[39];
     Panel64.Caption := PanelArray[40];
     Panel65.Caption := PanelArray[41];
     Panel66.Caption := PanelArray[42];
     Panel67.Caption := PanelArray[43];
     Panel68.Caption := PanelArray[44];
     Panel69.Caption := PanelArray[45];
     Panel70.Caption := PanelArray[46];
     Panel71.Caption := PanelArray[47];
     Panel72.Caption := PanelArray[48];
     Panel73.Caption := PanelArray[49];
     Panel74.Caption := PanelArray[50];
     Panel75.Caption := PanelArray[51];
     Panel76.Caption := PanelArray[52];
     Panel77.Caption := PanelArray[53];
     Panel79.Caption := PanelArray[54];
     Panel80.Caption := PanelArray[55];
     Panel81.Caption := PanelArray[56];
     Panel83.Caption := PanelArray[57];
     Panel84.Caption := PanelArray[58];
     Panel85.Caption := PanelArray[59];
     Panel87.Caption := PanelArray[60];
     Panel88.Caption := PanelArray[61];
     Panel89.Caption := PanelArray[62];
     Panel90.Caption := PanelArray[63];
     Panel91.Caption := PanelArray[64];
     Panel92.Caption := PanelArray[65];
     Panel93.Caption := PanelArray[66];
     Panel94.Caption := PanelArray[67];
     Panel95.Caption := PanelArray[68];
     Panel96.Caption := PanelArray[69];
     Panel97.Caption := PanelArray[70];
     Panel98.Caption := PanelArray[71];
     Panel99.Caption := PanelArray[72];
     Panel100.Caption := PanelArray[73];
     Panel101.Caption := PanelArray[74];

     frmHeadingOfTheDiagram.CalcRotLabelPosition();

  end;
end;

procedure Save_CaptionArray();
var
 MyCaption : TMyCaption;
 k,i       : Integer;
begin
  FillChar(CaptionArray, SizeOf(CaptionArray), 0);
  for k:=1 to frmPlanshetParam.sePoleCount.Value do begin
    for i:=0 to Form1.CaptionList[k].count - 1 do begin
      MyCaption  := TMyCaption(Form1.CaptionList[k].items[i]);

      CaptionArray[K, i].Orientation   := MyCaption.Orientation;
      CaptionArray[K, i].Caption       := MyCaption.Caption;
      CaptionArray[K, i].StartTimePos  := MyCaption.StartTimePos;
      CaptionArray[K, i].EndTimePos    := MyCaption.EndTimePos;
      CaptionArray[K, i].YStartValue   := MyCaption.YStartValue;
      CaptionArray[K, i].YEndValue     := MyCaption.YEndValue;
      CaptionArray[K, i].MyFont.Size   := MyCaption.Font.Size;
      CaptionArray[K, i].MyFont.Style  := MyCaption.Font.Style;
      CaptionArray[K, i].MyFont.Color  := MyCaption.Font.Color;
      CaptionArray[K, i].MyFont.Name   := MyCaption.Font.Name;
      CaptionArray[K, i].LineVisible   := MyCaption.LineVisible;

      MyCaption.Font.Size    := CaptionArray[k, i].MyFont.Size;
      MyCaption.Font.Style   := CaptionArray[k, i].MyFont.Style;
      MyCaption.Font.Color   := CaptionArray[k, i].MyFont.Color;
      MyCaption.Font.Name    := CaptionArray[k, i].MyFont.Name;
      MyCaption.LineVisible  := CaptionArray[k, i].LineVisible;

    end;
  end;
end;

procedure Load_CaptionArray();
var
 MyCaption : TMyCaption;
 k,i       : Integer;
begin
  for k:=1 to 3 do begin
    for i:=0 to 30 do begin
      if CaptionArray[k,i].EndTimePos = 0 then break;

      MyCaption := TMyCaption.Create(Form1.ChartArray[k,1].Canvas);

      Form1.CaptionList[k].Add(MyCaption);

      MyCaption.Orientation  := CaptionArray[k, i].Orientation;
      MyCaption.Caption      := CaptionArray[k, i].Caption;
      MyCaption.Font.Size    := CaptionArray[k, i].MyFont.Size;
      MyCaption.Font.Style   := CaptionArray[k, i].MyFont.Style;
      MyCaption.Font.Color   := CaptionArray[k, i].MyFont.Color;
      MyCaption.Font.Name    := CaptionArray[k, i].MyFont.Name;
      MyCaption.LineVisible  := CaptionArray[k, i].LineVisible;
      MyCaption.StartTimePos := CaptionArray[k, i].StartTimePos;
      MyCaption.YStartValue  := CaptionArray[k, i].YStartValue;
      MyCaption.EndTimePos   := CaptionArray[k, i].EndTimePos;
      MyCaption.YEndValue    := CaptionArray[k, i].YEndValue;

      frmCaptionParam.ListBox1.Items.AddObject(MyCaption.Caption, MyCaption);

      MyCaption.Draw;
    end;
  end;
end;

procedure Save_LegendArray();
var
 MyLegend  : TLegend;
 k,i       : Integer;
begin
  FillChar(LegendArray,  SizeOf(LegendArray ), 0);
  for k:=1 to frmPlanshetParam.sePoleCount.Value do begin
    for i:=0 to Form1.LegendList[k].count - 1 do begin
      MyLegend  := TLegend(Form1.LegendList[k].items[i]);
      LegendArray[k, i].StartTimePos := MyLegend.StartTimePos;
      LegendArray[k, i].EndTimePos   := MyLegend.EndTimePos;
      LegendArray[k, i].BrushStyle   := MyLegend.BrushStyle;
      LegendArray[k, i].Caption      := MyLegend.Caption;
    end;
  end;
end;

procedure Load_LegendArray();
var
 MyLegend  : TLegend;
 k,i       : Integer;
begin
  for k:=1 to 3 do begin
    for i:=0 to 30 do begin
      if LegendArray[k,i].EndTimePos = 0 then break;

      MyLegend  := TLegend.Create(Form1.ChartArray[k,1].Canvas);
      Form1.LegendList[k].Add(MyLegend);

      MyLegend.StartTimePos := LegendArray[k,i].StartTimePos;
      MyLegend.EndTimePos   := LegendArray[k,i].EndTimePos;
      MyLegend.BrushStyle   := LegendArray[k,i].BrushStyle;
      MyLegend.Caption      := LegendArray[k,i].Caption;

      MyLegend.Draw;

      //frmLegentParam.ListBox1.Items.AddObject(MyLegend.Caption,MyLegend);
      //frmLegentParam.CurrentLegend := MyLegend;
      //if MyLegend.BrushStyle = bsBDiagonal then frmLegentParam.RadioButton1.Checked := True
      //                                     else frmLegentParam.RadioButton2.Checked := True
    end;
  end;
end;

begin
end.
