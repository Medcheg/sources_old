//===========================================================================
#ifndef M_ReleThirdH
#define M_ReleThirdH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TReleThird : public TElement {
private:
        TFloat A1, A2, B;
public:
        TReleThird();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TReleThird *Create() { return new TReleThird(); };
};
//===========================================================================
#endif
