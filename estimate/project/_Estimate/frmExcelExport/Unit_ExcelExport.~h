//---------------------------------------------------------------------------

#ifndef Unit_ExcelExportH
#define Unit_ExcelExportH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TfrmExcelExport : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TLabel *Label8;
        TAnimate *Animate1;
        TProgressBar *ProgressBar1;
        void __fastcall FormActivate(TObject *Sender);
private:
        int fCountData;
        int fPosition;
        void __fastcall Set_CountData(int value);
        void __fastcall Set_Position(int value);	// User declarations
public:		// User declarations
        __fastcall TfrmExcelExport(TComponent* Owner);
        __property int CountData  = { write=Set_CountData };
        __property int Position  = { read=fPosition, write=Set_Position };
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmExcelExport *frmExcelExport;
//---------------------------------------------------------------------------
#endif
