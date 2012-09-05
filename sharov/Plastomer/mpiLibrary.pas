unit mpiLibrary;

interface

uses windows, StdCtrls;

type
   PInt = ^TInt;
   TInt = Integer;

   PFloat = ^TFloat;
   TFloat = Extended;

   PIntPointerArray = ^TIntPointerArray;
   TIntArray        = array of TInt;
   TIntPointerArray = array [0..0] of TInt;

   PFloatPointerArray = ^TFloatPointerArray;
   TFloatArray        = array of TFloat;
   TFloatPointerArray = array [0..0] of TFloat;


   TKeyType = (ktSnapShot, ktCtrl);

   procedure ShowWrongEdit(Edit : TEdit);
   procedure KeyReg(aHandle : THandle; aKeyType : TKeyType);
   function  Arctan360(x, y: TFloat): TFloat;


var
  idShots   : array [1..9] of integer;

implementation

uses Dialogs, SysUtils;


{===============================================================================
}
procedure ShowWrongEdit(Edit : TEdit);
begin
  Beep();
  Edit.SetFocus;
  Edit.SelectAll;
  MessageDlg('¬ведено не числовое значение !!!', mtError, [mbOk],0);
end;

{===============================================================================
}
procedure KeyReg(aHandle : THandle; aKeyType : TKeyType);
//     procedure WM_HotKeyHandler (var Message: TMessage); message WM_HotKey;
begin
  if akeyType = ktSnapShot then begin
     if idShots[1] = -1 then begin
          idShots[1] := GlobalAddAtom('PrintScreen');
          idShots[2] := GlobalAddAtom('Alt+PrintScreen');
          idShots[3] := GlobalAddAtom('Control+PrintScreen');
          idShots[4] := GlobalAddAtom('Shift+PrintScreen');
          idShots[5] := GlobalAddAtom('Win+PrintScreen');
          idShots[6] := GlobalAddAtom('alt+Shift+PrintScreen');
          idShots[7] := GlobalAddAtom('Control+Shift+PrintScreen');
          idShots[8] := GlobalAddAtom('Control+Alt+PrintScreen');
          RegisterHotKey(aHandle, idShots[1], 0                      , VK_SNAPSHOT);
          RegisterHotKey(aHandle, idShots[2], MOD_ALT                , VK_SNAPSHOT);
          RegisterHotKey(aHandle, idShots[3], MOD_CONTROL            , VK_SNAPSHOT);
          RegisterHotKey(aHandle, idShots[4], MOD_SHIFT              , VK_SNAPSHOT);
          RegisterHotKey(aHandle, idShots[5], MOD_WIN                , VK_SNAPSHOT);
          RegisterHotKey(aHandle, idShots[6], MOD_ALT+MOD_SHIFT      , VK_SNAPSHOT);
          RegisterHotKey(aHandle, idShots[7], MOD_CONTROL + MOD_SHIFT, VK_SNAPSHOT);
          RegisterHotKey(aHandle, idShots[8], MOD_CONTROL + MOD_ALT  , VK_SNAPSHOT);
     end else begin
          UnregisterHotKey(aHandle, idShots[1]);
          UnregisterHotKey(aHandle, idShots[2]);
          UnregisterHotKey(aHandle, idShots[3]);
          UnregisterHotKey(aHandle, idShots[4]);
          UnregisterHotKey(aHandle, idShots[5]);
          UnregisterHotKey(aHandle, idShots[6]);
          UnregisterHotKey(aHandle, idShots[7]);
          UnregisterHotKey(aHandle, idShots[8]);
          idShots[1] := -1;
          idShots[2] := -1;
          idShots[3] := -1;
          idShots[4] := -1;
          idShots[5] := -1;
          idShots[6] := -1;
          idShots[7] := -1;
          idShots[8] := -1;
     end;
  end;
  // ----------
  if akeyType = ktCtrl then begin
     if idShots[9] = -1 then begin
         idShots[9] := GlobalAddAtom('Ctrl');
         RegisterHotKey(aHandle, idShots[9], 0, VK_CONTROL);
     end else begin
          UnregisterHotKey(aHandle, idShots[9]);
          idShots[9] := -1;
     end;
  end;
end;

function Arctan360(x, y: TFloat): TFloat;
begin
  if (x=0) AND (y=0)  then begin Result :=-999*pi/180; exit; end;

  if (x>0) AND (y=0)  then begin Result :=pi/2;        exit; end;
  if (x<0) AND (y=0)  then begin Result :=3*pi/2;      exit; end;
  if (x=0) AND (y<0)  then begin Result := pi;         exit; end;
  if (x=0) AND (y>0)  then begin Result := 0;          exit; end;

  Result := arcTan(abs(x/y));

  if (x>0) AND (y>0)  then Result :=Result;
  if (x>0) AND (y<0)  then Result :=pi - Result;
  if (x<0) AND (y<0)  then Result :=pi + Result;
  if (x<0) AND (y>0)  then Result :=2*PI - Result;
end;

begin
  FillChar(idShots, SizeOf(idShots), -1);
end.
