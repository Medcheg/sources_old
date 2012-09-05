unit Unit_SaveDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, FileCtrl,
  MPIDeclaration;

type
  TfrmSaveDialog = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    Bevel1: TBevel;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DirEditBeforeExecute(Sender: TObject);
    procedure DirEditAfterExecute(Sender: TObject);
    procedure DirEditChange(Sender: TObject);
  private
    ProjectPath : String;
    function CheckProjectPath(Path : String) : boolean;
    function CheckFileError  (Handle : integer) : boolean;
    function Get_FileNameFromFilePath(FileName: String): String;
    function Get_FileNameWitOutFileExtention(FileName: String):String;
    function Get_NormalLine_30(AString : String):String;
    procedure PrepareDataToSaveFile();
    procedure SaveFileTo_LAS_Format(CurFile : TFile);
    procedure SaveFileTo_DAN_Format(CurFile : TFile);

  public
      function  SaveShablonPlanshet(Path, FileName : string; bSaveFiles : Boolean):boolean;
      procedure LoadShablonPlanshet(Path, FileName : string; bLoadFiles : Boolean);
  end;

var
  frmSaveDialog: TfrmSaveDialog;

implementation

uses Unit_PlanshetCreator, Unit_PlanshetParam, Unit_SaveType,
     Unit_Main, Unit_HeadingOfTheDiagram;

{$R *.DFM}

function TfrmSaveDialog.Get_FileNameWitOutFileExtention(
  FileName: String): String;
var
  FirstPos  : Integer;  // --- Slesh
  SecondPos : Integer;  // --- Point
  i         : Integer;
begin
  //----------------------------------
  FirstPos := 1;
  for i:=Length(FileName) DownTo 1 do
     if FileName[i] = '\' then begin
       FirstPos := i + 1;
       Break;
     end;
  //----------------------------------
  SecondPos:=FirstPos;
  for i:=FirstPos to Length(FileName) do begin
    SecondPos := i;
    if FileName[i] = '.' then Break;
  end;
  //  --------------------------------
  Result := Copy(FileName, FirstPos , SecondPos - FirstPos);
end;

function TfrmSaveDialog.Get_FileNameFromFilePath(FileName: String): String;
var
  i                  : integer;
  PositionFirstSlesh : Integer;
  FirstPos           : Integer;
begin
   // ---- Опредиляю позицию последнего слеша --------
   if FileName[Length(FileName)] = '\' then FirstPos := Length(FileName)-1
                                       else FirstPos := Length(FileName);

   PositionFirstSlesh := 0;
   for i:= FirstPos Downto 1 do
      if FileName[i] = '\' then begin
         PositionFirstSlesh := i+1;
         break;
      end;
   if PositionFirstSlesh = 0 then begin
     Result := FileName;
     exit;
   end;
   // --- Определяю Имя файла без полгного пути к нему ---
   Result := '';
   for i:= PositionFirstSlesh to FirstPos do begin
      Result := Result + ' ';
      Result[i - PositionFirstSlesh + 1]:= FileName[i];
   end;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.FormShow(Sender: TObject);
var
   i             : integer;
   Path          : String;
begin
  //---------------------------
  Path := ExtractFilePath(Application.ExeName) + 'Проекты';
  SetCurrentDir(Path);
  //---------------------------
  ProjectPath                 := Path;
  //---------------------------
  ListBox1.Items.Assign(frmPlanshetCreator.ListBox1.Items);

  for i:=0 to listbox1.items.count - 1 do ListBox1.Selected[i] := true;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.DirEditAfterExecute(Sender: TObject);
begin
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.DirEditBeforeExecute(Sender: TObject);
begin
  //ProjectPath  := DirEdit.DirDialog.Directory;
  //DirEdit.Text := ProjectPath;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.DirEditChange(Sender: TObject);
begin
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function TfrmSaveDialog.CheckFileError(Handle: integer): boolean;
// --- 'Result = true'  --- esli Sohibka otrytija Fajla ---
begin
  Result := False;
  if Handle <> -1 then exit;
  Result := True;
  beep;
  MessageDlg('Ошибка создания файла проэкта', mtWarning, [mbOk],0);
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.LoadShablonPlanshet(Path, FileName: string; bLoadFiles : Boolean);
var
  iFileHandle  : Int64;
begin
  fillChar(ChartParam   , SizeOf(ChartParam),0);
  fillChar(ProjectRecord, SizeOf(ProjectRecord),0);
  fillChar(FileListArray, SizeOf(FileListArray),0);
  If not bLoadFiles then FileName := FileName + '.shab'
                    else FileName := FileName + '.prj';

  iFileHandle := FileOpen(Path + FileName, fmOpenRead);

  FileRead  (iFileHandle, ChartParam  , sizeOf(ChartParam  ));
  FileRead  (iFileHandle, PanelArray   , sizeOf(PanelArray ));
  If bLoadFiles then Begin
      FileRead  (iFileHandle, ProjectRecord, sizeOf(ProjectRecord));
      FileRead  (iFileHandle, FileListArray, sizeOf(FileListArray));
      FileRead (iFileHandle,  LegendArray ,  sizeOf(LegendArray));
      FileRead (iFileHandle,  CaptionArray,  sizeOf(CaptionArray));
      Load_LegendArray();
      Load_CaptionArray();
  end;
  FileClose(iFileHandle);
  //----------------------------------
  Load_DataPanelArrayToHeadingDiagram();
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function TfrmSaveDialog.SaveShablonPlanshet(Path, FileName: string; bSaveFiles : Boolean): Boolean;
var
  iFileHandle      : Int64;
  ResultMessageDlg : Integer;
  i,k              : Integer;
begin
  Result := False;
  If not bSaveFiles then begin
    FileName := FileName + '.shab';
    if FileExists(Path+FileName) then begin
      beep;
      ResultMessageDlg := MessageDlg('Шаблон проекта с именем "'+Path+FileName+'" уже существует'#13#13'Перезаписать шаблон проекта ?', mtWarning, [mbOk, mbCancel],0);
      if ResultMessageDlg = mrCancel then begin
        Result := True;
        exit;
      end;
    end;

  end
    else begin
      FileName := FileName + '.prj';
      Form1.caption := Form1Caption + ' - ['+FileName+']'

    end;

  // ---- Подготавливаю FileListArray ----
       for i:=0 to ListBox1.Items.Count-1 do
          FileListArray[i] := ExtractFileName(TFile(frmPlanshetCreator.ListBox1.items.Objects[i]).FileName);
  // ---- Еще одна подготовка -----
  for i:=0 to frmPlanshetParam.sePoleCount.Value-1 do
    for k := 0 to ProjectRecord.MainData[i].CountItems - 1 do
       ProjectRecord.MainData[i].FileName[k] := ExtractFileName(ProjectRecord.MainData[i].FileName[k]);
  // --- Еще одна подготовка ------
  Save_LegendArray();
  // --- Еще одна подготовка ------
  Save_CaptionArray();


  iFileHandle := FileCreate(Path+FileName); if CheckFileError(iFileHandle) then exit;
  FileWrite (iFileHandle, ChartParam   , sizeOf(ChartParam   ));
  FileWrite (iFileHandle, PanelArray   , sizeOf(PanelArray   ));
  FileWrite (iFileHandle, ProjectRecord, sizeOf(ProjectRecord));
  FileWrite (iFileHandle, FileListArray, sizeOf(FileListArray));

  FileWrite (iFileHandle, LegendArray, sizeOf(LegendArray));
  FileWrite (iFileHandle, CaptionArray, sizeOf(CaptionArray));

  FileClose(iFileHandle);
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function TfrmSaveDialog.CheckProjectPath(Path: String): boolean;
var
 CurFileName : String;
 Handle      : Integer;
begin
  Result:= False;

  CurFileName := Path+'_____.___';
  Handle := FileCreate(CurFileName);
  if Handle = -1 then exit;

  FileClose(Handle);
  DeleteFile(CurFileName);

  Result := True;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.PrepareDataToSaveFile;
var
 MySeries : TMySeries;
 CurFile  : TFile;

 FileCounter   : Integer;
 PoleCounter   : Integer;
 SeriesCounter : Integer;
 DataCounter   : Integer;
begin
  for FileCounter := 0 to ListBox1.items.Count -1 do begin

     CurFile := TFile(ListBox1.items.Objects[FileCounter]);
     for PoleCounter :=1 to frmPlanshetParam.sePoleCount.Value do begin
         for SeriesCounter :=0 to Form1.SeriesList[PoleCounter].Count-1 do begin
             MySeries := TMySeries(Form1.SeriesList[PoleCounter].Items[SeriesCounter]);

             if CurFile.FileName = MySeries.FileName then begin
                CurFile.Data[MySeries.DataType].StartDate := MySeries.StartDateTime;

                for DataCounter := 0 to CurFile.Data[MySeries.DataType].CountData - 1 do
                  CurFile.Data[MySeries.DataType].Data[DataCounter] := MySeries.Data[DataCounter];

             end; // --- if CurFile.FileName = MySeries.FileName then begin
         end; // --- for SeriesCounter :=0 to Form1.SeriesList[PoleCounter].Count-1 do begin
     end; // --- for PoleCounter :=1 to frmPlanshetParam.sePoleCount.Value do begin
  end; // --- for FileCounter := 0 to ListBox1.items.Count - 1 do begin
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function TfrmSaveDialog.Get_NormalLine_30(AString: String): String;
var
 i : integer;
begin
 Result := '';
 for i:=1 to 30 - Length(AString) do Result := Result + ' ' ;
 Result := Result + AString;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.SaveFileTo_LAS_Format(CurFile: TFile);
function Get_FileTime(AString : String):String;
var
 i : integer;
begin
 Result := Astring;
 for i:=1 to Length(Result) do if Result[i] = ':' then Result[i]:=' ';

end;
var
  FileName : String;
  f        : TextFile;
  Step     : Extended;
  FirstElememt : String;
  LastElememt  : String;
  StepElement  : String;
  Company      : String;
  Well         : String;
  Field        : String;
  LogDate      : String;
  TimeLog      : String;
  i            : Integer;
  Value1       : String;
  Value2       : String;
  Value3       : String;
  Value4       : String;
  Value5       : String;
  CurFileTime  : String;
begin
  FileName := Get_FileNameWitOutFileExtention(CurFile.FileName) + '.las';
  AssignFile(f, FileName);
  ReWrite(f);

  Step         := (CurFile.Data[dtPressure].TimeData[2] - CurFile.Data[dtPressure].TimeData[1])/TimeInOneSecond;
  FirstElememt := Get_NormalLine_30(FloatToStrf(Step, fffixed,3,3));
  LastElememt  := Get_NormalLine_30(FloatToStrf((CurFile.Data[dtPressure].CountData-2)*Step, fffixed,5,3));
  StepElement  := FirstElememt;
  Company      := Get_NormalLine_30(frmHeadingOfTheDiagram.panel12.Caption);
  Well         := Get_NormalLine_30(frmHeadingOfTheDiagram.panel7.Caption);  // --- Имя скважены
  Field        := Get_NormalLine_30(frmHeadingOfTheDiagram.panel8.Caption); // --- Имя Площади ---
  LogDate      := Get_NormalLine_30(DateToStr(CurFile.Data[dtPressure].StartDate));
  TimeLog      := Get_NormalLine_30(TimeToStr(CurFile.Data[dtPressure].TimeData[0]));

  WriteLn(f, '~Version information ');
  WriteLn(f, '  VERS.                             2.0: LAS - version 2.0 ');
  WriteLn(f, '  WRAP.                              No: One line per depth step');
  WriteLn(f, '~Well information ');
  WriteLn(f, '# MNEM.UNIT                        DATA  INFORMATION ');
  WriteLn(f, '# ====.================================: ===================  ');
  WriteLn(f, '  STRT.DS'+ FirstElememt             +': First depth in file  '); // --- первое измерение ---
  WriteLn(f, '  STOP.DS'+ LastElememt              +': Last depth in file   '); // --- последнее измерение ---
  WriteLn(f, '  STEP.DS'+ StepElement              +': Depth increment  ');     // --- шаг ----
  WriteLn(f, '  NULL.M                     -32768.000: Null values  ');         // --- ненулевое значение ---
  WriteLn(f, '  COMP.  '+ Company                  +': COMPANY');               // --- имя компаниии
  WriteLn(f, '  WELL.  '+ Well                     +': WELL');                  // --- Имя скважены
  WriteLn(f, '  FLD .  '+ Field                    +': FIELD');                 // --- Имя Площади ---
  WriteLn(f, '  LOC .                                : LOCATION');
  WriteLn(f, '  CNTY.                                : COUNTY     ');
  WriteLn(f, '  STAT.                                : STATE      ');
  WriteLn(f, '  CTRY.                                : COUNTRY ');
  WriteLn(f, '  SRVC.                                : SERVICE COMPANY');
  WriteLn(f, '  DATE.  '+ LogDate                  +': LOG DATE');             // --- Датакаротажа ---
  WriteLn(f, '  TIME.  '+ TimeLog                  +': TIME OF JOB START  ');  // --- Время каротажа ---
  WriteLn(f, '  TRIG.                                : TIME INTERVAL ');
  WriteLn(f, '  API .                                : API NUMBER ');
  WriteLn(f, '~Curve information');
  WriteLn(f, '# MNEM.UNIT                                              DATA INFORMATION');
  WriteLn(f, '# ====.================================================: ================');
  WriteLn(f, '  TIME.    DS                                            : 1 REAL TIME  ');
  WriteLn(f, '  TEMP.    Grad C                                        : 2 external T ');
  WriteLn(f, '  PRES.    ATM                                           : 3  Press     ');
  WriteLn(f, '  temp.    Grad C                                        : 4 internal T ');
  WriteLn(f, '  CHAS.                                                  : 5 real chas  ');
  WriteLn(f, '  MIN .                                                  : 6 real min   ');
  WriteLn(f, '  SEK .                                                  : 7 real sek   ');
  WriteLn(f, '#');
  WriteLn(f, '~P');
  WriteLn(f, '#');
  WriteLn(f, '~Ascii Log data');

  for i:=1 to CurFile.Data[dtPressure].CountData - 1 do begin
     CurFileTime := TimeToStr(CurFile.Data[dtPressure].TimeData[i]);

     Value1      := FloatToStrf((CurFile.Data[dtPressure].TimeData[i]-CurFile.Data[dtPressure].TimeData[0])/TimeInOneSecond, fffixed,7,1) + ' ';
     Value2      := FloatToStrf(CurFile.Data[dtTempIn  ].Data[i], fffixed,7,4) + ' ';
     Value3      := FloatToStrf(CurFile.Data[dtPressure].Data[i], fffixed,7,4) + ' ';
     Value4      := FloatToStrf(CurFile.Data[dtTempOut ].Data[i], fffixed,7,4) + ' ';
     Value5      := Get_FileTime(CurFileTime) + ' ';

     WriteLn(f, Value1 + Value2 + Value3 + Value4 + Value5);
  end;


  CloseFile(f);
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.SaveFileTo_DAN_Format(CurFile: TFile);
type
  THourMinSec = record
    H,M,S : Byte;
  end;

function Get_Houre_Min_Sec(CurTime : string):THourMinSec;
var
 i          : byte;
 TempString : String;
 CurPos     : byte;
begin
  TempString := '';
  CurPos := 1;
  for i:=CurPos to Length(CurTime) do begin
    CurPos := i+1;
    if CurTime[i]=':' then Break;
    TempString := TempString + CurTime[i];
  end;
  Result.H := StrToInt(TempString);
  //--------------------------------------------------
  TempString := '';
  for i:=CurPos to Length(CurTime) do begin
    CurPos := i+1;
    if CurTime[i]=':' then Break;
    TempString := TempString + CurTime[i];
  end;
  Result.M := StrToInt(TempString);
  //--------------------------------------------------
  TempString := '';
  for i:=CurPos to Length(CurTime) do begin
    if CurTime[i]=':' then Break;
    TempString := TempString + CurTime[i];
  end;
  Result.S := StrToInt(TempString);
  //--------------------------------------------------
end;

var
  FileName               : String;
  iFileHandle            : Integer;
  BytesToSave            : int64;

  god_pr, mes_pr, den_pr : Byte;
  god_Temp               : Integer;
  CurData                : String;
  CurPos                 : Integer;
  i                      : Integer;
  LongIntBuffer          : LongInt;
  NumData                : Integer;
  A                      : Extended;
  B                      : Extended;
  A_1                    : Extended;
  B_1                    : Extended;
  E                      : Extended;
  F                      : Extended;
  G                      : Extended;
  H                      : Extended;

  oldt, oldP             : word;
  oldt1                  : byte;

  CurTime                : String;
  TempHour               : byte;
  TempMin                : byte;
  TempSec                : byte;

  TempValue              : Byte;
  TempString             : String;
  TempHMS                : THourMinSec;


begin
  CurData       := DateToStr(CurFile.Data[dtPressure].StartDate);

  LongIntBuffer := 0;
  god_pr        := 255;
  mes_pr        := 255;
  den_pr        := 255;

  CurPos := 1;

  for i:=CurPos to Length(CurData) do if CurData[i] = '.' then begin den_pr := StrToInt(copy(CurData,CurPos,i-CurPos)); CurPos := i+1; Break; end;
  for i:=CurPos to Length(CurData) do if CurData[i] = '.' then begin mes_pr := StrToInt(copy(CurData,CurPos,i-CurPos)); CurPos := i+1; Break; end;
  god_Temp := StrToInt(copy(CurData,CurPos,255)); if god_Temp > 255 then god_pr := god_Temp - trunc(god_Temp/100)*100;

  CurFile.FileBuffer^[LongIntBuffer + 7] := god_pr;
  CurFile.FileBuffer^[LongIntBuffer + 8] := mes_pr;
  CurFile.FileBuffer^[LongIntBuffer + 9] := den_pr;

  LongIntBuffer := LongInt(CurFile.FileBuffer);

   A     := SmallInt(Pointer(LongIntBuffer+22)^)  / 100;      //
   B     := SmallInt(Pointer(LongIntBuffer+24)^)  / 10000;    //
   A_1   := SmallInt(Pointer(LongIntBuffer+26)^)  / 100;      //
   B_1   := SmallInt(Pointer(LongIntBuffer+28)^)  / 10000;    //
   E     := SmallInt(Pointer(LongIntBuffer+30)^)  / 100;      //
   F     := SmallInt(Pointer(LongIntBuffer+32)^)  / 10000;    //
   G     := SmallInt(Pointer(LongIntBuffer+34)^)  / 100000;   //
   H     := SmallInt(Pointer(LongIntBuffer+36)^)  / 10000000; //

  NumData       := ((CurFile.iFileLength - CurFile.Position_START_WORD) -
                   ((CurFile.iFileLength - CurFile.Position_START_WORD) mod 8)) div 8;
  if NumData > CurFile.Data[dtPressure].CountData then NumData := CurFile.Data[dtPressure].CountData;
  for i:= 0 to NumData - 1 do begin
     LongIntBuffer    := CurFile.Position_START_WORD + i*8;

     oldt  := Word(Round((CurFile.Data[dtTempOut].Data[i]-A)/B));
     oldt1 := Byte(Round(CurFile.Data[dtTempIn  ].Data[i]));
     oldp  := Word(Round(
                          (CurFile.Data[dtPressure].Data[i]/10 - (E + F*(A_1 + B_1*oldt1/256)))
                          /
                          (G + H*(A_1 + B_1*oldt1/265))
                        ));

     CurFile.FileBuffer^[LongIntBuffer + 0] := Lo(Oldt);
     CurFile.FileBuffer^[LongIntBuffer + 1] := Hi(Oldt);

     CurFile.FileBuffer^[LongIntBuffer + 2] := byte(Oldt1);

     CurFile.FileBuffer^[LongIntBuffer + 3] := Lo(Oldp);
     CurFile.FileBuffer^[LongIntBuffer + 4] := Hi(Oldp);


     TempHMS := Get_Houre_Min_Sec(TimeToStr(CurFile.Data[dtPressure].TimeData[i]));

     TempHour  := (Trunc(TempHMS.H/10) SHL 4)  + TempHMS.H - Trunc(TempHMS.H/10)*10;
     TempMin   := (Trunc(TempHMS.M/10) SHL 4)  + TempHMS.M - Trunc(TempHMS.M/10)*10;
     TempSec   := (Trunc(TempHMS.S/10) SHL 4)  + TempHMS.S - Trunc(TempHMS.S/10)*10;

     CurFile.FileBuffer^[LongIntBuffer + 5] := Byte(TempHour);
     CurFile.FileBuffer^[LongIntBuffer + 6] := Byte(TempMin);
     CurFile.FileBuffer^[LongIntBuffer + 7] := Byte(TempSec);
     CurFile.FileBuffer^[LongIntBuffer + 7] := Byte(TempSec);
  end;
  BytesToSave := CurFile.Position_START_WORD + NumData*8;


  FileName := Get_FileNameWitOutFileExtention(CurFile.FileName) + '.dan';
  iFileHandle := FileCreate(FileName);
  FileWrite (iFileHandle,CurFile.FileBuffer^, BytesToSave);
  FileClose(iFileHandle);
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure TfrmSaveDialog.Button1Click(Sender: TObject);
var
 FileCounter      : integer;
 ResultMessageDlg : integer;
 CurFile          : TFile;
begin
   // --- Check for ERROR ----------
   if ListBox1.items.Count = 0 then begin
     MessageDLG('Нечего записывать', mtError, [mbOk],0);
     exit;
   end;
   // --- End Of Check for ERROR ----------
   if ProjectPath[Length(ProjectPath)] <> '\' then
      ProjectPath := ProjectPath + '\';
   if CheckProjectPath(ProjectPath) then begin
      beep;
      ResultMessageDlg := MessageDlg('Папка '+ProjectPath+' уже существует'#13#13'Файлы находящиеся в ней будут перезаписанны', mtWarning, [mbOk, mbCancel],0);
      if ResultMessageDlg = mrCancel then exit;
   end else CreateDir(ProjectPath);
   //-------------------------------------
   SetCurrentDir(ProjectPath);
   // --- Save PlanshetProject --------------------------------
   if SaveShablonPlanshet(ProjectPath,  Get_FileNameFromFilePath(ProjectPath), true) then Exit;
   //----------------------------------------------------------
   PrepareDataToSaveFile();
   For FileCounter := 0 to ListBox1.Items.Count - 1 do begin
     CurFile := TFile(ListBox1.items.Objects[FileCounter]);
     // --- Save Las Format -----
     if CheckBox1.Checked then SaveFileTo_LAS_Format(CurFile);
     // --- Save DAN Format -----
     if CheckBox2.Checked then SaveFileTo_DAN_Format(CurFile);
   end;
   ModalResult     := mrOk;
   close;
end;
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

end.

