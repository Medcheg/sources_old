//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Menus.hpp>
#include <Chart.hpp>
#include <Dialogs.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
//---------------------------------------------------------------------------
#include "pmCollection.h"
#include "Mmsystem.h"
#include <jpeg.hpp>
typedef struct{
        char   RIFF[4];
        DWORD  bytes;
        char   WAVE[4];
        char   fmt[4];
        int    siz_wf;
        WORD   wFormatTag;
        WORD   nChannels;
        DWORD  nSamplesPerSec;
        DWORD  nAvgBytesPerSec;
        WORD   nBlockAlign;
        WORD   wBitsPerSample;
        char   data[4];
        DWORD  pcmbytes;
} WAVHEADER;
//---------------------------------------------------------------------------
class TfrmMain : public TForm
{
__published:	// IDE-managed Components
        TMainMenu *MainMenu1;
        TMenuItem *miSaveData;
        TPanel *Panel2;
        TPanel *Panel4;
        TLabel *Label7;
        TLabel *Label8;
        TLabel *Label9;
        TLabel *Label10;
        TEdit *e_Freq2;
        TEdit *e_Freq1;
        TCheckBox *CheckBox1;
        TCheckBox *CheckBox2;
        TButton *bBPF_Start;
        TButton *bDTF_Start;
        TChart *Chart2;
        TLineSeries *lsDPF;
        TLineSeries *Series2;
        TPanel *pChart;
        TImage *Image1;
        TPanel *Panel1;
        TLabel *Label5;
        TLabel *Label6;
        TListBox *ListBox1;
        TButton *bStart;
        TButton *bStop;
        TListBox *ListBox2;
        TEdit *eWorkTime;
        TPanel *Panel3;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TLabel *Label12;
        TLabel *Label13;
        TLabel *Label14;
        TEdit *e_ResonansFreq1;
        TEdit *e_ResonansFreq2;
        TEdit *e_DeltaResonans;
        TEdit *e_Dobrotnost1;
        TEdit *e_Dobrotnost2;
        TSaveDialog *SaveDialog1;
        TTimer *Timer1;
        TLabel *Label11;
        TEdit *e_DecayTime;
        TListBox *ListBox3;
        TPanel *Panel5;
        TLabel *Label15;
        TLabel *Label17;
        TLabel *Label19;
        TEdit *eCountMaxPoint;
        TCheckBox *cbFullBPF;
        TPanel *Panel6;
        TChart *Chart1;
        TLineSeries *Series1;
        TLineSeries *Series4;
        TChart *Chart3;
        TLineSeries *Series3;
        TLabel *Label20;
        TEdit *eMinFreq;
        TPanel *Panel7;
        TPanel *Panel8;
        TPanel *Panel9;
        TLabel *Label16;
        TLabel *Label21;
        TEdit *e_Dobrotnost0;
        TLabel *Label22;
        TMenuItem *miSaveWaveFile;
        TMenuItem *C1;
        TPanel *Panel10;
        TMemo *mLog;
        TPanel *Panel11;
        TImage *iLogo;
    TButton *button_StopDTFCalc;
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall miSaveDataClick(TObject *Sender);
        void __fastcall ListBox1Click(TObject *Sender);
        void __fastcall bStartClick(TObject *Sender);
        void __fastcall bStopClick(TObject *Sender);
        void __fastcall bBPF_StartClick(TObject *Sender);
        void __fastcall CheckBox1Click(TObject *Sender);
        void __fastcall CheckBox2Click(TObject *Sender);
        void __fastcall bDTF_StartClick(TObject *Sender);
        void __fastcall ListBox2Click(TObject *Sender);
        void __fastcall Chart3AfterDraw(TObject *Sender);
        void __fastcall ListBox3Click(TObject *Sender);
        void __fastcall miSaveWaveFileClick(TObject *Sender);
        void __fastcall C1Click(TObject *Sender);
    void __fastcall button_StopDTFCalcClick(TObject *Sender);
private:	// User declarations

        short int   *WaveBuffer;
        WAVEFORMATEX wfx;
        HWAVEIN      hWaveIn;
        int          BitsCount;
        //WAVEHDR     *whdr[200];
		float        WorkFreq;
		double       PlayTime;

		LARGE_INTEGER   li_q1, li_q2, li_freq;
		int             SecCounter;
		bool            isStarted;
		bool            isDTFStoped;

        void CalcDeltaFreq(CCollection<double> *xValues, CCollection<double> *yValues, int *IndexOfMax);
        void __fastcall Setup_lb_WaveFormDevice();
        double  GetMaxValueOnFreq   (CCollection<short int> *aSoundData, double aFreq1, double aFreq2, int i1, int i2);
        void    Dobrotnost0Calculate(CCollection<short int> *aSoundData, int CountPoint, double aFreq, double *aDobrotnost, double *aDecayTime);
        void    Dobrotnost1Calculate(CCollection<short int> *aValues, double aFreq, double *aDobrotnost);
        void    Dobrotnost2Calculate(CCollection<double> *xValues, CCollection<double> *yValues, int aFreqIndex, double aFreqValue, double *aDobrotnost);

		void ClearSeries(TChart *aChart, bool isAutoMashtab);

     // --------- Все что связано с отрисовкой ----
         TColor    BGColor;
         TColor    FrameNetColor;
         TColor    NetColor;
         int     AlreadyDrawedData;
         TRect DrawRect;

		 double CoefX;
		 double CoefY;
		 int    ZeroPos;

		 void   InitGraphics();
         void   DrawNet(TCanvas *aCanvas);
         void   InitEditedControl();

         float MnkCoef[10];

         void ClearLog();
         void AddStringToLog(AnsiString as);
         void Chart_NormScale(TChart *aChart);
		 void GetMaximums(CCollection<double> *in_y, CCollection<double> *out_x, CCollection<double> *out_y);

     // --------- End of : Все что связано с отрисовкой ----
public:		// User declarations
        bool            isStoped;
        CCollection<short int> SoundData;
        __fastcall TfrmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmMain *frmMain;
//---------------------------------------------------------------------------
#endif

