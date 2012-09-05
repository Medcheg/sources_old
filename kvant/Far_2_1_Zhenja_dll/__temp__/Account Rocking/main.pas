unit main;

interface

uses
  Forms, Controls;

{Прототипы экспортируемых процедур}
procedure ValueAssignment (vCommonTime  : Int64; vBetta, vEpsilon  : Extended); stdcall; export;
procedure AccountRocking (out vDeltaBetta, vDeltaEpsilon  : Extended); stdcall; export;
procedure ChamgeRockingParameters (hWnd  : THandle); stdcall; export;

implementation

uses
  RockinParameters;

var
  _Betta0, _Epsilon0          : Extended; // Заданные значения азимута и угла места
  _DeltaBetta, _DeltaEpsilon  : Extended; // Значения поправок для электронной достабилизации луча
  _CommonTime                 : Int64;
  _TestParams                 : Integer;  

//------------------------------------------------------------------------------
procedure ValueAssignment (vCommonTime  : Int64; vBetta, vEpsilon  : Extended);
begin
  _CommonTime := vCommonTime;
  _Betta0 := vBetta;
  _Epsilon0 := vEpsilon;
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
procedure AccountRocking (out vDeltaBetta, vDeltaEpsilon  : Extended); stdcall; export;
var
  a, b, c  : Extended;
begin
  a := -8 * Pi / 180;
  b := 20 * Pi / 180;
  c := 2 * Pi * _CommonTime / 5000000;

  _DeltaEpsilon := a + b * sin (c);// + 30 * c_DegToRad);
  _DeltaBetta := 0;

  vDeltaBetta := _DeltaBetta;
  vDeltaEpsilon := _DeltaEpsilon;
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
procedure ChamgeRockingParameters (hWnd  : THandle);
var
  bRetVal  : Boolean;
begin
  bRetVal := True;
  Application.Handle := hWnd;
  try
    RockingParams := TRockingParams.Create (Application);
  except
    bRetVal := False;
    Exit;
  end ; {try..except}

  RockingParams.ValueAssignment (_TestParams);
  if RockingParams.ShowModal = mrOk then
    _TestParams := RockingParams.GetTestParameters;
  RockingParams.Free;
end;
//------------------------------------------------------------------------------

end.
