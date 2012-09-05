unit mpiLasFile;

interface

uses Classes, mpiDeclaration, mpiLibrary;

{

const
VERSION INFORMATION
WELL INFORMATION
PARAMETR INFORMATION SECTION
CURVE INFORMATION SECTION
OTHER INFORMATION
ASCII DATA

}

const MaxLengthOutString = 16;

type
   tLFLoaded = (lfNormalLasFile, lfGisLasFile);

   PBuffer   =  PChar;

   TLasFileOneLine = record
      Name       : String;
      Dimension  : String;
      Value      : String;
      Comments   : String;
   end;
   TChapter = array of TLasFileOneLine;

   TTwoValue = record
      Depth : TFloat;
      Kanal : Integer;
   end;

   TWellInf = record
      Start       : TFloat;
      Stop        : TFloat;
      Step        : TFloat;
      Null        : TFloat;
      Well        : String;
      Field       : String;
      Loc         : String;
      Serv        : String;
      Date        : String;
   end;

   TLasFile = class
   private
      ErrorCounter  : Integer;
      ErrorList     : array of TTwoValue;
      // ---------
      PointPosition : Integer;
      ColonPosition : Integer;
      // ---------
      procedure OutPutCountError(aErrorCounter : Integer);

      procedure GetDecodeLineFromFile(var aChapter : TChapter; curString : String);
      procedure CheckCorrection();
      function  GetElementFromName(aChapter : TChapter; curString : String): TLasFileOneLine;
      function  LineCoding(aData : TLasFileOneLine) : string;

      procedure Read___Chapter(aCode : char; var aChapter : TChapter; var CurString : String);
      procedure Read_A_Chapter(var CurString: String);
      procedure SetSeriesParam();
      procedure ChangeLasFile(start, stop : TFloat; Sections : Integer; aFileName : String);
   public
      V_Chapter         : TChapter;
      W_Chapter         : TChapter;
      C_Chapter         : TChapter;
      P_Chapter         : TChapter;
      O_Chapter         : TChapter;
      WellInf           : TWellInf;
      //------------------------------
      FileName          : String;

      CalibrationFactor : Boolean; // ---- Прокалибрированная реализация --------
      //-----------------------
       SeriesList  : TList;
       XValue      : TSeries;
      // ----------------------
       TypeLasFileLoaded : tLFLoaded;

      procedure   Load();
      procedure   Save(start, stop : TFloat; Sections : Integer; aFileName : String);
      procedure   Save_With_Compiled(aFileName: String; aLas1, aLas2 : TLasFile);

      function    GetSeries(aName : String):TSeries;
      function    GetSeriesIndex(Series : TSeries):integer;
      function    GetDepthIndex(aDepth :TFloat):Integer;

      function    SeriesPresent(aName : String):boolean;
      function    AddNewSeries(aName, aComents : String) : TSeries;
      // ---------
      // ---------
      constructor create(aFileName : String; LFLoaded : tLFLoaded);
      destructor  destroy; override;
   end;

var
  LasFile       : TLasFile;

implementation

uses SysUtils, Dialogs, Forms;

var
//   Shapka : array of AnsiString;
   tfLas  : TextFile;

{ TLasFile }

{===============================================================================
}
constructor TLasFile.create(aFileName : String; LFLoaded : tLFLoaded);
var i : integer;
begin
  inherited create;
  // ----------
   SeriesList        := TList.Create;
   FileName          := aFileName;
   TypeLasFileLoaded := LFLoaded;
  // ---------
   Load();
  // ----------
   PointPosition := 0;
  // -----------  Нахожу в лас файле максимальное положение "точки" в шапке файла ------------
  for i := 0 to length(C_Chapter) - 1 do
     if PointPosition < length(C_Chapter[i].Name) then PointPosition := length(C_Chapter[i].Name);

//  PointPosition := PointPosition + 1;
  ColonPosition := 40;
end;

{===============================================================================
}
destructor TLasFile.destroy;
var
  i : integer;
begin
  if SeriesList.Count <> 0 then
    for i := 0 to SeriesList.Count - 1 do TSeries(SeriesList.Items[i]).Free;

  SeriesList.Free;
  inherited destroy;
end;

{===============================================================================
}
procedure TLasFile.OutPutCountError(aErrorCounter : Integer);
var
  CountDec, Res : Integer;
  MyStr         : String;
  f             : TextFile;
  i             : Integer;
  aFileName      : String;
begin
   aFileName := ExtractFilePath(Application.ExeName)+'Plastomer.err';
   // --------- Запись файла ошибок ----------
      AssignFile(f, aFileName);
      Rewrite(f);
      WriteLn(f, ' В Файле "'+FileName+'" было найдено ' + IntToStr(aErrorCounter) + ' ошибок ');
      WriteLn(f);
      WriteLn(f, '      Глубина                 Имя кривой');
      WriteLn(f);
      for i := 0 to aErrorCounter - 1 do begin
           WriteLn(f, intToStr(i+1) + ':   ' + FloatToStrF(ErrorList[i].Depth, ffFixed, 20, 4) + #09#09#09 +TSeries(SeriesList.Items[ErrorList[i].Kanal]).Name);
      end;
      CloseFile(f);
   // --------- End of Запись файла ошибок ----------

   Beep();

   CountDec := aErrorCOunter div 10;
   if CountDec <> 0 then res := aErrorCounter mod (CountDec*10)
                    else res := aErrorCounter;
   MyStr    := '';
   case res of
     1    : MyStr := 'ка';
     2..4 : MyStr := 'ки';
     5..9 : MyStr := 'ок';
     0    : MyStr := 'ок';
   end;
   // ------------------
   MessageDlg(intToStr(aErrorCounter) + ' Ошиб' + MyStr + ' в "LAS" файле'#13#10#13#10'Создан файл ошибок "Plastomer.err"', mtInformation, [mbOk], 0);
end;

{===============================================================================
}
procedure TLasFile.GetDecodeLineFromFile(var aChapter: TChapter;
  curString: String);
  function DeleteFrontAndBackSpaces(aTempStr : String):String;
      var i : Integer; pos1, pos2 : Integer;
  begin
      Result := '';
      if Length(aTempStr) = 0 then exit;
      Pos1 := Length(aTempStr); Pos2 := 1;
      for i := 1 to Length(aTempStr)     do
              if ATempStr[i] <> ' ' then begin
                    Pos1 := i; Break; end;
      for i := Length(aTempStr) downto 1 do
            if ATempStr[i] <> ' ' then begin
                  Pos2 := i; Break; end;
      for i := pos1 to pos2 do Result := Result + aTempStr[i];
  end;
var
 LasFileOneLine : TLasFileOneLine;
 TempStr        : String;
 i              : Integer;
begin
  FillChar(LasFileOneLine, sizeOf(TLasFileOneLine), 0);
  i := 1;
  //---------------------------
  TempStr := ''; while curString[i] <> '.' do begin TempStr := TempStr + curString[i]; i := i + 1; end; i := i + 1; LasFileOneLine.Name      := DeleteFrontAndBackSpaces(TempStr);
  TempStr := ''; while curString[i] <> ' ' do begin TempStr := TempStr + curString[i]; i := i + 1; end; i := i + 1; LasFileOneLine.Dimension := DeleteFrontAndBackSpaces(TempStr);
  TempStr := ''; while curString[i] <> ':' do begin TempStr := TempStr + curString[i]; i := i + 1; end; i := i + 1; LasFileOneLine.Value     := DeleteFrontAndBackSpaces(TempStr);
  TempStr := ''; while curString[i] <> #0  do begin TempStr := TempStr + curString[i]; i := i + 1; end; LasFileOneLine.Comments  := DeleteFrontAndBackSpaces(TempStr);
  //---------------------------
  SetLength(aChapter, Length(aChapter)+1);
  aChapter[Length(aChapter)-1] := LasFileOneLine;
end;

{===============================================================================
}
procedure TLasFile.Read___Chapter(aCode: char; var aChapter: TChapter;
  var CurString: String);
begin
  while not eof(tfLas) do begin
     if (CurString[1]='~') and (CurString[2] <> aCode) then break;
     try if (CurString[1]<>'~') and (CurString[1]<>'#') then GetDecodeLineFromFile(aChapter, CurString); except Beep(); MessageDLG('Не верный формат в "шапки" LAS файла', mtError, [mbOk], 0); exit; end;
     ReadLn(tfLas, CurString)
  end;
end;

{===============================================================================
}
function TLasFile.GetElementFromName(aChapter: TChapter;
  curString: String): TLasFileOneLine;
var
  i : integer;
begin
   for i := 0 to Length(aChapter) - 1 do
     if UpperCase(aChapter[i].Name) = UpperCase(CurString) then begin
        Result := aChapter[i];
        exit;
     end;
   //----------------------------
   Result.Name      := '----';
   Result.Dimension := '----';
   Result.Value     := '----';
   Result.Comments  := '----';
end;

{===============================================================================
}
procedure TLasFile.SetSeriesParam();
var
  Count, i                : Integer;
  Series                  : TSeries;
begin
  WellInf.Start := StrToFloat(GetElementFromName(W_Chapter,'STRT').Value);
  WellInf.Stop  := StrToFloat(GetElementFromName(W_Chapter,'STOP').Value);
  WellInf.Step  := StrToFloat(GetElementFromName(W_Chapter,'STEP').Value);
  WellInf.Null  := StrToFloat(GetElementFromName(W_Chapter,'NULL').Value);
  WellInf.Well  := GetElementFromName(W_Chapter,'WELL').Value;
  WellInf.Field := GetElementFromName(W_Chapter,'FLD').Value;
  WellInf.Loc   := GetElementFromName(W_Chapter,'LOC').Value;
  WellInf.Serv  := GetElementFromName(W_Chapter,'SRVC').Value;
  WellInf.Date  := GetElementFromName(W_Chapter,'DATE').Value;

  Count := abs(Trunc((WellInf.Stop - WellInf.Start)/WellInf.Step)) + 1;

  for i := 0 to Length(C_Chapter) - 1 do begin
     Series := TSeries.Create;
     SeriesList.Add(Series);

     Series.Name       := C_Chapter[i].Name;
     Series.FileName   := FileName;
     Series.Dimension  := C_Chapter[i].Dimension;
     Series.Count      := Count;
     Series.Step       := WellInf.Step;
     Series.NullValue  := WellInf.Null;
     Series.BeginDepth := WellInf.Start;
     Series.EndDepth   := WellInf.Stop;
     Series.Parent     := Self;
     GetMem(Series.Data, SizeOf(TFloat)*Series.Count);

     if i = 0 then XValue := Series;
  end;
end;

{===============================================================================
}
function TLasFile.GetSeries(aName: String): TSeries;
var
  i : integer;
begin
  Result := nil;

  for i := 0 to SeriesList.Count - 1 do begin
      if UpperCase(TSeries(SeriesList.Items[i]).Name) = UpperCase(aName) then begin
           Result := TSeries(SeriesList.Items[i]);
           Break;
      end;
  end;
end;

{===============================================================================
}
procedure TLasFile.Read_A_Chapter(var CurString: String);
var
  i, k        : Integer;
  FloatValue  : TFloat;
//  FloatValue  : TFloat;
{  bValue        : Boolean;
  SValue        : String;
  rChar       : Char;}
  LineCounter   : Integer;
  ReadString    : AnsiString;

  RadiusArray : array [0..5] of TSeries;
  Series      : TSeries;
  RealCountData : Integer;
begin
  try SetSeriesParam(); except Beep(); MessageDLG('Ошибка данных в "шапке" LAS файла', mtError, [mbOk], 0); exit end;

  SetLength(ErrorList, 0);
  ///// Закрываю файл ////////
  CloseFile(tfLas);
  ///// Открываю файл ////////
  Reset(tfLas);
  LineCounter := 0;
  repeat
     Readln(tfLas, ReadString);
     inc(LineCounter);
     if LineCounter = 1 then ;
     if (ReadString[1] = '~') and (ReadString[2] = 'A') then begin
         Readln(tfLas, ReadString);
         while ReadString[1] = '#' do begin
           inc(LineCounter);
             Readln(tfLas, ReadString);
         end;
         break;
     end;
  until false;
  CloseFile(tfLas);
  ///////////
  Reset(tfLas);
  for i := 0 to LineCounter - 1 do Readln(tfLas, ReadString);
  /////////////////
  // ----------   Очистка масивов -------------
  for k := 0 to SeriesList.Count - 1 do begin
     Series := TSeries(SeriesList.Items[k]);
     for i := 0 to TSeries(SeriesList.Items[0]).Count - 1 do
          Series.Data^[i] := WellInf.Null;
  end;
  //-----------   Быстрый метод который подхватывает ощибки Лас Файла --------------
  RealCountData := 0;
  for i := 0 to TSeries(SeriesList.Items[0]).Count - 1 do begin
        if eof(tfLas) then break;
        // ------ Загрузка данных ++++ Обработка ошибок данных -----
        // ------- если в данных чего-то там неправильно, значит виноват тот кто предоставил данные ---
        for k := 0 to SeriesList.Count - 1 do begin
              try
                 Read(tfLas, FloatValue);
                 if eof(tfLas) then break;
                 TSeries(SeriesList.Items[k]).AddValue[i] := FloatValue;
              except
                 SetLength(ErrorList, ErrorCounter + 1);
                 ErrorList[ErrorCounter].Depth := TSeries(SeriesList.Items[0]).data^[i];
                 ErrorList[ErrorCounter].Kanal := k;
                 ErrorCounter                  := ErrorCounter + 1;
                 //TSeries(SeriesList.Items[k]).AddValue[i] := WellInf.Null;
                 if i <> 0 then TSeries(SeriesList.Items[k]).AddValue[i] := TSeries(SeriesList.Items[k]).Data^[i-1]
                           else TSeries(SeriesList.Items[k]).AddValue[i] := WellInf.Null;
              end;
        end;
        // ------  Возможная будующая проверка на разнотактовость -------------------
        if i <> 0 then begin
           if abs(TSeries(SeriesList.Items[0]).Data^[i] - TSeries(SeriesList.Items[0]).Data^[i-1]) > WellInf.Step*1.0001 then begin
           end;
        end;
        // ----- Увеличиваем счетчик данных -------
        RealCountData := RealCountData + 1;
  end;
  // -----  Правка хренового Ласика ----------------
   WellInf.Start := TSeries(SeriesList.Items[0]).Data^[0];
   WellInf.Stop  := TSeries(SeriesList.Items[0]).Data^[RealCountData - 3];
   // ---- Правка --- реалбное количество считанных данных ----------
   for k := 0 to SeriesList.Count - 1 do begin
      TSeries(SeriesList.Items[k]).Count := RealCountData-1;
   end;
   // ---- Правка масива глубины на всякий случай , а вдруг чето не правильно было в ласике--------
   Series := TSeries(SeriesList.Items[0]);
   Series.MinValue := 1000000000;
   Series.MaxValue :=-1000000000;
   for i := 0 to Series.Count - 1 do
        Series.AddValue[i] := Series.Data^[i];
   //   WellInf.Stop  := TSeries(SeriesList.Items[0]).Data^[TSeries(SeriesList.Items[0]).Count - 1];

   // ------ Считаю средний радиус -------------------
    // --------------- Заполняю масив радиусов ------------
    if TypeLasFileLoaded <> lfGisLasFile then
        for i := 0 to 5 do
           if GetElementFromName(C_Chapter,'RAD'+intToStr(i+1)).Dimension <> '----' then RadiusArray[i] := GetSeries('RAD'+intToStr(i+1))
                                                                                    else begin Beep(); MessageDLG('В "LAS" файле отсутсвуют необходимые "радиусы" для расчета среднего радиуса'#10#13'Не возможно создать кривую среднего радиуса "RADS"'#10#13'"Las" файл загружен - продолжайте работу...', mtInformation, [mbOk], 0); exit end;
     // ----------
      if (GetElementFromName(C_Chapter,'RADS').Dimension = '----') and (TypeLasFileLoaded = lfNormalLasFile) then AddNewSeries('RADS', 'Middle radius');
      if (TypeLasFileLoaded = lfNormalLasFile) then begin
           Series := GetSeries('RADS');
           for i := 0 to TSeries(SeriesList.Items[0]).Count - 1 do
             Series.AddValue[i] := (RadiusArray[0].data^[i] + RadiusArray[1].data^[i] + RadiusArray[2].data^[i] + RadiusArray[3].data^[i] + RadiusArray[4].data^[i] + RadiusArray[5].data^[i])/6;
      end;
end;

{===============================================================================
}
procedure TLasFile.CheckCorrection;
var
  LasFileOneLine : TLasFileOneLine;
  i              : Integer;
  Flag           : Boolean;
begin
  Flag := False;
  for i := 0 to Length(P_Chapter) - 1 do begin
     LasFileOneLine := P_Chapter[i];
     if LasFileOneLine.Name = 'NP6' then begin
        if LasFileOneLine.Value = '1' then CalibrationFactor := true
                                      else CalibrationFactor := false;
        flag := true;
     end;
  end;
  // -------------
  if not Flag then begin
     LasFileOneLine.Name      := 'NP6';
     LasFileOneLine.Dimension := '';
     LasFileOneLine.Value     := '0';
     LasFileOneLine.Comments  := 'Correction not present';
     SetLength(P_Chapter, Length(P_Chapter) + 1);
     P_Chapter[Length(P_Chapter) - 1] := LasFileOneLine;
  end;
end;

{===============================================================================
}
procedure TLasFile.Load();
var
  CurrentWorkString : String;
begin
    if FileName = '' then exit;
   // -----------
    CurrentWorkString := '    ';
    CalibrationFactor := false;
   // -----------  Кусок отвечающий за считывание файла -------------
    AssignFile(tfLas, FileName);
    reset(tfLas);
   // -------------  Преобразование данных -----------------------------
   while not eof(tfLas) do begin
          if CurrentWorkString[1] <> '~' then ReadLn(tfLas, CurrentWorkString);
          if CurrentWorkString[1] = '~' then
             case CurrentWorkString[2] of
                'V' : Read___Chapter('V', V_Chapter, CurrentWorkString);
                'W' : Read___Chapter('W', W_Chapter, CurrentWorkString);
                'C' : Read___Chapter('C', C_Chapter, CurrentWorkString);
                'P' : begin Read___Chapter('P', P_Chapter, CurrentWorkString); CheckCorrection(); end;
                'O' : ReadLn(tfLas, CurrentWorkString);
                'A' : begin Read_A_Chapter(CurrentWorkString); break; end;
             end else ReadLn(tfLas, CurrentWorkString);
   end;
   CloseFile(tfLas);
   // ---------------
   // --------- Удаление предыдущего файла ошиббок ----------

   try DeleteFile(ExtractFilePath(Application.ExeName)+'Plastomer.err'); except end;
   if ErrorCounter <> 0 then OutPutCountError(ErrorCounter);
end;

{===============================================================================
}
function TLasFile.LineCoding(aData: TLasFileOneLine): string;
var
  i          : Integer;
begin
  result := '';

  result := ' ' + aData.Name;

  for i := Length(result) to PointPosition + 1 do result := result + ' ';
  Result := Result + '.' + aData.Dimension;

  for i  := Length(Result) to ColonPosition - 1 - Length(aData.Value) do Result := Result + ' ';
  Result := Result + aData.Value + ' : ' + aData.Comments
end;

{===============================================================================
}
function GetNormalString(aString : String):String;
var
  i : integer;
begin
   Result := '';
   for i := 1 to MaxLengthOutString - Length(aString) do Result := Result + ' ';
   Result := Result + aString
end;

{===============================================================================
SAVE   SAVE     SAVE      SAVE      SAVE       SAVE       SAVE         SAVE         SAVE         SAVE}
procedure TLasFile.Save(start, stop : TFloat; Sections : Integer; aFileName : String);
var
  LasFileOneLine : TLasFileOneLine;

  i, k           : Integer;
  NameString     : AnsiString;
  StepArray      : TFloatArray;
  CountSaveData  : integer;

  SaveArray      : array of PFloatPointerArray;
  fStep          : TFloat;
  iBeginPos      : Integer;
  iEndPos        : Integer;
  SeriesCounter  : Integer;
  fSeries        : TSeries;
  fYStep         : TFloat;
//  fSin, fCos     : TFLoat;
//fSinStep, fCosStep : TFloat;
begin
  // ----------------------
  // ----------------------
  // ----------------------
   fStep := WellInf.Step / Sections;
   CountSaveData := Trunc(abs(start-stop) / fStep) + 1;
   if WellInf.start > WellInf.stop then fStep := - fStep;
  // ----------
   SetLength(SaveArray, SeriesList.Count); for i := 0 to SeriesList.Count - 1 do GetMem(SaveArray[i], SizeOf(TFLoat)*CountSaveData);
  // ---- Новый масив глубин
   for i := 0 to CountSaveData - 1 do SaveArray[0]^[i] := start + fStep*i;
   Stop := SaveArray[0]^[CountSaveData - 1];
  // ----------------------
  // ----------------------
  // ----------------------

  NameString := '';
  SetLength(StepArray, SeriesList.Count);

  AssignFile(tfLas, aFileName);
  ReWrite(tfLas);
  // ---------- Пишем раздел "V" -------------
     WriteLn(tfLas, '~VERSION INFORMATION');
     for i := 0 to Length(V_Chapter) - 1 do begin
        LasFileOneLine := V_Chapter[i];
        if LasFileOneLine.Name = 'WRAP' then begin
           LasFileOneLine.Value    := 'No';
           LasFileOneLine.Comments := 'One line per depth';
        end;
        WriteLn(tfLas, LineCoding(LasFileOneLine));
     end;
  // ---------- Пишем раздел "W" -------
    WriteLn(tfLas, '~WELL INFORMATION');
       for i := 0 to Length(W_Chapter) - 1 do begin
          LasFileOneLine := W_Chapter[i];
          if LasFileOneLine.Name = 'STRT' then LasFileOneLine.Value    := FloatToStrF(start                  , ffFixed, 15, 4);
          if LasFileOneLine.Name = 'STOP' then LasFileOneLine.Value    := FloatToStrF(stop                   , ffFixed, 15, 4);
          if LasFileOneLine.Name = 'STEP' then LasFileOneLine.Value    := FloatToStrF(WellInf.Step / Sections, ffFixed, 15, 4);
          WriteLn(tfLas, LineCoding(LasFileOneLine));
       end;
  // ----------------

  // ---------- Пишем раздел "C" -------
  WriteLn(tfLas, '~CURVE INFORMATION SECTION');
     for i := 0 to Length(C_Chapter) - 1 do begin
        LasFileOneLine := C_Chapter[i];
        NameString     := NameString + GetNormalString(LasFileOneLine.Name);
        WriteLn(tfLas, LineCoding(LasFileOneLine));
     end;
  NameString[1] := '#';
  // ---------- Пишем раздел "P" -------
  WriteLn(tfLas, '~PARAMETR INFORMATION SECTION');
     for i := 0 to Length(P_Chapter) - 1 do begin
        LasFileOneLine := P_Chapter[i];
        if LasFileOneLine.Name = 'NP6' then begin
           if CalibrationFactor then begin LasFileOneLine.Value := '1'; LasFileOneLine.Comments := 'Correction present' end
                                else begin LasFileOneLine.Value := '0'; LasFileOneLine.Comments := 'Correction not present' end
        end;
        WriteLn(tfLas, LineCoding(LasFileOneLine));
     end;
  // ---------- Пишем раздел "P" -------
  WriteLn(tfLas, '~OTHER INFORMATION');
  // ---------- Пишем раздел "A" -------
  WriteLn(tfLas, NameString);
  WriteLn(tfLas, '~ASCII DATA');

  // ----------  Делаю новые масивы --------------------
   iBeginPos := GetDepthIndex(Start);
   iEndPos   := GetDepthIndex(Stop);
   for SeriesCounter := 1 to SeriesList.Count - 1 do begin

       fSeries := TSeries(SeriesList.Items[SeriesCounter]);
       for i := iBeginPos to iEndPos - 2 do begin

            if (fSeries.Data^[i+1] <> WellInf.Null) and (fSeries.Data^[i] <> WellInf.Null) then begin
                 if (UpperCase(fSeries.Name[1]) = 'A') and (UpperCase(fSeries.Name[2]) = 'Z') then begin
                     {fSinStep := (sin(fSeries.Data^[i+1]*pi/180) - sin(fSeries.Data^[i]*pi/180))/Sections;
                     fCosStep := (cos(fSeries.Data^[i+1]*pi/180) - cos(fSeries.Data^[i]*pi/180))/Sections;
                     for k := 0 to Sections do begin
                         fSin := sin(fSeries.Data^[i]*pi/180) + k*fSinStep;
                         fCos := cos(fSeries.Data^[i]*pi/180) + k*fCosStep;

                         if (fSin = 0) and (fCos = 0)
                              then SaveArray[SeriesCounter]^[(i-iBeginPos)*Sections + k] := fSeries.NullValue
                              else SaveArray[SeriesCounter]^[(i-iBeginPos)*Sections + k] := ArcTan360(fSin, fCos)*180/pi;


                     end; // --- for k := 0 to Sections do begin}
                     SaveArray[SeriesCounter]^[(i-iBeginPos)*Sections ] := fSeries.Data^[i];
                     for k := 1 to Sections  do begin
                         SaveArray[SeriesCounter]^[(i-iBeginPos)*Sections + k] := WellInf.Null;
                     end;
                 end else begin // --- if (UpperCase(fSeries.Name[1]) = 'A') and (UpperCase(fSeries.Name[1]) = 'Z') then begin
                     fYStep := (fSeries.Data^[i+1] - fSeries.Data^[i])/Sections;
                     for k := 0 to Sections do
                         SaveArray[SeriesCounter]^[(i-iBeginPos)*Sections + k] := fSeries.Data^[i] + k*fYStep;
                 end; // ---- if (UpperCase(fSeries.Name[1]) = 'A') and (UpperCase(fSeries.Name[1]) = 'Z') then begin
            end else begin
               for k := 0 to Sections do begin
                        SaveArray[SeriesCounter]^[(i-iBeginPos)*Sections + k] := WellInf.Null;
               end;
            end;
       end; // --- for i := iBeginPos to iEndPos - 2 do begin
   end; // --- for SeriesCounter := 1 to SeriesList.Count - 1 do begin
  // ----------  Добавляю последний елемент --------------------
   for SeriesCounter := 1 to SeriesList.Count - 1 do begin
       fSeries := TSeries(SeriesList.Items[SeriesCounter]);
       if fSeries.Data^[iEndPos] <> WellInf.Null then begin
          if Sections <> 1 then begin
              for k := 0 to Sections - 1 do
                  SaveArray[SeriesCounter]^[(iEndPos-1-iBeginPos)*Sections + k] := fSeries.Data^[iEndPos]
          end else SaveArray[SeriesCounter]^[CountSaveData -  1]                := fSeries.Data^[iEndPos]
       end;
   end;
  // ----------------------
   for i := 0 to CountSaveData -  1 do begin
      for k := 0 to SeriesList.Count - 1 do
                  Write(tfLas,  GetNormalString(FloatToStrf(SaveArray[k]^[i], ffFixed, 15, 4)));
      WriteLn(tfLas);
   end;

   for i := 0 to SeriesList.Count - 1 do
          FreeMem(SaveArray[i], SizeOf(TFLoat)*CountSaveData);
   (*  // ---------------
  CountSaveData := Trunc(abs(start-stop) / WellInf.Step) + 1;
  BeginPoint    := 0;
  for i := 0 to TSeries(SeriesList.items[0]).Count - 1 do
    if TSeries(SeriesList.items[0]).Data^[i] >= start then begin
         BeginPoint    := i;
         break;
    end;
  // ---------------
  if {(BeginPoint = 0) and} (abs(CountSaveData - TSeries(SeriesList.items[0]).Count) < 3) then
                      CountSaveData := TSeries(SeriesList.items[0]).Count - 1;
  // ---------------
   for i := BeginPoint to BeginPoint + CountSaveData do begin
         NameString := '';
        // ------
         for k := 0 to SeriesList.Count - 1 do begin
            Value1 := TSeries(SeriesList.items[k]).data^[i    ];
            if i = BeginPoint + CountSaveData then Sections     := 1
            else begin
                Value2 := TSeries(SeriesList.items[k]).data^[i + 1];
                StepArray[k] := (Value2 - Value1)/Sections;
            end;
         end;
        // ------
         for t := 0 to Sections - 1 do begin
               for k := 0 to SeriesList.Count - 1 do begin
                  Value1 := TSeries(SeriesList.items[k]).data^[i];

                  if Value1 <> WellInf.Null then Value1 := Value1 + t*StepArray[k];

                  Write(tfLas,  GetNormalString(FloatToStrf(Value1, ffFixed, 15, 4)));
               end;
               WriteLn(tfLas);
         end;
   end;*)
  // -----------------------------------
    CloseFile(tfLas);
  // -----------------------------------
    ChangeLasFile(start, stop, sections, aFileName);
end;

{===============================================================================
}
function TLasFile.GetSeriesIndex(Series: TSeries): integer;
var
  i : integer;
begin
  Result := -1;
  if Series = nil then exit;
  for i := 0 to SeriesList.Count - 1 do
    if TSeries(SeriesList.Items[i]).Name = Series.Name then begin
        Result := i;
        Break;
    end;
end;

{===============================================================================
}
function TLasFile.SeriesPresent(aName: String): boolean;
var
  i : integer;
begin
  Result := false;
  for i := 0 to SeriesList.Count - 1 do
    if UpperCase(TSeries(SeriesList.Items[i]).Name) = UpperCase(aName) then begin
        Result := true;
        Break;
    end;
end;

{===============================================================================
}
function TLasFile.AddNewSeries(aName, aComents: String) : TSeries;
var
  Series : TSeries;
begin
        Series := TSeries.Create;
        SeriesList.Add(Series);

        Series.Name      := aName;
        Series.Count     := TSeries(SeriesList.Items[0]).Count;
        Series.Step      := WellInf.Step;
        Series.NullValue := WellInf.Null;

        GetMem(Series.Data, SizeOf(TFloat)*Series.Count);
        // --------------- Заполняю структуру "LAS" файла ------------ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        SetLength(C_Chapter, Length(C_Chapter)+1);
        C_Chapter[Length(C_Chapter)-1].Name      := aName;
        C_Chapter[Length(C_Chapter)-1].Dimension := '';
        C_Chapter[Length(C_Chapter)-1].Value     := '';
        C_Chapter[Length(C_Chapter)-1].Comments  := intToStr(Length(C_Chapter)) + ' ' + aComents;
        // ------
        Result := Series;
end;

function TLasFile.GetDepthIndex(aDepth: TFloat): Integer;
begin
   Result := Round((aDepth - XValue.MinValue)/ XValue.Step);
   if (Result < 0) or (Result > XValue.Count) then result := -1;
end;

procedure TLasFile.ChangeLasFile(start, stop : TFloat; Sections : Integer; aFileName : String);
{var
  Count, i, k             : Integer;
  Series                  : TSeries;

  iBeginPos               : Integer;
  iEndPos                 : Integer;
  Step                    : TFloat;
  aData                   : PFloatArray;

  NewCountData            : Integer;
  SeriesCounter           : Integer;
 }
begin
{  // ----------------
   FileName := aFileName;
  // -----------
   iBeginPos := GetDepthIndex(Start);
   iEndPos   := GetDepthIndex(Stop);
  // ----------
   WellInf.Step := WellInf.Step / Sections;
  // -----------
   NewCountData := Trunc(abs(start-stop) / WellInf.Step) + 1;
   GetMem(aData, SizeOf(TFloat)*NewCountData);


//   Count     :=
   for SeriesCounter := 0 to LasFile.SeriesList.Count - 1 do begin

       Series := TSeries(SeriesList.Items[SeriesCounter]);
       for i := iBeginPos to iEndPos - 1 do begin
         Step := (Series.Data^[i+1] - Series.Data^[i])/Sections;
         for k := 0 to Sections do begin
             aData^[i*Sections + k] := Series.Data^[i] + k*Step;
         end;
       end;
      // -----------
       FreeMem(Series.Data, SizeOf(TFloat)*Series.Count);
       Series.Data  := aData;
       Series.Step  := WellInf.Step;
       Series.Count := NewCountData;
   end;
{
  WellInf.Start := StrToFloat(GetElementFromName(W_Chapter,'STRT').Value);
  WellInf.Stop  := StrToFloat(GetElementFromName(W_Chapter,'STOP').Value);
  WellInf.Step  := StrToFloat(GetElementFromName(W_Chapter,'STEP').Value);
  WellInf.Null  := StrToFloat(GetElementFromName(W_Chapter,'NULL').Value);
  WellInf.Well  := GetElementFromName(W_Chapter,'WELL').Value;
  WellInf.Field := GetElementFromName(W_Chapter,'FLD').Value;
  WellInf.Loc   := GetElementFromName(W_Chapter,'LOC').Value;
  WellInf.Serv  := GetElementFromName(W_Chapter,'SRVC').Value;
  WellInf.Date  := GetElementFromName(W_Chapter,'DATE').Value;

  Count := abs(Trunc((WellInf.Stop - WellInf.Start)/WellInf.Step)) + 1;

  for i := 0 to Length(C_Chapter) - 1 do begin
     Series := TSeries.Create;
     SeriesList.Add(Series);

     Series.Name      := C_Chapter[i].Name;
     Series.Dimension := C_Chapter[i].Dimension;
     Series.Count     := Count;
     Series.Step      := WellInf.Step;
     Series.NullValue := WellInf.Null;
     GetMem(Series.Data, SizeOf(TFloat)*Series.Count);

     if i = 0 then XValue := Series;
  end;
}
end;

procedure TLasFile.Save_With_Compiled(aFileName: String; aLas1, aLas2 : TLasFile);
var
  LasFileOneLine : TLasFileOneLine;

  i, k           : Integer;
  NameString     : AnsiString;
  StepArray      : TFloatArray;
  CountSaveData  : integer;

  aDepthArray    : PFloatPointerArray;
  aData          : PFloatPointerArray;
  aStep          : TFloat;
  aSeries        : TSeries;
  IndexCounter   : Integer;
  MainLas        : TLasFile;

begin
  NameString := '';
  SetLength(StepArray, SeriesList.Count);

  AssignFile(tfLas, aFileName);
  ReWrite(tfLas);
  // ---------- Пишем раздел "V" -------------
     WriteLn(tfLas, '~VERSION INFORMATION');
     for i := 0 to Length(V_Chapter) - 1 do begin
        LasFileOneLine := V_Chapter[i];
        if LasFileOneLine.Name = 'WRAP' then begin
           LasFileOneLine.Value    := 'No';
           LasFileOneLine.Comments := 'One line per depth';
        end;
        WriteLn(tfLas, LineCoding(LasFileOneLine));
     end;
  // ---------- Пишем раздел "W" -------
    WriteLn(tfLas, '~WELL INFORMATION');
       for i := 0 to Length(W_Chapter) - 1 do begin
          LasFileOneLine := W_Chapter[i];
          if LasFileOneLine.Name = 'STRT' then LasFileOneLine.Value    := FloatToStrF(WellInf.start, ffFixed, 15, 4);
          if LasFileOneLine.Name = 'STOP' then LasFileOneLine.Value    := FloatToStrF(WellInf.stop , ffFixed, 15, 4);
          if LasFileOneLine.Name = 'STEP' then LasFileOneLine.Value    := FloatToStrF(WellInf.Step , ffFixed, 15, 4);
          WriteLn(tfLas, LineCoding(LasFileOneLine));
       end;
  // ---------- Пишем раздел "C" -------
  WriteLn(tfLas, '~CURVE INFORMATION SECTION');
     for i := 0 to Length(C_Chapter) - 1 do begin
        LasFileOneLine := C_Chapter[i];
        NameString     := NameString + GetNormalString(LasFileOneLine.Name);
        WriteLn(tfLas, LineCoding(LasFileOneLine));
     end;
  NameString[1] := '#';
  // ---------- Пишем раздел "P" -------
  WriteLn(tfLas, '~PARAMETR INFORMATION SECTION');
     for i := 0 to Length(P_Chapter) - 1 do begin
        LasFileOneLine := P_Chapter[i];
        if LasFileOneLine.Name = 'NP6' then begin
           if CalibrationFactor then begin LasFileOneLine.Value := '1'; LasFileOneLine.Comments := 'Correction present' end
                                else begin LasFileOneLine.Value := '0'; LasFileOneLine.Comments := 'Correction not present' end
        end;
        WriteLn(tfLas, LineCoding(LasFileOneLine));
     end;
  // ---------- Пишем раздел "P" -------
  WriteLn(tfLas, '~OTHER INFORMATION');
  // ---------- Пишем раздел "A" -------
   WriteLn(tfLas, NameString);
   WriteLn(tfLas, '~ASCII DATA');


   MainLas := aLas1;
   if aLas1  = nil then MainLas := aLas2;
  // ----- Количество данных которые будут записаны --------------
   CountSaveData := Trunc(abs(WellInf.start-WellInf.stop) / WellInf.Step) + 1;
   aStep := WellInf.Step; if WellInf.start > WellInf.stop then aStep := - WellInf.Step;
  // -------- Новый масив глубины -----------
   GetMem(aDepthArray, SizeOf(TFloat)*CountSaveData);
   for i := 0 to CountSaveData - 1 do aDepthArray^[i] := WellInf.start + aStep*i;
  // -----------------------------------------

   for k := 1 to SeriesList.Count - 1 do begin
       aSeries := TSeries(SeriesList.Items[k]);
       GetMem(aData, SizeOf(TFloat)*CountSaveData);
       IndexCounter := 0;
      // ----------
       for i := 0 to CountSaveData -  1 do begin
              if Trunc(aDepthArray^[i]*1000)/1000 = Trunc(TLasFile(aSeries.Parent).XValue.Data^[IndexCounter]*1000)/1000 then begin
                 aData^[i] := aSeries.Data^[IndexCounter];
                 if IndexCounter <  aSeries.Count - 1 then IndexCounter := IndexCounter + 1;
              end else aData^[i] := MainLas.WellInf.Null;
       end;
      // ----------
       FreeMem(aSeries.Data, SizeOf(TFloat)*aSeries.Count);
       aSeries.Data  := aData;
       aSeries.Count := CountSaveData;
   end;
   // --------- Перекидую масив глубины -----------
    aSeries := TSeries(SeriesList.Items[0]);
    FreeMem(aSeries.Data, SizeOf(TFloat)*aSeries.Count);
    aSeries.Data  := aDepthArray;
    aSeries.Count := CountSaveData;
   // ----------------------- ЗАПИСЬ ДАННЫХ ----------

   for i := 0 to CountSaveData -  1 do begin
      for k := 0 to SeriesList.Count - 1 do Write(tfLas,  GetNormalString(FloatToStrf(TSeries(SeriesList.items[k]).data^[i], ffFixed, 15, 4)));
      WriteLn(tfLas);
   end;

  // -----------------------------------*)
    CloseFile(tfLas);
  // -----------------------------------
end;

end.

