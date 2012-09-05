unit Graphdlg;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TGraphCreateDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    GroupBox1: TGroupBox;
    Panel12: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    CaptionEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ComboX: TComboBox;
    ComboY: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    EditScaleX: TEdit;
    EditScaleY: TEdit;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    BitBtn1: TBitBtn;
    Panel18: TPanel;
    Label6: TLabel;
    TaktEdit: TEdit;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ComboXChange(Sender: TObject);
    procedure ComboYChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GraphCreateDlg: TGraphCreateDlg;

implementation

{$R *.DFM}

procedure TGraphCreateDlg.FormCreate(Sender: TObject);
begin
  ComboX.Items.LoadFromFile('Vals.txt');
  ComboY.Items.LoadFromFile('Vals.txt');
end;

procedure TGraphCreateDlg.ComboXChange(Sender: TObject);
begin
  CaptionEdit.Text:=CaptionEdit.Text+' '+ComboX.Text;
end;

procedure TGraphCreateDlg.ComboYChange(Sender: TObject);
begin
  CaptionEdit.Text:=CaptionEdit.Text+' '+ComboY.Text;
end;

end.
