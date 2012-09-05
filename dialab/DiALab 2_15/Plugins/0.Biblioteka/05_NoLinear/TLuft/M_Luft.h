//===========================================================================
#ifndef M_LuftH
#define M_LuftH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TLuft : public TElement {
private:
        TFloat A, K;

        TFloat C, x1, x2;
public:
        TLuft();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TLuft *Create() { return new TLuft(); };
};
//===========================================================================
#endif
