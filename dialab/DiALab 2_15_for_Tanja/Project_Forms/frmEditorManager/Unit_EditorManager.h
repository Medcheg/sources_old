//---------------------------------------------------------------------------

#ifndef Unit_EditorManagerH
#define Unit_EditorManagerH
//---------------------------------------------------------------------------

#include "CGAUGES.h"
#include <ActnList.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <StdCtrls.hpp>
#include <ToolWin.hpp>

#include "mpiElement.h"
#include "mpiLink.h"
// ----------- НИже параметры выведены глобальными (может это не коректно , но уже сделал, что уж говорить) -----------
enum TWhatDo          {wdNone, wdMove, wdResize, wdCopy, wdAllSelected, wdLink, wdEdit, wdMenuPopup};
//---------------------------------------------------------------------------
class TfrmEditorManager : public TForm
{
__published:	// IDE-managed Components
        TStatusBar *StatusBar1;
        TPanel *Panel1;
        TScrollBar *sbVertical;
        TControlBar *cbWork;
        TToolBar *tbWork;
        TSpeedButton *SpeedButton1;
        TToolButton *ToolButton3;
        TPanel *pTimer;
        TToolButton *ToolButton2;
        TSpeedButton *tbStart;
        TToolButton *ToolButton1;
        TSpeedButton *tbPause;
        TToolButton *ToolButton36;
        TSpeedButton *tbStop;
        TToolButton *ToolButton6;
        TMainMenu *MainMenu1;
        TMenuItem *N222222221;
        TMenuItem *miPrintScheme;
        TMenuItem *miNULL1;
        TMenuItem *miClose;
        TMenuItem *N1;
        TMenuItem *N9;
        TMenuItem *N10;
        TMenuItem *N11;
        TMenuItem *N2;
        TMenuItem *N4;
        TMenuItem *N5;
        TMenuItem *N6;
        TMenuItem *N3;
        TActionList *ActionList1;
        TAction *aDeleteElement;
        TAction *aRotateElement;
        TAction *aPrintScheme;
        TAction *aClose;
        TAction *aParamters;
        TAction *aStart;
        TAction *aPause;
        TAction *aStop;
        TAction *aSelectAll;
        TImageList *ilActionList;
        TPanel *Panel2;
        TPanel *Panel3;
        TScrollBar *sbHorizontal;
        TCGauge *CGauge1;
        TPaintBox *PaintBox1;
        TPopupMenu *PopupMenu1;
        TMenuItem *N12;
        TMenuItem *N13;
        TMenuItem *N14;
        TAction *aFogElement;
        TAction *aParamElement;
        TMenuItem *N15;
        TMenuItem *N16;
        TMenuItem *N17;
        TMenuItem *N18;
        TMenuItem *N19;
        TMenuItem *N20;
        TMenuItem *N21;
        TMenuItem *N22;
        TMenuItem *N7;
        TToolButton *tbShowAllWindow;
        TAction *aShowAllWindow;
        void __fastcall Image1DragDrop(TObject *Sender, TObject *Source,
          int X, int Y);
        void __fastcall Image1DragOver(TObject *Sender, TObject *Source,
          int X, int Y, TDragState State, bool &Accept);
        void __fastcall sbChange(TObject *Sender);
        void __fastcall pBackGroundResize(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall Image1MouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
        void __fastcall Image1MouseDown(TObject *Sender,
          TMouseButton Button, TShiftState Shift, int X, int Y);
        void __fastcall Image1MouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
        void __fastcall Image1DblClick(TObject *Sender);
        void __fastcall aAllAction(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall PaintBox1Paint(TObject *Sender);
        void __fastcall tbWorkDblClick(TObject *Sender);
private:	// User declarations
        Graphics::TBitmap   *FonBitmap;      // ------ Фоновое ихображение --------
        TCanvas             *FonBitmap_Canvas;
        Graphics::TBitmap   *RedrawBitmap;   // ------ Битмап отрисовки информации -----
        TCanvas             *RedrawBitmap_Canvas;
        //Graphics::TBitmap   *Image1_Bitmap;
        //TCanvas             *Image1_Canvas;

      // ------- Эти параметры наверно должны быть глобальными -----------

        int                   NetStep;

      // ------- Списки элементов --------
        TBaseClass          **SelectedList;                               // --- Список выделенных елементов на редакторе ----
        TRect                *RectList;                                   // --- Список квадратов ----
        TRect                *OldRectList;                                // --- Список квадратов ----
        int                   SelectedList_Count;                         // --- Количество элементов в списке выделенных элементов ----

      // -------
        TMouseParam           mp;                                         // --- Где крыса на редакторе -----
        TWhatDo               WhatDo;                                     // --- Что сейчас делаем на редакторе -----
      // -------
        TElement           *MouseElement;
        TLink              *MouseLink;


        bool                  MouseDown;                                         // --- Флаг отображающий нажатую клавишу мыши ------

/*        TPoint                OldMouseDownPos;                                       // --- Старая позиция мыши нажатой  ---
        TRect                 OldMousePositionWhenSelect;                        // --- Предыдущая Позиция указаля мыши когда идет выделения фрагмента ---
        TPoint                fMouseDownPos;                                     // --- Оконные координаты нажатия мышм на экране ----
        TPoint                fMousePos;                                         // --- Оконные координаты мышм на экране ----
        TPoint                OldMousePos;
        int                  *OffsetX;*/

     // --------- Внутренние функции ------------
        void                  ShowMouseInforation();
        int                   GetElementIndex(TBaseClass *aEl);
        void                  CheckWhereMouse(int xPos, int yPos);                                 // ---- Опредиление местоположения крысы (Элемент, Линк, Нигде) ---м
        void                  SetMouseCoordinat(int aX, int aY);
        TPoint                Get_MouseCoordinatBinding(int aX, int aY);


     // --------
        void                  FindElementInSelectedRegion(TRect ar);

     // --------
        void                  Free_SelectedList();                           // --- Удалить список выделенных элементов ----
        bool                  SelectedList_ItemPresent(TBaseClass *aElement);  // ---- Возвращает ТРУЕ если элемент присутсвует в списке выделенных элементов ---
        void                  SelectedList_ItemDelete (TBaseClass *aElement);  // ---- Удаляет заданый элемент из списка выделенных элементов ----
        void                  SelectedList_ItemAdd    (TBaseClass *aElement);  // ---- Удаляет заданый элемент из списка выделенных элементов ----

     // --------

      // ----------- ПРоцедуры для юнита "Unit_EditorManager_Image_Mouse_Events" ------------
        void                 SetDefaultScreenDragElementRect();
        void                 End_Move_Event();
        void                 End_Resize_Event();
        void                 End_AllSelected_Event();
        void                 End_CopyElement_Event();

        void                 SelectRegion(TPoint bPoint, TPoint ePoint);
        void                 ResizeOneConerElement(TElement *aElement, int aX, int aY);
        void                 MoveListOfElement    ();

     // ---------------------------- Фукции работы со связями ---------------
        void                 DrawRealTimeLink();
        void                 CreateLink (int aParentId);
        void                 CreateLink_SetFirstElement (int aNumberOut, TElement *aFirstElement);
        void                 CreateLink_SetSecondElement(int aNumberIn , TElement *aSecondElement);
        void                 AddLinkPoint(int aSx, int aSy);
        void                 BeginLink                (TElement *aMouseElement);
        void                 EndLink                  (TElement *aMouseElement);
        void                 EndLinkWhenMouseOnElement(TElement *aMouseElement);
        void                 EndMove_Event();
        void                 DeleteCurrenetLink();


     // ------------
        void                 PackList(TBaseClass **&aList, int &aCount);
//        void                 SetNullItemInElementList(TBaseClass *aElement);
     // ------------
        void                 Action_RunModel();
        void                 Action_RotateElements();
        void                 Action_SelectAll();
        void                 Action_FogElement();     
        void                 Action_ParamElement();
     // ------------
        void                 Action_DeleteElements();
        void                 Action_DeleteElements_CheckLinkToPressentElement(TBaseClass *aElement);
        void                 Action_DeleteElements_CheckElementToPressentLink(TLink *aLink);
        void                 Action_DeleteElements_DeleteElement(TBaseClass *aElement);
        void                 Action_DeleteElements_DeleteLinkFromSubSystem(TBaseClass *aSS, TBaseClass *aElement);

     // ------------
        void __fastcall FillElementGlobalParam (TElement **aElement, AnsiString aClassName, int aParentID);
public:		// User declarations
     // -------
        void         Draw();   // --- Полная ортрисовка ----
//        void         Draw_SelectedElement();
        void         SetFormCaption();
        int          IdCurrentSubSystemManager;

        int          aaGLobC;
        __fastcall TfrmEditorManager(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmEditorManager *frmEditorManager;
extern void SetEditoManagerFormCaption();
//---------------------------------------------------------------------------
#endif
