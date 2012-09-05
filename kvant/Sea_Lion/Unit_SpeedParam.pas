unit Unit_SpeedParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TfrmSpeedParam = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
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
    edB31: TEdit;
    edB32: TEdit;
    edB33: TEdit;
    edOmega31: TEdit;
    edOmega32: TEdit;
    edOmega33: TEdit;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
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
  frmSpeedParam: TfrmSpeedParam;

implementation

Uses Unit_Main;//MPIDeclaration;

{$R *.DFM}

procedure TfrmSpeedParam.FormShow(Sender: TObject);
begin
 edit1.Text := FloatToStr(Form1.Platform.SpeedParam.B0*180/pi);
 edit2.Text := FloatToStr(Form1.Platform.SpeedParam.B1*180/pi);
 edit3.Text := FloatToStr(Form1.Platform.SpeedParam.B2*180/pi);


 edB31.Text := FloatToStr(Form1.Platform.DeltaSpeedParam.b3i[1]*60*180/pi);
 edB32.Text := FloatToStr(Form1.Platform.DeltaSpeedParam.b3i[2]*60*180/pi);
 edB33.Text := FloatToStr(Form1.Platform.DeltaSpeedParam.b3i[3]*60*180/pi);

 edOmega31.Text := FloatToStr(Form1.Platform.DeltaSpeedParam.Omega3i[1]);
 edOmega32.Text := FloatToStr(Form1.Platform.DeltaSpeedParam.Omega3i[2]);
 edOmega33.Text := FloatToStr(Form1.Platform.DeltaSpeedParam.Omega3i[3]);

 CheckBox1.Checked := Form1.Platform.SpeedParam.Enable;
 CheckBox2.Checked := Form1.Platform.DeltaSpeedParam.Enable;

 CheckBox1Click(Self)
end;

procedure TfrmSpeedParam.BitBtn1Click(Sender: TObject);
begin
 Form1.Platform.SpeedParam.Enable := CheckBox1.Checked;
 try Form1.Platform.SpeedParam.B0 := StrToFloat(Edit1.Text) except Edit1.setfocus; Edit1.SelectAll; exit; end;
 try Form1.Platform.SpeedParam.B1 := StrToFloat(Edit2.Text) except Edit2.setfocus; Edit2.SelectAll; exit; end;
 try Form1.Platform.SpeedParam.B2 := StrToFloat(Edit3.Text) except Edit3.setfocus; Edit3.SelectAll; exit; end;

 Form1.Platform.DeltaSpeedParam.Enable     := CheckBox2.Checked;
 try Form1.Platform.DeltaSpeedParam.B3i[1] := StrToFloat(edB31.Text) except edB31.setfocus; edB31.SelectAll; exit; end;
 try Form1.Platform.DeltaSpeedParam.B3i[2] := StrToFloat(edB32.Text) except edB32.setfocus; edB32.SelectAll; exit; end;
 try Form1.Platform.DeltaSpeedParam.B3i[3] := StrToFloat(edB33.Text) except edB33.setfocus; edB33.SelectAll; exit; end;

 try Form1.Platform.DeltaSpeedParam.Omega3i[1] := StrToFloat(edOmega31.Text) except edOmega31.setfocus; edOmega31.SelectAll; exit; end;
 try Form1.Platform.DeltaSpeedParam.Omega3i[2] := StrToFloat(edOmega32.Text) except edOmega32.setfocus; edOmega32.SelectAll; exit; end;
 try Form1.Platform.DeltaSpeedParam.Omega3i[3] := StrToFloat(edOmega33.Text) except edOmega33.setfocus; edOmega33.SelectAll; exit; end;


 Form1.Platform.SpeedParam.B0          := Form1.Platform.SpeedParam.B0*pi/180;
 Form1.Platform.SpeedParam.B1          := Form1.Platform.SpeedParam.B1*pi/180;
 Form1.Platform.SpeedParam.B2          := Form1.Platform.SpeedParam.B2*pi/180;
 Form1.Platform.DeltaSpeedParam.b3i[1] := Form1.Platform.DeltaSpeedParam.b3i[1]*pi/180/60;
 Form1.Platform.DeltaSpeedParam.b3i[2] := Form1.Platform.DeltaSpeedParam.b3i[2]*pi/180/60;
 Form1.Platform.DeltaSpeedParam.b3i[3] := Form1.Platform.DeltaSpeedParam.b3i[3]*pi/180/60;

 close;
end;

procedure TfrmSpeedParam.SetEnable1(flag: Boolean);
begin
  Label1.Enabled := flag;
  Label2.Enabled := flag;
  Label4.Enabled := flag;
  Label5.Enabled := flag;
  Label7.Enabled := flag;
  Label10.Enabled := flag;
  Label11.Enabled := flag;
  Label20.Enabled := flag;
  Label31.Enabled := flag;
  Label32.Enabled := flag;

  Edit1.Enabled := flag;
  Edit2.Enabled := flag;
  Edit3.Enabled := flag;
end;

procedure TfrmSpeedParam.SetEnable2(flag : boolean);
begin
  Label8 .Enabled:= flag;

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

  edB31.Enabled  := flag;
  edB32.Enabled  := flag;
  edB33.Enabled  := flag;

  edOmega31.Enabled  := flag;
  edOmega32.Enabled  := flag;
  edOmega33.Enabled  := flag;
end;

procedure TfrmSpeedParam.CheckBox1Click(Sender: TObject);
begin
 if CheckBox1.Checked then SetEnable1(true)
                      else SetEnable1(False);
 if CheckBox2.Checked then SetEnable2(true)
                      else SetEnable2(False);
end;

end.
