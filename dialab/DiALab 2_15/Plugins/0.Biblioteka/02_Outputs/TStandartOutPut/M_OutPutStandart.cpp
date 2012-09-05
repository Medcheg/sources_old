//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#pragma package(smart_init)

#include "M_OutPutStandart.h"
#include "frm__OutPutStandart.h"
#include "dlg__OutPutStandart.h"
//===========================================================================
void TOutElementStandart_Init() { RegisterElement("DiALab - Базовые", "Выходы", (int)&TOutElementStandart::Create); }
#pragma startup TOutElementStandart_Init 250 // default 100
//===========================================================================
TOutElementStandart::TOutElementStandart()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Стандартный выход";
     Note        = "Элемент предназначен для вывода на график потока данных с возвожностью последующей записи их в файл в виде таблици.";
     CreateDate  = "04.02.2005";

  // ---------
     DesignPhase = dpNeedModified;

  // ---------
     MinY        = -10;
     MaxY        =  10;
     DrawDots    = false;

  // ---------
     frmOutPut         = new TfrmOutPutStandart(NULL);
     ((TfrmOutPutStandart*)frmOutPut)->Left    = (Screen->Width  - ((TfrmOutPutStandart*)frmOutPut)->Width ) / 2;
     ((TfrmOutPutStandart*)frmOutPut)->Top     = (Screen->Height - ((TfrmOutPutStandart*)frmOutPut)->Height) / 2;
     ((TfrmOutPutStandart*)frmOutPut)->Element = this;
     ((TfrmOutPutStandart*)frmOutPut)->pMinY   = &MinY;
     ((TfrmOutPutStandart*)frmOutPut)->pMaxY   = &MaxY;
     //fSeriesParamList   = new TList();
  // ---------
      mpiSeries               = NULL;

  // ---------
     fCountInput              = 0;
      CountInput              = 1;

  // ---------
     VisualElementParam->Width  = 2 * 16;
     VisualElementParam->Height = 2 * 16;
  // ---------
  // --- CountInput  = iPoints->Items_Count; ---
  // ---------
}

//===========================================================================
TOutElementStandart::~TOutElementStandart()
{
  if (frmOutPut != NULL) delete (TfrmOutPutStandart*)frmOutPut; frmOutPut = NULL;

  // ---- Удаляю список кривых --------------
   if (mpiSeries != NULL) {
         for (int i = 0; i < iPoints->Items_Count; i++)
             delete mpiSeries[i];
         free (mpiSeries);

         mpiSeries = NULL;
   }
}

//===========================================================================
void TOutElementStandart::LoadFromStream(TStream *aStream) {

   // ------ Перед загрузкой удаляю ввсе входы -------
         CountInput = 0;

   // ---- Загружаю по родительской очереди ----------
         TElement::LoadFromStream(aStream);

         int        aCountInput;
         TColor     aColor;
         TPenStyle  aPenStyle;
         int        aPenWidth;
         AnsiString aCaptionString;
         int        aLeft, aTop, aWidth, aHeight;

         aStream->Read(&aLeft  , sizeof(aLeft  ));
         aStream->Read(&aTop   , sizeof(aTop   ));
         aStream->Read(&aWidth , sizeof(aWidth ));
         aStream->Read(&aHeight, sizeof(aHeight));

         aStream->Read(&MinY       , sizeof(MinY));
         aStream->Read(&MaxY       , sizeof(MaxY));
         aStream->Read(&DrawDots   , sizeof(DrawDots));
         aStream->Read(&aCountInput, sizeof(aCountInput));

      // ---- Удаляю проинициализированы начально входы ---------
          while (iPoints->Items_Count != 0) iPoints->Delete(0);
      // ---- Сношу загруженные выходы ------

          CountInput = aCountInput;

      for ( int i = 0; i < aCountInput; i++){
          aStream->Read(&aColor   , sizeof(aColor));
          aStream->Read(&aPenStyle, sizeof(aPenStyle));
          aStream->Read(&aPenWidth, sizeof(aPenWidth));

          LoadAnsiSringFromStream(aStream, aCaptionString);

          mpiSeries[i]->Color        = aColor;
          mpiSeries[i]->PenStyle     = aPenStyle;
          mpiSeries[i]->PenWidth     = aPenWidth;
          mpiSeries[i]->Name         = aCaptionString;
          iPoints->Items[i]->Caption = aCaptionString;
      }

      ((TfrmOutPutStandart*)frmOutPut)->OnResize = NULL;
      ((TfrmOutPutStandart*)frmOutPut)->Left   = aLeft;
      ((TfrmOutPutStandart*)frmOutPut)->Top    = aTop;
      ((TfrmOutPutStandart*)frmOutPut)->Width  = aWidth  + ((TfrmOutPutStandart*)frmOutPut)->Panel1->Width;
      ((TfrmOutPutStandart*)frmOutPut)->Height = aHeight;
      ((TfrmOutPutStandart*)frmOutPut)->OnResize = ((TfrmOutPutStandart*)frmOutPut)->FormResize;
}

//===========================================================================
void TOutElementStandart::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
      TColor     aColor;
      TPenStyle  aPenStyle;
      int        aPenWidth;
      int        aLeft, aTop, aWidth, aHeight;
  // -----------------
      aLeft    = ((TfrmOutPutStandart*)frmOutPut)->Left;
      aTop     = ((TfrmOutPutStandart*)frmOutPut)->Top;
      aWidth   = ((TfrmOutPutStandart*)frmOutPut)->Width;
      aHeight  = ((TfrmOutPutStandart*)frmOutPut)->Height;
  // -----------------
      aStream->Write(&aLeft  , sizeof(aLeft  ));
      aStream->Write(&aTop   , sizeof(aTop   ));
      aStream->Write(&aWidth , sizeof(aWidth ));
      aStream->Write(&aHeight, sizeof(aHeight));
  // -----------------
      aStream->Write(&MinY       , sizeof(MinY       ));
      aStream->Write(&MaxY       , sizeof(MaxY       ));
      aStream->Write(&DrawDots   , sizeof(DrawDots   ));
      aStream->Write(&fCountInput, sizeof(fCountInput));
  // -----------------
      for ( int i = 0; i < fCountInput; i++){
          aColor    = mpiSeries[i]->Color;
          aPenStyle = mpiSeries[i]->PenStyle;
          aPenWidth = mpiSeries[i]->PenWidth;

          aStream->Write(&aColor   , sizeof(aColor));
          aStream->Write(&aPenStyle, sizeof(aPenStyle));
          aStream->Write(&aPenWidth, sizeof(aPenWidth));

          SaveAnsiSringToStream(aStream, iPoints->Items[i]->Caption);
      }
}

//===========================================================================
void TOutElementStandart::DrawElementFace()
{
   // -----
      AnsiString  as       = "Out";

      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;

      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;

      dbCanvas->Rectangle(0, 0, aw, ah);

   // --------- Отрисовка прямоугольника --- (прямокгольник процесса разработки) -----
     if (DesignPhase != dpAllreadyTesting) {
         if (DesignPhase == dpNotTesting  ) {dbCanvas->Pen  ->Color = clRed;}
         if (DesignPhase == dpNeedModified) {dbCanvas->Pen  ->Color = clRed; dbCanvas->Pen  ->Style = psDot;}

         dbCanvas->Rectangle(2, 2, VisualElementParam->Width - 2, VisualElementParam->Height - 2);

         dbCanvas->Pen->Color = clBlack;
         dbCanvas->Pen->Style = psSolid;
      }   
      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2, (ah - dbCanvas->TextHeight(as))/2, as);
}


//===========================================================================
void TOutElementStandart::Edit()
{
   TdlgOutPutStandart *dlg;

   try {
     dlg = new TdlgOutPutStandart(NULL);

     dlg->Element            = this;
     dlg->GroupBox1->Caption = DefaultName;
     dlg->lTitle   ->Caption = Note;
     dlg->Element            = this;
     dlg->pMinY              = &MinY;
     dlg->pMaxY              = &MaxY;

     dlg->ShowModal();
   } __finally {
       delete dlg;
   }
}

//===========================================================================
void TOutElementStandart::Copy(void *aElement) { TElement::Copy(aElement);
// COPY 
}

//===========================================================================
void __fastcall TOutElementStandart::Set_CountInput(int aCountInput)
{
   if (fCountInput == aCountInput) return;

  // ----
  // ---- Выставляю параметры элемента -------
  // ----

     // ---- Если элементов стало больше ----------
       if (fCountInput < aCountInput) {
           mpiSeries = (TmpiSeries**) realloc (mpiSeries, sizeof(TmpiSeries*) * aCountInput);

           for (int i = fCountInput; i < aCountInput; i++) {
               iPoints->Add("Вход №" + IntToStr(i + 1));
               mpiSeries[i]        = new TmpiSeries;
               mpiSeries[i]->Color = ColorArray[i];
           }
       }

     // ---- Если элементов стало меньше ----------
       if (fCountInput > aCountInput) {
         // ---- Удаляю входы ------
             while (iPoints->Items_Count != aCountInput) {
                  if (iPoints->Items[aCountInput]->Conected) {
                     ((TLink*)iPoints->Items[aCountInput]->CurrentLink)->SecondElement = NULL;
                     ((TLink*)iPoints->Items[aCountInput]->CurrentLink)->NumberInput   = -1;
                  }
                  iPoints->Delete(aCountInput);
             }

         // ---- Удаляю серии ------------
             for (int i = aCountInput; i < fCountInput; i++){
                  delete mpiSeries[i];
                  mpiSeries[i] = NULL;
             }
           mpiSeries = (TmpiSeries**) realloc (mpiSeries, sizeof(TmpiSeries*) * aCountInput);
       }

       fCountInput = aCountInput;
}

//===========================================================================
void TOutElementStandart::Init() { TElement::Init();

  // ---- Для окна вывода графикков устанавливаю параметры ---------
       frmOutPut->mpiSeries = (void**)mpiSeries;
       frmOutPut->Init();
       frmOutPut->Show();
  // -----
       for (int i = 0; i < fCountInput; i++) {
              mpiSeries[i]->Init();

            // ---- Выделяю память под грайики -----
              mpiSeries[i]->XValues = (TFloat*) malloc (sizeof(TFloat) * (pProjectParam->EndCalcTime / pProjectParam->AnalogT0 + 2));
              mpiSeries[i]->YValues = (TFloat*) malloc (sizeof(TFloat) * (pProjectParam->EndCalcTime / pProjectParam->AnalogT0 + 2));
       }
  // -----
}

//===========================================================================
void TOutElementStandart::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


       for (int i = 0; i < iPoints->Items_Count; i++){
           TFloat aValue = (iPoints->Items[i]->Queue == NULL)? 0 : iPoints->Items[i]->Queue[0];
           mpiSeries[i]->AddXYValue(*pCurModelTime, aValue);
           frmOutPut->AddXYValue(i, mpiSeries[i]->Values_Count - 1, true); // --- true
       }
}


