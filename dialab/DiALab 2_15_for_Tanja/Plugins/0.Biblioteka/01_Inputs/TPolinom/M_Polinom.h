//===========================================================================
#ifndef M_PolinomH
#define M_PolinomH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TPolinom : public TElement {
private:
public:
        TPolinom();
        TFloat  Polinom[6];

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TPolinom *Create() { return new TPolinom(); };
};
//===========================================================================
#endif
