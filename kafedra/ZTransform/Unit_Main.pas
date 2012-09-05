unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, MPIDeclaration, ExtCtrls, ToolWin, ComCtrls, MPITypes, Menus;

type
  TForm1 = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edK: TEdit;
    edS: TEdit;
    edT1: TEdit;
    edKsi1: TEdit;
    edT3: TEdit;
    edKsi3: TEdit;
    edT5: TEdit;
    edT7: TEdit;
    edT9: TEdit;
    edT2: TEdit;
    edKsi2: TEdit;
    edT4: TEdit;
    edKsi4: TEdit;
    edT6: TEdit;
    edT8: TEdit;
    edT10: TEdit;
    edT12: TEdit;
    ToolButton1: TToolButton;
    Panel3: TPanel;
    ToolButton2: TToolButton;
    Label20: TLabel;
    edT0: TEdit;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel2: TPanel;
    Image2: TImage;
    edKk: TEdit;
    edMjuk: TEdit;
    edT1k: TEdit;
    edKsi1k: TEdit;
    edT3k: TEdit;
    edKsi3k: TEdit;
    edT5k: TEdit;
    edT7k: TEdit;
    edT9k: TEdit;
    edT2k: TEdit;
    edKsi2k: TEdit;
    edT4k: TEdit;
    edKsi4k: TEdit;
    edT6k: TEdit;
    edT8k: TEdit;
    edT10k: TEdit;
    Panel4: TPanel;
    Label40: TLabel;
    Label12: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label21: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label39: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label22: TLabel;
    Label30: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    procedure SetParam();
    function  GetTextFromEditComponent():boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit_ShowResult, Unit_GraphAndTable1, Unit_ACH_FCH, MPILibrary;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
  SetParam();
  ZTransform := TZTrans.Create;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ToolBar1.Width := ControlBar1.Width;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 ZTransform.Free;
end;

procedure TForm1.SetParam;
begin
  edK.Text     := FloatToStr(OC.K);
  edS.Text     := FloatToStr(OC.S);
  /////////////////////////////////////////
  edT0.Text    := FloatToStr(MainT0);
  /////////////////////////////////////////
  edT1.Text    := FloatToStr(OC.T1);
  edKsi1.Text  := FloatToStr(OC.Ksi1);
  edT3.Text    := FloatToStr(OC.T3);
  edKsi3.Text  := FloatToStr(OC.Ksi3);
  edT5.Text    := FloatToStr(OC.T5);
  edT7.Text    := FloatToStr(OC.T7);
  edT9.Text    := FloatToStr(OC.T9);
  /////////////////////////////////////////
  edT2.Text    := FloatToStr(OC.T2);
  edKsi2.Text  := FloatToStr(OC.Ksi2);
  edT4.Text    := FloatToStr(OC.T4);
  edKsi4.Text  := FloatToStr(OC.Ksi4);
  edT6.Text    := FloatToStr(OC.T6);
  edT8.Text    := FloatToStr(OC.T8);
  edT10.Text   := FloatToStr(OC.T10);
  edT12.Text   := FloatToStr(OC.T12);
  //+++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++
  //+++++++++++++++++++++++++++++++++++++++++
  edKk.Text     := FloatToStr(Coef_Korec.K);
  edMjuk.Text     := FloatToStr(Coef_Korec.Mju);
  /////////////////////////////////////////
  edT1k.Text    := FloatToStr(Coef_Korec.T1);
  edKsi1k.Text  := FloatToStr(Coef_Korec.Ksi1);
  edT3k.Text    := FloatToStr(Coef_Korec.T3);
  edKsi3k.Text  := FloatToStr(Coef_Korec.Ksi3);
  edT5k.Text    := FloatToStr(Coef_Korec.T5);
  edT7k.Text    := FloatToStr(Coef_Korec.T7);
  edT9k.Text    := FloatToStr(Coef_Korec.T9);
  /////////////////////////////////////////
  edT2k.Text    := FloatToStr(Coef_Korec.T2);
  edKsi2k.Text  := FloatToStr(Coef_Korec.Ksi2);
  edT4k.Text    := FloatToStr(Coef_Korec.T4);
  edKsi4k.Text  := FloatToStr(Coef_Korec.Ksi4);
  edT6k.Text    := FloatToStr(Coef_Korec.T6);
  edT8k.Text    := FloatToStr(Coef_Korec.T8);
  edT10k.Text   := FloatToStr(Coef_Korec.T10);
end;

function TForm1.GetTextFromEditComponent:boolean;
begin
  Result := False;
  //---------------------
  Try OC.k := StrToFloat(edK.text) except ShowWrongEdit(edK);exit end;
  Try OC.s := StrToFloat(edS.text) except ShowWrongEdit(edS);exit end;
  //---------------------
  Try MainT0   := StrToFloat(edT0.text)   except ShowWrongEdit(edT0);  exit end;
  Try OC.T1   := StrToFloat(edT1.text)   except ShowWrongEdit(edT1);  exit end;
  Try OC.Ksi1 := StrToFloat(edKsi1.text) except ShowWrongEdit(edKsi1);exit end;
  Try OC.T3   := StrToFloat(edT3.text)   except ShowWrongEdit(edT3);  exit end;
  Try OC.Ksi3 := StrToFloat(edKsi3.text) except ShowWrongEdit(edKsi3);exit end;
  Try OC.T5   := StrToFloat(edT5.text)   except ShowWrongEdit(edT5);  exit end;
  Try OC.T7   := StrToFloat(edT7.text)   except ShowWrongEdit(edT7);  exit end;
  Try OC.T9   := StrToFloat(edT9.text)   except ShowWrongEdit(edT9);  exit end;
  //---------------------
  Try OC.T2   := StrToFloat(edT2.text)   except ShowWrongEdit(edT2);  exit end;
  Try OC.Ksi2 := StrToFloat(edKsi2.text) except ShowWrongEdit(edKsi2);exit end;
  Try OC.T4   := StrToFloat(edT4.text)   except ShowWrongEdit(edT4);  exit end;
  Try OC.Ksi4 := StrToFloat(edKsi4.text) except ShowWrongEdit(edKsi4);exit end;
  Try OC.T6   := StrToFloat(edT6.text)   except ShowWrongEdit(edT6);  exit end;
  Try OC.T8   := StrToFloat(edT8.text)   except ShowWrongEdit(edT8);  exit end;
  Try OC.T10  := StrToFloat(edT10.text)  except ShowWrongEdit(edT10); exit end;
  Try OC.T12  := StrToFloat(edT12.text)  except ShowWrongEdit(edT12); exit end;
  //---------------------
  if abs(OC.Ksi1) > 1 then begin edKsi1.SetFocus; MessageDlg('Параметр Ksi1 должен быть меньше 1', mtError, [mbOk],0); exit; end;
  if abs(OC.Ksi3) > 1 then begin edKsi3.SetFocus; MessageDlg('Параметр Ksi3 должен быть меньше 1', mtError, [mbOk],0); exit; end;
  if abs(OC.Ksi2) > 1 then begin edKsi2.SetFocus; MessageDlg('Параметр Ksi2 должен быть меньше 1', mtError, [mbOk],0); exit; end;
  if abs(OC.Ksi4) > 1 then begin edKsi4.SetFocus; MessageDlg('Параметр Ksi4 должен быть меньше 1', mtError, [mbOk],0); exit; end;
  //---------------------
  if (oc.t2  = oc.t4)  and (oc.t2  <> 0) and (oc.t4  <> 0) then begin MessageDlg('Параметры T2 , T4  не могут быть равны', mtError, [mbOk],0); exit; end;
  if (oc.t6  = oc.t8)  and (oc.t6  <> 0) and (oc.t8  <> 0) then begin MessageDlg('Параметры T6 , T8  не могут быть равны', mtError, [mbOk],0); exit; end;
  if (oc.t6  = oc.t10) and (oc.t6  <> 0) and (oc.t10 <> 0) then begin MessageDlg('Параметры T6 , T10 не могут быть равны', mtError, [mbOk],0); exit; end;
  if (oc.t6  = oc.t12) and (oc.t6  <> 0) and (oc.t12 <> 0) then begin MessageDlg('Параметры T6 , T12 не могут быть равны', mtError, [mbOk],0); exit; end;
  if (oc.t8  = oc.t10) and (oc.t8  <> 0) and (oc.t10 <> 0) then begin MessageDlg('Параметры T8 , T10 не могут быть равны', mtError, [mbOk],0); exit; end;
  if (oc.t8  = oc.t12) and (oc.t8  <> 0) and (oc.t12 <> 0) then begin MessageDlg('Параметры T8 , T12 не могут быть равны', mtError, [mbOk],0); exit; end;
  if (oc.t10 = oc.t12) and (oc.t10 <> 0) and (oc.t12 <> 0) then begin MessageDlg('Параметры T10, T12 не могут быть равны', mtError, [mbOk],0); exit; end;
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Try Coef_Korec.k := StrToFloat(edKk.text) except ShowWrongEdit(edKk);exit end;
  Try Coef_Korec.Mju := StrToFloat(edMjuk.text) except ShowWrongEdit(edMjuk);exit end;
  //---------------------
  Try Coef_Korec.T1   := StrToFloat(edT1k.text)   except ShowWrongEdit(edT1k);  exit end;
  Try Coef_Korec.Ksi1 := StrToFloat(edKsi1k.text) except ShowWrongEdit(edKsi1k);exit end;
  Try Coef_Korec.T3   := StrToFloat(edT3k.text)   except ShowWrongEdit(edT3k);  exit end;
  Try Coef_Korec.Ksi3 := StrToFloat(edKsi3k.text) except ShowWrongEdit(edKsi3k);exit end;
  Try Coef_Korec.T5   := StrToFloat(edT5k.text)   except ShowWrongEdit(edT5k);  exit end;
  Try Coef_Korec.T7   := StrToFloat(edT7k.text)   except ShowWrongEdit(edT7k);  exit end;
  Try Coef_Korec.T9   := StrToFloat(edT9k.text)   except ShowWrongEdit(edT9k);  exit end;
  //---------------------
  Try Coef_Korec.T2   := StrToFloat(edT2k.text)   except ShowWrongEdit(edT2k);  exit end;
  Try Coef_Korec.Ksi2 := StrToFloat(edKsi2k.text) except ShowWrongEdit(edKsi2k);exit end;
  Try Coef_Korec.T4   := StrToFloat(edT4k.text)   except ShowWrongEdit(edT4k);  exit end;
  Try Coef_Korec.Ksi4 := StrToFloat(edKsi4k.text) except ShowWrongEdit(edKsi4k);exit end;
  Try Coef_Korec.T6   := StrToFloat(edT6k.text)   except ShowWrongEdit(edT6k);  exit end;
  Try Coef_Korec.T8   := StrToFloat(edT8k.text)   except ShowWrongEdit(edT8k);  exit end;
  Try Coef_Korec.T10  := StrToFloat(edT10k.text)  except ShowWrongEdit(edT10k); exit end;
  //---------------------
  if abs(Coef_Korec.Ksi1) > 1 then begin edKsi1k.SetFocus; MessageDlg('Параметр Ksi1 должен быть меньше 1', mtError, [mbOk],0); exit; end;
  if abs(Coef_Korec.Ksi3) > 1 then begin edKsi3k.SetFocus; MessageDlg('Параметр Ksi3 должен быть меньше 1', mtError, [mbOk],0); exit; end;
  if abs(Coef_Korec.Ksi2) > 1 then begin edKsi2k.SetFocus; MessageDlg('Параметр Ksi2 должен быть меньше 1', mtError, [mbOk],0); exit; end;
  if abs(Coef_Korec.Ksi4) > 1 then begin edKsi4k.SetFocus; MessageDlg('Параметр Ksi4 должен быть меньше 1', mtError, [mbOk],0); exit; end;
  //---------------------
  if (Coef_Korec.t2  = Coef_Korec.t4)  and (Coef_Korec.t2  <> 0) and (Coef_Korec.t4  <> 0) then begin MessageDlg('Параметры T2 , T4  не могут быть равны', mtError, [mbOk],0); exit; end;
  if (Coef_Korec.t6  = Coef_Korec.t8)  and (Coef_Korec.t6  <> 0) and (Coef_Korec.t8  <> 0) then begin MessageDlg('Параметры T6 , T8  не могут быть равны', mtError, [mbOk],0); exit; end;
  if (Coef_Korec.t6  = Coef_Korec.t10) and (Coef_Korec.t6  <> 0) and (Coef_Korec.t10 <> 0) then begin MessageDlg('Параметры T6 , T10 не могут быть равны', mtError, [mbOk],0); exit; end;
  if (Coef_Korec.t6  = Coef_Korec.t12) and (Coef_Korec.t6  <> 0) and (Coef_Korec.t12 <> 0) then begin MessageDlg('Параметры T6 , T12 не могут быть равны', mtError, [mbOk],0); exit; end;
  if (Coef_Korec.t8  = Coef_Korec.t10) and (Coef_Korec.t8  <> 0) and (Coef_Korec.t10 <> 0) then begin MessageDlg('Параметры T8 , T10 не могут быть равны', mtError, [mbOk],0); exit; end;
  if (Coef_Korec.t8  = Coef_Korec.t12) and (Coef_Korec.t8  <> 0) and (Coef_Korec.t12 <> 0) then begin MessageDlg('Параметры T8 , T12 не могут быть равны', mtError, [mbOk],0); exit; end;
  if (Coef_Korec.t10 = Coef_Korec.t12) and (Coef_Korec.t10 <> 0) and (Coef_Korec.t12 <> 0) then begin MessageDlg('Параметры T10, T12 не могут быть равны', mtError, [mbOk],0); exit; end;
  //---------------------

  Result := True;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
   if GetTextFromEditComponent() then begin
       //////////////////////////////////////////////////////////////////////
       {////////////////////}    ZTransform.Calc();    {////////////////////}
       //////////////////////////////////////////////////////////////////////

       frmShowResult.Close();
       frmShowResult.Show();
       n2.Enabled := True;
   end;
   Caption := IntToStr(ZOrder);
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  frmGraphAndTable1.ShowModal;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  frmACH_FCH.ShowModal;
end;

end.
