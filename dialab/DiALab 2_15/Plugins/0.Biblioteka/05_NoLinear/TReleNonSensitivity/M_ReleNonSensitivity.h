//===========================================================================
#ifndef M_ReleNonSensitivityH
#define M_ReleNonSensitivityH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TReleNonSensitivity : public TElement {
private:
        TFloat A, B;
public:
        TReleNonSensitivity();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TReleNonSensitivity *Create() { return new TReleNonSensitivity(); };
};
//===========================================================================
#endif
