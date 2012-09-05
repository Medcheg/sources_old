unit Unit_PlanshetCreator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, MPIDeclaration, Gauges;

type
  TfrmPlanshetCreator = class(TForm)
    ListBox1: TListBox;
    SpeedButtonAddFile: TSpeedButton;
    SpeedButtonRemoveFile: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    ListBox2: TListBox;
    Bevel1: TBevel;
    Label3: TLabel;
    ListBox3: TListBox;
    StatusBar1: TStatusBar;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    Gauge1: TGauge;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel3: TBevel;
    ListBox4: TListBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel4: TBevel;
    ListBox5: TListBox;
    Label10: TLabel;
    Label11: TLabel;
    procedure SpeedButtonAddFileClick(Sender: TObject);
    procedure SpeedButtonRemoveFileClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    CurFile  : TFile;
    CurData  : TData;
    function Get_ShortFileName(FileName : String): String;
    function Get_ItemIndexListBox1(FindString : String):Integer;
    function Get_ItemIndexListBox2(DataType : TDataType):byte;
  public
    procedure LoadFile(FileName : String);
    procedure AddDataToListBox3(ListBox : TListBox; TypeData : Byte; flag : boolean);
    procedure SetupDataProject();
  end;

var
  frmPlanshetCreator: TfrmPlanshetCreator;

implementation

uses Unit_Main, Unit_PlanshetParam, Unit_SaveType;

{$R *.DFM}

function TfrmPlanshetCreator.Get_ShortFileName(FileName: String): String;
var
  i                  : integer;
  PositionFirstSlesh : Integer;
begin
   // ---- Опредиляю позицию последнего слеша --------
   PositionFirstSlesh := 0;
   for i:= Length(FileName) Downto 1 do
      if FileName[i] = '\' then begin
         PositionFirstSlesh := i+1;
         break;
      end;
   if PositionFirstSlesh = 0 then begin
     Result := FileName;
     exit;
   end;
   // --- Определяю Имя файла без полгного пути к нему ---
   Result := '';
   for i:= PositionFirstSlesh to Length(FileName) do begin
      Result := Result + ' ';
      Result[i - PositionFirstSlesh + 1]:= FileName[i];
   end;
end;

procedure TfrmPlanshetCreator.LoadFile(FileName: String);
var
  iFileHandle   : Integer;
  iBytesRead    : LongInt;
begin
         iFileHandle := FileOpen(FileName, fmOpenRead);
      if iFileHandle = -1 then begin
        MessageDLG('Невозможно загрузить файл', mtError, [mbOk],0);
        Exit
      end;
      // --- Создаем новый экземпляр класса TFile
      CurFile     := TFile.Create;  Form1.FileList.Add(CurFile);
      CurFile.FileName      := FileName;
      CurFile.ShortFileName := Get_ShortFileName(FileName);        // --- Имя без пути --

      ListBox1.Items.AddObject(CurFile.ShortFileName, CurFile);    // --- Добавляю елемент в ListBox с файлами ---
      ListBox1.ItemIndex              := ListBox1.Items.Count - 1; // --- Подсвечиваю в ListBoxе последний загруженный файл ---

      StatusBar1.Panels.Items[0].Text := CurFile.FileName;         // --- Вывожу на StatusBar имя и путь к файлу ---

       // ---  Загружаю Данные Файлa  --------------
        CurFile.iFileLength := FileSeek(iFileHandle,0,2);
        GetMem (CurFile.FileBuffer, CurFile.iFileLength);
        FileSeek(iFileHandle,0,0);
        iBytesRead  := FileRead (iFileHandle, CurFile.FileBuffer^, CurFile.iFileLength);
        FileClose(iFileHandle);
        //----- Создаем класс и доьавляем в ListBox ----------
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                   CurFile.Load_AmFile(iBytesRead);
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++
       // ---  End of Загружаю Данные Файлa  --------------

        ListBox2.Items.Clear;
        ListBox1Click(nil);
end;

procedure TfrmPlanshetCreator.SpeedButtonAddFileClick(Sender: TObject);
begin
  // --- Параметры Опен Диалога ----
  OpenDialog1.Filter     := 'Файлы данных (*.dan)|*.dan';
  OpenDialog1.InitialDir := FileInitialDir;

  // --- Обработка результатов ОпенДиалога ---
  if OpenDialog1.Execute then begin
      LoadFile(OpenDialog1.FileName);
  end;
end;

procedure TfrmPlanshetCreator.SpeedButtonRemoveFileClick(Sender: TObject);
begin
  //
end;

procedure TfrmPlanshetCreator.ListBox1Click(Sender: TObject);
begin
  ListBox2.ItemIndex := -1;
  ListBox3.ItemIndex := -1;

  CurFile                 := TFile(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  StatusBar1.Panels.Items[0].Text := CurFile.FileName;

  ListBox2.Items.Clear;

  ListBox2.Items.AddObject(CurFile.Data[dtTempIn]  .SeriesName, CurFile.Data[dtTempIn]  );
  ListBox2.Items.AddObject(CurFile.Data[dtTempOut] .SeriesName, CurFile.Data[dtTempOut] );
  ListBox2.Items.AddObject(CurFile.Data[dtPressure].SeriesName, CurFile.Data[dtPressure]);
end;

procedure TfrmPlanshetCreator.ListBox2Click(Sender: TObject);
begin
  ListBox1.ItemIndex := -1;
  ListBox3.ItemIndex := -1;
  CurData := TData(ListBox2.Items.Objects[ListBox2.ItemIndex]);
  StatusBar1.Panels.Items[0].Text := CurData.FileName + '   |   ' + CurData.SeriesName;
end;

procedure TfrmPlanshetCreator.ListBox2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

procedure TfrmPlanshetCreator.AddDataToListBox3(ListBox: TListBox; TypeData : Byte;flag : boolean);
var
  MySeries     : TMySeries;
  i            : Integer;
  NumberSeries : Integer;
begin
  NumberSeries    := ListBox.items.count-1;
  CurData         := TData(ListBox.Items.Objects[NumberSeries]);
  MySeries        := TMySeries.Create;
  Form1.SeriesList[NumberPole].Add(MySeries);

  MySeries.Max           := Round(CurData.Max + CurData.Max/33);
  MySeries.Min           := Round(CurData.Min - CurData.Max/33);
  MySeries.Name          := CurData.SeriesName;
  MySeries.CountData     := CurData.CountData;
  MySeries.FileName      := CurData.FileName;
  MySeries.DataType      := CurData.DataType;
  MySeries.StartDateTime := CurData.StartDate;

  for i := 0 to MySeries.CountData - 1 do begin
    MySeries.Data[i]     := CurData.Data[i];
    MySeries.TimeData[i] := CurData.TimeData[i];
  end;

  Form1.MinPlanshetTime := MySeries.StartDateTime + CurData.TimeData[0];
  //Form1.MaxPlanshetTime := CurData.TimeData[0] + ChartParam.MaxVisibleTime;
  Form1.MaxPlanshetTime := MySeries.StartDateTime + CurData.TimeData[MySeries.CountData - 1];

  if not flag then begin
    // ------------------------------------------------------------------------
        ProjectRecord.MainData[NumberPole-1].CountItems                    := ListBox.items.count;
        ProjectRecord.MainData[NumberPole-1].DataType[NumberSeries]        := CurData.DataType;
        ProjectRecord.MainData[NumberPole-1].FileName[NumberSeries]        := CurData.FileName;

        ProjectRecord.MainData[NumberPole-1].SeriesName[NumberSeries]     := MySeries.Name;
        ProjectRecord.MainData[NumberPole-1].SeriesColor[NumberSeries]    := clBlack;
        ProjectRecord.MainData[NumberPole-1].SeriesStyle[NumberSeries]    := psSolid;
        ProjectRecord.MainData[NumberPole-1].SeriesMax[NumberSeries]      := MySeries.Max;
        ProjectRecord.MainData[NumberPole-1].SeriesMin[NumberSeries]      := MySeries.Min;
        ProjectRecord.MainData[NumberPole-1].SeriesPenWidth[NumberSeries] := 1;
    // ------------------------------------------------------------------------
  end else begin
    // ------------------------------------------------------------------------
        MySeries.Name     := ProjectRecord.MainData[NumberPole-1].SeriesName[NumberSeries];
        MySeries.PenColor := ProjectRecord.MainData[NumberPole-1].SeriesColor[NumberSeries];
        MySeries.PenStyle := ProjectRecord.MainData[NumberPole-1].SeriesStyle[NumberSeries];
        MySeries.Max      := ProjectRecord.MainData[NumberPole-1].SeriesMax[NumberSeries];
        MySeries.Min      := ProjectRecord.MainData[NumberPole-1].SeriesMin[NumberSeries];
        MySeries.PenWidth := ProjectRecord.MainData[NumberPole-1].SeriesPenWidth[NumberSeries];
    // ------------------------------------------------------------------------
  end;
  Form1.ChartArray[NumberPole,1].UndoZoom;

  //Form1.ChartArray[NumberPole,1].Series[NumberSeries]
  Form1.DrawSeriesOntoChart(Form1.MyFastLineSeries[NumberPole,NumberSeries],MySeries);
end;

procedure TfrmPlanshetCreator.ListBox3DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  lbSource : TListBox;
  lbSender : TListBox;
  flag     : boolean;
begin
// --- Переносим информацию с "SOURCE" в "SENDER" ---
     lbSender := TListBox(Sender);
     lbSource := TListBox(Source);
  if lbSource.ItemIndex = -1 then exit;

  if  (Source is TListBox) and (Sender is TListBox) then
        lbSender.Items.AddObject(
                                  lbSource.Items.Strings[lbSource.ItemIndex],
                                  lbSource.Items.Objects[lbSource.ItemIndex]);

  case lbSender.name[Length(lbSender.name)] of
    '3' : NumberPole := 1;
    '4' : NumberPole := 2;
    '5' : NumberPole := 3;
  end;
  if (x = -100) and (y = -100) then flag := True
                               else flag := false;
  AddDataToListBox3(lbSender, lbSource.ItemIndex, flag);

  Form1.ChartArray[NumberPole,2].Repaint;
  NumberPole := -1;
end;

procedure TfrmPlanshetCreator.ListBox3Click(Sender: TObject);
begin
  ListBox1.ItemIndex := -1;
  ListBox2.ItemIndex := -1;
  CurData := TData(ListBox3.Items.Objects[ListBox3.ItemIndex]);
  StatusBar1.Panels.Items[0].Text := CurData.FileName + '   |   ' + CurData.SeriesName;
end;

procedure TfrmPlanshetCreator.FormShow(Sender: TObject);
begin
//  frmPlanshetParam.sePoleCountChange(nil)
end;

procedure TfrmPlanshetCreator.FormCreate(Sender: TObject);
begin
 MyGauge1 := Gauge1;
end;

function TfrmPlanshetCreator.Get_ItemIndexListBox1(FindString : String):Integer;
var
 i       : byte;
begin
  Result := -1;
  for i:=0 to ListBox1.Items.Count-1 do
     if FindString = TFile(ListBox1.Items.Objects[i]).FileName then Result := i;
end;

function TfrmPlanshetCreator.Get_ItemIndexListBox2(DataType : TDataType):byte;
begin
  Result := 0;
  if Datatype = dtTempOut  then Result := 1;
  if Datatype = dtPressure then Result := 2;
end;

procedure TfrmPlanshetCreator.SetupDataProject();
var
 i, j         : integer;
 ItemIndexlb1 : Integer;
 ItemIndexlb2 : Byte;
begin
  i := 0;
  while FileListArray[i] <> '' do begin
    LoadFile(FileListArray[i]);
    inc(i);
  end;

  for i:=0 to frmPlanshetParam.sePoleCount.Value-1 do begin
    for j := 0 to ProjectRecord.MainData[i].CountItems - 1 do begin
       ItemIndexlb1 := Get_ItemIndexListBox1(ProjectRecord.MainData[i].FileName[j]);
       ListBox1.ItemIndex := ItemIndexlb1;
       ListBox1Click(nil);
       ItemIndexlb2 := Get_ItemIndexListBox2(ProjectRecord.MainData[i].DataType[j]);
       ListBox2.ItemIndex := ItemIndexlb2;
       if i = 0 then ListBox3DragDrop(ListBox3, ListBox2,-100,-100);
       if i = 1 then ListBox3DragDrop(ListBox4, ListBox2,-100,-100);
       if i = 2 then ListBox3DragDrop(ListBox5, ListBox2,-100,-100);
    end;
  end;

  for i := 1 to 3 do begin
    Form1.ChooseSeries[i]        := -1;
    Form1.ChooseSeriesONChart[i] := -1;
    Form1.ChartArray[i,2].Repaint;
  end;
  NumberPole := -1;
  Form1.ClearTextOnStatusBar();

  // ------------------------------------
end;

procedure TfrmPlanshetCreator.ListBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ListBox1.ItemIndex = -1 then exit;
  {if Key = 46  then begin
      TFile(Form1.FileList.Items[ListBox1.ItemIndex]).Free;
      Form1.FileList.Delete(ListBox1.ItemIndex);
      ListBox1  .Items.Delete(ListBox1.ItemIndex);
      ListBox2  .Clear;
  end;}
end;

end.
