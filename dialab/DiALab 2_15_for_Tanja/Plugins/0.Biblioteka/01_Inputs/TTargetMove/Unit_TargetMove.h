//---------------------------------------------------------------------------

#ifndef Unit_TargetMoveH
#define Unit_TargetMoveH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Unit_BaseDialog.h"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
//---------------------------------------------------------------------------
class TfrmTargetMove : public TfrmBaseDialog
{
__published:	// IDE-managed Components
        TLabel *Label3;
        TEdit *eH0;
        TLabel *Label4;
        TEdit *eBetta0;
        TLabel *Label5;
        TEdit *eV0;
        TLabel *Label6;
        TEdit *eR0;
        TLabel *Label7;
        TEdit *eK0;
        TLabel *Label8;
        TEdit *eGLoad;
        TLabel *Label9;
        TEdit *efi;
        TLabel *Label11;
        TEdit *eA1;
        TLabel *Label12;
        TEdit *eA3;
        TLabel *Label13;
        TEdit *eSigma1;
        TLabel *Label14;
        TEdit *eSigma2;
        TLabel *Label15;
        TEdit *eSigma3;
        TLabel *Label16;
        TEdit *et1;
        TLabel *Label17;
        TLabel *Label18;
        TLabel *Label19;
        TLabel *Label20;
        TLabel *Label21;
        TLabel *Label22;
        TLabel *Label24;
        TLabel *Label25;
        TLabel *Label26;
        TLabel *Label27;
        TLabel *Label28;
        TLabel *Label29;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall bbOkClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        long double    *H0;
        long double    *Betta0;
        long double    *V0;
        long double    *R0;
        long double    *K0;
        long double    *t1; // --- Время до розворота -----
        long double    *GLoad;       // ---- Перегрузка на развороте ------
        long double    *fi; // ---- Угол разворота ----
        long double    *radius;      // ---- радиус разворота *-----
        long double    *a1;      // ---- ускорение на 1 участке ------
        long double    *a3;      // ---- ускорение на 3 участке ------

        long double    *sigma1;   // ---- Шум в канале дальности ----
        long double    *sigma2;   // ---- Шум в азимутальном канале ----
        long double    *sigma3;   // ---- Шум в угломестном канале ---
        __fastcall TfrmTargetMove(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmTargetMove *frmTargetMove;
//---------------------------------------------------------------------------
#endif
