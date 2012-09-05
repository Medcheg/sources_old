unit dlgOutBFZ2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, TeEngine, Series, TeeProcs, Chart, ExtCtrls;

type
  TfrmOutBFZ2 = class(TForm)
    Panel1: TPanel;
    lblLeft: TLabel;
    lblCenter: TLabel;
    lblRight: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Chart: TChart;
    Series: TBarSeries;
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OutValues (ALeft, ACenter, ARight  : Extended);
  end;

var
  frmOutBFZ2  : TfrmOutBFZ2;

implementation

uses dlgOutBFZ1, Main;

{$R *.DFM}

procedure TfrmOutBFZ2.OutValues (ALeft, ACenter, ARight  : Extended);
begin
  Series.Clear;
  Series.AddBar (ALeft / 1000, 'Левый', clTeeColor);
  Series.AddBar (ACenter / 1000, 'Цетр', clTeeColor);
  Series.AddBar (ARight / 1000, 'Правый', clTeeColor);

  lblLeft.Caption := Format ('%12.6f В', [ALeft / 1000]);
  lblCenter.Caption := Format ('%12.6f В', [ACenter / 1000]);
  lblRight.Caption := Format ('%12.6f В', [ARight / 1000]);
end;

procedure TfrmOutBFZ2.FormResize(Sender: TObject);
begin
  frmOutBFZ1.Width := frmOutBFZ2.Width;
end;

procedure TfrmOutBFZ2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.N25.Checked := False;
end;

end.
