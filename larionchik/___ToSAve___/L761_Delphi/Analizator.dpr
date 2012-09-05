program Analizator;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {Form1},
  MPIDeclaration in 'MPIDeclaration.pas',
  Unit_ReadACPData in 'Unit_ReadACPData.pas' {frmReadACPData},
  Unit_SetACPParam in 'Unit_SetACPParam.pas' {frmSetACPParam},
  Unit_FFT_Param in 'Unit_FFT_Param.pas' {frmFFT_Param},
  Unit_FFTShowResult in 'Unit_FFTShowResult.pas' {frmFFTShowResult},
  Unit_About in 'Unit_About.pas' {frmAbout},
  Unit_FindMinMax in 'Unit_FindMinMax.pas' {frmFindMinMax},
  mpiFilters in 'mpiFilters.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmSetACPParam, frmSetACPParam);
  Application.CreateForm(TfrmReadACPData, frmReadACPData);
  Application.CreateForm(TfrmFFT_Param, frmFFT_Param);
  Application.CreateForm(TfrmFFTShowResult, frmFFTShowResult);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmFindMinMax, frmFindMinMax);
  Application.Run;
end.
