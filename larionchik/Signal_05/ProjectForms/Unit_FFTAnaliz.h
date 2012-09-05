//---------------------------------------------------------------------------

#ifndef Unit_FFTAnalizH
#define Unit_FFTAnalizH
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
class TfrmFFTAnaliz : public TForm
{
__published:	// IDE-managed Components
    TPanel *Panel1;
    TListBox *ListBox1;
    TLabel *Label1;
    TButton *Button1;
    TCheckBox *cbTimeInterval;
    TPanel *Panel2;
    TLabel *Label2;
    TEdit *eBeginTime;
    TLabel *Label3;
    TEdit *eEndTime;
    TPanel *pBG;
    TPanel *Panel3;
    TLabel *Label7;
    TLabel *Label8;
    TLabel *Label9;
    TLabel *Label10;
    TPageControl *PageControl1;
    TTabSheet *TabSheet1;
    TChart *Chart1;
    TLineSeries *Series1;
    TProgressBar *ProgressBar1;
        TPanel *Panel4;
        TLabel *Label5;
        TLabel *Label4;
        TLabel *Label6;
        TEdit *eBeginFreq;
        TEdit *eEndFreq;
        TButton *Button2;
        TButton *Button3;
        TPanel *Panel5;
        TLabel *Label11;
        TLabel *Label12;
        TLabel *Label13;
        TLabel *Label14;
    TLineSeries *Series2;
    TCheckBox *cbFindFFTMaximums;
    TEdit *eFreq1;
    TEdit *eFreq2;
    TEdit *eFreqValue1;
    TEdit *eFreqValue2;
    void __fastcall FormShow(TObject *Sender);
    void __fastcall cbTimeIntervalClick(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall Button3Click(TObject *Sender);
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall Chart1MouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
    void __fastcall Chart1MouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
    void __fastcall Chart1MouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
    void __fastcall FormActivate(TObject *Sender);
        void __fastcall Button4Click(TObject *Sender);
    void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
private:	// User declarations
    float    *re;
    float    *im;
    int       fftPower;
    bool      isMouseDown;    
    void      DrawFFT();
    void      ClearChart();
    bool      CheckDoubleValue(TEdit *editBox, double *val);


public:		// User declarations
    __fastcall TfrmFFTAnaliz(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmFFTAnaliz *frmFFTAnaliz;
//---------------------------------------------------------------------------
#endif
