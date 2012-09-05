program Music;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {frmMain},
  mpiComplex in 'mpiComplex.pas',
  mpiMusic in 'mpiMusic.pas',
  mpiFFT in 'mpiFFT.pas',
  Unit_Param in 'Unit_Param.pas' {frmParam};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParam, frmParam);
  Application.Run;
end.
