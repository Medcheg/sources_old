//===========================================================================
#ifndef M_IntegralH
#define M_IntegralH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================
class TIntegral : public TElement {
private:
        TFloat *iQueue, *oQueue;
        TFloat K_AnalogT0_05;
public:
        TFloat K;
        TFloat C0;
        TIntegral();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static TIntegral *Create() { return new TIntegral(); };
};
//===========================================================================
#endif
