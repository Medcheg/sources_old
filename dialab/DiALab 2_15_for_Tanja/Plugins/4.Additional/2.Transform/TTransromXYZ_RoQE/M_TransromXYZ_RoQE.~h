//===========================================================================
#ifndef M_TransromXYZ_RoQEH
#define M_TransromXYZ_RoQEH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TTransromXYZ_RoQE : public TElement {
private:
        TFloat *iQueue1, *iQueue2, *iQueue3, *oQueue1, *oQueue2, *oQueue3;
public:
        TTransromXYZ_RoQE();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TTransromXYZ_RoQE *Create() { return new TTransromXYZ_RoQE(); };
};
//===========================================================================
#endif
