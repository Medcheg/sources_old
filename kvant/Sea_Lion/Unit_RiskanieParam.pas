unit Unit_RiskanieParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmRiskanieParam = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label21: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Image2: TImage;
    Label18: TLabel;
    Label19: TLabel;
    Label41: TLabel;
    Label44: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    CheckBox2: TCheckBox;
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
  frmRiskanieParam: TfrmRiskanieParam;

implementation

uses Unit_Main;

{$R *.DFM}

procedure TfrmRiskanieParam.FormShow(Sender: TObject);
begin
 edit1.Text := FloatToStr(Form1.Platform.RiskanieParam.fi[1]*180/pi);
 edit2.Text := FloatToStr(Form1.Platform.RiskanieParam.omega[1]);
 edit3.Text := FloatToStr(Form1.Platform.RiskanieParam.fi[2]*180/pi);
 edit4.Text := FloatToStr(Form1.Platform.RiskanieParam.omega[2]);
 CheckBox1.Checked := Form1.Platform.RiskanieParam.Enable;

 edit5.Text := FloatToStr(Form1.Platform.DeltaRiskanieParam.fi[1]*180/pi*60);
 edit6.Text := FloatToStr(Form1.Platform.DeltaRiskanieParam.omega[1]);
 edit7.Text := FloatToStr(Form1.Platform.DeltaRiskanieParam.fi[2]*180/pi*60);
 edit8.Text := FloatToStr(Form1.Platform.DeltaRiskanieParam.omega[2]);
 CheckBox2.Checked := Form1.Platform.DeltaRiskanieParam.Enable;

  CheckBox1Click(Self)
end;

procedure TfrmRiskanieParam.BitBtn1Click(Sender: TObject);
begin
 Form1.Platform.RiskanieParam.Enable     := CheckBox1.Checked;
 try Form1.Platform.RiskanieParam.fi[1]    := StrToFloat(Edit1.Text) except Edit1.setfocus; Edit1.SelectAll; exit; end;
 try Form1.Platform.RiskanieParam.omega[1] := StrToFloat(Edit2.Text) except Edit2.setfocus; Edit2.SelectAll; exit; end;
 try Form1.Platform.RiskanieParam.fi[2]    := StrToFloat(Edit3.Text) except Edit3.setfocus; Edit3.SelectAll; exit; end;
 try Form1.Platform.RiskanieParam.omega[2] := StrToFloat(Edit4.Text) except Edit4.setfocus; Edit4.SelectAll; exit; end;

 Form1.Platform.DeltaRiskanieParam.Enable     := CheckBox2.Checked;
 try Form1.Platform.DeltaRiskanieParam.fi[1]    := StrToFloat(Edit5.Text) except Edit5.setfocus; Edit5.SelectAll; exit; end;
 try Form1.Platform.DeltaRiskanieParam.omega[1] := StrToFloat(Edit6.Text) except Edit6.setfocus; Edit6.SelectAll; exit; end;
 try Form1.Platform.DeltaRiskanieParam.fi[2]    := StrToFloat(Edit7.Text) except Edit7.setfocus; Edit7.SelectAll; exit; end;
 try Form1.Platform.DeltaRiskanieParam.omega[2] := StrToFloat(Edit8.Text) except Edit8.setfocus; Edit8.SelectAll; exit; end;

 Form1.Platform.RiskanieParam.fi[1]      := Form1.Platform.RiskanieParam.fi[1]     *pi/180;
 Form1.Platform.RiskanieParam.fi[2]      := Form1.Platform.RiskanieParam.fi[2]     *pi/180;
 Form1.Platform.DeltaRiskanieParam.fi[1] := Form1.Platform.DeltaRiskanieParam.fi[1]*pi/180/60;
 Form1.Platform.DeltaRiskanieParam.fi[2] := Form1.Platform.DeltaRiskanieParam.fi[2]*pi/180/60;
 close;
end;

procedure TfrmRiskanieParam.SetEnable1(flag: Boolean);
begin
  Label21.Enabled := flag;
  Label18.Enabled := flag;

  Label50.Enabled := flag;
  Label41.Enabled := flag;
  Label37.Enabled := flag;
  Label38.Enabled := flag;
  Label51.Enabled := flag;
  Label44.Enabled := flag;
  Label46.Enabled := flag;
  Label52.Enabled := flag;
  Label48.Enabled := flag;
  Label42.Enabled := flag;
  Label43.Enabled := flag;
  Label53.Enabled := flag;
  Label49.Enabled := flag;
  Label19.Enabled := flag;
  Label39.Enabled := flag;
  Label47.Enabled := flag;
  Label45.Enabled := flag;

  Edit1.Enabled := flag;
  Edit2.Enabled := flag;
  Edit3.Enabled := flag;
  Edit4.Enabled := flag;
end;

procedure TfrmRiskanieParam.SetEnable2(flag: Boolean);
begin
  Label1.Enabled := flag;
  Label16.Enabled := flag;

  Label5 .Enabled := flag;
  Label2 .Enabled := flag;
  Label3 .Enabled := flag;
  Label17.Enabled := flag;
  Label12.Enabled := flag;
  Label20.Enabled := flag;
  Label9 .Enabled := flag;
  Label10.Enabled := flag;
  Label22.Enabled := flag;
  Label7 .Enabled := flag;
  Label8 .Enabled := flag;
  Label14.Enabled := flag;
  Label15.Enabled := flag;
  Label6 .Enabled := flag;
  Label4 .Enabled := flag;
  Label13.Enabled := flag;
  Label1.Enabled := flag;

  Edit5.Enabled := flag;
  Edit6.Enabled := flag;
  Edit7.Enabled := flag;
  Edit8.Enabled := flag;
end;

procedure TfrmRiskanieParam.CheckBox1Click(Sender: TObject);
begin
 if CheckBox1.Checked then SetEnable1(true)
                      else SetEnable1(False);
 if CheckBox2.Checked then SetEnable2(true)
                      else SetEnable2(False);
end;

end.
