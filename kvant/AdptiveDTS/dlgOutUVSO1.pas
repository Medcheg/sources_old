unit dlgOutUVSO1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Declaration, StdCtrls, ComCtrls, TeEngine, Series, ExtCtrls, TeeProcs,
  Chart, Math;

type
  TfrmOutUVSO1 = class(TForm)
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
  frmOutUVSO1: TfrmOutUVSO1;

implementation

uses
  Main, dlgOutUVSO2;

{$R *.DFM}

procedure TfrmOutUVSO1.FormCreate(Sender: TObject);
var
  APoint  : PEDiagramPoint;
//  Offset  : Extended;
  K       : Extended;
  i       : LongInt;
begin
  FLeft  := frmMain.LeftDiagram;
  FRight := frmMain.RightDiagram;
  FBlockUVSO := frmMain.ComonScheme1.BlockUVSO;

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

procedure TfrmOutUVSO1.FormShow(Sender: TObject);
begin
  frmMain.ComonScheme1.InitializationUVSO_OutDlg (lblOffset, lblOffsetV,
                                                  lblLeft, lblRight,
                                                  srPoints, srOffset,
                                                  srLeftLevel, srRightLevel);
end;

procedure TfrmOutUVSO1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmMain.N114.Checked := False;
  frmMain.ComonScheme1.FinalizationUVSO_OutDlg;
end;

procedure TfrmOutUVSO1.FormResize(Sender: TObject);
begin
  frmOutUVSO2.Width := frmOutUVSO1.Width;
  frmOutUVSO2.Height := frmOutUVSO1.Height;
end;

end.
