//---------------------------------------------------------------------------
#ifndef mpiFarH
#define mpiFarH
#include "mpiTypes.h"
#include "mpiMatrix.h"
#include "mpiTarget.h"


/*class TFarDiagram{
private:
        TFarParam       *fpFarParam; // ------- Параметры структуры --------
        TBeamParam      *fpBeamParam;
        TDirectionScan  *fpDirectionScan; // ------ Gde skaniruju ---------
        TFloat          *fpCurTime;               // ----- указатель на текущее время  --------

        TMatrix3x3      *fpMatrix_Geo_Far;
        TMatrix3x3      *fpClearMatrix_Geo_Far;

        TDiagramPoint   *fHValues;
        TDiagramPoint   *fVValues;

        bool            fBeginPack; // ------- Признак начала пачки --------
        bool            fEndPack;   // ------- Признак конца пачки --------

        int             fCountPointDiagram;    // ------- Количество расчитанных точек диаграммы ---------
        int             fCountEllipsePoint;    // ----- Количество точек сечения еллипса -------

        TFloat          fVoltLevel;            // ------- Уровень среза в вольтах -------
        TFloat          fDetectorVoltLevel;     // ------- Порог обнаружителя ------
        TFloat          fStepAproximationDiagrram; // ----- Шаг с которым будет расчитана диаграмма --------

        TFloat          fDetectorShirH;
        TFloat          fDetectorShirV;
        TFloat          fShirH;
        TFloat          fShirV;

        TFloat          fDeltaAlfa;
        TFloat          fDeltaQ;
        TFloat          fFreq;

        void      Calc_FormDiagram();

        TDiagramPoint __fastcall Get_HValues(int index);
        TDiagramPoint __fastcall Get_VValues(int index);
        TTwoFloat     Get_RelayValue(TTwoFloat aValue);
        bool Check_BeginPack(int aParam);
        bool Check_EndPack(int aParam);
public:
         int            id;

         TFloat         Freq;
         TFloat         MaxLuchGeoAzim, MinLuchGeoAzim;
         TFloat         MaxLuchGeoEps , MinLuchGeoEps;

         TMatrix3x3  Matrix_DeltaQ;         // --- Матрица перехода от ФАРа к Лучу --------
//         TMatrix3x3  Matrix_DeltaAlfa;      // --- Матрица перехода от ФАРа к Лучу --------
         TMatrix3x3  Cur_Matrix_DeltaAlfa;      // --- Матрица перехода от ФАРа к Лучу --------
         TFloat      Cur_Delta_Alfa;

         TMatrix3x3  Matrix_Geo_Beam;
         TMatrix3x3  ClearMatrix_Geo_Beam;

         TTwoFloat      *EllipseArray;
         TTwoFloat      *DetectorEllipseArray;
         TImpuls        *ImpulsPack;
         int            Length_ImpulsPack;


        // -------
         void      Calc_PulsePackedTarget();
         TTwoFloat GetSignalValueTarget_Tanja(TFloat aQc, TFloat aEps);
         TTwoFloat GetSignalValueTarget_Butyrin(TFloat aQc, TFloat aEps);
        // -------
         TFarDiagram(TFarParam *apFarParam,         TBeamParam     *apBeamParam,
                     int        aCountEllipsePoint, TDirectionScan *apDirectionScan,
                     TFloat    *apCurTime,          TMatrix3x3 *apMatrix_Geo_Far, TMatrix3x3 *apClearMatrix_Geo_Far);
        ~TFarDiagram();
        __property TDiagramPoint HValues[int index]  = { read=Get_HValues};
        __property TDiagramPoint VValues[int index]  = { read=Get_VValues};

        __property TFloat DeltaQ             = { read=fDeltaQ                                     };
        __property TFloat DeltaAlfa          = { read=fDeltaAlfa                                  };
        __property TFloat ShirH              = { read=fShirH            , write=fShirH            };
        __property TFloat ShirV              = { read=fShirV            , write=fShirV            };
        __property TFloat DetectorShirH      = { read=fDetectorShirH                              };
        __property TFloat DetectorShirV      = { read=fDetectorShirV                              };
        __property TFloat VoltLevel          = { read=fVoltLevel                                  };
        __property TFloat DetectorVoltLevel  = { read=fDetectorVoltLevel                          };
        __property int    CountEllipsePoint  = { read=fCountEllipsePoint, write=fCountEllipsePoint};
        __property int    CountPointDiagram  = { read=fCountPointDiagram                          };
        __property bool BeginPack            = { read = fBeginPack      , write = fBeginPack      };
        __property bool EndPack              = { read = fEndPack        , write = fEndPack        };
};
*/

class TFar{
private:
        TFarParam       *fpFarParam;              // ----- указатель на структуру Парметры ФАР антенны --------
        TFloat          *fpCurTime;               // ----- указатель на текущее время  --------

     // ---------------  Переменные индикатора ----------
        TFloat           fCurAzimFAR_Korabel;     // ------ Азимут нормали ФАР -------

        TFloat           fCurAzimFAR_Geo;      // ------- Азимут нормали ФАР
        TFloat           fCurAzimLuch_Geo;    // ------ Азимут Луча ФАР ----------

        int              fCountReview;    // ------ Коилчество обзоров ------
        bool             fStrobing;       // ------ Переменная нуная для индикатора ---------
        TFloat           fLuchDistance;   // ---- Дальность луча --------

     // ---------------
        int              fFa; // ---- Текущая частота следования импульсов ФАР

     // ---------------
        void Calc_SpeedsFAR();
        void __fastcall Set_CurAzimFAR_Korabel(TFloat value);
        void __fastcall Set_Fa (int aValue) {fFa = aValue; T0 = 1 / (TFloat)aValue; }
public:
       // ----------- Адреса параметров нужных для индикатора -------------
          TFloat       *pCurAzimFAR_Geo;   // --- Параметр для индикатора --------  Азимут нормали антенны ---------
          TFloat       *pCurAzimLuch_Geo;  // --- Параметр для индикатора --------  Азимут луча --------
          bool         *pStrobing;     // --- Параметр для индикатора --------  Надоли рисовать желтый луч -------
          TFloat       *pLuchDistance; // --- Параметр для индикатора --------  Дальность луча --------
      // -------------
          TFloat        T0;            // --- Так дисктетизации работы ФАР (--- Парметр равен 1/Fa ---) ---
      // -------------

        TFloat      DeltaAlfa, DeltaQ, Teta, Fi;
        TMatrix3x3  Ravnosignal_DirectionalCosines;

        TMatrix3x3 Matrix_Geo_Far;
        TMatrix3x3 Matrix_Clear_Geo_Far;
        TMatrix3x3 Matrix_Geo_Stab;
        TMatrix3x3 Matrix_Clear_Geo_Stab;

        TMatrix3x3 Matrix_Geo_Korabel_t;
        TMatrix3x3 ClearMatrix_Geo_Far;


         TFar (TFloat *apCurTime, TFarParam *apFarParam);
        ~TFar();
        void Init();
        void Next();
        void Calc_Beam_EllipseCoordinates(bool CalcMaxAndMin);
        void Calc_DeltaQ_DeltaAlfa_Teta_Fi(TFloat aDeltaAlfa, TFloat aDeltaQ, TFloat &aTeta, TFloat &aFi);
        void Calc_Teta_Fi_DeltaQ_DeltaAlfa(TFloat aTeta, TFloat aFi, TFloat &aDeltaQ, TFloat &aDeltaAlfa);
        void Set_DeltaQ_DeltaAlfa(TFloat aDeltaQ, TFloat aDeltaAlfa);

        __property TFarParam *FarParam            = { read = fpFarParam  , write = fpFarParam     };
        __property TFloat     CurAzimFAR_Korabel  = { read = fCurAzimFAR_Korabel , write = Set_CurAzimFAR_Korabel };
        __property int        CountReview         = { read = fCountReview                         };
        __property int        Fa                  = { read = fFa         , write = Set_Fa         };
};
//---------------------------------------------------------------------------
extern void TransformCoordinates(TMatrix3x3 &aMatrix, TFloat inX, TFloat inY, TFloat &OutX, TFloat &OutY);
extern void Calc_DirectionalCosines(TMatrix3x3 &aVector, TFloat inX, TFloat inY);
extern void Calc_Angle(TMatrix3x3 &aVector, TFloat &OutX, TFloat &OutY);


#endif

