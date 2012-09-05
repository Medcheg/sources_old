//===========================================================================

#ifndef mpiDeclarationH
#define mpiDeclarationH
//===========================================================================
//#include "typeinfo.h"
#include "mpiTypes.h"
//#include "mpiLibrary.h"
//===========================================================================

//===========================================================================

//===========================================================================
extern bool Running;
extern bool Stoped;
extern bool Paused;
extern bool ProjectModified;
extern bool ProjectError;
extern bool EnabledModifiedTimePameters;
extern TWhoUseProgram WhoUseProgram;

extern AnsiString DefaultFileName;
extern AnsiString MainRegistryKeyValue;

extern TFloat CurModelTime;

/*
extern int  GlobalElementCounter;
extern TColor FonColor;
extern TFloat EndCalcTime;
extern TFloat AnalogT0;
extern TFloat DigitalT0;*/

extern TList *CalculateList;
extern TList *InputList;
extern TList *MultiInputList;
extern TList *OtherElements;


extern TProjectParam ProjectParam;
extern TManagerParam ManagerParam;
//===========================================================================
#endif
