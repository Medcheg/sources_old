//---------------------------------------------------------------------------
#ifndef mpiDeclarationH
#define mpiDeclarationH
//---------------------------------------------------------------------------
#include "mpiBlackBox.h"
//---------------------------------------------------------------------------
void ErrorExit(LPTSTR lpszFunction); 
int  PosNextLine(char *aBuffer, int aPosition);
bool DecodeBuffer(TBEvent *aEvent, unsigned char *aBuffer);
int  Correct_DataBuffer(TBEvent *aEvent);
void Save_DataEvent_to_Disk (TBEvent *aEvent, int aEventNumber);
void Save_VideoEvent_to_Disk(TBEvent *aEvent, int aEventNumber);
extern AnsiString  ProjectCaption;

extern char SaveEventPath[4096];
//---------------------------------------------------------------------------
#endif
