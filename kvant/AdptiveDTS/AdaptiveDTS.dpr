program AdaptiveDTS;

uses
  Forms,
  Declaration in 'Declaration.pas',
  dlgBFZ_Params in 'dlgBFZ_Params.pas' {frmBFZ_Params},
  dlgPU_Params in 'dlgPU_Params.pas' {frmPU_Params},
  dlgUVSO_Params in 'dlgUVSO_Params.pas' {frmUVSO_Params},
  dlgAZ_Params in 'dlgAZ_Params.pas' {frmAZ_Params},
  dlgComonIndicator in 'dlgComonIndicator.pas' {frmComonIndicator},
  dlgModelParams in 'dlgModelParams.pas' {frmModelParams},
  dlgOutBFZ1 in 'dlgOutBFZ1.pas' {frmOutBFZ1},
  dlgOutBFZ2 in 'dlgOutBFZ2.pas' {frmOutBFZ2},
  dlgOutUVSO1 in 'dlgOutUVSO1.pas' {frmOutUVSO1},
  dlgOutUVSO2 in 'dlgOutUVSO2.pas' {frmOutUVSO2},
  dlgAbonent_Params in 'dlgAbonent_Params.pas' {frmAbonent_Params},
  DeclPasha in 'DeclPasha.pas',
  Main in 'Main.pas' {frmMain},
  Unit_GraphNameForm in 'Unit_GraphNameForm.pas' {GraphNameForm},
  Unit_SpatialWave in 'Unit_SpatialWave.pas' {Form_SpatialWave},
  Unit_ElementDataForm in 'Unit_ElementDataForm.pas' {Form_ElementData},
  Unit_OgranForm in 'Unit_OgranForm.pas' {OgranForm},
  Unit_Scheme in 'Unit_Scheme.pas' {Form_Scheme},
  Unit_ConverterCoordinate in 'Unit_ConverterCoordinate.pas' {Form_ConverterCoordinate},
  dlgBK_Params in 'dlgBK_Params.pas' {frmBKParams},
  dlgPrintPreview in 'dlgPrintPreview.pas' {PrintPreviewForm},
  dlgTable in 'dlgTable.pas' {frmTable},
  tvAPIThing in 'tvAPIThing.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmComonIndicator, frmComonIndicator);
  Application.CreateForm(TfrmOutBFZ1, frmOutBFZ1);
  Application.CreateForm(TfrmOutBFZ2, frmOutBFZ2);
  Application.CreateForm(TfrmOutUVSO1, frmOutUVSO1);
  Application.CreateForm(TfrmOutUVSO2, frmOutUVSO2);
  Application.CreateForm(TGraphNameForm, GraphNameForm);
  Application.CreateForm(TForm_ElementData, Form_ElementData);
  Application.Run;
end.
