//===========================================================================
//#pragma once
#ifndef mpiBaseTypeH
#define mpiBaseTypeH
//===========================================================================
//===========================================================================
#if defined(DEBUG) || defined(_DEBUG)
    #define DEBUG_BREAK() __asm {int 3};
#else
    #define DEBUG_BREAK() {}
#endif
//===========================================================================
#define min(a, b)  (((a) < (b)) ? (a) : (b))
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min3(a, b, c)  (((a) <  (b)) ? (((a)<(c))?(a):(c)) : (((b)<(c))?(b):(c)))
#define max3(a, b, c)  (((a) >  (b)) ? (((a)>(c))?(a):(c)) : (((b)>(c))?(b):(c)))
#define sign(a)		   (((a) >= (0)) ? (1) : (-1))
//===========================================================================
class CMatrix;
class CBaseType{
protected:
    CBaseType *SetSize(int aRows, int aColumns);
    void DeleteMatrix();
public:
    int Rows, Columns;
    double **Data;
    //double   mData[256];

    CBaseType();
    virtual ~CBaseType();

    double& operator () (int row, int column);
    double* operator [] (int row);
    //void DumpMatrix(void* file = 0);
};
#endif
