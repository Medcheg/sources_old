unit Unit_FFTShowResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls, ToolWin, StdCtrls,
  Spin;

type
  TfrmFFTShowResult = class(TForm)
    ControlBar1: TControlBar;
    TabControl1: TTabControl;
    Chart1: TChart;
    Series1: TFastLineSeries;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    procedure DrawSeries(NumberSeries : Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFFTShowResult: TfrmFFTShowResult;

implementation

Uses MPIDeclaration, Unit_FFT_Param;

{$R *.DFM}

procedure TfrmFFTShowResult.DrawSeries(NumberSeries: Integer);
var
  k   : integer;
  Max : Single;
begin
  Chart1.series[0].Clear;
  Max := 0;
  for k := 0 to (frmFFT_Param.CountFFTPoint div 2) - 1 do begin
      Chart1.series[0].AddXY(k/frmFFT_Param.CountFFTPoint*AcpFreq, frmFFT_Param.Spectr[NumberSeries]^[k]);
      if (Max < frmFFT_Param.Spectr[NumberSeries]^[k]) {and (k <> 0)} then
          Max := frmFFT_Param.Spectr[NumberSeries]^[k];
  end;

  Chart1.LeftAxis.SetMinMax(0,max*1.23);
  Application.ProcessMessages;
end;

procedure TfrmFFTShowResult.FormShow(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
  DrawSeries(0);
end;

procedure TfrmFFTShowResult.TabControl1Change(Sender: TObject);
begin
  Chart1.UndoZoom;
  DrawSeries(TabControl1.TabIndex)
end;

procedure TfrmFFTShowResult.ToolButton1Click(Sender: TObject);
var
  FileName : String;
begin
  // --- Параметры Save Диалога ----
  SaveDialog1.Filter     := 'Файлы bmp (*.bmp)|*.bmp';
  SaveDialog1.Title      := 'Запись файла';
  SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  SaveDialog1.FileName   := '';
  if SaveDialog1.Execute then begin
      FileName := SaveDialog1.FileName;
      if ExtractFileExt(FileName) = '' then FileName := FileName + '.bmp';
      Chart1.Color := clWhite;
      Chart1.SaveToBitmapFile(FileName);
      Chart1.Color := clBtnFace;
  end;
end;

end.
