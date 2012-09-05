//===========================================================================
#ifndef pmMatrixH
#define pmMatrixH
//===========================================================================
#if defined(DEBUG) || defined(_DEBUG)
    #define DEBUG_BREAK() __asm {int 3};
#else
    #define DEBUG_BREAK() {}
#endif

#define min(a, b)  (((a) < (b)) ? (a) : (b))
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#define min3(a, b, c)  (((a) <  (b)) ? (((a)<(c))?(a):(c)) : (((b)<(c))?(b):(c)))
#define max3(a, b, c)  (((a) >  (b)) ? (((a)>(c))?(a):(c)) : (((b)>(c))?(b):(c)))
#define sign(a)		   (((a) >= (0)) ? (1) : (-1))

//===========================================================================
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

//===========================================================================
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
//CMatrix diad(const CVector& v1, const CVector& v2);
//CMatrix CSop(const CVector& v);
//===========================================================================
#endif
