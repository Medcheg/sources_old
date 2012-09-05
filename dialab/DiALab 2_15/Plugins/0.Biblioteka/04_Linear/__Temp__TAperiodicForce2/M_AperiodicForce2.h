//===========================================================================
#ifndef M_AperiodicForce2H
#define M_AperiodicForce2H
//===========================================================================
#include "mpiElement.h"
//===========================================================================

class TAperiodicForce2 : public TElement {
private:
        TFloat K;
public:
        TAperiodicForce2();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        static TAperiodicForce2 *Create() { return new TAperiodicForce2(); };
};
//===========================================================================
#endif
