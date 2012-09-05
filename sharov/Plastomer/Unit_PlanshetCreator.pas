unit Unit_PlanshetCreator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, mpiLasFile, MPIDeclaration,
  ImgList;

type
  TfrmPlanshetCreator = class(TForm)
    Label2: TLabel;
    lbSeries: TListBox;
    Bevel1: TBevel;
    Label3: TLabel;
    lbPole1: TListBox;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel3: TBevel;
    lbPole2: TListBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel4: TBevel;
    lbPole3: TListBox;
    Label10: TLabel;
    Label11: TLabel;
    ToolBar1: TToolBar;
    tbRemoveSeries: TToolButton;
    ToolButton3: TToolButton;
    tbPlanshetParam: TToolButton;
    cb1: TCheckBox;
    cb2: TCheckBox;
    cb3: TCheckBox;
    ilButtons: TImageList;
    Bevel5: TBevel;
    ToolButton2: TToolButton;
    procedure lbClick(Sender: TObject);
    procedure lbSeriesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbPoleDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure tbRemoveSeriesClick(Sender: TObject);
    procedure cbClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbPlanshetParamClick(Sender: TObject);
    procedure lbPoleDblClick(Sender: TObject);
    procedure lbPoleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbPoleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbPoleMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbPoleMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
  private
    lbMouseDown   : Boolean;
    lbItemIndex   : Integer;
    lbDragString  : String;
    lbDragObject  : TSeries;

    function  Get_PolesCount(): byte;
    function  SeriesPresent(aName : String):boolean;
  public
    lbArray : array [-1..2] of TListBox;
    cbArray : array [ 0..2] of TCheckBox;
    procedure SetParam();
    procedure AddSeriesFromLasFileToListBox(); 
    procedure AddSeries(NumberPole : Integer; Series : TSeries);

  end;

var
  frmPlanshetCreator: TfrmPlanshetCreator;

implementation

uses Unit_Main, Unit_PlanshetParam, Unit_SeriesValue, Unit_SeriesParam,
  mpiLibrary;

{$R *.DFM}

{===============================================================================
}
procedure TfrmPlanshetCreator.FormCreate(Sender: TObject);
begin
  lbArray[-1] := lbSeries;
  lbArray[ 0] := lbPole1;
  lbArray[ 1] := lbPole2;
  lbArray[ 2] := lbPole3;

  cbArray[0] := cb1;
  cbArray[1] := cb2;
  cbArray[2] := cb3;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.FormShow(Sender: TObject);
var
  i : integer;
begin
  Caption := frmMainCaption + frmMain.tbPlanshet.Caption;

  for i := -1 to 2 do lbArray[i].ItemIndex := -1;

  tbRemoveSeries.Enabled := False;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.tbRemoveSeriesClick(Sender: TObject);
var
  i         : Integer;
  CurPole   : Integer;
  OldIndex  : Integer;
begin
  CurPole := -1;
  for i := 0 to 2 do
       if lbArray[i].ItemIndex <> -1 then CurPole := i;

  if CurPole = -1 then exit;

  OldIndex := lbArray[CurPole].ItemIndex;
  Planshet.PoleArray[CurPole].SeriesList.Delete(OldIndex);
  lbArray[CurPole].Items.Delete(OldIndex);

 tbRemoveSeries.Enabled := False;

  Planshet.CalcPositionPole;
  Planshet.Draw(False);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  frmSeriesValue.SetParam();

  //
  if OldIndex > lbArray[CurPole].Items.Count - 1 then OldIndex := lbArray[CurPole].Items.Count - 1;

  if OldIndex <> -1 then begin
     lbArray[CurPole].ItemIndex   := OldIndex;
     tbRemoveSeries.Enabled       := true;
  end else tbRemoveSeries.Enabled := false;
  lbArray[CurPole].Refresh;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.lbClick(Sender: TObject);
var
  CurItemIndex : Integer;
  CurTag       : Integer;
  i            : Integer;
begin
  CurItemIndex := lbArray[TListBox(Sender).Tag].ItemIndex;
  CurTag       := TListBox(Sender).Tag;

  for i := -1 to 2 do
      lbArray[i].ItemIndex := -1;

  lbArray[CurTag].ItemIndex := CurItemIndex;

  if CurTag = -1 then tbRemoveSeries.Enabled := False
                 else tbRemoveSeries.Enabled := True;

end;

{===============================================================================
}
function TfrmPlanshetCreator.SeriesPresent(aName: String): boolean;
var
  i, k    : Integer;
  mdr     : word;
begin
  result     := false;

  for k := 0 to 2 do
      for i := 0 to lbArray[k].Items.Count - 1 do
         if TSeries(lbArray[k].Items.Objects[i]).Name = aName then Result := true;

  if Result then begin
      Beep();
      mdr := MessageDlg('Кривая на планшете уже присутсвует.'#10#13#10#13'Положить кривую на поле ?', mtWarning, [mbOk, mbCancel], 0);
      if mdr = mrOk then result := False;
  end;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.AddSeries(NumberPole: Integer;
  Series: TSeries);
var
  AbsMaxValue : TFloat;
begin
  Planshet.PoleArray[NumberPole].SeriesList.Add(Series);
  //Planshet.PoleArray[NumberPole].xValues := TSeries(Planshet.PoleArray[NumberPole].SeriesList.Items[0]);
  Planshet.xValues                       := TSeries(LasFile.SeriesList.Items[0]);
  Planshet.PoleArray[NumberPole].xValues := Planshet.xValues;
  Planshet.DepthInOnePixel               := LasFile.WellInf.Step;
  Planshet.StartDepth                    := LasFile.WellInf.Start;

  // ---- Устанавливаем Лист Боксы *----------
  lbArray[NumberPole].Items.AddObject(Series.Name,  Series);
  lbArray[NumberPole].ItemIndex := lbArray[NumberPole].Items.Count - 1;
  lbArray[        -1].ItemIndex :=  -1;

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

  if Planshet.PoleArray[NumberPole].Visible then Series.coefY := (Planshet.PoleArray[NumberPole].PoleRect.Bottom - Planshet.PoleArray[NumberPole].PoleRect.Top) / ( Series.CorrectMaxValue - Series.CorrectMinValue);
  // ---
  tbRemoveSeries.Enabled        := True;
  // ---
  Planshet.CalcPositionPole();
  Planshet.draw(False);

  if frmSeriesValue.Updated then begin
      frmSeriesValue.SetParam();
      frmSeriesValue.Show;
      frmMain.SetFocus;
  end;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.lbSeriesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TListBox;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.lbPoleDragDrop(Sender, Source: TObject; X,
  Y: Integer);
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

  // ---- Проверка на пристутсвие кривой ---------
   if SeriesPresent(Series.Name) then exit;
  // ---- Добавляем серию -------
   AddSeries(lbSender.Tag, Series);
  // ---- Параметры Скорлл Бара
   frmMain.Set_ScrollBarParam();
  // --- Отрисовуем то, что полуямлось -----------
   Planshet.Draw(False);
   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.AddSeriesFromLasFileToListBox();
var
  i : integer;
  Series : TSeries;
begin
  lbSeries.Items.Clear;

  for i := 1 to LasFile.SeriesList.Count - 1 do begin
     Series := TSeries(LasFile.SeriesList.Items[i]);
     lbSeries.Items.AddObject(Series.Name, Series);
  end;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.SetParam();
begin
  lbPole1.Items.Clear;
  lbPole2.Items.Clear;
  lbPole3.Items.Clear;

  AddSeriesFromLasFileToListBox();
end;

{===============================================================================
}
function TfrmPlanshetCreator.Get_PolesCount: byte;
begin
  Result := 0;
  if Planshet.PoleArray[0].Visible then inc(Result);
  if Planshet.PoleArray[1].Visible then inc(Result);
  if Planshet.PoleArray[2].Visible then inc(Result);
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.cbClick(Sender: TObject);
var
 CurTag : Integer;
 i      : Integer;
begin
  CurTag := TCheckBox(Sender).Tag;

  // -------- Делаю активные - неактивные компоненты на форме --------
  for i := 0 to ComponentCount - 1 do
     if TComponent(Components[i]).Name <> 'ilButtons' then
         if TComponent(Components[i]).Tag = CurTag - 10 then
                      TCheckBox(Components[i]).Enabled := not TCheckBox(Components[i]).Enabled;
  // -------- End of Делаю активные - неактивные компоненты на форме --------

  Planshet.PoleArray[CurTag - 10].Visible := TCheckBox(Sender).Checked;
  Planshet.PolesCount := Get_PolesCount();
  Planshet.CalcPositionPole();
  Planshet.Draw(False);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;

  if Planshet.PolesCount = 0 then frmSeriesValue.Visible := False
                             else frmSeriesValue.Visible := True;

  frmSeriesValue.SetParam();
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.tbPlanshetParamClick(Sender: TObject);
begin
//  frmPlanshetParam.ShowModal;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.lbPoleDblClick(Sender: TObject);
var
  lb : TListBox;
begin
  lb := TListBox(Sender);
  if lb.ItemIndex = -1 then exit;

  frmSeriesParam.SetParam(Tseries(lb.Items.Objects[lb.ItemIndex]));
  frmSeriesParam.ShowModal;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.lbPoleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if TListBox(Sender).ItemIndex = -1 then exit;

  if Key = 46 then
    tbRemoveSeriesClick(Sender)
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.lbPoleMouseDown(Sender: TObject;
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
procedure TfrmPlanshetCreator.lbPoleMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i : integer;
begin
  lbMouseDown := False;

  if lbDragObject <> nil then begin
    for i := 0 to TListBox(Sender).Items.Count - 1 do begin
       Planshet.PoleArray[TListBox(Sender).Tag].SeriesList.Items[i] := TListBox(Sender).Items.Objects[i];
    end;

    frmSeriesValue.SetParam();

    Planshet.Draw(False);
    Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
    //Application.ProcessMessages;
  end;

  lbItemIndex  := -1;
  lbDragObject := nil;
end;

{===============================================================================
}
procedure TfrmPlanshetCreator.lbPoleMouseMove(Sender: TObject;
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
procedure TfrmPlanshetCreator.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
