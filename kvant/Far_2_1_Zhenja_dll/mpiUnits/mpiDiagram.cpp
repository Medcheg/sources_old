//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiDiagram.h"
#include "Math.h"
#include <Math.hpp>
#include "mpiDeclaration.h"
//#include "Unit_Main.h"

//===========================================================================

#pragma package(smart_init)

int const CountEllipsePoint = 48;
// =============================================================================
// ===========================    Calc Teta Fi      ============================
// ==============================================================================
void Calc_DeltaQ_DeltaAlfa_Teta_Fi(TFloat aDeltaQ, TFloat aDeltaAlfa, TFloat &aTeta, TFloat &aFi)
{
  TFloat aq = aDeltaQ;
  TFloat aa = aDeltaAlfa;

  aTeta = _ArcCos_(cos(aa)*cos(aq));
  aFi   = Math::ArcTan2(sin(aa), cos(aa)*sin(aq));
/*  aTeta = _ArcCos_(cos(aDeltaAlfa)*cos(aDeltaQ));
  aFi   = aDeltaAlfa;*/
}
// =============================================================================
// ===========================    Calc DeltaQ DeltaAlfa     ====================
//==============================================================================
void Calc_Teta_Fi_DeltaQ_DeltaAlfa(TFloat aTeta, TFloat aFi, TFloat &aDeltaQ, TFloat &aDeltaAlfa)
{
  TFloat at = aTeta;
  TFloat af = aFi;

  aDeltaQ    = Math::ArcTan2(cos(af), cos(at));
  aDeltaAlfa = Math::ArcTan2(sin(af)*cos(aDeltaQ), cos(at));

/*  aDeltaQ    = _ArcCos_(cos(aTeta)/cos(aFi));
  aDeltaAlfa = aFi;*/
}

// =============================================================================
// ========================    Расчет углов по направляющемым косинусам  =======
//==============================================================================
void Calc_Angle(TMatrix3x3 &aVector, TFloat &OutX, TFloat &OutY)
{
   OutX = - Math::ArcTan2(aVector.cell[1][0], aVector.cell[0][0]);
   OutY =   _ArcSin_(aVector.cell[2][0]);
   //OutY =   Math::ArcTan2(aVector.cell[2][0], sqrt(fabs(1 - aVector.cell[2][0]*aVector.cell[2][0])));
}

//===========================================================================
void ReCreateDiagrams(int aDiagram_Count)
{
  if (aDiagram_Count != 4 && aDiagram_Count != 1) return;

    if (DiagramArray != NULL) Destroy_Diagrams();

    Diagram_Count = aDiagram_Count;
    DiagramArray = (TDiagram**) malloc (sizeof(TDiagram*) * (Diagram_Count));

 // ---------------------
    if (aDiagram_Count == 4){
             DiagramArray[0] = new TDiagram(&FarParam, dpTopLeft);
             DiagramArray[1] = new TDiagram(&FarParam, dpTopRight);
             DiagramArray[2] = new TDiagram(&FarParam, dpBottomLeft);
             DiagramArray[3] = new TDiagram(&FarParam, dpBottomRight);
    }

    if (aDiagram_Count == 1){
             DiagramArray[0] = new TDiagram(&FarParam, dpCenter);
    }
}

//===========================================================================
void Destroy_Diagrams()
{
   OldDiagram_Count = Diagram_Count;
   
   if (DiagramArray != NULL){
        for (int i = 0; i < Diagram_Count; i++) delete DiagramArray[i];

        free (DiagramArray); DiagramArray = NULL;
        Diagram_Count = 0;
   }
}

//===========================================================================
TDiagram::TDiagram(TFarParam *apFarParam, TDiagramPosition aDiagramPosition)
{
     fpFarParam       = apFarParam;
     fDiagramPosition = aDiagramPosition;

   // ---------- Память под отображаемый уровень среза еллипса ---------
     EllipseArray = NULL;
     EllipseArray = (TTwoFloat*) malloc(sizeof(TTwoFloat) * (CountEllipsePoint + 1));

   // --------
     Init();
}

//===========================================================================
TDiagram::~TDiagram()
{
   if (EllipseArray != NULL) free (EllipseArray);
}

void TDiagram::Init()
{
   fOffsetX = -999;
   fOffsetY = -999;

   if (fDiagramPosition == dpCenter ) { fOffsetX =  fOffsetY =  0;}
   if (fDiagramPosition == dpTop    ) { fOffsetX =  fpFarParam->Diagram.Shir / 2.0; fOffsetY =  fpFarParam->Diagram.Shir / 2.0; }
   if (fDiagramPosition == dpBottom ) { fOffsetX = -fpFarParam->Diagram.Shir / 2.0; fOffsetY = -fpFarParam->Diagram.Shir / 2.0; }

   if (fDiagramPosition == dpTopLeft    ) { fOffsetX = -fpFarParam->Diagram.Shir * *fpFarParam->Diagram.KoefPlacingDiagram / 2.0; fOffsetY =  fpFarParam->Diagram.Shir * *fpFarParam->Diagram.KoefPlacingDiagram / 2.0; }
   if (fDiagramPosition == dpTopRight   ) { fOffsetX =  fpFarParam->Diagram.Shir * *fpFarParam->Diagram.KoefPlacingDiagram / 2.0; fOffsetY =  fpFarParam->Diagram.Shir * *fpFarParam->Diagram.KoefPlacingDiagram / 2.0; }
   if (fDiagramPosition == dpBottomLeft ) { fOffsetX = -fpFarParam->Diagram.Shir * *fpFarParam->Diagram.KoefPlacingDiagram / 2.0; fOffsetY = -fpFarParam->Diagram.Shir * *fpFarParam->Diagram.KoefPlacingDiagram / 2.0; }
   if (fDiagramPosition == dpBottomRight) { fOffsetX =  fpFarParam->Diagram.Shir * *fpFarParam->Diagram.KoefPlacingDiagram / 2.0; fOffsetY = -fpFarParam->Diagram.Shir * *fpFarParam->Diagram.KoefPlacingDiagram / 2.0; }

  // ------------
   EllipseArray[0].x = -999;
   EllipseArray[0].y = -999;
  // ------------

   DirectionalCosines.cell[1][0] = Ravnosignal_DirectionalCosines.cell[1][0] + sin(fOffsetX);
   DirectionalCosines.cell[2][0] = Ravnosignal_DirectionalCosines.cell[2][0] + sin(fOffsetY);
   DirectionalCosines.cell[0][0] = sqrt(fabs(1 - sqr(DirectionalCosines.cell[1][0]) - sqr(DirectionalCosines.cell[2][0])));

 // --------- Положение цели в системе координат ФАР ---------
   TFloat aQ, aE;
   Calc_Angle(DirectionalCosines, aQ, aE);

   Calc_DeltaQ_DeltaAlfa_Teta_Fi(aQ, aE, Teta, Fi);
}


/*TTwoFloat TFarDiagram::GetSignalValueTarget_Butyrin(TFloat aQc, TFloat aEps)
{
  TTwoFloat Result;   Result.x = 0;   Result.y = 0;
  TFloat    a, b, x0, y0, Alfa, x, ka;
  int       ind1, indCentr, ind2;

   a  = fDetectorShirH/2;
   b  = fDetectorShirV/2;
//   a  = fShirH/2;
//   b  = fShirV/2;
   x0 = aQc;
   y0 = aEps;
   Alfa = atan(y0/x0*a/b);
   x    = a*cos(Alfa);
   ka   = x0/x;
   Result.y = fabs(sin(2.7831*ka/2)/(2.7831*ka/2.0));
  // ----- Расчет значеня ослабленя по горизонтальной координате  ------
   indCentr = int(aQc/fabs(fHValues[0].Offset - fHValues[1].Offset) + fabs(int(fHValues[0].Offset/(fHValues[0].Offset - fHValues[1].Offset)))) + 1;
   ind1     = indCentr - 2; if (ind1 < 0                     ) return Result;
   ind2     = indCentr + 2; if (ind2 > fCountPointDiagram - 1) return Result;
   for (int i = ind1; i <= ind2; i++)
     if (fHValues[i].Offset <= aQc && fHValues[i+1].Offset > aQc){
        Result.x = fHValues[i].Offset;
     }

   return Result;
}*/

//===========================================================================
void TDiagram::Calc_CutEllipse(TFloat aDeltaQ, TFloat aDeltaAlfa)
{
  // --------------------------------------------------------
  // ----------- Система Координат XYZ ----------------------
  // ----------- Ось X напрвлена по нормали -----------------
  // ----------- Плоскость YZ лежит в апертуре антенны ------
  // ----------- Ось Z направлена по вертикали апертуры -----
  // ----------- Ось Х направлена по гГоризонтали апертуры --
  // --------------------------------------------------------
  // ----------- По оси "Y" идет сторона "А" еллипса --------
  // ----------- По оси "Z" идет сторона "B" еллипса --------
  // --------------------------------------------------------

     TMatrix3x3 New_Vector;
     TFloat     a_sin, b_sin;

  // ---------- Реальный углом места луча -----------
      //EllipseArray[0].x = aDeltaQ + fOffsetX;
      //EllipseArray[0].y = aDeltaAlfa + fOffsetY;


      a_sin = sin(atan(fpFarParam->Diagram.Shir / 2.0));
      b_sin = sin(atan(fpFarParam->Diagram.Shir / 2.0));

      eMinAzimOffset = eMinEpsOffset =  999999999;
      eMaxAzimOffset = eMaxEpsOffset = - 999999999;

      for (int i = 0; i <= CountEllipsePoint; i ++ ){
           New_Vector.cell[1][0] = DirectionalCosines.cell[1][0] + a_sin * cos(i/(TFloat) CountEllipsePoint * Two_Pi);
           New_Vector.cell[2][0] = DirectionalCosines.cell[2][0] + b_sin * sin(i/(TFloat) CountEllipsePoint * Two_Pi);
           if (i == 0) New_Vector.cell[1][0] = DirectionalCosines.cell[1][0];


           New_Vector.cell[0][0] = sqrt(fabs(1 - sqr(New_Vector.cell[1][0]) - sqr(New_Vector.cell[2][0])));

           Calc_Angle(New_Vector, EllipseArray[i].x, EllipseArray[i].y);

           if (eMinAzimOffset > EllipseArray[i].x) eMinAzimOffset = EllipseArray[i].x;
           if (eMaxAzimOffset < EllipseArray[i].x) eMaxAzimOffset = EllipseArray[i].x;
           if (eMinEpsOffset  > EllipseArray[i].y) eMinEpsOffset  = EllipseArray[i].y;
           if (eMaxEpsOffset  < EllipseArray[i].y) eMaxEpsOffset  = EllipseArray[i].y;
      }
}

//===========================================================================
TFloat TDiagram::Get_RelayValue(TFloat aValue)
{
   if ( aValue < 0 ) return aValue;

   TFloat s1, s2;
  // ------ Вставить релеевскле распределение --------
     s1     = RandG(0,*fpFarParam->Sigma2);
     s2     = RandG(0,*fpFarParam->Sigma2);
  // ----
     aValue = sqrt(sqr(s1) + sqr(fpFarParam->fNormValue*aValue + s2));
     return aValue;
}

//===========================================================================
TFloat TDiagram::Get_SignalStrength(TFloat aHorizOffset, TFloat aVertOffset)
{
  TFloat Res = -999;

     if (fpFarParam->Diagram.Form == dfSinH_H) {
         Res = -999;

         //fVValues[i].Offset    = u * Pi_del_180;
         //fVValues[i].VoltValue = fabs(sin(2.7831*u)/(2.7831*u));   if (fDiagramType == dtActive) fValue *= fValue; // ----------- Если диаграма активная то вольтики в квадрате --------
     }
   // ------------
     if (fpFarParam->Diagram.Form == dfCos) {

         TFloat XVoltValue = cos((aHorizOffset/* - fOffsetX*/) * pi / 4.0 / (fpFarParam->Diagram.Shir / 2.0));
         TFloat YVoltValue = cos((aVertOffset /* - fOffsetY*/) * pi / 4.0 / (fpFarParam->Diagram.Shir / 2.0));

         // ------ Бутырин сказал в Пасивном режиме ослаблять cos 3/2 (x) -----------
         // ------ -------------- в Активном режиме ослаблять cos 3/4 (x) -----------

         Res = XVoltValue * YVoltValue; if (fpFarParam->Diagram.Type == dtActive) Res *= Res;

         TFloat Oslablenije = (fpFarParam->Diagram.Type != dtActive) ? Power(cos(Teta), 3.0 / 2.0) : Power(cos(Teta), 3.0 / 4.0);
         Res *= Oslablenije;
     }
   // ------------
     return Res;
}
