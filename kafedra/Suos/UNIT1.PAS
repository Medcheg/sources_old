unit Unit1;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls;

type
  TBtnBottomDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    procedure FormPaint(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    b: TbitMap;
    r1,r2: TRect;
    p: TPoint;
  end;

var
  BtnBottomDlg: TBtnBottomDlg;

implementation

uses Main;

{$R *.DFM}

procedure TBtnBottomDlg.FormPaint(Sender: TObject);
begin
  with Canvas do begin
    Draw(ClientRect.Left, ClientRect.Top,b);
    brush.Style:=bsDiagCross;
    Brush.Color:=clWhite;
    Pen.Color:=clWhite;
    Pen.Mode:=pmXOR;
    Pen.Width:=1;
    Rectangle(ClientRect.Left,ClientRect.Top,
    ClientRect.Right,ClientRect.Bottom);
  end;
end;

procedure TBtnBottomDlg.OKBtnClick(Sender: TObject);
begin
 Hide;
  b.Free;
end;

procedure TBtnBottomDlg.FormShow(Sender: TObject);
begin
  b:=TBitMap.Create;
  p:=ClientToScreen(ClientRect.TopLeft);
  r1.TopLeft:=MainForm.ScreenToClient(p);
  p:=ClientToScreen(ClientRect.BottomRight);
  r1.BottomRight:=MainForm.ScreenToClient(p);
  r1.left:=r1.Left;
  r1.Top:=r1.Top;
  r1.Right:=r1.Right;
  r1.bottom:=r1.Bottom;
  b.Width:=r1.Right-r1.Left;
  b.Height:=r1.bottom-r1.top;
  r2.top:=0;
  r2.left:=0;
  r2.right:=b.Width;
  r2.bottom:=b.Height;
  b.Canvas.CopyRect(r2,MainForm.Canvas,r1);

end;

end.
