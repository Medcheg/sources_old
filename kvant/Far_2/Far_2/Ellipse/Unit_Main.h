//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
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
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TChart *Chart1;
        TFastLineSeries *Series1;
        TFastLineSeries *Series2;
        TFastLineSeries *Series3;
        TFastLineSeries *Series4;
        TTrackBar *TrackBar1;
        TLabel *Label1;
        TLabel *Label2;
        TTrackBar *TrackBar2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label10;
        TPointSeries *Series5;
        TLabel *Label11;
        TLabel *Label12;
        TLabel *Label13;
        TLabel *Label14;
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall TrackBar1Change(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
private:	// User declarations
        double   DeltaQ;
        double   DeltaAlfa;

public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
