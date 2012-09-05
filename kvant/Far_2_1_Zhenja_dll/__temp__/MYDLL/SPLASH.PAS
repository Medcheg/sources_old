unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, StdCtrls, ExtCtrls;

type
  TfrmSplash = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Gauge1: TGauge;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash   : TfrmSplash ;

implementation

{$R *.DFM}

end.
