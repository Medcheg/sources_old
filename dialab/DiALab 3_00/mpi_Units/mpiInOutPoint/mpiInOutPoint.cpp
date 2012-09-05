//---------------------------------------------------------------------------
#include "mpiInOutPoint.h"
#include "mpiElement.h"
//---------------------------------------------------------------------------
TInOutPoint::TInOutPoint(void *aParentElement, int *aCountInOutPointsOnElement, std::string aCaption, TPointType aType)
{
   fParentElement             = aParentElement;
   fCountInOutPointsOnElement = aCountInOutPointsOnElement;
   Caption                    = aCaption;
   Queue                      = NULL; 
   Elements                   = NULL;
   Elements_Count             = 0;
   xPos                       = 0;
   yPos                       = 0;
   Conected                   = false;
   Visible                    = true;
   Type                       = aType;
   EnableCalc                 = NULL;
   CurrentLink                = NULL;

   if (Type == tOutput) {
        EnableCalc = (bool*) malloc (sizeof(bool));
       *EnableCalc = false;
   }
}

//===========================================================================
TInOutPoint::~TInOutPoint()
{
   if (Type == tInput) {
      Queue = NULL;
      return;
   }

   if (Elements_Count != 0)
        free (Elements);

   if (EnableCalc != NULL) free (EnableCalc);     

   free (Queue);
}
//===========================================================================
void TInOutPoint::SetQueueSize  (int aQueueSize)
{
    Queue = (TComplexMatrix*) realloc (Queue, sizeof(TComplexMatrix) * aQueueSize );
}

//===========================================================================
void TInOutPoint::ClearPoints()
{
   if (Elements == NULL) return;
   Elements_Count = 0;
   Elements = (void**) realloc (Elements, sizeof (TElement*) * Elements_Count);
}

//===========================================================================
void TInOutPoint::AddElement(void *aElement)
{
   Elements = (void**) realloc (Elements, sizeof (TElement*)*(++Elements_Count));
   Elements[Elements_Count - 1] = aElement;
}

//===========================================================================
void TInOutPoint::Draw()
{
//!!!!!!!!!!!!!!!!!!
//   fParentElement             = aParentElement;
//   fCountInOutPointsOnElement = aCountInOutPointsOnElement;
//!!!!!!!!!!!!!!!!!!
}


