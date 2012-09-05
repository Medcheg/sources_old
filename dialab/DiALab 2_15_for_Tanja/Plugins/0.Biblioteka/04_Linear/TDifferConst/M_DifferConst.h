//===========================================================================
#ifndef M_DifferConstH
#define M_DifferConstH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TDifferConst : public TElement {
private:
        TFloat K, T1;

        TFloat K1, K2;
public:
        TDifferConst();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TDifferConst *Create() { return new TDifferConst(); };
};
//===========================================================================
#endif
