//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "M_LogicKey.h"
#include "math.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TLogicKey_Init() { RegisterElement("DiALab - Дополнительные", "Ключи", (int)&TLogicKey::Create); }
#pragma startup TLogicKey_Init 110 // default 100
//===========================================================================
TLogicKey::TLogicKey()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Логический ключ";
     Note        = "Елемент выбирает, по заданому критерию, какой из входов будет на выходе";
     CreateDate  = "30.06.2005";
  // ---------
     DesignPhase = dpNotTesting;//  dpAllreadyTesting;

   // -------------- Зугрузка ресурса если он есть ----------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());
  // ---------
     ShowCaption = false;
  // ---------
     VisualElementParam->Width  = 2.0 * 16;
     VisualElementParam->Height = 2.0 * 16;
  // ---------
     CountInTakt  = 3;
     CountOutTakt = 3;
     ControlValue = 0.5;

  // --------- Добавляю один выход --------
     iPoints->Add("x1");
     iPoints->Add("x2");
     oPoints->Add("y");
}

//===========================================================================
TLogicKey::~TLogicKey()
{
}

//===========================================================================
void TLogicKey::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
   aStream->Read(&CountInTakt , sizeof(CountInTakt ));
   aStream->Read(&CountOutTakt, sizeof(CountOutTakt));
   aStream->Read(&ControlValue, sizeof(ControlValue));
}

//===========================================================================
void TLogicKey::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
   aStream->Write(&CountInTakt , sizeof(CountInTakt ));
   aStream->Write(&CountOutTakt, sizeof(CountOutTakt));
   aStream->Write(&ControlValue, sizeof(ControlValue));
}

//===========================================================================
void TLogicKey::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;
  // --------
//      int x1 = 0.35 * aw;
//      int y1 = 0.32 * ah;
//      int x2 = 0.35 * aw;
//      int y2 = 0.50  * ah;
//      int x3 = x2 + (aw - x2 - x1) / 2;
  // --------
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

   // -------------- Отрисовка ресурса если он есть ----------
      dbCanvas->Draw((aw - ResourseBitmapFaceElement->Width) / 2, (ah - ResourseBitmapFaceElement->Height) / 2,ResourseBitmapFaceElement);
}

//===========================================================================
void TLogicKey::Edit()
{
 // ------
   TfrmBaseDialog1 *dlg;
 // ------
   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;

     // ------
        dlg->ValueArray[0]          = &CountInTakt;
        dlg->ValueArray[1]          = &CountOutTakt;
        dlg->ValueArray[2]          = &ControlValue;
        dlg->LabelArray[0]->Caption = "Критерий входа в трубку (количество точек):";
        dlg->LabelArray[1]->Caption = "Критерий выхода из трубку (количество точек):";
        dlg->LabelArray[2]->Caption = "Ширина трубки [А]:";
        dlg->ParameteresCount       = 3;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();

     // ------
   } __finally { delete dlg; }
}

//===========================================================================
void TLogicKey::Copy(void *aElement) { TElement::Copy(aElement);
   TLogicKey *el = (TLogicKey*)aElement;
   el->CountInTakt  = CountInTakt;
   el->CountOutTakt = CountOutTakt;
   el->ControlValue = ControlValue;
}

//===========================================================================
void TLogicKey::Init() { TElement::Init();
    CurInTakt  = 0;//CountInTakt;
    CurOutTakt = CountOutTakt;
}

//===========================================================================
void TLogicKey::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------


        TFloat *oQueue  = oPoints->Items[0]->Queue;
        TFloat *iQueue1 = iPoints->Items[0]->Queue;
        TFloat *iQueue2 = iPoints->Items[1]->Queue;
    //------------------------------------------------------
        bool InTube = false;

        if (fabs(iQueue1[0]) <  ControlValue) {
              InTube = true;
              CurInTakt  ++;
        }
        else{
              InTube = false;
              CurOutTakt ++;
        }
    //------------------------------------------------------
        //for ( int i = 1; i < 12; i ||)


    //------------------------------------------------------
        if (CurInTakt  >= CountInTakt && InTube) { // && CurOutTakt != 0
              oQueue[0] = iQueue2[0];
              CurOutTakt = 0;
        } else {
            if (CurOutTakt >= CountOutTakt && !InTube) { //  && CurInTakt != 0
                  oQueue[0] = iQueue1[0];
                  CurInTakt  = 0;
            } else
              if (!InTube)
                 oQueue[0] = iQueue2[0];
              else
                 oQueue[0] = iQueue1[0];
        }
}

