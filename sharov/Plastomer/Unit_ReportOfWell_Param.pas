unit Unit_ReportOfWell_Param;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Spin, ImgList, ToolWin, mpiDeclaration,
  Menus;

type
  TfrmReportOfWell_Param = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    tsh1: TTabSheet;
    tsh2: TTabSheet;
    tsh3: TTabSheet;
    tsh4: TTabSheet;
    tsh5: TTabSheet;
    tsh6: TTabSheet;
    tsh7: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label5: TLabel;
    eDepthStep: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    seGolovasticRadius: TSpinEdit;
    Label9: TLabel;
    lbSeries: TListBox;
    Bevel3: TBevel;
    Label10: TLabel;
    Bevel4: TBevel;
    lbPole1: TListBox;
    ToolBar1: TToolBar;
    tbRemoveSeries: TToolButton;
    ilRecyled: TImageList;
    cbNominalDiametr: TCheckBox;
    eNominalDiametr: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    lbLayer: TListBox;
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    tbAddLayer: TToolButton;
    tbDeleteLayer: TToolButton;
    Bevel5: TBevel;
    PopupMenu1: TPopupMenu;
    ilBrushStyle: TImageList;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ToolButton3: TToolButton;
    pLithographyLayer: TPanel;
    Label13: TLabel;
    eNameLayer: TEdit;
    lLayerColor: TLabel;
    pLayerColor: TPanel;
    Label14: TLabel;
    Panel3: TPanel;
    PaintBox1: TPaintBox;
    eBeginLayerDepth: TEdit;
    eEndLayerDepth: TEdit;
    bApplyLayer: TButton;
    Label15: TLabel;
    Label16: TLabel;
    ColorDialog1: TColorDialog;
    N7: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    Bevel6: TBevel;
    lbFreqLayer: TListBox;
    ControlBar2: TControlBar;
    ToolBar3: TToolBar;
    tbAddFreqLayer: TToolButton;
    ToolButton6: TToolButton;
    tbDeleteFreqLayer: TToolButton;
    pFreqLayer: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    eBeginDepthFreqLayer: TEdit;
    eEndDepthFreqLayer: TEdit;
    Button3: TButton;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    seAzimWindowFreqLayer: TSpinEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    seBeginAlfaFreqlayer: TSpinEdit;
    seEndAlfaFreqLayer: TSpinEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    ilHolovastic: TImageList;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    bbLoadLasFile: TBitBtn;
    Bevel7: TBevel;
    Label52: TLabel;
    lbGISSeries: TListBox;
    Bevel8: TBevel;
    Label53: TLabel;
    lbGISPole: TListBox;
    tbGISButton: TToolBar;
    tbRemoveGISSeries: TToolButton;
    OpenDialog1: TOpenDialog;
    lFileName: TLabel;
    Label54: TLabel;
    pGisSeriesParam: TPanel;
    Label55: TLabel;
    lGisSeriesName: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    seGisSeriesWidth: TSpinEdit;
    panelLineStyle: TPanel;
    pbGisSeriesStyle: TPaintBox;
    pGisSeriesCOlor: TPanel;
    pmGisSeriesStyle: TPopupMenu;
    fg1: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    imGisSeriesStyle: TImageList;
    seMain1: TSpinEdit;
    se1: TSpinEdit;
    se4: TSpinEdit;
    seMain2: TSpinEdit;
    se3: TSpinEdit;
    seMain3: TSpinEdit;
    se2: TSpinEdit;
    seMain4: TSpinEdit;
    se5: TSpinEdit;
    seMain5: TSpinEdit;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    bbRemoveGISLasFile: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Label3DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure seGolovasticRadiusChange(Sender: TObject);
    procedure lbSeriesClick(Sender: TObject);
    procedure lbSeriesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbPole1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbPole1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbPole1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbPole1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbPole1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbRemoveSeriesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbNominalDiametrClick(Sender: TObject);
    procedure tbAddLayerClick(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure miLayerBrushStyleClick(Sender: TObject);
    procedure pLayerColorClick(Sender: TObject);
    procedure bApplyLayerClick(Sender: TObject);
    procedure tbInsertLayerClick(Sender: TObject);
    procedure eNameLayerChange(Sender: TObject);
    procedure lbLayerClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure eBeginLayerDepthChange(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure tbAddFreqLayerClick(Sender: TObject);
    procedure tbInsertFreqLayerClick(Sender: TObject);
    procedure lbFreqLayerClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FreqLayerChange(Sender: TObject);
    procedure tbDeleteLayerClick(Sender: TObject);
    procedure tbDeleteFreqLayerClick(Sender: TObject);
    procedure bbLoadLasFileClick(Sender: TObject);
    procedure lbGISSeriesClick(Sender: TObject);
    procedure lbGISSeriesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbGISPoleDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbGISPoleDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbGISPoleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbRemoveGISSeriesClick(Sender: TObject);
    procedure lbGISPoleEnter(Sender: TObject);
    procedure pGisSeriesCOlorClick(Sender: TObject);
    procedure pbGisSeriesStyleClick(Sender: TObject);
    procedure seseGisSeriesWidthChange(Sender: TObject);
    procedure pbGisSeriesStylePaint(Sender: TObject);
    procedure fg1Click(Sender: TObject);
    procedure se1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbRemoveGISLasFileClick(Sender: TObject);
  private
    lbMouseDown   : Boolean;
    lbItemIndex   : Integer;
    lbDragString  : String;
    lbDragObject  : TSeries;

    DataFilling : Boolean;

    function  SeriesPresent(aName : String):boolean;
    procedure Add_Lithography_Layer(Pos : Integer);
    procedure Add_Freq_Layer(Pos : Integer);

    procedure ReAddAllLitLayer();
    procedure ReAddAllFreqLayer();
  public
    procedure addSeriesToPoleDopCurves(Series : TSeries);
    procedure addSeriesToGISPole(Series : TSeries);
    procedure LoadGisLasFile(aFileName : String);
  end;

var
  frmReportOfWell_Param: TfrmReportOfWell_Param;

implementation

uses mpiReportClass, mpiLibrary, Unit_ReportOfWell,
  Unit_Main, Unit_PlanshetCreator, mpiLasFile, Unit_CaptionSaveLoad;

{$R *.DFM}

{===============================================================================
}
procedure TfrmReportOfWell_Param.FormShow(Sender: TObject);
begin
   DataFilling := False;
  // ----------------------------
    Caption := frmMainCaption + frmMain.aReportOfWell.Caption + '  -  Параметры' ;
  // ----------------------------
    lbSeries.Items.Assign(frmPlanshetCreator.lbSeries.Items);
    PageControl1.ActivePageIndex := 0;
  // ----------------------------
    if TGIS(ReportClass.PoleList.Items[4]).GISLasFile = nil then bbRemoveGISLasFile.Enabled := false
                                                            else bbRemoveGISLasFile.Enabled := true;
    if lbGISPole.ItemIndex = -1 then tbRemoveGISSeries.Enabled := false
                                else tbRemoveGISSeries.Enabled := true;

    // ------------- 1111111111 ----------------
{    if ReportClass.MashtabCoef > 1 then TrackBar1.Position := Round(ReportClass.MashtabCoef + 10);
    if ReportClass.MashtabCoef = 1 then TrackBar1.Position := 10;
    if ReportClass.MashtabCoef < 1 then TrackBar1.Position := Round(ReportClass.MashtabCoef * 10);
}
//    eDepthStep.text := FloatToStr(TDepthPole(ReportClass.PoleList.Items[0]).StepDepthLabel);
    // ------------- 2222222222 ----------------
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.TrackBar1Change(Sender: TObject);
begin
    if TrackBar1.Position > 10 then ReportClass.MashtabCoef := TrackBar1.Position - 9;
    if TrackBar1.Position = 10 then ReportClass.MashtabCoef := 1;
    if TrackBar1.Position < 10 then ReportClass.MashtabCoef := TrackBar1.Position / 10;

    Label70.Caption := FloatToStrF(ReportClass.MashtabCoef, ffFixed, 20, 1);

    frmReportOfWell.ScrollBar1Change(Sender);
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.Label3DblClick(Sender: TObject);
begin
   TrackBar1.Position := 10;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.BitBtn1Click(Sender: TObject);
begin
  Try TDepthPole  (ReportClass.PoleList.Items[0]).StepDepthLabel := StrToFloat(eDepthStep.text)      except ShowWrongEdit(eDepthStep     ); exit end;
  Try TMidleRadius(ReportClass.PoleList.Items[3]).NominalDiametr := StrToFloat(eNominalDiametr.text) except ShowWrongEdit(eNominalDiametr); exit end;

  ReportClass.Draw;
  close;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.seGolovasticRadiusChange(Sender: TObject);
begin
   TGolovastic(ReportClass.PoleList.Items[5]).HolovasticRadius := seGolovasticRadius.Value;
   ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbSeriesClick(Sender: TObject);
var
  CurItemIndex : Integer;
  CurTag       : Integer;
begin
  CurItemIndex := TListBox(Sender).ItemIndex;
  CurTag       := TListBox(Sender).Tag;

  lbPole1 .ItemIndex := -1;
  lbSeries.ItemIndex := -1;

  TListBox(Sender).ItemIndex := CurItemIndex;

  if CurTag = -1 then tbRemoveSeries.Enabled := False
                 else tbRemoveSeries.Enabled := True;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbSeriesDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

{===============================================================================
}
function TfrmReportOfWell_Param.SeriesPresent(aName: String): boolean;
var
  i       : Integer;
  mdr     : word;
begin
  result     := false;

      for i := 0 to lbPole1.Items.Count - 1 do
         if lbPole1.Items.Strings[i] = aName then Result := true;

  if Result then begin
      Beep();
      mdr := MessageDlg('Кривая на планшете уже присутсвует.'#10#13#10#13'Положить кривую на поле ?', mtWarning, [mbOk, mbCancel], 0);
      if mdr = mrOk then result := False;
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbPole1DragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  lbSource : TListBox;
  lbSender : TListBox;
  Series   : TSeries;
begin
  // --- Переносим информацию с "SOURCE" в "SENDER" ---
  if  TListBox(Source).ItemIndex = -1 then exit;

  lbSource := TListBox(Source);
  lbSender := TListBox(Sender);
  Series   := Tseries(lbSource.Items.Objects[lbSource.ItemIndex]);
  // ---------- Проверка на количество кивых --------
{  if lbSender.Items.Count >= 3 then begin
      MessageDlg('В этом разделе не допускается ложить больше трех кривых на поле ...', mtWarning, [mbOk], 0);
      exit;
  end;}
  // ---- Проверка на пристутсвие кривой ---------
  if SeriesPresent(Series.Name) then exit;
  addSeriesToPoleDopCurves(Series);
  // ---- Параметры Скорлл Бара
  // frmMain.Set_ScrollBarParam();
  // ------
  lbSource.ItemIndex := -1;
  lbSender.SetFocus;
  // --- Отрисовуем то, что полуямлось -----------
  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbPole1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lbMouseDown := True;
  lbItemIndex := TListBox(Sender).ItemIndex;

  if lbItemIndex <> -1 then begin
    lbDragString := TListBox(Sender).Items.Strings[lbItemIndex];
    lbDragObject := TSeries(TListBox(Sender).Items.Objects[lbItemIndex]);
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbPole1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if lbMouseDown and (TListBox(Sender).ItemIndex <> -1) then begin
    if TListBox(Sender).ItemIndex <> lbItemIndex then begin
       TListBox(Sender).Items.Strings[lbItemIndex] := TListBox(Sender).Items.Strings[TListBox(Sender).ItemIndex];
       TListBox(Sender).Items.Objects[lbItemIndex] := TListBox(Sender).Items.Objects[TListBox(Sender).ItemIndex];

       TListBox(Sender).Items.Strings[TListBox(Sender).ItemIndex] := lbDragString;
       TListBox(Sender).Items.Objects[TListBox(Sender).ItemIndex] := lbDragObject;

       lbItemIndex := TListBox(Sender).ItemIndex;
    end;
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbPole1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i : integer;
begin
  lbMouseDown := False;

  if lbDragObject <> nil then begin
    for i := 0 to TListBox(Sender).Items.Count - 1 do
       TDropCurves(ReportClass.PoleList.Items[2]).SeriesList.Items[i] := TListBox(Sender).Items.Objects[i];

    ReportClass.Draw;
  end;

  lbItemIndex  := -1;
  lbDragObject := nil;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbPole1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if TListBox(Sender).ItemIndex = -1 then exit;

  if Key = 46 then
    tbRemoveSeriesClick(Sender)
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.tbRemoveSeriesClick(Sender: TObject);
var
  OldIndex  : Integer;
begin
  if lbPole1.ItemIndex = -1 then exit;

  OldIndex := lbPole1.ItemIndex;
  TDropCurves(ReportClass.PoleList.Items[2]).SeriesList.Delete(OldIndex);
  lbPole1.Items.Delete(OldIndex);

  tbRemoveSeries.Enabled := False;

  if OldIndex > lbPole1.Items.Count - 1 then OldIndex := lbPole1.Items.Count - 1;

  if OldIndex <> -1 then begin
     lbPole1.ItemIndex      := OldIndex;
     tbRemoveSeries.Enabled := true;
  end;

  lbPole1.Refresh;
  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.addSeriesToPoleDopCurves(Series : TSeries);
var
  AbsMaxValue : Float;
begin
  // ---- Добавляем серию -------
     lbPole1.Items.AddObject(Series.Name,  Series);
     lbPole1.ItemIndex := lbPole1.Items.Count - 1;
     TDropCurves(ReportClass.PoleList.Items[2]).SeriesList.Add(Series);
     if (Series.CorrectMinValue = 0) and (Series.CorrectMaxValue = 0) then begin
           // ---- Устанавливаем откоректированные значения максимума и минимума -------
           if abs(Series.MaxValue) > abs(Series.MinValue) then AbsMaxValue := abs(Series.MaxValue)
                                                          else AbsMaxValue := abs(Series.MinValue);

           // --- Выставляю для покладеной на поле новые максимумы - минимумы --------
           Series.CorrectMaxValue := Series.MaxValue + AbsMaxValue*0.07;
           Series.CorrectMinValue := Series.MinValue - AbsMaxValue*0.07;
           // ---
           if Series.CorrectMaxValue - Series.CorrectMinValue = 0 then begin
               Series.CorrectMaxValue :=  1;
               Series.CorrectMaxValue := -1
           end;
     end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.cbNominalDiametrClick(Sender: TObject);
begin
   Label11.Enabled         := cbNominalDiametr.Checked;
   Label12.Enabled         := cbNominalDiametr.Checked;
   eNominalDiametr.Enabled := cbNominalDiametr.Checked;

   TMidleRadius(ReportClass.PoleList.Items[3]).NominalDiametrEnabled := cbNominalDiametr.Checked;

   ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.Add_Lithography_Layer(Pos: Integer);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  Lithography.CurEditIndexInListBox := pos;

  ReAddAllLitLayer();

  Lithography.LayerArray[Pos].NameLayer       :=  'Без имени';
  Lithography.LayerArray[Pos].LayerPenColor   :=  clBlack;
  Lithography.LayerArray[Pos].LayerBrushStyle   :=  byte(bsBDiagonal);
  Lithography.LayerArray[Pos].BeginDepth      :=  LasFile.WellInf.Start;
  Lithography.LayerArray[Pos].EndDepth        :=  LasFile.WellInf.Stop;

  pLayerColor.Color     := clBlack;
  eNameLayer.Text       := Lithography.LayerArray[Pos].NameLayer;
//  eBeginLayerDepth.Text := FloatToStrF(Lithography.LayerArray[Pos].BeginDepth, ffFixed, 20, 4);
//  eEndLayerDepth.Text   := FloatToStrF(Lithography.LayerArray[Pos].EndDepth, ffFixed, 20, 4);

  pLithographyLayer.visible := true;

  tbAddLayer.Enabled        := false;
//  tbInsertLayer.Enabled     := false;
  tbDeleteLayer.Enabled     := false;
  lbLayer.Enabled           := false;

  BitBtn1.Enabled           := false;
  BitBtn2.Enabled           := false;

  PaintBox1.Repaint;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.tbAddLayerClick(Sender: TObject);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);
  SetLength(Lithography.LayerArray, Length(Lithography.LayerArray) + 1);

  Add_Lithography_Layer(lbLayer.Items.Count);

  lbLayer.ItemIndex := -1;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.tbInsertLayerClick(Sender: TObject);
var
  Lithography : TLithography;
  i           : Integer;
begin

  if lbLayer.ItemIndex = -1 then exit;
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  SetLength(Lithography.LayerArray, Length(Lithography.LayerArray) + 1);

  for i := Length(Lithography.LayerArray) - 1 downto lbLayer.ItemIndex + 1 do
     Lithography.LayerArray[i] := Lithography.LayerArray[i-1];

  FillChar(Lithography.LayerArray[lbLayer.ItemIndex], SizeOf(Lithography.LayerArray[lbLayer.ItemIndex]), 0);

  Add_Lithography_Layer(lbLayer.ItemIndex);
  lbLayer.ItemIndex := -1;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.bApplyLayerClick(Sender: TObject);
var
  Lithography : TLithography;
begin
   Lithography := TLithography(ReportClass.PoleList.Items[1]);

   try Lithography.LayerArray[Lithography.CurEditIndexInListBox].BeginDepth := StrToFloat(eBeginLayerDepth.Text) except ShowWrongEdit(eBeginLayerDepth); exit end;
   try Lithography.LayerArray[Lithography.CurEditIndexInListBox].EndDepth   := StrToFloat(eEndLayerDepth  .Text) except ShowWrongEdit(eEndLayerDepth  ); exit end;

   Lithography.LayerArray[Lithography.CurEditIndexInListBox].LayerPenColor := pLayerColor.Color;
   Lithography.LayerArray[Lithography.CurEditIndexInListBox].LayerBrushStyle := Integer(PaintBox1.Canvas.Brush.Style);
   eNameLayerChange(Sender);

   // ---------- Тут возмоно какие нибудь передупредения на стет неправильного ввода глубин --------
   if (Lithography.LayerArray[Lithography.CurEditIndexInListBox].BeginDepth < LasFile.WellInf.Start) or
      (Lithography.LayerArray[Lithography.CurEditIndexInListBox].BeginDepth > LasFile.WellInf.Stop) then begin
      eBeginLayerDepth.SetFocus;
      eBeginLayerDepth.SelectAll;
      Beep();
      MessageDLG('Введенное значение глубины выходит за рамки диапазона глубин LAS файла', mtError, [mbOk], 0);
      exit;
   end;
   if (Lithography.LayerArray[Lithography.CurEditIndexInListBox].EndDepth < LasFile.WellInf.Start) or
      (Lithography.LayerArray[Lithography.CurEditIndexInListBox].EndDepth > LasFile.WellInf.Stop) then begin
      eEndLayerDepth.SetFocus;
      eEndLayerDepth.SelectAll;
      Beep();
      MessageDLG('Введенное значение глубины выходит за рамки диапазона глубин LAS файла', mtError, [mbOk], 0);
      exit;
   end;
   // ---------- End Of Тут возмоно какие нибудь передупредения на стет неправильного ввода глубин --------

   pLithographyLayer.Visible := False;

   tbAddLayer.Enabled        := true;
//   tbInsertLayer.Enabled     := false;
   tbDeleteLayer.Enabled     := false;
   lbLayer.Enabled           := True;
   lbLayer.ItemIndex         := -1;

   BitBtn1.Enabled           := true;
   BitBtn2.Enabled           := true;

   ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.PaintBox1Paint(Sender: TObject);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  With PaintBox1.Canvas do begin
     Pen.Color   := clBlack;

     Brush.Color := Lithography.LayerArray[Lithography.CurEditIndexInListBox].LayerPenColor;
     Brush.Style := TBrushStyle(Lithography.LayerArray[Lithography.CurEditIndexInListBox].LayerBrushStyle);

     Rectangle(0,0,PaintBox1.Width, PaintBox1.Height);
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.PaintBox1Click(Sender: TObject);
var
  CurPoint    : TPoint;
begin
      CurPoint.X := tsh2.Left + pLithographyLayer.Left + Panel3.Left;
      CurPoint.Y := tsh2.Top + pLithographyLayer.Top + Panel3.Top + Panel3.Height+1;
      CurPoint   := ClientToScreen(CurPoint);
      PopUpMenu1.Popup(CurPoint.X, CurPoint.Y);
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.miLayerBrushStyleClick(Sender: TObject);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);
  Lithography.LayerArray[Lithography.CurEditIndexInListBox].LayerBrushStyle := TMenuItem(Sender).Tag;

  PaintBox1.Repaint;
   ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.pLayerColorClick(Sender: TObject);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  if ColorDialog1.Execute then begin
    Lithography.LayerArray[Lithography.CurEditIndexInListBox].LayerPenColor := ColorDialog1.Color;
    pLayerColor.Color := ColorDialog1.Color;
  end;

  PaintBox1.Repaint;
   ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.eNameLayerChange(Sender: TObject);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  Lithography.LayerArray[Lithography.CurEditIndexInListBox].NameLayer := eNameLayer.Text;

  lbLayer.Items.Strings[Lithography.CurEditIndexInListBox] := Lithography.LayerArray[Lithography.CurEditIndexInListBox].NameLayer;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbLayerClick(Sender: TObject);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  if lbLayer.ItemIndex = -1 then exit;

//  tbInsertLayer.Enabled := true;
  tbDeleteLayer.Enabled := true;

  // ------------------------
     Lithography.CurEditIndexInListBox := lbLayer.ItemIndex;

     eNameLayer.text       := Lithography.LayerArray[Lithography.CurEditIndexInListBox].NameLayer;
     pLayerColor.Color     := Lithography.LayerArray[Lithography.CurEditIndexInListBox].LayerPenColor;
     eBeginLayerDepth.Text := FloatToStrF(Lithography.LayerArray[Lithography.CurEditIndexInListBox].BeginDepth, ffFixed, 20, 4);
     eEndLayerDepth  .Text := FloatToStrF(Lithography.LayerArray[Lithography.CurEditIndexInListBox].EndDepth, ffFixed, 20, 4);

     pLithographyLayer.Visible := True;

     lbLayer.Enabled           := True;
     BitBtn1.Enabled           := True;
     BitBtn2.Enabled           := True;
     tbAddLayer.Enabled        := True;
//     tbInsertLayer.Enabled     := True;
     tbDeleteLayer.Enabled     := True;

     PaintBox1.Repaint;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.Button1Click(Sender: TObject);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  if Lithography.CurEditIndexInListBox = 0 then begin
     eBeginLayerDepth.Text :=  FloatToStrF(LasFile.WellInf.Start, ffFixed, 20, 4)
  end else begin
     eBeginLayerDepth.Text := FloatToStrF(Lithography.LayerArray[Lithography.CurEditIndexInListBox - 1].EndDepth, ffFixed, 20, 4)
  end;
   ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.Button2Click(Sender: TObject);
var
  Lithography : TLithography;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  if Lithography.CurEditIndexInListBox = lbLayer.Items.Count - 1 then begin
     eEndLayerDepth.Text := FloatToStrF(LasFile.WellInf.Stop, ffFixed, 20, 4)
  end else begin
     eEndLayerDepth.Text := FloatToStrF(Lithography.LayerArray[Lithography.CurEditIndexInListBox + 1].BeginDepth, ffFixed, 20, 4)
  end;
   ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if BitBtn1.Enabled then CanClose := True
                     else CanClose := false;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.eBeginLayerDepthChange(Sender: TObject);
begin
     lbLayer.Enabled           := false;
     BitBtn1.Enabled           := false;
     BitBtn2.Enabled           := false;
     tbAddLayer.Enabled        := false;
//     tbInsertLayer.Enabled     := false;
     tbDeleteLayer.Enabled     := false;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (PageControl1.ActivePageIndex = 1) and (not BitBtn1.Enabled) then AllowChange := False
                                                                  else AllowChange := True;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.Add_Freq_Layer(Pos: Integer);
var
  FreqPole : TFreqPole;
begin
  FreqPole := TFreqPole(ReportClass.PoleList.Items[6]);

  FreqPole.CurEditIndexInFreqListBox := pos;

  ReAddAllFreqLayer();

  FreqPole.FreqLayerArray[Pos].BeginDepth      := LasFile.WellInf.Start;
  FreqPole.FreqLayerArray[Pos].EndDepth        := LasFile.WellInf.Stop;

  DataFilling := true;
    seAzimWindowFreqLayer.Value := 11;
    seBeginAlfaFreqlayer.Value  := 0;
    seEndAlfaFreqlayer.Value    := 30;
    eBeginDepthFreqLayer.Text   := '0';
    eEndDepthFreqLayer.Text     := '0';
  DataFilling := false;

  FreqPole.FreqLayerArray[Pos].AzimWindow      := 11;
  FreqPole.FreqLayerArray[Pos].BeginAlfa       := 0;
  FreqPole.FreqLayerArray[Pos].EndAlfa         := 30;


  pFreqLayer.visible := true;

  tbAddFreqLayer.Enabled        := false;
//  tbInsertFreqLayer.Enabled     := false;
  tbDeleteFreqLayer.Enabled     := false;
  lbFreqLayer.Enabled           := false;

  BitBtn1.Enabled           := false;
  BitBtn2.Enabled           := false;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.tbAddFreqLayerClick(Sender: TObject);
var
  FreqPole : TFreqPole;
begin
  FreqPole := TFreqPole(ReportClass.PoleList.Items[6]);
  SetLength(FreqPole.FreqLayerArray, Length(FreqPole.FreqLayerArray) + 1);

  Add_Freq_Layer(Length(FreqPole.FreqLayerArray)-1);

  lbLayer.ItemIndex := -1;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.tbInsertFreqLayerClick(Sender: TObject);
var
  FreqPole : TFreqPole;
  i        : Integer;
begin
  if lbLayer.ItemIndex = -1 then exit;
  FreqPole := TFreqPole(ReportClass.PoleList.Items[6]);

  SetLength(FreqPole.FreqLayerArray, Length(FreqPole.FreqLayerArray) + 1);

  for i := Length(FreqPole.FreqLayerArray) - 1 downto lbFreqLayer.ItemIndex + 1 do
      FreqPole.FreqLayerArray[i] := FreqPole.FreqLayerArray[i-1];

  FillChar(FreqPole.FreqLayerArray[lbFreqLayer.ItemIndex], SizeOf(FreqPole.FreqLayerArray[lbFreqLayer.ItemIndex]), 0);

  Add_Freq_Layer(lbFreqLayer.ItemIndex);
  lbFreqLayer.ItemIndex := -1;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbFreqLayerClick(Sender: TObject);
var
  FreqPole : TFreqPole;
  v1, v2, v3 : Integer;
begin
  FreqPole := TFreqPole(ReportClass.PoleList.Items[6]);

  if lbFreqLayer.ItemIndex = -1 then exit;

//  tbInsertFreqLayer.Enabled := true;
  tbDeleteFreqLayer.Enabled := true;
  DataFilling :=  True;

  // ------------------------

     FreqPole.CurEditIndexInFreqListBox := lbFreqLayer.ItemIndex;

     eBeginDepthFreqLayer.Text   := FloatToStrF(FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].BeginDepth, ffFixed, 20, 4);
     eEndDepthFreqLayer  .Text   := FloatToStrF(FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].EndDepth, ffFixed, 20, 4);

     v1 := FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].AzimWindow;
     v2 := FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].BeginAlfa;
     v3 := FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].EndAlfa;

     seAzimWindowFreqLayer.Value := v1;
     seBeginAlfaFreqlayer.Value  := v2;
     seEndAlfaFreqlayer.Value    := v3;

     FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].AzimWindow := v1;
     FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].BeginAlfa  := v2;
     FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].EndAlfa    := v3;

     pFreqLayer.Visible := True;
     DataFilling        := False;

     lbFreqLayer.Enabled           := True;
     BitBtn1.Enabled               := True;
     BitBtn2.Enabled               := True;
     tbAddFreqLayer.Enabled        := True;
//     tbInsertFreqLayer.Enabled     := True;
     tbDeleteFreqLayer.Enabled     := True;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.Button3Click(Sender: TObject);
var
  FreqPole : TFreqPole;
begin
  FreqPole := TFreqPole(ReportClass.PoleList.Items[6]);

   try FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].BeginDepth := StrToFloat(eBeginDepthFreqLayer.Text) except ShowWrongEdit(eBeginDepthFreqLayer); exit end;
   try FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].EndDepth   := StrToFloat(eEndDepthFreqLayer  .Text) except ShowWrongEdit(eEndDepthFreqLayer  ); exit end;

   FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].AzimWindow := seAzimWindowFreqLayer.Value;
   FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].BeginAlfa  := seBeginAlfaFreqlayer.Value;
   FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].EndAlfa    := seEndAlfaFreqlayer.Value;

   // ---------- Тут возмоно какие нибудь передупредения на стет неправильного ввода глубин --------
   if (FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].BeginDepth < LasFile.WellInf.Start) or
      (FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].BeginDepth > LasFile.WellInf.Stop) then begin
      eBeginDepthFreqLayer.SetFocus;
      eBeginDepthFreqLayer.SelectAll;
      Beep();
      MessageDLG('Введенное значение глубины выходит за рамки диапазона глубин LAS файла', mtError, [mbOk], 0);
      exit;
   end;
   if (FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].EndDepth < LasFile.WellInf.Start) or
      (FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].EndDepth > LasFile.WellInf.Stop) then begin
      eEndDepthFreqLayer.SetFocus;
      eEndDepthFreqLayer.SelectAll;
      Beep();
      MessageDLG('Введенное значение глубины выходит за рамки диапазона глубин LAS файла', mtError, [mbOk], 0);
      exit;
   end;
   // ---------- End Of Тут возмоно какие нибудь передупредения на стет неправильного ввода глубин --------
   ReAddAllFreqLayer();

   pFreqLayer.Visible := False;

   tbAddFreqLayer.Enabled        := true;
//   tbInsertFreqLayer.Enabled     := false;
   tbDeleteFreqLayer.Enabled     := false;
   lbFreqLayer.Enabled           := true;
   lbFreqLayer.ItemIndex         := -1;

   BitBtn1.Enabled           := true;
   BitBtn2.Enabled           := true;

   ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.FreqLayerChange(
  Sender: TObject);
var
  FreqPole : TFreqPole;
begin
  if DataFilling then exit;
  
  FreqPole := TFreqPole(ReportClass.PoleList.Items[6]);

     lbFreqLayer.Enabled           := false;
     BitBtn1.Enabled               := false;
     BitBtn2.Enabled               := false;
     tbAddFreqLayer.Enabled        := false;
//     tbInsertFreqLayer.Enabled     := false;
     tbDeleteFreqLayer.Enabled     := false;

  if FreqPole.CurEditIndexInFreqListBox <> -1 then begin
     LbFreqLayer.Items.Strings[FreqPole.CurEditIndexInFreqListBox] := eBeginDepthFreqLayer.Text + ' - ' + eEndDepthFreqLayer.Text;

     if UpperCase(TComponent(Sender).Name) = UpperCase('seBeginAlfaFreqlayer') then begin
        if seBeginAlfaFreqlayer.Value >= seEndAlfaFreqlayer.Value then begin
          seBeginAlfaFreqlayer.Value    := seEndAlfaFreqlayer.Value - 1;
        end;
        seBeginAlfaFreqlayer.MaxValue := seEndAlfaFreqlayer.Value - 1;
        seEndAlfaFreqlayer.MinValue   := seBeginAlfaFreqlayer.Value + 1;
     end;
     if UpperCase(TComponent(Sender).Name) = UpperCase('seEndAlfaFreqlayer') then begin
        if seEndAlfaFreqlayer.Value <= seBeginAlfaFreqlayer.Value then begin
          seEndAlfaFreqlayer.Value    := seBeginAlfaFreqlayer.Value + 1;
        end;
        seEndAlfaFreqlayer  .MinValue := seBeginAlfaFreqlayer.Value + 1;
        seBeginAlfaFreqlayer.MaxValue := seEndAlfaFreqlayer.Value - 1;
     end;

     FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].AzimWindow := seAzimWindowFreqLayer.Value;
     FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].BeginAlfa  := seBeginAlfaFreqlayer.Value;
     FreqPole.FreqLayerArray[FreqPole.CurEditIndexInFreqListBox].EndAlfa    := seEndAlfaFreqlayer.Value;

     ReportClass.Draw;
  end;

end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.ReAddAllFreqLayer();
var
  FreqPole : TFreqPole;
  i        : Integer;
begin
  FreqPole := TFreqPole(ReportClass.PoleList.Items[6]);

  lbFreqLayer.Clear;
  for i := 0 to Length(FreqPole.FreqLayerArray) - 1 do begin
      lbFreqLayer.Items.AddObject(FLoatTOStrF(FreqPole.FreqLayerArray[i].BeginDepth, ffFixed, 20,4) + ' - ' + FLoatTOStrF(FreqPole.FreqLayerArray[i].EndDepth, ffFixed, 20,4), addr(FreqPole.FreqLayerArray[i]));
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.tbDeleteLayerClick(Sender: TObject);
var
  Lithography : TLithography;
  i           : Integer;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  if lbLayer.ItemIndex = -1 then exit;

  for i := lbLayer.ItemIndex to Length(Lithography.LayerArray) - 2 do begin
     Lithography.LayerArray[i] := Lithography.LayerArray[i+1];
  end;

  SetLength(Lithography.LayerArray, Length(Lithography.LayerArray) - 1);
  ReAddAllLitLayer();

  pLithographyLayer.Visible := False;
  tbDeleteLayer.Enabled     := False;

  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.ReAddAllLitLayer();
var
  Lithography : TLithography;
  i        : Integer;
begin
  Lithography := TLithography(ReportClass.PoleList.Items[1]);

  lbLayer.Clear;
  for i := 0 to Length(Lithography.LayerArray) - 1 do begin
      lbLayer.Items.AddObject(Lithography.LayerArray[i].NameLayer, Pointer(@Lithography.LayerArray[i]));
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.tbDeleteFreqLayerClick(Sender: TObject);
var
  FreqPole    : TFreqPole;
  i           : Integer;
begin
  FreqPole := TFreqPole(ReportClass.PoleList.Items[6]);

  if lbFreqLayer.ItemIndex = -1 then exit;

  for i := lbFreqLayer.ItemIndex to Length(FreqPole.FreqLayerArray) - 2 do begin
     FreqPole.FreqLayerArray[i] := FreqPole.FreqLayerArray[i+1];
  end;

  SetLength(FreqPole.FreqLayerArray, Length(FreqPole.FreqLayerArray) - 1);
  ReAddAllFreqLayer();

  pFreqLayer.Visible        := False;
  tbDeleteFreqLayer.Enabled := False;

  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.bbLoadLasFileClick(Sender: TObject);
var
  FileName : String;
begin
  Application.ProcessMessages;
  // --- Параметры Open Диалога ----
  OpenDialog1.Title      := frmMainCaption + 'Отрытие "GIS Las" файлa';
  OpenDialog1.Filter     := 'GIS Las файл (*.las)|*.las';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Las\';
  OpenDialog1.FileName   := '';
  // ---------
  if OpenDialog1.Execute then begin
      FileName := OpenDialog1.FileName;
      if ExtractFileExt(FileName) = ''                 then FileName := FileName + '.las';
      if UpperCase(ExtractFileExt(FileName)) <> '.LAS' then exit;

      LoadGisLasFile(FileName);
      ReportClass.Draw;
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.LoadGisLasFile(aFileName: String);
var
  GISPole  : TGIS;
  i        : Integer;
  Series   : TSeries;
begin
  GISPole := TGIS(ReportClass.PoleList.Items[4]);

      if GISPole.GISLasFile <> nil then bbRemoveGISLasFileClick(nil);

      if not FileExists(aFileName) then exit;

        lFileName.Caption := aFileName;
        lFileName.Hint    := aFileName;

     // -------- Загрузка ---------------
        frmCaptionSaveLoad.aCaption := 'Загрузка файла';
        frmCaptionSaveLoad.Show;
        Application.ProcessMessages;
              GISPole.GISLasFile := TLasFile.Create(aFileName, lfGisLasFile);
        frmCaptionSaveLoad.Close;
     // ------ End of Загрузка ---------------

     // ------- Заполнение ГИС Лист Бокса Кривыми
       for i := 0 to GISPole.GISLasFile.SeriesList.Count - 1 do begin
          Series := Tseries(GISPOle.GISLasFile.SeriesList.Items[i]);
          lbGISSeries.Items.AddObject(Series.Name, Series);
       end;
    // -----------------------
      bbRemoveGISLasFile.Enabled := true;
      lbGISSeries.ItemIndex      := -1;
      tbGISButton.Enabled        := true;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbGISSeriesClick(Sender: TObject);
var
  CurItemIndex : Integer;
  CurTag       : Integer;
begin
  CurItemIndex := TListBox(Sender).ItemIndex;
  CurTag       := TListBox(Sender).Tag;

  lbGISPole  .ItemIndex := -1;
  lbGISSeries.ItemIndex := -1;

  TListBox(Sender).ItemIndex := CurItemIndex;

  if CurTag = -1 then tbRemoveGISSeries.Enabled := False
                 else tbRemoveGISSeries.Enabled := True;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbGISSeriesDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbGISPoleDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  lbSource : TListBox;
  lbSender : TListBox;
  Series   : TSeries;
begin
  // --- Переносим информацию с "SOURCE" в "SENDER" ---
  if  TListBox(Source).ItemIndex = -1 then exit;

  lbSource := TListBox(Source);
  lbSender := TListBox(Sender);
  Series   := Tseries(lbSource.Items.Objects[lbSource.ItemIndex]);
  // ---------- Проверка на количество кивых --------
  if lbSender.Items.Count >= 1 then begin
      beep();
      MessageDlg('В этом разделе не допускается ложить больше одной кривой на поле ...', mtWarning, [mbOk], 0);
      exit;
  end;
  // ---- Проверка на пристутсвие кривой ---------
  addSeriesToGISPole(Series);
  // ------
  lbSource.ItemIndex := -1;
  lbSender.SetFocus;
  tbRemoveGISSeries.Enabled := True;
  // --- Отрисовуем то, что получилось -----------
  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbGISPoleDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbGISPoleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if TListBox(Sender).ItemIndex = -1 then exit;

  if Key = 46 then
    tbRemoveGISSeriesClick(Sender)
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.tbRemoveGISSeriesClick(Sender: TObject);
var
  OldIndex  : Integer;
begin
  if lbGISPole.ItemIndex = -1 then exit;

  OldIndex := lbGISPole.ItemIndex;
  TGIS(ReportClass.PoleList.Items[4]).SeriesList.Delete(OldIndex);
  lbGISPole.Items.Delete(OldIndex);

  if OldIndex > lbGISPole.Items.Count - 1 then OldIndex := lbGISPole.Items.Count - 1;

  tbRemoveGISSeries.Enabled := False;
  pGisSeriesParam.Visible   := False;

  if OldIndex <> -1 then begin
     lbGISPole.ItemIndex       := OldIndex;
     tbRemoveGISSeries.Enabled := true;
  end;


  lbGISPole.Refresh;
  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.addSeriesToGISPole(Series: TSeries);
var
  AbsMaxValue : Float;
begin
  // ---- Добавляем серию -------
     lbGISPole.Items.AddObject(Series.Name,  Series);
     lbGISPole.ItemIndex := lbGISPole.Items.Count - 1;
     TGIS(ReportClass.PoleList.Items[4]).SeriesList.Add(Series);
     if (Series.CorrectMinValue = 0) and (Series.CorrectMaxValue = 0) then begin
           // ---- Устанавливаем откоректированные значения максимума и минимума -------
           if abs(Series.MaxValue) > abs(Series.MinValue) then AbsMaxValue := abs(Series.MaxValue)
                                                          else AbsMaxValue := abs(Series.MinValue);

           // --- Выставляю для покладеной на поле новые максимумы - минимумы --------
           Series.CorrectMaxValue := Series.MaxValue + AbsMaxValue*0.07;
           Series.CorrectMinValue := Series.MinValue - AbsMaxValue*0.07;
           // ---
           if Series.CorrectMaxValue - Series.CorrectMinValue = 0 then begin
               Series.CorrectMaxValue :=  1;
               Series.CorrectMaxValue := -1
           end;
     end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.lbGISPoleEnter(Sender: TObject);
var
  Series : TSeries;
begin
  if TListBox(Sender).Items.Count = 0  then exit;
  if TListBox(Sender).ItemIndex   = -1 then exit;

  Series := TSeries(TGIS(ReportClass.PoleList.Items[4]).SeriesList.Items[TListBox(Sender).ItemIndex]);

  pGisSeriesParam.Visible := True;

  lGisSeriesName.Caption := Series.Name;
  pGisSeriesColor.Color  := Series.PenColor;
  seGisSeriesWidth.Value := Series.PenWidth;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.pGisSeriesCOlorClick(Sender: TObject);
var
  OldColor : TColor;
  Series : TSeries;
begin
  Series := TSeries(TGIS(ReportClass.PoleList.Items[4]).SeriesList.Items[TListBox(Sender).ItemIndex]);

  OldColor           := pGISSeriesColor.Color;
  ColorDialog1.Color := pGISSeriesColor.Color;

  if ColorDialog1.Execute then pGISSeriesColor.Color := ColorDialog1.Color;

  if OldColor <> pGISSeriesColor.Color then begin
    Series.PenColor := pGISSeriesColor.Color;

    pbGisSeriesStyle.Repaint;
    ReportClass.Draw;
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.pbGisSeriesStyleClick(Sender: TObject);
var
  CurPoint    : TPoint;
begin
      CurPoint.X := tsh5.Left +  panelLineStyle.Left;
      CurPoint.Y := tsh5.Top  + panelLineStyle.Top + panelLineStyle.Height+1;
      CurPoint   := ClientToScreen(CurPoint);
      pmGisSeriesStyle.Popup(CurPoint.X, CurPoint.Y);
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.seseGisSeriesWidthChange(Sender: TObject);
var
  Series : TSeries;
begin
  Series := TSeries(TGIS(ReportClass.PoleList.Items[4]).SeriesList.Items[lbGISPole.ItemIndex]);

  Series.PenWidth    := seGisSeriesWidth.Value;
  if Series.PenWidth > 1 then begin
     Series.PenStyle := psSolid;
     pbGisSeriesStyle.RePaint;
  end;
  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.pbGisSeriesStylePaint(Sender: TObject);
var
  Series : TSeries;
begin
  if lbGISPole.ItemIndex = - 1 then exit;

  Series := TSeries(TGIS(ReportClass.PoleList.Items[4]).SeriesList.Items[lbGISPole.ItemIndex]);
  With pbGisSeriesStyle.Canvas do begin
     Pen.Style := Series.PenStyle;
     Pen.Color := Series.PenColor;
     MoveTo (1,                   (pbGisSeriesStyle.Height div 2 )-1);
     LineTo (PaintBox1.Width-1,   (pbGisSeriesStyle.Height div 2 )-1);
     MoveTo (1,                   (pbGisSeriesStyle.Height div 2 )  );
     LineTo (PaintBox1.Width-1,   (pbGisSeriesStyle.Height div 2 )  );
     MoveTo (1,                   (pbGisSeriesStyle.Height div 2 )+1);
     LineTo (PaintBox1.Width-1,   (pbGisSeriesStyle.Height div 2 )+1);
  end;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.fg1Click(Sender: TObject);
var
  Series : TSeries;
begin
  Series := TSeries(TGIS(ReportClass.PoleList.Items[4]).SeriesList.Items[lbGISPole.ItemIndex]);

  Case TComponent(Sender).tag of
    0 : Series.PenStyle := psSolid;
    1 : Series.PenStyle := psDash;
    2 : Series.PenStyle := psDot;
    3 : Series.PenStyle := psDashDot;
    4 : Series.PenStyle := psDashDotDot;
  end;
  if (Series.PenWidth <> 1) and (Series.PenStyle <> psSolid) then Series.PenWidth := 1;

  seGisSeriesWidth.Value := Series.PenWidth;
  pbGisSeriesStyle.Repaint;
  ReportClass.Draw;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.se1Change(Sender: TObject);
var
  GolovasticPole : TGolovastic;
begin
  GolovasticPole := TGolovastic(ReportClass.PoleList.Items[5]);

  se1.MaxValue := 99;

  seMain2.Value := se1.Value;
  seMain3.Value := se2.Value;
  seMain4.Value := se3.Value;
  seMain5.Value := se4.Value;

  if seMain2.Value <= se2.Value then begin se2.Value := seMain2.Value - 1; seMain3.Value := se2.Value end;
  if seMain3.Value <= se3.Value then begin se3.Value := seMain3.Value - 1; seMain4.Value := se3.Value end;
  if seMain4.Value <= se4.Value then begin se4.Value := seMain4.Value - 1; seMain5.Value := se4.Value end;
  if seMain5.Value <= se5.Value then begin se5.Value := seMain5.Value - 1;                            end;

  se2.MaxValue := seMain2.Value - 1;
  se3.MaxValue := seMain3.Value - 1;
  se4.MaxValue := seMain4.Value - 1;
  se5.MaxValue := seMain5.Value - 1;

  GolovasticPole.MinMaxArray[0].min := se1.Value;    GolovasticPole.MinMaxArray[0].max := seMain1.Value;
  GolovasticPole.MinMaxArray[1].min := se2.Value;    GolovasticPole.MinMaxArray[1].max := seMain2.Value;
  GolovasticPole.MinMaxArray[2].min := se3.Value;    GolovasticPole.MinMaxArray[2].max := seMain3.Value;
  GolovasticPole.MinMaxArray[3].min := se4.Value;    GolovasticPole.MinMaxArray[3].max := seMain4.Value;
  GolovasticPole.MinMaxArray[4].min := se5.Value;    GolovasticPole.MinMaxArray[4].max := seMain5.Value;
end;

{===============================================================================
}
procedure TfrmReportOfWell_Param.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmReportOfWell_Param.bbRemoveGISLasFileClick(Sender: TObject);
var
  GISPole  : TGIS;
begin
  GISPole := TGIS(ReportClass.PoleList.Items[4]);

  GISPole.GISLasFile.Free;
  GISPole.GISLasFile := nil;
  // --------------------
  lbGISSeries.Items.Clear;
  lbGISPole.Items.Clear;
  lbGISPole.ItemIndex := -1;
  GISPole.SeriesList.Clear;

  pGisSeriesParam.Visible    := False;
  bbRemoveGISLasFile.Enabled := False;
  tbRemoveGISSeries.Enabled  := False;
end;

end.

