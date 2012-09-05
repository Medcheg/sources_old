unit dlgComonIndicator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TfrmComonIndicator = class(TForm)
    Image: TImage;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  
  public
    { Public declarations }
    BitmapShip1  : TBitmap;
    BitmapShip2  : TBitmap;
  end;

var
  frmComonIndicator: TfrmComonIndicator;

implementation

uses
  Main;

{$R *.DFM}

procedure TfrmComonIndicator.FormCreate(Sender: TObject);
begin
  BitmapShip1 := TBitmap.Create;
  BitmapShip1.TransparentColor := clWhite;
  BitmapShip1.Transparent := True;

  BitmapShip2 := TBitmap.Create;
  BitmapShip2.TransparentColor := clWhite;
  BitmapShip2.Transparent := True;

  BitmapShip1.LoadFromResourceName(HInstance, 'Ship1');
  BitmapShip2.LoadFromResourceName(HInstance, 'Ship2');
  frmMain.IndicatorInitialzation;
end;

procedure TfrmComonIndicator.FormResize(Sender: TObject);
begin
  if Assigned (frmMain.ComonIndicator) then
    frmMain.ComonIndicator.ChangeShowParams;
end;

procedure TfrmComonIndicator.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frmMain.N19.Checked := False;
end;

end.
