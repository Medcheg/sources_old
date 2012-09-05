//===========================================================================
#include "mpiOperationWithElement.h"

//===========================================================================
TElement *FindElementByID(int aId, TElement **aElementList, int aElementList_Count)
{
   TElement *Result = NULL;

   for (int i = 0; i < aElementList_Count; i++)
       if (aElementList[i] != NULL)
           if (aElementList[i]->Id == aId) {
               Result = aElementList[i];
               break;
           }

   return Result;
}

//===========================================================================

