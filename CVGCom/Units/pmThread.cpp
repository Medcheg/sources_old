//===========================================================================
#include "pmPCH.h"
#pragma hdrstop
//===========================================================================
#include "pmThread.h"

//===========================================================================
DWORD WINAPI CThread::ThreadFunc(void* lpData)
{
  CThread* thread = (CThread *)lpData;

  if ( thread             == NULL                ) return 0xFFFFFFFF;
  if ( thread->hEventKill == INVALID_HANDLE_VALUE) return 0xFFFFFFFE;

  if(thread->hEventStart != INVALID_HANDLE_VALUE)
  {
    WaitForSingleObject(thread->hEventStart, INFINITE);
  }

 // -------------
  InitializeCriticalSection(&thread->cs);

 // -------------
  while ( thread->isKill == false )
  //while( WaitForSingleObject(thread->hEventKill, 0 ) != WAIT_OBJECT_0 )
  {
       if ( thread->isThreadBeginKilled == true ) continue;
     // ----
//        if(WaitForSingleObject(thread->hEventPause, 0) == WAIT_OBJECT_0)
//        {
//            EnterCriticalSection(&thread->cs);
//              thread->Stoped = true;
//              ResetEvent(thread->hEventPause);
//              SetEvent(thread->hEventActionDone);
//            LeaveCriticalSection(&thread->cs);
//
//          HANDLE objects[2] = {thread->hEventResume, thread->hEventKill};
//          DWORD  result     = WaitForMultipleObjects(2, objects, false, INFINITE);
//
//          if(result == (WAIT_OBJECT_0 + 1)) break;
//
//            EnterCriticalSection(&thread->cs);
//              thread->Stoped = false;
//              ResetEvent(thread->hEventResume);
//              SetEvent(thread->hEventActionDone);
//            LeaveCriticalSection(&thread->cs);
//        }

     // ----
        if(thread->CallBackAction != NULL)
        {
          thread->CallBackAction(&thread->cs, thread->pUserData);
        }
     // ----
  }

  DeleteCriticalSection(&thread->cs);
  //SetEvent(thread->hEventDoneKill);
  thread->isKilled = true;

  return 0x00000000;
}

//===========================================================================
CThread::CThread(void *apUserData)
{
  dwThreadId       = 0xFFFFFFFF;
  hThread          = INVALID_HANDLE_VALUE;
  hEventStart      = INVALID_HANDLE_VALUE;
  hEventKill       = INVALID_HANDLE_VALUE;
  hEventPause      = INVALID_HANDLE_VALUE;
  hEventResume     = INVALID_HANDLE_VALUE;
  hEventDoneKill   = INVALID_HANDLE_VALUE;
  hEventActionDone = INVALID_HANDLE_VALUE;

  isKill   = false;
  isKilled = false;

  pUserData           = apUserData;
  CallBackAction      = NULL;
  Stoped              = false;
  Finished            = false;
  isThreadBeginKilled = false;
}

//===========================================================================
CThread::~CThread()
{
  if ( hThread          != INVALID_HANDLE_VALUE ) CloseHandle(hThread);
  if ( hEventPause      != INVALID_HANDLE_VALUE ) CloseHandle(hEventPause);
  if ( hEventResume     != INVALID_HANDLE_VALUE ) CloseHandle(hEventResume);
  if ( hEventStart      != INVALID_HANDLE_VALUE ) CloseHandle(hEventStart);
  if ( hEventKill       != INVALID_HANDLE_VALUE ) CloseHandle(hEventKill);
  if ( hEventDoneKill   != INVALID_HANDLE_VALUE ) CloseHandle(hEventDoneKill);
  if ( hEventActionDone != INVALID_HANDLE_VALUE ) CloseHandle(hEventActionDone);

  hThread          = INVALID_HANDLE_VALUE;
  hEventPause      = INVALID_HANDLE_VALUE;
  hEventResume     = INVALID_HANDLE_VALUE;
  hEventStart      = INVALID_HANDLE_VALUE;
  hEventKill       = INVALID_HANDLE_VALUE;
  hEventDoneKill   = INVALID_HANDLE_VALUE;
  hEventActionDone = INVALID_HANDLE_VALUE;
}

//===========================================================================
bool CThread::Create(bool manualStart, _tThreadCallBackAction func, int aThreadPriority)
{
    char buff[128];

    if ( manualStart == true )
    {
        sprintf(buff, "START%08X\n", ((unsigned __int64)this & 0xFFFFFFFF));
        hEventStart = CreateEvent(NULL, FALSE, FALSE, buff);
    }

    isKill   = false;
    isKilled = false;

        sprintf(buff, "KILL%08X\n"   , ((unsigned __int64)this & 0xFFFFFFFF)); hEventKill       = CreateEvent(NULL, FALSE, FALSE, buff);
    sprintf(buff, "PAUSE%08X\n"  , ((unsigned __int64)this & 0xFFFFFFFF)); hEventPause      = CreateEvent(NULL, FALSE, FALSE, buff);
    sprintf(buff, "RESUME%08X\n" , ((unsigned __int64)this & 0xFFFFFFFF)); hEventResume     = CreateEvent(NULL, FALSE, FALSE, buff);
    sprintf(buff, "DONE%08X\n"   , ((unsigned __int64)this & 0xFFFFFFFF)); hEventDoneKill   = CreateEvent(NULL, FALSE, FALSE, buff);
    sprintf(buff, "ACTDONE%08X\n", ((unsigned __int64)this & 0xFFFFFFFF)); hEventActionDone = CreateEvent(NULL, FALSE, FALSE, buff);
    CallBackAction = func;

    hThread = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)ThreadFunc, (void *)this, 0, &dwThreadId);

    isThreadBeginKilled = false;

    if(hThread == INVALID_HANDLE_VALUE) return false;

    SetThreadPriority(hThread, aThreadPriority);

    if ( manualStart == false ) Sleep(100);

    return true;
}

//===========================================================================
bool CThread::Start()
{
    if ( hThread     == INVALID_HANDLE_VALUE ) return false;
    if ( hEventStart == INVALID_HANDLE_VALUE ) return true;

    isThreadBeginKilled = false;

    SetEvent(hEventStart);

    return true;
}

//===========================================================================
bool CThread::Kill()
{
    if ( hThread        == INVALID_HANDLE_VALUE ) return false;
    if ( hEventKill     == INVALID_HANDLE_VALUE ) return false;
    if ( hEventDoneKill == INVALID_HANDLE_VALUE ) return false;

    isThreadBeginKilled = true;
    Sleep(20);

    isKill = true;
    Sleep(120);
/*
    SetEvent(hEventKill);
    if( WaitForSingleObject(hEventDoneKill, 500) != WAIT_OBJECT_0 )
    {
       TerminateThread( hThread, 0 );
    }
*/
//  if ( TerminateThread( hThread, 0 ) == 0 ) __asm { nop };


    Finished = true;

    return true;
}

////===========================================================================
//bool CThread::Pause()
//{
//  if ( hThread     == INVALID_HANDLE_VALUE ) return false;
//  if ( hEventPause == INVALID_HANDLE_VALUE ) return false;
//
//  if ( Stoped == true ) return true;
//
//  SetEvent(hEventPause);
//  WaitForSingleObject(hEventActionDone, INFINITE);
//  ResetEvent(hEventActionDone);
//
//  return true;
//}
//
////===========================================================================
//bool CThread::Resume()
//{
//  if ( hThread      == INVALID_HANDLE_VALUE ) return false;
//  if ( hEventResume == INVALID_HANDLE_VALUE ) return false;
//
//  if ( Stoped == false ) return true;
//
//  SetEvent(hEventResume);
//  WaitForSingleObject(hEventActionDone, INFINITE);
//  ResetEvent(hEventActionDone);
//
//  return true;
//}

