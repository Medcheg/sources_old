unit Unit_Graphics;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls;

type
  TfrmGraphic = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGraphic: TfrmGraphic;

implementation

{$R *.DFM}

end.
