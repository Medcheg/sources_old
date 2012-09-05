//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_Dispersija.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TDispersija_Init() { RegisterElement("DiALab - Базовые", "Мат. операции", (int)&TDispersija::Create); }
#pragma startup TDispersija_Init 110 // default 100
//===========================================================================
TDispersija::TDispersija()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Дисперсия";
     Note        = "";
     CreateDate  = "6.02.2005";
  // ---------
     DesignPhase = dpAllreadyTesting;
  // ---------
     ShowCaption = false;
  // ---------
     VisualElementParam->Width  = 2.0 * 16;
     VisualElementParam->Height = 2.0 * 16;
  // ---------
     fCalcCountTakt = 0;

  // --------- Добавляю один выход --------
     iPoints->Add("x");
     oPoints->Add("D");
}

//===========================================================================
TDispersija::~TDispersija()
{
}

//===========================================================================
void TDispersija::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
   aStream->Read(&fCalcCountTakt, sizeof(fCalcCountTakt));
}

//===========================================================================
void TDispersija::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
   aStream->Write(&fCalcCountTakt, sizeof(fCalcCountTakt));
}

//===========================================================================
void TDispersija::DrawElementFace()
{
      AnsiString  as       = "s";
  // --------
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;
      int         FontSize   = dbCanvas->Font->Size;
      AnsiString  FontName   = dbCanvas->Font->Name;
      TFontStyles FontStyles = dbCanvas->Font->Style;
      TColor      FontColor  = dbCanvas->Font->Color;
  // --------
      dbCanvas->Font->Name   = "Symbol";
      dbCanvas->Font->Size   = 14;
      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;
  // --------
      dbCanvas->Rectangle(0, 0, aw, ah);

   // --------- Отрисовка прямоугольника --- (прямокгольник процесса разработки) -----
     if (DesignPhase != dpAllreadyTesting) {
         if (DesignPhase == dpNotTesting  ) {dbCanvas->Pen  ->Color = clRed;}
         if (DesignPhase == dpNeedModified) {dbCanvas->Pen  ->Color = clRed; dbCanvas->Pen  ->Style = psDot;}

         dbCanvas->Rectangle(2, 2, VisualElementParam->Width - 2, VisualElementParam->Height - 2);

         dbCanvas->Pen->Color = clBlack;
         dbCanvas->Pen->Style = psSolid;
      }   
  // --------
      dbCanvas->Font->Style = TFontStyles() << fsBold;
      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2 - 2, (ah - dbCanvas->TextHeight(as))/2, as);

      dbCanvas->Font->Style = TFontStyles();
      dbCanvas->Font->Name   = "MS Sans Serif";
      dbCanvas->Font->Size   = 6;
      dbCanvas->TextOut(aw/2 + dbCanvas->TextWidth(as) + 0, (ah - dbCanvas->TextHeight(as))/2 - 2, "2");

      dbCanvas->Font->Size = FontSize;
      dbCanvas->Font->Name = FontName;
      dbCanvas->Font->Style = FontStyles;
      dbCanvas->Font->Color = FontColor;
}

//===========================================================================
void TDispersija::Edit()
{
   TfrmBaseDialog1 *dlg;
   try {
         dlg = new TfrmBaseDialog1(NULL);
         dlg->Element            = this;
         dlg->GroupBox1->Caption = DefaultName;
         dlg->lTitle   ->Caption = Note;

     // ------
        dlg->ValueArray[0]          = &fCalcCountTakt;
        dlg->LabelArray[0]->Caption = "Такт с которого начинается счет дисперсии";
        dlg->ParameteresCount       = 1;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;

     // ------
        dlg->ShowModal();
     // ------
   } __finally { delete dlg; }
}


//===========================================================================
void TDispersija::Copy(void *aElement) { TElement::Copy(aElement);
}

//===========================================================================
void TDispersija::Init() { TElement::Init();
   fGlobalCountPoint = 0;

   fNullValue  = 0;
   fCountPoint = 0;
   fSummaSred  = 0;
   fSummaD     = 0;
   fSredError  = 0;
}

//===========================================================================
void   TDispersija::Draw(TCanvas *aCanvas, int aParentId) { TElement::Draw(aCanvas, aParentId);
}


//===========================================================================
void TDispersija::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------



       TFloat *oQueue1 =  oPoints->Items[0]->Queue;
       TFloat *iQueue1 = (iPoints->Items[0]->Queue != NULL) ? iPoints->Items[0]->Queue : &fNullValue;

       fGlobalCountPoint++;

       if (fGlobalCountPoint >= fCalcCountTakt) {
             fCountPoint ++;

           //----------------- Мат ожидание ------
             fSummaSred += iQueue1[0];
             fSredError  = fSummaSred / (TFloat)fCountPoint;
             //oQueue1[0]  = fSredError;

           // ---------------- Дисперсия ---------
             TFloat a    = iQueue1[0] - fSredError;
             fSummaD  += a*a;
             //oQueue2[0]  = sqrt( fSummaSKO / (TFloat)fCountPoint );
             oQueue1[0]  = fSummaD / (TFloat)fCountPoint;
       }
}

