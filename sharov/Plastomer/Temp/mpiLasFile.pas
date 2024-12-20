      unit mpiLasFile;

interface

uses Classes, mpiDeclaration;

type
   PBuffer   =  PChar;

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
      Buffer  : PChar;


      procedure Load_VersionInformation(var i : Integer);
      procedure Load_WellInformation(var i : Integer);
      procedure Load_ParametrInfomation(var i : Integer);
      procedure Load_CurveInformation(var i : Integer);
      procedure Load_Series(var i : Integer);

      function GetNextStringFromBuffer(Buffer : PBuffer; var i : integer): PChar;
   public
      WellInf           : TWellInf;
      FileName          : String;
      CountDataElement  : Integer;

      SeriesList  : TList;
      XValue      : TSeries;

      Shapka      : array of String;
      procedure Load();
      procedure Save();
      procedure SetArrayForSeries(Count : Integer);
      constructor create(aFileName : String);
      destructor  destroy; override;
   end;

var
  LasFile : TLasFile;

implementation

uses SysUtils, Dialogs;

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

function TLasFile.GetNextStringFromBuffer(Buffer: PBuffer;
  var i: integer): PChar;
var stringLength : Integer;
begin
  stringLength := 0; while (Buffer[i + stringLength] <> #10) do stringLength := stringLength + 1;
  Result                   := PChar(@Buffer[i]);
  Result[StringLength - 1] := #0;
  Result[StringLength + 0] := #0;
  i := i + StringLength + 1;
end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load_VersionInformation(var i: Integer);
begin

end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load_WellInformation(var i: Integer);
var
  CurrentWorkString : PChar;
  FlagArray         : array [1..9] of boolean;

  function GetFloatValue(InputStr : PChar; pos : Integer; var Flag : Boolean) : Float;  var i : integer; ResultString : String; FirstSymbol  : Boolean; begin ResultString := ''; FirstSymbol := False; for i := pos to 255 do if (InputStr[i] in ['0'..'9']) or (InputStr[i] = '.') or (InputStr[i] = '-') or (UpperCase(InputStr[i]) = 'E')then begin ResultString := ResultString + InputStr[i]; FirstSymbol := True; end else if FirstSymbol then break; Result := StrToFloat(ResultString); Flag   := true; end;
  function GetTextValue (InputStr : PChar; pos : Integer; var Flag : Boolean) : String; var i : integer; FirstSymbol  : Boolean;                        begin Result       := ''; FirstSymbol := False; for i := pos to 255 do begin if InputStr[i] <> ' ' then FirstSymbol := True; if InputStr[i] = ':' then Break; if FirstSymbol then Result := Result + InputStr[i]; end; Flag   := true; end;
begin
  fillChar(FlagArray, SizeOf(FlagArray), 0);
  while Buffer[i] <> '~' do begin // ---- ���� �� ����� ���������� �������� ������ ���������� --------
       CurrentWorkString := GetNextStringFromBuffer(Buffer, i);
       if CurrentWorkString[0] <> '#' then begin   // --- ���������� ������ � ����������� -----
             if (not FlagArray[1]) and (AnsiPos('STRT', CurrentWorkString) <> 0) then WellInf.Start := GetFloatValue(CurrentWorkString, 12, FlagArray[1]) else
             if (not FlagArray[2]) and (AnsiPos('STOP', CurrentWorkString) <> 0) then WellInf.Stop  := GetFloatValue(CurrentWorkString, 12, FlagArray[2]) else
             if (not FlagArray[3]) and (AnsiPos('STEP', CurrentWorkString) <> 0) then WellInf.Step  := GetFloatValue(CurrentWorkString, 12, FlagArray[3]) else
             if (not FlagArray[4]) and (AnsiPos('NULL', CurrentWorkString) <> 0) then WellInf.Null  := GetFloatValue(CurrentWorkString, 12, FlagArray[4]) else
             if (not FlagArray[5]) and (AnsiPos('WELL', CurrentWorkString) <> 0) then WellInf.Well  := GetTextValue(CurrentWorkString, 12, FlagArray[5]) else
             if (not FlagArray[6]) and (AnsiPos('FLD',  CurrentWorkString) <> 0) then WellInf.Field := GetTextValue(CurrentWorkString, 12, FlagArray[6]) else
             if (not FlagArray[7]) and (AnsiPos('LOC',  CurrentWorkString) <> 0) then WellInf.Loc   := GetTextValue(CurrentWorkString, 12, FlagArray[7]) else
             if (not FlagArray[8]) and (AnsiPos('SRVC', CurrentWorkString) <> 0) then WellInf.Serv  := GetTextValue(CurrentWorkString, 12, FlagArray[8]) else
             if (not FlagArray[9]) and (AnsiPos('DATE', CurrentWorkString) <> 0) then WellInf.Date  := GetTextValue(CurrentWorkString, 12, FlagArray[9]) ;
       end;
   end;

   CountDataElement := Trunc((WellInf.Stop - WellInf.Start)/WellInf.Step);
end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load_ParametrInfomation(var i : Integer);
begin

end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
//*************************************************************************************************************************************
procedure TLasFile.Load_CurveInformation(var i: Integer);
var
  CurrentWorkString : PChar;
  Series            : TSeries;
  function GetSeriesName(aStr : PChar): String; var i : integer; begin Result := ''; for i := 0 to 255 do if aStr[i] = '.' then Break else Result := Result + aStr[i]; end;
begin
  while Buffer[i] <> '~' do begin // ---- ���� �� ����� ���������� �������� ������ ���������� --------
       CurrentWorkString := GetNextStringFromBuffer(Buffer, i);
       if CurrentWorkString[0] <> '#' then begin   // --- ���������� ������ � ����������� -----
             Series := TSeries.Create;
             SeriesList.Add(Series);

             Series.Name      := GetSeriesName(CurrentWorkString);
             Series.Count     := CountDataElement;
             Series.Step      := WellInf.Step;
             Series.NullValue := WellInf.Null;

             GetMem(Series.Data, SizeOf(Series.Data)*Series.Count);
       end;
  end;
end;

procedure TLasFile.Load_Series(var i : Integer);
var
  n, k : Integer;
  function GetNextFloatValue(var i : Integer) : Float;
  {}var
  {}  ResultString : String;
  {}  FirstSymbol  : Boolean;
  begin
  {}   ResultString := '';
  {}   FirstSymbol  := False;
  {}   while true do begin // ---- �������� ���� � ����� -------
  {}       if Buffer[i] = '#' then begin   // ---- ���� ���������� -----
  {}              Repeat Inc(i); until (Buffer[i] = #13) and (Buffer[i+1] = #10); inc(i, 2); // ---- ���� ���������� �� �� ����� ����� ������ -----
  {}       end else begin
  {}         if (Buffer[i] in ['0'..'9']) or (Buffer[i] = '.') or (Buffer[i] = '-') then begin
  {}              ResultString := ResultString + Buffer[i];
  {}              FirstSymbol := True;
  {}              inc(i);
  {}         end else if FirstSymbol then break else inc(i);
  {}       end;
  {}   end;
  {}
  {}   Result := StrToFloat(ResultString);
  end;

begin
  for n := 0 to CountDataElement - 1 do
     for k := 0 to SeriesList.Count - 1 do
        TSeries(SeriesList.Items[k]).AddValue[n] := GetNextFloatValue(i);
end;

procedure TLasFile.Load();
var
  iFileHandle       : Integer;
  iFileLength       : Int64;
  iBytesRead        : LongInt;

  CurrentWorkString : PChar;

  i                 : LongInt;
begin
   i      := 0;
   // -----------  ����� ���������� �� ���������� ����� -------------
   iFileHandle := FileOpen(LasFile.FileName, fmOpenRead);

   if iFileHandle = -1 then begin MessageDlg('������ ������� � �����', mtError, [mbOK],0); exit; end;

   iFileLength := FileSeek(iFileHandle,0,2);
   GetMem (Buffer, iFileLength);
   FileSeek(iFileHandle,0,0);
   iBytesRead  := FileRead (iFileHandle, Buffer^, iFileLength);
   FileClose(iFileHandle);
   // -------------  �������������� ������ -----------------------------
   While i < iBytesRead do begin
          CurrentWorkString := GetNextStringFromBuffer(Buffer, i);

          if CurrentWorkString[0] = '~' then
             case CurrentWorkString[1] of
                'V' : Load_VersionInformation(i);
                'W' : Load_WellInformation(i);
                'P' : Load_ParametrInfomation(i);
                'C' : Load_CurveInformation(i);
                'A' : Load_Series(i);
             end;
   end;
   // ------------------------------------------------------------------
   FreeMem (Buffer, iFileLength);
end;

procedure TLasFile.Save();
begin

end;

procedure TLasFile.SetArrayForSeries(Count : Integer);
var
 i : integer;
begin
  //--------------  ��������� �������� ��� ��� ������������ �������� ����� -------
  for i := 0 to SeriesList.Count - 1 do begin
      SetLength(TSeries(SeriesList.Items[i]).GraphPoints , Count);
      SetLength(TSeries(SeriesList.Items[i]).ValuesPoints, Count);
  end;
end;

end.
