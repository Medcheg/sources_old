//===========================================================================
#ifndef M_WaveForce2H
#define M_WaveForce2H
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TWaveForce2 : public TElement {
private:
        TFloat K, T1, T2, Ksi1, Ksi2;

        TFloat B1, B2, D1, D2, K1, K2, K3;
public:
        TWaveForce2();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TWaveForce2 *Create() { return new TWaveForce2(); };
};
//===========================================================================
#endif
