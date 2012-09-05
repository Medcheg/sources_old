unit PashaLibrery;

interface
type
  TVector = array [1..3]      of Extended;
  TMatrix = array [1..3,1..3] of Extended;

  //------------------------------
  function KosoSemetrMatrix(v : TVector):TMatrix;
  //------------------------------

  function VV(V1,V2:TVector):Extended;         // ��������� ������������ ��������
  function VVT(V1,V2:TVector):TMatrix;      // V*V^T
  function VxV(V1,V2:TVector):TVector;      // ��������� ������������ ��������
  function SumV(V1,V2:TVector):TVector;     // �������� ��������
  function SubV(V1,V2:TVector):TVector;     // ��������� ��������
  function XV(X:Extended;V:TVector):TVector;    // ��������� ������� �� �����
  function MV(M:TMatrix;V:TVector):TVector;  // ��������� ������� �� ������

  function MM(A,B:TMatrix              ):TMatrix; overload;     // ������������ ������ A*B
  function MM(A,B,C:TMatrix            ):TMatrix; overload;     // ������������ ������ A*B*C
  function MM(A,B,C,D:TMatrix          ):TMatrix; overload;     // ������������ ������ A*B*C*D
  function MM(A,B,C,D,E:TMatrix        ):TMatrix; overload;     // ������������ ������ A*B*C*D*E
  function MM(A,B,C,D,E,F:TMatrix      ):TMatrix; overload;     // ������������ ������ A*B*C*D*E*F
  function MM(A,B,C,D,E,F,G:TMatrix    ):TMatrix; overload;     // ������������ ������ A*B*C*D*E*F*G
  function MM(A,B,C,D,E,F,G,H:TMatrix  ):TMatrix; overload;     // ������������ ������ A*B*C*D*E*F*G*H
  function MM(A,B,C,D,E,F,G,H,I:TMatrix):TMatrix; overload;     // ������������ ������ A*B*C*D*E*F*G*H*I

  function TM(M:TMatrix):TMatrix;           // ���������������� �������
  function SumM(M1,M2:TMatrix):TMatrix;     // �������� ������
  function SubM(M1,M2:TMatrix):TMatrix;     // ��������� ������
  function XM(X:Extended;M:TMatrix):TMatrix;    // ��������� ������� �� �����
  function detM(M:TMatrix):Extended;           // ���������� ������������ �������
  function ObrM(M:TMatrix):TMatrix;         // ���������� �������� �������
  function FVV(V1,V2:TVector):TMatrix;      // F(v1)*F(V2)
  function GetVV(V1 : TVector):TMatrix; // �������� ������ �������
  function GetHV(M1 : TMatrix):TVector; // �������� ������ �������


implementation

function VV(V1,V2:TVector):Extended;
// ��������� ������������ ��������
begin
 result :=   V1[1]*V2[1] + V1[2]*V2[2] + V1[3]*V2[3];
end;

function VVT(V1,V2:TVector):TMatrix;
// V*V^T
begin
 result[1,1] := V1[1]*V2[1];
 result[1,2] := V1[2]*V2[1];
 result[1,3] := V1[3]*V2[1];
 result[2,1] := V1[1]*V2[2];
 result[2,2] := V1[2]*V2[2];
 result[2,3] := V1[3]*V2[2];
 result[3,1] := V1[1]*V2[3];
 result[3,2] := V1[2]*V2[3];
 result[3,3] := V1[3]*V2[3];
end;

function VxV(V1,V2:TVector):TVector;
// ��������� ������������ ��������
begin
 result[1] := V1[2]*V2[3] - V1[3]*V2[2];
 result[2] := V1[3]*V2[1] - V1[1]*V2[3];
 result[3] := V1[1]*V2[2] - V1[2]*V2[1];
end;

function SumV(V1,V2:TVector):TVector;
// �������� ��������
begin
 result[1] := V1[1] + V2[1];
 result[2] := V1[2] + V2[2];
 result[3] := V1[3] + V2[3];
end;

function SubV(V1,V2:TVector):TVector;
// ��������� ��������
begin
 result[1] := V1[1] - V2[1];
 result[2] := V1[2] - V2[2];
 result[3] := V1[3] - V2[3];
end;

function XV(X:Extended;V:TVector):TVector;
// ��������� ������� �� �����
begin
 result[1] := X*V[1];
 result[2] := X*V[2];
 result[3] := X*V[3];
end;

function MV(M:TMatrix;V:TVector):TVector;
// ��������� ������� �� ������
begin
 result[1] := M[1,1]*V[1] + M[1,2]*V[2] + M[1,3]*V[3];
 result[2] := M[2,1]*V[1] + M[2,2]*V[2] + M[2,3]*V[3];
 result[3] := M[3,1]*V[1] + M[3,2]*V[2] + M[3,3]*V[3];
end;

function MM(A,B:TMatrix):TMatrix;
// ������������ ������
var i,j:integer;
begin
 for i:=1 to 3 do
   for j:=1 to 3 do
     result[i,j] := A[i,1]*B[1,j] + A[i,2]*B[2,j] + A[i,3]*B[3,j];
end;

function MM(A,B,C:TMatrix):TMatrix;      // ������������ ������ A*B*C
var
  AB : TMatrix;
Begin
  AB     := MM(A ,B);
  Result := MM(AB,C);
end;

function MM(A,B,C,D:TMatrix):TMatrix;      // ������������ ������ A*B*C*D
var
  ABC : TMatrix;
Begin
  ABC    := MM(A,B,C);
  Result := MM(ABC,D);
end;

function MM(A,B,C,D,E:TMatrix):TMatrix;      // ������������ ������ A*B*C*D*E
var
  ABCD : TMatrix;
Begin
  ABCD   := MM(A,B,C,D);
  Result := MM(ABCD, E);
end;

function MM(A,B,C,D,E,F:TMatrix  ):TMatrix; overload;     // ������������ ������ A*B*C*D*E*F
var
 ABCDE : TMatrix;
begin
 ABCDE  := MM(A, B, C, D, E);
 Result := MM(ABCDE,F);
end;

function MM(A,B,C,D,E,F,G:TMatrix):TMatrix; overload;     // ������������ ������ A*B*C*D*E*F*G
var
 ABCDEF : TMatrix;
begin
 ABCDEF := MM(A, B, C, D, E, F);
 Result  := MM(ABCDEF, G);
end;

function MM(A,B,C,D,E,F,G,H:TMatrix):TMatrix; overload;     // ������������ ������ A*B*C*D*E*F*G*H
var
 ABCDEFG : TMatrix;
begin
 ABCDEFG := MM(A, B, C, D, E, F, G);
 Result  := MM(ABCDEFG, H);
end;

function MM(A,B,C,D,E,F,G,H,I:TMatrix):TMatrix; overload;     // ������������ ������ A*B*C*D*E*F*G*H*I
var
 ABCDEFGH : TMatrix;
begin
 ABCDEFGH := MM(A, B, C, D, E, F, G, H);
 Result   := MM(ABCDEFGH, I);
end;

function TM(M:TMatrix):TMatrix;
// ���������������� �������
var i,j:integer;
begin
 for i:=1 to 3 do
   for j:=1 to 3 do
     result[i,j]:=M[j,i];
end;

function SumM(M1,M2:TMatrix):TMatrix;
// �������� ������
var i,j:integer;
begin
 for i:=1 to 3 do
   for j:=1 to 3 do
     result[i,j] := M1[i,j] + M2[i,j];
end;

function SubM(M1,M2:TMatrix):TMatrix;
// ��������� ������
var i,j:integer;
begin
 for i:=1 to 3 do
   for j:=1 to 3 do
     result[i,j] := M1[i,j] - M2[i,j];
end;

function XM(X:Extended;M:TMatrix):TMatrix;
// ��������� ������� �� �����
var i,j:integer;
begin
 for i:=1 to 3 do
   for j:=1 to 3 do
     result[i,j] := X*M[i,j];
end;

function detM(M:TMatrix):Extended;
// ���������� ������������ �������
begin
 result :=   M[1,1]*( M[2,2]*M[3,3]-M[2,3]*M[3,2] )
           + M[1,2]*( M[2,1]*M[3,3]-M[2,3]*M[3,1] )
           + M[1,3]*( M[2,1]*M[3,2]-M[2,2]*M[3,1] );
end;

function ObrM(M:TMatrix):TMatrix;
// ���������� �������� �������
var d1:Extended;
begin
 d1:=detM(M);
 try
  result[1,1] := (M[2,2]*M[3,3] - M[2,3]*M[3,2])/d1;
  result[1,2] := (M[1,2]*M[3,3] - M[1,3]*M[3,2])/d1;
  result[1,3] := (M[1,2]*M[2,3] - M[1,3]*M[2,2])/d1;
  result[2,1] := (M[2,1]*M[3,3] - M[2,3]*M[3,1])/d1;
  result[2,2] := (M[1,1]*M[3,3] - M[1,3]*M[3,1])/d1;
  result[2,3] := (M[1,1]*M[2,3] - M[1,3]*M[2,1])/d1;
  result[3,1] := (M[2,1]*M[3,2] - M[2,2]*M[3,1])/d1;
  result[3,2] := (M[1,1]*M[3,2] - M[3,1]*M[1,2])/d1;
  result[3,3] := (M[1,1]*M[2,2] - M[1,2]*M[2,1])/d1;
 except
  result:=M;
 end;
end;

function FVV(V1,V2:TVector):TMatrix;
// F(V1)*F(V2)
begin
 result[1,1] := -V1[3]*V2[3]-V1[2]*V2[2];
 result[1,2] :=  V1[1]*V2[2];
 result[1,3] :=  V1[1]*V2[3];
 result[2,1] :=  V1[2]*V2[1];
 result[2,2] := -V1[3]*V2[3]-V1[1]*V2[1];
 result[2,3] :=  V1[2]*V2[3];
 result[3,1] :=  V1[3]*V2[1];
 result[3,2] :=  V1[3]*V2[2];
 result[3,3] := -V1[2]*V2[2]-V1[1]*V2[1];
end;

function GetVV(V1 : TVector):TMatrix;
// �������� ������ �������
var i,j:integer;
begin
 for i:=1 to 3 do
   for j:=1 to 3 do
     result[i,j] := 0;

 result[1,1] := v1[1];
 result[2,1] := v1[2];
 result[3,1] := v1[3];
end;

function GetHV(M1 : TMatrix):TVector;
// �������� ������ �������
begin
 result[1] := M1[1,1];
 result[2] := M1[2,1];
 result[3] := M1[3,1];
end;

function KosoSemetrMatrix(v : TVector):TMatrix;
begin
 result[1,1] :=  0;
 result[1,2] := -v[3];
 result[1,3] :=  v[2];

 result[2,1] :=  v[3];
 result[2,2] :=  0;
 result[2,3] := -v[1];

 result[3,1] := -v[2];
 result[3,2] :=  v[1];
 result[3,3] :=  0;
end;


end.
