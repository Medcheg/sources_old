unit SignTabel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Spin;

type
  TfmSigMatrix = class(TForm)
    fmSignTabel: TDrawGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EditSenterP: TEdit;
    EditDeltaP: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    GroupBox1: TGroupBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    fmSignTabelTA: TDrawGrid;
    Label19: TLabel;
    procedure fmSignTabelDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSigMatrix: TfmSigMatrix;

implementation

{$R *.DFM}

procedure TfmSigMatrix.fmSignTabelDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var k,l:integer;
begin
          with fmSigMatrix,fmSignTabel,canvas do
             begin
              Brush.Color:=clMenu;
              for k:=fmSigMatrix.fmSignTabel.Selection.Left to
                                      fmSigMatrix.fmSignTabel.Selection.Right do
              for l:=fmSigMatrix.fmSignTabel.Selection.Top to
                                     fmSigMatrix.fmSignTabel.Selection.Bottom do
              FillRect(fmSignTabel.CellRect(k,l));
              Brush.Color:=clWhite;
             end;
end;

end.
