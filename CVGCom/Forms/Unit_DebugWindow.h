//===========================================================================

#ifndef Unit_DebugWindowH
#define Unit_DebugWindowH
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//===========================================================================
class TfrmDebugWindow : public TForm
{
__published:	// IDE-managed Components
    TListBox *ListBox1;
    void __fastcall FormShow(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TfrmDebugWindow(TComponent* Owner);
};
//===========================================================================
extern PACKAGE TfrmDebugWindow *frmDebugWindow;
//===========================================================================
#endif
