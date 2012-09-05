unit dlgOutBFZ1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, TeEngine, Series, TeeProcs, Chart, ExtCtrls;

type
  TfrmOutBFZ1 = class(TForm)
    Panel1: TPanel;
    lblLeft: TLabel;
    lblCenter: TLabel;
    lblRight: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Chart: TChart;
    Series: TBarSeries;
    Chart1: TChart;
    Series1: TBarSeries;
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    //procedure OutValues(ALeft, ACenter, ARight: Extended);
    { Private declarations }
  public
    { Public declarations }
    procedure OutValues (ALeft, ACenter, ARight  : Extended);
    procedure OutTestValues (Betta, RealBetta  : Extended);
  end;

var
  frmOutBFZ1  : TfrmOutBFZ1;

implementation

uses dlgOutBFZ2, Main;

{$R *.DFM}

procedure TfrmOutBFZ1.OutTestValues(Betta, RealBetta: Extended);
begin
  Series1.Clear;
  Series1.AddBar (0, '', clTeeColor);
  Series1.AddBar ((Betta - RealBetta) * 180/Pi, '', clTeeColor);
end;

procedure TfrmOutBFZ1.OutValues (ALeft, ACenter, ARight  : Extended);
begin
  Series.Clear;
  Series.AddBar (ALeft / 1000, 'Левый', clTeeColor);
  Series.AddBar (ACenter / 1000, 'Цетр', clTeeColor);
  Series.AddBar (ARight / 1000, 'Правый', clTeeColor);

  lblLeft.Caption := Format ('%12.6f В', [ALeft / 1000]);
  lblCenter.Caption := Format ('%12.6f В', [ACenter / 1000]);
  lblRight.Caption := Format ('%12.6f В', [ARight / 1000]);
end;

procedure TfrmOutBFZ1.FormResize(Sender: TObject);
begin
  frmOutBFZ2.Width := frmOutBFZ1.Width;
end;

procedure TfrmOutBFZ1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.N113.Checked := False;
end;

end.
