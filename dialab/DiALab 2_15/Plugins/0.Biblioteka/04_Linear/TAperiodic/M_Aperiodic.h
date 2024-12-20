//===========================================================================
#ifndef M_AperiodicH
#define M_AperiodicH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TAperiodic : public TElement {
private:
        TFloat *iQueue, *oQueue;

        TFloat K, T1;

        TFloat A, B, C, D1, K1;
public:
        TAperiodic();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static TAperiodic *Create() { return new TAperiodic(); };
};
//===========================================================================
#endif
