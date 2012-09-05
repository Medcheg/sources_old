//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------

#include "mpiTypes.h"
//---------------------------------------------------------------------------

TElement *BufferElementList; // ---------- Копируемая ветка дерева ---------
int       BufferElementList_Items_Count; // ------ Количество копируемых елементов -------

int   *MaterialListID  = NULL;   int   MaterialListID_Count  = 0;
int   *RashodnikListID = NULL;   int   RashodnikListID_Count = 0;
int   *MashineListID   = NULL;   int   MashineListID_Count   = 0;
int   *EnergoListID    = NULL;   int   EnergoListID_Count    = 0;
int   *ServiseListID   = NULL;   int   ServiseListID_Count   = 0;

//TElement      *ElementList;
//TMaterial     *MaterialList;
//int            Element_Count;     // --- Количество елементов м Масиве "ElementList"
//int            Material_Count;     // ---- Количество елементов в масиве "MaterialList"
//---------------------------------------------------------------------------

