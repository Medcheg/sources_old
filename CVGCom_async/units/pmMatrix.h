//---------------------------------------------------------------------------
#ifndef pmMatrixH
#define pmMatrixH
//---------------------------------------------------------------------------
typedef unsigned short int Uint16;

void matrix_mul       (Uint16 Rows1, Uint16 Columns1 , float *m1, Uint16 Rows2, Uint16 Columns2, float *m2, float *out_Matrix);
void matrix_transponce(Uint16 Rows , Uint16 Columns  , float *in_Matrix, float *out_Matrix);
void matrix_summ      (Uint16 Rows , Uint16 Columns  , float *m1, float *m2, float *out_Matrix);
void matrix_sub       (Uint16 Rows , Uint16 Columns  , float *m1, float *m2, float *out_Matrix);
void matrix_invers    (Uint16 Rows , float *in_Matrix, float *out_Matrix);

void matrix_mul       (Uint16 Rows1, Uint16 Columns1  , double *m1, Uint16 Rows2, Uint16 Columns2  , double *m2, double *out_Matrix);
void matrix_transponce(Uint16 Rows , Uint16 Columns   , double *in_Matrix, double *out_Matrix);
void matrix_summ      (Uint16 Rows , Uint16 Columns   , double *m1, double *m2, double *out_Matrix);
void matrix_sub       (Uint16 Rows , Uint16 Columns   , double *m1, double *m2, double *out_Matrix);
void matrix_invers    (Uint16 Rows , double *in_Matrix, double *out_Matrix);

//---------------------------------------------------------------------------
#endif
