//===========================================================================
#ifndef pmThreadH
#define pmThreadH

class CThread
{
protected:
  typedef void (* _tThreadCallBackAction)(void*, void*);

  HANDLE hThread;
  DWORD dwThreadId;
  HANDLE hEventStart;
  HANDLE hEventKill;
  HANDLE hEventPause;
  HANDLE hEventResume;
  HANDLE hEventDoneKill;
  HANDLE hEventActionDone;

  void  *pUserData;

  bool isKill;
  bool isKilled;
  bool Stoped;
  bool Finished;
  bool isThreadBeginKilled;

  static DWORD WINAPI ThreadFunc(void* lpData);
  _tThreadCallBackAction CallBackAction;
  CRITICAL_SECTION       cs;
public:
   CThread(void *apUserData);
  ~CThread();

  bool Create(bool manualStart, _tThreadCallBackAction func, int aThreadPriority);
  bool Start();
  bool Kill();

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

  __inline bool IsKill()
  {
    return isKill;
  }

  __inline bool IsKilled()
  {
    return isKilled;
  }

};
#endif
