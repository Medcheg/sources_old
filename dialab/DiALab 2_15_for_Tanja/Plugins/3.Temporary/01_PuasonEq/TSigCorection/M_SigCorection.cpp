//===========================================================================
//===========================================================================
//== ����������� ��� ��������������� ���� ������ ���� ����������� �������� ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop
#include "Math.hpp"
#include "Math.h"

#include "M_SigCorection.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TSigCorection_Init() { RegisterElement("DiALab - ��������", "���.�����.��������", (int)&TSigCorection::Create); }
#pragma startup TSigCorection_Init // default 100
//===========================================================================
TSigCorection::TSigCorection()
{
  // --------- ��������� ������ ���� �� ���� ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "������������ �������� ���������";
     Note        = "������������ �������� ���������";
     CreateDate  = "21.11.2005";
     ShowCaption = false;

  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 36;
     VisualElementParam->Height = 2 * 16;
  // ---------
     Ka  = 0.01;
     Kg1 = 0.001;
     Kg2 = 0.001;

     iPoints->Add("Ax0");
     iPoints->Add("Ay0");
     iPoints->Add("Az0");

     iPoints->Add("Hx0");
     iPoints->Add("Hy0");
     iPoints->Add("Hz0");

     iPoints->Add("c11");
     iPoints->Add("c12");
     iPoints->Add("c13");
     iPoints->Add("c21");
     iPoints->Add("c22");
     iPoints->Add("c23");
     iPoints->Add("a31");
     iPoints->Add("c32");
     iPoints->Add("c33");

     iPoints->Add("Psi");
     iPoints->Add("Teta");
     iPoints->Add("Gamma");

     oPoints->Add("wxo_k");
     oPoints->Add("wyo_k");
     oPoints->Add("wzo_k");
  // ---------
}

//===========================================================================
void TSigCorection::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TSigCorection::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TSigCorection::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width ;
      int         ah       = VisualElementParam->Height;
      AnsiString  as       = "A B";

      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;

      dbCanvas->Rectangle(0, 0, aw, ah);

   // --------- ��������� �������������� --- (������������� �������� ����������) -----
     if (DesignPhase != dpAllreadyTesting) {
         if (DesignPhase == dpNotTesting  ) {dbCanvas->Pen  ->Color = clRed;}
         if (DesignPhase == dpNeedModified) {dbCanvas->Pen  ->Color = clRed; dbCanvas->Pen  ->Style = psDot;}

         dbCanvas->Rectangle(2, 2, VisualElementParam->Width - 2, VisualElementParam->Height - 2);

         dbCanvas->Pen->Color = clBlack;
         dbCanvas->Pen->Style = psSolid;
      }

      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2, (ah - dbCanvas->TextHeight(as))/2, as);
      dbCanvas->Ellipse(aw / 2 - 1, ah / 2 - 1, aw / 2 + 1, ah / 2 + 1);
}

//===========================================================================
void TSigCorection::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ParameteresCount       = 0;
     // ------
        dlg->ShowModal();
     // ------
   } __finally { delete dlg; }
}


//===========================================================================
void TSigCorection::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TSigCorection::InitBeforeRun()
{
};

//===========================================================================
void TSigCorection::Init() { TElement::Init();
}

//===========================================================================
void TSigCorection::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------

       Axo   = iPoints->Items[0]->Queue[0];
       Ayo   = iPoints->Items[1]->Queue[0];
       Azo   = iPoints->Items[2]->Queue[0];

    // ----------
       Hxo = iPoints->Items[3]->Queue[0];
       Hyo = iPoints->Items[4]->Queue[0];
       Hzo = iPoints->Items[5]->Queue[0];
    // ----------
       c[0][0] = iPoints->Items[6]->Queue[0];
       c[0][1] = iPoints->Items[7]->Queue[0];
       c[0][2] = iPoints->Items[8]->Queue[0];
       c[1][0] = iPoints->Items[9]->Queue[0];
       c[1][1] = iPoints->Items[10]->Queue[0];
       c[1][2] = iPoints->Items[11]->Queue[0];
       c[2][0] = iPoints->Items[12]->Queue[0];
       c[2][1] = iPoints->Items[13]->Queue[0];
       c[2][2] = iPoints->Items[14]->Queue[0];
    // ----------
       psi   = iPoints->Items[15]->Queue[0];
       teta  = iPoints->Items[16]->Queue[0];
       gamma = iPoints->Items[17]->Queue[0];
   // --------
       TFloat Hx1 = cos(gamma) * Hxo + sin(gamma)*Hzo;
       TFloat Hy1 = sin(gamma)*sin(teta) * Hxo + cos(teta)*Hyo - cos(gamma)*sin(teta)*Hzo;
       TFloat PsiMag;

   // ----- ��������� ����������� ----
/*       if (Hy1 < 0) PsiMag = -atan(Hx1/Hy1) + M_PI;
          else if (Hx1 < 0) PsiMag = -atan(Hx1/Hy1);
              else PsiMag = -atan(Hx1/Hy1) + 2*M_PI;*/

/*      bool aTanFlag = true;
      if (Hx1 == 0 && Hy1 == 0)  {PsiMag =  0; aTanFlag = false; } /// --- �������������� �������� ---

      if (Hx1 >  0 && Hy1 == 0)  {PsiMag = 0;            aTanFlag = false; }
      if (Hx1 <  0 && Hy1 == 0)  {PsiMag = pi;           aTanFlag = false; }
      if (Hx1 == 0 && Hy1 >  0)  {PsiMag = pi_div_2;     aTanFlag = false; }
      if (Hx1 == 0 && Hy1 <  0)  {PsiMag = tri_pi_div_2; aTanFlag = false; }

      if (aTanFlag) {
            PsiMag =  atan(fabs(Hx1 / Hy1));

            if (Hx1 > 0 && Hy1 > 0)  PsiMag =          PsiMag;
            if (Hx1 > 0 && Hy1 < 0)  PsiMag = two_pi - PsiMag;
            if (Hx1 < 0 && Hy1 < 0)  PsiMag = pi     + PsiMag;
            if (Hx1 < 0 && Hy1 > 0)  PsiMag = pi     - PsiMag;
      } else
        Beep();*/

//      PsiMag =  -atan(Hx1 / Hy1);
      PsiMag =  -Math::ArcTan2(Hx1 , Hy1);

//       PsiMag = -PsiMag;

       wcy =-Kg2 * (c[0][0]*Axo + c[0][1]*Ayo + c[0][2]*Azo);
       wcx = Kg1 * (c[1][0]*Axo + c[1][1]*Ayo + c[1][2]*Azo);
       wcz = Ka  * (cos(PsiMag)*c[0][1] - sin(PsiMag)*c[1][1]);

   // ---- ���������������� ������� "�" :) -----------
        for (int i = 0; i < 3; i++)
               for (int j = 0; j < 3; j++)
                     b[i][j] = c[j][i];
   // ------------------------------------------------
       oPoints->Items[0]->Queue[0] = b[0][0]*wcx + b[0][1]*wcy + b[0][2]*wcz;
       oPoints->Items[1]->Queue[0] = b[1][0]*wcx + b[1][1]*wcy + b[1][2]*wcz;
       oPoints->Items[2]->Queue[0] = b[2][0]*wcx + b[2][1]*wcy + b[2][2]*wcz;
}

