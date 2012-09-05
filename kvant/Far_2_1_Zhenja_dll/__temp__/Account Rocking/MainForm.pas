unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmTestDLL = class(TForm)
    btnPlay: TButton;
    btnStop: TButton;
    Timer: TTimer;
    lblEpsilon: TLabel;
    lblBetta: TLabel;
    btnParameters: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnParametersClick(Sender: TObject);
  private
    { Private declarations }
    FCommonTime    : Int64;
    FDeltaBetta    : Extended;
    FDeltaEpsilon  : Extended;
  public
    { Public declarations }
  end;

var
  frmTestDLL               : TfrmTestDLL;

  hDLL                     : THandle;
  ValueAssignment          : procedure (vCommonTime  : Int64; vBetta, vEpsilon  : Extended); stdcall;
  AccountRocking           : procedure (out vDeltaBetta, vDeltaEpsilon  : Extended); stdcall;
  ChamgeRockingParameters  : procedure (hWnd  : THandle); stdcall;

implementation

{$R *.dfm}

procedure TfrmTestDLL.FormCreate(Sender: TObject);
var
  dwError  : DWORD;
begin
  FCommonTime := 0;

  hDLL := 0;
  hDLL := LoadLibrary ('rocking.dll');
  If (hDLL = 0) then
    begin
      dwError := GetLastError;
      if (dwError = ERROR_DLL_NOT_FOUND) then {value of 1157}
        ShowMessage ('Error: ' + IntToStr (dwError) +
        ' "required.dll" не найдена!');
      Close;
    end;

  @ValueAssignment := GetProcAddress (hDLL, 'ValueAssignment');
  @AccountRocking := GetProcAddress (hDLL, 'AccountRocking');
  @ChamgeRockingParameters := GetProcAddress (hDLL, 'ChamgeRockingParameters');
end;

procedure TfrmTestDLL.FormDestroy(Sender: TObject);
begin
  If (hDLL <> 0) then
    FreeLibrary (hDLL);
end;

procedure TfrmTestDLL.btnPlayClick(Sender: TObject);
begin
  Timer.Enabled := True;
end;

procedure TfrmTestDLL.btnStopClick(Sender: TObject);
begin
  Timer.Enabled := False;
end;

procedure TfrmTestDLL.TimerTimer(Sender: TObject);
begin
  FCommonTime := FCommonTime + 500;
  ValueAssignment (FCommonTime, 0, 20 * 180 / Pi);
  AccountRocking (FDeltaBetta, FDeltaEpsilon);
  lblBetta.Caption := Format ('Betta: %5.3f грд', [FDeltaBetta]);
  lblEpsilon.Caption := Format ('Betta: %5.3f грд', [FDeltaEpsilon]);
end;

procedure TfrmTestDLL.btnParametersClick(Sender: TObject);
begin
  ChamgeRockingParameters (Self.Handle);
end;

end.
