//===========================================================================
#ifndef M_SubSystemOutH
#define M_SubSystemOutH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TSubSystemOut : public TElement {
private:
        int fOutputIndex;

        void __fastcall Set_OutputIndex(int aValue);
public:
        TSubSystemOut();
/*
        void   Run ();
        void   Init();
        void   Edit();
        void   PrepareElementBitmaps(Graphics::TBitmap *aBitmap);
*/
        virtual void     LoadFromStream(TStream *aStream){ TElement::LoadFromStream(aStream); };
        virtual void     SaveToStream  (TStream *aStream){ TElement::SaveToStream(aStream);   };
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TSubSystemOut *Create() { return new TSubSystemOut(); };
      __property int OutputIndex = { read = fOutputIndex, write = Set_OutputIndex};
};
//===========================================================================
#endif
