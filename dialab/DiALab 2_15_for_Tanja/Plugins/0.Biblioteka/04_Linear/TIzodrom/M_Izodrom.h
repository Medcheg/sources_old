//===========================================================================
#ifndef M_IzodromH
#define M_IzodromH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TIzodrom : public TElement {
private:
        TFloat K, T1;

        TFloat K1, K2;
public:
        TIzodrom();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TIzodrom *Create() { return new TIzodrom(); };
};
//===========================================================================
#endif
