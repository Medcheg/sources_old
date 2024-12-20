//=============================================================================
//=============================================================================
//== ����������� ��� ��������������� ���� ������ ���� ����������� �������� ====
//=============================================================================
//=============================================================================
#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_Absolute.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TAbsolute_Init() { RegisterElement("DiALab - �������", "���. ��������", (int)&TAbsolute::Create); }
#pragma startup TAbsolute_Init 110 // default 100
//===========================================================================
TAbsolute::TAbsolute()
{
  // --------- ��������� ������ ���� �� ���� ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "������";
     Note        = "y = | x |";
     CreateDate  = "12.01.2005";

  // ---------
     DesignPhase = dpAllreadyTesting;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
}

//===========================================================================
void TAbsolute::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void TAbsolute::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void TAbsolute::DrawElementFace()
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
void TAbsolute::Edit()
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
void TAbsolute::Copy(void *aElement) { TElement::Copy(aElement);
}

//===========================================================================
void TAbsolute::Init() { TElement::Init();
}

//===========================================================================
void TAbsolute::InitBeforeRun()
{
       iQueue = (iPoints->Items[0]->Queue) ? iPoints->Items[0]->Queue : &ZerroValue;
       oQueue = oPoints->Items[0]->Queue;
}

//===========================================================================
void TAbsolute::Run() { if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      oQueue[0] = fabs(iQueue[0]);
   // --------------
}


