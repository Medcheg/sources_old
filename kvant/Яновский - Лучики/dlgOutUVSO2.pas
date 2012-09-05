unit dlgOutUVSO2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Declaration, StdCtrls, ComCtrls, TeEngine, Series, ExtCtrls, TeeProcs,
  Chart, Math;

type
  TfrmOutUVSO2 = class(TForm)
    Chart: TChart;
    srLeft: TFastLineSeries;
    srRight: TFastLineSeries;
    srPoints: TPointSeries;
    srOffset: TLineSeries;
    srLeftLevel: TFastLineSeries;
    srRightLevel: TFastLineSeries;
    Panel1: TPanel;
    lblLeft: TLabel;
    lblRight: TLabel;
    lblOffset: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblOffsetV: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FBlockUVSO  : TEBlockUVSO;
    FLeft       : TEDirectionalDiagram;
    FRight      : TEDirectionalDiagram;
  public
    { Public declarations }
  end;

var
  frmOutUVSO2: TfrmOutUVSO2;

implementation

uses
  Main, dlgOutUVSO1;

{$R *.DFM}

procedure TfrmOutUVSO2.FormCreate(Sender: TObject);
var
  APoint  : PEDiagramPoint;
//  Offset  : Extended;
  K       : Extended;
  i       : LongInt;
begin
  FLeft  := frmMain.LeftDiagram;
  FRight := frmMain.RightDiagram;
  FBlockUVSO := frmMain.ComonScheme2.BlockUVSO;

  srLeft.Clear;
  for i := 0 to FLeft.Values.Count-1 do
    begin
      APoint := FLeft.Values.Items [i];
      //K := Power (10, APoint^.DampingFactor);
      K := APoint^.DampingFactor;
      srLeft.AddXY (APoint^.Offset * 180/Pi, K, '', clTeeColor);
    end;

  srRight.Clear;
  for i := 0 to FRight.Values.Count-1 do
    begin
      APoint := FRight.Values.Items [i];
      //K := Power (10, APoint^.DampingFactor);
      K := APoint^.DampingFactor;
      srRight.AddXY (APoint^.Offset * 180/Pi, K, '', clTeeColor);
    end;
end;

procedure TfrmOutUVSO2.FormShow(Sender: TObject);
begin
  frmMain.ComonScheme2.InitializationUVSO_OutDlg (lblOffset, lblOffsetV,
                                                  lblLeft, lblRight,
                                                  srPoints, srOffset,
                                                  srLeftLevel, srRightLevel);
end;

procedure TfrmOutUVSO2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmMain.N26.Checked := False;
  frmMain.ComonScheme2.FinalizationUVSO_OutDlg;
end;

procedure TfrmOutUVSO2.FormResize(Sender: TObject);
begin
  frmOutUVSO1.Width := frmOutUVSO2.Width;
  frmOutUVSO1.Height := frmOutUVSO2.Height;
end;

end.
