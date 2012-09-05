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
     TFloat     Betta;            // ---- Угол места луча ()
     TFloat     Alfa;             // ---- Азимут места луча --------
     TFloat     f;                // ---- Частота на которой работает луч --------
     TFloat     FiBetta;          // ---- Фазовое смещение по азимуму --------
     TFloat     FiAlfa;           // ---- Фазовое смещение по углу места ---------
     TFloat     kH;               // ---- Коеэф. расширения диагрмы по азимуту -------
     TFloat     kW;               // ---- Коеэф. расширения диагрмы по углу места -------

     void SetBettaAlfa(TFloat aAlfa, TFloat aBetta)
     // ------- 0. процедура расчитывает ,по заданым значениям альфа и бетта ---------
     // ------- 1. частоту на которой работае Луч -------
     // ------- 2. Фазовые значения смещение по углу места и азимуту --------
     // ------- 3. Коэфициенты ширин диаграммы ----------
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
         TFarParam *fpFarParam;           // --- Параметры ФАР ---------

       // --------------
         TFloat     fOffsetX, fOffsetY;   // --- Смещение луча относительно "Нуля" -------

       // --------------

/*        int        fCenterPos;
        int        fCountPointDiagram;
        int        fCountEllipsePoint;

       // -------------------------
        TDiagramForm    fDiagramForm;
        TDiagramType    fDiagramType;

        TFloat          fCutLevel;               // ---- Уровень среза ------
        TFloat          fDetectorCutLevel;       // ---- Порог обнаружителя ------
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

        TTwoFloat  *EllipseArray;         // --- Еллипс соответствующий уровню среза луча с СК ФАР
        TMatrix3x3  DirectionalCosines;
        TFloat      Teta, Fi;              // --- Текущие углы отклонения луча от нормали ----------

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
