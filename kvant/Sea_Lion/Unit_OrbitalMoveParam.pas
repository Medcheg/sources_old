unit Unit_OrbitalMoveParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, MPIDeclaration;

type
  TfrmOrbitalMoveParam = class(TForm)
    Label14: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Image2: TImage;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label6: TLabel;
    CheckBox2: TCheckBox;
    edC11: TEdit;
    edC12: TEdit;
    edC13: TEdit;
    edOmega11: TEdit;
    edOmega12: TEdit;
    edOmega13: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    CheckBox1: TCheckBox;
    edC21: TEdit;
    edC22: TEdit;
    edC23: TEdit;
    edOmega21: TEdit;
    edOmega22: TEdit;
    edOmega23: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Image3: TImage;
    Label26: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    CheckBox3: TCheckBox;
    edC31: TEdit;
    edC32: TEdit;
    edC33: TEdit;
    edOmega31: TEdit;
    edOmega32: TEdit;
    edOmega33: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
  private
    BaseClass : TBaseClass;
    procedure WrongEdit(Myedit : TEdit);
    procedure SetEnable1(flag : Boolean);
    procedure SetEnable2(flag : Boolean);
    procedure SetEnable3(flag : Boolean);
  public
    { Public declarations }
  end;

var
  frmOrbitalMoveParam: TfrmOrbitalMoveParam;

implementation

uses Unit_Main;

{$R *.DFM}

{ TfrmOrbitalMoveParam }

procedure TfrmOrbitalMoveParam.SetEnable1(flag: Boolean);
begin
 Label14.Enabled := flag;
 Label6 .Enabled := flag;
 Label37.Enabled := flag;
 Label38.Enabled := flag;
 Label39.Enabled := flag;
 Label40.Enabled := flag;
 Label41.Enabled := flag;
 Label42.Enabled := flag;
 Label45.Enabled := flag;
 Label46.Enabled := flag;
 Label21.Enabled := flag;
 Label28.Enabled := flag;
 Label44.Enabled := flag;
 Label43.Enabled := flag;
 Label22.Enabled := flag;
 Label29.Enabled := flag;

 EdC11.Enabled       := flag;
 EdC12.Enabled       := flag;
 EdC13.Enabled       := flag;

 EdOmega11.Enabled   := flag;
 EdOmega12.Enabled   := flag;
 EdOmega13.Enabled   := flag;
end;

procedure TfrmOrbitalMoveParam.SetEnable2(flag: Boolean);
begin
 Label18.Enabled := flag;
 Label7 .Enabled := flag;
 Label8 .Enabled := flag;
 Label9 .Enabled := flag;
 Label10 .Enabled := flag;
 Label11 .Enabled := flag;
 Label12 .Enabled := flag;
 Label1 .Enabled := flag;
 Label16.Enabled := flag;
 Label17.Enabled := flag;
 Label2 .Enabled := flag;
 Label4 .Enabled := flag;
 Label15.Enabled := flag;
 Label13.Enabled := flag;
 Label3 .Enabled := flag;
 Label5 .Enabled := flag;

 EdC21.Enabled       := flag;
 EdC22.Enabled       := flag;
 EdC23.Enabled       := flag;

 EdOmega21.Enabled   := flag;
 EdOmega22.Enabled   := flag;
 EdOmega23.Enabled   := flag;
end;

procedure TfrmOrbitalMoveParam.SetEnable3(flag: Boolean);
begin
 Label48.Enabled := flag;
 Label26.Enabled := flag;
 Label27.Enabled := flag;
 Label30.Enabled := flag;
 Label31.Enabled := flag;
 Label32.Enabled := flag;
 Label33.Enabled := flag;
 Label19.Enabled := flag;
 Label36.Enabled := flag;
 Label47.Enabled := flag;
 Label20.Enabled := flag;
 Label24.Enabled := flag;
 Label35.Enabled := flag;
 Label34.Enabled := flag;
 Label23.Enabled := flag;
 Label25.Enabled := flag;

 EdC31.Enabled       := flag;
 EdC32.Enabled       := flag;
 EdC33.Enabled       := flag;

 EdOmega31.Enabled   := flag;
 EdOmega32.Enabled   := flag;
 EdOmega33.Enabled   := flag;
end;

procedure TfrmOrbitalMoveParam.FormShow(Sender: TObject);
begin
  BaseClass := Form1.Platform;
  CheckBox1.Checked := BaseClass.Orbital_X_Param.Enable;
  CheckBox2.Checked := BaseClass.Orbital_Y_Param.Enable;
  CheckBox3.Checked := BaseClass.Orbital_Z_Param.Enable;

  // ---- 1111111111111111111111111111111111111111111111111111111111111111 ---
      edC11 .Text := floatToStr(BaseClass.Orbital_X_Param.ci[1]*180/pi);
      edC12 .Text := floatToStr(BaseClass.Orbital_X_Param.ci[2]*180/pi);
      edC13 .Text := floatToStr(BaseClass.Orbital_X_Param.ci[3]*180/pi);
  edOmega11 .Text := floatToStr(BaseClass.Orbital_X_Param.omegai[1]);
  edOmega12 .Text := floatToStr(BaseClass.Orbital_X_Param.omegai[2]);
  edOmega13 .Text := floatToStr(BaseClass.Orbital_X_Param.omegai[3]);
  // ---- 2222222222222222222222222222222222222222222222222222222222222222 ---
      edC21 .Text := floatToStr(BaseClass.Orbital_Y_Param.ci[1]*180/pi);
      edC22 .Text := floatToStr(BaseClass.Orbital_Y_Param.ci[2]*180/pi);
      edC23 .Text := floatToStr(BaseClass.Orbital_Y_Param.ci[3]*180/pi);
  edOmega21 .Text := floatToStr(BaseClass.Orbital_Y_Param.omegai[1]);
  edOmega22 .Text := floatToStr(BaseClass.Orbital_Y_Param.omegai[2]);
  edOmega23 .Text := floatToStr(BaseClass.Orbital_Y_Param.omegai[3]);
  // ---- 3333333333333333333333333333333333333333333333333333333333333333 ---
      edC31 .Text := floatToStr(BaseClass.Orbital_Z_Param.ci[1]*180/pi);
      edC32 .Text := floatToStr(BaseClass.Orbital_Z_Param.ci[2]*180/pi);
      edC33 .Text := floatToStr(BaseClass.Orbital_Z_Param.ci[3]*180/pi);
  edOmega31 .Text := floatToStr(BaseClass.Orbital_Z_Param.omegai[1]);
  edOmega32 .Text := floatToStr(BaseClass.Orbital_Z_Param.omegai[2]);
  edOmega33 .Text := floatToStr(BaseClass.Orbital_Z_Param.omegai[3]);

  CheckBoxClick(Self)
end;

procedure TfrmOrbitalMoveParam.WrongEdit(Myedit: TEdit);
begin
  MyEdit.SetFocus;
  MyEdit.SelectAll;
  MessageDLG('Не числовое значение', mtWarning, [mbOk],0);
end;

procedure TfrmOrbitalMoveParam.BitBtn1Click(Sender: TObject);
begin
  try BaseClass.Orbital_X_Param.ci[1]     := StrToFloat(edC11 .Text)     except WrongEdit(edC11); Exit end;
  try BaseClass.Orbital_X_Param.ci[2]     := StrToFloat(edC12 .Text)     except WrongEdit(edC12); Exit end;
  try BaseClass.Orbital_X_Param.ci[3]     := StrToFloat(edC13 .Text)     except WrongEdit(edC13); Exit end;
  try BaseClass.Orbital_X_Param.omegai[1] := StrToFloat(edOmega11 .Text) except WrongEdit(edOmega11); Exit end;
  try BaseClass.Orbital_X_Param.omegai[2] := StrToFloat(edOmega12 .Text) except WrongEdit(edOmega12); Exit end;
  try BaseClass.Orbital_X_Param.omegai[3] := StrToFloat(edOmega13 .Text) except WrongEdit(edOmega13); Exit end;
  BaseClass.Orbital_X_Param.ci[1] := BaseClass.Orbital_X_Param.ci[1] * pi/180;
  BaseClass.Orbital_X_Param.ci[2] := BaseClass.Orbital_X_Param.ci[2] * pi/180;
  BaseClass.Orbital_X_Param.ci[3] := BaseClass.Orbital_X_Param.ci[3] * pi/180;

  try BaseClass.Orbital_Y_Param.ci[1]     := StrToFloat(edC21 .Text)     except WrongEdit(edC21); Exit end;
  try BaseClass.Orbital_Y_Param.ci[2]     := StrToFloat(edC22 .Text)     except WrongEdit(edC22); Exit end;
  try BaseClass.Orbital_Y_Param.ci[3]     := StrToFloat(edC23 .Text)     except WrongEdit(edC23); Exit end;
  try BaseClass.Orbital_Y_Param.omegai[1] := StrToFloat(edOmega21 .Text) except WrongEdit(edOmega21); Exit end;
  try BaseClass.Orbital_Y_Param.omegai[2] := StrToFloat(edOmega22 .Text) except WrongEdit(edOmega22); Exit end;
  try BaseClass.Orbital_Y_Param.omegai[3] := StrToFloat(edOmega23 .Text) except WrongEdit(edOmega23); Exit end;
  BaseClass.Orbital_Y_Param.ci[1] := BaseClass.Orbital_Y_Param.ci[1] * pi/180;
  BaseClass.Orbital_Y_Param.ci[2] := BaseClass.Orbital_Y_Param.ci[2] * pi/180;
  BaseClass.Orbital_Y_Param.ci[3] := BaseClass.Orbital_Y_Param.ci[3] * pi/180;

  try BaseClass.Orbital_Z_Param.ci[1]     := StrToFloat(edC21 .Text)     except WrongEdit(edC31); Exit end;
  try BaseClass.Orbital_Z_Param.ci[2]     := StrToFloat(edC22 .Text)     except WrongEdit(edC32); Exit end;
  try BaseClass.Orbital_Z_Param.ci[3]     := StrToFloat(edC23 .Text)     except WrongEdit(edC33); Exit end;
  try BaseClass.Orbital_Z_Param.omegai[1] := StrToFloat(edOmega21 .Text) except WrongEdit(edOmega31); Exit end;
  try BaseClass.Orbital_Z_Param.omegai[2] := StrToFloat(edOmega22 .Text) except WrongEdit(edOmega32); Exit end;
  try BaseClass.Orbital_Z_Param.omegai[3] := StrToFloat(edOmega23 .Text) except WrongEdit(edOmega33); Exit end;
  BaseClass.Orbital_Z_Param.ci[1] := BaseClass.Orbital_Z_Param.ci[1] * pi/180;
  BaseClass.Orbital_Z_Param.ci[2] := BaseClass.Orbital_Z_Param.ci[2] * pi/180;
  BaseClass.Orbital_Z_Param.ci[3] := BaseClass.Orbital_Z_Param.ci[3] * pi/180;

  BaseClass.Orbital_X_Param.Enable := CheckBox1.Checked;
  BaseClass.Orbital_Y_Param.Enable := CheckBox2.Checked;
  BaseClass.Orbital_Z_Param.Enable := CheckBox3.Checked;

  close;
end;

procedure TfrmOrbitalMoveParam.CheckBoxClick(Sender: TObject);
begin
 if CheckBox1.Checked then SetEnable1(true)
                      else SetEnable1(false);
 if CheckBox2.Checked then SetEnable2(true)
                      else SetEnable2(false);
 if CheckBox3.Checked then SetEnable3(true)
                      else SetEnable3(false);
end;

end.
