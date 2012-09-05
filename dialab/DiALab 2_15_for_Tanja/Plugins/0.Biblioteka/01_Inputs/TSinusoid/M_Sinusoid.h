//===========================================================================
#ifndef M_SinusoidH
#define M_SinusoidH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TSinusoid : public TElement {
private:
    TFloat    A_Exponenet_Alfa;
    TFloat    Two_Pi_F;
public:
        TFloat  A;
        TFloat  Alfa;
        TFloat  F;
        TFloat  Fi;

        TSinusoid();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TSinusoid *Create() { return new TSinusoid(); };
};
//===========================================================================
#endif
