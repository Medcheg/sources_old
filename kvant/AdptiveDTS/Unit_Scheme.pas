unit Unit_Scheme;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons;

type
  TForm_Scheme = class(TForm)
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClick(Sender: TObject);
  private
    Bitmap         : TBitmap;
    BitmapRec      : TBitmap;
    CurrentParamStabilizer   : Pointer;
    reDraw         : Boolean;
    Temp           : Pointer;
    Function  Move_And_Click_on_Big_Bitmap(x,y : integer):Pointer;
    Procedure PowerFormShow(Temp : Pointer);
    Procedure IntegralFormShow(Temp: Pointer);
    Procedure AperiodicFormShow(Temp: Pointer);
    Procedure OgranFormShow(Temp: Pointer);
    Procedure LuftFormShow(Temp: Pointer);
  public
     Procedure SetParametrs(ACaption : String; Param : Pointer);
  end;

var
  Form_Scheme: TForm_Scheme;

implementation

uses DeclPasha, Zveno, Unit_ElementDataForm;

{$R *.DFM}

procedure TForm_Scheme.SetParametrs(ACaption : String; Param: Pointer);
begin
  Caption:=ACaption;
  CurrentParamStabilizer := Param;
end;

procedure TForm_Scheme.FormPaint(Sender: TObject);
begin
  canvas.draw(0,0,bitmap);
end;

procedure TForm_Scheme.FormCreate(Sender: TObject);
begin
  Bitmap    := TBitmap.Create;
  BitmapRec := TBitmap.Create;
  Bitmap   .LoadFromResourceName(HInstance,'Scheme');
  BitmapRec.LoadFromResourceName(HInstance,'Rec');

//  Bitmap.Transparent:=True;
//  Bitmap.TransparentColor:=clBlack;

  BitmapRec.Transparent     :=True;
  BitmapRec.TransparentColor:=clWhite;

  ClientWidth :=Bitmap.Width;
  ClientHeight:=Bitmap.Height+Statusbar1.Height;

  BitBtn1.Top :=ClientHeight - BitBtn1.Height - Statusbar1.Height;
  BitBtn2.Top :=ClientHeight - BitBtn2.Height + 1 - Statusbar1.Height;
  BitBtn2.Left:=ClientWidth  - BitBtn1.Width - 1;
  BitBtn1.Left:=1;
end;


procedure TForm_Scheme.FormDestroy(Sender: TObject);
begin
  Bitmap.Free;
  BitmapRec.Free;
end;

Function  TForm_Scheme.Move_And_Click_on_Big_Bitmap(x,y : integer):Pointer;
var i    : integer;
Begin
  For i:=0 to TPPrivod(CurrentParamStabilizer).ElementList.Count-1 do begin
     Temp:=TPPrivod(CurrentParamStabilizer).ElementList.Items[i];
     if  (X > TElement(Temp).Pos.X+5 ) and
         (Y > TElement(Temp).Pos.Y+5 ) and
         (X < TElement(Temp).Pos.X+26) and
         (Y < TElement(Temp).Pos.Y+26) then begin
         if Not ReDraw then begin
           Canvas.Draw(TElement(Temp).Pos.X,TElement(Temp).Pos.Y,BitmapRec);
           ReDraw:=True;
         end;
         StatusBar1.Panels.Items[0].Text:='    '+TElement(Temp).caption;
         Result:=Temp;
         exit;
     end
  end;
  ReDraw:=False;
  Result:=nil;
  StatusBar1.Panels.Items[0].Text := '';
  Canvas.Draw(0,0,bitmap);
end;

procedure TForm_Scheme.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  temp:=Move_And_Click_on_Big_Bitmap(X,Y);
end;

procedure TForm_Scheme.FormClick(Sender: TObject);
begin
//   1 TPower
//   2 TIntegral
//   3 TDiffer
//   4 TAperiod
//   5 TPeriod
//   6 TOgran
//   7 TLuft_AND_Ogran
//   8 TLuft
  if Temp<>nil then begin
    case TElement(Temp).Name of
      1 : PowerFormShow(Temp);
      2 : IntegralFormShow(Temp);
      4 : AperiodicFormShow(Temp);
      6 : OgranFormShow(Temp);
      8 : LuftFormShow(Temp);
    end;
  end;
end;

procedure TForm_Scheme.PowerFormShow(Temp: Pointer);
var St    : String;
    Prev  : Extended;
begin
  St:=InputBox('KVant - ' + TElement(Temp).caption,'Коэффициент усиления : ',FloatToStr(round(TPower(temp).K*1000000)/1000000));
  try
        Prev:=StrToFloat(St);
  except
        MessageDlg('Не правильно введено значение',mtError,[mbOk],0);
        Prev:=TPower(temp).K;
  end;
  TPower(temp).K:=Prev;
end;

Procedure TForm_Scheme.IntegralFormShow(Temp: Pointer);
var St    : String;
    Prev  : Extended;
begin
  St:=InputBox('KVant - Интегрирующее звено ','Коэффициент усиления интегрирующего звена : ',FloatToStr(round(TIntegral(temp).K*1000000)/1000000));
  try
    Prev:=StrToFloat(St);
  except
    MessageDlg('Не правильно введено значение',mtError,[mbOk],0);
    Prev:=TIntegral(temp).K;
  end;
  TIntegral(temp).K:=Prev;
end;


procedure TForm_Scheme.AperiodicFormShow(Temp: Pointer);
var dlg : TForm_ElementData;
begin
  Dlg:=TForm_ElementData.Create(nil);
  Dlg.Caption        := 'KVant - Апериодическое звено';
  Dlg.Label1.Caption := 'Коэффициент усиления апериодического звена (K):';
  Dlg.Label2.Caption := 'Постоянная времени апериодического звена (T1):';
  Dlg.Edit1.Text := FloatToStr(round(TAperiod(Temp).K *1000000)/1000000);
  Dlg.Edit2.Text := FloatToStr(round(TAperiod(Temp).T1*1000000)/1000000);
  if Dlg.ShowModal = mrOk then begin
      TAperiod(Temp).K  := StrToFloat(Dlg.Edit1.Text);
      TAperiod(Temp).T1 := StrToFloat(Dlg.Edit2.Text);
  end;
  Dlg.Free;
end;

procedure TForm_Scheme.OgranFormShow(Temp: Pointer);
var dlg : TForm_ElementData;
begin
  Dlg:=TForm_ElementData.Create(nil);
  Dlg.Caption        := 'KVant - Ограничение';
  Dlg.Label1.Caption := 'Величина ограничения (B):';
  Dlg.Label2.Caption := 'Коэффициент наклона линейной характеристики (K):';
  Dlg.Edit1.Text := FloatToStr(round(TOgran(Temp).B *1000000)/1000000);
  Dlg.Edit2.Text := FloatToStr(round(TOgran(Temp).K*1000000)/1000000);
  if Dlg.ShowModal = mrOk then begin
      TOgran(Temp).B  := StrToFloat(Dlg.Edit1.Text);
      TOgran(Temp).K := StrToFloat(Dlg.Edit2.Text);
  end;
  Dlg.Free;
end;

procedure TForm_Scheme.LuftFormShow(Temp: Pointer);
var dlg : TForm_ElementData;
begin
  Dlg:=TForm_ElementData.Create(nil);
  Dlg.Caption        := 'KVant - Люфт';
  Dlg.Label1.Caption := 'Зона люфта (a):';
  Dlg.Label2.Caption := 'Коэффициент наклона линейной характеристики (K):';
  Dlg.Edit1.Text := FloatToStr(round(TLuft(Temp).A *1000000)/1000000);
  Dlg.Edit2.Text := FloatToStr(round(TLuft(Temp).K *1000000)/1000000);
  if Dlg.ShowModal = mrOk then begin
      TLuft(Temp).A := StrToFloat(Dlg.Edit1.Text);
      TLuft(Temp).K := StrToFloat(Dlg.Edit2.Text);
  end;
  Dlg.Free;
end;

end.
