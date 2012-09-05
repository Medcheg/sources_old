//===========================================================================
#ifndef M_NonSensitivity_and_BoundariesH
#define M_NonSensitivity_and_BoundariesH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TNonSensitivity_and_Boundaries : public TElement {
private:
        TFloat K, A, B;

        TFloat D, C, x1;
        bool   WasError;
public:
        TNonSensitivity_and_Boundaries();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TNonSensitivity_and_Boundaries *Create() { return new TNonSensitivity_and_Boundaries(); };
};
//===========================================================================
#endif
