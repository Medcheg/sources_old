//---------------------------------------------------------------------------
#ifndef mpiDeclarationH
#define mpiDeclarationH
//---------------------------------------------------------------------------
#include "ComCtrls.hpp"
//---------------------------------------------------------------------------
extern ShortString DataFileDescription1;
extern ShortString DataFileDescription2;
extern ShortString DataFileDescription3;
extern ShortString DataFileDescription4;
extern ShortString DataFileDescription5;


extern int GlobalElementCounter;   // --- ��������� ������ �������� � ���� ������ ---------
extern int GlobalMaterialCounter;  // --- ��������� ������ �������� � ���� ������ ���������� ---------
extern int GlobalMashineCounter;   // --- ��������� ������ �������� � ���� ������ ����� � ���������� ---------
extern int GlobalEnergoCounter;    // --- ��������� ������ �������� � ���� ������ ������ ������ ---------
extern int   GlobalProjectElementCounter; // ---- GlobalProjectElementCounter
extern int GlobalElementID;  // ---  ---------

extern AnsiString ApplicationName;
           
extern bool isProjectModified;

extern double         CoefMat1, CoefWork1;
extern double         CoefMat2, CoefWork2;
extern double         RoomHeight;

extern AnsiString     Valjuta;

extern TTreeNode *SelectedNode;
//---------------------------------------------------------------------------
#endif
