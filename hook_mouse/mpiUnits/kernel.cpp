#include "stdafx.h"

#define BUFFER_SIZE 1024

HANDLE hComPort = INVALID_HANDLE_VALUE;
HANDLE hKill = NULL;
HANDLE hDone = NULL;
HANDLE hReady = NULL;
HANDLE hReadThread = NULL;
DWORD dwReadThread = 0xFFFFFFFF;
bool Stopped = false;

unsigned char ReceivedData[BUFFER_SIZE];
int ReceivedPos = 0;
int ReceivedCount = 0;

static void ProcessData(unsigned char* data, int size)
{
  if((ReceivedPos + size) > BUFFER_SIZE) ReceivedPos = 0;
  memcpy(&ReceivedData[ReceivedPos], data, size);
  ReceivedCount = size;
  SetEvent(hReady);
}

static DWORD ThreadProc(LPVOID param)
{
  DWORD mask;
  DWORD size;
  OVERLAPPED ovWait;

  if(hComPort == INVALID_HANDLE_VALUE) ExitThread(1);
  if(hKill == NULL) ExitThread(1);
  if(hDone == NULL) ExitThread(1);
  if(hReady == NULL) ExitThread(1);

  ovWait.Internal = 0;
  ovWait.InternalHigh = 0;
  ovWait.Offset = 0;
  ovWait.OffsetHigh = 0;
  ovWait.hEvent = CreateEvent(NULL, FALSE, FALSE, NULL);
  if(ovWait.hEvent == NULL) ExitThread(3);

  while(true)
  {
    if(hComPort == INVALID_HANDLE_VALUE) ExitThread(2);

    ovWait.Internal = 0;
    ovWait.InternalHigh = 0;
    ovWait.Offset = 0;
    ovWait.OffsetHigh = 0;
    ovWait.Pointer = NULL;
    SetLastError(0);
    if(WaitCommEvent(hComPort, &mask, &ovWait) == FALSE)
    {
      if(GetLastError() == ERROR_IO_PENDING)
      {
        ResetEvent(ovWait.hEvent);
        continue;
      }
      else ExitThread(4);
    }
    ResetEvent(ovWait.hEvent);

    //-----------------------------------------------------
    // зафиксирована ошибка
    //-----------------------------------------------------
    if(mask & EV_ERR)
    {
      DWORD errs;
      COMSTAT stat;
      ClearCommError(hComPort, &errs, &stat);
    }

    //-----------------------------------------------------
    // приняты данные
    //-----------------------------------------------------
    if(mask & EV_RXCHAR)
    {
      BYTE data[64];
      ReadFile(hComPort, data, 16, &size, &ovWait);

      ProcessData(data, size);
      HANDLE events[2] = {hDone, hKill};
      DWORD resultEvent;
      resultEvent = WaitForMultipleObjects(2, events, FALSE, INFINITE);
      if(resultEvent == (WAIT_OBJECT_0+1)) break;
      ResetEvent(hDone);
    }
  }

  CloseHandle(ovWait.hEvent);
  CloseHandle(hDone);
  CloseHandle(hKill);
  CloseHandle(hReady);
  hDone = NULL;
  hKill = NULL;
  ExitThread(0);
}

bool InitReadingThread()
{
  hDone = CreateEvent(NULL, TRUE, FALSE, "DONE PROC");
  hKill = CreateEvent(NULL, TRUE, FALSE, "KILL PROC");
  hReady = CreateEvent(NULL, TRUE, FALSE, "DATA READY");
  hReadThread = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE )ThreadProc, NULL, 0, &dwReadThread);
  return (hReadThread != NULL);
}

void TerminateReadingThread()
{
  if(hReadThread == INVALID_HANDLE_VALUE) return;
  if(Stopped == true)
  {
    ResumeThread(hReadThread);
    Stopped = false;
  }
  SetEvent(hKill);
  hReadThread = INVALID_HANDLE_VALUE;
  dwReadThread = 0;
}
