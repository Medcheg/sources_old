unit Sparams;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Tabs, Buttons, POS, BFZ, GIVUS, GRS,
  KzaCom;

type
  TSystemParamsDlg = class(TForm)
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    TabSet1: TTabSet;
    Notebook: TNotebook;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    T: TEdit;
    T0: TEdit;
    GroupBox2: TGroupBox;
    POSBox: TComboBox;
    GIVUSBox: TComboBox;
    EMIOBox: TComboBox;
    GRSBox: TComboBox;
    BFZBox: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MIOBox: TComboBox;
    BCVKBox: TComboBox;
    ValDstList: TListBox;
    ValExAllBtn: TSpeedButton;
    ValExcludeBtn: TSpeedButton;
    ValIncAllBtn: TSpeedButton;
    ValIncludeBtn: TSpeedButton;
    ValSrcList: TListBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    procedure ValIncludeBtnClick(Sender: TObject);
    procedure ValExcludeBtnClick(Sender: TObject);
    procedure ValIncAllBtnClick(Sender: TObject);
    procedure ValExAllBtnClick(Sender: TObject);
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
    procedure FormCreate(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure OkBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function Save(F: LongInt): boolean;
    function Open(F: LongInt): boolean;
  public
    vmT : Extended;
    vmT0: Extended;
  end;

var
  SystemParamsDlg: TSystemParamsDlg;

implementation

uses MIO, Main;
{$R *.DFM}
function TSystemParamsDlg.Save(F: LongInt): boolean;
begin
  FileWrite(F,vmT,SizeOf(vmT));
  FileWrite(F,vmT0,SizeOf(vmT0));
  Result:=True;
end;

function TSystemParamsDlg.Open(F: LongInt): boolean;
begin
  FileRead(F,vmT,SizeOf(vmT));
  FileRead(F,vmT0,SizeOf(vmT0));
  Result:=True;
end;

procedure TSystemParamsDlg.ValIncludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(ValSrcList);
  MoveSelected(ValSrcList, ValDstList.Items);
  SetItem(ValSrcList, Index);
end;

procedure TSystemParamsDlg.ValExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(ValDstList);
  MoveSelected(ValDstList, ValSrcList.Items);
  SetItem(ValDstList, Index);
end;

procedure TSystemParamsDlg.ValIncAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ValSrcList.Items.Count - 1 do
    ValDstList.Items.AddObject(ValSrcList.Items[I],
      ValSrcList.Items.Objects[I]);
  ValSrcList.Items.Clear;
  SetItem(ValSrcList, 0);
end;

procedure TSystemParamsDlg.ValExAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ValDstList.Items.Count - 1 do
    ValSrcList.Items.AddObject(ValDstList.Items[I], ValDstList.Items.Objects[I]);
  ValDstList.Items.Clear;
  SetItem(ValDstList, 0);
end;

procedure TSystemParamsDlg.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  I: Integer;
begin
  for I := List.Items.Count - 1 downto 0 do
    if List.Selected[I] then
    begin
      Items.AddObject(List.Items[I], List.Items.Objects[I]);
      List.Items.Delete(I);
    end;
end;

procedure TSystemParamsDlg.SetButtons;
var
  GraphSrcEmpty, GraphDstEmpty, ValSrcEmpty, ValDstEmpty: Boolean;
begin
  ValSrcEmpty := ValSrcList.Items.Count = 0;
  ValDstEmpty := ValDstList.Items.Count = 0;
  ValIncludeBtn.Enabled := not ValSrcEmpty;
  ValIncAllBtn.Enabled := not ValSrcEmpty;
  ValExcludeBtn.Enabled := not ValDstEmpty;
  ValExAllBtn.Enabled := not ValDstEmpty;
end;

function TSystemParamsDlg.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := LB_ERR;
end;

procedure TSystemParamsDlg.SetItem(List: TListBox; Index: Integer);
var
  MaxIndex: Integer;
begin
  with List do
  begin
    SetFocus;
    MaxIndex := List.Items.Count - 1;
    if Index = LB_ERR then Index := 0
    else if Index > MaxIndex then Index := MaxIndex;
    Selected[Index] := True;
  end;
  SetButtons;
end;


procedure TSystemParamsDlg.FormCreate(Sender: TObject);
begin
  TabSet1.Tabs := Notebook.Pages;
  ValSrcList.Items.LoadFromFile('Vals.txt');
end;

procedure TSystemParamsDlg.TabSet1Change(Sender: TObject;
  NewTab: Integer; var AllowChange: Boolean);
begin
  Notebook.PageIndex := NewTab{TabSet1.TabIndex};
end;

procedure TSystemParamsDlg.OkBtnClick(Sender: TObject);
begin
  vmT0:=StrToFloat(T0.Text);
  vmT:=StrToFloat(T.Text);
  Hide;
end;

procedure TSystemParamsDlg.CancelBtnClick(Sender: TObject);
begin
  Hide;
end;

procedure TSystemParamsDlg.FormShow(Sender: TObject);
begin
  POSBox.Items:=POSDlg.NoteBook.Pages;
  POSBox.Items.Insert(0,'(Пусто)');
  BFZBox.Items:=BFZDlg.NoteBook.Pages;
  BFZBox.Items.Insert(0,'(Пусто)');
  GRSBox.Items:=GRSDlg.NoteBook.Pages;
  GRSBox.Items.Insert(0,'(Пусто)');
  MIOBox.Items:=MIODlg.NoteBook.Pages;
  MIOBox.Items.Insert(0,'(Пусто)');
  GIVUSBox.Items:=GIVUSDlg.NoteBook.Pages;
  GIVUSBox.Items.Insert(0,'(Пусто)');
  EMIOBox.Items.Insert(0,'(Пусто)');
  BCVKBox.Items.Insert(0,'(Пусто)');
  T.Text:=FloatToStrF(vmT,ffFixed,9,8);
  T0.Text:=FloatToStrF(vmT0,ffFixed,9,8);
end;
end.
