(*
-------- Project options --------
Производитель        111     CopmanyName          Dymamic system
Описание             222     FileDescription      Пингует нужные серваки
Внутренее имя        444     InternalName
авторские права      555     LegalCopyright
товарные знаки       666     LegalTrademarks
Исходное имя файла   777     OriginalFilename
Название продукта    888     ProductName
Версия продукта      999     ProductVersion
Коментарий           000     Comments
*)
unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus, Registry, ImgList, CoolTrayIcon;

const
  IcmpData = 32;


type
  TForm1 = class(TForm)
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    p1: TMenuItem;
    Exit1: TMenuItem;
    p2: TMenuItem;
    p3: TMenuItem;
    p4: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    p5: TMenuItem;
    CoolTrayIcon1: TCoolTrayIcon;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure pClick(Sender: TObject);
    procedure CoolTrayIcon1Startup(Sender: TObject;
      var ShowMainForm: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    RegIni       : TRegistry;
    ipAddressStr : String;
    icmpHandle   : THandle;
    procedure SetupMenuItem();
  public
  end;

var
  Form1: TForm1;
  strArray : array [0..4] of String;

implementation

uses IcmpApi, WinSock, Unit_Options;


{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  strArray[0] := '';
  strArray[1] := '';
  strArray[2] := '';
  strArray[3] := '';
  try
    RegIni         := TRegistry.Create;

    RegIni.RootKey := HKEY_LOCAL_MACHINE;
    // ----- Прописал в Windows/Автозапуск ---------
    RegIni.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', true);
    RegIni.WriteString('Myst <Ping>', Application.ExeName);
    RegIni.CloseKey;


    RegIni.OpenKey('Software\Myst\Ping', true);
    strArray[0] := RegIni.ReadString('Address1');
    strArray[1] := RegIni.ReadString('Address2');
    strArray[2] := RegIni.ReadString('Address3');
    strArray[3] := RegIni.ReadString('Address4');
    RegIni.CloseKey;
  except
  end;

  icmpHandle   := IcmpCreateFile();
  if icmpHandle = 0 then ExitProcess(0);
  SetupMenuItem();
  pClick(p1);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  try
    RegIni.RootKey := HKEY_LOCAL_MACHINE;

    RegIni.OpenKey('Software\Myst\Ping', true);
        RegIni.WriteString('Address1', strArray[0]);
        RegIni.WriteString('Address2', strArray[1]);
        RegIni.WriteString('Address3', strArray[2]);
        RegIni.WriteString('Address4', strArray[3]);
    RegIni.CloseKey;
  except
  end;

  RegIni.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  RequestOptions : TIPOptionInformation;
  Result         : Integer;
  EchoSize       : Integer;
  Echo           : PChar;
  ipAddress     : TIPAddr;
  Data           : array [0..IcmpData-1] of Char;
begin
  if ipAddressStr = '' then begin
     CoolTrayIcon1.iconIndex := 2;
     exit;
  end;
  
  ipAddress := inet_addr(PChar(ipAddressStr));
  FillChar(RequestOptions,SizeOf(TIPOptionInformation),#0);

  EchoSize  := (SizeOf(TIcmpEchoReply)+IcmpData);
  Echo      := StrAlloc(EchoSize+1);

  FillChar(Echo^,EchoSize+1,#0);

  Result    := IcmpSendEcho(IcmpHandle, ipAddress, @Data, IcmpData, nil, Echo, EchoSize, 100);

  if Result = 0 then CoolTrayIcon1.iconIndex := 1
                else CoolTrayIcon1.iconIndex := 0; //Hint  := 'Ping  ' + ipAddressStr + ' bytes = ' + IntToStr(IcmpData) + ' Time = ' + IntToStr(TIcmpEchoReply(Pointer(Echo)^).RoundTripTime) + ' mSec';


  StrDispose(Echo);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
 close;
end;

procedure TForm1.pClick(Sender: TObject);
var
 tempStr : String;
 i       : Integer;
begin
  Timer1.Enabled := False;
  ipAddressStr   := '';

  for i := 0 to PopupMenu1.Items.Count - 1 do PopupMenu1.Items[i].Checked := false;

  if TMenuItem(Sender).MenuIndex = 5 then begin
         frmOptions.ShowModal;
         SetupMenuItem();
         CoolTrayIcon1.iconIndex := 2;
  end else begin
        TMenuItem(Sender).Checked := True;

        TempStr      := TMenuItem(Sender).Caption;
        for i:=1 to Length(TempStr) do
          if byte(TempStr[i]) <> 38 then ipAddressStr := ipAddressStr + TempStr[i];
  end;

  Timer1.Enabled := True;
end;

procedure TForm1.CoolTrayIcon1Startup(Sender: TObject;
  var ShowMainForm: Boolean);
begin
   ShowMainForm := False;
end;

procedure TForm1.SetupMenuItem();
var
  i : integer;
begin
  for i := 0 to 3 do begin
     if strArray[i] <> '' then begin
        PopupMenu1.items[i].Caption := strArray[i];
        PopupMenu1.items[i].Visible := True;
     end else PopupMenu1.items[i].Visible := false;
  end;
end;

end.
