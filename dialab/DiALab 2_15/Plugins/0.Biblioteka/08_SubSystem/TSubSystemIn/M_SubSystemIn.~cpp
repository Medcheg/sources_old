//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "M_SubSystemIn.h"
//===========================================================================
void TSubSystemIn_Init() { RegisterElement("DiALab - Базовые", "Блочные элементы", (int)&TSubSystemIn::Create); }
#pragma startup TSubSystemIn_Init 110 // default 100
//===========================================================================
TSubSystemIn::TSubSystemIn()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Вход блока";           
     Note        = "Входной порт блочного элемента";
     CreateDate  = "01.12.2004";


     ShowCaption = false;
  // ---------
     VisualElementParam->Width  = 2.2 * 16;
     VisualElementParam->Height = 1.1 * 16;
  // ---------

     iPoints->Add("1");  iPoints->Items[0]->Visible = false;
     oPoints->Add("1");
  // ---------
     fInputIndex = -1;
}

//===========================================================================
void TSubSystemIn::DrawElementFace()
{
      if (pManagerParam == NULL) return;

      AnsiString  as       = IntToStr(fInputIndex);
      if (fInputIndex == -1) as = "In";

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
void __fastcall TSubSystemIn::Set_InputIndex(int aValue)
{
    fInputIndex = aValue;
    DrawElementFace();
}

//===========================================================================
void TSubSystemIn::Edit()
{
}

//===========================================================================
void TSubSystemIn::Copy(void *aElement) { TElement::Copy(aElement);

//COPY_COPY
}

//===========================================================================
void TSubSystemIn::Init() { TElement::Init();
}


//===========================================================================
void TSubSystemIn::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------
      if  (iPoints->Items[0]->Queue == NULL)
           oPoints->Items[0]->Queue[0] = 0;
      else oPoints->Items[0]->Queue[0] = iPoints->Items[0]->Queue[0];
}

