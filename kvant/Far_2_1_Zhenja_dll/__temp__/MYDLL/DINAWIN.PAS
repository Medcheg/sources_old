unit DinaWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmLicense = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnCaption: TButton;
    btnAgrae: TButton;
    procedure btnCaptionClick(Sender: TObject);
    procedure btnAgraeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLicense  : TfrmLicense ;

implementation

{$R *.DFM}

procedure TfrmLicense.btnCaptionClick(Sender: TObject);
begin
  ModalResult := mrCancel ;
end;

procedure TfrmLicense.btnAgraeClick(Sender: TObject);
begin
  ModalResult := mrOk ;
end;

end.
