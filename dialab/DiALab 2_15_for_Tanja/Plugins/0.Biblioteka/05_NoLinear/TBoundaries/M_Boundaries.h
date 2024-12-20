//===========================================================================
#ifndef M_BoundariesH
#define M_BoundariesH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TBoundaries : public TElement {
private:
        TFloat K, B;

        TFloat C;
        bool   WasError;
public:
        TBoundaries();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TBoundaries *Create() { return new TBoundaries(); };
};
//===========================================================================
#endif
