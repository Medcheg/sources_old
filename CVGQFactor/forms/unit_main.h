//---------------------------------------------------------------------------

#ifndef unit_mainH
#define unit_mainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ToolWin.hpp>
#include <ExtCtrls.hpp>
#include <jpeg.hpp>
//---------------------------------------------------------------------------
#include "Mmsystem.h"
#include "Chart.hpp"
#include "Series.hpp"
#include "TeEngine.hpp"
#include "TeeProcs.hpp"
#include <Dialogs.hpp>
#include <Menus.hpp>
//---------------------------------------------------------------------------
#define MESSAGE_STOP_DEVICE      WM_USER + 10
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

class COscilograph;
class CBandPassFiltration;
class Tform_Main : public TForm
{
__published:    // IDE-managed Components
    TToolBar *ToolBar1;
    TToolButton *tbFile;
    TToolButton *tbSetting;
    TToolButton *tbAnalisys;
    TToolButton *tbWindow;
    TPanel *panel_SoundCard;
    TComboBox *combobox_SoundCard;
    TComboBox *combobox_SoundFreq;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TButton *bStart;
    TButton *bStop;
    TEdit *eWorkTime;
    TImage *iLogo;
    TPanel *Panel5;
    TPanel *Panel6;
    TPageControl *PageControl1;
    TTabSheet *TabSheet1;
    TTabSheet *TabSheet2;
    TTabSheet *TabSheet4;
    TTabSheet *TabSheet5;
    TChart *Chart4;
    TLineSeries *Series5;
    TButton *bBPF_Start;
    TPanel *Panel3;
    TLabel *Label11;
    TLabel *Label12;
    TLabel *Label13;
    TLabel *Label14;
    TEdit *e_Dobrotnost1;
    TEdit *e_Dobrotnost2;
    TPanel *Panel9;
    TLineSeries *Series1;
    TPanel *Panel4;
    TLabel *Label10;
    TLabel *Label7;
    TLabel *Label9;
    TLabel *Label8;
    TButton *button_StopDTFCalc;
    TEdit *e_Freq1;
    TEdit *e_Freq2;
    TChart *Chart2;
    TLineSeries *lsDPF;
    TLineSeries *Series2;
    TLabel *Label15;
    TPanel *Panel1;
    TPageControl *PageControl2;
    TTabSheet *TabSheet7;
    TRichEdit *mLog;
    TTabSheet *TabSheet8;
    TOpenDialog *OpenDialog1;
    TTabSheet *TabSheet9;
    TChart *Chart7;
    TLineSeries *LineSeries9;
    TLineSeries *LineSeries10;
    TLabel *Label17;
    TEdit *edit_tau_t1;
    TLabel *Label18;
    TEdit *edit_tau_t2;
    TChart *Chart8;
    TLineSeries *LineSeries11;
    TLineSeries *LineSeries12;
    TChart *Chart6;
    TLineSeries *LineSeries8;
    TLineSeries *LineSeries14;
    TLineSeries *Series3;
    TLineSeries *Series6;
    TChart *Chart5;
    TLineSeries *LineSeries1;
    TLineSeries *LineSeries2;
    TPointSeries *Series4;
    TPopupMenu *PopupMenu1;
    TMenuItem *N1;
    TMenuItem *N2;
    TSaveDialog *SaveDialog1;
    TLineSeries *Series7;
    TListBox *listbox_DTFFreqs;
    TButton *button_calcTau;
    TButton *Button1;
    TButton *button_StartDTFCalc;
    TPanel *panel_FFt_param;
    TCheckBox *checkbox_isLogarithmicScale;
    void __fastcall combobox_SoundCardChange(TObject *Sender);
    void __fastcall bStartClick(TObject *Sender);
    void __fastcall bStopClick(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall combobox_SoundFreqChange(TObject *Sender);
    void __fastcall bBPF_StartClick(TObject *Sender);
    void __fastcall FormActivate(TObject *Sender);
    void __fastcall button_calcTauClick(TObject *Sender);
    void __fastcall listbox_DTFFreqsClick(TObject *Sender);
    void __fastcall button_StopDTFCalcClick(TObject *Sender);
    void __fastcall button_StartDTFCalcClick1(TObject *Sender);
    void __fastcall checkbox_isLogarithmicScaleClick(TObject *Sender);
    void __fastcall N1Click(TObject *Sender);
    void __fastcall N2Click(TObject *Sender);
    void __fastcall tbSettingClick(TObject *Sender);
    void __fastcall Chart5AfterDraw(TObject *Sender);
    void __fastcall Button1Click(TObject *Sender);
private:    // User declarations

    short int           *WaveBuffer;

    WAVEFORMATEX wfx;
    HWAVEIN      hWaveIn;
    // ----
    float   ResonatorFreq;
    float   tau1, tau2;
    float   BaseT1, BaseT2;
    bool    isTimeDefined;

    // ----
    double  DFT_DeltaFreq;
    int     DTF_InterpolationPointsCount;
    int     FFT_MaxPointsCount;
    int     SoundCardIndex;
    int     FreqSoundCardIndex;
    // ----


    CCollection<float>         Data_Filtr_raw;
    CCollection<float>         Data_Filtr;
    CCollectionStorage<float>  Data_FFT;
    CCollectionStorage<float>  BPFMaximums;

    int     SecCounter;
    int     BitsCount;

    CCollectionStorage<float>  LoadedData;

    void __fastcall Setup_lb_WaveFormDevice();
    void            AddStringToLog(AnsiString as);
    void __fastcall NewWndProc(TMessage &Msg);
    void            ClearSeries(TChart *aChart, bool isAutoMashtab);

    void ReadDataFromRegistry();
    void SaveDataToRegistry();

    void    run_FFT        ( CCollection<short int> *in, CCollectionStorage<float>  *fft, float *CentralFreq, float minFreq, float maxFreq );
    void    run_Filtration ( CCollection<short int> *in, CCollection<float>         *out, CCollection <float> *out_raw, float  CentralFreq );
    void    GetMaximums    ( CCollectionStorage<float> *in, CCollectionStorage<float> *out, float freq1, float freq2);

public:     // User declarations
    bool    isStarted;
    bool    isStoped;
    bool	isCallBackStoped;
    bool    isDTFStoped;

    CCollection<short int> SoundData;

    float   WorkFreq;
    double  PlayTime;

    COscilograph *graphs;
    __fastcall Tform_Main(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE Tform_Main *form_Main;
//---------------------------------------------------------------------------
#endif
