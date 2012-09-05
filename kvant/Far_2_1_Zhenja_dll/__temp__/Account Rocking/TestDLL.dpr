program TestDLL;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmTestDLL};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTestDLL, frmTestDLL);
  Application.Run;
end.
