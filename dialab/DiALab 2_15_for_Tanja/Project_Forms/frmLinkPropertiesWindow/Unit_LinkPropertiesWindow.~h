//---------------------------------------------------------------------------

#ifndef Unit_LinkPropertiesWindowH
#define Unit_LinkPropertiesWindowH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "CGRID.h"
#include <Buttons.hpp>
//---------------------------------------------------------------------------
#include "mpiLink.h"
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include "CSPIN.h"
//---------------------------------------------------------------------------
class TfrmLinkPropertiesWindow : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TBitBtn *BitBtn1;
        TBitBtn *BitBtn2;
        TPanel *Panel1;
        TColorDialog *ColorDialog1;
        TLabel *Label2;
        TCSpinEdit *CSpinEdit1;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall Panel1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        TLink *Link;
        __fastcall TfrmLinkPropertiesWindow(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmLinkPropertiesWindow *frmLinkPropertiesWindow;
//---------------------------------------------------------------------------
#endif
