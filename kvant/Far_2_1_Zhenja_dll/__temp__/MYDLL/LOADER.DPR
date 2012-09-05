program Loader;

uses
  Forms,
  LoaderU in 'LoaderU.pas' {frmLoader},
  ExempleU in 'ExempleU.pas' {frmExemple};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLoader, frmLoader);
  Application.CreateForm(TfrmExemple, frmExemple);
  Application.Run;
end.
