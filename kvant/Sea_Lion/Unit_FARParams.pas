unit Unit_FARParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, MPIDeclaration;

type
  TfrmFARParams = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Image1: TImage;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Image8: TImage;
    Image9: TImage;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Image6: TImage;
    Image7: TImage;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Image10: TImage;
    Image11: TImage;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Image12: TImage;
    Image13: TImage;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit36: TEdit;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Image14: TImage;
    Image15: TImage;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit40: TEdit;
    Edit41: TEdit;
    Edit42: TEdit;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Image16: TImage;
    Image17: TImage;
    Edit43: TEdit;
    Edit44: TEdit;
    Edit45: TEdit;
    Edit46: TEdit;
    Edit47: TEdit;
    Edit48: TEdit;
    Label41: TLabel;
    Edit49: TEdit;
    Label42: TLabel;
    Edit50: TEdit;
    Label43: TLabel;
    Edit51: TEdit;
    Label44: TLabel;
    Edit52: TEdit;
    Label45: TLabel;
    Edit53: TEdit;
    Label46: TLabel;
    Edit54: TEdit;
    Label47: TLabel;
    Edit55: TEdit;
    Label48: TLabel;
    Edit56: TEdit;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
  private
    BaseClass : TBaseClass;
    procedure WrongEdit(Myedit : TEdit);
  public
  end;

var
  frmFARParams: TfrmFARParams;

implementation

uses  Unit_Main;

{$R *.DFM}

procedure TfrmFARParams.FormCreate(Sender: TObject);
begin
 PageControl1.ActivePageIndex := 0;
end;

procedure TfrmFARParams.FormShow(Sender: TObject);
var curFar : TFARClass;
begin
  BaseClass := Form1.Platform;
  Edit1 .Text := floatToStr(BaseClass.r_1[1]);
  Edit2 .Text := floatToStr(BaseClass.r_1[2]);
  Edit3 .Text := floatToStr(BaseClass.r_1[3]);
  Edit4 .Text := floatToStr(BaseClass.r_h[1]);
  Edit5 .Text := floatToStr(BaseClass.r_h[2]);
  Edit6 .Text := floatToStr(BaseClass.r_h[3]);
  //----------------------------------------------------------
  curFar := TFARClass(BaseClass.FARList.Items[0]);
  Edit7 .Text := floatToStr(curFar.R_pr[1]);
  Edit8 .Text := floatToStr(curFar.R_pr[2]);
  Edit9 .Text := floatToStr(curFar.R_pr[3]);
  Edit10.Text := floatToStr(curFar.R_pp[1]);
  Edit11.Text := floatToStr(curFar.R_pp[2]);
  Edit12.Text := floatToStr(curFar.R_pp[3]);
  Edit49.Text := floatToStr(curFar.eps_0i*180/pi);
  Edit50.Text := floatToStr(curFar.q_0i  *180/pi);
  //----------------------------------------------------------
  curFar := TFARClass(BaseClass.FARList.Items[1]);
  Edit13.Text := floatToStr(curFar.R_pr[1]);
  Edit14.Text := floatToStr(curFar.R_pr[2]);
  Edit15.Text := floatToStr(curFar.R_pr[3]);
  Edit16.Text := floatToStr(curFar.R_pp[1]);
  Edit17.Text := floatToStr(curFar.R_pp[2]);
  Edit18.Text := floatToStr(curFar.R_pp[3]);
  Edit51.Text := floatToStr(curFar.eps_0i*180/pi);
  Edit52.Text := floatToStr(curFar.q_0i  *180/pi-90);
  //----------------------------------------------------------
  curFar := TFARClass(BaseClass.FARList.Items[2]);
  Edit19.Text := floatToStr(curFar.R_pr[1]);
  Edit20.Text := floatToStr(curFar.R_pr[2]);
  Edit21.Text := floatToStr(curFar.R_pr[3]);
  Edit22.Text := floatToStr(curFar.R_pp[1]);
  Edit23.Text := floatToStr(curFar.R_pp[2]);
  Edit24.Text := floatToStr(curFar.R_pp[3]);
  Edit53.Text := floatToStr(curFar.eps_0i*180/pi);
  Edit54.Text := floatToStr(curFar.q_0i  *180/pi-180);
  //----------------------------------------------------------
  curFar := TFARClass(BaseClass.FARList.Items[3]);
  Edit25.Text := floatToStr(curFar.R_pr[1]);
  Edit26.Text := floatToStr(curFar.R_pr[2]);
  Edit27.Text := floatToStr(curFar.R_pr[3]);
  Edit28.Text := floatToStr(curFar.R_pp[1]);
  Edit29.Text := floatToStr(curFar.R_pp[2]);
  Edit30.Text := floatToStr(curFar.R_pp[3]);
  Edit55.Text := floatToStr(curFar.eps_0i*180/pi);
  Edit56.Text := floatToStr(curFar.q_0i  *180/pi-270);
end;

procedure TfrmFARParams.WrongEdit(Myedit: TEdit);
begin
  MyEdit.SetFocus;
  MyEdit.SelectAll;
  MessageDLG('Не числовое значение', mtWarning, [mbOk],0);
end;

procedure TfrmFARParams.BitBtn1Click(Sender: TObject);
var curFar : TFARClass;
begin
  try BaseClass.r_1[1] := StrToFloat(Edit1 .Text) except WrongEdit(Edit1); Exit end;
  try BaseClass.r_1[2] := StrToFloat(Edit2 .Text) except WrongEdit(Edit2); Exit end;
  try BaseClass.r_1[3] := StrToFloat(Edit3 .Text) except WrongEdit(Edit3); Exit end;

  try BaseClass.r_h[1] := StrToFloat(Edit4 .Text) except WrongEdit(Edit4); Exit end;
  try BaseClass.r_h[2] := StrToFloat(Edit5 .Text) except WrongEdit(Edit5); Exit end;
  try BaseClass.r_h[3] := StrToFloat(Edit6 .Text) except WrongEdit(Edit6); Exit end;
  // ---- 1111111111111111111111111111111111111111111111111111111111111111 ---
  curFar := TFARClass(BaseClass.FARList.Items[0]);
  try curFar.R_pr[1] := StrToFloat(Edit7 .Text)  except  WrongEdit(Edit7); Exit end;
  try curFar.R_pr[2] := StrToFloat(Edit8 .Text)  except  WrongEdit(Edit8); Exit end;
  try curFar.R_pr[3] := StrToFloat(Edit9 .Text)  except  WrongEdit(Edit9); Exit end;
  try curFar.R_pp[1] := StrToFloat(Edit10.Text)  except  WrongEdit(Edit10); Exit end;
  try curFar.R_pp[2] := StrToFloat(Edit11.Text)  except  WrongEdit(Edit11); Exit end;
  try curFar.R_pp[3] := StrToFloat(Edit12.Text)  except  WrongEdit(Edit12); Exit end;
  try curFar.eps_0i   := StrToFloat(Edit49.Text)  except  WrongEdit(Edit49); Exit end;
  try curFar.q_0i     := StrToFloat(Edit50.Text)  except  WrongEdit(Edit50); Exit end;
  curFar.eps_0i := curFar.eps_0i*pi/180;
  curFar.q_0i   := curFar.q_0i  *pi/180;
  // ---- 2222222222222222222222222222222222222222222222222222222222222222 ---
  curFar := TFARClass(BaseClass.FARList.Items[1]);
  try curFar.R_pr[1] := StrToFloat(Edit13.Text)  except  WrongEdit(Edit13); Exit end;
  try curFar.R_pr[2] := StrToFloat(Edit14.Text)  except  WrongEdit(Edit14); Exit end;
  try curFar.R_pr[3] := StrToFloat(Edit15.Text)  except  WrongEdit(Edit15); Exit end;
  try curFar.R_pp[1] := StrToFloat(Edit16.Text)  except  WrongEdit(Edit16); Exit end;
  try curFar.R_pp[2] := StrToFloat(Edit17.Text)  except  WrongEdit(Edit17); Exit end;
  try curFar.R_pp[3] := StrToFloat(Edit18.Text)  except  WrongEdit(Edit18); Exit end;
  try curFar.eps_0i   := StrToFloat(Edit51.Text)  except  WrongEdit(Edit51); Exit end;
  try curFar.q_0i     := StrToFloat(Edit52.Text)  except  WrongEdit(Edit52); Exit end;
  curFar.eps_0i := curFar.eps_0i     *pi/180;
  curFar.q_0i   := (90 + curFar.q_0i)*pi/180;
  // ---- 3333333333333333333333333333333333333333333333333333333333333333 ---
  curFar := TFARClass(BaseClass.FARList.Items[2]);
  try curFar.R_pr[1] := StrToFloat(Edit19.Text)  except  WrongEdit(Edit19); Exit end;
  try curFar.R_pr[2] := StrToFloat(Edit20.Text)  except  WrongEdit(Edit20); Exit end;
  try curFar.R_pr[3] := StrToFloat(Edit21.Text)  except  WrongEdit(Edit21); Exit end;
  try curFar.R_pp[1] := StrToFloat(Edit22.Text)  except  WrongEdit(Edit22); Exit end;
  try curFar.R_pp[2] := StrToFloat(Edit23.Text)  except  WrongEdit(Edit23); Exit end;
  try curFar.R_pp[3] := StrToFloat(Edit24.Text)  except  WrongEdit(Edit24); Exit end;
  try curFar.eps_0i   := StrToFloat(Edit53.Text)  except  WrongEdit(Edit53); Exit end;
  try curFar.q_0i     := StrToFloat(Edit54.Text)  except  WrongEdit(Edit54); Exit end;
  curFar.eps_0i :=        curFar.eps_0i*pi/180;
  curFar.q_0i   := (180 + curFar.q_0i) *pi/180;
  // ---- 4444444444444444444444444444444444444444444444444444444444444444 ---
  curFar := TFARClass(BaseClass.FARList.Items[3]);
  try curFar.R_pr[1] := StrToFloat(Edit25.Text)  except  WrongEdit(Edit25); Exit end;
  try curFar.R_pr[2] := StrToFloat(Edit26.Text)  except  WrongEdit(Edit26); Exit end;
  try curFar.R_pr[3] := StrToFloat(Edit27.Text)  except  WrongEdit(Edit27); Exit end;
  try curFar.R_pp[1] := StrToFloat(Edit28.Text)  except  WrongEdit(Edit28); Exit end;
  try curFar.R_pp[2] := StrToFloat(Edit29.Text)  except  WrongEdit(Edit29); Exit end;
  try curFar.R_pp[3] := StrToFloat(Edit30.Text)  except  WrongEdit(Edit30); Exit end;
  try curFar.eps_0i   := StrToFloat(Edit55.Text)  except  WrongEdit(Edit55); Exit end;
  try curFar.q_0i     := StrToFloat(Edit56.Text)  except  WrongEdit(Edit56); Exit end;
  curFar.eps_0i :=         curFar.eps_0i*pi/180;
  curFar.q_0i   := (270 + curFar.q_0i)  *pi/180;
  Close;
end;

procedure TfrmFARParams.Edit1Change(Sender: TObject);
var
  CurText : String;
begin
  CurText := TEdit(Sender).Text;
  Edit1.text := CurText;
  Edit31.Text:=CurText;
  Edit37.Text:=CurText;
  Edit43.Text:=CurText;
end;

procedure TfrmFARParams.Edit2Change(Sender: TObject);
var
  CurText : String;
begin
  CurText := TEdit(Sender).Text;
  Edit2.text := CurText;
  Edit32.Text:=CurText;
  Edit38.Text:=CurText;
  Edit44.Text:=CurText;
end;

procedure TfrmFARParams.Edit3Change(Sender: TObject);
var
  CurText : String;
begin
  CurText := TEdit(Sender).Text;
  Edit3.text := CurText;
  Edit33.Text:=CurText;
  Edit39.Text:=CurText;
  Edit45.Text:=CurText;
end;

procedure TfrmFARParams.Edit4Change(Sender: TObject);
var
  CurText : String;
begin
  CurText := TEdit(Sender).Text;
  Edit4.text := CurText;
  Edit34.Text:=CurText;
  Edit40.Text:=CurText;
  Edit46.Text:=CurText;
end;

procedure TfrmFARParams.Edit5Change(Sender: TObject);
var
  CurText : String;
begin
  CurText := TEdit(Sender).Text;
  Edit5.text := CurText;
  Edit35.Text:=CurText;
  Edit41.Text:=CurText;
  Edit47.Text:=CurText;
end;

procedure TfrmFARParams.Edit6Change(Sender: TObject);
var
  CurText : String;
begin
  CurText := TEdit(Sender).Text;
  Edit6.text := CurText;
  Edit36.Text:=CurText;
  Edit42.Text:=CurText;
  Edit48.Text:=CurText;
end;

end.
