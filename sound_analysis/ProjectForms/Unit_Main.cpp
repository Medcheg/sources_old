//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Main.h"
#include "mpiGlobals.h"
#include "complex.h"
#include "math.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

TfrmMain *frmMain;
//---------------------------------------------------------------------------
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
   SoundData.gr_BaseMaxY =  16000;
   SoundData.gr_BaseMinY = -16000;
   SoundData.gr_MaxY     =  16000;
   SoundData.gr_MinY     = -16000;

   pChart->DoubleBuffered = true;

   Caption   = AnsiString(ProjectCaption) + AnsiString("0");

   isStoped  = false;
   isStarted = false;
   PlayTime  = 1;
   WorkFreq  = 1000;

   WorkFreq = -1;

   ListBox1->Clear();

   Setup_lb_WaveFormDevice();

   WaveBuffer = NULL;

   QueryPerformanceFrequency(&li_freq);

   InitGraphics();
}

//---------------------------------------------------------------------------
int __fastcall round(double aValue)
{
  int aFloor = floor(aValue);

  return (aValue - aFloor > 0.5) ? ceil (aValue) : aFloor;
}

//---------------------------------------------------------------------------

void __fastcall TfrmMain::Timer1Timer(TObject *Sender)
{
    if ( isStarted == false ) return;
    if ( SoundData.ValuesCount < 4) return;

  // -------------- Секундомер -----
    QueryPerformanceCounter(&li_q2);
    if (li_q2.QuadPart - li_q1.QuadPart >= li_freq.QuadPart)
    {
        li_q1 = li_q2;
        SecCounter++;

        Caption = ProjectCaption + IntToStr(SecCounter);
    }
    if ( SecCounter >= PlayTime - 1 ) bStopClick(Sender);

  // -------------- Отрисовка -----
    int DataCount = SoundData.ValuesCount - 2;
    Image1->Canvas->MoveTo(DrawRect.Left + AlreadyDrawedData*CoefX, ZeroPos - SoundData.Values[AlreadyDrawedData] * CoefY);
    for ( int i = AlreadyDrawedData+1; i < DataCount; i++)
    {
          int yPos;
          try {
              yPos = ZeroPos - SoundData.Values[i] * CoefY;
              if ( yPos < DrawRect.Top    ) yPos = DrawRect.Top    + 1;
              if ( yPos > DrawRect.Bottom ) yPos = DrawRect.Bottom + 1;
          } catch (...)
          {
              yPos = ZeroPos - SoundData.Values[i] * CoefY;
              if ( yPos < DrawRect.Top    ) yPos = DrawRect.Top    + 1;
              if ( yPos > DrawRect.Bottom ) yPos = DrawRect.Bottom + 1;
             _asm {nop};
          }

          Image1->Canvas->LineTo(DrawRect.Left + i*CoefX, yPos);
    }
    AlreadyDrawedData = DataCount;

    //Image1->Canvas->Draw(0, 0, DrawBitmap);
//    Image1->Canvas->Draw(0, 0, DrawBitmap);


    Application->ProcessMessages();
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
void TfrmMain::ClearSeries(TChart *aChart, bool isAutoMashtab)
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
void TfrmMain::DrawNet(TCanvas *aCanvas)
{
       aCanvas->Pen->Color = NetColor;
       double yStep = (DrawRect.Bottom  - DrawRect.Top) / 10.0;
       double xStep = (DrawRect.Right  - DrawRect.Left) / 10.0;
  // ---------------
       for ( double i = DrawRect.Top + yStep; i < DrawRect.Bottom; i = i + yStep)
       {
             aCanvas->MoveTo(DrawRect.Left , i);
             aCanvas->LineTo(DrawRect.Right, i);
       }
       for ( double i = DrawRect.Left + xStep; i < DrawRect.Right; i = i + xStep )
       {
             aCanvas->MoveTo(i, DrawRect.Top);
             aCanvas->LineTo(i, DrawRect.Bottom);

       }
   // ---- Отрисовка дополнительных отметок ------------
       double CountTicks = 4.0;
       double xStep1 = xStep / CountTicks;
       double yStep1 = yStep / CountTicks;
       short int x1 = DrawRect.Left + DrawRect.Width() / 2 - 3;
       short int x2 = DrawRect.Left + DrawRect.Width() / 2 + 3;
       short int y1 = DrawRect.Top + DrawRect.Height() / 2 - 3;
       short int y2 = DrawRect.Top + DrawRect.Height() / 2 + 3;
       for ( double i = DrawRect.Left + xStep1; i < DrawRect.Right - 2; i = i + xStep1 )
       {
           aCanvas->MoveTo(i, y1);
           aCanvas->LineTo(i, y2);
       }
       for ( double i = DrawRect.Top + yStep1; i < DrawRect.Bottom - 2; i = i + yStep1)
       {
           aCanvas->MoveTo(x1, i);
           aCanvas->LineTo(x2, i);
       }
}

//---------------------------------------------------------------------------
void TfrmMain::InitGraphics()
{
   BGColor       = (TColor)0x00154A00;
   FrameNetColor = (TColor)0x0011dd11;
   NetColor      = (TColor)0x000c8100;

   BGColor       = (TColor)0x00154A00;//0x00254A00;
   FrameNetColor = (TColor)0x0011dd11;
   NetColor      = (TColor)0x000c8100;
   DrawRect    = Rect(20, 20, Image1->Width - 20, Image1->Height - 20);

 // ---------------
/*   SoundData.gr_BaseMaxY =  ( BitsCount == 8 ) ?  70 :  12000;
   SoundData.gr_BaseMinY =  ( BitsCount == 8 ) ? -70 : -12000;
   SoundData.gr_MaxY     =  ( BitsCount == 8 ) ?  70 :  12000;
   SoundData.gr_MinY     =  ( BitsCount == 8 ) ? -70 : -12000;
*/   
 // ---------------
   pChart->Color = BGColor;
   Image1->Canvas->Brush->Color = BGColor;
   Image1->Canvas->Pen->Color = BGColor;
   Image1->Canvas->Rectangle(0, 0, Image1->Width, Image1->Height);

 // ---------------
   Image1->Canvas->Pen->Color = FrameNetColor;
   Image1->Canvas->Rectangle(DrawRect);
   DrawNet(Image1->Canvas);
   Image1->Canvas->Pen->Color = clYellow;

   AlreadyDrawedData = 0;

   ZeroPos = DrawRect.Height() / 2.0 + DrawRect.Top;
   CoefX   = DrawRect.Width () / (WorkFreq * PlayTime);
   CoefY   = DrawRect.Height() / (SoundData.gr_BaseMaxY - SoundData.gr_BaseMinY);
}



void __fastcall TfrmMain::miSaveDataClick(TObject *Sender)
{
    SaveDialog1->Filter = "Файлы данных *.dat|*.dat|Text file|*.txt";
    SaveDialog1->DefaultExt = "dat";
  // ----------
    if ( SaveDialog1->Execute() == false ) return;

    if ( ExtractFileExt(SaveDialog1->FileName) == "dat")
    {
      // ----------
         FILE *h_file = fopen ( SaveDialog1->FileName.t_str(), "wb" );

         int        aCount  = SoundData.ValuesCount;
         double     aT0     = SoundData.zValueT0[0];
         short int *aValues = SoundData.ValuesPtr(0);

         fwrite(&aCount , sizeof(int   ), 1, h_file);
         fwrite(&aT0    , sizeof(double), 1, h_file);
         fwrite( aValues, sizeof(short int)*aCount, 1, h_file);

         fclose(h_file);
    } else {
         CCollectionStorage<short int> templ; templ.Clear();
         templ.SetItemsCount(1);
         templ.file_Param.StorageT0[0] = SoundData.zValueT0[0];
         templ.file_Param.FileName     = strdup(SaveDialog1->FileName.t_str());
         templ.Items[0]->SetName("MicroData");

         for ( int i = 0; i < (int)SoundData.ValuesCount; i++)
            templ.Items[0]->Add(SoundData.Values[i]);

        templ.Save(NULL, 3);
    }
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
void CALLBACK myWaveInProc(HWAVEIN hwi, UINT uMsg, DWORD dwInstance, DWORD dwParam1, DWORD dwParam2)
{
  WAVEHDR* whdr = (WAVEHDR*)dwParam1;
  switch(uMsg)
  {
    case WIM_OPEN:   __asm {nop};  break;
    case WIM_CLOSE:  __asm {nop};  break;
    case WIM_DATA:
          short int *arr = (short int*)whdr->lpData;
        // ------


          for ( unsigned int i = 0; i < (whdr->dwBufferLength / sizeof(short int) - 1 ); i++)
              frmMain->SoundData.Add(arr[i]);
        // ------
          if (frmMain->isStoped == false)
               waveInAddBuffer(hwi, whdr, sizeof(WAVEHDR));
    break;
  }
}

//===========================================================================
void __fastcall TfrmMain::Setup_lb_WaveFormDevice()
{
	ListBox1->Items->Clear();
  // ----- Количество ВАйфФОрм Устройств ------
	for ( unsigned int i = 0; i < waveInGetNumDevs(); i++)
	{
		 WAVEINCAPS wic;
		 ZeroMemory(&wic, sizeof(wic));
		 waveInGetDevCaps(i, &wic, sizeof(wic));
		 ListBox1->Items->Add(wic.szPname);
	}
}

void __fastcall TfrmMain::ListBox1Click(TObject *Sender)
{
   //if ( wic.dwFormats & WAVE_FORMAT_4M16 ) ListBox1->Items->Add(wic.szPname);
   if ( ListBox1->ItemIndex == -1 ) return;

   WAVEINCAPS wic;
   ZeroMemory(&wic, sizeof(wic));
   waveInGetDevCaps(ListBox1->ItemIndex, &wic, sizeof(wic));


   ListBox2->Items->Clear();
   for ( DWORD k = 1; k < 0xFFFFFFF; k = k * 2)// (k << 1)
   {
//2channels, 16bit, 96kHz => size is 0x5DC0
		/*
		  if ( (wic.dwFormats & WAVE_INVALIDFORMAT) && k == WAVE_INVALIDFORMAT ) ListBox2->Items->Add("invalid format");             else //  0x00000000       // invalid format
		  if ( (wic.dwFormats & WAVE_FORMAT_1M08  ) && k == WAVE_FORMAT_1M08   ) ListBox2->Items->Add("11.025 kHz, Mono,   8-bit");  else   // 0x00000001       //
		  if ( (wic.dwFormats & WAVE_FORMAT_1S08  ) && k == WAVE_FORMAT_1S08   ) ListBox2->Items->Add("11.025 kHz, Stereo, 8-bit");  else   // 0x00000002       //
		  if ( (wic.dwFormats & WAVE_FORMAT_1M16  ) && k == WAVE_FORMAT_1M16   ) ListBox2->Items->Add("11.025 kHz, Mono,   16-bit"); else   // 0x00000004       //
		  if ( (wic.dwFormats & WAVE_FORMAT_1S16  ) && k == WAVE_FORMAT_1S16   ) ListBox2->Items->Add("11.025 kHz, Stereo, 16-bit"); else   // 0x00000008       //
		  if ( (wic.dwFormats & WAVE_FORMAT_2M08  ) && k == WAVE_FORMAT_2M08   ) ListBox2->Items->Add("22.05  kHz, Mono,   8-bit");  else   // 0x00000010       //
		  if ( (wic.dwFormats & WAVE_FORMAT_2S08  ) && k == WAVE_FORMAT_2S08   ) ListBox2->Items->Add("22.05  kHz, Stereo, 8-bit");  else   // 0x00000020       //
		  if ( (wic.dwFormats & WAVE_FORMAT_2M16  ) && k == WAVE_FORMAT_2M16   ) ListBox2->Items->Add("22.05  kHz, Mono,   16-bit"); else   // 0x00000040       //
		  if ( (wic.dwFormats & WAVE_FORMAT_2S16  ) && k == WAVE_FORMAT_2S16   ) ListBox2->Items->Add("22.05  kHz, Stereo, 16-bit"); else   // 0x00000080       //
		*/
		  //if ( (wic.dwFormats & WAVE_FORMAT_4M08  ) && k == WAVE_FORMAT_4M08   ) ListBox2->Items->Add("44.1   kHz, Mono,   8-bit");  else   // 0x00000100       //
		  //if ( (wic.dwFormats & WAVE_FORMAT_4S08  ) && k == WAVE_FORMAT_4S08   ) ListBox2->Items->Add("44.1   kHz, Stereo, 8-bit");  else   // 0x00000200       //
		  if ( (wic.dwFormats & WAVE_FORMAT_4M16  ) && k == WAVE_FORMAT_4M16   ) ListBox2->Items->Add("44.1   kHz, Mono,   16-bit"); else   // 0x00000400       //
		  if ( (wic.dwFormats & WAVE_FORMAT_4S16  ) && k == WAVE_FORMAT_4S16   ) ListBox2->Items->Add("44.1   kHz, Stereo, 16-bit"); else   // 0x00000800       //
		  //if ( (wic.dwFormats & WAVE_FORMAT_48M08 ) && k == WAVE_FORMAT_48M08  ) ListBox2->Items->Add("48     kHz, Mono,   8-bit");  else   // 0x00001000       //
		  //if ( (wic.dwFormats & WAVE_FORMAT_48S08 ) && k == WAVE_FORMAT_48S08  ) ListBox2->Items->Add("48     kHz, Stereo, 8-bit");  else   // 0x00002000       //
		  if ( (wic.dwFormats & WAVE_FORMAT_48M16 ) && k == WAVE_FORMAT_48M16  ) ListBox2->Items->Add("48     kHz, Mono,   16-bit"); else   // 0x00004000       //
		  if ( (wic.dwFormats & WAVE_FORMAT_48S16 ) && k == WAVE_FORMAT_48S16  ) ListBox2->Items->Add("48     kHz, Stereo, 16-bit"); else   // 0x00008000       //
		  //if ( (wic.dwFormats & WAVE_FORMAT_96M08 ) && k == WAVE_FORMAT_96M08  ) ListBox2->Items->Add("96     kHz, Mono,   8-bit");  else   // 0x00010000       //
		  //if ( (wic.dwFormats & WAVE_FORMAT_96S08 ) && k == WAVE_FORMAT_96S08  ) ListBox2->Items->Add("96     kHz, Stereo, 8-bit");  else   // 0x00020000       //
		  if ( (wic.dwFormats & WAVE_FORMAT_96M16 ) && k == WAVE_FORMAT_96M16  ) ListBox2->Items->Add("96     kHz, Mono,   16-bit"); else   // 0x00040000       //
		  if ( (wic.dwFormats & WAVE_FORMAT_96S16 ) && k == WAVE_FORMAT_96S16  ) ListBox2->Items->Add("96     kHz, Stereo, 16-bit");  // 0x00080000       //
   }

// ---------------
//   int iIndex = ListBox2->Items->IndexOf("44.1   kHz, Mono,   16-bit");
//   if ( iIndex == -1 ) ListBox2->ItemIndex = iIndex;
}

//---------------------------------------------------------------------------
void TfrmMain::ClearLog()
{
	mLog->Clear();
}

//---------------------------------------------------------------------------
void TfrmMain::AddStringToLog(AnsiString as)
{
   mLog->Lines->Add(as);
   Application->ProcessMessages();
}

void __fastcall TfrmMain::bStartClick(TObject *Sender)
{
     if ( ListBox1->ItemIndex == -1) return;
     if ( ListBox2->ItemIndex == -1) return;

     PlayTime = StrToFloat(eWorkTime->Text);
     SoundData.Clear();
     InitEditedControl();
     ClearLog();
     ListBox3->Items->Clear();
     AddStringToLog("Старт съема данных");

  // -----------
     SecCounter          = 0;
     isStoped            = false;
     isStarted           = true;
     bStart->Enabled     = false;
     bStop ->Enabled     = true;
     bBPF_Start->Enabled = false;
     bDTF_Start->Enabled = false;

  // -----------
     QueryPerformanceCounter(&li_q1);

  // ----------
     char  str[255];
     int   ChanelsCount;
     BitsCount    = -1;
     sscanf(ListBox2->Items->Strings[ListBox2->ItemIndex].t_str(), "%f kHz, %s %i", &WorkFreq, str, &BitsCount);

     WorkFreq     = round(WorkFreq * 1000.0);
     ChanelsCount = ( strcmp(str, "Mono,") == 0) ? 1 : 2;

     SoundData.zValueT0[0]     =  1.0 / WorkFreq;
  // ---------
     InitGraphics();

    //HANDLE       hwndApp = Handle;
    unsigned int wReturn = -1;

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
    wReturn = waveInOpen((LPHWAVEIN)&hWaveIn, ListBox1->ItemIndex, (LPWAVEFORMATEX)&wfx, (LONG)myWaveInProc, 0L, CALLBACK_FUNCTION);

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
        wReturn = waveInAddBuffer    (hWaveIn, whdr, sizeof(WAVEHDR));
        if ( wReturn == 0 ) __asm {nop};
    }

  // -----------------------
    MMRESULT r = waveInStart(hWaveIn);
    if ( r == 0 ) __asm {nop};
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::bStopClick(TObject *Sender)
{
      isStoped = true;
      isStarted = false;
      bStart->Enabled = true;
      bStop ->Enabled = false;
      bBPF_Start->Enabled = true;
      bDTF_Start->Enabled = false;

      waveInReset(hWaveIn);
      waveInStop(hWaveIn);
      //waveInUnprepareHeader(hWaveIn, )
      waveInClose(hWaveIn);

      AddStringToLog("Стоп...");
      AddStringToLog("");
}
//---------------------------------------------------------------------------
// =============================================================================
template <class TemplateType> void FFT(CCollection<TemplateType> *re, CCollection<TemplateType> *im, int *aPower)
{
    double    m,Count,e,l,f;
    double    z,c,s,p,q,r,t,w,v,u,k;
    int      o, i, j,j1,i1;

    *aPower = floor(std::log((double)re->ValuesCount) / (double)std::log(2.0));
    Count   = exp(*aPower * std::log(2.0));
    m       = *aPower;
    //------------------- FFT -----------------------
    for ( l = 1; l <= m; l++){
          e =  round(exp((m+1-l)*std::log(2.0)));
          f =  round(e/2.0);
          u =  1;
          v =  0;
          z =  M_PI / (double)f;
          c =  cos(z);
          s = -sin(z);
          for ( int j = 1; j <= f; j++)
          {
                i = j;
                while (i <= Count)
                {
                      o = i + f - 1;

                      p = re->Values[i-1] + re->Values[o];
                      q = im->Values[i-1] + im->Values[o];
                      r = re->Values[i-1] - re->Values[o];
                      t = im->Values[i-1] - im->Values[o];

                      re->Values[o]   = r*u - t*v;
                      im->Values[o]   = t*u + r*v;
                      re->Values[i-1] = p;
                      im->Values[i-1] = q;

                      i = i + e;
                }
                w = u*c-v*s;
                v = v*c+u*s;
                u = w;
          }
    }

    // ----- -тюшўэр  яхЁхёЄрэютър ---------
    j=1;
    for ( i = 1; i < Count; i ++)
    {
      if (i > j) goto mot1;
      j1 = j-1;
      i1 = i-1;
      p  = re->Values[j1];
      q  = im->Values[j1];
      re->Values[j1] = re->Values[i1];
      im->Values[j1] = im->Values[i1];
      re->Values[i1] = p;
      im->Values[i1] = q;
  mot1:
      k = Count/2.0;
  mot2:
      if (k >= j) goto mot3;
      j = j - round(k);
      k = k/2.0;
      goto mot2;
  mot3:
      j = j + round(k);
    }
}



void TfrmMain::Chart_NormScale(TChart *aChart)
{
      Application->ProcessMessages();

      double minY = aChart->LeftAxis->Minimum;
      double maxY = aChart->LeftAxis->Maximum;

      aChart->LeftAxis->SetMinMax(minY - 0.2*(maxY - minY),  maxY + 0.2*(maxY - minY));
}

void TfrmMain::GetMaximums(CCollection<double> *in_y, CCollection<double> *out_x, CCollection<double> *out_y)
{
         out_x->Clear();
         out_y->Clear();

       // -----------
         double differ_old = in_y->Values[1] - in_y->Values[0];     // ---- Предыдущая производная  -------
         double differ_cur;                                        // ---- Текущая производная  -------
         for ( unsigned int i = 2; i < in_y->ValuesCount; i++)
         {
            differ_cur = in_y->Values[i] - in_y->Values[i-1];
            if ( differ_old > 0 && differ_cur < 0 )
            {
                out_y->Add(in_y->Values[i-1]);
                out_x->Add(i-1);
            }
            differ_old = differ_cur;
         }
}

void __fastcall TfrmMain::bBPF_StartClick(TObject *Sender)
{
    bBPF_Start->Enabled = false;
 // ----------- Чарт -----------
    ClearSeries(Chart1, true);
    ListBox3->Items->Clear();

  // -------------------------------
    AddStringToLog("Расчет БПФ");
  // -------------------------------

         int aPower;
         CCollection<double> re; re.Clear();
         CCollection<double> im; im.Clear();

         for ( unsigned int i = 0; i < SoundData.ValuesCount; i++) {
             re.Add(SoundData.Values[i]);
             im.Add(0);
         }

         FFT(&re, &im, &aPower);

  // -------------------------------
     AddStringToLog("Отрисовка БПФ");
  // -------------------------------

         CCollection<double> xValues; xValues.Clear();
         CCollection<double> yValues; yValues.Clear();

         int DataCount = exp(aPower * std::log(2.0));
         for ( int i = 0; i < DataCount / 2; i++)
         {
             double xVal = i / (double)DataCount * WorkFreq;
             double yVal = sqrt(re.Values[i]*re.Values[i] + im.Values[i]*im.Values[i])*2.0 / (double)DataCount;

             xValues.Add(xVal);
             yValues.Add(yVal);

             Series1->AddXY(xVal, yVal);
         }

  // -------------------------------
     AddStringToLog("Поиск максимальных амплитуд");
  // -------------------------------

         CCollection<double> ValuesOfMax, IndexesOfMax;
         GetMaximums(&yValues, &IndexesOfMax, &ValuesOfMax);

      // ----------- Нахожу 3 максимум -------
         int     MaximumCount = StrToInt(eCountMaxPoint->Text);
         double  MinFreq      = StrToFloat(eMinFreq->Text);

         for ( int i = 0; i  < MaximumCount; i++ ) { //ValuesOfMax.Count
               for ( unsigned int k = i; k  < ValuesOfMax.ValuesCount; k++ ){
                   if ( ValuesOfMax.Values[i] < ValuesOfMax.Values[k] )
                   {
                       double aa = ValuesOfMax.Values[i];
                       ValuesOfMax.Values[i] = ValuesOfMax.Values[k];
                       ValuesOfMax.Values[k] = aa;

                       double bb = IndexesOfMax.Values[i];
                       IndexesOfMax.Values[i] = IndexesOfMax.Values[k];
                       IndexesOfMax.Values[k] = bb;
                   }
               }
               double xx_val = xValues.Values[(int)IndexesOfMax.Values[i]];
               if ( xx_val < MinFreq )
               {
                  MaximumCount++;
               } else {
                  ListBox3->Items->Add(FloatToStrF(xx_val, ffFixed, 20, 2));
                  Chart1->Series[1]->AddXY(xx_val, ValuesOfMax.Values[i]);
               }
         }

    // -- Для дискретного Преобразования Фурье Вывожу значения чатоты скана ---
      if ( ListBox3->Items->Count >= 0 )
      {
           ListBox3->ItemIndex = 0;
           ListBox3Click(Sender);
      }
      AddStringToLog("Конец БПФ");
      AddStringToLog("");

    // ------ Подгонка маштаба Чарта ----------
      Chart_NormScale(Chart1);
      Chart1->BottomAxis->SetMinMax(0.0,  0.25 * WorkFreq);

      bDTF_Start->Enabled = true;
      bBPF_Start->Enabled = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::CheckBox1Click(TObject *Sender)
{
   lsDPF->Pointer->Visible = CheckBox1->Checked;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::ListBox2Click(TObject *Sender)
{
   bStart->Enabled = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::CheckBox2Click(TObject *Sender)
{
   lsDPF->Marks->Visible = CheckBox2->Checked;
}

//---------------------------------------------------------------------------
void TfrmMain::CalcDeltaFreq(CCollection<double> *xValues, CCollection<double> *yValues, int *aIndexOfMax)
{
   // -----------
     if ( yValues->ValuesCount < 2 ) return;

   // -----------

     CCollection<double> ValuesOfMax, IndexesOfMax;
     GetMaximums(yValues, &IndexesOfMax, &ValuesOfMax);

   // ----------- Нахожу 1 максимум -------
     double aValuesOfMax[30];
     aValuesOfMax[0] = -100;
     aIndexOfMax [0] = -100;
     for ( unsigned int i = 0; i  < ValuesOfMax.ValuesCount; i++ )
     {
        if ( aValuesOfMax[0] < ValuesOfMax.Values[i] )
        {
           aValuesOfMax[0] = ValuesOfMax.Values[i];
           aIndexOfMax[0] = IndexesOfMax.Values[i];
        }
     }

   // ----------- Нахожу 2 максимум -------
     aValuesOfMax[1] = -100;
     aIndexOfMax [1] = -100;
     for ( unsigned int i = 0; i < ValuesOfMax.ValuesCount; i++ )
     {
        if ( aValuesOfMax[1] < ValuesOfMax.Values[i] && IndexesOfMax.Values[i] != aIndexOfMax[0] )
        {
           aValuesOfMax[1] = ValuesOfMax.Values[i];
           aIndexOfMax[1] = IndexesOfMax.Values[i];
        }
     }
     if ( aIndexOfMax[1] < 0 ) aIndexOfMax[1] = 0;
}

//---------------------------------------------------------------------------
double  TfrmMain::GetMaxValueOnFreq(CCollection<short int> *aSoundData, double aFreq1, double aFreq2, int i1, int i2)
{
       CCollection<double> re, im;
       re.Clear(); im.Clear();
  // -----------
       for ( int i = i1; i < i2; i++)
       {
           re.Add(SoundData.Values[i]);
           im.Add(0);
       }
  // -----------
       int  aPower    = 0;
       FFT(&re, &im, &aPower);
       
  // -----------
      double aResultMax = -1000;
      int DataCount = exp(aPower * std::log(2.0));
      for ( int i = 0; i < DataCount / 2; i++)
      {
          double xVal = i / (double)DataCount * WorkFreq;
          double yVal = sqrt(re.Values[i]*re.Values[i] + im.Values[i]*im.Values[i])*2.0 / (double)DataCount;

          if ( xVal > aFreq1 && xVal < aFreq2 )
              if ( aResultMax < yVal ) aResultMax = yVal;
      }
  // -----------
      return aResultMax;
}

//---------------------------------------------------------------------------
void TfrmMain::Dobrotnost0Calculate(CCollection<short int> *aSoundData, int CountPoint, double aFreq, double *aDobrotnost, double *aDecayTime)
{
   // ---------- Если точек меньше чем нужно, тогда нафик ---------
       if ( aSoundData->ValuesCount  < 1.3 * CountPoint ) return;

   // -------- Нахожу начало с которого начинаем исследование ------
       int BeginIndex = -1;
       for ( unsigned int i = 0; i < aSoundData->ValuesCount; i++)
       {
          if ( aSoundData->Values[i] > aSoundData->Maximum * 0.9 )
          {
             BeginIndex = i;
             break;
          }
       }

   // -------- опредиляю шумовую составляющую в конце реализации -------
       double ShumValue = GetMaxValueOnFreq(aSoundData, aFreq-3, aFreq+3, aSoundData->ValuesCount - CountPoint, aSoundData->ValuesCount);

   // -------- Основной алгоритм ---------
       double curValue = 1212100;

       int    CurrentIndex = BeginIndex;
       int    LastIndex    = -1;
       //int    TimeIndex    = -1;
       bool   isFound = false;
       double MinDB = ShumValue * 2.0;
       double MaxDB = -100;
       double FreqIncriment = 0.25 * WorkFreq;
       while ( curValue >= ShumValue && CurrentIndex + CountPoint < 0.99 * aSoundData->ValuesCount )
       {
            curValue = GetMaxValueOnFreq(aSoundData, aFreq-3, aFreq+3, CurrentIndex, CurrentIndex + CountPoint);
            if ( MaxDB < curValue ) MaxDB = curValue;

            if ( curValue / MaxDB <= 0.7 && isFound == false)
            {
                isFound = true;
                //TimeIndex = CurrentIndex;
            }

            CurrentIndex = CurrentIndex + FreqIncriment;
       }
       LastIndex = CurrentIndex - FreqIncriment;

               *aDecayTime      = fabs((double)LastIndex - (double)BeginIndex) / (double)WorkFreq;
        double  DeltaDBFullTime = 20.0 * log10(MaxDB / 32768.0) - 20.0 * log10(MinDB / 32768.0);
        double  Tau_z           = *aDecayTime * exp(1.0) / DeltaDBFullTime;
        //double  Tau_z         = fabs(TimeIndex - BeginIndex) / WorkFreq;
               *aDobrotnost     =  Tau_z * M_PI  * aFreq;
}

//---------------------------------------------------------------------------
void TfrmMain::Dobrotnost1Calculate(CCollection<short int> *aValues, double aFreq, double *aDobrotnost)
{
      double Max1 =  aValues->Values[0];
//      double Max2 = -123;
      int   ArrayIndex1 = -1;
      int   ArrayIndex2 = -1;

   // --------- Нахожу первую величину, максимума принимаю ее за базовую ----------
      for ( unsigned int i = 1; i < aValues->ValuesCount; i++ )
         if ( Max1 < aValues->Values[i] )
         {
            Max1        = aValues->Values[i];
            ArrayIndex1 = i;
         }
   // ---- Отступаю от начала 0.1 секунды ----------
      Max1 = -10033;
      for ( unsigned int i = ArrayIndex1 + 0.11*WorkFreq; i < ArrayIndex1 + 0.2*WorkFreq; i++ )
         if ( Max1 < aValues->Values[i] )
         {
            Max1        = aValues->Values[i];
            ArrayIndex1 = i;
         }

   // --------- Нахожу второй индекс масива ( с права на лево по первому пересечению, по уровню 1.2 шума микрофона )--------
      double NoiseMicrofone = -100;
      for ( unsigned int i = aValues->ValuesCount - 1; i > aValues->ValuesCount - 0.2 * WorkFreq; i-- )
             if ( NoiseMicrofone < aValues->Values[i]) NoiseMicrofone = aValues->Values[i];

      NoiseMicrofone = NoiseMicrofone * 1.1;

      for ( int i = int(aValues->ValuesCount - 1); i >= 0; i-- )
      {
             if ( aValues->Values[i] < 0 ) continue;
          // ---
             if ( aValues->Values[i] > NoiseMicrofone ) // NoiseMicrofone * 1.2
             {
                 ArrayIndex2  = i;
                 break;
             }
      }

   // ---------
      AddStringToLog("Отрисовка выборки");
      Chart3->Series[0]->Clear();
      for ( int i = ArrayIndex1; i < ArrayIndex2; i++)
          if ( aValues->Values[i] > 0 ) Chart3->Series[0]->AddXY(i / WorkFreq, aValues->Values[i]);

   // ---------
      double FullDecayTime   = fabs((ArrayIndex2 - ArrayIndex1) / WorkFreq);
      //double DeltaDBFullTime = 1.0 - aValues->Value[ArrayIndex2] / Max1;
      double DeltaDBFullTime = 20.0 * log10(Max1 / 32768.0) - 20.0 * log10(aValues->Values[ArrayIndex2] / 32768.0);
      //double Tau_z           = FullDecayTime / (DeltaDBFullTime * exp(1.0));
      //*aDecayTime  = FullDecayTime;
      //*aDobrotnost = M_PI * aFreq * Tau_z;
      *aDobrotnost = FullDecayTime * exp(1.0) * M_PI  * aFreq / DeltaDBFullTime;
}

void TfrmMain::Dobrotnost2Calculate(CCollection<double> *xValues, CCollection<double> *yValues, int aFreqIndex, double aFreqValue, double *aDobrotnost)
{
          float x_val[5];
          float y_val[5];
          float MnkCoef[5];

          x_val[0] = xValues->Values[aFreqIndex - 2] - xValues->Values[aFreqIndex    ];    y_val[0] = -(yValues->Values[aFreqIndex - 2] / yValues->Values[aFreqIndex] - 1.0 ) - 0.3;
          x_val[1] = xValues->Values[aFreqIndex - 1] - xValues->Values[aFreqIndex    ];    y_val[1] = -(yValues->Values[aFreqIndex - 1] / yValues->Values[aFreqIndex] - 1.0 ) - 0.3;
          x_val[2] = xValues->Values[aFreqIndex    ] - xValues->Values[aFreqIndex    ];    y_val[2] = -(yValues->Values[aFreqIndex    ] / yValues->Values[aFreqIndex] - 1.0 ) - 0.3;
          x_val[3] = xValues->Values[aFreqIndex + 1] - xValues->Values[aFreqIndex    ];    y_val[3] = -(yValues->Values[aFreqIndex + 1] / yValues->Values[aFreqIndex] - 1.0 ) - 0.3;
          x_val[4] = xValues->Values[aFreqIndex + 2] - xValues->Values[aFreqIndex    ];    y_val[4] = -(yValues->Values[aFreqIndex + 2] / yValues->Values[aFreqIndex] - 1.0 ) - 0.3;
       // ---------------------
          Get_LMK_Coef (2, x_val, y_val, 5, MnkCoef);

       // ---------------------
          double D, x1, x2;
          double a = MnkCoef[2];
          double b = MnkCoef[1];
          double c = MnkCoef[0];

          D = b*b - 4*a*c;

          x1 = (-b - sqrt(fabs(D))) / 2.0 / a;
          x2 = (-b + sqrt(fabs(D))) / 2.0 / a;

          //*aDobrotnost = aFreqValue / (x2 - x1);
          *aDobrotnost = aFreqValue / (x2 - x1);
}

//---------------------------------------------------------------------------
void TfrmMain::InitEditedControl()
{
    e_Freq1        ->Text = "---------";
    e_Freq2        ->Text = "---------";
    e_ResonansFreq1->Text = "---------";
    e_ResonansFreq2->Text = "---------";
    e_DeltaResonans->Text = "---------";
    e_Dobrotnost0  ->Text = "---------";
    e_Dobrotnost1  ->Text = "---------";
    e_Dobrotnost2  ->Text = "---------";
    e_DecayTime    ->Text = "---------";
}


void __fastcall TfrmMain::bDTF_StartClick(TObject *Sender)
{
    isDTFStoped = false;
   // -----------------------------------------
       AddStringToLog("Расчет ДПФ");
   // -----------------------------------------

           // ----------- Чарт -----------
                bDTF_Start->Enabled = false;
                button_StopDTFCalc->Enabled = true;
           // ----------- Чарт -----------
               ClearSeries(Chart2, true);
            // -----------
               double Freq1 = StrToFloat( e_Freq1->Text );
               double Freq2 = StrToFloat( e_Freq2->Text );

            // --------------
               int CountData    = SoundData.ValuesCount;
               int ArrayMemSize = sizeof(std::complex<double>)*(CountData + 100);
               std::complex<double> *in_x  = (std::complex<double> *) malloc (ArrayMemSize);
               std::complex<double> *out_x = (std::complex<double> *) malloc (ArrayMemSize);
//                                         in_x[0] = (1,2);
            // -------------
               ZeroMemory(in_x , ArrayMemSize);
               ZeroMemory(out_x, ArrayMemSize);

            // -------------
               for ( unsigned int i = 0; i < SoundData.ValuesCount; i++) {
                   in_x[i]._Val[0] = SoundData.Values[i];
                   in_x[i]._Val[1] = 0;
               }

            // -------------
               int    Mode =  0;  // ----- Прямое преобразование фурье ----
               double S    = -1; // ---- Прямое или обратное (-1 / 1) преобразование
               double R    =  1; // ----

               if ( Mode == 1 )
               {
                 S = 1.0;
                 R = 1.0 / (double)CountData;
               }

              CCollection<double> xFreqValues;  xFreqValues.Clear();
              CCollection<double> yFreqValues;  yFreqValues.Clear();

            // ------------- Индексы масивов , для которых будем  считать ДПФ -----
               int i1 = (CountData) * Freq1 / WorkFreq;
               int i2 = (CountData) * Freq2 / WorkFreq;

            // -------------
               Chart2->BottomAxis->SetMinMax(i1 / (double) CountData * WorkFreq, i2 / (double)CountData * WorkFreq);
               for (int k = i1; k < i2; k++ )
               {
                    if ( isDTFStoped ) break;
                    out_x[k]._Val[0] = 0;
                    out_x[k]._Val[1] = 0;
                   //out_x[k]._M_re = 0;
                   //out_x[k]._M_im = 0;
                   for ( int n = 0; n < CountData; n++ )
                   {
                        double argument = S*2.0*M_PI*k*n / (double) CountData;
                        std::complex<double> temporary(cos(argument), sin(argument));

                        out_x[k] = out_x[k] + in_x[n]*temporary;
                        if ( isDTFStoped ) break;
                   }
                   out_x[k] = out_x[k] * R;

                   double x_val = k / (double)CountData * WorkFreq;

                   double y_val = sqrt(out_x[k].real()*out_x[k].real() + out_x[k].imag()*out_x[k].imag());

                   y_val = y_val * 2.0/(double)CountData;

                   xFreqValues.Add(x_val);
                   yFreqValues.Add(y_val);

                   Chart2->Series[0]->AddXY(x_val, y_val);
                   Application->ProcessMessages();
              }

            // -------------
               free(in_x);
               free(out_x);

   // -----------------------------------------
   // -----------------------------------------
        if ( isDTFStoped == true ){
            AddStringToLog("Расчет ДПФ остановлен");
        } else {
            // ---------- Нахождение 2 максимумов частот ------
               int iIndex[2];
               AddStringToLog("Расчет разночастотность");
               CalcDeltaFreq(&xFreqValues, &yFreqValues, iIndex);

            // ------------- Опредиление добротности -----------
               double Dobrotnost0 = 0;
               double Dobrotnost1 = 0;
               double Dobrotnost2 = 0;
               double DecayTime  =  0;
               double aFreq      =  0;
               int    aFreqIndex =  0;
               try
               {
                     aFreq      = ( yFreqValues.Values[iIndex[0]] > yFreqValues.Values[iIndex[1]] ) ? xFreqValues.Values[iIndex[0]] : xFreqValues.Values[iIndex[1]];
                     aFreqIndex = ( yFreqValues.Values[iIndex[0]] > yFreqValues.Values[iIndex[1]] ) ? iIndex[0]                     : iIndex[1];

                     AddStringToLog("Расчет добротности 1");
                     Dobrotnost0Calculate(&SoundData, 65536, aFreq, &Dobrotnost0, &DecayTime);

                     AddStringToLog("Расчет добротности 2");
                     Dobrotnost1Calculate(&SoundData, aFreq, &Dobrotnost1); //, double *aDecayTime

                     AddStringToLog("Расчет добротности 3");
                     Dobrotnost2Calculate(&xFreqValues, &yFreqValues, aFreqIndex, aFreq, &Dobrotnost2);
               } catch ( ... )
               {
                     bDTF_Start->Enabled = true;
               }

           // --------
                bool flag1 = ( iIndex[0] > 3 && iIndex[0] < lsDPF->XValues->Count - 3 );
                bool flag2 = ( iIndex[1] > 3 && iIndex[1] < lsDPF->XValues->Count - 3 );
            
                if ( flag1 ) Chart2->Series[1]->AddXY(xFreqValues.Values[iIndex[0]], yFreqValues.Values[iIndex[0]]);
                if ( flag2 ) Chart2->Series[1]->AddXY(xFreqValues.Values[iIndex[1]], yFreqValues.Values[iIndex[1]]);

                e_ResonansFreq1->Text = ( flag1 == true  )? FloatToStrF(xFreqValues.Values[iIndex[0]], ffFixed, 20, 1) : UnicodeString("--------");
                e_ResonansFreq2->Text = ( flag2 == true  )? FloatToStrF(xFreqValues.Values[iIndex[1]], ffFixed, 20, 1) : UnicodeString("--------");
                e_DeltaResonans->Text = ( flag1 && flag2 )? FloatToStrF(fabs(xFreqValues.Values[iIndex[1]] - xFreqValues.Values[iIndex[0]]), ffFixed, 20, 2) : UnicodeString("--------");
                e_Dobrotnost0  ->Text = IntToStr((int)Dobrotnost0);
                e_Dobrotnost1  ->Text = IntToStr((int)Dobrotnost1);
                e_Dobrotnost2  ->Text = IntToStr((int)Dobrotnost2);
                e_DecayTime    ->Text = FloatToStrF(DecayTime  , ffFixed, 20, 2);


            // ------ Подгонка маштаба Чарта ----------
              Chart_NormScale(Chart2);
          
              AddStringToLog("");
              AddStringToLog("---------------");
              AddStringToLog("");

              AddStringToLog("Расчет завершен");
          }

          bDTF_Start->Enabled = true;
          button_StopDTFCalc->Enabled = false;
          isDTFStoped = false;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::button_StopDTFCalcClick(TObject *Sender)
{
    isDTFStoped = true;
}

//---------------------------------------------------------------------------
void __fastcall TfrmMain::Chart3AfterDraw(TObject *Sender)
{
  int InputCounter = 0 ;
  for (double i = Chart3->BottomAxis->Minimum; i < Chart3->BottomAxis->Maximum; i = i + (Chart3->BottomAxis->Maximum - Chart3->BottomAxis->Minimum) / 100.0)
  {
        double y1 = MnkCoef[0] + MnkCoef[1]*i + MnkCoef[2]*i*i + MnkCoef[3]*i*i*i;

        double iy1 = Chart3->LeftAxis->CalcPosValue(y1);
        double ix1 = Chart3->BottomAxis->CalcPosValue(i);

        if ( InputCounter++ == 0) Chart3->Canvas->MoveTo(ix1, iy1);
        Chart3->Canvas->LineTo(ix1, iy1);
  }
//
}
//---------------------------------------------------------------------------


void __fastcall TfrmMain::ListBox3Click(TObject *Sender)
{
      if ( ListBox3->ItemIndex == -1 ) return;

      AnsiString as = ListBox3->Items->Strings[ListBox3->ItemIndex];
      double freq = StrToFloat(as);

    // ---- Заполнение полей редактора --------
      e_Freq1->Text = floor(freq - 2.2);
      e_Freq2->Text = ceil (freq + 2.2);
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::miSaveWaveFileClick(TObject *Sender)
{
    int aTag = ((TComponent*)Sender)->Tag;
  // ----------
    SaveDialog1->Filter     = "Звуковые файлы *.wav|*.wav";
    SaveDialog1->DefaultExt = "wav";
    if ( SaveDialog1->Execute() == false ) return;

  // ----------
      WAVHEADER wh;
      memcpy(wh.RIFF,"RIFF",4);
      memcpy(wh.WAVE,"WAVE",4);
      memcpy(wh.fmt ,"fmt ",4);
      memcpy(wh.data,"data",4);

      DWORD bWrite    = 0;
      DWORD blockSize = SoundData.ValuesCount * 2;
      short int   *block = SoundData.ValuesPtr(0);

      if ( aTag == 22)
      {

           // -------- Нахожу начало с которого начинаем исследование ------
               int BeginIndex = -1;
               for ( unsigned int i = 0; i < SoundData.ValuesCount; i++)
               {
                  if ( SoundData.Values[i] > SoundData.Maximum * 0.9 )
                  {
                     BeginIndex = i;
                     break;
                  }
               }
               blockSize = (SoundData.ValuesCount - BeginIndex) * 2;
               block     =  SoundData.ValuesPtr(BeginIndex);
      }

      wh.bytes           = blockSize+36;
      wh.siz_wf          = 16;
      wh.pcmbytes        = blockSize;
      wh.wFormatTag      = wfx.wFormatTag;
      wh.nChannels       = wfx.nChannels;
      wh.nSamplesPerSec  = wfx.nSamplesPerSec;
      wh.nAvgBytesPerSec = wfx.nAvgBytesPerSec;
      wh.nBlockAlign     = wfx.nBlockAlign;
      wh.wBitsPerSample  = wfx.wBitsPerSample;
  // -----------------
      HANDLE hFile = CreateFile(
                                    SaveDialog1->FileName.t_str(), // file to create
                                    GENERIC_WRITE, // open for writing
                                    0, // do not share
                                    NULL, // default security
                                    CREATE_ALWAYS, // overwrite existing
                                    FILE_ATTRIBUTE_NORMAL, // normal file
                                    NULL
                                );
  // -----------------
      WriteFile(hFile, (char*)&wh, sizeof(WAVHEADER), &bWrite, NULL);
      WriteFile(hFile, block, blockSize,&bWrite, NULL);
      CloseHandle(hFile);  // ----------
  // -----------------
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::C1Click(TObject *Sender)
{
//        
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

