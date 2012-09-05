//===========================================================================
#ifndef M_Luft_and_BoundariesH
#define M_Luft_and_BoundariesH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TLuft_and_Boundaries : public TElement {
private:
        TFloat K, A, B;

        TFloat D, C, x1, x2;
        bool   WasError;
public:
        TLuft_and_Boundaries();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TLuft_and_Boundaries *Create() { return new TLuft_and_Boundaries(); };
};
//===========================================================================
#endif
