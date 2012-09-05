unit Unit_ObjectParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfrmObjectParam = class(TForm)
    eJ11: TEdit;
    eJ12: TEdit;
    eJ13: TEdit;
    eJ21: TEdit;
    eJ22: TEdit;
    eJ23: TEdit;
    eJ31: TEdit;
    eJ32: TEdit;
    eJ33: TEdit;
    eAlfa0Pos: TEdit;
    eAlfa0Speed: TEdit;
    eBetta0Pos: TEdit;
    eBetta0Speed: TEdit;
    eGamma0Pos: TEdit;
    eGamma0Speed: TEdit;
    eF1: TEdit;
    eM1: TEdit;
    eF2: TEdit;
    eM2: TEdit;
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
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmObjectParam: TfrmObjectParam;

implementation

uses Unit_Main;

{$R *.DFM}

procedure ShowWrongEdit(Edit : TEdit);
begin
  Beep;
  Edit.SetFocus;
  Edit.SelectAll;
  MessageDlg('Введено не числове значення !!!', mtError, [mbOk],0);
end;

procedure TfrmObjectParam.FormShow(Sender: TObject);
begin
    eJ11.Text := FloatToStr(frmMain.j[0,0]);
    eJ12.Text := FloatToStr(frmMain.j[0,1]);
    eJ13.Text := FloatToStr(frmMain.j[0,2]);
    eJ21.Text := FloatToStr(frmMain.j[1,0]);
    eJ22.Text := FloatToStr(frmMain.j[1,1]);
    eJ23.Text := FloatToStr(frmMain.j[1,2]);
    eJ31.Text := FloatToStr(frmMain.j[2,0]);
    eJ32.Text := FloatToStr(frmMain.j[2,1]);
    eJ33.Text := FloatToStr(frmMain.j[2,2]);

    eAlfa0Pos   .Text := FloatToStr(frmMain.alfa0.pos  *180/pi);
    eBetta0Pos  .Text := FloatToStr(frmMain.betta0.pos *180/pi);
    eGamma0Pos  .Text := FloatToStr(frmMain.gamma0.pos *180/pi);

    eAlfa0Speed .Text := FloatToStr(frmMain.alfa0 .speed *180/pi);
    eBetta0Speed.Text := FloatToStr(frmMain.betta0.speed *180/pi);
    eGamma0Speed.Text := FloatToStr(frmMain.gamma0.speed *180/pi);

    eF1.Text := FloatToStr(frmMain.f1);
    eF2.Text := FloatToStr(frmMain.f2);

    eM1.Text := FloatToStr(frmMain.m1);
    eM2.Text := FloatToStr(frmMain.m2);
end;

procedure TfrmObjectParam.BitBtn1Click(Sender: TObject);
begin
  try frmMain.j[0,0] := StrToFloat(eJ11.Text) except ShowWrongEdit(eJ11); exit end;
  try frmMain.j[0,1] := StrToFloat(eJ12.Text) except ShowWrongEdit(eJ12); exit end;
  try frmMain.j[0,2] := StrToFloat(eJ13.Text) except ShowWrongEdit(eJ13); exit end;
  try frmMain.j[1,0] := StrToFloat(eJ21.Text) except ShowWrongEdit(eJ21); exit end;
  try frmMain.j[1,1] := StrToFloat(eJ22.Text) except ShowWrongEdit(eJ22); exit end;
  try frmMain.j[1,2] := StrToFloat(eJ23.Text) except ShowWrongEdit(eJ23); exit end;
  try frmMain.j[2,0] := StrToFloat(eJ31.Text) except ShowWrongEdit(eJ31); exit end;
  try frmMain.j[2,1] := StrToFloat(eJ32.Text) except ShowWrongEdit(eJ32); exit end;
  try frmMain.j[2,2] := StrToFloat(eJ33.Text) except ShowWrongEdit(eJ33); exit end;

  try frmMain.alfa0.pos  := StrToFloat(eAlfa0Pos.Text) *pi/180 except ShowWrongEdit(eAlfa0Pos); exit end;
  try frmMain.betta0.pos := StrToFloat(eBetta0Pos.Text)*pi/180 except ShowWrongEdit(eBetta0Pos); exit end;
  try frmMain.gamma0.pos := StrToFloat(eGamma0Pos.Text)*pi/180 except ShowWrongEdit(eGamma0Pos); exit end;

  try frmMain.alfa0 .speed := StrToFloat(eAlfa0Speed.Text)*pi/180 except ShowWrongEdit(eAlfa0Speed); exit end;
  try frmMain.betta0.speed := StrToFloat(eBetta0Speed.Text)*pi/180 except ShowWrongEdit(eBetta0Speed); exit end;
  try frmMain.gamma0.speed := StrToFloat(eGamma0Speed.Text)*pi/180 except ShowWrongEdit(eGamma0Speed); exit end;

  try frmMain.f1 := StrToFloat(eF1.Text) except ShowWrongEdit(eF1); exit end;
  try frmMain.f2 := StrToFloat(eF2.Text) except ShowWrongEdit(eF2); exit end;

  try frmMain.m1 := StrToFloat(eM1.Text) except ShowWrongEdit(eM1); exit end;
  try frmMain.m2 := StrToFloat(eM2.Text) except ShowWrongEdit(eM2); exit end;
  
  close;
end;

end.
