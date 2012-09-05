//===========================================================================
#ifndef mpiTargetH
#define mpiTargetH
#include "mpiTypes.h"
#include "mpiMatrix.h"

//===========================================================================
/*
      bool       *Radiation;    // --- ���� � ��������� ��, �� -----
      bool       *EndRadiation; // --- ��������� �� ��������  -----
      bool       *InSector;     // --- ��������� �� ��������  -----
      bool       *OutSector;    // --- ��������� �� ��������  -----

      bool       EnabledCalcPosTarget; // -- ����� �� ����������� ���������� ���� ------
      bool       EnabledDrawTarget;    // -- ����� �� ������������ ���������� ���� ------

      TTargetPoint *IdealPositionTarget;
      TTargetPoint *RealPositionTarget;
      int           CountDataPointTarget;  // ---- ��������� ����� � ���� ������� -------

      TDiagramPoint  **Pachka1; // ---- ����� ���������� ��������� ������� ���� � ������ ���� ---
      TDiagramPoint  **Pachka2; // ---- ����� ���������� ��������� ������� ���� � ������ ���� ---

      int             *LengthPachka1;  // ---- ��������� ����� � ���� ������� -------
      int             *LengthPachka2;  // ---- ��������� ����� � ���� ������� -------

      void Save_Ideal_And_Real_PositionTarget(TFloat aQ_Ideal, TFloat aEps_Ideal, TFloat aQ_Real, TFloat aEps_Real, TFloat aCurTime);
*/

// ================================================================================
typedef struct {
      TFloat     E1;
      TFloat     E2;
}TValueOffset;

// ================================================================================
class TTarget{
private:
        TFarParam *fpFarParam;
        TFloat     Rz, xi, yi, zi; // ------ ������������� ���������� ��������� ��� ������� ��������� ���� -----------
        TFloat     x0, y0, z0, Vx, Vy;
        TFloat     Eps0;   // *** ����������� ��������� ���� ����� ���� ***

        TMatrix3x3  fDirectionalCosines;

        void      Get_Ro_Fi(TImpuls aImpuls, TFloat &aRo, TFloat &aFi);
        void      Get_Ro1_Ro2(TImpuls aImpuls, TFloat &aRo, TFloat &aFi);
        TImpuls   KoefPelengCharacteristic(bool aCalcDirectionalCosines, bool aCalcRelay, TFloat aQ_c, TFloat aEps_c);

public:
        int        id;         // ---------����� ���� (����� ������) ----------

     // -----------  ���� ������ �������� ��� ��� ������� � ���������� � ���� ---------  
        TTargetAccess *TargetAccess;
        int            TargetAccess_Count;

     // -----------  �������� ��������� �������� --------------
        TFloat     R0;         // --- ��������� ��������� � ���� ------------------
        TFloat     B0;         // --- ��������� ������ ����  ----------
        TFloat     V0;         // --- ��������� �������� �������� ���� ----------
        TFloat     H0;         // --- ��������� ������ �������� ���� ----------
        TFloat     K0;         // --- ��������� ���� �������� ����  ----------

     // --------------------------------------------------------
        TTargetsCoord  Coord;                          // -----------  ������� (���������) ��������� ���� --------------
        TTargetsCoord  Coord_FisrtImpuls;              // -----------  ������� (���������) ���������� ���� � �� ������� ��� ������ ��������� � ���� f(����������) --------------
        TTargetsCoord  Coord_Far_Clear;                // -----------  ������� (���������) ���������� ���� � �� ��� (����������) --------------

        TTargetsCoord  Coord_Far;          // -----------  ������� (���������) ���������� ���� � �� ��� (� ������ ������) --------------
        TTargetsCoord  Coord_Stab;         // -----------  ������� (���������) ���������� ���� � �� ����������������� (� ������ ������) --------------

        TTargetsCoord  IndicatorCoord;     // -----------  ������� ���������� ���� ������������ --------------
        TTargetsCoord  OldIndicatorCoord;  // -----------  ���������� ���������� ���� ������������ --------------
        AnsiString    Indicator_Name;
        bool          Indicator_Redraw;

        TMatrix3x3    tm_Fixed_Geo_Far;
        TMatrix3x3    ___Fixed_Far_Ravnosignal_DirectionalCosines;

     // --------------------------------------------------------
        TMatrix3x3 A_Eps_c;     // --- ������� ���� ����� ���� � �������������� ������� ��������� ---
        TMatrix3x3 A_Q_c;       // --- ������� ������� ���� ���������� � �������������� ������� ��������� ----------

/*        TFloat     Stab_Eps_c;   // --- ����������� ���� ����� ���� � ������� ��������� ����������������� ------
        TFloat     Stab_Q_c;     // --- ����������� ������ ���� � ������� ��������� ����������������� ----------

        TFloat     FAR_Eps_c;   // --- ����������� ���� ����� ���� � ������� ��������� FAR ------
        TFloat     FAR_Q_c;     // --- ����������� ������ ���� � ������� ��������� FAR ----------
        TFloat     FAR_Clear_Eps_c;   // --- ����������� ���� ����� ���� � ������� ��������� FAR ------
        TFloat     FAR_Clear_Q_c;     // --- ����������� ������ ���� � ������� ��������� FAR ----------
  */

        TFloat     Luch_Eps_c;  // --- ����������� ���� ����� ���� � ������� ��������� Luch� -----------------
        TFloat     Luch_Q_c;    // --- ����������� ������ ���� � ������� ��������� Luch� ----------

     // --------------------------------------------------------
        TFloat SkoShum1;   // ---- ��� ������������������ ��������� ���� ------
        TFloat SkoShum2;   // ---- ��� ������������������ ��������� ���� ------

     // --------------------------------------------------------
        int        CountZondImpulses;
        bool       Radiation, Radiation1, Radiation2;
        bool       Enabled; /// ------  �������� �� �� ���� ����������� ��������� ------
        TFloat     SectorCoef; // --------- � ����� ����� ������� � �������� ----------
     // --------------------------------------------------------


        void     Init();
        void     Move();
        void     CalcRadiationValue();
        void     CalcPosition();
         TTarget(TFarParam * apFarParam);
        ~TTarget();
};
//===========================================================================
#endif
