//===========================================================================
#ifndef M_ExtrapoljatorH
#define M_ExtrapoljatorH
//===========================================================================
#include "mpiElement.h"
//===========================================================================

class TExtrapoljator : public TElement {
private:
        TFloat K, T1;

        TFloat A, B, C, D1, K1;
public:
        TExtrapoljator();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        static TExtrapoljator *Create() { return new TExtrapoljator(); };
};
//===========================================================================
#endif
