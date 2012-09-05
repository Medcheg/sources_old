//---------------------------------------------------------------------------

#ifndef Unit_SimulationDiagramH
#define Unit_SimulationDiagramH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
class TfrmSimulationDiagram : public TForm
{
__published:	// IDE-managed Components
        TChart *Chart1;
        TFastLineSeries *Series1;
        TFastLineSeries *Series2;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormPaint(TObject *Sender);
private:	// User declarations
        bool FirstPaint;
public:		// User declarations
        __fastcall TfrmSimulationDiagram(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmSimulationDiagram *frmSimulationDiagram;
//---------------------------------------------------------------------------
#endif
