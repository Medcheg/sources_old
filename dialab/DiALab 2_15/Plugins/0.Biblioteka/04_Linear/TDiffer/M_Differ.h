//===========================================================================
#ifndef M_DifferH
#define M_DifferH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TDiffer : public TElement {
private:
        TFloat K;
public:
        TDiffer();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TDiffer *Create() { return new TDiffer(); };
};
//===========================================================================
#endif
