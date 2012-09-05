//===========================================================================
#include <StdCtrls.hpp>
#include <Math.h>
#include <Math.hpp>
#pragma hdrstop

#include "mpiLibrary.h"
#include "mpiErrors_and_Warning.h"
// =============================================================================
// ========================        =========================
//===========================================================================
int __fastcall round(double aValue)
{
  int aFloor = floor(aValue);

  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
}

//===========================================================================
double __fastcall round(double aValue, int aDigit)
{
  double mValue = Power(10, aDigit);

  int aFloor = floor(aValue * mValue);
  return (aValue*mValue - aFloor > 0.5) ? ceil (aValue*mValue) / mValue : aFloor / mValue;
}

// =============================================================================
// ========================        =========================
//===========================================================================
int __fastcall round(long double aValue)
{
  int aFloor = floor(aValue);

  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
}

//===========================================================================
double __fastcall round(long double aValue, int aDigit)
{
  double mValue = Power(10, aDigit);

  int aFloor = floor(aValue * mValue);
  return (aValue*mValue - aFloor > 0.5) ? ceil (aValue*mValue) / mValue : aFloor / mValue;
}

//===========================================================================

void ShowWrongEdit(void *aEdit)
{
   ((TEdit*)aEdit)->SetFocus();
   ((TEdit*)aEdit)->SelectAll();
   InputError_None_Digital_Value(NULL);
}


