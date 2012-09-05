unit Unit_HeadingOfTheDiagram;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmHeadingOfTheDiagram = class(TForm)
    Panel1: TPanel;
    Panel10: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel11: TPanel;
    Panel6: TPanel;
    Panel12: TPanel;
    Panel8: TPanel;
    Panel7: TPanel;
    Panel2_: TPanel;
    Panel9: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Label17: TLabel;
    Panel17: TPanel;
    Panel18: TPanel;
    Label20: TLabel;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Panel32: TPanel;
    Panel33: TPanel;
    Panel36: TPanel;
    Panel37: TPanel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel40: TPanel;
    Panel41: TPanel;
    Panel42: TPanel;
    Panel43: TPanel;
    Panel44: TPanel;
    Panel45: TPanel;
    Panel46: TPanel;
    Panel47: TPanel;
    Panel48: TPanel;
    Panel49: TPanel;
    Panel50: TPanel;
    Panel51: TPanel;
    Panel52: TPanel;
    Panel53: TPanel;
    Panel54: TPanel;
    Panel55: TPanel;
    Panel56: TPanel;
    Panel57: TPanel;
    Panel34: TPanel;
    Panel35: TPanel;
    Panel58: TPanel;
    Panel59: TPanel;
    Panel3: TPanel;
    Panel60: TPanel;
    Panel61: TPanel;
    Panel62: TPanel;
    Panel63: TPanel;
    Panel64: TPanel;
    Panel65: TPanel;
    Panel66: TPanel;
    Panel67: TPanel;
    Panel68: TPanel;
    Panel69: TPanel;
    Panel70: TPanel;
    Panel71: TPanel;
    Panel72: TPanel;
    Panel73: TPanel;
    Panel74: TPanel;
    Panel75: TPanel;
    Panel76: TPanel;
    Panel77: TPanel;
    Panel78: TPanel;
    Panel79: TPanel;
    Panel80: TPanel;
    Panel81: TPanel;
    Panel82: TPanel;
    Panel83: TPanel;
    Panel84: TPanel;
    Panel85: TPanel;
    Panel86: TPanel;
    Panel87: TPanel;
    Panel88: TPanel;
    Panel89: TPanel;
    Panel90: TPanel;
    Panel91: TPanel;
    Panel92: TPanel;
    Panel93: TPanel;
    Panel94: TPanel;
    Panel95: TPanel;
    Panel96: TPanel;
    Panel97: TPanel;
    Panel98: TPanel;
    Panel99: TPanel;
    Panel100: TPanel;
    Panel101: TPanel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure PanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    OldPanelMove : TPanel;

  public
   procedure CalcRotLabelPosition();
  end;

var
  frmHeadingOfTheDiagram: TfrmHeadingOfTheDiagram;

implementation

uses Unit_SaveType, MPIDeclaration;

{$R *.DFM}

procedure TfrmHeadingOfTheDiagram.FormShow(Sender: TObject);
begin
  AutoSize       := False;
  AutoScroll     := True;
  Height         := 500;
  Width          := 689;

  Panel1.Top     := 0;
  Panel1.Left    := 2;
  Panel2.Left    := 2;
  Panel2.Top     := Panel1.Height-2;

//  ScrollBar1.Min := 0;
//  ScrollBar1.Max := Panel1.Height  + Panel2.Height - ClientHeight;
//  ClientWidth    := Panel1.Width + ScrollBar1.Width + 4
end;

procedure TfrmHeadingOfTheDiagram.ScrollBar1Change(Sender: TObject);
begin
//  Panel1.Top := -ScrollBar1.Position;
//  Panel2.Top :=  Panel1.Height - ScrollBar1.Position;
end;

procedure TfrmHeadingOfTheDiagram.PanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if OldPanelMove <> nil then OldPanelMove.Color := clWhite;
  OldPanelMove := TPanel(Sender);
  OldPanelMove.Color := clGray;
end;

procedure TfrmHeadingOfTheDiagram.PanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    CurrentPanel : TPanel;
begin
  CurrentPanel         := TPanel(Sender);
  CurrentPanel.Caption := InputBox('Автономный манометр-термометр АМТ','',CurrentPanel.Caption);

  CalcRotLabelPosition();
end;

procedure TfrmHeadingOfTheDiagram.FormCreate(Sender: TObject);
begin
  OldPanelMove := nil;
end;

procedure TfrmHeadingOfTheDiagram.Panel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if OldPanelMove <> nil then OldPanelMove.Color := clWhite;
end;

procedure TfrmHeadingOfTheDiagram.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PrepareHeadingDiagramPanelArray();
end;

procedure TfrmHeadingOfTheDiagram.CalcRotLabelPosition;
begin
  Application.ProcessMessages;
end;

procedure TfrmHeadingOfTheDiagram.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 27 then close;
end;

end.
