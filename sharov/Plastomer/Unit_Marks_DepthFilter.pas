unit Unit_Marks_DepthFilter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, mpiDeclaration, mpiLibrary;

type
  TfrmMarks_DepthFilter = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbFiltration: TCheckBox;
    Bevel3: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    lStartDepth: TLabel;
    lStopDepth: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    procedure cbFiltrationClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    function CheckEditInput() : boolean;
    procedure EnambleDisableLabelsANdEdits(Flag : Boolean);
  public
    BeginDepth : TFloat;
    EndDepth   : TFloat;
  end;

var
  frmMarks_DepthFilter: TfrmMarks_DepthFilter;

implementation

uses Unit_Marks, mpiLasFile;

{$R *.DFM}

{===============================================================================
}
procedure TfrmMarks_DepthFilter.FormShow(Sender: TObject);
begin
  Caption := frmMainCaption + 'Фильтр по глубине';

  lStartDepth.Caption := FloatToStrF(LasFile.WellInf.Start, ffFixed, 16, 4) + ' м';
  lStopDepth .Caption := FloatToStrF(LasFile.WellInf.Stop , ffFixed, 16, 4) + ' м';

  if Edit1.text = '0' then Edit1.Text := FloatToStrF(LasFile.WellInf.Start, ffFixed, 16, 4);
  if Edit2.text = '0' then Edit2.Text := FloatToStrF(LasFile.WellInf.Stop , ffFixed, 16, 4);

  EnambleDisableLabelsANdEdits(cbFiltration.Checked);
end;

{===============================================================================
}
procedure TfrmMarks_DepthFilter.EnambleDisableLabelsANdEdits(
  Flag: Boolean);
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
procedure TfrmMarks_DepthFilter.cbFiltrationClick(Sender: TObject);
begin
  if frmMarks.miRepeatDepth.Checked then begin
     frmMarks.miRepeatDepth.Checked := False;
  end;

  frmMarks.miDepthFilter.Checked := cbFiltration.Checked;

  EnambleDisableLabelsANdEdits(cbFiltration.Checked);
end;

{===============================================================================
}
function TfrmMarks_DepthFilter.CheckEditInput: boolean;
begin
  Result              := False;
  BitBtn1.ModalResult := mrNone;
  Self.ModalResult    := mrNone;

  try BeginDepth := StrToFloat(Edit1.Text) except ShowWrongEdit(Edit1); exit end;
  try EndDepth   := StrToFloat(Edit2.Text) except ShowWrongEdit(Edit2); exit end;
  // -----------------
  if (BeginDepth >= LasFile.WellInf.Start) and
     (BeginDepth <= LasFile.WellInf.Stop)  and
     (EndDepth   >= LasFile.WellInf.Start) and
     (EndDepth   <= LasFile.WellInf.Stop)  then else begin
      Beep();
      MessageDlg('Неверно задан диапазон глубин', mtError, [mbOk], 0);
      exit;
  end;
  Result := True;
end;

{===============================================================================
}
procedure TfrmMarks_DepthFilter.BitBtn1Click(Sender: TObject);
begin
   if cbFiltration.Checked and (not CheckEditInput()) then exit;

   BitBtn1.ModalResult := mrOk;
   Self.ModalResult    := mrOk;

//   Close;
end;

{===============================================================================
}
procedure TfrmMarks_DepthFilter.FormActivate(Sender: TObject);
begin
  DecimalSeparator    := '.';
end;

end.
