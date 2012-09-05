//===========================================================================
#ifndef M_WaveForce1H
#define M_WaveForce1H
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TWaveForce1 : public TElement {
private:
        TFloat K, T1, Ksi1, T2;

        TFloat B1, D1, D2, K1, K2;
public:
        TWaveForce1();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TWaveForce1 *Create() { return new TWaveForce1(); };
};
//===========================================================================
#endif
