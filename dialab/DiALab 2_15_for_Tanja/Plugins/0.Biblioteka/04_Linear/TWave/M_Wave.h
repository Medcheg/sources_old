//===========================================================================
#ifndef M_WaveH
#define M_WaveH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TWave : public TElement {
private:
        TFloat K, T1, Ksi1;

        TFloat B1, D1, K1;
public:
        TWave();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TWave *Create() { return new TWave(); };
};
//===========================================================================
#endif
