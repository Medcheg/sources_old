unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls, Menus, ActnList, ImgList, Buttons,
  mpiDeclaration;

type
  TfrmMain = class(TForm)
    Panel5: TPanel;
    ControlBar1: TControlBar;
    tb1: TToolBar;
    tb2: TToolBar;
    ToolButton1: TToolButton;
    tbPlanshet: TToolButton;
    ToolButton3: TToolButton;
    tbNew: TToolButton;
    tbOpen: TToolButton;
    tbSave: TToolButton;
    pmFile: TPopupMenu;
    miNew: TMenuItem;
    N4: TMenuItem;
    miExit: TMenuItem;
    N1: TMenuItem;
    miLoadLasFile: TMenuItem;
    miSaveLasFile: TMenuItem;
    ActionList1: TActionList;
    aExit: TAction;
    aNew: TAction;                                     
    aOpenLasFile: TAction;
    aSaveLasFile: TAction;
    OpenDialog1: TOpenDialog;
    pmSettings: TPopupMenu;
    miCalibration: TMenuItem;
    miPriborParam: TMenuItem;
    pBackGround: TPanel;
    pBottom: TPanel;
    Panel6: TPanel;
    ScrollBar1: TScrollBar;
    tbPlastomerParam: TToolButton;
    N2: TMenuItem;
    miPrintScreen: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel1: TPanel;
    pTrackBar: TPanel;
    tbMashtab: TTrackBar;
    Panel4: TPanel;
    aPrintScreen: TAction;
    ilMainToolBar: TImageList;
    ToolButton7: TToolButton;
    tbMouse: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    tbStartMark: TToolButton;
    tbEndMark: TToolButton;
    ToolButton9: TToolButton;
    tbAutoMark: TToolButton;
    ToolButton11: TToolButton;
    tbOtmetki: TToolButton;
    tbOtmetkiPanel: TToolButton;
    Edit1: TEdit;
    aCalibration: TAction;
    aPriborParam: TAction;
    aMatematParam: TAction;
    N5: TMenuItem;
    miMatematParam: TMenuItem;
    ToolButton5: TToolButton;
    pmService: TPopupMenu;
    aSeriesTransform: TAction;
    N3: TMenuItem;
    pmHeadFunction: TPopupMenu;
    miSeriesTransform: TMenuItem;
    N7: TMenuItem;
    miDeleteSeries: TMenuItem;
    miAddSeriesToPole: TMenuItem;
    aStatAnalysis: TAction;
    N6: TMenuItem;
    N8: TMenuItem;
    ToolButton6: TToolButton;
    aReportOfWell1: TAction;
    Panel2: TPanel;
    Label8: TLabel;
    Animate1: TAnimate;
    N9: TMenuItem;
    aSaveLasData: TAction;
    Las1: TMenuItem;
    ImageList1: TImageList;
    Image1: TImage;
    Panel3: TPanel;
    bCheckApsidalAngle: TSpeedButton;
    bKoreljationWindow: TSpeedButton;
    Panel7: TPanel;
    pmDeleteMark: TPopupMenu;
    MenuItem1: TMenuItem;
    ToolButton8: TToolButton;
    Timer_1: TTimer;
    Timer_5: TTimer;
    Timer_10: TTimer;
    Timer_20: TTimer;
    Timer_40: TTimer;
    Timer_50: TTimer;
    pmReportOfWell: TPopupMenu;
    miReport1: TMenuItem;
    miReport2: TMenuItem;
    aReportOfWell2: TAction;
    aTransformLasFile: TAction;
    N10: TMenuItem;
    Las2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aOpenLasFileExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure aPlanshetParamExecute(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure aNewExecute(Sender: TObject);
    procedure tbPlanshetClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1DblClick(Sender: TObject);
    procedure aSaveLasFileExecute(Sender: TObject);
    procedure tbMashtabChange(Sender: TObject);
    procedure pTrackBarClick(Sender: TObject);
    procedure aPrintScreenExecute(Sender: TObject);
    procedure tbClick(Sender: TObject);
    procedure tbAutoMarkClick(Sender: TObject);
    procedure tbOtmetkiPanelClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure tbEndMarkClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbOtmetkiClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure aCalibrationExecute(Sender: TObject);
    procedure aSeriesTransformExecute(Sender: TObject);
    procedure miSeriesTransformClick(Sender: TObject);
    procedure miDeleteSeriesClick(Sender: TObject);
    procedure miAddSeriesToPoleClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure aStatAnalysisExecute(Sender: TObject);
    procedure aReportOfWell1Execute(Sender: TObject);
    procedure aSaveLasDataExecute(Sender: TObject);
    procedure bKoreljationWindowClick(Sender: TObject);
    procedure Panel3DblClick(Sender: TObject);
    procedure ScrollBar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bCheckApsidalAngleClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MenuItem1Click(Sender: TObject);
    procedure ScrollBar1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButton8Click(Sender: TObject);
    procedure tb1Click(Sender: TObject);
    procedure Timer_1Timer(Sender: TObject);
    procedure Timer_5Timer(Sender: TObject);
    procedure Timer_10Timer(Sender: TObject);
    procedure Timer_20Timer(Sender: TObject);
    procedure Timer_40Timer(Sender: TObject);
    procedure Timer_50Timer(Sender: TObject);
    procedure aReportOfWell2Execute(Sender: TObject);
    procedure aTransformLasFileExecute(Sender: TObject);
    procedure aPriborParamExecute(Sender: TObject);
  private
     FirstPaint          : Boolean;
     OldTrackBarPosition : Integer;
     MouseCoordinate     : TPoint;
     InputString         : String;


     tbArray              : array [0..1] of TToolButton;
     EndMarkInput_Enabled : Boolean;

     function  CheckLoadedLasFile():Boolean;
     function  CheckPresentSeriesInLasFile(InputParam : TInputParam; b1, b2, b3 : String):boolean;
     function  CheckModifiedProject_AndSaveProject():integer;

     procedure New_or_FillCharParam();
     procedure LoadLasFile(FileName : String);
     procedure CheckPresentDerictories();

     procedure WM_Control(var Msg: TMsg; var Handled: Boolean);
     procedure Get_MinMaxInfo(var msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
     procedure LoadFromFileFromMenuStack(Sender: TObject);
  public
     procedure SetFormCaption();
     procedure Set_ScrollBarParam();
  end;

var
  frmMain: TfrmMain;

implementation

uses mpiLasFile, Unit_PlanshetCreator, Unit_CaptionSaveLoad,
  Unit_GL, Unit_CalibrationCoef, Unit_SeriesValue, Unit_SeriesParam, Printers,
  Unit_SaveLasFile, Unit_Marks, Unit_SeriesTransform,
  Unit_Marks_DepthFilter, Unit_StatAnalysis, Unit_ReportOfWell1,
  Unit_ReportOfWell1_Param, mpiReportClass, mpiSaveLoadDataFile,
  Unit_AutoMark, mpiFileMenuStack, mpiAPI, mpiGuardantStealth,
  Unit_TransformLasFile, mpiLibrary, Unit_BlackWindow,
  Unit_PriborParam, Unit_About, Unit_ReportOfWell2;

{$R *.DFM}

{===============================================================================
}
procedure TfrmMain.CheckPresentDerictories();
begin
  CreateDir(ExtractFilePath(Application.ExeName) + 'Калибровка');
  CreateDir(ExtractFilePath(Application.ExeName) + 'LasData');
end;

{===============================================================================
}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
    KeyReg(Handle, ktSnapShot);
//    KeyReg(Handle, ktCtrl);
  // -------------------------
    Icon.Transparent := true;
  // ----------------------------
     CheckPresentDerictories();
  // ----------------------------
    InitialDir := ExtractFilePath(Application.ExeName) + 'Las\';
    if not SetCurrentDir(InitialDir) then InitialDir := ExtractFilePath(Application.ExeName);

  DecimalSeparator    := '.';
  FirstPaint          := True;
  OldTrackBarPosition := -100;
  InputString         := '';

  tbArray[0]          := tbMouse;
  tbArray[1]          := tbStartMark;

  EndMarkInput_Enabled := True;

  Edit1.left          := -100;
  EDit1.Top           := -100;

{  if FileName <> '' then begin
     if ExtractFileExt(ProjectFileName) <> '.spr' then ExitProcess(0)
                                                  else LoadProjectFile();
  end else ProjectFileName := ExtractFilePath(Application.ExeName)+'default.spr';}

   SetFormCaption();
   AddNewFileToMainMenu(pmFile, 'Load', LoadFromFileFromMenuStack);
  // ---------
   Application.OnMessage := WM_Control;
end;

{===============================================================================
}
procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if CheckModifiedProject_AndSaveProject() = mrCancel then CanClose := false;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
   Planshet.Free;
   if LasFile     <> nil then LasFile.Free;
   if ReportClass <> nil then ReportClass.Free;

   KeyReg(Handle, ktSnapShot);
//   KeyReg(Handle, ktCtrl);
end;

{===============================================================================
}
procedure TfrmMain.Get_MinMaxInfo(var msg: TWMGetMinMaxInfo);
begin
  msg.MinMaxInfo.ptMinTrackSize  := Point(800,600);
  tb1.Width       := ControlBar1.Width;
  tb2.Width       := ControlBar1.Width;
//  Left            := -4;
//  Top             := -4;
end;

{===============================================================================
}
procedure TfrmMain.FormResize(Sender: TObject);
begin
  if Planshet <> nil then begin
    Planshet.draw(False);
    Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  end;
end;

{===============================================================================
}
procedure TfrmMain.FormPaint(Sender: TObject);
begin
  if FirstPaint then begin
//     Image1.Picture.Bitmap.PixelFormat := pf4bit;

     Planshet := TPlanshet.Create(Image1.Picture.Bitmap,
                                  Image1.Canvas,
                                  @Image1.Width,
                                  @Image1.Height);

     Planshet .ScrollBarMax := addr(ScrollBar1.max);
     Planshet .draw(False);
     //-------------
     if ParamStr(1) <> '' then begin
        if UpperCase(ExtractFileExt(ParamStr(1))) = '.LAS' then LoadLasFile(ParamStr(1))
                                                          else begin MessageDlg('Программа PLASTOMER работает только с входными файлами типа "LAS"', mtWarning, [mbOk], 0); ExitProcess(0) end;
     end;
     //-------------
  end;
  FirstPaint := False;
end;

{===============================================================================
}
procedure TfrmMain.SetFormCaption();
var
  TempString : String;
begin
  TempString := '';
  if LasFile <> nil then
     if LasFile.CalibrationFactor then TempString := '[Данные откалиброваны] - ';
  //------------
  if LasFile <> nil then Caption := frmMainCaption + TempString + '[' + LasFile.FileName + ']'
                    else Caption := frmMainCaption + TempString + '[]'
end;

{===============================================================================
}
procedure TfrmMain.aExitExecute(Sender: TObject);
begin
  Close;
end;

{===============================================================================
}
procedure TfrmMain.aOpenLasFileExecute(Sender: TObject);
var
 FileName : String;
begin
  Application.ProcessMessages;
  // ----------------------
   if CheckModifiedProject_AndSaveProject() = mrCancel then exit;
  // --- Параметры Open Диалога ----
   OpenDialog1.Title      := frmMainCaption + 'Отрытие "Las" файлa';
   OpenDialog1.Filter     := 'Las файл (*.las)|*.las';
   OpenDialog1.InitialDir := InitialDir;
   OpenDialog1.FileName   := '';
  //------------------------------
   if OpenDialog1.Execute then begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             // ------- Проверка на измененность проекта --------   //if Modified then  if ShowAndGetResultDialogBox() = mrCancel then exit; // ------- End of Проверка на измененность проекта --------
       FileName := OpenDialog1.FileName;
       if ExtractFileExt(FileName) = '' then FileName := FileName + '.las';

       New_or_FillCharParam();

       LoadLasFile(FileName);
     // -------------
       AddNewFileToMainMenu(pmFile, FileName, LoadFromFileFromMenuStack);
     // -------------
       InitialDir := ExtractFilePath(FileName);
   end;
  // --------------------------------
   LasFileModified := false;
  // --------------------------------
   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
   Planshet.draw(false);
end;

{===============================================================================
}
procedure TfrmMain.LoadFromFileFromMenuStack(Sender: TObject);
begin
  if FileExists(FileNameStackArray[TMenuItem(Sender).Tag - 10]) then begin
       New_or_FillCharParam();
       LoadLasFile(FileNameStackArray[TMenuItem(Sender).Tag - 10]);
       AddNewFileToMainMenu(pmFile, FileNameStackArray[TMenuItem(Sender).Tag - 10], LoadFromFileFromMenuStack);
  end else MessageDlg('Неверно указаны имя файла или путь к нему. Попробуйте выполнить следующие действия.'#10#13'* Проверте разрешения на доступ к документу или диску.'#10#13'* Для поиска документа воспользуйтесь окном "Загрузить Las файл".'#10#13'('+FileNameStackArray[TMenuItem(Sender).Tag - 10]+')', mtWarning, [mbOk],0);
end;

{===============================================================================
}
procedure TfrmMain.LoadLasFile(FileName: String);
var
  i, k  : Integer;
  Series : TSeries;
  fn     : String;
begin
  if UpperCase(ExtractFileExt(FileName)) <> '.LAS' then exit;

  fn := ExtractFileName(FileName); SetLength(fn, Length(fn)-4); fn := fn +'.ld';

  frmCaptionSaveLoad.aCaption := 'Загрузка файла';
  frmCaptionSaveLoad.Show;
  Application.ProcessMessages;

  // -------- Загрузка ---------------
     try
        LasFile     := TLasFile.Create(FileName, lfNormalLasFile);
     except
        beep;
        MessageDlg('Ошибка загрузки '#$27'Las'#$27' файла.'#10#13'Проверте '#$27'Las'#$27' файл ... (возможно '#$27'Las'#$27' "плохой")'#10#13#$27'Las'#$27' не загружен ....', mtError, [mbOk],0);
        frmCaptionSaveLoad.Close;
        Exit;
     end;
     try
     LoadDataFile();
     except
        beep;
        MessageDlg('Ошибка загрузки файла данных к '#$27'Las'#$27' файлу.'#10#13'Пожалуйста удалите файл '#39 + fn +#39' c папки '#39'LasData'#39' всеми доступными методами ...', mtError, [mbOk],0);
        frmCaptionSaveLoad.Close;
        Exit;
     end;
     Planshet.xValues := Tseries(LasFile.SeriesList.items[0]);
  // ------ End of Загрузка ---------------
     SetFormCaption();

  frmPlanshetCreator.SetParam();
  frmCaptionSaveLoad.Close;
  Application.ProcessMessages;

  //-----------------
        for k := 0 to 2 do begin
            frmPlanshetCreator.cbArray[k].Checked := PlanshetParam.Pole_Visible[k];
            Planshet.PoleArray[k].Visible         := PlanshetParam.Pole_Visible[k];
        end;
        Planshet.CalcPositionPole();
      // --------
        frmSeriesValue.Updated := false;
        for k := 0 to 2 do
           for i := 0 to PlanshetParam.CountSeriesPole[k] - 1 do begin
              if (PlanshetParam.SeriesListPole[k][i].index < LasFile.SeriesList.Count) and (PlanshetParam.SeriesListPole[k][i].index <> -1) then begin
                 Series := TSeries(LasFile.SeriesList.Items[PlanshetParam.SeriesListPole[k][i].index]);
                 frmPlanshetCreator.AddSeries(k, Series);

                 Series.PenColor := PlanshetParam.SeriesListPole[k][i].PenColor;
                 Series.PenStyle := TPenStyle(PlanshetParam.SeriesListPole[k][i].PenStyle);
                 Series.PenWidth := PlanshetParam.SeriesListPole[k][i].PenWidth;

                 if PlanshetParam.SeriesListPole[k][i].fMin <> -1 then Series.CorrectMinValue := PlanshetParam.SeriesListPole[k][i].fMin;
                 if PlanshetParam.SeriesListPole[k][i].fMax <> -1 then Series.CorrectMaxValue := PlanshetParam.SeriesListPole[k][i].fMax;
                 if Planshet.PoleArray[k].Visible                 then Series.coefY := (Planshet.PoleArray[k].PoleRect.Bottom - Planshet.PoleArray[k].PoleRect.Top) / ( Series.CorrectMaxValue - Series.CorrectMinValue );
              end;
           end;
       // -----------

       tbOtmetki.Down       := PlanshetParam.OtmetkiVisible;
       Planshet.MarkEnabled := PlanshetParam.OtmetkiVisible;
       tbOtmetkiPanel.Down  := PlanshetParam.ListOtmetkiVisible;

       if (PlanshetParam.WindowsValuePosition.x <> -1) and (PlanshetParam.WindowsValuePosition.y <> -1) then begin
           if PlanshetParam.WindowsValuePosition.x > Screen.Width  - 100 then PlanshetParam.WindowsValuePosition.x := Screen.Width - 100;
           if PlanshetParam.WindowsValuePosition.y > Screen.Height - 100 then PlanshetParam.WindowsValuePosition.y := Screen.Height - 100;
           frmSeriesValue.Left := PlanshetParam.WindowsValuePosition.x;
           frmSeriesValue.Top  := PlanshetParam.WindowsValuePosition.y;
       end;
       if (PlanshetParam.WindowsOtmetkiValue.x <> -1) and (PlanshetParam.WindowsOtmetkiValue.y <> -1) then begin
           if PlanshetParam.WindowsOtmetkiValue.x > Screen.Width  - 100 then PlanshetParam.WindowsOtmetkiValue.x := Screen.Width - 100;
           if PlanshetParam.WindowsOtmetkiValue.y > Screen.Height - 100 then PlanshetParam.WindowsOtmetkiValue.y := Screen.Height - 100;
           frmMarks.Left := PlanshetParam.WindowsOtmetkiValue.x;
           frmMarks.Top  := PlanshetParam.WindowsOtmetkiValue.y;
       end;

  //-----------------
     ReportClass := TReportClass.Create(frmReportOfWell1.Image1.Canvas, frmReportOfWell1.Image1.Width, frmReportOfWell1.Image1.Height);
     SetFormParamReportClass();
  //-----------------
    frmSeriesValue.Updated := True;
    frmSeriesValue.Show;
    frmSeriesValue.SetParam();
    frmSeriesValue.Visible := True;
    Self.SetFocus;
  //-----------------
   if tbOtmetkiPanel.Down then frmMarks.Show;
  //-----------------
    aSaveLasFile     .Enabled := True;
    aPrintScreen     .Enabled := True;
    aNew             .Enabled := True;
    aSaveLasData     .Enabled := True;
    aTransformLasFile.Enabled := False;
  //-----------------
    bKoreljationWindow.Visible := true;
    bCheckApsidalAngle.Visible := true;
  //-----------------
    frmStatAnalysis.Edit1.text := '0';
    frmStatAnalysis.Edit2.text := '0';
  //-----------------
    Set_ScrollBarParam();
  // -----------
     tbMashtab.Position  := PlanshetParam.MashtabCoef;
     ScrollBar1.Position := PlanshetParam.ScrollBarPos;
  // -----------
  Planshet .draw(False); // Planshet.draw(True);
  Planshet .AssignedBitmap := not Planshet.AssignedBitmap;

  frmSeriesValue.Show;
  Self.SetFocus;
end;

{===============================================================================
}
procedure TfrmMain.WM_Control(var Msg: TMsg; var Handled: Boolean);
var StrArray : array [0..3] of String;
    MaxLength : Integer;
    i         : Integer;
    aHeightText :Integer;
begin
  if Msg.message = WM_keyDown then begin
    if Msg.wParam = vk_COntrol then begin
       if (tbOtmetki.Down) and (Planshet.SelectedMark <> nil)then begin
           Image1.Canvas.Pen.Color  := clBlue;
           Image1.Canvas.Pen.Width  := 2;
           Image1.Canvas.Font.Size  := 8;
           Image1.Canvas.Font.Style := [fsBold];

           StrArray[0] := 'Глубина : '               + FloatToStrF(Planshet.SelectedMark^.fCurrentDepth, ffFixed, 12, 4) + ' м';
           StrArray[1] := 'Достоверность : '         + FloatToStrF((Planshet.SelectedMark^.kArray[0].Kor + Planshet.SelectedMark^.kArray[1].Kor)/2, ffFixed, 12, 4);
           StrArray[2] := 'Угол падения пласта : '   + FloatToStrF(Planshet.SelectedMark^.Alfa_1*180/pi, ffFixed, 12, 4) + ' гр';
           StrArray[3] := 'Азимут падения пласта : ' + FloatToStrF(Planshet.SelectedMark^.Teta_1*180/pi, ffFixed, 12, 4) + ' гр';

           MaxLength := -1;
           for i := 0 to 3 do
              if MaxLength < Image1.Canvas.TextWidth(StrArray[i]) then MaxLength := Image1.Canvas.TextWidth(StrArray[i]);
           MaxLength := MaxLength + 20;

           aHeightText := Image1.Canvas.TextHeight('0');


           Image1.Canvas.Rectangle(MouseCoordinate.x-MaxLength-10, MouseCoordinate.y+5, MouseCoordinate.x - 5, MouseCoordinate.y+round(6.5*aHeightText)+5);
           Image1.Canvas.TextOut(MouseCoordinate.x-MaxLength-5, MouseCoordinate.y+ 5 + round(0.5*aHeightText),StrArray[0]);
           Image1.Canvas.TextOut(MouseCoordinate.x-MaxLength-5, MouseCoordinate.y+ 5 + round(2.0*aHeightText),StrArray[1]);
           Image1.Canvas.TextOut(MouseCoordinate.x-MaxLength-5, MouseCoordinate.y+ 5 + round(3.5*aHeightText),StrArray[2]);
           Image1.Canvas.TextOut(MouseCoordinate.x-MaxLength-5, MouseCoordinate.y+ 5 + round(5.0*aHeightText),StrArray[3]);

           Handled := true;
       end;
    end;
  end;
end;

{===============================================================================
}
procedure TfrmMain.aSaveLasFileExecute(Sender: TObject);
begin
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6           then prov7 := Check_Guardant_Stealth_7();
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 then prov8 := Check_Guardant_Stealth_8();
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then begin
       Application.ProcessMessages;
      //--------------------------
       if frmSaveLasFile.ShowModal = mrOk then begin
          //caption := '123';
       end;
      // ---
       SetFormCaption();
   end else begin
      MessageDlg('Запись файла в демо режиме отключена'#10#13'Для отмены демо режима необходимо:'#10#13'   1. Закрыть программу.'#10#13'   2. Вставить электронный ключ поставляемый с программой в USB разъем компьютера.'#10#13'   3. Запустить программу.', mtWarning, [mbok], 0);
   end;
end;

{===============================================================================
}
procedure TfrmMain.aPrintScreenExecute(Sender: TObject);
var
  PrintBitmap : TBitmap;
begin
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6           then prov7 := Check_Guardant_Stealth_7();
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 then prov8 := Check_Guardant_Stealth_8();
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then begin
        Printer.Orientation := poLandscape;

        if PrinterSetupDialog1.Execute then begin
           // ---------------
           PlanshetFoneColor := clWhite;
           Planshet.draw(True);
           Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
           Application.ProcessMessages;
           // ---------------

           PrintBitmap := TBitmap.Create;
           PrintBitmap.Assign(Planshet.ReDrawBitmap);
           PrintBitmap.PixelFormat := pf4Bit;

           Printer.BeginDoc;
           with Printer.Canvas do begin
               StretchDraw(Rect(Round(Printer.PageWidth *0.13),
                                Round(Printer.PageHeight*0.07),
                                Round(Printer.PageWidth *0.93),
                                Round(Printer.PageHeight*0.93)), PrintBitmap);

               Font.Size  := 12;
               Font.Style := [fsBold];
               TextOut((Printer.PageWidth - TextWidth(LasFile.FileName)) div 2, Round(Printer.PageHeight*0.04), LasFile.FileName)
           end;
           Printer.EndDoc;

           // ---------------
           PrintBitmap.Free;
           PlanshetFoneColor := RGB(200 ,200, 178);
           Planshet.draw(True);
           Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
           Application.ProcessMessages;
           // ---------------
        end;
   end else begin
      MessageDlg('Печать экрана в демо режиме отключена'#10#13'Для отмены демо режима необходимо:'#10#13'   1. Закрыть программу.'#10#13'   2. Вставить электронный ключ поставляемый с программой в USB разъем компьютера.'#10#13'   3. Запустить программу.', mtWarning, [mbok], 0);
   end;
end;

{===============================================================================
}
procedure TfrmMain.Set_ScrollBarParam();
var
  TempMaxValue : int64;
begin
  if Planshet.xValues = nil then exit;
  //------------------
  if Planshet.MashtabCoef >= 1 then TempMaxValue := Planshet.xValues.Count div Planshet.MashtabCoef -  (Planshet.PoleArray[0].PoleRect.Right - Planshet.PoleArray[0].PoleRect.Left) + 20
                               else TempMaxValue := round(Planshet.xValues.Count * (-Planshet.MashtabCoef)) -  (Planshet.PoleArray[0].PoleRect.Right - Planshet.PoleArray[0].PoleRect.Left) + 20;

  if TempMaxValue <= 0 then  TempMaxValue := 20;//Planshet.xValues.Count;

  if TempMaxValue >= High(Integer) then begin
    Beep();
    MessageDlg('Достигнуто максимальное значение маштабирования кривой ...'#10#13'Кликните на панеле маштабирования ...', mtInformation, [mbOk], 0);
    exit;
  end;
  //------------------
  ScrollBar1.Max         :=  TempMaxValue;
  ScrollBar1.Min         := -20;
  ScrollBar1.Position    :=  0;
  ScrollBar1.SmallChange :=  10;
  ScrollBar1.LargeChange :=  Image1.Width div 4;
end;

{===============================================================================
}
procedure TfrmMain.ScrollBar1Change(Sender: TObject);
begin
  if not tbStartMark.down then begin
     Planshet.AssignedBitmap  := False;
     Planshet.ScrollBarOffset := ScrollBar1.Position;
     Planshet.draw(False);
     // ----------------
  end else begin
     ScrollBar1.Position := Planshet.ScrollBarOffset;
     Edit1.SetFocus;
  end;
end;

{===============================================================================
}
function TfrmMain.CheckLoadedLasFile(): Boolean;
begin
   Result := True;
   if LasFile <> nil then exit;

   Beep();
   MessageDlg('Загрузите "Las" файл'#13#10#13#10'Пункт меню " Файл " -> "Загрузить "Las" файл"', mtInformation, [mbOk], 0);
   result := False;
end;

{===============================================================================
}
procedure TfrmMain.aPlanshetParamExecute(Sender: TObject);
begin
//
end;

{===============================================================================
}
procedure TfrmMain.tbPlanshetClick(Sender: TObject);
begin
   if CheckLoadedLasFile() then frmPlanshetCreator.showModal;
end;

{===============================================================================
}
procedure TfrmMain.ToolButton3Click(Sender: TObject);
begin
   if CheckLoadedLasFile() then begin
      frmGL := TfrmGl.Create(nil);
      frmGL.ShowModal;
      frmGL.Free;
   end;
end;

{===============================================================================
}

procedure TfrmMain.New_or_FillCharParam();
begin
  if LasFile <> nil then begin
           tbClick(tbarray[0]);
          // ----------------------
           SetDefaultParamForPlanshet();
           SetDefaultParamForReportClass();
          // ----------------------
           LasFile    .Free;
           ReportClass.Free;
          // -------------------
           SetLength(MarkArray, 0);
           frmMarks.close;
          // ----------------------
           LasFile     := nil;
           ReportClass := nil;
          // ----------------------
           frmPlanshetCreator.lbPole1 .Items.Clear;
           frmPlanshetCreator.lbPole2 .Items.Clear;
           frmPlanshetCreator.lbPole3 .Items.Clear;
           frmPlanshetCreator.lbSeries.Items.Clear;
           frmPlanshetCreator.tbRemoveSeries.Enabled := False;

           frmSeriesValue.Visible := false;

           Planshet.PoleArray[0].SeriesList.Clear;
           Planshet.PoleArray[1].SeriesList.Clear;
           Planshet.PoleArray[2].SeriesList.Clear;
           Planshet.PoleArray[0].xValues := nil;
           Planshet.PoleArray[1].xValues := nil;
           Planshet.PoleArray[2].xValues := nil;
           Planshet.xValues              := nil;

          // ----------------------
           Planshet.CalcPositionPole;
           Planshet.draw(False);
           Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
          //------------

           aSaveLasFile     .Enabled := False;
           aPrintScreen     .Enabled := False;
           aNew             .Enabled := False;
           aSaveLasData     .Enabled := False;

           aTransformLasFile.Enabled := True;
          // -----------
           SetFormCaption();
          // -----------
           frmSeriesValue.SetParam();
          // -----------
          bKoreljationWindow.Visible := false;
          bCheckApsidalAngle.Visible := false;
  end;
  LasFileModified := false;
end;

procedure TfrmMain.aNewExecute(Sender: TObject);
begin
   Application.ProcessMessages;
  // --------------------------
   if CheckModifiedProject_AndSaveProject() = mrCancel then exit;
  // -----------------------
   New_or_FillCharParam();
end;

{===============================================================================
}
procedure TfrmMain.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Planshet            = nil  then exit;
  if Planshet.xValues    = nil  then exit;
  if LasFile             = nil  then exit;
  if Planshet.PolesCount = 0    then exit;
  if frmCaptionSaveLoad.Visible then exit;


  MouseCoordinate := point(x,y);


  Planshet.AssignedBitmap := true;
  Planshet.ReDraw;

  Planshet.Set_MouseCoordinate(x, y);

  //----------------
{  if Planshet.WhereIAm = wiaPole then caption := 'WhereIAm = wiaPole ';
  if Planshet.WhereIAm = wiaHead then caption := 'WhereIAm = wiaHead ';
  if Planshet.WhereIAm = wiaNone then caption := 'WhereIAm = wiaNone ';
  Caption := Caption + '  CurrentPole = ' + intToStr(Planshet.CurrentPole) + '  NumberSeries = ' + IntToStr(Planshet.NumberSeries)}
  //----------------
end;

{===============================================================================
}
procedure TfrmMain.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Planshet = nil             then exit;
  if LasFile  = nil             then exit;
  if Planshet.PolesCount = 0    then exit;
  if frmCaptionSaveLoad.Visible then exit;

  case Planshet.WhereIAm of
     wiaHead : if (Shift = [ssRight]) and (Planshet.CurrentSeries <> nil) then pmHeadFunction.Popup(Image1.ClientToScreen(Point(x, y)).x, Image1.ClientToScreen(Point(x, y)).y);
     wiaPole : if (Shift = [ssRight]) and (Planshet.SelectedMark  <> nil) and (tbOtmetki.Down) then pmDeleteMark.Popup(Image1.ClientToScreen(Point(x, y)).x, Image1.ClientToScreen(Point(x, y)).y);
  end;
end;

{===============================================================================
}
procedure TfrmMain.Image1DblClick(Sender: TObject);
begin
  if Planshet = nil               then exit;
  if LasFile  = nil               then exit;
  if Planshet.PolesCount = 0      then exit;
  if frmCaptionSaveLoad.Visible   then exit;
  if Planshet.CurrentSeries = nil then exit;

  frmSeriesParam.SetParam(Planshet.CurrentSeries);
  frmSeriesParam.ShowModal;
end;

{===============================================================================
}
procedure TfrmMain.tbMashtabChange(Sender: TObject);
begin
   if LasFile = nil then exit;

   if OldTrackBarPosition = tbMashtab.Position then exit;

   if tbMashtab.Position >= 1 then Planshet.MashtabCoef := tbMashtab.Position
                              else Planshet.MashtabCoef := tbMashtab.Position - 1;
   Planshet.draw(false);
   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;

   Set_ScrollBarParam();
   OldTrackBarPosition := tbMashtab.Position;
   if tbMashtab.Position >= 1 then pTrackBar.Caption := '1:' + IntToStr(tbMashtab.Position)
                              else pTrackBar.Caption := IntToStr(-tbMashtab.Position+1) + ':1';
  // ----------------
   if tbStartMark.Down then Edit1.SetFocus;
end;

{===============================================================================
}
procedure TfrmMain.pTrackBarClick(Sender: TObject);
begin
  tbMashtab.Position := 1;
end;

{===============================================================================
}
procedure TfrmMain.tbClick(Sender: TObject);
var
  i : integer;
  flag : Boolean;
  ShortName : String;
  CurVisiblePole : TPole;
begin
  // ----------------------------------------
   Planshet.InputMarks := False;
   if not CheckLoadedLasFile() then begin
      tbStartMark.Down := False;
      exit;
   end;
  // ----------------

   if tbStartMark.Down then ScrollBar1.SetFocus;
  // ----- Поднятие всех бутонов ---------
   for i := 0 to Length(tbArray) - 1 do tbArray[i].Down := False;
  // ----- Опускаем ботон который нуно ----------
   TToolButton(Sender).Down := True;
  // -----------
   if TToolButton(Sender).Name = 'tbMouse' then begin
        if not EndMarkInput_Enabled then
           if (Length(MarkArray) <> 0) and Planshet.PoleMouseDownPresent then
                 SetLength(MarkArray, Length(MarkArray) - 1);

        EndMarkInput_Enabled := true;

        Planshet.PoleMouseDownPresent := False;

        Planshet.DeSelectSeries();
        Planshet.draw(false);
        Planshet.AssignedBitmap := not Planshet.AssignedBitmap;

        frmMarks.OtputMarks();
   end;
  // ----------
   if TToolButton(Sender).Name = 'tbStartMark' then begin
       // ---- Проверяем включино ли одно поле -------------
        if Planshet.PolesCount <> 1 then begin
            Beep();
            MessageDlg('В режиме ввода отметок необходимо работать на одном поле !!!', mtError, [mbOk], 0);
            tbClick(tbArray[0]);
            exit;
        end;
       // ---- Проверка : "Три первых кривых должны быть БМК"
        Flag           := False;
        CurVisiblePole := nil;
       // ------ текущее поле на планшете ------------------
        for i := 0 to 2 do
            if Planshet.PoleArray[i].Visible then CurVisiblePole := Planshet.PoleArray[i];
       // ------ если меньше трех кривых ------------------
        if CurVisiblePole.SeriesList.Count < 3 then flag := true;
       // ------------------------
        if not flag then
              for i := 0 to 2 do begin
                   ShortName := copy (TSeries(CurVisiblePole.SeriesList.Items[i]).Name, 1, 3);
                   if ShortName <> 'BMK' then flag := True;
              end;
       // -----  Вывод ошибки ---------------
        if flag then begin
            Beep();
            MessageDlg('В режиме ввода отметок первые три кривых на поле должны бить "BMK" !!!', mtError, [mbOk], 0);
            tbClick(tbArray[0]);
           exit;
         end;
       // -------- Проверка на наличие кривых в Лас Файле ------------------
         if not CheckPresentSeriesInLasFile(ipHand, TSeries(CurVisiblePole.SeriesList.Items[0]).Name, TSeries(CurVisiblePole.SeriesList.Items[1]).Name, TSeries(CurVisiblePole.SeriesList.Items[2]).Name) then begin tbEndMarkClick(sender); exit; end;
       // ------------
        Planshet.InputMarks := True;
        EndMarkInput_Enabled := False;

        frmMarks.miRepeatDepth.Checked             := False;
        frmMarks.Show;
        frmMarks_DepthFilter.cbFiltration.Checked := False;
        Self.SetFocus;
        Edit1.SetFocus;
   end else begin // if TToolButton(Sender).Name = 'tbStartMark' then begin
      Planshet.SelectedSeries := nil;
     // ---- Снимаю все кореляционные сдиги --------------
      for i := 0 to LasFile.SeriesList.Count - 1 do
             TSeries(LasFile.SeriesList.Items[i]).KoreljationOffset := 0;
     // --- -----------------------

      Planshet.draw(false);
      Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
   end; // if TToolButton(Sender).Name = 'tbStartMark' then begin
end;

{===============================================================================
}
procedure TfrmMain.tbEndMarkClick(Sender: TObject);
begin
  EndMarkInput_Enabled := true;

  tbClick(tbArray[0]);
end;

{===============================================================================
}
procedure TfrmMain.tbAutoMarkClick(Sender: TObject);
begin
  if not CheckLoadedLasFile() then exit;
 // ----------------------------------------
  tbClick(tbArray[0]);
 // -------- Проверка на наличие кривых в Лас Файле ------------------
  if not CheckPresentSeriesInLasFile(ipAvto, '','','') then exit;
 // ----------------------------------------
  frmAutoMark.ShowModal;
end;

{===============================================================================
}
procedure TfrmMain.tbOtmetkiPanelClick(Sender: TObject);
begin
  if frmMarks.Visible then frmMarks.Close
                      else frmMarks.Show;
  Self.SetFocus;
end;

{===============================================================================
}
procedure TfrmMain.Image1Click(Sender: TObject);
var
  CurrentVisiblePole : TPole;
  i                  : Integer;
  ShortName          : String;
  //-------
  ind1, ind2         : Integer;
  CountIndex : Integer;
  //-------
begin
  if not tbStartMark.Down then exit;

  // ----- Выделяем текущее поле -------------
  CurrentVisiblePole := nil;
  for i := 0 to 2 do
        if Planshet.PoleArray[i].Visible then CurrentVisiblePole := Planshet.PoleArray[i];
  // -------------------------------------------


  if (Planshet.WhereIAm = wiaPole) and not Planshet.PoleMouseDownPresent and (Planshet.DepthArrayIndex <> -1) then begin
     try
        // ---- Проверка на ошибку ввода отметки -------
        CountIndex := Round(KoreljationWindow/Planshet.XValues.Step);
        ind1       := Planshet.DepthArrayIndex - (CountIndex div 2);
        ind2       := Planshet.DepthArrayIndex + (CountIndex div 2);
        if (ind1 < 0) or (ind2 > Planshet.xValues.Count - 1) then begin
           Beep();
           MessageDlg('Не верный ввод отметки'#13#10#13#10'Метка должна находиться на глубине половинного окна корреляции от начала или конца кривой', mtError, [mbOk], 0);
           tbClick(tbArray[0]);
           exit;
        end;
        // ---- End of Проверка на ошибку ввода отметки -------
        EndMarkInput_Enabled := false;

        Planshet.PoleMouseDownPresent := True;

        SetLength(MarkArray, Length(MarkArray) + 1);

        MarkArray[Length(MarkArray) - 1].fCurrentDepth := Planshet.xValues.Data^[Planshet.DepthArrayIndex];
        MarkArray[Length(MarkArray) - 1].Alfa_1        := 0;
        MarkArray[Length(MarkArray) - 1].Teta_1        := 0;
        MarkArray[Length(MarkArray) - 1].Alfa_2        := 0;
        MarkArray[Length(MarkArray) - 1].Teta_2        := 0;

        for i := 0 to 1 do begin
           MarkArray[Length(MarkArray) - 1].kArray[i].Kor      := 0;
           MarkArray[Length(MarkArray) - 1].kArray[i].Offset   := 0;
           MarkArray[Length(MarkArray) - 1].kArray[i].iSeries1 := LasFile.GetSeriesIndex(TSeries(CurrentVisiblePole.SeriesList.items[i+1]));
           MarkArray[Length(MarkArray) - 1].kArray[i].iSeries2 := LasFile.GetSeriesIndex(TSeries(CurrentVisiblePole.SeriesList.items[0]));
        end;

        frmMarks.ScrollBar1.Position := 0;
        frmMarks.OtputMarks();
        frmMarks.ModifyOneElement(Length(MarkArray) - 1);
     except
        tbClick(tbArray[0]);
        exit;
     end;
  end;

  // -------------
  if (Planshet.WhereIAm = wiaHead) and Planshet.PoleMouseDownPresent then begin
    if Planshet.CurrentSeries <> nil then begin
       // ---- Делаю всем сериям ДеСелект ----
       Planshet. DeSelectSeries();
       // ---- Проверка на нулевую cерию поля ----------
       ShortName := copy (Planshet.CurrentSeries.Name, 1, 3);
       if (TSeries(CurrentVisiblePole.SeriesList.Items[0]).Name <> Planshet.CurrentSeries.Name) and (ShortName = 'BMK') then begin
          Planshet.CurrentSeries.Selected := True;
          Planshet.SelectedSeries         := Planshet.CurrentSeries;
       end;
    end;
  end;

  // ------------------------------------------
  Planshet.SelectedMark := nil;
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
end;

{===============================================================================
}
procedure TfrmMain.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  OldKoreljationOffset : Integer;
  indexDepth           : Integer;
  CountIndex           : Integer;
  ind1                 : Integer;
  ind2                 : Integer;
begin
  if Planshet.SelectedSeries = nil then exit;
  if not tbStartMark.Down          then exit;

     OldKoreljationOffset := Planshet.SelectedSeries.KoreljationOffset;
     case Key of
       VK_Left  : Planshet.SelectedSeries.KoreljationOffset := Planshet.SelectedSeries.KoreljationOffset + 1;
       VK_Right : Planshet.SelectedSeries.KoreljationOffset := Planshet.SelectedSeries.KoreljationOffset - 1;
       VK_UP    : Planshet.SelectedSeries.KoreljationOffset := Planshet.SelectedSeries.KoreljationOffset - 5;
       VK_Down  : Planshet.SelectedSeries.KoreljationOffset := Planshet.SelectedSeries.KoreljationOffset + 5;
     end;
     // ------------------- Проверочка для OFFSETa ---------

     indexDepth      := LasFile.GetDepthIndex(MarkArray[Length(MarkArray) - 1].fCurrentDepth);
     CountIndex      := Round(KoreljationWindow/Planshet.XValues.Step);
     ind1            := indexDepth - (CountIndex div 2);
     ind2            := indexDepth + (CountIndex div 2);

     if (ind1 - (-Planshet.SelectedSeries.KoreljationOffset) < 0) or
        (ind2 + (Planshet.SelectedSeries.KoreljationOffset) >= Planshet.SelectedSeries.Count - 1) then begin
        MessageDlg('Достигнуто масксимально допустимое значение смещения окна корреляции !!!', mtError, [mbOk], 0);
        Planshet.SelectedSeries.KoreljationOffset := OldKoreljationOffset;
        exit;
     end;
     // ----------------------------------------------------
     Planshet.draw(false);
     Planshet.AssignedBitmap := not Planshet.AssignedBitmap;

     if MarkArray[Length(MarkArray) - 1].kArray[0].iSeries1 = LasFile.GetSeriesIndex(Planshet.SelectedSeries) then begin
        MarkArray[Length(MarkArray) - 1].kArray[0].Offset := - Planshet.SelectedSeries.KoreljationOffset{ * Planshet.SelectedSeries.Step * 100};
     end;
     if MarkArray[Length(MarkArray) - 1].kArray[1].iSeries1 = LasFile.GetSeriesIndex(Planshet.SelectedSeries) then begin
        MarkArray[Length(MarkArray) - 1].kArray[1].Offset := - Planshet.SelectedSeries.KoreljationOffset{ * Planshet.SelectedSeries.Step * 100};
     end;

     frmMarks.ModifyOneElement(Length(MarkArray) - 1);
end;

{===============================================================================
}
procedure TfrmMain.tbOtmetkiClick(Sender: TObject);
begin
  if Planshet = nil             then exit;
  if LasFile  = nil             then exit;
  if Planshet.PolesCount = 0    then exit;

   Planshet.MarkEnabled := tbOtmetki.Down;


   Planshet.draw(false);
   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
end;

{===============================================================================
}
procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
end;

{===============================================================================
}
procedure TfrmMain.aCalibrationExecute(Sender: TObject);
begin
   if CheckLoadedLasFile() then frmCalibrationCoef.ShowModal;
end;

{===============================================================================
}
procedure TfrmMain.aSeriesTransformExecute(Sender: TObject);
begin
  if CheckLoadedLasFile() then frmSeriesTransform.ShowModal;
end;

{===============================================================================
}
procedure TfrmMain.miSeriesTransformClick(Sender: TObject);
begin
   frmSeriesTransform.NumberSelectedElement := LasFile.GetSeriesIndex(Planshet.CurrentSeries) - 1;
   frmSeriesTransform.ShowModal;
end;

{===============================================================================
}
procedure TfrmMain.miDeleteSeriesClick(Sender: TObject);
var
 i : integer;
begin
  for i := 0 to 2 do frmPlanshetCreator.lbArray[i].ItemIndex := -1;
  frmPlanshetCreator.lbArray[Planshet.CurrentPole].ItemIndex := Planshet.NumberSeries;

  frmPlanshetCreator.tbRemoveSeriesClick(Sender);
end;

{===============================================================================
}
procedure TfrmMain.miAddSeriesToPoleClick(Sender: TObject);
begin
   frmPlanshetCreator.showModal;
end;

{===============================================================================
}
procedure TfrmMain.MenuItem1Click(Sender: TObject);
var
 i : integer;
 MarkArrayIndex : Integer;
begin
   MarkArrayIndex := - 1;
  // --------------------
   for i := 0 to Length(MarkArray) - 1 do begin
       if Planshet.SelectedMark^.fCurrentDepth = MarkArray[i].fCurrentDepth then begin
            MarkArrayIndex := i;
            break;
     end;
   end;
  // --------------------
   Planshet.SelectedMark := nil;
  // --------------------
   for i := MarkArrayIndex to Length(MarkArray) - 2 do
        MarkArray[i] := MarkArray[i+1];
  // --------------------
   SetLength(MarkArray, Length(MarkArray) - 1);
  // --------------------
   frmMarks.OtputMarks();
  //---------------------
   ReportClass.Draw;
  //---------------------
  Planshet.draw(false);
  Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  //---------------------
end;

{===============================================================================
}
procedure TfrmMain.FormActivate(Sender: TObject);
begin
  DecimalSeparator := '.';
end;

{===============================================================================
}
procedure TfrmMain.aStatAnalysisExecute(Sender: TObject);
begin
   if CheckLoadedLasFile() then frmStatAnalysis.ShowModal;
end;

{===============================================================================
}
procedure TfrmMain.aReportOfWell1Execute(Sender: TObject);
begin
  if CheckLoadedLasFile() then begin
     frmMarks.miSortByDepthClick(nil);
     frmReportOfWell1.ShowModal;
  end;
end;

{===============================================================================
}
procedure TfrmMain.aReportOfWell2Execute(Sender: TObject);
var
 frm : TfrmReportOfWell2;
begin
  if CheckLoadedLasFile() then begin
      frm := nil;
      try
         frm := TfrmReportOfWell2.Create(nil);
         frm.ShowModal;
      finally
         if frm <> nil then frm.free;
      end;
  end;
end;

{===============================================================================
}
procedure TfrmMain.aSaveLasDataExecute(Sender: TObject);
begin
   if LasFile <> nil then begin
      SaveDataFile(LasFile.FileName, LasFile.WellInf.Start, LasFile.WellInf.Stop);
      ShowMessage('Файл данных записан');
   end;
end;

procedure TfrmMain.bKoreljationWindowClick(Sender: TObject);
var St    : String;
    Prev  : TFloat;
begin
   St   := InputBox(frmMainCaption + 'Окно корреляции','Значение окна корреляции, м : ',FloatToStr(KoreljationWindow));
   try
      Prev := StrToFloat(St);
   except
      MessageDlg('Ошибка ввода окна корреляции', mtError, [mbOk], 0); exit;
      Prev := KoreljationWindow;
   end;

   KoreljationWindow := Prev;
  //-----------------
   bKoreljationWindow.Caption := 'Окно корреляции = ' + FloatToStr(KoreljationWindow) + ' м';
  // ----------------
   ScrollBar1.SetFocus;
end;

procedure TfrmMain.bCheckApsidalAngleClick(Sender: TObject);
var St    : String;
    Prev  : TFloat;
begin
   St   := InputBox(frmMainCaption + 'Расчетное значение "фи" для зенита >','Ввод расчетного значение "фи" для зенита >, гр : ',FloatToStr(CheckApsidalAngle*180/pi));
   try
      Prev := StrToFloat(St);
   except
      MessageDlg('Ошибка ввода значения', mtError, [mbOk], 0); exit;
      Prev := CheckApsidalAngle * 180/pi;
   end;

   CheckApsidalAngle := Prev*pi/180;
  //-----------------
   bCheckApsidalAngle.Caption := 'Расчет "фи" для зенита > ' + FloatToStr(CheckApsidalAngle*180/pi) + ' гр';
  // ----------------
   ScrollBar1.SetFocus;
end;

procedure TfrmMain.Panel3DblClick(Sender: TObject);
var
   f  : TextFile;
   i  : Integer;
begin
   AssignFile(f, '1.Txt');
   ReWrite(f);

   for i := 0 to LasFile.XValue.Count - 1 do begin
      WriteLn(f, TSeries(LasFile.SeriesList.items[2]).Data^[i])
      //
   end;
   CloseFile(f);

   MessageDlg('OK', mtInformation, [mbOk], 0);
end;

function TfrmMain.CheckPresentSeriesInLasFile(InputParam : TInputParam; b1, b2, b3 : String): boolean;
var
  OutStr : String;
  i      : Integer;
begin
  result := true;

  OutStr := 'В "Las" файле отсутсвуют кривые: ';

  if LasFile.GetSeries('AX')   = nil then begin result := false; OutStr := OutStr + 'AX, '; end;
  if LasFile.GetSeries('Ay')   = nil then begin result := false; OutStr := OutStr + 'AY, '; end;
  if LasFile.GetSeries('Az')   = nil then begin result := false; OutStr := OutStr + 'AZ, '; end;
{  if LasFile.GetSeries('Tx')   = nil then begin result := false; OutStr := OutStr + 'TX, '; end;
  if LasFile.GetSeries('Ty')   = nil then begin result := false; OutStr := OutStr + 'TY, '; end;
  if LasFile.GetSeries('Tz')   = nil then begin result := false; OutStr := OutStr + 'TZ, '; end;}
  if LasFile.GetSeries('Azim') = nil then begin result := false; OutStr := OutStr + 'AZIM, '; end;
  if LasFile.GetSeries('Az1b') = nil then begin result := false; OutStr := OutStr + 'AZ1B, '; end;
  if LasFile.GetSeries('Devi') = nil then begin result := false; OutStr := OutStr + 'DEVI, '; end;


  if InputParam = ipAvto then begin
     for i := 1 to 6 do begin
         if LasFile.GetSeries('RAD'+intToStr(i)) = nil then begin
               result := false;
               OutStr := OutStr + 'RAD'+intToStr(i) + ', ';
         end
     end;
  end else begin
     if LasFile.GetSeries('RAD'+b1[4]) = nil then begin result := false; OutStr := OutStr + 'RAD'+b1[4]+', '; end;
     if LasFile.GetSeries('RAD'+b2[4]) = nil then begin result := false; OutStr := OutStr + 'RAD'+b2[4]+', '; end;
     if LasFile.GetSeries('RAD'+b3[4]) = nil then begin result := false; OutStr := OutStr + 'RAD'+b3[4]+', '; end;
  end;
  SetLength(OutStr, Length(OutStr) - 2);

  if InputParam = ipAvto then OutStr := OutStr + #10#13#10#13 + 'Режим автоматического ввода отметок недоступен ...'
                         else OutStr := OutStr + #10#13#10#13 + 'Режим ручного ввода отметок недоступен ...';

  if not Result then begin
    beep();
    MessageDlg(OutStr, mtWarning, [mbOk], 0); exit;
  end;

// ---- R1 ------------
// ---- R2 ------------
// ---- R3 ------------
// ---- R4 ------------
// ---- R5 ------------
// ---- R6 ------------
end;

procedure TfrmMain.ScrollBar1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (shift = [ssShift, ssCtrl]) and (LowerCase(chr(key))[1] in ['a'..'z']) then begin
         InputString := InputString + chr(key);
         if LowerCase(InputString) = 'param' then frmBlackWindow.ShowModal;
         ScrollBar1.SetFocus;
   end;
  // -----------
    Planshet.ReDraw();
  // -----------
    Planshet.Set_MouseCoordinate(MouseCoordinate.x, MouseCoordinate.y);
end;

procedure TfrmMain.ScrollBar1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    Planshet.ReDraw();
    Planshet.Set_MouseCoordinate(MouseCoordinate.x, MouseCoordinate.y);
    if shift <> [ssShift, ssCtrl] then InputString := '';
end;

function TfrmMain.CheckModifiedProject_AndSaveProject(): integer;
begin
  Result := mrOk;

  if LasFileModified then begin
     Result   := MessageDlg('В даном проекте была произведена трансформация кривых'#10#13#10#13'Сохранить изменения в '#$27'Las'#$27' файле ?', mtWarning , mbYesNoCancel, 0);
     if Result = mrYes then begin
         frmSaveLasFile.ShowModal;
         if LasFileModified then Result := mrCancel;
     end;
  end else
     if LasFile <> nil then
       SaveDataFile(LasFile.FileName, LasFile.WellInf.Start, LasFile.WellInf.Stop);
end;

procedure TfrmMain.ToolButton8Click(Sender: TObject);
var
  afrmAbout : TfrmAbout;
begin
  afrmAbout := TfrmAbout.Create(self);
  afrmAbout .ShowModal;
  afrmAbout .Free;

end;

procedure TfrmMain.tb1Click(Sender: TObject);
begin
{ if Check_Guardant_Stealth_1() then caption := 'Проверка №1 : Ключ обнаружен'
                               else caption := 'Проверка №1 : Ключ не обнаружен';
 if Check_Guardant_Stealth_2() then caption := 'Проверка №2 : Ключ обнаружен'
                               else caption := 'Проверка №2 : Ключ не обнаружен';}
end;

procedure TfrmMain.Timer_1Timer(Sender: TObject);
begin
  prov1 := Check_Guardant_Stealth_1();
  Application.ProcessMessages;
end;

procedure TfrmMain.Timer_5Timer(Sender: TObject);
begin
  if prov1 then prov2 := Check_Guardant_Stealth_2();
  Application.ProcessMessages;
end;

procedure TfrmMain.Timer_10Timer(Sender: TObject);
begin
  if prov1 and prov2 then prov3 := Check_Guardant_Stealth_3();
  Application.ProcessMessages;
end;

procedure TfrmMain.Timer_20Timer(Sender: TObject);
begin
  if prov1 and prov2 and prov3 then prov4 := Check_Guardant_Stealth_4();
  Application.ProcessMessages;
end;

procedure TfrmMain.Timer_40Timer(Sender: TObject);
begin
  if prov1 and prov2 and prov3 and prov4 then prov5 := Check_Guardant_Stealth_5();
  Application.ProcessMessages;
end;

procedure TfrmMain.Timer_50Timer(Sender: TObject);
begin
  if prov1 and prov2 and prov3 and prov4 and prov5 then prov6 := Check_Guardant_Stealth_6();
  Application.ProcessMessages;
end;

procedure TfrmMain.aTransformLasFileExecute(Sender: TObject);
begin
   frmTransformLasFile.ShowModal;
  // ----------------------
   Planshet.CalcPositionPole;
   Planshet.draw(False);
   Planshet.AssignedBitmap := not Planshet.AssignedBitmap;
  //------------
end;

procedure TfrmMain.aPriborParamExecute(Sender: TObject);
begin
   if CheckLoadedLasFile() then frmPriborParam.ShowModal;
end;

end.
