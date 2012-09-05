program NLC;

uses
  Forms,
  UMain in 'UMain.pas' {FmMain},
  glob_2 in 'glob_2.pas',
  matfun in 'MATFUN.PAS',
  RsrchFun in 'RSRCHFUN.PAS',
  sigp_J in 'sigp_j.pas',
  SpecFun in 'SPECFUN.PAS',
  unit_NLC in 'UNIT_NLC.PAS',
  unitnew1 in 'unitnew1.pas',
  ZV00 in 'Zv00.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
