program Plastomer;

uses
  Forms,
  Unit_Main in 'Unit_Main.pas' {frmMain},
  mpiDeclaration in 'mpiDeclaration.pas',
  Unit_PlanshetCreator in 'Unit_PlanshetCreator.pas' {frmPlanshetCreator},
  mpiLasFile in 'mpiLasFile.pas',
  Unit_CaptionSaveLoad in 'Unit_CaptionSaveLoad.pas' {frmCaptionSaveLoad},
  Unit_PlanshetParam in 'Unit_PlanshetParam.pas' {frmPlanshetParam},
  Unit_GL in 'Unit_GL.pas' {frmGL},
  Unit_GLSettings in 'Unit_GLSettings.pas' {frmGLSettings},
  Unit_CalibrationCoef in 'Unit_CalibrationCoef.pas' {frmCalibrationCoef},
  Unit_SeriesValue in 'Unit_SeriesValue.pas' {frmSeriesValue},
  Unit_SeriesParam in 'Unit_SeriesParam.pas' {frmSeriesParam},
  Unit_SaveLasFile in 'Unit_SaveLasFile.pas' {frmSaveLasFile},
  Unit_GLVizualZaboyParams in 'Unit_GLVizualZaboyParams.pas' {frmGLVizualZaboyParams},
  Unit_Marks in 'Unit_Marks.pas' {frmMarks},
  Unit_SeriesTransform in 'Unit_SeriesTransform.pas' {frmSeriesTransform},
  Unit_Marks_DepthFilter in 'Unit_Marks_DepthFilter.pas' {frmMarks_DepthFilter},
  Unit_StatAnalysis in 'Unit_StatAnalysis.pas' {frmStatAnalysis},
  Unit_ReportOfWell1 in 'Unit_ReportOfWell1.pas' {frmReportOfWell1},
  mpiReportClass in 'mpiReportClass.pas',
  Unit_ReportOfWell1_Param in 'Unit_ReportOfWell1_Param.pas' {frmReportOfWell1_Param},
  mpiSaveLoadDataFile in 'mpiSaveLoadDataFile.pas',
  Unit_PrintReportOfWell1 in 'Unit_PrintReportOfWell1.pas' {frmPrintReportOfWell},
  mpiPrintReportOfWell in 'mpiPrintReportOfWell.pas',
  Unit_AutoMark in 'Unit_AutoMark.pas' {frmAutoMark},
  Unit_TransformLasFile in 'Unit_TransformLasFile.pas' {frmTransformLasFile},
  Unit_BlackWindow in 'Unit_BlackWindow.pas' {frmBlackWindow},
  Unit_PriborParam in 'Unit_PriborParam.pas' {frmPriborParam};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmPlanshetCreator, frmPlanshetCreator);
  Application.CreateForm(TfrmCaptionSaveLoad, frmCaptionSaveLoad);
  Application.CreateForm(TfrmPlanshetParam, frmPlanshetParam);
  Application.CreateForm(TfrmGLSettings, frmGLSettings);
  Application.CreateForm(TfrmCalibrationCoef, frmCalibrationCoef);
  Application.CreateForm(TfrmSeriesValue, frmSeriesValue);
  Application.CreateForm(TfrmSeriesParam, frmSeriesParam);
  Application.CreateForm(TfrmSaveLasFile, frmSaveLasFile);
  Application.CreateForm(TfrmGLVizualZaboyParams, frmGLVizualZaboyParams);
  Application.CreateForm(TfrmMarks, frmMarks);
  Application.CreateForm(TfrmSeriesTransform, frmSeriesTransform);
  Application.CreateForm(TfrmMarks_DepthFilter, frmMarks_DepthFilter);
  Application.CreateForm(TfrmStatAnalysis, frmStatAnalysis);
  Application.CreateForm(TfrmReportOfWell1, frmReportOfWell1);
  Application.CreateForm(TfrmReportOfWell1_Param, frmReportOfWell1_Param);
  Application.CreateForm(TfrmPrintReportOfWell, frmPrintReportOfWell);
  Application.CreateForm(TfrmAutoMark, frmAutoMark);
  Application.CreateForm(TfrmTransformLasFile, frmTransformLasFile);
  Application.CreateForm(TfrmBlackWindow, frmBlackWindow);
  Application.CreateForm(TfrmPriborParam, frmPriborParam);
  Application.Run;
end.
