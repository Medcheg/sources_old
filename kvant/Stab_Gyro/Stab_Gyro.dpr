program Stab_Gyro;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {frmMain},
  mpiMatrix in 'mpiMatrix.pas',
  Unit_ObjectParam in 'Unit_ObjectParam.pas' {frmObjectParam},
  Unit_ProjectParam in 'Unit_ProjectParam.pas' {frmProjectParam},
  mpiTypes in 'mpiTypes.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmObjectParam, frmObjectParam);
  Application.CreateForm(TfrmProjectParam, frmProjectParam);
  Application.Run;
end.
