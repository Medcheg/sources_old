//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "mpiMath.h"
#include "mpiGraph.h"
#include "Unit_GraphicList.h"
#include "Unit_TargetList.h"
//#include "Unit_GL.h"

//---------------------------------------------------------------------------

#pragma package(smart_init)

  AnsiString as_h;
  AnsiString as_m;
  AnsiString as_s;
  AnsiString as_ms;

  LARGE_INTEGER liFrequency;
  LARGE_INTEGER liCurCounter;
  LARGE_INTEGER liStepCounter;

void InitialPositionSimulation()
{
   CurModelTime  = 0;
   CurReviewTime = 0;
  // -------
   TimerRefreshTime = -1.0 / TimerRefreshFreq;
  // -------
   Stoped           = false;
   Paused           = false;
  // -------
   OperationCounter = 0;
  // -------
   aFar         ->Init();
   Indicator    ->Init();
   Graph        ->Init();
   frmTargetList->Init();
  // --------
   ReCreateDiagrams(4);

//   aFar->Calc_Beam_EllipseCoordinates(true);
//   frmSimulationEllipses->Init();
}

void DelayProcess()
{
   QueryPerformanceCounter(&liStepCounter);
   liCurCounter = liStepCounter;
   liStepCounter.QuadPart += DelayValue * liFrequency.QuadPart / 100000;

   while (liCurCounter.QuadPart < liStepCounter.QuadPart)
   {
      QueryPerformanceCounter(&liCurCounter);
   }
}

void ModifiedTimer()
{
  // ----------- Модификация глобального таймера --------
    int h         =     CurModelTime  /   3600;
    int TempValue =     CurModelTime  - h*3600;
    int m         =     TempValue     /   60;
    int s         =     TempValue     - m*60;
    int ms        =    (CurModelTime  - int(CurModelTime))*1000;

    as_h  = IntToStr(h);   if (as_h .Length() == 1) as_h  = "0" + as_h;
    as_m  = IntToStr(m);   if (as_m .Length() == 1) as_m  = "0" + as_m;
    as_s  = IntToStr(s);   if (as_s .Length() == 1) as_s  = "0" + as_s;
    as_ms = IntToStr(ms);  if (as_ms.Length() == 2) as_ms = "0" + as_ms; else if (as_ms.Length() == 1) as_ms = "00" + as_ms;

    frmMain->pTimer->Caption = as_h + ':' + as_m + ':' + as_s + ':' + as_ms;

  // ----------- Модификация кругового таймера --------
    s     = int(CurReviewTime);
    ms    = (CurReviewTime  - int(CurReviewTime))*1000;
    as_s  = IntToStr(s);   if (as_s .Length() == 1) as_s  = "0" + as_s;
    as_ms = IntToStr(ms);  if (as_ms.Length() == 2) as_ms = "0" + as_ms; else if (as_ms.Length() == 1) as_ms = "00" + as_ms;

    frmMain->pReviewTimer->Caption = as_s + ':' + as_ms;

    TStatusPanels *sp = frmMain->sbWork->Panels;
  // ----------- Модификация Номера обзора --------
    sp->Items[2]->Text = " № обзора : " + IntToStr(aFar->CountReview);

  // ----------- Модификация значения азимутального положения ФАР --------
    TFloat ka = aFar->CurAzimFAR_Korabel * _180_del_Pi;
    if (ka < 0) ka = ka + 360;
    sp->Items[5]->Text = " Ka : " + FloatToStrF(ka, ffFixed, 7, 2) + "°";
}

void RunDynamicModel()
{
   InitialPositionSimulation();

   QueryPerformanceFrequency(&liFrequency);
   Started   = true;
   int OldFa = 0;

   while (!Stoped) {
      OperationCounter ++;

      if (!Paused || ModelStepEnabled) {
          // ---------------------------------------------------------
          // --------------------- FAR MODELLING ---------------------
          // ---------------------------------------------------------
             Calc_Wave();
             aFar->Next();
             Indicator->Draw();
             Graph->Draw();

             if ( DelayValue != 0) DelayProcess();
          // ---------- END FAR MODELLING -----

            if (ModelStepEnabled || CurModelTime >= TimerRefreshTime + 1/TimerRefreshFreq){
                 ModifiedTimer();
                 TimerRefreshTime += 1.0 / TimerRefreshFreq;
               // -------
                 frmTargetList->ReDrawTargetIndicatorForm();
            }

        // ---------
           CurModelTime  += 1.0 / aFar->Fa;
           CurReviewTime += 1.0 / aFar->Fa;

          if (ModelStepEnabled || OldFa != aFar->Fa){
                AnsiString TempString = " Частота след. имп " + IntToStr(aFar->Fa) + " Гц";
                 frmMain->sbWork->Panels->Items[1]->Text = TempString;
                 OldFa = aFar->Fa;
          }
        // ----- 5 часовая проверка --------
          if (CurModelTime >= 18000) frmMain->tbStopClick(NULL);
          ModelStepEnabled = false;
      }
      Application->ProcessMessages();
   }
}
