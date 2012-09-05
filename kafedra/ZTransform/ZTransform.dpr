program ZTransform;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {Form1},
  MPIDeclaration in 'MPIDeclaration.pas',
  MPITypes in 'MPITypes.pas',
  Unit_ShowResult in 'Unit_ShowResult.pas' {frmShowResult},
  Unit_GraphAndTable1 in 'Unit_GraphAndTable1.pas' {frmGraphAndTable1},
  Unit_ACH_FCH in 'Unit_ACH_FCH.pas' {frmACH_FCH},
  MPILibrary in 'MPILibrary.pas',
  Unit_AchFchParam in 'Unit_AchFchParam.pas' {frmAchFchParam};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmShowResult, frmShowResult);
  Application.CreateForm(TfrmGraphAndTable1, frmGraphAndTable1);
  Application.CreateForm(TfrmACH_FCH, frmACH_FCH);
  Application.CreateForm(TfrmAchFchParam, frmAchFchParam);
  Application.Run;
end.
