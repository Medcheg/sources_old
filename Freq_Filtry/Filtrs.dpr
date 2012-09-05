program Filtrs;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {frmMain},
  MPI_Declaration in 'MPI_Declaration.pas',
  Unit_ShowResult in 'Unit_ShowResult.pas' {frmShowResult},
  MPI_Types in 'Library\MPI_Types.pas',
  MPI_Library in 'Library\MPI_Library.pas',
  Unit_AchFchParam in 'MPI_Ach_Fch_Draw\Unit_AchFchParam.pas' {frmAchFchParam},
  MPI_Ach_Fch_Draw in 'MPI_Ach_Fch_Draw\MPI_Ach_Fch_Draw.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmShowResult, frmShowResult);
  Application.CreateForm(TfrmAchFchParam, frmAchFchParam);
  Application.Run;
end.
