//===========================================================================
//=======  TElemenetPoint класс описывающий параметры входа или выхода елемента -----
//===========================================================================
TElementPoint::TElementPoint(AnsiString aCaption, TPointType aType)
{
   Caption                    = aCaption;
   Queue                      = NULL; // (TFloat*)malloc(sizeof(TFloat))
   Elements                   = NULL;
   Elements_Count             = 0;
   xPos                       = 0;
   yPos                       = 0;
   Conected                   = false;
   Visible                    = true;
   Type                       = aType;
   EnabledCalc_TemporaryFalse = false;
   EnableCalc                 = NULL;
   CurrentLink                = NULL;

   if (Type == tOutput) {
        EnableCalc = (bool*) malloc (sizeof(bool));
       *EnableCalc = false;
   }
}

//===========================================================================
TElementPoint::~TElementPoint()
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
void TElementPoint::SetQueueSize  (int aQueueSize)
{
    Queue = (TFloat*) realloc (Queue, sizeof(TFloat) * aQueueSize );
}

//===========================================================================
void TElementPoint::ClearPoints()
{
   if (Elements == NULL) return;
   Elements_Count = 0;
   Elements = (TBaseClass**) realloc (Elements, sizeof (TBaseClass*) * Elements_Count);
}

//===========================================================================
void TElementPoint::AddElement(TBaseClass *Element)
{
//   if (Type != tOutput) return;

   Elements = (TBaseClass**) realloc (Elements, sizeof (TBaseClass*)*(++Elements_Count));
   Elements[Elements_Count - 1] = Element;
}

     
