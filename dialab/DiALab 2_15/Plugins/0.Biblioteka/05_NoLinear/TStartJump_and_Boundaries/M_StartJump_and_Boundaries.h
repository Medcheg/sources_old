//===========================================================================
#ifndef M_StartJump_and_BoundariesH
#define M_StartJump_and_BoundariesH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TStartJump_and_Boundaries : public TElement {
private:
        TFloat K, A, B;

        TFloat C;
        bool   WasError;
public:
        TStartJump_and_Boundaries();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TStartJump_and_Boundaries *Create() { return new TStartJump_and_Boundaries(); };
};
//===========================================================================
#endif
