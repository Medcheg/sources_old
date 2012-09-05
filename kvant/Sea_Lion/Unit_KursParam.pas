unit Unit_KursParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TfrmKursParam = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label20: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    Label14: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    CheckBox2: TCheckBox;
    Image2: TImage;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    edC31: TEdit;
    edC32: TEdit;
    edC33: TEdit;
    edOmega31: TEdit;
    edOmega32: TEdit;
    edOmega33: TEdit;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label6: TLabel;
    Bevel3: TBevel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    procedure SetEnable1(flag : Boolean);
    procedure SetEnable2(flag : Boolean);
  public
    { Public declarations }
  end;

var
  frmKursParam: TfrmKursParam;

implementation

uses Unit_Main;

{$R *.DFM}

procedure TfrmKursParam.FormShow(Sender: TObject);
begin
 edit1.Text := FloatToStr(Form1.Platform.KkParam.c0*180/pi);
 edit2.Text := FloatToStr(Form1.Platform.KkParam.c1*180/pi);
 edit3.Text := FloatToStr(Form1.Platform.KkParam.c2*180/pi);

 edC31.Text := FloatToStr(Form1.Platform.DeltaKkParam.c3i[1]*60*180/pi);
 edC32.Text := FloatToStr(Form1.Platform.DeltaKkParam.c3i[2]*60*180/pi);
 edC33.Text := FloatToStr(Form1.Platform.DeltaKkParam.c3i[3]*60*180/pi);

 edOmega31.Text := FloatToStr(Form1.Platform.DeltaKkParam.Omega3i[1]);
 edOmega32.Text := FloatToStr(Form1.Platform.DeltaKkParam.Omega3i[2]);
 edOmega33.Text := FloatToStr(Form1.Platform.DeltaKkParam.Omega3i[3]);

 CheckBox1.Checked := Form1.Platform.KkParam.Enable;
 CheckBox2.Checked := Form1.Platform.DeltaKkParam.Enable;
 CheckBox1Click(Self)
end;

procedure TfrmKursParam.BitBtn1Click(Sender: TObject);
begin
 Form1.Platform.KkParam.Enable    := CheckBox1.Checked;
 try Form1.Platform.KkParam.C0    := StrToFloat(Edit1.Text) except Edit1.setfocus; Edit1.SelectAll; exit; end;
 try Form1.Platform.KkParam.C1    := StrToFloat(Edit2.Text) except Edit2.setfocus; Edit2.SelectAll; exit; end;
 try Form1.Platform.KkParam.C2    := StrToFloat(Edit3.Text) except Edit3.setfocus; Edit3.SelectAll; exit; end;

 Form1.Platform.DeltaKkParam.Enable     := CheckBox2.Checked;
 try Form1.Platform.DeltaKkParam.C3i[1] := StrToFloat(edC31.Text) except edC31.setfocus; edC31.SelectAll; exit; end;
 try Form1.Platform.DeltaKkParam.C3i[2] := StrToFloat(edC32.Text) except edC32.setfocus; edC32.SelectAll; exit; end;
 try Form1.Platform.DeltaKkParam.C3i[3] := StrToFloat(edC33.Text) except edC33.setfocus; edC33.SelectAll; exit; end;

 try Form1.Platform.DeltaKkParam.Omega3i[1] := StrToFloat(edOmega31.Text) except edOmega31.setfocus; edOmega31.SelectAll; exit; end;
 try Form1.Platform.DeltaKkParam.Omega3i[2] := StrToFloat(edOmega32.Text) except edOmega32.setfocus; edOmega32.SelectAll; exit; end;
 try Form1.Platform.DeltaKkParam.Omega3i[3] := StrToFloat(edOmega33.Text) except edOmega33.setfocus; edOmega33.SelectAll; exit; end;

 Form1.Platform.KkParam.c0          := Form1.Platform.KkParam.c0*pi/180;
 Form1.Platform.KkParam.c1          := Form1.Platform.KkParam.c1*pi/180;
 Form1.Platform.KkParam.c2          := Form1.Platform.KkParam.c2*pi/180;
 Form1.Platform.DeltaKkParam.c3i[1] := Form1.Platform.DeltaKkParam.c3i[1]*pi/180/60;
 Form1.Platform.DeltaKkParam.c3i[2] := Form1.Platform.DeltaKkParam.c3i[2]*pi/180/60;
 Form1.Platform.DeltaKkParam.c3i[3] := Form1.Platform.DeltaKkParam.c3i[3]*pi/180/60;
 close;
end;

procedure TfrmKursParam.SetEnable1(flag: Boolean);
begin
  Label4 .Enabled := flag;
  Label1 .Enabled := flag;
  Label2 .Enabled := flag;
  Label3 .Enabled := flag;
  Label20.Enabled := flag;

  Label7 .Enabled := flag;
  Label8 .Enabled := flag;
  Label9 .Enabled := flag;
  Label31.Enabled := flag;

  Label10.Enabled := flag;
  Label11.Enabled := flag;
  Label12.Enabled := flag;
  Label32.Enabled := flag;

  Edit1.Enabled := flag;
  Edit2.Enabled := flag;
  Edit3.Enabled := flag;
end;

procedure TfrmKursParam.SetEnable2(flag: Boolean);
begin
  Label6 .Enabled:= flag;

  Label40.Enabled:= flag;
  Label41.Enabled:= flag;
  Label42.Enabled:= flag;

  Label14.Enabled:= flag;
  Label45.Enabled:= flag;
  Label46.Enabled:= flag;

  Label21.Enabled:= flag;
  Label28.Enabled:= flag;
  Label44.Enabled:= flag;

  Label43.Enabled:= flag;
  Label22.Enabled:= flag;
  Label29.Enabled:= flag;

  Label37.Enabled:= flag;
  Label38.Enabled:= flag;
  Label39.Enabled:= flag;

  edC31.Enabled  := flag;
  edC32.Enabled  := flag;
  edC33.Enabled  := flag;

  edOmega31.Enabled  := flag;
  edOmega32.Enabled  := flag;
  edOmega33.Enabled  := flag;
end;

procedure TfrmKursParam.CheckBox1Click(Sender: TObject);
begin
 if CheckBox1.Checked then SetEnable1(true)
                      else SetEnable1(False);
 if CheckBox2.Checked then SetEnable2(true)
                      else SetEnable2(False);
end;

end.
