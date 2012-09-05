//===========================================================================
#ifndef M_MulMatrix3x3H
#define M_MulMatrix3x3H
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================

class TMulMatrix3x3 : public TElement {
private:
       TFloat *a[3][3], *b[3][3], *c[3][3];
public:
        TMulMatrix3x3();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TMulMatrix3x3 *Create() { return new TMulMatrix3x3(); };
};
//===========================================================================
#endif
