//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации елемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "M_asd.h"
#include "Unit_BaseDialog_01.h"
//#include "Unit_BaseDialog_01.h"
#pragma package(smart_init)
//===========================================================================
Tasd::Tasd()
{
     DefaultName = "--------";
     Note        = "----------------------------------------";
     CreateDate  = "--.--.----";
  // ---------
     ShowCaption = false;
  // ---------
     VisualElementParam->Width  = 2.0 * 16;
     VisualElementParam->Height = 2.0 * 16;
  // ---------

  // --------- Добавляю один выход --------
     iPoints->Add("x");
     oPoints->Add("y");
}

//===========================================================================
Tasd::~Tasd()
{
}

//===========================================================================
void Tasd::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
}

//===========================================================================
void Tasd::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
}

//===========================================================================
void Tasd::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;
  // --------
      int w  = 0.35 * aw;
      int h  = 0.35 * ah;
      int cx = VisualElementParam->sLeft + aw / 2;
      int cy = VisualElementParam->sTop  + ah / 2;
  // --------
      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;
  // --------
      dbCanvas->Rectangle(0, 0, aw, ah);
  // --------
      dbCanvas->Ellipse(cx - w/2, cy - h/2, cx + w/2, cy + h/2);
}

//===========================================================================
void Tasd::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;

     // ------
        dlg->LabelArray[0]->Caption = "Коэффициенты сумматора";
        dlg->ValueArray[0]          = 0;
        dlg->ParameteresCount       = 1;
        dlg->BaseDialogFormStyle    = bdfsStandart;
     // ------
        dlg->ShowModal();

    // ------
   } __finally { delete dlg; }
}

//===========================================================================
void Tasd::Init()
{
  // -------- Обязательно выставляем размер очереди ------
     Order = 1;
}

//===========================================================================
void   Tasd::Draw(TCanvas *aCanvas, int aParentId) { TElement::Draw(aCanvas, aParentId);
}


//===========================================================================
void Tasd::Run() { TElement::Run();
/*    TFloat *oQueue = oPoints->Items[0]->Queue;
    TFloat *iQueue;
    TFloat  aSum   = 0;

    for (int i = 0; i < iPoints->Items_Count; i ++){
         iQueue = iPoints->Items[i]->Queue;

        // ---- Если входа нет , то он равен 0 ------
         TFloat CurrentInputValue = (iQueue == NULL)? 0 : iQueue[0];

         aSum += Formula[i] * CurrentInputValue;
    }

    oQueue[0] = aSum;*/
}

