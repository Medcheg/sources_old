//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "mpiBaseType.h"
//===========================================================================
CBaseType::CBaseType()
{
   Rows    = 0;
   Columns = 0;
   Data    = NULL;
}

//===========================================================================
CBaseType::~CBaseType()
{
   DeleteMatrix();
}

//===========================================================================
void CBaseType::DeleteMatrix()
{
   if (Data == NULL) return;
  //
   for (int i = 0; i < Rows; i++)
        if (Data[i] != NULL )delete [] Data[i];
   delete [] Data;
  //
   Data    = NULL;
   Rows    = 0;
   Columns = 0;
}

//===========================================================================
CBaseType *CBaseType::SetSize(int aRows, int aColumns)
{
      if (aRows    < 0) return NULL;
      if (aColumns < 0) return NULL;
    // ----
      if (Data != NULL) DeleteMatrix();
    // ----
      Data = new double*[aRows];
      if (Data == NULL) return NULL;

      for (int i = 0; i < aRows; i++) {
         Data[i] = new double[aColumns];
         if (Data != NULL) {
            memset(Data[i], 0, sizeof(double)*aColumns);
            continue;
         }

        // --- Если совсем плохо удалем строки ----
         for (int k = 0; k < i; k++) delete[] Data[k];
         delete[] Data;
         return NULL;
      }

    // ----
      Rows    = aRows;
      Columns = aColumns;

      //for (int i = 0; i < aRows*aColumns; i++) mData[i] = 0;
      
      return this; // --- Если все удачно возвращаем указатель на структуру -----
}

//===========================================================================
double& CBaseType::operator () (int row, int column)
{
    if ((row    < 0 ) || (row    >= Rows   )) DEBUG_BREAK();
    if ((column < 0 ) || (column >= Columns)) DEBUG_BREAK();
  
    //mData[row * Columns + column] =  Data[row][column];
    return Data[row][column];
}
/*
//===========================================================================
//*******************************************************************
// void CMatrixNM::Dump(void* file = 0)
//-------------------------------------------------------------------
// DESCRIPTION:
//  Вывод информации о матрице в файл
//
//  Выводится информация о собдержимом матрицы в файл. Если файл не
//  задан (передано значение 0), то происходит вывод на консоль
//-------------------------------------------------------------------
// PARAMETERS:
//  file - дескриптор файла, куда будет выполнен вывод. По умолчанию
//         равен NULL
//*******************************************************************
void CBaseType::DumpMatrix(void* file)
{
  FILE* output;
  if(file == NULL) output = stdout;
  else output = (FILE *)file;

  if (Data == NULL) {
      fprintf(output, "Matrix is not valid\n");
      return;
  }

  fprintf(output, "Rows : %d\tColumns %d\n", Rows, Columns);
  for(int i = 0; i < Rows; i++)
  {
    for(int j = 0; j < Columns; j++) fprintf(output, "%g ", Data[i][j]);
    fprintf(output, "\n");
  }
}
  */
