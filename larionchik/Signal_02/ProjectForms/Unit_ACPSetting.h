//---------------------------------------------------------------------------
#ifndef Unit_ACPSettingH
#define Unit_ACPSettingH

//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
#include <CheckLst.hpp>
//---------------------------------------------------------------------------
#include "mpiBaseADC.h"
//---------------------------------------------------------------------------

class CBaseADC;
class TfrmACPSetting : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TComboBox *ComboBox1;
        TPanel *Panel1;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TRadioGroup *RadioGroup1;
        TRadioGroup *RadioGroup2;
        TCheckListBox *CheckListBox1;
        TCheckListBox *CheckListBox2;
        TLabel *Label2;
        TPanel *Panel2;
        TMemo *Memo1;
        TLabel *Label3;
        TEdit *eAcpFreq;
        TLabel *Label4;
        TEdit *eTimeWork;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TTimer *Timer1;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall RadioGroup2Click(TObject *Sender);
        void __fastcall CheckListBox2Click(TObject *Sender);
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
    void __fastcall ComboBox1Change(TObject *Sender);
    void __fastcall RadioGroup1Click(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
private:	// User declarations
        double TotalPhysMem;
        double AvaiblePhysMem;
        double TotalPageFile;
        double AvaiblePageFile;
        CCollection<CBaseADC*>  ADCList;

        int    CurAcpFreq;

        bool   ValidateACPFreq_AndTime();
public:		// User declarations
        CBaseADC  *WorkACP;
        __fastcall TfrmACPSetting(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmACPSetting *frmACPSetting;
//---------------------------------------------------------------------------
#endif
