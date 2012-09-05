unit Unit_SpatialWave;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, MPIDeclaration;

type
  TfrmSpatialWave = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label51: TLabel;                                
    Label52: TLabel;
    Bevel1: TBevel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    CheckBox1: TCheckBox;
    Bevel2: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Image2: TImage;
    CheckBox2: TCheckBox;
    Image1: TImage;
    Label11: TLabel;
    Label12: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    CheckBox3: TCheckBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    CheckBox4: TCheckBox;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    procedure SetEnable1(flag : Boolean);
    procedure SetEnable2(flag : Boolean);
    procedure SetEnableDelta1(flag : Boolean);
    procedure SetEnableDelta2(flag : Boolean);
  public
    Kachka      : TKachka;
    DeltaKachka : TKachka;
    procedure SetParam(aCaption : String;aKachka : TKachka; aDeltaKachka : TKachka);
  end;

var
  frmSpatialWave: TfrmSpatialWave;

implementation

{$R *.DFM}

procedure TfrmSpatialWave.SetParam(aCaption : String;aKachka : TKachka; aDeltaKachka : TKachka);
begin
 Caption      := aCaption;
 Kachka       := aKachka;
 DeltaKachka  := aDeltaKachka;

 Edit1.Text := FloatToStr(Kachka.A[1]*180/pi);
 Edit5.Text := FloatToStr(Kachka.A[2]*180/pi);
 Edit9.Text := FloatToStr(Kachka.A[3]*180/pi);

 Edit2 .Text := FloatToStr(Kachka.Alfa[1]);
 Edit6 .Text := FloatToStr(Kachka.Alfa[2]);
 Edit10.Text := FloatToStr(Kachka.Alfa[3]);

 Edit3 .Text := FloatToStr(Kachka.f[1]);
 Edit7 .Text := FloatToStr(Kachka.f[2]);
 Edit11.Text := FloatToStr(Kachka.f[3]);

 Edit4 .Text := FloatToStr(Kachka.Fi[1]);
 Edit8 .Text := FloatToStr(Kachka.Fi[2]);
 Edit12.Text := FloatToStr(Kachka.Fi[3]);

 Edit13.Text := FloatToStr(Kachka.A_);
 Edit14.Text := FloatToStr(Kachka.mju_);
 Edit15.Text := FloatToStr(Kachka.lambda_);
 CheckBox1.Checked := Kachka.Enable;
 CheckBox2.Checked := Kachka.Enable_;


 Edit16.Text := FloatToStr(DeltaKachka.A[1]*60*180/pi);
 Edit20.Text := FloatToStr(DeltaKachka.A[2]*60*180/pi);
 Edit24.Text := FloatToStr(DeltaKachka.A[3]*60*180/pi);

 Edit17.Text := FloatToStr(DeltaKachka.Alfa[1]);
 Edit21.Text := FloatToStr(DeltaKachka.Alfa[2]);
 Edit25.Text := FloatToStr(DeltaKachka.Alfa[3]);

 Edit18.Text := FloatToStr(DeltaKachka.f[1]);
 Edit22.Text := FloatToStr(DeltaKachka.f[2]);
 Edit26.Text := FloatToStr(DeltaKachka.f[3]);

 Edit19.Text := FloatToStr(DeltaKachka.Fi[1]);
 Edit23.Text := FloatToStr(DeltaKachka.Fi[2]);
 Edit27.Text := FloatToStr(DeltaKachka.Fi[3]);

 Edit28.Text := FloatToStr(DeltaKachka.A_);
 Edit29.Text := FloatToStr(DeltaKachka.mju_);
 Edit30.Text := FloatToStr(DeltaKachka.lambda_);
 CheckBox3.Checked := DeltaKachka.Enable;
 CheckBox4.Checked := DeltaKachka.Enable_;

 CheckBox1Click(Self)
end;

procedure TfrmSpatialWave.BitBtn1Click(Sender: TObject);
begin
 Kachka.Enable  := CheckBox1.Checked;
 Kachka.Enable_ := CheckBox2.Checked;

 try Kachka.A   [1] :=  StrToFloat(Edit1.Text ) except Edit1.setfocus; Edit1.SelectAll; exit; end;
 try Kachka.Alfa[1] :=  StrToFloat(Edit2 .Text) except Edit2.setfocus; Edit2.SelectAll; exit; end;
 try Kachka.f   [1] :=  StrToFloat(Edit3 .Text) except Edit3.setfocus; Edit3.SelectAll; exit; end;
 try Kachka.Fi  [1] :=  StrToFloat(Edit4 .Text) except Edit4.setfocus; Edit4.SelectAll; exit; end;

 try Kachka.A   [2] :=  StrToFloat(Edit5.Text ) except Edit5.setfocus; Edit5.SelectAll; exit; end;
 try Kachka.Alfa[2] :=  StrToFloat(Edit6 .Text) except Edit6.setfocus; Edit6.SelectAll; exit; end;
 try Kachka.f   [2] :=  StrToFloat(Edit7 .Text) except Edit7.setfocus; Edit7.SelectAll; exit; end;
 try Kachka.Fi  [2] :=  StrToFloat(Edit8 .Text) except Edit8.setfocus; Edit8.SelectAll; exit; end;

 try Kachka.A   [3] :=  StrToFloat(Edit9.Text ) except Edit9.setfocus; Edit9.SelectAll; exit; end;
 try Kachka.Alfa[3] :=  StrToFloat(Edit10.Text) except Edit10.setfocus; Edit10.SelectAll; exit; end;
 try Kachka.f   [3] :=  StrToFloat(Edit11.Text) except Edit11.setfocus; Edit11.SelectAll; exit; end;
 try Kachka.Fi  [3] :=  StrToFloat(Edit12.Text) except Edit12.setfocus; Edit12.SelectAll; exit; end;

 try Kachka.A_      :=  StrToFloat(Edit13.Text) except Edit13.setfocus; Edit13.SelectAll; exit; end;
 try Kachka.mju_    :=  StrToFloat(Edit14.Text) except Edit14.setfocus; Edit14.SelectAll; exit; end;
 try Kachka.lambda_ :=  StrToFloat(Edit15.Text) except Edit15.setfocus; Edit15.SelectAll; exit; end;

 DeltaKachka.Enable  := CheckBox3.Checked;
 DeltaKachka.Enable_ := CheckBox4.Checked;

 try DeltaKachka.A   [1] :=  StrToFloat(Edit16.Text) except Edit16.setfocus; Edit16.SelectAll; exit; end;
 try DeltaKachka.Alfa[1] :=  StrToFloat(Edit17.Text) except Edit17.setfocus; Edit17.SelectAll; exit; end;
 try DeltaKachka.f   [1] :=  StrToFloat(Edit18.Text) except Edit18.setfocus; Edit18.SelectAll; exit; end;
 try DeltaKachka.Fi  [1] :=  StrToFloat(Edit19.Text) except Edit19.setfocus; Edit19.SelectAll; exit; end;

 try DeltaKachka.A   [2] :=  StrToFloat(Edit20.Text) except Edit20.setfocus; Edit20.SelectAll; exit; end;
 try DeltaKachka.Alfa[2] :=  StrToFloat(Edit21.Text) except Edit21.setfocus; Edit21.SelectAll; exit; end;
 try DeltaKachka.f   [2] :=  StrToFloat(Edit22.Text) except Edit22.setfocus; Edit22.SelectAll; exit; end;
 try DeltaKachka.Fi  [2] :=  StrToFloat(Edit23.Text) except Edit23.setfocus; Edit23.SelectAll; exit; end;

 try DeltaKachka.A   [3] :=  StrToFloat(Edit24.Text) except Edit24.setfocus; Edit24.SelectAll; exit; end;
 try DeltaKachka.Alfa[3] :=  StrToFloat(Edit25.Text) except Edit25.setfocus; Edit25.SelectAll; exit; end;
 try DeltaKachka.f   [3] :=  StrToFloat(Edit26.Text) except Edit26.setfocus; Edit26.SelectAll; exit; end;
 try DeltaKachka.Fi  [3] :=  StrToFloat(Edit27.Text) except Edit27.setfocus; Edit27.SelectAll; exit; end;

 try DeltaKachka.A_      :=  StrToFloat(Edit28.Text) except Edit28.setfocus; Edit28.SelectAll; exit; end;
 try DeltaKachka.mju_    :=  StrToFloat(Edit29.Text) except Edit29.setfocus; Edit29.SelectAll; exit; end;
 try DeltaKachka.lambda_ :=  StrToFloat(Edit30.Text) except Edit30.setfocus; Edit30.SelectAll; exit; end;

 Kachka.A[1]      := Kachka.A[1]*pi/180;
 Kachka.A[2]      := Kachka.A[1]*pi/180;
 Kachka.A[3]      := Kachka.A[1]*pi/180;
 DeltaKachka.A[1] := DeltaKachka.A[1]*pi/180/60;
 DeltaKachka.A[2] := DeltaKachka.A[1]*pi/180/60;
 DeltaKachka.A[3] := DeltaKachka.A[1]*pi/180/60;

 close;
end;

procedure TfrmSpatialWave.SetEnable1(flag: Boolean);
begin
  Label1 .Enabled := flag;
  Label2 .Enabled := flag;
  Label3 .Enabled := flag;
  Label4 .Enabled := flag;
  Label5 .Enabled := flag;
  Label6 .Enabled := flag;
  Label7 .Enabled := flag;
  Label51.Enabled := flag;
  Label52.Enabled := flag;

  Edit1 .Enabled := flag;
  Edit2 .Enabled := flag;
  Edit3 .Enabled := flag;
  Edit4 .Enabled := flag;
  Edit5 .Enabled := flag;
  Edit6 .Enabled := flag;
  Edit7 .Enabled := flag;
  Edit8 .Enabled := flag;
  Edit9 .Enabled := flag;
  Edit10.Enabled := flag;
  Edit11.Enabled := flag;
  Edit12.Enabled := flag;
end;

procedure TfrmSpatialWave.SetEnable2(flag: Boolean);
begin
  Label8 .Enabled := flag;
  Label9 .Enabled := flag;
  Label10.Enabled := flag;
  Label22.Enabled := flag;
  Label23.Enabled := flag;
  Label24.Enabled := flag;
  Edit13.Enabled := flag;
  Edit14.Enabled := flag;
  Edit15.Enabled := flag;
end;

procedure TfrmSpatialWave.SetEnableDelta1(flag: Boolean);
begin
  Label13.Enabled := flag;
  Label14.Enabled := flag;
  Label15.Enabled := flag;
  Label16.Enabled := flag;
  Label17.Enabled := flag;
  Label18.Enabled := flag;
  Label19.Enabled := flag;
  Label20.Enabled := flag;
  Label21.Enabled := flag;

  Edit16.Enabled := flag;
  Edit17.Enabled := flag;
  Edit18.Enabled := flag;
  Edit19.Enabled := flag;
  Edit20.Enabled := flag;
  Edit21.Enabled := flag;
  Edit22.Enabled := flag;
  Edit23.Enabled := flag;
  Edit24.Enabled := flag;
  Edit25.Enabled := flag;
  Edit26.Enabled := flag;
  Edit27.Enabled := flag;
end;

procedure TfrmSpatialWave.SetEnableDelta2(flag: Boolean);
begin
  Label25.Enabled := flag;
  Label26.Enabled := flag;
  Label27.Enabled := flag;
  Label28.Enabled := flag;
  Label29.Enabled := flag;
  Label30.Enabled := flag;
  Edit28.Enabled := flag;
  Edit29.Enabled := flag;
  Edit30.Enabled := flag;
end;

procedure TfrmSpatialWave.CheckBox1Click(Sender: TObject);
begin
 if CheckBox1.Checked then SetEnable1(true)
                      else SetEnable1(False);
 if CheckBox2.Checked then SetEnable2(true)
                      else SetEnable2(False);
 if CheckBox3.Checked then SetEnableDelta1(true)
                      else SetEnableDelta1(False);
 if CheckBox4.Checked then SetEnableDelta2(true)
                      else SetEnableDelta2(False);
end;

end.
