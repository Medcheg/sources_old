//===========================================================================
#ifndef M_ReleH
#define M_ReleH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TRele : public TElement {
private:
        TFloat B;
public:
        TRele();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TRele *Create() { return new TRele(); };
};
//===========================================================================
#endif
