//---------------------------------------------------------------------------

#ifndef Unit_KalanFilterParamH
#define Unit_KalanFilterParamH
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
class TfrmKalmanBajasFilterParam : public TfrmBaseDialog
{
__published:	// IDE-managed Components
        TLabel *Label3;
        TLabel *Label12;
        TLabel *Label13;
        TEdit *Edit3;
        TEdit *Edit4;
        TEdit *Edit5;
        TEdit *Edit7;
        TEdit *Edit8;
        TEdit *Edit9;
        TEdit *Edit10;
        TEdit *Edit11;
        TEdit *Edit12;
        TEdit *Edit13;
        TEdit *Edit14;
        TEdit *Edit15;
        TEdit *Edit6;
        TEdit *Edit16;
        TEdit *Edit17;
        TLabel *Label14;
        TLabel *Label15;
        TPanel *Panel2;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label11;
        TEdit *eP11;
        TEdit *eP12;
        TEdit *eP22;
        TEdit *eN;
        TRadioButton *RadioButton2;
        TRadioButton *RadioButton1;
        TPanel *Panel3;
        TRadioButton *RadioButton3;
        TRadioButton *RadioButton4;
        void __fastcall RadioButton1Click(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall bbOkClick(TObject *Sender);
private:	// User declarations
        void SetEnabledsAndDisabledsComponenets();
public:		// User declarations
         bool       *CalcFiltrWithBeginInit;     // -- Если да, то фильтр с начальной оценкой параметров траектории ---
         TFloat     *PFil;                       // --- Память фильтра [ PFILL ] ---
//         TFloat     *p11, *p12, *p22;            // --- Элементы матрици ошибок фильтрациии на текущем шаге ----
         TFloat     *N;                          // --- Количество точек начальных параметров траектории
        __fastcall TfrmKalmanBajasFilterParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmKalmanBajasFilterParam *frmKalmanBajasFilterParam;
//---------------------------------------------------------------------------
#endif
