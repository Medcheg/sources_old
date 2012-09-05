//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_SKO.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TSKO_Init() { RegisterElement("DiALab - Базовые", "Мат. операции", (int)&TSKO::Create); }
#pragma startup TSKO_Init 110 // default 100
//===========================================================================
TSKO::TSKO()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Средне-квадратич. отклонение";
     Note        = "";
     CreateDate  = "13.02.2005";
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
     oPoints->Add("СКО");
}

//===========================================================================
TSKO::~TSKO()
{
}

//===========================================================================
void TSKO::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
   aStream->Read(&fCalcCountTakt, sizeof(fCalcCountTakt));
}

//===========================================================================
void TSKO::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
   aStream->Write(&fCalcCountTakt, sizeof(fCalcCountTakt));
}

//===========================================================================
void TSKO::DrawElementFace()
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
      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2, (ah - dbCanvas->TextHeight(as))/2, as);

      dbCanvas->Font->Size = FontSize;
      dbCanvas->Font->Name = FontName;
      dbCanvas->Font->Style = FontStyles;
      dbCanvas->Font->Color = FontColor;
}

//===========================================================================
void TSKO::Edit()
{
   TfrmBaseDialog1 *dlg;
   try {
         dlg = new TfrmBaseDialog1(NULL);
         dlg->Element            = this;
         dlg->GroupBox1->Caption = DefaultName;
         dlg->lTitle   ->Caption = Note;

     // ------
        dlg->ValueArray[0]          = &fCalcCountTakt;
        dlg->LabelArray[0]->Caption = "Такт с которого начинается счет СКО";
        dlg->ParameteresCount       = 1;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;

     // ------
        dlg->ShowModal();
     // ------
   } __finally { delete dlg; }
}


//===========================================================================
void TSKO::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TSKO::Init() { TElement::Init();
   fGlobalCountPoint = 0;

   fNullValue  = 0;
   fCountPoint = 0;
   fSummaSred  = 0;
   fSummaSKO     = 0;
   fSredError  = 0;
}

//===========================================================================
void   TSKO::Draw(TCanvas *aCanvas, int aParentId) { TElement::Draw(aCanvas, aParentId);
}


//===========================================================================
void TSKO::Run()
{      if (!isEnabledCalc()) return; TElement::Run();
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

           // ---------------- СКО ---------
             TFloat a    = iQueue1[0] - fSredError;
             fSummaSKO  += a*a;
             oQueue1[0]  = sqrt( fSummaSKO / (TFloat)fCountPoint );
       }
}

