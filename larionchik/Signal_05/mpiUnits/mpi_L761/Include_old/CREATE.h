#ifndef __TEST__
#define __TEST__

typedef IDaqLDevice* (*CREATEFUNCPTR)(ULONG Slot);

ULONG CallCreateInstance(char* name);
ULONG CallFreeInstance();

extern CREATEFUNCPTR CreateInstance;

#endif
