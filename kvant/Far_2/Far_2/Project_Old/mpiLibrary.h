//---------------------------------------------------------------------------
#ifndef mpiLibraryH
#define mpiLibraryH
//---------------------------------------------------------------------------
#include "mpiMatrix.h"
//---------------------------------------------------------------------------
//extern void TransformCoordinates(TMatrix3x3 &aMatrix, TFloat inX, TFloat inY, TFloat &OutX, TFloat &OutY);

extern __fastcall int round(double aValue);
extern double __fastcall round(double aValue, int aDigit);
extern void ShowWrongEdit(TEdit *Edit);

//---------------------------------------------------------------------------
#endif
