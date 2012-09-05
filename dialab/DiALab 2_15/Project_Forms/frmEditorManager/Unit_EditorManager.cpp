//===========================================================================
#include <vcl.h>
#include <typeinfo.h>
#pragma hdrstop

#include "mpiElementsTree.h"
#include "M_SubSystem.h"
#include "M_SubSystemIn.h"
#include "M_SubSystemOut.h"
#include "M_OutPutStandart.h"
#include "frm__OutPutStandart.h"
#include "mpiTimeManager.h"
#include "mpiErrors_and_Warning.h"

#include "mpiDeclaration.h"

#include "Unit_EditorManager.h"
#include "Unit_EditorManager_add1.h"                 // ---
#include "Unit_EditorManager_SelectedList.h"
#include "Unit_EditorManager_Drag_and_Drop.h"        // ---
#include "Unit_EditorManager_Image_Mouse_Events.h"
#include "Unit_EditorManager_Links.h"
#include "Unit_EditorManager_DeleteElements.h"
#include "Unit_ProjectParameters.h"
//===========================================================================
#pragma resource "*.dfm"
TfrmEditorManager *frmEditorManager;
//===========================================================================
/*void TfrmEditorManager_init() { Beep(); }
#pragma startup TfrmEditorManager_init 110 // default 100*/
//===========================================================================
//===========================================================================
void SetEditoManagerFormCaption()
{
   // ------- Базовая строка ------
      AnsiString BaseString = "DiALab - [ " + ExtractFileName(ElementList[0]->Caption);
      BaseString.SetLength(BaseString.Length() - 4);
      BaseString = BaseString + " ]";

   // --------------- Нохожу все подсистемы и меняю им Саптионы ------
      for (int i = 0; i < ElementList_Count; i++) {

            if (ElementList[i]->ClassName == "TSubSystem") {
                  TElement **Ela       = NULL;   // ---- От ветки до корня (дерево подсистем ) ---
                  TElement  *ele       = ElementList[i];
                  int        Ela_Count = 0;
                  while (ele->ParentId != -1) {
                     Ela = (TElement**) realloc (Ela, sizeof(TElement*) * (++ Ela_Count));
                     Ela[Ela_Count - 1] = ele;

                    ele = FindElementByID(ele->ParentId);
                     if (ele->ParentId == -1) break;
                  }
                  AnsiString ResultString = BaseString;
                  for (int i = Ela_Count - 1; i >= 0; i--) ResultString = ResultString + "\\" + Ela[i]->Caption;
                // -----
                  free (Ela);
                // -----
                  ((TSubSystem*)ElementList[i])->EditorManager->Caption = ResultString;
            }
      }
}
//===========================================================================
__fastcall TfrmEditorManager::TfrmEditorManager(TComponent* Owner)
        : TForm(Owner)
{
  // --------- Для быстроты отрисовки делаю то, что ниже ------------
     FonBitmap            = new Graphics::TBitmap;
     FonBitmap_Canvas     = FonBitmap->Canvas;

     RedrawBitmap         = new Graphics::TBitmap;
     RedrawBitmap_Canvas  = RedrawBitmap->Canvas;

  // ---------

     NetStep               = 12;

     SelectedList          = NULL;
     RectList              = NULL;
     SelectedList_Count    = 0;

     sbHorizontal->SmallChange = NetStep;
     sbVertical  ->SmallChange = NetStep;

     MouseDown                  = false;
}

//===========================================================================
void __fastcall TfrmEditorManager::FormDestroy(TObject *Sender)
{
     Free_SelectedList();
  // ----------
     delete FonBitmap;
     delete RedrawBitmap;
  // ----------
     FonBitmap = NULL;
     RedrawBitmap = NULL;
}

//===========================================================================
void __fastcall TfrmEditorManager::Image1DblClick(TObject *Sender)
{
      if (!Stoped) { Warning_if_Model_Is_Runnig(Handle); return; }

   // ----------- Если на связи то редактируем свойства связи -----
      if (MouseLink    != NULL) {
         // ---- Если связь замкнута (тобишь всьо подключено) , тогла -----
           if (MouseLink->FirstElement != NULL && MouseLink->SecondElement != NULL)

                // ---- Если второй елемент не ВЫХОД тогда редактируем связь -----
                // ---- потомучто "Выходные связи" проставляю цвета выходов автоматически -----
                     if (MouseLink->SecondElement->ClassName != "TOutElementStandart" || !ManagerParam.AutoLinkColor) {
                           MouseLink->Edit();
                           Draw();
                           WhatDo = wdEdit;
                           return;
                     } else Warning_Edit_Link_Properties(Handle);
      }

   // -----------

      if (MouseElement == NULL) { Draw(); return; }
   // -----------
      bool flag1 = false;
      bool flag2 = false;

   // ---- Есди двойное нажатие на редакторе произошло на "подсистеме" тогда ее открываем ---------
      if (MouseElement->ClassName == "TSubSystem") {
          ((TSubSystem*)MouseElement)->Open = true;
          flag1 = true;
      }

   // ---- Есди двойное нажатие на редакторе произошло на "выходе" тогда его открываем ---------
      if (MouseElement->ClassName == "TOutElementStandart") {
          ((TfrmOutPutStandart*)((TOutElementStandart*)MouseElement)->frmOutPut)->Show();
            flag2 = true;
      }


   // ---- Если ничего сверху не бахнуло, тогда редактируем елемент -----
      if ( !flag1 && !flag2 ) {
          MouseElement->Edit();
          MouseElement->NeedRedraw = true;
          MouseElement->VisualElementParam->SetGraphicsParam();
          WhatDo = wdEdit;
      }

   // -----------
      if (MouseElement->NeedRedraw)
           Draw();

   // -- Коментрарий : после редактировании свойств Подписи ПодСистемы нужно произвести по всем формам выставку Каптиона форм
   // -- для этогшо исползуем
   // -- SetEditoManagerFormCaption()
}

//===========================================================================
void __fastcall TfrmEditorManager::aAllAction(TObject *Sender)
{
 //----------@@@@
    switch ( ((TControl*)Sender)->Tag) {
        case 101 :  /**/ break; // --- Print Scheme ----
        case 102 :  Visible = false; break; // --- Close Scheme ----

        case 201 :  if (Stoped) Action_DeleteElements(); break;
        case 202 :  if (Stoped) Action_RotateElements(); break;
        case 203 :  if (Stoped) Action_SelectAll();      break;
        case 204 :  if (Stoped) Action_FogElement();     break;
        case 205 :              Action_ParamElement();   break;

        case 301 :  frmProjectParameters->ShowModal(); break; // --- Parameters ----
        case 302 :  Free_SelectedList(); aStart->Enabled = false; aPause->Enabled =  true; aStop->Enabled = true ; Paused = false;         Stoped = false; tbPause->Down = false; Action_RunModel(); aAllAction(aStop); break; // --- Run Scheme ----
        case 303 :  aStart->Enabled = false; aPause->Enabled =  true; aStop->Enabled = true ; Paused = tbPause->Down; Stoped = false; break; // --- Pause Scheme ----
        case 304 :  aStart->Enabled = true ; aPause->Enabled = false; aStop->Enabled = false; Paused = false;         Stoped = true;  tbPause->Down = false; break; // --- Stop Scheme ----

        case 400 :   for (int i = 0; i < ElementList_Count; i++) {
                         if (ElementList[i]->ClassName == "TOutElementStandart") {
                             if (tbShowAllWindow->Down) ((TOutElementStandart*)ElementList[i])->frmOutPut->Show();
                                 else ((TOutElementStandart*)ElementList[i])->frmOutPut->Close();
                         }
                     } break; // --- 
    }

    WhatDo = wdNone;
}

//===========================================================================
void TfrmEditorManager::Action_RunModel()
{
//      AnalogT0 = StrToFloat(Edit1->Text);
    // ---------
             /* TODO 5 : Нада поправить */
       /*for (int i = 0; i < iPoint->Items_Count; i++) {
         iPoints->Items[i]->
         }
              mpiSeries[i]->Init();

            // ---- Выделяю память под грайики -----
              mpiSeries[i]->XValues = (TFloat*) malloc (sizeof(TFloat) * (*pEndCalcTime / *pAnalogT0 + 2));
              mpiSeries[i]->YValues = (TFloat*) malloc (sizeof(TFloat) * (*pEndCalcTime / *pAnalogT0 + 2));
       } */

    // ---------
      CGauge1->Progress = 0;
      CGauge1->MaxValue = ProjectParam.EndCalcTime;
    // ---------
      Running = true;
      Stoped  = false;
      Paused  = false;
    // ---------
      TimeRun(CGauge1, pTimer);
    // ---------
      Beep();
}

//===========================================================================
void TfrmEditorManager::Action_RotateElements()
{
  if (WhatDo != wdNone && WhatDo != wdMenuPopup) return;

      AnsiString as;
   // -----
      for (int i = 0; i < SelectedList_Count; i ++){
           if (SelectedList[i]->ClassName != "TLink") {
              ((TElement*)SelectedList[i])->RotateElemenet();
              ((TElement*)SelectedList[i])->NeedRedraw = true;
           }
      }
   // -----
      Draw();
   // -----
      ProjectModified = true;
}

//===========================================================================
void TfrmEditorManager::Action_SelectAll()
{
  // --- 1. нужно снять выделение с выделенных элементов ------
      Free_SelectedList();

  // --- 2. нужно найти все элементы пренадлежащие текущему Саб Сыстэм ----------
      // --- Цикл по связям -----
         for (int i = 0; i < ElementList_Count; i++)
            if (ElementList[i]->ParentId == IdCurrentSubSystemManager)
               SelectedList_ItemAdd(ElementList[i]);
      // --- Цикл по линкам -----
         for (int i = 0; i < LinkList_Count; i++)
            if (LinkList[i]->ParentId == IdCurrentSubSystemManager)
               SelectedList_ItemAdd(LinkList[i]);
}

//===========================================================================
void TfrmEditorManager::Action_FogElement()
{
     if (SelectedList == NULL) return;
     for (int i = 0; i < SelectedList_Count; i ++ ){
             ((TElement*)SelectedList[i])->Shadow = !((TElement*)SelectedList[i])->Shadow;
             ((TElement*)SelectedList[i])->NeedRedraw = true;
     }
     aFogElement->Checked != aFogElement->Checked;
/*
     for (int i = 0; i < ElementList_Count; i ++ )
         if (ElementList[i]->ParentId  == IdCurrentSubSystemManager){
             ElementList[i]->Shadow = !ElementList[i]->Shadow;
             ElementList[i]->NeedRedraw = true;
         }
*/
     Draw();
   // --------
     ProjectModified = true;
}

//===========================================================================
void TfrmEditorManager::Action_ParamElement()
{
      if (!Stoped) { Warning_if_Model_Is_Runnig(Handle); return; }
   // -----------
      if (MouseElement == NULL && SelectedList_Count != 1) return;

   // -----------
      SelectedList[SelectedList_Count - 1]->Edit();
      //MouseElement->Edit();
      WhatDo = wdEdit;

   // ---- Если редактируемы елемент "TOutElementStandart" тогда если надо раставляем цвета связей ---------
      if (MouseElement != NULL)
            if (MouseElement->ClassName == "TOutElementStandart")
                 for (int i = 0; i < LinkList_Count; i++)
                     if (LinkList[i]->SecondElement == SelectedList[SelectedList_Count - 1])
                             LinkList[LinkList_Count - 1]->LinkPenColor =
                                      ((TOutElementStandart*)SelectedList[SelectedList_Count - 1])->mpiSeries[LinkList[i]->NumberInput]->Color;

                                      //((TOutElementStandart*)SelectedList[SelectedList_Count - 1])->mpiSeries[LinkList[LinkList_Count - 1]->NumberInput]->Color;

   // -----------
      if (((TElement*)SelectedList[SelectedList_Count - 1])->NeedRedraw) Draw();

   // -----------
      ProjectModified = true;
}

//===========================================================================
void __fastcall TfrmEditorManager::FormCloseQuery(TObject *Sender,
      bool &CanClose)
{
      CanClose = aClose->Enabled;

      if (CanClose) Free_SelectedList();
}

//===========================================================================
void __fastcall TfrmEditorManager::PaintBox1Paint(TObject *Sender)
{
  // ---------------------
     PaintBox1->Canvas->Draw(0,0,RedrawBitmap);

     if (ProjectError) return;

//     Caption = ++aaGLobC;

  // ---------------- Отрисовка Отрисовка выделенных элементов, если есть такие --------
     for (int i = 0; i < ElementList_Count; i++)
         if (ElementList[i] != NULL)
          if (ElementList[i]->ParentId == IdCurrentSubSystemManager && ElementList[i]->SelectedParam.Selected)
                 ElementList[i]->Draw_SelectedElement(PaintBox1->Canvas);

//     PaintBox1->Canvas->Draw(0, 0, RedrawBitmap);
}

//===========================================================================
void __fastcall TfrmEditorManager::tbWorkDblClick(TObject *Sender)
{
   ElementList[0]->NeedRedraw = true;
   Draw();
}
//===========================================================================


//===========================================================================
void __fastcall TfrmEditorManager::FillElementGlobalParam (TElement **aElement, AnsiString aClassName, int aParentID)
{
     int aCreateAdress = GetCreateAddressByClassName(aClassName);


     *aElement                     = ( (CreateElement) aCreateAdress)();                       // ---------- Создаю экземпля класса -------

     (*aElement)->pManagerParam      =  &ManagerParam;
     (*aElement)->pProjectParam      =  &ProjectParam;
     (*aElement)->pCurModelTime      =  &CurModelTime;

     (*aElement)->pElementList       =  &ElementList;
     (*aElement)->pElementList_Count =  &ElementList_Count;
     (*aElement)->pLinkList          =  &LinkList;
     (*aElement)->pLinkList_Count    =  &LinkList_Count;

     (*aElement)->ParentId      =   aParentID;                                              // ---- Запоминаем какой подсистеме принадлежит элемент ------
     (*aElement)->Id            =  (*aElement)->pProjectParam->GlobalElementCounter++;        // ---- Айди нового елемента (pProjectParam - глобальная структура - поетому и делаем так) ------
     (*aElement)->CreateAdress  =   aCreateAdress;                                          // ---- Созданому елементу присваиваем адрес статического конструктора ----
     (*aElement)->ClassName     =   aClassName;                                             // ---- Имя класса -------------

}

