//===========================================================================
#ifndef M_TDivider1H
#define M_TDivider1H
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TDivider1 : public TElement {
private:
        TFloat K, T1;

        TFloat A, B, C, D1, K1;
public:
        TDivider1();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TDivider1 *Create() { return new TDivider1(); };
};
//===========================================================================
#endif
