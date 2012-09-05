unit LoaderU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExempleU ;

type
  TfrmLoader = class(TForm)
    btnLoad         : TButton ;
    btnFree         : TButton ;
    btnLicense      : TButton ;
    btnShowSplash   : TButton ;
    btnHideSplash   : TButton ;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure FormClose (Sender  : TObject ; var Action  : TCloseAction) ;
    procedure btnLoadClick (Sender  : TObject) ;
    procedure btnFreeClick (Sender  : TObject) ;
    procedure btnLicenseClick (Sender  : TObject) ;
    procedure btnShowSplashClick (Sender  : TObject) ;
    procedure btnHideSplashClick (Sender  : TObject) ;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLoader          : TfrmLoader ;
  hDLL               : THandle    ;
  ExecuteLicense : function (hWnd  : THandle) : Integer stdcall ;
  CreateSplash   : function (hWnd  : THandle) : Boolean stdcall ;
  ShowSplash     : function : Boolean stdcall ;
  HideSplash      : function : Boolean stdcall ;
  FreeSplash     : function : Boolean stdcall ;

implementation

{$R *.DFM}

procedure TfrmLoader.FormClose (Sender  : TObject ; var Action  : TCloseAction) ;
begin
  If (hDLL <> 0) then
    FreeLibrary (hDLL) ;
  Action := caFree ;
end;

procedure TfrmLoader.btnLoadClick (Sender  : TObject) ;
var
  dwError  : DWORD ;
begin
  hDLL := 0 ;
  hDLL := LoadLibrary ('FirstDLL.dll') ;
  If (hDLL = 0) then
    begin
      dwError := GetLastError ;
      If (dwError = ERROR_DLL_NOT_FOUND) then {value of 1157}
        ShowMessage ('Error: ' + IntToStr (dwError) +
        ' Cannot find FirstDLL.dll or a module required by FirstDLL.dll') ;
    end ;
 end ;

procedure TfrmLoader.btnFreeClick (Sender  : TObject) ;
begin
  If (hDLL <> 0) then
    FreeLibrary (hDLL) ;
end;

procedure TfrmLoader.btnLicenseClick (Sender  : TObject) ;
begin
  @ExecuteLicense := GetProcAddress (hDLL, 'ExecuteLicense') ;
  If (@ExecuteLicense <> nil) then
    ExecuteLicense (Self.Handle) ;
  frmLoader.Show ;
end;

procedure TfrmLoader.btnShowSplashClick (Sender  : TObject) ;
begin
  @CreateSplash := GetProcAddress (hDLL, 'CreateSplash') ;
  If (@CreateSplash <> nil) then
    CreateSplash (Self.Handle) ;
  @ShowSplash := GetProcAddress (hDLL, 'ShowSplash') ;
  ShowSplash ;
end;

procedure TfrmLoader.btnHideSplashClick (Sender  : TObject) ;
begin
  @HideSplash := GetProcAddress (hDLL, 'HideSplash') ;
  HideSplash ;
  @FreeSplash := GetProcAddress (hDLL, 'FreeSplash') ;
  FreeSplash ;
end;

procedure TfrmLoader.Button1Click(Sender: TObject);
begin
  frmExemple.Show ;
end;

procedure TfrmLoader.Button2Click(Sender: TObject);
begin
  frmExemple.Hide ;
end;

procedure TfrmLoader.Button3Click(Sender: TObject);
begin
  frmExemple.Visible := True ;
end;

procedure TfrmLoader.Button4Click(Sender: TObject);
begin
  frmExemple.Free ;
end;

procedure TfrmLoader.Button5Click(Sender: TObject);
begin
  Application.Handle := Self.Handle ;
  frmExemple.Create (Application) ;
end;

end.
