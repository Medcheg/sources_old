//===========================================================================

#include <vcl.h>
#pragma hdrstop

#include "mpiDeclaration.h"
//===========================================================================
bool Running                     = false;
bool Stoped                      = true;
bool Paused                      = false;
bool ProjectModified             = false;
bool ProjectError                = false;
bool EnabledModifiedTimePameters = true;
int  GlobalElementCounter = 0;

TWhoUseProgram WhoUseProgram;

TFloat CurModelTime = 0;

AnsiString DefaultFileName = "noname.dls";

AnsiString MainRegistryKeyValue = "DiALab - Digital & Analog Laboratory";

TList *CalculateList;   // ---- Список правильной последовательности счета ---
TList *InputList;       // ---- Список входных элементов (Под входным элементом понимается элемент у которого нету входов и есть больше равно одного выхода) ---------------------
TList *MultiInputList;  // ---- Список элементов имеющие больше чем один вход (тут не учитываются блочные элементы) ---
TList *SumMultList;     // ---- Список элементов Суматоров и Умножителей  ---
TList *OtherElements;   // ---- Список "стандартных" элементов ----


TProjectParam ProjectParam;
TManagerParam ManagerParam;
//===========================================================================
//===========================================================================
void Initialization()
{
    CalculateList  = new TList();
    InputList      = new TList();
    MultiInputList = new TList();
    OtherElements  = new TList();
}

//===========================================================================
void Finalization()
{
    delete CalculateList;
    delete InputList;
    delete MultiInputList;
    delete OtherElements;
}
//===========================================================================
#pragma startup Initialization 100 //<priority> // ---- default 100
#pragma exit    Finalization   100 //<priority> // ---- default 100

