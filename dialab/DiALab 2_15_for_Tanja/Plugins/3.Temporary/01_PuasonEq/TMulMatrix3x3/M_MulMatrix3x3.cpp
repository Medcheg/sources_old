//===========================================================================
//===========================================================================
//== ����������� ��� ��������������� ���� ������ ���� ����������� �������� ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "Math.hpp"
#pragma hdrstop

#include "M_MulMatrix3x3.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TMulMatrix3x3_Init() { RegisterElement("DiALab - ��������", "���.�����.��������", (int)&TMulMatrix3x3::Create); }
#pragma startup TMulMatrix3x3_Init // default 100
//===========================================================================
TMulMatrix3x3::TMulMatrix3x3()
{
  // --------- ��������� ������ ���� �� ���� ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "������������ ������";
     Note        = "������������ ������ ������������ 3�3";
     CreateDate  = "01.12.2004";
     ShowCaption = false;

  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 36;
     VisualElementParam->Height = 2 * 16;

     iPoints->Add("a11");
     iPoints->Add("a12");
     iPoints->Add("a13");
     iPoints->Add("a21");
     iPoints->Add("a22");
     iPoints->Add("a23");
     iPoints->Add("a31");
     iPoints->Add("a32");
     iPoints->Add("a33");

     iPoints->Add("b11");
     iPoints->Add("b12");
     iPoints->Add("b13");
     iPoints->Add("b21");
     iPoints->Add("b22");
     iPoints->Add("b23");
     iPoints->Add("b31");
     iPoints->Add("b32");
     iPoints->Add("b33");

     oPoints->Add("c11");
     oPoints->Add("c12");
     oPoints->Add("c13");
     oPoints->Add("c21");
     oPoints->Add("c22");
     oPoints->Add("c23");
     oPoints->Add("c31");
     oPoints->Add("c32");
     oPoints->Add("c33");
  // ---------
}

//===========================================================================
void TMulMatrix3x3::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TMulMatrix3x3::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TMulMatrix3x3::DrawElementFace()
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
void TMulMatrix3x3::Edit()
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
void TMulMatrix3x3::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TMulMatrix3x3::Init() { TElement::Init();
}

//===========================================================================
void TMulMatrix3x3::InitBeforeRun() {
       a[0][0] = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
       a[0][1] = (iPoints->Items[1]->Queue) ? iPoints->Items[1]->Queue : &ZerroValue;
       a[0][2] = (iPoints->Items[2]->Queue) ? iPoints->Items[2]->Queue : &ZerroValue;
       a[1][0] = (iPoints->Items[3]->Queue) ? iPoints->Items[3]->Queue : &ZerroValue;
       a[1][1] = (iPoints->Items[4]->Queue) ? iPoints->Items[4]->Queue : &ZerroValue;
       a[1][2] = (iPoints->Items[5]->Queue) ? iPoints->Items[5]->Queue : &ZerroValue;
       a[2][0] = (iPoints->Items[6]->Queue) ? iPoints->Items[6]->Queue : &ZerroValue;
       a[2][1] = (iPoints->Items[7]->Queue) ? iPoints->Items[7]->Queue : &ZerroValue;
       a[2][2] = (iPoints->Items[8]->Queue) ? iPoints->Items[8]->Queue : &ZerroValue;

       b[0][0] = (iPoints->Items[ 9]->Queue) ? iPoints->Items[ 9]->Queue : &ZerroValue;
       b[0][1] = (iPoints->Items[10]->Queue) ? iPoints->Items[10]->Queue : &ZerroValue;
       b[0][2] = (iPoints->Items[11]->Queue) ? iPoints->Items[11]->Queue : &ZerroValue;
       b[1][0] = (iPoints->Items[12]->Queue) ? iPoints->Items[12]->Queue : &ZerroValue;
       b[1][1] = (iPoints->Items[13]->Queue) ? iPoints->Items[13]->Queue : &ZerroValue;
       b[1][2] = (iPoints->Items[14]->Queue) ? iPoints->Items[14]->Queue : &ZerroValue;
       b[2][0] = (iPoints->Items[15]->Queue) ? iPoints->Items[15]->Queue : &ZerroValue;
       b[2][1] = (iPoints->Items[16]->Queue) ? iPoints->Items[16]->Queue : &ZerroValue;
       b[2][2] = (iPoints->Items[17]->Queue) ? iPoints->Items[17]->Queue : &ZerroValue;

       c[0][0] = oPoints->Items[0]->Queue;
       c[0][1] = oPoints->Items[1]->Queue;
       c[0][2] = oPoints->Items[2]->Queue;
       c[1][0] = oPoints->Items[3]->Queue;
       c[1][1] = oPoints->Items[4]->Queue;
       c[1][2] = oPoints->Items[5]->Queue;
       c[2][0] = oPoints->Items[6]->Queue;
       c[2][1] = oPoints->Items[7]->Queue;
       c[2][2] = oPoints->Items[8]->Queue;
};

//===========================================================================
void TMulMatrix3x3::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      *c[0][0] = *a[0][0] * *b[0][0] + *a[0][1] * *b[1][0] + *a[0][2] * *b[2][0];
      *c[0][1] = *a[0][0] * *b[0][1] + *a[0][1] * *b[1][1] + *a[0][2] * *b[2][1];
      *c[0][2] = *a[0][0] * *b[0][2] + *a[0][1] * *b[1][2] + *a[0][2] * *b[2][2];

      *c[1][0] = *a[1][0] * *b[0][0] + *a[1][1] * *b[1][0] + *a[1][2] * *b[2][0];
      *c[1][1] = *a[1][0] * *b[0][1] + *a[1][1] * *b[1][1] + *a[1][2] * *b[2][1];
      *c[1][2] = *a[1][0] * *b[0][2] + *a[1][1] * *b[1][2] + *a[1][2] * *b[2][2];

      *c[2][0] = *a[2][0] * *b[0][0] + *a[2][1] * *b[1][0] + *a[2][2] * *b[2][0];
      *c[2][1] = *a[2][0] * *b[0][1] + *a[2][1] * *b[1][1] + *a[2][2] * *b[2][1];
      *c[2][2] = *a[2][0] * *b[0][2] + *a[2][1] * *b[1][2] + *a[2][2] * *b[2][2];

/*   for (int i = 0; i < 3; i++)
             for (int j = 0; j < 3; j++){
                   TFloat CollumSum = 0;
                   for (int k = 0; k < 3; k++)
                     CollumSum = CollumSum + a[i][k][0] * b[k][j][0];

                    c[i][j][0] = CollumSum;
             }*/
   // --------------
}

