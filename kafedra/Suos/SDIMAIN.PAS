unit Sdimain;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TSDIAppForm = class(TForm)
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    OpenItem: TMenuItem;
    SaveItem: TMenuItem;
    ExitItem: TMenuItem;
    N1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SpeedPanel: TPanel;
    OpenBtn: TSpeedButton;
    SaveBtn: TSpeedButton;
    ExitBtn: TSpeedButton;
    NewItem: TMenuItem;
    SaveAsItem: TMenuItem;
    ModeMenu: TMenuItem;
    ControlItem: TMenuItem;
    RazgruzItem: TMenuItem;
    SUOSMenu: TMenuItem;
    POSItem: TMenuItem;
    GIVUSItem: TMenuItem;
    EMIOItem: TMenuItem;
    GRSItem: TMenuItem;
    BFZItem: TMenuItem;
    MIOItem: TMenuItem;
    BDCCItem: TMenuItem;
    SAMenu: TMenuItem;
    OrbitItem: TMenuItem;
    TenzorItem: TMenuItem;
    DisturbItem: TMenuItem;
    ICItem: TMenuItem;
    N2: TMenuItem;
    RunMenu: TMenuItem;
    RunItem: TMenuItem;
    StopItem: TMenuItem;
    PauseItem: TMenuItem;
    SystemItem: TMenuItem;
    OutItem: TMenuItem;
    procedure ExitItemClick(Sender: TObject);
    procedure OpenItemClick(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SDIAppForm: TSDIAppForm;

implementation

uses About;

{$R *.DFM}

procedure TSDIAppForm.ExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.OpenItemClick(Sender: TObject);
begin
  OpenDialog.Execute
end;

procedure TSDIAppForm.SaveItemClick(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure TSDIAppForm.About1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

end.
 
