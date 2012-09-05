#ifndef _THREAD__INC_
#define _THREAD__INC_

#include <windows.h>
#include "delegate.h"

typedef IDelegate ThreadProcedure;

class Thread
{
private:
    static DWORD WINAPI InternalThreadProcedure(LPVOID lpParam);

private:
    MultyCastDelegate threadRoutine;
    
    CRITICAL_SECTION criticalSection;
    HANDLE hStopEvent;
    HANDLE hStopedEvent;
    HANDLE hThread;
    DWORD dwThreadId;

    bool suspend;
public:
    Thread(ThreadProcedure* proc, bool paused = false) throw(...);
    ~Thread();

    void Resume() throw(...);
    void Pause() throw(...);
    void Abort() throw(...);
};

#endif