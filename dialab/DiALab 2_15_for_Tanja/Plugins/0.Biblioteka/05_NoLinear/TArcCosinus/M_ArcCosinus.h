//===========================================================================
#ifndef M_ArcCosinusH
#define M_ArcCosinusH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TArcCosinus : public TElement {
private:
        TFloat *iQueue, *oQueue;
public:
        TArcCosinus();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static TArcCosinus *Create() { return new TArcCosinus(); };
};
//===========================================================================
#endif
