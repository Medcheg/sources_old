unit mpiSaveLoadDataFile;

interface

uses mpiDeclaration, mpiLibrary;

  procedure SaveDataFile(aLasFileName : String; fStartDepth, fEndDepth : TFloat);
  procedure LoadDataFile();

  procedure SetDefaultParamForPlanshet();
  procedure SetDefaultParamForReportClass();

  procedure SetFormParamReportClass();


implementation

uses mpiLasFile, SysUtils, unit_Main, Classes, Unit_SeriesValue, Unit_Marks, Dialogs,
     Forms, mpiGuardantStealth, mpiReportClass, Unit_ReportOfWell1_Param, Graphics;

{===============================================================================
}
procedure SaveDataFile(aLasFileName : String; fStartDepth, fEndDepth : TFloat);
var
  aFileName            : String;
  iFileHandle          : Integer;
  i,k                  : Integer;
  Series               : Tseries;

  CountMarks          : Integer;
  NewMarkArray        : array of TMarks;
begin
  if LasFile = nil then exit;
  if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 then begin
        aFileName := ExtractFileName(aLasFileName);
        aFileName := ExtractFilePath(Application.ExeName) + 'LasData\' + copy(aFileName, 1, Length(aFileName) - 4) + '.ld';
        if (LasFile <> nil) {and (Length(MarkArray) <> 0)} then begin
            Try
               // -----  Опредиляю список записываемых отметок ----------
               CountMarks := 0;
               for i := 0 to Length(MarkArray) - 1 do begin
                 if ((MarkArray[i].fCurrentDepth >= fStartDepth) and (MarkArray[i].fCurrentDepth <= fEndDepth)) or
                    ((MarkArray[i].fCurrentDepth <= fStartDepth) and (MarkArray[i].fCurrentDepth >= fEndDepth)) then begin
                     CountMarks := CountMarks + 1;
                     SetLength(NewMarkArray, CountMarks);
                     NewMarkArray[CountMarks-1] := MarkArray[i];
                 end
               end;
               // ---------------
               CountMarks := Length(NewMarkArray);

               //=======================================
                 iFileHandle := FileCreate(aFileName);
               //=======================================
               // ------ Запись отметок ----------------
                  FileWrite(iFileHandle, CountMarks, SizeOf(CountMarks));
                  for i := 0 to CountMarks - 1 do FileWrite(iFileHandle, NewMarkArray[i], SizeOf(NewMarkArray[i]));
               // ------ Запись Установок планшета -------------
                     FillChar(PlanshetParam, sizeOf(PlanshetParam), 0);
                  // ---------
                     for k := 0 to 2 do PlanshetParam.Pole_Visible[k] := Planshet.PoleArray[k].Visible;
                     FileWrite(iFileHandle, PlanshetParam.Pole_Visible, SizeOf(PlanshetParam.Pole_Visible));
                  // ---------
                     for k := 0 to 2 do PlanshetParam.CountSeriesPole[k] := Planshet.PoleArray[k].SeriesList.Count;
                     FileWrite(iFileHandle, PlanshetParam.CountSeriesPole, SizeOf(PlanshetParam.CountSeriesPole));
                  // ---------
                     for k := 0 to 2 do begin
                         SetLength(PlanshetParam.SeriesListPole[k], PlanshetParam.CountSeriesPole[k]);
                         for i := 0 to PlanshetParam.CountSeriesPole[k] - 1 do begin
                            Series := TSeries(Planshet.PoleArray[k].SeriesList.Items[i]);
                            PlanshetParam.SeriesListPole[k][i].index    := LasFile.GetSeriesIndex(Series);
                            PlanshetParam.SeriesListPole[k][i].PenColor := Integer(Series.PenColor);
                            PlanshetParam.SeriesListPole[k][i].PenStyle := Integer(Series.PenStyle);
                            PlanshetParam.SeriesListPole[k][i].PenWidth := Series.PenWidth;
                            PlanshetParam.SeriesListPole[k][i].fMin     := Series.CorrectMinValue;
                            PlanshetParam.SeriesListPole[k][i].fMax     := Series.CorrectMaxValue;

                            FileWrite(iFileHandle, PlanshetParam.SeriesListPole[k][i], SizeOf(PlanshetParam.SeriesListPole[k][i]));
                         end;
                     end;
                  // ---------
                   PlanshetParam.MashtabCoef        := frmMain.tbMashtab.Position;   FileWrite(iFileHandle, PlanshetParam.MashtabCoef, SizeOf(PlanshetParam.MashtabCoef));
                   PlanshetParam.ScrollBarPos       := frmMain.ScrollBar1.Position;  FileWrite(iFileHandle, PlanshetParam.ScrollBarPos, SizeOf(PlanshetParam.ScrollBarPos));
                   PlanshetParam.OtmetkiVisible     := frmMain.tbOtmetki.Down;       FileWrite(iFileHandle, PlanshetParam.OtmetkiVisible, SizeOf(PlanshetParam.OtmetkiVisible));
                   PlanshetParam.ListOtmetkiVisible := frmMain.tbOtmetkiPanel.Down;  FileWrite(iFileHandle, PlanshetParam.ListOtmetkiVisible, SizeOf(PlanshetParam.ListOtmetkiVisible));

                   PlanshetParam.WindowsValuePosition := point(frmSeriesValue.Left, frmSeriesValue.Top);  FileWrite(iFileHandle, PlanshetParam.WindowsValuePosition, SizeOf(PlanshetParam.WindowsValuePosition));
                   PlanshetParam.WindowsOtmetkiValue  := point(frmMarks.Left      , frmMarks.Top);        FileWrite(iFileHandle, PlanshetParam.WindowsOtmetkiValue, SizeOf(PlanshetParam.WindowsOtmetkiValue));
                  // ---------------------------------------------
                  // ---------------------------------------------
                  // ---------------------------------------------
                  // --------- Запись отчетной формы -------------
                  // ---------------------------------------------
                  // ---------------------------------------------
                  // ---------------------------------------------
                   FillChar(ReportClassParam, SizeOf(ReportClassParam), 0);

                   ReportClassParam.DepthCoef :=  ReportClass.MashtabCoef;
                     FileWrite(iFileHandle, ReportClassParam.DepthCoef, SizeOf(ReportClassParam.DepthCoef));
                   ReportClassParam.DepthStep := StrToFloat(frmReportOfWell1_Param.eDepthStep.Text);
                     FileWrite(iFileHandle, ReportClassParam.DepthStep, SizeOf(ReportClassParam.DepthStep));

                   ReportClassParam.CountLitLayer := frmReportOfWell1_Param.lbLayer.Items.Count; SetLength(ReportClassParam.LitLayerArray, ReportClassParam.CountLitLayer);
                     FileWrite(iFileHandle, ReportClassParam.CountLitLayer, SizeOf(ReportClassParam.CountLitLayer));
                   for i := 0 to ReportClassParam.CountLitLayer - 1 do Begin
                       ReportClassParam.LitLayerArray[i] := TLithography(ReportClass.PoleList.Items[1]).LayerArray[i];
                       FileWrite(iFileHandle, ReportClassParam.LitLayerArray[i], SizeOf(TLithographyLayer));
                   end;

                   ReportClassParam.CountDopCurves := TDropCurves (ReportClass.PoleList.Items[2]).SeriesList.Count; SetLength(ReportClassParam.DopCurverArray, ReportClassParam.CountDopCurves);
                     FileWrite(iFileHandle, ReportClassParam.CountDopCurves, SizeOf(ReportClassParam.CountDopCurves));
                   for i := 0 to ReportClassParam.CountDopCurves - 1 do begin
                     ReportClassParam.DopCurverArray[i] := LasFile.GetSeriesIndex(TSeries(TDropCurves (ReportClass.PoleList.Items[2]).SeriesList.Items[i]));
                     FileWrite(iFileHandle, ReportClassParam.DopCurverArray[i], SizeOf(Integer));
                   end;

                   ReportClassParam.NominalDiametrEnabled := frmReportOfWell1_Param.cbNominalDiametr.Checked;
                     FileWrite(iFileHandle, ReportClassParam.NominalDiametrEnabled, SizeOf(ReportClassParam.NominalDiametrEnabled));
                   ReportClassParam.NominalDiametr        := StrToFLoat(frmReportOfWell1_Param.eNominalDiametr.Text);
                     FileWrite(iFileHandle, ReportClassParam.NominalDiametr, SizeOf(ReportClassParam.NominalDiametr));

                   if TGIS(ReportClass.PoleList.Items[4]).GISLasFile <> nil then begin
                      ReportClassParam.NameLasFile  := TGIS(ReportClass.PoleList.Items[4]).GISLasFile.FileName;
                      ReportClassParam.NumberSeries := TGIS(ReportClass.PoleList.Items[4]).GISLasFile.GetSeriesIndex(TSeries(frmReportOfWell1_Param.lbGISPole.Items.Objects[0]));
                      ReportClassParam.SeriesColor  := Integer(TSeries(frmReportOfWell1_Param.lbGISPole.Items.Objects[0]).PenColor);
                      ReportClassParam.SeriesStyle  := Integer(TSeries(frmReportOfWell1_Param.lbGISPole.Items.Objects[0]).PenStyle);
                      ReportClassParam.SeriesWidth  := Integer(TSeries(frmReportOfWell1_Param.lbGISPole.Items.Objects[0]).PenWidth);
                   end else begin
                      ReportClassParam.NameLasFile  := '';
                      ReportClassParam.NumberSeries := -1;
                      ReportClassParam.SeriesColor  := 0;
                      ReportClassParam.SeriesStyle  := 0;
                      ReportClassParam.SeriesWidth  := 0;
                   end;
                     FileWrite(iFileHandle, ReportClassParam.NameLasFile, SizeOf(ReportClassParam.NameLasFile));
                     FileWrite(iFileHandle, ReportClassParam.NumberSeries, SizeOf(ReportClassParam.NumberSeries));
                     FileWrite(iFileHandle, ReportClassParam.SeriesColor, SizeOf(ReportClassParam.SeriesColor));
                     FileWrite(iFileHandle, ReportClassParam.SeriesStyle, SizeOf(ReportClassParam.SeriesStyle));
                     FileWrite(iFileHandle, ReportClassParam.SeriesWidth, SizeOf(ReportClassParam.SeriesWidth));

                   ReportClassParam.DiametrGolovastic := frmReportOfWell1_Param.seGolovasticRadius.Value;
                   ReportClassParam.a1                := frmReportOfWell1_Param.se1.Value;
                   ReportClassParam.a2                := frmReportOfWell1_Param.seMain1.Value;
                   ReportClassParam.b1                := frmReportOfWell1_Param.se2.Value;
                   ReportClassParam.b2                := frmReportOfWell1_Param.seMain2.Value;
                   ReportClassParam.c1                := frmReportOfWell1_Param.se3.Value;
                   ReportClassParam.c2                := frmReportOfWell1_Param.seMain3.Value;
                   ReportClassParam.d1                := frmReportOfWell1_Param.se4.Value;
                   ReportClassParam.d2                := frmReportOfWell1_Param.seMain4.Value;
                   ReportClassParam.e1                := frmReportOfWell1_Param.se5.Value;
                   ReportClassParam.e2                := frmReportOfWell1_Param.seMain5.Value;
                     FileWrite(iFileHandle, ReportClassParam.DiametrGolovastic, SizeOf(ReportClassParam.DiametrGolovastic));
                     FileWrite(iFileHandle, ReportClassParam.a1, SizeOf(ReportClassParam.a1));
                     FileWrite(iFileHandle, ReportClassParam.a2, SizeOf(ReportClassParam.a2));
                     FileWrite(iFileHandle, ReportClassParam.b1, SizeOf(ReportClassParam.b1));
                     FileWrite(iFileHandle, ReportClassParam.b2, SizeOf(ReportClassParam.b2));
                     FileWrite(iFileHandle, ReportClassParam.c1, SizeOf(ReportClassParam.c1));
                     FileWrite(iFileHandle, ReportClassParam.c2, SizeOf(ReportClassParam.c2));
                     FileWrite(iFileHandle, ReportClassParam.d1, SizeOf(ReportClassParam.d1));
                     FileWrite(iFileHandle, ReportClassParam.d2, SizeOf(ReportClassParam.d2));
                     FileWrite(iFileHandle, ReportClassParam.e1, SizeOf(ReportClassParam.e1));
                     FileWrite(iFileHandle, ReportClassParam.e2, SizeOf(ReportClassParam.e2));

                   ReportClassParam.CountFreqLayer := frmReportOfWell1_Param.lbFreqLayer.Items.Count; SetLength(ReportClassParam.FreqLayerArray, ReportClassParam.CountFreqLayer);
                     FileWrite(iFileHandle, ReportClassParam.CountFreqLayer, SizeOf(ReportClassParam.CountFreqLayer));
                   for i := 0 to ReportClassParam.CountFreqLayer - 1 do begin
                     ReportClassParam.FreqLayerArray[i] := TFreqPole(ReportClass.PoleList.Items[6]).FreqLayerArray[i];
                     FileWrite(iFileHandle, ReportClassParam.FreqLayerArray[i], SizeOf(TFreqLayer));
                   end;
                   //FileWrite(iFileHandle, ReportClassParam, SizeOf(ReportClassParam));

                   FileWrite(iFileHandle, L_big  , SizeOf(L_big)  );
                   FileWrite(iFileHandle, L_Small, SizeOf(L_Small));
                   FileWrite(iFileHandle, r0     , SizeOf(r0)     );
               //=======================================
                  FileClose(iFileHandle);
               //=======================================
            except
               Beep();
               MessageDlg('Ошибка записи файла данных "'+ExtractFileName(aFileName)+'" соответствующего файлу "'+ExtractFileName(LasFile.FileName)+'"' + #13#10#13#10'Файл данных не будет записан ... ', mtError, [mbOk], 0);
            end;
        end;
  end; // ---- if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 then begin
end;
{===============================================================================
}
procedure LoadDataFile();
var
  aFileName            : String;
  iFileHandle          : Integer;
  CountMarks           : Integer;
  i, k                 : Integer;
  TempMarkArray        : array of TMarks;
  err                  : Boolean;
begin
  err := False;

  aFileName := ExtractFileName(LasFile.FileName);
  aFileName := ExtractFilePath(Application.ExeName) + 'LasData\' + copy(aFileName, 1, Length(aFileName) - 4) + '.ld';

  if FileExists(aFileName) then begin
      Try
         //=======================================
         iFileHandle := FileOpen(aFileName, fmOpenRead);
         //=======================================
         FileRead(iFileHandle, CountMarks, SizeOf(CountMarks));
         // -------  Загружаю отметки ------------
            SetLength(TempMarkArray, CountMarks);
            if CountMarks <> 0 then for i := 0 to CountMarks - 1 do FileRead(iFileHandle, TempMarkArray[i], SizeOf(TempMarkArray[i]));
         // -------  Заружаю параметры планшета ------------
            FillChar(PlanshetParam, sizeOf(PlanshetParam), 0);
            FileRead(iFileHandle, PlanshetParam.Pole_Visible   , SizeOf(PlanshetParam.Pole_Visible   ));
            FileRead(iFileHandle, PlanshetParam.CountSeriesPole, SizeOf(PlanshetParam.CountSeriesPole));
            // ---------

               for k := 0 to 2 do begin
                   SetLength(PlanshetParam.SeriesListPole[k], PlanshetParam.CountSeriesPole[k]);
                   for i := 0 to PlanshetParam.CountSeriesPole[k] - 1 do
                      FileRead(iFileHandle, PlanshetParam.SeriesListPole[k][i], SizeOf(PlanshetParam.SeriesListPole[k][i]));
               end;
            // ---------
            FileRead(iFileHandle, PlanshetParam.MashtabCoef, SizeOf(PlanshetParam.MashtabCoef));
            FileRead(iFileHandle, PlanshetParam.ScrollBarPos, SizeOf(PlanshetParam.ScrollBarPos));
            FileRead(iFileHandle, PlanshetParam.OtmetkiVisible, SizeOf(PlanshetParam.OtmetkiVisible));
            FileRead(iFileHandle, PlanshetParam.ListOtmetkiVisible, SizeOf(PlanshetParam.ListOtmetkiVisible));

            FileRead(iFileHandle, PlanshetParam.WindowsValuePosition, SizeOf(PlanshetParam.WindowsValuePosition));
            FileRead(iFileHandle, PlanshetParam.WindowsOtmetkiValue, SizeOf(PlanshetParam.WindowsOtmetkiValue));


            // ---------------------------------------------
            // ---------------------------------------------
            // ---------------------------------------------
            // --------- Считывание отчетной формы ---------
            // ---------------------------------------------
            // ---------------------------------------------
            // ---------------------------------------------
            FillChar(ReportClassParam, SizeOf(ReportClassParam), 0);

            FileRead(iFileHandle, ReportClassParam.DepthCoef    , SizeOf(ReportClassParam.DepthCoef));
            FileRead(iFileHandle, ReportClassParam.DepthStep    , SizeOf(ReportClassParam.DepthStep));

            FileRead(iFileHandle, ReportClassParam.CountLitLayer, SizeOf(ReportClassParam.CountLitLayer)); SetLength(ReportClassParam.LitLayerArray, ReportClassParam.CountLitLayer);
            for i := 0 to ReportClassParam.CountLitLayer - 1  do FileRead(iFileHandle, ReportClassParam.LitLayerArray[i], SizeOf(TLithographyLayer));

            FileRead(iFileHandle, ReportClassParam.CountDopCurves, SizeOf(ReportClassParam.CountDopCurves)); SetLength(ReportClassParam.DopCurverArray, ReportClassParam.CountDopCurves);
            for i := 0 to ReportClassParam.CountDopCurves - 1 do FileRead(iFileHandle, ReportClassParam.DopCurverArray[i], SizeOf(Integer));

            FileRead(iFileHandle, ReportClassParam.NominalDiametrEnabled, SizeOf(ReportClassParam.NominalDiametrEnabled));
            FileRead(iFileHandle, ReportClassParam.NominalDiametr, SizeOf(ReportClassParam.NominalDiametr));

            FileRead(iFileHandle, ReportClassParam.NameLasFile, SizeOf(ReportClassParam.NameLasFile));
            FileRead(iFileHandle, ReportClassParam.NumberSeries, SizeOf(ReportClassParam.NumberSeries));
            FileRead(iFileHandle, ReportClassParam.SeriesColor, SizeOf(ReportClassParam.SeriesColor));
            FileRead(iFileHandle, ReportClassParam.SeriesStyle, SizeOf(ReportClassParam.SeriesStyle));
            FileRead(iFileHandle, ReportClassParam.SeriesWidth, SizeOf(ReportClassParam.SeriesWidth));

            FileRead(iFileHandle, ReportClassParam.DiametrGolovastic, SizeOf(ReportClassParam.DiametrGolovastic));
            FileRead(iFileHandle, ReportClassParam.a1               , SizeOf(ReportClassParam.a1));
            FileRead(iFileHandle, ReportClassParam.a2               , SizeOf(ReportClassParam.a2));
            FileRead(iFileHandle, ReportClassParam.b1               , SizeOf(ReportClassParam.b1));
            FileRead(iFileHandle, ReportClassParam.b2               , SizeOf(ReportClassParam.b2));
            FileRead(iFileHandle, ReportClassParam.c1               , SizeOf(ReportClassParam.c1));
            FileRead(iFileHandle, ReportClassParam.c2               , SizeOf(ReportClassParam.c2));
            FileRead(iFileHandle, ReportClassParam.d1               , SizeOf(ReportClassParam.d1));
            FileRead(iFileHandle, ReportClassParam.d2               , SizeOf(ReportClassParam.d2));
            FileRead(iFileHandle, ReportClassParam.e1               , SizeOf(ReportClassParam.e1));
            FileRead(iFileHandle, ReportClassParam.e2               , SizeOf(ReportClassParam.e2));

            FileRead(iFileHandle, ReportClassParam.CountFreqLayer, SizeOf(ReportClassParam.CountFreqLayer));
//            ReportClassParam.CountFreqLayer := 0;
            SetLength(ReportClassParam.FreqLayerArray, ReportClassParam.CountFreqLayer);
            for i := 0 to ReportClassParam.CountFreqLayer - 1 do FileRead(iFileHandle, ReportClassParam.FreqLayerArray[i], SizeOf(TFreqLayer));

                   FileRead(iFileHandle, L_big  , SizeOf(L_big)  );
                   FileRead(iFileHandle, L_Small, SizeOf(L_Small));
                   FileRead(iFileHandle, r0     , SizeOf(r0)     );
         //=======================================
           FileClose(iFileHandle);
         //=======================================
         // -------------------
         frmMarks.OtputMarks();
      except
        Beep();
        err := true;
        if MessageDlg('Файл данных "'+ExtractFileName(aFileName)+'" соответствующий файлу "'+ExtractFileName(LasFile.FileName)+'" поврежден ...'#13#10#13#10'Удалить поврежденный файл данных ?', mtError, [mbOk, mbCancel], 0) = 1 {mrOk} then begin
              DeleteFile(aFileName);
        end;
      end;
      //------------------
      if not err then begin
          SetLength(MarkArray, CountMarks);
          for i := 0 to CountMarks - 1 do
              MarkArray[i] := TempMarkArray[i];
      end;
      //------------------
      SetLength(TempMarkArray, 0);
  end else begin
      SetDefaultParamForPlanshet();

      PlanshetParam.SeriesListPole[0][0].index    := LasFile.GetSeriesIndex(LasFile.GetSeries('BMK1'));
      PlanshetParam.SeriesListPole[0][1].index    := LasFile.GetSeriesIndex(LasFile.GetSeries('BMK3'));
      PlanshetParam.SeriesListPole[0][2].index    := LasFile.GetSeriesIndex(LasFile.GetSeries('BMK5'));
      PlanshetParam.SeriesListPole[0][3].index    := LasFile.GetSeriesIndex(LasFile.GetSeries('RADS'));

      PlanshetParam.SeriesListPole[1][0].index    := LasFile.GetSeriesIndex(LasFile.GetSeries('BMK2'));
      PlanshetParam.SeriesListPole[1][1].index    := LasFile.GetSeriesIndex(LasFile.GetSeries('BMK4'));
      PlanshetParam.SeriesListPole[1][2].index    := LasFile.GetSeriesIndex(LasFile.GetSeries('BMK6'));
      PlanshetParam.SeriesListPole[1][3].index    := LasFile.GetSeriesIndex(LasFile.GetSeries('RADS'));

      SetDefaultParamForReportClass();
  end;
end;

{===============================================================================
}
procedure SetDefaultParamForPlanshet();
begin
  FillChar(PlanshetParam, SizeOf(PlanshetParam), 0);
  with PlanshetParam do begin
      Pole_Visible[0] := True;
      Pole_Visible[1] := False;
      Pole_Visible[2] := False;
      // ----------------------------
      CountSeriesPole[0] :=  4;  SetLength(SeriesListPole[0], CountSeriesPole[0]);
      CountSeriesPole[1] :=  4;  SetLength(SeriesListPole[1], CountSeriesPole[1]);
      CountSeriesPole[2] :=  0;  SetLength(SeriesListPole[2], CountSeriesPole[2]);
      // ----------------------------
      SeriesListPole[0][0].index    :=  2;
      SeriesListPole[0][0].PenColor :=  clBlue;
      SeriesListPole[0][0].PenStyle :=  Integer(psSolid);
      SeriesListPole[0][0].PenWidth :=  1;
      SeriesListPole[0][0].fMax     := -1;
      SeriesListPole[0][0].fMin     := -1;

      SeriesListPole[0][1].index    := 4;
      SeriesListPole[0][1].PenColor := clRed;
      SeriesListPole[0][1].PenStyle := Integer(psSolid);
      SeriesListPole[0][1].PenWidth := 1;
      SeriesListPole[0][1].fMax     := -1;
      SeriesListPole[0][1].fMin     := -1;

      SeriesListPole[0][2].index    := 6;
      SeriesListPole[0][2].PenColor := clGreen;
      SeriesListPole[0][2].PenStyle := Integer(psSolid);
      SeriesListPole[0][2].PenWidth := 1;
      SeriesListPole[0][2].fMax     := -1;
      SeriesListPole[0][2].fMin     := -1;

      SeriesListPole[0][3].index    := 25;
      SeriesListPole[0][3].PenColor := clBlack;
      SeriesListPole[0][3].PenStyle := Integer(psSolid);
      SeriesListPole[0][3].PenWidth := 1;
      SeriesListPole[0][3].fMax     := -1;
      SeriesListPole[0][3].fMin     := -1;

      SeriesListPole[1][0].index    :=  3;
      SeriesListPole[1][0].PenColor :=  clBlue;
      SeriesListPole[1][0].PenStyle :=  Integer(psSolid);
      SeriesListPole[1][0].PenWidth :=  1;
      SeriesListPole[1][0].fMax     := -1;
      SeriesListPole[1][0].fMin     := -1;

      SeriesListPole[1][1].index    := 5;
      SeriesListPole[1][1].PenColor := clRed;
      SeriesListPole[1][1].PenStyle := Integer(psSolid);
      SeriesListPole[1][1].PenWidth := 1;
      SeriesListPole[1][1].fMax     := -1;
      SeriesListPole[1][1].fMin     := -1;

      SeriesListPole[1][2].index    := 7;
      SeriesListPole[1][2].PenColor := clGreen;
      SeriesListPole[1][2].PenStyle := Integer(psSolid);
      SeriesListPole[1][2].PenWidth := 1;
      SeriesListPole[1][2].fMax     := -1;
      SeriesListPole[1][2].fMin     := -1;

      SeriesListPole[1][3].index    := 25;
      SeriesListPole[1][3].PenColor := clBlack;
      SeriesListPole[1][3].PenStyle := Integer(psSolid);
      SeriesListPole[1][3].PenWidth := 1;
      SeriesListPole[1][3].fMax     := -1;
      SeriesListPole[1][3].fMin     := -1;
      // ----------------------------
      MashtabCoef      := 1;
      ScrollBarPos     := 0;
      // ----------------------------
      OtmetkiVisible       := true;
      ListOtmetkiVisible   := true;
      // ----------------------------
      WindowsValuePosition := Point(-1, -1);
      WindowsOtmetkiValue  := Point(-1, -1);
  end;
end;

{===============================================================================
}
procedure SetDefaultParamForReportClass();
var
  i : integer;
begin
  FillChar(ReportClassParam, SizeOf(ReportClassParam), 0);
  with ReportClassParam do begin
      ReportClassParam.DepthCoef := 1;
      ReportClassParam.DepthStep := 1;

      ReportClassParam.CountLitLayer := 0;
      SetLength(ReportClassParam.LitLayerArray,  ReportClassParam.CountLitLayer);

      ReportClassParam.CountDopCurves := 6;
      SetLength(ReportClassParam.DopCurverArray, ReportClassParam.CountDopCurves);
      for i := 2 to 2 + ReportClassParam.CountDopCurves - 1 do ReportClassParam.DopCurverArray[i-2] := i;

      ReportClassParam.NominalDiametrEnabled := true;
      ReportClassParam.NominalDiametr        := 210;

      ReportClassParam.NameLasFile           := '';
      ReportClassParam.NumberSeries          := -1;
      ReportClassParam.SeriesColor           := clBlack;
      ReportClassParam.SeriesStyle           := integer(psSolid);
      ReportClassParam.SeriesWidth           := 1;

      ReportClassParam.DiametrGolovastic := 4;

      ReportClassParam.a1                := 90;
      ReportClassParam.a2                := 100;
      ReportClassParam.b1                := 80;
      ReportClassParam.b2                := 90;
      ReportClassParam.c1                := 70;
      ReportClassParam.c2                := 80;
      ReportClassParam.d1                := 60;
      ReportClassParam.d2                := 70;
      ReportClassParam.e1                := 0;
      ReportClassParam.e2                := 60;

      ReportClassParam.CountFreqLayer    := 0;
      SetLength(ReportClassParam.FreqLayerArray, ReportClassParam.CountFreqLayer);
  end;
end;

procedure SetFormParamReportClass();
var
  DepthPole   : TDepthPole;
  Lithography : TLithography;
  DropCurves  : TDropCurves;
  MidleRadius : TMidleRadius;
  GIS         : TGIS;
  Golovastic  : TGolovastic;
  FreqPole    : TFreqPole;

  i           : Integer;
  Series      : TSeries;
begin

  // ------------------
  DepthPole   := TDepthPole  (ReportClass.PoleList.Items[0]);
  Lithography := TLithography(ReportClass.PoleList.Items[1]);
  DropCurves  := TDropCurves (ReportClass.PoleList.Items[2]);
  MidleRadius := TMidleRadius(ReportClass.PoleList.Items[3]);
  GIS         := TGIS        (ReportClass.PoleList.Items[4]);
  Golovastic  := TGolovastic (ReportClass.PoleList.Items[5]);
  FreqPole    := TFreqPole   (ReportClass.PoleList.Items[6]);
  // -------------------
  DropCurves.SeriesList.Clear;
  Gis.SeriesList.clear;
  frmReportOfWell1_Param.lbLayer.Items.Clear;
  frmReportOfWell1_Param.lbPole1.Items.Clear;
  frmReportOfWell1_Param.lbGISPole.Items.Clear;
  frmReportOfWell1_Param.lbGISSeries.Items.Clear;
  frmReportOfWell1_Param.lbFreqLayer.Items.Clear;
  // --------------------

  // ----------- 11 ------------
        ReportClass.MashtabCoef  := ReportClassParam.DepthCoef;
     if ReportClass.MashtabCoef > 1 then frmReportOfWell1_Param.TrackBar1.Position := Round(ReportClass.MashtabCoef + 9);
     if ReportClass.MashtabCoef = 1 then frmReportOfWell1_Param.TrackBar1.Position := 10;
     if ReportClass.MashtabCoef < 1 then frmReportOfWell1_Param.TrackBar1.Position := Round(ReportClass.MashtabCoef * 10);
     DepthPole.StepDepthLabel := ReportClassParam.DepthStep; frmReportOfWell1_Param.eDepthStep.text := FloatToStr(DepthPole.StepDepthLabel);
  // ---------- 22 -----------
     SetLength(Lithography.LayerArray, ReportClassParam.CountLitLayer);
     for i := 0 to ReportClassParam.CountLitLayer - 1 do begin
        Lithography.LayerArray[i] := ReportClassParam.LitLayerArray[i];
        frmReportOfWell1_Param.lbLayer.Items.AddObject(Lithography.LayerArray[i].NameLayer, addr(Lithography.LayerArray[i].NameLayer));
     end;
  // ---------- 33 -----------
  // ---!!!!!!!!!!!!!!!??????????????????????????????????????????????
  try
     for i := 0 to ReportClassParam.CountDopCurves - 1 do begin
        frmReportOfWell1_Param.addSeriesToPoleDopCurves(TSeries(LasFile.SeriesList.Items[ReportClassParam.DopCurverArray[i]]))
        //DropCurves.SeriesList.Add();
        //frmReportOfWell1_Param.lbPole1.Items.AddObject(TSeries(DropCurves.SeriesList.Items[i]).Name, TSeries(DropCurves.SeriesList.Items[i]));
     end;
  except end;
  // ---------- 44 -----------
     MidleRadius.NominalDiametrEnabled := ReportClassParam.NominalDiametrEnabled; frmReportOfWell1_Param.cbNominalDiametr.Checked := MidleRadius.NominalDiametrEnabled;
     MidleRadius.NominalDiametr        := ReportClassParam.NominalDiametr;        frmReportOfWell1_Param.eNominalDiametr.Text     := FloatToStr(MidleRadius.NominalDiametr);
  // ---------- 55 -----------
     if ReportClassParam.NameLasFile <> '' then begin
       frmReportOfWell1_Param.LoadGisLasFile(ReportClassParam.NameLasFile);
       if (Gis.GISLasFile <> nil) and (ReportClassParam.NumberSeries <> -1) then begin
          Series := TSeries(Gis.GISLasFile.SeriesList.Items[ReportClassParam.NumberSeries]);
          frmReportOfWell1_Param.addSeriesToGISPole(Series);

          Series.PenColor := ReportClassParam.SeriesColor;
          Series.PenStyle := TPenStyle(ReportClassParam.SeriesStyle);
          Series.PenWidth := ReportClassParam.SeriesWidth;
       end;
     end;
  // --------- 66 -----------
     Golovastic.HolovasticRadius   := ReportClassParam.DiametrGolovastic;
     Golovastic.MinMaxArray[0].min := ReportClassParam.a1;
     Golovastic.MinMaxArray[0].max := ReportClassParam.a2;
     Golovastic.MinMaxArray[1].min := ReportClassParam.b1;
     Golovastic.MinMaxArray[1].max := ReportClassParam.b2;
     Golovastic.MinMaxArray[2].min := ReportClassParam.c1;
     Golovastic.MinMaxArray[2].max := ReportClassParam.c2;
     Golovastic.MinMaxArray[3].min := ReportClassParam.d1;
     Golovastic.MinMaxArray[3].max := ReportClassParam.d2;
     Golovastic.MinMaxArray[4].min := ReportClassParam.e1;
     Golovastic.MinMaxArray[4].max := ReportClassParam.e2;

     frmReportOfWell1_Param.se1.value     := ReportClassParam.a1;
     frmReportOfWell1_Param.seMain1.value := ReportClassParam.a2;
     frmReportOfWell1_Param.se2.value     := ReportClassParam.b1;
     frmReportOfWell1_Param.seMain2.value := ReportClassParam.b2;
     frmReportOfWell1_Param.se3.value     := ReportClassParam.c1;
     frmReportOfWell1_Param.seMain3.value := ReportClassParam.c2;
     frmReportOfWell1_Param.se4.value     := ReportClassParam.d1;
     frmReportOfWell1_Param.seMain4.value := ReportClassParam.d2;
     frmReportOfWell1_Param.se5.value     := ReportClassParam.e1;
     frmReportOfWell1_Param.seMain5.value := ReportClassParam.e2;
     frmReportOfWell1_Param.seGolovasticRadius.Value := ReportClassParam.DiametrGolovastic;
   // -------- 77 -----------
     SetLength(FreqPole.FreqLayerArray, ReportClassParam.CountFreqLayer);
     for i := 0 to ReportClassParam.CountFreqLayer - 1 do begin
        FreqPole.FreqLayerArray[i] := ReportClassParam.FreqLayerArray[i];
        frmReportOfWell1_Param.lbFreqLayer.Items.AddObject(FloatToStrF(FreqPole.FreqLayerArray[i].BeginDepth, ffFixed, 20,4) + ' - ' + FloatTOStrF(FreqPole.FreqLayerArray[i].EndDepth, ffFixed, 20,4), addr(FreqPole.FreqLayerArray[i]));
     end;
end;

end.
