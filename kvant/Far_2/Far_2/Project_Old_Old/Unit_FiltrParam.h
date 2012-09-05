//---------------------------------------------------------------------------

#ifndef Unit_FiltrParamH
#define Unit_FiltrParamH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "FloatEdit.h"
#include "IntEdit.h"
#include <Buttons.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include "mpiWave.h"
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmFiltrParam : public TForm
{
__published:	// IDE-managed Components
        TGroupBox *GroupBox1;
        TLabel *Label1;
        TFloatEdit *efK1;
        TLabel *Label2;
        TFloatEdit *efK2;
        TGroupBox *GroupBox2;
        TLabel *Label3;
        TIntEdit *efN;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TLabel *Label6;
        TButton *Button1;
        TButton *Button3;
        TButton *Button5;
        TLabel *Label7;
        TButton *Button7;
        TButton *Button11;
        TLabel *Label9;
        TButton *Button13;
        TButton *Button17;
        TButton *Button18;
        TBitBtn *BitBtn3;
        TLabel *Label5;
        TLabel *Label8;
        TLabel *Label11;
        TLabel *Label13;
        TFloatEdit *efT0;
        TFloatEdit *efT;
        TButton *Button2;
        TRadioButton *RadioButton1;
        TRadioButton *RadioButton2;
        TLabel *Label10;
        TFloatEdit *efEndTimeCoefN;
        TLabel *Label4;
        TButton *Button4;
        TButton *Button6;
        TBevel *Bevel1;
        TBevel *Bevel2;
        TBevel *Bevel3;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall BitBtn3Click(TObject *Sender);
        void __fastcall ButtonClick(TObject *Sender);
        void __fastcall RadioButton1Click(TObject *Sender);
        void __fastcall RadioButton2Click(TObject *Sender);
private:	// User declarations
        TWave  *Wave;
        TFloat c0, c1;
        TFloat A, W;
        TFloat EndTimeCoefN;   

        TFloat EndCalcTime, aCurModelTime, T0;
        bool CheckInputValues();
public:		// User declarations
        __fastcall TfrmFiltrParam(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmFiltrParam *frmFiltrParam;
//---------------------------------------------------------------------------
#endif
