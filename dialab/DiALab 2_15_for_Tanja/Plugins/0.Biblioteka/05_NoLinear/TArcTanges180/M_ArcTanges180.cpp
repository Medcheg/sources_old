//=============================================================================
//=============================================================================
//== ����������� ��� ��������������� ���� ������ ���� ����������� �������� ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#include "Math.hpp"
#pragma hdrstop

#include "Unit_BaseDialog_01.h"
#include "M_ArcTanges180.h"
//===========================================================================
void TArcTanges180_Init() { RegisterElement("DiALab - �������", "�������������", (int)&TArcTanges180::Create); }
#pragma startup TArcTanges180_Init 110 // default 100
//===========================================================================
TArcTanges180::TArcTanges180()
{
  // --------- ��������� ������ ���� �� ���� ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "��������� (-pi...+pi)";
     Note        = "����� = ArcTan( y / x )";
     CreateDate  = "13.01.2005";
  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x");
     iPoints->Add("y");
     oPoints->Add("�����");
}

//===========================================================================
void TArcTanges180::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TArcTanges180::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TArcTanges180::DrawElementFace()
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
void TArcTanges180::Edit()
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
void TArcTanges180::Copy(void *aElement) { TElement::Copy(aElement);
}

//===========================================================================
void TArcTanges180::Init() { TElement::Init();
}

//===========================================================================
void TArcTanges180::InitBeforeRun()
{
   iQueue1 = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
   iQueue2 = (iPoints->Items[1]->Queue) ? iPoints->Items[1]->Queue : &ZerroValue;
   oQueue   = oPoints->Items[0]->Queue;
}

//===========================================================================
void TArcTanges180::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      oQueue[0] = Math::ArcTan2(iQueue1[0], iQueue2[0]);
}

