unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls, TeEngine, Series, TeeProcs, Chart,
  MPIDeclaration, Menus;

type
  TForm1 = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    Panel4: TPanel;
    Panel1: TPanel;
    ScrollBar1: TScrollBar;
    ToolBar2: TToolBar;
    tbFile: TToolButton;
    tbReadACPData: TToolButton;
    tbService: TToolButton;
    nSpectr: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    TabControl1: TTabControl;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ComboBox1: TComboBox;
    Label8: TLabel;
    tbAbout: TToolButton;
    PopupMenu1: TPopupMenu;
    nOpenFile: TMenuItem;
    nSaveFile: TMenuItem;
    N3: TMenuItem;
    nClose: TMenuItem;
    N5: TMenuItem;
    nSaveBitampToFile: TMenuItem;
    SaveDialog1: TSaveDialog;
    Panel3: TPanel;
    ControlBar2: TControlBar;
    ToolBar3: TToolBar;
    ListBox1: TListBox;
    tbAdd: TToolButton;
    tbClear: TToolButton;
    OpenDialog1: TOpenDialog;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    Label9: TLabel;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tbReadACPDataClick(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure tbFFTClick(Sender: TObject);
    procedure tbAboutClick(Sender: TObject);
    procedure nSaveBitampToFileClick(Sender: TObject);
    procedure tbClearClick(Sender: TObject);
    procedure tbAddClick(Sender: TObject);
    procedure nDFTClick(Sender: TObject);
    procedure nOpenFileClick(Sender: TObject);
    procedure nSaveFileClick(Sender: TObject);
    procedure nCloseClick(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbFiltrClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    ClearBitmap      : TBitmap;
    ReDrawBitmap     : TBitmap;

    // -------------
    BackGroundColor   : TColor;
    RectangleEnabled  : Boolean;
    // -------------

    ListBoxItemsCount : Integer;
    ListBoxArray      : array [0..1000] of Single;

    GraphArray       : array [0..2000] of TPoint;
    EnabledMouseMove : Boolean;

    TimeScale        : Integer;
    YAxisScale       : Integer;

    PointToSlice     : Integer;
    FileOpened       : Boolean;

    procedure DrawVerticalLinesAndLabels(Offset : Integer);
  public
    ImagePos        : TImagePos;
    procedure Draw(offset : Integer);
    procedure SetParamClearBitamp();
  end;

var
  Form1: TForm1;

implementation

uses Unit_ReadACPData, MPILibrary, Unit_FFT_Param, Unit_About,
  Unit_FindMinMax, mpiFilters;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  PlataPresent := Detect_And_Start_Plata_L761();
  if not PlataPresent then
//       tbReadACPData.Enabled := False;
//       if MessageBox(Handle,'����� L-761 �� ����������','������ ���������� �����',MB_OKCANCEL) = mrCancel then begin
//       tbReadACPData.Enabled := False;
       //ExitProcess(0);
//    end;

  if not PlataPresent then tbReadACPData.Enabled := False;
  ClearBitmap         := TBitmap.Create;
  ReDrawBitmap        := TBitmap.Create;
  DecimalSeparator    := '.';
  ComboBox1.ItemIndex := 0;
  ComboBox2.ItemIndex := 0;
  BackGroundColor     := clBtnFace;
  RectangleEnabled    := True;
  FileOpened          := False;
  ListBoxItemsCount   := 0;
  YAxisScale          := 1;

  ComboBox1Change(nil);
//  ComboBox2Change(nil);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
  //tbReadACPData.Enabled := False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   ClearBitmap .Free;
   ReDrawBitmap.Free;
   Stop_ACP_L761();
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  ToolBar1.Width := ControlBar1.Width;
  ToolBar2.Width := ControlBar1.Width;
  SetParamClearBitamp();
end;

procedure TForm1.tbReadACPDataClick(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
  EndGraphPoint       := 0;
  ScrollBar1.Position := 0;

  ListBox1.Items.Clear;
  FillChar(ListBoxArray, SizeOf(ListBoxArray), 0);
  ListBoxItemsCount := 0;

  if FileOpened then begin
       FreeMem(data, SizeOf(smallInt)*EndGraphPoint*3);
       FileOpened := False;
       Draw(ScrollBar1.Position);
  end;
  Caption := '���������� - []';
  FileOpened := false;

  SetParamClearBitamp();
  frmReadACPData.Show;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Draw(ScrollBar1.Position);
end;

procedure TForm1.TabControl1Change(Sender: TObject);
begin
  ScrollBar1.Position := 0;
  Label2.Caption := IntToStr(TabControl1.TabIndex + 1);
  Draw(ScrollBar1.Position);
end;

procedure TForm1.SetParamClearBitamp();
var
  i               : integer;
  StepY           : Double;

  LabelsArray     : Array [-10..10] of String;
  LabelWidth      : Integer;
  LabelHeight     : Integer;
  MaxLabelWidth   : Integer;
begin
  ClearBitmap .Width  := Image1.Width;
  ClearBitmap .Height := Image1.Height - 20;
  ReDrawBitmap.Width  := Image1.Width;
  ReDrawBitmap.Height := Image1.Height - 20;
  //--------  ������� �������� --------------
  if RectangleEnabled then ClearBitmap.Canvas.Pen.Color := clBlack
                      else ClearBitmap.Canvas.Pen.Color := BackGroundColor;
  ClearBitmap.Canvas.Pen.Style   := psSolid;
  ClearBitmap.Canvas.Brush.Color := BackGroundColor;
  ClearBitmap.Canvas.Rectangle(Rect(0, 0, ClearBitmap.Width, ClearBitmap.Height));
  // --------- ������������ ������ �������, � ����������� ������������ ������ ������� -------
  MaxLabelWidth := 0;
  for i:= -10 to 10 do begin
        LabelsArray[i] := FloatToStrF(CurrentVolt/YAxisScale*i/10, ffFixed, 8, 7);
        if i = 0 then LabelsArray[i] := '0';
        LabelWidth     := ClearBitmap.Canvas.TextWidth(LabelsArray[i]);
        if MaxLabelWidth < LabelWidth then MaxLabelWidth := LabelWidth;
  end;
  LabelHeight := ClearBitmap.Canvas.TextHeight('0');
  // ------- ������� ���������� ImagePos ------------
  ImagePos.x  := MaxLabelWidth + 20;
  ImagePos.y  := LabelHeight;
  ImagePos.w  := ClearBitmap.Width  - ImagePos.x - 12;
  ImagePos.h  := ClearBitmap.Height - 2*ImagePos.y;
  ImagePos.xw := ImagePos.x + ImagePos.w;
  ImagePos.yh := ImagePos.y + ImagePos.h;
  ImagePos.ZeroPos := ImagePos.y + ImagePos.h div 2;
  ImagePos.MinYValue := ImagePos.y + 1;
  ImagePos.MaxYValue := ImagePos.y + ImagePos.h - 1;
  //--------  �������� PolyLine  ------------------------------
  for i:=0 to ImagePos.w - 2 do begin
     GraphArray[i].x := ImagePos.x + i + 1;
     GraphArray[i].y := ImagePos.ZeroPos;
  end;
  //--------  ����� --------------
  ClearBitmap.Canvas.Pen.Color   := clBlack;
  ClearBitmap.Canvas.Pen.Style   := psSolid;
  ClearBitmap.Canvas.Brush.Color := BackGroundColor;//rgb(217,217,174);
  ClearBitmap.Canvas.Rectangle(ImagePos.x, ImagePos.y, ImagePos.xw, ImagePos.yh);
  //---------  ����  -------------
  ClearBitmap.Canvas.MoveTo(ImagePos.x , ImagePos.ZeroPos);
  ClearBitmap.Canvas.LineTo(ImagePos.xw, ImagePos.ZeroPos);
  //---------  ����� �������������� and ������� ����������-------------
  StepY := ImagePos.h / 20;
  i     := 0;
  ClearBitmap.Canvas.Pen.Color   := clGray;
  ClearBitmap.Canvas.Pen.Style   := psDot;
  ClearBitmap.Canvas.Brush.Color := BackGroundColor;
  while i <= 10 do begin
    if (i <> 10) and (i <> 0) then begin
       ClearBitmap.Canvas.MoveTo(ImagePos.x  + 1, Trunc(ImagePos.ZeroPos + StepY * i) + 0);
       ClearBitmap.Canvas.LineTo(ImagePos.xw - 1, Trunc(ImagePos.ZeroPos + StepY * i) + 0);
       ClearBitmap.Canvas.MoveTo(ImagePos.x  + 1, Trunc(ImagePos.ZeroPos - StepY * i) + 1);
       ClearBitmap.Canvas.LineTo(ImagePos.xw - 1, Trunc(ImagePos.ZeroPos - StepY * i) + 1);
    end;
    ClearBitmap.Canvas.TextOut(ImagePos.x - 10 - ClearBitmap.Canvas.TextWidth(LabelsArray[-i]), Trunc(ImagePos.ZeroPos + StepY * i) + 1 - LabelHeight div 2,LabelsArray[-i]);
    ClearBitmap.Canvas.TextOut(ImagePos.x - 10 - ClearBitmap.Canvas.TextWidth(LabelsArray[-i]), Trunc(ImagePos.ZeroPos - StepY * i) + 1 - LabelHeight div 2,LabelsArray[i ]);
    inc(i);
  end;

  Draw(-1);

  Label9   .Top := Panel4.Height - 112;
  ComboBox2.Top := Panel4.Height - 91;

  Label7   .Top := Panel4.Height - 62;
  ComboBox1.Top := Panel4.Height - 41;

  Panel3.Height := Panel4.Height - Panel3.Top - 125;
end;

procedure TForm1.Draw(offset: Integer);
var
  i                     : integer;
  Value                 : Single;
  {OldValue              : Single;
  PromValue             : Single;}
  CurCountGrawphicPoint : Integer;
begin
  EnabledMouseMove := False;
  PointToSlice     := ImagePos.w - 2;
  //-----------------------------------
  Image1.Canvas.Draw(0,0,ClearBitmap);
  DrawVerticalLinesAndLabels(offset);
  //-----------------------------------
  if EndGraphPoint <> 0  then begin
      CurCountGrawphicPoint := EndGraphPoint div TimeScale;
      if CurCountGrawphicPoint = 0 then exit;
      // --- ���� ���������� ��������� �� ... -----------
      if PointToSlice > CurCountGrawphicPoint then begin
         ScrollBar1.Max := 0;
         PointToSlice   := CurCountGrawphicPoint
      end else ScrollBar1.Max   := Integer(CurCountGrawphicPoint) - ImagePos.w;
      // ----- ��������� ������ "�����������" ---------
      if Offset <> -1 then begin
              Value           := (data[offset*3*TimeScale + TabControl1.TabIndex] - Postojanka[TabControl1.TabIndex]);
              GraphArray[0].y := ImagePos.ZeroPos - Trunc(Value / 8192 / YAxisScale * (ImagePos.h div 2));
              for i:= 1 to PointToSlice - 1 do begin

                 //----------------
                 {OldValue := (data[(i - 1 + offset)*3*TimeScale + TabControl1.TabIndex] - Postojanka[TabControl1.TabIndex]);
                 Value    := (data[(i     + offset)*3*TimeScale + TabControl1.TabIndex] - Postojanka[TabControl1.TabIndex]);

                 if Value > OldValue then begin
                   for k := 1 to TimeScale do begin
                       PromValue := (data[(i - 1 + offset + k)*3*TimeScale + TabControl1.TabIndex] - Postojanka[TabControl1.TabIndex]);
                       if PromValue > Value then Value := PromValue;
                   end;
                 end else for k := 1 to TimeScale do begin
                       PromValue := (data[(i - 1 + offset + k)*3*TimeScale + TabControl1.TabIndex] - Postojanka[TabControl1.TabIndex]);
                       if PromValue < Value then Value := PromValue;
                 end;}
                 //----------------
                 Value       := (data[(i+offset)*3*TimeScale + TabControl1.TabIndex] - Postojanka[TabControl1.TabIndex]);
                 GraphArray[i].y := ImagePos.ZeroPos - Trunc(Value / 8192 * YAxisScale * (ImagePos.h div 2));
              end;
      end;
  end;
  Image1.Canvas.Polyline(Slice(GraphArray, PointToSlice));
  //-----------------------------------
  //-----------------------------------
  ReDrawBitmap.Assign(Image1.Picture);
  EnabledMouseMove := True;
end;

procedure TForm1.DrawVerticalLinesAndLabels(Offset : Integer);
var
 VerticalLineStep  : Single;
 NumberVerticalLine : Integer;
 PosX              : Integer;
 strTextOut        : String;
begin
  Image1.Canvas.Pen.Style   := psDot;
  Image1.Canvas.Pen.Color   := clGray;
  Image1.canvas.Brush.Color := BackGroundColor;
  VerticalLineStep          := AcpFreq / 10;
  PosX                      := ImagePos.x;
  NumberVerticalLine        := Trunc(Offset /  VerticalLineStep);

  // -------- ����� ������������ ����� ----------
  while PosX <= ImagePos.xw - trunc(VerticalLineStep - 2) do begin
     NumberVerticalLine := NumberVerticalLine + 1;
     PosX := ImagePos.x + Round(NumberVerticalLine * VerticalLineStep) - Offset;
     Image1.Canvas.MoveTo(PosX, ImagePos.y  + 1);
     Image1.Canvas.LineTo(PosX, ImagePos.yh - 3);
  end;
  // -------- ����� �������� ������������ ����� ----------

  Image1.Canvas.Brush.Color := clWhite;
  Image1.canvas.FillRect(Rect(0,ClearBitmap.Height, ClearBitmap.Width, ClearBitmap.Height + 20));
  NumberVerticalLine        := Trunc(Offset /  VerticalLineStep);
  PosX                      := ImagePos.x;
  while PosX <= ImagePos.xw do begin
     PosX := ImagePos.x + Round(NumberVerticalLine * VerticalLineStep) - Offset;
     strTextOut := FloatToStr(NumberVerticalLine/10*TimeScale) + ' c.';
     Image1.Canvas.TextOut (PosX - Image1.Canvas.TextWidth(strTextOut) div 2, ClearBitmap.Height + 3, strTextOut);
     Image1.Canvas.FillRect(Rect(0,ClearBitmap.Height, ImagePos.x - 12, ClearBitmap.Height + 20));
     NumberVerticalLine := NumberVerticalLine + 1;
  end;
  //----------------------------
  Image1.Canvas.Pen.Style := psSolid;
  Image1.Canvas.Pen.Color := clBlack;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  yPos     : Integer;
  yPosVolt : Extended;
  xTime    : Extended;
begin
  Image1.Canvas.Draw(0,0,ReDrawBitmap);
  if (TComponent(Sender).name = 'Image1') and EnabledMouseMove and (EndGraphPoint <> 0) and (X > ImagePos.x) and (X <= ImagePos.xw) and (X <= PointToSlice + ImagePos.x) then begin
    yPos     := GraphArray[x - ImagePos.x - 1].y;
    yPosVolt := (ImagePos.ZeroPos - yPos) / (ImagePos.h - ImagePos.y) * CurrentVolt * 2 / YAxisScale;
    xTime    := (ScrollBar1.Position + x - ImagePos.x - 1)/AcpFreq*TimeScale;

    DrawCircle(Image1.Canvas, x, yPos);
    Image1.Canvas.MoveTo(x, ImagePos.y + 6); Image1.Canvas.LineTo(x, yPos        - 6);
    Image1.Canvas.MoveTo(x, yPos       + 6); Image1.Canvas.LineTo(x, ImagePos.yh - 6);

    Label4.Caption := FloatToStrF(xTime, ffFixed, 10, 3) + ' �.';
    Label6.Caption := FloatToStrF(yPosVolt     , ffFixed, 15, 7) + ' �.';
    Label8.Caption := FloatToStrF(yPosVolt/9.81, ffFixed, 15, 7) + ' g';
  end else begin
     Label4.Caption := '--------------------------';
     Label6.Caption := '--------------------------';
     Label8.Caption := '--------------------------';
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  TimeScale           := Round(exp(ComboBox1.ItemIndex*ln(2)));
  ScrollBar1.Position := 0;
  if Sender <> nil then Draw(ScrollBar1.Position);
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
    YAxisScale := 1;
  case ComboBox2.ItemIndex of
    1 : YAxisScale := 2;
    2 : YAxisScale := 4;
    3 : YAxisScale := 8;
    4 : YAxisScale := 10;
    5 : YAxisScale := 25;
    6 : YAxisScale := 50;
    7 : YAxisScale := 100;
    8 : YAxisScale := 200;
    9 : YAxisScale := 300;
    10 : YAxisScale := 500;
    11 : YAxisScale := 1000;
  end;

  SetParamClearBitamp();
  Draw(ScrollBar1.Position);
end;

procedure TForm1.tbFFTClick(Sender: TObject);
begin
  frmFFT_Param.ShowModal;
end;

procedure TForm1.nDFTClick(Sender: TObject);
begin
//
end;

procedure TForm1.tbAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TForm1.nSaveBitampToFileClick(Sender: TObject);
var
  FileName : String;
begin
  // --- ��������� Save ������� ----
  SaveDialog1.Filter     := '����� bmp (*.bmp)|*.bmp';
  SaveDialog1.Title      := '������ �����';
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  SaveDialog1.FileName   := '';
  if SaveDialog1.Execute then begin
      FileName := SaveDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.bmp';

      BackGroundColor  := clWhite;
      RectangleEnabled := False;
      SetParamClearBitamp();
      Draw(ScrollBar1.Position);

      Image1.Picture.SaveToFile(FileName);

      BackGroundColor  := clBtnFace;
      RectangleEnabled := True;
      SetParamClearBitamp();
      Draw(ScrollBar1.Position);
  end;
end;

procedure TForm1.tbClearClick(Sender: TObject);
begin
  ListBox1.Clear;
  ListBoxItemsCount := -1;
end;

procedure TForm1.tbAddClick(Sender: TObject);
begin
  ListBox1.Items.Add(intToStr(ListBox1.items.Count + 1) + ' - ' + FloatToStrF(frmReadACPData.CurrentACPTime, ffFixed, 16, 2));
  ListBoxItemsCount := ListBox1.items.Count;
  ListBoxArray[ ListBoxItemsCount - 1] := frmReadACPData.CurrentACPTime;
end;

procedure TForm1.nOpenFileClick(Sender: TObject);
var
  FileName   : String;
  FileHandle : Integer;
  i          : Integer;
begin
  // --- ��������� Save ������� ----
  OpenDialog1.Filter     := '����� dat (*.dat)|*.dat';
  OpenDialog1.Title      := '������ �����';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  OpenDialog1.FileName   := '';
  if OpenDialog1.Execute then begin
      FileName := OpenDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.dat';

      FileHandle := FileOpen(FileName, fmOpenRead);
      if FileHandle = -1 then exit;
      Caption := '���������� - ['+FileName+']';
      FileSeek(FileHandle,0,0);


      if FileOpened then FreeMem(data, SizeOf(smallInt)*EndGraphPoint*3);

      EndGraphPoint       := 0;
      CurrentVolt         := 0;
      FileOpened          := True;
      ListBoxItemsCount	  := 0;
      ScrollBar1.Position := 0;
      Draw(ScrollBar1.Position);
      //-----------------------
      FileRead (FileHandle, EndGraphPoint    , SizeOf(EndGraphPoint)); GetMem (data, SizeOf(smallInt)*EndGraphPoint*3);
      FileRead (FileHandle, CurrentVolt      , SizeOf(CurrentVolt  ));
      FileRead (FileHandle, Postojanka       , SizeOf(Postojanka));
      FileRead (FileHandle, ListBoxItemsCount, SizeOf(ListBoxItemsCount));
      FileRead (FileHandle, ListBoxArray     , SizeOf(Integer)*ListBoxItemsCount);
      FileRead (FileHandle, data^            , SizeOf(tA)*EndGraphPoint*3);
      {for i := 0 to EndGraphPoint*3 - 1 do
             FileRead (FileHandle, data^[i], SizeOf(tA));}

      FileClose(FileHandle);
      //-----------------------
      ListBox1.Items.clear;
      for i := 0 to ListBoxItemsCount - 1 do
             ListBox1.Items.Add(intToStr(ListBox1.items.Count + 1) + ' - ' + FloatToStrF(ListBoxArray[i], ffFixed, 16, 2));

      SetParamClearBitamp();
      Draw(ScrollBar1.Position);

  end;
end;

procedure TForm1.nSaveFileClick(Sender: TObject);
var
  FileName   : String;
  FileHandle : Integer;
begin
  // --- ��������� Save ������� ----
  SaveDialog1.Filter     := '����� dat (*.dat)|*.dat';
  SaveDialog1.Title      := '������ �����';
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  SaveDialog1.FileName   := '';
  if SaveDialog1.Execute then begin
      FileName := SaveDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.dat';

      FileHandle := FileCreate(FileName);

      FileWrite(FileHandle, EndGraphPoint       , SizeOf(EndGraphPoint     ));
      FileWrite(FileHandle, CurrentVolt         , SizeOf(CurrentVolt       ));
      FileWrite(FileHandle, Postojanka          , SizeOf(Postojanka        ));
      FileWrite(FileHandle, ListBoxItemsCount   , SizeOf(ListBoxItemsCount ));
      FileWrite(FileHandle, ListBoxArray        , SizeOf(Integer)*ListBoxItemsCount);
      FileWrite(FileHandle, data^               , SizeOf(tA)*EndGraphPoint*3);

      FileClose(FileHandle);
  end;
end;

procedure TForm1.nCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then ListBox1.Items.Delete(ListBox1.ItemIndex);
end;

procedure TForm1.tbFiltrClick(Sender: TObject);
var
  i , k : Integer;
  Filtr_100 : TFiltr_100;
begin
  Filtr_100 := TFiltr_100.Create();

  for k := 0 to 2 do begin
      Filtr_100.Init();
      for i := 0 to EndGraphPoint - 1 do
           data[i*3 + k] := smallInt(round(Filtr_100.Run(data[i*3 + k])));
  end;
  Draw(ScrollBar1.Position);

  Filtr_100.Free;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  frmFindMinMax.ShowModal;
end;

end.
