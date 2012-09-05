//=============================================================================
//=============================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ====
//=============================================================================
//=============================================================================

#include <vcl.h>
#pragma hdrstop

#include "M_AperiodicForce2.h"
#include "Unit_BaseDialog_01.h"
#pragma package(smart_init)

//=============================================================================
TAperiodicForce2::TAperiodicForce2()
{
     DefaultName = "Коэффициент усиления";
     Note        = "Пропорциональное звено: y(t) = K * x(t)";
     CreateDate  = "01.12.2004";

     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
     iPoints->Add("x1");
     oPoints->Add("y1");
  // ---------
     K  = 1;
  // ---------
}

//===========================================================================
void TAperiodicForce2::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
    aStream->Read(&K , sizeof(K ));
}

//===========================================================================
void TAperiodicForce2::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
    aStream->Write(&K , sizeof(K));
}

//===========================================================================
void TAperiodicForce2::DrawElementFace()
{
      AnsiString  as       = "K";

      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;

      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;

      dbCanvas->Rectangle(0, 0, aw, ah);
      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2, (ah - dbCanvas->TextHeight(as))/2, as);
}

//===========================================================================
void TAperiodicForce2::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ValueArray[0]          = &K;
        dlg->LabelArray[0]->Caption = "Коэффициент усиления :";
        dlg->ParameteresCount       = 1;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TAperiodicForce2::Init() { TElement::Init();

}

//===========================================================================
void TAperiodicForce2::Run()
{
      if (!*iPoints->Items[0]->EnableCalc) {
          *oPoints->Items[0]->EnableCalc = false;
          return;
      }
    // ---------- РОдиьельский Ран -------
      TElement::Run();
   // --------
      oPoints->Items[0]->Queue[0] = iPoints->Items[0]->Queue[0] * K;
   // --------
      *oPoints->Items[0]->EnableCalc = true;
}

