//---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall FormPaint(TObject *Sender);
private:	// User declarations
        bool    FirstPaint;
        void FindFile(AnsiString dir, AnsiString mask, AnsiString ff);
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
