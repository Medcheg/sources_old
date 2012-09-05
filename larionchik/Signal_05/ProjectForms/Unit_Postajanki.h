//---------------------------------------------------------------------------

#ifndef Unit_PostajankiH
#define Unit_PostajankiH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TfrmPostajanki : public TForm
{
__published:	// IDE-managed Components
    TLabel *Label9;
    TButton *Button1;
    TButton *Button2;
    TListBox *ListBox1;
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TfrmPostajanki(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmPostajanki *frmPostajanki;
//---------------------------------------------------------------------------
#endif
