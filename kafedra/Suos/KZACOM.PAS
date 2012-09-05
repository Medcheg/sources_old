unit Kzacom;

interface

uses Classes;

type

  TModes=(mRGS,mPSO,mPPSO,mNone);

  TKind=(kNames,kValues);

  Coord = (X,Y,Z);

  IntegralDegree = 0..3;

  ZType = -30..0;

  Range = set of IntegralDegree;

  TStek = class (TObject)
  public
    constructor Create;
    destructor Destroy;
    procedure Set_( Expr: Extended);
    procedure Change_( Expr: Extended);
    function Get_( Index: ZType): Extended;
    function Save(var Handle: LongInt): boolean;
    function Open(var Handle: LongInt): boolean;
    procedure Clear;
  private
    St: Array [ZType] of Extended;
  end;

{  TIntegr = class (TObject)
  Public
    constructor Create;
    destructor Destroy;
    procedure _Set(Val:Extended; What: Range; T: Extended);
    procedure _Change(Val:Extended; Degree: IntegralDegree);
    function _Get(Degree: IntegralDegree; Index: ZType): Extended;
    function Save(var Handle: LongInt): boolean;
    function Open(var Handle: LongInt): boolean;
  private
    Value: array [IntegralDegree] of TStek;
    Procedure Integr(Coef: Extended; var Input,Output: TStek);
end;}

  CoordExtended  = Array [Coord] of Extended;
  MatrixExtended = Array [Coord,Coord] of Extended;
  CoordBoolean   = Array [Coord] of Boolean;
  CoordInteger   = Array [Coord] of longInt;
  CoordTStek     = Array [Coord] of TStek;

  TKindString    = array [TKind] of TStringList;

function ArcSin(x: Real): Real;
function ArcCos(x: Real): Real;
function Tan(x: Real): Real;
function aTan(sa,ca: Real): Real;
function Sign(x: Extended): Integer;
function M_M(M1,m2: MatrixExtended):MatrixExtended;
function M_V(M: MatrixExtended; V: CoordExtended): CoordExtended;
Procedure Integral1(Coef: Extended; Input:Tstek;var Output: TStek);

implementation

uses SysUtils;

function M_M(M1,m2: MatrixExtended):MatrixExtended;
var i,j,k: Coord;
begin
  for i:=x to z do
    for j:=x to z do begin
      Result[i,j]:=0;
      for k:=x to z do
        Result[i,j]:=Result[i,j]+M1[i,k]*M2[k,j];
    end;
end;

function M_V(M: MatrixExtended; V: CoordExtended): CoordExtended;
var i,j : Coord;
begin
  for i:=x to z do begin
    Result[i]:=0;
    for j:=x to z do
      Result[i]:=Result[i]+M[i,j]*V[j];
  end;
end;

function aTan(sa,ca: Real): Real;
begin
 if ca=0 then begin
         if sa>0 then Result:=pi/2 else Result:=-pi/2
         end else
 if ca>0 then Result:=arctan(sa/ca)
         else if (sa>0) then Result:=arctan(sa/ca)+pi
                        else Result:=arctan(sa/ca)-pi;
end;

function ArcSin(x: Real): Real;
begin
  Result:=ArcTan(x/sqrt(1-sqr(x)))
end;

function ArcCos(x: Real): Real;
begin
  Result:=ArcTan(sqrt(1-sqr(x))/x)
end;

function Tan(x: Real): Real;
begin
  Result:=Sin(x)/Cos(x)
end;

function Sign(x: Extended): Integer;
begin
  if x=0 then Result:=0
  else if x<0 then Result:=-1
       else Result:=1;
end;

constructor TStek.Create;
var i: ZType;
begin
  Inherited Create;
  for i:=-9 to 0 do St[i]:=0
end;

procedure TStek.Clear;
var i: ZType;
begin
  for i:=-9 to 0 do St[i]:=0
end;

destructor TStek.Destroy;
begin
  inherited Destroy;
end;

procedure TStek.Set_( Expr: Extended);
var i: ZType;
begin
  for i:=-8 to 0 do St[i-1]:=St[i];
  St[0]:=Expr;
end;

procedure TStek.Change_( Expr: Extended);
begin
  St[0]:=Expr;
end;

function TStek.Get_( Index: ZType): Extended;
begin
  Result:=St[Index];
end;

function TStek.Save(var Handle: LongInt): boolean;
begin
  if SizeOf(St)=FileWrite(Handle,St,SizeOf(St))
     then Save:=True
     else Save:=False;
end;

function TStek.Open(var Handle: LongInt): boolean;
begin
  if SizeOf(St)=FileRead(Handle,St,SizeOf(St))
     then Open:=True
     else Open:=False;
end;
{
Constructor TIntegr.Create;
var i: IntegralDegree;
begin
  inherited Create;
  for i:=0 to 3 do Value[i]:=TStek.Create;
end;

destructor TIntegr.Destroy;
var i: IntegralDegree;
begin
  For i:=0 to 3 do Value[i].Free;
  inherited Destroy;
end;

Procedure TIntegr.Integr(Coef: Extended; var Input,Output: TStek);
Begin
  Output.Set_(Output.Get_(0)+Coef*(Input.Get_(0)+Input.Get_(-1))/2);
end;
}
Procedure Integral1(Coef: Extended; Input:Tstek;var Output: TStek);
Begin
  Output.Set_(Output.Get_(0)+Coef*(Input.Get_(0)+Input.Get_(-1))/2);
end;
 {
procedure TIntegr._Int(T: Extended; What: Range);
Begin
  if 1 in What then Integr(T,Value[0],Value[1]);
  if 2 in What then Integr(T,Value[1],Value[2]);
  if 3 in What then Integr(T,Value[2],Value[3]);
end;

procedure TIntegr._Set(Val:Extended; What: Range; T: Extended);
begin
  Value[0].Set_(Val);
  _Int(T, What);
end;

function TIntegr._Get(Degree: IntegralDegree; Index: ZType): Extended;
begin
  Result:= Value[Degree].Get_(Index);
end;

function TIntegr.Save(var Handle: LongInt): boolean;
begin
  if SizeOf(Value)=FileWrite(Handle,Value,SizeOf(Value))
     then Save:=True
     else Save:=False;
end;

function TIntegr.Open(var Handle: LongInt): boolean;
begin
  if SizeOf(Value)=FileRead(Handle,Value,SizeOf(Value))
     then Open:=True
     else Open:=False;
end;

procedure TIntegr._Change(Val:Extended; Degree: IntegralDegree);
begin
  Value[Degree].Change_(Val);
end; }
end.
