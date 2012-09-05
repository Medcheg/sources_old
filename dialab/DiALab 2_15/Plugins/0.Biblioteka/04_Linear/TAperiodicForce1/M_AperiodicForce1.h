//===========================================================================
#ifndef M_AperiodicForce1H
#define M_AperiodicForce1H
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TAperiodicForce1 : public TElement {
private:
        TFloat *iQueue, *oQueue;

        TFloat K, T1, T2;

        TFloat D1, D2, D3, Gamma1, Gamma2;
public:
        TAperiodicForce1();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static TAperiodicForce1 *Create() { return new TAperiodicForce1(); };
};
//===========================================================================
#endif
