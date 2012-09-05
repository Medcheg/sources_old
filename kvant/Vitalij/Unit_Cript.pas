unit Unit_Cript;

interface

uses Windows, Dialogs;


const
  CountTest = 10;
  SerialNumberArray : array [0..CountTest] of Cardinal = (746067712,  // ---- �� - ��������� �������
                                                          122297812,  // ---- �� - ��������� �����
                                                          2,
                                                          3,
                                                          4,
                                                          5,
                                                          6,
                                                          7,
                                                          794204000,
                                                          3563790268, //-----�� - ������� SDRom
                                                          2603380172);
  procedure cript;
  function Get_SerialNumberCdRom():Cardinal;
  function Get_SerialNumberDiskC():Cardinal;

var
    GLobalErrorOffset : extended;

implementation

Function CompareSerialNumber(SerialNumber : Cardinal): Boolean;
Const
  Max_Path = 255;
var
 MyStr                               : pChar;
 DriveList                           : array [0..20] of String;
 DriveLetter                         : PChar;

 VolumeName,  FileSystemName         : array [0..Max_Path-1] of Char;
 VolumeSerialNo                      : Cardinal;
 MaxComponentLength, FileSystemFlags : DWORD;
 i                                   : Integer;
 Count                               : Integer;
begin
    Result := false;
    GetMem(MyStr, Max_Path);
    //------- ������� ������ ������� -------------------------
    GetLogicalDriveStrings(Max_Path,MyStr);
    Count := 0;
    for i:=0 to Max_Path-1 do begin
        if (MyStr[i] >= 'a') and (MyStr[i] <= 'z') or ((MyStr[i] >= 'A') and (MyStr[i] <= 'Z')) then begin
           DriveList[Count] := MyStr[i]+MyStr[i+1]+MyStr[i+2] + #0;
           Count := Count + 1;
        end;
        if (MyStr[i] = #0) and (MyStr[i+1] = #0) then Break;
    end;
    FreeMem(MyStr, Max_Path);

    //------- ������� �� -------------------------
    GetMem(DriveLetter,4);
    for i:= 0 to Count - 1 do begin
       DriveLetter[0] := DriveList[i][1];
       DriveLetter[1] := DriveList[i][2];
       DriveLetter[2] := DriveList[i][3];
       DriveLetter[3] := DriveList[i][4];
       if (DriveLetter[0] <> 'a') and
          (DriveLetter[0] <> 'A') and
          (DriveLetter[0] <> 'b') and
          (DriveLetter[0] <> 'B')    then
           try
             GetVolumeInformation(DriveLetter,
                                  VolumeName,
                                  MAX_PATH,
                                  @VolumeSerialNo,
                                  MaxComponentLength,
                                  FileSystemFlags,
                                  FileSystemName,
                                  MAX_PATH);
             if VolumeSerialNo = SerialNumber then begin
                //StrSerialNumber := IntToHex(HiWord(VolumeSerialNo),4)+ '-' + IntToHex(LoWord(VolumeSerialNo),4);
                Result := true;
             end;
           except end;
    end;
    FreeMem(DriveLetter,4);
    //--------------------------------
end;
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Function Get_SerialNumberCdRom(): Cardinal;
Const
  Max_Path = 255;
var
 MyStr                               : pChar;
 DriveList                           : array [0..20] of String;
 DriveLetter                         : PChar;

 VolumeName,  FileSystemName         : array [0..Max_Path-1] of Char;
 VolumeSerialNo                      : Cardinal;
 MaxComponentLength, FileSystemFlags : DWORD;
 i                                   : Integer;
 Count                               : Integer;
begin
    Result := 0;
    GetMem(MyStr, Max_Path);
    //------- ������� ������ ������� -------------------------
    GetLogicalDriveStrings(Max_Path,MyStr);
    Count := 0;
    for i:=0 to Max_Path-1 do begin
        if (MyStr[i] >= 'a') and (MyStr[i] <= 'z') or ((MyStr[i] >= 'A') and (MyStr[i] <= 'Z')) then begin
           DriveList[Count] := MyStr[i]+MyStr[i+1]+MyStr[i+2] + #0;
           Count := Count + 1;
        end;
        if (MyStr[i] = #0) and (MyStr[i+1] = #0) then Break;
    end;
    FreeMem(MyStr, Max_Path);

    //------- ������� �� -------------------------
    GetMem(DriveLetter,4);
    for i:= 0 to Count - 1 do begin
       DriveLetter[0] := DriveList[i][1]; DriveLetter[1] := DriveList[i][2]; DriveLetter[2] := DriveList[i][3]; DriveLetter[3] := DriveList[i][4];
       if GetDriveType (DriveLetter) = 5 then
           try
             GetVolumeInformation(DriveLetter,
                                  VolumeName,
                                  MAX_PATH,
                                  @VolumeSerialNo,
                                  MaxComponentLength,
                                  FileSystemFlags,
                                  FileSystemName,
                                  MAX_PATH);
             Result := VolumeSerialNo;
             Break;
           except end;
    end;
    FreeMem(DriveLetter,4);
    //--------------------------------
end;
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Function Get_SerialNumberDiskC(): Cardinal;
Const
  Max_Path = 255;
var
 MyStr                               : pChar;
 DriveList                           : array [0..20] of String;
 DriveLetter                         : PChar;

 VolumeName,  FileSystemName         : array [0..Max_Path-1] of Char;
 VolumeSerialNo                      : Cardinal;
 MaxComponentLength, FileSystemFlags : DWORD;
 i                                   : Integer;
 Count                               : Integer;
begin
    Result := 0;
    GetMem(MyStr, Max_Path);
    //------- ������� ������ ������� -------------------------
    GetLogicalDriveStrings(Max_Path,MyStr);
    Count := 0;
    for i:=0 to Max_Path-1 do begin
        if (MyStr[i] >= 'a') and (MyStr[i] <= 'z') or ((MyStr[i] >= 'A') and (MyStr[i] <= 'Z')) then begin
           DriveList[Count] := MyStr[i]+MyStr[i+1]+MyStr[i+2] + #0;
           Count := Count + 1;
        end;
        if (MyStr[i] = #0) and (MyStr[i+1] = #0) then Break;
    end;
    FreeMem(MyStr, Max_Path);

    //------- ������� �� -------------------------
    GetMem(DriveLetter,4);
    for i:= 0 to Count - 1 do begin
       DriveLetter[0] := DriveList[i][1]; DriveLetter[1] := DriveList[i][2]; DriveLetter[2] := DriveList[i][3]; DriveLetter[3] := DriveList[i][4];
       if (DriveLetter[0] = 'c') or
          (DriveLetter[0] = 'C') then
           try
             GetVolumeInformation(DriveLetter,
                                  VolumeName,
                                  MAX_PATH,
                                  @VolumeSerialNo,
                                  MaxComponentLength,
                                  FileSystemFlags,
                                  FileSystemName,
                                  MAX_PATH);
             Result := VolumeSerialNo;
             Break;
           except end;
    end;
    FreeMem(DriveLetter,4);
    //--------------------------------
end;
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// *++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure cript;
var
 flag       : Boolean;
 i          : Integer;
 //StrSerialNumber      : String;
begin
  //*********   �������� ������� ����  *********************
  repeat
      flag := false;
      //---------------------------------------------------
      for i := 0 to CountTest do begin
         if CompareSerialNumber(SerialNumberArray[i]) then flag := true; // ---- �������� ����� ���������� �� ������
      end;
      //--------------------------------------------------      if not flag then
         if MessageDLG('������� �������� �������������� ����', mtError, [mbCancel,mbRetry],0) = idCancel then
                                                                                                ExitProcess(0);
  until flag;
  // ********************************************************
end;

begin
  GLobalErrorOffset :=1 ;
end.

