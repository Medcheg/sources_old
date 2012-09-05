//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================

#include "unit_main.h"
#include "pmOscilograph.h"
#include "pmTauDetection.h"
#include "pmFiltration.h"
//===========================================================================
#include "complex.h"
#include "unit_settings.h"
//===========================================================================


#pragma package(smart_init)
#pragma link "Chart"
#pragma link "Series"
#pragma link "TeEngine"
#pragma link "TeeProcs"
#pragma resource "*.dfm"
Tform_Main *form_Main;

//===========================================================================
float *asd;
__fastcall Tform_Main::Tform_Main(TComponent* Owner)
    : TForm(Owner)
{
    asd = (float*) malloc (123123);

    DFT_DeltaFreq = 0.8;

    DTF_InterpolationPointsCount = 20;
    FFT_MaxPointsCount = 4;

    SoundCardIndex = -1;
    FreqSoundCardIndex = -1;

    ReadDataFromRegistry();

    Caption = AnsiString(ProjectCaption) + AnsiString("0");

    isStoped    = false;
    isStarted   = false;
    isDTFStoped = false;

    PlayTime  = 1;
    WorkFreq  = 1000;

    WorkFreq = -1;

    mLog->Lines->Clear();
    Setup_lb_WaveFormDevice();

    if ( combobox_SoundCard->Items->Count > 0 )
    {
         combobox_SoundCard->ItemIndex = SoundCardIndex;
         combobox_SoundCardChange(NULL);
    }

    WaveBuffer = NULL;

 // ------------------
    this->WindowProc     = NewWndProc;
 // ------------------
    PageControl1->TabIndex = 0;
}

//===========================================================================
void __fastcall Tform_Main::FormCreate(TObject *Sender)
{
    graphs = new COscilograph( Chart4, &SoundData, &WorkFreq, &PlayTime );
    graphs->Init();
}

//===========================================================================
void __fastcall Tform_Main::FormDestroy(TObject *Sender)
{
    SaveDataToRegistry();
    delete graphs;
}

//===========================================================================
void __fastcall Tform_Main::FormActivate(TObject *Sender)
{
    DecimalSeparator = '.';
}

//===========================================================================
void Tform_Main::ReadDataFromRegistry()
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
        try {
           Reg = new TRegistry;
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);

           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\InnalabsUA\\ccg_QFactor", true);

            DFT_DeltaFreq = Reg->ReadFloat("DFT_DeltaFreq");

            DTF_InterpolationPointsCount = Reg->ReadInteger("DTF_InterpolationPointsCount");
            FFT_MaxPointsCount = Reg->ReadInteger("FFT_MaxPointsCount");
            SoundCardIndex = Reg->ReadInteger("SoundCardIndex");
            FreqSoundCardIndex = Reg->ReadInteger("FreqSoundCardIndex");

       } catch ( ... ){
            Reg->CloseKey();
            SaveDataToRegistry();
        }
    } __finally {
        Reg->CloseKey();
        if (Reg != NULL)
            delete Reg;
    }
}

//===========================================================================
void Tform_Main::SaveDataToRegistry()
{
    TRegistry *Reg = NULL;
    try {
        Reg = new TRegistry;
        AnsiString appName = ExtractFileName(Application->ExeName);
        appName.SetLength(appName.Length() - 4);

        Reg->RootKey = HKEY_LOCAL_MACHINE;
        Reg->OpenKey("Software\\InnalabsUA\\ccg_QFactor", true);

        Reg->WriteFloat("DFT_DeltaFreq", DFT_DeltaFreq);

        Reg->WriteInteger("DTF_InterpolationPointsCount", DTF_InterpolationPointsCount);
        Reg->WriteInteger("FFT_MaxPointsCount", FFT_MaxPointsCount);
        Reg->WriteInteger("SoundCardIndex", SoundCardIndex);
        Reg->WriteInteger("FreqSoundCardIndex", FreqSoundCardIndex);

    } __finally {
        Reg->CloseKey();
        if (Reg != NULL)
            delete Reg;
    }
}

//===========================================================================

void __fastcall Tform_Main::NewWndProc(TMessage &Msg)
{
    // ----- Update event -----
    if ( Msg.Msg == MESSAGE_STOP_DEVICE && isStoped == false )
    {
        bStopClick(NULL);
    }                                              //
    WndProc(Msg);
}

//===========================================================================
void __fastcall Tform_Main::Setup_lb_WaveFormDevice()
{
    combobox_SoundCard->Items->Clear();
    combobox_SoundFreq->Items->Clear();
    // ----- Количество ВАйфФОрм Устройств ------
    for ( unsigned int i = 0; i < waveInGetNumDevs(); i++)
    {
         WAVEINCAPS wic;
         ZeroMemory(&wic, sizeof(wic));
         waveInGetDevCaps(i, &wic, sizeof(wic));
         combobox_SoundCard->Items->Add(wic.szPname);
    }
}

//===========================================================================
void __fastcall Tform_Main::combobox_SoundCardChange(TObject *Sender)
{
    //if ( wic.dwFormats & WAVE_FORMAT_4M16 ) ListBox1->Items->Add(wic.szPname);
    if ( combobox_SoundCard->ItemIndex == -1 ) return;

    WAVEINCAPS wic;
    ZeroMemory(&wic, sizeof(wic));
    waveInGetDevCaps(combobox_SoundCard->ItemIndex, &wic, sizeof(wic));


    combobox_SoundFreq->Items->Clear();
    for ( DWORD k = 1; k < 0xFFFFFFF; k = k * 2)// (k << 1)
    {
        //2channels, 16bit, 96kHz => size is 0x5DC0
        //if ( (wic.dwFormats & WAVE_INVALIDFORMAT) && k == WAVE_INVALIDFORMAT ) combobox_SoundFreq->Items->Add("invalid format");             else //  0x00000000       // invalid format
        //if ( (wic.dwFormats & WAVE_FORMAT_1M08  ) && k == WAVE_FORMAT_1M08   ) combobox_SoundFreq->Items->Add("11.025 kHz, Mono,   8-bit");  else   // 0x00000001       //
        //if ( (wic.dwFormats & WAVE_FORMAT_1S08  ) && k == WAVE_FORMAT_1S08   ) combobox_SoundFreq->Items->Add("11.025 kHz, Stereo, 8-bit");  else   // 0x00000002       //
        //if ( (wic.dwFormats & WAVE_FORMAT_1M16  ) && k == WAVE_FORMAT_1M16   ) combobox_SoundFreq->Items->Add("11.025 kHz, Mono,   16-bit"); else   // 0x00000004       //
        //if ( (wic.dwFormats & WAVE_FORMAT_1S16  ) && k == WAVE_FORMAT_1S16   ) combobox_SoundFreq->Items->Add("11.025 kHz, Stereo, 16-bit"); else   // 0x00000008       //
        //if ( (wic.dwFormats & WAVE_FORMAT_2M08  ) && k == WAVE_FORMAT_2M08   ) combobox_SoundFreq->Items->Add("22.05  kHz, Mono,   8-bit");  else   // 0x00000010       //
        //if ( (wic.dwFormats & WAVE_FORMAT_2S08  ) && k == WAVE_FORMAT_2S08   ) combobox_SoundFreq->Items->Add("22.05  kHz, Stereo, 8-bit");  else   // 0x00000020       //
        //if ( (wic.dwFormats & WAVE_FORMAT_2M16  ) && k == WAVE_FORMAT_2M16   ) combobox_SoundFreq->Items->Add("22.05  kHz, Mono,   16-bit"); else   // 0x00000040       //
        //if ( (wic.dwFormats & WAVE_FORMAT_2S16  ) && k == WAVE_FORMAT_2S16   ) combobox_SoundFreq->Items->Add("22.05  kHz, Stereo, 16-bit"); else   // 0x00000080       //
        //if ( (wic.dwFormats & WAVE_FORMAT_4M08  ) && k == WAVE_FORMAT_4M08   ) combobox_SoundFreq->Items->Add("44.1   kHz, Mono,   8-bit");  else   // 0x00000100       //
        //if ( (wic.dwFormats & WAVE_FORMAT_4S08  ) && k == WAVE_FORMAT_4S08   ) combobox_SoundFreq->Items->Add("44.1   kHz, Stereo, 8-bit");  else   // 0x00000200       //
        //if ( (wic.dwFormats & WAVE_FORMAT_4M16  ) && k == WAVE_FORMAT_4M16   ) combobox_SoundFreq->Items->Add("44.1   kHz, Mono,   16-bit"); else   // 0x00000400       //
        //if ( (wic.dwFormats & WAVE_FORMAT_4S16  ) && k == WAVE_FORMAT_4S16   ) combobox_SoundFreq->Items->Add("44.1   kHz, Stereo, 16-bit"); else   // 0x00000800       //
        //if ( (wic.dwFormats & WAVE_FORMAT_48M08 ) && k == WAVE_FORMAT_48M08  ) combobox_SoundFreq->Items->Add("48     kHz, Mono,   8-bit");  else   // 0x00001000       //
        //if ( (wic.dwFormats & WAVE_FORMAT_48S08 ) && k == WAVE_FORMAT_48S08  ) combobox_SoundFreq->Items->Add("48     kHz, Stereo, 8-bit");  else   // 0x00002000       //
        //if ( (wic.dwFormats & WAVE_FORMAT_48M16 ) && k == WAVE_FORMAT_48M16  ) combobox_SoundFreq->Items->Add("48     kHz, Mono,   16-bit"); else   // 0x00004000       //
        //if ( (wic.dwFormats & WAVE_FORMAT_48S16 ) && k == WAVE_FORMAT_48S16  ) combobox_SoundFreq->Items->Add("48     kHz, Stereo, 16-bit"); else   // 0x00008000       //
        //if ( (wic.dwFormats & WAVE_FORMAT_96M08 ) && k == WAVE_FORMAT_96M08  ) combobox_SoundFreq->Items->Add("96     kHz, Mono,   8-bit");  else   // 0x00010000       //
        //if ( (wic.dwFormats & WAVE_FORMAT_96S08 ) && k == WAVE_FORMAT_96S08  ) combobox_SoundFreq->Items->Add("96     kHz, Stereo, 8-bit");  else   // 0x00020000       //
        //if ( (wic.dwFormats & WAVE_FORMAT_96M16 ) && k == WAVE_FORMAT_96M16  ) combobox_SoundFreq->Items->Add("96     kHz, Mono,   16-bit");// else   // 0x00040000       //
        //if ( (wic.dwFormats & WAVE_FORMAT_96S16 ) && k == WAVE_FORMAT_96S16  ) combobox_SoundFreq->Items->Add("96     kHz, Stereo, 16-bit");  // 0x00080000       //

        if ( (wic.dwFormats & WAVE_FORMAT_48M16 ) && k == WAVE_FORMAT_48M16  ) combobox_SoundFreq->Items->Add("48     kHz, Mono,   16-bit"); else   // 0x00004000       //
        if ( (wic.dwFormats & WAVE_FORMAT_96M16 ) && k == WAVE_FORMAT_96M16  ) combobox_SoundFreq->Items->Add("96     kHz, Mono,   16-bit");// else   // 0x00040000       //
    }

    SoundCardIndex = combobox_SoundCard->ItemIndex;

    if ( combobox_SoundFreq->Items->Count > 0 ){
         combobox_SoundFreq->ItemIndex = FreqSoundCardIndex;
        combobox_SoundFreqChange(NULL);
    }

    combobox_SoundFreqChange(Sender);
}

//===========================================================================
void __fastcall Tform_Main::combobox_SoundFreqChange(TObject *Sender)
{
    if ( combobox_SoundCard->ItemIndex != -1 && combobox_SoundFreq->ItemIndex != -1 ) bStart->Enabled = true;
    FreqSoundCardIndex = combobox_SoundFreq->ItemIndex;
}

//===========================================================================
void CALLBACK myWaveInProc(HWAVEIN hwi, UINT uMsg, DWORD dwInstance, DWORD dwParam1, DWORD dwParam2)
{
  WAVEHDR* whdr = (WAVEHDR*)dwParam1;
  switch(uMsg)
  {
    case WIM_OPEN:   __asm {nop};  break;
    case WIM_CLOSE:
            __asm {nop};
    break;
    case WIM_DATA:
          short int *arr = (short int*)whdr->lpData;
        // ------

        if ( form_Main->isCallBackStoped == false )
            for ( unsigned int i = 0; i < (whdr->dwBufferLength / sizeof(short int) - 1 ); i++)
            {
                if ( form_Main->SoundData.ValuesCount >= form_Main->WorkFreq * form_Main->PlayTime ) {
                    waveInUnprepareHeader(hwi, whdr, sizeof(WAVEHDR));

                    if ( form_Main->isCallBackStoped == false )
                        PostMessage((HWND__*)form_Main->Handle, MESSAGE_STOP_DEVICE, 0, 0);

                    form_Main->isCallBackStoped = true;

                    break;
                }

                  form_Main->SoundData.Add(arr[i]);
            }

        if ( form_Main->isCallBackStoped == false && form_Main->isStoped == false )
            waveInAddBuffer(hwi, whdr, sizeof(WAVEHDR));
        else
            __asm {nop};

    break;
  }
}

//===========================================================================
void __fastcall Tform_Main::bStartClick(TObject *Sender)
{
    if ( combobox_SoundCard->ItemIndex == -1) return;
    if ( combobox_SoundFreq->ItemIndex == -1) return;

    PlayTime = StrToFloat(eWorkTime->Text);
    AddStringToLog("Begin working");

    // -----------
    SecCounter          = 0;
    isStoped            = false;
    isStarted           = true;
    isDTFStoped         = false;
    isCallBackStoped    = false;
    bStart->Enabled     = false;
    bStop ->Enabled     = true;

    // -----------
    PageControl1->TabIndex = 0;

    // ----------
    char  str[255];
    int   ChanelsCount;
    BitsCount    = -1;
    sscanf(combobox_SoundFreq->Items->Strings[combobox_SoundFreq->ItemIndex].t_str(), "%f kHz, %s %i", &WorkFreq, str, &BitsCount);

    WorkFreq     = round(WorkFreq * 1000.0);
    ChanelsCount = ( strcmp(str, "Mono,") == 0) ? 1 : 2;
    // ---------

    mLog->Clear();
    graphs->Init();
    graphs->timer->Enabled = true;
    SoundData.Clear();

    unsigned int wReturn;

    // -----------
    HGLOBAL      hWaveHdr;
    LPWAVEHDR    lpWaveHdr;
    HMMIO        hmmio;
    UINT         wResult;
    HANDLE       hFormat;
    DWORD        dwDataSize;

    // -----------
    ZeroMemory(&wfx, sizeof(wfx));
    wfx.wFormatTag      = WAVE_FORMAT_PCM;
    wfx.nChannels       = ChanelsCount;
    wfx.nSamplesPerSec  = WorkFreq; //
    wfx.nAvgBytesPerSec = WorkFreq*ChanelsCount; //
    wfx.nBlockAlign     = 2;
    wfx.wBitsPerSample  = BitsCount;
    wfx.cbSize          = 0;

    // -----------
    wReturn = waveInOpen((LPHWAVEIN)&hWaveIn, combobox_SoundCard->ItemIndex, (LPWAVEFORMATEX)&wfx, (LONG)myWaveInProc, 0L, CALLBACK_FUNCTION);
    if ( wReturn == 0 ) __asm {nop};

    // -----------
    for ( int i = 0; i < 10; i++)
    {
        WAVEHDR *whdr = new WAVEHDR;
        ZeroMemory(whdr, sizeof(whdr));

        int BytesCount = wfx.nAvgBytesPerSec / 20;
        WaveBuffer = (short int*) malloc (BytesCount);
        ZeroMemory(WaveBuffer, BytesCount);

        whdr->lpData         = (char*)WaveBuffer;
        whdr->dwBufferLength = BytesCount;
        whdr->dwFlags = 0;

        wReturn = waveInPrepareHeader(hWaveIn, whdr, sizeof(WAVEHDR));
        if ( wReturn == 0 ) __asm {nop};
        wReturn = waveInAddBuffer    (hWaveIn, whdr, sizeof(WAVEHDR));
        if ( wReturn == 0 ) __asm {nop};
    }

    // -----------------------
    MMRESULT r = waveInStart(hWaveIn);
    if ( r == 0 ) __asm {nop};
}

//===========================================================================
void __fastcall Tform_Main::bStopClick(TObject *Sender)
{
    graphs->timer->Enabled = false;

    isStoped = true;
    isStarted = false;

    WAVEHDR whdr;
    waveInUnprepareHeader(hWaveIn, &whdr, sizeof(WAVEHDR));

    waveInReset(hWaveIn);
    waveInStop(hWaveIn);
    waveInClose(hWaveIn);

    AddStringToLog("Stop...");
    AddStringToLog("");

    bStart->Enabled = true;
    bStop ->Enabled = false;

    bBPF_Start->Enabled = true;
}

//===========================================================================
void Tform_Main::AddStringToLog(AnsiString as)
{
   mLog->Lines->Add(as);
   Application->ProcessMessages();
}

//===========================================================================
void Tform_Main::ClearSeries(TChart *aChart, bool isAutoMashtab)
{
    for ( int i = 0; i < aChart->SeriesList->Count; i++)
		   aChart->Series[i]->Clear();

    if ( isAutoMashtab == true)
    {
       aChart->UndoZoom();
	   aChart->BottomAxis->Automatic = true;
       aChart->LeftAxis  ->Automatic = true;
    }

	Application->ProcessMessages();
}


//===========================================================================
void __fastcall Tform_Main::bBPF_StartClick(TObject *Sender)
{
    BaseT1 = 0;
    BaseT2 = 0;
    isTimeDefined = false;

    bBPF_Start->Enabled = false;
 // ----------- Чарт -----------
    ClearSeries(Chart5, true);
    ClearSeries(Chart6, true);
    ClearSeries(Chart7, true);
    ClearSeries(Chart8, true);
    mLog->Clear();

  // -------------------------------
    AddStringToLog("FFT Calculate");
  // -------------------------------

        for ( int i = 0; i < (int)SoundData.ValuesCount; i++)
            SoundData.Values[i] = sin(TWO_PI*1000.0*i/WorkFreq) + 0.5*sin(TWO_PI*1000.13*i/WorkFreq);

        float minFreq = 1;
        float maxFreq = WorkFreq / 2;
        run_FFT(&SoundData, &Data_FFT, NULL, minFreq, maxFreq);

        Draw_ChartSeries_simple(Chart5, 0, false, false, 3000, 0, 0, Data_FFT.Items[0]->ValuesCount, Data_FFT.Items[0], Data_FFT.Items[1]);

        checkbox_isLogarithmicScaleClick(Sender);

  // -------------------------------
    AddStringToLog("Maximums Search");
  // -------------------------------

        Chart5AfterDraw(Sender);

        Application->ProcessMessages();


    PageControl1->TabIndex = 1;
    PageControl2->TabIndex = 0;

    button_StartDTFCalc->Enabled = true;
    button_calcTau->Enabled = true;
    button_StopDTFCalc ->Enabled = false;
    bBPF_Start->Enabled = true;

}

//===========================================================================
void __fastcall Tform_Main::checkbox_isLogarithmicScaleClick(TObject *Sender)
{
    if ( checkbox_isLogarithmicScale->Checked == true )
         Chart5->BottomAxis->Minimum = 1;
    else Chart5->BottomAxis->Minimum = 0;

    Chart5->BottomAxis->Logarithmic = checkbox_isLogarithmicScale->Checked;

    Application->ProcessMessages();
}

//===========================================================================
void Tform_Main::run_FFT ( CCollection<short int> *in, CCollectionStorage<float>  *fft, float *CentralFreq, float minFreq, float maxFreq )
{
    int aPower;
    CCollection<float> re; re.Clear();
    CCollection<float> im; im.Clear();

    int counter = 0;
    int MaximumIndex = -1;
    float temp;
    SoundData.Get_Maximum_ext(&temp, &MaximumIndex);

    for ( unsigned int i = MaximumIndex; i < SoundData.ValuesCount; i++) {
        re.Add(SoundData.Values[i]);
        //re.Add(LoadedData.Items[1]->Values[i]);
        im.Add(0);
        if ( counter++ > 263144 ) break; /// --- Если больше 2 ^18 ----
    }

    // ******************
        FFT(&re, &im, &aPower);
    // ******************

// -----
    fft->SetItemsCount(2);
     int DataCount = exp(aPower * std::log(2.0));
     for ( int i = 0; i < DataCount / 2; i++)
     {
         double xVal = i / (double)DataCount * WorkFreq;
         if ( xVal >= minFreq && xVal < maxFreq )
         {
             double yVal = sqrt(re.Values[i]*re.Values[i] + im.Values[i]*im.Values[i])*2.0 / (double)DataCount;
             fft->Items[0]->Add(xVal);
             fft->Items[1]->Add(yVal);
         }

    }

//    int   array_index = -1;
//      float array_value = -1;
//    fft->Items[1]->Get_Maximum_ext(&array_value, &array_index);
//    *CentralFreq = fft->Items[0]->Values[array_index];
}

//===========================================================================
void Tform_Main::run_Filtration ( CCollection<short int> *in, CCollection <float> *out, CCollection <float> *out_raw, float  CentralFreq )
{
    CBandPassFiltration bpf;
    float delta_w = 5;
    bpf.Init(CentralFreq, delta_w, 1.0 / WorkFreq );

    // ---------
    out->Clear();
    out_raw->Clear();
    //Data_Filtr_raw
    // ---- Опредиляю начала удара ------
    int   array_index = -1;
    float array_value = -1;
    in->Get_Maximum_ext(&array_value, &array_index);

    for ( unsigned int i = array_index; i < in->ValuesCount; i++ ){
        bpf.Run(in->Values[i]);
        out_raw->Add(bpf.f[0]);
        if ( i >= array_index + WorkFreq / delta_w * 1.3 )
            out->Add(bpf.f[0]);
    }
}

//===========================================================================
void Tform_Main::GetMaximums( CCollectionStorage<float> *in, CCollectionStorage<float> *out_y, float freq1, float freq2)
{
    if ( in == NULL ) return;
    if ( in->Items == NULL ) return;
    // ФОрмируем масив с реальных максимумов , ищем по производным
        CCollection<float> x, y;

       // -----------
         float differ_old = in->Items[1]->Values[1] - in->Items[1]->Values[0];     // ---- Предыдущая производная  -------
         float differ_cur;                                        // ---- Текущая производная  -------
         for ( unsigned int i = 2; i < in->Items[0]->ValuesCount; i++)
         {
            if ( in->Items[0]->Values[i-1] >= freq1 && in->Items[0]->Values[i-1] <= freq2 )
            {
                differ_cur = in->Items[1]->Values[i] - in->Items[1]->Values[i-1];
                if ( differ_old > 0 && differ_cur < 0 )
                {
                    y.Add(in->Items[1]->Values[i-1]);
                    x.Add(in->Items[0]->Values[i-1]);
                }
                differ_old = differ_cur;
            }
         }


    // теперь с предыдущих максимумов ищу первых N_Maximums максимумов
    int N_Maximums = FFT_MaxPointsCount;

    out_y->Items[0]->Clear();
    out_y->Items[1]->Clear();
    CCollection<int> indexes;

    float max = -1111;
    int   max_index = -1;
    for ( unsigned int i = 0; i < x.ValuesCount; i++ )
    {
        // Прохожусь по запомненым индексам, откидываю повторения
        bool is_index_found = false;
        for ( unsigned int k = 0; k < indexes.ValuesCount; k++ )
            if ( (int ) i == indexes.Values[k] ) is_index_found = true;
        if ( is_index_found == true ) continue;

        // фиксирую максимум
        if ( max < y.Values[i] ) {
            max_index = i;
            max       = y.Values[i];
        }

        // если дошел до конца масива, акамулирую данные
        if ( (unsigned int)i >= x.ValuesCount-1 ){
            out_y->Items[0]->Add(x.Values[max_index]);
            out_y->Items[1]->Add(y.Values[max_index]);
            indexes.Add(max_index);

            i = 0;
            max = -1111;
            max_index = -1;

            // если нашел больше четырех максимумов, валю от сюда )
            if ( indexes.ValuesCount >= (unsigned int)N_Maximums ) break;
        }
    }

}

//===========================================================================
void __fastcall Tform_Main::button_calcTauClick(TObject *Sender)
{
    DecimalSeparator = '.';
    if ( listbox_DTFFreqs->Items->Count != 0 )
        if ( listbox_DTFFreqs->ItemIndex != -1 )
            ResonatorFreq = StrToFloat(listbox_DTFFreqs->Items->Strings[listbox_DTFFreqs->ItemIndex]);

    if ( ResonatorFreq < 50 ) return;

    CTau TauDetect;
  // -------------------------------
    AddStringToLog("        Frequency " + FloatToStrF(ResonatorFreq, ffFixed, 20, 1) + "Hz"  );
    AddStringToLog("");
    AddStringToLog("Signal Filtration");
  // -------------------------------

    run_Filtration ( &SoundData, &Data_Filtr, &Data_Filtr_raw, ResonatorFreq );
    Application->ProcessMessages();


  // -------------------------------
    AddStringToLog("");
    AddStringToLog("TAU (Demodulation)");
  // -------------------------------

    if ( isTimeDefined == false )
    {
        BaseT1 = 0;
        BaseT2 = Data_Filtr_raw.ValuesCount / WorkFreq;
        edit_tau_t1->Text = BaseT1;
        edit_tau_t2->Text = FloatToStrF(BaseT2, ffFixed, 20, 2);

        isTimeDefined = true;
    }

    float t1 = StrToFloat(edit_tau_t1->Text);
    float t2 = StrToFloat(edit_tau_t2->Text);

    CCollectionStorage<float> Data_Filtr_Demod;
    Data_Filtr_Demod.SetItemsCount(7);

    TauDetect.Init( ResonatorFreq, 1.0 / WorkFreq );

    TauDetect.GetTau_demod( &Data_Filtr_raw, &Data_Filtr_Demod, t1, t2, &tau1 );

    Draw_ChartSeries_simple(Chart6, 0, true, false, 40000, 0, 0, Data_Filtr_Demod.Items[0]->ValuesCount, Data_Filtr_Demod.Items[0], Data_Filtr_Demod.Items[3]);
    Draw_ChartSeries_simple(Chart6, 1, true, false, 40000, 0, 0, Data_Filtr_Demod.Items[0]->ValuesCount, Data_Filtr_Demod.Items[0], Data_Filtr_Demod.Items[1]);
    Draw_ChartSeries_simple(Chart6, 2, true, false, 40000, 0, 0, Data_Filtr_Demod.Items[0]->ValuesCount, Data_Filtr_Demod.Items[0], Data_Filtr_Demod.Items[2]);
    Draw_ChartSeries_simple(Chart8, 0, true, false, 40000, 0, 0, Data_Filtr_Demod.Items[0]->ValuesCount, Data_Filtr_Demod.Items[0], Data_Filtr_Demod.Items[4]);
    Draw_ChartSeries_simple(Chart8, 1, true, false, 40000, 0, 0, Data_Filtr_Demod.Items[0]->ValuesCount, Data_Filtr_Demod.Items[0], Data_Filtr_Demod.Items[5]);
    Draw_ChartSeries_simple(Chart7, 0, true, false, 40000, 0, 0, Data_Filtr_Demod.Items[0]->ValuesCount, Data_Filtr_Demod.Items[0], Data_Filtr_Demod.Items[6]);

    float q = tau1 * M_PI * ResonatorFreq;
    e_Dobrotnost1->Text = FloatToStrF(q, ffFixed, 20, 2);

    AddStringToLog("        TAU = " + FloatToStrF(tau1, ffFixed, 20, 4));
    AddStringToLog("        Q   = " + FloatToStrF(q   , ffFixed, 20, 1));
    AddStringToLog("*************");

    PageControl1->TabIndex = 2;
    PageControl2->TabIndex = 0;
}

//===========================================================================
void __fastcall Tform_Main::listbox_DTFFreqsClick(TObject *Sender)
{
    DecimalSeparator = '.';
    if ( listbox_DTFFreqs->ItemIndex == -1 ) return;

    AnsiString as = listbox_DTFFreqs->Items->Strings[listbox_DTFFreqs->ItemIndex];
    double freq = StrToFloat(as);

    // ---- Заполнение полей редактора --------
    e_Freq1->Text = FloatToStrF(freq - DFT_DeltaFreq, ffFixed, 20, 2);
    e_Freq2->Text = FloatToStrF(freq + DFT_DeltaFreq, ffFixed, 20, 2);
}

//===========================================================================
void __fastcall Tform_Main::button_StopDTFCalcClick(TObject *Sender)
{
    isDTFStoped = true;
}

//===========================================================================
void __fastcall Tform_Main::button_StartDTFCalcClick1(TObject *Sender)
{
    DecimalSeparator = '.';

    if ( listbox_DTFFreqs->Items->Count != 0 )
        if ( listbox_DTFFreqs->ItemIndex != -1 )
            ResonatorFreq = StrToFloat(listbox_DTFFreqs->Items->Strings[listbox_DTFFreqs->ItemIndex]);

    PageControl1->TabIndex = 3;
    PageControl2->TabIndex = 0;
    Application->ProcessMessages();

    ClearSeries(Chart2, true);
    Chart2->AutoSize = true;
    // -----------------------------------------
    AddStringToLog("DFT Calculate");
   // -----------------------------------------

        // -----------
        float Freq1 = 0;
        float Freq2 = 0;
        try {
            Freq1 = StrToFloat( e_Freq1->Text );
            Freq2 = StrToFloat( e_Freq2->Text );
        } catch (...)
        {
            MessageBox(Handle, "Ошибка ввода диапазона частот", "Ошибка", 0);
            return;
        }

        // ----------- Чарт -----------
        ClearSeries(Chart2, true);

        button_StartDTFCalc->Enabled = false;
        button_StopDTFCalc ->Enabled = true;
        isDTFStoped = false;

////////////////////////////////
/*
        SoundData.Clear();
        Freq1 = 5929.56;
        Freq2 = 5932.56;
        WorkFreq = 48000;
        for ( int i = 0; i < 500000; i++)
            SoundData.Add(10000.0 * sin(TWO_PI*5931.06*i / (float)WorkFreq));
*/
////////////////////////////////

        // --------------
///////////////
        int CountData = SoundData.ValuesCount;
        float *x_r  = (float*) malloc (sizeof(float) * CountData);
        float  s_r;
        float  s_i;
        float  t_r;
        float  t_i;

        for ( int i = 0; i < CountData; i++)
            x_r[i] = SoundData.Values[i];

        // -------------
        int    Mode =  0;  // ----- Прямое преобразование фурье ----
        float S    = -1; // ---- Прямое или обратное (-1 / 1) преобразование
        //float R    =  1; // ----

        if ( Mode == 1 )
        {
         S = 1.0;
         //R = 1.0 / (float)CountData;
        }
        CCollection<float> xFreqValues;  xFreqValues.Clear();
        CCollection<float> yFreqValues;  yFreqValues.Clear();

        // ------------- Индексы масивов , для которых будем  считать ДПФ -----
///////////////
        int i1 = (CountData) * Freq1 / WorkFreq;
        int i2 = (CountData) * Freq2 / WorkFreq;

        // -------------
        Chart2->BottomAxis->SetMinMax(i1 / (float) CountData * WorkFreq, i2 / (float)CountData * WorkFreq);
        float CountData_inv = 1.0 / (float)CountData;
        float S_TWO_PI_CountData_inv = S*TWO_PI*CountData_inv;

        float max = -121312;
        int   max_index = -1;

        for (int k = i1; k < i2; k++ )
        {
            if ( isDTFStoped == true ) break;

                s_i = 0;
                s_r = 0;
                for ( int n = 0; n < CountData; n++ )
                {
                    float argument = S_TWO_PI_CountData_inv * k*n;

                    t_r = cos(argument);
                    t_i = sin(argument);
                    s_r = s_r + x_r[n]*t_r;// - a.i*b.i;
                    s_i = s_i + x_r[n]*t_i;// + a.r*b.i;
                }
                float x_val = k * CountData_inv * WorkFreq;
                float y_val = sqrt(s_r*s_r + s_i*s_i);

                y_val = y_val * 2.0 * CountData_inv;

                if ( max < y_val ){
                    max = y_val;
                    max_index = k;
                }

                xFreqValues.Add(x_val);
                yFreqValues.Add(y_val);

                Chart2->Series[0]->AddXY(x_val, y_val);
                Application->ProcessMessages();
        }

        float index1 = (max_index - 2 < 0 ) ? 0 : max_index - 2;
        float index2 = (max_index + 2 > CountData - 1 ) ? CountData - 1 : max_index + 2;
        float indexator_incroment = 1.0 / (float)DTF_InterpolationPointsCount;
        for (float k = index1; k < index2; k = k + indexator_incroment )
        {
            if ( isDTFStoped == true ) break;

            s_i = s_r = 0;
            for ( int n = 0; n < CountData; n++ )
            {
                //float argument = k*n * S_TWO_PI_CountData_inv;
                float argument = S_TWO_PI_CountData_inv * k*n;
                t_r = cos(argument);
                t_i = sin(argument);

                s_r = s_r + x_r[n]*t_r;
                s_i = s_i + x_r[n]*t_i;
            }
            float x_val = k * CountData_inv * WorkFreq;
            float y_val = sqrt(s_r*s_r + s_i*s_i);

            y_val = y_val * 2.0 * CountData_inv;

            xFreqValues.Add(x_val);
            yFreqValues.Add(y_val);

            Chart2->Series[0]->AddXY(x_val, y_val);
            Application->ProcessMessages();
        }

        free(x_r);


   // -----------------------------------------
   // -----------------------------------------
   // ----- Расчет добротности ----------------
   // -----------------------------------------
        if ( isDTFStoped == true ){
            AddStringToLog("DFT stoped");
        } else {
            TFastLineSeries *ls = (TFastLineSeries *)Chart2->Series[0];
            float max = -1000;
            float CenterFreq = 0;
            int   Index_of_MaxFreq = -1;

            for ( int i = 0; i < ls->YValues->Count; i++)
                if ( max < ls->YValues->Value[i] ) {
                    max              = ls->YValues->Value[i];
                    CenterFreq       = ls->XValues->Value[i];
                    Index_of_MaxFreq = i;
                }

            float freq1 = 0, freq2 = 0;
            float val1, val2;

            float px_1[2], py_1[2];
            float px_2[2], py_2[2];

            // ---- Поиск Левого бока ----
            for ( int i = Index_of_MaxFreq; i > 1; i-- ) {
                if ( ls->YValues->Value[i] <= 0.707*max)
                {
                    float df = ls->XValues->Value[i+1] - ls->XValues->Value[i];
                    float ya = ls->YValues->Value[i  ];
                    float yb = ls->YValues->Value[i+1];

                    val1  = 0.707*max;
                    freq1 = ls->XValues->Value[i] + df * (0.707*max - ya) / (yb - ya);

                    break;
                }
            }

            // ---- Поиск Правой бока ----
            for ( int i = Index_of_MaxFreq; i < ls->YValues->Count; i++ ) {
                if ( ls->YValues->Value[i] <= 0.707*max)
                {
                    float df = ls->XValues->Value[i  ] - ls->XValues->Value[i-1];
                    float ya = ls->YValues->Value[i-1];
                    float yb = ls->YValues->Value[i  ];

                    val2  = 0.707*max;
                    freq2 = ls->XValues->Value[i-1] + df * (0.707*max - ya) / (yb - ya);

                    break;
                }
            }

/*
Index_of_MaxFreq
*/
/*
            for ( int i = 1; i < ls->YValues->Count; i++)
            {
                if ( ls->YValues->Value[i] >= 0.707*max && freq1 < 100)
                {
                    float df = ls->XValues->Value[i] - ls->XValues->Value[i-1];
                    float ya = ls->YValues->Value[i-1];
                    float yb = ls->YValues->Value[i  ];

                    val1  = 0.707*max;
                    freq1 = ls->XValues->Value[i-1] + df * (0.707*max - ya) / (yb - ya);
                }
                if ( ls->YValues->Value[i] <= 0.707*max && freq1 > 100 && freq2 < 100)
                {
                    float df = ls->XValues->Value[i] - ls->XValues->Value[i-1];
                    float ya = ls->YValues->Value[i-1];
                    float yb = ls->YValues->Value[i  ];

                    val2  = 0.707*max;
                    freq2 = ls->XValues->Value[i-1] + df * (0.707*max - ya) / (yb - ya);
                }
            }
*/
            float q = CenterFreq / (freq2 - freq1);
            AddStringToLog("F/dF = " + FloatToStrF(q, ffFixed, 20, 2));
            e_Dobrotnost2->Text = FloatToStrF(q, ffFixed, 20, 2);
            Chart2->Series[1]->AddXY(CenterFreq, max);
            Chart2->Series[1]->AddXY(freq1, val1);
            Chart2->Series[1]->AddXY(freq2, val2);

            Chart2->Series[2]->AddXY(freq1 - 0.5*(freq2 - freq1), 0.707 * max);
            Chart2->Series[2]->AddXY(freq2 + 0.5*(freq2 - freq1), 0.707 * max);

            Chart2->LeftAxis->SetMinMax(0, max*1.12);
            Chart2->BottomAxis->SetMinMax(freq1 - 2.0*(freq2 - freq1), freq2 + 2.0*(freq2 - freq1));
        }
    // -----------
    button_StartDTFCalc->Enabled = true;
    button_StopDTFCalc ->Enabled = false;
    isDTFStoped = false;
}

//---------------------------------------------------------------------------
void __fastcall Tform_Main::N1Click(TObject *Sender)
{

    LoadedData.Clear();

    if ( OpenDialog1->Execute() == false ) return;

    ClearSeries(Chart2, true);
    ClearSeries(Chart4, true);
    ClearSeries(Chart5, true);
    ClearSeries(Chart6, true);
    ClearSeries(Chart7, true);
    ClearSeries(Chart8, true);

    PageControl1->TabIndex = 0;

    Caption = AnsiString(ProjectCaption) + "[" + OpenDialog1->FileName + "]";

    Application->ProcessMessages();

    float mean = 0;
    int series_index = 0;
    bool second_mode = false;
    if ( ExtractFileExt(OpenDialog1->FileName) == ".bin" )
         LoadedData.Load_binary(OpenDialog1->FileName.t_str());
    else {
        //LoadedData.Load(OpenDialog1->FileName.t_str(), NULL);
        //second_mode = true;
        //series_index = 1;
    }

    if ( second_mode == false )
        WorkFreq = 48000;
    else
        WorkFreq = 200;

    mean = LoadedData.Items[series_index]->Get_Mean();

    SoundData.Clear();

    for ( unsigned int i = 0; i < LoadedData.Items[0]->ValuesCount; i++)
        SoundData.Add(LoadedData.Items[series_index]->Values[i] - mean);

    Draw_ChartSeries(Chart4, 0, true, false, 3000, 0, 0, LoadedData.Items[series_index]->ValuesCount, NULL, LoadedData.Items[series_index]);

    bBPF_Start->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall Tform_Main::N2Click(TObject *Sender)
{
    if ( SaveDialog1->Execute() == true )
    {
        Caption = AnsiString(ProjectCaption) + "[" + SaveDialog1->FileName + "]";

        CCollectionStorage<float>  SavedData;
        SavedData.SetItemsCount(1);

        for ( unsigned int i = 0; i < SoundData.ValuesCount; i++ )
            SavedData.Items[0]->Add(SoundData.Values[i]);

        if (  ExtractFileExt(SaveDialog1->FileName) == "") SaveDialog1->FileName = SaveDialog1->FileName + ".bin";
        SavedData.Save_binary(SaveDialog1->FileName.t_str());

    }
}

//---------------------------------------------------------------------------
void __fastcall Tform_Main::tbSettingClick(TObject *Sender)
{
    Tform_Settings *dlg = new Tform_Settings(this);

    dlg->MaxsCount = FFT_MaxPointsCount;
    dlg->InterpolationPointsCount = DTF_InterpolationPointsCount;
    dlg->DeltaFreq = DFT_DeltaFreq;

    if ( dlg->ShowModal() == mrOk )
    {
        FFT_MaxPointsCount = dlg->MaxsCount;
        DTF_InterpolationPointsCount = dlg->InterpolationPointsCount;
        DFT_DeltaFreq = dlg->DeltaFreq;
    }

    delete dlg;
}

//---------------------------------------------------------------------------
void __fastcall Tform_Main::Chart5AfterDraw(TObject *Sender)
{
        DecimalSeparator = '.';

        Chart5->Series[2]->Clear();
        listbox_DTFFreqs->Items->Clear();
        BPFMaximums.Clear();
        BPFMaximums.SetItemsCount(2);

        GetMaximums( &Data_FFT, &BPFMaximums, Chart5->BottomAxis->Minimum, Chart5->BottomAxis->Maximum);
        // Отрисовка максимумов на Чарте
        // Заполнение ЛистБокса Частот в ДТФ  закладке
        listbox_DTFFreqs->Items->BeginUpdate();
        for ( unsigned int i = 0; i < BPFMaximums.Items[0]->ValuesCount; i++)
        {
            Chart5->Series[2]->AddXY(BPFMaximums.Items[0]->Values[i], BPFMaximums.Items[1]->Values[i]);
            listbox_DTFFreqs->Items->Add(FloatToStrF(BPFMaximums.Items[0]->Values[i], ffFixed, 20, 2));
        }
        listbox_DTFFreqs->Items->EndUpdate();

        if ( listbox_DTFFreqs->Items->Count != 0 )
        {
            listbox_DTFFreqs->ItemIndex = 0;
            listbox_DTFFreqsClick(Sender);
        }

        Chart5->Refresh();
        Chart5->Repaint();


        // Меняю Максимум минимум оси графика БПФ
        //CheckBox1Click(Sender);

        //float DeltaF = BPFMaximums.Items[0]->Maximum - BPFMaximums.Items[0]->Minimum;
        //Chart5->BottomAxis->SetMinMax (BPFMaximums.Items[0]->Minimum - 0.25*DeltaF, BPFMaximums.Items[0]->Maximum + 0.25*DeltaF);
}

//---------------------------------------------------------------------------
void __fastcall Tform_Main::Button1Click(TObject *Sender)
{
    edit_tau_t1->Text = BaseT1;
    edit_tau_t2->Text = FloatToStrF(BaseT2, ffFixed, 20, 2);
}

//---------------------------------------------------------------------------

