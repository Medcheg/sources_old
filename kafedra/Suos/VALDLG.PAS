unit Valdlg;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Grids, ExtCtrls, Menus, SParams, KzaCom;

type
  TOutValDlg = class(TForm)
    Panel1: TPanel;
    ValueGrid: TStringGrid;
    Panel2: TPanel;
    CloseBtn: TBitBtn;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PanelTime: TPanel;
    PanelTakt: TPanel;
    PanelName: TPanel;
    ValPopup: TPopupMenu;
    AddItem: TMenuItem;
    RemoveItem: TMenuItem;
    procedure AddItemClick(Sender: TObject);
    procedure RemoveItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses SysUtils;

{$R *.DFM}

procedure TOutValDlg.AddItemClick(Sender: TObject);
begin
  SystemParamsDlg.NoteBook.ActivePage:='Значения';
  SystemParamsDlg.TabSet1.Enabled:=False;
  SystemParamsDlg.Show;
  SystemParamsDlg.TabSet1.Enabled:=True;
  ValueGrid.ColCount:=SystemParamsDlg.ValDstList.Items.Count+1;
  ValueGrid.Rows[0]:=SystemParamsDlg.ValDstList.Items;
  ValueGrid.Rows[0].Insert(0,'Время');
  ValueGrid.Repaint;
end;

procedure TOutValDlg.RemoveItemClick(Sender: TObject);
begin
  SystemParamsDlg.NoteBook.ActivePage:='Значения';
  SystemParamsDlg.TabSet1.Enabled:=False;
  SystemParamsDlg.Show;
  SystemParamsDlg.TabSet1.Enabled:=True;
  ValueGrid.ColCount:=SystemParamsDlg.ValDstList.Items.Count+1;
  ValueGrid.Rows[0]:=SystemParamsDlg.ValDstList.Items;
  ValueGrid.Rows[0].Insert(0,'Время');
  ValueGrid.Repaint;
end;

procedure TOutValDlg.FormCreate(Sender: TObject);
begin
  ValueGrid.Cells[0,0]:='Время';
end;

procedure TOutValDlg.FormShow(Sender: TObject);
begin
  ValueGrid.ColCount:=SystemParamsDlg.ValDstList.Items.Count+1;
  ValueGrid.Rows[0]:=SystemParamsDlg.ValDstList.Items;
  ValueGrid.Rows[0].Insert(0,'Время');
  PanelTime.Caption:=FloatToStrF(vmT,ffFixed,9,8);
  PanelTakt.Caption:=FloatToStrF(vmT0,ffFixed,9,8);
end;

end.
