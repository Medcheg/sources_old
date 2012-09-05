//===========================================================================
#ifndef mpiLibraryH
#define mpiLibraryH
//===========================================================================
//#include "mpiTypes.h"
//===========================================================================
extern int    __fastcall round(double aValue);
extern double __fastcall round(double aValue, int aDigit);
extern int    __fastcall round(long double aValue);
extern double __fastcall round(long double aValue, int aDigit);
extern void ShowWrongEdit(void *aEdit);
//===========================================================================
#endif
