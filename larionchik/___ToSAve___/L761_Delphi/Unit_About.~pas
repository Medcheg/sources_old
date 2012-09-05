unit Unit_About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TfrmAbout = class(TForm)
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    Label8: TLabel;
    Bevel1: TBevel;
    Label9: TLabel;
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Flag : Boolean;
    Offset : Integer;
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.DFM}

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  Offset         := 0;
  Panel3.Top     := 8;
  Flag           := False;
  Timer2.Enabled := False;
  Timer1.Enabled := True;
end;

procedure TfrmAbout.Timer1Timer(Sender: TObject);
begin
  if Flag then begin
     Timer2.Enabled := True;
     Timer1.Enabled := False;
  end;
  Flag := True;
end;

procedure TfrmAbout.Timer2Timer(Sender: TObject);
begin
  Panel3.Top := 8 - Offset;
  Inc(Offset);
  if Offset > 105 then Timer2.Enabled := False;
end;

end.
