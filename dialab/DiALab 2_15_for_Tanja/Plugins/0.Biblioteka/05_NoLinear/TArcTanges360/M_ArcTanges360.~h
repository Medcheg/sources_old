//===========================================================================
#ifndef M_ArcTanges360H
#define M_ArcTanges360H
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TArcTanges360 : public TElement {
private:
        TFloat *iQueue1, *iQueue2, *oQueue;
public:
        TArcTanges360();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static TArcTanges360 *Create() { return new TArcTanges360(); };
};
//===========================================================================
#endif
