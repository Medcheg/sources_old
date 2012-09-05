//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <ActnList.hpp>
#include <FileCtrl.hpp>
#include <Dialogs.hpp>
#include <Graphics.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include <ExtDlgs.hpp>
#include <Menus.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TControlBar *cbMainMenu;
        TToolBar *tbMainMenu;
        TToolButton *tbFile;
        TToolButton *tbAbout;
        TControlBar *cbWork;
        TToolBar *tbWork;
        TSpeedButton *tbExit;
        TToolButton *ToolButton29;
        TToolButton *ToolButton1;
        TSpeedButton *sbRunStatic;
        TToolButton *ToolButton3;
        TStatusBar *StatusBar1;
        TActionList *ActionList1;
        TAction *aStartStatic;
        TPanel *Panel1;
        TPageControl *PageControl1;
        TTabSheet *TabSheet1;
        TTabSheet *TabSheet2;
        TPanel *Panel3;
        TLabel *Label6;
        TFileListBox *FileListBox1;
        TAction *aEsktrapoling;
        TLabel *Label2;
        TEdit *eMaxGorizontDistance;
        TLabel *Label3;
        TEdit *eMaxVerticalDistance;
        TLabel *Label5;
        TLabel *Label4;
        TCheckBox *cbEsktrapoling;
        TPanel *pBgColor;
        TLabel *Label22;
        TPanel *pAxesColor;
        TLabel *Label23;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label12;
        TEdit *eBasicDistance;
        TEdit *eShirLuch;
        TEdit *eEpsLuch;
        TEdit *eHa;
        TLabel *Label1;
        TLabel *Label16;
        TLabel *Label17;
        TLabel *Label20;
        TColorDialog *ColorDialog1;
        TAction *aBgColor;
        TAction *aAxesColor;
        TAction *aAbout;
        TCheckBox *cbAnglesLine;
        TAction *aAnglesLine;
        TCheckBox *cbChangingAngleNet;
        TLabel *Label25;
        TLabel *Label26;
        TTabSheet *TabSheet3;
        TRadioButton *rbSeaSurfaceShumMeter;
        TEdit *eSeaSurfaceShumMeter;
        TLabel *Label11;
        TLabel *Label27;
        TLabel *Label28;
        TEdit *eLa;
        TLabel *Label29;
        TLabel *Label30;
        TLabel *Label31;
        TLabel *Label32;
        TEdit *eLj;
        TLabel *Label33;
        TLabel *Label34;
        TEdit *eRe;
        TLabel *Label35;
        TLabel *Label36;
        TBevel *Bevel2;
        TBevel *Bevel3;
        TTabSheet *TabSheet4;
        TBevel *Bevel4;
        TLabel *Label15;
        TCheckBox *cbOtherPd;
        TLabel *Label10;
        TLabel *Label13;
        TLabel *Label18;
        TTabSheet *TabSheet5;
        TBevel *Bevel5;
        TCheckBox *cbCalcBaseDistance;
        TLabel *Label14;
        TEdit *eTargetEPR;
        TLabel *Label21;
        TLabel *Label37;
        TRadioButton *rbFljuk0;
        TRadioButton *rbFljuk1;
        TRadioButton *rbFljuk2;
        TRadioButton *rbFljuk3;
        TRadioButton *rbFljuk4;
        TLabel *Label38;
        TLabel *Label39;
        TEdit *eOmegaA;
        TLabel *Label40;
        TLabel *Label41;
        TLabel *Label42;
        TLabel *Label43;
        TLabel *Label44;
        TComboBox *ComboBox1;
        TSpeedButton *SpeedButton1;
        TLabel *Label45;
        TEdit *ePt;
        TLabel *Label46;
        TLabel *Label47;
        TEdit *eGt;
        TLabel *Label48;
        TLabel *Label49;
        TEdit *eGr;
        TLabel *Label50;
        TLabel *Label51;
        TEdit *eDSink;
        TLabel *Label777;
        TEdit *eNFSink;
        TLabel *Label55;
        TEdit *eBSink;
        TLabel *Label56;
        TLabel *Label57;
        TEdit *eASink;
        TLabel *Label58;
        TLabel *Label59;
        TEdit *eLt;
        TLabel *Label60;
        TLabel *Label61;
        TEdit *eLr;
        TLabel *Label62;
        TLabel *Label63;
        TEdit *eLs;
        TLabel *Label64;
        TLabel *Label65;
        TEdit *eDeltaGa;
        TLabel *Label66;
        TLabel *Label67;
        TLabel *Label68;
        TBevel *Bevel1;
        TEdit *eSeaSurfaceShumBall;
        TRadioButton *rbSeaSurfaceShumBall;
        TEdit *eLambda;
        TCheckBox *cbAutoMaxGorizontalDistance;
        TLabel *Label19;
        TEdit *eVerticalAxisValueStep;
        TLabel *Label52;
        TLabel *Label53;
        TEdit *eGorizontalAxisValueStep;
        TLabel *Label69;
        TAction *aStartDynamic;
        TLabel *Label71;
        TLabel *Label72;
        TEdit *eAWave;
        TLabel *Label73;
        TLabel *Label74;
        TEdit *eFWave;
        TLabel *Label75;
        TLabel *Label76;
        TEdit *eFiWave;
        TLabel *Label77;
        TImage *Image1;
        TSpeedButton *sbRunDynamic;
        TSpeedButton *sbStopDynamic;
        TAction *aStopModelling;
        TSpeedButton *SpeedButton2;
        TAction *aSavePicture;
        TToolButton *ToolButton2;
        TToolButton *ToolButton4;
        TSavePictureDialog *SavePictureDialog1;
        TAction *aDeleteFile;
        TPopupMenu *PopupMenu1;
        TMenuItem *aDeleteFile1;
        TAction *aRenameFile;
        TMenuItem *N1;
        TCheckBox *cbAutoMaxVerticalDistance;
        TLabel *Label24;
        TPanel *pFontColor;
        TLabel *Label79;
        TPanel *pBackupColor;
        TBevel *Bevel6;
        TBevel *Bevel7;
        TBevel *Bevel8;
        TBevel *Bevel9;
        TButton *Button1;
        TPopupMenu *PopupMenu2;
        TMenuItem *N2;
        TMenuItem *N3;
        TMenuItem *N4;
        TMenuItem *N5;
        TOpenDialog *OpenDialog1;
        TSaveDialog *SaveDialog1;
        TSpeedButton *sbSetDefaulProjectParam;
        TToolButton *ToolButton5;
        TLabel *Label54;
        TToolButton *tbSetting;
        TPopupMenu *PopupMenu3;
        TImageList *ImageList1;
        TMenuItem *Russian1;
        TMenuItem *English1;
        TComboBox *cbPfa;
        TComboBox *cbPd;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall aAllAction(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall FormPaint(TObject *Sender);
        void __fastcall cbCalcBaseDistanceClick(TObject *Sender);
        void __fastcall rbSeaSurfaceShumBallClick(TObject *Sender);
        void __fastcall rbSeaSurfaceShumMeterClick(TObject *Sender);
        void __fastcall cbAutoMaxGorizontalDistanceClick(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall aSavePictureExecute(TObject *Sender);
        void __fastcall FileListBox1Change(TObject *Sender);
        void __fastcall aDeleteFileExecute(TObject *Sender);
        void __fastcall FileListBox1DblClick(TObject *Sender);
        void __fastcall cbAutoMaxVerticalDistanceClick(TObject *Sender);
        void __fastcall N2Click(TObject *Sender);
        void __fastcall N3Click(TObject *Sender);
        void __fastcall LanguageClick(TObject *Sender);
protected:
        void __fastcall SetMinMaxSizeForm(TWMGetMinMaxInfo &Message);
                        BEGIN_MESSAGE_MAP
                             MESSAGE_HANDLER(WM_GETMINMAXINFO, TWMGetMinMaxInfo, SetMinMaxSizeForm);
                        END_MESSAGE_MAP(TForm);
private:	// User declarations
        TFloat          AWave, FWave, FiWave;
        bool            Stoped;

        TWinControl *fLastFocusedControl;
        void __fastcall WM_AppMessage(tagMSG &Msg, bool &Handled);
        void            SetProjectParam();
        bool            CheckInputParam();
        void            ShowWrongEdit(TEdit *aEdit);
        void            RunModel();
        void            RunDynamicModel();
        void            Set_DefaultParam();
        void            Set_Language();
public:		// User declarations

        __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif