//---------------------------------------------------------------------------
#ifndef Unit_FarParamH
#define Unit_FarParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include "mpiTypes.h"
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmFarParam : public TForm
{
__published:	// IDE-managed Components
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TBevel *Bevel1;
        TLabel *Label19;
        TComboBox *cbDiagramForm;
        TLabel *Label28;
        TComboBox *cbDiagramType;
        TLabel *Label30;
        TLabel *Label32;
        TLabel *Label31;
        TLabel *Label17;
        TLabel *Label16;
        TLabel *Label7;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TEdit *egKursAngle0;
        TEdit *egRotationSpeed;
        TLabel *Label34;
        TLabel *Label37;
        TLabel *Label38;
        TEdit *efCutLevel;
        TLabel *Label50;
        TEdit *egHalfScanSector;
        TBevel *Bevel2;
        TLabel *Label29;
        TLabel *Label27;
        TLabel *Label26;
        TLabel *Label25;
        TLabel *Label23;
        TLabel *Label22;
        TLabel *Label21;
        TEdit *efSigma2;
        TEdit *efSH;
        TBevel *Bevel3;
        TLabel *Label33;
        TLabel *Label40;
        TEdit *efDiametrFar;
        TLabel *Label99;
        TLabel *Label100;
        TLabel *Label98;
        TLabel *Label107;
        TLabel *Label108;
        TLabel *labe123123;
        TLabel *Label110;
        TLabel *Label111;
        TLabel *Label112;
        TLabel *Label103;
        TLabel *Label36;
        TLabel *Label35;
        TLabel *Label48;
        TLabel *Label46;
        TLabel *Label8;
        TLabel *Label15;
        TLabel *Label10;
        TLabel *Label11;
        TLabel *Label13;
        TLabel *Label20;
        TLabel *Label69;
        TLabel *Label70;
        TEdit *efHx;
        TEdit *efHy;
        TEdit *efHz;
        TEdit *egEps0;
        TEdit *emDeltaEps0;
        TEdit *egNju;
        TEdit *emDeltaNju;
        TLabel *Label53;
        TLabel *Label87;
        TEdit *efWorkFreq;
        TLabel *Label92;
        TEdit *egMaxTetaAngle;
        TLabel *Label18;
        TLabel *Label24;
        TLabel *Label39;
        TLabel *Label41;
        TLabel *Label42;
        TLabel *Label44;
        TLabel *Label45;
        TLabel *Label51;
        TBevel *Bevel4;
        TBevel *Bevel5;
        TLabel *Label9;
        TLabel *Label12;
        TEdit *efKoefPlacingDiagram;
        TEdit *egSigmaEkstrapol;
        TEdit *egDeltaRo1;
        TEdit *egDeltaRo2;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
protected:
/*        void __fastcall WindowsPosChanging(TWMWindowPosChanging &Message);
                        BEGIN_MESSAGE_MAP
                             MESSAGE_HANDLER(WM_WINDOWPOSCHANGING, TWMWindowPosChanging,WindowsPosChanging);
                        END_MESSAGE_MAP(TObject);
 */
private:	// User declarations
        bool     CheckInputParam(TObject *Sender);
        void     SetParam();


public:		// User declarations
        __fastcall TfrmFarParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmFarParam *frmFarParam;
//---------------------------------------------------------------------------
#endif
