//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------

#include "mpiDeclaration.h"

//---------------------------------------------------------------------------
ShortString DataFileDescription1 = "===================================================         \n";
ShortString DataFileDescription2 = "=== !!!! ���� ��������� �����  !!! (������ 2.1) ===         \n";
ShortString DataFileDescription3 = "===================================================         \n";
ShortString DataFileDescription4 = "========  !!! ���� �� ������������� !!! ===========         \n";
ShortString DataFileDescription5 = "===================================================        \n\n";

int   GlobalElementCounter;            // --- ��������� ������ �������� � ���� ������ ---------
int   GlobalMaterialCounter;           // --- ��������� ������ �������� � ���� ������ ���������� ---------
int   GlobalMashineCounter;            // --- ��������� ������ �������� � ���� ������ ����� � ���������� ---------
int   GlobalEnergoCounter;             // --- ��������� ������ �������� � ���� ������ ������ ������ ---------
int   GlobalElementID;                 // ---  ---------
int   GlobalProjectElementCounter;     // ---- GlobalProjectElementCounter

AnsiString ApplicationName = "";

bool  isProjectModified = false;

// ----------- ��������� ��������� --------------------
  double         CoefMat1 = 1,    CoefWork1 = 1;
  double         CoefMat2 = 1,    CoefWork2 = 1;

  double         RoomHeight = 3;
  AnsiString     Valjuta = "���";
// -------------------------------
TTreeNode *SelectedNode;

//---------------------------------------------------------------------------

