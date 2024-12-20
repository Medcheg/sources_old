//===========================================================================
#include <vcl.h>
#pragma hdrstop
//===========================================================================
#include "mpiVector.h"
#include "mpiMatrix.h"
#include "math.h"
//===========================================================================
CVector::CVector()
{
   if ( SetSize(3, 1) == NULL) { DEBUG_BREAK(); return; }
}

//========== =================================================================
CVector::CVector(const CVector& Src)
{
   if (Src.Data      == NULL) { DEBUG_BREAK(); return; }
   if (SetSize(3, 1) == NULL) { DEBUG_BREAK(); return; }

   Data[0][0] = Src.Data[0][0];
   Data[1][0] = Src.Data[1][0];
   Data[2][0] = Src.Data[2][0];
}

//===========================================================================
CVector::CVector(double _x, double _y, double _z)
{
   if (SetSize(3, 1) == NULL) { DEBUG_BREAK(); return; }

   Data[0][0] = _x;
   Data[1][0] = _y;
   Data[2][0] = _z;
}

//===========================================================================
CVector::CVector(double data[3])
{
   if (SetSize(3, 1) == NULL) { DEBUG_BREAK(); return; }

   Data[0][0] = data[0];
   Data[1][0] = data[1];
   Data[2][0] = data[2];
}

//===========================================================================
CVector& CVector::operator = (double* pData)
{
    if(pData == NULL) { DEBUG_BREAK(); return *this; }
    if( Data == NULL) { DEBUG_BREAK(); return *this; }

    Data[0][0] = pData[0];
    Data[1][0] = pData[1];
    Data[2][0] = pData[2];

    return *this;
}

//===========================================================================
CVector& CVector::operator = (const CVector& v)
{
    if (v.Data == NULL) { DEBUG_BREAK(); return *this; }
    if (  Data == NULL) { DEBUG_BREAK(); return *this; }

    Data[0][0] = v.Data[0][0];
    Data[1][0] = v.Data[1][0];
    Data[2][0] = v.Data[2][0];
    
    return *this;
}

//===========================================================================
CVector CVector::operator + (const CVector& v)
{
  if (v.Data == NULL) { DEBUG_BREAK(); return *this; }
  if (  Data == NULL) { DEBUG_BREAK(); return *this; }

  return CVector(Data[0][0] + v.Data[0][0],
                 Data[1][0] + v.Data[1][0],
                 Data[2][0] + v.Data[2][0]);
}

//==========================================================================
CVector CVector::operator - (const CVector& v)
{
  if (v.Data == NULL) { DEBUG_BREAK(); return *this; }
  if (  Data == NULL) { DEBUG_BREAK(); return *this; }

  return CVector(Data[0][0] - v.Data[0][0],
                 Data[1][0] - v.Data[1][0],
                 Data[2][0] - v.Data[2][0]);
}

//===========================================================================
double  CVector::operator * (const CVector& v)
{
  if (v.Data == NULL) { DEBUG_BREAK(); return -999; }
  if (  Data == NULL) { DEBUG_BREAK(); return -999; }

  return (Data[0][0]*v.Data[0][0] +
          Data[1][0]*v.Data[1][0] +
          Data[2][0]*v.Data[2][0]);
}

//===========================================================================
CVector CVector::operator ^ (const CVector& v)
{
  if (v.Data == NULL) { DEBUG_BREAK(); return *this; }
  if (  Data == NULL) { DEBUG_BREAK(); return *this; }

  return CVector(Data[1][0] * v.Data[2][0] - Data[2][0] * v.Data[1][0],
                 Data[2][0] * v.Data[0][0] - Data[0][0] * v.Data[2][0],
                 Data[0][0] * v.Data[1][0] - Data[1][0] * v.Data[0][0]);

//  return CVector(y*v.z - z*v.y,    z*v.x - x*v.z,    x*v.y - y*v.x);
}

//===========================================================================
CVector CVector::operator * (double s)
{
  if (  Data == NULL) { DEBUG_BREAK(); return *this; }

  return CVector(Data[0][0] * s, Data[1][0] * s, Data[2][0] * s);
}

//===========================================================================
CVector CVector::operator / (double s)
{
  if (  Data == NULL) { DEBUG_BREAK(); return *this; }
  if (     s == 0   ) { DEBUG_BREAK(); return *this; }

  return CVector(Data[0][0] / s, Data[1][0] / s, Data[2][0] / s);
}

//===========================================================================
CVector& CVector::operator += (const CVector& v)
{
  if (v.Data == NULL) { DEBUG_BREAK(); return *this; }
  if (  Data == NULL) { DEBUG_BREAK(); return *this; }

  Data[0][0] += v.Data[0][0];
  Data[1][0] += v.Data[1][0];
  Data[2][0] += v.Data[2][0];
  return *this;
}

//===========================================================================
CVector& CVector::operator -= (const CVector& v)
{
  if (v.Data == NULL) { DEBUG_BREAK(); return *this; }
  if (  Data == NULL) { DEBUG_BREAK(); return *this; }

  Data[0][0] -= v.Data[0][0];
  Data[1][0] -= v.Data[1][0];
  Data[2][0] -= v.Data[2][0];
  
  return *this;
}

//===========================================================================
CVector& CVector::operator ^= (const CVector& v)
{
  if (v.Data == NULL) { DEBUG_BREAK(); return *this; }
  if (  Data == NULL) { DEBUG_BREAK(); return *this; }

  double _x = Data[1][0]*v.Data[2][0] - Data[2][0]*v.Data[1][0];
  double _y = Data[2][0]*v.Data[0][0] - Data[0][0]*v.Data[2][0];
  double _z = Data[0][0]*v.Data[1][0] - Data[1][0]*v.Data[0][0];

  Data[0][0] = _x;
  Data[1][0] = _y;
  Data[2][0] = _z;
  
  return *this;
}

//===========================================================================
CVector& CVector::operator *= (double s)
{
  if (Data == NULL)  { DEBUG_BREAK(); return *this; }

  Data[0][0] *= s;
  Data[1][0] *= s;
  Data[2][0] *= s;
  
  return *this;
}

//===========================================================================
CVector& CVector::operator /= (double s)
{
    if (Data == NULL) { DEBUG_BREAK(); return *this; }
    if (   s == 0   ) { DEBUG_BREAK(); return *this; }

    Data[0][0] /= s;
    Data[1][0] /= s;
    Data[2][0] /= s;

    return *this;
}

//===========================================================================
double& CVector::operator [] (int row)
{
  switch( row )
  {
    case 0: return Data[0][0];            // --- ��������� ����� X ---
    case 1: return Data[1][0];            // --- ��������� ����� Y ---
    case 2: return Data[2][0];            // --- ��������� ����� Z ---
  }
  DEBUG_BREAK();  return Data[0][0];          // --- ��������� ����� X ---
}

//===========================================================================
double CVector::Norm()
{
    if (Data == NULL) { DEBUG_BREAK(); return -999; }

    return sqrt(Data[0][0] * Data[0][0] +
                Data[1][0] * Data[1][0] +
                Data[2][0] * Data[2][0]);
 
}

//===========================================================================
void CVector::Normalize()
{
    double norm = Norm();
    
  // ----------  
    if ( norm == 0 ) { DEBUG_BREAK(); return; }

    Data[0][0] = Data[0][0] / norm;
    Data[1][0] = Data[1][0] / norm;
    Data[2][0] = Data[2][0] / norm;
  // ----------  
}

//double  operator [] (const CVector& v, int row)
//{
//    return v.Data[row][0];
//}

//===========================================================================
CVector operator * (const CMatrix& m, const CVector& v)
{
    if (v.Data    ==   NULL) { DEBUG_BREAK(); return CVector(); }
    if (m.Data    ==   NULL) { DEBUG_BREAK(); return CVector(); }
    if (m.Columns != v.Rows) { DEBUG_BREAK(); return CVector(); }

    CVector Res; 

    Res.Data[0][0] = m.Data[0][0]*v.Data[0][0] + m.Data[0][1]*v.Data[1][0] + m.Data[0][2]*v.Data[2][0];
    Res.Data[1][0] = m.Data[1][0]*v.Data[0][0] + m.Data[1][1]*v.Data[1][0] + m.Data[1][2]*v.Data[2][0];
    Res.Data[2][0] = m.Data[2][0]*v.Data[0][0] + m.Data[2][1]*v.Data[1][0] + m.Data[2][2]*v.Data[2][0];
  
    return Res;
}

//===========================================================================
CVector operator * (double s, const CVector& v)
{
    if (v.Data == NULL) { DEBUG_BREAK(); return CVector(); }

    return CVector(v.Data[0][0] * s, v.Data[1][0] * s, v.Data[2][0] * s);
}


