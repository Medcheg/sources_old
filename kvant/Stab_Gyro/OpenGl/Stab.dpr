program Stab;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {Form1},
  unit_GL in 'unit_GL.pas' {frmGL};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmGL, frmGL);
  Application.Run;
end.
