//===========================================================================
//#pragma once
#ifndef mpiVectorH
#define mpiVectorH
//===========================================================================
#include "mpiBaseType.h"
//===========================================================================
class CMatrix;
class CQuaternion;
class CVector : public CBaseType{
public:
    double x() { return Data[0][0]; }
    double y() { return Data[1][0]; }
    double z() { return Data[2][0]; }
public:
    CVector();
    CVector(const CVector& Src);
    CVector(double _x, double _y, double _z);
    CVector(double data[3]);

    CVector& operator = (double* pData);
    CVector& operator = (const CVector& v);

    CVector operator + (const CVector& v);
    CVector operator - (const CVector& v);
    double  operator * (const CVector& v);
    CVector operator ^ (const CVector& v);
    CVector operator * (double s);
    CVector operator / (double s);

    CVector& operator += (const CVector& v);
    CVector& operator -= (const CVector& v);
    CVector& operator ^= (const CVector& v);
    CVector& operator *= (double s);
    CVector& operator /= (double s);
    double & operator [] (int row);
    
    double Norm();
    void   Normalize();
};
//===========================================================================
CVector operator * (const CMatrix& m, const CVector& v);
CVector operator * (double s, const CVector& v);
//===========================================================================
#endif
