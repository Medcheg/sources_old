//=============================================================================
//=============================================================================
//== ����������� ��� ��������������� ���� ������ ���� ����������� �������� ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "math.hpp"
#include "math.h"
#pragma hdrstop

#include "M_ArcCosinus.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TArcCosinus_Init() { RegisterElement("DiALab - �������", "�������������", (int)&TArcCosinus::Create); }
#pragma startup TArcCosinus_Init 110 // default 100
//===========================================================================
TArcCosinus::TArcCosinus()
{
  // --------- ��������� ������ ���� �� ���� ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "����������";
     Note        = "y = ArcCos( x )";
     CreateDate  = "12.01.2005";
   // --------------
     DesignPhase = dpNeedModified;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x");
     oPoints->Add("y");
  // ---------
}

//===========================================================================
void TArcCosinus::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TArcCosinus::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TArcCosinus::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
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
   // -------------- ��������� ������� ���� �� ���� ----------
      dbCanvas->Draw((aw - ResourseBitmapFaceElement->Width) / 2, (ah - ResourseBitmapFaceElement->Height) / 2,ResourseBitmapFaceElement);
}

//===========================================================================
void TArcCosinus::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ParameteresCount       = 0;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TArcCosinus::Copy(void *aElement) { TElement::Copy(aElement);
}

//===========================================================================
void TArcCosinus::Init() { TElement::Init();
}

//===========================================================================
void TArcCosinus::InitBeforeRun()
{
   iQueue = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
   oQueue = oPoints->Items[0]->Queue;
}

//===========================================================================
void TArcCosinus::Run() { if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      oQueue[0] = Math::ArcTan2(sqrt(fabs(1-iQueue[0]*iQueue[0])), iQueue[0]);
   // --------------
}

