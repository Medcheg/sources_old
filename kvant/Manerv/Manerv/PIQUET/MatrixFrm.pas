unit MatrixFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, jbStrGrd, ExtCtrls, StdCtrls, ActnList, Grids;

type
  TMatrixForm = class(TForm)
    MatrixGrid: TPubStrGrid;
    spbOpen: TSpeedButton;
    spdSave: TSpeedButton;
    edtFileName: TEdit;
    Label1: TLabel;
    MatrixOpenDialog: TOpenDialog;
    MatrixSaveDialog: TSaveDialog;
    ActionList1: TActionList;
    actOpen: TAction;
    actSave: TAction;
    Bevel: TBevel;
    btnCancel: TButton;
    btnOk: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure MatrixGridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var AAlignment: TAlignment);
    procedure FormCreate(Sender: TObject);
    procedure spbOpenClick(Sender: TObject);
    procedure spdSaveClick(Sender: TObject);
    procedure MatrixGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure MatrixGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtFileNameKeyPress(Sender: TObject; var Key: Char);

  private
    InitGridHeight : integer;
    { Private declarations }
    procedure GridTuning;

  public


    procedure Set1D(Dimension:integer);
    procedure Set3D(Dimension:integer);



    { Public declarations }
  end;

var
  MatrixForm: TMatrixForm;

implementation

{$R *.DFM}

procedure TMatrixForm.FormCreate(Sender: TObject);
begin
  MatrixGrid.RowHeights[0]:= Trunc(MatrixGrid.DefaultRowHeight*0.7);
  MatrixGrid.Color := clWindow;
  InitGridHeight := MatrixGrid.Height;

  edtFileName.DoubleBuffered := True;
  MatrixOpenDialog.InitialDir := ExtractFilePath(Application.EXEName);
  MatrixSaveDialog.InitialDir := ExtractFilePath(Application.EXEName);
end;

procedure TMatrixForm.FormShow(Sender: TObject);
begin
  //��� ����������� ����� �����
  edtFileName.SelStart := Length(edtFileName.Text);
  MatrixGrid.SetAppropColWidth;
end;


procedure TMatrixForm.MatrixGridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var AAlignment: TAlignment);
begin
  if ARow=0 then AALignment := taCenter;
end;

procedure TMatrixForm.spbOpenClick(Sender: TObject);
begin
  if MatrixOpenDialog.Execute then
    if MatrixGrid.LoadFromFile(MatrixOpenDialog.FileName) then begin
      edtFileName.Text := MatrixOpenDialog.FileName;
      edtFileName.SelStart := Length(edtFileName.Text);
      GridTuning;
    end;
end;

procedure TMatrixForm.edtFileNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    if MatrixGrid.LoadFromFile(edtFileName.Text) then
      GridTuning;
    Key:=#0;
  end;
end;

procedure TMatrixForm.spdSaveClick(Sender: TObject);
begin
  if MatrixSaveDialog.Execute then
    MatrixGrid.SaveToFile(MatrixSaveDialog.FileName);
end;

procedure TMatrixForm.MatrixGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {107 = '+' of NumberPad, 187='-'}
  if ((Key=187) or (Key=107)) and (Shift=[ssCtrl]) then
    GridTuning;
end;

procedure TMatrixForm.MatrixGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then MatrixGrid.ApprShowHScroll;
end;

procedure TMatrixForm.FormResize(Sender: TObject);
begin
  MatrixGrid.ApprShowHScroll;
  Bevel.Visible := not(MatrixGrid.Top + MatrixGrid.Height>Bevel.Top);
  edtFileName.SelStart := 1;
  edtFileName.SelStart := Length(edtFileName.Text);
end;

procedure TMatrixForm.GridTuning;
begin
  MatrixGrid.SetAppropColWidth;
  MatrixGrid.ApprShowHScroll;
end;

procedure TMatrixForm.Set1D(Dimension:integer);
begin
  lbl1.Visible := False;
  lbl2.Visible := False;
  lbl3.Visible := False;
  MatrixGrid.Left := 5;
  MatrixGrid.Width := MatrixGrid.Width+15;
  MatrixGrid.RowCount := 2;
  MatrixGrid.ColCount := Dimension;
  MatrixGrid.NameFixedCols;
  MatrixGrid.Height := 41;
  InitGridHeight := 41;
  Constraints.MinHeight := 160;
  Constraints.MaxHeight := 160;
  Height := 120;
end;

procedure TMatrixForm.Set3D(Dimension:integer);
begin
  lbl1.Visible := True;
  lbl2.Visible := True;
  lbl3.Visible := True;
  MatrixGrid.Left := 20;
  MatrixGrid.RowCount := 4;
  MatrixGrid.ColCount := Dimension;
  MatrixGrid.NameFixedCols;
  MatrixGrid.Height := 81;
  InitGridHeight := 81;
  Constraints.MinHeight := 200;
  Constraints.MaxHeight := 200;
  Height := 160;
end;

end.
