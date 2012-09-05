program AutoLoad ;

uses
  Forms,
  AutoU1 in 'AutoU1.pas' {frmAutoLoad};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAutoLoad, frmAutoLoad);
  Application.Run;
end.
