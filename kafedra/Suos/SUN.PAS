unit Sun;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

const RateX=307/360;
      RateY=202/360;
      CenterX=153;
      CenterY=101;

type
  TSunDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SunBox: TPaintBox;
    PanelDark: TPanel;
    PanelSun: TPanel;
    _AlfaEdit: TEdit;
    _BettaEdit: TEdit;
    BettaEdit: TEdit;
    AlfaEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure SunBoxPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SunDlg: TSunDlg;

implementation

{$R *.DFM}

procedure TSunDlg.SunBoxPaint(Sender: TObject);
var R1: TRect;
begin
  With SunBox.Canvas do begin
    Brush.Color:=clBlack;
    Brush.Style:=bsSolid;
    R1.Left:=0;
    R1.Top:=0;
    R1.Right:=SunBox.Width;
    R1.Bottom:=SunBox.Height;
    FillRect(R1);
    Pen.Color:=clSilver;
    Pen.Style:=psSolid;
    MoveTo(0,Trunc(SunBox.Height/2));
    LineTo(SunBox.Width,Trunc(SunBox.Height/2));
    MoveTo(Trunc(SunBox.Width/2),0);
    LineTo(Trunc(SunBox.Width/2),SunBox.Height);
    Pen.Color:=clRed;
    Pen.Style:=psDot;


  end;
end;

end.
