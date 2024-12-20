//===========================================================================
#ifndef M_SubSystemInH
#define M_SubSystemInH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TSubSystemIn : public TElement {
private:
        int fInputIndex;

        void __fastcall Set_InputIndex(int aValue);
public:
        TSubSystemIn();
/*
        void   Run ();
        void   Init();
        void   Edit();
        void   PrepareElementBitmaps(Graphics::TBitmap *aBitmap);
*/
        virtual void     LoadFromStream(TStream *aStream){ TElement::LoadFromStream(aStream); };
        virtual void     SaveToStream  (TStream *aStream){ TElement::SaveToStream(aStream);   };
        virtual void     DrawElementFace();
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Run();
        virtual void     DoneRun(){};
        static TSubSystemIn *Create() { return new TSubSystemIn(); };

      __property int InputIndex = { read = fInputIndex, write = Set_InputIndex};
};
//===========================================================================
#endif
