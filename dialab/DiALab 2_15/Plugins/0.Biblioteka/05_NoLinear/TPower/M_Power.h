//===========================================================================
#ifndef M_PowerH
#define M_PowerH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TPower : public TElement {
private:
        TFloat N;

public:
        TPower();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TPower *Create() { return new TPower(); };
};
//===========================================================================
#endif
