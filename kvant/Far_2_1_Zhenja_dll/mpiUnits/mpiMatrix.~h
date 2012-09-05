//---------------------------------------------------------------------------
#ifndef _mpiMatrixH_
#define _mpiMatrixH_

#include "mpiTypes.h"

// =============================================================================
// ========================    Classify TMatrix    =============================
// =============================================================================
class TMatrix3x3 {
private:
public:
        int      id;
        int      RowsCount, CollumsCount;
        TMatrix3x3() {
           this->RowsCount = 3; this->CollumsCount = 3;
           for (int i = 0; i < 16 ; i++) GLcell[i] = 0;
        };

        void GLMatrixCalc();

        TFloat   cell[3][3];
        TFloat   GLcell[16];
};

// =============================================================================
// ======================     Operator " * "      ==============================
// =============================================================================
inline TMatrix3x3 operator *(const TMatrix3x3 &m1, const TMatrix3x3 &m2)
{
  TMatrix3x3 ReturnMatrix;
  for (int i = 0; i < ReturnMatrix.RowsCount; i++)
         for (int j = 0; j < ReturnMatrix.CollumsCount; j++){

               TFloat CollumSum = 0;

               if (m1.CollumsCount != 3 || ReturnMatrix.cell == NULL)
                  return ReturnMatrix;

               for (int k = 0; k < ReturnMatrix.CollumsCount; k++)
                 CollumSum += m1.cell[i][k] * m2.cell[k][j];

               ReturnMatrix.cell[i][j] = CollumSum;

         }

  ReturnMatrix.id = m1.id*10 + m2.id;

  return ReturnMatrix;
}

// =============================================================================
// ======================     Operator " + "      ==============================
// =============================================================================
inline TMatrix3x3 operator + (const TMatrix3x3 &m1, const TMatrix3x3 &m2)
{
  TMatrix3x3 ReturnMatrix;

  for (int i = 0; i < ReturnMatrix.RowsCount; i++)
         for (int j = 0; j < ReturnMatrix.CollumsCount; j++)
               ReturnMatrix.cell[i][j] = m1.cell[i][j] + m2.cell[i][j];

  return ReturnMatrix;
}

// =============================================================================
// ======================     Operator " - "      ==============================
// =============================================================================
inline TMatrix3x3 operator - (const TMatrix3x3 &m1, const TMatrix3x3 &m2)
{
  TMatrix3x3 ReturnMatrix;

  for (int i = 0; i < ReturnMatrix.RowsCount; i++)
         for (int j = 0; j < ReturnMatrix.CollumsCount; j++)
               ReturnMatrix.cell[i][j] = m1.cell[i][j] - m2.cell[i][j];

  return ReturnMatrix;
}

// =============================================================================
// ======================     Транспонирование   ===============================
// =============================================================================
TMatrix3x3 tm(const TMatrix3x3 &m1)
{
  TMatrix3x3 ReturnMatrix;

  for (int i = 0; i < ReturnMatrix.RowsCount; i++)
         for (int j = 0; j < ReturnMatrix.CollumsCount; j++)
               ReturnMatrix.cell[i][j] = m1.cell[j][i];

  return ReturnMatrix;
}
void TMatrix3x3::GLMatrixCalc()
{
  GLcell[ 0] = cell[0][0];    GLcell[ 1] = cell[0][1];    GLcell[ 2] = cell[0][2];    GLcell[ 3] = 0;
  GLcell[ 4] = cell[1][0];    GLcell[ 5] = cell[1][1];    GLcell[ 6] = cell[1][2];    GLcell[ 7] = 0;
  GLcell[ 8] = cell[2][0];    GLcell[ 9] = cell[2][1];    GLcell[10] = cell[2][2];    GLcell[11] = 0;
  GLcell[12] = 0;             GLcell[13] = 0;             GLcell[14] = 0;             GLcell[15] = 1;
}

/*
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++       Нахождение детерминанта матрицы      ++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function detM(M : PMatrix ):TFloat;
begin
 result :=   M^.cell[0][0]*( M^.cell[1][1]*M^.cell[2][2]-M^.cell[1][2]*M^.cell[2][1] )
           + M^.cell[0][1]*( M^.cell[1][0]*M^.cell[2][2]-M^.cell[1][2]*M^.cell[2][0] )
           + M^.cell[0][2]*( M^.cell[1][0]*M^.cell[2][1]-M^.cell[1][1]*M^.cell[2][0] );
end;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++       Нахождение обратной матрицы          ++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function ObrM(M : PMatrix ):TMatrix;
var d1 : TFloat;
begin
 d1 := detM(M);
 //---------------------------------
 result.nStrok := M^.nStrok;
 result.nStolb := M^.nStolb;
 SetLength(result.cell, M^.nStrok, M^.nStolb);
 //---------------------------------
 try
  result.cell[0][0] := (M^.cell[1][1]*M^.cell[2][2] - M^.cell[1][2]*M^.cell[2][1])/d1;
  result.cell[0][1] := (M^.cell[0][1]*M^.cell[2][2] - M^.cell[0][2]*M^.cell[2][1])/d1;
  result.cell[0][2] := (M^.cell[0][1]*M^.cell[1][2] - M^.cell[0][2]*M^.cell[1][1])/d1;
  result.cell[1][0] := (M^.cell[1][0]*M^.cell[2][2] - M^.cell[1][2]*M^.cell[2][0])/d1;
  result.cell[1][1] := (M^.cell[0][0]*M^.cell[2][2] - M^.cell[0][2]*M^.cell[2][0])/d1;
  result.cell[1][2] := (M^.cell[0][0]*M^.cell[1][2] - M^.cell[0][2]*M^.cell[1][0])/d1;
  result.cell[2][0] := (M^.cell[1][0]*M^.cell[2][1] - M^.cell[1][1]*M^.cell[2][0])/d1;
  result.cell[2][1] := (M^.cell[0][0]*M^.cell[2][1] - M^.cell[2][0]*M^.cell[0][1])/d1;
  result.cell[2][2] := (M^.cell[0][0]*M^.cell[1][1] - M^.cell[0][1]*M^.cell[1][0])/d1;
 except
  result:=M^;
 end;
end;
*/
#endif;
