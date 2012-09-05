//===========================================================================
//===========================================================================
//== Обязательно при модифицировании кода менять дату модификации элемента ==
//===========================================================================
//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "M_SubSystem.h"
#include "M_SubSystemIn.h"
#include "M_SubSystemOut.h"
#include "Unit_BaseDialog_01.h"
#include "Unit_EditorManager.h"
//===========================================================================
void TSubSystem_Init() { RegisterElement("DiALab - Базовые", "Блочные элементы", (int)&TSubSystem::Create); }
#pragma startup TSubSystem_Init 120 // default 100
//===========================================================================
TSubSystem::TSubSystem()
{
  // --------- Загружаем ресурс если он есть ---------
     ResourseBitmapFaceElement->Handle = LoadBitmap(HInstance, typeid(*this).name());

  // ---------
     DefaultName = "Блочный элемент";
     Note        = "Предназначен для формирования подсистемы в данном блоке, который учавствывает в счете всей системы";
     CreateDate  = "20.02.2004";

     frmEditorManager = new TfrmEditorManager(NULL);

  // ---------
     VisualElementParam->Width  = 3 * 16;
     VisualElementParam->Height = 3 * 16;

  // ---------
     fInputList  = new TList;
     fOutputList = new TList;
  // ---------
     ShowCaption = true;
}

TSubSystem::~TSubSystem()
{
     delete fInputList;  fInputList = NULL;
     delete fOutputList; fOutputList = NULL;
  // -----
     if (frmEditorManager != NULL)
          delete frmEditorManager;
}

//===========================================================================
void TSubSystem::DrawElementFace()
{
      AnsiString  as       = "Block";

      TCanvas    *dbCanvas = VisualElementParam->Bitmap->Canvas;
      int         aw       = VisualElementParam->Width;
      int         ah       = VisualElementParam->Height;

      dbCanvas->Brush->Color = clWhite;
      dbCanvas->Pen  ->Color = clBlack;

      dbCanvas->Rectangle(0, 0, aw, ah);

      dbCanvas->TextOut((aw - dbCanvas->TextWidth(as))/2, (ah - dbCanvas->TextHeight(as))/2, as);
}

//===========================================================================
void __fastcall TSubSystem::Set_Open(bool aOpen)
{
    fOpen = aOpen;
    
  // ----
     if (aOpen && !frmEditorManager->Visible) {
         frmEditorManager->IdCurrentSubSystemManager = Id;
         frmEditorManager->Show();                             
     }

   // ---- Если окно не ативно , или гденибудь спятано под другими окнами , или свернутое , то показываем его ---------
     if (frmEditorManager->Visible) {
         frmEditorManager->SetFocus();
         frmEditorManager->WindowState = wsNormal;
     }
}

//===========================================================================
void  __fastcall TSubSystem::Set_WindowPosition(TRect aRect)
{
   fWindowPosition = aRect;
   if (frmEditorManager != NULL) {
       frmEditorManager->Left   = fWindowPosition.Left;
       frmEditorManager->Top    = fWindowPosition.Top;
       frmEditorManager->Width  = fWindowPosition.Width();
       frmEditorManager->Height = fWindowPosition.Height();
   }
}

//===========================================================================
void TSubSystem::Add_Input(TElement *aElement)
{
    iPoints->Add("");
    fInputList->Add(aElement);
    ((TSubSystemIn*)fInputList->Items[fInputList->Count - 1])->InputIndex = fInputList->Count;
}

//===========================================================================
void TSubSystem::Add_OutPut(TElement *aElement)
{
    oPoints->Add("");
    fOutputList->Add(aElement);
    ((TSubSystemOut*)fOutputList->Items[fOutputList->Count - 1])->OutputIndex = fOutputList->Count;
}

//===========================================================================
void TSubSystem::Delete_Input(TElement *aElement)
{
   for (int i = 0; i < fInputList->Count; i++)
      if (fInputList->Items[i] == aElement) {
         fInputList->Items[i] = NULL;
         iPoints->Delete(i);
      }
   fInputList->Pack();

  // --------
   for (int i = 0; i < fInputList->Count; i++)
      ((TSubSystemIn*)fInputList->Items[i])->InputIndex = i + 1;

}

//===========================================================================
void TSubSystem::Delete_OutPut(TElement *aElement)
{
   for (int i = 0; i < fOutputList->Count; i++)
      if (fOutputList->Items[i] == aElement) {
         fOutputList->Items[i] = NULL;
         oPoints->Delete(i);
      }
   fOutputList->Pack();

  // --------
   for (int i = 0; i < fOutputList->Count; i++)
      ((TSubSystemOut*)fOutputList->Items[i])->OutputIndex = i + 1;
}

//===========================================================================
void TSubSystem::Edit()
{
   TfrmBaseDialog1 *dlg;

   try {
        dlg = new TfrmBaseDialog1(NULL);
        dlg->Element            = this;
        dlg->GroupBox1->Caption = DefaultName;
        dlg->lTitle   ->Caption = Note;
     // ------
        dlg->ParameteresCount       = 0;
        dlg->BaseDialogFormStyle    = bdfsFloatValues;
     // ------
        dlg->ShowModal();
   } __finally { delete dlg; }
}

//===========================================================================
void TSubSystem::Copy(void *aElement) { TElement::Copy(aElement);
//COPY_COPY
}

void TSubSystem::LoadFromStream(TStream *aStream){ TElement::LoadFromStream(aStream);
      aStream->Read(&fEditorManagerWidth , sizeof(fEditorManagerWidth ));
      aStream->Read(&fEditorManagerHeight, sizeof(fEditorManagerHeight));
      aStream->Read(&fEditorManagerLeft  , sizeof(fEditorManagerLeft  ));
      aStream->Read(&fEditorManagerTop   , sizeof(fEditorManagerTop   ));

      Classes::TNotifyEvent OnResize = &frmEditorManager->pBackGroundResize;
      frmEditorManager->OnResize    = NULL;

      frmEditorManager->Width  = fEditorManagerWidth;
      frmEditorManager->Height = fEditorManagerHeight;
      frmEditorManager->Left   = fEditorManagerLeft;
      frmEditorManager->Top    = fEditorManagerTop;

      frmEditorManager->OnResize = OnResize;
};

void TSubSystem::SaveToStream  (TStream *aStream){ TElement::SaveToStream(aStream);
      fEditorManagerWidth  = frmEditorManager->Width;
      fEditorManagerHeight = frmEditorManager->Height;
      fEditorManagerLeft   = frmEditorManager->Left;
      fEditorManagerTop    = frmEditorManager->Top;

      aStream->Write(&fEditorManagerWidth , sizeof(fEditorManagerWidth ));
      aStream->Write(&fEditorManagerHeight, sizeof(fEditorManagerHeight));
      aStream->Write(&fEditorManagerLeft  , sizeof(fEditorManagerLeft  ));
      aStream->Write(&fEditorManagerTop   , sizeof(fEditorManagerTop   ));
};



