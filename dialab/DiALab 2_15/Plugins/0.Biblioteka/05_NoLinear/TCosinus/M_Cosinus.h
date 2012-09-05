//===========================================================================
#ifndef M_CosinusH
#define M_CosinusH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TCosinus : public TElement {
private:
public:
        TCosinus();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};
        static TCosinus *Create() { return new TCosinus(); };
};
//===========================================================================
#endif
