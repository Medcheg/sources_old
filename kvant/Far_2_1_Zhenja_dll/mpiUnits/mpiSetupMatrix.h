//---------------------------------------------------------------------------

#ifndef mpiSetupMatrixH
#define mpiSetupMatrixH
#include "mpiMatrix.h"
//#include "mpiFar.h"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------

/*extern TMatrix3x3 B_k;
extern TMatrix3x3 A_fi_g;
extern TMatrix3x3 A_psi;

extern TMatrix3x3 A_teta_k;
extern TMatrix3x3 A_teta_k_a;
extern TMatrix3x3 A_psi_a;
extern TMatrix3x3 A_q_a;

extern TMatrix3x3 A_betta;
extern TMatrix3x3 A_delta_betta;

extern TMatrix3x3 A_eps0;
extern TMatrix3x3 A_delta_eps0;

extern TMatrix3x3 TempMatrix;

extern void Calc_GLMatrixs(TFar *fFar);
extern TMatrix3x3 Calc_MatrixDeltaAlfa(TFloat DeltaAlfa);
extern TMatrix3x3 Calc_MatrixDeltaQ   (TFloat DeltaQ);*/

extern TMatrix3x3 A_delta_K_k; ///////
extern TMatrix3x3 A_delta_Psi;
extern TMatrix3x3 A_delta_Teta_k;
extern TMatrix3x3 A_delta_Q_a; //
extern TMatrix3x3 A_delta_Eps0;//
extern TMatrix3x3 A_delta_Nju; //

extern TMatrix3x3 A_K_k;
extern TMatrix3x3 A_Psi;
extern TMatrix3x3 A_Teta_k;
extern TMatrix3x3 A_Q_a;
extern TMatrix3x3 A_Eps0;
extern TMatrix3x3 A_Nju;


extern TMatrix3x3 Matrix_Geo_Stab;
extern TMatrix3x3 Matrix_Clear_Geo_Stab;
extern TMatrix3x3 Matrix_Geo_Far;
extern TMatrix3x3 Matrix_Clear_Geo_Far;


extern void Calc_Matrixs();
//extern void Calc_Matrixs(TFar *fFar);

extern TMatrix3x3 Calc_MatrixPelengC(TFloat aPelengC);
extern TMatrix3x3 Calc_MatrixEpsC(TFloat aEpsC);
extern TMatrix3x3 Calc_MatrixDeltaAlfa(TFloat DeltaAlfa);
extern TMatrix3x3 Calc_MatrixDeltaQ(TFloat DeltaQ);

#endif
