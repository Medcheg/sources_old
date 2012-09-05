unit dlgPrintPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, TeEngine, Series, TeeProcs, Chart;

type
  TPrintPreviewForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ListBox1: TListBox;
    TabSheet2: TTabSheet;
    ListBox2: TListBox;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
     procedure DrawGraphic(GrArray : Pointer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintPreviewForm: TPrintPreviewForm;

implementation

uses DeclPasha, Main, Printers;

{$R *.DFM}

procedure TPrintPreviewForm.DrawGraphic(GrArray : Pointer);
var
//  i : integer;
  Count        : Integer;
begin
  Chart1.Series[0].clear;
  Count:=0;
  repeat
     Chart1.Series[0].AddXY(Count/GrTakt, PGraphicArray(GRArray)^.PrGr^[Count]);
    inc(count);
  until Count>=frmMain.FPlatform1.CurrentGraphicPoint;

end;

procedure TPrintPreviewForm.FormShow(Sender: TObject);
begin
   PageControl1.ActivePage:=TabSheet1;
   Chart1.UndoZoom;
   Chart1.Title.Text.Strings[0]:=' Абонент 1 - ' + Listbox1.Items.Strings[0];
   DrawGraphic(Listbox1.Items.Objects[0]);
end;

procedure TPrintPreviewForm.ListBox1Click(Sender: TObject);
begin
  if Listbox1.Items.Objects[Listbox1.ItemIndex] <> Nil then begin
      Chart1.UndoZoom;
      Chart1.Title.Text.Strings[0]:=' Абонент 1 - ' + Listbox1.Items.Strings[Listbox1.ItemIndex];
      DrawGraphic(Listbox1.Items.Objects[Listbox1.ItemIndex]);
  end;
end;

procedure TPrintPreviewForm.ListBox2Click(Sender: TObject);
begin
  if Listbox2.Items.Objects[Listbox2.ItemIndex] <> Nil then begin
      Chart1.UndoZoom;
      Chart1.Title.Text.Strings[0]:=' Абонент 2 - ' + Listbox2.Items.Strings[Listbox2.ItemIndex];
      DrawGraphic(Listbox2.Items.Objects[Listbox2.ItemIndex]);
  end;
end;

procedure TPrintPreviewForm.BitBtn3Click(Sender: TObject);
begin
   PrinterSetupDialog1.Execute;
end;

procedure TPrintPreviewForm.BitBtn1Click(Sender: TObject);
const
  otstup = 15;
var
  MyRect : TRect;
begin
  Printer.Orientation:=poLandscape;
  MyRect.Top     := Round(otstup/100*printer.PageHeight);
  MyRect.Left    := Round(otstup/100*printer.PageWidth);
  MyRect.Bottom  := Round((1-otstup/100)*printer.PageHeight);
  MyRect.Right   := Round((1-otstup/100)*printer.PageWidth);
  Chart1.Series[0].SeriesColor:=clblack;
  Chart1.PrintRect(MyRect);
  Chart1.Series[0].SeriesColor:=ClRed;
end;

end.
