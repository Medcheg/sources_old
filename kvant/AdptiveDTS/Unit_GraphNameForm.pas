unit Unit_GraphNameForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, Buttons,
  DeclPasha;

type
  TGraphNameForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Panel1: TPanel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
     procedure DrawGraphic(GrArray : PGraphicArray);
  public
     Procedure Init;

    { Public declarations }
  end;

var
  GraphNameForm: TGraphNameForm;

implementation

uses Main,  dlgPrintPreview;

{$R *.DFM}

procedure TGraphNameForm.FormShow(Sender: TObject);
begin
  frmMain.FPlatform1.SetParamToGraphicNameWindow;
  if PageControl1.ActivePageIndex = 0 then Chart1.Title.Text.Strings[0]:=' Абонент 1 - ' + Listbox1.Items.Strings[Listbox1.ItemIndex];
  if PageControl1.ActivePageIndex = 1 then Chart1.Title.Text.Strings[0]:=' Абонент 2 - ' + Listbox1.Items.Strings[Listbox1.ItemIndex];
  Left:=frmMain.Width - Width - 2;
  Top:=55;

      Chart1.UndoZoom;
      Chart1.Title.Text.Strings[0]:=' Абонент 1 - ' + Listbox1.Items.Strings[Listbox1.ItemIndex];
      CurrentGraphic:= PGraphicArray(ListBox1.Items.Objects[Listbox1.ItemIndex]);
      DrawGraphic(CurrentGraphic);
end;

procedure TGraphNameForm.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage:=TabSheet1;
  ListBox1.Items.AddObject('Килевая  качка',Pointer(frmMain.FPlatform1.Kachka_Ksi.GrArray));
  ListBox1.Items.AddObject('Бортовая качка',Pointer(frmMain.FPlatform1.Kachka_Teta.GrArray));
  ListBox1.Items.AddObject('--------------',Nil);
  ListBox1.Items.AddObject('Заданный курс',Pointer(frmMain.FPlatform1.k_k_GrArray));
  ListBox1.Items.AddObject('Угол места'   ,Pointer(frmMain.FPlatform1.Eps_C_GrArray));
  ListBox1.Items.AddObject('Рыскание корабля',Pointer(frmMain.FPlatform1.Riskanie_GrArray));
  ListBox1.Items.AddObject('--------------',nil);
  ListBox1.Items.AddObject('Q_k'  ,Pointer(frmMain.FPlatform1.PC1  .GrArray1));
  ListBox1.Items.AddObject('Eps_K',Pointer(frmMain.FPlatform1.PC1  .GrArray2));
  ListBox1.Items.AddObject('--------------', nil);
  ListBox1.Items.AddObject('Привод КУ (выход) ',Pointer(frmMain.FPlatform1.PrivodKU.GrArrayOut));
  ListBox1.Items.AddObject('Привод КУ (ошибка)',Pointer(frmMain.FPlatform1.PrivodKU.GrArrayOshibka));
  ListBox1.Items.AddObject('Привод УM (выход) ',Pointer(frmMain.FPlatform1.PrivodUM.GrArrayOut));
  ListBox1.Items.AddObject('Привод УM (ошибка)',Pointer(frmMain.FPlatform1.PrivodUM.GrArrayOshibka));
  ListBox1.Items.AddObject('--------------', nil);
  ListBox1.Items.AddObject('P_ca'   ,Pointer(frmMain.FPlatform1.PC2.GrArray1));
  ListBox1.Items.AddObject('Eps_ca' ,Pointer(frmMain.FPlatform1.PC2.GrArray2));
  ListBox1.Items.AddObject('Kappa'  ,Pointer(frmMain.FPlatform1.PC2.GrArray3));
  //----------------------------------------------------------------------
  ListBox2.Items.AddObject('Килевая  качка',Pointer(frmMain.FPlatform2.Kachka_Ksi.GrArray));
  ListBox2.Items.AddObject('Бортовая качка',Pointer(frmMain.FPlatform2.Kachka_Teta.GrArray));
  ListBox2.Items.AddObject('--------------',Nil);
  ListBox2.Items.AddObject('Заданный курс',Pointer(frmMain.FPlatform2.k_k_GrArray));
  ListBox2.Items.AddObject('Угол места'   ,Pointer(frmMain.FPlatform2.Eps_C_GrArray));
  ListBox2.Items.AddObject('Рыскание корабля',Pointer(frmMain.FPlatform2.Riskanie_GrArray));
  ListBox2.Items.AddObject('--------------',nil);
  ListBox2.Items.AddObject('Q_k'  ,Pointer(frmMain.FPlatform2.PC1  .GrArray1));
  ListBox2.Items.AddObject('Eps_K',Pointer(frmMain.FPlatform2.PC1  .GrArray2));
  ListBox2.Items.AddObject('--------------', nil);
  ListBox2.Items.AddObject('Привод КУ (выход) ',Pointer(frmMain.FPlatform2.PrivodKU.GrArrayOut));
  ListBox2.Items.AddObject('Привод КУ (ошибка)',Pointer(frmMain.FPlatform2.PrivodKU.GrArrayOshibka));
  ListBox2.Items.AddObject('Привод УM (выход) ',Pointer(frmMain.FPlatform2.PrivodUM.GrArrayOut));
  ListBox2.Items.AddObject('Привод УM (ошибка)',Pointer(frmMain.FPlatform2.PrivodUM.GrArrayOshibka));
  ListBox2.Items.AddObject('--------------', nil);
  ListBox2.Items.AddObject('P_ca'   ,Pointer(frmMain.FPlatform2.PC2.GrArray1));
  ListBox2.Items.AddObject('Eps_ca' ,Pointer(frmMain.FPlatform2.PC2.GrArray2));
  ListBox2.Items.AddObject('Kappa'  ,Pointer(frmMain.FPlatform2.PC2.GrArray3));
end;

procedure TGraphNameForm.Init;
begin
  CurrentGraphic:= frmMain.FPlatform1.Kachka_Ksi.GrArray;
end;

procedure TGraphNameForm.DrawGraphic(GrArray : PGraphicArray);
var
  i : integer;
begin
  Chart1.Series[0].clear;
//  for i:=Round(Chart1.BottomAxis.Minimum*GrTakt) to round(Chart1.BottomAxis.Maximum*GrTakt)-1 do begin

  for i:=0 to round(Chart1.BottomAxis.Maximum*GrTakt)-1 do begin
     if i<= frmMain.FPlatform1.CurrentGraphicPoint-2 then Chart1.Series[0].AddXY(i/GrTakt, GRArray^.PrGr^[i]);
  end;
end;

procedure TGraphNameForm.ListBox1Click(Sender: TObject);
begin
  if Listbox1.Items.Objects[Listbox1.ItemIndex] <> Nil then begin
      Chart1.UndoZoom;
      Chart1.Title.Text.Strings[0]:=' Абонент 1 - ' + Listbox1.Items.Strings[Listbox1.ItemIndex];

      CurrentGraphic:= PGraphicArray(ListBox1.Items.Objects[Listbox1.ItemIndex]);

      DrawGraphic(CurrentGraphic);
  end;
end;


procedure TGraphNameForm.ListBox2Click(Sender: TObject);
begin
  if Listbox2.Items.Objects[Listbox2.ItemIndex] <> Nil then begin
      Chart1.UndoZoom;
      Chart1.Title.Text.Strings[0]:=' Абонент 2 - ' + Listbox2.Items.Strings[Listbox2.ItemIndex];

      CurrentGraphic:= PGraphicArray(ListBox2.Items.Objects[Listbox2.ItemIndex]);
      DrawGraphic(CurrentGraphic);
  end;
end;

procedure TGraphNameForm.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=Tabsheet1 then ListBox1Click(nil);
  if PageControl1.ActivePage=Tabsheet2 then ListBox2Click(nil);
end;

procedure TGraphNameForm.SpeedButton1Click(Sender: TObject);
var
  dlg : TPrintPreviewForm;
begin
 //-
  dlg := TPrintPreviewForm.Create(nil);

  dlg.ListBox1.Items.Assign(ListBox1.Items);
  dlg.ListBox2.Items.Assign(ListBox2.Items);
  dlg.ListBox1.ItemIndex:=0;
  dlg.ListBox2.ItemIndex:=0;

  dlg.ShowModal;
end;

procedure TGraphNameForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frmMain.N20.Checked := False;
end;

end.
