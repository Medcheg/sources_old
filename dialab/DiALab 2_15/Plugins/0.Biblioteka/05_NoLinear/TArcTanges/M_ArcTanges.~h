//===========================================================================
#ifndef M_ArcTangesH
#define M_ArcTangesH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TArcTanges : public TElement {
private:
        TFloat *iQueue, *oQueue;
public:
        TArcTanges();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static TArcTanges *Create() { return new TArcTanges(); };
};
//===========================================================================
#endif
