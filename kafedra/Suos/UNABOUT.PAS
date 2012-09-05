unit Unabout;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox1 = class(TForm)
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    ProgramIcon: TImage;
    OkBtn: TBitBtn;
    Label1: TLabel;
    procedure OkBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox1: TAboutBox1;

implementation

{$R *.DFM}

procedure TAboutBox1.OkBtnClick(Sender: TObject);
begin
  Hide;
end;

end.

