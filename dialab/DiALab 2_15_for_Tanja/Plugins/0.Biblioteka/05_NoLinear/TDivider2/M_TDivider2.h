//===========================================================================
#ifndef M_TDivider2H
#define M_TDivider2H
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TDivider2 : public TElement {
private:
public:
        TDivider2();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TDivider2 *Create() { return new TDivider2(); };
};
//===========================================================================
#endif
