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
#include <Menus.hpp>
#include <Buttons.hpp>
#include <Dialogs.hpp>
#include <ImgList.hpp>
#include <ActnList.hpp>
//---------------------------------------------------------------------------
#include "Unit_LogoEstimate.h"
#include "mpiTypes.h"
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TControlBar *cbMainMenu;
        TToolBar *tbMainMenu;
        TToolButton *tbFile;
        TLabel *lTV1;
        TLabel *lMemo1;
        TBevel *Bevel1;
        TLabel *lMemo2;
        TLabel *lMemo3;
        TTreeView *tv1;
        TTreeView *tv2;
        TPanel *pElementName;
        TEdit *Edit1;
        TBitBtn *bbDeleteElement;
        TStatusBar *StatusBar1;
        TScrollBar *sb1;
        TMemo *Memo1;
        TMemo *Memo2;
        TPanel *Panel2;
        TLabel *Label8;
        TAnimate *Animate1;
        TSaveDialog *SaveDialog1;
        TOpenDialog *OpenDialog1;
        TTimer *Timer1;
        TPopupMenu *pmFile;
        TMenuItem *nNewSmeta;
        TMenuItem *N2;
        TMenuItem *nLoadSmeta;
        TMenuItem *nSaveSmeta;
        TMenuItem *N5;
        TMenuItem *nExportSmeta;
        TMenuItem *N3;
        TPopupMenu *pmParam;
        TMenuItem *nTreeInputParam;
        TMenuItem *N1;
        TMenuItem *N9;
        TMenuItem *N10;
        TMenuItem *N4;
        TMenuItem *nGloss;
        TMenuItem *nAdvabcedRezhim;
        TPopupMenu *PopupMenu3;
        TMenuItem *N7;
        TMenuItem *N8;
        TMenuItem *N6;
        TToolButton *tbEdit;
        TActionList *alMain;
        TAction *aExit;
        TPopupMenu *pmEdit;
        TAction *aCopy;
        TAction *aElementParameters;
        TAction *aPaste;
        TAction *aCut;
        TAction *aFind;
        TMenuItem *aCopy1;
        TMenuItem *aPaste1;
        TMenuItem *aCut1;
        TMenuItem *miNULL1;
        TMenuItem *aFind1;
        TAction *aTv1Click;
        TAction *aTv2Click;
        TPopupMenu *pm;
        TMenuItem *N11;
        TMenuItem *N12;
        TMenuItem *N13;
        TMenuItem *miNULL2;
        TAction *aDelete;
        TMenuItem *N14;
        TMenuItem *N15;
        TImageList *ImageList2;
        TPanel *pSpeedButtons;
        TSpeedButton *SpeedButton1;
        TSpeedButton *SpeedButton2;
        TSpeedButton *SpeedButton3;
        TSpeedButton *SpeedButton4;
        TSpeedButton *SpeedButton5;
        TSpeedButton *SpeedButton6;
        TSpeedButton *SpeedButton7;
        TSpeedButton *SpeedButton8;
        TPanel *pBig;
        TLabel *Label11;
        TLabel *Label12;
        TLabel *Label13;
        TLabel *lType;
        TLabel *lPrice;
        TLabel *lDimension;
        TLabel *Label17;
        TLabel *Label18;
        TLabel *lCountUEPOD;
        TLabel *lComplexity;
        TLabel *Label23;
        TLabel *lShowInExcel;
        TLabel *Label25;
        TLabel *lCatalogNumber;
        TLabel *Label27;
        TLabel *lNomenklatNumber;
        TLabel *Label29;
        TLabel *lParent;
        TLabel *Label40;
        TLabel *lCoefUEE_UER;
        TLabel *Label32;
        TLabel *lCoefRashod;
        TLabel *Label34;
        TLabel *lBlockParamCountUEPOD;
        TLabel *Label36;
        TLabel *lCompareRoomHeight;
        TImageList *ImageList1;
        TLabel *lProperty;
        TAction *aOpenProject;
        TAction *aSaveProject;
        TAction *aSaveProjectAs;
        TAction *aNewProject;
        TMenuItem *N16;
        TMenuItem *N17;
        TLabel *lModified;
        TBevel *Bevel2;
        TBevel *Bevel3;
        TBevel *Bevel4;
        TListBox *ListBox1;
        TLabel *lHint;
        TMenuItem *N18;
        TToolButton *ToolButton1;
        TAction *aProjectParameters;
        TMenuItem *N19;
        TMenuItem *N20;
        TAction *aExport;
        TTimer *SecureTimer;
        TLabel *lUrl;
        TPanel *ppppppTemp;
        TLabel *Label100;
        TLabel *Label101;
        TLabel *Label102;
        TLabel *Label103;
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall tvDeletion(TObject *Sender, TTreeNode *Node);
        void __fastcall tvDragDrop(TObject *Sender, TObject *Source,  int X, int Y);
        void __fastcall tvDragOver(TObject *Sender, TObject *Source, int X, int Y, TDragState State, bool &Accept);
        void __fastcall aAllAction(TObject *Sender);
        void __fastcall tvGetSelectedIndex(TObject *Sender,  TTreeNode *Node);
        void __fastcall sb1Change(TObject *Sender);
        void __fastcall SaveDialog1CanClose(TObject *Sender,   bool &CanClose);
        void __fastcall tv2Exit(TObject *Sender);
        void __fastcall tv1Change(TObject *Sender, TTreeNode *Node);
        void __fastcall Edit1Change(TObject *Sender);
        void __fastcall tv2KeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
        void __fastcall ListBox1MouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
        void __fastcall ElementsMouseMove(TObject *Sender,
          TShiftState Shift, int X, int Y);
        void __fastcall aElementParametersExecute(TObject *Sender);
        void __fastcall SecureTimerTimer(TObject *Sender);
        void __fastcall lUrlClick(TObject *Sender);
        void __fastcall lUrlMouseLeave(TObject *Sender);
        void __fastcall lUrlMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
protected:
        void __fastcall SetMinMaxSizeForm(TWMGetMinMaxInfo &Message);
                        BEGIN_MESSAGE_MAP
                             MESSAGE_HANDLER(WM_GETMINMAXINFO, TWMGetMinMaxInfo, SetMinMaxSizeForm);
                        END_MESSAGE_MAP(TForm);
private:	// User declarations
        void __fastcall MyLBWndProc_BLACK(TMessage &msg);
        void __fastcall MyLBWndProc_BLUE (TMessage &msg);
        void __fastcall MyLBWndProc_GREEN_Memo1(TMessage &msg);
        void __fastcall MyLBWndProc_GREEN_Memo2(TMessage &msg);
        void __fastcall MyLBWndProc_GREEN_Memo3(TMessage &msg);

        bool              isControlKeyDown;
        bool              isEscapeDown; 
        bool              isNewProject;
        TStringList      *sl1, *sl2, *sl3;

        AnsiString        ProjectFileName;
        AnsiString        ProjectCaption;
        TfrmLogoEstimate *frmLogoEstimate;


        TWinControl* fLastFocusedControl;
        void __fastcall ApplicationMessages(tagMSG &Msg, bool &Handled);
        void __fastcall LoadProjectFromMenu(TObject * Sender);

        void RegisterFileType(AnsiString prefix, AnsiString exepfad, byte IconIndex);
        void ResizingMainWindow(int aWidth, int aHeight);
        int  ShowConfirmDialogForSaveProject(HWND hWnd);
        void Show_ElementParam(TTreeView *atv);

        void NewProject();
        void OpenProject_With_Dialog();
        void OpenProject(AnsiString aProjectFileName);
        void SaveProject(AnsiString aProjectFileName);
        void SaveProjectAs();

        void SetScrollBarPosition(int aPosition);

        void ClearMemoAndStringList();
        void BeginUpdateMemoAndStringList();
        void EndUpdateMemoAndStringList();
        void ClearEditText();


        void ExcellExprort(TTreeView *tv);
        void OutReport_1();
        void OutReport_2();
        void OutReport_3();
        void OutReport_4();
public:		// User declarations
        void UpdateMemos();
        void SetRoomHeight(int aNewRoomHeight);
        __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif
