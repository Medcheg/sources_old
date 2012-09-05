//---------------------------------------------------------------------------

#ifndef Unit_BaseDialog_ImportDataH
#define Unit_BaseDialog_ImportDataH
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
#include <Buttons.hpp>
#include <Classes.hpp>
#include <ComCtrls.hpp>
#include <Controls.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <StdCtrls.hpp>
#include "Unit_BaseDialog.h"
class TfrmBaseDialog_ImportData : public TfrmBaseDialog
{
__published:	// IDE-managed Components
        TLabel *Label3;
        TLabel *lT0;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *lCountData;
        TLabel *lTime;
        TLabel *lCanalCount;
        TBitBtn *bbLoadFile;
        TLabel *lFileName;
        TOpenDialog *OpenDialog1;
        TBevel *Bevel1;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall bbLoadFileClick(TObject *Sender);
        void __fastcall bbOkClick(TObject *Sender);
private:	// User declarations
        void __fastcall SnowFileParam ();
public:		// User declarations
        TImportData   *ImportData;
        __fastcall TfrmBaseDialog_ImportData(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmBaseDialog_ImportData *frmBaseDialog_ImportData;
//---------------------------------------------------------------------------
#endif
