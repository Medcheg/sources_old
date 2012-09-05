//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "M_SubSystemOut.h"
//===========================================================================
void TSubSystemOut_Init() { RegisterElement("DiALab - Базовые", "Блочные элементы", (int)&TSubSystemOut::Create); }
#pragma startup TSubSystemOut_Init 110 // default 100
//===========================================================================
TSubSystemOut::TSubSystemOut()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Выход блока";
     Note        = "Выходной порт блочного элемента";
     CreateDate  = "01.12.2004";

     ShowCaption = false;
  // ---------
     VisualElementParam->Width  = 2.2 * 16;
     VisualElementParam->Height = 1.1 * 16;
  // ---------
     iPoints->Add("x");
     oPoints->Add("y"); oPoints->Items[0]->Visible = false;
  // ---------
     fOutputIndex = -1;
}

//===========================================================================
void TSubSystemOut::DrawElementFace()
{
      if (pManagerParam == NULL) return;

      AnsiString  as       = IntToStr(fOutputIndex);
      if (fOutputIndex == -1) as = "Out";

      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;
      int         MinSide  = min (aw, ah) * 2 / 3 ;


    // --- Так как элемент не прямоугольный , то ощищаю подложку ----
       dbCanvas->Brush->Color = pManagerParam->FonColor;
       dbCanvas->Pen  ->Color = pManagerParam->FonColor;
       dbCanvas->FillRect(Rect(0,0, aw, ah));
    // --- Тень ------
       if (Shadow) {
          dbCanvas->Brush->Color = clGray;
          dbCanvas->Pen  ->Color = clGray;
          dbCanvas->RoundRect(3, 3, aw+3, ah+3, MinSide, MinSide);
       }

    // --- не Тень ------
       dbCanvas->Brush->Color = clWhite;
       dbCanvas->Pen  ->Color = clBlack;
       dbCanvas->RoundRect(0, 0, aw, ah, MinSide, MinSide);
    // ---
      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2, (ah - dbCanvas->TextHeight(as))/2, as);
}

//===========================================================================
void __fastcall TSubSystemOut::Set_OutputIndex(int aValue)
{

    fOutputIndex = aValue;
    DrawElementFace();
}
//===========================================================================
void TSubSystemOut::Edit()
{
}

//===========================================================================
void TSubSystemOut::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TSubSystemOut::Init() { TElement::Init();
}

//===========================================================================
void TSubSystemOut::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      if  (iPoints->Items[0]->Queue == NULL)
           oPoints->Items[0]->Queue[0] = 0;
      else oPoints->Items[0]->Queue[0] = iPoints->Items[0]->Queue[0];
}

