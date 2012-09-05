//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------

#include "mpiDeclaration.h"

//---------------------------------------------------------------------------
ShortString DataFileDescription1 = "===================================================         \n";
ShortString DataFileDescription2 = "=== !!!! База программы СМЕТА  !!! (версия 2.1) ===         \n";
ShortString DataFileDescription3 = "===================================================         \n";
ShortString DataFileDescription4 = "========  !!! Файл не редактировать !!! ===========         \n";
ShortString DataFileDescription5 = "===================================================        \n\n";

int   GlobalElementCounter;            // --- Последний индекс елемента в базе данных ---------
int   GlobalMaterialCounter;           // --- Последний индекс елемента в базе данных материалов ---------
int   GlobalMashineCounter;            // --- Последний индекс елемента в базе данных машин и механизмов ---------
int   GlobalEnergoCounter;             // --- Последний индекс елемента в базе данных Енерго затрат ---------
int   GlobalElementID;                 // ---  ---------
int   GlobalProjectElementCounter;     // ---- GlobalProjectElementCounter

AnsiString ApplicationName = "";

bool  isProjectModified = false;

// ----------- Проектные параметры --------------------
  double         CoefMat1 = 1,    CoefWork1 = 1;
  double         CoefMat2 = 1,    CoefWork2 = 1;

  double         RoomHeight = 3;
  AnsiString     Valjuta = "грн";
// -------------------------------
TTreeNode *SelectedNode;

//---------------------------------------------------------------------------


