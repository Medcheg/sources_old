unit Value;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Menus, Grids, ExtCtrls, SParams, KzaCom, Dialogs;

type
  TOutValDlg = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PanelTime: TPanel;
    PanelTakt: TPanel;
    Panel2: TPanel;
    CloseBtn: TBitBtn;
    ValueGrid: TStringGrid;
    ValPopup: TPopupMenu;
    AddItem: TMenuItem;
    Panel1: TPanel;
    TaktEdit: TEdit;
    Label4: TLabel;
    SaveItem: TMenuItem;
    SaveDialog: TSaveDialog;
    TabEdit: TEdit;
    Label5: TLabel;
    procedure AddItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure AddRow(var Surc: TKindString);
    procedure Clear;
    procedure CloseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TaktEditChange(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TaktSb: Extended;
    CurRow: LongInt;
  end;

var
  OutValDlg: TOutValDlg;

implementation

uses SysUtils, Main;

{$R *.DFM}

procedure TOutValDlg.Clear;
var i: LongInt;
begin
  Screen.Cursor:=crHourGlass;
  with ValueGrid do
  For i:=1 to RowCount-1 do Rows[i].Clear;
  Screen.Cursor:=crDefault;
end;

procedure TOutValDlg.AddRow(var Surc: TKindString);
var i: Integer;
    index: Integer;
begin
  if Visible then begin
  with ValueGrid do begin
    for i:=0 to ColCount-1 do begin
      If Surc[kNames].Find(Cells[i,0],index)
         then Cells[i,CurRow]:= Surc[kValues].Strings[index]
         else Cells[i,CurRow]:= 'Отсутствует';
    end;
    if CurRow>VisibleRowCount
       then TopRow:=CurRow-VisibleRowCount+1;
    Refresh;
  end;
  inc(CurRow);
  end;
end;

procedure TOutValDlg.AddItemClick(Sender: TObject);
begin
  SystemParamsDlg.NoteBook.ActivePage:='Значения';
  SystemParamsDlg.TabSet1.TabIndex:=SystemParamsDlg.NoteBook.PageIndex;
  SystemParamsDlg.TabSet1.Enabled:=False;
  SystemParamsDlg.ShowModal;
  if SystemParamsDlg.ModalResult=mrOk then begin
    if SystemParamsDlg.ValDstList.Items.Count=0 then begin
      ValueGrid.Hide;
      Panel1.Show;
    end
    else begin
      Panel1.Hide;
      ValueGrid.Show;
      ValueGrid.ColCount:=SystemParamsDlg.ValDstList.Items.Count;
      ValueGrid.Rows[0]:=SystemParamsDlg.ValDstList.Items;
      ValueGrid.Repaint;
    end;
  end;
  SystemParamsDlg.TabSet1.Enabled:=True;
end;

procedure TOutValDlg.FormShow(Sender: TObject);
begin
  if SystemParamsDlg.vmT<>0 then TaktSb:=SystemParamsDlg.vmT/10000
                            else TaktSb:=1;
  TaktEdit.Text:=FloatToStr(TaktSb);
  PanelTime.Caption:=FloatToStrF(SystemParamsDlg.vmT,ffFixed,9,8);
  PanelTakt.Caption:=FloatToStrF(SystemParamsDlg.vmT0,ffFixed,9,8);
  if SystemParamsDlg.ValDstList.Items.Count=0 then begin
    ValueGrid.Hide;
    Panel1.Show;
  end
  else begin
    Panel1.Hide;
    ValueGrid.Show;
    ValueGrid.ColCount:=SystemParamsDlg.ValDstList.Items.Count;
    ValueGrid.Rows[0]:=SystemParamsDlg.ValDstList.Items;
  end;
end;

procedure TOutValDlg.FormHide(Sender: TObject);
begin
  MainForm.ValItem.Checked:=False;
  Clear;
end;

procedure TOutValDlg.CloseBtnClick(Sender: TObject);
begin
 Hide;
end;

procedure TOutValDlg.FormCreate(Sender: TObject);
begin
  OutValDlg.TabEdit.Text:='tab1.tab';
end;

procedure TOutValDlg.TaktEditChange(Sender: TObject);
begin
  TaktSb:=StrToFloat(TaktEdit.Text);
  if TaktSb=0 then begin
    TaktSb:=1;
    TaktEdit.Text:='1';
  end;
end;

procedure TOutValDlg.SaveItemClick(Sender: TObject);
var i,j,k: LongInt;
    F: TextFile;
    StrA: String;
    a: Integer;
begin
  SaveDialog.FileName:=TabEdit.Text;
  if SaveDialog.Execute then begin
  {}{}{}{}{}{}{}{}
    AssignFile(F,SaveDialog.FileName);
    Rewrite(F);
    for j:=0 to ValueGrid.colCount-1 do begin
      Write(F,' ',ValueGrid.Cells[j,0]);
    end;
    Writeln(F);
    Writeln(F);
    for i:=1 to curRow do begin
      for j:=0 to ValueGrid.colCount-1 do begin
        StrA:=ValueGrid.Cells[j,i];
        a:=Length(ValueGrid.Cells[j,0])-Length(StrA);
        if a>=0 then
          for k:=1 to a do
            StrA:=StrA+' '
         else Delete(StrA,Length(StrA)-a+1,Abs(a));
        Write(F,' ',StrA);
      end;
      Writeln(F);
    end;
        CloseFile(F);
  end;
end;

end.
