//===========================================================================
#ifndef Unit_MainH
#define Unit_MainH
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Menus.hpp>
#include <ExtCtrls.hpp>
#include <ComCtrls.hpp>
#include <Buttons.hpp>
#include <CheckLst.hpp>
#include <Dialogs.hpp>
//===========================================================================
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
    TStatusBar *StatusBar1;
    TPanel *pBGround;
    TPanel *pChart;
    TPanel *pManager;
    TMemo *mConsole;
    TLabel *Label9;
    TTrackBar *TrackBar1;
    TPanel *pLeft;
    TButton *bStart;
    TButton *bStop;
    TRadioGroup *rgVoltScales;
    TRadioGroup *rgTimeScales;
    TLabel *Label1;
    TLabel *Label10;
    TMainMenu *MainMenu1;
    TMenuItem *miFile;
    TMenuItem *miSettings;
    TMenuItem *miAnaliz;
    TMenuItem *miAbout;
    TMenuItem *miDataOpen;
    TMenuItem *miDataSave;
    TMenuItem *N3;
    TMenuItem *N4;
    TButton *bAutoPosition;
    TOpenDialog *OpenDialog1;
    TSaveDialog *SaveDialog1;
    TPanel *Panel2;
    TCheckListBox *CheckListBox1;
    TPanel *Panel1;
    TLabel *Label8;
    TColorBox *cbCanal;
    TPanel *Panel3;
    TButton *bAddCanals;
    TButton *bSubCanals;
    TMenuItem *N1;
    TMenuItem *miPostojanka;
    void __fastcall FormCreate  (TObject *Sender);
    void __fastcall FormDestroy (TObject *Sender);
    void __fastcall bStartClick(TObject *Sender);
    void __fastcall bStopClick(TObject *Sender);
    void __fastcall miSettingsClick(TObject *Sender);
    void __fastcall pBGroundResize(TObject *Sender);
    void __fastcall FormPaint(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall CheckListBox1Click(TObject *Sender);
    void __fastcall cbCanalChange(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    void __fastcall rgTimeScalesClick(TObject *Sender);
    void __fastcall rgVoltScalesClick(TObject *Sender);
    void __fastcall miDataOpenClick(TObject *Sender);
    void __fastcall miDataSaveClick(TObject *Sender);
    void __fastcall bAutoPositionClick(TObject *Sender);
    void __fastcall N4Click(TObject *Sender);
    void __fastcall bAddCanalsClick(TObject *Sender);
    void __fastcall miAnalizClick(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
    void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
    void __fastcall miPostojankaClick(TObject *Sender);
private:	// User declarations
        LARGE_INTEGER qPerfCounter1, qPerfCounter2, qPerfFreq;
        int           DrawFPS;
        bool          ifAutoPositionInit;   

        void SetInterfaceParam();
        void ReadDataFromRegistry();
        void SaveDataToRegistry();
        void SetCaption();
        void __fastcall Idle(System::TObject* Sender, bool &Done);
public:		// User declarations
        __fastcall TfrmMain(TComponent* Owner);
};

//===========================================================================
extern PACKAGE TfrmMain *frmMain;
//===========================================================================
#endif
