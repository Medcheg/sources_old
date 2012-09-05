unit KatalogFram;

interface

uses 
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg;

type
  TKatalogFrame = class(TFrame)
    Panel1: TPanel;
    imgTraek: TImage;
    shpSelect: TShape;
    stxtTraekName: TStaticText;
    lblNo: TLabel;
    procedure imgTraekClick(Sender: TObject);
    procedure stxtTraekNameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    procedure SetInactive();
    procedure SetActive();
    { Public declarations }
  end;

implementation

uses KatalogFrm, MainFrm;

{$R *.DFM}

procedure TKatalogFrame.SetActive;
var PFrame : TKatalogFrame;
    TheRect: TRect;
begin
  if Assigned (KatalogForm.CurFrame) then
    KatalogForm.CurFrame.SetInactive;

  KatalogForm.CurFrame := Self;

  shpSelect.Visible := True;
  stxtTraekName.Font.Color := clHighlightText;
  stxtTraekName.Color := clHighlight;

  lblNo.Font.Style := lblNo.Font.Style+[fsBold];
end;

procedure TKatalogFrame.SetInactive;
begin
  shpSelect.Visible := False;
  stxtTraekName.Font.Color := clWindowText;
  stxtTraekName.Color := clWindow;
  lblNo.Font.Style := lblNo.Font.Style-[fsBold];
end;

procedure TKatalogFrame.imgTraekClick(Sender: TObject);
begin
  SetActive;
end;

procedure TKatalogFrame.stxtTraekNameMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetActive;
end;


end.
