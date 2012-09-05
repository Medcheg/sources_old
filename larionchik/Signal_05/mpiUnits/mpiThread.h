#ifndef mpiThread_H
#define mpiThread_H

//#include <windows.h>

class CmpiThread
{
public:

protected:
  typedef void (* _tThreadCallBackAction)(void*, void*);

  HANDLE hThread;
  DWORD dwThreadId;
  HANDLE hEventStart;
  HANDLE hEventKill;
  HANDLE hEventPause;
  HANDLE hEventResume;
  HANDLE hEventDone;
  HANDLE hEventActionDone;

  void  *pUserData;

  bool Stoped;
  bool Finished;

  static DWORD WINAPI ThreadFunc(void* lpData);
  _tThreadCallBackAction CallBackAction;
  CRITICAL_SECTION       cs;
public:
   CmpiThread(void *apUserData);
  ~CmpiThread();

  bool Create(bool manualStart, _tThreadCallBackAction func, int aThreadPriority);
  bool Start();
  bool Kill();
  bool Pause();
  bool Resume();

  __inline void SetPriotity(int aLevel)
  {
      SetThreadPriority(hThread, aLevel);
  }

  __inline bool IsPaused()
  {
    return Stoped;
  }

  __inline void SetAction(_tThreadCallBackAction func)
  {
    CallBackAction = func;
  }

  __inline bool IsFinished()
  {
    return Finished;
  }
};
#endif