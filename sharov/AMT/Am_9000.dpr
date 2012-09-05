program Am_9000;

uses
  Forms,
  Dialogs,
  windows, SysUtils,
  Unit_Main in 'Unit_Main.pas' {Form1},
  MPIDeclaration in 'MPIDeclaration.pas',
  Unit_CaptionParam in 'Unit_CaptionParam.pas' {frmCaptionParam},
  Unit_LegentParam in 'Unit_LegentParam.pas' {frmLegentParam},
  Unit_PlanshetCreator in 'Unit_PlanshetCreator.pas' {frmPlanshetCreator},
  Unit_SeriesParam in 'Unit_SeriesParam.pas' {frmSeriesParam},
  Unit_TransformationParam in 'Unit_TransformationParam.pas' {frmTransformationParam},
  Unit_FiltrationParam in 'Unit_FiltrationParam.pas' {frmFiltrationParam},
  Unit_HeadingOfTheDiagram in 'Unit_HeadingOfTheDiagram.pas' {frmHeadingOfTheDiagram},
  Unit_PlanshetParam in 'Unit_PlanshetParam.pas' {frmPlanshetParam},
  Unit_ChoosDestop in 'Unit_ChoosDestop.pas' {frmChoosDestop},
  Unit_SaveDialog in 'Unit_SaveDialog.pas' {frmSaveDialog},
  Unit_SaveSeriesToTable in 'Unit_SaveSeriesToTable.pas' {frmSaveSeriesToTable},
  Unit_PrintPartialSeries in 'Unit_PrintPartialSeries.pas' {frmPrintPartialSeries},
  Unit_PrintPreview in 'Unit_PrintPreview.pas' {frmPrintPreview},
  Unit_SaveType in 'Unit_SaveType.pas';

{$R *.RES}

begin
  if (Screen.Width < 1024) or (Screen.Height < 768) then begin
     beep;
     if MessageDlg('Разрешение монитора должно быть не менее 1024т на 768т'#13#13'Некоторые информацыонные данные могут быть утеряны', mtError, [mbOk,mbCancel],0) = idCancel then ExitProcess(0);
  end;
  if Screen.PixelsPerInch <> 96                      then begin
     beep;
    if MessageDlg('Системный разрер шрифта должен быть 96 точек на дюйм'#13#13'Некоторые информацыонные данные могут быть утеряны',mtError,[mbOk,mbCancel]    ,0) = idCancel then ExitProcess(0);
  end;
  Application.Initialize;
  Application.Title := 'Автономный манометр-термометр АМТ';
  Application.CreateForm(TfrmChoosDestop, frmChoosDestop);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmCaptionParam, frmCaptionParam);
  Application.CreateForm(TfrmLegentParam, frmLegentParam);
  Application.CreateForm(TfrmPlanshetCreator, frmPlanshetCreator);
  Application.CreateForm(TfrmSeriesParam, frmSeriesParam);
  Application.CreateForm(TfrmTransformationParam, frmTransformationParam);
  Application.CreateForm(TfrmFiltrationParam, frmFiltrationParam);
  Application.CreateForm(TfrmHeadingOfTheDiagram, frmHeadingOfTheDiagram);
  Application.CreateForm(TfrmPlanshetParam, frmPlanshetParam);
  Application.CreateForm(TfrmSaveDialog, frmSaveDialog);
  Application.CreateForm(TfrmSaveSeriesToTable, frmSaveSeriesToTable);
  Application.CreateForm(TfrmPrintPartialSeries, frmPrintPartialSeries);
  Application.CreateForm(TfrmPrintPreview, frmPrintPreview);
  Application.Run;
end.
