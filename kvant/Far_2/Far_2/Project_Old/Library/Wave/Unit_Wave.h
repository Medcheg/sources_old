//---------------------------------------------------------------------------
#ifndef _Unit_WaveH_
#define _Unit_WaveH_
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include "mpiWave.h"
#include "mpiTypes.h"

//---------------------------------------------------------------------------
class TfrmWave : public TForm
{
__published:	// IDE-managed Components
        TBevel *Bevel1;
        TBevel *Bevel11;
        TBevel *Bevel10;
        TBevel *Bevel9;
        TBevel *Bevel6;
        TBevel *Bevel13;
        TBevel *Bevel15;
        TBevel *Bevel3;
        TLabel *Label17;
        TLabel *Label18;
        TLabel *Label19;
        TBevel *Bevel4;
        TBevel *Bevel5;
        TLabel *Label20;
        TLabel *Label21;
        TLabel *Label22;
        TBevel *Bevel7;
        TBevel *Bevel8;
        TLabel *Label24;
        TLabel *Label25;
        TLabel *Label132;
        TLabel *Label111;
        TLabel *Label26;
        TLabel *Label31;
        TLabel *Label33;
        TLabel *Label32;
        TLabel *Label34;
        TLabel *Label35;
        TLabel *Label36;
        TLabel *Label37;
        TLabel *Label38;
        TLabel *Label39;
        TLabel *Label40;
        TLabel *Label1;
        TLabel *Label28;
        TLabel *Label29;
        TLabel *Label30;
        TBevel *Bevel2;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label11;
        TLabel *Label12;
        TLabel *Label13;
        TLabel *Label15;
        TLabel *Label16;
        TLabel *Label41;
        TLabel *Label43;
        TLabel *Label44;
        TLabel *Label45;
        TLabel *Label46;
        TLabel *Label47;
        TLabel *Label48;
        TLabel *Label51;
        TLabel *Label53;
        TLabel *Label54;
        TLabel *Label10;
        TLabel *Label14;
        TLabel *Label42;
        TLabel *Label55;
        TLabel *Label56;
        TLabel *Label57;
        TLabel *Label58;
        TLabel *Label59;
        TLabel *Label60;
        TLabel *Label61;
        TLabel *Label62;
        TLabel *Label63;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TButton *Button1;
        TCheckBox *isPolinomBox;
        TEdit *eC0;
        TEdit *eC1;
        TEdit *eC2;
        TCheckBox *isSinusBox;
        TEdit *eSinA1;
        TEdit *eSinF1;
        TEdit *eSinW1;
        TCheckBox *isSawBox;
        TEdit *eSawK;
        TEdit *eSawTe;
        TEdit *eImpulsTb;
        TEdit *eImpulsL;
        TCheckBox *isImpulsBox;
        TCheckBox *isGauseNoise;
        TEdit *eGauseSKO;
        TEdit *eC3;
        TEdit *eSinAlfa1;
        TCheckBox *isSinHarmonik1Box;
        TEdit *eSinA2;
        TEdit *eSinF2;
        TEdit *eSinW2;
        TEdit *eSinAlfa2;
        TEdit *eSinA3;
        TEdit *eSinF3;
        TEdit *eSinW3;
        TEdit *eSinAlfa3;
        TCheckBox *isSinHarmonik2Box;
        TCheckBox *isSinHarmonik3Box;
        TEdit *eImpulsA;
        TEdit *ePrevBegin;
        TEdit *ePrevEnd;
        TCheckBox *isRandomProcess;
        TEdit *eRandomTf;
        TEdit *eRandomSKO;
        TPanel *Panel1;
        TPanel *Panel2;
        TBitBtn *BitBtn3;
        TPanel *Panel3;
        TChart *Chart1;
        TFastLineSeries *Series1;
        TImageList *ImageList1;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall isPolinomBoxClick(TObject *Sender);
        void __fastcall isSinHarmonik1BoxClick(TObject *Sender);
        void __fastcall isSinHarmonik2BoxClick(TObject *Sender);
        void __fastcall isSinHarmonik3BoxClick(TObject *Sender);
        void __fastcall isSawBoxClick(TObject *Sender);
        void __fastcall isImpulsBoxClick(TObject *Sender);
        void __fastcall isGauseNoiseClick(TObject *Sender);
        void __fastcall isRandomProcessClick(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall BitBtn3Click(TObject *Sender);
        void __fastcall isSinusBoxClick(TObject *Sender);
private:	// User declarations
        bool CheckRightInput();
        void ShowWrongEdit(TEdit *Edit);
public:		// User declarations
        TWave *Wave;

        __fastcall TfrmWave(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmWave *frmWave;
//---------------------------------------------------------------------------
#endif
