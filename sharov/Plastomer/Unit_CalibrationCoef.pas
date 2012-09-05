
unit Unit_CalibrationCoef;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ToolWin, ExtCtrls, Buttons, ImgList;

const
  aCaption = 'Паспорт прибора НП6 № ';
type
  TfrmCalibrationCoef = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label6: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Label8: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit15: TEdit;
    Edit16: TEdit;
    Label14: TLabel;
    Edit17: TEdit;
    Edit18: TEdit;
    Label15: TLabel;
    Edit19: TEdit;
    Edit20: TEdit;
    Label16: TLabel;
    Edit21: TEdit;
    Edit22: TEdit;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    tbLoadCoef: TToolButton;
    tbSaveCoef: TToolButton;
    Label17: TLabel;
    Label18: TLabel;
    Edit25: TEdit;
    Edit26: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    tbClearParam: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Bevel1: TBevel;
    Label19: TLabel;
    Label20: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    ImageList1: TImageList;
    procedure tbClearParamClick(Sender: TObject);
    procedure tbLoadCoefClick(Sender: TObject);
    procedure tbSaveCoefClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
     FileName   : String;

     RADArray   : array [1..6,1..2] of Extended;
     BMKArray   : array [1..6,1..2] of Extended;
     Depth, Azim : Extended;
     function GetValues() : boolean;
     procedure SetValues();
     procedure SetFormCaption();
  public
    { Public declarations }
  end;

var
  frmCalibrationCoef: TfrmCalibrationCoef;

implementation

Uses mpiDeclaration, mpiLibrary, mpiLasFile, Unit_Main;

{$R *.DFM}

{===============================================================================
}
procedure TfrmCalibrationCoef.SetFormCaption;
begin
   if FileName = '' then Caption := frmMainCaption + aCaption + '-------------------'
                    else Caption := frmMainCaption + aCaption + copy(ExtractFileName(FileName), 1, Length(ExtractFileName(FileName))-4);
//                    else Caption := FormCaption + aCaption + ExtractShortPathName(FileName);

end;

{===============================================================================
}
procedure TfrmCalibrationCoef.SetValues();
begin
  edit1 .Text := FloatToStr(RADArray[1,1]); edit2 .Text := FloatToStr(RADArray[1,2]);
  edit3 .Text := FloatToStr(RADArray[2,1]); edit4 .Text := FloatToStr(RADArray[2,2]);
  edit5 .Text := FloatToStr(RADArray[3,1]); edit6 .Text := FloatToStr(RADArray[3,2]);
  edit7 .Text := FloatToStr(RADArray[4,1]); edit8 .Text := FloatToStr(RADArray[4,2]);
  edit9 .Text := FloatToStr(RADArray[5,1]); edit10.Text := FloatToStr(RADArray[5,2]);
  edit11.Text := FloatToStr(RADArray[6,1]); edit12.Text := FloatToStr(RADArray[6,2]);

  edit13.Text := FloatToStr(BMKArray[1,1]); edit14.Text := FloatToStr(BMKArray[1,2]);
  edit15.Text := FloatToStr(BMKArray[2,1]); edit16.Text := FloatToStr(BMKArray[2,2]);
  edit17.Text := FloatToStr(BMKArray[3,1]); edit18.Text := FloatToStr(BMKArray[3,2]);
  edit19.Text := FloatToStr(BMKArray[4,1]); edit20.Text := FloatToStr(BMKArray[4,2]);
  edit21.Text := FloatToStr(BMKArray[5,1]); edit22.Text := FloatToStr(BMKArray[5,2]);
  edit23.Text := FloatToStr(BMKArray[6,1]); edit24.Text := FloatToStr(BMKArray[6,2]);

  edit25.Text := FloatToStr(Depth);
  edit26.Text := FloatToStr(Azim);
end;

{===============================================================================
}
function TfrmCalibrationCoef.GetValues():Boolean;
begin
  result := false;
  try RADArray[1,1] := StrToFloat(edit1 .Text) except ShowWrongEdit(edit1 ); exit; end;
  try RADArray[1,2] := StrToFloat(edit2 .Text) except ShowWrongEdit(edit2 ); exit; end;
  try RADArray[2,1] := StrToFloat(edit3 .Text) except ShowWrongEdit(edit3 ); exit; end;
  try RADArray[2,2] := StrToFloat(edit4 .Text) except ShowWrongEdit(edit4 ); exit; end;
  try RADArray[3,1] := StrToFloat(edit5 .Text) except ShowWrongEdit(edit5 ); exit; end;
  try RADArray[3,2] := StrToFloat(edit6 .Text) except ShowWrongEdit(edit6 ); exit; end;
  try RADArray[4,1] := StrToFloat(edit7 .Text) except ShowWrongEdit(edit7 ); exit; end;
  try RADArray[4,2] := StrToFloat(edit8 .Text) except ShowWrongEdit(edit8 ); exit; end;
  try RADArray[5,1] := StrToFloat(edit9 .Text) except ShowWrongEdit(edit9 ); exit; end;
  try RADArray[5,2] := StrToFloat(edit10.Text) except ShowWrongEdit(edit10); exit; end;
  try RADArray[6,1] := StrToFloat(edit11.Text) except ShowWrongEdit(edit11); exit; end;
  try RADArray[6,2] := StrToFloat(edit12.Text) except ShowWrongEdit(edit12); exit; end;

  try BMKArray[1,1] := StrToFloat(edit13.Text) except ShowWrongEdit(edit13); exit; end;
  try BMKArray[1,2] := StrToFloat(edit14.Text) except ShowWrongEdit(edit14); exit; end;
  try BMKArray[2,1] := StrToFloat(edit15.Text) except ShowWrongEdit(edit15); exit; end;
  try BMKArray[2,2] := StrToFloat(edit16.Text) except ShowWrongEdit(edit16); exit; end;
  try BMKArray[3,1] := StrToFloat(edit17.Text) except ShowWrongEdit(edit17); exit; end;
  try BMKArray[3,2] := StrToFloat(edit18.Text) except ShowWrongEdit(edit18); exit; end;
  try BMKArray[4,1] := StrToFloat(edit19.Text) except ShowWrongEdit(edit19); exit; end;
  try BMKArray[4,2] := StrToFloat(edit20.Text) except ShowWrongEdit(edit20); exit; end;
  try BMKArray[5,1] := StrToFloat(edit21.Text) except ShowWrongEdit(edit21); exit; end;
  try BMKArray[5,2] := StrToFloat(edit22.Text) except ShowWrongEdit(edit22); exit; end;
  try BMKArray[6,1] := StrToFloat(edit23.Text) except ShowWrongEdit(edit23); exit; end;
  try BMKArray[6,2] := StrToFloat(edit24.Text) except ShowWrongEdit(edit24); exit; end;

  try Depth := StrToFloat(edit25.Text) except ShowWrongEdit(edit25); exit; end;
  try Azim  := StrToFloat(edit26.Text) except ShowWrongEdit(edit26); exit; end;

  OffsetVizirAngle := Azim * pi/180;
  result := True;
end;

{===============================================================================
}
procedure TfrmCalibrationCoef.tbClearParamClick(Sender: TObject);
var
  i : integer;
begin
  FileName := '';

  for i := 1 to 6 do begin
    BMKArray[i,1] := 1;
    BMKArray[i,2] := 0;

    RADArray[i,1] := 1;
    RADArray[i,2] := 0;
  end;

  Depth := 0;
  Azim  := 0;

  SetValues();
  SetFormCaption();
end;

{===============================================================================
}
procedure TfrmCalibrationCoef.tbLoadCoefClick(Sender: TObject);
var
  iFileHandle : Integer;
begin
  // --- Параметры Open Диалога ----
  OpenDialog1.Title      := frmMainCaption + 'Отрытие файлa калибровочных коеф.';
  OpenDialog1.Filter     := 'Файл данных (*.klb)|*.klb';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Калибровка';
  OpenDialog1.FileName   := '';
  //------------------------------
  if OpenDialog1.Execute then begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             // ------- Проверка на измененность проекта --------   //if Modified then  if ShowAndGetResultDialogBox() = mrCancel then exit; // ------- End of Проверка на измененность проекта --------
      FileName := OpenDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.klb';

      iFileHandle := FileOpen(FileName, fmOpenRead);
      FileRead(iFileHandle, RADArray , SizeOf(RADArray));
      FileRead(iFileHandle, BMKArray , SizeOf(BMKArray));
      FileRead(iFileHandle, Depth    , SizeOf(Depth));
      FileRead(iFileHandle, Azim     , SizeOf(Azim));
      FileClose(iFileHandle);

      SetValues();
      SetFormCaption();
  end;
end;

{===============================================================================
}
procedure TfrmCalibrationCoef.tbSaveCoefClick(Sender: TObject);
var
  iFileHandle : Integer;
begin
  if not GetValues() then exit;
  // --- Параметры Save Диалога ----
  SaveDialog1.Title      := frmMainCaption + 'Запись файлa калибровочных коеф.';
  SaveDialog1.Filter     := 'Файл данных (*.klb)|*.klb';
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Калибровка';
  SaveDialog1.FileName   := '';
  //------------------------------
  if SaveDialog1.Execute then begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             // ------- Проверка на измененность проекта --------   //if Modified then  if ShowAndGetResultDialogBox() = mrCancel then exit; // ------- End of Проверка на измененность проекта --------
      FileName := SaveDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.klb';

      iFileHandle := FileCreate(FileName);
      FileWrite(iFileHandle, RADArray , SizeOf(RADArray));
      FileWrite(iFileHandle, BMKArray , SizeOf(BMKArray));
      FileWrite(iFileHandle, Depth    , SizeOf(Depth));
      FileWrite(iFileHandle, Azim     , SizeOf(Azim));
      FileClose(iFileHandle);

      SetFormCaption();
  end;
end;

{===============================================================================
}
procedure TfrmCalibrationCoef.FormCreate(Sender: TObject);
begin
  FileName := '';
end;

{===============================================================================
}
procedure TfrmCalibrationCoef.FormShow(Sender: TObject);
begin
  SetFormCaption();
  tbClearParamClick(nil);
end;

{===============================================================================
}
procedure TfrmCalibrationCoef.BitBtn1Click(Sender: TObject);
var
  k, i   : Integer;
  Series : TSeries;
  RadiusArray : array [0..5] of TSeries;
begin
  if GetValues() then begin
    if not LasFile.CalibrationFactor then begin
      // -------  Поправка к радиусам ---------------
       for k := 1 to 6 do begin
           Series := LasFile.GetSeries('RAD'+intToStr(k));
           RadiusArray[k-1] := Series;
           for i := 0 to Series.Count - 1 do
              if Series.Data^[i] <> Series.NullValue then
                   Series.AddValue[i] := RADArray[k,1]*Series.data^[i] + RADArray[k,2];
       end;
      // ------------- Перерасчет значения среднего радиуса ------------
       Series := LasFile.GetSeries('RADS');
        for i := 0 to TSeries(LasFile.SeriesList.Items[0]).Count - 1 do
          Series.AddValue[i] := (RadiusArray[0].data^[i] + RadiusArray[1].data^[i] + RadiusArray[2].data^[i] + RadiusArray[3].data^[i] + RadiusArray[4].data^[i] + RadiusArray[5].data^[i])/6;
      // -------  поправка на башмаки ----------------------------------
       for k := 1 to 6 do begin
           Series := LasFile.GetSeries('BMK'+intToStr(k));
           for i := 0 to Series.Count - 1 do
              if Series.Data^[i] <> Series.NullValue then
                   Series.AddValue[i] := BMKArray[k,1]*Series.data^[i] + BMKArray[k,2];
       end;
      // ---------  Поправка на глубину ----------------------
       Series := LasFile.GetSeries('DEPT');
       for i := 0 to Series.Count - 1 do
          Series.AddValue[i] := Series.data^[i] + Depth;
      // ---------  Поправка на азимут ----------------------
       Series := LasFile.GetSeries('AZ1B');
       for i := 0 to Series.Count - 1 do
          Series.AddValue[i] := Series.data^[i] + Azim;
      // -------------------------------
       LasFile.CalibrationFactor := True;
      // --------------
       frmMain.SetFormCaption();
       Planshet.Draw(False);
       Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
      // ----------------
       LasFileModified := True;
    end else begin
      Beep();
      MessageDlg('В данном файле учтены поправки прибора !!!'#10#13'Любые изменения в поправках не воспримутся ...', mtWarning, [mbOk], 0);
    end;
    close;
  end;
end;

{===============================================================================
}
procedure TfrmCalibrationCoef.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
