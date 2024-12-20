//===========================================================================
//#pragma once
#ifndef mpiQuaternionH
#define mpiQuaternionH
//===========================================================================
#include "mpiBaseType.h"
#include "mpiVector.h"
//===========================================================================
class CVector;
class CMatrixc;
class CQuaternion : public CBaseType
{
public:
    double  w() { return Data[0][0]; }
    CVector v() { return CVector(Data[1][0], Data[2][0], Data[3][0]); }

    double x() { return Data[1][0]; }
    double y() { return Data[2][0]; }
    double z() { return Data[3][0]; }
public:
    CQuaternion();
    CQuaternion(double _w, double _x, double _y, double _z);
    CQuaternion(double data[4]);
    CQuaternion(const CQuaternion& q);
    CQuaternion(double _w, const CVector& _v);
    CQuaternion(double fi, double psi, double theta);

    CQuaternion &operator = (double* data);
    CQuaternion &operator = (const CQuaternion& q);

    CQuaternion operator + (const CQuaternion& q);
    CQuaternion operator - (const CQuaternion& q);
    CQuaternion operator * (const CQuaternion& q);
    CQuaternion operator * (double s);
    CQuaternion operator / (double s);

    CQuaternion operator ~ ();
    CQuaternion operator - ();

    CQuaternion& operator += (const CQuaternion& q);
    CQuaternion& operator -= (const CQuaternion& q);
    CQuaternion& operator *= (const CQuaternion& q);

    double& operator [] (int index);

    double Norm();
    bool IsNormalized();
    void Normalize();

    void GetAngles(double& a, double& b, double& c);
    CMatrix GetMatrix();
};
CQuaternion operator * (const CMatrix &m, const CQuaternion &q);
CQuaternion operator + (const CQuaternion &q, const CMatrix &m);
CQuaternion operator + (const CMatrix &m, const CQuaternion &q);
CQuaternion operator - (const CQuaternion &q, const CMatrix &m);
CQuaternion operator - (const CMatrix &m, const CQuaternion &q);
//CQuaternion operator * (double s, const CQuaternion q);
//===========================================================================
#endif
