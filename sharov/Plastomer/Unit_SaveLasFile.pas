unit Unit_SaveLasFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, mpiDeclaration, mpiLibrary, Spin;

type
  TfrmSaveLasFile = class(TForm)
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    SaveDialog1: TSaveDialog;
    Label5: TLabel;
    Label6: TLabel;
    lStartDepth: TLabel;
    lStopDepth: TLabel;
    Bevel3: TBevel;
    Label9: TLabel;
    Label11: TLabel;
    CheckBox2: TCheckBox;
    Label13: TLabel;
    lDepthStep: TLabel;
    Bevel4: TBevel;
    seSection: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    BeginDepth : TFloat;
    EndDepth   : TFloat;
    procedure EnambleDisableLabelsANdEdits(Flag : Boolean);
    function CheckEditInput() : boolean;
    { Private declarations }
  public
  end;

var
  frmSaveLasFile: TfrmSaveLasFile;

implementation

uses mpiLasFile, Unit_CaptionSaveLoad, Unit_PlanshetCreator,
  Unit_SeriesValue, Unit_Marks, Unit_Main, mpiSaveLoadDataFile;

{$R *.DFM}

{===============================================================================
}
procedure TfrmSaveLasFile.FormShow(Sender: TObject);
begin
  lStartDepth.Caption := FloatToStrF(LasFile.WellInf.Start, ffFixed, 16, 4) + ' м';
  lStopDepth .Caption := FloatToStrF(LasFile.WellInf.Stop , ffFixed, 16, 4) + ' м';
  lDepthStep .Caption := FloatToStrF(LasFile.WellInf.Step , ffFixed, 16, 4) + ' м';

  Edit1.Text := FloatToStrF(LasFile.WellInf.Start, ffFixed, 16, 4);
  Edit2.Text := FloatToStrF(LasFile.WellInf.Stop , ffFixed, 16, 4);

  caption           := frmMainCaption + 'Запись кривой';
  CheckBox1.Checked := true;
  CheckBox2.Checked := false;
end;

{===============================================================================
}
procedure TfrmSaveLasFile.EnambleDisableLabelsANdEdits(Flag: Boolean);
begin
  Label1.Enabled := Flag;
  Label2.Enabled := Flag;
  Label3.Enabled := Flag;
  Label4.Enabled := Flag;

  Edit1.Enabled  := Flag;
  Edit2.Enabled  := Flag;
end;

{===============================================================================
}
function TfrmSaveLasFile.CheckEditInput(): boolean;
begin
  Result := False;
  try BeginDepth := StrToFloat(Edit1.Text) except ShowWrongEdit(Edit1); exit end;
  try EndDepth   := StrToFloat(Edit2.Text) except ShowWrongEdit(Edit2); exit end;
  // -----------------
  if (BeginDepth >= LasFile.WellInf.Start) and
     (BeginDepth <= LasFile.WellInf.Stop)  and
     (EndDepth   >= LasFile.WellInf.Start) and
      (EndDepth   <= LasFile.WellInf.Stop)  and
      (EndDepth   >= BeginDepth)            then else begin
      Beep();
      MessageDlg('Неверно задан диапазон глубин', mtError, [mbOk], 0);
      exit;
  end;
  Result := True;
end;

{===============================================================================
}
procedure TfrmSaveLasFile.CheckBox1Click(Sender: TObject);
begin
  EnambleDisableLabelsANdEdits(not CheckBox1.Checked);
end;

{===============================================================================
}
procedure TfrmSaveLasFile.CheckBox2Click(Sender: TObject);
begin
  Label9 .Enabled := not Label9 .Enabled;
  Label11.Enabled := not Label11.Enabled;
  seSection.Enabled := not seSection.Enabled;
end;

{===============================================================================
}
procedure TfrmSaveLasFile.BitBtn1Click(Sender: TObject);
var
 FileName : String;
begin
  if CheckBox1.Checked then begin
    BeginDepth := LasFile.WellInf.Start;
    EndDepth   := LasFile.WellInf.Stop;
  end else if not CheckEditInput() then exit;
  // ---------------------------

  // --- Параметры Саве Диалога ----
  SaveDialog1.Title      := frmMainCaption + 'Запись "Las" Файлa';
  SaveDialog1.Filter     := 'Las файл (*.las)|*.las';
  SaveDialog1.InitialDir := InitialDir;
  SaveDialog1.FileName   := '';
  //------------------------------
  if SaveDialog1.Execute then begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             // ------- Проверка на измененность проекта --------   //if Modified then  if ShowAndGetResultDialogBox() = mrCancel then exit; // ------- End of Проверка на измененность проекта --------
      FileName := SaveDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.las';

        frmCaptionSaveLoad.aCaption := 'Запись файла';
        frmCaptionSaveLoad.Show;
        Application.ProcessMessages;
        // ----------
        SaveDataFile(FileName,  BeginDepth, EndDepth);
        // ----------
        if not CheckBox2.Checked then LasFile.Save(BeginDepth, EndDepth, 1              , FileName)
                                 else LasFile.Save(BeginDepth, EndDepth, seSection.Value, FileName);

        frmCaptionSaveLoad.Close;
        LasFileModified := false;
        InitialDir      := ExtractFilePath(FileName);
  end;

  ModalResult := mrOk;
end;

{===============================================================================
}
procedure TfrmSaveLasFile.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
//  caption := intToStr7(ord(key));
end;

{===============================================================================
}
procedure TfrmSaveLasFile.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
