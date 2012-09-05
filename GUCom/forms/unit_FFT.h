//---------------------------------------------------------------------------

#ifndef unit_FFTH
#define unit_FFTH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Chart.hpp"
#include "Series.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <ExtCtrls.hpp>
#include <Buttons.hpp>
//---------------------------------------------------------------------------
class Tform_FreqAnalysis : public TForm
{
__published:	// IDE-managed Components
    TPanel *panel_FFt_param;
    TCheckBox *checkbox_isLogarithmicScale;
    TChart *Chart5;
    TLineSeries *LineSeries1;
    TLineSeries *LineSeries2;
    TPointSeries *Series4;
    TScrollBar *ScrollBar1;
    TLabel *Label6;
    TEdit *eSamplingTime;
    TLabel *Label10;
    TBitBtn *bCalculate;
    TEdit *Edit1;
    void __fastcall bCalculateClick(TObject *Sender);
    void __fastcall checkbox_isLogarithmicScaleClick(TObject *Sender);
    void __fastcall Chart5Zoom(TObject *Sender);
private:	// User declarations
public:		// User declarations
    CCollection<float> *Data;
    __fastcall Tform_FreqAnalysis(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_FreqAnalysis *form_FreqAnalysis;
//---------------------------------------------------------------------------
#endif
