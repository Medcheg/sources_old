//---------------------------------------------------------------------------

#ifndef Unit_PelengCharacteristicH
#define Unit_PelengCharacteristicH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "GradusEdit.h"
#include <Buttons.hpp>
#include <ExtCtrls.hpp>
#include <Chart.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include <Series.hpp>
//---------------------------------------------------------------------------
class TfrmPelengCharacteristic : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TGradusEdit *egBeginTeta;
        TGradusEdit *egEndTeta;
        TLabel *Label5;
        TLabel *Label6;
        TBitBtn *BitBtn1;
        TChart *Chart1;
        TLabel *Label7;
        TLabel *Label8;
        TGradusEdit *egTetaStep;
        TLabel *Label10;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall BitBtn1Click(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall Chart1BeforeDrawSeries(TObject *Sender);
private:	// User declarations
        TFloat  BeginTeta, EndTeta, TetaStep;
        TImpuls Impuls;
        TFloat  aRadValue[50];
        TFloat  E1, E2;
        void CreateSeriesAndAddToChart(TChart *aChart, TFloat aVal);
public:		// User declarations
        __fastcall TfrmPelengCharacteristic(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmPelengCharacteristic *frmPelengCharacteristic;
//---------------------------------------------------------------------------
#endif
