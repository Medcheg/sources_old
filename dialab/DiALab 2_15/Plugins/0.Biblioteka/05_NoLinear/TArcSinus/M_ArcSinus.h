//===========================================================================
#ifndef M_ArcSinusH
#define M_ArcSinusH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TArcSinus : public TElement {
private:
        TFloat *iQueue, *oQueue;
public:
         TArcSinus();

         virtual void     SaveToStream(TStream *aStream);
         virtual void     LoadFromStream(TStream *aStream);
         virtual void     DrawElementFace();
         virtual void     Edit();
         virtual void     Copy(void *aElement);
         virtual void     Init();
         virtual void     InitBeforeRun();
         virtual void     Run();
         virtual void     DoneRun(){};
         static TArcSinus *Create() { return new TArcSinus(); };
};
//===========================================================================
#endif
