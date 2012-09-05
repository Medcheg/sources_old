unit Unit_PrintPartialSeries;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, TeEngine, Series, TeeProcs, Chart, ExtCtrls, MPIDeclaration,
  Spin, Printers;

type
  TfrmPrintPartialSeries = class(TForm)
    Panel11: TPanel;
    Chart1: TChart;
    Series1: TFastLineSeries;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    se111: TSpinEdit;
    se222: TSpinEdit;
    se333: TSpinEdit;
    se444: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel111: TPanel;
    Panel222: TPanel;
    Panel333: TPanel;
    PrintDialog1: TPrintDialog;
    procedure Label2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure seChange(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    MySeries    : TMySeries;
    FirstPoint  : Integer;
    SecondPoint : Integer;
    MyRect      : Trect;
    Procedure Transfer;
  public
     procedure Set_Param(aSeries : TMySeries; aFirstPoint, aSecondPoint : integer);
  end;

var
  frmPrintPartialSeries: TfrmPrintPartialSeries;

implementation

uses Unit_HeadingOfTheDiagram;

{$R *.DFM}

procedure TfrmPrintPartialSeries.Set_Param(aSeries: TMySeries;
  aFirstPoint, aSecondPoint: integer);
begin
  FirstPoint  := aFirstPoint;
  SecondPoint := aSecondPoint;
  MySeries    := ASeries;
  Edit1.text  := MySeries.Name;
end;


procedure TfrmPrintPartialSeries.Label2Click(Sender: TObject);
begin
  CheckBox1.Checked := not CheckBox1.Checked;
end;

procedure TfrmPrintPartialSeries.FormShow(Sender: TObject);
var
  i : integer;
begin
 Edit2Change(Self);
 seChange(Self);
 Chart1.Series[0].Clear;
 Chart1.UndoZoom;
 for i:=FirstPoint to SecondPoint do
   Chart1.series[0].addXY(MySeries.TimeData[i] - MySeries.TimeData[FirstPoint] ,MySeries.Data[i])
   
end;

procedure TfrmPrintPartialSeries.Edit1Change(Sender: TObject);
begin
  Chart1.Title.Text.Strings[0] := Edit1.Text;
end;

procedure TfrmPrintPartialSeries.Edit2Change(Sender: TObject);
begin
  Chart1.LeftAxis.Title.Caption := Edit2.Text;
end;

procedure TfrmPrintPartialSeries.seChange(Sender: TObject);
begin
    Panel222.Visible:=False;
    Transfer;
    Panel222.Visible:=True;
end;

procedure TfrmPrintPartialSeries.Transfer;
begin
   try MyRect.Top    := StrToInt(se111.text); except end;
   try MyRect.Left  := StrToInt(se222.text); except end;
   try MyRect.Bottom  := StrToInt(se333.text); except end;
   try MyRect.Right := StrToInt(se444.text); except end;
   Panel222.Left:=(Panel111.Width  div 2) - (Panel222.Width div 2);
   Panel222.Top:= (Panel111.Height div 2) - (Panel222.Height div 2);
   Panel333.top:= Round(Panel222.Height*MyRect.Top/100);
   Panel333.Height := Round(Panel222.Height*(1-(MyRect.Top+MyRect.Bottom)/100));
   Panel333.left   := Round((Panel222.Width*MyRect.left/100));
   Panel333.Width  := Round(Panel222.width*(1-(MyRect.left+MyRect.Right)/100));
end;

procedure TfrmPrintPartialSeries.RadioButton1Click(Sender: TObject);
var    prom : integer;
begin
  if radiobutton1.checked then begin
    Panel222.Visible:=False;
    Prom:=Panel222.Width;
    Panel222.Width:=Panel222.Height;
    Panel222.Height:=Prom;
    Transfer;
    Panel222.Visible:=True;
  end;
end;

procedure TfrmPrintPartialSeries.RadioButton2Click(Sender: TObject);
var    prom : integer;
begin
  if radiobutton2.checked then begin
    Panel222.Visible:=False;
    Prom          := Panel222.Width;
    Panel222.Width  := Panel222.Height;
    Panel222.Height := Prom;
    Transfer;
    Panel222.Visible:=True;
  end;
end;

procedure TfrmPrintPartialSeries.BitBtn1Click(Sender: TObject);
var
 BitmapIn  : TBitmap;
 BitMapTemp : TBitMap;
begin
  if PrintDialog1.Execute then begin
       Printer.Orientation:=poLandscape;
      /// --- Печать заголовка диаграммы ---
      //if checkBox1.Checked then begin
        frmHeadingOfTheDiagram.AutoSize       := True;
        frmHeadingOfTheDiagram.AutoScroll     := False;
        frmHeadingOfTheDiagram.Width          := 662;
        BitmapIn  := frmHeadingOfTheDiagram.GetFormImage;

        BitMapTemp := TBitmap.Create;

        BitMapTemp.Width  := Trunc(Printer.PageWidth*0.50);
        BitMapTemp.Height := Trunc(Printer.PageHeight*0.97);
        BitMapTemp.PixelFormat := pf4bit;


        BitMapTemp.Canvas.StretchDraw(Rect(Trunc(Printer.PageWidth*0.09),
                                           Trunc(Printer.PageHeight*0.03),
                                           Trunc(Printer.PageWidth*0.50),
                                           Trunc(Printer.PageHeight*0.97)), BitmapIn);

      Printer.BeginDoc;

      {Printer.Canvas.StretchDraw(Rect(Trunc(Printer.PageWidth*0.09),
                                      Trunc(Printer.PageHeight*0.03),
                                      Trunc(Printer.PageWidth*0.50),
                                      Trunc(Printer.PageHeight*0.97)), BitmapIn);}

      Printer.Canvas.Draw(0,0,BitmapTemp);

       { for i:=0 to BitMapTemp.Width-1 do
           for k:=0 to BitMapTemp.Height - 1 do
              Printer.Canvas.Pixels[i,k] := BitMapTemp.Canvas.Pixels[i,k];}

      /// ---- Отпечаток сериии ------
      MyRect.Top   :=  1;
      MyRect.left   := 51;
      MyRect.Right  := 1;
      MyRect.Bottom := 1;
      //if radiobutton1.Checked then Printer.Orientation:=poPortrait;
      //if radiobutton2.Checked then Printer.Orientation:=poLandscape;
      MyRect.Top     := Round(MyRect.Top/100*printer.PageHeight);
      MyRect.Left    := Round(MyRect.left/100*printer.PageWidth);
      MyRect.Bottom  := Round((1-MyRect.Bottom/100)*printer.PageHeight);
      MyRect.Right   := Round((1-MyRect.Right/100)*printer.PageWidth);
      Chart1.PrintPartial(MyRect);
      Printer.EndDoc;

      BitMapTemp.Free;
  end;
  close;
end;

end.
