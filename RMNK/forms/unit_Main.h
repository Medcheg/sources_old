//---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "Chart.hpp"
#include "TeeDraw3D.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <ExtCtrls.hpp>
#include "Series.hpp"
//---------------------------------------------------------------------------
class TForm25 : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel1;
    TButton *Button1;
    TPanel *Panel2;
    TChart *Chart2;
    TLineSeries *LineSeries1;
    TLineSeries *LineSeries2;
    TLineSeries *LineSeries3;
    TPanel *Panel3;
    TChart *Chart1;
    TLineSeries *Series1;
    TLineSeries *Series2;
    TChart *Chart3;
    TLineSeries *LineSeries4;
    TLineSeries *LineSeries5;
    TLineSeries *LineSeries6;
    TChart *Chart4;
    TLineSeries *LineSeries7;
    TLineSeries *LineSeries8;
    TLineSeries *LineSeries9;
    TMemo *Memo1;
    TEdit *Edit1;
    TEdit *Edit2;
    TEdit *Edit3;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
private:	// User declarations
    void SeriesClear(TChart *chart);
public:		// User declarations
    __fastcall TForm25(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm25 *Form25;
//---------------------------------------------------------------------------
#endif
