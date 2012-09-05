//---------------------------------------------------------------------------

#ifndef Unit_mainH
#define Unit_mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Chart.hpp"
#include "Series.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
#include "pmCollection.h"
//---------------------------------------------------------------------------
class Tform_Main : public TForm
{
__published:	// IDE-managed Components
	TButton *button_LoadmARHS;
	TProgressBar *ProgressBar1;
	TButton *button_Export2Text;
	TOpenDialog *OpenDialog1;
	TSaveDialog *SaveDialog1;
	TChart *Chart1;
	TLineSeries *LineSeries1;
	TChart *Chart2;
	TLineSeries *LineSeries2;
	TChart *Chart3;
	TLineSeries *LineSeries3;
	TChart *Chart4;
	TLineSeries *LineSeries4;
	TButton *Button1;
	TLabel *Label1;
	TLabel *Label2;
	void __fastcall button_LoadmARHSClick(TObject *Sender);
	void __fastcall button_Export2TextClick(TObject *Sender);
private:	// User declarations
    FILE  *h_file;
    TChart  *Charts[4];
    TLabel  *Labels[4];

    bool    iLoaded_1;
    bool    iLoaded_2;

    CCollectionStorage<double>  iData[2];
    CCollectionStorage<double>  oData;
    void ChartClear(int tt);
public:		// User declarations
	__fastcall Tform_Main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Main *form_Main;
//---------------------------------------------------------------------------
#endif
