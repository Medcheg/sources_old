//===========================================================================
#ifndef M_NonSensitivityH
#define M_NonSensitivityH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TNonSensitivity : public TElement {
private:
        TFloat K, A;
public:
        TNonSensitivity();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TNonSensitivity *Create() { return new TNonSensitivity(); };
};
//===========================================================================
#endif
