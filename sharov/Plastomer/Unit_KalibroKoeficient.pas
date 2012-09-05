unit Unit_KalibroKoeficient;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ToolWin, ExtCtrls, Buttons;

const
  aCaption = 'Паспортные данные прибора № ';
type
  TfrmKalibroKoeficient = class(TForm)
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
    Edit11: TEdit;
    Edit12: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Label14: TLabel;
    Edit15: TEdit;
    Edit16: TEdit;
    Label15: TLabel;
    Edit17: TEdit;
    Edit18: TEdit;
    Label16: TLabel;
    Edit19: TEdit;
    Edit20: TEdit;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    tbLoadCoef: TToolButton;
    tbSaveCoef: TToolButton;
    Label17: TLabel;
    Label18: TLabel;
    Edit21: TEdit;
    Edit22: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    tbClearParam: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Bevel1: TBevel;
    procedure tbClearParamClick(Sender: TObject);
    procedure tbLoadCoefClick(Sender: TObject);
    procedure tbSaveCoefClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
     FileName   : String;
     EditValues : array [0..21] of extended;
     function GetValues() : boolean;
     procedure SetValues();
     procedure SetFormCaption();
  public
    { Public declarations }
  end;

var
  frmKalibroKoeficient: TfrmKalibroKoeficient;

implementation

Uses mpiDeclaration, mpiLibrary;

{$R *.DFM}

procedure TfrmKalibroKoeficient.SetFormCaption;
begin
   if FileName = '' then Caption := FormCaption + aCaption + '-------------------'
                    else Caption := FormCaption + aCaption + copy(ExtractFileName(FileName), 1, Length(ExtractFileName(FileName))-4);
//                    else Caption := FormCaption + aCaption + ExtractShortPathName(FileName);

end;

procedure TfrmKalibroKoeficient.SetValues();
begin
  edit1 .Text := FloatToStr(EditValues[ 0]);
  edit2 .Text := FloatToStr(EditValues[ 1]);
  edit3 .Text := FloatToStr(EditValues[ 2]);
  edit4 .Text := FloatToStr(EditValues[ 3]);
  edit5 .Text := FloatToStr(EditValues[ 4]);
  edit6 .Text := FloatToStr(EditValues[ 5]);
  edit7 .Text := FloatToStr(EditValues[ 6]);
  edit8 .Text := FloatToStr(EditValues[ 7]);
  edit9 .Text := FloatToStr(EditValues[ 8]);
  edit10.Text := FloatToStr(EditValues[ 9]);
  edit11.Text := FloatToStr(EditValues[10]);
  edit12.Text := FloatToStr(EditValues[11]);
  edit13.Text := FloatToStr(EditValues[12]);
  edit14.Text := FloatToStr(EditValues[13]);
  edit15.Text := FloatToStr(EditValues[14]);
  edit16.Text := FloatToStr(EditValues[15]);
  edit17.Text := FloatToStr(EditValues[16]);
  edit18.Text := FloatToStr(EditValues[17]);
  edit19.Text := FloatToStr(EditValues[18]);
  edit20.Text := FloatToStr(EditValues[19]);
  edit21.Text := FloatToStr(EditValues[20]);
  edit22.Text := FloatToStr(EditValues[21]);
end;

function TfrmKalibroKoeficient.GetValues():Boolean;
begin
  result := false;
  try EditValues[ 0] := StrToFloat(edit1 .Text) except ShowWrongEdit(edit1 ); exit; end;
  try EditValues[ 1] := StrToFloat(edit2 .Text) except ShowWrongEdit(edit2 ); exit; end;
  try EditValues[ 2] := StrToFloat(edit3 .Text) except ShowWrongEdit(edit3 ); exit; end;
  try EditValues[ 3] := StrToFloat(edit4 .Text) except ShowWrongEdit(edit4 ); exit; end;
  try EditValues[ 4] := StrToFloat(edit5 .Text) except ShowWrongEdit(edit5 ); exit; end;
  try EditValues[ 5] := StrToFloat(edit6 .Text) except ShowWrongEdit(edit6 ); exit; end;
  try EditValues[ 6] := StrToFloat(edit7 .Text) except ShowWrongEdit(edit7 ); exit; end;
  try EditValues[ 7] := StrToFloat(edit8 .Text) except ShowWrongEdit(edit8 ); exit; end;
  try EditValues[ 8] := StrToFloat(edit9 .Text) except ShowWrongEdit(edit9 ); exit; end;
  try EditValues[ 9] := StrToFloat(edit10.Text) except ShowWrongEdit(edit10); exit; end;
  try EditValues[10] := StrToFloat(edit11.Text) except ShowWrongEdit(edit11); exit; end;
  try EditValues[11] := StrToFloat(edit12.Text) except ShowWrongEdit(edit12); exit; end;
  try EditValues[12] := StrToFloat(edit13.Text) except ShowWrongEdit(edit13); exit; end;
  try EditValues[13] := StrToFloat(edit14.Text) except ShowWrongEdit(edit14); exit; end;
  try EditValues[14] := StrToFloat(edit15.Text) except ShowWrongEdit(edit15); exit; end;
  try EditValues[15] := StrToFloat(edit16.Text) except ShowWrongEdit(edit16); exit; end;
  try EditValues[16] := StrToFloat(edit17.Text) except ShowWrongEdit(edit17); exit; end;
  try EditValues[17] := StrToFloat(edit18.Text) except ShowWrongEdit(edit18); exit; end;
  try EditValues[18] := StrToFloat(edit19.Text) except ShowWrongEdit(edit19); exit; end;
  try EditValues[19] := StrToFloat(edit20.Text) except ShowWrongEdit(edit20); exit; end;
  try EditValues[20] := StrToFloat(edit21.Text) except ShowWrongEdit(edit21); exit; end;
  try EditValues[21] := StrToFloat(edit22.Text) except ShowWrongEdit(edit22); exit; end;
  result := True;
end;

procedure TfrmKalibroKoeficient.tbClearParamClick(Sender: TObject);
var
  i : integer;
begin
  FileName := '';

  i := 0;
  While i <= 18 do begin
     EditValues[i    ] := 1;
     EditValues[i + 1] := 0;
     i := i + 2
  end;

  EditValues[20] := 3;
  EditValues[21] := 0;

  SetValues();
  SetFormCaption();
end;

procedure TfrmKalibroKoeficient.tbLoadCoefClick(Sender: TObject);
var
  iFileHandle : Integer;
begin
  {$I-} MkDir(ExtractFilePath(Application.ExeName) + 'Калибровка'); {$I+}
  // --- Параметры Open Диалога ----
  OpenDialog1.Title      := FormCaption + 'Отрытие файлa калибровочных коеф.';
  OpenDialog1.Filter     := 'Файл данных (*.klb)|*.klb';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Калибровка';
  OpenDialog1.FileName   := '';
  //------------------------------
  if OpenDialog1.Execute then begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             // ------- Проверка на измененность проекта --------   //if Modified then  if ShowAndGetResultDialogBox() = mrCancel then exit; // ------- End of Проверка на измененность проекта --------
      FileName := OpenDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.klb';

      iFileHandle := FileOpen(FileName, fmOpenRead);
      FileRead(iFileHandle, EditValues , SizeOf(EditValues));
      FileClose(iFileHandle);

      SetValues();
      SetFormCaption();
  end;
end;

procedure TfrmKalibroKoeficient.tbSaveCoefClick(Sender: TObject);
var
  iFileHandle : Integer;
begin
  if not GetValues() then exit;
  // --- Параметры Save Диалога ----
  SaveDialog1.Title      := FormCaption + 'Запись файлa калибровочных коеф.';
  SaveDialog1.Filter     := 'Файл данных (*.klb)|*.klb';
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Калибровка';
  SaveDialog1.FileName   := '';
  //------------------------------
  if SaveDialog1.Execute then begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             // ------- Проверка на измененность проекта --------   //if Modified then  if ShowAndGetResultDialogBox() = mrCancel then exit; // ------- End of Проверка на измененность проекта --------
      FileName := SaveDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.klb';

      iFileHandle := FileCreate(FileName);
      FileWrite(iFileHandle, EditValues , SizeOf(EditValues));
      FileClose(iFileHandle);

      SetFormCaption();
  end;
end;

procedure TfrmKalibroKoeficient.FormCreate(Sender: TObject);
begin
  FileName := '';
end;

procedure TfrmKalibroKoeficient.FormShow(Sender: TObject);
begin
  SetFormCaption();
end;

procedure TfrmKalibroKoeficient.BitBtn1Click(Sender: TObject);
begin
  if GetValues() then close;
end;

end.
