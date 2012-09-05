unit Unit_DiscretAlfaBetta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, ExtCtrls;

type
  TfrmDiscretAlfaBetta = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDiscretAlfaBetta: TfrmDiscretAlfaBetta;

implementation

uses MPiDeclaration, Unit_Main;

{$R *.DFM}

procedure TfrmDiscretAlfaBetta.FormShow(Sender: TObject);
begin
  SpinEdit1.Value :=  Round(Form1.Platform.DiscretAlfaBetta*60*180/pi);
end;

procedure TfrmDiscretAlfaBetta.BitBtn1Click(Sender: TObject);
begin
  Form1.Platform.DiscretAlfaBetta := SpinEdit1.Value/60*pi/180;
  close;
end;

procedure TfrmDiscretAlfaBetta.SpinEdit1Change(Sender: TObject);
begin
  Form1.Platform.DiscretAlfaBetta := SpinEdit1.Value/60*pi/180;
end;

end.
