//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "mpiSetupMatrix.h"
#include <Math.hpp>
#include "Unit_GraphicList.h"

//---------------------------------------------------------------------------

#pragma package(smart_init)

/*TMatrix3x3 A_peleng_c;
TMatrix3x3 A_eps_c;*/

TMatrix3x3 A_delta_K_k; ///////
TMatrix3x3 A_delta_Psi;
TMatrix3x3 A_delta_Teta_k;
TMatrix3x3 A_delta_Q_a; //
TMatrix3x3 A_delta_Eps0;//
TMatrix3x3 A_delta_Nju; //

TMatrix3x3 A_K_k;
TMatrix3x3 A_Psi;
TMatrix3x3 A_Teta_k;
TMatrix3x3 A_Q_a;
TMatrix3x3 A_Eps0;
TMatrix3x3 A_Nju;

//TMatrix3x3 A_psi_otr;
//TMatrix3x3 A_teta_k_otr;


TMatrix3x3 TempMatrix;
TMatrix3x3 EMatrix;

// -------------------------------------------------------------------------
// -------------------------------------------------------------------------
// -------------------------------------------------------------------------
void Calc_GLMatrixs(TFar *fFar)
{
/*   A_K_k.GLMatrixCalc();
   A_fi_g.GLMatrixCalc();
   A_Psi.GLMatrixCalc();

   A_Teta_k.GLMatrixCalc();
   //A_q_c.GLMatrixCalc();
   //A_eps_c.GLMatrixCalc();
   A_teta_k_a.GLMatrixCalc();
   A_psi_a.GLMatrixCalc();
   A_Q_a.GLMatrixCalc();

   A_Eps0.GLMatrixCalc();
   A_delta_eps0.GLMatrixCalc();

   A_betta.GLMatrixCalc();
   A_delta_betta.GLMatrixCalc();*/
}

void Calc_Matrixs(TFar *fFar)
{
  // ------------------ �������� �������    ---------------
    A_K_k.cell[0][0]    =  cos(K_k->Value);        A_K_k.cell[0][1]     = -sin(K_k->Value);      A_K_k.cell[0][2]    = 0;
    A_K_k.cell[1][0]    =  sin(K_k->Value);        A_K_k.cell[1][1]     =  cos(K_k->Value);      A_K_k.cell[1][2]    = 0;
    A_K_k.cell[2][0]    =  0;                         A_K_k.cell[2][1]     =  0;                       A_K_k.cell[2][2]    = 1;
  // ------------------ ������ ��������� ����� �������    ---------------
    A_delta_K_k.cell[0][0]    =  cos(DeltaK_k->Value);        A_delta_K_k.cell[0][1]     = -sin(DeltaK_k->Value);      A_delta_K_k.cell[0][2]    = 0;
    A_delta_K_k.cell[1][0]    =  sin(DeltaK_k->Value);        A_delta_K_k.cell[1][1]     =  cos(DeltaK_k->Value);      A_delta_K_k.cell[1][2]    = 0;
    A_delta_K_k.cell[2][0]    =  0;                           A_delta_K_k.cell[2][1]     =  0;                         A_delta_K_k.cell[2][2]    = 1;



  //*********************************************************************************************************************************************************************************************
  //*********************************************************************************************************************************************************************************************
  // ------------------ ������� ������� �����     ---------------
    A_Psi.cell[0][0] =  cos(Psi->Value);           A_Psi.cell[0][1] =  0;    A_Psi.cell[0][2] = sin(Psi->Value);
    A_Psi.cell[1][0] =  0;                         A_Psi.cell[1][1] =  1;    A_Psi.cell[1][2] = 0;
    A_Psi.cell[2][0] = -sin(Psi->Value);           A_Psi.cell[2][1] =  0;    A_Psi.cell[2][2] = cos(Psi->Value);
  // ------------------ ������� ������ ��������� ������� �����     ---------------
    A_delta_Psi.cell[0][0] =  cos(DeltaPsi->Value);        A_delta_Psi.cell[0][1] =  0;    A_delta_Psi.cell[0][2] = sin(DeltaPsi->Value);
    A_delta_Psi.cell[1][0] =  0;                           A_delta_Psi.cell[1][1] =  1;    A_delta_Psi.cell[1][2] = 0;
    A_delta_Psi.cell[2][0] = -sin(DeltaPsi->Value);        A_delta_Psi.cell[2][1] =  0;    A_delta_Psi.cell[2][2] = cos(DeltaPsi->Value);



  //*********************************************************************************************************************************************************************************************
  //*********************************************************************************************************************************************************************************************
  // ------------------ ������� ��������  �����     ---------------
    A_Teta_k.cell[0][0] =  1;      A_Teta_k.cell[0][1] = 0;                       A_Teta_k.cell[0][2] =  0;
    A_Teta_k.cell[1][0] =  0;      A_Teta_k.cell[1][1] = cos(Teta_k->Value);   A_Teta_k.cell[1][2] = -sin(Teta_k->Value);
    A_Teta_k.cell[2][0] =  0;      A_Teta_k.cell[2][1] = sin(Teta_k->Value);   A_Teta_k.cell[2][2] =  cos(Teta_k->Value);
  // ------------------ ������� ������ ��������� ��������  �����     ---------------
    A_delta_Teta_k.cell[0][0] =  1;      A_delta_Teta_k.cell[0][1] = 0;                       A_delta_Teta_k.cell[0][2] =  0;
    A_delta_Teta_k.cell[1][0] =  0;      A_delta_Teta_k.cell[1][1] = cos(DeltaTeta->Value);   A_delta_Teta_k.cell[1][2] = -sin(DeltaTeta->Value);
    A_delta_Teta_k.cell[2][0] =  0;      A_delta_Teta_k.cell[2][1] = sin(DeltaTeta->Value);   A_delta_Teta_k.cell[2][2] =  cos(DeltaTeta->Value);



  //*********************************************************************************************************************************************************************************************
  //*********************************************************************************************************************************************************************************************
  // ------------------ ������� �������� ������� ------------
    A_Q_a.cell[0][0]    =  cos(fFar->CurAzimFAR_Korabel);        A_Q_a.cell[0][1]     = -sin(fFar->CurAzimFAR_Korabel);      A_Q_a.cell[0][2]    = 0;
    A_Q_a.cell[1][0]    =  sin(fFar->CurAzimFAR_Korabel);        A_Q_a.cell[1][1]     =  cos(fFar->CurAzimFAR_Korabel);      A_Q_a.cell[1][2]    = 0;
    A_Q_a.cell[2][0]    =  0;                                    A_Q_a.cell[2][1]     =  0;                                  A_Q_a.cell[2][2]    = 1;
  // ------------------ �������������� �������� ������� ------------
    A_delta_Q_a.cell[0][0]    =  cos(DeltaQ_a->Value);        A_delta_Q_a.cell[0][1]     = -sin(DeltaQ_a->Value);      A_delta_Q_a.cell[0][2]    = 0;
    A_delta_Q_a.cell[1][0]    =  sin(DeltaQ_a->Value);        A_delta_Q_a.cell[1][1]     =  cos(DeltaQ_a->Value);      A_delta_Q_a.cell[1][2]    = 0;
    A_delta_Q_a.cell[2][0]    =  0;                           A_delta_Q_a.cell[2][1]     =  0;                         A_delta_Q_a.cell[2][2]    = 1;



  //*********************************************************************************************************************************************************************************************
  //*********************************************************************************************************************************************************************************************
  // ------------------ ������� �������� ������� �� ���� �����  ------------
    A_Eps0.cell[0][0] =  cos(fFar->FarParam->Eps0);        A_Eps0.cell[0][1] =  0;    A_Eps0.cell[0][2] = sin(fFar->FarParam->Eps0);
    A_Eps0.cell[1][0] =  0;                                A_Eps0.cell[1][1] =  1;    A_Eps0.cell[1][2] = 0;
    A_Eps0.cell[2][0] = -sin(fFar->FarParam->Eps0);        A_Eps0.cell[2][1] =  0;    A_Eps0.cell[2][2] = cos(fFar->FarParam->Eps0);
  // ------------------ ������� ������ �������� ������� �� ���� �����  ------------
    A_delta_Eps0.cell[0][0] =  cos(fFar->FarParam->DeltaEps0);        A_delta_Eps0.cell[0][1] =  0;    A_delta_Eps0.cell[0][2] = sin(fFar->FarParam->DeltaEps0);
    A_delta_Eps0.cell[1][0] =  0;                                     A_delta_Eps0.cell[1][1] =  1;    A_delta_Eps0.cell[1][2] = 0;
    A_delta_Eps0.cell[2][0] = -sin(fFar->FarParam->DeltaEps0);        A_delta_Eps0.cell[2][1] =  0;    A_delta_Eps0.cell[2][2] = cos(fFar->FarParam->DeltaEps0);



  //*********************************************************************************************************************************************************************************************
  //*********************************************************************************************************************************************************************************************
  // ------------------ ������� ���������� ��������� �������   ------------
    A_Nju.cell[0][0] =  1;      A_Nju.cell[0][1] = 0;                          A_Nju.cell[0][2] =  0;
    A_Nju.cell[1][0] =  0;      A_Nju.cell[1][1] = cos(fFar->FarParam->Nju);   A_Nju.cell[1][2] = -sin(fFar->FarParam->Nju);
    A_Nju.cell[2][0] =  0;      A_Nju.cell[2][1] = sin(fFar->FarParam->Nju);   A_Nju.cell[2][2] =  cos(fFar->FarParam->Nju);
  // ------------------ ������� ������ ��������� ���������� ��������� �������   ------------
    A_delta_Nju.cell[0][0] =  1;      A_delta_Nju.cell[0][1] = 0;                               A_delta_Nju.cell[0][2] =  0;
    A_delta_Nju.cell[1][0] =  0;      A_delta_Nju.cell[1][1] = cos(fFar->FarParam->DeltaNju);   A_delta_Nju.cell[1][2] = -sin(fFar->FarParam->DeltaNju);
    A_delta_Nju.cell[2][0] =  0;      A_delta_Nju.cell[2][1] = sin(fFar->FarParam->DeltaNju);   A_delta_Nju.cell[2][2] =  cos(fFar->FarParam->DeltaNju);



 // ------------------- ������� ��������� ������� ����� --------------
/*    TFloat Psi_otr = -Psi->Value + DeltaPsi->Value;
    A_psi_otr.cell[0][0] =  cos(Psi_otr);        A_psi_otr.cell[0][1] =  0;    A_psi_otr.cell[0][2] = sin(Psi_otr);
    A_psi_otr.cell[1][0] =  0;                   A_psi_otr.cell[1][1] =  1;    A_psi_otr.cell[1][2] = 0;
    A_psi_otr.cell[2][0] = -sin(Psi_otr);        A_psi_otr.cell[2][1] =  0;    A_psi_otr.cell[2][2] = cos(Psi_otr);

 // ------------------- ������� ��������� �������� ����� --------------
    TFloat Teta_otr = -Teta_k->Value + DeltaTeta->Value;
    A_teta_k_otr.cell[0][0] =  1;      A_teta_k_otr.cell[0][1] = 0;                       A_teta_k_otr.cell[0][2] =  0;
    A_teta_k_otr.cell[1][0] =  0;      A_teta_k_otr.cell[1][1] = cos(Teta_otr);   A_teta_k_otr.cell[1][2] = -sin(Teta_otr);
    A_teta_k_otr.cell[2][0] =  0;      A_teta_k_otr.cell[2][1] = sin(Teta_otr);   A_teta_k_otr.cell[2][2] =  cos(Teta_otr);
*/
}

//==========================================================================
TMatrix3x3 Calc_MatrixPelengC(TFloat aPelengC){
   TMatrix3x3 ResMatrix;

  // ------------------ ������� ������� ����  ---------------
    ResMatrix.cell[0][0]    =  cos(aPelengC);        ResMatrix.cell[0][1]     = -sin(aPelengC);      ResMatrix.cell[0][2]    = 0;
    ResMatrix.cell[1][0]    =  sin(aPelengC);        ResMatrix.cell[1][1]     =  cos(aPelengC);      ResMatrix.cell[1][2]    = 0;
    ResMatrix.cell[2][0]    =  0;                    ResMatrix.cell[2][1]     =  0;                  ResMatrix.cell[2][2]    = 1;

   return ResMatrix;
}

//==========================================================================
TMatrix3x3 Calc_MatrixEpsC(TFloat aEpsC){
   TMatrix3x3 ResMatrix;

  // ------------------ ������� ���� ����� ����  ---------------
    ResMatrix.cell[0][0] =  cos(aEpsC);        ResMatrix.cell[0][1] =  0;    ResMatrix.cell[0][2] = sin(aEpsC);
    ResMatrix.cell[1][0] =  0;                 ResMatrix.cell[1][1] =  1;    ResMatrix.cell[1][2] = 0;
    ResMatrix.cell[2][0] = -sin(aEpsC);        ResMatrix.cell[2][1] =  0;    ResMatrix.cell[2][2] = cos(aEpsC);

   return ResMatrix;
}

//==========================================================================
TMatrix3x3 Calc_MatrixDeltaAlfa(TFloat DeltaAlfa){
   TMatrix3x3 ResMatrix;

   ResMatrix.cell[0][0] =  cos(DeltaAlfa);        ResMatrix.cell[0][1] =  0;    ResMatrix.cell[0][2] = sin(DeltaAlfa);
   ResMatrix.cell[1][0] =  0;                     ResMatrix.cell[1][1] =  1;    ResMatrix.cell[1][2] = 0;
   ResMatrix.cell[2][0] = -sin(DeltaAlfa);        ResMatrix.cell[2][1] =  0;    ResMatrix.cell[2][2] = cos(DeltaAlfa);

   return ResMatrix;
}

//==========================================================================
TMatrix3x3 Calc_MatrixDeltaQ(TFloat DeltaQ){
   TMatrix3x3 ResMatrix;

    ResMatrix.cell[0][0] =  cos(DeltaQ);        ResMatrix.cell[0][1]     = -sin(DeltaQ);      ResMatrix.cell[0][2]    = 0;
    ResMatrix.cell[1][0] =  sin(DeltaQ);        ResMatrix.cell[1][1]     =  cos(DeltaQ);      ResMatrix.cell[1][2]    = 0;
    ResMatrix.cell[2][0] =  0;                  ResMatrix.cell[2][1]     =  0;                ResMatrix.cell[2][2]    = 1;

   return ResMatrix;
}

