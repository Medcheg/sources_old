//=============================================================================
//=============================================================================
//== ����������� ��� ��������������� ���� ������ ���� ����������� �������� ====
//=============================================================================
//=============================================================================
#include <vcl.h>
#pragma hdrstop

#include "M_Proportional.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TProportional_Init() { RegisterElement("DiALab - �������", "���. ��������", (int)&TProportional::Create); }
#pragma startup TProportional_Init 110 // default 100
//===========================================================================
TProportional::TProportional()
{
  // --------- ��������� ������ ���� �� ���� ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "����������� ��������";
     Note        = "���������������� �����: y(t) = K * x(t)";
     CreateDate  = "01.12.2004";
  // ---------
     DesignPhase = dpAllreadyTesting;
  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 8;
     ShowCaption = false;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
     K     = 1;
     str_K = "";
  // ---------
}

//===========================================================================
void TProportional::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K , sizeof(K ));
}

//===========================================================================
void TProportional::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K));
}

void TProportional::Draw(TCanvas *aCanvas, int aParentId) {
    if (aParentId != ParentId || ParentId == -1) return;

    DrawElementFace();

    TElement::Draw(aCanvas, aParentId);
}

/*
    Draw_Shadow (aCanvas);
    Draw_Caption(aCanvas);
    Draw_In     (aCanvas);
    Draw_Out    (aCanvas);

    aCanvas->Draw(VisualElementParam->sLeft , VisualElementParam->sTop, VisualElementParam->Bitmap);

   // --------- ��������� �������������� --- (������������� �������� ����������) -----

    aCanvas->Brush->Color = pManagerParam->FonColor;
    Draw_InHint (aCanvas);
    Draw_OutHint(aCanvas);

//    if (SelectedParam.Selected) Draw_SelectedElement(aCanvas);   // ---- ���� ������� �������, �� ���� ������� ��������������� ������ ------

    fNeedRedraw = false;
*/

//===========================================================================
void TProportional::DrawElementFace()
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

      str_K = FloatToStr(K);
      dbCanvas->TextOut((aw - dbCanvas->TextWidth(str_K))/2, (ah - dbCanvas->TextHeight(str_K))/2, str_K);
}

//===========================================================================
void TProportional::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &K;
        dlg->LabelArray[0]->Caption = "����������� �������� :";
        dlg->ParameteresCount       = 1;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TProportional::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TProportional::Init() { TElement::Init();

}

//===========================================================================
void TProportional::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


      oPoints->Items[0]->Queue[0] = iPoints->Items[0]->Queue[0] * K;
}

