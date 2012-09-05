program Guardant_Stealth;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {Form1},
  mpiGuardantStealth in 'mpiGuardantStealth.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
