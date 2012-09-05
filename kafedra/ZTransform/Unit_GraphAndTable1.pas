unit Unit_GraphAndTable1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, Grids, TeEngine, Series, TeeProcs, Chart;

const
  Ksi2Array : array [0..4] of Extended = (0.1, 0.3, 0.5, 0.7, 0.9);

type
  TfrmGraphAndTable1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Chart1: TChart;
    Series1: TFastLineSeries;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Series5: TFastLineSeries;
    Chart2: TChart;
    FastLineSeries1: TFastLineSeries;
    FastLineSeries2: TFastLineSeries;
    FastLineSeries3: TFastLineSeries;
    FastLineSeries4: TFastLineSeries;
    FastLineSeries5: TFastLineSeries;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    t0                 : Extended;
     Count              : Integer;
  public
    { Public declarations }
  end;

var
  frmGraphAndTable1: TfrmGraphAndTable1;

implementation

uses MPITypes, MPIDeclaration;

{$R *.DFM}

procedure TfrmGraphAndTable1.FormCreate(Sender: TObject);
begin
  t0                           := 0.01;
  Count                        := Trunc(10/t0);
  StringGrid1.RowCount         := Count + 1;
  StringGrid2.RowCount         := Count + 1;

  StringGrid1.ColCount         := Length(Ksi2Array) + 1;
  StringGrid2.ColCount         := Length(Ksi2Array) + 1;

  StringGrid1.DefaultColWidth  := Trunc(StringGrid1.Width / StringGrid1.ColCount) - 4;
  StringGrid2.DefaultColWidth  := Trunc(StringGrid2.Width / StringGrid2.ColCount) - 4;

  StringGrid1.Cells[0,0]       := 'Lambda';
  StringGrid2.Cells[0,0]       := 'Lambda';
end;

procedure TfrmGraphAndTable1.FormShow(Sender: TObject);
var
 Gamma              : Extended;
 i, k               : Integer;
 r                  : array [0..4] of TTwoValues;
begin
  ToolBar1.Width               := ControlBar1.Width;
  PageControl1.ActivePageIndex := 0;

  for i:=0 to Chart1.SeriesCount -1 do Chart1.Series[i].Clear;
  for i:=0 to Chart2.SeriesCount -1 do Chart2.Series[i].Clear;

  Chart1.UndoZoom;
  Chart2.UndoZoom;

  ////////////////////////////////////////////
  for k:=0 to 4 do begin
      StringGrid1.Cells[k+1,0] := 'ksi = ' + floatToStr(Ksi2Array[k]);
      StringGrid2.Cells[k+1,0] := 'ksi = ' + floatToStr(Ksi2Array[k]);
      for i:= 1 to Count do begin
         Gamma := i*t0;
         StringGrid1.Cells[0,i] := FloatToStr(Gamma);
         StringGrid2.Cells[0,i] := StringGrid1.Cells[0,i];

         r[k] := ZTransform.Get_Coef_T_2_4e_and_Zetta_2_4e(Gamma,1, Ksi2Array[k]);

         Chart1.Series[k].AddXY(Gamma, r[k].val1);
         Chart2.Series[k].AddXY(Gamma, r[k].val2/Ksi2Array[k]);

         StringGrid1.Cells[k+1,i] := FloatToStrF(r[k].val1             , ffFixed, 12,7);
         StringGrid2.Cells[k+1,i] := FloatToStrF(r[k].val2/Ksi2Array[k], ffFixed, 12,7);
      end;
  end;
 ////////////////////////////////////////////
end;

procedure TfrmGraphAndTable1.ToolButton1Click(Sender: TObject);
begin
  Close;
end;

end.
