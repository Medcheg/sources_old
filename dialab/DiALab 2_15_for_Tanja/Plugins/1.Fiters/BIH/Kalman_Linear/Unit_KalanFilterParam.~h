//---------------------------------------------------------------------------

#ifndef Unit_KalmanBajasFilterParamH
#define Unit_KalmanBajasFilterParamH
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
class TfrmKalanFilterParam : public TfrmBaseDialog
{
__published:	// IDE-managed Components
        TLabel *Label3;
        TEdit *ePFil;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TLabel *Label4;
        TEdit *eP11;
        TLabel *Label5;
        TEdit *eP12;
        TLabel *Label6;
        TEdit *eP22;
        TBevel *Bevel1;
        TBevel *Bevel2;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label11;
        TEdit *eN;
        void __fastcall RadioButton1Click(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall bbOkClick(TObject *Sender);
private:	// User declarations
        void SetEnabledsAndDisabledsComponenets();
public:		// User declarations
         bool       *CalcFiltrWithBeginInit;  // -- Если да, то фильтр с начальной оценкой параметров траектории ---
         TFloat     *PFil;                    // --- Память фильтра [ PFILL ] ---
         TFloat     *p11, *p12, *p22;           // --- Элементы матрици ошибок фильтрациии на текущем шаге ----
         TFloat     *N;                       // --- Количество точек начальных параметров траектории
        __fastcall TfrmKalanFilterParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmKalanFilterParam *frmKalanFilterParam;
//---------------------------------------------------------------------------
#endif
