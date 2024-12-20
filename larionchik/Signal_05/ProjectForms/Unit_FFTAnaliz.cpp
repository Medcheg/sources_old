//===========================================================================
#include <PCH.h>
#pragma hdrstop
//===========================================================================

#include "Unit_FFTAnaliz.h"
#include "mpiBaseADC.h"
#include "mpiGlobals.h"
#include "alloc.h"
//===========================================================================
#pragma package(smart_init)
#pragma resource "*.dfm"

TfrmFFTAnaliz *frmFFTAnaliz;

//===========================================================================
__fastcall TfrmFFTAnaliz::TfrmFFTAnaliz(TComponent* Owner)
    : TForm(Owner)
{
    ChartBeginFreq          = 300;
    ChartEndFreq            = 1100;
    cbTimeInterval->Checked = true;
    re                      = NULL;
    im                      = NULL;
    isMouseDown             = false;

    cbFindFFTMaximums->Checked = cbFindFFTMaximums;
    
    SetEnableDisabled_VCL_Group(frmFFTAnaliz, "Panel2", (cbTimeInterval->Checked == false));
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::FormDestroy(TObject *Sender)
{
    if ( re != NULL )
    {
        free(re); re = NULL;
    }
    if ( im != NULL )
    {
        free(im); im = NULL;
    }
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::FormShow(TObject *Sender)
{
    Label9 ->Caption = "-----------";
    Label10->Caption = "-----------";
  // ----------
    ListBox1->Items->BeginUpdate();
    ListBox1->Items->Clear();

   // ---- ���� ������ ��������� ------
     if ( CurrentWorkDevice != NULL )
     {

        // ---- ��������� �������� -----
         for (  int i = 0; i < CurrentWorkDevice->Canals->ItemsCount; i++ )
             ListBox1->Items->AddObject(CurrentWorkDevice->Canals->Items[i]->Name, (TObject*)CurrentWorkDevice->Canals->Items[i]);
         ListBox1->ItemIndex = 0;

        // ---- ³������� ��������� ����������  -----
         cbTimeIntervalClick(Sender);
     }
    ListBox1->Items->EndUpdate();
  // ----
    if ( ChartEndFreq > 0.5 * CurrentWorkDevice->AcpCanalFreq ) ChartEndFreq = 0.5 * CurrentWorkDevice->AcpCanalFreq;
    eBeginFreq->Text = FloatToStr(ChartBeginFreq);
    eEndFreq  ->Text = FloatToStr(ChartEndFreq  );
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::FormClose(TObject *Sender,
      TCloseAction &Action)
{
    ListBox1->Items->Clear();
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::cbTimeIntervalClick(TObject *Sender)
{
    SetEnableDisabled_VCL_Group(frmFFTAnaliz, "Panel2", (cbTimeInterval->Checked == false));

    if ( CurrentWorkDevice != NULL )
          if ( cbTimeInterval->Checked == true )
          {
               eBeginTime->Text = "0";
               eEndTime  ->Text = CurrentWorkDevice->Canals->Items[0]->Count / (double)CurrentWorkDevice->AcpCanalFreq;
          }
          else
          {
              double val     = StrToFloat(eEndTime->Text);
              double newTime = CurrentWorkDevice->Canals->Items[0]->Count / (double)CurrentWorkDevice->AcpCanalFreq;

              if  ( val > newTime ) val = newTime;
              eEndTime->Text = FloatToStr(val);
          }
}

//===========================================================================
bool TfrmFFTAnaliz::CheckDoubleValue(TEdit *editBox, double *val)
{
   double TempValue = *val;
   try
   {
        *val = StrToFloat(editBox->Text);
   }
   catch ( ... )
   {
        *val = TempValue;
        MessageBox(NULL, "�� �������� ��������", "Signal - ��������������", MB_OK|MB_ICONWARNING|MB_TASKMODAL);
        editBox->SelectAll();
        editBox->SetFocus();
   }
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::Button2Click(TObject *Sender)
{
   if ( CheckDoubleValue(eBeginFreq, &ChartBeginFreq) == false ) return;
   if ( ChartBeginFreq > 0.5 * CurrentWorkDevice->AcpCanalFreq ) ChartBeginFreq = 0.5 * CurrentWorkDevice->AcpCanalFreq;
   if ( ChartBeginFreq < 0.0                                   ) ChartBeginFreq = 0.0;

   eBeginFreq->Text = ChartBeginFreq;
  // ----
   DrawFFT();
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::Button3Click(TObject *Sender)
{
   if ( CheckDoubleValue(eEndFreq, &ChartEndFreq) == false ) return;
   if ( ChartEndFreq > 0.5 * CurrentWorkDevice->AcpCanalFreq ) ChartEndFreq = 0.5 * CurrentWorkDevice->AcpCanalFreq;
   if ( ChartEndFreq < 0.0                                   ) ChartEndFreq = 0.0;

   eEndFreq->Text = ChartEndFreq;
  // --------
   DrawFFT();
}


// =============================================================================
void FFT(int InputDataCount, float *re, float *im, int *aPower, TProgressBar *sb)
{
    double    m,Count,e,l,f;
    double    z,c,s,p,q,r,t,w,v,u,k;
    int      o, i, j,j1,i1;

    *aPower = floor(std::log((double)InputDataCount) / (double)std::log(2.0));
    Count   = exp(*aPower * std::log(2.0));
    m       = *aPower;
    sb->Position = 0;
    sb->Max      = m;
    //------------------- FFT -----------------------
    for ( l = 1; l <= m; l++){
          sb->Position = l;
          Application->ProcessMessages();
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

                      p = re[i-1] + re[o];
                      q = im[i-1] + im[o];
                      r = re[i-1] - re[o];
                      t = im[i-1] - im[o];

                      re[o]   = r*u - t*v;
                      im[o]   = t*u + r*v;
                      re[i-1] = p;
                      im[i-1] = q;

                      i = i + e;
                }
                w = u*c-v*s;
                v = v*c+u*s;
                u = w;
          }
    }

    // ----- -������ ������������ ---------
    j=1;
    for ( i = 1; i < Count; i ++)
    {
      if (i > j) goto mot1;
      j1 = j-1;
      i1 = i-1;
      p  = re[j1];
      q  = im[j1];
      re[j1] = re[i1];
      im[j1] = im[i1];
      re[i1] = p;
      im[i1] = q;
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

//===========================================================================
void __fastcall TfrmFFTAnaliz::Button1Click(TObject *Sender)
{
    if ( CurrentWorkDevice   == NULL ) return;
    if ( ListBox1->ItemIndex == -1   ) return;

    // ---------
    double BeginTime, EndTime;
    if ( CheckDoubleValue(eBeginTime, &BeginTime) == false ) return;
    if ( CheckDoubleValue(eEndTime  , &EndTime  ) == false ) return;
    int    BeginArrayPoint = BeginTime * CurrentWorkDevice->AcpCanalFreq;
    int    EndArrayPoint   = EndTime   * CurrentWorkDevice->AcpCanalFreq;
    // ---------

    ClearChart();

    // --
    CCollection<short int> *cc = (CCollection<short int> *)ListBox1->Items->Objects[ListBox1->ItemIndex];
    if ( cc == NULL ) return;

 // ------
    TabSheet1->Caption = "��� - " + AnsiString(cc->Name);
    Label9 ->Caption = "-----------";
    Label10->Caption = "-----------";

  // -------------------------------
  //   AddStringToLog("������ ���");
  // -------------------------------
    fftPower = -1;
    if ( re != NULL )
    {
        free(re); re = NULL;
        free(im); im = NULL;
    }

    re = (float*) malloc ((EndArrayPoint - BeginArrayPoint + 10000) * sizeof(float));
    im = (float*) calloc ((EndArrayPoint - BeginArrayPoint + 10000),  sizeof(float));
    for ( int i = BeginArrayPoint; i < EndArrayPoint; i++ )
       re[i - BeginArrayPoint] = cc->Value[i] * cc->gr_YVoltTransformCoef;

        FFT((EndArrayPoint - BeginArrayPoint), re, im, &fftPower, ProgressBar1);

  // -------------------------------
  //   AddStringToLog("��������� ���");
  // -------------------------------
    DrawFFT();

    if ( cbFindFFTMaximums->Checked == true ) Button4Click(Sender);
}

// =============================================================================
void TfrmFFTAnaliz::ClearChart()
{
    Series1->Clear();
    Series2->Clear();
    Label9 ->Caption = "-----------";
    Label10->Caption = "-----------";

    Chart1->AutoSize = true;
    Chart1->UndoZoom();

    Application->ProcessMessages();
}

// =============================================================================
void TfrmFFTAnaliz::DrawFFT()
{
    if ( re == NULL || im == NULL ) return;
    ClearChart();
  // ----
    int DataCount = exp(fftPower * std::log(2.0));
    int DataCount_div_2 = DataCount / 2;
    double ymax = -1000;
    for ( int i = DataCount * ChartBeginFreq / CurrentWorkDevice->AcpCanalFreq ; i < DataCount * ChartEndFreq / CurrentWorkDevice->AcpCanalFreq; i++)
    {
        double xVal = i / (double)DataCount * CurrentWorkDevice->AcpCanalFreq;
        double yVal = sqrt(re[i]*re[i] + im[i]*im[i]) * 2.0 / (double)DataCount;

        if ( ymax < yVal ) ymax = yVal;
        Series1->AddXY(xVal, yVal);
    }

   // ----- Scaling ----
    Application->ProcessMessages();

    Chart1->LeftAxis->SetMinMax(-ymax*0.055, ymax +ymax *0.1);
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::Chart1MouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
    if ( isMouseDown == true ) return;
    if ( Series1->XValues->Count() == 0 ) return;

    Chart1->Canvas->ReDrawBitmap();

    Chart1->Canvas->MoveTo(X, Chart1->LeftAxis->IStartPos);
    Chart1->Canvas->LineTo(X, Chart1->LeftAxis->IEndPos  );
    Chart1->Canvas->MoveTo(X, Y);

    double freq     = Chart1->BottomAxis->CalcPosPoint(X);
    int    ar_index = ceil(((freq - Series1->XValues->MinValue) / (Series1->XValues->MaxValue - Series1->XValues->MinValue)) * Series1->XValues->Count());
    ar_index = ar_index - 1;

    if ( ar_index <                          0 ) ar_index = 0;
    if ( ar_index >= Series1->XValues->Count() ) ar_index = Series1->XValues->Count()-1;

    double val      = Series1->YValues->Value[ar_index];

  // ----
    int PointBeetwenValues = Series1->CalcXPosValue(Series1->XValues->Value[1]) - Series1->CalcXPosValue(Series1->XValues->Value[0]);
    //Series1->Stairs = ( PointBeetwenValues >= 3 );
  // ----
    Label9 ->Caption = FloatToStrF(freq, ffFixed, 20, 4);
    Label10->Caption = FloatToStrF(val , ffExponent, 4, 4);
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::Chart1MouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
    Chart1->Canvas->ReDrawBitmap();
    isMouseDown = true;
}

//===========================================================================
void __fastcall TfrmFFTAnaliz::Chart1MouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
    isMouseDown = false;
}
//===========================================================================

void __fastcall TfrmFFTAnaliz::FormActivate(TObject *Sender)
{
  DecimalSeparator = '.';    
}
//---------------------------------------------------------------------------

void __fastcall TfrmFFTAnaliz::Button4Click(TObject *Sender)
{
   double max1 = -1990;
   int    Index1 = -1;
   double max2 = -1990;
   int    Index2 = -1;
   for ( int i = 0; i < Series1->YValues->Count; i++ )
   {
        if ( max1 < Series1->YValues->Value[i] )
        {
                max1 = Series1->YValues->Value[i];
                Index1 = i;
        }
   }
   // --------------
   if ( Index1  < 0 ) return;

   double freq1 = Series1->XValues->Value[Index1] * 2.0 - 0.8;
   double freq2 = Series1->XValues->Value[Index1] * 2.0 + 0.8;
   for ( int i = Index1; i < Series1->YValues->Count; i++)
   {
        if ( Series1->XValues->Value[i] > freq1 && Series1->XValues->Value[i] < freq2)
        {
            if (  max2 < Series1->YValues->Value[i] )
            {
                max2 = Series1->YValues->Value[i];
                Index2 = i;
            }
        }
   }

    if ( Index1 >= 0 )
    {
      eFreq1     ->Text = FloatToStrF(Series1->XValues->Value[Index1], ffFixed   , 20, 4);
      eFreqValue1->Text = FloatToStrF(Series1->YValues->Value[Index1], ffExponent,  4, 4);
      Series2->AddXY(Series1->XValues->Value[Index1], Series1->YValues->Value[Index1]);
    }

    if ( Index2 >= 0 )
    {
      eFreq2     ->Text = FloatToStrF(Series1->XValues->Value[Index2], ffFixed   , 20, 4);
      eFreqValue2->Text = FloatToStrF(Series1->YValues->Value[Index2], ffExponent,  4, 4);
      Series2->AddXY(Series1->XValues->Value[Index2], Series1->YValues->Value[Index2]);
    }
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

