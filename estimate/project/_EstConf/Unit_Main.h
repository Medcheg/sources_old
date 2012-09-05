//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <Buttons.hpp>
#include <ActnList.hpp>
#include <Menus.hpp>
#include <ImgList.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TControlBar *ControlBar1;
        TToolBar *tbMainMenu;
        TToolButton *tbFile;
        TToolButton *tbEdit;
        TControlBar *ControlBar2;
        TToolBar *ToolBar2;
        TToolButton *ToolButton5;
        TToolButton *ToolButton6;
        TToolButton *ToolButton7;
        TToolButton *ToolButton8;
        TToolButton *ToolButton9;
        TToolButton *ToolButton10;
        TToolButton *ToolButton11;
        TToolButton *tbHelp;
        TPopupMenu *pmHelp;
        TMenuItem *miHelp;
        TMenuItem *miNull1;
        TMenuItem *miAbout;
        TPanel *pBack;
        TStatusBar *StatusBar1;
        TActionList *ActionList1;
        TAction *aHelp;
        TAction *aAbout;
        TAction *aSaveBase;
        TAction *aLoadOldBaseMaterial;
        TImageList *ImageList1;
        TOpenDialog *OpenDialog1;
        TBevel *Bevel1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label1;
        TLabel *Label6;
        TTreeView *tvMainTree;
        TToolBar *ToolBar3;
        TToolButton *tbElement1;
        TToolButton *tbWork1;
        TToolButton *tbData11;
        TAction *aPressMaterial;
        TPanel *ppppppTemp;
        TLabel *Label30;
        TLabel *Label31;
        TLabel *Label32;
        TCheckBox *cbExcelEnable;
        TPopupMenu *pmFile;
        TMenuItem *N1;
        TMenuItem *miNull2;
        TMenuItem *miNull3;
        TMenuItem *N2;
        TAction *aExit;
        TMenuItem *N3;
        TImageList *ilActionList;
        TAction *aPressWork;
        TAction *aPressElement;
        TAction *aCopy;
        TAction *aPaste;
        TAction *aCut;
        TPopupMenu *pmEdit;
        TMenuItem *N4;
        TMenuItem *N5;
        TMenuItem *N6;
        TMenuItem *miNull4;
        TAction *aFind;
        TAction *aReplace;
        TToolButton *ToolButton1;
        TToolButton *ToolButton2;
        TToolButton *ToolButton3;
        TToolButton *ToolButton4;
        TToolButton *ToolButton12;
        TToolButton *ToolButton13;
        TToolButton *ToolButton14;
        TMenuItem *miNull5;
        TMenuItem *Insert11;
        TMenuItem *Insert21;
        TMenuItem *Find11;
        TMenuItem *Find21;
        TAction *aAddElement;
        TMenuItem *Bigtri1;
        TAction *aAddSubElement;
        TAction *aBigTree;
        TAction *aLoadOldBaseWork;
        TMenuItem *N7;
        TToolBar *ToolBar1;
        TToolButton *ToolButton15;
        TToolButton *ToolButton16;
        TLabel *Label14;
        TPanel *pMaterial2;
        TLabel *Label15;
        TEdit *eName2;
        TToolBar *ToolBar4;
        TToolButton *tbElement2;
        TToolButton *tbData2;
        TBevel *Bevel2;
        TLabel *Label5;
        TTreeView *tvMaterial;
        TPanel *pMaterial1;
        TLabel *Label10;
        TLabel *Label12;
        TLabel *Label13;
        TLabel *Label21;
        TLabel *Label22;
        TLabel *Label23;
        TLabel *lMaterialName;
        TLabel *lMaterialPrice;
        TLabel *lMaterialDimension;
        TLabel *lCatalogNumber;
        TLabel *lNomenklatNumber;
        TLabel *Label24;
        TLabel *lParent;
        TCheckBox *cbBlockParamCountUEPOD;
        TCheckBox *cbCompareRoomHeight;
        TPanel *pWork;
        TLabel *Label8;
        TEdit *eName1;
        TToolButton *ToolButton17;
        TPanel *Panel1;
        TLabel *Label4;
        TLabel *Label9;
        TEdit *eWorkDimension;
        TPanel *Panel2;
        TLabel *Label17;
        TLabel *Label18;
        TLabel *Label19;
        TLabel *Label20;
        TLabel *Label25;
        TLabel *Label40;
        TEdit *eDimension2;
        TEdit *eCatalogNumber2;
        TEdit *eNomenklatNumber2;
        TEdit *eParent2;
        TTreeView *tvEnergo;
        TToolButton *tbData12;
        TLabel *Label7;
        TLabel *lUEM_UER2;
        TTreeView *tvMashine;
        TToolButton *tbWork2;
        TToolButton *ToolButton18;
        TToolButton *ToolButton19;
        TEdit *eScaleFactorMaterial;
        TEdit *ePriceMaterial;
        TEdit *eWorkPrice;
        TEdit *eCoefRashod;
        TLabel *Label11;
        TButton *Button1;
        TTimer *SecureTimer;
        TButton *Button2;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall Change_Element_Property(TObject *Sender);
        void __fastcall aAllActions(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall Change_Data_Property(TObject *Sender);
        void __fastcall tvDeletion(TObject *Sender, TTreeNode *Node);
        void __fastcall tvDragOver(TObject *Sender, TObject *Source, int X, int Y, TDragState State, bool &Accept);
        void __fastcall tvDragDrop(TObject *Sender, TObject *Source, int X, int Y);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall tvExit(TObject *Sender);
        void __fastcall tvMouseDown(TObject *Sender,
          TMouseButton Button, TShiftState Shift, int X, int Y);
        void __fastcall Label30Click(TObject *Sender);
        void __fastcall tvChange(TObject *Sender, TTreeNode *Node);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall SecureTimerTimer(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
private:
        bool         ControlKeyDown;
        TWinControl *fLastFocusedControl;

        void Set_Element_Param();
        void Set_Data_Param();
        void Show_ID(TElement *el);

        void Enable_Disable_ElementBlock(bool flag);
        void Enable_Disable_DataBlock(bool flag);
///////////////////////////
        void Execute_Trash_Action();
        void Execute_Copy_Action();
        void Execute_Paste_Action();
        void Execute_Find_Action();
        void Execute_Replace_Action();
        void Execute_AddElement_Action(int aTag);
        void Execute_BigTree_Action();
        void Set_Action_Enabled();
///////////////////////////
        void __fastcall WM_Control(tagMSG &Msg, bool &Handled);
public:		// User declarations
        __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif
