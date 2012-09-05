
program SeaLion;

uses
  Forms,
  Dialogs,
  windows,
  Unit_Main in 'Unit_Main.pas' {Form1},
  MPIDeclaration in 'MPIDeclaration.pas',
  PashaLibrery in 'PashaLibrery.pas',
  Unit_ProjectParam in 'Unit_ProjectParam.pas' {frmProjectParam},
  Unit_SpatialWave in 'Unit_SpatialWave.pas' {frmSpatialWave},
  Unit_KursParam in 'Unit_KursParam.pas' {frmKursParam},
  Unit_RiskanieParam in 'Unit_RiskanieParam.pas' {frmRiskanieParam},
  Unit_SpeedParam in 'Unit_SpeedParam.pas' {frmSpeedParam},
  Unit_FARParams in 'Unit_FARParams.pas' {frmFARParams},
  Unit_GeneralParam in 'Unit_GeneralParam.pas' {frmGeneralParam},
  Untit_TargetParam in 'Untit_TargetParam.pas' {frmTargetParam},
  Unit_OrbitalMoveParam in 'Unit_OrbitalMoveParam.pas' {frmOrbitalMoveParam},
  Unit_DiscretAlfaBetta in 'Unit_DiscretAlfaBetta.pas' {frmDiscretAlfaBetta},
  Unit_WhiteNoise in 'Unit_WhiteNoise.pas';

{$R *.RES}

begin

    if (Screen.Width < 1024) or (Screen.Height < 768) then
               if MessageDlg('Разрешение монитора должно быть не менее 1024т на 768т'#13#13'Некоторые информацыонные данные могут быть утеряны',mtError,[mbOk,mbCancel],0) = idCancel
               then ExitProcess(0);

    if Screen.PixelsPerInch <> 96 then
                if MessageDlg('Системный разрер шрифта должен быть 96 точек на дюйм'#13#13'Некоторые информацыонные данные могут быть утеряны',mtError,[mbOk,mbCancel],0)   = idCancel
               then ExitProcess(0);

    Application.Initialize;
    Application.Title := 'Sea Lion';
    Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmProjectParam, frmProjectParam);
  Application.CreateForm(TfrmSpatialWave, frmSpatialWave);
  Application.CreateForm(TfrmKursParam, frmKursParam);
  Application.CreateForm(TfrmRiskanieParam, frmRiskanieParam);
  Application.CreateForm(TfrmSpeedParam, frmSpeedParam);
  Application.CreateForm(TfrmFARParams, frmFARParams);
  Application.CreateForm(TfrmGeneralParam, frmGeneralParam);
  Application.CreateForm(TfrmTargetParam, frmTargetParam);
  Application.CreateForm(TfrmOrbitalMoveParam, frmOrbitalMoveParam);
  Application.CreateForm(TfrmDiscretAlfaBetta, frmDiscretAlfaBetta);
  Application.Run;
end.

