//===========================================================================
#include "PCH.h"
#pragma hdrstop
//===========================================================================
#include "mpiThread.h"

DWORD WINAPI CmpiThread::ThreadFunc(void* lpData)
{
  CmpiThread* thread = (CmpiThread *)lpData;
  if(thread == NULL) return 0xFFFFFFFF;
  if(thread->hEventKill == INVALID_HANDLE_VALUE) return 0xFFFFFFFE;

  if(thread->hEventStart != INVALID_HANDLE_VALUE)
  {
    WaitForSingleObject(thread->hEventStart, INFINITE);
  }

//  SetThreadAffinityMask(thread->hThread, 3);
  InitializeCriticalSection(&thread->cs);

  while(WaitForSingleObject(thread->hEventKill, 0) != WAIT_OBJECT_0)
  {
     // ----
        if(WaitForSingleObject(thread->hEventPause, 0) == WAIT_OBJECT_0)
        {
            EnterCriticalSection(&thread->cs);
              thread->Stoped = true;
              ResetEvent(thread->hEventPause);
              SetEvent(thread->hEventActionDone);
            LeaveCriticalSection(&thread->cs);

          HANDLE objects[2] = {thread->hEventResume, thread->hEventKill};
          DWORD result = WaitForMultipleObjects(2, objects, false, INFINITE);
          if(result == (WAIT_OBJECT_0 + 1)) break;

            EnterCriticalSection(&thread->cs);
              thread->Stoped = false;
              ResetEvent(thread->hEventResume);
              SetEvent(thread->hEventActionDone);
            LeaveCriticalSection(&thread->cs);
        }
     // ----
        if(thread->CallBackAction != NULL)
        {
          thread->CallBackAction(&thread->cs, thread->pUserData);
        }
     // ----
  }

  DeleteCriticalSection(&thread->cs);
  SetEvent(thread->hEventDone);

  return 0x00000000;
}

CmpiThread::CmpiThread(void *apUserData)
{
  hThread          = INVALID_HANDLE_VALUE;
  dwThreadId       = 0xFFFFFFFF;
  hEventStart      = INVALID_HANDLE_VALUE;
  hEventKill       = INVALID_HANDLE_VALUE;
  hEventPause      = INVALID_HANDLE_VALUE;
  hEventResume     = INVALID_HANDLE_VALUE;
  hEventDone       = INVALID_HANDLE_VALUE;
  hEventActionDone = INVALID_HANDLE_VALUE;

  pUserData        = apUserData;

  CallBackAction = NULL;
  Stoped         = false;
  Finished       = false;
}

CmpiThread::~CmpiThread()
{
  if(hThread          != INVALID_HANDLE_VALUE) CloseHandle(hThread);          hThread          = NULL;
  if(hEventPause      != INVALID_HANDLE_VALUE) CloseHandle(hEventPause);      hEventPause      = NULL;
  if(hEventResume     != INVALID_HANDLE_VALUE) CloseHandle(hEventResume);     hEventResume     = NULL;
  if(hEventStart      != INVALID_HANDLE_VALUE) CloseHandle(hEventStart);      hEventStart      = NULL;
  if(hEventKill       != INVALID_HANDLE_VALUE) CloseHandle(hEventKill);       hEventKill       = NULL;
  if(hEventDone       != INVALID_HANDLE_VALUE) CloseHandle(hEventDone);       hEventDone       = NULL;
  if(hEventActionDone != INVALID_HANDLE_VALUE) CloseHandle(hEventActionDone); hEventActionDone = NULL;
}

bool CmpiThread::Create(bool manualStart, _tThreadCallBackAction func, int aThreadPriority)
{
  char buff[128];

  if(manualStart == true)
  {
    sprintf(buff, "START%08X\n", ((unsigned __int64)this & 0xFFFFFFFF));
    hEventStart = CreateEvent(NULL, TRUE, FALSE, buff);
  }

  sprintf(buff, "KILL%08X\n"   , ((unsigned __int64)this & 0xFFFFFFFF));  hEventKill       = CreateEvent(NULL, TRUE, FALSE, buff);
  sprintf(buff, "PAUSE%08X\n"  , ((unsigned __int64)this & 0xFFFFFFFF));  hEventPause      = CreateEvent(NULL, TRUE, FALSE, buff);
  sprintf(buff, "RESUME%08X\n" , ((unsigned __int64)this & 0xFFFFFFFF));  hEventResume     = CreateEvent(NULL, TRUE, FALSE, buff);
  sprintf(buff, "DONE%08X\n"   , ((unsigned __int64)this & 0xFFFFFFFF));  hEventDone       = CreateEvent(NULL, TRUE, FALSE, buff);
  sprintf(buff, "ACTDONE%08X\n", ((unsigned __int64)this & 0xFFFFFFFF));  hEventActionDone = CreateEvent(NULL, TRUE, FALSE, buff);

  CallBackAction = func;

  hThread = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)ThreadFunc, (void *)this, 0, &dwThreadId);

  if(hThread == INVALID_HANDLE_VALUE) return false;

  SetThreadPriority(hThread, aThreadPriority);

  return true;
}

bool CmpiThread::Start()
{
  if ( hThread     == INVALID_HANDLE_VALUE) return false;
  if ( hEventStart == INVALID_HANDLE_VALUE) return true;

  SetEvent(hEventStart);
  return true;
}

bool CmpiThread::Kill()
{
  if ( hThread    == INVALID_HANDLE_VALUE) return false;
  if ( hEventKill == INVALID_HANDLE_VALUE) return false;
  if ( hEventDone == INVALID_HANDLE_VALUE) return false;

  SetEvent(hEventKill);
  WaitForSingleObject(hEventDone, INFINITE);
  Finished = true;
  return true;
}

bool CmpiThread::Pause()
{
  if ( hThread     == INVALID_HANDLE_VALUE) return false;
  if ( hEventPause == INVALID_HANDLE_VALUE) return false;

  if(Stoped == true) return true;

  SetEvent(hEventPause);
  WaitForSingleObject(hEventActionDone, INFINITE);
  ResetEvent(hEventActionDone);
  
  return true;
}

bool CmpiThread::Resume()
{
  if(hThread == INVALID_HANDLE_VALUE) return false;
  if(hEventResume == INVALID_HANDLE_VALUE) return false;

  if(Stoped == false) return true;
  SetEvent(hEventResume);
  WaitForSingleObject(hEventActionDone, INFINITE);
  ResetEvent(hEventActionDone);
  return true;
}
