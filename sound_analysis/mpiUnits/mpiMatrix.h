//===========================================================================
//#pragma once
#ifndef mpiMatrix_H
#define mpiMatrix_H
//===========================================================================
#include "mpiBaseType.h"
//===========================================================================
class CVector;
class CQuaternion;
class CMatrix : public CBaseType{
public:
    double GLMatrix[16];
public:
    CMatrix();
    CMatrix(const CMatrix& Src);
    CMatrix(int aRows, int aColumns, double *aData);
    CMatrix(int aRows, int aColumns);

    CMatrix Transpose();        // ---- Транспонирование матрици -----
    CMatrix Inverse_Sharov();   // ---
    CMatrix Inverse_Zhordan_0();   // --- 

    void     Clear();             // --- Обнуление всех элементов матрицы. ---
    CMatrix &Identity();          // ---- Единичная матрица -----
    double   Det();               // ---- Детерминант матрици -----
    double  *Get_GL_Matrix();
    
    //CMatrix GetBlock(int I, int J, int rows, int columns);
    //void    SetBlock(int I, int J, const CMatrix& m);

    CMatrix operator = (const CMatrix &m);
    CMatrix operator + (const CMatrix &m);
    CMatrix operator - (const CMatrix &m);
    CMatrix operator * (const CMatrix &m);

    CMatrix operator * (const double s);
    CMatrix operator / (const double s);

    double* operator [] (int row);
};
//===========================================================================
CMatrix operator * (double s, CMatrix& m);
CMatrix diad(const CVector& v1, const CVector& v2);
CMatrix CSop(const CVector& v);
//===========================================================================
#endif
