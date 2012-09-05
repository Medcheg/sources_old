//---------------------------------------------------------------------------

#ifndef Unit_TestBinReadH
#define Unit_TestBinReadH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
class TfrmTestBinRead : public TForm
{
__published:	// IDE-managed Components
        TComboBox *ComboBox1;
        TMemo *Memo1;
        void __fastcall ComboBox1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TfrmTestBinRead(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmTestBinRead *frmTestBinRead;
//---------------------------------------------------------------------------
#endif
