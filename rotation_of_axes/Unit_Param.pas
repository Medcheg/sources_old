unit Unit_Param;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, ExtCtrls;

type
  TfrmParam = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    SpinEdit2: TSpinEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit1: TSpinEdit;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParam: TfrmParam;

implementation

uses Unit_Main;

{$R *.DFM}

procedure TfrmParam.FormShow(Sender: TObject);
begin
   SpinEdit1.Value := frmMain.MainLineWidth;
   SpinEdit2.Value := frmMain.MinorLineWidth;
   SpinEdit3.Value := frmMain.RotationAngle;

   CheckBox1.Checked := frmMain.ArrowEnabled
end;

procedure TfrmParam.SpinEdit1Change(Sender: TObject);
begin
   frmMain.MainLineWidth  := SpinEdit1.Value;

   frmMain.CreateList();
   frmMain.Draw_GL();
end;

procedure TfrmParam.SpinEdit2Change(Sender: TObject);
begin
   frmMain.MinorLineWidth := SpinEdit2.Value;

   frmMain.CreateList();
   frmMain.Draw_GL();
end;

procedure TfrmParam.SpinEdit3Change(Sender: TObject);
begin
   frmMain.RotationAngle  := SpinEdit3.Value;
   
   if frmParam.RadioGroup1.ItemIndex = 1 then frmMain.ang1 :=  frmMain.RotationAngle;
   if frmParam.RadioGroup1.ItemIndex = 0 then frmMain.ang1 := -frmMain.RotationAngle;
   if frmParam.RadioGroup2.ItemIndex = 1 then frmMain.ang2 :=  frmMain.RotationAngle;
   if frmParam.RadioGroup2.ItemIndex = 0 then frmMain.ang2 := -frmMain.RotationAngle;
   if frmParam.RadioGroup3.ItemIndex = 1 then frmMain.ang3 :=  frmMain.RotationAngle;
   if frmParam.RadioGroup3.ItemIndex = 0 then frmMain.ang3 := -frmMain.RotationAngle;

   frmMain.CreateList();
   frmMain.Draw_GL();
end;

procedure TfrmParam.CheckBox1Click(Sender: TObject);
begin
   frmMain.ArrowEnabled := CheckBox1.Checked;

   frmMain.CreateList();
   frmMain.Draw_GL();
end;

procedure TfrmParam.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmParam.RadioButton1Click(Sender: TObject);
begin
   frmMain.Coef := 1;
   frmMain.y.y := L;
   frmMain.CreateList();
   frmMain.Draw_GL();
end;

procedure TfrmParam.RadioButton2Click(Sender: TObject);
begin
   frmMain.Coef := -1;
   frmMain.y.y := -L;
   frmMain.CreateList();
   frmMain.Draw_GL();
end;

procedure TfrmParam.RadioGroup1Click(Sender: TObject);
begin
   if frmParam.RadioGroup1.ItemIndex = 1 then frmMain.ang1 :=  frmMain.RotationAngle;
   if frmParam.RadioGroup1.ItemIndex = 0 then frmMain.ang1 := -frmMain.RotationAngle;

   frmMain.CreateList();
   frmMain.Draw_GL();
end;

procedure TfrmParam.RadioGroup2Click(Sender: TObject);
begin
   if frmParam.RadioGroup2.ItemIndex = 1 then frmMain.ang2 :=  frmMain.RotationAngle;
   if frmParam.RadioGroup2.ItemIndex = 0 then frmMain.ang2 := -frmMain.RotationAngle;

   frmMain.CreateList();
   frmMain.Draw_GL();
end;

procedure TfrmParam.RadioGroup3Click(Sender: TObject);
begin
   if frmParam.RadioGroup3.ItemIndex = 1 then frmMain.ang3 :=  frmMain.RotationAngle;
   if frmParam.RadioGroup3.ItemIndex = 0 then frmMain.ang3 := -frmMain.RotationAngle;

   frmMain.CreateList();
   frmMain.Draw_GL();
end;

end.
