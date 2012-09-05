 unit Unit_GLSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmGLSettings = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    procedure EdPointSizeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGLSettings: TfrmGLSettings;

implementation

Uses Unit_Main, Unit_GL, Unit_GLVizualZaboyParams;

{$R *.DFM}
{===============================================================================
клик на поле знчения размера  точки}
procedure TfrmGLSettings.EdPointSizeClick(Sender: TObject);
begin
end;

{===============================================================================
ОК- клик}
procedure TfrmGLSettings.Button1Click(Sender: TObject);
begin
  frmGL.PointSize := StrToFloat(frmGLVizualZaboyParams.EdPointSize.Text);
  frmGL.SegRasst  := StrToFloat(frmGLVizualZaboyParams.EdSegmentRasst.Text);
  frmGLSettings.Close;
  frmGL.Refresh;
end;

{===============================================================================
показ. формы настроек}
procedure TfrmGLSettings.FormShow(Sender: TObject);
begin
  frmGLVizualZaboyParams.EdPointSize.Text :=  FloatToStr (frmGL.PointSize);
  frmGLVizualZaboyParams.EdSegmentRasst.Text := FloatToStr (frmGL.SegRasst);
end;

{===============================================================================
}
end.
