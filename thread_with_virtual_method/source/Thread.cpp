#include "thread.h"
#include <stdio.h>

DWORD WINAPI Thread::InternalThreadProcedure(LPVOID lpParam)
{
    Thread* thread = (Thread *)lpParam;
    if(thread == NULL) ExitThread(0xFFFFFFFF);

    if(thread->threadRoutine.IsNull() == true) ExitThread(0xFFFFFFFE);
    if(thread->hStopEvent == NULL) ExitThread(0xFFFFFFFD);
    if(thread->hStopedEvent == NULL) ExitThread(0xFFFFFFFD);

    while(WaitForSingleObject(thread->hStopEvent, 0) != WAIT_OBJECT_0)
    {
        EnterCriticalSection(&thread->criticalSection);
        thread->threadRoutine();
        LeaveCriticalSection(&thread->criticalSection);
    }

    SetEvent(thread->hStopedEvent);
    ExitThread(0);
}

Thread::Thread(ThreadProcedure* proc, bool paused)
{
    hStopEvent = NULL;
    hStopedEvent = NULL;
    hThread = NULL;
    dwThreadId = 0xFFFFFFFF;

    suspend = false;

    InitializeCriticalSection(&criticalSection);
    threadRoutine += proc;
    suspend = paused;
    
    char name[64];
    sprintf_s(name, 64, "stop%p", this);
    hStopEvent = CreateEvent(NULL, TRUE, FALSE, name);
    sprintf_s(name, 64, "stoped%p", this);
    hStopedEvent = CreateEvent(NULL, TRUE, FALSE, name);
    if((hStopEvent == NULL) || (hStopedEvent == NULL)) throw("signaling events was not created");

    hThread = CreateThread(NULL, 0, InternalThreadProcedure, this, suspend ? CREATE_SUSPENDED : 0, &dwThreadId);
    if(hThread == NULL) throw ("failed to start thread");
}

Thread::~Thread()
{
    if((hStopedEvent != NULL) && (hThread != NULL))
    {
        if(WaitForSingleObject(hStopedEvent, 0) != WAIT_OBJECT_0) Abort();
    }
    if(hStopEvent != NULL) CloseHandle(hStopEvent);
    if(hStopedEvent != NULL) CloseHandle(hStopedEvent);
    if(hThread != NULL) CloseHandle(hThread);

    DeleteCriticalSection(&criticalSection);
}

void Thread::Resume()
{
    if(suspend == false) return;
    if(hThread == NULL) throw ("thread was not created");
    
    if(ResumeThread(hThread) != 1) throw ("thread was suspend or resumed outside from object");
    suspend = false;
}

void Thread::Pause()
{
    if(suspend == true) return;
    if(hThread == NULL) throw ("thread was not created");
    
    if(SuspendThread(hThread)!= 0) throw ("thread was suspend or resumed outside from object");
    suspend = true;
}

void Thread::Abort()
{
    if(hThread == NULL) throw ("thread was not created");
    if((hStopEvent == NULL) || (hStopedEvent == NULL)) throw("signaling events was not created");
    
    if(suspend == true) Resume();
    SetEvent(hStopEvent);
    WaitForSingleObject(hStopedEvent, INFINITE);
}