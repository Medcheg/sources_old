//---------------------------------------------------------------------------

#ifndef Unit_KalanFilterParamH
#define Unit_KalanFilterParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
#include "Unit_BaseDialog.h"
//---------------------------------------------------------------------------
class TfrmKalmanBajasFilterParam : public TfrmBaseDialog
{
__published:	// IDE-managed Components
        TLabel *Label3;                                        
        TLabel *Label12;
        TLabel *Label13;
        TEdit *ep_11;
        TEdit *ep_12;
        TEdit *ep_13;
        TEdit *ep_21;
        TEdit *ep_22;
        TEdit *ep_23;
        TEdit *ep_31;
        TEdit *ep_32;
        TEdit *ep_33;
        TEdit *ep1;
        TEdit *ep2;
        TEdit *ep3;
        TEdit *eAMax;
        TEdit *eSigma_x;
        TEdit *eQm;
        TLabel *Label14;
        TLabel *Label15;
        TPanel *Panel2;
        TLabel *Label11;
        TEdit *eN;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TPanel *Panel3;
        TRadioButton *rbFiltrMethod2;
        TRadioButton *rbFiltrMethod1;
        TLabel *Label4;
        TEdit *ePsi11;
        TEdit *ePsi12;
        TEdit *ePsi22;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label16;
        TBevel *Bevel1;
        void __fastcall RadioButton2Click(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall bbOkClick(TObject *Sender);
private:	// User declarations
        void SetEnabledsAndDisabledsComponenets();
public:		// User declarations
         int        *FiltrMethod;  // ----- Тип фильтра (1. разделенный по каланам, 2. С обратной связзю по решению);
         long double      *AMax;         // ----- Максимальное ускорение --------
         long double      *Qm;           // ----- Qm - параметр определяемый из експерементальных данных ------
         long double      *Sigma_x;     // ----- Дисперсия ошибок измерения ----------------------------------

         long double       *p1;     // ---- Матрица априорных вероятностей  ---------
         long double       *p2;     // ---- Матрица априорных вероятностей  ---------
         long double       *p3;     // ---- Матрица априорных вероятностей  ---------

         long double       *pi_11;     // ---- Матрица переходных вероятностей ---------
         long double       *pi_12;     // ---- Матрица переходных вероятностей ---------
         long double       *pi_13;     // ---- Матрица переходных вероятностей ---------
         long double       *pi_21;     // ---- Матрица переходных вероятностей ---------
         long double       *pi_22;     // ---- Матрица переходных вероятностей ---------
         long double       *pi_23;     // ---- Матрица переходных вероятностей ---------
         long double       *pi_31;     // ---- Матрица переходных вероятностей ---------
         long double       *pi_32;     // ---- Матрица переходных вероятностей ---------
         long double       *pi_33;     // ---- Матрица переходных вероятностей ---------
         long double       *psi11;
         long double       *psi12;
         long double       *psi22;


         bool              *CalcFiltrWithDSTFitr;     // -- Если да, то фильтр с начальной оценкой параметров траектории ---
         long double       *N;                          // --- Количество точек начальных параметров траектории
        __fastcall TfrmKalmanBajasFilterParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmKalmanBajasFilterParam *frmKalmanBajasFilterParam;
//---------------------------------------------------------------------------
#endif
