unit Unit_Options;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmOptions = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

uses WinSock, Unit_Main;

{$R *.DFM}

procedure TfrmOptions.Button3Click(Sender: TObject);
begin
 close;
end;

procedure TfrmOptions.Button1Click(Sender: TObject);
var
  ipAddressStr : String;
begin
  if ListBox1.Items.Count = 4 then exit;

  ipAddressStr := InputBox('Myst Ping - IP адресс', 'Введите IP адресс', ipAddressStr);
  //if inet_addr(PChar(ipAddressStr)) = INADDR_NONE then MessageDlg('Неправильно введен адресс !!!', mtError, [mbOk], 0)
  //                                                else begin
                                                         ListBox1.Items.Add(ipAddressStr);
                                                         strArray[ListBox1.Items.Count-1] := ipAddressStr;
//                                                       end;
end;

procedure TfrmOptions.Button2Click(Sender: TObject);
var
  i : integer;
begin
  ListBox1.Items.Delete(ListBox1.ItemIndex);

  for i := 0 to 3 do strArray[i] := '';
  for i := 0 to ListBox1.Items.Count - 1 do strArray[i] := ListBox1.Items[i];
end;

procedure TfrmOptions.FormShow(Sender: TObject);
var
 i : integer;
begin
  ListBox1.Items.Clear;
  for i := 0 to 3 do
     if strArray[i] <> '' then ListBox1.Items.Add(strArray[i]);
end;

end.
