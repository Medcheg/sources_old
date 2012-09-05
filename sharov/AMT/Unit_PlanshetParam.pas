unit Unit_PlanshetParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, ExtCtrls, ImgList, Menus;

type
  TfrmPlanshetParam = class(TForm)
    sePoleCount: TSpinEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    SpinEdit2: TSpinEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    Label4: TLabel;
    Bevel2: TBevel;
    panelLineStyle1: TPanel;
    PaintBox1: TPaintBox;
    Label7: TLabel;
    Label9: TLabel;
    panelLineStyle2: TPanel;
    PaintBox2: TPaintBox;
    Bevel1: TBevel;
    PopupMenu1: TPopupMenu;
    fg1: TMenuItem;
    N1: TMenuItem;
    N4: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ImageList1: TImageList;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    SpinEdit3: TSpinEdit;
    procedure sePoleCountChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox2Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure abcColorComboBox1Change(Sender: TObject);
    procedure abcColorComboBox2Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
  private
    procedure Set_1Pole();
    procedure Set_2Pole();
    procedure Set_3Pole();
  public
    procedure Set_ChartParam();
    procedure Set_FormParams();
  end;

var
  frmPlanshetParam        : TfrmPlanshetParam;

implementation

uses Unit_Main, Unit_PlanshetCreator, MPIDeclaration, Unit_SaveType;

{$R *.DFM}

procedure TfrmPlanshetParam.sePoleCountChange(Sender: TObject);
begin
   ChartParam.PolesCount := sePoleCount.Value;
   case sePoleCount.Value of
     0 : Form1.PanelChart.Visible := False;
     1 : Set_1Pole();
     2 : Set_2Pole();
     3 : Set_3Pole();
   end;
   Set_ChartParam();
   PaintBox1.Repaint;
   PaintBox2.Repaint;
end;

procedure TfrmPlanshetParam.Set_1Pole();
begin
  Form1.PanelChart.Visible := True;
  Form1.PanelPole1.Visible := True;
  Form1.PanelPole2.Visible := False;
  Form1.PanelPole3.Visible := False;

  Form1.PanelPole1.Align := alClient;
  Form1.Chart1.BottomAxis.Labels := true;
  Form1.Chart1.BottomAxis.Grid.Visible := False;


  frmPlanshetCreator.BitBtn1.Left := 224;
  frmPlanshetCreator.BitBtn2.Left := 304;
  frmPlanshetCreator.Width := 389;
  frmPlanshetCreator.left  := (Screen.Width - frmPlanshetCreator.Width) div 2;

  Form1.ChartArray[1,1].Repaint;
  Form1.ChartArray[1,2].Repaint;
end;

procedure TfrmPlanshetParam.Set_2Pole();
begin
  Form1.PanelChart.Visible := True;
  Form1.PanelPole1.Visible := True;
  Form1.PanelPole2.Visible := True;
  Form1.PanelPole3.Visible := False;

  Form1.PanelPole1.Align := alTop;
  Form1.PanelPole2.Align := alClient;

  Form1.PanelPole1.Height := (Form1.PanelChart.Height - Form1.ScrollBar1.Height) div 2;
  Form1.Chart1.BottomAxis.Labels := False;
  Form1.Chart3.BottomAxis.LabelsFont.Color := clBlack;

  frmPlanshetCreator.BitBtn1.Left := 224;
  frmPlanshetCreator.BitBtn2.Left := 456;
  frmPlanshetCreator.Width        := 547;
  frmPlanshetCreator.left         := (Screen.Width - frmPlanshetCreator.Width) div 2;

  Form1.ChartArray[1,1].Repaint;
  Form1.ChartArray[2,1].Repaint;
  Form1.ChartArray[1,2].Repaint;
  Form1.ChartArray[2,2].Repaint;
end;

procedure TfrmPlanshetParam.Set_3Pole();
begin
  Form1.ScrollBar1.top := 2000;

  Form1.PanelChart.Visible := True;
  Form1.PanelPole1.Visible := True;
  Form1.PanelPole2.Visible := True;
  Form1.PanelPole3.Visible := True;

  Form1.PanelPole3.Align   := alNone;

  Form1.PanelPole1.Align := alTop;
  Form1.PanelPole2.Align := alClient;
  Form1.PanelPole3.Align := alBottom;

  //Form1.ScrollBar1.top := 2000;
//  Form1.ScrollBar1.Visible := False;
//  Form1.ScrollBar1.Visible := true;
//  Form1.ScrollBar1.align   := alBottom;

  Form1.PanelPole1.Height := (Form1.PanelChart.Height - Form1.ScrollBar1.Height) div 3;
  Form1.PanelPole2.Height := (Form1.PanelChart.Height - Form1.ScrollBar1.Height) div 3;
  Form1.PanelPole3.Height := (Form1.PanelChart.Height - Form1.ScrollBar1.Height) div 3;

  Form1.Chart1.BottomAxis.Labels := False;
  Form1.Chart3.BottomAxis.LabelsFont.Color := clBtnFace;
  //Form1.Chart3.BottomAxis.Labels := False;
  Form1.Chart5.BottomAxis.Labels := true;

  frmPlanshetCreator.BitBtn1.Left := 224;
  frmPlanshetCreator.BitBtn2.Left := 621;
  frmPlanshetCreator.Width        := 710;
  frmPlanshetCreator.left         := (Screen.Width - frmPlanshetCreator.Width) div 2;

  Form1.ChartArray[1,1].Repaint;
  Form1.ChartArray[2,1].Repaint;
  Form1.ChartArray[3,1].Repaint;
  Form1.ChartArray[1,2].Repaint;
  Form1.ChartArray[2,2].Repaint;
  Form1.ChartArray[3,2].Repaint;
end;


procedure TfrmPlanshetParam.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmPlanshetParam.PaintBox1Click(Sender: TObject);
var
  CurPoint    : TPoint;
begin
      CurPoint.X := panelLineStyle1.Left;
      CurPoint.Y := panelLineStyle1.Top + panelLineStyle1.Height+1;
      CurPoint   := ClientToScreen(CurPoint);
      PopUpMenu1.Popup(CurPoint.X, CurPoint.Y);
end;

procedure TfrmPlanshetParam.PaintBox2Click(Sender: TObject);
var
  CurPoint    : TPoint;
begin
      CurPoint.X := panelLineStyle2.Left;
      CurPoint.Y := panelLineStyle2.Top + panelLineStyle2.Height+1;
      CurPoint   := ClientToScreen(CurPoint);
      PopUpMenu2.Popup(CurPoint.X, CurPoint.Y);
end;

procedure TfrmPlanshetParam.PaintBox1Paint(Sender: TObject);
begin
  With PaintBox1.Canvas do begin
     Pen.Style := ChartParam.MainLine_PenStyle;
     Pen.Color := ChartParam.MainLine_PenColor;
     MoveTo (1,                   (PaintBox1.Height div 2 )-1);
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )-1);
     MoveTo (1,                   (PaintBox1.Height div 2 )  );
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )  );
     MoveTo (1,                   (PaintBox1.Height div 2 )+1);
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )+1);
  end;
end;

procedure TfrmPlanshetParam.PaintBox2Paint(Sender: TObject);
begin
  With PaintBox2.Canvas do begin
     Pen.Style := ChartParam.NotMainLine_PenStyle;
     Pen.Color := ChartParam.NotMainLine_PenColor;
     MoveTo (1,                   (PaintBox1.Height div 2 )-1);
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )-1);
     MoveTo (1,                   (PaintBox1.Height div 2 )  );
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )  );
     MoveTo (1,                   (PaintBox1.Height div 2 )+1);
     LineTo (PaintBox1.Width-1,   (PaintBox1.Height div 2 )+1);
  end;
end;

procedure TfrmPlanshetParam.N1Click(Sender: TObject);
begin
  Case TComponent(Sender).tag of
    0 : ChartParam.MainLine_PenStyle := psSolid;
    1 : ChartParam.MainLine_PenStyle := psDash;
    2 : ChartParam.MainLine_PenStyle := psDot;
    3 : ChartParam.MainLine_PenStyle := psDashDot;
    4 : ChartParam.MainLine_PenStyle := psDashDotDot;
  end;
  sePoleCountChange(self);
end;

procedure TfrmPlanshetParam.MenuItem2Click(Sender: TObject);
begin
  Case TComponent(Sender).tag of
    0 : ChartParam.NotMainLine_PenStyle := psSolid;
    1 : ChartParam.NotMainLine_PenStyle := psDash;
    2 : ChartParam.NotMainLine_PenStyle := psDot;
    3 : ChartParam.NotMainLine_PenStyle := psDashDot;
    4 : ChartParam.NotMainLine_PenStyle := psDashDotDot;
  end;
  sePoleCountChange(self);
end;

procedure TfrmPlanshetParam.abcColorComboBox1Change(Sender: TObject);
begin
  sePoleCountChange(self);
end;

procedure TfrmPlanshetParam.abcColorComboBox2Change(Sender: TObject);
begin
  sePoleCountChange(self);
end;

procedure TfrmPlanshetParam.SpinEdit1Change(Sender: TObject);
var
  i                : Integer;
begin
  Try
      ChartParam.CountMinInOneSantimetr := SpinEdit1.Value;
  except
  end;
  if Form1.Chart1.BottomAxis.IEndPos - Form1.Chart1.BottomAxis.IStartPos <> 0 then
     ChartParam.MaxSmInChart   := (Form1.Chart1.BottomAxis.IEndPos - Form1.Chart1.BottomAxis.IStartPos)/PixelsPerInch*SmPerInch;
  ChartParam.MaxVisibleTimeOnChart := (ChartParam.MaxSmInChart*ChartParam.CountMinInOneSantimetr*60)*TimeInOneSecond;

  for i:=1 to 3 do begin
    //Form1.ChartArray[i,1].BottomAxis.Maximum := Form1.ChartArray[i,1].BottomAxis.Minimum + ChartParam.MaxVisibleTimeOnChart;
    //Form1.ChartArray[i,1].TopAxis   .Maximum := Form1.ChartArray[i,1].BottomAxis.Maximum
    Form1.ChartArray[i,1].BottomAxis.SetMinMax(Form1.ChartArray[i,1].BottomAxis.Minimum,Form1.ChartArray[i,1].BottomAxis.Minimum + ChartParam.MaxVisibleTimeOnChart);
    Form1.ChartArray[i,1].TopAxis   .SetMinMax(Form1.ChartArray[i,1].TopAxis   .Minimum,Form1.ChartArray[i,1].TopAxis   .Minimum + Form1.ChartArray[i,1].BottomAxis.Maximum);
  end;
  Set_ChartParam();
  PaintBox1.Repaint;
  PaintBox2.Repaint;
end;

procedure TfrmPlanshetParam.SpinEdit2Change(Sender: TObject);
var
  flag : boolean;
  i    : Integer;
begin
  ChartParam.BottomAxis_MinorGridStep  := SpinEdit2.Value;
  flag := True;
  if SpinEdit2.Value = 0 then Flag := False;

  for i:=1 to 3 do begin
    Form1.ChartArray[i,1].BottomAxis.MinorGrid.Visible := Flag;
    Form1.ChartArray[i,1].TopAxis   .MinorGrid.Visible := Flag;

    Form1.ChartArray[i,1].BottomAxis.MinorTickCount := ChartParam.BottomAxis_MinorGridStep;
    Form1.ChartArray[i,1].TopAxis   .MinorTickCount := ChartParam.BottomAxis_MinorGridStep;
  end;
  sePoleCountChange(self);
end;

procedure TfrmPlanshetParam.SpinEdit3Change(Sender: TObject);
var
  i    : integer;
  flag : Boolean;
begin
  ChartParam.BottomAxis_GridStep := SpinEdit3.Value;
  flag                           := True;
  if ChartParam.BottomAxis_GridStep = 0 then Flag := False;


  for i:=1 to 3 do begin
    Form1.ChartArray[i,1].BottomAxis.Grid.Visible := Flag;
    Form1.ChartArray[i,1].TopAxis   .Grid.Visible := Flag;
    Form1.ChartArray[i,1].TopAxis   .Increment    := ChartParam.BottomAxis_GridStep/100*ChartParam.MaxVisibleTimeOnChart;
    Form1.ChartArray[i,1].BottomAxis.Increment    := ChartParam.BottomAxis_GridStep/100*ChartParam.MaxVisibleTimeOnChart;
  end;
  sePoleCountChange(self);
end;

procedure TfrmPlanshetParam.SpinEdit4Change(Sender: TObject);
var
  i    : integer;
  flag : Boolean;
begin
  ChartParam.LeftAxis_GridStep       := SpinEdit4.Value;
  flag                               := True;
  if ChartParam.LeftAxis_GridStep = 0 then Flag := False;

  for i:=1 to 3 do begin
    Form1.ChartArray[i,1].LeftAxis  .Grid.Visible := Flag;
    Form1.ChartArray[i,1].LeftAxis.Increment := ChartParam.LeftAxis_GridStep/100;
  end;
  sePoleCountChange(self);
end;

procedure TfrmPlanshetParam.SpinEdit5Change(Sender: TObject);
var
  flag : boolean;
  i    : Integer;
begin
  ChartParam.LeftAxis_MinorGridStep  := SpinEdit5.Value;
  flag := True;
  if SpinEdit5.Value = 0 then Flag := False;

  for i:=1 to 3 do begin
    Form1.ChartArray[i,1].LeftAxis.MinorGrid.Visible := Flag;
    Form1.ChartArray[i,1].LeftAxis.MinorTickCount    := ChartParam.LeftAxis_MinorGridStep;
  end;
  sePoleCountChange(self);
end;

procedure TfrmPlanshetParam.Set_FormParams();
begin
   sePoleCount.Value               := ChartParam.PolesCount;

   SpinEdit1.Value                 := ChartParam.CountMinInOneSantimetr;
   SpinEdit2.Value                 := ChartParam.BottomAxis_MinorGridStep;
   SpinEdit3.Value                 := ChartParam.BottomAxis_GridStep;
   SpinEdit4.Value                 := ChartParam.LeftAxis_GridStep;
   SpinEdit5.Value                 := ChartParam.LeftAxis_MinorGridStep;

end;

procedure TfrmPlanshetParam.Set_ChartParam();
var
  i : integer;
begin
   ChartParam.  MaxVisibleTimeOnChart := (ChartParam.MaxSmInChart*ChartParam.CountMinInOneSantimetr*60)*TimeInOneSecond;
   ChartParam.OldScaledMaxVisibleTime := ChartParam.MaxVisibleTimeOnChart;
   ChartParam.   ScaledMaxVisibleTime := ChartParam.MaxVisibleTimeOnChart;

      for i:=1 to 3 do begin
        Form1.ChartArray[i,1].BottomAxis.Grid.Color := ChartParam.MainLine_PenColor;
        Form1.ChartArray[i,1].TopAxis   .Grid.Color := ChartParam.MainLine_PenColor;
        Form1.ChartArray[i,1].LeftAxis  .Grid.Color := ChartParam.MainLine_PenColor;

        Form1.ChartArray[i,1].BottomAxis.Grid.Style := ChartParam.MainLine_PenStyle;
        Form1.ChartArray[i,1].TopAxis   .Grid.Style := ChartParam.MainLine_PenStyle;
        Form1.ChartArray[i,1].LeftAxis  .Grid.Style := ChartParam.MainLine_PenStyle;

        Form1.ChartArray[i,1].BottomAxis.MinorGrid.Style := ChartParam.NotMainLine_PenStyle;
        Form1.ChartArray[i,1].TopAxis   .MinorGrid.Style := ChartParam.NotMainLine_PenStyle;
        Form1.ChartArray[i,1].LeftAxis  .MinorGrid.Style := ChartParam.NotMainLine_PenStyle;

        Form1.ChartArray[i,1].BottomAxis.MinorGrid.Color := ChartParam.NotMainLine_PenColor;
        Form1.ChartArray[i,1].TopAxis   .MinorGrid.Color := ChartParam.NotMainLine_PenColor;
        Form1.ChartArray[i,1].LeftAxis  .MinorGrid.Color := ChartParam.NotMainLine_PenColor;

        Form1.ChartArray[i,1].BottomAxis.Maximum := Form1.ChartArray[i,1].BottomAxis.Minimum + ChartParam.MaxVisibleTimeOnChart;
        Form1.ChartArray[i,1].TopAxis   .Maximum := Form1.ChartArray[i,1].TopAxis.Minimum    + ChartParam.MaxVisibleTimeOnChart;

        Form1.ChartArray[i,1].BottomAxis.Increment := ChartParam.BottomAxis_GridStep/100*ChartParam.MaxVisibleTimeOnChart;
        Form1.ChartArray[i,1].TopAxis   .Increment := ChartParam.BottomAxis_GridStep/100*ChartParam.MaxVisibleTimeOnChart;
        Form1.ChartArray[i,1].LeftAxis  .Increment := ChartParam.LeftAxis_GridStep/100;

        Form1.ChartArray[i,1].LeftAxis  .MinorTickCount := ChartParam.LeftAxis_MinorGridStep  ;
        Form1.ChartArray[i,1].BottomAxis.MinorTickCount := ChartParam.BottomAxis_MinorGridStep;
        Form1.ChartArray[i,1].TopAxis   .MinorTickCount := ChartParam.BottomAxis_MinorGridStep;
      end;
   Application.ProcessMessages;
end;

begin
  ChartParam.MainLine_PenStyle       := psSolid;
  ChartParam.MainLine_PenColor       := clGray;
  ChartParam.NotMainLine_PenStyle    := psDot;
  ChartParam.NotMainLine_PenColor    := clGray;
end.
