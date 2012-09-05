//---------------------------------------------------------------------------
#ifndef mpiDiagramH
#define mpiDiagramH
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include "mpiMatrix.h"
//---------------------------------------------------------------------------
enum TDiagramPosition {dpCenter, dpTop, dpBottom, dpTopLeft, dpTopRight, dpBottomLeft, dpBottomRight};

class TDiagram{
private:
/*
typedef struct TBeam{
     TFloat     Betta;            // ---- ���� ����� ���� ()
     TFloat     Alfa;             // ---- ������ ����� ���� --------
     TFloat     f;                // ---- ������� �� ������� �������� ��� --------
     TFloat     FiBetta;          // ---- ������� �������� �� ������� --------
     TFloat     FiAlfa;           // ---- ������� �������� �� ���� ����� ---------
     TFloat     kH;               // ---- �����. ���������� ������� �� ������� -------
     TFloat     kW;               // ---- �����. ���������� ������� �� ���� ����� -------

     void SetBettaAlfa(TFloat aAlfa, TFloat aBetta)
     // ------- 0. ��������� ����������� ,�� ������� ��������� ����� � ����� ---------
     // ------- 1. ������� �� ������� ������� ��� -------
     // ------- 2. ������� �������� �������� �� ���� ����� � ������� --------
     // ------- 3. ����������� ����� ��������� ----------
     {
        Alfa    = aAlfa;
        Betta   = aBetta;
        f       = 1000.0;
        FiBetta = 0.10;
        FiAlfa  = 0.10;
        kH      = 1.6;
        kW      = 1.4;
     };
}TBeam;
*/
       // --------------
         TFarParam *fpFarParam;           // --- ��������� ��� ---------

       // --------------
         TFloat     fOffsetX, fOffsetY;   // --- �������� ���� ������������ "����" -------

       // --------------

/*        int        fCenterPos;
        int        fCountPointDiagram;
        int        fCountEllipsePoint;

       // -------------------------
        TDiagramForm    fDiagramForm;
        TDiagramType    fDiagramType;

        TFloat          fCutLevel;               // ---- ������� ����� ------
        TFloat          fDetectorCutLevel;       // ---- ����� ������������ ------
       // -------------------------
        TFloat          fIdealShirH;
        TFloat          fIdealShirV;
        TFloat          fIdealDetectorShirH;
        TFloat          fIdealDetectorShirV;
       // -------------------------
        TDiagramPoint   *fHValues;
        TDiagramPoint   *fVValues;
        TTwoFloat       *fIdeal_EllipseArray;
        TTwoFloat       *fIdeal_DetectorEllipseArray;

        void Calc_Diagram();
        void Calc_EllipseArray();
        void Calc_DetectorEllipseArray();

       // -------------------------

        TDiagramPoint __fastcall Get_HValues(int index);
        TDiagramPoint __fastcall Get_VValues(int index);
        TTwoFloat     __fastcall Get_Ideal_EllipseArray(int index);
        TTwoFloat     __fastcall Get_Ideal_DetectorEllipseArray(int index);*/
        TDiagramPosition fDiagramPosition;

public:
        TFloat eMinAzimOffset;
        TFloat eMaxAzimOffset;
        TFloat eMinEpsOffset;
        TFloat eMaxEpsOffset;

        TTwoFloat  *EllipseArray;         // --- ������ ��������������� ������ ����� ���� � �� ���
        TMatrix3x3  DirectionalCosines;
        TFloat      Teta, Fi;              // --- ������� ���� ���������� ���� �� ������� ----------

          TFloat Get_RelayValue(TFloat aValue);
          TDiagram(TFarParam *apFarParam, TDiagramPosition aDiagramPosition);
         ~TDiagram();
          void Init();

         __property TFloat OffsetX = { read = fOffsetX };
         __property TFloat OffsetY = { read = fOffsetY };

/*        __property TDiagramPoint HValues                [int index]  = { read=Get_HValues                    };
        __property TDiagramPoint VValues                [int index]  = { read=Get_VValues                    };
        __property TTwoFloat Ideal_EllipseArray         [int index]  = { read=Get_Ideal_EllipseArray         };
        __property TTwoFloat Ideal_DetectorEllipseArray [int index]  = { read=Get_Ideal_DetectorEllipseArray };

        __property int CountPointDiagram   = { read=fCountPointDiagram};
        __property int CountEllipsePoint   = { read=fCountEllipsePoint};*/
        //TFloat RadiationValue;

        void   Calc_CutEllipse(TFloat aDeltaQ, TFloat aDeltaAlfa);
        TFloat Get_SignalStrength(TFloat aHorizOffset, TFloat aVertOffset);
};

extern const int CountEllipsePoint;
extern void ReCreateDiagrams(int aDiagram_Count);
extern void Destroy_Diagrams();

//---------------------------------------------------------------------------
#endif
