unit Unit_About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg;

type
  TfrmAbout = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Label4: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    procedure Label2Click(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public


    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses ShellApi;

{$R *.DFM}

procedure TfrmAbout.Label2Click(Sender: TObject);
begin
  ShellExecute(Handle,'open', PChar(TLabel(Sender).Caption),nil,nil,SW_SHOW);
end;

procedure TfrmAbout.OKButtonClick(Sender: TObject);
begin
  Close;
end;

end.

