//===========================================================================
#ifndef M_ArcTanges180H
#define M_ArcTanges180H
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TArcTanges180 : public TElement {
private:
        TFloat *iQueue1, *iQueue2, *oQueue;
public:
        TArcTanges180();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static TArcTanges180 *Create() { return new TArcTanges180(); };
};
//===========================================================================
#endif
