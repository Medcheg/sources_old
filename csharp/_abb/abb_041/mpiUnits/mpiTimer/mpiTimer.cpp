//---------------------------------------------------------------------------
#pragma hdrstop
#include "mpiTimer.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#include <windows.h>

///TmpiTimer aTimer;
bool mpiTimerThreadFlag = true;

DWORD TmpiTimer::ThreadProc(LPVOID param)
{
     TmpiTimer* CurrTimer = (TmpiTimer *)param;
  // -------
     while (mpiTimerThreadFlag == true) {
            QueryPerformanceCounter(&CurrTimer->liCurCounter);

          // ---- �������� ������� (����� ���������) -----  
            if (CurrTimer->liCurCounter.QuadPart >= CurrTimer->NextOneSecTimeCounter) {
                CurrTimer->NextOneSecTimeCounter += CurrTimer->liFrequency.QuadPart;
                CurrTimer->RealFreq = CurrTimer->TickCounter;
                CurrTimer->TickCounter = 0;
            }
            
          // ----------
            if (CurrTimer->liCurCounter.QuadPart >= CurrTimer->NextTimeCounter) {
                CurrTimer->TickCounter++;
                CurrTimer->NextTimeCounter += CurrTimer->TimerFreq;
                CurrTimer->OnTimer(CurrTimer->GetTime());
            }
     }
  // -------
     ExitThread(0);
     return 0;
}

//---------------------------------------------------------------------------
bool TmpiTimer::isEnabled()
{
      return fEnabled;
}

//---------------------------------------------------------------------------
void TmpiTimer::Enabled(bool isEnabled)
{
   // ---- asd ---
      if (fEnabled == isEnabled) return;

      fEnabled = isEnabled;

   // ---- ���� ���������� ������ - ����� ----
      if (isEnabled == false) {
            QueryPerformanceCounter(&liStopCounter);
            fEnabled = false;
            if (hReadThread != NULL) SuspendThread(hReadThread);
            return;
      }

   // ---- ���� ��������� ������ - ����� ----
      if (isEnabled == true) {
           // ---- ������ ������ ������� -- ����� ������ (liBaseCounter) ------
            if (fFirstStart == true) {
                 QueryPerformanceCounter(&liBaseCounter );
                 liStopCounter.QuadPart  = liBaseCounter.QuadPart;
                 fFirstStart             = false;
            }
            QueryPerformanceCounter(&liCurCounter);
            liBaseCounter.QuadPart = liBaseCounter.QuadPart + (liCurCounter.QuadPart - liStopCounter.QuadPart);

            if (hReadThread != NULL) {
               //OldCounterStep = liCurCounter.QuadPart; // --- ���� - � �� �������� ������  :)) *------
               NextTimeCounter       = liCurCounter.QuadPart + TimerFreq;
               NextOneSecTimeCounter = liCurCounter.QuadPart + liFrequency.QuadPart;
               ResumeThread(hReadThread);
            }
      }
}

//---------------------------------------------------------------------------
TmpiTimer::TmpiTimer()
{
   // -----------
     QueryPerformanceFrequency(&liFrequency);
     fEnabled                = false;
     fFirstStart             = true;
     TimerFreq               = 0;
     OnTimer                 = NULL;
     //hDone                   = NULL;
     //hKill                   = NULL;
     hReadThread             = NULL;
}

//---------------------------------------------------------------------------
TmpiTimer::~TmpiTimer()
{
    if (fEnabled == true)
       if (hReadThread != NULL) SuspendThread(hReadThread);
}

//---------------------------------------------------------------------------
TmpiTimer::TmpiTimer(TOnTimer aOnTimer, int aFreq)
{
     QueryPerformanceFrequency(&liFrequency);
     fEnabled                = false;
     fFirstStart             = true;
     TimerFreq               = 0;
     OnTimer                 = NULL;
     //hDone                   = NULL;
     //hKill                   = NULL;
     hReadThread             = NULL;
   // -------------------------
     TimerFreq = liFrequency.QuadPart / (double) aFreq;
     OnTimer   = aOnTimer;
   // ----- ������ ����� -----
     //hDone       = CreateEvent (NULL, TRUE, FALSE, "DONE PROC");
     //hKill       = CreateEvent (NULL, TRUE, FALSE, "KILL PROC");
     hReadThread = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE )ThreadProc, (LPVOID)(this), CREATE_SUSPENDED, &dwReadThread);
     //SetThreadPriority(hReadThread, THREAD_PRIORITY_HIGHEST);
}

//---------------------------------------------------------------------------
double TmpiTimer::GetTime()
{
    QueryPerformanceCounter(&liCurCounter);
  // -----------
    if ( fEnabled == false ) return 0;
  // -----------
    return (liCurCounter.QuadPart - liBaseCounter.QuadPart) / (double) liFrequency.QuadPart;
}

//---------------------------------------------------------------------------
void TmpiTimer::Reset()
{ // ----- ��������� ��� ��������� ------
     QueryPerformanceCounter(&liBaseCounter);
     fFirstStart = true;
}
//---------------------------------------------------------------------------

