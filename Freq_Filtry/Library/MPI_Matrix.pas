unit MPI_Matrix;

interface

type
  PMatrix = ^TMatrix;
  TMatrix = record
    nStrok, nStolb : Integer;
    Matrix : array of array of Extended;
  end;

  PMatrixArray = array of PMatrix;

{  PVector = ^TVector;
  TVector = record
    nStrok : Integer;
    Vector : array of array of Extended;
  end;}
  procedure SetMatrix(aStrok, aStolb : Integer; M : PMatrix);

  // -------- Математические операции --------
  function MM  (A, B : PMatrix):TMatrix;  // Умножение матрицы на матрицу
  function SumM(A, B : PMatrix):TMatrix;  // Сложение  матриц
  function SubM(A, B : PMatrix):TMatrix;  // Вычитание матриц

  // -------- Операции перобразований --------
  function TM(M : PMatrix):TMatrix;  // Транспонирование матрицы

var
   MatrixArray : PMatrixArray;

implementation

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
procedure SetMatrix(aStrok, aStolb : Integer; M : PMatrix);
var
  i, j   : integer;
begin
  M.nStrok := aStrok;
  M.nStolb := aStolb;

  SetLength(M.Matrix     , aStrok, aStolb           );
  for i := 0 to M^.nStrok - 1 do
      for j := 0 to M^.nStolb - 1 do M^.Matrix[i][j] := 0;
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++         Умножение матрицы на матрицу              +++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function MM(A, B : PMatrix) : TMatrix;
var
 k, i, j : Integer;
 CurSum  : Extended;
begin
 if A.nStolb <> B.nStrok then begin
     result.nStrok := -9999999;
     result.nStolb := -9999999;
     result.Matrix := nil;
     exit;
 end;
 //---------------------------------
 result.nStrok := A.nStrok;
 result.nStolb := B.nStolb;
 SetLength(result.Matrix, A.nStrok, B.nStolb);
 //---------------------------------
 for i:=0 to A.nStrok-1 do
     for j:=0 to B.nStolb-1 do begin
         CurSum := 0;

         for k:=0 to A.nStolb - 1 do
             CurSum := CurSum + A.MAtrix[i,k] * B.Matrix[k,j];

         result.Matrix[i,j] := CurSum;
     end;

end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++         Сложение  матриц                          +++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function SumM(A, B : PMatrix):TMatrix;  //
var
 i, j : Integer;
begin
 if (A.nStrok <> B.nStrok) or (A.nStolb <> B.nStolb) then begin
     result.nStrok := -9999999;
     result.nStolb := -9999999;
     result.Matrix := nil;
     exit;
 end;
 //---------------------------------
 result.nStrok := A.nStrok;
 result.nStolb := A.nStolb;
 SetLength(result.Matrix, A.nStrok, A.nStolb);
 //---------------------------------
 for i:=0 to A.nStrok-1 do
     for j:=0 to A.nStolb-1 do
         result.Matrix[i,j] := A.Matrix[i,j] + B.Matrix[i,j];
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++         Вычитание матриц                           ++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function SubM(A, B : PMatrix):TMatrix;  //
var
 i, j : Integer;
begin
 if (A.nStrok <> B.nStrok) or (A.nStolb <> B.nStolb) then begin
     result.nStrok := -9999999;
     result.nStolb := -9999999;
     result.Matrix := nil;
     exit;
 end;
 //---------------------------------
 result.nStrok := A.nStrok;
 result.nStolb := A.nStolb;
 SetLength(result.Matrix, A.nStrok, A.nStolb);
 //---------------------------------
 for i:=0 to A.nStrok-1 do
     for j:=0 to A.nStolb-1 do
         result.Matrix[i,j] := A.Matrix[i,j] - B.Matrix[i,j];
end;
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++       Транспонирование матрицы             ++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function TM(M : PMatrix):TMatrix;  // Транспонирование матрицы
var i,j : integer;
begin
 //---------------------------------
 result.nStrok := M.nStolb;
 result.nStolb := M.nStrok;
 SetLength(result.Matrix, result.nStrok, result.nStolb);
 //---------------------------------
 for i:=0 to result.nStrok-1 do
     for j:=0 to result.nStolb-1 do
         result.Matrix[i,j] := M.Matrix[j,i];
end;

end.
