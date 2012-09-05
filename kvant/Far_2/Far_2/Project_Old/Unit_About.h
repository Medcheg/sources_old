//---------------------------------------------------------------------------

#ifndef Unit_AboutH
#define Unit_AboutH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class TfrmAbout : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label2;
        TBitBtn *BitBtn1;
        TPanel *Panel1;
        TBevel *Bevel1;
        TPanel *Panel2;
        TImage *Image1;
        TLabel *ProductName;
        TLabel *Version;
        TLabel *Comments;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TTimer *Timer1;
        TLabel *Label3;
        TLabel *PhysMem;
        TLabel *FreeRes;
        TLabel *CpuLabel;
        void __fastcall FormClick(TObject *Sender);
        void __fastcall Image1DblClick(TObject *Sender);
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall Label3Click(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
private:	// User declarations
        int     CountDblClick;
        double __fastcall GetCPUSpeed();
public:		// User declarations
        __fastcall TfrmAbout(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmAbout *frmAbout;
//---------------------------------------------------------------------------
#endif
