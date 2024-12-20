unit Access;

interface

uses
  Windows, Forms, DinaWin, SysUtils, Dialogs, Splash ;
  {Classes,  WinTypes, Controls, Buttons, Messages, Graphics,
   ExtCtrls, StdCtrls, ComCtrls ;}

{��������� �������������� ��������}

function AddValues (iArg1, iArg2  : Integer) : Integer ; stdcall ; export ;
function GetStrChar (sVal  : String ; iIndex  : Integer) : Char ; stdcall ; export ;
procedure BeepLoop (iNumTimes  : Integer) ; stdcall ; export ;
function ExecuteLicense (hWnd  : THandle) : Integer ; stdcall ; export ;
function CreateSplash (hWnd  : THandle) : Boolean ; stdcall ; export ;
function ShowSplash : Boolean ; stdcall ; export ;
function HideSplash : Boolean ; stdcall ; export ;
function FreeSplash : Boolean ; stdcall ; export ;

implementation

{���������� ����� ���������� �� ����������}
function AddValues (iArg1, iArg2  : Integer) : Integer ;
begin
  Result := iArg1 + iArg2 ;
end ;

{���������� ������, ����������� � ���������� pos, �������� ���������� iIndex}
function GetStrChar (sVal  : String ; iIndex  : Integer) : Char ;
begin
  Result := Char (sVal [iIndex]) ;
end ;

{��� �������� ������ n ���, n ������� ����������� iNumTimes}
procedure BeepLoop (iNumTimes  : Integer) ;
begin
  While (iNumTimes > 0) do
    begin
      MessageBeep (0) ;
      Dec (iNumTimes) ;
    end ;
end ;

{����� ������� � ����������� ���� ������������� ����������,
 ���������� ��������� ������}
function ExecuteLicense (hWnd  : THandle) : Integer ;
var
  iRetVal  : Integer ;
begin
  Application.Handle := hWnd ;
  try
    try
      frmLicense := TfrmLicense.Create (Application) ;
      iRetVal := frmLicense.ShowModal ;
    finally
      {frmLicense.Free ;}
    end ; {try..finally}
  except
    on E:Exception do
      begin
        ShowMessage ('Error Creating or Showing License: ' + E.Message) ;
        raise ;
      end ;
  end ; {try..except}
  Result := iRetVal ;
end ;

{������� ������ ��������� ����� ��������.
 ���������� False � ������ ��������� ������� �������� �����}
function CreateSplash (hWnd  : THandle) : Boolean ;
var
  bRetVal  : Boolean ;
begin
  bRetVal := True ;
  Application.Handle := hWnd ;
  try
    frmSplash := TfrmSplash.Create (Application) ;
  except
    bRetVal := False ;
  end ; {try..except}
  Result := bRetVal ;
end ;

{����� ���������� ���� ��������}
function ShowSplash : Boolean ;
var
  bRetVal  : Boolean ;
begin
  bRetVal := False ;
  If (frmSplash <> nil) then
    begin
      try
        frmSplash.Show ;
        bRetVal := True ;
      except
        bRetVal := False ;
      end ; {try..except}
    end ;
  Result := bRetVal ;
end ;

{������� ���������� ���� ��������}
function HideSplash : Boolean ;
var
  bRetVal  : Boolean ;
begin
  bRetVal := False ;
  If (frmSplash <> nil) then
    begin
      frmSplash.Hide ;
      bRetVal := True ;
    end ;
  Result := bRetVal ;
end ;

{�������� ���������� ���� ��������}
function FreeSplash : Boolean ;
var
  bRetVal  : Boolean ;
begin
  bRetVal := False ;
  If (frmSplash <> nil) then
    begin
      frmSplash.Free ;
      bRetVal := True ;
    end ;
  Result := bRetVal ;
end ;

end.
