unit Unit_ChoosDestop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmChoosDestop = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    Path_File : String;
    function CheckProjectPath(Path : String) : boolean;
  public
    { Public declarations }
  end;

var
  frmChoosDestop: TfrmChoosDestop;

implementation

uses Unit_Main, Unit_SaveDialog;

{$R *.DFM}

procedure TfrmChoosDestop.Button3Click(Sender: TObject);
begin
   Form1.Show;
end;

procedure TfrmChoosDestop.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmChoosDestop.Button1Click(Sender: TObject);
begin
 ////
end;

procedure TfrmChoosDestop.FormShow(Sender: TObject);
var
 SR      : TSearchRec;
 TempStr : String;
 i       : integer;
 PosPoint: integer;
begin
  CreateDir(ExtractFilePath(Application.ExeName) + 'Шаблоны проектов\');
  CreateDir(ExtractFilePath(Application.ExeName) + 'Проекты\');
  // --- Загружаю перечень существующих файлов в рабочей директории ---
  Path_File := ExtractFilePath(Application.ExeName) + 'Шаблоны проектов\';
  if FindFirst(Path_File + '*.shab', faAnyFile,SR)=0 then
    repeat
       TempStr  := '';
       PosPoint := -1;
       for i := Length(SR.Name) downto 1 do
         if Sr.Name[i] = '.' then begin
           PosPoint := i-1;
           break;
         end;
       for i:= 1 to PosPoint do TempStr := TempStr + Sr.Name[i];
       ListBox1.Items.Add(TempStr);
    until FindNext(SR) <>0;
  FindClose(SR);
end;

procedure TfrmChoosDestop.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then begin
    Button1.Enabled := True;
    Button1.Default := True;
  end;
  Caption := ListBox1.Items.Strings[ListBox1.ItemIndex]
end;

procedure TfrmChoosDestop.ListBox1DblClick(Sender: TObject);
var
 FileName : String;
begin
  FileName :=  ExtractFileName(ListBox1.Items.Strings[ListBox1.ItemIndex]);
  frmSaveDialog.LoadShablonPlanshet(Path_File, FileName, False);
  Form1.Show;
end;

function TfrmChoosDestop.CheckProjectPath(Path: String): boolean;
var
 CurFileName : String;
 Handle      : Integer;
begin
  Result:= False;

  CurFileName := Path+'_____.___';
  Handle := FileCreate(CurFileName);
  if Handle = -1 then exit;

  FileClose(Handle);
  DeleteFile(CurFileName);

  Result := True;
end;

end.
