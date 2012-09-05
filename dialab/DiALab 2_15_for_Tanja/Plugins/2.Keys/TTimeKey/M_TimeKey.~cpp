//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#include "math.h"
#pragma hdrstop

#include "M_TimeKey.h"
#include "Unit_BaseDialog_01.h"
//===========================================================================
void TTimeKey_Init() { RegisterElement("DiALab - Дополнительные", "Ключи", (int)&TTimeKey::Create); }
#pragma startup TTimeKey_Init 110 // default 100
//===========================================================================
TTimeKey::TTimeKey()
{
  // -------------- Зугрузка ресурса если он есть ----------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Временной ключ";
     Note        = "Елемент умножет вход на число (А) от времени (Т1)(вкл) до (Т2), умножает вход на число (B) от времени (Т2)(вкл) до (Т3)(вкл), вне границ временного интервала выход елемента равен '0'";
     CreateDate  = "30.06.2005";
  // ---------
     DesignPhase = dpAllreadyTesting;//  dpAllreadyTesting;

  // ---------
     ShowCaption = false;
  // ---------
     VisualElementParam->Width  = 2.0 * 16;
     VisualElementParam->Height = 2.0 * 16;
  // ---------
     t1 =  0;
     t2 =  20;
     t3 =  99999;
     a  =  0;
     b  =  1;

  // --------- Добавляю один выход --------
     iPoints->Add("x");
     oPoints->Add("y");
}

//===========================================================================
TTimeKey::~TTimeKey()
{
}

//===========================================================================
void TTimeKey::LoadFromStream(TStream *aStream) { TElement::LoadFromStream(aStream);
   aStream->Read(&t1, sizeof(t1));
   aStream->Read(&t2, sizeof(t2));
   aStream->Read(&t3, sizeof(t3));
   aStream->Read(&a , sizeof(a));
   aStream->Read(&b , sizeof(b));
}

//===========================================================================
void TTimeKey::SaveToStream(TStream *aStream) { TElement::SaveToStream(aStream);
   aStream->Write(&t1, sizeof(t1));
   aStream->Write(&t2, sizeof(t2));
   aStream->Write(&t3, sizeof(t3));
   aStream->Write(&a , sizeof(a));
   aStream->Write(&b , sizeof(b));
}

//===========================================================================
void TTimeKey::DrawElementFace()
{
      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;
  // --------
      //int x1 = 0.35 * aw;
      //int y1 = 0.32 * ah;
      //int x2 = 0.35 * aw;
      //int y2 = 0.50  * ah;
      //int x3 = x2 + (aw - x2 - x1) / 2;
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
void TTimeKey::Edit()
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
        dlg->ValueArray[0]          = &t1;
        dlg->ValueArray[1]          = &t2;
        dlg->ValueArray[2]          = &t3;
        dlg->ValueArray[3]          = &a;
        dlg->ValueArray[4]          = &b;
        dlg->LabelArray[0]->Caption = "Время T1[c]:";
        dlg->LabelArray[1]->Caption = "Время T2[c]:";
        dlg->LabelArray[2]->Caption = "Время T3[c]:";
        dlg->LabelArray[3]->Caption = "Величина полки 'А':";
        dlg->LabelArray[4]->Caption = "Величина полки 'B':";

        dlg->ParameteresCount       = 5;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();

     // ------
   } __finally { delete dlg; }
}

//===========================================================================
void TTimeKey::Copy(void *aElement) { TElement::Copy(aElement);
   TTimeKey *el = (TTimeKey*)aElement;
   el->t1 = t1;
   el->t2 = t2;
   el->t3 = t3;
   el->a  = a;
   el->b  = b;
}

//===========================================================================
void TTimeKey::Init() { TElement::Init();
}

//===========================================================================
void TTimeKey::Run()
{     if (!isEnabledCalc()) return; TElement::Run();
   // --------------

        TFloat *iQueue  = iPoints->Items[0]->Queue;
        TFloat *oQueue  = oPoints->Items[0]->Queue;

        if (*pCurModelTime >= 0 && *pCurModelTime < t1) oQueue[0] = 0;
           else if (*pCurModelTime >= t1 && *pCurModelTime < t2) oQueue[0] = iQueue[0] * a;
               else if (*pCurModelTime >= t2 && *pCurModelTime <= t3) oQueue[0] = iQueue[0] * b;
                   else if (*pCurModelTime > t3) oQueue[0] = 0;
}

