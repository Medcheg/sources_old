//===========================================================================
#ifndef M_AbsoluteH
#define M_AbsoluteH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TAbsolute : public TElement {
private:
        TFloat *iQueue, *oQueue;
public:
        TAbsolute();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static TAbsolute *Create() { return new TAbsolute(); };
};
//===========================================================================
#endif
