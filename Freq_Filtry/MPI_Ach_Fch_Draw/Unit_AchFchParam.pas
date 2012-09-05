unit Unit_AchFchParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Spin, Menus, ImgList;

type
  TfrmAchFchParam = class(TForm)
    Label1: TLabel;
    edBeginFreq: TEdit;
    Label2: TLabel;
    edEndFreq: TEdit;
    CheckBox2: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label5: TLabel;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Panel2: TPanel;
    PaintBox2: TPaintBox;
    Label11: TLabel;
    SpinEdit2: TSpinEdit;
    Panel4: TPanel;
    Bevel1: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Panel3: TPanel;
    PaintBox1: TPaintBox;
    Label8: TLabel;
    SpinEdit1: TSpinEdit;
    Panel5: TPanel;
    ColorDialog1: TColorDialog;
    PopupMenu1: TPopupMenu;
    fg1: TMenuItem;
    N1: TMenuItem;
    N4: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    ImageList1: TImageList;
    procedure BitBtn1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox2Paint(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox2Click(Sender: TObject);
    procedure fg2(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAchFchParam: TfrmAchFchParam;

implementation

uses Unit_Main, MPI_Library, MPI_Ach_Fch_Draw;

{$R *.DFM}

procedure TfrmAchFchParam.FormCreate(Sender: TObject);
begin
  AchFchParam.BeginFreq := StrToFloat(edBeginFreq.text);
  AchFchParam.EndFreq   := StrToFloat(edendFreq  .text);
  
  Panel1.Color                := Rgb(212, 208, 200);
  AchFchParam.BackGroundColor := Rgb(212, 208, 200);

  Panel5.Color         := clRed;
  AchFchParam.AchColor := clRed;

  Panel4.Color         := clYellow;
  AchFchParam.FchColor := clYellow;

  AchFchParam.AchPenWidth := 2;
  SpinEdit1.Value         := AchFchParam.AchPenWidth;
  AchFchParam.FchPenWidth := 2;
  SpinEdit2.Value         := AchFchParam.FchPenWidth;

  AchFchParam.AchPenStyle := psSolid;
  AchFchParam.FchPenStyle := psSolid;

  AchFchParam.AchEnabled := CheckBox4.Checked;
  AchFchParam.FchEnabled := CheckBox5.Checked;
  AchFchParam.t0Enabled  := CheckBox2.Checked;
end;

procedure TfrmAchFchParam.PaintBox1Paint(Sender: TObject);
var
 cy  : Integer;
begin
  cy := PaintBox1.Height div 2;
  With PaintBox1.Canvas do begin
     Brush.Color := Color;
     Pen.Color   := clBlack;
     Pen.Width   := 1;
     Pen.Style   := psSolid;
     Rectangle(0, 0, PaintBox1.Width, PaintBox1.Height);

     Pen.Color := AchFchParam.AchColor;
     Pen.Style := AchFchParam.AchPenStyle;
     Pen.Width := AchFchParam.AchPenWidth;
     MoveTo(2, cy - 1); LineTo(PaintBox1.Width-2, cy - 1);
     MoveTo(2, cy - 0); LineTo(PaintBox1.Width-2, cy - 0);
     MoveTo(2, cy + 1); LineTo(PaintBox1.Width-2, cy + 1);
  end;
end;

procedure TfrmAchFchParam.PaintBox2Paint(Sender: TObject);
var
 cy  : Integer;
begin
  cy := PaintBox2.Height div 2;
  With PaintBox2.Canvas do begin
     Brush.Color := Color;
     Pen.Color   := clBlack;
     Pen.Width   := 1;
     Pen.Style   := psSolid;
     Rectangle(0, 0, PaintBox2.Width, PaintBox2.Height);

     Pen.Color := AchFchParam.FchColor;
     Pen.Style := AchFchParam.FchPenStyle;
     Pen.Width := AchFchParam.FchPenWidth;
     MoveTo(2, cy - 1); LineTo(PaintBox2.Width-2, cy - 1);
     MoveTo(2, cy - 0); LineTo(PaintBox2.Width-2, cy - 0);
     MoveTo(2, cy + 1); LineTo(PaintBox2.Width-2, cy + 1);
  end;
end;

procedure TfrmAchFchParam.Panel1Click(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
     Panel1.Color                := ColorDialog1.Color;
     AchFchParam.BackGroundColor := ColorDialog1.Color;
  end;
end;

procedure TfrmAchFchParam.Panel5Click(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
     Panel5.Color         := ColorDialog1.Color;
     AchFchParam.AchColor := ColorDialog1.Color;
  end;
  PaintBox1.Repaint;
end;

procedure TfrmAchFchParam.Panel4Click(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
     Panel4.Color         := ColorDialog1.Color;
     AchFchParam.FchColor := ColorDialog1.Color;
  end;
  PaintBox2.Repaint;
end;

procedure TfrmAchFchParam.SpinEdit1Change(Sender: TObject);
begin
  AchFchParam.AchPenWidth := SpinEdit1.Value;
end;

procedure TfrmAchFchParam.SpinEdit2Change(Sender: TObject);
begin
  AchFchParam.FchPenWidth := SpinEdit2.Value;
end;

procedure TfrmAchFchParam.PaintBox1Click(Sender: TObject);
var
  CurPoint    : TPoint;
begin
      CurPoint.X := Panel3.Left;
      CurPoint.Y := Panel3.Top + Panel3.Height+1;
      CurPoint   := ClientToScreen(CurPoint);
      PopUpMenu1.Popup(CurPoint.X, CurPoint.Y);
end;

procedure TfrmAchFchParam.PaintBox2Click(Sender: TObject);
var
  CurPoint    : TPoint;
begin
      CurPoint.X := Panel2.Left;
      CurPoint.Y := Panel2.Top + Panel2.Height+1;
      CurPoint   := ClientToScreen(CurPoint);
      PopUpMenu2.Popup(CurPoint.X, CurPoint.Y);
end;

procedure TfrmAchFchParam.fg2(Sender: TObject);
begin
  Case TComponent(Sender).tag of
    0 : AchFchParam.AchPenStyle := psSolid;
    1 : AchFchParam.AchPenStyle := psDash;
    2 : AchFchParam.AchPenStyle := psDot;
    3 : AchFchParam.AchPenStyle := psDashDot;
    4 : AchFchParam.AchPenStyle := psDashDotDot;
  end;
  if (AchFchParam.AchPenWidth <> 1) and (AchFchParam.AchPenStyle <> psSolid) then AchFchParam.AchPenWidth := 1;

  SpinEdit1.Value := AchFchParam.AchPenWidth;
  PaintBox1.Repaint;
end;

procedure TfrmAchFchParam.MenuItem1Click(Sender: TObject);
begin
  Case TComponent(Sender).tag of
    0 : AchFchParam.FchPenStyle := psSolid;
    1 : AchFchParam.FchPenStyle := psDash;
    2 : AchFchParam.FchPenStyle := psDot;
    3 : AchFchParam.FchPenStyle := psDashDot;
    4 : AchFchParam.FchPenStyle := psDashDotDot;
  end;
  if (AchFchParam.FchPenWidth <> 1) and (AchFchParam.FchPenStyle <> psSolid) then AchFchParam.FchPenWidth := 1;

  SpinEdit2.Value := AchFchParam.FchPenWidth;
  PaintBox2.Repaint;
end;

procedure TfrmAchFchParam.BitBtn1Click(Sender: TObject);
var
  Finish : Boolean;
begin
  Finish := True;

  try AchFchParam.BeginFreq := StrToFloat(edBeginFreq.text) except ShowWrongEdit(edBeginFreq); Finish := False; end;
  try AchFchParam.EndFreq   := StrToFloat(edendFreq  .text) except ShowWrongEdit(edEndFreq  ); Finish := False; end;

  AchFchParam.AchEnabled := CheckBox4.Checked;
  AchFchParam.FchEnabled := CheckBox5.Checked;
  AchFchParam.t0Enabled  := CheckBox2.Checked;

  if Finish then begin
     Ach_Fch_Draw();
     close
  end;
end;

end.
