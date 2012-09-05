program InterfaceUpgrade;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  RefTableFrm in 'RefTableFrm.pas' {RefTableForm},
  KatalogFrm in 'KatalogFrm.pas' {KatalogForm},
  KatalogFram in 'KatalogFram.pas' {KatalogFrame: TFrame},
  TrParamsFrm in 'TrParamsFrm.pas' {TrParamsForm},
  dan_cko in 'Sour\DAN_CKO.PAS',
  TraekParams in 'TraekParams.pas',
  MatrixFrm in 'MatrixFrm.pas' {MatrixForm},
  traektor in 'Sour\Traektor.pas',
  fil_cko in 'Sour\Fil_cko.pas',
  fil_wfA in 'Sour\Fil_wfa.pas',
  matfun in 'Sour\MATFUN.PAS',
  ob_cko in 'Sour\Ob_CKO.pas',
  ob_wfa in 'Sour\Ob_wfa.pas',
  CKO in 'Sour\CKO.pas',
  XPTheme in 'XPTheme.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Пикет';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
