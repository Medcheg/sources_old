unit mpiLasFile;

interface

uses Classes, mpiDeclaration;

type
   PBuffer   =  PChar;

   TTwoValue = record
      Depth : Float;
      Kanal : Integer;
   end;

   TWellInf = record
      Start       : Float;
      Stop        : Float;
      Step        : Float;
      Null        : Float;
      Well        : String;
      Field       : String;
      Loc         : String;
      Serv        : String;
      Date        : String;
   end;

   TLasFile = class
   private

      function CheckPresentSeries(aName : String): boolean;

      procedure Load_VersionInformation(CurStr : String);
      procedure Load_WellInformation(CurStr : String);
      procedure Load_ParametrInfomation(CurStr : String);
      procedure Load_CurveInformation(CurStr : String);
   public
      WellInf           : TWellInf;
      FileName          : String;
      CountDataElement  : Integer;
      CalibrationFactor : Boolean; // ---- Прокалибрированная реализация --------

      SeriesList  : TList;
      XValue      : TSeries;

      ErrorCounter : Integer;
      ErrorList    : array of TTwoValue;

      procedure   Load();
      procedure   Save(start, stop : float; aFileName : String);
      function GetSeries(aName : String):TSeries;
      constructor create(aFileName : String);
      destructor  destroy; override;
   end;

var
  LasFile       : TLasFile;

implementation

uses SysUtils, Dialogs, Forms;

var
   Shapka : array of AnsiString;

{ TLasFile }

constructor TLasFile.create(aFileName : String);
begin
  inherited create;
  SeriesList := TList.Create;
  FileName := aFileName;
end;

destructor TLasFile.destroy;
var
  i : integer;
begin
  if SeriesList.Count <> 0 then
    for i := 0 to SeriesList.Count - 1 do TSeries(SeriesList.Items[i]).Free;

  SeriesList.Free;
  inherited destroy;
end;

//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load_VersionInformation(CurStr : String);
begin

end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load_WellInformation(CurStr : String);
  function GetFloatValue(InputStr : String; pos : Integer) : Float;  var i : integer; ResultString : String; FirstSymbol  : Boolean; begin ResultString := ''; FirstSymbol := False; for i := pos to 255 do if (InputStr[i] in ['0'..'9']) or (InputStr[i] = '.') or (InputStr[i] = '-') or (UpperCase(InputStr[i]) = 'E')then begin ResultString := ResultString + InputStr[i]; FirstSymbol := True; end else if FirstSymbol then break; Result := StrToFloat(ResultString);end;
  function GetTextValue (InputStr : String; pos : Integer) : String; var i : integer; FirstSymbol  : Boolean;                        begin Result       := ''; FirstSymbol := False; for i := pos to 255 do begin if InputStr[i] <> ' ' then FirstSymbol := True; if InputStr[i] = ':' then Break; if FirstSymbol then Result := Result + InputStr[i]; end;end;
begin
  if AnsiPos('STRT', CurStr) <> 0 then WellInf.Start := GetFloatValue(CurStr, 12);
  if AnsiPos('STOP', CurStr) <> 0 then WellInf.Stop  := GetFloatValue(CurStr, 12);
  if AnsiPos('STEP', CurStr) <> 0 then WellInf.Step  := GetFloatValue(CurStr, 12);
  if AnsiPos('NULL', CurStr) <> 0 then WellInf.Null  := GetFloatValue(CurStr, 12);
  if AnsiPos('WELL', CurStr) <> 0 then WellInf.Well  := GetTextValue(CurStr, 12);
  if AnsiPos('FLD',  CurStr) <> 0 then WellInf.Field := GetTextValue(CurStr, 12);
  if AnsiPos('LOC',  CurStr) <> 0 then WellInf.Loc   := GetTextValue(CurStr, 12);
  if AnsiPos('SRVC', CurStr) <> 0 then WellInf.Serv  := GetTextValue(CurStr, 12);
  if AnsiPos('DATE', CurStr) <> 0 then WellInf.Date  := GetTextValue(CurStr, 12);
end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load_ParametrInfomation(CurStr : String);
begin

end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load_CurveInformation(CurStr : String);
var
  Series            : TSeries;
  function GetSeriesName(aStr : String): String; var i : integer; begin Result := ''; for i := 1 to 255 do if aStr[i] = '.' then Break else Result := Result + aStr[i]; end;
begin
  Series := TSeries.Create;
  SeriesList.Add(Series);

  Series.Name      := GetSeriesName(CurStr);
  Series.Count     := CountDataElement;
  Series.Step      := WellInf.Step;
  Series.NullValue := WellInf.Null;

  GetMem(Series.Data, SizeOf(Series.Data)*Series.Count);
end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure OutPutError(aErrorCounter : Integer);
var
  CountDec, Res : Integer;
  MyStr         : String;
begin
   CountDec := aErrorCOunter div 10;
   res      := aErrorCounter mod CountDec*10;
   MyStr    := '';
   case res of
     1    : MyStr := 'ка';
     2..4 : MyStr := 'ки';
     5..9 : MyStr := 'об';
     0    : MyStr := 'об';
   end;
   MessageDlg(intToStr(aErrorCounter) + ' Ошиб' + MyStr + ' в "LAS" файле', mtInformation, [mbOk], 0);
end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load();
var
  CurrentWorkString : String;

  n, k, i           : Integer;
  f                 : TextFile;
  floatValue        : Float;
  Series            : TSeries;
  RadiusArray       : array [0..5] of TSeries;
begin
   CurrentWorkString := '    ';
   FloatValue        := 0;
   ErrorCounter      := 0;
   CalibrationFactor := false;
   SetLength(ErrorList, 0);
   // -----------  Кусок отвечающий за считывание файла -------------
   AssignFile(f, LasFile.FileName);
   reset(f);
   //if iFileHandle = -1 then begin MessageDlg('Ошибка доступа к файлу', mtError, [mbOK],0); exit; end;
   // -------------  Преобразование данных -----------------------------
   while not eof(f) do begin
          if CurrentWorkString[1] <> '~' then
                ReadLn(f, CurrentWorkString);

          if CurrentWorkString[1] = '~' then
             case CurrentWorkString[2] of
                'V' : begin ReadLn(f, CurrentWorkString); while CurrentWorkString[1] <> '~' do begin if CurrentWorkString[1] <> '#' then Load_VersionInformation(CurrentWorkString); ReadLn(f, CurrentWorkString); end; end;
                'W' : begin ReadLn(f, CurrentWorkString); while CurrentWorkString[1] <> '~' do begin if CurrentWorkString[1] <> '#' then Load_WellInformation(CurrentWorkString);    ReadLn(f, CurrentWorkString); end; CountDataElement := abs(Trunc((WellInf.Stop - WellInf.Start)/WellInf.Step)); end;
                'P' : begin ReadLn(f, CurrentWorkString); while CurrentWorkString[1] <> '~' do begin if CurrentWorkString[1] <> '#' then Load_ParametrInfomation(CurrentWorkString); ReadLn(f, CurrentWorkString); end; end;
                'C' : begin ReadLn(f, CurrentWorkString); while CurrentWorkString[1] <> '~' do begin if CurrentWorkString[1] <> '#' then Load_CurveInformation(CurrentWorkString);   ReadLn(f, CurrentWorkString); end; end;
                'O' : begin ReadLn(f, CurrentWorkString); while CurrentWorkString[1] <> '~' do begin if AnsiPos('NP6_1', CurrentWorkString) <> 0 then CalibrationFactor := True; ReadLn(f, CurrentWorkString); end; end;
                'A' : begin
                          for n := 0 to CountDataElement - 1 do begin
                             // ------ Загрузка данных ++++ Обработка ошибок данных -----
                             // ------- если в данных чего-то там неправильно, значит виноват тот кто предоставил данные ---
                             for k := 0 to SeriesList.Count - 1 do begin
                                   try
                                      Read(f, FloatValue);
                                   except
                                      SetLength(ErrorList, ErrorCounter + 1);
                                      ErrorList[ErrorCounter].Depth := TSeries(SeriesList.Items[0]).data^[n];
                                      ErrorList[ErrorCounter].Kanal := k;
                                      ErrorCounter                  := ErrorCounter + 1;
                                   end;
                                   TSeries(SeriesList.Items[k]).AddValue[n] := FloatValue;
                             end;
                         end;
                         break;
                      end;
             end;
   end;
   // ------------------------------------------------------------------
   WellInf.Start := TSeries(SeriesList.Items[0]).Data^[0];
   WellInf.Stop  := TSeries(SeriesList.Items[0]).Data^[CountDataElement - 1];
   // ------------------------------------------------------------------
   CloseFile(f);
   // ---------------
   if ErrorCounter <> 0 then OutPutError(ErrorCounter);
   // ------------------------------------------------------------------
   // ------ Считаю средний радиус *-------------------
   if not CheckPresentSeries('RADS') then begin
        Series := TSeries.Create;
        SeriesList.Add(Series);

        Series.Name      := 'RADS';
        Series.Count     := CountDataElement;
        Series.Step      := WellInf.Step;
        Series.NullValue := WellInf.Null;

        GetMem(Series.Data, SizeOf(Series.Data)*Series.Count);
        for i := 0 to 5 do begin
           if CheckPresentSeries('RAD'+intToStr(i+1)) then RadiusArray[i] := GetSeries('RAD'+intToStr(i+1))
                                                      else begin MessageDLG('Неверный тип LAS файла'#10#13'Не возможно создать кривую среднего радиуса "RADS"', mtError, [mbOk], 0); exit end;
        end;
        for i := 0 to CountDataElement - 1 do
          Series.AddValue[i] := (RadiusArray[0].data^[i] + RadiusArray[1].data^[i] + RadiusArray[2].data^[i] + RadiusArray[3].data^[i] + RadiusArray[4].data^[i] + RadiusArray[5].data^[i])/6;
   end;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function FindLinePos(aStr : String):integer;
var
 i, k, n : Integer;
 flag    : boolean;
begin
  Result := -1;
  for i := 0 to Length(Shapka) - 1 do begin
     n    := 1;
     flag := False;

     for k := 1 to Length(Shapka[i]) do begin
         if UpperCase(Shapka[i][k]) = aStr[n] then begin
           flag := True;
           n := n + 1;
         end else begin
           if Flag then begin
              if n = Length(AStr) + 1 then begin
                 Result := i;
                 exit;
              end else begin
                 flag := False;
                 n    := 1;
              end;
           end
         end;
     end;
  end;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function SetElementString(aStr : AnsiString; Value : Float) : AnsiString;
var
 k, i         : Integer;
 aPos1, aPos2 : Integer;
 StrValue     : String;
begin
  aPos1 := 1;
  aPos2 := 1;
  k := 1;
  // -----  Устанавливаем первую позицию в строке ------------------
  for i := 1 to Length(aStr) do if aStr[i] = '.' then begin k := i + 1; break; end;
  for i := k to Length(aStr) do
     if aStr[i] = ' ' then begin
       aPos1 := i;
       break;
     end;
  // -----  Устанавливаем Вторую позицию в строке ------------------
  for i := 1 to Length(aStr) do if aStr[i] = ':' then begin k := i; break; end;
  for i := k downto 1 do
     if Ord(aStr[i]) - 48 in [0..9] then begin
       aPos2 := i + 1;
       break;
     end;
  // -------------------
  StrValue := FLoatToStrF(Value, ffFixed, 15, 2);
  Result   := '';
  for i := 1 to aPos1 do Result := Result + aStr[i];
  for i := aPos1+1 to aPos2 - Length(StrValue) - 1 do Result := Result + ' ';
  Result := Result + StrValue;
  for i := aPos2 to Length(aStr) do Result := Result + aStr[i];
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function GetNormalString(aString : String):String;
var
 i : integer;
begin
   Result := '';
   for i := 1 to 12 - Length(aString) do Result := Result + ' ';
   Result := Result + aString
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure DeleteRems();
var i : integer;
    Flag : Boolean;
begin
  Flag := False;
  for i := Length(Shapka) -  1 downto Length(Shapka) -  5 do begin
       if Shapka[i][1] = '#' then begin
          Shapka[i] := '#';
          Flag := True;
       end;
  end;
  //------------------
  if Not Flag then begin
     SetLength(Shapka, Length(Shapka)+1);
     Shapka[Length(Shapka)-1] := Shapka[Length(Shapka)-2];
  end;
  //-------------------
  Shapka[Length(Shapka)-2] := '';
  for i := 0 to LasFile.SeriesList.Count - 1 do
      Shapka[Length(Shapka)-2] := Shapka[Length(Shapka)-2] + GetNormalString(TSeries(LasFile.SeriesList.items[i]).Name);
  //--------------------------
  Shapka[Length(Shapka)-2][1]  := '#';
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TLasFile.Save(start, stop : float; aFileName : String);
var
  CurString     : AnsiString;
  StringCounter : Integer;
  f             : TextFile;
  i, k          : Integer;
  // ---------------------------
  el            : Integer;
  // ---------------------------
begin
  // --------- Читаем шапку -----------------------------
  AssignFile(f, LasFile.FileName);
  Reset(f);

  StringCounter := 0;
  while Not eof(f) do begin
    SetLength(Shapka, StringCounter + 1);
    ReadLn(f, CurString);

    Shapka[StringCounter] := CurString;

    inc(StringCounter);
    if CurString[1] = '~' then
         if UpperCase(CurString[2]) = 'A' then Break;
  end;
  CloseFile(f);
  // ---------  Исправляем шапку -----------------------
  el := FindLinePos('STRT'); Shapka[el] := SetElementString(Shapka[el], start);
  el := FindLinePos('STOP'); Shapka[el] := SetElementString(Shapka[el], stop);
  DeleteRems();
  // ---------  Пишем данные   -------------------------
  AssignFile(f, aFileName);
  Rewrite(f);
  for i := 0 to Length(Shapka) - 1 do
      WriteLn(f, Shapka[i]);
  //-----------------
  for i := 0 to CountDataElement - 1 do begin
    if TSeries(LasFile.SeriesList.items[0]).Data^[i] >= start then begin
         for k := 0 to LasFile.SeriesList.Count - 1 do
            Write(f,  GetNormalString(FloatToStrf(TSeries(LasFile.SeriesList.items[k]).data^[i], ffFixed, 15, 2)));

         WriteLn(f);
    end;
    //----
    if TSeries(LasFile.SeriesList.items[0]).Data^[i] > Stop then Break;
  end;

  CloseFile(f);
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function TLasFile.CheckPresentSeries(aName: String): boolean;
var
  i : integer;
begin
  Result := False;

  for i := 0 to SeriesList.Count - 1 do begin
      if TSeries(SeriesList.Items[i]).Name = aName then begin
           Result := True;
           Break;
      end;
  end;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function TLasFile.GetSeries(aName: String): TSeries;
var
  i : integer;
begin
  Result := nil;

  for i := 0 to SeriesList.Count - 1 do begin
      if TSeries(SeriesList.Items[i]).Name = aName then begin
           Result := TSeries(SeriesList.Items[i]);
           Break;
      end;
  end;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
end.
