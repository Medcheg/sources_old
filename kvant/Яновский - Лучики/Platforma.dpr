program Platforma;

uses
  Forms,
  KVMain in 'KVMain.pas' {frmMain},
  DeclPasha in 'DeclPasha.pas',
  Unit_ConverterCoordinate in 'Unit_ConverterCoordinate.pas' {Form_ConverterCoordinate},
  Unit_ElementDataForm in 'Unit_ElementDataForm.pas' {Form_ElementData},
  Unit_GraphNameForm in 'Unit_GraphNameForm.pas' {GraphNameForm},
  Unit_OgranForm in 'Unit_OgranForm.pas' {OgranForm},
  Unit_Scheme in 'Unit_Scheme.pas' {Form_Scheme},
  Unit_SpatialWave in 'Unit_SpatialWave.pas' {Form_SpatialWave},
  Zveno in 'Zveno.pas',
  Declaration in '..\..\..\Evgeny\new\Adaptive DTS\Declaration.pas';

{$R *.RES}
{$R Kvant.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TGraphNameForm, GraphNameForm);
  Application.Run;
end.
