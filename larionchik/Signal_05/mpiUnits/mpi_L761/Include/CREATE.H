#ifndef __TEST__
#define __TEST__

typedef IDaqLDevice* (*CREATEFUNCPTR)(ULONG Slot);

HINSTANCE CallCreateInstance(char* name);

extern CREATEFUNCPTR CreateInstance;

#endif
