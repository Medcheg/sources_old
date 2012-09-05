unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AppEvnts;

type
  TForm1 = class(TForm)
    Button1: TButton;
    tmr1: TTimer;
    Edit1: TEdit;
    cmb1: TComboBox;
    Button2: TButton;
    Edit4: TEdit;
    cmb2: TComboBox;
    tmr2: TTimer;
    Button3: TButton;
    Edit6: TEdit;
    cmb3: TComboBox;
    tmr3: TTimer;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    cmb4: TComboBox;
    cmb5: TComboBox;
    cmb6: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit5: TEdit;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    tmr4: TTimer;
    tmr5: TTimer;
    tmr6: TTimer;
    procedure tmr1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
    procedure tmr3Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure tmr4Timer(Sender: TObject);
    procedure tmr5Timer(Sender: TObject);
    procedure tmr6Timer(Sender: TObject);
  private
    { Private declarations }
  public
    Procedure Execute1;
    Procedure Execute2;
    Procedure Execute3;
    Procedure Execute4;
    Procedure Execute5;
    Procedure Execute6;
  end;

var
  Form1: TForm1;
  S1   : TStringList;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
if tmr2.Enabled then
Begin
  tmr2.Enabled := False;
  Button2.Caption := 'Start';
End
Else
Begin
  tmr2.Enabled := True;
  tmr2.Interval := StrToInt(Edit4.Text) * 1000;
  Execute2;
  Button2.Caption := 'Stop';
End;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if tmr3.Enabled then
Begin
  tmr3.Enabled := False;
  Button3.Caption := 'Start';
End
Else
Begin
  tmr3.Enabled := True;
  tmr3.Interval := StrToInt(Edit6.Text) * 1000;
  Execute3;
  Button3.Caption := 'Stop';
End;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
if tmr4.Enabled then
Begin
  tmr4.Enabled := False;
  Button4.Caption := 'Start';
End
Else
Begin
  tmr4.Enabled := True;
  tmr4.Interval := StrToInt(Edit2.Text) * 1000;
  Execute4;
  Button4.Caption := 'Stop';
End;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
if tmr5.Enabled then
Begin
  tmr5.Enabled := False;
  Button5.Caption := 'Start';
End
Else
Begin
  tmr5.Enabled := True;
  tmr5.Interval := StrToInt(Edit3.Text) * 1000;
  Execute5;
  Button5.Caption := 'Stop';
End;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
if tmr6.Enabled then
Begin
  tmr6.Enabled := False;
  Button6.Caption := 'Start';
End
Else
Begin
  tmr6.Enabled := True;
  tmr6.Interval := StrToInt(Edit5.Text) * 1000;
  Execute6;
  Button6.Caption := 'Stop';
End;
end;

procedure TForm1.Execute1;
var
    wnd     : HWND;
    keycode : integer;
Begin
  keycode := 0;
  wnd := StrToInt(S1[combobox2.ItemIndex]);
  //wnd := GetWindow(StrToInt(S1[combobox2.ItemIndex]), gw_HWndFirst);
  //  wnd := FindWindow(nil,PWideChar(Edit2.text));
  if ((wnd <> 0) and (cmb1.ItemIndex <> -1 )) then
  Begin
      case cmb1.ItemIndex of
      0: keycode := vk_f1;
      1: keycode := vk_f2;
      2: keycode := vk_f3;
      3: keycode := vk_f4;
      4: keycode := vk_f5;
      5: keycode := vk_f6;
      6: keycode := vk_f7;
      7: keycode := vk_f8;
      8: keycode := vk_f9;
      9: keycode := vk_f10;
      10: keycode := vk_f11;
      11: keycode := vk_f12;
      end;
      if CheckBox1.Checked then
      Begin
        BringWindowToTop(wnd);
        Sleep(1000);
      End;
      SendMessage(wnd, WM_keydown, keycode, 0);
      SendMessage(wnd, WM_keyUP, keycode, 0);
  End;
End;

procedure TForm1.Execute4;
var
    wnd     : HWND;
    keycode : integer;
Begin
  keycode := 0;
  wnd := StrToInt(S1[combobox1.ItemIndex]);
  //wnd := GetWindow(StrToInt(S1[combobox2.ItemIndex]), gw_HWndFirst);
  //  wnd := FindWindow(nil,PWideChar(Edit2.text));
  if ((wnd <> 0) and (cmb4.ItemIndex <> -1 )) then
  Begin
      case cmb4.ItemIndex of
      0: keycode := vk_f1;
      1: keycode := vk_f2;
      2: keycode := vk_f3;
      3: keycode := vk_f4;
      4: keycode := vk_f5;
      5: keycode := vk_f6;
      6: keycode := vk_f7;
      7: keycode := vk_f8;
      8: keycode := vk_f9;
      9: keycode := vk_f10;
      10: keycode := vk_f11;
      11: keycode := vk_f12;
      end;
      if CheckBox4.Checked then
      Begin
        BringWindowToTop(wnd);
        Sleep(1000);
      End;
      SendMessage(wnd, WM_keydown, keycode, 0);
      SendMessage(wnd, WM_keyUP, keycode, 0);
  End;
End;

procedure TForm1.Execute5;
var
    wnd     : HWND;
    keycode : integer;
Begin
  keycode := 0;
  wnd := StrToInt(S1[combobox5.ItemIndex]);
  //wnd := GetWindow(StrToInt(S1[combobox2.ItemIndex]), gw_HWndFirst);
  //  wnd := FindWindow(nil,PWideChar(Edit2.text));
  if ((wnd <> 0) and (cmb5.ItemIndex <> -1 )) then
  Begin
      case cmb5.ItemIndex of
      0: keycode := vk_f1;
      1: keycode := vk_f2;
      2: keycode := vk_f3;
      3: keycode := vk_f4;
      4: keycode := vk_f5;
      5: keycode := vk_f6;
      6: keycode := vk_f7;
      7: keycode := vk_f8;
      8: keycode := vk_f9;
      9: keycode := vk_f10;
      10: keycode := vk_f11;
      11: keycode := vk_f12;
      end;
      if CheckBox5.Checked then
      Begin
        BringWindowToTop(wnd);
        Sleep(1000);
      End;
      SendMessage(wnd, WM_keydown, keycode, 0);
      SendMessage(wnd, WM_keyUP, keycode, 0);
  End;
End;

procedure TForm1.Execute6;
var
    wnd     : HWND;
    keycode : integer;
Begin
  keycode := 0;
  wnd := StrToInt(S1[combobox6.ItemIndex]);
  //wnd := GetWindow(StrToInt(S1[combobox2.ItemIndex]), gw_HWndFirst);
  //  wnd := FindWindow(nil,PWideChar(Edit2.text));
  if ((wnd <> 0) and (cmb6.ItemIndex <> -1 )) then
  Begin
      case cmb6.ItemIndex of
      0: keycode := vk_f1;
      1: keycode := vk_f2;
      2: keycode := vk_f3;
      3: keycode := vk_f4;
      4: keycode := vk_f5;
      5: keycode := vk_f6;
      6: keycode := vk_f7;
      7: keycode := vk_f8;
      8: keycode := vk_f9;
      9: keycode := vk_f10;
      10: keycode := vk_f11;
      11: keycode := vk_f12;
      end;
      if CheckBox6.Checked then
      Begin
        BringWindowToTop(wnd);
        Sleep(1000);
      End;
      SendMessage(wnd, WM_keydown, keycode, 0);
      SendMessage(wnd, WM_keyUP, keycode, 0);
  End;
End;

procedure TForm1.Execute2;
var
    wnd     : HWND;
    keycode : integer;
Begin
  keycode := 0;
  wnd := StrToInt(S1[combobox3.ItemIndex]);
  //wnd := FindWindow(nil,PWideChar(Edit3.text));
  if ((wnd <> 0) and (cmb2.ItemIndex <> -1 )) then
  Begin
      case cmb2.ItemIndex of
      0: keycode := vk_f1;
      1: keycode := vk_f2;
      2: keycode := vk_f3;
      3: keycode := vk_f4;
      4: keycode := vk_f5;
      5: keycode := vk_f6;
      6: keycode := vk_f7;
      7: keycode := vk_f8;
      8: keycode := vk_f9;
      9: keycode := vk_f10;
      10: keycode := vk_f11;
      11: keycode := vk_f12;
      end;
      if CheckBox2.Checked then
      Begin
        BringWindowToTop(wnd);
        Sleep(1000);
      End;
      SendMessage(wnd, WM_keydown, keycode, 0);
      SendMessage(wnd, WM_keyUP, keycode, 0);
  End;
End;

procedure TForm1.Execute3;
var
    wnd     : HWND;
    keycode : integer;
Begin
  keycode := 0;
  wnd := StrToInt(S1[combobox4.ItemIndex]);
//  wnd := FindWindow(nil,PWideChar(Edit5.text));
  if ((wnd <> 0) and (cmb3.ItemIndex <> -1 )) then
  Begin
      case cmb3.ItemIndex of
      0: keycode := vk_f1;
      1: keycode := vk_f2;
      2: keycode := vk_f3;
      3: keycode := vk_f4;
      4: keycode := vk_f5;
      5: keycode := vk_f6;
      6: keycode := vk_f7;
      7: keycode := vk_f8;
      8: keycode := vk_f9;
      9: keycode := vk_f10;
      10: keycode := vk_f11;
      11: keycode := vk_f12;
      end;
      if CheckBox3.Checked then
      Begin
        BringWindowToTop(wnd);
        Sleep(1000);
      End;
      SendMessage(wnd, WM_keydown, keycode, 0);
      SendMessage(wnd, WM_keyUP, keycode, 0);
  End;
End;

procedure TForm1.FormShow(Sender: TObject);
VAR
Wnd : hWnd;
buff: ARRAY [0..127] OF Char;
begin
if S1 <> nil then
  Exit;
combobox2.Items.Clear;
combobox3.Items.Clear;
combobox4.Items.Clear;
S1 := TstringList.Create;
// Получаем hWnd первого окна
Wnd := GetWindow(Handle, gw_HWndFirst);
// Цикл поиска окон
WHILE Wnd <> 0 DO BEGIN
  IF (Wnd <> Application.Handle) AND // -Собственное окно
  IsWindowVisible(Wnd) AND // -Невидимые окна
  (GetWindow(Wnd, gw_Owner) = 0) AND // -Дочернии окна
  (GetWindowText(Wnd, buff, sizeof(buff)) <> 0) // -Окна без заголовков
  THEN BEGIN
    GetWindowText(Wnd, buff, sizeof(buff));
    combobox2.Items.Add(StrPas(buff) + ' ' + IntToStr(wnd));
    combobox3.Items.Add(StrPas(buff) + ' ' + IntToStr(wnd));
    combobox4.Items.Add(StrPas(buff) + ' ' + IntToStr(wnd));
    combobox1.Items.Add(StrPas(buff) + ' ' + IntToStr(wnd));
    combobox5.Items.Add(StrPas(buff) + ' ' + IntToStr(wnd));
    combobox6.Items.Add(StrPas(buff) + ' ' + IntToStr(wnd));
    S1.Add(IntToStr(wnd));
  END;
  // Ищем новое окно
  Wnd := GetWindow(Wnd, gw_hWndNext);
END;
combobox2.ItemIndex := 0;
combobox3.ItemIndex := 0;
combobox4.ItemIndex := 0;
combobox1.ItemIndex := 0;
combobox5.ItemIndex := 0;
combobox6.ItemIndex := 0;
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
var
    k: integer;
  begin
    application.Minimize;
    for k := 0 to Screen.FormCount - 1 do begin
      Screen.Forms[k].Hide;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if tmr1.Enabled then
Begin
  tmr1.Enabled := False;
  Button1.Caption := 'Start';
End
Else
Begin
  tmr1.Enabled := True;
  tmr1.Interval := StrToInt(Edit1.Text) * 1000;
  Execute1;
  Button1.Caption := 'Stop';
End;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
  execute1;
end;

procedure TForm1.tmr2Timer(Sender: TObject);
begin
  execute2;
end;

procedure TForm1.tmr3Timer(Sender: TObject);
begin
  execute3;
end;

procedure TForm1.tmr4Timer(Sender: TObject);
begin
  execute4;
end;

procedure TForm1.tmr5Timer(Sender: TObject);
begin
  execute5;
end;

procedure TForm1.tmr6Timer(Sender: TObject);
begin
  execute6;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
var
    k: integer;
begin
    for k := Screen.FormCount - 1 downto 0 do begin
      Screen.Forms[k].Show;
    end;
    application.Restore;
    application.BringToFront;
end;

end.
