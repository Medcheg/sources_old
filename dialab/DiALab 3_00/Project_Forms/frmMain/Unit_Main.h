//---------------------------------------------------------------------------
#ifndef Unit_MainH
#define Unit_MainH
#include <Classes.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TOpenDialog *OpenDialog1;
        TSaveDialog *SaveDialog1;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
        void __fastcall FormActivate(TObject *Sender);
protected:
        void __fastcall SetMinMaxSizeForm(TWMGetMinMaxInfo &Message);
                        BEGIN_MESSAGE_MAP
                             MESSAGE_HANDLER(WM_GETMINMAXINFO, TWMGetMinMaxInfo, SetMinMaxSizeForm);
                        END_MESSAGE_MAP(TForm);
private:	// User declarations
public:		// User declarations
        __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif
