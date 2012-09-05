program Myst_Ping;

uses
  Forms,
  Windows,
  Unit_Main in 'Unit_Main.pas' {Form1},
  IcmpApi in 'Icmpapi.pas',
  Unit_Options in 'Unit_Options.pas' {frmOptions};

{$R *.RES}

var
  h : THandle;
function Check: boolean;
begin
  h := OpenMutex(MUTEX_ALL_ACCESS, false, 'Runing Myst <Ping>');
  Result := (h <> 0);
  if h = 0 then h := CreateMutex(nil, false, 'Runing Myst <Ping>');
end;

begin
  if Check() then Exit;
  Application.Initialize;
  Application.Title := 'MYST -  ÎÂ‚˚È œ»Õ√';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
