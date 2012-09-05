//===========================================================================
#ifndef Unit_MainH
#define Unit_MainH
//===========================================================================
#include <ActnList.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include <StdCtrls.hpp>
#include <ToolWin.hpp>
//===========================================================================
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TStatusBar *StatusBar1;
        TTreeView *TreeView1;
        TListBox *ListBox1;
        TRichEdit *RichEdit1;
        TControlBar *ControlBar2;
        TToolBar *ToolBar2;
        TToolButton *ToolButton4;
        TToolButton *ToolButton6;
        TToolButton *ToolButton5;
        TToolButton *ToolButton7;
        TToolButton *ToolButton8;
        TControlBar *ControlBar1;
        TToolBar *ToolBar1;
        TToolButton *tbFile;
        TToolButton *ToolButton2;
        TImageList *ImageList1;
        TImageList *ImageList2;
        TOpenDialog *OpenDialog1;
        TSaveDialog *SaveDialog1;
        TActionList *aMainMenu;
        TAction *aNewScheme;
        TAction *aLoadScheme;
        TAction *aSaveScheme;
        TAction *aSaveSchemeAs;
        TAction *aPrint;
        TPopupMenu *pmFile;
        TMenuItem *N771;
        TMenuItem *miNULL1;
        TMenuItem *N3;
        TMenuItem *N4;
        TMenuItem *N881;
        TMenuItem *N2;
        TMenuItem *N5;
        TMenuItem *miNULL2;
        TMenuItem *N1;
        TAction *aExit;
        TAction *aAbout;
        TTimer *TimerLogo;

        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall TreeView1Change(TObject *Sender, TTreeNode *Node);
        void __fastcall ListBox1DrawItem(Controls::TWinControl* Control, int Index, const TRect &aRect, TOwnerDrawState State);
        void __fastcall ListBox1DragOver(TObject *Sender, TObject *Source, int X, int Y, TDragState State, bool &Accept);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall aAllAction(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall ListBox1Click(TObject *Sender);
        void __fastcall RichEdit1Enter(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall TreeView1MouseUp(TObject *Sender,
          TMouseButton Button, TShiftState Shift, int X, int Y);
        void __fastcall TreeView1Collapsing(TObject *Sender,
          TTreeNode *Node, bool &AllowCollapse);
        void __fastcall TimerLogoTimer(TObject *Sender);
protected:
        void __fastcall SetMinMaxSizeForm(TWMGetMinMaxInfo &Message);
                        BEGIN_MESSAGE_MAP
                             MESSAGE_HANDLER(WM_GETMINMAXINFO, TWMGetMinMaxInfo, SetMinMaxSizeForm);
                        END_MESSAGE_MAP(TForm);
private:	// User declarations
        int             ResId; // ---- Результат диалога записи файла ----
        bool            EnabledTVModivication;

        void __fastcall ShowHint(TObject *Sender);
        void            SetupTreeView();
    // -------------------------
        void            NewScheme();
        void            DeleteScheme();

        int             ShowProjectSaveConfirmDialog();
        void __fastcall LoadProjectFromMenu(TObject *Sender);
        void            LoadProjectDialog();
        void            SaveProjectDialog();
        void            LoadProject(AnsiString aFileName);
        void            SaveProject(AnsiString aFileName);

    // ---------- Работа с реестром ---------
        void            LoadManagerParamFromRegistry();
        void            SaveManagerParamToRegistry();
        void            RegisterFileType(AnsiString prefix, AnsiString exepfad, int IconIndex);
        void            SaveDTSParam();

public:		// User declarations
        void            SetDefaultProjectParam();
        void            SetDefaultManagerParam();
        __fastcall TfrmMain(TComponent* Owner);
};
//===========================================================================
extern PACKAGE TfrmMain *frmMain;
//===========================================================================
#endif
