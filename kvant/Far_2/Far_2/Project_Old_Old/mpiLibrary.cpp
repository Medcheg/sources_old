//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include "mpiLibrary.h"
#include "Math.h"
#include "Math.hpp"
#pragma package(smart_init)
// =============================================================================
// ========================    TransformCoordinates    =========================
//===========================================================================
void TransformCoordinates(TMatrix3x3 &aMatrix, TFloat inX, TFloat inY, TFloat &OutX, TFloat &OutY)
{
/* TMatrix3x3 aVector;

   aVector.cell[0][0] =  cos(inY) * sin(inX);     aVector.cell[0][1] =  0;        aVector.cell[0][2] =  0;
   aVector.cell[1][0] =  sin(inY);                aVector.cell[1][1] =  0;        aVector.cell[1][2] =  0;
   aVector.cell[2][0] =  cos(inY) * cos(inX);     aVector.cell[2][1] =  0;        aVector.cell[2][2] =  0;

  // ------------
   aVector = aMatrix * aVector;
  // ------------

   OutX = Math::ArcTan2( aVector.cell[0][0], aVector.cell[2][0]);
   OutY = Math::ArcSin ( aVector.cell[1][0] );*/
}

// =============================================================================
// ========================        =========================
//===========================================================================
int round(double aValue)
{
  int aFloor = floor(aValue);

  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
}


double round(double aValue, int aDigit)
{
  double mValue = Power(10, aDigit);

  int aFloor = floor(aValue * mValue);
  return (aValue*mValue - aFloor > 0.5) ? ceil (aValue*mValue) / mValue : aFloor / mValue;
}
