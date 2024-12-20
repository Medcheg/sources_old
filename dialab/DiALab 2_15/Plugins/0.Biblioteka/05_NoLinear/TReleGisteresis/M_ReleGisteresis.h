//===========================================================================
#ifndef M_ReleGisteresisH
#define M_ReleGisteresisH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TReleGisteresis : public TElement {
private:
        TFloat K, T1;

        TFloat A, B, C, D1, K1;
public:
        TReleGisteresis();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TReleGisteresis *Create() { return new TReleGisteresis(); };
};
//===========================================================================
#endif
