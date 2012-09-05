//---------------------------------------------------------------------------

#ifndef Unit_AlanResultH
#define Unit_AlanResultH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
#include "M_Alan.h"
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
//---------------------------------------------------------------------------
class TfrmAlanResult : public TForm
{
__published:	// IDE-managed Components
        TChart *Chart1;
        TFastLineSeries *FastLineSeries1;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
private:	// User declarations
public:		// User declarations
        TAlan        *Element;
        __fastcall TfrmAlanResult(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmAlanResult *frmAlanResult;
//---------------------------------------------------------------------------
#endif
