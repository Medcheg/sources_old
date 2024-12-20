//===========================================================================
//===========================================================================
//== ����������� ��� ��������������� ���� ������ ���� ����������� �������� ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "Math.hpp"
#include "Math.h"
#include "M_TransromXYZ_RoQE.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TTransromXYZ_RoQE_Init() { RegisterElement("DiALab - ��������������", "���������������", (int)&TTransromXYZ_RoQE::Create); }
#pragma startup TTransromXYZ_RoQE_Init // default 100
//===========================================================================
TTransromXYZ_RoQE::TTransromXYZ_RoQE()
{
  // --------- ��������� ������ ���� �� ���� ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

//     WhoUseProgram = wupTanjaKvant;
  // ---------
     DefaultName = "XYZ -> RoBetaEps";
     Note        = "������� �� ������� ��������� XYZ ->";
     CreateDate  = "01.12.2004";

  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;

     iPoints->Add("x");
     iPoints->Add("y");
     iPoints->Add("z");

     oPoints->Add("Ro");
     oPoints->Add("Beta");
     oPoints->Add("Eps");
  // ---------
}

//===========================================================================
void TTransromXYZ_RoQE::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    //aStream->Read(&TransromXYZ_RoQE, sizeof(TransromXYZ_RoQE));
}

//===========================================================================
void TTransromXYZ_RoQE::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    //aStream->Write(&TransromXYZ_RoQE, sizeof(TransromXYZ_RoQE));
}

//===========================================================================
void TTransromXYZ_RoQE::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width ;
      int         ah       = VisualElementParam->Height;

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

      dbCanvas->MoveTo(5, 2     );   dbCanvas->LineTo(5, ah - 2);
      dbCanvas->MoveTo(2, ah - 5);   dbCanvas->LineTo(aw - 2, ah - 5);

      dbCanvas->Pen->Color = clBlue;
      dbCanvas->MoveTo(8, ah - 10);   dbCanvas->LineTo(aw - 4, 6);

      dbCanvas->Pen->Color = clBlack;
}

//===========================================================================
void TTransromXYZ_RoQE::Init() { TElement::Init();
}


//===========================================================================
void TTransromXYZ_RoQE::Edit()
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
void TTransromXYZ_RoQE::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TTransromXYZ_RoQE::InitBeforeRun()
{
   iQueue1 = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
   iQueue2 = (iPoints->Items[1]->Queue) ? iPoints->Items[1]->Queue : &ZerroValue;
   iQueue3 = (iPoints->Items[2]->Queue) ? iPoints->Items[2]->Queue : &ZerroValue;
   oQueue1 =  oPoints->Items[0]->Queue;
   oQueue2 =  oPoints->Items[1]->Queue;
   oQueue3 =  oPoints->Items[2]->Queue;
};

//===========================================================================
void TTransromXYZ_RoQE::Run() { if (!isEnabledCalc()) return; TElement::Run();
   // --------------

      oQueue1[0] = sqrt(iQueue1[0]*iQueue1[0] + iQueue2[0]*iQueue2[0] + iQueue3[0]*iQueue3[0]);
      oQueue2[0] = Math::ArcTan2(iQueue2[0], iQueue1[0]);

      if (oQueue1[0] != 0 ) oQueue3[0] = Math::ArcSin(iQueue3[0] / oQueue1[0]); else oQueue3[0] = 0;
}

