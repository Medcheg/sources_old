//===========================================================================

#ifndef Unit_MainH
#define Unit_MainH
//===========================================================================
#include <ActnList.hpp>
#include <Classes.hpp>
#include <Menus.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <StdCtrls.hpp>
//===========================================================================
#include "mpiTypes.h"
#include <ImgList.hpp>
#include <Buttons.hpp>
#include <Chart.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <Dialogs.hpp>
//===========================================================================
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TControlBar *cbMainMenu;
        TToolBar *tbMenu;
        TToolButton *tbFile;
        TToolButton *tbProjectParam;
        TControlBar *cbWork;
        TToolBar *tbWork;
        TStatusBar *sbWork;
        TTimer *Timer1;
        TToolButton *tbInputParam;
        TToolButton *tbAbout;
        TActionList *ActionList2;
        TAction *aExit;
        TPopupMenu *pmFile;
        TMenuItem *miLoadTargets;
        TAction *aLoadTargets;
        TMenuItem *miNULL4;
        TAction *aSaveDefaultParam;
        TMenuItem *N2;
        TMenuItem *miNULL5;
        TAction *aLoadParam;
        TAction *aSaveParam;
        TMenuItem *N4;
        TMenuItem *N5;
        TAction *aProjectParam;
        TPopupMenu *pmInputParam;
        TAction *aPsiWave;
        TAction *aTetaWave;
        TAction *aKursWave;
        TAction *aDeltaPsi;
        TAction *aDeltaTeta;
        TMenuItem *miPsiWave;
        TMenuItem *miTetaWave;
        TMenuItem *miFiWave;
        TMenuItem *miNULL3;
        TMenuItem *miDeltaPsi;
        TMenuItem *miDeltaTeta;
        TMenuItem *miDeltaStabPsi;
        TMenuItem *miAerodynamicsMoment;
        TAction *aSimulationDiagram;
        TAction *aTargetsParam;
        TAction *aAbout;
        TAction *aDynamicModelRun;
        TAction *aStaticModelRun;
        TToolButton *tbFarParam;
        TAction *aFarParam1;
        TMenuItem *miNULL6;
        TMenuItem *N11;
        TImageList *imToolButton;
        TSpeedButton *tbExit;
        TToolButton *ToolButton1;
        TToolButton *ToolButton2;
        TSpeedButton *tbStart;
        TSpeedButton *tbPause;
        TSpeedButton *tbStop;
        TToolButton *ToolButton3;
        TToolButton *ToolButton4;
        TToolButton *ToolButton5;
        TAction *aFarParam2;
        TAction *aFarParam4;
        TAction *aFarParam3;
        TPopupMenu *pmFarParam;
        TMenuItem *N12;
        TMenuItem *N13;
        TMenuItem *N14;
        TMenuItem *N15;
        TToolButton *tbTargetWindow;
        TAction *aBlackAndWhiteIndicator;
        TControlBar *cbSpeedButton;
        TToolBar *tbSpeedButton;
        TToolButton *ToolButton6;
        TToolButton *ToolButton7;
        TToolButton *ToolButton8;
        TToolButton *ToolButton9;
        TToolButton *ToolButton12;
        TToolButton *ToolButton13;
        TToolButton *ToolButton14;
        TToolButton *ToolButton15;
        TToolButton *ToolButton17;
        TToolButton *ToolButton18;
        TToolButton *ToolButton16;
        TToolButton *ToolButton10;
        TToolButton *ToolButton11;
        TToolButton *ToolButton19;
        TToolButton *ToolButton20;
        TToolButton *ToolButton21;
        TToolButton *ToolButton22;
        TToolButton *ToolButton23;
        TToolButton *ToolButton26;
        TImageList *ImageList1;
        TToolButton *ToolButton27;
        TToolButton *ToolButton28;
        TAction *aSedefaultProjectParam;
        TEdit *eDelay;
        TUpDown *UpDown1;
        TPanel *Panel1;
        TToolButton *ToolButton29;
        TPanel *Panel2;
        TToolButton *ToolButton30;
        TToolButton *ToolButton31;
        TToolButton *ToolButton32;
        TToolButton *ToolButton33;
        TToolButton *ToolButton34;
        TAction *aZoomIn;
        TAction *aZoomOut;
        TAction *aUndooZoom;
        TAction *aF9Run;
        TAction *aF10Pause;
        TAction *aF11Pause_One_Step;
        TToolButton *tbPause_One_Step;
        TToolButton *ToolButton36;
        TAction *aF12Stop;
        TToolButton *ToolButton24;
        TAction *aSimulation3dDiagram;
        TPanel *pReviewTimer;
        TPanel *pTimer;
        TImageList *ilDisabled;
        TImageList *ImageList3;
        TAction *aFilterParams;
        TAction *aCompareACH_Xe;
        TAction *aCompareACH_Xo;
        TAction *aCompareACH_pXo;
        TAction *aCompare_Xe;
        TAction *aCompare_Xo;
        TAction *aCompare_pXo;
        TPanel *pIndicator;
        TPaintBox *pbIndicator;
        TPanel *pGraph;
        TPaintBox *pbGraph;
        TToolButton *tbWaveFilterEnabled;
        TToolButton *ToolButton35;
        TAction *aWaveFilterEnabled;
        TAction *aDeltaQ_a;
        TToolButton *ToolButton25;
        TPanel *Panel3;
        TPanel *Panel4;
        TToolButton *ToolButton37;
        TPanel *Panel5;
        TToolButton *ToolButton38;
        TToolButton *ToolButton39;
        TAction *aStabEnabled;
        TAction *Action1;
        TMenuItem *miNULL2;
        TAction *aSpeedShip;
        TAction *aSpeedVerticalShip;
        TMenuItem *N1;
        TMenuItem *N3;
        TToolButton *tbSpeedVerticalShip;
        TToolButton *tbSpeedShip;
        TToolButton *ToolButton40;
        TToolButton *ToolButton41;
        TToolButton *ToolButton42;
        TAction *aDeltaKursWave;
        TToolButton *ToolButton43;
        TAction *aPelengCharateristic;
        TOpenDialog *OpenDialog1;
        TSaveDialog *SaveDialog1;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall aAllAction(TObject *Sender);
        void __fastcall tbStartClick(TObject *Sender);
        void __fastcall tbPauseClick(TObject *Sender);
        void __fastcall tbStopClick(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall eTimerEnter(TObject *Sender);
        void __fastcall eDelayChange(TObject *Sender);
        void __fastcall UpDown1Changing(TObject *Sender,
          bool &AllowChange);
        void __fastcall tbPause_One_StepClick(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
protected:
        void __fastcall SetMinMaxSizeForm(TWMGetMinMaxInfo &Message);
//        void __fastcall aonPaint         (TWMPaint         &Message);
                        BEGIN_MESSAGE_MAP
                             MESSAGE_HANDLER(WM_GETMINMAXINFO, TWMGetMinMaxInfo, SetMinMaxSizeForm);
                             //MESSAGE_HANDLER(WM_PAINT        , TWMPaint        , aonPaint);

                        END_MESSAGE_MAP(TForm);
private:	// User declarations
       void OpenProject();
       void SaveProject();
public:		// User declarations
        __fastcall TfrmMain(TComponent* Owner);
};
//===========================================================================
extern PACKAGE TfrmMain *frmMain;
//===========================================================================
#endif
