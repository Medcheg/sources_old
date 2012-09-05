//---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TLabel *Label1;
    TImage *Image1;
    TLabel *Label2;
    TLabel *Label3;
    TListBox *ListBox1;
    TButton *Button1;
    TPanel *Panel1;
    TListBox *ListBox3;
    TButton *Button2;
    TProgressBar *ProgressBar1;
    TEdit *Edit1;
    TButton *Button4;
    TMemo *Memo1;
    TMemo *Memo2;
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall Button4Click(TObject *Sender);
private:	// User declarations
    bool    Stoped;

    void __fastcall Calc_Roots_Polinom(int a_len, double *a);
public:		// User declarations
    __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
